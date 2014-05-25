// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once
#include <kernel/kernel.h>
#include <kernel/mem-manager.h>
#include <kernel/irq-dispatcher.h>
#include <kernel/system-context.h>

#ifdef RUNTIMEJS_PLATFORM_X64
#include <kernel/x64/platform-x64.h>
#else
#error Platform is not supported
#endif

namespace rt {

/**
 * Arch-independent platform
 */
class Platform {
public:
    Platform() {}

    /**
     * Start all other available CPUs
     */
    void StartCPUs() { platform_arch_.StartCPUs(); }

    /**
     * Initialize per-cpu data
     */
    void InitCurrentCPU() { platform_arch_.InitCurrentCPU(); }

    /**
     * Returns number of available CPUs in the system
     */
    uint32_t cpu_count() const {
        uint32_t cpus_count = platform_arch_.cpu_count();
        RT_ASSERT(cpus_count > 0);
        return cpus_count;
    }

    /**
     * Returns CPU bus frequency
     */
    uint32_t bus_frequency() const {
        return platform_arch_.bus_frequency();
    }

    /**
     * Returns IRQ dispatcher for current platform
     */
    IrqDispatcher& irq_dispatcher() { return irq_dispatcher_; }

    /**
     * IRQ handler (requires IRQ context)
     */
    void HandleIRQ(SystemContextIRQ irq_context, uint8_t number) {
        irq_dispatcher_.Raise(irq_context, number);
        platform_arch_.AckIRQ();
    }

private:
    PlatformArch platform_arch_;
    IrqDispatcher irq_dispatcher_;
    DELETE_COPY_AND_ASSIGN(Platform);
};

} // namespace rt
