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

namespace rt {

struct CpuMSRValue {
    uint32_t lo;
    uint32_t hi;
    CpuMSRValue() : lo(0), hi(0) { }
    CpuMSRValue(uint32_t lo_, uint32_t hi_) : lo(lo_), hi(hi_) { }
};

class CpuPlatform {
public:
    static CpuMSRValue GetMSR(uint32_t msr) {
        CpuMSRValue value;
        asm volatile("rdmsr" : "=a"(value.lo), "=d"(value.hi) : "c"(msr));
        return value;
    }

    static void SetMSR(uint32_t msr, CpuMSRValue value) {
        asm volatile("wrmsr" : : "a"(value.lo), "d"(value.hi), "c"(msr));
    }

    /**
     * Pause operation for busy-wait loops
     */
    static void WaitPause() {
        asm volatile("pause" : : : "memory");
    }

    /**
     * Disable interrupts and stop execution
     */
    __attribute__((__noreturn__)) static void HangSystem() {
        asm volatile ("cli");
        for (;;) WaitPause();
    }

    /**
     * Get current CPU index
     */
    static uint32_t id() {
        uint16_t gs = 0;    // gs contains cpu id
        asm volatile("movw %%gs,%0" : "=r"(gs));
        return gs;
    }

    /**
     * Clear IF flag so the interrupt can not occur
     */
    inline static void DisableInterrupts() {
        asm volatile("cli");
    }

    /**
     * Set IF flag to be able to receive interrupts
     */
    inline static void EnableInterrupts() {
        asm volatile("sti");
    }

    /**
     * Get interrupts enabled status
     */
    inline static bool IsInterruptsEnabled() {
        uint32_t eflags;
        asm volatile("pushf; pop %0" : "=r" (eflags));
        return 1 == (eflags & 0x200);
    }

    /**
     * Put current CPU into sleep until next interrupt
     */
    inline static void Halt() {
        asm volatile("hlt");
    }
};

} // namespace rt
