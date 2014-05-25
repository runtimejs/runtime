// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

void* __dso_handle = 0;

extern "C" int __cxa_atexit(void (*f)(void*), void* objptr, void* dso) {
    return 0;
}

extern "C" void __cxa_pure_virtual() {
    // Do nothing.
}

namespace __cxxabiv1 {
    __extension__ typedef int __guard __attribute__((mode(__DI__)));

    extern "C" int __cxa_guard_acquire (__guard *);
    extern "C" void __cxa_guard_release (__guard *);
    extern "C" void __cxa_guard_abort (__guard *);
    extern "C" int __cxa_guard_acquire (__guard *g) {
        return !*(char *)(g);
    }
    extern "C" void __cxa_guard_release (__guard *g) {
        *(char *)g = 1;
    }
    extern "C" void __cxa_guard_abort (__guard *) {

    }
}
