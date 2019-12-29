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

#include <vector>
#include <kernel/kernel.h>
#include <kernel/utils.h>
#include <v8.h>

#define NATIVE_FUNCTION(TypeName, FuncName) 									\
    void TypeName::FuncName(const v8::FunctionCallbackInfo<v8::Value>& args)

#define DECLARE_NATIVE(NAME)													\
    static void NAME(const v8::FunctionCallbackInfo<v8::Value>& args)

#define PROLOGUE		 														\
    auto th = V8Utils::GetThread(args);		 							\
    auto that = GetThis(th, args);			  								\
    if (nullptr == that) return;												\
    RT_ASSERT(th);															\
    RuntimeStateScope<RuntimeState::NATIVE_CALL> native_call_state(th->thread_manager()); \
    v8::Isolate* iv8 = th->IsolateV8();										\
    v8::Local<v8::Context> context = iv8->GetCurrentContext();				\
    RT_ASSERT(iv8)

#define PROLOGUE_NOTHIS		 													\
    auto th = V8Utils::GetThread(args);								\
    RT_ASSERT(th);															\
    RuntimeStateScope<RuntimeState::NATIVE_CALL> native_call_state(th->thread_manager()); \
    v8::Isolate* iv8 = th->IsolateV8();										\
    v8::Local<v8::Context> context = iv8->GetCurrentContext();				\
    RT_ASSERT(iv8)

