// Copyright 2015 runtime.js project authors
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

#include "heap-snapshot.h"
#include <kernel/engines.h>

namespace rt {

v8::OutputStream::WriteResult HeapSnapshotStream::WriteAsciiChunk(char* data, int size) {
    if (!data || size <= 0) {
        return v8::OutputStream::WriteResult::kContinue;
    }

    // Use buffer allocator because we're going to wrap
    // it in ArrayBuffer and let V8 free it
    void* buf = GLOBAL_engines()->AllocateUninitializedBuffer(size);
    memcpy(buf, data, size);
    chunks_.push_back(std::make_pair(buf, size));
    return v8::OutputStream::WriteResult::kContinue;
}

v8::Local<v8::Array> HeapSnapshotStream::FetchBuffers(v8::Isolate* iv8) {
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);

    v8::Local<v8::Array> ret = v8::Array::New(iv8, chunks_.size());
    v8::Local<v8::Context> context = iv8->GetCurrentContext();
    size_t next = 0;

    for (auto chunk : chunks_) {
        // Let V8 free the buffers
        auto buf = v8::ArrayBuffer::New(iv8,
            chunk.first, chunk.second,
            v8::ArrayBufferCreationMode::kInternalized);
        auto u8 = v8::Uint8Array::New(buf, 0, buf->ByteLength());
        ret->Set(context, next++, u8);
    }

    chunks_.clear();
    return scope.Escape(ret);
}

} // namespace rt

