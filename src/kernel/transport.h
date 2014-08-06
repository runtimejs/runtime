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
#include <v8.h>
#include <memory>
#include <common/constants.h>
#include <kernel/vector.h>
#include <kernel/resource.h>

namespace rt {

class Isolate;

/**
 * Dynamic size contiguous byte array for mixed data
 */
class ByteStream {
    friend class ByteStreamReader;
public:
    ByteStream() {}

    ByteStream(ByteStream&& other)
        :	data_(std::move(other.data_)) {}

    /**
     * Memcpy value into stream
     */
    template<typename T>
    void AppendValue(T value) {
        size_t size = data_.size();
        size_t valsize = sizeof(T);
        data_.resize(size + valsize);
        T* p = reinterpret_cast<T*>(data_.data() + size);
        memcpy(p, &value, valsize);
    }

    /**
     * Clear stream
     */
    void Clear() {
        data_.clear();
    }

    /**
     * Allocate uninitialized space on the stream. Returns pointer
     * to first element.
     */
    void* AppendBuffer(uint32_t len) {
        size_t size = data_.size();
        data_.resize(size + len);
        return data_.data() + size;
    }

private:
    SharedSTLVector<uint8_t> data_;
    DELETE_COPY_AND_ASSIGN(ByteStream);
};

/**
 * Provides read functionality for ByteStream object
 */
class ByteStreamReader {
public:
    ByteStreamReader(const ByteStream& stream)
        :	stream_(stream), pos_(0) {}

    /**
     * Copy value from stream. Moves read position sizeof(T)
     * elements forward.
     */
    template<typename T>
    T ReadValue() {
        size_t valsize = sizeof(T);
        RT_ASSERT(pos_ + valsize <= stream_.data_.size());
        const void* p = stream_.data_.data() + pos_;
        T ret;
        memcpy(&ret, p, valsize);
        pos_ += valsize;
        return ret;
    }

    /**
     * Returns pointer to current stream position. Moves
     * read position "len" elements forward.
     */
    const void* ReadBuffer(uint32_t len) {
        RT_ASSERT(pos_ + len <= stream_.data_.size());
        const void* p = stream_.data_.data() + pos_;
        pos_ += len;
        return p;
    }

private:
    const ByteStream& stream_;
    size_t pos_;
};

/**
 * Serialized data to be transferred between contexts or isolates
 */
class TransportData {
public:
    enum class SerializeError {
        NONE,
        MAX_STACK,
        INVALID_TYPE,
        EXTERNAL_BUFFER,
        TYPEDARRAY_VIEW,
        NOT_CLONABLE,
    };

    /**
     * Construct empty transport data object. Deserialize returns
     * undefined
     */
    TransportData()
        :	thread_(nullptr),
            allow_ref_(false),
            err_(SerializeError::NONE) {
        SetUndefined();
    }

    /**
     * Deserialize to undefined
     */
    void SetUndefined() {
        Clear();
        AppendType(Type::UNDEFINED);
    }

    /**
     * Append v8 string value
     */
    void AppendString(v8::Local<v8::Value> value) {
        RT_ASSERT(value->IsString());
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
    }

    /**
     * Construct data to be sent as part of evaluate thread message.
     * From string buffer (source) and filename. Deserialize returns
     * strings Array [source, filename]
     */
    void SetEvalData(const uint8_t* buf, size_t len, const char* filename) {
        RT_ASSERT(buf);
        RT_ASSERT(filename);
        Clear();

        AppendType(Type::ARRAY);
        stream_.AppendValue<uint32_t>(2);

        {   AppendType(Type::STRING_UTF8);
            stream_.AppendValue<uint32_t>(len);
            void* place { stream_.AppendBuffer(len + 1) };
            memcpy(place, buf, len);
            uint8_t* p = reinterpret_cast<uint8_t*>(place);
            p[len] = '\0';
        }

        {   AppendType(Type::STRING_UTF8);
            auto namelen = std::strlen(filename);
            stream_.AppendValue<uint32_t>(namelen);
            void* place { stream_.AppendBuffer(namelen + 1) };
            memcpy(place, filename, namelen);
            uint8_t* p = reinterpret_cast<uint8_t*>(place);
            p[namelen] = '\0';
        }
    }

