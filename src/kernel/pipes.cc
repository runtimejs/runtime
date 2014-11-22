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

#include <kernel/pipes.h>
#include <kernel/native-object.h>
#include <kernel/engines.h>

namespace rt {

void Pipe::ProcessPullQueue() {
    ClientItem item;
    while (pull_queue_.try_dequeue(item)) {
        uint32_t bulk_count = item.count();
        RT_ASSERT(bulk_count > 0);

        if (1 == bulk_count) {
            TransportData data;
            if (!q_.try_dequeue(data)) {
                if (closed_) {
                    std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
                        ThreadMessage::Type::PIPE_PULL,
                        ResourceHandle<EngineThread>(), TransportData(), nullptr, item.index()));
                    item.thread().getUnsafe()->PushMessage(std::move(msg));
                    return;
                }

                pull_queue_.enqueue(item);
                return;
            }

            RT_ASSERT(!item.thread().empty());
            {   std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
                    ThreadMessage::Type::PIPE_PULL,
                    ResourceHandle<EngineThread>(), std::move(data), nullptr, item.index()));
                item.thread().getUnsafe()->PushMessage(std::move(msg));
            }
        } else {
            TransportData* dataarray = new TransportData[bulk_count];
            auto count = q_.try_dequeue_bulk(dataarray, bulk_count);
            if (0 == count) {
                delete[] dataarray;
                if (closed_) {
                    std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
                        ThreadMessage::Type::PIPE_PULL,
                        ResourceHandle<EngineThread>(), TransportData(), nullptr, item.index()));
                    item.thread().getUnsafe()->PushMessage(std::move(msg));
                    return;
                }

                pull_queue_.enqueue(item);
                return;
            }

            RT_ASSERT(!item.thread().empty());
            {   std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
                    ThreadMessage::Type::PIPE_PULL,
                    ResourceHandle<EngineThread>(), TransportData(), dataarray, item.index(), count));
                item.thread().getUnsafe()->PushMessage(std::move(msg));
            }
        }


        WaitResolve(bulk_count);
    }
}

void Pipe::WaitResolve(size_t count) {
    size_t i = 0;
    ClientItem item;
    while (i++ < count && wait_queue_.try_dequeue(item)) {
        std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
            ThreadMessage::Type::PIPE_WAIT,
            ResourceHandle<EngineThread>(), TransportData(), nullptr, item.index()));
        item.thread().getUnsafe()->PushMessage(std::move(msg));
    }
}

bool Pipe::Push(TransportData data) {
    bool result = q_.enqueue(std::move(data));
    if (result) {
        ProcessPullQueue();
    }
    return result;
}

void Pipe::Close() {
    closed_ = true;
    ProcessPullQueue();
}

void Pipe::Wait(ResourceHandle<EngineThread> thread, uint32_t index) {
    RT_ASSERT(!thread.empty());
    wait_queue_.enqueue(ClientItem(thread, index, 1));
}

void Pipe::Pull(ResourceHandle<EngineThread> thread, uint32_t index, uint32_t count) {
    RT_ASSERT(!thread.empty());
    pull_queue_.enqueue(ClientItem(thread, index, count));
    ProcessPullQueue();
}

} // namespace rt
