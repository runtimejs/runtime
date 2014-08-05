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
#include <common/utils.h>
#include <kernel/allocator.h>
#include <kernel/string.h>
#include <common/utils.h>
#include <EASTL/vector.h>
#include <kernel/vector.h>
#include <EASTL/string.h>
#include <kernel/spinlock.h>
#include <v8.h>

namespace rt {

class Isolate;
class EngineThread;
class Thread;

using ::common::Nullable;

template<typename R>
class ResourceHandle {
    friend class ResourceManager;
public:
    ResourceHandle()
        :	resource_(nullptr),
            empty_(true) { }

    explicit ResourceHandle(R* resource)
        :	resource_(resource),
            empty_(false) {
        RT_ASSERT(resource_);
    }

    bool operator==(const ResourceHandle<R>& that) const {
        return empty_ == that.empty_ && resource_ == that.resource_;
    }

    bool operator!=(const ResourceHandle<R>& that) const {
        return !(this == that);
    }

    LockingPtr<R> get() const {
        RT_ASSERT(resource_ && "Using empty handle.");
        return LockingPtr<R>(resource_, &resource_->locker_);
    }

    /**
     * Unsafe returns raw pointer instead of LockingPtr
     * This used in IRQ handler to get thread handle
     * PushMessage already uses lock, so its ok
     *
     * TODO: fix this, to avoid this call completely
     */
    R* getUnsafe() const {
        RT_ASSERT(resource_ && "Using empty handle.");
        return resource_;
    }

    v8::Local<v8::Value> NewExternal(v8::Isolate* iv8) {
        RT_ASSERT(resource_ && "Using empty handle.");
        RT_ASSERT(iv8);
        v8::EscapableHandleScope scope(iv8);
        return scope.Escape(v8::External::New(iv8, resource_));
    }

    void Reset() {
        empty_ = true;
        resource_ = nullptr;
    }

    bool empty() const { return empty_; }
private:
    R* resource_;
    bool empty_;
};

class Resource {
    template<typename R> friend class ResourceHandle;
public:
    Resource() { }
    virtual v8::Local<v8::Object> NewInstance(Thread* thread) = 0;
private:
    Locker locker_;
    DELETE_COPY_AND_ASSIGN(Resource);
};

} // namespace rt
