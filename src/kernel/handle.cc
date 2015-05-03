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

#include "handle.h"
#include <kernel/engines.h>

namespace rt {

HandlePool::HandlePool(uint32_t index, Thread *th, ResourceHandle<EngineThread> recv,
    SharedSTLVector<std::string> methods, SharedSTLVector<v8::Eternal<v8::Value>> impls,
    bool pipes)
    :   index_(index),
        methods_(std::move(methods)),
        impls_(std::move(impls)),
        th_(th),
        recv_(recv),
        max_handle_id_(0),
        pipes_(pipes),
        has_ctor_(!impls_[0].IsEmpty()),
        has_dtor_(!impls_[1].IsEmpty()),
        has_wpipe_(false),
        has_rpipe_(false) {
    RT_ASSERT(th);
    RT_ASSERT(2 + methods_.size() == impls_.size());
}

} // namespace rt
