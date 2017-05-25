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

#include <kernel/mem-manager.h>
#include <stdio.h>
#include <kernel/engines.h>
#include <kernel/constants.h>

namespace rt {

MemManager::MemManager()
  :	pmm_(),
    vmm_(),
    table_allocator_(pmm_, vmm_),
    addr_space_(&table_allocator_),
    malloc_available_(false) {}

void MemManager::InitSubsystems() {
  if (0 == Cpu::id()) {
    RT_ASSERT(!malloc_available_);

    // Setup address space, physical, virtual and malloc
    // allocators
    addr_space_.Configure();
    addr_space_.Install();
    malloc_.InitCpu();
    malloc_.InitOnce();

    // Enable memory allocation using malloc / free
    malloc_available_ = true;
  } else {
    addr_space_.Install();
    malloc_.InitCpu();
  }
}

void MemManager::PageFault(void* fault_address, uint64_t error_code) {
  void* phys_mem = nullptr;
  bool writethrough = true;
  bool clean = false;

  uintptr_t fa = reinterpret_cast<uintptr_t>(fault_address);
  if (fa < 4 * Constants::GiB) {
    // Lazy-identity mapping for 4 GB virtual address space
    phys_mem = fault_address;
    writethrough = true;
  } else if (fa < 512 * 256 * Constants::GiB) {
    // Automatic mapping normal space
    phys_mem = pmm_.alloc();

    // clean = true;
    writethrough = false;
  } else {
    GLOBAL_boot_services()
    ->FatalError("Invalid Faulting address = %p,"
                 " error code = %d, alloc to %p, cpu %d\n",
                 fault_address, error_code, phys_mem, Cpu::id());
  }
  RT_ASSERT(phys_mem);
  addr_space_.MapPage(fault_address, phys_mem, true, writethrough);

  if (clean) {
    // Clean memory
    void* s = pmm_.PageAligned(fault_address);
    memset(s, 0, pmm_.chunk_size());
  }
}

MallocAllocator::MallocAllocator()
  :   default_mspace_(nullptr),
      enter_callback_(nullptr),
      exit_callback_(nullptr),
      callback_param_(nullptr),
      allocation_tracker_(nullptr) {}

void MallocAllocator::InitCpu() {}

void MallocAllocator::InitOnce() {
  uint32_t cpuid = Cpu::id();
  RT_ASSERT(0 == cpuid);

  void* s = GLOBAL_mem_manager()->virtual_allocator().GetSharedSpace();
  size_t cap = GLOBAL_mem_manager()->virtual_allocator().GetSpaceSize();

  RT_ASSERT(s);
  RT_ASSERT(cap >= 1 * Constants::GiB);

  RT_ASSERT(nullptr == default_mspace_);
  default_mspace_ = create_mspace_with_base(s, cap, 0);
  mspace_track_large_chunks(default_mspace_, true);
  RT_ASSERT(nullptr != default_mspace_);
}


} // namespace rt

extern "C" void* malloc(size_t size) {
  RT_ASSERT(nullptr != GLOBAL_mem_manager());
  RT_ASSERT(GLOBAL_mem_manager()->CanMalloc());
  return GLOBAL_mem_manager()->malloc_allocator().Alloc(size);
}

extern "C" void* memalign(size_t alignment, size_t size) {
  RT_ASSERT(nullptr != GLOBAL_mem_manager());
  RT_ASSERT(GLOBAL_mem_manager()->CanMalloc());
  return GLOBAL_mem_manager()->malloc_allocator().AllocAligned(alignment, size);
}

extern "C" void* calloc(size_t elements, size_t element_size) {
  RT_ASSERT(nullptr != GLOBAL_mem_manager());
  RT_ASSERT(GLOBAL_mem_manager()->CanMalloc());
  return GLOBAL_mem_manager()->malloc_allocator().Calloc(elements, element_size);
}

extern "C" void* realloc(void* ptr, size_t size) {
  RT_ASSERT(nullptr != GLOBAL_mem_manager());
  RT_ASSERT(GLOBAL_mem_manager()->CanMalloc());
  return GLOBAL_mem_manager()->malloc_allocator().Realloc(ptr, size);
}

extern "C" void free(void* ptr) {
  RT_ASSERT(nullptr != GLOBAL_mem_manager());
  RT_ASSERT(GLOBAL_mem_manager()->CanMalloc());
  GLOBAL_mem_manager()->malloc_allocator().Free(ptr);
}

extern "C" void allocator_abort() {
  printf("Allocator fatal error, CPU = %d\n", rt::Cpu::id());
  abort();
}
