// Copyright 2015 Runtime.JS project authors
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
#include <kernel/x64/io-x64.h>

namespace rt {

enum class CMOSTimeRegisters {
  CMOSAddress = 0x70,
  CMOSData = 0x71
};

class CMOSTime {
public:
  CMOSTime();
  uint64_t GetCurrentMilliseconds();
private:
  int second;
  int minute;
  int hour;
  int day;
  int month;
  int year;

  int GetUpdateProgressFlag();
  int GetRTCRegister(int reg);
};

} // namespace rt
