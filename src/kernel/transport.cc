// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "transport.h"
#include <kernel/isolate.h>
#include <kernel/template-cache.h>
#include <kernel/object-wrapper.h>
#include <kernel/thread.h>

namespace rt {

TransportData::SerializeError TransportData::MoveValue(Thread* exporter,
                                                       Isolate* isolate_recv,
                                                       v8::Local<v8::Value> value) {
    RT_ASSERT(exporter);
    Isolate* isolate { exporter->isolate() };
    RT_ASSERT(isolate);
    RT_ASSERT(isolate_recv);
    Clear();
    isolate_ = isolate;
    allow_ref_ = isolate_recv == isolate;

    SerializeError err { SerializeValue(exporter, value, 1) };
    if (SerializeError::NONE != err) {
        SetUndefined();
    }

    return err;
}

TransportData::SerializeError TransportData::MoveArgs(Thread* exporter,
                                                      Isolate* isolate_recv,
                                                      const v8::FunctionCallbackInfo<v8::Value>& args) {
    RT_ASSERT(exporter);
    Isolate* isolate { exporter->isolate() };
    RT_ASSERT(isolate);
    RT_ASSERT(isolate_recv);
    Clear();
    isolate_ = isolate;
    allow_ref_ = isolate_recv == isolate;

    AppendType(Type::ARRAY);
    uint32_t len = args.Length();
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
    RT_ASSERT(isolate_);
    RT_ASSERT(isolate_->IsolateV8());
    RT_ASSERT(isolate_->IsolateV8() == iv8);
    RT_ASSERT(index < refs_.size());
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape(v8::Local<v8::Value>::New(iv8, refs_[index]));
}

uint32_t TransportData::AddRef(v8::Local<v8::Value> value) {
    RT_ASSERT(allow_ref_);
    RT_ASSERT(isolate_);
    RT_ASSERT(isolate_->IsolateV8());
    size_t index = refs_.size();
    refs_.push_back(std::move(v8::UniquePersistent<v8::Value>(isolate_->IsolateV8(), value)));
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
        if (allow_ref_) {
            // Strings are immutable, its safe to pass by reference
            // for same-isolate calls
            AppendType(Type::STRING_REF);
            stream_.AppendValue<uint32_t>(AddRef(value));
        } else {
            AppendType(Type::STRING_16);
            v8::Local<v8::String> s { value->ToString() };
            int len = s->Length();
            RT_ASSERT(len >= 0);
            stream_.AppendValue<uint32_t>(len);
            void* place { stream_.AppendBuffer((len + 1) * sizeof(uint16_t)) };
            s->Write(reinterpret_cast<uint16_t*>(place), 0, len);
        }

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

    if (value->IsArrayBuffer()) {
        // Neuter this array buffer and take its contents
        AppendType(Type::ARRAYBUFFER);
        v8::Local<v8::ArrayBuffer> b { v8::Local<v8::ArrayBuffer>::Cast(value) };
        if (b->IsExternal()) {
            return SerializeError::EXTERNAL_BUFFER;
        }
        v8::ArrayBuffer::Contents c { b->Externalize() };
        stream_.AppendValue<void*>(c.Data());
        stream_.AppendValue<size_t>(c.ByteLength());
        b->Neuter();

        return SerializeError::NONE;
    }

    if (value->IsFunction()) {
        ExportedFunction* efn { exporter->AddExport(value) };
        AppendType(Type::FUNCTION);
        stream_.AppendValue<ExportedFunction*>(efn);
    }

    // This check should be the last one
    if (value->IsObject()) {
        RT_ASSERT(isolate_);
        RT_ASSERT(isolate_->template_cache());

        v8::Local<v8::Object> obj { value->ToObject() };

        // Check if this is native object (wrapped instance)
        void* ptr { isolate_->template_cache()->GetWrapped(value) };
        if (nullptr != ptr) {
            if (allow_ref_) {
                AppendType(Type::OBJECT_REF);
                stream_.AppendValue<uint32_t>(AddRef(value));
                return SerializeError::NONE;
            } else {
                RT_ASSERT(!"not implemented");
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

v8::Local<v8::Value> TransportData::Unpack(Isolate* isolate) const {
    RT_ASSERT(isolate);
    v8::Isolate* iv8 { isolate->IsolateV8() };
    RT_ASSERT(iv8);

    ByteStreamReader reader(stream_);
    if (allow_ref_) {
        RT_ASSERT(nullptr != isolate_);
    }
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape(UnpackValue(isolate, reader));
}

v8::Local<v8::Value> TransportData::UnpackValue(Isolate* isolate, ByteStreamReader& reader) const {
    RT_ASSERT(isolate);
    v8::Isolate* iv8 { isolate->IsolateV8() };
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
        return scope.Escape<v8::Primitive>(v8::Int32::New(iv8,
            reader.ReadValue<uint32_t>()));
    case Type::DOUBLE:
        return scope.Escape<v8::Primitive>(v8::Int32::New(iv8,
            reader.ReadValue<double>()));
    case Type::BOOL_TRUE:
        return scope.Escape<v8::Primitive>(v8::True(iv8));
    case Type::BOOL_FALSE:
        return scope.Escape<v8::Primitive>(v8::False(iv8));
    case Type::ARRAYBUFFER: {
        void* buf = reader.ReadValue<void*>();
        size_t len = reader.ReadValue<size_t>();
        return scope.Escape(v8::ArrayBuffer::NewNonExternal(iv8, buf, len));
    }
    case Type::ARRAY: {
        uint32_t len = reader.ReadValue<uint32_t>();
        v8::Local<v8::Array> arr { v8::Array::New(iv8, len) };
        for (uint32_t i = 0; i < len; ++i) {
            arr->Set(i, UnpackValue(isolate, reader));
        }
        return scope.Escape(arr);
    }
    case Type::HASHMAP: {
        uint32_t len = reader.ReadValue<uint32_t>();
        v8::Local<v8::Object> obj { v8::Object::New(iv8) };
        for (uint32_t i = 0; i < len; ++i) {
            v8::Local<v8::Value> k { UnpackValue(isolate, reader) };
            v8::Local<v8::Value> v { UnpackValue(isolate, reader) };
            obj->Set(k, v);
        }
        return scope.Escape(obj);
    }
    case Type::FUNCTION: {
        ExportedFunction* efn = reader.ReadValue<ExportedFunction*>();
        RT_ASSERT(isolate->template_cache());
        v8::Local<v8::Value> fnobj { isolate->template_cache()->MakeRemoteFunction(efn) };
        return scope.Escape(fnobj);
    }
    default:
        RT_ASSERT(!"unknown data type");
        break;
    }

    RT_ASSERT(!"should not be here");
    return scope.Escape<v8::Primitive>(v8::Undefined(iv8));
}

} // namespace rt
