// Copyright 2014 runtime.js project authors
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

#include <assert.h>
#include <stddef.h>
#include <stdint.h>

#define RT_ASSERT(x) assert(x)

#define DELETE_COPY_AND_ASSIGN(TypeName)           \
    TypeName(const TypeName&) = delete;            \
    TypeName& operator=(const TypeName&) = delete

//#define RUNTIME_PROFILER
//#define RUNTIME_TRACK_STATE
//#define RUNTIME_ALLOCATOR_CALLBACKS

/**
 * Module that can track allocated pointers to make sure
 * they're getting freed. When enabled it uses hashtable to
 * store pointers and tracks all free() calls to malloc subsystem.
 * Pointers to track need to be added manually.
 *
 * USAGE:
 *
 * Add pointer to track:
 * GLOBAL_mem_manager()->malloc_allocator().allocation_tracker()->RegisterAlloc(ptr);
 *
 * Get number of unfreed tracked pointers:
 * GLOBAL_mem_manager()->malloc_allocator().allocation_tracker()->unfreed_allocations_count();
 */
//#define RUNTIME_ALLOCATION_TRACKER
