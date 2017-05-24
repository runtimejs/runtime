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

#ifdef RUNTIMEJS_PLATFORM_X64
#include <kernel/x64/cpu-x64.h>
#else
#error Platform is not supported
#endif

namespace rt {

class Cpu {
public:
  /**
   * Pause operation for busy-wait loops
   */
  static void WaitPause() {
    CpuPlatform::WaitPause();
  }

  static void Cpuid(int code,uint32_t *a,uint32_t *d) {
    CpuPlatform::Cpuid(code,a,d);
  }

  /**
   * Disable interrupts and stop execution
   */
  __attribute__((__noreturn__)) static void HangSystem() {
    CpuPlatform::HangSystem();
  }

  /**
   * Get current CPU index
   */
  static uint32_t id() {
    return CpuPlatform::id();
  }

  /**
   * Enable interrupts on current CPU
   */
  static void EnableInterrupts() {
    CpuPlatform::EnableInterrupts();
  }

  /**
   * Disable interrupts on current CPU
   */
  static void DisableInterrupts() {
    CpuPlatform::DisableInterrupts();
  }

  /**
   * Get interrupts enabled status
   */
  static bool IsInterruptsEnabled() {
    return CpuPlatform::IsInterruptsEnabled();
  }

  /**
   * Put CPU into sleep until next interrupt
   */
  static void Halt() {
    CpuPlatform::Halt();
  }
};

} // namespace rt
