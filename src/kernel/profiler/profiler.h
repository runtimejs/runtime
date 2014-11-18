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
#include <kernel/atomic.h>
#include <kernel/system-context.h>
#include <kernel/runtime-state.h>
#include <stdio.h>
#include <string>
#include <map>
#include <vector>

namespace v8 {
    struct JitCodeEvent;
} // namespace v8

namespace rt {

struct RegisterState {
    void* rsp;
    void* rbp;
    void* rip;
};

struct ProfilerCounters {
    uint64_t sampleCount = 0;
    uint64_t idleCount = 0;
    uint64_t jsCount = 0;
    uint64_t gcCount = 0;
    uint64_t compilerCount = 0;
    uint64_t otherCount = 0;
    uint64_t externalCount = 0;
    uint64_t v8idleCount = 0;

    uint64_t startTime = 0;
    uint64_t endTime = 0;

    uint64_t runtime_state_counters[(uint32_t)RuntimeState::LAST] = {0};

    void Print() {
        uint64_t timediff = endTime - startTime;
        uint64_t timediffms = (endTime - startTime) / 1000;
        printf("==== Counters ====\n");

        RT_ASSERT(timediff > 0);
        RT_ASSERT(sampleCount > 0);

        {   double r = idleCount / (double)sampleCount;
            printf(" Idle thread:   %lu (%lu%%, %lu ms)\n", idleCount, (uint64_t)(r * 100), (uint64_t)(timediffms * r));
        }
        {   double r = jsCount / (double)sampleCount;
            printf(" JavaScript:    %lu (%lu%%, %lu ms)\n", jsCount, (uint64_t)(r * 100), (uint64_t)(timediffms * r));
        }
        {   double r = gcCount / (double)sampleCount;
            printf(" GC:            %lu (%lu%%, %lu ms)\n", gcCount, (uint64_t)(r * 100), (uint64_t)(timediffms * r));
        }
        {   double r = compilerCount / (double)sampleCount;
            printf(" Compiler:      %lu (%lu%%, %lu ms)\n", compilerCount, (uint64_t)(r * 100), (uint64_t)(timediffms * r));
        }
        {   double r = otherCount / (double)sampleCount;
            printf(" Other:         %lu (%lu%%, %lu ms)\n", otherCount, (uint64_t)(r * 100), (uint64_t)(timediffms * r));
        }
        {   double r = externalCount / (double)sampleCount;
            printf(" External:      %lu (%lu%%, %lu ms)\n", externalCount, (uint64_t)(r * 100), (uint64_t)(timediffms * r));
        }
        {   double r = v8idleCount / (double)sampleCount;
            printf(" V8 idle:       %lu (%lu%%, %lu ms)\n", v8idleCount, (uint64_t)(r * 100), (uint64_t)(timediffms * r));
        }

        printf(" Total:         %lu\n", sampleCount);
        printf("\n");
        printf(" Time:          %lu ms\n", timediffms);

        printf("\nRuntime states:\n");
        for (uint32_t i = 0; i < (uint32_t)RuntimeState::LAST; ++i) {
            printf("%s: %lu\n", RuntimeStateToString((RuntimeState)i), runtime_state_counters[i]);
        }
    }
};

class Profiler {
public:
    Profiler() {}
    void Enable();
    void Disable();
    void MakeSample(SystemContextIRQ irq_context, const RegisterState& state);
    void OnJitCodeEvent(const v8::JitCodeEvent* event);
private:
    Atomic<bool> enabled_;
    ProfilerCounters counters_;

    struct CodeEventEntry {
        std::string name;
        const void* code_start;
        size_t code_len;
    };
    typedef std::map<const void*, CodeEventEntry> CodeEntries;
    const CodeEventEntry* FindEventEntry(const void* address);
    CodeEntries code_entries_;
    char* log_;
    char* log_position_;

    void LogWrite(const char* str) {
        RT_ASSERT(str);
        RT_ASSERT(log_position_);
        auto len = strlen(str);
        memcpy(log_position_, str, len);
        log_position_ += len;
    }
};

} // namespace rt
