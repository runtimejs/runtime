// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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

    class DefaultEASTLAlloc;

    template<typename T>
    using SharedVector = eastl::vector<T, DefaultEASTLAlloc>;

    using SharedString = eastl::basic_string<char, DefaultEASTLAlloc>;

    class TraceScope
    {
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
