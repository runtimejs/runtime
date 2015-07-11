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
#include <kernel/spinlock.h>
#include <kernel/multiboot.h>
#include <kernel/boot-services.h>
#include <kernel/dlmalloc.h>
#include <kernel/x64/address-space-x64.h>
#include <kernel/runtime-state.h>
#include <kernel/threadlib/spinlock.h>
#include <kernel/allocation-tracker.h>

namespace rt {

/**
 * Physical pages stack
 */
class PagesStack {
public:
    PagesStack(uintptr_t location, size_t size) {
        RT_ASSERT(location);
        RT_ASSERT(size);
        location_overflow_ = reinterpret_cast<uint64_t*>(location);
        current_location_ = reinterpret_cast<uint64_t*>(location + size - sizeof(uint64_t));
        location_ = current_location_;
        push(0); // pageid guard
    }

    inline void push(uint64_t pageid) {
        if (current_location_ == location_overflow_) {
            return;
        }
        *(current_location_--) = pageid;
    }

    inline uint64_t pop() {
        if (current_location_ == location_) {
            return 0;
        }
        return *(++current_location_);
    }

private:
    uint64_t* location_overflow_;
    uint64_t* location_;
    uint64_t* current_location_;
};

/**
 * Represents chunk of physical memory
 */
class PhysicalMemoryZone {
public:
    PhysicalMemoryZone(void* ptr, size_t size) :
        ptr_(ptr),
        size_(size) { }

    void* ptr() {
        return ptr_;
    }

    size_t size() {
        return size_;
    }

    bool empty() {
        return (nullptr == ptr_ && 0 == size_);
    }

private:
    void* ptr_;
    size_t size_;
};

/**
 * Manages physical pages of memory
 *
 * Basic layout (MB):
 *  0  -  2  - reserved
 *  2  -  4  - kernel code start
 *  4  -  6  - kernel code
 *  6  -  8  - kernel code
 *  8  - 10  - kernel code
 * 10  - 12  - kernel code
 * 12  - 14  - kernel code
 * 14  - 16  - reserved memory hole
 * 16  - 18  - reserved to catch stack overflow (TODO)
 * 18  - 20  - kernel main stack
 * 20  - 22  - kernel main stack (stack top 22)
 * 22  - 24  - physical memory manager startup data area
 * 24  - 26  - physical memory manager startup data area
 * 26+       - free to allocate
 */
class PhysicalAllocator {
public:
    PhysicalAllocator() :
        stack_32_(kStackStartAddress, 1 * Constants::MiB),
        stack_64_(kStackStartAddress + Constants::MiB, 1 * Constants::MiB),
        pages_status_(reinterpret_cast<bool*>(kPagesStatusStartAddress)),
        available_phys_memory_(0),
        used_phys_memory_(0) {

        memset(reinterpret_cast<void*>(kPagesStatusStartAddress), 1, kPagesStatusSize);
        MultibootMemoryMapEnumerator mmap = GLOBAL_multiboot()->memory_map();

        do {
            MemoryZone zone = mmap.NextAvailableMemory();
            if (zone.empty()) {
                break;
            }
            uintptr_t start = reinterpret_cast<uintptr_t>(Utils
                ::AlignPtr<void>(zone.ptr(), chunk_size()));

            uintptr_t end = reinterpret_cast<uintptr_t>(
                PageAligned(reinterpret_cast<uint8_t*>(zone.ptr()) + zone.size()));

            if (start < kAllocStartAddress) {
                start = kAllocStartAddress;
            }

            if (start >= end) {
                continue;
            }

            _insert_pages_range(reinterpret_cast<uintptr_t>(start), reinterpret_cast<uintptr_t>(end));
        }
        while (true);

        if (available_phys_memory_ < 256 * Constants::MiB) {
            printf("System requires at least 256 MiB or memory.\n");
            abort();
        }

        printf("Detected available %d MiB of memory.\n", available_phys_memory_ / 1024 / 1024);
    }

    ~PhysicalAllocator() {}

    PhysicalAllocator(const PhysicalAllocator&) = delete;
    PhysicalAllocator& operator=(const PhysicalAllocator&) = delete;

