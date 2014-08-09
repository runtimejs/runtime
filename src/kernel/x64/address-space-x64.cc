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

#include "address-space-x64.h"
#include <stdio.h>
#include <kernel/mem-manager.h>

namespace rt {

AddressSpaceX64::AddressSpaceX64(PageTableAllocator* table_allocator)
    :	table_allocator_(table_allocator),
        pml4_table_(nullptr) {

    RT_ASSERT(table_allocator_);

    // Allocate 1 PML4 table for whole address space
    pml4_table_ = table_allocator_->AllocTable<PML4Entry>();
    RT_ASSERT(pml4_table_);
}

void AddressSpaceX64::Configure() {
    cr3_.IsWriteThrough = false;
    cr3_.PageDirectory = pml4_table_;

    uint64_t identity_region = PhysicalAllocator::identity_mapped_region_size();
    RT_ASSERT(identity_region);

    size_t pagesize = PhysicalAllocator::chunk_size();
    RT_ASSERT(pagesize > 0);
    size_t pages = identity_region / pagesize;
    RT_ASSERT(pages > 0);

    printf("TO ident pages : %d, loc 1 = %x, loc 2 = %x\n", pages, pages * pagesize ,
           reinterpret_cast<uint64_t>(pml4_table_));

    for (size_t i = 0; i < pages; ++i) {
        MapPage(reinterpret_cast<void*>(pagesize * i),
                reinterpret_cast<void*>(pagesize * i), false, true); // identity
    }

    printf("CR3 value = %p\n", cr3_.Encode());
}

void AddressSpaceX64::Install() {
    asm volatile("mov %0, %%cr3":: "b"(cr3_.Encode()));
}

class VirtualAddressX64 {
public:
    explicit VirtualAddressX64(void* address)
        : address_(reinterpret_cast<uintptr_t>(address)) {}
    explicit VirtualAddressX64(uintptr_t address)
        : address_(address) {}

    inline uint32_t page_offset() const {
        uint32_t offset = address_ & 0x1FFFFF;
        return offset;
    }

    inline uint32_t pd_offset() const {
        uint32_t offset = (address_ >> 21) & 0x1FF;
        RT_ASSERT(offset < 512);
        return offset;
    }

    inline uint32_t pdp_offset() const {
        uint32_t offset = (address_ >> 30) & 0x1FF;
        RT_ASSERT(offset < 512);
        return offset;
    }

    inline uint32_t pml4_offset() const {
        uint32_t offset = (address_ >> 39) & 0x1FF;
        RT_ASSERT(offset < 512);
        return offset;
    }

    inline uintptr_t address() const { return address_; }
private:
    uintptr_t address_;
};

void* AddressSpaceX64::VirtualToPhysical(void* virtaddr) {
    VirtualAddressX64 vaddr(virtaddr);

    RT_ASSERT(cr3_.PageDirectory);
    PageTable<PML4Entry>* pml4_table =
        reinterpret_cast<PageTable<PML4Entry>*>(cr3_.PageDirectory);
    RT_ASSERT(pml4_table);

    PML4Entry pml4 = pml4_table->GetEntry(vaddr.pml4_offset());
    if (!pml4.IsPresent) {
        return nullptr;
    }

    RT_ASSERT(pml4.PageDirectory);
    auto pdp_table = reinterpret_cast<PageTable<PDPEntry>*>(pml4.PageDirectory);

    PDPEntry pdp = pdp_table->GetEntry(vaddr.pdp_offset());
    if (!pdp.IsPresent) {
        return nullptr;
    }

    RT_ASSERT(pdp.PageDirectory);
    auto pd_table = reinterpret_cast<PageTable<PDEntry>*>(pdp.PageDirectory);

    PDEntry pd = pd_table->GetEntry(vaddr.pd_offset());
    if (!pd.IsPresent) {
        return nullptr;
    }

    uint8_t* page_addr = reinterpret_cast<uint8_t*>(pd.PageAddress);
    return reinterpret_cast<void*>(page_addr + vaddr.page_offset());
}

void AddressSpaceX64::MapPage(void* virtaddr, void* physaddr, bool invalidate, bool writethrough) {
    VirtualAddressX64 vaddr(virtaddr);

    physaddr = PhysicalAllocator::PageAligned(physaddr);
    RT_ASSERT(cr3_.PageDirectory);
    PageTable<PML4Entry>* pml4_table =
        reinterpret_cast<PageTable<PML4Entry>*>(cr3_.PageDirectory);
    RT_ASSERT(pml4_table);
    PageTable<PDPEntry>* pdp_table = nullptr;
    PageTable<PDEntry>* pd_table = nullptr;

    bool create_pde = false;
    bool create_pdpe = false;
    bool create_pml4e = false;

    PML4Entry pml4 = pml4_table->GetEntry(vaddr.pml4_offset());
    if (pml4.IsPresent) {
        RT_ASSERT(pml4.PageDirectory);
        pdp_table = reinterpret_cast<PageTable<PDPEntry>*>(pml4.PageDirectory);

        PDPEntry pdp = pdp_table->GetEntry(vaddr.pdp_offset());
        if (pdp.IsPresent) {
            RT_ASSERT(pdp.PageDirectory);
            pd_table = reinterpret_cast<PageTable<PDEntry>*>(pdp.PageDirectory);

            PDEntry pd = pd_table->GetEntry(vaddr.pd_offset());
            if (pd.IsPresent) {
                void* page_addr = pd.PageAddress;
                if (physaddr == page_addr) {
                    return;
                }
            } else {
                create_pde = true;
            }
        } else {
            create_pde = true;
            create_pdpe = true;
        }
    } else {
        create_pde = true;
        create_pdpe = true;
        create_pml4e = true;
    }

    if (create_pde) {
        PDEntry pd;
        pd.IsPresent = true;
        pd.IsWriteable = true;
        pd.IsWriteThrough = writethrough;
        pd.IsPageSize = true;
        pd.IsGlobal = false;
        pd.PageAddress = physaddr;

        if (nullptr == pd_table) {
            pd_table = table_allocator_->AllocTable<PDEntry>();
            RT_ASSERT(pd_table);
        }

        pd_table->SetEntry(vaddr.pd_offset(), pd);
    }

    if (create_pdpe) {
        PDPEntry pdp;
        pdp.IsPresent = true;
        pdp.IsWriteable = true;
        pdp.IsWriteThrough = false;
        RT_ASSERT(pd_table);
        pdp.PageDirectory = pd_table;

        if (nullptr == pdp_table) {
            pdp_table = table_allocator_->AllocTable<PDPEntry>();
            RT_ASSERT(pdp_table);
        }

        pdp_table->SetEntry(vaddr.pdp_offset(), pdp);
    }

    if (create_pml4e) {
        PML4Entry pml4;
        pml4.IsPresent = true;
        pml4.IsWriteable = true;
        pml4.IsWriteThrough = false;
        RT_ASSERT(pdp_table);
        pml4.PageDirectory = pdp_table;
        pml4_table->SetEntry(vaddr.pml4_offset(), pml4);
    }

    if (invalidate) {
        asm volatile("invlpg (%0)" ::"r" (virtaddr) : "memory");
    }
}

} // namespace rt
