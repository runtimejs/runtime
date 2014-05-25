// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <kernel/kernel-main.h>
#include <kernel/cpu.h>

void main(void* mbt) {
    rt::KernelMain kernel_core(mbt);
    rt::Cpu::HangSystem();
}
