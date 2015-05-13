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

TransportData::SerializeError TransportData::PushArrayElement(Thread* exporter, v8::Local<v8::Value> value) {
    SerializeError err { SerializeValue(exporter, value, 1) };
    if (SerializeError::NONE != err) {
        SetUndefined();
        return err;
    }

    return SerializeError::NONE;
}

TransportData::SerializeError TransportData::MoveValue(Thread* exporter,
        v8::Local<v8::Value> value) {
    RT_ASSERT(exporter);
    RuntimeStateScope<RuntimeState::TRANSPORT_SERIALIZER> ts_state(exporter->thread_manager());
    Clear();

    SerializeError err { SerializeValue(exporter, value, 1) };
    if (SerializeError::NONE != err) {
        SetUndefined();
    }

    return err;
}

TransportData::SerializeError TransportData::MoveArgs(Thread* exporter,
        const v8::FunctionCallbackInfo<v8::Value>& args) {
    RT_ASSERT(exporter);
    RuntimeStateScope<RuntimeState::TRANSPORT_SERIALIZER> ts_state(exporter->thread_manager());
    Clear();

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
        RT_ASSERT(exporter);
        RT_ASSERT(exporter->IsolateV8());
        v8::Isolate* iv8 { exporter->IsolateV8() };
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

    if (value->IsArrayBufferView()) {
        RT_ASSERT(exporter);
        RT_ASSERT(exporter->IsolateV8());
        v8::Isolate* iv8 { exporter->IsolateV8() };
        v8::Local<v8::ArrayBufferView> view { v8::Local<v8::ArrayBufferView>::Cast(value) };
        v8::Local<v8::ArrayBuffer> b = view->Buffer();
        if (0 == b->ByteLength()) {
            return SerializeError::EMPTY_BUFFER;
        }

        if (view->IsUint8Array()) AppendType(Type::TYPEDARRAY_UINT8);
        else if (view->IsUint16Array()) AppendType(Type::TYPEDARRAY_UINT16);
        else if (view->IsUint32Array()) AppendType(Type::TYPEDARRAY_UINT32);
        else if (view->IsDataView()) AppendType(Type::TYPEDARRAY_DATAVIEW);
        else if (view->IsInt8Array()) AppendType(Type::TYPEDARRAY_INT8);
        else if (view->IsInt16Array()) AppendType(Type::TYPEDARRAY_INT16);
        else if (view->IsInt32Array()) AppendType(Type::TYPEDARRAY_INT32);
        else if (view->IsUint8ClampedArray()) AppendType(Type::TYPEDARRAY_UINT8_CLAMPED);
        else return SerializeError::TYPEDARRAY_VIEW;

        // Put ArrayBuffer itself
        auto ab = ArrayBuffer::FromInstance(iv8, b);
        stream_.AppendValue<void*>(ab->data());
        stream_.AppendValue<size_t>(ab->size());

        // Put view data
        stream_.AppendValue<size_t>(view->ByteOffset());
        stream_.AppendValue<size_t>(view->ByteLength());

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

    if (value->IsFunction()) {
        ExternalFunction* efn { exporter->AddExport(value) };
        AppendType(Type::FUNCTION);
        stream_.AppendValue<ExternalFunction*>(efn);
        return SerializeError::NONE;
    }

    if (value->IsNativeError()) {
        RT_ASSERT(exporter);
        RT_ASSERT(exporter->IsolateV8());
        AppendType(Type::ERROR_OBJ);
        v8::Isolate* iv8 { exporter->IsolateV8() };
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
        RT_ASSERT(exporter);
        RT_ASSERT(exporter->template_cache());

        v8::Local<v8::Object> obj { value->ToObject() };
        NativeObjectWrapper* ptr { exporter->template_cache()->GetWrapped(value) };

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
    RT_ASSERT(!stream_.empty());

    ByteStreamReader reader(stream_);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape(UnpackValue(thread, reader));
}

#define TYPEDARRAY_READ                                                 \
    void* buf = reader.ReadValue<void*>();                              \
    size_t len = reader.ReadValue<size_t>();                            \
    size_t byte_offset = reader.ReadValue<size_t>();                    \
    size_t byte_length = reader.ReadValue<size_t>();                    \
    auto buffer = ArrayBuffer::FromBuffer(iv8, buf, len)->GetInstance()

v8::Local<v8::Value> TransportData::UnpackValue(Thread* thread, ByteStreamReader& reader) const {
    RT_ASSERT(thread);
    RuntimeStateScope<RuntimeState::TRANSPORT_DESERIALIZER> td_state(thread->thread_manager());
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
    case Type::TYPEDARRAY_UINT8: {
        TYPEDARRAY_READ;
        return scope.Escape(v8::Uint8Array::New(buffer, byte_offset, byte_length));
    }
    case Type::TYPEDARRAY_UINT8_CLAMPED: {
        TYPEDARRAY_READ;
        return scope.Escape(v8::Uint8ClampedArray::New(buffer, byte_offset, byte_length));
    }
    case Type::TYPEDARRAY_UINT16: {
        TYPEDARRAY_READ;
        return scope.Escape(v8::Uint16Array::New(buffer, byte_offset, byte_length >> 1));
    }
    case Type::TYPEDARRAY_UINT32: {
        TYPEDARRAY_READ;
        return scope.Escape(v8::Uint32Array::New(buffer, byte_offset, byte_length >> 2));
    }
    case Type::TYPEDARRAY_INT8: {
        TYPEDARRAY_READ;
        return scope.Escape(v8::Int8Array::New(buffer, byte_offset, byte_length));
    }
    case Type::TYPEDARRAY_INT16: {
        TYPEDARRAY_READ;
        return scope.Escape(v8::Int16Array::New(buffer, byte_offset, byte_length >> 1));
    }
    case Type::TYPEDARRAY_INT32: {
        TYPEDARRAY_READ;
        return scope.Escape(v8::Int32Array::New(buffer, byte_offset, byte_length >> 2));
    }
    case Type::TYPEDARRAY_DATAVIEW: {
        TYPEDARRAY_READ;
        return scope.Escape(v8::DataView::New(buffer, byte_offset, byte_length));
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
        // TODO: cache value
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

#undef TYPEDARRAY_READ

} // namespace rt
