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
#include <string>
#include <vector>
#include <cstdlib>
#include <kernel/string.h>

namespace rt {

/**
 * Represents initrd file
 */
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

/**
 * Manages initrd files storage
 */
class Initrd {
public:
    Initrd() {
        files_.reserve(20);
    }

    /**
     * Initialize using preloaded initrd data buffer
     */
    void Init(const void* buf, size_t len);

    /**
     * Use filename to get initrd file
     */
    const InitrdFile Get(const char* filename);

    /**
     * Use index to get initrd file
     */
    const InitrdFile GetByIndex(size_t index);

    /**
     * Initrd files count
     */
    size_t files_count() const { return files_.size(); }
private:
    std::vector<InitrdFile> files_;
};

} // namespace rt

