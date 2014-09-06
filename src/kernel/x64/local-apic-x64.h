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
#include <kernel/cpu.h>
#include <stdio.h>
#include <stdlib.h>
#include <kernel/kernel.h>
#include <kernel/spinlock.h>

namespace rt {

class PlatformArch;

/**
 * List of available local apic registers
 */
enum class LocalApicRegister {
    ID                              = 0x0020,  // Local APIC ID
    VERSION                         = 0x0030,  // Local APIC Version
    TASK_PRIORITY                   = 0x0080,  // Task Priority
    ARBITRATION_PRIORITY            = 0x0090,  // Arbitration Priority
    PROCESSOR_PRIORITY              = 0x00a0,  // Processor Priority
    EOI                             = 0x00b0,  // EOI
    RRD                             = 0x00c0,  // Remote Read
    LOGICAL_DESTINATION             = 0x00d0,  // Logical Destination
    DESTINATION_FORMAT              = 0x00e0,  // Destination Format
    SPURIOUS_INTERRUPT_VECTOR       = 0x00f0,  // Spurious Interrupt Vector
    ISR                             = 0x0100,  // In-Service (8 registers)
    TMR                             = 0x0180,  // Trigger Mode (8 registers)
    IRR                             = 0x0200,  // Interrupt Request (8 registers)
    ERROR_STATUS                    = 0x0280,  // Error Status
    INTERRUPT_COMMAND_LO            = 0x0300,  // Interrupt Command (writing here sends command)
    INTERRUPT_COMMAND_HI            = 0x0310,  // Interrupt Command [63:32]
    TIMER                           = 0x0320,  // LVT Timer
    THERMAL                         = 0x0330,  // LVT Thermal Sensor
    PERF                            = 0x0340,  // LVT Performance Counter
    LINT0                           = 0x0350,  // LVT LINT0
    LINT1                           = 0x0360,  // LVT LINT1
    ERROR                           = 0x0370,  // LVT Error
    TIMER_INITIAL_COUNT             = 0x0380,  // Initial Count (for Timer)
    TIMER_CURRENT_COUNT             = 0x0390,  // Current Count (for Timer)
    TIMER_DIVIDE_CONFIG             = 0x03e0   // Divide Configuration (for Timer)
};

/**
 * Local apic command object
 */
class LocalApicInterruptCommand {
    friend class LocalApicRegisterAccessor;
public:
    enum class DeliveryMode {
        FIXED = 0,
        LOWEST_PRIORITY = 1,
        SMI = 2,
        NMI = 4,
        INIT = 5,
        STARTUP = 6
    };

    enum class DestinationMode {
        PHYSICAL = 0,
        LOGICAL = 1
    };

    enum class DeliveryStatus {
        IDLE = 0,
        PENDING = 1
    };

    enum class DestinationShorthand {
        NONE = 0,
        SELF = 1,
        ALL = 2,
        ALL_EXCEPT_SELF = 3
    };

    LocalApicInterruptCommand(uint8_t vector_num,
                              DeliveryMode dmode,
                              DestinationMode destmode,
                              bool is_no_deassert,
                              bool trigger_mode,
                              DestinationShorthand dshort,
                              uint8_t dest) :
        hi_(dest << 24),
        lo_(vector_num |
            (static_cast<uint32_t>(dmode) << 8) |
            (static_cast<uint32_t>(destmode) << 11) |
            (static_cast<uint32_t>(is_no_deassert) << 14) |
            (static_cast<uint32_t>(trigger_mode) << 15) |
            (static_cast<uint32_t>(dshort) << 18)) {}
private:
    uint32_t hi_;
    uint32_t lo_;
};

/**
 * Provides access to local apic registers
 */
class LocalApicRegisterAccessor {
public:
    LocalApicRegisterAccessor(void* local_apic_base) :
        local_apic_base_(static_cast<uint8_t*>(local_apic_base)) {
        RT_ASSERT(local_apic_base);
    }

    inline uint32_t Read(LocalApicRegister reg) {
        return *(volatile uint32_t*)(local_apic_base_ + static_cast<uint32_t>(reg));
    }

    inline void Write(LocalApicRegister reg, uint32_t value) {
        *(volatile uint32_t*)(local_apic_base_ + static_cast<uint32_t>(reg)) = value;
    }

    inline void InterruptCommand(LocalApicInterruptCommand command) {
        Write(LocalApicRegister::INTERRUPT_COMMAND_HI, command.hi_);
        Write(LocalApicRegister::INTERRUPT_COMMAND_LO, command.lo_);
    }

private:
    uint8_t* local_apic_base_;
};

class LocalApicX64 {
public:
    LocalApicX64(void* local_apic_address);

    /**
     * Send INIT command
     */
    void SendApicInit(uint8_t apicid) {
        registers_.InterruptCommand(LocalApicInterruptCommand(
            0,
            LocalApicInterruptCommand::DeliveryMode::INIT,
            LocalApicInterruptCommand::DestinationMode::PHYSICAL,
            true,
            false,
            LocalApicInterruptCommand::DestinationShorthand::NONE,
            apicid
        ));
    }

    /**
     * Send STARTUP command
     */
    void SendApicStartup(uint8_t apicid, uint8_t vector_num) {
        registers_.InterruptCommand(LocalApicInterruptCommand(
            vector_num,
            LocalApicInterruptCommand::DeliveryMode::STARTUP,
            LocalApicInterruptCommand::DestinationMode::PHYSICAL,
            true,
            false,
            LocalApicInterruptCommand::DestinationShorthand::NONE,
            apicid
        ));
    }

    /**
     * Set EOI (End Of Interrupt) flag. Interrupt handler must
     * do it before IRETQ
     */
    void EOI() {
        registers_.Write(LocalApicRegister::EOI, 0);
    }

    /**
     * Read Local Apic ID
     */
    uint32_t Id() {
        return registers_.Read(LocalApicRegister::ID);
    }

    uint32_t bus_frequency() const { return bus_freq_; }

    void CpuSetAPICBase(uintptr_t apic);
    uintptr_t CpuGetAPICBase();

    void InitCpu(PlatformArch* platform);
private:
    static const int kApicBaseMSR = 0x1b;
    static const int kApicBaseMSREnable = 0x800;

    void* local_apic_address_;
    LocalApicRegisterAccessor registers_;
    uint32_t bus_freq_;
    ~LocalApicX64() = delete;
    DELETE_COPY_AND_ASSIGN(LocalApicX64);
};

} // namespace rt
