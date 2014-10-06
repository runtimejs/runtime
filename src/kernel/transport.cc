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

#include "transport.h"
#include <kernel/template-cache.h>
#include <kernel/object-wrapper.h>
#include <kernel/thread.h>
#include <kernel/native-object.h>
#include <kernel/arraybuffer.h>

namespace rt {

TransportData::SerializeError TransportData::MoveValue(Thread* exporter,
                                                       Thread* recv,
                                                       v8::Local<v8::Value> value) {
    RT_ASSERT(exporter);
    Clear();
    thread_ = exporter;
    allow_ref_ = recv == exporter;

    SerializeError err { SerializeValue(exporter, value, 1) };
    if (SerializeError::NONE != err) {
        SetUndefined();
    }

    return err;
}

TransportData::SerializeError TransportData::MoveArgs(Thread* exporter,
                                                      Thread* recv,
                                                      const v8::FunctionCallbackInfo<v8::Value>& args) {
    RT_ASSERT(exporter);
    Clear();
    thread_ = exporter;
    allow_ref_ = recv == exporter;

    uint32_t len = args.Length();
    if (0 == len) {
        AppendType(Type::EMPTY_ARRAY);
        return SerializeError::NONE;
    }

    AppendType(Type::ARRAY);
    stream_.AppendValue<uint32_t>(len);

    for (uint32_t i = 0; i < len; ++i) {
        SerializeError err { SerializeValue(exporter, args[i], 1) };
        if (SerializeError::NONE != err) {
            SetUndefined();
            return err;
        }
    }

    return SerializeError::NONE;
}

v8::Local<v8::Value> TransportData::GetRef(v8::Isolate* iv8, uint32_t index) const {
    RT_ASSERT(allow_ref_);
    RT_ASSERT(iv8);
    RT_ASSERT(thread_);
    RT_ASSERT(thread_->IsolateV8());
    RT_ASSERT(thread_->IsolateV8() == iv8);
    RT_ASSERT(index < refs_.size());
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape(v8::Local<v8::Value>::New(iv8, refs_[index]));
}

uint32_t TransportData::AddRef(v8::Local<v8::Value> value) {
    RT_ASSERT(allow_ref_);
    RT_ASSERT(thread_);
    RT_ASSERT(thread_->IsolateV8());
    size_t index = refs_.size();
    refs_.push_back(std::move(v8::UniquePersistent<v8::Value>(thread_->IsolateV8(), value)));
    return static_cast<uint32_t>(index);
}

TransportData::SerializeError TransportData::SerializeValue(Thread* exporter,
                                                            v8::Local<v8::Value> value,
                                                            uint32_t stack_level) {
    RT_ASSERT(exporter);
    RT_ASSERT(!value.IsEmpty());

    if (stack_level > kMaxStackSize) {
        return SerializeError::MAX_STACK;
    }

    if (value->IsUndefined()) {
        AppendType(Type::UNDEFINED);
        return SerializeError::NONE;
    }

    if (value->IsNull()) {
        AppendType(Type::NUL);
        return SerializeError::NONE;
    }

    if (value->IsBoolean()) {
        AppendType(value->BooleanValue() ? Type::BOOL_TRUE : Type::BOOL_FALSE);
        return SerializeError::NONE;
    }

    if (value->IsArrayBuffer()) {
        // Neuter this array buffer and take its contents
        AppendType(Type::ARRAYBUFFER);
        RT_ASSERT(thread_);
        RT_ASSERT(thread_->IsolateV8());
        v8::Isolate* iv8 { thread_->IsolateV8() };
        v8::Local<v8::ArrayBuffer> b { v8::Local<v8::ArrayBuffer>::Cast(value) };
        if (0 == b->ByteLength()) {
            return SerializeError::EMPTY_BUFFER;
        }

        auto ab = ArrayBuffer::FromInstance(iv8, b);
        stream_.AppendValue<void*>(ab->data());
        stream_.AppendValue<size_t>(ab->size());

        // Make sure ArrayBuffer wrapper instance is aware
        // that buffer is neutered here
        ab->Neuter();
        RT_ASSERT(0 == ab->size());
        RT_ASSERT(0 == b->ByteLength());
        return SerializeError::NONE;
    }

    if (value->IsInt32()) {
        AppendType(Type::INT32);
        stream_.AppendValue<int32_t>(value->Int32Value());
        return SerializeError::NONE;
    }

    if (value->IsUint32()) {
        AppendType(Type::UINT32);
        stream_.AppendValue<uint32_t>(value->Uint32Value());
        return SerializeError::NONE;
    }

    if (value->IsNumber()) {
        AppendType(Type::DOUBLE);
        stream_.AppendValue<double>(value->NumberValue());
        return SerializeError::NONE;
    }

    if (value->IsString()) {
        AppendString(value);
        return SerializeError::NONE;
    }

    if (value->IsArray()) {
        AppendType(Type::ARRAY);
        v8::Local<v8::Array> a { v8::Local<v8::Array>::Cast(value) };
        stream_.AppendValue<uint32_t>(a->Length());

        for (uint32_t i = 0; i < a->Length(); ++i) {
            SerializeError err { SerializeValue(exporter, a->Get(i), stack_level + 1) };
            if (SerializeError::NONE != err) {
                return err;
            }
        }

        return SerializeError::NONE;
    }

    if (value->IsArrayBufferView()) {
        return SerializeError::TYPEDARRAY_VIEW;
    }

    if (value->IsFunction()) {
        ExternalFunction* efn { exporter->AddExport(value) };
        AppendType(Type::FUNCTION);
        stream_.AppendValue<ExternalFunction*>(efn);
        return SerializeError::NONE;
    }

    if (value->IsNativeError()) {
        RT_ASSERT(thread_);
        RT_ASSERT(thread_->IsolateV8());
        AppendType(Type::ERROR_OBJ);
        v8::Isolate* iv8 { thread_->IsolateV8() };
        LOCAL_V8STRING(s_message, "message");
        v8::Local<v8::Object> obj { value->ToObject() };
        v8::Local<v8::Value> msg { obj->Get(s_message) };
        if (!msg->IsString()) {
            LOCAL_V8STRING(s_no_message, "<no error message>");
            AppendString(s_no_message);
        } else {
            AppendString(msg);
        }
        return SerializeError::NONE;
    }

    // This condition check should be the last one
    if (value->IsObject()) {
        RT_ASSERT(thread_);
        RT_ASSERT(thread_->template_cache());

        v8::Local<v8::Object> obj { value->ToObject() };
        NativeObjectWrapper* ptr { thread_->template_cache()->GetWrapped(value) };

        // If current object is wrapped native
        if (nullptr != ptr) {
            switch (ptr->type_id()) {
            case NativeTypeId::TYPEID_FUNCTION: {
                ExternalFunction* efn { static_cast<ExternalFunction*>(ptr) };
                AppendType(Type::FUNCTION);
                stream_.AppendValue<ExternalFunction*>(efn);
                return SerializeError::NONE;
            }
            default:
                break;
            }

            if (allow_ref_) {
                AppendType(Type::OBJECT_REF);
                stream_.AppendValue<uint32_t>(AddRef(value));
                return SerializeError::NONE;
            } else {
                JsObjectWrapperBase* baseptr { static_cast<JsObjectWrapperBase*>(ptr) };
                RT_ASSERT(baseptr);
                auto clone = baseptr->Clone();
                if (nullptr != clone) {
                    AppendType(Type::NATIVE_OBJECT);
                    stream_.AppendValue<JsObjectWrapperBase*>(clone);
                    return SerializeError::NONE;
                } else {
                    return SerializeError::NOT_CLONABLE;
                }
            }
        }

        AppendType(Type::HASHMAP);
        v8::Local<v8::Array> a { obj->GetOwnPropertyNames() };
        stream_.AppendValue<uint32_t>(a->Length());
        for (uint32_t i = 0; i < a->Length(); ++i) {
            v8::Local<v8::Value> k { a->Get(i) };
            {	SerializeError err { SerializeValue(exporter, k, stack_level + 1) };
                if (SerializeError::NONE != err) {
                    return err;
                }
            }

            {	SerializeError err { SerializeValue(exporter, obj->Get(k), stack_level + 1) };
                if (SerializeError::NONE != err) {
                    return err;
                }
            }
        }

        return SerializeError::NONE;
    }

    return SerializeError::INVALID_TYPE;
}

v8::Local<v8::Value> TransportData::Unpack(Thread* thread) const {
    RT_ASSERT(thread);
    v8::Isolate* iv8 { thread->IsolateV8() };
    RT_ASSERT(iv8);

    ByteStreamReader reader(stream_);
    if (allow_ref_) {
        RT_ASSERT(nullptr != thread_);
    }
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape(UnpackValue(thread, reader));
}

v8::Local<v8::Value> TransportData::UnpackValue(Thread* thread, ByteStreamReader& reader) const {
    RT_ASSERT(thread);
    v8::Isolate* iv8 { thread->IsolateV8() };
    RT_ASSERT(iv8);

    v8::EscapableHandleScope scope(iv8);
    Type t { ReadType(reader) };

    switch (t) {
    case Type::UNDEFINED:
        return scope.Escape<v8::Primitive>(v8::Undefined(iv8));
    case Type::NUL:
        return scope.Escape<v8::Primitive>(v8::Null(iv8));
    case Type::STRING_UTF8: {
        uint32_t len = reader.ReadValue<uint32_t>();
        return scope.Escape(v8::String::NewFromUtf8(iv8,
            reinterpret_cast<const char*>(reader.ReadBuffer(len + 1)),
            v8::String::kNormalString, len));
    }
    case Type::STRING_16: {
        uint32_t len = reader.ReadValue<uint32_t>();
        return scope.Escape(v8::String::NewFromTwoByte(iv8,
            reinterpret_cast<const uint16_t*>(reader.ReadBuffer((len + 1) * sizeof(uint16_t))),
            v8::String::kNormalString, len));
    }
    case Type::STRING_REF:
    case Type::OBJECT_REF:
        return scope.Escape(GetRef(iv8, reader.ReadValue<uint32_t>()));
    case Type::INT32:
        return scope.Escape<v8::Primitive>(v8::Int32::New(iv8,
            reader.ReadValue<int32_t>()));
    case Type::UINT32:
        return scope.Escape<v8::Primitive>(v8::Uint32::NewFromUnsigned(iv8,
            reader.ReadValue<uint32_t>()));
    case Type::DOUBLE:
        return scope.Escape<v8::Primitive>(v8::Number::New(iv8,
            reader.ReadValue<double>()));
    case Type::BOOL_TRUE:
        return scope.Escape<v8::Primitive>(v8::True(iv8));
    case Type::BOOL_FALSE:
        return scope.Escape<v8::Primitive>(v8::False(iv8));
    case Type::ARRAYBUFFER: {
        void* buf = reader.ReadValue<void*>();
        size_t len = reader.ReadValue<size_t>();
        return scope.Escape(ArrayBuffer::FromBuffer(iv8, buf, len)->GetInstance());
    }
    case Type::EMPTY_ARRAY:
        return scope.Escape(v8::Array::New(iv8, 0));
    case Type::ARRAY: {
        uint32_t len = reader.ReadValue<uint32_t>();
        v8::Local<v8::Array> arr { v8::Array::New(iv8, len) };
        for (uint32_t i = 0; i < len; ++i) {
            arr->Set(i, UnpackValue(thread, reader));
        }
        return scope.Escape(arr);
    }
    case Type::HASHMAP: {
        uint32_t len = reader.ReadValue<uint32_t>();
        v8::Local<v8::Object> obj { v8::Object::New(iv8) };
        for (uint32_t i = 0; i < len; ++i) {
            v8::Local<v8::Value> k { UnpackValue(thread, reader) };
            v8::Local<v8::Value> v { UnpackValue(thread, reader) };
            obj->Set(k, v);
        }
        return scope.Escape(obj);
    }
    case Type::FUNCTION: {
        ExternalFunction* efn = reader.ReadValue<ExternalFunction*>();
        RT_ASSERT(efn);
        RT_ASSERT(thread->template_cache());
        v8::Local<v8::Value> fnobj { thread->template_cache()->NewWrappedFunction(efn) };
        return scope.Escape(fnobj);
    }
    case Type::NATIVE_OBJECT: {
        JsObjectWrapperBase* baseptr = reader.ReadValue<JsObjectWrapperBase*>();
        RT_ASSERT(baseptr);
        RT_ASSERT(thread->template_cache());
        return scope.Escape(baseptr->BindToTemplateCache(thread->template_cache())
            ->GetInstance());
    }
    case Type::ERROR_OBJ: {
        v8::Local<v8::Value> v { UnpackValue(thread, reader) };
        return scope.Escape(v8::Exception::Error(v->ToString()));
    }
    case Type::RESOURCES_FN: {
        return scope.Escape(v8::Function::New(iv8, NativesObject::Resources));
    }
    default:
        RT_ASSERT(!"unknown data type");
        break;
    }

    RT_ASSERT(!"should not be here");
    return scope.Escape<v8::Primitive>(v8::Undefined(iv8));
}

} // namespace rt
