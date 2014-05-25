// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "engine.h"
#include <v8.h>

namespace rt {

Isolate* EngineThread::isolate() const {
    RT_ASSERT(engine_);
    return engine_->isolate();
}

v8::Local<v8::Object> EngineThread::NewInstance(Isolate* isolate) {
    RT_ASSERT(isolate);
    v8::Isolate* iv8 = isolate->IsolateV8();
    RT_ASSERT(iv8);
    v8::EscapableHandleScope scope(iv8);
    return scope.Escape(v8::Object::New(iv8));
}

} // namespace rt
