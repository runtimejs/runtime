// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>
#include <kernel/allocator.h>
#include <kernel/isolate.h>
#include <kernel/local-storage.h>
#include <kernel/thread.h>
#include <kernel/system-context.h>
#include <kernel/resource.h>
#include <EASTL/fixed_vector.h>

namespace rt {

class Thread;

class ThreadMessage {
public:
    enum class Type {
        EMPTY,
        SET_ARGUMENTS,
        EVALUATE,
        TIMEOUT_EVENT,
        IRQ_RAISE,
        FUNCTION_CALL,
        FUNCTION_RETURN_RESOLVE,
        FUNCTION_RETURN_REJECT,
    };

    ThreadMessage(Type type, ResourceHandle<EngineThread> sender,
        TransportData data,
        ExternalFunction* efn = nullptr,
        size_t recv_index = 0)
        :	type_(type),
            sender_(sender),
            data_(std::move(data)),
            efn_(efn),
            recv_index_(recv_index) {}

    Type type() const { return type_; }
    const TransportData& data() { return data_; }
    ExternalFunction* exported_func() {
        RT_ASSERT(efn_);
        return efn_;
    }

    ResourceHandle<EngineThread> sender() {
        RT_ASSERT(!sender_.empty());
        return sender_;
    }

    size_t recv_index() const { return recv_index_; }
    DELETE_COPY_AND_ASSIGN(ThreadMessage);
private:
    Type type_;
    ResourceHandle<EngineThread> sender_;
    TransportData data_;
    ExternalFunction* efn_;
    size_t recv_index_;
};

class EngineThread : public Resource {
    friend class Isolate;
public:
    typedef SharedVector<ThreadMessage*> ThreadMessagesVector;
    enum class Status {
        EMPTY,
        NOT_STARTED,
        RUNNING,
        PAUSED
    };

    v8::Local<v8::Object> NewInstance(Isolate* isolate);

    EngineThread(Engine* engine)
        :	engine_(engine),
            status_(Status::EMPTY),
            thread_(nullptr) {
        RT_ASSERT(engine_);
    }

    ThreadMessagesVector TakeMessages() {
        ThreadMessagesVector s;
        {	ScopedLock lock(c_locker_);
            if (0 == messages_.size()) return s;
            messages_.swap(s);
        }
        return s;
    }

    void PushMessage(std::unique_ptr<ThreadMessage> message) {
        ScopedLock lock(c_locker_);
        messages_.push_back(message.release());
    }

    Isolate* isolate() const;

private:
    Engine* engine_;
    Status status_;
    Thread* thread_;
    Locker c_locker_;
    ThreadMessagesVector messages_;
    DELETE_COPY_AND_ASSIGN(EngineThread);
};

enum class EngineType {
    DISABLED,
    EXECUTION,
    SERVICE
};


class Engine {
public:
    class Threads {
    public:
        Threads(Engine* engine)
            :	engine_(engine) {
            RT_ASSERT(engine_);
        }

        ResourceHandle<EngineThread> Create() {
            ScopedLock lock(datalocker_);
            RT_ASSERT(engine_);
            EngineThread* t = new EngineThread(engine_);
            threads_.push_back(t);
            ResourceHandle<EngineThread> th(t);
            new_threads_.push_back(th);
            return th;
        }

        SharedVector<ResourceHandle<EngineThread>> TakeNewThreads() {
            SharedVector<ResourceHandle<EngineThread>> transport;

            { 	ScopedLock lock(datalocker_);
                if (0 == threads_.size()) return transport;
                new_threads_.swap(transport);
            }

            return transport;
        }

    private:
        Engine* engine_;
        SharedVector<EngineThread*> threads_;
        SharedVector<ResourceHandle<EngineThread>> new_threads_;
        Locker datalocker_;
    };

    Engine(EngineType type)
        :	type_(type),
            isolate_(nullptr),
            init_(false),
            threads_(this) {}
    ~Engine() {}

    Isolate* isolate() const { RT_ASSERT(isolate_); return isolate_; }
    bool is_init() const { return init_; }
    Threads& threads() { return threads_; }
    EngineType type() const { return type_; }


    void Enter() {
        RT_ASSERT(!init_);
        RT_ASSERT(!isolate_);

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
            uint32_t cpu_id = Cpu::id();
            isolate_ = new Isolate(this, cpu_id, 1 == cpu_id);
            RT_ASSERT(isolate_);
        }
            break;
        default:
            RT_ASSERT(!"Invalid engine type.");
            break;
        }

        init_ = true;

        if (isolate_) {
            isolate_->Enter();
        }
    }

    void TimerTick(SystemContextIRQ& irq_context) const {
        if (isolate_) {
            isolate_->TimerInterruptNotify();
        }
    }

    inline void ThreadLocalSet(uint64_t index, void* value) {
        if (nullptr == isolate_) {
            local_storage_.Set(index, value);
        } else {
            isolate_->current_thread()->GetLocalStorage().Set(index, value);
        }
    }

    inline void* ThreadLocalGet(uint64_t index) {
        if (nullptr == isolate_) {
            return local_storage_.Get(index);
        } else {
            return isolate_->current_thread()->GetLocalStorage().Get(index);
        }
    }

private:
    EngineType type_;
    Isolate* isolate_;
    bool init_;
    LocalStorage local_storage_;
    Threads threads_;
};

} // namespace rt
