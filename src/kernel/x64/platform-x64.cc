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

#include <kernel/platform.h>
#include <kernel/kernel.h>
#include <kernel/cpu.h>
#include <kernel/x64/io-x64.h>

namespace rt {

void PlatformArch::StartCPUs() {
    acpi_.StartCPUs();
}

void PlatformArch::InitCurrentCPU() {
    if (0 == Cpu::id()) {
        acpi_.InitIoApics();
    }

    RT_ASSERT(acpi_.local_apic());
    acpi_.local_apic()->InitCpu(this);
}

void PlatformArch::AckIRQ() {
    RT_ASSERT(acpi_.local_apic());
    acpi_.local_apic()->EOI();
}

void PlatformArch::Reboot() {
    const uint8_t magic = 0x02;
    const uint16_t port = 0x64;

    uint8_t value = magic;
    while (value & magic) {
        value = IoPortsX64::InB(port);
    }

    IoPortsX64::OutB(port, 0xfe);
    Cpu::HangSystem();
}

} // namespace rt

