// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "native-thread.h"

namespace rt {

NativeThread::NativeThread(uint32_t id, String name, uint32_t stacksize,
                           void* entry, void* arg)
    :	id_(id),
        name_(name),
        status_(NativeThreadStatus::IDLE),
        state_(malloc(1024)),
        vstack_(GLOBAL_mem_manager()->virtual_allocator().AllocStack()),
        entry_(entry),
        arg_(arg) {

    RT_ASSERT(entry);
    RT_ASSERT(vstack_.top());
    RT_ASSERT(state_);
}

NativeThread::~NativeThread() {
    free(state_);
    state_ = nullptr;
    //TODO: free vstack
}

} // namespace rt
