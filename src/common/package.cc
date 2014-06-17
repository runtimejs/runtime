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

#include "package.h"
#include <common/crc64.h>

#define PACKAGE_MAGIC 0xCAFECAFE

namespace package {

void PackageWriter::WriteString(const char* str) {
    size_t len = strlen(str);
    WriteData(reinterpret_cast<const void*>(str), len + 1);
}

void PackageWriter::WriteBuf(const uint8_t* buf, size_t len) {
    WriteData(reinterpret_cast<const void*>(buf), len);
}

void PackageWriter::WriteUint64(uint64_t value) {
    WriteData(reinterpret_cast<const void*>(&value), sizeof(uint64_t));
}

void PackageWriter::WriteUint32(uint32_t value) {
    WriteData(reinterpret_cast<const void*>(&value), sizeof(uint32_t));
}

void PackageWriter::Write() {
    WriteUint32(PACKAGE_MAGIC);

    const char* hdr = "PCKG";
    WriteBuf(reinterpret_cast<const uint8_t*>(hdr), 4);

    size_t file_count = files_.size();
    WriteUint64(file_count);

    for (const PackageFileData& file : files_) {
        const char* name = file.name();
        size_t len = file.len();
        size_t name_len = strlen(name);
        WriteUint32(static_cast<uint32_t>(PackageFileType::DEFAULT));
        WriteUint64(name_len);
        WriteString(name);
        WriteUint64(CRC64::Compute(0, file.buf(), len));
        WriteUint64(len);
        WriteBuf(file.buf(), len);
    }
}

PackageReader::PackageReader(const void* start, size_t len)
    :	next_(nullptr),
        files_left_(0) {

    RT_ASSERT(start);
    RT_ASSERT(len > 0);

    const uint8_t* pos = reinterpret_cast<const uint8_t*>(start);
    const uint8_t* end = pos + len;

    pos = common::Utils::AlignPtr<const uint8_t>(pos, sizeof(uint32_t));

    // Search for archive header
    while (pos < end) {
        const uint32_t* value = reinterpret_cast<const uint32_t*>(pos);
        pos += sizeof(uint32_t);

        if (PACKAGE_MAGIC != *value) {
            continue;
        }

        if ('P' != pos[0] || 'C' != pos[1] || 'K' != pos[2] || 'G' != pos[3]) {
            continue;
        }

        files_left_ = common::Utils::ReadUnaligned<size_t>(reinterpret_cast<const void*>(pos + 4));
        next_ = pos + 4 + sizeof(uint64_t);
        break;
    }
}

PackageFile PackageReader::Next() {
    if (0 == files_left_ || nullptr == next_) {
        return Finish();
    }

    // File type
    uint32_t type = common::Utils
            ::ReadUnaligned<uint32_t>(reinterpret_cast<const void*>(next_));
    next_ += sizeof(uint32_t);

    // Check type
    if (static_cast<uint32_t>(PackageFileType::DEFAULT) != type) {
        return Finish();
    }

    // Name length
    size_t name_len = common::Utils
            ::ReadUnaligned<size_t>(reinterpret_cast<const void*>(next_));
    next_ += sizeof(uint64_t);

    // Filename
    const char* name = reinterpret_cast<const char*>(next_);
    next_ += name_len;

    // Null-terminator of string
    if (*next_ != 0) {
        return Finish();
    }
    ++next_;

    // File CRC64
    uint64_t crc64 = common::Utils
            ::ReadUnaligned<size_t>(reinterpret_cast<const void*>(next_));
    next_ += sizeof(uint64_t);

    // File length
    size_t len = common::Utils
            ::ReadUnaligned<size_t>(reinterpret_cast<const void*>(next_));
    next_ += sizeof(uint64_t);

    // File buffer
    const uint8_t* buf = next_;

    --files_left_;
    next_ += len;
    return PackageFile(name, buf, len, crc64);
}

PackageFile PackageReader::Finish() {
    next_ = nullptr;
    files_left_ = 0;
    return PackageFile();
}

} // namespace package
