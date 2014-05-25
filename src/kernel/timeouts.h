// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
