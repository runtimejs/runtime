// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <runtimejs.h>

class CRC64 {
public:
    static uint64_t Compute(uint64_t crc, const unsigned char* s, uint64_t l);
};
