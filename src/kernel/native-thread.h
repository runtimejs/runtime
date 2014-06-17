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

#include <string>
#include <kernel/kernel.h>
#include <kernel/mem-manager.h>
#include <kernel/string.h>

namespace rt {

enum class NativeThreadStatus {
    IDLE,
    RUNNING,
    WAITING
};

class NativeThread {
public:
    NativeThread(uint32_t id, String name, uint32_t stacksize, void* entry, void* arg);
    ~NativeThread();

    String name() const { return name_; }
    uint32_t id() const { return id_; }
    NativeThreadStatus status() const { return status_; }
    void* entry() const { return entry_; }
    void* arg() const { return arg_; }

    void SetStatus(NativeThreadStatus status) {
        status_ = status;
    }

    DELETE_COPY_AND_ASSIGN(NativeThread);
private:
    uint32_t id_;
    String name_;
    NativeThreadStatus status_;
    void* state_;
    VirtualStack vstack_;
    void* entry_;
    void* arg_;
};

class NativeThreadHandle {
public:
    NativeThreadHandle()
        :	index_(0) { }
    NativeThreadHandle(size_t index)
        :	index_(index) { }
private:
    size_t index_;
};

} // namespace rt
