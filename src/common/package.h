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

#include <vector>
#include <string.h>
#include <runtimejs.h>
#include <common/utils.h>

namespace package {

enum class PackageFileType {
    EMPTY = 0x00,
    DEFAULT = 0xAA
};

class PackageFileData {
public:
    PackageFileData(std::string name, std::vector<uint8_t> buf)
        :	name_(name),
            buf_(buf) {}
    const char* name() const { return name_.c_str(); }
    const uint8_t* buf() const { return &buf_[0]; }
    size_t len() const { return buf_.size(); }
private:
    std::string name_;
    std::vector<uint8_t> buf_;
};

class PackageWriter {
public:
    void AddFileData(PackageFileData data) {
        files_.push_back(std::move(data));
    }
    void Write();
    virtual void WriteData(const void* data, size_t len) = 0;
private:
    void WriteString(const char* str);
    void WriteBuf(const uint8_t* buf, size_t len);
    void WriteUint64(uint64_t value);
    void WriteUint32(uint32_t value);
    std::vector<PackageFileData> files_;
};

class PackageFile {
public:
    PackageFile()
        :	name_(nullptr),
            buf_(nullptr),
            len_(0),
            crc64_(0) { }

    PackageFile(const char* name, const uint8_t* buf,
                size_t len, uint64_t crc64)
        :	name_(name),
            buf_(buf),
            len_(len),
            crc64_(crc64) { }

    const char* name() const { return name_; }
    const uint8_t* buf() const { return buf_; }
    size_t len() const { return len_; }
    uint64_t crc64() const { return crc64_; }
    bool empty() const { return nullptr == buf_; }
private:
    const char* name_;
    const uint8_t* buf_;
    size_t len_;
    uint64_t crc64_;
};

class PackageReader {
public:
    PackageReader(const void* start, size_t len);
    PackageFile Next();
    PackageFile Finish();
private:
    const uint8_t* next_;
    size_t files_left_;
};

} // namespace package
