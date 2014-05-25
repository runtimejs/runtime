// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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

class ExportedFunction {
public:
    ExportedFunction(uint32_t index, size_t export_id, Isolate* isolate,
                     ResourceHandle<EngineThread> recv)
        :	active_(true), index_(index),
            export_id_(export_id), isolate_(isolate),
            recv_(recv) {
        RT_ASSERT(isolate_);
    }

    uint32_t index() const { return index_; }
    bool active() const { return active_; }
    Isolate* isolate() const { return isolate_; }
    size_t export_id() const { return export_id_; }
    ResourceHandle<EngineThread> recv() const { return recv_; }

private:
    bool active_;
    uint32_t index_;
    size_t export_id_;
    Isolate* isolate_;
    ResourceHandle<EngineThread> recv_;
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
    };

    /**
     * Construct empty transport data object. Deserialize returns
     * undefined
     */
    TransportData()
        :	isolate_(nullptr),
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
     * Serialize value to transport it
     */
    SerializeError MoveValue(Thread* exporter,
                             Isolate* isolate_recv,
                             v8::Local<v8::Value> value);

    /**
     * Serialize v8 arguments array to transport it
     */
    SerializeError MoveArgs(Thread* exporter,
                            Isolate* isolate_recv,
                            const v8::FunctionCallbackInfo<v8::Value>& args);

    TransportData(TransportData&& other)
        :	isolate_(other.isolate_),
            allow_ref_(other.allow_ref_),
            err_(other.err_),
            stream_(std::move(other.stream_)),
            refs_(std::move(other.refs_)) {}

    /**
     * Deserialize data to V8 value
     */
    v8::Local<v8::Value> Unpack(Isolate* isolate) const;

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
                "Maximum call stack size exceeded")));
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
    };

    void Clear() {
        isolate_ = nullptr;
        err_ = SerializeError::NONE;
        allow_ref_ = false;
        stream_.Clear();
    }

    SerializeError SerializeValue(Thread* exporter, v8::Local<v8::Value> value, uint32_t stack_level);
    v8::Local<v8::Value> UnpackValue(Isolate* isolate, ByteStreamReader& reader) const;

    Type ReadType(ByteStreamReader& reader) const {
        return static_cast<Type>(reader.ReadValue<uint8_t>());
    }

    v8::Local<v8::Value> GetRef(v8::Isolate* iv8, uint32_t index) const;
    uint32_t AddRef(v8::Local<v8::Value> value);

    void AppendType(Type type) {
        stream_.AppendValue<uint8_t>(static_cast<uint8_t>(type));
    }

    static const uint32_t kMaxStackSize = 128;

    Isolate* isolate_;
    bool allow_ref_;
    SerializeError err_;
    ByteStream stream_;
    SharedSTLVector<v8::UniquePersistent<v8::Value>> refs_;

    DELETE_COPY_AND_ASSIGN(TransportData);
};

} // namespace rt
