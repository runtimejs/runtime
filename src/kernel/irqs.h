// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once
#include <kernel/kernel.h>
#include <kernel/resource.h>
#include <kernel/engine.h>

#ifdef RUNTIMEJS_PLATFORM_X64
#include <kernel/x64/irqs-x64.h>
#else
#error Platform is not supported
#endif

namespace rt {

class Irqs {
public:
    Irqs() {
        irqs_arch_.SetUp();
    }
private:
    IrqsArch irqs_arch_;
    DELETE_COPY_AND_ASSIGN(Irqs);
};


} // namespace rt
