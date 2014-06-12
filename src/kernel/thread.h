// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
class Isolate;
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
    FunctionExports(Isolate* isolate)
        :	isolate_(isolate), export_id_(0) {
        RT_ASSERT(isolate);
    }

    ExternalFunction* Add(v8::Local<v8::Value> v, ResourceHandle<EngineThread> recv);
    v8::Local<v8::Value> Get(uint32_t index, size_t export_id);

private:
    Isolate* isolate_;
    SharedSTLVector<FunctionExportData> data_;
    size_t export_id_;
};

class Thread {
    friend class ThreadManager;
public:
    Thread(Isolate* isolate, uint64_t id, String name, ResourceHandle<EngineThread> ethread);
    ~Thread();
    DELETE_COPY_AND_ASSIGN(Thread);

    void Init();
    void Run();

    Isolate* isolate() const {
        return isolate_;
    }

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

    inline uint64_t id() const {
        return id_;
    }

    ResourceHandle<EngineThread> handle() const { return ethread_; }

    ExternalFunction* AddExport(v8::Local<v8::Value> fn) {
        return exports_.Add(fn, ethread_);
    }

    uint32_t AddIRQData(v8::UniquePersistent<v8::Value> v) {
        return irq_data_.Push(std::move(v));
    }

    v8::Local<v8::Value> GetIRQData(uint32_t index) {
        v8::EscapableHandleScope scope(iv8_);
        return scope.Escape(irq_data_.GetLocal(iv8_, index));
    }

    uint32_t AddTimeoutData(v8::UniquePersistent<v8::Value> v) {
        return timeout_data_.Push(std::move(v));
    }

    v8::UniquePersistent<v8::Value> TakeTimeoutData(uint32_t index) {
        return timeout_data_.Take(index);
    }

    uint32_t AddPromise(v8::UniquePersistent<v8::Promise::Resolver> resolver) {
        return promises_.Push(std::move(resolver));
    }

    v8::UniquePersistent<v8::Promise::Resolver> TakePromise(uint32_t index) {
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

    void SetCallWrapper(v8::Local<v8::Function> fn) {
        RT_ASSERT(call_wrapper_.IsEmpty());
        RT_ASSERT(!fn.IsEmpty());
        RT_ASSERT(fn->IsFunction());
        call_wrapper_ = std::move(v8::UniquePersistent<v8::Function>(iv8_, fn));
    }

    void SetTimeout(uint32_t timeout_id, uint64_t timeout_ms);

    v8::Local<v8::Value> args() const {
        v8::EscapableHandleScope scope(iv8_);
        if (args_.IsEmpty()) {
            v8::Local<v8::Value> nl(v8::Null(iv8_));
            return scope.Escape(nl);
        }
        return scope.Escape(v8::Local<v8::Value>::New(iv8_, args_));
    }

    /**
     * Thread state storage required for stack switch
     */
    uint8_t _fxstate[1024] alignas(16);
private:
    Isolate* isolate_;
    v8::Isolate* iv8_;
    uint64_t id_;
    String name_;

    LocalStorage local_storage_;
    v8::UniquePersistent<v8::Context> context_;
    v8::UniquePersistent<v8::Value> args_;
    v8::UniquePersistent<v8::Function> call_wrapper_;

    VirtualStack stack_;
//    AtomicUINT32 priority_;
    Atomic<uint32_t> priority_;

    ResourceHandle<EngineThread> ethread_;
    FunctionExports exports_;
    Timeouts<uint32_t> timeouts_;

    UniquePersistentIndexedPool<v8::Value> timeout_data_;
    UniquePersistentIndexedPool<v8::Value> irq_data_;
    UniquePersistentIndexedPool<v8::Promise::Resolver> promises_;
};

} // namespace rt

