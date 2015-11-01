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
