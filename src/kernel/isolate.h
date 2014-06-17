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
#include <string>

#include <kernel/kernel.h>
#include <v8.h>
#include <kernel/initrd.h>
#include <kernel/local-storage.h>
#include <kernel/spinlock.h>
#include <kernel/timeouts.h>
#include <kernel/allocator.h>
#include <kernel/resource.h>
#include <kernel/atomic.h>

namespace rt {

class ThreadManager;
class TemplateCache;
class Interface;
class Engine;
class EngineThread;


class Isolate {
public:
    Isolate(Engine* engine, uint32_t id, bool first_isolate);

    inline v8::Isolate* IsolateV8() const {
        return isolate_;
    }

    inline ThreadManager* thread_manager() const {
        return thread_manager_;
    }

    inline TemplateCache* template_cache() const {
        return tpl_cache_;
    }

    void Init();

    uint64_t ticks_count() const {
        return ticks_counter_.Get();
    }

    void ProcessNewThreads();
    void TimerInterruptNotify();

    Thread* current_thread();
    void Enter();

    DELETE_COPY_AND_ASSIGN(Isolate);
private:

    void NewThreads(SharedVector<ResourceHandle<EngineThread>> threads);
    ~Isolate() {}

    Engine* engine_;
    uint32_t id_;
    bool startup_script_;
    v8::Isolate* isolate_;
    ThreadManager* thread_manager_;
    TemplateCache* tpl_cache_;

    Atomic<uint64_t> ticks_counter_;

    Locker thread_handles_locker_;
    Locker locker_;
};

} // namespace rt
