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

#include <runtimejs.h>

namespace eastl {
template <typename T, typename Allocator> class vector;
template <typename T, typename Allocator> class basic_string;
}

namespace rt {
class Platform;
class BootServices;
class Multiboot;
class MemManager;
class Thread;
class KeyStorage;
class ThreadManager;
class Initrd;
class Engines;
class Trace;
class Irqs;

class TraceScope {
public:
  TraceScope(const char* func, const char* file, int line);
  ~TraceScope();
private:
  DELETE_COPY_AND_ASSIGN(TraceScope);
};
}

#define EXTERNAL_ACCESSOR(TypeName, AccessorName)   \
static TypeName* AccessorName()                     \
{                                                   \
    extern TypeName* intr_##AccessorName;           \
    return intr_##AccessorName;                     \
}

EXTERNAL_ACCESSOR(rt::Platform, GLOBAL_platform)
EXTERNAL_ACCESSOR(rt::BootServices, GLOBAL_boot_services)
EXTERNAL_ACCESSOR(rt::Multiboot, GLOBAL_multiboot)
EXTERNAL_ACCESSOR(rt::MemManager, GLOBAL_mem_manager)
EXTERNAL_ACCESSOR(rt::Irqs, GLOBAL_irqs)
EXTERNAL_ACCESSOR(rt::KeyStorage, GLOBAL_keystorage)
EXTERNAL_ACCESSOR(rt::Initrd, GLOBAL_initrd)
EXTERNAL_ACCESSOR(rt::Engines, GLOBAL_engines)
EXTERNAL_ACCESSOR(rt::Trace, GLOBAL_trace)

#define RT_TRACESCOPE rt::TraceScope scope(__PRETTY_FUNCTION__, __FILE__, __LINE__)

#undef EXTERNAL_ACCESSOR
