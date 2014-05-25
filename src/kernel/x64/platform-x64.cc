// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <kernel/platform.h>
#include <kernel/kernel.h>
#include <kernel/cpu.h>

namespace rt {

void PlatformArch::StartCPUs() {
    acpi_.StartCPUs();
}

void PlatformArch::InitCurrentCPU() {
    if (0 == Cpu::id()) {
        acpi_.InitIoApics();
    }

    RT_ASSERT(acpi_.local_apic());
    acpi_.local_apic()->InitCpu();
}

void PlatformArch::AckIRQ() {
    RT_ASSERT(acpi_.local_apic());
    acpi_.local_apic()->EOI();
}

} // namespace rt

