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

#include "irq-dispatcher.h"
#include <kernel/platform.h>

namespace rt {

void IrqDispatcher::Raise(SystemContextIRQ irq_context, uint8_t number) {
  RT_ASSERT(0 == Cpu::id()); // IRQ raise restricted to CPU0
  RT_ASSERT(number < kIrqCount);

  {
    ScopedLock<threadlib::spinlock_t> lock(bindings_locker_);
    for (const IRQBinding& binding : bindings_[number]) {
      binding.Raise(irq_context);
    }
  }
}

} // namespace rt
