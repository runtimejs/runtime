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
