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

#include "native-thread.h"

namespace rt {

extern "C" void preemptStart(void* current_state, void* new_state);
extern "C" void threadStructInit(void* thread_state,
    void (*entry_point)(NativeThread* t), uintptr_t sp, NativeThread* t);

void EntryPointWrapper(NativeThread* t) {
    RT_ASSERT(t);
    t->Run();
    for (;;);
}

NativeThread::NativeThread(NativeThreadEntry entry, void* arg)
    :	name_(),
        status_(NativeThreadStatus::IDLE),
        entry_(entry),
        state_(malloc(1024)),
        vstack_(GLOBAL_mem_manager()->virtual_allocator().AllocStack()),
        arg_(arg) {

    RT_ASSERT(entry);
    RT_ASSERT(vstack_.top());
    RT_ASSERT(state_);
    uintptr_t sp = reinterpret_cast<uintptr_t>(vstack_.top()) + vstack_.len() - 256;
    threadStructInit(state_, EntryPointWrapper, sp, this);
}

void NativeThread::Run() {
    SetStatus(NativeThreadStatus::RUNNING);
    entry_(arg_);
    SetStatus(NativeThreadStatus::DONE);
}

NativeThread::~NativeThread() {
    free(state_);
    state_ = nullptr;
    //TODO: free vstack
}

} // namespace rt
