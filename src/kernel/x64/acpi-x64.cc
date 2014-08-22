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

#include "acpi-x64.h"
#include "local-apic-x64.h"
#include <kernel/engines.h>

namespace rt {

struct AcpiHeader {
    uint32_t signature;
    uint32_t length;
    uint8_t revision;
    uint8_t checksum;
    uint8_t oem[6];
    uint8_t oemTableId[8];
    uint32_t oemRevision;
    uint32_t creatorId;
    uint32_t creatorRevision;
} __attribute__((packed));

constexpr static uint32_t TableUint32(const char* str) {
    return ((uint32_t)str[0] <<  0) |
           ((uint32_t)str[1] <<  8) |
           ((uint32_t)str[2] << 16) |
           ((uint32_t)str[3] << 24);
}

static_assert(TableUint32("ABCD") == 0x44434241,
              "Invalid table name convertion on current platform.");

struct AcpiHeaderMADT {
    AcpiHeader header;
    uint32_t localApicAddr;
    uint32_t flags;
} __attribute__((packed));

struct AcpiHPETAddress {
    uint8_t addressSpaceId;
    uint8_t registerBitWidth;
    uint8_t registerBitOffset;
    uint8_t reserved;
    uint64_t address;
} __attribute__((packed));

struct AcpiHeaderHPET {
    AcpiHeader header;
    uint8_t hardwareRevId;
    uint8_t comparatorCount : 5;
    uint8_t counterSize : 1;
    uint8_t reserved : 1;
    uint8_t legacyPlacement : 1;
    uint16_t pciVendorId;
    AcpiHPETAddress address;
    uint8_t hpetNumber;
    uint16_t minimumTick;
    uint8_t pageProtection;
} __attribute__((packed));

enum class ApicType : uint8_t {
    LOCAL_APIC = 0,
    IO_APIC = 1,
    INTERRUPT_OVERRIDE = 2
};

struct ApicHeader {
    ApicType type;
    uint8_t length;
} __attribute__((packed));

struct ApicLocalApic {
    ApicHeader header;
    uint8_t acpiProcessorId;
    uint8_t apicId;
    uint32_t flags;
} __attribute__((packed));

struct ApicIoApic {
    ApicHeader header;
    uint8_t ioApicId;
    uint8_t reserved;
    uint32_t ioApicAddress;
    uint32_t globalSystemInterrupt;
} __attribute__((packed));

void AcpiX64::Init() {
    for (uint8_t* p = (uint8_t*)0xe0000; p < (uint8_t*)0x1000000; p += 16) {
        uint64_t sig = *(uint64_t*)p;
        if (0x2052545020445352 == sig) { // 'RSD PTR '
            if (ParseRSDP(p))
            {
                break;
            }
        }
    }

    if (io_apics_.size() == 0) {
        printf("Unable to find IO APIC to setup interrupts.\n");
        abort();
    }
}

bool AcpiX64::ParseRSDP(void* p) {
    uint8_t* pt = static_cast<uint8_t*>(p);

    {	uint8_t sum = 0;
        for (uint8_t i = 0; i < 20; ++i) {
            sum += pt[i];
        }

        if (sum) {
            return false;
        }
    }

    uint8_t rev = pt[15];
    uint32_t rsdt_addr = 0;

    switch (rev) {
    case 0:
        memcpy(&rsdt_addr, pt + 16, sizeof(uint32_t));
        break;
    case 2:
        memcpy(&rsdt_addr, pt + 16, sizeof(uint32_t));
        break;
    default:
        printf("ACPI unknown revision.\n");
        return false;
    }

    RT_ASSERT(rsdt_addr);
    ParseRSDT(reinterpret_cast<AcpiHeader*>((uint64_t)(rsdt_addr)));
    return true;
}

void AcpiX64::ParseRSDT(AcpiHeader* ptr) {
    RT_ASSERT(ptr);

    uint32_t* p = reinterpret_cast<uint32_t*>(ptr + 1);
    uint32_t* end = reinterpret_cast<uint32_t*>((uint8_t*)ptr + ptr->length);

    while (p < end) {
        uint64_t addr = static_cast<uint64_t>(*p++);
        ParseDT((AcpiHeader *)(uintptr_t)addr);
    }
}

void AcpiX64::ParseDT(AcpiHeader* ptr) {
    RT_ASSERT(ptr);
    uint32_t signature = ptr->signature;

    switch (signature) {
    case TableUint32("APIC"):
        ParseTableAPIC(reinterpret_cast<AcpiHeaderMADT*>(ptr));
        break;
    case TableUint32("HPET"):
        ParseTableHPET(reinterpret_cast<AcpiHeaderHPET*>(ptr));
        break;
    default:
        break;
    }
}

void AcpiX64::ParseTableHPET(AcpiHeaderHPET* header) {
    RT_ASSERT(header);
    if (nullptr != hpet_) {
        // Ignore other HPET devices except first one
        return;
    }

    uint64_t address = header->address.address;
    RT_ASSERT(address);
    RT_ASSERT(!hpet_);
    hpet_ = new HpetX64(reinterpret_cast<void*>(address));
    RT_ASSERT(hpet_);
}

void AcpiX64::ParseTableAPIC(AcpiHeaderMADT* header) {
    RT_ASSERT(header);
    RT_ASSERT(header->localApicAddr);

    void* local_apic_address = reinterpret_cast<void*>(
        static_cast<uint64_t>(header->localApicAddr));

    local_apic_address_ = local_apic_address;
    local_apic_ = new LocalApicX64(local_apic_address);

    uint8_t* p = (uint8_t*)(header + 1);
    uint8_t* end = (uint8_t*)header + header->header.length;

    while (p < end) {
        ApicHeader* header = (ApicHeader*)p;
        ApicType type = header->type;
        uint8_t length = header->length;

        switch (type) {
        case ApicType::LOCAL_APIC: {
            ApicLocalApic* s = (ApicLocalApic*)p;
            AcpiCPU cpu;
            cpu.cpu_id = s->acpiProcessorId;
            cpu.local_apic_id = s->apicId;
            cpu.enabled = (1 == (s->flags & 1));
            cpus_.push_back(cpu);
            ++cpu_count_;
        }
        break;
        case ApicType::IO_APIC: {
            ApicIoApic* s = (ApicIoApic*)p;
            io_apics_.push_back(new IoApicX64(s->ioApicId,
                (uintptr_t)s->ioApicAddress, s->globalSystemInterrupt));
        }
        break;
        case ApicType::INTERRUPT_OVERRIDE:
            break;
        default:
            // TODO: parse others
            break;
        }

        p += length;
    }
}

void AcpiX64::StartCPUs() {
    CpuTrampolineX64 trampoline;
    uint8_t startup_vec = 0x08;

    RT_ASSERT(0 == trampoline.cpus_counter_value());

    uint32_t bsp_apic_id = local_apic_->Id();
    uint16_t cpus_started = 0;
    for (const AcpiCPU& cpu : cpus_) {
        if (cpu.local_apic_id == bsp_apic_id) {
            continue;
        }
        local_apic_->SendApicInit(cpu.local_apic_id);
    }

    GLOBAL_engines()->NonIsolateSleep(50);

    for (const AcpiCPU& cpu : cpus_) {
        if (cpu.local_apic_id == bsp_apic_id) {
            continue;
        }
        local_apic_->SendApicStartup(cpu.local_apic_id, startup_vec);
        ++cpus_started;

        printf("Starting #%d...\n", cpus_started);
        while (trampoline.cpus_counter_value() != cpus_started) {
            rt::Cpu::WaitPause();
        }
    }

    printf("Cpus: done.\n");
}

void AcpiX64::InitIoApics() {
    for (IoApicX64* ioa : io_apics_) {
        ioa->Init();
    }
}

} // namespace rt
