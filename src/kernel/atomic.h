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

