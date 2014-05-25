// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
