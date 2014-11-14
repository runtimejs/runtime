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

struct HPETRegisters {
    uint32_t generalCapabilities;
    uint32_t counterPeriod;
    uint64_t reserved0;
    uint64_t generalConfiguration;
    uint64_t reserved1;
    uint64_t generalInterruptStatus;
} __attribute__((packed));

struct HPETTimerConfig {
    uint64_t config;
    uint64_t comparatorValue;
    uint64_t interruptRoute;
    uint64_t reserved0;
};

class HpetX64 {
public:
    /**
     * Create HPET instance using registers base address
     */
    HpetX64(void* address);

    /**
     * Read counter value converted to microseconds
     */
    uint64_t ReadMicroseconds() const {
        return ReadCounter() / us_div_;
    }

    /**
     * Read raw counter value
     */
    uint64_t ReadCounter() const {
        return *counter_;
    }

    /**
     * Reset counter (must be disabled)
     */
    void ResetCounter() {
        *counter_ = 0;
    }

    HPETTimerConfig* GetTimerConfig(uint8_t timer_index) {
        return reinterpret_cast<HPETTimerConfig*>(reinterpret_cast<uint8_t*>(address_) +
            kTimerConfigsOffset + sizeof(HPETTimerConfig) * timer_index);
    }
private:
    static const int kCapabilitiesCounterSizeMask = (1 << 13);
    static const int kConfigurationEnable = (1 << 0);
    static const int kCounterOffset = 0x0f0;
    static const int kTimerConfigsOffset = 0x100;
    void* address_;
    HPETRegisters* registers_;
    volatile uint64_t* counter_;
    uint64_t frequency_;
    uint64_t us_div_;
};

} // namespace rt
