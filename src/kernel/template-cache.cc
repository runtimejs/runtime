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

#include "template-cache.h"
#include <kernel/native-object.h>
#include <kernel/v8utils.h>
#include <kernel/native-fn.h>
#include <kernel/initrd.h>
#include <kernel/engines.h>
#include <kernel/initjs.h>

namespace rt {

TemplateCache::TemplateCache(v8::Isolate* iv8)
  :   iv8_(iv8) {
  RT_ASSERT(iv8_);
  v8::HandleScope scope(iv8_);

  {
    v8::Local<v8::FunctionTemplate> t { v8::FunctionTemplate::New(iv8_) };
    t->InstanceTemplate()->SetInternalFieldCount(1);
    wrapper_template_.Set(iv8_, t);
  }
}

v8::Local<v8::UnboundScript> TemplateCache::GetInitScript() {
  RT_ASSERT(iv8_);
  v8::Isolate* iv8 = iv8_;
  v8::EscapableHandleScope scope(iv8);
  LOCAL_V8STRING(s_init, "__init");

  v8::Local<v8::String> inits = v8::String::NewFromUtf8(iv8, INIT_JS,
                                v8::NewStringType::kNormal, sizeof(INIT_JS) - 1).ToLocalChecked();
  v8::ScriptCompiler::Source source(inits, v8::ScriptOrigin(s_init));
  v8::Local<v8::UnboundScript> script = v8::ScriptCompiler
                                        ::CompileUnboundScript(iv8, &source,
                                            v8::ScriptCompiler::CompileOptions::kNoCompileOptions).ToLocalChecked();

  return scope.Escape(script);
}

v8::Local<v8::Context> TemplateCache::NewContext() {
  RT_ASSERT(iv8_);

  v8::EscapableHandleScope scope(iv8_);
  if (global_object_template_.IsEmpty()) {
    v8::Local<v8::ObjectTemplate> global { v8::ObjectTemplate::New(iv8_) };

    global->Set(iv8_, "setImmediate",
                v8::FunctionTemplate::New(iv8_, NativesObject::SetImmediate));

    global->Set(iv8_, "setTimeout",
                v8::FunctionTemplate::New(iv8_, NativesObject::SetTimeout));
    global->Set(iv8_, "clearTimeout",
                v8::FunctionTemplate::New(iv8_, NativesObject::ClearTimer));

    global->Set(iv8_, "setInterval",
                v8::FunctionTemplate::New(iv8_, NativesObject::SetInterval));
    global->Set(iv8_, "clearInterval",
                v8::FunctionTemplate::New(iv8_, NativesObject::ClearTimer));

    {
      auto encoder = v8::FunctionTemplate::New(iv8_, NativesObject::TextEncoder);
      encoder->PrototypeTemplate()->Set(iv8_, "encode",
                                        v8::FunctionTemplate::New(iv8_, NativesObject::TextEncoderEncode));
      global->Set(iv8_, "TextEncoder", encoder);
    }

    {
      auto decoder = v8::FunctionTemplate::New(iv8_, NativesObject::TextDecoder);
      decoder->PrototypeTemplate()->Set(iv8_, "decode",
                                        v8::FunctionTemplate::New(iv8_, NativesObject::TextDecoderDecode));
      global->Set(iv8_, "TextDecoder", decoder);
    }

    // Functions implemented by runtime.js kernel
    v8::Local<v8::ObjectTemplate> syscall { v8::ObjectTemplate::New(iv8_) };
#define SET_SYSCALL(NAME, FN) syscall->Set(iv8_, NAME, v8::FunctionTemplate::New(iv8_, FN))
    // General
    SET_SYSCALL("log", NativesObject::Log);
    SET_SYSCALL("write", NativesObject::Write);
    SET_SYSCALL("eval", NativesObject::Eval);
    SET_SYSCALL("version", NativesObject::Version);
    SET_SYSCALL("getCommandLine", NativesObject::GetCommandLine);

    // Initrd FS access
    SET_SYSCALL("initrdReadFile", NativesObject::InitrdReadFile);
    SET_SYSCALL("initrdReadFileBuffer", NativesObject::InitrdReadFileBuffer);
    SET_SYSCALL("initrdListFiles", NativesObject::InitrdListFiles);
    SET_SYSCALL("initrdGetKernelIndex", NativesObject::InitrdGetKernelIndex);
    SET_SYSCALL("initrdGetAppIndex", NativesObject::InitrdGetAppIndex);

    // Profiler, debug and system info
    SET_SYSCALL("startProfiling", NativesObject::StartProfiling);
    SET_SYSCALL("stopProfiling", NativesObject::StopProfiling);
    SET_SYSCALL("debug", NativesObject::Debug);
    SET_SYSCALL("takeHeapSnapshot", NativesObject::TakeHeapSnapshot);
    SET_SYSCALL("memoryInfo", NativesObject::MemoryInfo);
    SET_SYSCALL("systemInfo", NativesObject::SystemInfo);
    SET_SYSCALL("reboot", NativesObject::Reboot);
    SET_SYSCALL("poweroff", NativesObject::Poweroff);
    SET_SYSCALL("exit", NativesObject::Exit);
    SET_SYSCALL("unrefTimer", NativesObject::UnrefTimer);

    // Low level system access
    SET_SYSCALL("bufferAddress", NativesObject::BufferAddress);
    SET_SYSCALL("memoryBarrier", NativesObject::MemoryBarrier);
    SET_SYSCALL("allocDMA", NativesObject::AllocDMA);
    SET_SYSCALL("getSystemResources", NativesObject::GetSystemResources);
    SET_SYSCALL("stopVideoLog", NativesObject::StopVideoLog);
    SET_SYSCALL("setTime", NativesObject::SetTime);

    // Temporary for init.js script
    SET_SYSCALL("_setPromiseHandlers", NativesObject::SetPromiseHandlers);

    // ACPI control bindings
    SET_SYSCALL("acpiGetPciDevices", NativesObject::AcpiGetPciDevices);
    SET_SYSCALL("acpiSystemReset", NativesObject::AcpiSystemReset);
    SET_SYSCALL("acpiEnterSleepState", NativesObject::AcpiEnterSleepState);
#undef SET_SYSCALL
    syscall->Set(iv8_, "onexit", v8::Null(iv8_));
    syscall->Set(iv8_, "onerror", v8::Null(iv8_));

    global->Set(iv8_, "__SYSCALL", syscall);

    // Global performance object
    v8::Local<v8::ObjectTemplate> performance { v8::ObjectTemplate::New(iv8_) };
    performance->Set(iv8_, "now", v8::FunctionTemplate::New(iv8_,
                     NativesObject::PerformanceNow));
    global->Set(iv8_, "performance", performance);

    global_object_template_.Set(iv8_, global);
  }

  v8::Local<v8::Context> context = v8::Context::New(iv8_, nullptr,
                                   global_object_template_.Get(iv8_));

  v8::Context::Scope cs(context);
  context->Global()->Set(context, v8::String::NewFromUtf8(iv8_,
                         "global", v8::NewStringType::kNormal).ToLocalChecked(), context->Global());

  if (init_script_.IsEmpty()) {
    init_script_.Set(iv8_, GetInitScript());
  }

  RT_ASSERT(!init_script_.IsEmpty());
  init_script_.Get(iv8_)->BindToCurrentContext()->Run(context).ToLocalChecked();
  return scope.Escape(context);
}

v8::Local<v8::Object> TemplateCache::NewWrappedObject(NativeObjectWrapper*
    nativeobj) {
  RT_ASSERT(nativeobj);
  RT_ASSERT(iv8_);
  v8::Local<v8::Context> context = iv8_->GetCurrentContext();
  v8::EscapableHandleScope scope(iv8_);
  v8::Local<v8::Object> obj = wrapper_template_.Get(iv8_)
                              ->InstanceTemplate()->NewInstance(context).ToLocalChecked();

  obj->SetAlignedPointerInInternalField(0,
                                        static_cast<NativeObjectWrapper*>(nativeobj));
  return scope.Escape(obj);
}

} // namespace rt
