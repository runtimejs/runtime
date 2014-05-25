// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <assert.h>
#include <stddef.h>
#include <stdint.h>

#define RT_ASSERT(x) assert(x)

#define DELETE_COPY_AND_ASSIGN(TypeName)           \
    TypeName(const TypeName&) = delete;            \
    TypeName& operator=(const TypeName&) = delete
