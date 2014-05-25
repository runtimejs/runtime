// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <vector>
#include <kernel/allocator.h>

namespace rt {

template<typename T>
using SharedSTLVector = std::vector<T, DefaultSTLAlloc<T>>;

} // namespace rt
