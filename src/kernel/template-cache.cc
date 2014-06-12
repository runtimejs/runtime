// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "template-cache.h"
#include <kernel/native-object.h>
#include <kernel/v8utils.h>
#include <kernel/native-fn.h>

namespace rt {

TemplateCache::TemplateCache(Isolate* isolate)
    :	isolate_(isolate) {
    v8::Isolate* iv8 = isolate->IsolateV8();
    RT_ASSERT(iv8);
    v8::HandleScope scope(iv8);

    {	v8::Local<v8::FunctionTemplate> t { v8::FunctionTemplate::New(iv8) };
        t->InstanceTemplate()->SetInternalFieldCount(1);
        wrapper_template_.Set(iv8, t);
    }

    {	v8::Local<v8::FunctionTemplate> t { v8::FunctionTemplate::New(iv8) };
        t->InstanceTemplate()->SetInternalFieldCount(1);
        t->InstanceTemplate()->SetCallAsFunctionHandler(NativesObject::CallHandler);
        wrapper_callable_template_.Set(iv8, t);
    }
}

v8::Local<v8::UnboundScript> TemplateCache::GetInitScript() {
    RT_ASSERT(isolate_);
    v8::Isolate* iv8 = isolate_->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    InitrdFile initfile =  GLOBAL_initrd()->Get("/system/init.js");
    if (initfile.IsEmpty()) {
        printf("Unable to load /system/init.js file.");
        abort();
    }
    v8::Local<v8::String> inits = v8::String::NewFromUtf8(isolate_->IsolateV8(),
        reinterpret_cast<const char*>(initfile.Data()),
        v8::String::kNormalString, initfile.Size());

    v8::ScriptCompiler::Source source(inits);

    v8::Local<v8::UnboundScript> script = v8::ScriptCompiler
            ::CompileUnbound(iv8, &source,
              v8::ScriptCompiler::CompileOptions::kNoCompileOptions);
    return scope.Escape(script);
}

v8::Local<v8::Context> TemplateCache::NewContext() {
    v8::Isolate* iv8 = isolate_->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    if (global_object_template_.IsEmpty()) {
        global_object_template_.Set(iv8, v8::ObjectTemplate::New());
    }
    v8::Local<v8::Context> context = v8::Context::New(iv8, nullptr,
        global_object_template_.Get(iv8));

    ContextScope cs(context);

    if (init_script_.IsEmpty()) {
        init_script_.Set(iv8, GetInitScript());
    }

    RT_ASSERT(!init_script_.IsEmpty());
    v8::Local<v8::Value> init_func_val = init_script_.Get(iv8)
        ->BindToCurrentContext()->Run();

    RT_ASSERT(!init_func_val.IsEmpty());
    RT_ASSERT(init_func_val->IsFunction());
    v8::Local<v8::Function> init_func = v8::Local<v8::Function>::Cast(init_func_val);

    v8::Local<v8::Value> args_local[1] { (new NativesObject(isolate_))->GetInstance() };
    init_func->Call(context->Global(), 1, &args_local[0]);

    return scope.Escape(context);
}

v8::Local<v8::Value> TemplateCache::NewWrappedFunction(ExternalFunction* data) {
    RT_ASSERT(data);
    v8::Isolate* iv8 = isolate_->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    v8::Local<v8::Object> obj { wrapper_callable_template_.Get(iv8)
        ->InstanceTemplate()->NewInstance() };

    obj->SetAlignedPointerInInternalField(0,
        static_cast<NativeObjectWrapper*>(data));
    return scope.Escape(obj);
}

v8::Local<v8::Object> TemplateCache::NewWrappedObject(NativeObjectWrapper* nativeobj) {
    RT_ASSERT(nativeobj);
    v8::Isolate* iv8 = isolate_->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    v8::Local<v8::Object> obj = wrapper_template_.Get(isolate_->IsolateV8())
        ->InstanceTemplate()->NewInstance();

    obj->SetAlignedPointerInInternalField(0,
        static_cast<NativeObjectWrapper*>(nativeobj));
    return scope.Escape(obj);
}

} // namespace rt
