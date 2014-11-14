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

#include "local-apic-x64.h"
#include <kernel/kernel.h>
#include <kernel/engines.h>
#include <kernel/mem-manager.h>
#include <kernel/system-context.h>
#include <kernel/x64/io-x64.h>
#include <kernel/x64/platform-x64.h>

namespace rt {

LocalApicX64::LocalApicX64(void* local_apic_address)
    :	local_apic_address_(local_apic_address),
        registers_(local_apic_address),
        bus_freq_(0) {
    RT_ASSERT(local_apic_address);
}

void LocalApicX64::CpuSetAPICBase(uintptr_t apic) {
    uint32_t edx = (apic >> 32) & 0x0f;
    uint32_t eax = (apic & 0xfffff100) | kApicBaseMSREnable;

    CpuMSRValue value(eax, edx);
    CpuPlatform::SetMSR(kApicBaseMSR, value);
}

uintptr_t LocalApicX64::CpuGetAPICBase() {
    auto value = CpuPlatform::GetMSR(kApicBaseMSR);
    return (value.lo & 0xfffff100) | ((uintptr_t)(value.hi & 0x0f) << 32);
}

void LocalApicX64::InitCpu(PlatformArch* platform) {
    RT_ASSERT(platform);

    GLOBAL_mem_manager()->address_space().MapPage(
        local_apic_address_,
        local_apic_address_, true, true);

    CpuSetAPICBase(CpuGetAPICBase());

    // Clear task priority to enable all interrupts
    registers_.Write(LocalApicRegister::TASK_PRIORITY, 0);

    // Set masks
    registers_.Write(LocalApicRegister::LINT0, 1 << 16);
    registers_.Write(LocalApicRegister::LINT1, 1 << 16);
    registers_.Write(LocalApicRegister::TIMER, 1 << 16);

    // Perf
    registers_.Write(LocalApicRegister::PERF, 4 << 8);

    // Flat mode
    registers_.Write(LocalApicRegister::DESTINATION_FORMAT, 0xffffffff);

    // Logical Destination Mode, all cpus use logical id 1
    registers_.Write(LocalApicRegister::LOGICAL_DESTINATION, 1);

    // Configure Spurious Interrupt Vector Register
    registers_.Write(LocalApicRegister::SPURIOUS_INTERRUPT_VECTOR, 0x100 | 0xff);

    uint8_t timer_vector = 32;

    if (0 == bus_freq_) {
        // Ensure we do this once on CPU 0
        RT_ASSERT(0 == Cpu::id());

        // Calibrate times
        registers_.Write(LocalApicRegister::TIMER, timer_vector);
        registers_.Write(LocalApicRegister::TIMER_DIVIDE_CONFIG, 0x03);

        uint64_t start = platform->BootTimeMicroseconds();

        // Reset APIC timer (set counter to -1)
        registers_.Write(LocalApicRegister::TIMER_INITIAL_COUNT, 0xffffffffU);

        // 1/100 of a second
        while (platform->BootTimeMicroseconds() - start < 10000) {
            Cpu::WaitPause();
        }

        // Stop Apic timer
        registers_.Write(LocalApicRegister::TIMER, 1 << 16);

        // Calculate bus frequency
        uint32_t curr_count = registers_.Read(LocalApicRegister::TIMER_CURRENT_COUNT);
        uint32_t cpubusfreq = ((0xFFFFFFFF - curr_count) + 1) * 16 * 100;
        bus_freq_ = cpubusfreq;
    }

    RT_ASSERT(bus_freq_);
    uint32_t quantum = 32;
#ifdef RUNTIME_PROFILER
    quantum = 4096 * 4;
#endif
    uint32_t init_count = bus_freq_ / quantum / 16;

    // Set minimum initial count value to avoid QEMU
    // "I/O thread has spun for 1000 iterations" warning
    if (init_count < 0x1000) {
        init_count = 0x1000;
    }

    // Set periodic mode for APIC timer
    registers_.Write(LocalApicRegister::TIMER_INITIAL_COUNT, init_count);
    registers_.Write(LocalApicRegister::TIMER, timer_vector | 0x20000);
    registers_.Write(LocalApicRegister::TIMER_DIVIDE_CONFIG, 0x03);

    registers_.Read(LocalApicRegister::SPURIOUS_INTERRUPT_VECTOR);

    EOI();
}

} // namespace rt
