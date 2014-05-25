// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>

namespace common {

class Constants
{
public:
    static const uint64_t GiB = 1024 * 1024 * 1024;
    static const uint64_t MiB = 1024 * 1024;
    static const uint64_t KiB = 1024;
private:
    Constants() { }
    DELETE_COPY_AND_ASSIGN(Constants);
};

} // namespace rt
