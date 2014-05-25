// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>
#include <kernel/mem-manager.h>

namespace rt {

class KernelMain {
public:
    KernelMain(void* mbt);
    void InitSystemBSP(void* mbt);
    void InitSystemAP();
    void Initialize(void* mbt);
    MultibootParseResult ParseMultiboot(void* mbt);
    void ParseMemoryMap();
    void MakeV8Snapshot();
};

} // namespace rt
