// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "fileio.h"
#include <kernel/boot-services.h>

FILE* stdin_get() {
    RT_ASSERT(GLOBAL_boot_services()->fileio());
    RT_ASSERT(GLOBAL_boot_services()->fileio()->stdio_in());
    return GLOBAL_boot_services()->fileio()->stdio_in();
}

FILE* stdout_get() {
    RT_ASSERT(GLOBAL_boot_services()->fileio());
    RT_ASSERT(GLOBAL_boot_services()->fileio()->stdio_out());
    return GLOBAL_boot_services()->fileio()->stdio_out();
}

FILE* stderr_get() {
    RT_ASSERT(GLOBAL_boot_services()->fileio());
    RT_ASSERT(GLOBAL_boot_services()->fileio()->stdio_err());
    return GLOBAL_boot_services()->fileio()->stdio_err();
}

namespace rt {

void fileio_printer(void* p, char c, size_t offset) {
    RT_ASSERT(p);
    FileIoFile* file = reinterpret_cast<FileIoFile*>(p);
    file->WriteByte(c);
}

void StdoutWriteByte(char c) {
    Logger* log = GLOBAL_boot_services()->logger();
    log->__tmp_Putch(c);
}

void StderrWriteByte(char c) {
    Logger* log = GLOBAL_boot_services()->logger();
    log->__tmp_Putch(c);
}

void StdinWriteByte(char c) {
    RT_ASSERT(!"Stdin is not writeable.");
}

void V8LogWriteByte(char c) {
    printf("%c", c);
}

void V8SnapshotWriteByte(char c) {
    GLOBAL_boot_services()->logger()->PutCharSnapshot(c);
}

FileIo::FileIo()
    :	_stdout("stdout", StdoutWriteByte),
        _stderr("stderr", StderrWriteByte),
        _stdin("stdin", StdinWriteByte),
        _v8_log("v8_log", nullptr /*V8LogWriteByte*/),
        _v8_snapshot("v8_snapshot", V8SnapshotWriteByte) {
}

} // namespace rt
