// Copyright 2014 Runtime.JS project authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "thread.h"
#include <kernel/kernel.h>
#include <kernel/thread-manager.h>
#include <kernel/isolate.h>
#include <kernel/mem-manager.h>
#include <kernel/engine.h>
#include <kernel/engines.h>

namespace rt {

Thread::Thread(Isolate* isolate, uint64_t id,
    String name, ResourceHandle<EngineThread> ethread)
    :	isolate_(isolate),
        iv8_(isolate->IsolateV8()),
        id_(id),
        name_(name),
        stack_(GLOBAL_mem_manager()->virtual_allocator().AllocStack()),
        ethread_(ethread),
        exports_(isolate) {

    RT_ASSERT(isolate);
    priority_.Set(1);
}

Thread::~Thread() {}

ExternalFunction* FunctionExports::Add(v8::Local<v8::Value> v,
                                       ResourceHandle<EngineThread> recv) {
    uint32_t index = data_.size();
    RT_ASSERT(isolate_);
    RT_ASSERT(isolate_->IsolateV8());
    size_t export_id = ++export_id_;
    data_.push_back(std::move(FunctionExportData(isolate_->IsolateV8(), v, export_id)));
    return new ExternalFunction(index, export_id, isolate_, recv);
}

v8::Local<v8::Value> FunctionExports::Get(uint32_t index, size_t export_id) {
    RT_ASSERT(isolate_);
    RT_ASSERT(isolate_->IsolateV8());
    v8::Isolate* iv8 { isolate_->IsolateV8() };
    RT_ASSERT(iv8);

    RT_ASSERT(index < data_.size());
    v8::EscapableHandleScope scope(iv8);
    if (data_[index].export_id() != export_id) {
        return scope.Escape(v8::Local<v8::Value>());
    }

    return scope.Escape(data_[index].GetValue(iv8));
}


void Thread::Init() {
    isolate_->Init();
}

void Thread::SetTimeout(uint32_t timeout_id, uint64_t timeout_ms) {
    uint64_t ticks_now { isolate_->ticks_count() };
    uint64_t when = ticks_now + timeout_ms / GLOBAL_engines()->MsPerTick();
    timeouts_.Set(timeout_id, when);
}

void Thread::Run() {
    v8::Isolate* iv8 = isolate_->IsolateV8();
    RT_ASSERT(iv8);

    uint64_t ticks_now { isolate_->ticks_count() };
    while (timeouts_.Elapsed(ticks_now)) {
//        printf("Elapsed on ticks = %lu\n", ticks_now);
        uint32_t timeout_id { timeouts_.Take() };

        {	std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
                ThreadMessage::Type::TIMEOUT_EVENT,
                ResourceHandle<EngineThread>(), TransportData(), nullptr, timeout_id));
            ethread_.get()->PushMessage(std::move(msg));
        }
    }

    EngineThread::ThreadMessagesVector messages = ethread_.get()->TakeMessages();
    if (0 == messages.size()) {
        return;
    }

    v8::Locker lock(iv8);
    v8::Isolate::Scope ivscope(iv8);
    v8::HandleScope local_handle_scope(iv8);

    if (context_.IsEmpty()) {

        printf("++++++++++++++++ CONTEXT (X0)\n");
        v8::Local<v8::Context> context = isolate_->template_cache()->NewContext();
        context_ = std::move(v8::UniquePersistent<v8::Context>(iv8, context));
    }

    RT_ASSERT(!context_.IsEmpty());
    v8::Local<v8::Context> context = v8::Local<v8::Context>::New(iv8, context_);
    ContextScope cs(context);

    v8::TryCatch trycatch;

    for (ThreadMessage* raw : messages) {
        RT_ASSERT(raw);
        std::unique_ptr<ThreadMessage> message(raw);

        ThreadMessage::Type type = message->type();

        switch (type) {
        case ThreadMessage::Type::SET_ARGUMENTS: {
            RT_ASSERT(args_.IsEmpty());
            v8::Local<v8::Value> unpacked { message->data().Unpack(isolate_) };
            RT_ASSERT(!unpacked.IsEmpty());

            args_ = std::move(v8::UniquePersistent<v8::Value>(iv8, unpacked));
        }
            break;
        case ThreadMessage::Type::EVALUATE: {
            v8::Local<v8::Value> unpacked { message->data().Unpack(isolate_) };
            RT_ASSERT(!unpacked.IsEmpty());

            v8::ScriptCompiler::Source source(unpacked->ToString());
            v8::Local<v8::Script> script = v8::ScriptCompiler::Compile(iv8, &source,
                v8::ScriptCompiler::CompileOptions::kNoCompileOptions);
            if (!script.IsEmpty()) {
                script->Run();
            }
        }
            break;
        case ThreadMessage::Type::FUNCTION_CALL: {
            v8::Local<v8::Value> unpacked { message->data().Unpack(isolate_) };
            RT_ASSERT(!unpacked.IsEmpty());

            ExternalFunction* efn { message->exported_func() };
            RT_ASSERT(efn);

            v8::Local<v8::Value> fnval { exports_.Get(efn->index(), efn->export_id()) };
            if (fnval.IsEmpty()) {
                fnval = v8::Null(iv8);
            } else {
                RT_ASSERT(fnval->IsFunction());
            }

            {	v8::Local<v8::Function> fnwrap { v8::Local<v8::Function>::New(iv8, call_wrapper_) };
                v8::Local<v8::Value> argv[] {
                   fnval,
                   message->sender().NewExternal(iv8),
                   unpacked,
                   v8::Uint32::NewFromUnsigned(iv8, message->recv_index()),
                };
                fnwrap->Call(context->Global(), 4, argv);
            }
        }
            break;
        case ThreadMessage::Type::FUNCTION_RETURN_RESOLVE: {
            v8::Local<v8::Value> unpacked { message->data().Unpack(isolate_) };
            RT_ASSERT(!unpacked.IsEmpty());

            v8::Local<v8::Promise::Resolver> resolver {
                v8::Local<v8::Promise::Resolver>::New(iv8, TakePromise(message->recv_index())) };

            resolver->Resolve(unpacked);
            isolate_->IsolateV8()->RunMicrotasks();
        }
            break;
        case ThreadMessage::Type::FUNCTION_RETURN_REJECT: {
            v8::Local<v8::Value> unpacked { message->data().Unpack(isolate_) };
            RT_ASSERT(!unpacked.IsEmpty());

            v8::Local<v8::Promise::Resolver> resolver {
                v8::Local<v8::Promise::Resolver>::New(iv8, TakePromise(message->recv_index())) };

            resolver->Reject(unpacked);
            isolate_->IsolateV8()->RunMicrotasks();
        }
            break;
        case ThreadMessage::Type::TIMEOUT_EVENT: {
            v8::Local<v8::Value> fnv { v8::Local<v8::Value>::New(iv8,
                TakeTimeoutData(message->recv_index())) };
            RT_ASSERT(fnv->IsFunction());
            v8::Local<v8::Function> fn { v8::Local<v8::Function>::Cast(fnv) };
            fn->Call(context->Global(), 0, nullptr);
        }
            break;
        case ThreadMessage::Type::IRQ_RAISE: {
            v8::Local<v8::Value> fnv { v8::Local<v8::Value>::New(iv8,
                GetIRQData(message->recv_index())) };
            RT_ASSERT(fnv->IsFunction());
            v8::Local<v8::Function> fn { v8::Local<v8::Function>::Cast(fnv) };
            fn->Call(context->Global(), 0, nullptr);
        }
            break;
        case ThreadMessage::Type::EMPTY:
            break;
        default:
            RT_ASSERT(!"Unknown thread message");
            break;
        }
    }

    v8::Local<v8::Value> ex = trycatch.Exception();
    if (!ex.IsEmpty()) {
        v8::String::Utf8Value exception_str(ex);
        v8::Local<v8::Message> message = trycatch.Message();
        if (message.IsEmpty()) {
            printf("Uncaught exception: %s\n", *exception_str);
        } else {
            v8::String::Utf8Value script_name(message->GetScriptResourceName());
            int linenum = message->GetLineNumber();
            printf("Uncaught exception: %s:%i: %s\n", *script_name, linenum, *exception_str);
        }

        v8::String::Utf8Value stack(trycatch.StackTrace());
        if (stack.length() > 0) {
            printf("%s\n", *stack);
        }
    }

    trycatch.Reset();
}

} // namespace rt
