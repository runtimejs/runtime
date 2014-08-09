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

namespace rt {

TemplateCache::TemplateCache(v8::Isolate* iv8)
    :	iv8_(iv8) {
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
    InitrdFile initfile =  GLOBAL_initrd()->Get("/system/init.js");
    if (initfile.IsEmpty()) {
        printf("Unable to load /system/init.js file.");
        abort();
    }
    v8::Local<v8::String> inits = v8::String::NewFromUtf8(iv8_,
        reinterpret_cast<const char*>(initfile.Data()),
        v8::String::kNormalString, initfile.Size());

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

        v8::Local<v8::ObjectTemplate> runtime { v8::ObjectTemplate::New() };
        runtime->Set(iv8_, "args", v8::FunctionTemplate::New(iv8_, NativesObject::Args));
        runtime->Set(iv8_, "log", v8::FunctionTemplate::New(iv8_, NativesObject::KernelLog));
        runtime->Set(iv8_, "version", v8::FunctionTemplate::New(iv8_, NativesObject::Version));
        runtime->Set(iv8_, "exit", v8::FunctionTemplate::New(iv8_, NativesObject::Exit));
        runtime->Set(iv8_, "bufferAddress", v8::FunctionTemplate::New(iv8_, NativesObject::BufferAddress));

        global->Set(iv8_, "runtime", runtime);

        global_object_template_.Set(iv8_, global);
    }

    v8::Local<v8::Context> context = v8::Context::New(iv8_, nullptr,
        global_object_template_.Get(iv8_));

    v8::Context::Scope cs(context);

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
