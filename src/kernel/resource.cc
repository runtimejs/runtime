// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "resource.h"
#include <kernel/object-wrapper.h>
#include <kernel/native-object.h>
#include <kernel/engine.h>

namespace rt {

v8::Local<v8::Object> ResourceMemoryRange::NewInstance(Isolate* isolate) {
    RT_ASSERT(isolate);
    v8::Isolate* iv8 = isolate->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape((new ResourceMemoryRangeObject(isolate,
        ResourceHandle<ResourceMemoryRange>(this)))->GetInstance());
}

v8::Local<v8::Object> ResourceMemoryBlock::NewInstance(Isolate* isolate) {
    RT_ASSERT(isolate);
    v8::Isolate* iv8 = isolate->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape((new ResourceMemoryBlockObject(isolate,
        ResourceHandle<ResourceMemoryBlock>(this)))->GetInstance());
}

v8::Local<v8::Object> ResourceIORange::NewInstance(Isolate* isolate) {
    RT_ASSERT(isolate);
    v8::Isolate* iv8 = isolate->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape((new ResourceIORangeObject(isolate,
        ResourceHandle<ResourceIORange>(this)))->GetInstance());
}

v8::Local<v8::Object> ResourceIRQRange::NewInstance(Isolate* isolate) {
    RT_ASSERT(isolate);
    v8::Isolate* iv8 = isolate->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape((new ResourceIRQRangeObject(isolate,
        ResourceHandle<ResourceIRQRange>(this)))->GetInstance());
}

v8::Local<v8::Object> ResourceIRQ::NewInstance(Isolate* isolate) {
    RT_ASSERT(isolate);
    v8::Isolate* iv8 = isolate->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape((new ResourceIRQObject(isolate,
        ResourceHandle<ResourceIRQ>(this)))->GetInstance());
}

} // namespace rt

