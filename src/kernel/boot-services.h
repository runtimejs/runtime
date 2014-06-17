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
#include <kernel/logger.h>
#include <kernel/fileio.h>
#include <common/utils.h>

namespace rt {

class BootServices {
public:
    BootServices() {}

    __attribute__((__noreturn__)) void FatalError(const char* fmt, ...) {
        // Print error message
        _logger.Printf(LogDataType::ERR, "Kernel error: ");
        va_list va;
        va_start(va, fmt);
        _logger.VPrintf(LogDataType::ERR, fmt, va);
        va_end(va);
        _logger.Printf(LogDataType::ERR, "\n");

        // Hang system
        Cpu::HangSystem();
    }
    Logger* logger() { return &_logger; }
    FileIo* fileio() { return &_file_io; }
private:
    Logger _logger;
    FileIo _file_io;
    DELETE_COPY_AND_ASSIGN(BootServices);
};

} // namespace rt

