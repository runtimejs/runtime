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
#include <printf.h>
#include <stdio.h>
#include <array>

namespace rt {

typedef void (*FileIoDataEvent)(char c);

class FileIoFile {
public:
  FileIoFile(const char* name, FileIoDataEvent onwrite)
    :	_name(name),
      _onwrite(onwrite) {
    RT_ASSERT(_name);
  }
  void WriteByte(char c) {
    if (nullptr == _onwrite) {
      return;
    }
    _onwrite(c);
  }

private:
  const char* _name;
  FileIoDataEvent _onwrite;
};

void fileio_printer(void* p, char c, size_t offset);

class FileIo {
  friend class BootServices;
public:
  FILE* FOpen(const char* name) {

    printf("open: %s\n", name);

    if (0 == strcmp(name, "v8.log")) {
      return v8_log();
    }

    if (0 == strcmp(name, "snapshot")) {
      return v8_snapshot();
    }

    if (0 == strcmp(name, "deopt")) {
      return stdout_get();
    }

    RT_ASSERT(!"Trying to open unknown file.");
    return nullptr;
  }

  int FPutc(int c, FILE* f) {
    RT_ASSERT(f);
    FileIoFile* file = reinterpret_cast<FileIoFile*>(f);
    file->WriteByte(static_cast<char>(c));
    return c;
  }

  size_t FWrite(const void* src, size_t size, size_t nmemb, FILE* f) {
    RT_ASSERT(f);
    size_t result = 0;
    size_t len = size * nmemb;
    const char* data = reinterpret_cast<const char*>(src);
    FileIoFile* file = reinterpret_cast<FileIoFile*>(f);
    for (size_t i = 0; i < len; ++i) {
      file->WriteByte(data[i]);
      ++result;
    }
    return result;
  }

  int VFPrintf(FILE* f, const char* fmt, va_list va) {
    RT_ASSERT(f);
    return tfp_format(f, fileio_printer, fmt, va);
  }

  int FFlush(FILE* f) {
    RT_ASSERT(f);
    return 0;
  }

  int FClose(FILE* f) {
    RT_ASSERT(f);
    return 0;
  }

  FILE* stdio_out() {
    return reinterpret_cast<FILE*>(&_stdout);
  }
  FILE* stdio_in() {
    return reinterpret_cast<FILE*>(&_stdin);
  }
  FILE* stdio_err() {
    return reinterpret_cast<FILE*>(&_stderr);
  }
  FILE* v8_log() {
    return reinterpret_cast<FILE*>(&_v8_log);
  }
  FILE* v8_snapshot() {
    return reinterpret_cast<FILE*>(&_v8_snapshot);
  }
private:
  FileIoFile _stdout;
  FileIoFile _stderr;
  FileIoFile _stdin;
  FileIoFile _v8_log;
  FileIoFile _v8_snapshot;

  FileIo();
  ~FileIo() {}
  DELETE_COPY_AND_ASSIGN(FileIo);
};

} // namespace rt
