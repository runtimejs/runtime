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

#include "multiboot.h"
#include <string>
#include <kernel/boot-services.h>

namespace rt {

Multiboot::Multiboot(void* base) :
  _base(base) {}

MultibootMemoryMapEnumerator::MultibootMemoryMapEnumerator(const Multiboot* multiboot)
  :	mmap_start_(0),
    mmap_current_(0),
    mmap_len_(0) {
  uintptr_t base_addr = reinterpret_cast<uintptr_t>(multiboot->base_address());
  uint32_t mmap_len = 0;
  uint32_t mmap_addr = 0;

  memcpy(&mmap_len, reinterpret_cast<void*>(base_addr +
         offsetof(MultibootStruct, mmap_len)), sizeof(uint32_t));

  memcpy(&mmap_addr, reinterpret_cast<void*>(base_addr +
         offsetof(MultibootStruct, mmap_addr)), sizeof(uint32_t));

  if (0 == mmap_addr || 0 == mmap_len) {
    GLOBAL_boot_services()->FatalError("Invalid memory map provided.");
  }

  RT_ASSERT(mmap_addr);
  RT_ASSERT(mmap_len);
  mmap_start_ = mmap_addr;
  mmap_current_ = mmap_addr;
  mmap_len_ = mmap_len;
}

MemoryZone MultibootMemoryMapEnumerator::NextAvailableMemory() {
  if (mmap_current_ >= mmap_start_ + mmap_len_) {
    return MemoryZone(nullptr, 0);
  }

  MultibootMemoryMapEntry* entry =
    reinterpret_cast<MultibootMemoryMapEntry*>(mmap_current_);
  RT_ASSERT(entry);
  uint32_t size = 0;
  uint64_t base_addr = 0;
  uint64_t length = 0;
  uint32_t type = 0;
  memcpy(&size, reinterpret_cast<void*>(mmap_current_ +
                                        offsetof(MultibootMemoryMapEntry, size)), sizeof(uint32_t));

  RT_ASSERT(size);
  memcpy(&base_addr, reinterpret_cast<void*>(mmap_current_ +
         offsetof(MultibootMemoryMapEntry, base_addr)), sizeof(uint64_t));

  memcpy(&length, reinterpret_cast<void*>(mmap_current_ +
                                          offsetof(MultibootMemoryMapEntry, length)), sizeof(uint64_t));

  memcpy(&type, reinterpret_cast<void*>(mmap_current_ +
                                        offsetof(MultibootMemoryMapEntry, type)), sizeof(uint32_t));

  mmap_current_ += size + sizeof(uint32_t);
  if (type != 1) {
    return NextAvailableMemory();
  }

  return MemoryZone(reinterpret_cast<void*>(base_addr), length);
}

} // namespace rt
