// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>
#include <string>
#include <v8.h>
#include <functional>
#include <kernel/template-cache.h>
#include <kernel/isolate.h>

namespace rt {

class ExportBuilder
{
public:
    ExportBuilder(Isolate* isolate, v8::Local<v8::Object>& obj)
        :	isolate_(isolate),
            obj_(obj) { }

    void SetCallback(std::string key, v8::FunctionCallback callback) {
        v8::HandleScope scope(isolate_->IsolateV8());
        v8::Local<v8::FunctionTemplate> foo =
            v8::FunctionTemplate::New(isolate_->IsolateV8(), callback);

        v8::Local<v8::Function> fn = foo->GetFunction();
        v8::Local<v8::String> fname =
            v8::String::NewFromOneByte(isolate_->IsolateV8(),
                reinterpret_cast<const uint8_t*>(key.c_str()));

        fn->SetName(fname);
        obj_->Set(fname, fn);
    }

    void SetAccessors(std::string key, v8::AccessorGetterCallback getter,
                      v8::AccessorSetterCallback setter = nullptr) {
        v8::Local<v8::String> fname =
            v8::String::NewFromOneByte(isolate_->IsolateV8(),
                reinterpret_cast<const uint8_t*>(key.c_str()));

        obj_->SetAccessor(fname, getter, setter);
    }

private:
    Isolate* isolate_;
    v8::Local<v8::Object>& obj_;
};

class JsObjectWrapperBase {
public:
    JsObjectWrapperBase(Isolate* isolate, WrappedTypeIds type_id)
        :	isolate_(isolate),
            instance_typeid_(type_id),
            reference_count_(0) {
        RT_ASSERT(isolate);
    }

    inline WrappedTypeIds type_id() const {
        return instance_typeid_;
    }

    inline v8::Local<v8::Object> GetInstance() {
        v8::EscapableHandleScope scope(isolate_->IsolateV8());
        WrappedTypeIds type_id = instance_typeid_;

        TemplateCache* tc = isolate_->template_cache();
        if (object_.IsEmpty()) {

            v8::Local<v8::Object> cached;
            if (tc->Exists(type_id)) {
                cached = tc->Get(type_id);
            } else {
                v8::Local<v8::Object> local_obj = tc->NewWrapped(this);
                ObjectInit(ExportBuilder(isolate_, local_obj));
                cached = local_obj;
                tc->Put(type_id, cached);
            }

            v8::Local<v8::Object> loc = cached->Clone();
            loc->SetAlignedPointerInInternalField(0, this);
            object_ = std::move(v8::UniquePersistent<v8::Object>(isolate_->IsolateV8(), loc));
            object_.MarkIndependent();
            Weak();
            return scope.Escape(loc);
        } else {
            return scope.Escape(v8::Local<v8::Object>::New(isolate_->IsolateV8(), object_));
        }
    }

    inline void AddReference() {
        Unweak();
        ++reference_count_;
    }

    inline void RemoveReference() {
        if (0 == reference_count_) {
            return;
        }
        if (0 == --reference_count_) {
            Weak();
        }
    }

    inline void Weak() {
        object_.SetWeak(this, WeakCallback);
    }

    inline void Unweak() {
        object_.ClearWeak();
    }
protected:
    virtual void ObjectInit(ExportBuilder obj) = 0;

    inline virtual ~JsObjectWrapperBase() {
        // Prevent V8 from deleting this object
        Unweak();
    }

    inline static void WeakCallback(const v8::WeakCallbackData<v8::Object,
                                    JsObjectWrapperBase>& data) {
        JsObjectWrapperBase* w = static_cast<JsObjectWrapperBase*>(data.GetParameter());
        delete w;
    }

    v8::UniquePersistent<v8::Object> object_;
    Isolate* const isolate_;
    WrappedTypeIds instance_typeid_;
    uint32_t reference_count_;
    DELETE_COPY_AND_ASSIGN(JsObjectWrapperBase);
};

template<typename T, WrappedTypeIds TypeId>
class JsObjectWrapper : public JsObjectWrapperBase {
public:
    inline JsObjectWrapper(Isolate* isolate)
        :	JsObjectWrapperBase(isolate, TypeId) { }

    inline static T* FromHandle(Isolate* isolate, v8::Local<v8::Value> val) {
        RT_ASSERT(isolate);
        RT_ASSERT(isolate->template_cache());
        void* ptr = isolate->template_cache()->GetWrapped(val);
        if (nullptr == ptr) return nullptr;
        RT_ASSERT(ptr);
        if (TypeId != (static_cast<JsObjectWrapper<T,TypeId>*>(ptr))->instance_typeid_) {
            // Wrong type
            return nullptr;
        }
        return static_cast<T*>(ptr);
    }

protected:
    inline static T* GetThis(Isolate* isolate, v8::Local<v8::Object> that) {
        RT_ASSERT(isolate);
        RT_ASSERT(isolate->template_cache());
        void* ptr = isolate->template_cache()->GetWrapped(that);
        if (nullptr == ptr) return nullptr;

        if (TypeId != (static_cast<JsObjectWrapper<T,TypeId>*>(ptr))->instance_typeid_) {
            // Wrong type
            return nullptr;
        }

        return static_cast<T*>(ptr);
    }

    inline static T* GetThis(Isolate* isolate,
                             const v8::FunctionCallbackInfo<v8::Value>& args) {
        RT_ASSERT(isolate);
        v8::Local<v8::Object> that = args.This();
        return GetThis(isolate, that);
    }

    inline static T* GetThis(Isolate* isolate,
                             const v8::PropertyCallbackInfo<v8::Value>& args) {
        RT_ASSERT(isolate);
        v8::Local<v8::Object> that = args.This();
        return GetThis(isolate, that);
    }
};

} // namespace rt
