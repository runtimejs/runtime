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
#include <memory>

#include "thread.h"
#include <kernel/kernel.h>
#include <kernel/template-cache.h>
#include <kernel/atomic.h>
#include <kernel/resource.h>

namespace rt {

void ThreadEntryPoint(Thread *t);
extern void Preempt(ThreadManager* thread_mgr);
extern "C" void enterFirstThread(void* new_state);

class Engine;

class ThreadData {
public:
    explicit ThreadData(Thread* thread)
        :	thread_(thread),
            priority_(1) {
        RT_ASSERT(thread);
    }

    void AddPriority(size_t count) {
        priority_ += count;
    }

    void ResetPriority() {
        priority_ = 1;
    }

    void SetPriority(size_t value) {
        priority_ = value;
    }

    Thread* thread() const { return thread_; }
    size_t priority() const { return priority_; }

private:
    Thread* thread_;
    size_t priority_;
};

class ThreadManager {
    friend class Thread;
public:
    ThreadManager(Engine* engine);

    Thread* CreateThread(ResourceHandle<EngineThread> ethread) {
        RT_ASSERT(!ethread.empty());
        Thread* t = new Thread(this, ethread);
        ThreadInit(t);
        threads_.push_back(ThreadData(t));
        return t;
    }

    bool has_threads() {
        return threads_.size() > 0;
    }

    inline Thread* current_thread() {
        return current_thread_;
    }

    void Run() {
        ProcessNewThreads();
        RT_ASSERT(has_threads()); // at least idle thread

        if (0 == threads_.size()) {
            return;
        }

        RT_ASSERT(threads_.size() > 0);

        Cpu::DisableInterrupts();

        current_thread_index_ = 0;
        current_thread_ = threads_[current_thread_index_].thread();
        enterFirstThread(current_thread_->_fxstate);
    }


    // When thread needs to start without saved state
    void ThreadInit(Thread* t);

    Thread* SwitchToNextThread() {
        uint32_t max = 0;
        uint32_t min = std::numeric_limits<uint32_t>::max();
        size_t max_index = 0;
        size_t min_index = 0;

        for (auto it = threads_.begin(); it != threads_.end();) {
            auto thread = (*it).thread();
            if (ThreadType::TERMINATED == thread->type() && current_thread_ == thread) {
                std::swap(*it, threads_.back());
                threads_.pop_back();
                // TODO: delete thread object here too, fix crashes
                // TODO: delete thread stack
            }  else {
                ++it;
            }
        }

        // Make sure we have at least idle thread running
        RT_ASSERT(threads_.size() > 0);

        for (size_t i = 0; i < threads_.size(); ++i) {
            auto thread = threads_[i].thread();

            if (ThreadType::TERMINATED == thread->type()) {
                continue;
            }

            uint32_t p = thread->priority();

            // Copy priority from Atomic32 to thread data
            threads_[i].SetPriority(p);

            if (p > max) {
                max = p;
                max_index = i;
            }

            if (p < min) {
                min = p;
                min_index = i;
            }

        }

        if (max != min) {
            current_thread_index_ = max_index;
        } else {
            ++current_thread_index_;
            if (current_thread_index_ >= threads_.size()) {
                current_thread_index_ = 0;
            }
        }

        RT_ASSERT(current_thread_index_ < threads_.size());

        current_thread_ = threads_[current_thread_index_].thread();
        current_thread_->ResetPriority();
        return current_thread_;
    }

    bool IsPreemptEnabled() {
        return (1 == is_preempt_enabled_.Get());
    }

    void PreemptEnable() {
        is_preempt_enabled_.Set(1);
    }

    void PreemptDisable() {
        is_preempt_enabled_.Set(0);
    }

    uint64_t ticks_count() const {
        return ticks_counter_.Get();
    }

    void ProcessNewThreads();
    void TimerInterruptNotify();
    void Preempt();
private:
    Thread* current_thread_;
    Engine* engine_;
    uint64_t next_thread_id_;
    volatile uint64_t current_thread_index_;
    std::vector<ThreadData> threads_;
    Atomic<uint32_t> is_preempt_enabled_;
    Atomic<uint64_t> ticks_counter_;
    DELETE_COPY_AND_ASSIGN(ThreadManager);
};

} // namespace rt
