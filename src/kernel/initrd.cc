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

#include "initrd.h"
#include <common/package.h>
#include <common/crc64.h>

namespace rt {

void Initrd::Init(const void* buf, size_t len) {
    RT_ASSERT(buf);
    RT_ASSERT(len > 0);

    package::PackageReader reader(buf, len);
    package::PackageFile file = reader.Next();

    while (!file.empty()) {
        uint64_t crc64 = CRC64::Compute(0, file.buf(), file.len());
        if (file.crc64() != crc64) {
            printf("Initrd file %s invalid CRC64, loc %p, len %ul.\n", file.name(), file.buf(), file.len());
            break;
        }
        files_.push_back(InitrdFile(file.name(), file.len(), file.buf()));
        file = reader.Next();
    }
}

const InitrdFile Initrd::GetByIndex(size_t index) {
    RT_ASSERT(index < files_.size());
    return files_[index];
}

const InitrdFile Initrd::Get(const char* filename) {
    for (const InitrdFile& file : files_) {
        if (strcmp(filename, file.Name()) == 0) {
            printf("[INITRD] Load %s len %d\n", file.Name(), file.Size());
            return file;
        }
    }
    return InitrdFile();
}

} // namespace rt
