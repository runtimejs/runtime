// Copyright 2014-2015 runtime.js project authors
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

#include "native-object.h"
#include <kernel/x64/io-x64.h>
#include <kernel/acpi-manager.h>
#include <kernel/utils.h>
#include <kernel/v8utils.h>
#include <memory>
#include <accommon.h>
#include <acpi.h>
#include <kernel/engines.h>
#include <kernel/platform.h>
#include <kernel/version.h>
#include <kernel/heap-snapshot.h>
#include <v8-profiler.h>
#include <sodium.h>

namespace rt {

NATIVE_FUNCTION(NativesObject, MemoryBarrier) {
  __sync_synchronize();
}

NATIVE_FUNCTION(NativesObject, MemoryInfo) {
  PROLOGUE_NOTHIS;
  v8::HeapStatistics stat;
  iv8->GetHeapStatistics(&stat);

  size_t total = stat.total_heap_size();
  size_t used = stat.used_heap_size();

  size_t pm_total = GLOBAL_mem_manager()->physical_memory_total();
  size_t pm_used = GLOBAL_mem_manager()->physical_memory_used();

  LOCAL_V8STRING(s_heap_total, "heapTotal");
  LOCAL_V8STRING(s_heap_used, "heapUsed");
  LOCAL_V8STRING(s_pm_total, "pmTotal");
  LOCAL_V8STRING(s_pm_used, "pmUsed");
  LOCAL_V8STRING(s_buffers_size, "buffersSize");
  LOCAL_V8STRING(s_buffers_count, "buffersCount");

  v8::Local<v8::Object> obj = v8::Object::New(iv8);
  obj->Set(context, s_heap_total, v8::Number::New(iv8, total));
  obj->Set(context, s_heap_used, v8::Number::New(iv8, used));
  obj->Set(context, s_pm_total, v8::Number::New(iv8, pm_total));
  obj->Set(context, s_pm_used, v8::Number::New(iv8, pm_used));
  obj->Set(context, s_buffers_size, v8::Number::New(iv8, GLOBAL_engines()->buffers_size()));
  obj->Set(context, s_buffers_count, v8::Number::New(iv8, GLOBAL_engines()->buffers_count()));

  args.GetReturnValue().Set(obj);
}

NATIVE_FUNCTION(NativesObject, TakeHeapSnapshot) {
  PROLOGUE_NOTHIS;
  const v8::HeapSnapshot* snapshot = iv8->GetHeapProfiler()->TakeHeapSnapshot();
  RT_ASSERT(snapshot);
  HeapSnapshotStream stream;
  snapshot->Serialize(&stream, v8::HeapSnapshot::SerializationFormat::kJSON);
  const_cast<v8::HeapSnapshot*>(snapshot)->Delete();
  args.GetReturnValue().Set(stream.FetchBuffers(iv8));
}

NATIVE_FUNCTION(NativesObject, StartProfiling) {
  PROLOGUE_NOTHIS;
#ifdef RUNTIME_PROFILER
  printf("[PROFILER] started");
  GLOBAL_platform()->profiler().Enable();
#endif
}

NATIVE_FUNCTION(NativesObject, StopProfiling) {
  PROLOGUE_NOTHIS;
#ifdef RUNTIME_PROFILER
  printf("[PROFILER] stopped");
  GLOBAL_platform()->profiler().Disable();
#endif
}

NATIVE_FUNCTION(NativesObject, GetCommandLine) {
  PROLOGUE_NOTHIS;
  auto cmd = GLOBAL_platform()->GetCommandLine();
  v8::MaybeLocal<v8::String> maybe_string = v8::String::NewFromUtf8(iv8,
      cmd.c_str(), v8::NewStringType::kNormal);

  v8::Local<v8::String> string;
  if (!maybe_string.ToLocal(&string)) {
    return;
  }

  RT_ASSERT(!string.IsEmpty());
  args.GetReturnValue().Set(string);
}

NATIVE_FUNCTION(NativesObject, TextEncoderEncode) {
  PROLOGUE_NOTHIS;
  USEARG(0);
  v8::Local<v8::String> str = arg0->ToString(context).ToLocalChecked();
  int len = str->Utf8Length();
  RT_ASSERT(len >= 0);

  size_t buf_len = len;
  auto options = v8::String::WriteOptions::NO_NULL_TERMINATION;

  char* data = nullptr;
  if (0 != buf_len) {
    data = reinterpret_cast<char*>(GLOBAL_engines()->AllocateUninitializedBuffer(sizeof(char) * buf_len));
    str->WriteUtf8(data, buf_len, nullptr, options);
  }

  auto abv8 = v8::ArrayBuffer::New(iv8, data, buf_len, v8::ArrayBufferCreationMode::kInternalized);
  args.GetReturnValue().Set(v8::Uint8Array::New(abv8, 0, abv8->ByteLength()));
}

NATIVE_FUNCTION(NativesObject, TextDecoderDecode) {
  PROLOGUE_NOTHIS;
  USEARG(0);

  size_t offset = 0;
  size_t length = 0;
  v8::Local<v8::ArrayBuffer> buf;

  if (arg0->IsUint8Array()) {
    v8::Local<v8::Uint8Array> u8 = arg0.As<v8::Uint8Array>();
    buf = u8->Buffer();
    offset = u8->ByteOffset();
    length = u8->Length();
  } else if (arg0->IsArrayBuffer()) {
    buf = arg0.As<v8::ArrayBuffer>();
    length = buf->ByteLength();
  } else {
    THROW_ERROR("argument 0 is not an ArrayBuffer or Uint8Array");
  }

  RT_ASSERT(!buf.IsEmpty());

  if (0 == length) {
    args.GetReturnValue().SetEmptyString();
    return;
  }

  if (length > std::numeric_limits<int>::max()) {
    THROW_ERROR("buffer is too big");
  }

  v8::ArrayBuffer::Contents contents = buf->GetContents();
  uintptr_t dataPtr = reinterpret_cast<uintptr_t>(contents.Data()) + offset;

  v8::MaybeLocal<v8::String> maybe_str = v8::String::NewFromUtf8(iv8,
                                         reinterpret_cast<const char*>(dataPtr), v8::NewStringType::kNormal, length);
  v8::Local<v8::String> str;
  if (!maybe_str.ToLocal(&str)) {
    return;
  }

  RT_ASSERT(!str.IsEmpty());
  args.GetReturnValue().Set(str);
}

NATIVE_FUNCTION(NativesObject, TextEncoder) {
  PROLOGUE_NOTHIS;

  if (!args.IsConstructCall()) {
    THROW_ERROR("constructor cannot be called as a function");
  }

  // TODO: add other encodings
  LOCAL_V8STRING(s_encoding, "encoding");
  LOCAL_V8STRING(s_utf8, "utf-8");
  args.This()->Set(context, s_encoding, s_utf8);
}

NATIVE_FUNCTION(NativesObject, TextDecoder) {
  PROLOGUE_NOTHIS;

  if (!args.IsConstructCall()) {
    THROW_ERROR("constructor cannot be called as a function");
  }

  // TODO: add other encodings
  LOCAL_V8STRING(s_encoding, "encoding");
  LOCAL_V8STRING(s_utf8, "utf-8");
  args.This()->Set(context, s_encoding, s_utf8);
}

NATIVE_FUNCTION(NativesObject, ClearTimer) {
  PROLOGUE_NOTHIS;
  USEARG(0);
  args.GetReturnValue().Set(v8::Boolean::New(iv8,
                            th->FlagTimeoutCleared(arg0->Uint32Value(context).FromJust())));
}

uint32_t SetTimer(v8::Isolate* iv8, Thread* th,
                  v8::Local<v8::Value> cb, uint32_t delay, bool autoreset) {
  RT_ASSERT(iv8);
  RT_ASSERT(th);
  RT_ASSERT(!cb.IsEmpty());
  RT_ASSERT(cb->IsFunction());
  uint32_t index = th->AddTimeoutData(
                     TimeoutData(v8::UniquePersistent<v8::Value>(iv8, cb), delay, autoreset));

  RT_ASSERT(th->thread_manager());
  th->thread_manager()->SetTimeout(th, index, delay);
  return index;
}

NATIVE_FUNCTION(NativesObject, SetImmediate) {
  PROLOGUE_NOTHIS;
  USEARG(0);
  VALIDATEARG(0, FUNCTION, "setImmediate: argument 0 is not a function");

  uint32_t index { th->PutObject(v8::UniquePersistent<v8::Value>(iv8, arg0)) };

  {
    std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
                                         ThreadMessage::Type::SET_IMMEDIATE,
                                         ResourceHandle<EngineThread>(), TransportData(), nullptr, index));
    th->handle().getUnsafe()->PushMessage(std::move(msg));
  }
}

NATIVE_FUNCTION(NativesObject, SetTimeout) {
  PROLOGUE_NOTHIS;
  USEARG(0);
  USEARG(1);
  VALIDATEARG(0, FUNCTION, "setTimeout: argument 0 is not a function");
  args.GetReturnValue().Set(v8::Uint32::NewFromUnsigned(iv8,
                            SetTimer(iv8, th, arg0, arg1->Uint32Value(context).FromJust(), false)));
}

NATIVE_FUNCTION(NativesObject, SetInterval) {
  PROLOGUE_NOTHIS;
  USEARG(0);
  USEARG(1);
  VALIDATEARG(0, FUNCTION, "setInterval: argument 0 is not a function");
  args.GetReturnValue().Set(v8::Uint32::NewFromUnsigned(iv8,
                            SetTimer(iv8, th, arg0, arg1->Uint32Value(context).FromJust(), true)));
}

