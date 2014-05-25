// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "allocator.h"

namespace rt {

bool operator==(const DefaultEASTLAlloc& a, const DefaultEASTLAlloc& b) {
    return true;
}

bool operator!=(const DefaultEASTLAlloc& a, const DefaultEASTLAlloc& b) {
    return false;
}

} // namespace rt
