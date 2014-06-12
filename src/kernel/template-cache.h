// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <vector>
#include <array>
#include <v8.h>
#include <kernel/isolate.h>

namespace rt {

class ExternalFunction;

/**
 * List of available v8-exposed objects
 */
enum class NativeTypeId : uint32_t {
    NIL, // Keep it as the first element

    TYPEID_NATIVES,
    TYPEID_ACPI_MANAGER,
    TYPEID_ACPI_HANDLE,
    TYPEID_RESOURCE_MEMORY_RANGE,
    TYPEID_RESOURCE_MEMORY_BLOCK,
    TYPEID_RESOURCE_IRQ_RANGE,
    TYPEID_RESOURCE_IRQ,
    TYPEID_RESOURCE_IO_PORT,
    TYPEID_RESOURCE_IO_RANGE,
    TYPEID_PROCESS_HANDLE,
    TYPEID_PROCESS_MANAGER_HANDLE,
    TYPEID_ALLOCATOR,
    TYPEID_FUNCTION,

    LAST // Keep it as the last element
};

/**
 * Wrapper for all types of objects exposed to scripts
 */
class NativeObjectWrapper {
public:
    NativeObjectWrapper(NativeTypeId type_id)
        :	instance_typeid_(type_id) {
        RT_ASSERT((uint32_t)instance_typeid_ > (uint32_t)NativeTypeId::NIL);
        RT_ASSERT((uint32_t)instance_typeid_ < (uint32_t)NativeTypeId::LAST);
    }

    /**
     * Get type of wrapped object
     */
    inline NativeTypeId type_id() const { return instance_typeid_; }
private:
    NativeTypeId instance_typeid_;
};

/**
 * Per-isolate cache for v8 object and function templates
 */
class TemplateCache {
public:
    TemplateCache(Isolate* isolate);

    /**
     * Creates v8 callable object which represents exported external
     * function
     */
    v8::Local<v8::Value> NewWrappedFunction(ExternalFunction* data);

    /**
     * Creates v8 object which represents native object instance
     */
    v8::Local<v8::Object> NewWrappedObject(NativeObjectWrapper* nativeobj);

    /**
     * Check if object already in cache
     */
    bool Exists(NativeTypeId key) {
        return !object_cache_[(uint32_t)key].IsEmpty();
    }

    /**
     * Put object into cache
     */
    void Put(NativeTypeId key, v8::Local<v8::Object> obj) {
        RT_ASSERT(object_cache_[(uint32_t)key].IsEmpty());
        object_cache_[(uint32_t)key].Set(isolate_->IsolateV8(), obj);
    }

    /**
     * Get object from cache
     */
    v8::Local<v8::Object> Get(NativeTypeId key) {
        RT_ASSERT(!object_cache_[(uint32_t)key].IsEmpty());
        v8::EscapableHandleScope scope(isolate_->IsolateV8());
        return scope.Escape(object_cache_[(uint32_t)key].Get(isolate_->IsolateV8()));
    }

    /**
     * Check if provided value is wrapper for native object
     * Returns instance pointer or nullptr
     */
    NativeObjectWrapper* GetWrapped(v8::Local<v8::Value> value) {
        if (value.IsEmpty()) return nullptr;
        if (!value->IsObject()) return nullptr;

        v8::Local<v8::Object> obj { value->ToObject() };
        if (obj->InternalFieldCount() < 1) return nullptr;

        void* ptr = obj->GetAlignedPointerFromInternalField(0);
        RT_ASSERT(ptr);
        return static_cast<NativeObjectWrapper*>(ptr);
    }

    /**
     * Create new v8 context. This will run init script
     * for context automatically
     */
    v8::Local<v8::Context> NewContext();
private:
    v8::Local<v8::UnboundScript> GetInitScript();
    Isolate* isolate_;
    v8::Eternal<v8::ObjectTemplate> global_object_template_;
    v8::Eternal<v8::FunctionTemplate> wrapper_template_;
    v8::Eternal<v8::FunctionTemplate> wrapper_callable_template_;
    v8::Eternal<v8::UnboundScript> init_script_;
    std::array<v8::Eternal<v8::Object>, (uint32_t)NativeTypeId::LAST> object_cache_;
};

} // namespace rt
