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

    /**
     * Reboot machine using keyboard controller
     */
    void Reboot();

    uint32_t cpu_count() const { return acpi_.cpus_count(); }

    uint32_t bus_frequency() const {
        RT_ASSERT(acpi_.local_apic());
        return acpi_.local_apic()->bus_frequency();
    }

    uint64_t BootTimeMicroseconds() const {
        return acpi_.BootTimeMicroseconds();
    }
private:
    AcpiX64 acpi_;
    DELETE_COPY_AND_ASSIGN(PlatformArch);
};

} // namespace rt
