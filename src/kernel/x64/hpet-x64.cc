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

#include "hpet-x64.h"
#include <kernel/cpu.h>
#include <stdio.h>

namespace rt {

HpetX64::HpetX64(void* address)
    :   address_(address),
        registers_(reinterpret_cast<HPETRegisters*>(address)),
        counter_(reinterpret_cast<uint64_t*>(
            reinterpret_cast<uint8_t*>(address) + kCounterOffset)),
        frequency_(0),
        us_div_(0) {
    RT_ASSERT(registers_);

    uint32_t period = registers_->counterPeriod; // in femptoseconds (10^-15 seconds)

    // TODO: don't use HPET if this fails
    RT_ASSERT(0 != period);
    RT_ASSERT(period <= 0x05F5E100);

    if (!registers_->generalCapabilities & kCapabilitiesCounterSizeMask) {
        printf("[HPET] 32 bit counter (!)\n");
    }

    frequency_ = /* 10^15 */ 1000000000000000 / period;

    // TODO: don't use HPET if this fails
    RT_ASSERT(frequency_ >= 1000000);
    us_div_ = frequency_ / 1000000;
    RT_ASSERT(us_div_ > 0);

#if 0
    // Setup periodic profiler timer
    uint64_t interval = (100 * us_div_); /* 100 microseconds */

    auto timer_config = GetTimerConfig(0);
    uint32_t irq_bits = timer_config->config >> 32;
    uint32_t irq_number = __builtin_ctz(irq_bits);

    RT_ASSERT(0x10 == (timer_config->config & 0x10) && "HPET No periodic support");

//    timer_config->config = (irq_number << 9) | (1 << 2) | (1 << 3) | (1 << 6);
//    timer_config->comparatorValue = interval;
//    timer_config->comparatorValue = interval;
#endif

    ResetCounter();
    Cpu::WaitPause();
    registers_->generalConfiguration |= kConfigurationEnable;
    Cpu::WaitPause();
}

} // namespace rt
