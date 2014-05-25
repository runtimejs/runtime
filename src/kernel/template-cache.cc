// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "template-cache.h"
#include <kernel/native-object.h>

namespace rt {

TemplateCache::TemplateCache(Isolate* isolate)
    :	isolate_(isolate) {
    v8::Isolate* iv8 = isolate->IsolateV8();
    v8::HandleScope scope(iv8);
    v8::Local<v8::FunctionTemplate> t =
        v8::FunctionTemplate::New(iv8);

    t->InstanceTemplate()->SetInternalFieldCount(2);
    wrapper_template_.Set(iv8, t);

    for (size_t i = 0; i < stor_exists_.size(); ++i) {
        stor_exists_[i] = 0;
    }

    // Use TemplateCache instance as keytoken
    keytoken_.Set(iv8, v8::External::New(iv8, this));

    v8::Local<v8::FunctionTemplate> fnt { v8::FunctionTemplate::New(iv8) };
    fnt->InstanceTemplate()->SetInternalFieldCount(1);
    fnt->InstanceTemplate()->SetCallAsFunctionHandler(NativesObject::RemoteCall);

    remote_function_template_.Set(iv8, fnt);
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
    if (global_template_.IsEmpty()) {
        global_template_.Set(iv8, v8::ObjectTemplate::New());
    }
    v8::Local<v8::Context> context = v8::Context::New(iv8, nullptr,
        global_template_.Get(iv8));

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

} // namespace rt
