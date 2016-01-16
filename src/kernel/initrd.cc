// Copyright 2014 runtime.js project authors
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
#include <kernel/crc32.h>
#include <kernel/utils.h>
#include <kernel/version.h>
#include <tinfl.h>

#define PACKAGE_MAGIC 0xCAFECAFE
#define KERNEL_VER 2

namespace rt {

PackageReader::PackageReader(const void* start, size_t len)
  :	next_(nullptr),
    files_left_(0),
    runtime_index_name_(""),
    app_index_name_("") {

  RT_ASSERT(start);
  RT_ASSERT(len > 0);

  const uint8_t* pos = reinterpret_cast<const uint8_t*>(start);
  const uint8_t* end = pos + len;

  pos = Utils::AlignPtr<const uint8_t>(pos, sizeof(uint32_t));

  // Search for archive header
  while (pos < end) {
    uint32_t value = Utils::ReadUint32BE(static_cast<const void*>(pos));
    pos += sizeof(uint32_t);

    if (PACKAGE_MAGIC != value) {
      continue;
    }

    if ('P' != pos[0] || 'C' != pos[1] || 'K' != pos[2] || 'G' != pos[3]) {
      continue;
    }

    uint32_t old_count = Utils::ReadUint32BE(static_cast<const void*>(pos + 4));
    if (old_count != 0) {
      printf("Initrd format no longer supported.\n");
      return;
    }

    uint32_t kernelVer = Utils::ReadUint32BE(static_cast<const void*>(pos + 8));
    if (kernelVer != Version::getVersionNumber()) {
      printf("Initrd requires kernel version %d, current %d.\n", kernelVer, Version::getVersionNumber());
      return;
    }

    files_left_ = Utils::ReadUint32BE(static_cast<const void*>(pos + 12));

    uint32_t inflated_size = Utils::ReadUint32BE(static_cast<const void*>(pos + 16));
    void* ptr = malloc(inflated_size);
    if (!ptr) {
      printf("Initrd alloc out of memory.\n");
      return;
    }

    const void* compr_ptr = static_cast<const void*>(pos + 20);
    size_t compr_size = len - 20;
    size_t dec_result = tinfl_decompress_mem_to_mem(ptr, inflated_size, compr_ptr, compr_size,
        TINFL_FLAG_PARSE_ZLIB_HEADER | TINFL_FLAG_USING_NON_WRAPPING_OUTPUT_BUF);

    if (dec_result == TINFL_DECOMPRESS_MEM_TO_MEM_FAILED) {
      printf("Initrd decompress error.\n");
      return;
    }

    next_ = reinterpret_cast<const uint8_t*>(ptr);
    runtime_index_name_ = ReadString();
    app_index_name_ = ReadString();
    break;
  }
}

PackageFile PackageReader::Next() {
  if (0 == files_left_ || nullptr == next_) {
    return Finish();
  }

  uint32_t type = ReadUint32();     // file type
  if (static_cast<uint32_t>(PackageFileType::DEFAULT) != type &&
      static_cast<uint32_t>(PackageFileType::LINK) != type) {
    return Finish();
  }

  size_t len = ReadUint32();        // file length
  const char* name = ReadString();  // file name
  const uint8_t* buf = nullptr;
  uint32_t content = 0;
  bool is_link = false;

  if (static_cast<uint32_t>(PackageFileType::LINK) == type) {
    is_link = true;
    content = ReadUint32();         // link index
  } else {
    content = ReadUint32();         // file crc32
    buf = next_;                    // file buffer
    next_ += len;
  }

  --files_left_;
  return PackageFile(is_link, name, buf, len, content);
}

uint32_t PackageReader::ReadUint32() {
  uint32_t value = Utils::ReadUint32BE(static_cast<const void*>(next_));
  next_ += sizeof(uint32_t);
  return value;
}

const char* PackageReader::ReadString() {
  uint16_t len = Utils::ReadUint16BE(static_cast<const void*>(next_));
  const char* str = reinterpret_cast<const char*>(next_ + 2);

  if (str[len] != '\0') {
    return nullptr;
  }

  next_ += len + 3;
  return str;
}

PackageFile PackageReader::Finish() {
  next_ = nullptr;
  files_left_ = 0;
  return PackageFile();
}

void Initrd::Init(const void* buf, size_t len) {
  RT_ASSERT(buf);
  RT_ASSERT(len > 0);

  PackageReader reader(buf, len);
  PackageFile file = reader.Next();

  while (!file.empty()) {
    if (file.is_link()) {
      if (file.content() >= files_.size()) {
        printf("Initrd file %s invalid link index.\n", file.name());
        break;
      }

      auto f = files_[file.content()];
      files_.push_back(InitrdFile(f.Name(), f.Size(), f.Data()));
    } else {
      uint32_t crc32 = CRC32::Compute(file.buf(), file.len());
      if (file.content() != crc32) {
        printf("Initrd file %s invalid CRC32, loc %p, len %u.\n", file.name(), file.buf(), file.len());
        break;
      }
      files_.push_back(InitrdFile(file.name(), file.len(), file.buf()));
    }

    file = reader.Next();
  }

  runtime_index_name_ = reader.runtime_index_name();
  app_index_name_ = reader.app_index_name();
}

const InitrdFile Initrd::GetByIndex(size_t index) {
  RT_ASSERT(index < files_.size());
  return files_[index];
}

const InitrdFile Initrd::Get(const char* filename) {
  for (const InitrdFile& file : files_) {
    if (strcmp(filename, file.Name()) == 0) {
      return file;
    }
  }
  return InitrdFile();
}

} // namespace rt
