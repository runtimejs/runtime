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
        :	thread_(thread), recv_index_(recv_index),
            reusable_msg_(new ThreadMessage(ThreadMessage::Type::IRQ_RAISE,
            ResourceHandle<EngineThread>(), TransportData(), nullptr, recv_index_)) {
        reusable_msg_->MakeReusable();
    }

    IRQBinding(IRQBinding&& other)
        :	thread_(other.thread_),
            recv_index_(other.recv_index_),
            reusable_msg_(std::move(other.reusable_msg_)) {}

    void Raise(SystemContextIRQ irq_context) const {
        RT_ASSERT(reusable_msg_);
        RT_ASSERT(reusable_msg_->reusable());
        thread_.getUnsafe()->PushMessageIRQ(irq_context, reusable_msg_.get());
    }
private:
    ResourceHandle<EngineThread> thread_;
    size_t recv_index_;
    std::unique_ptr<ThreadMessage> reusable_msg_;
    DELETE_COPY_AND_ASSIGN(IRQBinding);
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
        NoInterrupsScope no_interrupts;
        ScopedLock lock(bindings_locker_);
        RT_ASSERT(number < kIrqCount);
        bindings_[number].push_back(std::move(IRQBinding(thread, recv_index)));
    }

    /**
     * Execute all handlers for provided IRQ number
     */
    void Raise(SystemContextIRQ irq_context, uint8_t number);
private:
    static const uint32_t kIrqCount = 225;
    std::vector<IRQBinding> bindings_[kIrqCount];
    Locker bindings_locker_;
    DELETE_COPY_AND_ASSIGN(IrqDispatcher);
};

} // namespace rt
