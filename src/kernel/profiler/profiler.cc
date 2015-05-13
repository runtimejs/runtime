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

#include <kernel/profiler/profiler.h>
#include <kernel/engines.h>
#include <kernel/platform.h>
#include <kernel/constants.h>

namespace rt {

#ifdef RUNTIME_ALLOCATOR_CALLBACKS

void AllocatorEnter(void* param) {
    Profiler* profiler = reinterpret_cast<Profiler*>(param);
    GLOBAL_engines()->cpu_engine()->thread_manager()->state_stack().Push(RuntimeState::ALLOCATOR);
}

void AllocatorExit(void* param) {
    Profiler* profiler = reinterpret_cast<Profiler*>(param);
    GLOBAL_engines()->cpu_engine()->thread_manager()->state_stack().Pop();
}

#endif

void Profiler::Enable() {
    log_ = new char[2 * Constants::MiB];
    log_position_ = log_;
    counters_.startTime = GLOBAL_platform()->BootTimeMicroseconds();
#ifdef RUNTIME_ALLOCATOR_CALLBACKS
    GLOBAL_mem_manager()->malloc_allocator().SetTraceCallbacks(AllocatorEnter, AllocatorExit, this);
#endif
    enabled_ = true;
}

void Profiler::Disable() {
    enabled_ = false;
    counters_.endTime = GLOBAL_platform()->BootTimeMicroseconds();
    counters_.Print();

#if 0
    *log_position_ = '\0';
    printf("\nLog:\n\n");
    printf("%s", log_);
    printf("\n=====\n");
#endif

    if (log_) {
        delete[] log_;
        log_ = nullptr;
        log_position_ = nullptr;
    }
    Cpu::HangSystem();
}

void Profiler::MakeSample(SystemContextIRQ irq_context, const RegisterState& state) {
    if (!enabled_) {
        return;
    }

    RT_ASSERT(GLOBAL_engines()->cpu_engine()->is_init());
    auto thread = GLOBAL_engines()->cpu_engine()->thread_manager()->current_thread();
    RT_ASSERT(thread);

    ++counters_.sampleCount;

    v8::RegisterState v8state;
    v8state.pc = state.rip; // RIP
    v8state.sp = state.rsp; // RSP
    v8state.fp = state.rbp; // RBP

    void* frames[8];
    v8::SampleInfo sample_info;

    v8::Isolate* iv8 = thread->IsolateV8();

    // Check if this is an idle thread
    if (nullptr == iv8) {
        ++counters_.idleCount;
        return;
    }


    RT_ASSERT(iv8);
    iv8->GetStackSample(v8state, frames, 8, &sample_info);

    switch (sample_info.vm_state) {
    case v8::JS: {
        ++counters_.jsCount;
        const char* s = nullptr;
        if (sample_info.frames_count > 0) {
            auto entry = FindEventEntry(frames[0]);
            if (entry) {
                s = entry->name.c_str();
            }
        }
        printf("prof %s, [JavaScript] : %s\n", thread->GetInfo().filename.c_str(), s);
        LogWrite(thread->GetInfo().filename.c_str());
        LogWrite(":");
        LogWrite(nullptr == s ? "" : s);
        LogWrite("\n");
    }
        break;
    case v8::GC:
        ++counters_.gcCount;
        printf("prof %s, [GC]\n", thread->GetInfo().filename.c_str());
        break;
    case v8::COMPILER:
        ++counters_.compilerCount;
        printf("prof %s, [Compiler]\n", thread->GetInfo().filename.c_str());
        break;
    case v8::OTHER:
        ++counters_.otherCount;
        printf("prof %s, [Other]\n", thread->GetInfo().filename.c_str());
        break;
    case v8::EXTERNAL:
        ++counters_.externalCount;
        printf("prof %s, [Ext]\n", thread->GetInfo().filename.c_str());
        break;
    case v8::IDLE:
        ++counters_.v8idleCount;
        printf("prof %s, [Idle]\n", thread->GetInfo().filename.c_str());
        break;
    default:
        RT_ASSERT(!"should not be here");
        break;
    }


#ifdef RUNTIME_TRACK_STATE
    RT_ASSERT(thread->thread_manager());
    RuntimeState runtime_state = thread->thread_manager()->state_stack().current();
    ++counters_.runtime_state_counters[(uint32_t)runtime_state];
#endif
}

void Profiler::OnJitCodeEvent(const v8::JitCodeEvent* event) {
    RT_ASSERT(event);

    switch (event->type) {
    case v8::JitCodeEvent::CODE_ADDED: {
        CodeEventEntry entry;
        entry.name = std::string(event->name.str, event->name.len);
        entry.code_start = event->code_start;
        entry.code_len = event->code_len;
        code_entries_.insert(std::make_pair(entry.code_start, entry));
    }
        break;
    case v8::JitCodeEvent::CODE_MOVED: {
        auto it = code_entries_.find(event->code_start);
        RT_ASSERT(it != code_entries_.end());
        code_entries_.erase(it);
        CodeEventEntry entry;
        entry.name = std::string(event->name.str, event->name.len);
        entry.code_start = event->new_code_start;
        entry.code_len = event->code_len;
        code_entries_.insert(std::make_pair(entry.code_start, entry));
    }
        break;
    case v8::JitCodeEvent::CODE_REMOVED: {
        code_entries_.erase(event->code_start);
    }
        break;
    default:
        break;
    }
}

const Profiler::CodeEventEntry* Profiler::FindEventEntry(const void* address) {
    RT_ASSERT(address);
    auto it = code_entries_.upper_bound(address);
    if (it == code_entries_.begin()) return nullptr;
    auto& entry = (--it)->second;
    const void* code_end = static_cast<const uint8_t*>(entry.code_start) + entry.code_len;
    return address < code_end ? &entry : nullptr;
}

} // namespace rt
