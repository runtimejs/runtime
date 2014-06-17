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

#pragma once
#include <kernel/kernel.h>
#include <kernel/x64/io-x64.h>

namespace rt {

class IrqsArch {
public:
    IrqsArch() {}
    void SetUp();
private:
    void DisableNMI();
    void EnableNMI();
    void InstallGate(uint8_t vector, uint64_t (*func)(), uint8_t type);

    static const uint64_t kIDTTableBase = 0;
    static const uint8_t kCodeSelector = 0x8;
    DELETE_COPY_AND_ASSIGN(IrqsArch);
};

} // namespace rt
