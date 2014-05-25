// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <vector>
#include <kernel/kernel.h>
#include <kernel/system-context.h>
#include <kernel/spinlock.h>
#include <kernel/engine.h>

namespace rt {

/**
 * Dispatcher internal binding element
 */
class IRQBinding {
public:
    IRQBinding(ResourceHandle<EngineThread> thread, size_t recv_index)
        :	thread_(thread), recv_index_(recv_index) {}

    void Raise(SystemContextIRQ irq_context) const {
        std::unique_ptr<ThreadMessage> msg(new ThreadMessage(ThreadMessage::Type::IRQ_RAISE,
            ResourceHandle<EngineThread>(), TransportData(), nullptr, recv_index_));
        thread_.get()->PushMessage(std::move(msg));
    }
private:
    ResourceHandle<EngineThread> thread_;
    size_t recv_index_;
};

/**
 * Dispatches IRQ messages to engine threads
 */
class IrqDispatcher {
public:
    IrqDispatcher() {}

    /**
     * Bind new handler for provided IRQ number
     */
    void Bind(uint8_t number, ResourceHandle<EngineThread> thread, size_t recv_index) {
        RT_ASSERT(Cpu::id() > 0); // IRQ binding restricted to CPU > 0
        ScopedLock lock(locker_);
        RT_ASSERT(number < kIrqCount);
        bindings_[number].push_back(IRQBinding(thread, recv_index));
    }

    /**
     * Execute all handlers for provided IRQ number
     */
    void Raise(SystemContextIRQ irq_context, uint8_t number);
private:
    static const uint32_t kIrqCount = 225;
    SharedSTLVector<IRQBinding> bindings_[kIrqCount];
    Locker locker_;
    DELETE_COPY_AND_ASSIGN(IrqDispatcher);
};

} // namespace rt
