// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>
#include <string>
#include <vector>
#include <cstdlib>
#include <kernel/string.h>

namespace rt {

class InitrdFile {
public:
    InitrdFile()
        :	_name("<invalid_file>"),
            _size(0),
            _data(reinterpret_cast<const uint8_t*>("")),
            _is_empty(true) { }

    InitrdFile(const char* name, size_t size, const uint8_t* data)
        :	_name(name),
            _size(size),
            _data(data),
            _is_empty(false) {
        RT_ASSERT(name);
        RT_ASSERT(data);
    }

    const char* Name() const { return _name; }
    size_t Size() const { return _size; }
    const uint8_t* Data() const { return _data; }
    bool IsEmpty() const { return _is_empty; }

    String ToString() const {
        return String(reinterpret_cast<const char*>(_data), _size);
    }

private:
    const char* _name;
    size_t _size;
    const uint8_t* _data;
    bool _is_empty;
};

class Initrd {
public:
    Initrd() {
        _files.reserve(20);
    }

    void Init(const void* buf, size_t len);
    const InitrdFile Get(const char* filename);
private:
    std::vector<InitrdFile> _files;
};

} // namespace rt

