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
#include <kernel/allocator.h>
#include <kernel/thread-manager.h>
#include <kernel/local-storage.h>
#include <kernel/thread.h>
#include <kernel/system-context.h>
#include <kernel/resource.h>

namespace rt {

class Thread;

class ThreadMessage {
public:
    enum class Type {
        EMPTY,
        SET_ARGUMENTS_NOPARENT,
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
            recv_index_(recv_index),
            reusable_(false) {}

    ~ThreadMessage() {
        RT_ASSERT(!reusable_);
    }

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

    void MakeReusable() {
        reusable_ = true;
    }

    size_t recv_index() const { return recv_index_; }
    bool reusable() const { return reusable_; }
    DELETE_COPY_AND_ASSIGN(ThreadMessage);
private:
    Type type_;
    ResourceHandle<EngineThread> sender_;
    TransportData data_;
    ExternalFunction* efn_;
    size_t recv_index_;
    bool reusable_;
};

class EngineThread : public Resource {
    friend class ThreadManager;
public:
    typedef SharedVector<ThreadMessage*> ThreadMessagesVector;
    enum class Status {
        EMPTY,
        NOT_STARTED,
        RUNNING,
        PAUSED
    };

    v8::Local<v8::Object> NewInstance(Thread* thread);

    EngineThread(Engine* engine, ThreadType type)
        :	engine_(engine),
            status_(Status::EMPTY),
            thread_(nullptr),
            type_(type) {
        RT_ASSERT(engine_);
    }

    ThreadMessagesVector TakeMessages() {
        ThreadMessagesVector s;
        {	NoInterrupsScope no_interrups;
            ScopedLock lock(c_locker_);
            if (0 == messages_.size()) return s;
            messages_.swap(s);
            messages_.reserve(128);
        }
        return s;
    }

    /**
     * Get promise resolve/reject message from message queue
     */
    std::unique_ptr<ThreadMessage> TakePromiseResultMessage(uint32_t promise_id) {
        NoInterrupsScope no_interrups;
        ScopedLock lock(c_locker_);
        if (0 == messages_.size()) return nullptr;
        for (size_t i = 0; i < messages_.size(); ++i) {
            ThreadMessage* message = messages_[i];
            if (nullptr == message) {
                continue;
            }

            RT_ASSERT(message);
            if (ThreadMessage::Type::FUNCTION_RETURN_RESOLVE == message->type() ||
                ThreadMessage::Type::FUNCTION_RETURN_REJECT == message->type()) {
                if (message->recv_index() == promise_id) {
                    RT_ASSERT(!message->reusable());
                    messages_[i] = nullptr; // remove from queue
                    return std::unique_ptr<ThreadMessage>(message);
                }
            }
        }
        return nullptr;
    }

    /**
     * Put message into thread processing queue. Use only
     * for non-IRQ context calls, because it will disable and
     * then enable interrupts on current CPU
     */
    void PushMessage(std::unique_ptr<ThreadMessage> message) {
        NoInterrupsScope no_interrups;
        ScopedLock lock(c_locker_);
        RT_ASSERT(message);
        messages_.push_back(message.release());
    }

    /**
     * Put message into thread processing queue. Use only
     * for IRQ-context calls. It doesn't touch IRQ flag
     */
    void PushMessageIRQ(SystemContextIRQ irq_context, ThreadMessage* message) {
        ScopedLock lock(c_locker_);
        RT_ASSERT(message);

        // We don't want to allocate memory in IRQ handler
        if (messages_.size() < messages_.capacity()) {
            messages_.push_back(message);
        }
    }

    Thread* thread() const;
    ThreadType type() const { return type_; }

private:
    Engine* engine_;
    Status status_;
    Thread* thread_;
    Locker c_locker_;
    ThreadMessagesVector messages_;
    ThreadType type_;
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

        ResourceHandle<EngineThread> Create(ThreadType type) {
            ScopedLock lock(datalocker_);
            RT_ASSERT(engine_);
            EngineThread* t = new EngineThread(engine_, type);
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
            thread_mgr_(nullptr),
            init_(false),
            threads_(this) {}
    ~Engine() {}

    ThreadManager* thread_manager() const {
        RT_ASSERT(thread_mgr_);
        return thread_mgr_;
    }

    bool is_init() const { return init_; }
    Threads& threads() { return threads_; }
    EngineType type() const { return type_; }


    void Enter();
    void TimerTick(SystemContextIRQ& irq_context) const;

    inline void ThreadLocalSet(uint64_t index, void* value) {
        if (nullptr == thread_mgr_) {
            local_storage_.Set(index, value);
        } else {
            thread_mgr_->current_thread()->GetLocalStorage().Set(index, value);
        }
    }

    inline void* ThreadLocalGet(uint64_t index) {
        if (nullptr == thread_mgr_) {
            return local_storage_.Get(index);
        } else {
            return thread_mgr_->current_thread()->GetLocalStorage().Get(index);
        }
    }

private:
    EngineType type_;
    ThreadManager* thread_mgr_;
    bool init_;
    LocalStorage local_storage_;
    Threads threads_;
};

} // namespace rt
