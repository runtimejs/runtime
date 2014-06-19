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
    virtual v8::Local<v8::Object> NewInstance(Isolate* isolate) = 0;
private:
    Locker locker_;
    DELETE_COPY_AND_ASSIGN(Resource);
};

class ResourceMemoryBlock : public Resource {
public:
    ResourceMemoryBlock(size_t base, size_t size)
        :	base_(base),
            size_(size) { }
    size_t base() const { return base_; }
    size_t size() const { return size_; }
    v8::Local<v8::Object> NewInstance(Isolate* isolate);
private:
    size_t base_;
    size_t size_;
};

class ResourceMemoryRange : public Resource {
public:
    class Range {
    public:
        Range(size_t start, size_t end)
            :	start_(start), end_(end) {
            RT_ASSERT(start_ <= end_);
        }

        bool IsOverlap(Range other) {
            return (start_ <= other.end_) && (other.start_ <= end_);
        }

        size_t start() const { return start_; }
        size_t end() const { return end_; }
    private:
        size_t start_;
        size_t end_;
    };

    ResourceMemoryRange(size_t start, size_t end)
        :	range_(start, end) {
        if (!common::Utils::IsSafeDouble(start) || !common::Utils::IsSafeDouble(end)) {
            range_ = Range(0, 0);
        }
    }

    ResourceHandle<ResourceMemoryRange> Subrange(size_t start, size_t end) {
        Range r(start, end);
        for (const Range& range : ranges_) {
            if (r.IsOverlap(range)) {
                return ResourceHandle<ResourceMemoryRange>();
            }
        }
        ranges_.push_back(Range(start, end));
        return ResourceHandle<ResourceMemoryRange>(new ResourceMemoryRange(start, end));
    }

    ResourceHandle<ResourceMemoryBlock> Block(size_t base, size_t length) {
        return ResourceHandle<ResourceMemoryBlock>(new ResourceMemoryBlock(base, length));
    }

    size_t start() const { return range_.start(); }
    size_t end() const { return range_.end(); }
    v8::Local<v8::Object> NewInstance(Isolate* isolate);
private:
    SharedVector<Range> ranges_;
    Range range_;
};

class ResourceIORange : public Resource {
public:
    ResourceIORange(uint16_t first, uint16_t last)
        :	first_(first),
            last_(last) { }
    uint16_t first() const { return first_; }
    uint16_t last() const { return last_; }
    v8::Local<v8::Object> NewInstance(Isolate* isolate);

    ResourceHandle<ResourceIORange> Subrange(size_t first, size_t last) {
        return ResourceHandle<ResourceIORange>(new ResourceIORange(first, last));
    }
private:
    uint16_t first_;
    uint16_t last_;
};

class ResourceIRQ : public Resource {
public:
    ResourceIRQ(uint8_t number)
        :	number_(number) { }
    size_t number() const { return number_; }
    v8::Local<v8::Object> NewInstance(Isolate* isolate);
private:
    uint8_t number_;
};

class ResourceIRQRange : public Resource {
public:
    ResourceIRQRange(uint8_t first, uint8_t last)
        :	first_(first),
            last_(last) { }
    size_t first() const { return first_; }
    size_t last() const { return last_; }
    v8::Local<v8::Object> NewInstance(Isolate* isolate);

    ResourceHandle<ResourceIRQ> Irq(uint8_t number) {
        return ResourceHandle<ResourceIRQ>(new ResourceIRQ(number));
    }
private:
    uint8_t first_;
    uint8_t last_;
};

} // namespace rt
