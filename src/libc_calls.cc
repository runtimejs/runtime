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

#include <kernel/kernel.h>
#include <kernel/boot-services.h>
#include <kernel/logger.h>
#include <kernel/platform.h>
#include <stdio.h>

extern "C" {

  void exit(int code) {
    GLOBAL_boot_services()->FatalError("exit() requested");
  }

  void abort() {
    GLOBAL_boot_services()->FatalError("abort() requested");
  }

  size_t __stdio_read(FILE* f, unsigned char* buf, size_t len) {
    GLOBAL_boot_services()->FatalError("stdio read requested");
  }

  void __assert_fail(const char* expr, const char* file, int line, const char* func) {
    GLOBAL_boot_services()->FatalError("Assertion failed: %s (%s: %s: %d)\n", expr, file, func, line);
  }

  void __cxa_bad_cast() {
    GLOBAL_boot_services()->FatalError("__cxa_bad_cast: dynamic_cast failed");
    abort();
  }

  void __cxa_bad_typeid() {
    GLOBAL_boot_services()->FatalError("__cxa_bad_typeid");
    abort();
  }

  struct tm {
    int tm_sec;
    int tm_min;
    int tm_hour;
    int tm_mday;
    int tm_mon;
    int tm_year;
    int tm_wday;
    int tm_yday;
    int tm_isdst;
    long __tm_gmtoff;
    const char* __tm_zone;
  };



  size_t strftime_l(char* s, size_t n, const char* f, const struct tm* tm, locale_t l) {
    GLOBAL_boot_services()->FatalError("strftime_l requested");
  }

  int __lockfile(FILE* f) {
    return 1;
  }
  void __unlockfile(FILE* f) { }
  int __stdio_close(FILE* f) {
    return 0;
  }
  long __stdio_seek(FILE* f, long off, int whence) {
    return -1;
  }
  void __stdio_exit(void) { }

  int* __errno_location(void) {
    static int e;
    return &e;
  }

  void sched_yield() { }

  FILE* fopen(const char* filename, const char* mode) {
    RT_ASSERT(filename);
    return GLOBAL_boot_services()->fileio()->FOpen(filename);
  }

  int fseeko(FILE* stream, off_t offset, int whence) {
    GLOBAL_boot_services()->FatalError("fseeko requested");
  }

  off_t ftello(FILE* stream) {
    GLOBAL_boot_services()->FatalError("ftello requested");
  }

  char* fgets(char* s, int n, FILE* f) {
    GLOBAL_boot_services()->FatalError("fgets requested");
  }

  size_t fwrite(const void* src, size_t size, size_t nmemb, FILE* f) {
    return GLOBAL_boot_services()->fileio()->FWrite(src, size, nmemb, f);
  }

  int fputc(int c, FILE* f) {
    return GLOBAL_boot_services()->fileio()->FPutc(c, f);
  }

  size_t fread(void* destv, size_t size, size_t nmemb, FILE* f) {
    GLOBAL_boot_services()->FatalError("fread requested");
  }

  int printf(const char* fmt, ...) {
    RT_ASSERT(fmt);
    RT_ASSERT(GLOBAL_boot_services()->logger());
    va_list ap;
    va_start(ap, fmt);
    int count = GLOBAL_boot_services()->logger()->VPrintf(rt::LogDataType::DEFAULT, fmt, ap);
    va_end(ap);
    return count;
  }

  int vprintf(const char* fmt, va_list ap) {
    return GLOBAL_boot_services()->logger()->VPrintf(rt::LogDataType::DEFAULT, fmt, ap);
  }

  int vfprintf(FILE* f, const char* fmt, va_list ap) {
    rt::Logger* log = GLOBAL_boot_services()->logger();
    log->__tmp_Lock();
    int c = GLOBAL_boot_services()->fileio()->VFPrintf(f, fmt, ap);
    log->__tmp_Unlock();
    return c;
  }

  int vsscanf(const char* s, const char* fmt, va_list ap) {
    GLOBAL_boot_services()->FatalError("vsscanf requested");
  }

  int vswprintf(wchar_t* s, size_t n, const wchar_t* fmt, va_list ap) {
    GLOBAL_boot_services()->FatalError("vswprintf requested");
  }

  int sscanf(const char* s, const char* fmt, ...) {
    GLOBAL_boot_services()->FatalError("sscanf requested");
  }

  int fscanf(FILE* f, const char* fmt, ...) {
    GLOBAL_boot_services()->FatalError("fscanf requested");
  }

  int __uflow(FILE* f) {
    GLOBAL_boot_services()->FatalError("__uflow requested");
  }

  void rewind(FILE* f) {
    GLOBAL_boot_services()->FatalError("rewind requested");
  }

  int setvbuf(FILE* f, char* buf, int type, size_t size) {
    GLOBAL_boot_services()->FatalError("setvbuf requested");
  }

  int fseek(FILE* f, long off, int whence) {
    GLOBAL_boot_services()->FatalError("fseek requested");
  }

  long ftell(FILE* f) {
    GLOBAL_boot_services()->FatalError("ftell requested");
  }

  int fprintf(FILE* f, const char* fmt, ...) {
    va_list va;
    va_start(va, fmt);
    int count = vfprintf(f, fmt, va);
    va_end(va);
    return count;
  }

  int fflush(FILE* f) {
    return GLOBAL_boot_services()->fileio()->FFlush(f);
  }

  int fclose(FILE* f) {
    return GLOBAL_boot_services()->fileio()->FClose(f);
  }

  int feof(FILE* f) {
    GLOBAL_boot_services()->FatalError("feof requested");
  }

  int ferror(FILE* f) {
    GLOBAL_boot_services()->FatalError("ferror requested");
  }

  int asprintf(char** s, const char* fmt, ...) {
    va_list va;
    va_start(va, fmt);
    int count = vasprintf(s, fmt, va);
    va_end(va);
    return count;
  }

  int vasprintf(char** s, const char* fmt, va_list ap) {
    GLOBAL_boot_services()->FatalError("vasprintf requested");
  }

  int swprintf(wchar_t* s, size_t n, const wchar_t* fmt, ...) {
    GLOBAL_boot_services()->FatalError("swprintf requested");
  }

  int vsprintf(char* s, const char* fmt, va_list ap) {
    return tfp_vsprintf(s, fmt, ap);
  }

  int vsnprintf(char* s, size_t n, const char* fmt, va_list ap) {
    return tfp_vsnprintf(s, n, fmt, ap);
  }

  int sprintf(char* s, const char* fmt, ...) {
    va_list va;
    va_start(va, fmt);
    int count = tfp_vsprintf(s, fmt, va);
    va_end(va);
    return count;
  }

  int snprintf(char* s, size_t n, const char* fmt, ...) {
    va_list va;
    va_start(va, fmt);
    int count = tfp_vsnprintf(s, n, fmt, va);
    va_end(va);
    return count;
  }

}
