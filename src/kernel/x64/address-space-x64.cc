// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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

void AddressSpaceX64::MapPage(void* virtaddr, void* physaddr, bool invalidate, bool writethrough) {
    uintptr_t vaddr = reinterpret_cast<uintptr_t>(virtaddr);
    uint32_t page_offset = vaddr & 0x1FFFFF;
    uint32_t pd_offset = (vaddr >> 21) & 0x1FF;
    uint32_t pdp_offset = (vaddr >> 30) & 0x1FF;
    uint32_t pml4_offset = (vaddr >> 39) & 0x1FF;

    RT_ASSERT(pd_offset < 512);
    RT_ASSERT(pdp_offset < 512);
    RT_ASSERT(pml4_offset < 512);

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

    PML4Entry pml4 = pml4_table->GetEntry(pml4_offset);
    if (pml4.IsPresent) {
        RT_ASSERT(pml4.PageDirectory);
        pdp_table = reinterpret_cast<PageTable<PDPEntry>*>(pml4.PageDirectory);

        PDPEntry pdp = pdp_table->GetEntry(pdp_offset);
        if (pdp.IsPresent) {
            RT_ASSERT(pdp.PageDirectory);
            pd_table = reinterpret_cast<PageTable<PDEntry>*>(pdp.PageDirectory);

            PDEntry pd = pd_table->GetEntry(pd_offset);
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

        pd_table->SetEntry(pd_offset, pd);
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

        pdp_table->SetEntry(pdp_offset, pdp);
    }

    if (create_pml4e) {
        PML4Entry pml4;
        pml4.IsPresent = true;
        pml4.IsWriteable = true;
        pml4.IsWriteThrough = false;
        RT_ASSERT(pdp_table);
        pml4.PageDirectory = pdp_table;
        pml4_table->SetEntry(pml4_offset, pml4);
    }

    if (invalidate) {
        asm volatile("invlpg (%0)" ::"r" (virtaddr) : "memory");
    }
}

} // namespace rt
