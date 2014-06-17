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