    /**
     * Construct data from string buffer. Deserialize returns
     * string
     */
    void SetString(const uint8_t* buf, size_t len) {
        RT_ASSERT(buf);
        Clear();

        AppendType(Type::STRING_UTF8);
        stream_.AppendValue<uint32_t>(len);
        void* place { stream_.AppendBuffer(len + 1) };
        memcpy(place, buf, len);
        uint8_t* p = reinterpret_cast<uint8_t*>(place);
        p[len] = '\0';
    }

    /**
     * Set data to kernel resources function. This is required
     * to start first process
     */
    void SetResourceFunction() {
        Clear();
        AppendType(Type::RESOURCES_FN);
    }

    /**
     * Serialize value to transport it
     */
    SerializeError MoveValue(Thread* exporter,
                             Thread* recv,
                             v8::Local<v8::Value> value);

    /**
     * Serialize v8 arguments array to transport it
     */
    SerializeError MoveArgs(Thread* exporter,
                            Thread* recv,
                            const v8::FunctionCallbackInfo<v8::Value>& args);

    TransportData(TransportData&& other)
        :	thread_(other.thread_),
            allow_ref_(other.allow_ref_),
            err_(other.err_),
            stream_(std::move(other.stream_)),
            refs_(std::move(other.refs_)) {}

    /**
     * Deserialize data to V8 value
     */
    v8::Local<v8::Value> Unpack(Thread* thread) const;

    /**
     * Helper function throws provided error. Returns true if
     * any errors were thrown
     */
    static bool ThrowError(v8::Isolate* iv8, SerializeError err) {
        RT_ASSERT(iv8);
        switch (err) {
        case SerializeError::NONE:
            return false;
        case SerializeError::MAX_STACK:
            iv8->ThrowException(
                v8::Exception::Error(
                v8::String::NewFromUtf8(iv8,
                "Maximum call stack size exceeded when transferring data")));
            return true;
        case SerializeError::INVALID_TYPE:
            iv8->ThrowException(
                v8::Exception::Error(
                v8::String::NewFromUtf8(iv8,
                "Unable to transfer data")));
            return true;
        case SerializeError::EXTERNAL_BUFFER:
            iv8->ThrowException(
                v8::Exception::Error(
                v8::String::NewFromUtf8(iv8,
                "ArrayBuffer have already transferred")));
            return true;
        case SerializeError::TYPEDARRAY_VIEW:
            iv8->ThrowException(
                v8::Exception::Error(
                v8::String::NewFromUtf8(iv8,
                "ArrayBufferView can't be transferred, use .buffer to get referenced buffer")));
            return true;
        case SerializeError::NOT_CLONABLE:
            iv8->ThrowException(
                v8::Exception::Error(
                v8::String::NewFromUtf8(iv8,
                "Native object is not clonable")));
            return true;
        default:
            RT_ASSERT(!"unknown serializer error");
            return true;
        }

        return false;
    }
private:
    enum class Type : uint8_t {
        UNDEFINED,
        NUL,
        STRING_16,
        STRING_UTF8,
        STRING_REF,
        OBJECT_REF,
        INT32,
        UINT32,
        DOUBLE,
        BOOL_TRUE,
        BOOL_FALSE,
        ARRAYBUFFER,
        ARRAY,
        HASHMAP,
        FUNCTION,
        NATIVE_OBJECT,
        ERROR_OBJ,
        RESOURCES_FN,
    };

    void Clear() {
        thread_ = nullptr;
        err_ = SerializeError::NONE;
        allow_ref_ = false;
        stream_.Clear();
    }

    SerializeError SerializeValue(Thread* exporter, v8::Local<v8::Value> value, uint32_t stack_level);
    v8::Local<v8::Value> UnpackValue(Thread* thread, ByteStreamReader& reader) const;

    Type ReadType(ByteStreamReader& reader) const {
        return static_cast<Type>(reader.ReadValue<uint8_t>());
    }

    v8::Local<v8::Value> GetRef(v8::Isolate* iv8, uint32_t index) const;
    uint32_t AddRef(v8::Local<v8::Value> value);

    void AppendType(Type type) {
        stream_.AppendValue<uint8_t>(static_cast<uint8_t>(type));
    }

    static const uint32_t kMaxStackSize = 128;

    Thread* thread_;
    bool allow_ref_;
    SerializeError err_;
    ByteStream stream_;
    SharedSTLVector<v8::UniquePersistent<v8::Value>> refs_;

    DELETE_COPY_AND_ASSIGN(TransportData);
};

} // namespace rt
