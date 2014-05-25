// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>
#include <kernel/cpu.h>

namespace rt {

class SystemContext {};

class SystemContextIRQ : public SystemContext {
protected:
    SystemContextIRQ() {}
};

class SystemContextDefaultIRQ : public SystemContextIRQ {
public:
    SystemContextDefaultIRQ() {
        // default IRQs allowed only on CPU0
        RT_ASSERT(0 == Cpu::id());
    }
};

class SystemContextTimerIRQ : public SystemContextIRQ {};


} // namespace rt


