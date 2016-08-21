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

#pragma once
#include <kernel/kernel.h>
#include <kernel/object-wrapper.h>
#include <kernel/v8utils.h>
#include <kernel/template-cache.h>
#include <acpi.h>
#include <kernel/utils.h>

namespace rt {

class AcpiManager;

class NativesObject : public JsObjectWrapper<NativesObject,
  NativeTypeId::TYPEID_NATIVES> {
public:
  NativesObject() : JsObjectWrapper() {}

  // Browser globals
  DECLARE_NATIVE(SetTimeout);          // setTimeout
  DECLARE_NATIVE(SetImmediate);        // setImmediate
  DECLARE_NATIVE(SetInterval);         // setInterval
  DECLARE_NATIVE(PerformanceNow);      // performance.now()
  DECLARE_NATIVE(ClearTimer);          // clearTimeout/clearInterval

  // Browser TextEncoder/TextDecoder (https://encoding.spec.whatwg.org/)
  DECLARE_NATIVE(TextEncoder);         // new TextEncoder() handler
  DECLARE_NATIVE(TextEncoderEncode);   // TextEncoder#encode()
  DECLARE_NATIVE(TextDecoder);         // new TextDecoder() handler
  DECLARE_NATIVE(TextDecoderDecode);   // TextDecoder#decode()

  // runtime.js syscalls: General
  DECLARE_NATIVE(Log);                 // Log into serial port
  DECLARE_NATIVE(Write);               // Same, log into serial port, but without extra newline
  DECLARE_NATIVE(Eval);                // Eval string as another script
  DECLARE_NATIVE(Version);             // Get runtime.js version
  DECLARE_NATIVE(GetCommandLine);      // Get kernel command line string

  // runtime.js syscalls: Initrd FS access
  DECLARE_NATIVE(InitrdReadFile);      // Read file from initrd filesystem into string
  DECLARE_NATIVE(InitrdReadFileBuffer);// Read file from initrd filesystem into buffer
  DECLARE_NATIVE(InitrdListFiles);     // List all files on initrd filesystem
  DECLARE_NATIVE(InitrdGetKernelIndex);// Get kernel entry point file
  DECLARE_NATIVE(InitrdGetAppIndex);   // Get application entry point path

  // runtime.js syscalls: Profiler, debug and system info
  DECLARE_NATIVE(StartProfiling);      // Start profiler
  DECLARE_NATIVE(StopProfiling);       // Stop profiler
  DECLARE_NATIVE(Debug);               // Debug util
  DECLARE_NATIVE(TakeHeapSnapshot);    // Create V8 heap snapshot
  DECLARE_NATIVE(MemoryInfo);          // Get memory information
  DECLARE_NATIVE(SystemInfo);          // Get system information
  DECLARE_NATIVE(Reboot);              // Reboot system
  DECLARE_NATIVE(Poweroff);            // Poweroff system
  DECLARE_NATIVE(Exit);                // Exit (will reboot system by default)

  // global event listeners
  DECLARE_NATIVE(AddEventListener);    // global.addEventListener
  DECLARE_NATIVE(RemoveEventListener); // global.removeEventListener

  // runtime.js syscalls: Low level system access
  DECLARE_NATIVE(BufferAddress);       // Get buffer physical address
  DECLARE_NATIVE(MemoryBarrier);       // Run full memory barrier
  DECLARE_NATIVE(AllocDMA);            // Allocate memory for DMA transfers
  DECLARE_NATIVE(GetSystemResources);  // Get low-level system resources
  DECLARE_NATIVE(StopVideoLog);        // Stop console redirection to display
  DECLARE_NATIVE(SetTime);             // Set time in V8 engine
  DECLARE_NATIVE(SetPromiseHandlers);  // Setup internal promise handlers

  // runtime.js syscalls: ACPI control bindings
  DECLARE_NATIVE(AcpiGetPciDevices);   // Get list of PCI devices
  DECLARE_NATIVE(AcpiSystemReset);     // Reset system using ACPI
  DECLARE_NATIVE(AcpiEnterSleepState); // Call ACPI to enter system into sleep state

  void ObjectInit(ExportBuilder obj) {}
  JsObjectWrapperBase* Clone() const {
    return nullptr; // Not clonable
  }
};

class IoPortX64Object : public JsObjectWrapper<IoPortX64Object,
  NativeTypeId::TYPEID_RESOURCE_IO_PORT> {
public:
  IoPortX64Object(uint16_t port_number)
    : JsObjectWrapper(),
      port_number_(port_number) { }

  DECLARE_NATIVE(Write8);
  DECLARE_NATIVE(Write16);
  DECLARE_NATIVE(Write32);
  DECLARE_NATIVE(Read8);
  DECLARE_NATIVE(Read16);
  DECLARE_NATIVE(Read32);

  void ObjectInit(ExportBuilder obj) {
    obj.SetCallback("write8", Write8);
    obj.SetCallback("write16", Write16);
    obj.SetCallback("write32", Write32);
    obj.SetCallback("read8", Read8);
    obj.SetCallback("read16", Read16);
    obj.SetCallback("read32", Read32);
  }

  JsObjectWrapperBase* Clone() const {
    return new IoPortX64Object(port_number_);
  }
private:
  uint16_t port_number_;
};

class AcpiHandleObject : public JsObjectWrapper<AcpiHandleObject,
  NativeTypeId::TYPEID_ACPI_HANDLE> {
public:
  AcpiHandleObject(ACPI_HANDLE handle)
    : JsObjectWrapper(),
      handle_(handle),
      devinfo_(nullptr) {
    RT_ASSERT(handle);
  }

  DECLARE_NATIVE(IsRootBridge);
  DECLARE_NATIVE(Address);
  DECLARE_NATIVE(Parent);
  DECLARE_NATIVE(IsDevice);
  DECLARE_NATIVE(HardwareId);
  DECLARE_NATIVE(GetIrqRoutingTable);
  DECLARE_NATIVE(GetRootBridgeBusNumber);

  void ObjectInit(ExportBuilder obj) {
    obj.SetCallback("isRootBridge", IsRootBridge);
    obj.SetCallback("getRootBridgeBusNumber", GetRootBridgeBusNumber);
    obj.SetCallback("address", Address);
    obj.SetCallback("parent", Parent);
    obj.SetCallback("isDevice", IsDevice);
    obj.SetCallback("hardwareId", HardwareId);
    obj.SetCallback("getIrqRoutingTable", GetIrqRoutingTable);
  }

  ~AcpiHandleObject() {
    if (devinfo_) {
      delete devinfo_;
    }
  }

  JsObjectWrapperBase* Clone() const {
    return nullptr; // Not clonable
  }
private:
  ACPI_DEVICE_INFO* GetInfo() {
    if (nullptr == devinfo_) {
      ACPI_DEVICE_INFO* devinfo = nullptr;
      ACPI_STATUS s = AcpiGetObjectInfo(handle_, &devinfo);
      if (ACPI_FAILURE(s)) {
        return nullptr;
      }
      devinfo_ = devinfo;
    }
    return devinfo_;
  }


  ACPI_HANDLE handle_;
  ACPI_DEVICE_INFO* devinfo_;
};

class ResourceMemoryRangeObject : public JsObjectWrapper<ResourceMemoryRangeObject,
  NativeTypeId::TYPEID_RESOURCE_MEMORY_RANGE> {
public:
  ResourceMemoryRangeObject(Range<size_t> memory_range)
    : JsObjectWrapper(),
      memory_range_(memory_range) { }

  DECLARE_NATIVE(Begin);
  DECLARE_NATIVE(End);
  DECLARE_NATIVE(Subrange);
  DECLARE_NATIVE(Block);

  void ObjectInit(ExportBuilder obj) {
    obj.SetCallback("begin", Begin);
    obj.SetCallback("end", End);
    obj.SetCallback("subrange", Subrange);
    obj.SetCallback("block", Block);
  }

  JsObjectWrapperBase* Clone() const {
    return new ResourceMemoryRangeObject(memory_range_);
  }
private:
  Range<size_t> memory_range_;
};

class ResourceIORangeObject : public JsObjectWrapper<ResourceIORangeObject,
  NativeTypeId::TYPEID_RESOURCE_IO_RANGE> {
public:
  ResourceIORangeObject(Range<uint16_t> io_range)
    : JsObjectWrapper(),
      io_range_(io_range) { }

  DECLARE_NATIVE(Begin);
  DECLARE_NATIVE(End);
  DECLARE_NATIVE(Subrange);
  DECLARE_NATIVE(Port);
  DECLARE_NATIVE(OffsetPort);

  void ObjectInit(ExportBuilder obj) {
    obj.SetCallback("begin", Begin);
    obj.SetCallback("end", End);
    obj.SetCallback("subrange", Subrange);
    obj.SetCallback("port", Port);
    obj.SetCallback("offsetPort", OffsetPort);
  }

  JsObjectWrapperBase* Clone() const {
    return new ResourceIORangeObject(io_range_);
  }
private:
  Range<uint16_t> io_range_;
};

class ResourceIRQRangeObject : public JsObjectWrapper<ResourceIRQRangeObject,
  NativeTypeId::TYPEID_RESOURCE_IRQ_RANGE> {
public:
  ResourceIRQRangeObject(Range<uint8_t> irq_range)
    : JsObjectWrapper(),
      irq_range_(irq_range) { }

  DECLARE_NATIVE(Irq);

  void ObjectInit(ExportBuilder obj) {
    obj.SetCallback("irq", Irq);
  }

  JsObjectWrapperBase* Clone() const {
    return new ResourceIRQRangeObject(irq_range_);
  }
private:
  Range<uint8_t> irq_range_;
};

class ResourceIRQObject : public JsObjectWrapper<ResourceIRQObject,
  NativeTypeId::TYPEID_RESOURCE_IRQ> {
public:
  ResourceIRQObject(uint8_t irq_number)
    : JsObjectWrapper(), irq_number_(irq_number) { }

  DECLARE_NATIVE(On);

  void ObjectInit(ExportBuilder obj) {
    obj.SetCallback("on", On);
  }

  JsObjectWrapperBase* Clone() const {
    return new ResourceIRQObject(irq_number_);
  }
private:
  uint8_t irq_number_;
};

class ResourceMemoryBlockObject : public JsObjectWrapper<ResourceMemoryBlockObject,
  NativeTypeId::TYPEID_RESOURCE_MEMORY_BLOCK> {
public:
  ResourceMemoryBlockObject(MemoryBlock<uint32_t> memory_block)
    : JsObjectWrapper(), memory_block_(memory_block) { }

  DECLARE_NATIVE(Buffer);
  DECLARE_NATIVE(Length);

  void ObjectInit(ExportBuilder obj) {
    obj.SetCallback("buffer", Buffer);
    obj.SetCallback("length", Length);
  }

  JsObjectWrapperBase* Clone() const {
    return new ResourceMemoryBlockObject(memory_block_);
  }
private:
  MemoryBlock<uint32_t> memory_block_;
};

} // namespace rt