NATIVE_FUNCTION(NativesObject, Log) {
  PROLOGUE_NOTHIS;
  int argc = args.Length();
  for (int i = 0; i < argc; ++i) {
    v8::Local<v8::Value> v = args[i];
    v8::Local<v8::String> s = v->ToString(context).ToLocalChecked();

    uint32_t len = s->Length();

    uint8_t* buf = new uint8_t[len+1];
    s->WriteOneByte(buf, 0);
    printf("%s", buf);
    delete[] buf;

    if (i != argc - 1) {
      printf(" ");
    }
  }
  printf("\n");
  args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(NativesObject, Write) {
  PROLOGUE_NOTHIS;
  int argc = args.Length();
  for (int i = 0; i < argc; ++i) {
    v8::Local<v8::Value> v = args[i];
    v8::Local<v8::String> s = v->ToString(context).ToLocalChecked();

    uint32_t len = s->Length();

    uint8_t* buf = new uint8_t[len+1];
    s->WriteOneByte(buf, 0);
    printf("%s", buf);
    delete[] buf;

    if (i != argc - 1) {
      printf(" ");
    }
  }
  args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(NativesObject, InitrdReadFile) {
  PROLOGUE_NOTHIS;
  USEARG(0);
  VALIDATEARG(0, STRING, "argument 0 is not a string");

  v8::Local<v8::String> filename = arg0->ToString(context).ToLocalChecked();
  v8::String::Utf8Value filename_utf8(filename);
  const char* filename_buf = *filename_utf8;
  RT_ASSERT(filename_buf);

  InitrdFile file = GLOBAL_initrd()->Get(filename_buf);
  if (file.IsEmpty()) {
    args.GetReturnValue().SetNull();
    return;
  }

  v8::MaybeLocal<v8::String> text { v8::String::NewFromUtf8(iv8,
                                    reinterpret_cast<const char*>(file.Data()),
                                    v8::NewStringType::kNormal, file.Size())
                                  };

  args.GetReturnValue().Set(text.ToLocalChecked());
}

NATIVE_FUNCTION(NativesObject, InitrdReadFileBuffer) {
  PROLOGUE_NOTHIS;
  USEARG(0);
  VALIDATEARG(0, STRING, "argument 0 is not a string");

  v8::Local<v8::String> filename = arg0->ToString(context).ToLocalChecked();
  v8::String::Utf8Value filename_utf8(filename);
  const char* filename_buf = *filename_utf8;
  RT_ASSERT(filename_buf);

  InitrdFile file = GLOBAL_initrd()->Get(filename_buf);
  if (file.IsEmpty()) {
    args.GetReturnValue().SetNull();
    return;
  }

  // Create a copy of the original buffer because it can be modified
  void* buf = GLOBAL_engines()->AllocateUninitializedBuffer(file.Size());
  RT_ASSERT(buf);
  memcpy(buf, file.Data(), file.Size());

  // Let V8 manage buffer lifetime
  v8::Local<v8::ArrayBuffer> ab = v8::ArrayBuffer::New(iv8, buf, file.Size(),
    v8::ArrayBufferCreationMode::kInternalized);

  args.GetReturnValue().Set(v8::Uint8Array::New(ab, 0, file.Size()));
}

NATIVE_FUNCTION(NativesObject, InitrdGetKernelIndex) {
  PROLOGUE_NOTHIS;
  args.GetReturnValue().Set(v8::String::NewFromUtf8(iv8,
    GLOBAL_initrd()->runtime_index_name(), v8::NewStringType::kNormal).ToLocalChecked());
}

NATIVE_FUNCTION(NativesObject, InitrdListFiles) {
  PROLOGUE_NOTHIS;
  size_t files_count { GLOBAL_initrd()->files_count() };
  v8::Local<v8::Array> arr { v8::Array::New(iv8, files_count) };

  for (size_t i = 0; i < files_count; ++i) {
    InitrdFile file = GLOBAL_initrd()->GetByIndex(i);
    RT_ASSERT(!file.IsEmpty());
    arr->Set(context, i, v8::String::NewFromUtf8(iv8,
      file.Name(), v8::NewStringType::kNormal).ToLocalChecked());
  }

  args.GetReturnValue().Set(arr);
}

NATIVE_FUNCTION(NativesObject, SystemInfo) {
  PROLOGUE_NOTHIS;
  USEARG(0);

  auto obj = v8::Object::New(iv8);

  // TODO: add other counters
  {
    auto counters = v8::Array::New(iv8, 1);
    auto ticks = static_cast<uint32_t>(th->thread_manager()->ticks_count());
    counters->Set(context, 0, v8::Uint32::NewFromUnsigned(iv8, ticks));
    LOCAL_V8STRING(s_irq_counters, "irqCounters");
    obj->Set(context, s_irq_counters, counters);
  }

  {
    auto ev_count = static_cast<uint32_t>(th->thread_manager()->events_count());
    LOCAL_V8STRING(s_events_count, "eventsCount");
    obj->Set(context, s_events_count, v8::Uint32::NewFromUnsigned(iv8, ev_count));
  }

  args.GetReturnValue().Set(obj);
}

NATIVE_FUNCTION(NativesObject, BufferAddress) {
  PROLOGUE_NOTHIS;
  USEARG(0);
  VALIDATEARG(0, UINT8ARRAY, "bufferAddress: argument 0 is not a Uint8Array");
  RT_ASSERT(arg0->IsUint8Array());
  v8::Local<v8::Uint8Array> u8 = arg0.As<v8::Uint8Array>();
  v8::Local<v8::ArrayBuffer> buf = u8->Buffer();
  if (!u8->HasBuffer() || 0 == u8->ByteLength()) {
    THROW_ERROR("Uint8Array is empty");
  }

  v8::ArrayBuffer::Contents contents = buf->GetContents();
  uintptr_t vaddr = reinterpret_cast<uintptr_t>(contents.Data()) + u8->ByteOffset();
  void* ptr = GLOBAL_mem_manager()->VirtualToPhysicalAddress(reinterpret_cast<void*>(vaddr));

  size_t length = u8->ByteLength();
  uintptr_t pstart = reinterpret_cast<uintptr_t>(ptr);
  uintptr_t pend = pstart + length;
  uintptr_t pboundary = pend & ~0x1FFFFF;

  uint32_t high = static_cast<uint32_t>(pstart >> 32);
  uint32_t low = static_cast<uint32_t>(pstart & 0xffffffffull);

  auto arr = v8::Array::New(iv8, 6);
  arr->Set(context, 0, v8::Uint32::NewFromUnsigned(iv8, length));
  arr->Set(context, 1, v8::Uint32::NewFromUnsigned(iv8, low));
  arr->Set(context, 2, v8::Uint32::NewFromUnsigned(iv8, high));
  arr->Set(context, 3, v8::Uint32::NewFromUnsigned(iv8, 0));
  arr->Set(context, 4, v8::Uint32::NewFromUnsigned(iv8, 0));
  arr->Set(context, 5, v8::Uint32::NewFromUnsigned(iv8, 0));

  // Test if this buffer requires more than one physical page
  // Note: this does not handle buffers over 2MiB (larger
  // than a single page)
  if (pstart < pboundary) {
    size_t len1 = pboundary - pstart;
    size_t len2 = length - len1;
    uintptr_t vaddr2 = vaddr + len1;
    void* ptr2 = GLOBAL_mem_manager()->VirtualToPhysicalAddress(reinterpret_cast<void*>(vaddr2));
    uintptr_t pstart2 = reinterpret_cast<uintptr_t>(ptr2);
    uint32_t high2 = static_cast<uint32_t>(pstart2 >> 32);
    uint32_t low2 = static_cast<uint32_t>(pstart2 & 0xffffffffull);
    arr->Set(context, 0, v8::Uint32::NewFromUnsigned(iv8, len1));
    arr->Set(context, 3, v8::Uint32::NewFromUnsigned(iv8, len2));
    arr->Set(context, 4, v8::Uint32::NewFromUnsigned(iv8, low2));
    arr->Set(context, 5, v8::Uint32::NewFromUnsigned(iv8, high2));
  }

  args.GetReturnValue().Set(arr);
}

NATIVE_FUNCTION(NativesObject, GetSystemResources) {
  PROLOGUE_NOTHIS;

  LOCAL_V8STRING(s_memory_range, "memoryRange");
  LOCAL_V8STRING(s_io_range, "ioRange");
  LOCAL_V8STRING(s_irq_range, "irqRange");
  LOCAL_V8STRING(s_libsodium, "libsodium");

  v8::Local<v8::Object> obj = v8::Object::New(iv8);

  obj->Set(context, s_memory_range, (new ResourceMemoryRangeObject(Range<size_t>(0, 0xffffffff)))
           ->BindToTemplateCache(th->template_cache())
           ->GetInstance());

  obj->Set(context, s_io_range, (new ResourceIORangeObject(Range<uint16_t>(1, 0xffff)))
           ->BindToTemplateCache(th->template_cache())
           ->GetInstance());

  obj->Set(context, s_irq_range, (new ResourceIRQRangeObject(Range<uint8_t>(1, 255)))
           ->BindToTemplateCache(th->template_cache())
           ->GetInstance());

  obj->Set(context, s_libsodium, (new LibsodiumObject())
           ->BindToTemplateCache(th->template_cache())
           ->GetInstance());

  args.GetReturnValue().Set(obj);
}

NATIVE_FUNCTION(NativesObject, Eval) {
  PROLOGUE_NOTHIS;
  USEARG(0);
  USEARG(1);
  VALIDATEARG(0, STRING, "eval: argument 0 is not a string");

  v8::ScriptOrigin origin((!arg1.IsEmpty() && arg1->IsString())
                          ? arg1.As<v8::String>() : v8::String::Empty(iv8));

  v8::Local<v8::String> source_code = arg0.As<v8::String>();
  v8::ScriptCompiler::Source source(source_code, origin);
  v8::MaybeLocal<v8::Script> maybe_script = v8::ScriptCompiler::Compile(context, &source,
      v8::ScriptCompiler::CompileOptions::kNoCompileOptions);

  v8::Local<v8::Script> script;
  if (!maybe_script.ToLocal(&script)) {
    return;
  }

  RT_ASSERT(!script.IsEmpty());
  v8::MaybeLocal<v8::Value> maybe_result = script->Run(context);
  v8::Local<v8::Value> result;
  if (!maybe_result.ToLocal(&result)) {
    return;
  }

  RT_ASSERT(!result.IsEmpty());
  args.GetReturnValue().Set(result);
}

NATIVE_FUNCTION(NativesObject, Version) {
  PROLOGUE_NOTHIS;

  auto obj = v8::Object::New(iv8);
  LOCAL_V8STRING(s_kernel, "kernel");
  LOCAL_V8STRING(s_v8, "v8");
  LOCAL_V8STRING(s_v8ver, v8::V8::GetVersion());
  obj->Set(context, s_kernel, v8::Uint32::NewFromUnsigned(iv8, Version::getVersionNumber()));
  obj->Set(context, s_v8, s_v8ver);

  args.GetReturnValue().Set(obj);
}

NATIVE_FUNCTION(NativesObject, Reboot) {
  PROLOGUE_NOTHIS;
  GLOBAL_platform()->Reboot();
  Cpu::HangSystem();
}

void PrintMemory(void* buf, size_t offset, size_t size) {
  uint8_t* p = reinterpret_cast<uint8_t*>(buf);
  size_t counter = 0;
  for (size_t i = offset; i < size; ++i) {
    ++counter;
    printf("0x%02x ", p[i]);
    if (0 == counter % 16) {
      printf("\n");
    } else if (0 == counter % 8) {
      printf("| ");
    }
  }
  printf("\n");
}

NATIVE_FUNCTION(NativesObject, Debug) {
  PROLOGUE_NOTHIS;
  USEARG(0);

  printf(" --- DEBUG --- \n");
}

NATIVE_FUNCTION(NativesObject, PerformanceNow) {
  PROLOGUE_NOTHIS;
  double value = GLOBAL_platform()->BootTimeMicroseconds() / 1000.0;
  args.GetReturnValue().Set(v8::Number::New(iv8, value));
}

NATIVE_FUNCTION(NativesObject, StopVideoLog) {
  PROLOGUE_NOTHIS;
  GLOBAL_boot_services()->logger()->DisableVideo();
}

NATIVE_FUNCTION(NativesObject, SetTime) {
  PROLOGUE_NOTHIS;
  USEARG(0);
  VALIDATEARG(0, NUMBER, "argument 0 is not a number value");
  uint64_t val = (arg0.As<v8::Number>())->Value();
  GLOBAL_platform()->SetTimeMicroseconds(val);
  args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(IoPortX64Object, Write8) {
  PROLOGUE;
  USEARG(0);
  VALIDATEARG(0, UINT32, "argument 0 is not a uint32 number value");
  uint8_t value = (arg0.As<v8::Uint32>())->Value() & 0xFF;
  IoPortsX64::OutB(that->port_number_, value);
  args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(IoPortX64Object, Write16) {
  PROLOGUE;
  USEARG(0);
  VALIDATEARG(0, UINT32, "argument 0 is not a uint32 number value");
  uint16_t value = (arg0.As<v8::Uint32>())->Value() & 0xFFFF;
  IoPortsX64::OutW(that->port_number_, value);
  args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(IoPortX64Object, Write32) {
  PROLOGUE;
  USEARG(0);
  VALIDATEARG(0, UINT32, "argument 0 is not a uint32 number value");
  uint32_t value = (arg0.As<v8::Uint32>())->Value();
  IoPortsX64::OutDW(that->port_number_, value);
  args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(IoPortX64Object, Read8) {
  PROLOGUE;
  uint8_t value = IoPortsX64::InB(that->port_number_);
  args.GetReturnValue().Set(static_cast<uint32_t>(value));
}

NATIVE_FUNCTION(IoPortX64Object, Read16) {
  PROLOGUE;
  uint16_t value = IoPortsX64::InW(that->port_number_);
  args.GetReturnValue().Set(static_cast<uint32_t>(value));
}

NATIVE_FUNCTION(IoPortX64Object, Read32) {
  PROLOGUE;
  uint32_t value = IoPortsX64::InDW(that->port_number_);
  args.GetReturnValue().Set(static_cast<uint32_t>(value));
}

NATIVE_FUNCTION(AcpiHandleObject, IsRootBridge) {
  PROLOGUE;
  ACPI_DEVICE_INFO* devinfo = that->GetInfo();
  RT_ASSERT(devinfo);
  args.GetReturnValue().Set(v8::Boolean::New(iv8, devinfo->Flags & ACPI_PCI_ROOT_BRIDGE));
}

NATIVE_FUNCTION(AcpiHandleObject, IsDevice) {
  PROLOGUE;
  ACPI_DEVICE_INFO* devinfo = that->GetInfo();
  RT_ASSERT(devinfo);

  if (0 == (ACPI_VALID_ADR & devinfo->Valid)) {
    args.GetReturnValue().Set(v8::False(iv8));
    return;
  }

  if (ACPI_TYPE_DEVICE != devinfo->Type) {
    args.GetReturnValue().Set(v8::False(iv8));
    return;
  }

  args.GetReturnValue().Set(v8::True(iv8));
}

NATIVE_FUNCTION(AcpiHandleObject, Address) {
  PROLOGUE;
  ACPI_DEVICE_INFO* devinfo = that->GetInfo();
  RT_ASSERT(devinfo);
  args.GetReturnValue().Set(v8::Uint32::New(iv8, devinfo->Address & 0xffffffff));
}

NATIVE_FUNCTION(AcpiHandleObject, Parent) {
  PROLOGUE;
  ACPI_HANDLE parent_handle;
  ACPI_STATUS s = AcpiGetParent(that->handle_, &parent_handle);

  if (ACPI_FAILURE(s)) {
    args.GetReturnValue().Set(v8::Null(iv8));
  }

  args.GetReturnValue().Set((new AcpiHandleObject(parent_handle))
                            ->BindToTemplateCache(th->template_cache())
                            ->GetInstance());
}

NATIVE_FUNCTION(AcpiHandleObject, HardwareId) {
  PROLOGUE;
  ACPI_DEVICE_INFO* devinfo = that->GetInfo();
  RT_ASSERT(devinfo);
  char* hwid { devinfo->HardwareId.String };
  uint32_t len = devinfo->HardwareId.Length;

  if (nullptr == hwid || 0 == len) {
    args.GetReturnValue().Set(v8::String::Empty(iv8));
    return;
  }

  RT_ASSERT(len > 0);
  RT_ASSERT('\0' == hwid[len - 1]);
  args.GetReturnValue().Set(v8::String::NewFromUtf8(iv8, hwid,
                            v8::NewStringType::kNormal, len - 1).ToLocalChecked());
}

class WalkResourcesIrqContext {
public:
  WalkResourcesIrqContext(AcpiPciIrqRoutingTable* routes,
                          uint8_t device, uint8_t pin, uint8_t source_index)
    : _routes(routes),
      _device(device),
      _pin(pin),
      _source_index(source_index) {
    RT_ASSERT(_routes);
  }
  AcpiPciIrqRoutingTable* routes() const {
    return _routes;
  }
  uint8_t device() const {
    return _device;
  }
  uint8_t pin() const {
    return _pin;
  }
  uint8_t source_index() const {
    return _source_index;
  }
private:
  AcpiPciIrqRoutingTable* _routes;
  uint8_t _device;
  uint8_t _pin;
  uint8_t _source_index;
};

ACPI_STATUS WalkResourcesCallback(ACPI_RESOURCE* res, void* context) {
  RT_ASSERT(res);
  RT_ASSERT(context);
  WalkResourcesIrqContext* ct = reinterpret_cast<WalkResourcesIrqContext*>(context);
  RT_ASSERT(ct);
  RT_ASSERT(ct->routes());

  switch (res->Type) {
  case ACPI_RESOURCE_TYPE_IRQ: {
    ACPI_RESOURCE_IRQ* irq = &res->Data.Irq;
    if (nullptr == irq || 0 == irq->InterruptCount) {
      break;
    }
    RT_ASSERT(ct->source_index() < irq->InterruptCount);
    ct->routes()->AddRoute(AcpiPciIrqRoute(ct->device(), ct->pin(),
                                           irq->Interrupts[ct->source_index()]));
  }
  break;
  case ACPI_RESOURCE_TYPE_EXTENDED_IRQ: {
    ACPI_RESOURCE_EXTENDED_IRQ* irq = &res->Data.ExtendedIrq;
    if (nullptr == irq || 0 == irq->InterruptCount) {
      break;
    }
    RT_ASSERT(ct->source_index() < irq->InterruptCount);
    ct->routes()->AddRoute(AcpiPciIrqRoute(ct->device(), ct->pin(),
                                           irq->Interrupts[ct->source_index()]));
  }
  break;
  default:
    break;
  }

  return AE_OK;
}

NATIVE_FUNCTION(AcpiHandleObject, GetIrqRoutingTable) {
  PROLOGUE;
  const size_t kBufSize = 8192;
  std::array<char, kBufSize> databuf;
  RT_ASSERT(databuf.data());
  databuf.fill(0);

  RT_ASSERT(that->handle_);
  ACPI_BUFFER buf;
  buf.Length = kBufSize;
  buf.Pointer = databuf.data();
  ACPI_STATUS s = AcpiGetIrqRoutingTable(that->handle_, &buf);

  if (ACPI_FAILURE(s)) {
    printf("FAILLLL %s.\n", AcpiFormatException(s));
    args.GetReturnValue().Set(v8::Array::New(iv8, 0));
  }

  RT_ASSERT(buf.Pointer);
  RT_ASSERT(buf.Length > 0);

  AcpiPciIrqRoutingTable routes;

  ACPI_PCI_ROUTING_TABLE* table = reinterpret_cast<ACPI_PCI_ROUTING_TABLE*>(buf.Pointer);
  RT_ASSERT(table);
  for (; table->Length; table =
         reinterpret_cast<ACPI_PCI_ROUTING_TABLE*>(
           reinterpret_cast<uint8_t*>(table) + table->Length)) {

    RT_ASSERT(table);
    uint8_t device_id = table->Address >> 16;
    uint8_t func_id = table->Address & 0xFFFF;
    uint8_t pin = table->Pin;
    uint8_t source_index = table->SourceIndex;

    char* src = reinterpret_cast<char*>(table->Source);
    if ('\0' == src[0]) {
      routes.AddRoute(AcpiPciIrqRoute(device_id, pin, source_index));
      continue;
    }

    ACPI_HANDLE source;
    s = AcpiGetHandle(that->handle_, table->Source, &source);
    if (ACPI_FAILURE(s)) {
      printf("Failed AcpiGetHandle %s\n", AcpiFormatException(s));
      continue;
    }

    WalkResourcesIrqContext context(&routes, device_id, pin, source_index);
    char crs[] = "_CRS";
    s = AcpiWalkResources(source, crs, WalkResourcesCallback, &context);
    if (ACPI_FAILURE(s)) {
      printf("Failed IRQ resource\n");
      continue;
    }
  }

  LOCAL_V8STRING(str_device_id, "deviceId");
  LOCAL_V8STRING(str_irq, "irq");
  LOCAL_V8STRING(str_pin, "pin");

  v8::Local<v8::Array> arr = v8::Array::New(iv8, routes.size());
  for (size_t i = 0; i < routes.size(); ++i) {
    v8::Local<v8::Object> row = v8::Object::New(iv8);
    row->Set(context, str_device_id, v8::Uint32::New(iv8, routes.Get(i).device()));
    row->Set(context, str_irq, v8::Uint32::New(iv8, routes.Get(i).irq()));
    row->Set(context, str_pin, v8::Uint32::New(iv8, routes.Get(i).pin()));
    arr->Set(context, i, row);
  }

  args.GetReturnValue().Set(arr);
}

ACPI_STATUS WalkResourcesBusLookupCallback(ACPI_RESOURCE* res, void* context) {
  ACPI_RESOURCE_ADDRESS64 addr64;
  int32_t* bus = reinterpret_cast<int32_t*>(context);

  if ((res->Type != ACPI_RESOURCE_TYPE_ADDRESS16) &&
      (res->Type != ACPI_RESOURCE_TYPE_ADDRESS32) &&
      (res->Type != ACPI_RESOURCE_TYPE_ADDRESS64)) {
    return AE_OK;
  }

  if (ACPI_FAILURE(AcpiResourceToAddress64(res, &addr64))) {
    return AE_OK;
  }

  if (addr64.ResourceType != ACPI_BUS_NUMBER_RANGE) {
    return AE_OK;
  }

  if (*bus != -1) {
    return AE_ALREADY_EXISTS;
  }

  if (addr64.Minimum > 0xFFFF) {
    return AE_BAD_DATA;
  }

  *bus = (int32_t)addr64.Minimum;
  return AE_OK;
}

ACPI_STATUS EvalObjectTyped(ACPI_HANDLE handle, const char* pathname,
                            ACPI_OBJECT_LIST* external_params,
                            ACPI_BUFFER* return_buffer, ACPI_OBJECT_TYPE return_type) {

  RT_ASSERT(4 == strnlen(pathname, 5));
  char path[5];
  strncpy(path, pathname, 4);
  path[4] = '\0';
  return AcpiEvaluateObjectTyped(handle, path, external_params, return_buffer, return_type);
}

ACPI_STATUS EvalInteger(ACPI_HANDLE handle, const char* name, ACPI_INTEGER* ret) {
  RT_ASSERT(ret != nullptr);
  ACPI_STATUS as;
  char intbuf[sizeof(ACPI_OBJECT)];

  ACPI_BUFFER intbufobj;
  intbufobj.Length = sizeof(intbuf);
  intbufobj.Pointer = intbuf;

  as = EvalObjectTyped(handle, name, NULL, &intbufobj, ACPI_TYPE_INTEGER);
  if (ACPI_SUCCESS(as)) {
    ACPI_OBJECT* obj = reinterpret_cast<ACPI_OBJECT*>(intbufobj.Pointer);
    *ret = obj->Integer.Value;
  }

  return as;
}

ACPI_STATUS WalkResources(ACPI_HANDLE device_handle, const char* pathname,
                          ACPI_WALK_RESOURCE_CALLBACK user_function, void* context) {
  RT_ASSERT(4 == strnlen(pathname, 5));
  char path[5];
  strncpy(path, pathname, 4);
  path[4] = '\0';
  return AcpiWalkResources(device_handle, path, user_function, context);
}

NATIVE_FUNCTION(AcpiHandleObject, GetRootBridgeBusNumber) {
  PROLOGUE;

  // Method1: Use _BBN on root bridge
  ACPI_INTEGER busnum;
  ACPI_STATUS as = EvalInteger(that->handle_, "_BBN", &busnum);
  if (ACPI_SUCCESS(as)) {
    args.GetReturnValue().Set(v8::Uint32::New(iv8, busnum & 0xFF));
  }

  // Method2: Search for bus number in resources
  int32_t invalid_bus = -1;
  int32_t bus = invalid_bus;
  ACPI_STATUS s = WalkResources(that->handle_, "_CRS", WalkResourcesBusLookupCallback, &bus);
  if (ACPI_FAILURE(s) || invalid_bus == bus) {
    args.GetReturnValue().SetNull();
    return;
  }

  args.GetReturnValue().Set(v8::Uint32::New(iv8, s));
}

NATIVE_FUNCTION(NativesObject, AcpiEnterSleepState) {
  PROLOGUE_NOTHIS;
  USEARG(0);
  VALIDATEARG(0, UINT32, "argument 0 is not a uint32 number value");
  GLOBAL_platform()->EnterSleepState(arg0.As<v8::Uint32>()->Value());
}

NATIVE_FUNCTION(NativesObject, AcpiSystemReset) {
  PROLOGUE_NOTHIS;
  AcpiReset();
}

NATIVE_FUNCTION(NativesObject, AcpiGetPciDevices) {
  PROLOGUE_NOTHIS;
  AcpiManager* acpi = GLOBAL_engines()->acpi_manager();
  RT_ASSERT(acpi);
  AcpiObjectsList list = acpi->GetPciDevices();
  v8::Local<v8::Array> arr = v8::Array::New(iv8, list.size());

  for (size_t i = 0; i < list.size(); ++i) {
    arr->Set(context, i, (new AcpiHandleObject(list.Get(i)))
             ->BindToTemplateCache(th->template_cache())
             ->GetInstance());
  }

  args.GetReturnValue().Set(arr);
}

NATIVE_FUNCTION(ResourceMemoryRangeObject, Begin) {
  PROLOGUE;
  auto begin = that->memory_range_.begin();
  RT_ASSERT(Utils::IsSafeDouble(begin));
  args.GetReturnValue().Set(v8::Number::New(iv8, begin));
}

NATIVE_FUNCTION(ResourceMemoryRangeObject, End) {
  PROLOGUE;
  auto end = that->memory_range_.end();
  RT_ASSERT(Utils::IsSafeDouble(end));
  args.GetReturnValue().Set(v8::Number::New(iv8, end));
}

NATIVE_FUNCTION(ResourceMemoryRangeObject, Subrange) {
  PROLOGUE;
  USEARG(0);
  USEARG(1);
  VALIDATEARG(0, NUMBER, "subrange: argument 0 is not a number");
  VALIDATEARG(1, NUMBER, "subrange: argument 1 is not a number");

  auto begin = static_cast<size_t>(arg0.As<v8::Number>()->Value());
  auto end = static_cast<size_t>(arg1.As<v8::Number>()->Value());

  if (begin > end) {
    THROW_RANGE_ERROR("subrange: invalid range (begin > end)");
  }

  Range<size_t> subrange(begin, end);
  if (!subrange.IsSubrangeOf(that->memory_range_)) {
    THROW_RANGE_ERROR("subrange: invalid range (out of bounds)");
  }

  args.GetReturnValue().Set((new ResourceMemoryRangeObject(subrange))
                            ->BindToTemplateCache(th->template_cache())
                            ->GetInstance());
}

NATIVE_FUNCTION(ResourceMemoryRangeObject, Block) {
  PROLOGUE;
  USEARG(0);
  USEARG(1);
  VALIDATEARG(0, NUMBER, "block: argument 0 is not a number");
  VALIDATEARG(1, NUMBER, "block: argument 1 is not a number");

  auto base = static_cast<uint64_t>(arg0->NumberValue(context).FromJust());
  auto size = static_cast<uint32_t>(arg1->Uint32Value(context).FromJust());

  Range<size_t> subrange(base, base + size);
  if (!subrange.IsSubrangeOf(that->memory_range_)) {
    THROW_RANGE_ERROR("block: out of bounds");
  }

  args.GetReturnValue().Set((new ResourceMemoryBlockObject(
                               MemoryBlock<uint32_t>(reinterpret_cast<void*>(base), size)))
                            ->BindToTemplateCache(th->template_cache())
                            ->GetInstance());
}

NATIVE_FUNCTION(ResourceIORangeObject, Begin) {
  PROLOGUE;
  auto begin = that->io_range_.begin();
  args.GetReturnValue().Set(v8::Uint32::New(iv8, begin));
}

NATIVE_FUNCTION(ResourceIORangeObject, End) {
  PROLOGUE;
  auto end = that->io_range_.end();
  args.GetReturnValue().Set(v8::Uint32::New(iv8, end));
}

NATIVE_FUNCTION(ResourceIORangeObject, Subrange) {
  PROLOGUE;
  USEARG(0);
  USEARG(1);
  VALIDATEARG(0, NUMBER, "subrange: argument 0 is not a number");
  VALIDATEARG(1, NUMBER, "subrange: argument 1 is not a number");

  auto begin = static_cast<uint32_t>(arg0->Uint32Value(context).FromJust());
  auto end = static_cast<uint32_t>(arg1->Uint32Value(context).FromJust());

  if (begin > end) {
    THROW_RANGE_ERROR("subrange: invalid range (begin > end)");
  }

  Range<uint16_t> subrange(begin, end);
  if (!subrange.IsSubrangeOf(that->io_range_)) {
    THROW_RANGE_ERROR("subrange: invalid range (out of bounds)");
  }

  args.GetReturnValue().Set((new ResourceIORangeObject(subrange))
                            ->BindToTemplateCache(th->template_cache())
                            ->GetInstance());
}

NATIVE_FUNCTION(ResourceIORangeObject, Port) {
  PROLOGUE;
  USEARG(0);
  VALIDATEARG(0, NUMBER, "port: argument 0 is not a number");

  auto number = arg0->Uint32Value(context).FromJust();
  if (!that->io_range_.Contains(number)) {
    THROW_RANGE_ERROR("port: invalid port number (required <= 0xffff)");
  }

  args.GetReturnValue().Set((new IoPortX64Object(number))
                            ->BindToTemplateCache(th->template_cache())
                            ->GetInstance());
}

NATIVE_FUNCTION(ResourceIORangeObject, OffsetPort) {
  PROLOGUE;
  USEARG(0);
  VALIDATEARG(0, NUMBER, "offsetPort: argument 0 is not a number");

  auto number = that->io_range_.begin() + arg0->Uint32Value(context).FromJust();
  if (!that->io_range_.Contains(number)) {
    THROW_RANGE_ERROR("offsetPort: port offset is out of range");
  }

//    printf("[OFFSET PORT] base = %d, offset = %d, result = %d\n",
//        that->io_range_.begin(), arg0->Uint32Value(), number);
  args.GetReturnValue().Set((new IoPortX64Object(number))
                            ->BindToTemplateCache(th->template_cache())
                            ->GetInstance());
}

NATIVE_FUNCTION(ResourceIRQRangeObject, Irq) {
  PROLOGUE;
  USEARG(0);
  VALIDATEARG(0, NUMBER, "irq: argument 0 is not a number");

  uint32_t number = arg0->Uint32Value(context).FromJust();
  if (!that->irq_range_.Contains(number)) {
    THROW_RANGE_ERROR("irq: irq number is out of range");
  }

  args.GetReturnValue().Set((new ResourceIRQObject(number))
                            ->BindToTemplateCache(th->template_cache())
                            ->GetInstance());
}

NATIVE_FUNCTION(ResourceIRQObject, On) {
  PROLOGUE;
  USEARG(0);
  VALIDATEARG(0, FUNCTION, "on: argument 0 is not a function");

  ResourceHandle<EngineThread> thread { th->handle() };
  RT_ASSERT(!thread.empty());

  auto irq_number = that->irq_number_;

  uint32_t index { th->PutObject(v8::UniquePersistent<v8::Value>(iv8, arg0)) };
  GLOBAL_platform()->irq_dispatcher().Bind(irq_number, thread, index);

#ifdef RUNTIME_DEBUG
  printf("[IRQ MANAGER] Bind %d (recv %d)\n", irq_number, index);
#endif
  args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(ResourceMemoryBlockObject, Buffer) {
  PROLOGUE;
  void* ptr = that->memory_block_.base();
  auto length = that->memory_block_.size();
  RT_ASSERT(ptr);
  RT_ASSERT(length > 0);
  auto abv8 = v8::ArrayBuffer::New(iv8, ptr, length, v8::ArrayBufferCreationMode::kExternalized);
  args.GetReturnValue().Set(abv8);
}

NATIVE_FUNCTION(ResourceMemoryBlockObject, Length) {
  PROLOGUE;
  auto length = that->memory_block_.size();
  args.GetReturnValue().Set(v8::Uint32::New(iv8, length));
}

NATIVE_FUNCTION(NativesObject, AllocDMA) {
  PROLOGUE_NOTHIS;

  LOCAL_V8STRING(s_address, "address");
  LOCAL_V8STRING(s_size, "size");
  LOCAL_V8STRING(s_buffer, "buffer");

  void* ptr { GLOBAL_mem_manager()->AllocPage32() };
  RT_ASSERT(ptr);

  size_t ptrvalue { reinterpret_cast<size_t>(ptr) };
  RT_ASSERT(ptrvalue == (ptrvalue & 0xffffffff));

  size_t size { GLOBAL_mem_manager()->page_size() };
  RT_ASSERT(size > 0);

#ifdef RUNTIME_DEBUG
  printf("DMA allocated = %p, size %d\n", ptr, size);
#endif
  // Clean DMA buffer
  memset(ptr, 0, size);

  v8::Local<v8::Object> ret { v8::Object::New(iv8) };
  ret->Set(context, s_address, v8::Uint32::New(iv8, static_cast<uint32_t>(ptrvalue)));
  ret->Set(context, s_size, v8::Uint32::New(iv8, static_cast<uint32_t>(size)));
  ret->Set(context, s_buffer, v8::ArrayBuffer::New(iv8, ptr, size,
           v8::ArrayBufferCreationMode::kExternalized));

  args.GetReturnValue().Set(ret);
}

NATIVE_FUNCTION(LibsodiumObject, RandombytesBuf) {
  PROLOGUE;
  USEARG(0);
  VALIDATEARG(0, NUMBER, "randombytes_buf: argument 0 is not a number.");

  v8::Local<v8::Number> bufNum = arg0->ToNumber(context).ToLocalChecked();
  unsigned long long bufLen = bufNum->Value();

  unsigned char buf[bufLen];
  randombytes_buf(buf, bufLen);

  char returnString[(sizeof(buf)/sizeof(unsigned char))*2 + 1];

  for (int i = 0; i < (sizeof(buf)/sizeof(unsigned char)); i++) {
    sprintf(&returnString[i*2], "%02X", buf[i]);
  }

  v8::MaybeLocal<v8::String> maybe_ret = v8::String::NewFromUtf8(iv8, returnString, v8::NewStringType::kNormal);

  v8::Local<v8::String> ret;
  if (!maybe_ret.ToLocal(&ret)) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  args.GetReturnValue().Set(ret);
}

NATIVE_FUNCTION(LibsodiumObject, BlakeHash) {
  PROLOGUE;
  USEARG(0);
  VALIDATEARG(0, OBJECT, "blake_hash: argument 0 is not a array/object");

  v8::Local<v8::Object> dataArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char dataBytes[(int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    dataBytes[i] = (unsigned char)dataArray->Get(i)->ToNumber()->Value();
  }

  unsigned char hash[crypto_generichash_BYTES];

  crypto_generichash(hash, sizeof hash, dataBytes, (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(), nullptr, 0);

  char returnString[(sizeof(hash)/sizeof(unsigned char))*2 + 1];

  for (int i = 0; i < (sizeof(hash)/sizeof(unsigned char)); i++) {
    sprintf(&returnString[i*2], "%02X", hash[i]);
  }

  v8::MaybeLocal<v8::String> maybe_ret = v8::String::NewFromUtf8(iv8, returnString, v8::NewStringType::kNormal);

  v8::Local<v8::String> ret;
  if (!maybe_ret.ToLocal(&ret)) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  args.GetReturnValue().Set(ret);
}

NATIVE_FUNCTION(LibsodiumObject, Sha256Hash) {
  PROLOGUE;
  USEARG(0);
  VALIDATEARG(0, OBJECT, "sha256_hash: argument 0 is not a object/array");

  v8::Local<v8::Object> dataArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char dataBytes[(int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    dataBytes[i] = (unsigned char)dataArray->Get(i)->ToNumber()->Value();
  }

  unsigned char hash[crypto_hash_sha256_BYTES];

  crypto_hash_sha256(hash, dataBytes, (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value());

  char returnString[(sizeof(hash)/sizeof(unsigned char))*2 + 1];

  for (int i = 0; i < (sizeof(hash)/sizeof(unsigned char)); i++) {
    sprintf(&returnString[i*2], "%02X", hash[i]);
  }

  v8::MaybeLocal<v8::String> maybe_ret = v8::String::NewFromUtf8(iv8, returnString, v8::NewStringType::kNormal);

  v8::Local<v8::String> ret;
  if (!maybe_ret.ToLocal(&ret)) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  args.GetReturnValue().Set(ret);
}

NATIVE_FUNCTION(LibsodiumObject, Sha512Hash) {
  PROLOGUE;
  USEARG(0);
  VALIDATEARG(0, OBJECT, "crypto_hash_sha512: argument 0 is not a array/object.");

  v8::Local<v8::Object> dataArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char dataBytes[(int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    dataBytes[i] = (unsigned char)dataArray->Get(i)->ToNumber()->Value();
  }

  unsigned char hash[crypto_hash_sha512_BYTES];

  crypto_hash_sha512(hash, dataBytes, (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value());

  char returnString[(sizeof(hash)/sizeof(unsigned char))*2 + 1];

  for (int i = 0; i < (sizeof(hash)/sizeof(unsigned char)); i++) {
    sprintf(&returnString[i*2], "%02X", hash[i]);
  }

  v8::MaybeLocal<v8::String> maybe_ret = v8::String::NewFromUtf8(iv8, returnString, v8::NewStringType::kNormal);

  v8::Local<v8::String> ret;
  if (!maybe_ret.ToLocal(&ret)) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  args.GetReturnValue().Set(ret);
}

NATIVE_FUNCTION(LibsodiumObject, Constants) {
  PROLOGUE;

  v8::Local<v8::Object> ret = v8::Object::New(iv8);
  LOCAL_V8STRING(s_crypto_secretbox_NONCEBYTES, "crypto_secretbox_NONCEBYTES");
  LOCAL_V8STRING(s_crypto_auth_BYTES, "crypto_auth_BYTES");
  LOCAL_V8STRING(s_crypto_auth_KEYBYTES, "crypto_auth_KEYBYTES");
  LOCAL_V8STRING(s_crypto_aead_chacha20poly1305_NPUBBYTES, "crypto_aead_chacha20poly1305_NPUBBYTES");
  //LOCAL_V8STRING(s_crypto_aead_aes256gcm_NPUBBYTES, "crypto_aead_aes256gcm_NPUBBYTES");
  LOCAL_V8STRING(s_crypto_box_NONCEBYTES, "crypto_box_NONCEBYTES");
  ret->Set(context, s_crypto_secretbox_NONCEBYTES, v8::Number::New(iv8, crypto_secretbox_NONCEBYTES));
  ret->Set(context, s_crypto_auth_BYTES, v8::Number::New(iv8, crypto_auth_BYTES));
  ret->Set(context, s_crypto_auth_KEYBYTES, v8::Number::New(iv8, crypto_auth_KEYBYTES));
  ret->Set(context, s_crypto_aead_chacha20poly1305_NPUBBYTES, v8::Number::New(iv8, crypto_aead_chacha20poly1305_NPUBBYTES));
  // "error: 'crypto_aead_aes256gcm_NPUBBYTES' was not declared in this scope"... why?
  //ret->Set(context, s_crypto_aead_aes256gcm_NPUBBYTES, v8::Number::New(iv8, crypto_aead_aes256gcm_NPUBBYTES));
  ret->Set(context, s_crypto_box_NONCEBYTES, v8::Number::New(iv8, crypto_box_NONCEBYTES));

  args.GetReturnValue().Set(ret);
}

NATIVE_FUNCTION(LibsodiumObject, SecretboxEasy) {
  PROLOGUE;
  USEARG(0);
  USEARG(1);
  USEARG(2);
  VALIDATEARG(0, OBJECT, "crypto_secretbox_easy: argument 0 is not an array/object.");
  VALIDATEARG(1, OBJECT, "crypto_secretbox_easy: argument 1 is not an array/object.");
  VALIDATEARG(2, OBJECT, "crypto_secretbox_easy: argument 2 is not an array/object.");

  v8::Local<v8::Object> dataArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char dataBytes[(int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    dataBytes[i] = (unsigned char)dataArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> keyArray = arg1->ToObject(context).ToLocalChecked();
  unsigned char keyBytes[(int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    keyBytes[i] = (unsigned char)keyArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> nonceArray = arg2->ToObject(context).ToLocalChecked();
  unsigned char nonceBytes[crypto_secretbox_NONCEBYTES];

  for (int i = 0; i < (int)nonceArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    nonceBytes[i] = (unsigned char)nonceArray->Get(i)->ToNumber()->Value();
  }

  unsigned char ciphertext[crypto_secretbox_MACBYTES + (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  crypto_secretbox_easy(ciphertext, dataBytes, (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(), nonceBytes, keyBytes);

  char returnString[(sizeof(ciphertext)/sizeof(unsigned char))*2 + 1];

  for (int i = 0; i < (sizeof(ciphertext)/sizeof(unsigned char)); i++) {
    sprintf(&returnString[i*2], "%02X", ciphertext[i]);
  }

  v8::MaybeLocal<v8::String> maybe_ret = v8::String::NewFromUtf8(iv8, returnString, v8::NewStringType::kNormal);

  v8::Local<v8::String> ret;
  if (!maybe_ret.ToLocal(&ret)) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  args.GetReturnValue().Set(ret);
}

NATIVE_FUNCTION(LibsodiumObject, SecretboxEasyOpen) {
  PROLOGUE;
  USEARG(0);
  USEARG(1);
  USEARG(2);
  VALIDATEARG(0, OBJECT, "crypto_secretbox_open_easy: argument 0 is not an array/object.");
  VALIDATEARG(1, OBJECT, "crypto_secretbox_open_easy: argument 1 is not an array/object.");
  VALIDATEARG(2, OBJECT, "crypto_secretbox_open_easy: argument 2 is not an array/object.");

  v8::Local<v8::Object> cipherArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char cipherBytes[(int)cipherArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)cipherArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    cipherBytes[i] = (unsigned char)cipherArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> keyArray = arg1->ToObject(context).ToLocalChecked();
  unsigned char keyBytes[(int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    keyBytes[i] = (unsigned char)keyArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> nonceArray = arg2->ToObject(context).ToLocalChecked();
  unsigned char nonceBytes[crypto_secretbox_NONCEBYTES];

  for (int i = 0; i < (int)nonceArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    nonceBytes[i] = (unsigned char)nonceArray->Get(i)->ToNumber()->Value();
  }

  unsigned char deciphertext[(int)cipherArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value() - crypto_secretbox_MACBYTES];

  if (crypto_secretbox_open_easy(deciphertext, cipherBytes, (int)cipherArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(), nonceBytes, keyBytes) != 0) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  char returnString[(sizeof(deciphertext)/sizeof(unsigned char))*2 + 1];

  for (int i = 0; i < (sizeof(deciphertext)/sizeof(unsigned char)); i++) {
    sprintf(&returnString[i*2], "%02X", deciphertext[i]);
  }

  v8::MaybeLocal<v8::String> maybe_ret = v8::String::NewFromUtf8(iv8, returnString, v8::NewStringType::kNormal);

  v8::Local<v8::String> ret;
  if (!maybe_ret.ToLocal(&ret)) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  args.GetReturnValue().Set(ret);
}

NATIVE_FUNCTION(LibsodiumObject, Auth) {
  PROLOGUE;
  USEARG(0);
  USEARG(1);
  VALIDATEARG(0, OBJECT, "crypto_auth: argument 0 is not an array/object.");
  VALIDATEARG(1, OBJECT, "crypto_auth: argument 1 is not an array/object.");

  v8::Local<v8::Object> dataArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char dataBytes[(int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    dataBytes[i] = (unsigned char)dataArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> keyArray = arg1->ToObject(context).ToLocalChecked();
  unsigned char keyBytes[(int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    keyBytes[i] = (unsigned char)keyArray->Get(i)->ToNumber()->Value();
  }

  unsigned char mac[crypto_auth_BYTES];

  crypto_auth(mac, dataBytes, (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(), keyBytes);

  char returnString[(sizeof(mac)/sizeof(unsigned char))*2 + 1];

  for (int i = 0; i < (sizeof(mac)/sizeof(unsigned char)); i++) {
    sprintf(&returnString[i*2], "%02X", mac[i]);
  }

  v8::MaybeLocal<v8::String> maybe_ret = v8::String::NewFromUtf8(iv8, returnString, v8::NewStringType::kNormal);

  v8::Local<v8::String> ret;
  if (!maybe_ret.ToLocal(&ret)) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  args.GetReturnValue().Set(ret);
}

NATIVE_FUNCTION(LibsodiumObject, AuthVerify) {
  PROLOGUE;
  USEARG(0);
  USEARG(1);
  USEARG(2);
  VALIDATEARG(0, OBJECT, "crypto_auth_verify: argument 0 is not an array/object.");
  VALIDATEARG(1, OBJECT, "crypto_auth_verify: argument 1 is not an array/object.");
  VALIDATEARG(2, OBJECT, "crypto_auth_verify: argument 2 is not an array/object.");

  v8::Local<v8::Object> macArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char macBytes[(int)macArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)macArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    macBytes[i] = (unsigned char)macArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> keyArray = arg1->ToObject(context).ToLocalChecked();
  unsigned char keyBytes[(int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    keyBytes[i] = (unsigned char)keyArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> dataArray = arg2->ToObject(context).ToLocalChecked();
  unsigned char dataBytes[(int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    dataBytes[i] = (unsigned char)dataArray->Get(i)->ToNumber()->Value();
  }

  if (crypto_auth_verify(macBytes, dataBytes, (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(), keyBytes) != 0) {
    args.GetReturnValue().Set(v8::Boolean::New(iv8, false));
    return;
  }

  args.GetReturnValue().Set(v8::Boolean::New(iv8, true));
}

NATIVE_FUNCTION(LibsodiumObject, AEADChaCha20Poly135Encrypt) {
  PROLOGUE;
  USEARG(0);
  USEARG(1);
  USEARG(2);
  USEARG(3);
  VALIDATEARG(0, OBJECT, "crypto_aead_chacha20poly1305_encrypt: argument 0 is not an array/object.");
  VALIDATEARG(1, OBJECT, "crypto_aead_chacha20poly1305_encrypt: argument 1 is not an array/object.");
  VALIDATEARG(2, OBJECT, "crypto_aead_chacha20poly1305_encrypt: argument 2 is not an array/object.");
  VALIDATEARG(3, OBJECT, "crypto_aead_chacha20poly1305_encrypt: argument 3 is not an array/object.");

  v8::Local<v8::Object> dataArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char dataBytes[(int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    dataBytes[i] = (unsigned char)dataArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> keyArray = arg1->ToObject(context).ToLocalChecked();
  unsigned char keyBytes[(int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    keyBytes[i] = (unsigned char)keyArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> nonceArray = arg2->ToObject(context).ToLocalChecked();
  unsigned char nonceBytes[crypto_secretbox_NONCEBYTES];

  for (int i = 0; i < (int)nonceArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    nonceBytes[i] = (unsigned char)nonceArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> addArray = arg3->ToObject(context).ToLocalChecked();
  unsigned char addBytes[(int)addArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)addArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    addBytes[i] = (unsigned char)addArray->Get(i)->ToNumber()->Value();
  }

  unsigned char ciphertext[crypto_aead_chacha20poly1305_ABYTES + (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];
  unsigned long long ciphertext_len;

  crypto_aead_chacha20poly1305_encrypt(ciphertext, &ciphertext_len, dataBytes, (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(), addBytes, (int)addArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(), NULL, nonceBytes, keyBytes);

  char returnString[(sizeof(ciphertext)/sizeof(unsigned char))*2 + 1];

  for (int i = 0; i < (sizeof(ciphertext)/sizeof(unsigned char)); i++) {
    sprintf(&returnString[i*2], "%02X", ciphertext[i]);
  }

  v8::MaybeLocal<v8::String> maybe_ret = v8::String::NewFromUtf8(iv8, returnString, v8::NewStringType::kNormal);

  v8::Local<v8::String> ret;
  if (!maybe_ret.ToLocal(&ret)) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  v8::Local<v8::Object> retObj = v8::Object::New(iv8);
  retObj->Set(context, v8::String::NewFromUtf8(iv8, "ciphertext", v8::NewStringType::kNormal).ToLocalChecked(), ret);
  retObj->Set(context, v8::String::NewFromUtf8(iv8, "ciphertext_len", v8::NewStringType::kNormal).ToLocalChecked(), v8::Number::New(iv8, ciphertext_len));

  args.GetReturnValue().Set(retObj);
}

NATIVE_FUNCTION(LibsodiumObject, AEADChaCha20Poly135Decrypt) {
  PROLOGUE;
  USEARG(0);
  USEARG(1);
  USEARG(2);
  USEARG(3);
  USEARG(4);
  VALIDATEARG(0, OBJECT, "crypto_aead_chacha20poly1305_decrypt: argument 0 is not an array/object.");
  VALIDATEARG(1, OBJECT, "crypto_aead_chacha20poly1305_decrypt: argument 1 is not an array/object.");
  VALIDATEARG(2, OBJECT, "crypto_aead_chacha20poly1305_decrypt: argument 2 is not an array/object.");
  VALIDATEARG(3, OBJECT, "crypto_aead_chacha20poly1305_decrypt: argument 3 is not an array/object.");
  VALIDATEARG(4, NUMBER, "crypto_aead_chacha20poly1305_decrypt: argument 4 is not a number.");

  v8::Local<v8::Object> cipherArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char cipherBytes[(int)cipherArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)cipherArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    cipherBytes[i] = (unsigned char)cipherArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> keyArray = arg1->ToObject(context).ToLocalChecked();
  unsigned char keyBytes[(int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    keyBytes[i] = (unsigned char)keyArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> nonceArray = arg2->ToObject(context).ToLocalChecked();
  unsigned char nonceBytes[crypto_secretbox_NONCEBYTES];

  for (int i = 0; i < (int)nonceArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    nonceBytes[i] = (unsigned char)nonceArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> addArray = arg3->ToObject(context).ToLocalChecked();
  unsigned char addBytes[(int)addArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)addArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    addBytes[i] = (unsigned char)addArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Number> ciphertextNum = arg4->ToNumber(context).ToLocalChecked();
  unsigned long long ciphertextLen = ciphertextNum->Value();

  unsigned char deciphertext[ciphertextLen - crypto_aead_chacha20poly1305_ABYTES];
  unsigned long long deciphertext_len;

  if (crypto_aead_chacha20poly1305_decrypt(deciphertext, &deciphertext_len, NULL, cipherBytes, ciphertextLen, addBytes, (int)addArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(), nonceBytes, keyBytes) != 0) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  char returnString[(sizeof(deciphertext)/sizeof(unsigned char))*2 + 1];

  for (int i = 0; i < (sizeof(deciphertext)/sizeof(unsigned char)); i++) {
    sprintf(&returnString[i*2], "%02X", deciphertext[i]);
  }

  v8::MaybeLocal<v8::String> maybe_ret = v8::String::NewFromUtf8(iv8, returnString, v8::NewStringType::kNormal);

  v8::Local<v8::String> ret;
  if (!maybe_ret.ToLocal(&ret)) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  v8::Local<v8::Object> retObj = v8::Object::New(iv8);
  retObj->Set(context, v8::String::NewFromUtf8(iv8, "deciphertext", v8::NewStringType::kNormal).ToLocalChecked(), ret);
  retObj->Set(context, v8::String::NewFromUtf8(iv8, "deciphertext_len", v8::NewStringType::kNormal).ToLocalChecked(), v8::Number::New(iv8, deciphertext_len));

  args.GetReturnValue().Set(retObj);
}

// AES-256 GCM isn't supported on QEMU's system-x86_64
// The JavaScript will automatically throw 'CPU not supported'
// plus, "crypto_aead_aes256gcm_* was not declared in this scope"... why?
/*NATIVE_FUNCTION(LibsodiumObject, AEADAES256GCMEncrypt) {
  PROLOGUE;
  if (crypto_aead_aes256gcm_is_available() == 0) {
    args.GetReturnValue().Set(v8::Exception::Error(v8::String::NewFromUtf8(iv8, "crypto_aead_aes256gcm_encrypt: CPU not supported", v8::NewStringType::kNormal).ToLocalChecked()));
    return;
  }
  USEARG(0);
  USEARG(1);
  USEARG(2);
  USEARG(3);
  VALIDATEARG(0, OBJECT, "crypto_aead_aes256gcm_encrypt: argument 0 is not an array/object.");
  VALIDATEARG(1, OBJECT, "crypto_aead_aes256gcm_encrypt: argument 1 is not an array/object.");
  VALIDATEARG(2, OBJECT, "crypto_aead_aes256gcm_encrypt: argument 2 is not an array/object.");
  VALIDATEARG(3, OBJECT, "crypto_aead_aes256gcm_encrypt: argument 3 is not an array/object.");
  v8::Local<v8::Object> dataArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char dataBytes[(int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];
  for (int i = 0; i < (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    dataBytes[i] = (unsigned char)dataArray->Get(i)->ToNumber()->Value();
  }
  v8::Local<v8::Object> keyArray = arg1->ToObject(context).ToLocalChecked();
  unsigned char keyBytes[(int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];
  for (int i = 0; i < (int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    keyBytes[i] = (unsigned char)keyArray->Get(i)->ToNumber()->Value();
  }
  v8::Local<v8::Object> nonceArray = arg2->ToObject(context).ToLocalChecked();
  unsigned char nonceBytes[crypto_secretbox_NONCEBYTES];
  for (int i = 0; i < (int)nonceArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    nonceBytes[i] = (unsigned char)nonceArray->Get(i)->ToNumber()->Value();
  }
  v8::Local<v8::Object> addArray = arg3->ToObject(context).ToLocalChecked();
  unsigned char addBytes[(int)addArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];
  for (int i = 0; i < (int)addArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    addBytes[i] = (unsigned char)addArray->Get(i)->ToNumber()->Value();
  }
  unsigned char ciphertext[crypto_aead_aes256gcm_ABYTES + (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];
  unsigned long long ciphertext_len;
  crypto_aead_aes256gcm_encrypt(ciphertext, &ciphertext_len, dataBytes, (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(), addBytes, (int)addArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(), NULL, nonceBytes, keyBytes);
  char returnString[(sizeof(ciphertext)/sizeof(unsigned char))*2 + 1];
  for (int i = 0; i < (sizeof(ciphertext)/sizeof(unsigned char)); i++) {
    sprintf(&returnString[i*2], "%02X", ciphertext[i]);
  }
  v8::MaybeLocal<v8::String> maybe_ret = v8::String::NewFromUtf8(iv8, returnString, v8::NewStringType::kNormal);
  v8::Local<v8::String> ret;
  if (!maybe_ret.ToLocal(&ret)) {
    args.GetReturnValue().SetUndefined();
    return;
  }
  v8::Local<v8::Object> retObj = v8::Object::New(iv8);
  retObj->Set(context, v8::String::NewFromUtf8(iv8, "ciphertext", v8::NewStringType::kNormal).ToLocalChecked(), ret);
  retObj->Set(context, v8::String::NewFromUtf8(iv8, "ciphertext_len", v8::NewStringType::kNormal).ToLocalChecked(), v8::Number::New(iv8, ciphertext_len));
  args.GetReturnValue().Set(retObj);
}
NATIVE_FUNCTION(LibsodiumObject, AEADAES256GCMDecrypt) {
  PROLOGUE;
  if (crypto_aead_aes256gcm_is_available() == 0) {
    args.GetReturnValue().Set(v8::Exception::Error(v8::String::NewFromUtf8(iv8, "crypto_aead_aes256gcm_decrypt: CPU not supported", v8::NewStringType::kNormal).ToLocalChecked()));
    return;
  }
  USEARG(0);
  USEARG(1);
  USEARG(2);
  USEARG(3);
  USEARG(4);
  VALIDATEARG(0, OBJECT, "crypto_aead_aes256gcm_decrypt: argument 0 is not an array/object.");
  VALIDATEARG(1, OBJECT, "crypto_aead_aes256gcm_decrypt: argument 1 is not an array/object.");
  VALIDATEARG(2, OBJECT, "crypto_aead_aes256gcm_decrypt: argument 2 is not an array/object.");
  VALIDATEARG(3, OBJECT, "crypto_aead_aes256gcm_decrypt: argument 3 is not an array/object.");
  VALIDATEARG(4, NUMBER, "crypto_aead_aes256gcm_decrypt: argument 4 is not a number.");
  v8::Local<v8::Object> cipherArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char cipherBytes[(int)cipherArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];
  for (int i = 0; i < (int)cipherArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    cipherBytes[i] = (unsigned char)cipherArray->Get(i)->ToNumber()->Value();
  }
  v8::Local<v8::Object> keyArray = arg1->ToObject(context).ToLocalChecked();
  unsigned char keyBytes[(int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];
  for (int i = 0; i < (int)keyArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    keyBytes[i] = (unsigned char)keyArray->Get(i)->ToNumber()->Value();
  }
  v8::Local<v8::Object> nonceArray = arg2->ToObject(context).ToLocalChecked();
  unsigned char nonceBytes[crypto_secretbox_NONCEBYTES];
  for (int i = 0; i < (int)nonceArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    nonceBytes[i] = (unsigned char)nonceArray->Get(i)->ToNumber()->Value();
  }
  v8::Local<v8::Object> addArray = arg3->ToObject(context).ToLocalChecked();
  unsigned char addBytes[(int)addArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];
  for (int i = 0; i < (int)addArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    addBytes[i] = (unsigned char)addArray->Get(i)->ToNumber()->Value();
  }
  v8::Local<v8::Number> ciphertextNum = arg4->ToNumber(context).ToLocalChecked();
  unsigned long long ciphertextLen = ciphertextNum->Value();
  unsigned char deciphertext[ciphertextLen - crypto_aead_aes256gcm_ABYTES];
  unsigned long long deciphertext_len;
  if (crypto_aead_aes256gcm_decrypt(deciphertext, &deciphertext_len, NULL, cipherBytes, ciphertextLen, addBytes, (int)addArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(), nonceBytes, keyBytes) != 0) {
    args.GetReturnValue().SetUndefined();
    return;
  }
  char returnString[(sizeof(deciphertext)/sizeof(unsigned char))*2 + 1];
  for (int i = 0; i < (sizeof(deciphertext)/sizeof(unsigned char)); i++) {
    sprintf(&returnString[i*2], "%02X", deciphertext[i]);
  }
  v8::MaybeLocal<v8::String> maybe_ret = v8::String::NewFromUtf8(iv8, returnString, v8::NewStringType::kNormal);
  v8::Local<v8::String> ret;
  if (!maybe_ret.ToLocal(&ret)) {
    args.GetReturnValue().SetUndefined();
    return;
  }
  v8::Local<v8::Object> retObj = v8::Object::New(iv8);
  retObj->Set(context, v8::String::NewFromUtf8(iv8, "deciphertext", v8::NewStringType::kNormal).ToLocalChecked(), ret);
  retObj->Set(context, v8::String::NewFromUtf8(iv8, "deciphertext_len", v8::NewStringType::kNormal).ToLocalChecked(), v8::Number::New(iv8, deciphertext_len));
  args.GetReturnValue().Set(retObj);
}*/

NATIVE_FUNCTION(LibsodiumObject, BoxEasy) {
  PROLOGUE;
  USEARG(0);
  USEARG(1);
  USEARG(2);
  USEARG(3);
  VALIDATEARG(0, OBJECT, "crypto_box_easy: argument 0 is not an array/object.");
  VALIDATEARG(1, OBJECT, "crypto_box_easy: argument 1 is not an array/object.");
  VALIDATEARG(2, OBJECT, "crypto_box_easy: argument 2 is not an array/object.");
  VALIDATEARG(3, OBJECT, "crypto_box_easy: argument 3 is not an array/object.");

  v8::Local<v8::Object> dataArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char dataBytes[(int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    dataBytes[i] = (unsigned char)dataArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> pkArray = arg1->ToObject(context).ToLocalChecked();
  unsigned char pkBytes[(int)pkArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)pkArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    pkBytes[i] = (unsigned char)pkArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> skArray = arg2->ToObject(context).ToLocalChecked();
  unsigned char skBytes[(int)skArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)skArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    skBytes[i] = (unsigned char)skArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> nonceArray = arg3->ToObject(context).ToLocalChecked();
  unsigned char nonceBytes[crypto_box_NONCEBYTES];

  for (int i = 0; i < (int)nonceArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    nonceBytes[i] = (unsigned char)nonceArray->Get(i)->ToNumber()->Value();
  }

  unsigned char ciphertext[crypto_box_MACBYTES + (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  crypto_box_easy(ciphertext, dataBytes, (int)dataArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(), nonceBytes, pkBytes, skBytes);

  char returnString[(sizeof(ciphertext)/sizeof(unsigned char))*2 + 1];

  for (int i = 0; i < (sizeof(ciphertext)/sizeof(unsigned char)); i++) {
    sprintf(&returnString[i*2], "%02X", ciphertext[i]);
  }

  v8::MaybeLocal<v8::String> maybe_ret = v8::String::NewFromUtf8(iv8, returnString, v8::NewStringType::kNormal);

  v8::Local<v8::String> ret;
  if (!maybe_ret.ToLocal(&ret)) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  args.GetReturnValue().Set(ret);
}

NATIVE_FUNCTION(LibsodiumObject, BoxEasyOpen) {
  PROLOGUE;
  USEARG(0);
  USEARG(1);
  USEARG(2);
  USEARG(3);
  VALIDATEARG(0, OBJECT, "crypto_box_open_easy: argument 0 is not an array/object.");
  VALIDATEARG(1, OBJECT, "crypto_box_open_easy: argument 1 is not an array/object.");
  VALIDATEARG(2, OBJECT, "crypto_box_open_easy: argument 2 is not an array/object.");
  VALIDATEARG(3, OBJECT, "crypto_box_open_easy: argument 3 is not an array/object.");

  v8::Local<v8::Object> cipherArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char cipherBytes[(int)cipherArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)cipherArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    cipherBytes[i] = (unsigned char)cipherArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> pkArray = arg1->ToObject(context).ToLocalChecked();
  unsigned char pkBytes[(int)pkArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)pkArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    pkBytes[i] = (unsigned char)pkArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> skArray = arg2->ToObject(context).ToLocalChecked();
  unsigned char skBytes[(int)skArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)skArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    skBytes[i] = (unsigned char)skArray->Get(i)->ToNumber()->Value();
  }

  v8::Local<v8::Object> nonceArray = arg3->ToObject(context).ToLocalChecked();
  unsigned char nonceBytes[crypto_box_NONCEBYTES];

  for (int i = 0; i < (int)nonceArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    nonceBytes[i] = (unsigned char)nonceArray->Get(i)->ToNumber()->Value();
  }

  unsigned char deciphertext[(int)cipherArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value() - crypto_box_MACBYTES];

  if (crypto_box_open_easy(deciphertext, cipherBytes, (int)cipherArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(), nonceBytes, pkBytes, skBytes) != 0) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  char returnString[(sizeof(deciphertext)/sizeof(unsigned char))*2 + 1];

  for (int i = 0; i < (sizeof(deciphertext)/sizeof(unsigned char)); i++) {
    sprintf(&returnString[i*2], "%02X", deciphertext[i]);
  }

  v8::MaybeLocal<v8::String> maybe_ret = v8::String::NewFromUtf8(iv8, returnString, v8::NewStringType::kNormal);

  v8::Local<v8::String> ret;
  if (!maybe_ret.ToLocal(&ret)) {
    args.GetReturnValue().SetUndefined();
    return;
  }

  args.GetReturnValue().Set(ret);
}

NATIVE_FUNCTION(LibsodiumObject, BoxKeypair) {
  PROLOGUE;

  unsigned char pk[crypto_box_PUBLICKEYBYTES];
  unsigned char sk[crypto_box_SECRETKEYBYTES];

  crypto_box_keypair(pk, sk);

  char returnString1[(sizeof(pk)/sizeof(unsigned char))*2 + 1];
  char returnString2[(sizeof(sk)/sizeof(unsigned char))*2 + 1];

  for (int i = 0; i < (sizeof(pk)/sizeof(unsigned char)); i++) {
    sprintf(&returnString1[i*2], "%02X", pk[i]);
  }

  for (int i = 0; i < (sizeof(sk)/sizeof(unsigned char)); i++) {
    sprintf(&returnString2[i*2], "%02X", sk[i]);
  }

  v8::MaybeLocal<v8::String> maybe_ret1 = v8::String::NewFromUtf8(iv8, returnString1, v8::NewStringType::kNormal);
  v8::MaybeLocal<v8::String> maybe_ret2 = v8::String::NewFromUtf8(iv8, returnString2, v8::NewStringType::kNormal);

  v8::Local<v8::String> ret1;
  v8::Local<v8::String> ret2;

  if (!maybe_ret1.ToLocal(&ret1)) {
    args.GetReturnValue().Set(v8::String::NewFromUtf8(iv8, "crypto_box_keypair: error creating public key", v8::NewStringType::kNormal).ToLocalChecked());
    return;
  }
  if (!maybe_ret2.ToLocal(&ret2)) {
    args.GetReturnValue().Set(v8::String::NewFromUtf8(iv8, "crypto_box_keypair: error creating secret key", v8::NewStringType::kNormal).ToLocalChecked());
    return;
  }

  v8::Local<v8::Object> retObj = v8::Object::New(iv8);
  retObj->Set(context, v8::String::NewFromUtf8(iv8, "public", v8::NewStringType::kNormal).ToLocalChecked(), ret1);
  retObj->Set(context, v8::String::NewFromUtf8(iv8, "secret", v8::NewStringType::kNormal).ToLocalChecked(), ret2);

  args.GetReturnValue().Set(retObj);
}

NATIVE_FUNCTION(LibsodiumObject, BoxSeedKeypair) {
  PROLOGUE;
  USEARG(0);
  VALIDATEARG(0, OBJECT, "crypto_box_seed_keypair: argument 0 is not an array/object.");

  v8::Local<v8::Object> seedArray = arg0->ToObject(context).ToLocalChecked();
  unsigned char seedBytes[(int)seedArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value()];

  for (int i = 0; i < (int)seedArray->Get(v8::String::NewFromUtf8(iv8, "length", v8::NewStringType::kNormal).ToLocalChecked())->ToNumber()->Value(); i++) {
    seedBytes[i] = (unsigned char)seedArray->Get(i)->ToNumber()->Value();
  }

  unsigned char pk[crypto_box_PUBLICKEYBYTES];
  unsigned char sk[crypto_box_SECRETKEYBYTES];

  crypto_box_seed_keypair(pk, sk, seedBytes);

  char returnString1[(sizeof(pk)/sizeof(unsigned char))*2 + 1];
  char returnString2[(sizeof(sk)/sizeof(unsigned char))*2 + 1];

  for (int i = 0; i < (sizeof(pk)/sizeof(unsigned char)); i++) {
    sprintf(&returnString1[i*2], "%02X", pk[i]);
  }

  for (int i = 0; i < (sizeof(sk)/sizeof(unsigned char)); i++) {
    sprintf(&returnString2[i*2], "%02X", sk[i]);
  }

  v8::MaybeLocal<v8::String> maybe_ret1 = v8::String::NewFromUtf8(iv8, returnString1, v8::NewStringType::kNormal);
  v8::MaybeLocal<v8::String> maybe_ret2 = v8::String::NewFromUtf8(iv8, returnString2, v8::NewStringType::kNormal);

  v8::Local<v8::String> ret1;
  v8::Local<v8::String> ret2;

  if (!maybe_ret1.ToLocal(&ret1)) {
    args.GetReturnValue().Set(v8::String::NewFromUtf8(iv8, "crypto_box_keypair: error creating public key", v8::NewStringType::kNormal).ToLocalChecked());
    return;
  }
  if (!maybe_ret2.ToLocal(&ret2)) {
    args.GetReturnValue().Set(v8::String::NewFromUtf8(iv8, "crypto_box_keypair: error creating secret key", v8::NewStringType::kNormal).ToLocalChecked());
    return;
  }

  v8::Local<v8::Object> retObj = v8::Object::New(iv8);
  retObj->Set(context, v8::String::NewFromUtf8(iv8, "public", v8::NewStringType::kNormal).ToLocalChecked(), ret1);
  retObj->Set(context, v8::String::NewFromUtf8(iv8, "secret", v8::NewStringType::kNormal).ToLocalChecked(), ret2);

  args.GetReturnValue().Set(retObj);
}

} // namespace rt
