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
#include <kernel/vector.h>
#include <kernel/resource.h>
#include <include/v8.h>
#include <atomic>

namespace rt {

/**
 * Object handle factory (common instance for all isolates)
 */
class HandlePool {
public:
    HandlePool(uint32_t index, Thread* th, ResourceHandle<EngineThread> recv,
        SharedSTLVector<std::string> methods, SharedSTLVector<v8::Eternal<v8::Value>> impls,
        bool pipes);

    const SharedSTLVector<std::string>& methods() const { return methods_; }
    uint32_t index() const { return index_; }
    Thread* thread() const { return th_; }
    ResourceHandle<EngineThread> thread_handle() const { return recv_; }

    v8::Local<v8::Value> GetImpl(v8::Isolate* iv8, uint32_t method_index) {
        v8::EscapableHandleScope scope(iv8);
        RT_ASSERT(method_index < impls_.size());
        return scope.Escape(impls_[method_index].Get(iv8));
    }

    uint32_t AllocNextId() { return max_handle_id_++; }
    uint32_t max_handle_id() const { return max_handle_id_; }
    bool pipes() const { return pipes_; }
private:
    uint32_t index_;
    SharedSTLVector<std::string> methods_;
    SharedSTLVector<v8::Eternal<v8::Value>> impls_;
    Thread* th_;
    ResourceHandle<EngineThread> recv_;
    std::atomic<uint32_t> max_handle_id_;
    bool pipes_;

    ~HandlePool() {
        RT_ASSERT(!"should not be here");
    }

    DELETE_COPY_AND_ASSIGN(HandlePool);
};

/**
 * Handle pool factory
 */
class HandlePoolManager {
public:
    HandlePoolManager()
        :   pools_count_(0) {
        for (uint32_t i = 0; i < kMaxHandlePools; ++i) {
            pools_[i] = nullptr;
        }
    }

    HandlePool* CreateHandlePool(Thread* th, ResourceHandle<EngineThread> recv,
            SharedSTLVector<std::string> methods, SharedSTLVector<v8::Eternal<v8::Value>> impls,
            bool pipes) {
        RT_ASSERT(th);
        RT_ASSERT(pools_count_ < kMaxHandlePools);
        RT_ASSERT(nullptr == pools_[pools_count_]);
        auto handle_pool = new HandlePool(pools_count_, th, recv,
            std::move(methods), std::move(impls), pipes);
        pools_[pools_count_++] = handle_pool;
        return handle_pool;
    }

    HandlePool* GetPoolById(uint32_t id) const {
        RT_ASSERT(id < kMaxHandlePools);
        RT_ASSERT(id < pools_count_);
        RT_ASSERT(nullptr != pools_[id]);
        return pools_[id];
    }

    static const uint32_t kMaxHandlePools = 32;
private:
    uint32_t pools_count_;
    HandlePool* pools_[kMaxHandlePools];
    DELETE_COPY_AND_ASSIGN(HandlePoolManager);
};

} // namespace rt
