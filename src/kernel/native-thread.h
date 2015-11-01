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

#include <string>
#include <kernel/kernel.h>
#include <kernel/mem-manager.h>

namespace rt {

enum class NativeThreadStatus {
  IDLE,
  RUNNING,
  DONE,
  WAITING
};

typedef void (*NativeThreadEntry)(void* arg);

class NativeThread {
public:
  NativeThread(NativeThreadEntry entry, void* arg);
  ~NativeThread();

  std::string name() const {
    return name_;
  }
  NativeThreadStatus status() const {
    return status_;
  }
  NativeThreadEntry entry() const {
    return entry_;
  }
  void* arg() const {
    return arg_;
  }

  void SetStatus(NativeThreadStatus status) {
    status_ = status;
  }

  void Run();
  DELETE_COPY_AND_ASSIGN(NativeThread);
private:
  std::string name_;
  NativeThreadStatus status_;
  NativeThreadEntry entry_;
  void* state_;
  VirtualStack vstack_;
  void* arg_;
};

} // namespace rt
