// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>
#include <EASTL/fixed_vector.h>
#include <kernel/allocator.h>

namespace rt {

/**
 * Thread local data container. Supports max 16 slots.
 */
class LocalStorage
{
public:
    LocalStorage()
        :	next_index_(1) {
        storage_.resize(kMaxSlots, nullptr);
    }

    inline void* Get(uint64_t keyid) {
        RT_ASSERT(keyid < kMaxSlots);
        return storage_[keyid];
    }

    inline void Set(uint64_t keyid, void* value) {
        RT_ASSERT(keyid < kMaxSlots);
        storage_[keyid] = value;
    }

    DELETE_COPY_AND_ASSIGN(LocalStorage);
private:
    static const size_t kMaxSlots = 16;
    eastl::fixed_vector<void*, kMaxSlots, false> storage_;
    uint64_t next_index_;
};


} // namespace rt
