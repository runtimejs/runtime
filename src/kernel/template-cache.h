// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <vector>
#include <array>
#include <v8.h>
#include <kernel/isolate.h>

namespace rt {

enum class WrappedTypeIds : uint32_t {
    TYPEID_NULL,
    TYPEID_NATIVES,
    TYPEID_IOPORTX64,
    TYPEID_ACPI_MANAGER,
    TYPEID_ACPI_HANDLE,
    TYPEID_RESOURCE_MEMORY_RANGE,
    TYPEID_RESOURCE_MEMORY_BLOCK,
    TYPEID_RESOURCE_IRQ_RANGE,
    TYPEID_RESOURCE_IRQ,
    TYPEID_RESOURCE_IO_RANGE,
    TYPEID_PROCESS_HANDLE,
    TYPEID_PROCESS_MANAGER_HANDLE,
    TYPEID_ALLOCATOR,

    LAST // Keep it last element
};

class ContextScope {
public:
    explicit inline ContextScope(v8::Local<v8::Context> context)
        :	context_(context) {
        context_->Enter();
    }
    inline ~ContextScope() { context_->Exit(); }

private:
    v8::Local<v8::Context> context_;
};

class TemplateCache {
public:
    TemplateCache(Isolate* isolate);

    v8::Local<v8::Value> MakeRemoteFunction(void* data) {
        v8::Isolate* iv8 = isolate_->IsolateV8();
        v8::EscapableHandleScope scope(iv8);
        v8::Local<v8::Object> obj { remote_function_template_.Get(iv8)
            ->InstanceTemplate()->NewInstance() };

        obj->SetAlignedPointerInInternalField(0, data);
        return scope.Escape(obj);
    }

    v8::Local<v8::Object> NewWrapped(void* nativeobj) {
        v8::EscapableHandleScope scope(isolate_->IsolateV8());
        v8::Local<v8::Object> obj = wrapper_template_.Get(isolate_->IsolateV8())
            ->InstanceTemplate()->NewInstance();

        obj->SetAlignedPointerInInternalField(0, nativeobj);
        obj->SetInternalField(1, keytoken_.Get(isolate_->IsolateV8()));
        return scope.Escape(obj);
    }

    bool Exists(WrappedTypeIds key) {
        return 1 == stor_exists_[(uint32_t)key];
    }

    void Put(WrappedTypeIds key, v8::Local<v8::Object> obj) {
        stor_[(uint32_t)key].Set(isolate_->IsolateV8(), obj);
        stor_exists_[(uint32_t)key] = 1;
    }

    v8::Local<v8::Object> Get(WrappedTypeIds key) {
        RT_ASSERT(1 == stor_exists_[(uint32_t)key]);
        v8::EscapableHandleScope scope(isolate_->IsolateV8());
        return scope.Escape(stor_[(uint32_t)key].Get(isolate_->IsolateV8()));
    }

    void* GetWrapped(v8::Local<v8::Value> value) {
        if (value.IsEmpty()) return nullptr;
        if (!value->IsObject()) return nullptr;

        v8::Local<v8::Object> obj { value->ToObject() };
        if (obj->InternalFieldCount() < 2) return nullptr;
        v8::Local<v8::Value> kt { obj->GetInternalField(1) };

        if (!kt->IsExternal()) return nullptr;
        v8::Local<v8::External> ext { v8::Local<v8::External>::Cast(kt) };
        if (!ext->SameValue(keytoken_.Get(isolate_->IsolateV8()))) return nullptr;

        void* ptr = obj->GetAlignedPointerFromInternalField(0);
        RT_ASSERT(ptr);
        return ptr;
    }

    v8::Local<v8::Context> NewContext();
private:
    v8::Local<v8::UnboundScript> GetInitScript();
    Isolate* isolate_;
    v8::Eternal<v8::ObjectTemplate> global_template_;
    v8::Eternal<v8::FunctionTemplate> wrapper_template_;
    v8::Eternal<v8::FunctionTemplate> remote_function_template_;
    v8::Eternal<v8::UnboundScript> init_script_;
    v8::Eternal<v8::External> keytoken_;
    std::array<v8::Eternal<v8::Object>, (uint32_t)WrappedTypeIds::LAST> stor_;
    std::array<uint8_t, (uint32_t)WrappedTypeIds::LAST> stor_exists_;
};

} // namespace rt