    inline void free(void* addr) {
        if (nullptr == addr) {
            return;
        }
        uint64_t pageid = reinterpret_cast<uintptr_t>(addr) / kPageSizeBytes;
        if (false == pages_status_[pageid]) {
            // Double free
            RT_ASSERT(!"Double free.");
            return;
        }
        pages_status_[pageid] = false;

        uint64_t last_32bit = 0xffffffff / kPageSizeBytes;
        if (pageid <= last_32bit) {
            stack_32_.push(pageid);
        } else {
            stack_64_.push(pageid);
        }

        used_phys_memory_ -= kPageSizeBytes;
    }

    PhysicalMemoryZone page_directory_zone() {
        RT_ASSERT(kAllocStartAddress);
        RT_ASSERT(kPageDirectoryStart);
        RT_ASSERT(kAllocStartAddress - kPageDirectoryStart
                  >= 1 * Constants::MiB);

        return PhysicalMemoryZone(reinterpret_cast<void*>(kPageDirectoryStart),
                                  kAllocStartAddress - kPageDirectoryStart);
    }

    inline void* alloc32() {
        uint64_t pageid = stack_32_.pop();
        if (0 == pageid) {
            RT_ASSERT(!"No more physical pages to allocate (32 bit).");
            return nullptr;
        }

        pages_status_[pageid] = true;
        used_phys_memory_ += kPageSizeBytes;
        return reinterpret_cast<void*>(pageid * kPageSizeBytes);
    }

    inline void* alloc() {
        uint64_t pageid = stack_64_.pop();
        if (0 == pageid) {
            pageid = stack_32_.pop();
        }

        if (0 == pageid) {
            RT_ASSERT(!"No more physical pages to allocate.");
            return nullptr;
        }

        used_phys_memory_ += kPageSizeBytes;
        pages_status_[pageid] = true;
        return reinterpret_cast<void*>(pageid * kPageSizeBytes);
    }

    uint64_t physical_memory_total() const {
        return available_phys_memory_;
    }

    uint64_t physical_memory_used() const {
        return used_phys_memory_;
    }

    static inline size_t chunk_size() {
        return kPageSizeBytes;
    }

    static uint64_t identity_mapped_region_size() {
        return kAllocStartAddress;
    }

    static void* PageAligned(void* ptr) {
        // Round down to 2 Mib page boundary
        return reinterpret_cast<void*>(reinterpret_cast<uintptr_t>(ptr) & ~0x1FFFFF);
    }
private:
    static const uint64_t kPageSizeBytes = 2 * Constants::MiB;
    static const uint64_t kAllocStartAddress = 32 * Constants::MiB;
    static const uint64_t kPageDirectoryStart = 26 * Constants::MiB;
    static const uint64_t kStackStartAddress = 22 * Constants::MiB;
    static const uint64_t kPagesStatusStartAddress = 24 * Constants::MiB;
    static const uint64_t kPagesStatusSize = 2 * Constants::MiB;

    PagesStack stack_32_;
    PagesStack stack_64_;
    bool* pages_status_;
    uint64_t available_phys_memory_;
    uint64_t used_phys_memory_;

    void _insert_pages_range(uintptr_t start, uintptr_t end) {
        uint64_t first_page = start / kPageSizeBytes;
        uint64_t last_page = end / kPageSizeBytes;

        uint64_t last_32bit = 0xffffffff / kPageSizeBytes;

        if (first_page >= last_page) {
            return;
        }

        for (uint64_t i = first_page; i < last_page; ++i) {
            if (0 ==pages_status_[i]) {
                // Skip double insert
                continue;
            }

            pages_status_[i] = false;

            if (i <= last_32bit) {
                stack_32_.push(i);
            } else {
                stack_64_.push(i);
            }

            available_phys_memory_ += chunk_size();
        }
        printf("RANGE %d MB - %d MB \n", first_page * 2, (last_page-1) * 2);
    }
};

/**
 * Virtual memory system allocated stack space
 */
class VirtualStack {
public:
    VirtualStack(void* top, size_t len) :
        top_(top),
        len_(len) { }

    void* top() const {
        return top_;
    }

    size_t len() const {
        return len_;
    }

private:
    void* top_;
    size_t len_;
};

/**
 * Manages virtual memory
 */
class VirtualAllocator {
public:
    VirtualAllocator() :
        stack_alloc_next_(kStacks) {}

    VirtualStack AllocStack() {
        ScopedLock<threadlib::spinlock_t> lock(stack_alloc_locker_);
        void* top = reinterpret_cast<void*>(stack_alloc_next_);
        uint64_t page_size = PhysicalAllocator::chunk_size();
        stack_alloc_next_ += 2 * page_size; // reserve two pages (1 extra for guard page)

        // This is required to trigger PF
        // Stack page needs to be allocated before
        // thread can switch to it with IRETQ
        memset(top, 0, page_size);

        return VirtualStack(top, page_size);
    }

