// Copyright 2014 runtime.js project authors
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

namespace rt {

enum class RuntimeState {
  INIT,
  EVENT_LOOP,
  HALT,
  JAVASCRIPT,
  NATIVE_CALL,
  TRANSPORT_SERIALIZER,
  TRANSPORT_DESERIALIZER,
  RPC_CALL,
  HANDLE_CALL,
  ALLOCATOR,
  CALL_ON_BACKGROUND,
  PROMISE_NATIVE_API,
  PIPE_CREATE,
  PIPE_PUSH,
  PIPE_PULL,

  LAST // keep this as the last element
};

const char* RuntimeStateToString(RuntimeState state);

class RuntimeStateStack {
public:
  RuntimeStateStack()
    :	size_(0) {}

  void Push(RuntimeState state) {
    RT_ASSERT(size_ < kMaxDepth);
    stack_[size_++] = state;
  }

  void Pop() {
    RT_ASSERT(size_ > 0);
    --size_;
  }

  RuntimeState current() const {
    RT_ASSERT(size_ > 0);
    return stack_[size_ - 1];
  }
private:
  static const uint8_t kMaxDepth = 16;
  RuntimeState stack_[kMaxDepth];
  uint8_t size_;
  DELETE_COPY_AND_ASSIGN(RuntimeStateStack);
};

} // namespace rt
