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

#include "template-cache.h"
#include <kernel/native-object.h>
#include <kernel/v8utils.h>
#include <kernel/native-fn.h>
#include <kernel/initrd.h>
#include <kernel/engines.h>
#include <kernel/initjs.h>

namespace rt {

TemplateCache::TemplateCache(v8::Isolate* iv8)
    :   iv8_(iv8) {
    RT_ASSERT(iv8_);
    v8::HandleScope scope(iv8_);

    {	v8::Local<v8::FunctionTemplate> t { v8::FunctionTemplate::New(iv8_) };
        t->InstanceTemplate()->SetInternalFieldCount(1);
        wrapper_template_.Set(iv8_, t);
    }

    {	v8::Local<v8::FunctionTemplate> t { v8::FunctionTemplate::New(iv8_) };
        t->InstanceTemplate()->SetInternalFieldCount(1);
        t->InstanceTemplate()->SetCallAsFunctionHandler(NativesObject::CallHandler);
        wrapper_callable_template_.Set(iv8_, t);
    }
}

v8::Local<v8::UnboundScript> TemplateCache::GetInitScript() {
    RT_ASSERT(iv8_);
    v8::EscapableHandleScope scope(iv8_);
    v8::Local<v8::String> inits = v8::String::NewFromUtf8(iv8_, INIT_JS,
        v8::String::kNormalString, sizeof(INIT_JS) - 1);
    v8::ScriptCompiler::Source source(inits);
    v8::Local<v8::UnboundScript> script = v8::ScriptCompiler
            ::CompileUnbound(iv8_, &source,
              v8::ScriptCompiler::CompileOptions::kNoCompileOptions);
    return scope.Escape(script);
}

v8::Local<v8::Context> TemplateCache::NewContext() {
    RT_ASSERT(iv8_);

    v8::EscapableHandleScope scope(iv8_);
    if (global_object_template_.IsEmpty()) {
        v8::Local<v8::ObjectTemplate> global { v8::ObjectTemplate::New() };

        global->Set(iv8_, "setTimeout",
                    v8::FunctionTemplate::New(iv8_, NativesObject::SetTimeout));
        global->Set(iv8_, "clearTimeout",
                    v8::FunctionTemplate::New(iv8_, NativesObject::ClearTimer));

        global->Set(iv8_, "setInterval",
                    v8::FunctionTemplate::New(iv8_, NativesObject::SetInterval));
        global->Set(iv8_, "clearInterval",
                    v8::FunctionTemplate::New(iv8_, NativesObject::ClearTimer));

        {   auto encoder = v8::FunctionTemplate::New(iv8_, NativesObject::TextEncoder);
            encoder->PrototypeTemplate()->Set(iv8_, "encode",
                v8::FunctionTemplate::New(iv8_, NativesObject::TextEncoderEncode));
            global->Set(iv8_, "TextEncoder", encoder);
        }

        {   auto decoder = v8::FunctionTemplate::New(iv8_, NativesObject::TextDecoder);
            decoder->PrototypeTemplate()->Set(iv8_, "decode",
                v8::FunctionTemplate::New(iv8_, NativesObject::TextDecoderDecode));
            global->Set(iv8_, "TextDecoder", decoder);
        }

        v8::Local<v8::ObjectTemplate> isolate { v8::ObjectTemplate::New() };
        isolate->Set(iv8_, "log", v8::FunctionTemplate::New(iv8_, NativesObject::KernelLog));
        isolate->Set(iv8_, "exit", v8::FunctionTemplate::New(iv8_, NativesObject::Exit));
        isolate->Set(iv8_, "eval", v8::FunctionTemplate::New(iv8_, NativesObject::Eval));
        isolate->Set(iv8_, "data", v8::Null(iv8_));
        isolate->Set(iv8_, "env", v8::Null(iv8_));
        isolate->Set(iv8_, "system", v8::Null(iv8_));
        isolate->Set(iv8_, "createPipe", v8::FunctionTemplate::New(iv8_, NativesObject::CreatePipe));
        isolate->Set(iv8_, "sync", v8::FunctionTemplate::New(iv8_, NativesObject::SyncRPC));
        global->Set(iv8_, "isolate", isolate);

        v8::Local<v8::ObjectTemplate> kernel { v8::ObjectTemplate::New() };
        kernel->Set(iv8_, "version", v8::FunctionTemplate::New(iv8_, NativesObject::Version));
        kernel->Set(iv8_, "getCommandLine", v8::FunctionTemplate::New(iv8_, NativesObject::GetCommandLine));
        kernel->Set(iv8_, "startProfiling", v8::FunctionTemplate::New(iv8_, NativesObject::StartProfiling));
        kernel->Set(iv8_, "stopProfiling", v8::FunctionTemplate::New(iv8_, NativesObject::StopProfiling));
        global->Set(iv8_, "kernel", kernel);

        v8::Local<v8::ObjectTemplate> runtime { v8::ObjectTemplate::New() };
        runtime->Set(iv8_, "bufferAddress", v8::FunctionTemplate::New(iv8_, NativesObject::BufferAddress));
        runtime->Set(iv8_, "bufferSliceInplace", v8::FunctionTemplate::New(iv8_, NativesObject::BufferSliceInplace));
        runtime->Set(iv8_, "toBuffer", v8::FunctionTemplate::New(iv8_, NativesObject::ToBuffer));
        runtime->Set(iv8_, "bufferToString", v8::FunctionTemplate::New(iv8_, NativesObject::BufferToString));
        runtime->Set(iv8_, "debug", v8::FunctionTemplate::New(iv8_, NativesObject::Debug));
        runtime->Set(iv8_, "syncRPC", v8::FunctionTemplate::New(iv8_, NativesObject::SyncRPC));
        global->Set(iv8_, "runtime", runtime);

        v8::Local<v8::ObjectTemplate> performance { v8::ObjectTemplate::New() };
        performance->Set(iv8_, "now", v8::FunctionTemplate::New(iv8_, NativesObject::PerformanceNow));
        global->Set(iv8_, "performance", performance);

        global_object_template_.Set(iv8_, global);
    }

    v8::Local<v8::Context> context = v8::Context::New(iv8_, nullptr,
        global_object_template_.Get(iv8_));


    v8::Context::Scope cs(context);
    context->Global()->Set(v8::String::NewFromUtf8(iv8_, "global"), context->Global());

    if (init_script_.IsEmpty()) {
        init_script_.Set(iv8_, GetInitScript());
    }

    RT_ASSERT(!init_script_.IsEmpty());
    v8::Local<v8::Value> init_func_val = init_script_.Get(iv8_)
        ->BindToCurrentContext()->Run();

    RT_ASSERT(!init_func_val.IsEmpty());
    RT_ASSERT(init_func_val->IsFunction());
    v8::Local<v8::Function> init_func = v8::Local<v8::Function>::Cast(init_func_val);

    v8::Local<v8::Value> args_local[1] { (new NativesObject())
        ->BindToTemplateCache(this)
        ->GetInstance() };
    init_func->Call(context->Global(), 1, &args_local[0]);

    return scope.Escape(context);
}

v8::Local<v8::Value> TemplateCache::NewWrappedFunction(ExternalFunction* data) {
    RT_ASSERT(data);
    RT_ASSERT(iv8_);
    v8::EscapableHandleScope scope(iv8_);
    v8::Local<v8::Object> obj { wrapper_callable_template_.Get(iv8_)
        ->InstanceTemplate()->NewInstance() };

    obj->SetAlignedPointerInInternalField(0,
        static_cast<NativeObjectWrapper*>(data));
    return scope.Escape(obj);
}

v8::Local<v8::Object> TemplateCache::NewWrappedObject(NativeObjectWrapper* nativeobj) {
    RT_ASSERT(nativeobj);
    RT_ASSERT(iv8_);
    v8::EscapableHandleScope scope(iv8_);
    v8::Local<v8::Object> obj = wrapper_template_.Get(iv8_)
        ->InstanceTemplate()->NewInstance();

    obj->SetAlignedPointerInInternalField(0,
        static_cast<NativeObjectWrapper*>(nativeobj));
    return scope.Escape(obj);
}

} // namespace rt
