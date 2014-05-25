// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>
#include <kernel/allocator.h>
#include <string>
#include <functional>
#include <vector>

namespace rt {

class String {
public:
    String()
        :	_size(0),
            _buf(nullptr) { }

    String(const char* source, size_t len = 0) {
        RT_ASSERT(source);
        if (0 == len) {
            len = std::strlen(source);
        }
        _buf = Alloc(len + 1);
        std::memcpy(_buf, source, len + 1);
        _buf[len] = '\0';
        _size = len;
    }

    ~String() {
        Free(_buf);
        _buf = nullptr;
        _size = 0;
    }

    String(const String& other) :
        _size(other._size),
        _buf(Alloc(other._size + 1)) {
        std::memcpy(_buf, other._buf, _size + 1);
    }

    String(String&& other) :
        _size(other._size),
        _buf(other._buf) {
        other._buf = nullptr;
        other._size = 0;
    }

    String& operator=(const String& other) {
        if (this == &other) {
            return *this;
        }
        _size = other._size;
        _buf = Alloc(other._size + 1);
        memcpy(_buf, other._buf, _size + 1);
        return *this;
    }

    String& operator=(String&& other) {
        if (this == &other) {
            return *this;
        }
        Free(_buf);
        _size = other._size;
        _buf = other._buf;
        other._size = 0;
        other._buf = nullptr;
        return *this;
    }

    const char* Data() const {
        return _buf;
    }

    size_t Length() const {
        return _size;
    }

    std::string ToStdString() const {
        return std::string(_buf, _size);
    }

    bool empty() const {
        return nullptr == _buf;
    }

    static bool IsEqual(const rt::String& lhs, const rt::String& rhs) {

        if (lhs.Length() != rhs.Length()) {
            return false;
        }

        if (0 == lhs.Length()) {
            return true;
        }

        if (lhs.empty()) {
            return true;
        }

        const char* s1 = lhs.Data();
        const char* s2 = rhs.Data();
        RT_ASSERT(s1);
        RT_ASSERT(s2);

        if (s1 == s2) {
            return true;
        }

        for (size_t i = 0; i < lhs.Length(); ++i) {
            if (s1[i] != s2[i]) {
                return false;
            }
        }

        return true;
    }


private:

    char* Alloc(size_t len) {
        return reinterpret_cast<char*>(malloc(len));
    }

    void Free(char* p) {
        if (nullptr != p) {
            free(p);
        }
    }

    size_t _size;
    char* _buf;
};

typedef std::vector<String, DefaultSTLAlloc<String>> StringsVector;

} // namespace rt

namespace std {

template<>
struct hash<rt::String> {
    size_t operator()(const rt::String& x) const {
        const char* s = x.Data();
        size_t len = x.Length();

        // djb2 hash algorithm
        // http://www.cse.yorku.ca/~oz/hash.html
        size_t hash = 5381;
        for (size_t i = 0; i < len; ++i) {
            int32_t c = s[i];
            hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
        }

        return hash;
    }
};

template<>
struct equal_to<rt::String> {
    bool operator()(const rt::String& lhs, const rt::String& rhs) const {
        return rt::String::IsEqual(lhs, rhs);
    }
};

} // namespace std
