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

#include <string>
#include <vector>
#include <queue>
#include <v8.h>
#include <kernel/local-storage.h>
#include <kernel/mem-manager.h>
#include <kernel/atomic.h>
#include <kernel/resource.h>
#include <common/constants.h>
#include <kernel/timeouts.h>
#include <kernel/transport.h>
#include <kernel/v8utils.h>
#include <kernel/native-fn.h>

namespace rt {

class ThreadManager;
class Interface;
class EngineThread;

class FunctionExportData {
public:
    FunctionExportData(v8::Isolate* iv8, v8::Local<v8::Value> fn, size_t export_id)
        :	fn_(std::move(v8::UniquePersistent<v8::Value>(iv8, fn))),
            export_id_(export_id) {
        RT_ASSERT(iv8);
    }

    FunctionExportData(FunctionExportData&& other)
        :	fn_(std::move(other.fn_)),
            export_id_(other.export_id_) {}

    v8::Local<v8::Value> GetValue(v8::Isolate* iv8) const {
        v8::EscapableHandleScope scope(iv8);
        return scope.Escape(v8::Local<v8::Value>::New(iv8, fn_));
    }

    size_t export_id() const { return export_id_; }
private:
    v8::UniquePersistent<v8::Value> fn_;
    size_t export_id_;
    DELETE_COPY_AND_ASSIGN(FunctionExportData);
};

class FunctionExports {
public:
    FunctionExports(Thread* thread)
        :	thread_(thread), export_id_(0) {
        RT_ASSERT(thread);
    }

    ExternalFunction* Add(v8::Local<v8::Value> v, ResourceHandle<EngineThread> recv);
    v8::Local<v8::Value> Get(uint32_t index, size_t export_id);

private:
    Thread* thread_;
    SharedSTLVector<FunctionExportData> data_;
    size_t export_id_;
};

enum class ThreadType {
    DEFAULT,
    IDLE,
    TERMINATED,
};

class Thread {
    friend class ThreadManager;
public:
    Thread(ThreadManager* thread_mgr, ResourceHandle<EngineThread> ethread);
    ~Thread();
    DELETE_COPY_AND_ASSIGN(Thread);

    /**
     * Set up thread and v8 isolate
     */
    void SetUp();

    /**
     * Send onExit message, clean up resources, delete
     * v8 isolate
     */
    void TearDown();

    /**
     * Run thread until message queue is empty. If this function
     * returns true, then this thread haven't finished all it's
     * work and expects another Run() call.
     * When this returns false, it's safe to terminate thread.
     */
    bool Run();

    /**
     * Get global isolate object
     */
    v8::Local<v8::Object> GetIsolateGlobal();

    ThreadManager* thread_manager() const {
        return thread_mgr_;
    }

    v8::Isolate* IsolateV8() const { return iv8_; }
    TemplateCache* template_cache() const { return tpl_cache_; }

    uintptr_t GetStackBottom() const {
        RT_ASSERT(stack_.top());
        RT_ASSERT(stack_.len());
        RT_ASSERT(reinterpret_cast<uintptr_t>(stack_.top()) % 2 * common::Constants::MiB == 0);
        RT_ASSERT(stack_.len() % 2 * common::Constants::MiB == 0);
        uintptr_t stack_pos = reinterpret_cast<uintptr_t>(stack_.top()) + stack_.len() - 256;
        RT_ASSERT(stack_pos);
        return stack_pos;
    }

    LocalStorage& GetLocalStorage() {
        return local_storage_;
    }

    ResourceHandle<EngineThread> handle() const { return ethread_; }

    void SetExitValue(v8::Local<v8::Value> value) {
        exit_value_ = std::move(v8::UniquePersistent<v8::Value>(iv8_, value));
    }

    ExternalFunction* AddExport(v8::Local<v8::Value> fn) {
        Ref();
        return exports_.Add(fn, ethread_);
    }

    uint32_t AddIRQData(v8::UniquePersistent<v8::Value> v) {
        Ref();
        return irq_data_.Push(std::move(v));
    }

    v8::Local<v8::Value> GetIRQData(uint32_t index) {
        v8::EscapableHandleScope scope(iv8_);
        return scope.Escape(irq_data_.GetLocal(iv8_, index));
    }

    uint32_t AddTimeoutData(v8::UniquePersistent<v8::Value> v) {
        Ref();
        return timeout_data_.Push(std::move(v));
    }

    v8::UniquePersistent<v8::Value> TakeTimeoutData(uint32_t index) {
        Unref();
        return timeout_data_.Take(index);
    }

    uint32_t AddPromise(v8::UniquePersistent<v8::Promise::Resolver> resolver) {
        Ref();
        return promises_.Push(std::move(resolver));
    }

    v8::UniquePersistent<v8::Promise::Resolver> TakePromise(uint32_t index) {
        Unref();
        return promises_.Take(index);
    }

    uint32_t priority() const {
        return priority_.Get();
    }

    void AddPriority(size_t count) {
        priority_.AddFetch(count);
    }

    void ResetPriority() {
        priority_.Set(1);
    }

    /**
     * Mark this thread as ready to be terminated, even if refcount > 0
     */
    void SetTerminateFlag() {
        terminate_ = true;
    }

    /**
     * Increment thread reference counter
     */
    void Ref() {
        ++ref_count_;
    }

    /**
     * Decrement thread reference counter
     */
    void Unref() {
        --ref_count_;
    }

    void SetCallWrapper(v8::Local<v8::Function> fn) {
        RT_ASSERT(call_wrapper_.IsEmpty());
        RT_ASSERT(!fn.IsEmpty());
        RT_ASSERT(fn->IsFunction());
        call_wrapper_ = std::move(v8::UniquePersistent<v8::Function>(iv8_, fn));
    }

    uint32_t parent_promise_id() const { return parent_promise_id_; }
    ResourceHandle<EngineThread> parent_thread() const { return parent_thread_; }

    void SetTimeout(uint32_t timeout_id, uint64_t timeout_ms);

    v8::Local<v8::Value> args() const {
        v8::EscapableHandleScope scope(iv8_);
        if (args_.IsEmpty()) {
            v8::Local<v8::Value> nl(v8::Null(iv8_));
            return scope.Escape(nl);
        }
        return scope.Escape(v8::Local<v8::Value>::New(iv8_, args_));
    }

    ThreadType type() const { return type_; }

    /**
     * Thread state storage required for stack switch
     */
    uint8_t _fxstate[1024] alignas(16);
private:
    ThreadManager* thread_mgr_;
    ThreadType type_;
    v8::Isolate* iv8_;
    TemplateCache* tpl_cache_;

    LocalStorage local_storage_;
    v8::UniquePersistent<v8::Context> context_;
    v8::UniquePersistent<v8::Value> args_;
    v8::UniquePersistent<v8::Value> exit_value_;
    v8::UniquePersistent<v8::Function> call_wrapper_;

    VirtualStack stack_;
    Atomic<uint32_t> priority_;

    ResourceHandle<EngineThread> ethread_;
    FunctionExports exports_;
    Timeouts<uint32_t> timeouts_;

    size_t ref_count_;
    bool terminate_;

    uint32_t parent_promise_id_;
    ResourceHandle<EngineThread> parent_thread_;

    UniquePersistentIndexedPool<v8::Value> timeout_data_;
    UniquePersistentIndexedPool<v8::Value> irq_data_;
    UniquePersistentIndexedPool<v8::Promise::Resolver> promises_;
};

} // namespace rt

