// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>

namespace rt {

class Version {
public:
    static uint32_t major() {
        return 0;
    }

    static uint32_t minor() {
        return 0;
    }

    static uint32_t rev() {
        return 1;
    }

private:
    ~Version() = delete;
    DELETE_COPY_AND_ASSIGN(Version);
};

} // namespace rt
