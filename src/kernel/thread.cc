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
#include <kernel/mem-manager.h>
#include <kernel/engine.h>
#include <kernel/engines.h>

namespace rt {

Thread::Thread(ThreadManager* thread_mgr, ResourceHandle<EngineThread> ethread)
    :	thread_mgr_(thread_mgr),
        iv8_(nullptr),
        tpl_cache_(nullptr),
        stack_(GLOBAL_mem_manager()->virtual_allocator().AllocStack()),
        ethread_(ethread),
        exports_(this),
        terminate_(false) {
    priority_.Set(1);
}

Thread::~Thread() {
    RT_ASSERT(thread_mgr_);
    RT_ASSERT(this != thread_mgr_->current_thread());

    timeout_data_.Clear();
    irq_data_.Clear();
    promises_.Clear();

    context_.Reset();
    args_.Reset();
    call_wrapper_.Reset();

    iv8_->Dispose(); // This deletes v8 isolate object
    delete tpl_cache_;
    // TODO: delete stack
}

ExternalFunction* FunctionExports::Add(v8::Local<v8::Value> v,
                                       ResourceHandle<EngineThread> recv) {
    uint32_t index = data_.size();
    RT_ASSERT(thread_);
    v8::Isolate* iv8 { thread_->IsolateV8() };
    RT_ASSERT(iv8);
    size_t export_id = ++export_id_;
    data_.push_back(std::move(FunctionExportData(iv8, v, export_id)));
    return new ExternalFunction(index, export_id, thread_, recv);
}

v8::Local<v8::Value> FunctionExports::Get(uint32_t index, size_t export_id) {
    RT_ASSERT(thread_);
    v8::Isolate* iv8 { thread_->IsolateV8() };

    RT_ASSERT(index < data_.size());
    v8::EscapableHandleScope scope(iv8);
    if (data_[index].export_id() != export_id) {
        return scope.Escape(v8::Local<v8::Value>());
    }

    return scope.Escape(data_[index].GetValue(iv8));
}


void Thread::SetTimeout(uint32_t timeout_id, uint64_t timeout_ms) {
    uint64_t ticks_now { thread_mgr_->ticks_count() };
    uint64_t when = ticks_now + timeout_ms / GLOBAL_engines()->MsPerTick();
    timeouts_.Set(timeout_id, when);
}

void Thread::Init() {
    RT_ASSERT(nullptr == iv8_);
    RT_ASSERT(nullptr == tpl_cache_);
    iv8_ = v8::Isolate::New();
    iv8_->SetData(0, this);
    v8::Locker lock(iv8_);
    v8::Isolate::Scope ivscope(iv8_);
    v8::HandleScope local_handle_scope(iv8_);
    tpl_cache_ = new TemplateCache(iv8_);
}

void Thread::Run() {
    RT_ASSERT(iv8_);
    RT_ASSERT(tpl_cache_);

    uint64_t ticks_now { thread_mgr_->ticks_count() };
    while (timeouts_.Elapsed(ticks_now)) {
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

    v8::Locker lock(iv8_);
    v8::Isolate::Scope ivscope(iv8_);
    v8::HandleScope local_handle_scope(iv8_);

    if (context_.IsEmpty()) {

        printf("++++++++++++++++ CONTEXT (X0)\n");
        v8::Local<v8::Context> context = tpl_cache_->NewContext();
        context_ = std::move(v8::UniquePersistent<v8::Context>(iv8_, context));
    }

    RT_ASSERT(!context_.IsEmpty());
    v8::Local<v8::Context> context = v8::Local<v8::Context>::New(iv8_, context_);
    v8::Context::Scope cs(context);

    v8::TryCatch trycatch;

    for (ThreadMessage* message : messages) {
        RT_ASSERT(message);

        ThreadMessage::Type type = message->type();

        switch (type) {
        case ThreadMessage::Type::SET_ARGUMENTS: {
            RT_ASSERT(args_.IsEmpty());
            v8::Local<v8::Value> unpacked { message->data().Unpack(this) };
            RT_ASSERT(!unpacked.IsEmpty());

            args_ = std::move(v8::UniquePersistent<v8::Value>(iv8_, unpacked));
        }
            break;
        case ThreadMessage::Type::EVALUATE: {
            v8::Local<v8::Value> unpacked { message->data().Unpack(this) };
            RT_ASSERT(!unpacked.IsEmpty());

            v8::ScriptCompiler::Source source(unpacked->ToString());
            v8::Local<v8::Script> script = v8::ScriptCompiler::Compile(iv8_, &source,
                v8::ScriptCompiler::CompileOptions::kNoCompileOptions);
            if (!script.IsEmpty()) {
                script->Run();
            }
        }
            break;
        case ThreadMessage::Type::FUNCTION_CALL: {
            v8::Local<v8::Value> unpacked { message->data().Unpack(this) };
            RT_ASSERT(!unpacked.IsEmpty());

            ExternalFunction* efn { message->exported_func() };
            RT_ASSERT(efn);

            v8::Local<v8::Value> fnval { exports_.Get(efn->index(), efn->export_id()) };
            if (fnval.IsEmpty()) {
                fnval = v8::Null(iv8_);
            } else {
                RT_ASSERT(fnval->IsFunction());
            }

            {	v8::Local<v8::Function> fnwrap { v8::Local<v8::Function>::New(iv8_, call_wrapper_) };
                v8::Local<v8::Value> argv[] {
                   fnval,
                   message->sender().NewExternal(iv8_),
                   unpacked,
                   v8::Uint32::NewFromUnsigned(iv8_, message->recv_index()),
                };
                fnwrap->Call(context->Global(), 4, argv);
            }
        }
            break;
        case ThreadMessage::Type::FUNCTION_RETURN_RESOLVE: {
            v8::Local<v8::Value> unpacked { message->data().Unpack(this) };
            RT_ASSERT(!unpacked.IsEmpty());

            v8::Local<v8::Promise::Resolver> resolver {
                v8::Local<v8::Promise::Resolver>::New(iv8_, TakePromise(message->recv_index())) };

            resolver->Resolve(unpacked);
            iv8_->RunMicrotasks();
        }
            break;
        case ThreadMessage::Type::FUNCTION_RETURN_REJECT: {
            v8::Local<v8::Value> unpacked { message->data().Unpack(this) };
            RT_ASSERT(!unpacked.IsEmpty());

            v8::Local<v8::Promise::Resolver> resolver {
                v8::Local<v8::Promise::Resolver>::New(iv8_, TakePromise(message->recv_index())) };

            resolver->Reject(unpacked);
            iv8_->RunMicrotasks();
        }
            break;
        case ThreadMessage::Type::TIMEOUT_EVENT: {
            v8::Local<v8::Value> fnv { v8::Local<v8::Value>::New(iv8_,
                TakeTimeoutData(message->recv_index())) };
            RT_ASSERT(fnv->IsFunction());
            v8::Local<v8::Function> fn { v8::Local<v8::Function>::Cast(fnv) };
            fn->Call(context->Global(), 0, nullptr);
        }
            break;
        case ThreadMessage::Type::IRQ_RAISE: {
            v8::Local<v8::Value> fnv { v8::Local<v8::Value>::New(iv8_,
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

        if (!message->reusable()) {
            delete message;
        }
    }

    if (terminate_) {
        return;
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
