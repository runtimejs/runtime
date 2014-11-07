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

namespace rt {

TemplateCache::TemplateCache(v8::Isolate* iv8)
    :   iv8_(iv8),
        handle_object_factory_(iv8) {
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
        global->Set(iv8_, "isolate", isolate);

        v8::Local<v8::ObjectTemplate> kernel { v8::ObjectTemplate::New() };
        kernel->Set(iv8_, "version", v8::FunctionTemplate::New(iv8_, NativesObject::Version));
        global->Set(iv8_, "kernel", kernel);

        v8::Local<v8::ObjectTemplate> runtime { v8::ObjectTemplate::New() };
        runtime->Set(iv8_, "bufferAddress", v8::FunctionTemplate::New(iv8_, NativesObject::BufferAddress));
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

v8::Local<v8::Value> TemplateCache::GetHandleInstance(uint32_t pool_id, uint32_t handle_id) {
    RT_ASSERT(iv8_);
    v8::EscapableHandleScope scope(iv8_);
    return scope.Escape(handle_object_factory_.Get(pool_id, handle_id));
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

v8::Local<v8::Object> HandleObjectFactory::Get(uint32_t pool_id, uint32_t handle_id) {
    v8::EscapableHandleScope scope(iv8_);
    uint64_t key = MakeKey(pool_id, handle_id);
    auto value = map_.find(key);
    if (value != map_.end()) {
        return scope.Escape(v8::Local<v8::Object>::New(iv8_, value->second));
    }

    {   auto handle_object = new HandleObject(pool_id, handle_id);
        auto pool = GLOBAL_engines()->handle_pools().GetPoolById(handle_object->pool_id());
        RT_ASSERT(pool);
        RT_ASSERT(pool->index() == handle_object->pool_id());

        auto index = pool->index();
        RT_ASSERT(index < HandlePoolManager::kMaxHandlePools);

        if (handle_pool_templates_[index].IsEmpty()) {
            v8::Local<v8::ObjectTemplate> t { v8::ObjectTemplate::New(iv8_) };
            t->SetInternalFieldCount(1);

            uint32_t mi = 0;
            for (auto& method_name : pool->methods()) {
                auto name = v8::String::NewFromUtf8(iv8_, method_name.c_str(),
                    v8::String::kNormalString, method_name.length());

                static_assert(sizeof(void*) == sizeof(uint64_t), "64-bit pointer size required");
                uint64_t pack = (static_cast<uint64_t>(index) << 32) | (mi++);

                t->Set(name, v8::FunctionTemplate::New(iv8_,
                    NativesObject::HandleMethodCall, v8::External::New(iv8_, reinterpret_cast<void*>(pack))));
            }

            handle_pool_templates_[index].Set(iv8_, t);
        }

        v8::Local<v8::Object> obj { handle_pool_templates_[index].Get(iv8_)->NewInstance() };
        obj->SetAlignedPointerInInternalField(0, static_cast<HandleObject*>(handle_object));
        auto persistent = MoveablePersistent<v8::Object>(iv8_, obj);
        persistent.SetWeak(this, WeakCallback);
        map_[key] = std::move(persistent);
        return scope.Escape(obj);
    }
}

void HandleObjectFactory::WeakCallback(const v8::WeakCallbackData<v8::Object, HandleObjectFactory>& data) {
    auto factory = data.GetParameter();
    RT_ASSERT(factory);

    auto handle_object = static_cast<HandleObject*>(data.GetValue()->GetAlignedPointerFromInternalField(0));
    RT_ASSERT(handle_object);

    uint64_t key = MakeKey(handle_object->pool_id(), handle_object->handle_id());
    auto value = factory->map_.find(key);
    if (value != factory->map_.end()) {
        factory->map_.erase(value);
    }

    delete handle_object;
}

} // namespace rt
