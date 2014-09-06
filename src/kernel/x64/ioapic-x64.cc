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

#include "ioapic-x64.h"
#include <stdio.h>

namespace rt {

IoApicX64::IoApicX64(uint32_t id, uintptr_t address, uint32_t interrupt_base)
    :	id_(id),
        address_(address),
        interrupt_base_(interrupt_base),
        registers_(IoApicRegistersAccessor(address)) {}

void IoApicX64::Init() {
    RT_ASSERT(address_);
    uint32_t id_reg = (registers_.Read(IoApicRegister::ID) >> 24) & 0xF;

    if (id_reg != id_) {
        registers_.Write(IoApicRegister::ID, 0, id_ << 24);
        printf("Patch APICID = %d, was = %d\n", id_, id_reg);
    }

//    RT_ASSERT(id_reg == id_);
    uint32_t max_value = (registers_.Read(IoApicRegister::VER) >> 16) & 0xFF;
    RT_ASSERT(max_value);

    uint32_t max_interrupts = max_value + 1;

    const uint32_t kIntMasked = 1 << 16;
    const uint32_t kIntTrigger = 1 << 15;
    const uint32_t kIntActiveLow = 1 << 14;
    const uint32_t kIntDstLogical = 1 << 11;
    const uint32_t kIRQOffset = 32;

    // Enable all interrupts
    for (uint32_t i = 0; i < max_interrupts; ++i) {
        // Mask timer (timer doesn't go through IOAPIC)
        if (0 == interrupt_base_ && (0 == i)) {
            registers_.SetEntry(i, kIntMasked | (kIRQOffset + i));
            continue;
        }

        EnableIrq(kIRQOffset, i);
    }
}

} // namespace rt
