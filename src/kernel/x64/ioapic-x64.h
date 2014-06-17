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

namespace rt {

enum class IoApicAccessorRegister {
    IOREGSEL    = 0x00,  // Register selector
    IOWIN       = 0x10   // Register data
};

enum class IoApicRegister {
    ID          = 0x00,  // IO APIC ID
    VER         = 0x01,  // IO APIC Version / Max Redirection Entry
    ARB         = 0x02,  // APIC Arbitration ID
    REDTBL      = 0x10   // Redirection Entries
};

class IoApicRegistersAccessor {
public:
    explicit IoApicRegistersAccessor(uintptr_t address)
        :	address_(address) {
        RT_ASSERT(address);
    }

    inline uint32_t Read(IoApicRegister reg) const {
        RT_ASSERT(address_);
        *(volatile uint32_t*)(address_ +
            static_cast<uint8_t>(IoApicAccessorRegister::IOREGSEL))
                = static_cast<uint32_t>(reg);

        return *(volatile uint32_t*)(address_ +
            static_cast<uint8_t>(IoApicAccessorRegister::IOWIN));
    }

    inline void Write(IoApicRegister reg, uint8_t reg_offset, uint32_t value) const {
        RT_ASSERT(address_);
        *(volatile uint32_t*)(address_ +
            static_cast<uint8_t>(IoApicAccessorRegister::IOREGSEL))
                = static_cast<uint32_t>(reg) + reg_offset;

        *(volatile uint32_t*)(address_ +
            static_cast<uint8_t>(IoApicAccessorRegister::IOWIN)) = value;
    }

    inline void SetEntry(uint8_t index, uint64_t data) const {
        Write(IoApicRegister::REDTBL, index * 2, static_cast<uint32_t>(data));
        Write(IoApicRegister::REDTBL, index * 2 + 1, static_cast<uint32_t>(data >> 32));
    }
private:
    uintptr_t address_;
};

class IoApicX64 {
public:
    IoApicX64(uint32_t id, uintptr_t address, uint32_t interrupt_base);

    void Init();

    void EnableIrq(uint32_t first_irq_offset, uint32_t irq) {
        registers_.SetEntry(irq, first_irq_offset + irq + interrupt_base_);
    }

private:
    uint32_t id_;
    uintptr_t address_;
    uint32_t interrupt_base_;
    IoApicRegistersAccessor registers_;
    DELETE_COPY_AND_ASSIGN(IoApicX64);
};

} // namespace rt
