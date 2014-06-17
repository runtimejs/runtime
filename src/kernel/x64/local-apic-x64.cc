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

namespace rt {

LocalApicX64::LocalApicX64(void* local_apic_address)
    :	local_apic_address_(local_apic_address),
        registers_(local_apic_address),
        bus_freq_(0) {
    RT_ASSERT(local_apic_address);
}

void LocalApicX64::InitCpu() {
    GLOBAL_mem_manager()->address_space().MapPage(
        local_apic_address_,
        local_apic_address_, true, true);

    // Clear task priority to enable all interrupts
    registers_.Write(LocalApicRegister::TASK_PRIORITY, 0);

    // Set masks
    registers_.Write(LocalApicRegister::LINT0, 1 << 16);
    registers_.Write(LocalApicRegister::LINT1, 1 << 16);
    registers_.Write(LocalApicRegister::TIMER, 1 << 16);

    // Perf
    registers_.Write(LocalApicRegister::PERF, 4 << 8);

    // Flat mode
    registers_.Write(LocalApicRegister::DESTINATION_FORMAT, 0xF0000000);

    // Logical Destination Mode, all cpus use logical id 1
    registers_.Write(LocalApicRegister::LOGICAL_DESTINATION, 1);

    // Configure Spurious Interrupt Vector Register
    registers_.Write(LocalApicRegister::SPURIOUS_INTERRUPT_VECTOR, 0x100 | 0xff);

    if (0 == bus_freq_) {
        // Ensure we do this once on CPU 0
        RT_ASSERT(0 == Cpu::id());

        // Calibrate times
        registers_.Write(LocalApicRegister::TIMER, 32);
        registers_.Write(LocalApicRegister::TIMER_DIVIDE_CONFIG, 0x03);

        // Initialize PIT channel 2 in one-shot mode to wait 1/100 sec
        IoPortsX64::OutB(0x61, (IoPortsX64::InB(0x61) & 0xFD) | 1);
        IoPortsX64::OutB(0x43, 0xB2);

        // 1193180/100 Hz = 11931 = 2e9bh
        IoPortsX64::OutB(0x42, 0x9B);					// LSB
        IoPortsX64::InB(0x60);							// Short delay
        IoPortsX64::OutB(0x42, 0x2E);					// MSB

        // Reset PIT one-shot counter (start counting)
        uint32_t tmp = (uint8_t)(IoPortsX64::InB(0x61) & 0xFE);
        IoPortsX64::OutB(0x61, (uint8_t)tmp);           //gate low
        IoPortsX64::OutB(0x61, (uint8_t)tmp | 1);		//gate high

        // Reset APIC timer (set counter to -1)
        registers_.Write(LocalApicRegister::TIMER_INITIAL_COUNT, 0xFFFFFFFF);

        // Wait until PIT counter reaches zero
        while(!(IoPortsX64::InB(0x61) & 0x20));

        // Stop Apic timer
        registers_.Write(LocalApicRegister::TIMER, 1 << 16);

        // Calculate bus frequency
        uint32_t curr_count = registers_.Read(LocalApicRegister::TIMER_CURRENT_COUNT);
        uint32_t cpubusfreq = ((0xFFFFFFFF - curr_count) + 1) * 16 * 100;
        bus_freq_ = cpubusfreq;
    }

    RT_ASSERT(bus_freq_);
    uint32_t quantum = 100;
    uint32_t val = bus_freq_ / quantum / 16;

    // Set periodic mode for APIC timer
    registers_.Write(LocalApicRegister::TIMER_INITIAL_COUNT, val < 16 ? 16 : val);
    registers_.Write(LocalApicRegister::TIMER, 32 | 0x20000);
    registers_.Write(LocalApicRegister::TIMER_DIVIDE_CONFIG, 0x03);
}

} // namespace rt
