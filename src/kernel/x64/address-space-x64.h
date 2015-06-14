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
#include <kernel/constants.h>
#include <kernel/spinlock.h>

namespace rt {

class CR3Entry {
public:
    bool IsWriteThrough; // PWT
    bool IsNotCachable;  // PCD
    void* PageDirectory;

    CR3Entry()
        :	IsWriteThrough(false),
            IsNotCachable(false),
            PageDirectory(nullptr) { }

    explicit CR3Entry(uint64_t entry)
        :	IsWriteThrough(entry & (1UL << 3)),
            IsNotCachable(entry & (1UL << 4)),
            PageDirectory(reinterpret_cast<void*>(entry & 0xFFFFFFFFFF000)) {}

    uint64_t Encode() const {
        RT_ASSERT((reinterpret_cast<uint64_t>(PageDirectory) & 0xFFF) == 0);
        return ((static_cast<uint64_t>(IsWriteThrough) << 3) |
                (static_cast<uint64_t>(IsNotCachable) << 4) |
                (reinterpret_cast<uint64_t>(PageDirectory)));
    }
};

class PML4PDPEntry {
public:
    bool IsPresent; 		// P
    bool IsWriteable; 		// R/W
    bool IsUserEnabled; 	// U/S
    bool IsWriteThrough; 	// PWT
    bool IsNotCachable; 	// PCD
    bool IsAccessed; 		// A
    bool IsNoExecute; 		// NX
    void* PageDirectory;

    PML4PDPEntry()
        :	IsPresent(false),
            IsWriteable(false),
            IsUserEnabled(false),
            IsWriteThrough(false),
            IsNotCachable(false),
            IsAccessed(false),
            IsNoExecute(false),
            PageDirectory(nullptr) { }

    explicit PML4PDPEntry(uint64_t entry)
        :	IsPresent(entry & 1UL),
            IsWriteable(entry & (1UL << 1)),
            IsUserEnabled(entry & (1UL << 2)),
            IsWriteThrough(entry & (1UL << 3)),
            IsNotCachable(entry & (1UL << 4)),
            IsAccessed(entry & (1UL << 5)),
            IsNoExecute(entry & (1UL << 63)),
            PageDirectory(reinterpret_cast<void*>(entry & 0xFFFFFFFFFF000)) { }

    uint64_t Encode() const {
        RT_ASSERT((reinterpret_cast<uint64_t>(PageDirectory) & 0xFFF) == 0);
        return ((static_cast<uint64_t>(IsPresent)) |
                (static_cast<uint64_t>(IsWriteable) << 1) |
                (static_cast<uint64_t>(IsUserEnabled) << 2) |
                (static_cast<uint64_t>(IsWriteThrough) << 3) |
                (static_cast<uint64_t>(IsNotCachable) << 4) |
                (static_cast<uint64_t>(IsAccessed) << 5) |
                (static_cast<uint64_t>(IsNoExecute) << 63) |
                (reinterpret_cast<uint64_t>(PageDirectory)));
    }
};

class PML4Entry : public PML4PDPEntry {
public:
    PML4Entry() : PML4PDPEntry() { }
    explicit PML4Entry(uint64_t entry) : PML4PDPEntry(entry) { }
};

class PDPEntry : public PML4PDPEntry {
public:
    PDPEntry() : PML4PDPEntry() { }
    explicit PDPEntry(uint64_t entry) : PML4PDPEntry(entry) { }
};

class PDEntry {
public:
    bool IsPresent; 		// P
    bool IsWriteable; 		// R/W
    bool IsUserEnabled; 	// U/S
    bool IsWriteThrough; 	// PWT
    bool IsNotCachable; 	// PCD
    bool IsAccessed; 		// A
    bool IsDirty; 			// D
    bool IsPageSize; 		// PS, 1 for 2MB
    bool IsGlobal; 			// G
    bool IsNoExecute; 		// NX
    void* PageAddress;

    PDEntry()
        :	IsPresent(false),
            IsWriteable(false),
            IsUserEnabled(false),
            IsWriteThrough(false),
            IsNotCachable(false),
            IsAccessed(false),
            IsDirty(false),
            IsPageSize(false),
            IsGlobal(false),
            IsNoExecute(false),
            PageAddress(nullptr) { }

    explicit PDEntry(uint64_t entry)
        :	IsPresent(entry & 1UL),
            IsWriteable(entry & (1UL << 1)),
            IsUserEnabled(entry & (1UL << 2)),
            IsWriteThrough(entry & (1UL << 3)),
            IsNotCachable(entry & (1UL << 4)),
            IsAccessed(entry & (1UL << 5)),
            IsDirty(entry & (1UL << 6)),
            IsPageSize(entry & (1UL << 7)),
            IsGlobal(entry & (1UL << 8)),
            IsNoExecute(entry & (1UL << 63)),
            PageAddress(reinterpret_cast<void*>(entry & 0xFFFFFFFE00000)) { }

    uint64_t Encode() const {
        RT_ASSERT((reinterpret_cast<uint64_t>(PageAddress) & 0x1FFFFF) == 0);
        return ((static_cast<uint64_t>(IsPresent)) |
                (static_cast<uint64_t>(IsWriteable) << 1) |
                (static_cast<uint64_t>(IsUserEnabled) << 2) |
                (static_cast<uint64_t>(IsWriteThrough) << 3) |
                (static_cast<uint64_t>(IsNotCachable) << 4) |
                (static_cast<uint64_t>(IsAccessed) << 5) |
                (static_cast<uint64_t>(IsDirty) << 6) |
                (static_cast<uint64_t>(IsPageSize) << 7) |
                (static_cast<uint64_t>(IsGlobal) << 8) |
                (static_cast<uint64_t>(IsNoExecute) << 63) |
                (reinterpret_cast<uint64_t>(PageAddress)));
    }
};

template<typename EntryType>
class PageTable {
public:
    void* physical_address() {
        return reinterpret_cast<void*>(this);
    }

    void SetEntry(uint32_t index, EntryType entry) {
        RT_ASSERT(index < 512);
        entries_[index] = entry.Encode();
    }

    EntryType GetEntry(uint32_t index) {
        RT_ASSERT(index < 512);
        return EntryType(entries_[index]);
    }

protected:
    uint64_t entries_[512];
    DELETE_COPY_AND_ASSIGN(PageTable);
};

static_assert(sizeof(PageTable<PML4Entry>) == 4 * 1024,
              "Invalid size of PDE, should be 4 KiB.");

static_assert(sizeof(PageTable<PDPEntry>) == 4 * 1024,
              "Invalid size of PDPE, should be 4 KiB.");

static_assert(sizeof(PageTable<PDEntry>) == 4 * 1024,
              "Invalid size of PML4E, should be 4 KiB.");

class PageTableAllocator;

class AddressSpaceX64 {
public:
    AddressSpaceX64(PageTableAllocator* table_allocator);

    void Install();
    void Configure();

    /**
     * Map virtual address to physical one
     */
    void MapPage(void* virtaddr, void* physaddr, bool invalidate, bool writethrough);

    /**
     * Convert virtual to physical memory address on this
     * address space
     */
    void* VirtualToPhysical(void* virtaddr);

    inline static CR3Entry current() {
        uint64_t cr3value;
        asm volatile("mov %%cr3, %0" : "=r"(cr3value));
        RT_ASSERT(cr3value);
        return CR3Entry(cr3value);
    }
private:
    PageTableAllocator* table_allocator_;
    CR3Entry cr3_;
    PageTable<PML4Entry>* pml4_table_;
};

} // namespace rt
