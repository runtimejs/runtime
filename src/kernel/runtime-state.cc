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

#include "runtime-state.h"

namespace rt {

const char* RuntimeStateToString(RuntimeState state) {
  RT_ASSERT((uint32_t)state < (uint32_t)RuntimeState::LAST);
  switch (state) {
  case RuntimeState::INIT:
    return "INIT";
  case RuntimeState::EVENT_LOOP:
    return "EVENT_LOOP";
  case RuntimeState::HALT:
    return "HALT";
  case RuntimeState::JAVASCRIPT:
    return "JAVASCRIPT";
  case RuntimeState::NATIVE_CALL:
    return "NATIVE_CALL";
  case RuntimeState::TRANSPORT_SERIALIZER:
    return "TRANSPORT_SERIALIZER";
  case RuntimeState::TRANSPORT_DESERIALIZER:
    return "TRANSPORT_DESERIALIZER";
  case RuntimeState::RPC_CALL:
    return "RPC_CALL";
  case RuntimeState::HANDLE_CALL:
    return "HANDLE_CALL";
  case RuntimeState::ALLOCATOR:
    return "ALLOCATOR";
  case RuntimeState::CALL_ON_BACKGROUND:
    return "CALL_ON_BACKGROUND";
  case RuntimeState::PROMISE_NATIVE_API:
    return "PROMISE_NATIVE_API";
  case RuntimeState::PIPE_CREATE:
    return "PIPE_CREATE";
  case RuntimeState::PIPE_PUSH:
    return "PIPE_PUSH";
  case RuntimeState::PIPE_PULL:
    return "PIPE_PULL";
  default:
    RT_ASSERT(!"should not be here");
  }

  return "<INVALID_STATE>";
}

} // namespace rt
