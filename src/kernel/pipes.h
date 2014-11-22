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
#include <kernel/transport.h>
#include <vector>
#include <atomic>
#include <concurrentqueue.h>

namespace rt {

class PipeObject;

class Pipe {
public:
    Pipe(uint64_t id)
        :	id_(id), refcount_(1), closed_(false) {}

    bool Push(TransportData data);
    void Pull(ResourceHandle<EngineThread> thread, uint32_t index, uint32_t count);
    void Wait(ResourceHandle<EngineThread> thread, uint32_t index);
    void Close();

    void ProcessPullQueue();
    void WaitResolve(size_t count);

    void Ref() { ++refcount_; }
    void Unref() {
        if (0 == --refcount_) {
            delete this;
        }
    }
private:
    class ClientItem {
    public:
        ClientItem()
            :	thread_(), index_(0) {}
        ClientItem(ResourceHandle<EngineThread> thread, uint32_t index, uint32_t count)
            :	thread_(thread), index_(index), count_(count) {}
        ResourceHandle<EngineThread> thread() const { return thread_; }
        uint32_t index() const { return index_; }
        uint32_t count() const { return count_; }
    private:
        ResourceHandle<EngineThread> thread_;
        uint32_t index_;
        uint32_t count_;
    };

    uint64_t id_;
    std::atomic<uint32_t> refcount_;
    std::atomic<bool> closed_;
    moodycamel::ConcurrentQueue<TransportData> q_;
    moodycamel::ConcurrentQueue<ClientItem> pull_queue_;
    moodycamel::ConcurrentQueue<ClientItem> wait_queue_;
    DELETE_COPY_AND_ASSIGN(Pipe);
};

class PipeManager {
public:
    PipeManager()
        :	next_id_(0) {

    }

    Pipe* CreatePipe() {
        return new Pipe(++next_id_);
    }
private:
    uint64_t next_id_;
};

} // namespace rt
