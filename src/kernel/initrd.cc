// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
        printf("Found file: %s, crc64: %lx\n", file.name(), file.crc64());

        uint64_t crc64 = CRC64::Compute(0, file.buf(), file.len());
        if (file.crc64() != crc64) {
            printf("Initrd file %s invalid CRC64, loc %p, len %ul.\n", file.name(), file.buf(), file.len());
            break;
        }
        _files.push_back(InitrdFile(file.name(), file.len(), file.buf()));
        file = reader.Next();
    }
}

const InitrdFile Initrd::Get(const char* filename) {
    for (const InitrdFile& file : _files) {
        if (strcmp(filename, file.Name()) == 0) {
            printf("[INITRD] Load %s len %d\n", file.Name(), file.Size());
            return file;
        }
    }
    return InitrdFile();
}

} // namespace rt
