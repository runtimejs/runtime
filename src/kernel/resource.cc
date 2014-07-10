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

#include "resource.h"
#include <kernel/object-wrapper.h>
#include <kernel/native-object.h>
#include <kernel/engine.h>

namespace rt {

v8::Local<v8::Object> ResourceMemoryRange::NewInstance(Thread* thread) {
    RT_ASSERT(thread);
    v8::Isolate* iv8 = thread->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape((new ResourceMemoryRangeObject(thread->template_cache(),
        ResourceHandle<ResourceMemoryRange>(this)))->GetInstance());
}

v8::Local<v8::Object> ResourceMemoryBlock::NewInstance(Thread* thread) {
    RT_ASSERT(thread);
    v8::Isolate* iv8 = thread->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape((new ResourceMemoryBlockObject(thread->template_cache(),
        ResourceHandle<ResourceMemoryBlock>(this)))->GetInstance());
}

v8::Local<v8::Object> ResourceIORange::NewInstance(Thread* thread) {
    RT_ASSERT(thread);
    v8::Isolate* iv8 = thread->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape((new ResourceIORangeObject(thread->template_cache(),
        ResourceHandle<ResourceIORange>(this)))->GetInstance());
}

v8::Local<v8::Object> ResourceIRQRange::NewInstance(Thread* thread) {
    RT_ASSERT(thread);
    v8::Isolate* iv8 = thread->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape((new ResourceIRQRangeObject(thread->template_cache(),
        ResourceHandle<ResourceIRQRange>(this)))->GetInstance());
}

v8::Local<v8::Object> ResourceIRQ::NewInstance(Thread* thread) {
    RT_ASSERT(thread);
    v8::Isolate* iv8 = thread->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape((new ResourceIRQObject(thread->template_cache(),
        ResourceHandle<ResourceIRQ>(this)))->GetInstance());
}

} // namespace rt

