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

#include "cpu-trampoline-x64.h"
#include <string>

// located at 64 bit code location
extern "C" uint8_t _ap_startup_location;

// located at 16 bit start and finish of code
extern "C" uint8_t _ap_startup_start;
extern "C" uint8_t _ap_startup_finish;

// other
extern "C" volatile uint16_t _cpus_counter;

namespace rt {

CpuTrampolineX64::CpuTrampolineX64() {
    RT_ASSERT(reinterpret_cast<uintptr_t>(&_ap_startup_finish)
              > reinterpret_cast<uintptr_t>(&_ap_startup_start));

    const void* ap_startup_loc = &_ap_startup_location;
    uint16_t ap_startup_len = reinterpret_cast<uintptr_t>(&_ap_startup_finish)
            - reinterpret_cast<uintptr_t>(&_ap_startup_start);
    RT_ASSERT(ap_startup_loc);
    RT_ASSERT(ap_startup_len);

    memcpy((void*)kLoadAddress, ap_startup_loc, ap_startup_len);

    printf("AP loader embedded at 0x%x, len = %d\n", ap_startup_loc, ap_startup_len);
}

uint16_t CpuTrampolineX64::cpus_counter_value() {
    return _cpus_counter;
}

} // namespace rt
