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

#include "thread-manager.h"
#include <kernel/kernel.h>
#include <kernel/engines.h>

namespace rt {

void ThreadEntryPoint(Thread* t) {
    RT_ASSERT(t);
    Cpu::EnableInterrupts();

    t->Init();
    for (;;) {
        Cpu::EnableInterrupts();
        t->Run();
        t->thread_manager()->Preempt();
    }
}

ThreadManager::ThreadManager(Engine* engine)
    :	current_thread_(nullptr),
        engine_(engine),
        current_thread_index_(0) {
    RT_ASSERT(engine);
    threads_.reserve(128);
    ticks_counter_.Set(1);
}

extern "C" void preemptStart(void* current_state, void* new_state);
extern "C" void threadStructInit(void* thread_state,
    void (*entry_point)(Thread* t), uintptr_t sp, Thread* t);

void ThreadManager::ThreadInit(Thread* t) {
    RT_ASSERT(t);
    RT_ASSERT(t->GetStackBottom());
    threadStructInit(t->_fxstate, ThreadEntryPoint, t->GetStackBottom(), t);
}

void ThreadManager::ProcessNewThreads() {
    auto threads = engine_->threads().TakeNewThreads();
    if (0 == threads.size()) return;

    for (auto thread : threads) {
        thread.get()->thread_ = CreateThread(thread);
    }
}

void ThreadManager::TimerInterruptNotify() {
    ticks_counter_.AddFetch(1);
}

void ThreadManager::Preempt() {
    Thread* curr_thread = current_thread();
    Thread* new_thread = SwitchToNextThread();

    ProcessNewThreads();

    if (curr_thread == new_thread) {
        return;
    }

    preemptStart(curr_thread->_fxstate, new_thread->_fxstate);
}

} // namespace rt
