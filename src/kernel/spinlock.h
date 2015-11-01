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
#include <kernel/cpu.h>
#include <kernel/threadlib/spinlock.h>

namespace rt {

template<typename T>
class ScopedLock {
public:
  inline ScopedLock(T& v) : v_(&v) {
    v_->lock();
  }

  inline ~ScopedLock() {
    v_->unlock();
  }
private:
  T* v_;
  DELETE_COPY_AND_ASSIGN(ScopedLock);
};

/**
 * Create scope where no interrupt can occur. This should
 * not be used in IRQ context, because it will set IF flag
 * before IRETQ
 */
class NoInterrupsScope {
public:
  inline NoInterrupsScope() {
    Cpu::DisableInterrupts();
  }

  inline ~NoInterrupsScope() {
    Cpu::EnableInterrupts();
  }
private:
  DELETE_COPY_AND_ASSIGN(NoInterrupsScope);
};

} // namespace rt
