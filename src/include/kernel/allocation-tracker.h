// Copyright 2015 runtime.js project authors
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
#include <unordered_map>

namespace rt {

/**
 * Hashtable to store and track allocated pointers.
 * Enable in runtimejs.h
 */
class AllocationTracker {
public:
#ifdef RUNTIME_ALLOCATION_TRACKER
  AllocationTracker() : nested_(false) {}

  /**
   * Add allocated pointer into hashtable
   */
  void RegisterAlloc(void* ptr) {
    if (nested_) {
      return;
    }

    nested_ = true;
    map_[ptr] = true;
    nested_ = false;
  }

  /**
   * Remove pointer from hashtable, gets called
   * automatically on every free()
   */
  void UnregisterAlloc(void* ptr) {
    if (nested_) {
      return;
    }

    nested_ = true;
    auto search = map_.find(ptr);
    if (search != map_.end()) {
      map_.erase(search);
    }
    nested_ = false;
  }

  /**
   * Get total number of unfreed tracked pointers
   */
  size_t unfreed_allocations_count() {
    nested_ = true;
    size_t result =  map_.size();
    nested_ = false;
    return result;
  }
private:
  bool nested_;
  std::unordered_map<void*, bool> map_;
#endif // RUNTIME_ALLOCATION_TRACKER
};

} // namespace rt
