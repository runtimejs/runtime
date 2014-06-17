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

#include <runtimejs.h>
#include <string>

namespace common {

class Utils {
public:
    /**
     * @brief Align (round up) value on provided alignment boundary
     * @param value Value to align
     * @param alignment Alignment boundary
     * @return Aligned value
     */
    inline static uintptr_t Align(uintptr_t value, size_t alignment) {
        RT_ASSERT(alignment);
        if (value % alignment != 0) {
            value += alignment - value % alignment;
        }
        return value;
    }

    /**
     * @brief Align (round up) pointer address on provided alignment boundary
     * @param ptr Pointer to align
     * @param alignment Alignment boundary
     * @return Aligned pointer
     */
    template<typename T>
    inline static T* AlignPtr(T* ptr, size_t alignment) {
        return reinterpret_cast<T*>(Align(reinterpret_cast<uintptr_t>(ptr), alignment));
    }

    /**
     * @brief Check if value could be represented by EcmaScript Number type
     *        without losing precision
     * @param value Checked value
     * @return Result
     */
    inline static bool IsSafeDouble(uint64_t value) {
        return value == (value & 0x1fffffffffffff);
    }

    template<typename T>
    inline static T ReadUnaligned(const void* ptr) {
        T value;
        memcpy(&value, ptr, sizeof(T));
        return value;
    }

    template<typename T>
    static void ToString(T value, char* sp, int radix) {
        if (radix < 2 || radix > 36) {
            radix = 10;
        }
        char tmp[66];
        char* tp = tmp;
        int i;
        uint64_t v;
        int sign;

        sign = (radix == 10 && value < 0);
        if (sign) {
            v = -value;
        } else {
            v = (uint64_t)value;
        }

        while (v || tp == tmp) {
            i = v % radix;
            v /= radix;
            if (i < 10)
              *tp++ = i+'0';
            else
              *tp++ = i + 'a' - 10;
        }

        if (sign) *sp++ = '-';
        while (tp > tmp) *sp++ = *--tp;
        *sp++ = '\0';
    }

    static void* Memset16(void* dst, uint16_t val, size_t n) {
        uint16_t *dst16 = (uint16_t *)dst;
        for(;n--;) *dst16++ = val;
        return dst;
    }

private:
    Utils() { }
    DELETE_COPY_AND_ASSIGN(Utils);
};

class MemoryZone {
public:
    MemoryZone(void* ptr, size_t size)
        :	ptr_(ptr),
            size_(size) { }

    void* ptr() {
        return ptr_;
    }

    size_t size() {
        return size_;
    }

    bool empty() {
        return (nullptr == ptr_ && 0 == size_);
    }

private:
    void* ptr_;
    size_t size_;
};

template<typename T>
class Nullable {
public:
    Nullable() : value_(), empty_(true) {}
    explicit Nullable(T value) : value_(value), empty_(false) {}

    bool empty() const { return empty_; }

    T get() const {
        RT_ASSERT(!empty_);
        return value_;
    }
private:
    T value_;
    bool empty_;
};

} // namespace rt
