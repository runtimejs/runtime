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
//    log->__tmp_Putch(c);
  log->Printf(LogDataType::DEFAULT, "%c", c); // TODO: make sure this works with a snapshot
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
