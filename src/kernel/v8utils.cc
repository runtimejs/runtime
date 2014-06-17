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
