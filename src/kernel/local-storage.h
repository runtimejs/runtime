// Copyright 2014 Runtime.JS project authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#pragma once

#include <kernel/kernel.h>
#include <kernel/allocator.h>
#include <array>

namespace rt {

/**
 * Thread local data container. Supports max 16 slots.
 */
class LocalStorage
{
public:
    LocalStorage()
        :	next_index_(1) {
        for (uint32_t i = 0; i < kMaxSlots; ++i) {
            storage_[i] = nullptr;
        }
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
    std::array<void*, kMaxSlots> storage_;
    uint64_t next_index_;
};


} // namespace rt
