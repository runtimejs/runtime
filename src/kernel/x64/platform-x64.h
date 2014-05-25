// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once
#include <kernel/kernel.h>
#include <kernel/platform.h>
#include <kernel/x64/acpi-x64.h>
#include <kernel/x64/local-apic-x64.h>

namespace rt {

class PlatformArch {
public:
    PlatformArch() {
    }

    void InitCurrentCPU();
    void StartCPUs();
    void AckIRQ();

    uint32_t cpu_count() const { return acpi_.cpus_count(); }

    uint32_t bus_frequency() const {
        RT_ASSERT(acpi_.local_apic());
        return acpi_.local_apic()->bus_frequency();
    }
private:
    AcpiX64 acpi_;
    DELETE_COPY_AND_ASSIGN(PlatformArch);
};

} // namespace rt

