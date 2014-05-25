// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once
#include <kernel/kernel.h>
#include <kernel/x64/io-x64.h>

namespace rt {

class IrqsArch {
public:
    IrqsArch() {}
    void SetUp();
private:
    void DisableNMI();
    void EnableNMI();
    void InstallGate(uint8_t vector, uint64_t (*func)(), uint8_t type);

    static const uint64_t kIDTTableBase = 0;
    static const uint8_t kCodeSelector = 0x8;
    DELETE_COPY_AND_ASSIGN(IrqsArch);
};

} // namespace rt
