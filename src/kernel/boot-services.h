// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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

