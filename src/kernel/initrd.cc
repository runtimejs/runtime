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
#include <kernel/crc32.h>
#include <kernel/utils.h>

#define PACKAGE_MAGIC 0xCAFECAFE

namespace rt {

PackageReader::PackageReader(const void* start, size_t len)
  :	next_(nullptr),
    files_left_(0) {

  RT_ASSERT(start);
  RT_ASSERT(len > 0);

  const uint8_t* pos = reinterpret_cast<const uint8_t*>(start);
  const uint8_t* end = pos + len;

  pos = Utils::AlignPtr<const uint8_t>(pos, sizeof(uint32_t));

  // Search for archive header
  while (pos < end) {
    uint32_t value = Utils::ReadUint32BE(reinterpret_cast<const void*>(pos));
    pos += sizeof(uint32_t);

    if (PACKAGE_MAGIC != value) {
      continue;
    }

    if ('P' != pos[0] || 'C' != pos[1] || 'K' != pos[2] || 'G' != pos[3]) {
      continue;
    }

    files_left_ = Utils::ReadUint32BE(reinterpret_cast<const void*>(pos + 4));
    next_ = pos + 4 + sizeof(uint32_t);
    break;
  }
}

PackageFile PackageReader::Next() {
  if (0 == files_left_ || nullptr == next_) {
    return Finish();
  }

  // File type
  uint32_t type = Utils::ReadUint32BE(reinterpret_cast<const void*>(next_));
  next_ += sizeof(uint32_t);

  // Check type
  if (static_cast<uint32_t>(PackageFileType::DEFAULT) != type) {
    return Finish();
  }

  // Name length
  uint32_t name_len = Utils::ReadUint32BE(reinterpret_cast<const void*>(next_));
  next_ += sizeof(uint32_t);

  // Filename
  const char* name = reinterpret_cast<const char*>(next_);
  next_ += name_len;

  // Null-terminator of string
  if (*next_ != 0) {
    return Finish();
  }
  ++next_;

  // File CRC
  uint32_t crc = Utils::ReadUint32BE(reinterpret_cast<const void*>(next_));
  next_ += sizeof(uint32_t);

  // File length
  size_t len = Utils::ReadUint32BE(reinterpret_cast<const void*>(next_));
  next_ += sizeof(uint32_t);

  // File buffer
  const uint8_t* buf = next_;

  --files_left_;
  next_ += len;
  return PackageFile(name, buf, len, crc);
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
    uint32_t crc32 = CRC32::Compute(file.buf(), file.len());
    if (file.crc() != crc32) {
      printf("Initrd file %s invalid CRC32, loc %p, len %u.\n", file.name(), file.buf(), file.len());
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