#define USEARG(number)															\
    v8::Local<v8::Value> arg##number = args[number];							\
    RT_ASSERT(!arg##number.IsEmpty());

#define VALIDATEARG(number, argtype, message)									\
    if (!V8Utils::ValidateArg(args, number, V8Utils::ArgType::argtype)) {		\
        V8Utils::ThrowTypeError(iv8, message);									\
        return;																	\
    }

#define V8STRING(string)														\
    v8::String::NewFromUtf8(iv8, string)

#define LOCAL_V8STRING(name, string)											\
    v8::Local<v8::String> name { v8::String::NewFromUtf8(iv8, string, v8::NewStringType::kNormal).ToLocalChecked() }

#define THROW_ERROR(string)														\
    V8Utils::ThrowError(iv8, string);											\
    return;

#define THROW_TYPE_ERROR(string)												\
    V8Utils::ThrowTypeError(iv8, string);										\
    return;

#define THROW_RANGE_ERROR(string)												\
    V8Utils::ThrowRangeError(iv8, string);										\
    return;

namespace rt {

class Isolate;

class V8Utils {
public:
  enum class ArgType {
    STRING,
    UINT32,
    INT32,
    FUNCTION,
    OBJECT,
    ARRAYBUFFER,
    UINT8ARRAY,
    NUMBER,
    ARRAY,
    BOOL,
    PROMISE,
  };

  inline static std::string ToString(const v8::Local<v8::String> str) {
    RT_ASSERT(!str.IsEmpty());
    RT_ASSERT(str->IsString());
    v8::String::Utf8Value data_value(str);
    const char* cdata = *data_value;
    RT_ASSERT(cdata);
    std::string s(cdata);
    return s;
  }

  inline static v8::Local<v8::String> FromString(v8::Isolate* iv8, std::string str) {
    v8::EscapableHandleScope scope(iv8);
    if (str.empty()) {
      return scope.Escape(v8::String::Empty(iv8));
    }

    v8::MaybeLocal<v8::String> s = v8::String::NewFromUtf8(iv8,
                                   str.c_str(), v8::NewStringType::kNormal, str.length());
    return scope.Escape(s.ToLocalChecked());
  }

  inline static Thread* GetThread(const v8::FunctionCallbackInfo<v8::Value>& args) {
    return reinterpret_cast<Thread*>(args.GetIsolate()->GetData(0));
  }

  inline static Thread* GetThreadFromIsolate(v8::Isolate* iv8) {
    RT_ASSERT(iv8);
    return reinterpret_cast<Thread*>(iv8->GetData(0));
  }

  inline static bool ValidateArg(const v8::FunctionCallbackInfo<v8::Value>& args,
                                 int argnum, ArgType type) {

    if (argnum < 0) {
      return false;
    }
    if (args.Length() < argnum) {
      return false;
    }
    v8::Local<v8::Value> arg = args[argnum];
    switch (type) {
    case ArgType::STRING:
      return arg->IsString();
    case ArgType::FUNCTION:
      return arg->IsFunction();
    case ArgType::OBJECT:
      return arg->IsObject();
    case ArgType::UINT32:
      return arg->IsUint32();
    case ArgType::INT32:
      return arg->IsInt32();
    case ArgType::ARRAYBUFFER:
      return arg->IsArrayBuffer();
    case ArgType::UINT8ARRAY:
      return arg->IsUint8Array();
    case ArgType::NUMBER:
      return arg->IsNumber();
    case ArgType::ARRAY:
      return arg->IsArray();
    case ArgType::BOOL:
      return arg->IsBoolean();
    case ArgType::PROMISE:
      return arg->IsPromise();
    default:
      RT_ASSERT(!"Invalid type");
      return false;
    }
  }

  inline static void ThrowError(v8::Isolate* iv8, const char* message) {
    RT_ASSERT(iv8);
    RT_ASSERT(message);
    v8::MaybeLocal<v8::String> maybe_m = v8::String::NewFromUtf8(iv8, message,
                                         v8::NewStringType::kNormal);
    v8::Local<v8::String> m;
    if (!maybe_m.ToLocal(&m)) {
      return;
    }

    iv8->ThrowException(v8::Exception::Error(m));
  }

  inline static void ThrowTypeError(v8::Isolate* iv8, const char* message) {
    RT_ASSERT(iv8);
    RT_ASSERT(message);
    v8::MaybeLocal<v8::String> maybe_m = v8::String::NewFromUtf8(iv8, message,
                                         v8::NewStringType::kNormal);
    v8::Local<v8::String> m;
    if (!maybe_m.ToLocal(&m)) {
      return;
    }

    iv8->ThrowException(v8::Exception::TypeError(m));
  }

  inline static void ThrowRangeError(v8::Isolate* iv8, const char* message) {
    RT_ASSERT(iv8);
    RT_ASSERT(message);
    v8::MaybeLocal<v8::String> maybe_m = v8::String::NewFromUtf8(iv8, message,
                                         v8::NewStringType::kNormal);
    v8::Local<v8::String> m;
    if (!maybe_m.ToLocal(&m)) {
      return;
    }

    iv8->ThrowException(v8::Exception::RangeError(m));
  }
};

/**
 * Random access array for moveable elements
 * O(n) insert, O(1) remove, O(1) lookup
 */
template<typename T>
class IndexedPool {
public:
  uint32_t Push(T value) {
    for (uint32_t i = 0; i < data_.size(); ++i) {
      if (data_[i].IsEmpty()) {
        data_[i] = std::move(value);
        return i;
      }
    }

    uint32_t index = data_.size();
    data_.push_back(std::move(value));
    return index;
  }

  T& Get(uint32_t index) {
    RT_ASSERT(index < data_.size());
    return data_[index];
  }

  T Take(uint32_t index) {
    RT_ASSERT(index < data_.size());
    return std::move(data_[index]);
  }

  size_t size() const {
    return data_.size();
  }

  void Clear() {
    data_.clear();
  }
private:
  std::vector<T> data_;
};

/**
 * Random access array for unique persistent handles
 * O(n) insert, O(1) remove, O(1) lookup
 */
template<typename T>
class UniquePersistentIndexedPool {
public:
  uint32_t Push(v8::UniquePersistent<T> value) {
    for (uint32_t i = 0; i < data_.size(); ++i) {
      if (data_[i].IsEmpty()) {
        data_[i] = std::move(value);
        return i;
      }
    }

    uint32_t index = data_.size();
    data_.push_back(std::move(value));
    return index;
  }

  v8::UniquePersistent<T> Take(uint32_t index) {
    RT_ASSERT(index < data_.size());
    return std::move(data_[index]);
  }

  Nullable<uint32_t> Find(v8::Local<T> value) {
    for (uint32_t i = 0; i < data_.size(); ++i) {
      if (data_[i].IsEmpty()) {
        continue;
      }

      if (data_[i] == value) {
        return Nullable<uint32_t>(i);
      }
    }

    return Nullable<uint32_t>();
  }

  v8::Local<T> GetLocal(v8::Isolate* iv8, uint32_t index) const {
    RT_ASSERT(index < data_.size());
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape<T>(v8::Local<T>::New(iv8, data_[index]));
  }

  void Clear() {
    data_.clear();
  }

  uint32_t Size() const {
    return data_.size();
  }
private:
  std::vector<v8::UniquePersistent<T>> data_;
};

} // namespace rt
