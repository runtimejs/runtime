// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "irq-dispatcher.h"

namespace rt {

void IrqDispatcher::Raise(SystemContextIRQ irq_context, uint8_t number) {
    RT_ASSERT(0 == Cpu::id()); // IRQ raise restricted to CPU0
    RT_ASSERT(number < kIrqCount);

    {   ScopedLock lock(locker_);
        for (const IRQBinding& binding : bindings_[number]) {
            binding.Raise(irq_context);
        }
    }
}

} // namespace rt
