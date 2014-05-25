// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "v8utils.h"
#include <EASTL/string.h>

namespace rt {

SharedString V8Utils::ToSharedString(const v8::Local<v8::String> str) {
    RT_ASSERT(!str.IsEmpty());
    RT_ASSERT(str->IsString());
    v8::String::Utf8Value data_value(str);
    const char* cdata = *data_value;
    RT_ASSERT(cdata);
    return SharedString(cdata);
}

} // namespace rt
