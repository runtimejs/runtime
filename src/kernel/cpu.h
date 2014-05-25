// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#ifdef RUNTIMEJS_PLATFORM_X64
#include <kernel/x64/cpu-x64.h>
#else
#error Platform is not supported
#endif

namespace rt {

class Cpu {
public:
    /**
     * Pause operation for busy-wait loops
     */
    static void WaitPause() {
        CpuPlatform::WaitPause();
    }

    /**
     * Disable interrupts and stop execution
     */
    __attribute__((__noreturn__)) static void HangSystem() {
        CpuPlatform::HangSystem();
    }

    /**
     * Get current CPU index
     */
    static uint32_t id() {
        return CpuPlatform::id();
    }

    /**
     * Enable interrupts on current CPU
     */
    static void EnableInterrupts() {
        CpuPlatform::EnableInterrupts();
    }

    /**
     * Disable interrupts on current CPU
     */
    static void DisableInterrupts() {
        CpuPlatform::DisableInterrupts();
    }
};

} // namespace rt
