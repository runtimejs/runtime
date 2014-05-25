// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
