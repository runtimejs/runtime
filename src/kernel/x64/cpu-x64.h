// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
        asm volatile("rep;nop" : : : "memory");
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
        uint16_t gs = 0;    // gs containts cpu id
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
};

} // namespace rt
