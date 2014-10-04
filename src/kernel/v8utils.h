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

#pragma once

#include <kernel/kernel.h>
#include <kernel/string.h>
#include <kernel/vector.h>
#include <common/utils.h>
#include <v8.h>

using common::Nullable;

#define NATIVE_FUNCTION(TypeName, FuncName) 									\
    void TypeName::FuncName(const v8::FunctionCallbackInfo<v8::Value>& args)

#define DECLARE_NATIVE(NAME)													\
    static void NAME(const v8::FunctionCallbackInfo<v8::Value>& args)

#define PROLOGUE		 														\
    auto th = V8Utils::GetThread(args);		 							\
    auto that = GetThis(th, args);			  								\
    if (nullptr == that) return;												\
    RT_ASSERT(th);															\
    v8::Isolate* iv8 = th->IsolateV8();										\
    RT_ASSERT(iv8)

#define PROLOGUE_NOTHIS		 													\
    auto th = V8Utils::GetThread(args);								\
    RT_ASSERT(th);															\
    v8::Isolate* iv8 = th->IsolateV8();										\
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
    v8::Local<v8::String> name { v8::String::NewFromUtf8(iv8, string) }

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

class V8Utils
{
public:
    enum class ArgType {
        STRING,
        UINT32,
        INT32,
        FUNCTION,
        OBJECT,
        ARRAYBUFFER,
        NUMBER,
        ARRAY,
        BOOL,
        PROMISE,
    };

    inline static String ToString(const v8::Local<v8::String> str) {
        RT_ASSERT(!str.IsEmpty());
        RT_ASSERT(str->IsString());
        v8::String::Utf8Value data_value(str);
        const char* cdata = *data_value;
        RT_ASSERT(cdata);
        String s(cdata);
        return s;
    }

    inline static v8::Local<v8::String> FromString(v8::Isolate* iv8, String str) {
        v8::EscapableHandleScope scope(iv8);
        return scope.Escape(v8::String::NewFromUtf8(iv8, str.Data(),
                v8::String::kNormalString, str.Length()));
    }

    inline static Thread* GetThread(const v8::FunctionCallbackInfo<v8::Value>& args) {
        return reinterpret_cast<Thread*>(args.GetIsolate()->GetData(0));
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
        case ArgType::STRING: return arg->IsString();
        case ArgType::FUNCTION: return arg->IsFunction();
        case ArgType::OBJECT: return arg->IsObject();
        case ArgType::UINT32: return arg->IsUint32();
        case ArgType::INT32: return arg->IsInt32();
        case ArgType::ARRAYBUFFER: return arg->IsArrayBuffer();
        case ArgType::NUMBER: return arg->IsNumber();
        case ArgType::ARRAY: return arg->IsArray();
        case ArgType::BOOL: return arg->IsBoolean();
        case ArgType::PROMISE: return arg->IsPromise();
        default:
            RT_ASSERT(!"Invalid type");
            return false;
        }
    }

    inline static void ThrowError(v8::Isolate* iv8, const char* message) {
        RT_ASSERT(iv8);
        RT_ASSERT(message);
        v8::Local<v8::String> m = v8::String::NewFromUtf8(iv8, message,
                                                          v8::String::kNormalString);
        iv8->ThrowException(v8::Exception::Error(m));
    }

    inline static void ThrowTypeError(v8::Isolate* iv8, const char* message) {
        RT_ASSERT(iv8);
        RT_ASSERT(message);
        v8::Local<v8::String> m = v8::String::NewFromUtf8(iv8, message,
                                                          v8::String::kNormalString);
        iv8->ThrowException(v8::Exception::TypeError(m));
    }

    inline static void ThrowRangeError(v8::Isolate* iv8, const char* message) {
        RT_ASSERT(iv8);
        RT_ASSERT(message);
        v8::Local<v8::String> m = v8::String::NewFromUtf8(iv8, message,
                                                          v8::String::kNormalString);
        iv8->ThrowException(v8::Exception::RangeError(m));
    }

    inline static StringsVector ToStringsVector(const v8::Local<v8::Array> arr) {
        RT_ASSERT(!arr.IsEmpty());
        RT_ASSERT(arr->IsArray());

        uint32_t len = arr->Length();
        if (0 == len) {
            return StringsVector();
        }

        StringsVector sv;
        sv.reserve(len);
        for (uint32_t i = 0; i < len; ++i) {
            v8::Local<v8::Value> v = arr->Get(i);
            v8::Local<v8::String> vs = v->ToString();
            sv.push_back(ToString(vs));
        }
        return sv;
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

    size_t size() const { return data_.size(); }

    void Clear() {
        data_.clear();
    }
private:
    SharedSTLVector<T> data_;
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
private:
    SharedSTLVector<v8::UniquePersistent<T>> data_;
};

} // namespace rt
