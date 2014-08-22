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
#include <stdio.h>
#include <string>
#include <vector>
#include <kernel/x64/cpu-trampoline-x64.h>
#include <kernel/x64/ioapic-x64.h>
#include <kernel/x64/hpet-x64.h>

namespace rt {

struct AcpiHeader;
struct AcpiHeaderMADT;
struct AcpiHeaderHPET;
class LocalApicX64;

struct AcpiCPU {
    uint32_t cpu_id;
    uint32_t local_apic_id;
    bool enabled;
};

class AcpiX64 {
public:
    AcpiX64()
        :	local_apic_(nullptr),
            local_apic_address_(nullptr),
            hpet_(nullptr),
            cpu_count_(0) {
        cpus_.reserve(12);
        Init();
        RT_ASSERT(local_apic_);

        if (nullptr == hpet_) {
            printf("Unable to find HPET device.");
            abort();
        }

        RT_ASSERT(hpet_);
    }

    LocalApicX64* local_apic() const { return local_apic_; }
    void* local_apic_address() const { return local_apic_address_; }
    uint32_t cpus_count() const { return cpu_count_; }

    void InitIoApics();
    void StartCPUs();

    uint64_t BootTimeMicroseconds() const {
        return hpet_->ReadMicroseconds();
    }
private:
    LocalApicX64* local_apic_;
    void* local_apic_address_;
    HpetX64* hpet_;
    std::vector<AcpiCPU> cpus_;
    std::vector<IoApicX64*> io_apics_;
    uint32_t cpu_count_;

    void Init();
    bool ParseRSDP(void* p);
    void ParseRSDT(AcpiHeader* ptr);
    void ParseDT(AcpiHeader* ptr);
    void ParseTableAPIC(AcpiHeaderMADT* header);
    void ParseTableHPET(AcpiHeaderHPET* header);
    DELETE_COPY_AND_ASSIGN(AcpiX64);
};

} // namespace rt
