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

class CpuTrampolineX86 {
public:
  CpuTrampolineX86();
  inline uintptr_t address() {
    return kLoadAddress;
  }
  uint16_t cpus_counter_value();
private:
  const uintptr_t kLoadAddress = 0x8000;
  DELETE_COPY_AND_ASSIGN(CpuTrampolineX86);
};

} // namespace rt
