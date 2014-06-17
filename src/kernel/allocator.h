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
#include <limits>

namespace rt {

/**
 * Default allocator for EASTL containers.
 */
class DefaultEASTLAlloc {
public:
    explicit inline DefaultEASTLAlloc(const char* name = "DefaultEASTLAlloc") { }
    inline DefaultEASTLAlloc(const DefaultEASTLAlloc& alloc) { }
    inline DefaultEASTLAlloc(const DefaultEASTLAlloc&, const char* name) { }
    inline DefaultEASTLAlloc& operator=(const DefaultEASTLAlloc& alloc) { return *this; }

    inline void* allocate(size_t n, int flags = 0) {
        return malloc(n);
    }

    inline void* allocate(size_t n, size_t alignment, size_t offset, int flags = 0) {
        return memalign(alignment, n);
    }

    inline void deallocate(void* p, size_t n) {
        free(p);
    }

    inline const char* get_name() const { return "DefaultEASTLAlloc"; }
    inline void set_name(const char* name) { }
};

bool operator==(const DefaultEASTLAlloc& a, const DefaultEASTLAlloc& b);
bool operator!=(const DefaultEASTLAlloc& a, const DefaultEASTLAlloc& b);

/**
 * Default allocator for STL containers.
 */
template <class T>
struct DefaultSTLAlloc {
    typedef size_t size_type;
    typedef ptrdiff_t difference_type;
    typedef T* pointer;
    typedef const T* const_pointer;
    typedef T& reference;
    typedef const T& const_reference;
    typedef T value_type;

    template <class U> struct rebind {
        typedef DefaultSTLAlloc<U> other;
    };

    DefaultSTLAlloc() {}
    DefaultSTLAlloc(const DefaultSTLAlloc&) {}
    ~DefaultSTLAlloc() {}

    template <class U> DefaultSTLAlloc(const DefaultSTLAlloc<U>&) {}

    pointer address(reference x) const { return &x; }
    const_pointer address(const_reference x) const { return &x; }

    pointer allocate(size_type s, void const* = 0) {
        if (0 == s) {
            return nullptr;
        }
        return reinterpret_cast<T*>(malloc(s * sizeof(T)));
    }

    void deallocate(pointer p, size_type) {
        return free(p);
    }

    size_type max_size() const {
        return std::numeric_limits<size_t>::max() / sizeof(T);
    }

    void construct(pointer p, const T& val) {
        new((void*)p) T(val);
    }

    template <class _Up, class... _Args>
    void construct(_Up* __p, _Args&&... __args) {
        ::new((void*)__p) _Up(std::forward<_Args>(__args)...);
    }

    void destroy(pointer p) {
        p->~T();
    }
};

} // namespace rt
