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

#pragma once

#include <kernel/kernel.h>
#include <kernel/constants.h>
#include <vector>
#include <v8-profiler.h>

namespace rt {

using rt::Constants;

class HeapSnapshotStream : public v8::OutputStream {
 public:
    HeapSnapshotStream() {}
    virtual int GetChunkSize() { return 2 * Constants::MiB; }
    virtual void EndOfStream() {}
    virtual v8::OutputStream::WriteResult WriteAsciiChunk(char* data, int size);
    v8::Local<v8::Array> FetchBuffers(v8::Isolate* iv8);
private:
    std::vector<std::pair<void*, size_t>> chunks_;
    DELETE_COPY_AND_ASSIGN(HeapSnapshotStream);
};

} // namespace rt
