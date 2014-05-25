// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>

namespace rt {

template<typename T>
class Atomic {
public:
    Atomic()
        :	_value(0) { }

    void Set(T value) {
        __atomic_store(&_value, &value, __ATOMIC_SEQ_CST);
    }

    T AddFetch(T count) {
        return __atomic_add_fetch(&_value, count, __ATOMIC_SEQ_CST);
    }

    T SubFetch(T count) {
        return __atomic_sub_fetch(&_value, count, __ATOMIC_SEQ_CST);
    }

    T Get() const {
        T value;
        __atomic_load(&_value, &value, __ATOMIC_SEQ_CST);
        return value;
    }
private:
    volatile T _value;
};

} // namespace rt

