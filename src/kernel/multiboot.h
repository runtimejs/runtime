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
#include <kernel/utils.h>

namespace rt {

class MultibootParseResult {
public:
    MultibootParseResult(const char* cmdline)
        :	cmdline_(cmdline) { }
    const char* cmdline() const { return cmdline_; }
private:
    const char* cmdline_;
};

struct MultibootStruct {
    uint32_t flags;
    uint32_t mem_lower;
    uint32_t mem_upper;
    uint32_t boot_device;
    uint32_t cmdline;
    uint32_t module_count;
    uint32_t module_addr;
    uint32_t syms1;
    uint32_t syms2;
    uint32_t syms3;
    uint32_t reserved;
    uint32_t mmap_len;
    uint32_t mmap_addr;
    uint32_t drives_len;
    uint32_t drives_addr;
    uint32_t config_tbl;
    uint32_t bootloader_name;

} __attribute__((packed));

struct MultibootMemoryMapEntry {
    uint32_t size;
    uint64_t base_addr;
    uint64_t length;
    uint32_t type;
} __attribute__((packed));

struct MultibootModuleEntry {
    uint32_t start;
    uint32_t end;
} __attribute__((packed));

class MultibootMemoryMapEnumerator {
public:
    MultibootMemoryMapEnumerator(const Multiboot* multiboot);
    MemoryZone NextAvailableMemory();
private:
    uint32_t mmap_start_;
    uint32_t mmap_current_;
    uint32_t mmap_len_;
};

class Multiboot {
public:
    Multiboot(void* base);

    void* base_address() const {
        return _base;
    }

    MultibootMemoryMapEnumerator memory_map() const {
        return MultibootMemoryMapEnumerator(this);
    }

    ~Multiboot() = delete;
    DELETE_COPY_AND_ASSIGN(Multiboot);
private:
    void* _base;
};

} // namespace rt
