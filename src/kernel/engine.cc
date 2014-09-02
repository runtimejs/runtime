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

#include "engine.h"
#include <v8.h>
#include <kernel/thread-manager.h>

namespace rt {

Thread* EngineThread::thread() const {
    RT_ASSERT(thread_);
    return thread_;
}

v8::Local<v8::Object> EngineThread::NewInstance(Thread* thread) {
    RT_ASSERT(thread);
    v8::Isolate* iv8 = thread->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape(v8::Object::New(iv8));
}

void Engine::TimerTick(SystemContextIRQ& irq_context) const {
    if (thread_mgr_) {
        thread_mgr_->TimerInterruptNotify(irq_context);
    }
}

void Engine::Enter() {
    RT_ASSERT(!init_);
    RT_ASSERT(!thread_mgr_);

    switch (type_) {
    case EngineType::DISABLED: {
        Cpu::HangSystem();
    }
        break;
    case EngineType::SERVICE: {
        for (;;) Cpu::WaitPause();
        Cpu::HangSystem();
    }
        break;
    case EngineType::EXECUTION: {
        thread_mgr_ = new ThreadManager(this);
        RT_ASSERT(thread_mgr_);
    }
        break;
    default:
        RT_ASSERT(!"Invalid engine type.");
        break;
    }

    init_ = true;

    if (thread_mgr_) {
        thread_mgr_->Run();
    }
}

} // namespace rt
