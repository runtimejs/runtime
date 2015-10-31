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

// Copyright 2013 the V8 project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <stdlib.h>
#include <kernel/kernel.h>
#include <kernel/keystorage.h>
#include <kernel/platform.h>
#include <kernel/native-thread.h>
#include <kernel/boot-services.h>

#include "v8.h"

#include "platform.h"
#include "src/base/platform/time.h"
#include "src/base/utils/random-number-generator.h"

extern "C" int sched_yield(void);

namespace v8 {
namespace base {

namespace {

bool g_hard_abort = false;

const char* g_gc_fake_mmap = NULL;

}  // namespace

double ceiling(double x) {
  return ceil(x);
}

intptr_t OS::CommitPageSize() {
  return 1024*4;
}


// Get rid of writable permission on code allocations.
void OS::ProtectCode(void* address, const size_t size) {
}


static LazyInstance<RandomNumberGenerator>::type
    platform_random_number_generator = LAZY_INSTANCE_INITIALIZER;


void OS::Initialize(int64_t random_seed, bool hard_abort,
                    const char* const gc_fake_mmap) {
  if (random_seed) {
    platform_random_number_generator.Pointer()->SetSeed(random_seed);
  }
  g_hard_abort = hard_abort;
  g_gc_fake_mmap = gc_fake_mmap;
}


// Create guard pages.
void OS::Guard(void* address, const size_t size) {
}


void* OS::GetRandomMmapAddr() {
  return NULL;
}


/*double OS::nan_value() {
  // NAN from math.h is defined in C99 and not in POSIX.
  return NAN;
}*/


int OS::GetCurrentProcessId() {
  return 1;
}


int OS::GetUserTime(uint32_t* secs,  uint32_t* usecs) {
  *secs = static_cast<uint32_t>(1);
  *usecs = static_cast<uint32_t>(1);
  return 0;
}


double OS::TimeCurrentMillis() {
  return Time::Now().ToJsTime();
}


double OS::DaylightSavingsOffset(double time, TimezoneCache*) {
  return 0;
}


int OS::GetLastError() {
  return 0;
}


FILE* OS::FOpen(const char* path, const char* mode) {
  RT_ASSERT(GLOBAL_boot_services()->fileio());
  FILE* f = GLOBAL_boot_services()->fileio()->FOpen(path);
  RT_ASSERT(f);
  return f;
}


bool OS::Remove(const char* path) {
  return true;
}


bool OS::isDirectorySeparator(const char ch) {
  return ch == '/';
}


FILE* OS::OpenTemporaryFile() {
  RT_ASSERT(!"tmptile()");
  return nullptr;
}


const char* const OS::LogFileOpenMode = "w";


void OS::Print(const char* format, ...) {
  va_list args;
  va_start(args, format);
  VPrint(format, args);
  va_end(args);
}


void OS::VPrint(const char* format, va_list args) {
  vprintf(format, args);
}


void OS::FPrint(FILE* out, const char* format, ...) {
  va_list args;
  va_start(args, format);
  VFPrint(out, format, args);
  va_end(args);
}


void OS::VFPrint(FILE* out, const char* format, va_list args) {
  vfprintf(out, format, args);
}


void OS::PrintError(const char* format, ...) {
  va_list args;
  va_start(args, format);
  VPrintError(format, args);
  va_end(args);
}


void OS::VPrintError(const char* format, va_list args) {
  vfprintf(stderr, format, args);
}


int OS::SNPrintF(char* str, int length, const char* format, ...) {
  va_list args;
  va_start(args, format);
  int result = VSNPrintF(str, length, format, args);
  va_end(args);
  return result;
}


int OS::VSNPrintF(char* str,
                  int length,
                  const char* format,
                  va_list args) {
  int n = vsnprintf(str, length, format, args);
  if (n < 0 || n >= length) {
    // If the length is zero, the assignment fails.
    if (length > 0)
      str[length - 1] = '\0';
    return -1;
  } else {
    return n;
  }
}


char* OS::StrChr(char* str, int c) {
  return strchr(str, c);
}


void OS::StrNCpy(char* dest, int length, const char* src, size_t n) {
  strncpy(dest, src, n);
}


std::vector<OS::SharedLibraryAddress> OS::GetSharedLibraryAddresses() {
  return std::vector<OS::SharedLibraryAddress>();
}


int OS::ActivationFrameAlignment() {
  return 16;
}

class TimezoneCache {};


TimezoneCache* OS::CreateTimezoneCache() {
  return NULL;
}


void OS::DisposeTimezoneCache(TimezoneCache* cache) {
  RT_ASSERT(cache == NULL);
}


void OS::ClearTimezoneCache(TimezoneCache* cache) {
  RT_ASSERT(cache == NULL);
}


const char* OS::LocalTimezone(double time, TimezoneCache* cache) {
  // TODO: implement timezones
  return "GMT";
}

double OS::LocalTimeOffset(TimezoneCache* cache) {
  // TODO: implement timezones
  return 0;
}

size_t OS::AllocateAlignment() {
  return 4 * 1024;
}


void* OS::Allocate(const size_t requested,
                   size_t* allocated,
                   bool is_executable) {
  const size_t msize = RoundUp(requested, AllocateAlignment());
  void* mbase = memalign(AllocateAlignment(), msize);
  *allocated = msize;
  return mbase;
}


void OS::Free(void* address, const size_t size) {
  free(address);
}


void OS::Sleep(v8::base::TimeDelta time_delta) {
  RT_ASSERT(!"Sleep() is not supported");
}


void OS::Abort() {
  abort();
}


void OS::DebugBreak() {
#if V8_HOST_ARCH_ARM
  asm("bkpt 0");
#elif V8_HOST_ARCH_ARM64
  asm("brk 0");
#elif V8_HOST_ARCH_MIPS
  asm("break");
#elif V8_HOST_ARCH_IA32
#if defined(__native_client__)
  asm("hlt");
#else
  asm("int $3");
#endif  // __native_client__
#elif V8_HOST_ARCH_X64
  asm("int $3");
#else
#error Unsupported host architecture.
#endif
}


class RuntimeJSMemoryMappedFile : public OS::MemoryMappedFile {
 public:
  RuntimeJSMemoryMappedFile(FILE* file, void* memory, int size)
    : file_(file), memory_(memory), size_(size) { }
  virtual ~RuntimeJSMemoryMappedFile();
  virtual void* memory() { return memory_; }
  virtual int size() { return size_; }
 private:
  FILE* file_;
  void* memory_;
  int size_;
};


OS::MemoryMappedFile* OS::MemoryMappedFile::open(const char* name) {
  RT_ASSERT(!"MemoryMappedFile is not supported");
  return nullptr;
}


OS::MemoryMappedFile* OS::MemoryMappedFile::create(const char* name, size_t size,
    void* initial) {
  RT_ASSERT(!"MemoryMappedFile is not supported");
  return nullptr;
}


RuntimeJSMemoryMappedFile::~RuntimeJSMemoryMappedFile() {}


void OS::SignalCodeMovingGC() {
}


VirtualMemory::VirtualMemory() : address_(NULL), size_(0) { }


VirtualMemory::VirtualMemory(size_t size)
    : address_(ReserveRegion(size)), size_(size) { }


VirtualMemory::VirtualMemory(size_t size, size_t alignment)
    : address_(NULL), size_(0) {
  DCHECK((alignment % OS::AllocateAlignment()) == 0);
  size_t request_size = RoundUp(size + alignment,
                                static_cast<intptr_t>(OS::AllocateAlignment()));

  void* reservation = memalign(alignment, request_size);
  uint8_t* base = static_cast<uint8_t*>(reservation);
  uint8_t* aligned_base = RoundUp(base, alignment);
  RT_ASSERT(base == aligned_base);

  address_ = reservation;
  size_ = request_size;
}


VirtualMemory::~VirtualMemory() {
  if (IsReserved()) {
    bool result = ReleaseRegion(address(), size());
    RT_ASSERT(result);
    USE(result);
  }
}


bool VirtualMemory::IsReserved() {
  return address_ != NULL;
}


void VirtualMemory::Reset() {
  address_ = NULL;
  size_ = 0;
}


bool VirtualMemory::Commit(void* address, size_t size, bool is_executable) {
  return true;
}


bool VirtualMemory::Uncommit(void* address, size_t size) {
  return true;
}


bool VirtualMemory::Guard(void* address) {
  OS::Guard(address, OS::CommitPageSize());
  return true;
}


void* VirtualMemory::ReserveRegion(size_t size) {
  void* addr = memalign(0x200000, size);
  return addr;
}


bool VirtualMemory::CommitRegion(void* base, size_t size, bool is_executable) {
  return true;
}


bool VirtualMemory::UncommitRegion(void* base, size_t size) {
  return true;
}


bool VirtualMemory::ReleaseRegion(void* base, size_t size) {
  free(base);
  return true;
}


bool VirtualMemory::HasLazyCommits() {
  return false;
}


class Thread::PlatformData {
 public:
  PlatformData() : thread_() {}
  rt::NativeThread* thread_;
};


Thread::Thread(const Options& options)
    : data_(new PlatformData()),
      stack_size_(options.stack_size()),
      start_semaphore_(NULL) {
  set_name(options.name());
}


Thread::~Thread() {
  delete data_;
}


static void* ThreadEntry(void* arg) {
  Thread* thread = reinterpret_cast<Thread*>(arg);
  thread->NotifyStartedAndRun();
  return NULL;
}


void Thread::set_name(const char* name) {
  strncpy(name_, name, sizeof(name_));
  name_[sizeof(name_) - 1] = '\0';
}


void Thread::Start() {
  RT_ASSERT(!"Thread::Start");
  // TODO: implement native threads
  return;
  RT_ASSERT(!"Thread::Start");
}


void Thread::Join() {
  // TODO: implement native threads
  return;
  RT_ASSERT(!"Thread::Join");
}


Thread::LocalStorageKey Thread::CreateThreadLocalKey() {
  uint64_t key = GLOBAL_keystorage()->NewKey();
  return static_cast<LocalStorageKey>(key);
}


void Thread::DeleteThreadLocalKey(LocalStorageKey key) {
  uint64_t storagekey = static_cast<int>(key);
  GLOBAL_keystorage()->DeleteKey(storagekey);
}


void* Thread::GetThreadLocal(LocalStorageKey key) {
  uint64_t storagekey = static_cast<int>(key);
  return GLOBAL_keystorage()->Get(storagekey);
}


void Thread::SetThreadLocal(LocalStorageKey key, void* value) {
  uint64_t storagekey = static_cast<int>(key);
  GLOBAL_keystorage()->Set(storagekey, value);
}


} }  // namespace v8::base
