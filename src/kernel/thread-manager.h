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
#include <atomic>
#include "thread.h"
#include <kernel/kernel.h>
#include <kernel/template-cache.h>
#include <kernel/resource.h>
#include <kernel/system-context.h>
#include <kernel/runtime-state.h>

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

class ThreadTimeout {
public:
    ThreadTimeout(Thread* thread, uint32_t index)
        :   thread_(thread),
            index_(index) {
        RT_ASSERT(thread);
    }

    Thread* thread() const { return thread_; }
    uint32_t index() const { return index_; }
private:
    Thread* thread_;
    uint32_t index_;
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
        return is_preempt_enabled_;
    }

    void PreemptEnable() {
        is_preempt_enabled_ = true;
    }

    void PreemptDisable() {
        is_preempt_enabled_ = false;
    }

    uint64_t ticks_count() const {
        return ticks_counter_;
    }

    std::vector<ThreadInfo> List() {
        // TODO (SMP port): lock threads_ here and everywhere else
        // Safe to use from the same CPU

        std::vector<ThreadInfo> vec;
        for (size_t i = 0; i < threads_.size(); ++i) {
            auto thread = threads_[i].thread();
            RT_ASSERT(thread);
            vec.push_back(thread->GetInfo());
        }

        return vec;
    }

    /**
     * Increment events processed counter
     */
    void SubmitEvWork(uint64_t ev_count) {
        ev_done_total_ += ev_count;
    }

    uint64_t events_count() const { return ev_done_total_; }
    uint64_t events_count_checkpoint() const { return ev_done_checkpoint_; }

    void SetEvCheckpoint() {
        ev_done_checkpoint_ = ev_done_total_;
    }

    bool CanHalt() const {
        return ev_done_checkpoint_ == ev_done_total_;
    }

#ifdef RUNTIME_TRACK_STATE
    RuntimeStateStack& state_stack() {
        return state_stack_;
    }
#endif

    void ProcessNewThreads();
    void ProcessTimeouts();
    void TimerInterruptNotify(SystemContextIRQ& irq_context);
    void SetTimeout(Thread* thread, uint32_t timeout_id, uint64_t timeout_ms);
    void Preempt();
private:
    Thread* current_thread_;
    Engine* engine_;
    uint64_t next_thread_id_;
    volatile uint64_t current_thread_index_;
    std::vector<ThreadData> threads_;
    std::atomic<bool> is_preempt_enabled_;
    std::atomic<uint64_t> ticks_counter_;
    Timeouts<ThreadTimeout> timeouts_;
    uint64_t ev_done_total_;
    uint64_t ev_done_checkpoint_;
    RuntimeStateStack state_stack_;
    DELETE_COPY_AND_ASSIGN(ThreadManager);
};

#ifdef RUNTIME_TRACK_STATE

template<RuntimeState state>
class RuntimeStateScope {
public:
    RuntimeStateScope(ThreadManager* thread_mgr)
        :	thread_mgr_(thread_mgr) {
        RT_ASSERT(thread_mgr_);
        NoInterrupsScope no_interrupts;
        thread_mgr_->state_stack().Push(state);
    }

    ~RuntimeStateScope() {
        RT_ASSERT(thread_mgr_);
        NoInterrupsScope no_interrupts;
        thread_mgr_->state_stack().Pop();
    }
private:
    ThreadManager* thread_mgr_;
};

#else

template<RuntimeState state>
class RuntimeStateScope {
public:
    RuntimeStateScope(ThreadManager* thread_mgr) {}
};

#endif

} // namespace rt
