// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>
#include <kernel/engines.h>
#include <kernel/local-storage.h>

namespace rt {

/**
 * Implements thread local storage for v8 engine
 */
class KeyStorage {
public:
    KeyStorage()
        :	next_index_(1) { }

    uint64_t NewKey() {
        return next_index_++;
    }

    inline void DeleteKey(uint64_t index) {
        RT_ASSERT(index > 0);
        Set(index, nullptr);
    }

    inline void Set(uint64_t index, void* value) {
        RT_ASSERT(index > 0);
        if (!GLOBAL_engines()) {
            no_platform_storage_.Set(index - 1, value);
            return;
        }

        GLOBAL_engines()->cpu_engine()->ThreadLocalSet(index - 1, value);
    }

    inline void* Get(uint64_t index) {
        RT_ASSERT(index > 0);
        if (!GLOBAL_engines()) {
            return no_platform_storage_.Get(index - 1);
        }

        return GLOBAL_engines()->cpu_engine()->ThreadLocalGet(index - 1);
    }
private:
    uint64_t next_index_;
    LocalStorage no_platform_storage_;
    DELETE_COPY_AND_ASSIGN(KeyStorage);
};

} // namespace rt
