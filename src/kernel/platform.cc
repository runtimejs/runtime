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

#include <kernel/platform.h>
#include <kernel/kernel.h>
#include <unwind.h>
#include <acpi.h>
#include <accommon.h>
#include <kernel/engines.h>

namespace threadlib {
void sched() {
  RT_ASSERT(!"not implemented");
}

void wait_pause() {
  rt::Cpu::WaitPause();
}

void libassert(int value) {
  RT_ASSERT(value);
}

uint32_t get_thread_id() {
  return rt::Cpu::id() + 1;
}

uint64_t get_time_microseconds() {
  return GLOBAL_platform()->BootTimeMicroseconds();
}
}

namespace rt {

_Unwind_Reason_Code TraceFn(_Unwind_Context* ctx, void* d) {
  int* depth = (int*)d;
  printf("\t#%d: at %08x\n", *depth, _Unwind_GetIP(ctx));
  (*depth)++;
  return _URC_NO_REASON;
}

void Platform::PrintBacktrace() {
  int depth = 0;
  _Unwind_Backtrace(&TraceFn, &depth);
}

void Platform::EnterSleepState(uint32_t state) const {
  RT_ASSERT(state <= ACPI_S_STATES_MAX);
  uint8_t sleep_state = state & 0xff;
  AcpiEnterSleepStatePrep(sleep_state);
  Cpu::DisableInterrupts();
  AcpiEnterSleepState(sleep_state);
  Cpu::HangSystem();
}

} // namespace rt
