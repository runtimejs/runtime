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

#include "process.h"
#include <kernel/native-object.h>
#include <kernel/engines.h>

namespace rt {

v8::Local<v8::Object> Process::NewInstance(Isolate* isolate) {
    RT_ASSERT(isolate);
    v8::Isolate* iv8 = isolate->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape((new ProcessHandleObject(isolate,
        ResourceHandle<Process>(this)))->GetInstance());
}

Process::Process() {}

v8::Local<v8::Object> ProcessManager::NewInstance(Isolate* isolate) {
    RT_ASSERT(isolate);
    v8::Isolate* iv8 = isolate->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape((new ProcessManagerHandleObject(isolate,
        ResourceHandle<ProcessManager>(this)))->GetInstance());
}

ResourceHandle<Process> ProcessManager::CreateProcess() {
    ScopedLock lock(plist_locker_);
    Process* p = new Process();

    uint32_t count = platform_->execution_engines_count();
    p->threads_.resize(count, ResourceHandle<EngineThread>());

    plist_.push_back(p);
    return ResourceHandle<Process>(p);
}

} // namespace rt
