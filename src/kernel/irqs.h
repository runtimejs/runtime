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
#include <kernel/resource.h>
#include <kernel/engine.h>

#ifdef RUNTIMEJS_PLATFORM_X64
#include <kernel/x64/irqs-x64.h>
#else
#error Platform is not supported
#endif

namespace rt {

class Irqs {
public:
    Irqs() {
        irqs_arch_.SetUp();
    }
private:
    IrqsArch irqs_arch_;
    DELETE_COPY_AND_ASSIGN(Irqs);
};


} // namespace rt
