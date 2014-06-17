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
#include <kernel/kernel.h>
#include <queue>
#include <stdio.h>

namespace rt {

template<typename T>
class TimeoutItem {
public:
    TimeoutItem(T item, uint64_t time)
        :	item_(item),
            time_(time) { }

    T item() const {
        return item_;
    }

    uint64_t time() const {
        return time_;
    }

private:
    T item_;
    uint64_t time_;
};

template<typename T>
class TimeoutItemComparer {
public:
    TimeoutItemComparer() { }
    bool operator() (const TimeoutItem<T>& lhs,
                     const TimeoutItem<T>& rhs) const {
        return (lhs.time() < rhs.time());
    }
};

template<typename T>
class Timeouts {
public:
    Timeouts() {}

    void Set(T item, uint64_t when_ticks) {
        queue_.push(TimeoutItem<T>(item, when_ticks));
    }

    bool Elapsed(uint64_t ticks_now) const {
        if (queue_.empty()) {
            return false;
        }
        const TimeoutItem<T>& top = queue_.top();
        return (ticks_now >= top.time());
    }

    T Take() {
        const TimeoutItem<T> top = queue_.top();
        queue_.pop();
        return top.item();
    }

    DELETE_COPY_AND_ASSIGN(Timeouts);
private:
    std::priority_queue<TimeoutItem<T>, std::vector<TimeoutItem<T>>,
        TimeoutItemComparer<T>> queue_;
};

} // namespace rt