    void* GetCpuSpace() const {
        uint32_t cpuid = Cpu::id();

        uint64_t p = kSpacesBase + kSpaceSize * ((uint64_t)(cpuid + 1));
        return reinterpret_cast<void*>(p);
    }

    void* GetSharedSpace() const {
        uint64_t p = kSpacesBase + kSpaceSize;
        return reinterpret_cast<void*>(p);
    }

    size_t GetSpaceSize() const {
        return kSpaceSize;
    }

    static const uint64_t kSpacesBase = 256 * Constants::GiB;
    static const uint64_t kSpaceSize = 256 * Constants::GiB;
    static const uint64_t kStacks = 128 * Constants::GiB;
private:
    threadlib::spinlock_t stack_alloc_locker_;
    uint64_t stack_alloc_next_;
    DELETE_COPY_AND_ASSIGN(VirtualAllocator);
};

/**
 * Allocates memory for page tables
 */
class PageTableAllocator {
public:
    explicit PageTableAllocator(PhysicalAllocator& pmm, VirtualAllocator& vmm)
        :	pmm_(pmm),
            vmm_(vmm),
            page_directory_zone_(pmm.page_directory_zone()),
            tables_taken_(0) { }

    template<typename EntryType>
    PageTable<EntryType>* AllocTable() {
        // TODO: support for allocation of more than 512 tables

        void* addr = reinterpret_cast<uint8_t*>(page_directory_zone_.ptr()) +
                tables_taken_ * 4 * Constants::KiB;

        RT_ASSERT(reinterpret_cast<uintptr_t>(addr) -
                  reinterpret_cast<uintptr_t>(
                      page_directory_zone_.ptr()) < page_directory_zone_.size());

        memset(addr, 0, 4 * Constants::KiB);
        ++tables_taken_;

        return reinterpret_cast<PageTable<EntryType>*>(addr);
    }

private:
    PhysicalAllocator& pmm_;
    VirtualAllocator& vmm_;
    PhysicalMemoryZone page_directory_zone_;
    uint32_t tables_taken_;
    DELETE_COPY_AND_ASSIGN(PageTableAllocator);
};

typedef void (*AllocatorTraceCallback)(void*);

/**
 * Allocates memory in custom-size chunks
 */
class MallocAllocator {
private:
public:
    MallocAllocator();

    inline void* Alloc(size_t size) {
#ifdef RUNTIME_ALLOCATOR_CALLBACKS
        if (enter_callback_) { enter_callback_(callback_param_); }
#endif
        void* result;
        {   ScopedLock<threadlib::spinlock_t> lock(default_mspace_locker_);
            result = mspace_malloc(default_mspace_, size);
        }
#ifdef RUNTIME_ALLOCATOR_CALLBACKS
        if (exit_callback_) { exit_callback_(callback_param_); }
#endif
        return result;
    }

    inline void* AllocAligned(size_t alignment, size_t size) {
#ifdef RUNTIME_ALLOCATOR_CALLBACKS
        if (enter_callback_) { enter_callback_(callback_param_); }
#endif
        void* result;
        {	ScopedLock<threadlib::spinlock_t> lock(default_mspace_locker_);
            result =  mspace_memalign(default_mspace_, alignment, size);
        }
#ifdef RUNTIME_ALLOCATOR_CALLBACKS
        if (exit_callback_) { exit_callback_(callback_param_); }
#endif
        return result;
    }

    inline void* Calloc(size_t elements, size_t element_size) {
#ifdef RUNTIME_ALLOCATOR_CALLBACKS
        if (enter_callback_) { enter_callback_(callback_param_); }
#endif
        void* result;
        {   ScopedLock<threadlib::spinlock_t> lock(default_mspace_locker_);
            result = mspace_calloc(default_mspace_, elements, element_size);
        }
#ifdef RUNTIME_ALLOCATOR_CALLBACKS
        if (exit_callback_) { exit_callback_(callback_param_); }
#endif
        return result;
    }

