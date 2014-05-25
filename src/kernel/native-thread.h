// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
