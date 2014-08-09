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
#include <kernel/engines.h>
#include <v8.h>
#include <utility>

namespace rt {

/**
 * Wrapper for externalized v8::ArrayBuffer objects
 */
class ArrayBuffer {
public:
    /**
     * Extract ArrayBuffer wrapper from v8::ArrayBuffer instance
     */
    static ArrayBuffer* FromInstance(v8::Isolate* iv8, v8::Local<v8::ArrayBuffer> buffer) {
        RT_ASSERT(iv8);
        RT_ASSERT(!buffer.IsEmpty());
        RT_ASSERT(buffer->IsArrayBuffer());
        if (buffer->IsExternal()) {
            return reinterpret_cast<ArrayBuffer*>(buffer
                ->GetAlignedPointerFromInternalField(kInternalFieldIndex));
        }

        auto contents = buffer->Externalize();
        return new ArrayBuffer(iv8, buffer, contents.Data(), contents.ByteLength());
    }

    static ArrayBuffer* FromBuffer(v8::Isolate* iv8, void* data, size_t size) {
        RT_ASSERT(iv8);
        RT_ASSERT(data);
        return new ArrayBuffer(iv8, v8::ArrayBuffer::New(iv8, data, size), data, size);
    }

    v8::Local<v8::ArrayBuffer> GetInstance() {
        RT_ASSERT(iv8_);
        RT_ASSERT(!buffer_.IsEmpty());
        v8::EscapableHandleScope scope(iv8_);
        return scope.Escape(v8::Local<v8::ArrayBuffer>::New(iv8_, buffer_));
    }

    void Neuter() {
        GetInstance()->Neuter();
        data_ = nullptr;
        size_ = 0;
    }

    void* data() const { RT_ASSERT(data_); return data_; }
    size_t size() const { return size_; }
private:
    ArrayBuffer(v8::Isolate* iv8, v8::Local<v8::ArrayBuffer> buffer, void* data, size_t size)
        :   iv8_(iv8), data_(data), size_(size) {
        RT_ASSERT(iv8_);
        RT_ASSERT((data_ && size_ > 0) || (!data_ && 0 == size_));
        RT_ASSERT(!buffer.IsEmpty());
        RT_ASSERT(buffer->IsArrayBuffer());
        RT_ASSERT(buffer->IsExternal());
        buffer->SetAlignedPointerInInternalField(kInternalFieldIndex, this);
        RT_ASSERT(buffer_.IsEmpty());
        buffer_ = std::move(v8::UniquePersistent<v8::ArrayBuffer>(iv8, buffer));
        buffer_.SetWeak(this, WeakCallback);
    }

    ~ArrayBuffer() {
        RT_ASSERT(buffer_.IsEmpty());
        iv8_ = nullptr;

        RT_ASSERT(GLOBAL_engines());
        if (nullptr != data_) {
            GLOBAL_engines()->arraybuffer_allocator()->Free(data_, size_);
        }

        data_ = nullptr;
        size_ = 0;
    }

    inline static void WeakCallback(const v8::WeakCallbackData<v8::ArrayBuffer, ArrayBuffer>& data) {
        ArrayBuffer* ab = data.GetParameter();
        ab->buffer_.Reset();
        delete ab;
    }

    static const int kInternalFieldIndex = 0;
    v8::Isolate* iv8_;
    void* data_;
    size_t size_;
    v8::UniquePersistent<v8::ArrayBuffer> buffer_;
    DELETE_COPY_AND_ASSIGN(ArrayBuffer);
};

} // namespace rt