    inline void* Realloc(void* ptr, size_t new_size) {
#ifdef RUNTIME_ALLOCATOR_CALLBACKS
        if (enter_callback_) { enter_callback_(callback_param_); }
#endif
        void* result;
        {   ScopedLock<threadlib::spinlock_t> lock(default_mspace_locker_);
            result = mspace_realloc(default_mspace_, ptr, new_size);
        }
#ifdef RUNTIME_ALLOCATOR_CALLBACKS
        if (exit_callback_) { exit_callback_(callback_param_); }
#endif
        return result;
    }

    inline void Free(void* ptr) {
#ifdef RUNTIME_ALLOCATION_TRACKER
        if (allocation_tracker_) {
            allocation_tracker_->UnregisterAlloc(ptr);
        }
#endif // RUNTIME_ALLOCATION_TRACKER

#ifdef RUNTIME_ALLOCATOR_CALLBACKS
        if (enter_callback_) { enter_callback_(callback_param_); }
#endif
        {   ScopedLock<threadlib::spinlock_t> lock(default_mspace_locker_);
            mspace_free(default_mspace_, ptr);
        }
#ifdef RUNTIME_ALLOCATOR_CALLBACKS
        if (exit_callback_) { exit_callback_(callback_param_); }
#endif
    }

#ifdef RUNTIME_ALLOCATOR_CALLBACKS
    void SetTraceCallbacks(AllocatorTraceCallback enter, AllocatorTraceCallback exit, void* param) {
        enter_callback_ = enter;
        exit_callback_ = exit;
        callback_param_ = param;
    }
#endif

    /**
     * Initialize allocator per-cpu data
     */
    void InitCpu();

    /**
     * Initialize allocator cpu-shared data
     */
    void InitOnce();

    /**
     * Get allocation tracker instance, not thread-safe
     */
    AllocationTracker* allocation_tracker() {
#ifdef RUNTIME_ALLOCATION_TRACKER
        if (!allocation_tracker_) {
            allocation_tracker_ = new AllocationTracker();
        }
#endif // RUNTIME_ALLOCATION_TRACKER
        RT_ASSERT(allocation_tracker_);
        return allocation_tracker_;
    }
private:
    threadlib::spinlock_t default_mspace_locker_;
    mspace default_mspace_;
    AllocatorTraceCallback enter_callback_;
    AllocatorTraceCallback exit_callback_;
    void* callback_param_;
    AllocationTracker* allocation_tracker_;
    DELETE_COPY_AND_ASSIGN(MallocAllocator);
};

/**
 * Controls memory and address space
 */
class MemManager {
public:
    MemManager();

    /**
     * Initialize memory manager for current CPU
     */
    void InitSubsystems();

    /**
     * Page fault handler, called from IRQ context
     */
    void PageFault(void* fault_address, uint64_t error_code);

    /**
     * Check if malloc (or new) can be used to allocate memory.
     * Automatically checked on malloc when assertions are enabled
     */
    bool CanMalloc() {
        return malloc_available_;
    }

    /**
     * Allocate 1 physical page identity-mapped to 32 bit part
     * of address space (useful for DMA memory allocation,
     * you can pass the same address to device that doesn't do
     * paging)
     */
    void* AllocPage32() {
        ScopedLock<threadlib::spinlock_t> lock(page_alloc_locker_);
        return pmm_.alloc32();
    }

    /**
     * Get physical page size
     */
    size_t page_size() const {
        return pmm_.chunk_size();
    }

    /**
     * Get total amount of available physical memory in bytes
     * (never changes after boot)
     */
    uint64_t physical_memory_total() const {
        return pmm_.physical_memory_total();
    }

    /**
     * Get total amount of used physical memory in bytes
     */
    uint64_t physical_memory_used() const {
        return pmm_.physical_memory_used();
    }

    /**
     * Locate physical memory address mapped to
     * virtual memory address
     */
    void* VirtualToPhysicalAddress(void* virtaddr) {
        return addr_space_.VirtualToPhysical(virtaddr);
    }

    inline VirtualAllocator& virtual_allocator() { return vmm_; }
    inline MallocAllocator& malloc_allocator() { return malloc_; }
    inline AddressSpaceX64& address_space() { return addr_space_; }
private:
    PhysicalAllocator pmm_;
    VirtualAllocator vmm_;
    MallocAllocator malloc_;
    PageTableAllocator table_allocator_;
    AddressSpaceX64 addr_space_;
    bool malloc_available_;
    threadlib::spinlock_t page_alloc_locker_;
    DELETE_COPY_AND_ASSIGN(MemManager);
};

} // namespace rt
