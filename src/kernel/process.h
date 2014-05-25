// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>
#include <kernel/allocator.h>
#include <kernel/spinlock.h>
#include <kernel/resource.h>
#include <EASTL/vector.h>
#include <kernel/engine.h>
#include <memory>

namespace rt {

class Engines;

class Process : public Resource {
    friend class ProcessManager;
public:
    v8::Local<v8::Object> NewInstance(Isolate* isolate);
    void SetThread(ResourceHandle<EngineThread> thread, uint32_t engine_index) {
        RT_ASSERT(engine_index < threads_.size());
        RT_ASSERT(threads_[engine_index].empty());
        threads_[engine_index] = thread;
    }
private:
    SharedVector<ResourceHandle<EngineThread>> threads_;

    Process();
    ~Process() {}
    DELETE_COPY_AND_ASSIGN(Process);
};

class ProcessManager : public Resource {
public:
    v8::Local<v8::Object> NewInstance(Isolate* isolate);
    ResourceHandle<Process> CreateProcess();

    ProcessManager(Engines* platform)
        :	platform_(platform) {
        plist_.reserve(64);
    }

private:
    Engines* platform_;
    SharedVector<Process*> plist_;
    Locker plist_locker_;

    DELETE_COPY_AND_ASSIGN(ProcessManager);
};

} // namespace rt
