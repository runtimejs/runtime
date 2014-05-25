// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>
#include <stdio.h>
#include <string>
#include <vector>
#include <kernel/x64/cpu-trampoline-x64.h>
#include <kernel/x64/ioapic-x64.h>

namespace rt {

struct AcpiHeader;
struct AcpiHeaderMADT;
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
            cpu_count_(0) {
        cpus_.reserve(12);
        Init();
        RT_ASSERT(local_apic_);
    }

    LocalApicX64* local_apic() const { return local_apic_; }
    void* local_apic_address() const { return local_apic_address_; }
    uint32_t cpus_count() const { return cpu_count_; }

    void InitIoApics();
    void StartCPUs();
private:
    LocalApicX64* local_apic_;
    void* local_apic_address_;
    std::vector<AcpiCPU> cpus_;
    std::vector<IoApicX64*> io_apics_;
    uint32_t cpu_count_;

    void Init();
    bool ParseRSDP(void* p);
    void ParseRSDT(AcpiHeader* ptr);
    void ParseDT(AcpiHeader* ptr);
    void ParseTableAPIC(AcpiHeaderMADT* header);
    DELETE_COPY_AND_ASSIGN(AcpiX64);
};

} // namespace rt
