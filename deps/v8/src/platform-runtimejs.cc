// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
#include "v8threads.h"
#include "vm-state-inl.h"
#include "codegen.h"

extern "C" int sched_yield(void);

namespace v8 {
namespace internal {


double ceiling(double x) {
  return ceil(x);
}

// Maximum size of the virtual memory.  0 means there is no artificial
// limit.
intptr_t OS::MaxVirtualMemory() {
    return 0;
}


intptr_t OS::CommitPageSize() {
  return 1024*4;
}


// Get rid of writable permission on code allocations.
void OS::ProtectCode(void* address, const size_t size) {
}


// Create guard pages.
void OS::Guard(void* address, const size_t size) {
}


void* OS::GetRandomMmapAddr() {
  return NULL;
}


double OS::nan_value() {
  // NAN from math.h is defined in C99 and not in POSIX.
  return NAN;
}


int OS::GetCurrentProcessId() {
  return 1;
}


int OS::GetUserTime(uint32_t* secs,  uint32_t* usecs) {
  *secs = static_cast<uint32_t>(1);
  *usecs = static_cast<uint32_t>(1);
  return 0;
}


double OS::TimeCurrentMillis() {
  return 1;
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


int OS::SNPrintF(Vector<char> str, const char* format, ...) {
  va_list args;
  va_start(args, format);
  int result = VSNPrintF(str, format, args);
  va_end(args);
  return result;
}


int OS::VSNPrintF(Vector<char> str,
                  const char* format,
                  va_list args) {
  int n = vsnprintf(str.start(), str.length(), format, args);
  if (n < 0 || n >= str.length()) {
    // If the length is zero, the assignment fails.
    if (str.length() > 0)
      str[str.length() - 1] = '\0';
    return -1;
  } else {
    return n;
  }
}


char* OS::StrChr(char* str, int c) {
  return strchr(str, c);
}


void OS::StrNCpy(Vector<char> dest, const char* src, size_t n) {
  strncpy(dest.start(), src, n);
}


void Thread::YieldCPU() {
  sched_yield();
}

void OS::PostSetUp() {
#if V8_TARGET_ARCH_IA32
  OS::MemMoveFunction generated_memmove = CreateMemMoveFunction();
  if (generated_memmove != NULL) {
    memmove_function = generated_memmove;
  }
#elif defined(V8_HOST_ARCH_ARM)
  OS::memcopy_uint8_function =
      CreateMemCopyUint8Function(&OS::MemCopyUint8Wrapper);
  OS::memcopy_uint16_uint8_function =
      CreateMemCopyUint16Uint8Function(&OS::MemCopyUint16Uint8Wrapper);
#endif
  // fast_exp is initialized lazily.
  init_fast_sqrt_function();
}


unsigned OS::CpuFeaturesImpliedByPlatform() {
  return 0;
}

int OS::ActivationFrameAlignment() {
  return 16;
}

class TimezoneCache {};


TimezoneCache* OS::CreateTimezoneCache() {
  return NULL;
}


void OS::DisposeTimezoneCache(TimezoneCache* cache) {
  ASSERT(cache == NULL);
}


void OS::ClearTimezoneCache(TimezoneCache* cache) {
  ASSERT(cache == NULL);
}


const char* OS::LocalTimezone(double time, TimezoneCache* cache) {
  RT_ASSERT(!"LocalTimezone");
  return nullptr;
}

double OS::LocalTimeOffset(TimezoneCache* cache) {
  RT_ASSERT(!"LocalTimeOffset");
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


void OS::Sleep(int milliseconds) {
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


OS::MemoryMappedFile* OS::MemoryMappedFile::create(const char* name, int size,
    void* initial) {
  RT_ASSERT(!"MemoryMappedFile is not supported");
  return nullptr;
}


RuntimeJSMemoryMappedFile::~RuntimeJSMemoryMappedFile() {}


void OS::LogSharedLibraryAddresses(Isolate* isolate) {
}


void OS::SignalCodeMovingGC() {
}


VirtualMemory::VirtualMemory() : address_(NULL), size_(0) { }


VirtualMemory::VirtualMemory(size_t size)
    : address_(ReserveRegion(size)), size_(size) { }


VirtualMemory::VirtualMemory(size_t size, size_t alignment)
    : address_(NULL), size_(0) {
  ASSERT(IsAligned(alignment, static_cast<intptr_t>(OS::AllocateAlignment())));
  size_t request_size = RoundUp(size + alignment,
                                static_cast<intptr_t>(OS::AllocateAlignment()));

  void* reservation = memalign(alignment, request_size);
  Address base = static_cast<Address>(reservation);
  Address aligned_base = RoundUp(base, alignment);
  ASSERT_EQ(base, aligned_base);

  address_ = reservation;
  size_ = request_size;
}


VirtualMemory::~VirtualMemory() {
  if (IsReserved()) {
    bool result = ReleaseRegion(address(), size());
    ASSERT(result);
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


class Thread::PlatformData : public Malloced {
 public:
  PlatformData() : thread_() {}
  rt::NativeThreadHandle thread_;
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
  ASSERT(!"Thread::Start");
}



void Thread::Join() {
  ASSERT(!"Thread::Join");
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


} }  // namespace v8::internal
