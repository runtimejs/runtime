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

#include <vector>
#include <kernel/kernel.h>
#include <v8.h>
#include <memory>
#include <kernel/constants.h>
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

    ByteStream& operator=(ByteStream&& other) {
        data_ = std::move(other.data_);
        return *this;
    }

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

    bool empty() const { return data_.empty(); }
private:
    std::vector<uint8_t> data_;
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
        EMPTY_BUFFER,
        TYPEDARRAY_VIEW,
        NOT_CLONABLE,
    };

    /**
     * Construct empty transport data object
     */
    TransportData() {}

    /**
     * Deserialize to undefined
     */
    void SetUndefined() {
        Clear();
        AppendType(Type::UNDEFINED);
    }

    void SetArray(uint32_t size) {
        Clear();
        AppendType(Type::ARRAY);
        stream_.AppendValue<uint32_t>(size);
    }

    TransportData::SerializeError PushArrayElement(Thread* exporter, v8::Local<v8::Value> value);

    /**
     * Check if TransportData is empty
     */
    bool empty() const { return stream_.empty(); }

    /**
     * Append v8 string value
     */
    void AppendString(v8::Local<v8::Value> value) {
        RT_ASSERT(value->IsString());
        AppendType(Type::STRING_16);
        v8::Local<v8::String> s { value->ToString() };
        int len = s->Length();
        RT_ASSERT(len >= 0);
        stream_.AppendValue<uint32_t>(len);
        void* place { stream_.AppendBuffer((len + 1) * sizeof(uint16_t)) };
        s->Write(reinterpret_cast<uint16_t*>(place), 0, len);
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
    SerializeError MoveValue(Thread* exporter, v8::Local<v8::Value> value);

    /**
     * Serialize v8 arguments array to transport it
     */
    SerializeError MoveArgs(Thread* exporter, const v8::FunctionCallbackInfo<v8::Value>& args);

    TransportData(TransportData&& other)
        :	stream_(std::move(other.stream_)) {}

    TransportData& operator=(TransportData&& other) {
        stream_ = std::move(other.stream_);
        return *this;
    }

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
        case SerializeError::EMPTY_BUFFER:
            iv8->ThrowException(
                v8::Exception::Error(
                v8::String::NewFromUtf8(iv8,
                "ArrayBuffer is empty or have already been transferred")));
            return true;
        case SerializeError::TYPEDARRAY_VIEW:
            iv8->ThrowException(
                v8::Exception::Error(
                v8::String::NewFromUtf8(iv8,
                "Unknown typed array cannot be transferred")));
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
        INT32,
        UINT32,
        DOUBLE,
        BOOL_TRUE,
        BOOL_FALSE,
        ARRAYBUFFER,
        TYPEDARRAY_UINT8,
        TYPEDARRAY_UINT8_CLAMPED,
        TYPEDARRAY_UINT16,
        TYPEDARRAY_UINT32,
        TYPEDARRAY_INT8,
        TYPEDARRAY_INT16,
        TYPEDARRAY_INT32,
        TYPEDARRAY_DATAVIEW,
        ARRAY,
        EMPTY_ARRAY,
        HASHMAP,
        FUNCTION,
        NATIVE_OBJECT,
        ERROR_OBJ,
        RESOURCES_FN,
    };

    void Clear() { stream_.Clear(); }

    SerializeError SerializeValue(Thread* exporter, v8::Local<v8::Value> value, uint32_t stack_level);
    v8::Local<v8::Value> UnpackValue(Thread* thread, ByteStreamReader& reader) const;

    Type ReadType(ByteStreamReader& reader) const {
        return static_cast<Type>(reader.ReadValue<uint8_t>());
    }

    void AppendType(Type type) {
        stream_.AppendValue<uint8_t>(static_cast<uint8_t>(type));
    }

    static const uint32_t kMaxStackSize = 128;
    ByteStream stream_;
    DELETE_COPY_AND_ASSIGN(TransportData);
};

} // namespace rt
