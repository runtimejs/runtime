// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <vector>
#include <string>
#include <memory>

#include <v8.h>
#include "thread.h"
#include <kernel/kernel.h>
#include <kernel/template-cache.h>
#include <kernel/atomic.h>
#include <kernel/resource.h>
#include <kernel/engine.h>

namespace rt {

void ThreadEntryPoint(Thread *t);
extern void Preempt(Isolate *isolate);
extern "C" void enterFirstThread(void* new_state);

class ThreadBlock {
public:
    explicit ThreadBlock(Thread* thread)
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

class ThreadBlockPriorityComparer {
public:
    bool operator() (const ThreadBlock& lhs, const ThreadBlock& rhs) const {
        return (lhs.priority() < rhs.priority());
    }
};

class ThreadManager {
    friend class Thread;
public:
    ThreadManager(Isolate* isolate);

    Thread* CreateThread(String name, ResourceHandle<EngineThread> ethread) {
        RT_ASSERT(!ethread.empty());
        Thread* t = new Thread(isolate_, next_thread_id_++, name, ethread);
        ThreadInit(t);
        threads_.push_back(ThreadBlock(t));
        return t;
    }

    bool has_threads() {
        return threads_.size() > 0;
    }

    inline Thread* current_thread() {
        return current_thread_;
    }

    void Run() {
        if (0 == threads_.size()) {
            return;
        }
        RT_ASSERT(threads_.size() > 0);

        asm volatile("cli");
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

        for (size_t i = 0; i < threads_.size(); ++i) {

            uint32_t p = threads_[i].thread()->priority();

            // Copy priority from Atomic32 to thread block
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
            if (current_thread_index_ == threads_.size())
            {
                current_thread_index_ = 0;
            }
        }

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

private:
    Thread* current_thread_;
    Isolate* isolate_;
    uint64_t next_thread_id_;
    volatile uint64_t current_thread_index_;
    std::vector<ThreadBlock> threads_;
    Atomic<uint32_t> is_preempt_enabled_;
    DELETE_COPY_AND_ASSIGN(ThreadManager);
};

} // namespace rt
