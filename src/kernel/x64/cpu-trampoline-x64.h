// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>

namespace rt {

class CpuTrampolineX64 {
public:
    CpuTrampolineX64();
    inline uintptr_t address() {
        return kLoadAddress;
    }
    uint16_t cpus_counter_value();
private:
    const uintptr_t kLoadAddress = 0x8000;
    DELETE_COPY_AND_ASSIGN(CpuTrampolineX64);
};

} // namespace rt
