// Copyright 2014 runtime.js project authors
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

#pragma once

#include <kernel/kernel.h>
#include <string>
#include <v8.h>
#include <functional>
#include <kernel/template-cache.h>
#include <kernel/thread.h>

namespace rt {

class ExportBuilder {
public:
  ExportBuilder(TemplateCache* tpl_cache, v8::Local<v8::Object>& obj)
    :	tpl_cache_(tpl_cache),
      obj_(obj) {
    RT_ASSERT(tpl_cache);
    RT_ASSERT(tpl_cache_->IsolateV8());
  }

  void SetCallback(std::string key, v8::FunctionCallback callback) {
    RT_ASSERT(tpl_cache_);
    v8::Isolate* iv8 = tpl_cache_->IsolateV8();
    v8::Local<v8::Context> context = iv8->GetCurrentContext();
    RT_ASSERT(iv8);
    v8::HandleScope scope(iv8);
    v8::Local<v8::FunctionTemplate> foo =
      v8::FunctionTemplate::New(iv8, callback);

    v8::Local<v8::Function> fn = foo->GetFunction(context).ToLocalChecked();
    v8::Local<v8::String> fname = v8::String::NewFromUtf8(iv8,
                                  key.c_str(), v8::NewStringType::kNormal).ToLocalChecked();

    fn->SetName(fname);
    obj_->Set(context, fname, fn);
  }
private:
  TemplateCache* tpl_cache_;
  v8::Local<v8::Object>& obj_;
};

/**
 * Wrapper for objects that own native object instance
 */
class JsObjectWrapperBase : public NativeObjectWrapper {
public:
  JsObjectWrapperBase(NativeTypeId type_id)
    :	NativeObjectWrapper(type_id),
      tpl_cache_(nullptr),
      reference_count_(0) {
    RT_ASSERT(nullptr == tpl_cache_);
  }

  virtual JsObjectWrapperBase* Clone() const = 0;

  JsObjectWrapperBase* BindToTemplateCache(TemplateCache* tpl_cache) {
    RT_ASSERT(tpl_cache);
    RT_ASSERT(!tpl_cache_);
    tpl_cache_ = tpl_cache;
    return this;
  }

  inline v8::Local<v8::Object> GetInstance() {
    RT_ASSERT(tpl_cache_ && "BindToTemplateCache() first");
    v8::Isolate* iv8 = tpl_cache_->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    EnsureInstance();
    return scope.Escape(v8::Local<v8::Object>::New(iv8, object_));
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
    EnsureInstance();
    object_.SetWeak(this, WeakCallback, v8::WeakCallbackType::kParameter);
  }

  inline void Unweak() {
    EnsureInstance();
    object_.ClearWeak();
  }
protected:
  virtual void ObjectInit(ExportBuilder obj) = 0;

  inline virtual ~JsObjectWrapperBase() {
    // Prevent V8 from deleting this object
    Unweak();
  }

  inline static void WeakCallback(const v8::WeakCallbackInfo<JsObjectWrapperBase>& data) {
    JsObjectWrapperBase* w = static_cast<JsObjectWrapperBase*>(data.GetParameter());
    data.GetParameter()->object_.Reset();
    delete w;
  }

  void EnsureInstance() {
    RT_ASSERT(tpl_cache_ && "BindToTemplateCache() first");

    if (!object_.IsEmpty()) {
      return;
    }

    v8::Isolate* iv8 = tpl_cache_->IsolateV8();
    RT_ASSERT(iv8);

    v8::HandleScope scope(iv8);
    RT_ASSERT(tpl_cache_);

    v8::Local<v8::Object> cached;
    if (tpl_cache_->Exists(type_id())) {
      cached = tpl_cache_->Get(type_id());
    } else {
      v8::Local<v8::Object> local_obj = tpl_cache_->NewWrappedObject(this);
      ObjectInit(ExportBuilder(tpl_cache_, local_obj));
      cached = local_obj;
      tpl_cache_->Put(type_id(), cached);
    }

    v8::Local<v8::Object> loc = cached->Clone();
    loc->SetAlignedPointerInInternalField(0, static_cast<NativeObjectWrapper*>(this));
    object_ = std::move(v8::UniquePersistent<v8::Object>(iv8, loc));
    object_.MarkIndependent();
    Weak();
  }

  TemplateCache* tpl_cache_;
  v8::UniquePersistent<v8::Object> object_;
  uint32_t reference_count_;
  DELETE_COPY_AND_ASSIGN(JsObjectWrapperBase);
};

template<typename T, NativeTypeId TypeId>
class JsObjectWrapper : public JsObjectWrapperBase {
public:
  inline JsObjectWrapper() : JsObjectWrapperBase(TypeId) { }

  inline static T* FromHandle(Thread* thread, v8::Local<v8::Value> val) {
    NativeObjectWrapper* ptr = TemplateCache::GetWrapped(val);
    if (nullptr == ptr) {
      return nullptr;
    }
    RT_ASSERT(ptr);

    // Wrong type check
    if (TypeId != ptr->type_id()) {
      return nullptr;
    }

    return static_cast<T*>(ptr);
  }

protected:
  static T* GetThis(Thread* thread, v8::Local<v8::Object> that) {
    NativeObjectWrapper* ptr = TemplateCache::GetWrapped(that);
    if (nullptr == ptr) {
      return nullptr;
    }

    // Wrong type check
    if (TypeId != ptr->type_id()) {
      return nullptr;
    }

    return static_cast<T*>(ptr);
  }

  static T* GetThis(Thread* thread,
                    const v8::FunctionCallbackInfo<v8::Value>& args) {
    RT_ASSERT(thread);
    v8::Local<v8::Object> that = args.This();
    return GetThis(thread, that);
  }

  inline static T* GetThis(Thread* thread,
                           const v8::PropertyCallbackInfo<v8::Value>& args) {
    RT_ASSERT(thread);
    v8::Local<v8::Object> that = args.This();
    return GetThis(thread, that);
  }
};

} // namespace rt
