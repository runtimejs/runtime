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
#include <kernel/object-wrapper.h>
#include <kernel/string.h>
#include <kernel/v8utils.h>
#include <kernel/template-cache.h>
#include <acpi.h>
#include <common/utils.h>

using common::Range;
using common::MemoryBlock;

namespace rt {

class AcpiManager;

class NativesObject : public JsObjectWrapper<NativesObject,
        NativeTypeId::TYPEID_NATIVES> {
public:
    NativesObject(TemplateCache* tpl_cache)
        :	JsObjectWrapper(tpl_cache) {}

    DECLARE_NATIVE(CallHandler);
    DECLARE_NATIVE(SetTimeout);
    DECLARE_NATIVE(KernelLog);
    DECLARE_NATIVE(InitrdText);
    DECLARE_NATIVE(KernelLoaderCallback);
    DECLARE_NATIVE(Resources);
    DECLARE_NATIVE(Version);
    DECLARE_NATIVE(Exit);
    DECLARE_NATIVE(Args);
    DECLARE_NATIVE(InstallInternals);
    DECLARE_NATIVE(CallResult);
    DECLARE_NATIVE(Reboot);
    DECLARE_NATIVE(Debug);
    DECLARE_NATIVE(StopVideoLog);

    /**
     * Get array of all initrd file names
     */
    DECLARE_NATIVE(InitrdList);

    void ObjectInit(ExportBuilder obj) {
        obj.SetCallback("timeout", SetTimeout);
        obj.SetCallback("kernelLog", KernelLog);
        obj.SetCallback("resources", Resources);
        obj.SetCallback("args", Args);
        obj.SetCallback("installInternals", InstallInternals);
        obj.SetCallback("callResult", CallResult);
        obj.SetCallback("initrdText", InitrdText);
        obj.SetCallback("debug", Debug);
        obj.SetCallback("reboot", Reboot);
        obj.SetCallback("stopVideoLog", StopVideoLog);
        obj.SetCallback("initrdList", InitrdList);
    }
};

class IoPortX64Object : public JsObjectWrapper<IoPortX64Object,
        NativeTypeId::TYPEID_RESOURCE_IO_PORT> {
public:
    IoPortX64Object(TemplateCache* tpl_cache, uint16_t port_number)
        :	JsObjectWrapper(tpl_cache),
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
private:
    uint16_t port_number_;
};

class AcpiHandleObject : public JsObjectWrapper<AcpiHandleObject,
        NativeTypeId::TYPEID_ACPI_HANDLE> {
public:
    AcpiHandleObject(TemplateCache* tpl_cache, ACPI_HANDLE handle)
        :	JsObjectWrapper(tpl_cache),
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
        if (devinfo_) delete devinfo_;
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

class AcpiManagerObject : public JsObjectWrapper<AcpiManagerObject,
        NativeTypeId::TYPEID_ACPI_MANAGER> {
public:
    AcpiManagerObject(TemplateCache* tpl_cache, AcpiManager* mgr)
        :	JsObjectWrapper(tpl_cache),
            mgr_(mgr) {
        RT_ASSERT(mgr_);
    }

    DECLARE_NATIVE(GetPciDevices);
    DECLARE_NATIVE(SystemReset);

    /**
     * Use ACPICA to switch system sleep state
     */
    DECLARE_NATIVE(EnterSleepState);

    void ObjectInit(ExportBuilder obj) {
        obj.SetCallback("getPciDevices", GetPciDevices);
        obj.SetCallback("systemReset", SystemReset);
        obj.SetCallback("enterSleepState", EnterSleepState);
    }
private:
    AcpiManager* mgr_;
};

class ResourceMemoryRangeObject : public JsObjectWrapper<ResourceMemoryRangeObject,
        NativeTypeId::TYPEID_RESOURCE_MEMORY_RANGE> {
public:
    ResourceMemoryRangeObject(TemplateCache* tpl_cache, Range<size_t> memory_range)
        :	JsObjectWrapper(tpl_cache),
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
private:
    Range<size_t> memory_range_;
};

class ResourceIORangeObject : public JsObjectWrapper<ResourceIORangeObject,
        NativeTypeId::TYPEID_RESOURCE_IO_RANGE> {
public:
    ResourceIORangeObject(TemplateCache* tpl_cache, Range<uint16_t> io_range)
        :	JsObjectWrapper(tpl_cache),
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
private:
    Range<uint16_t> io_range_;
};

class ResourceIRQRangeObject : public JsObjectWrapper<ResourceIRQRangeObject,
        NativeTypeId::TYPEID_RESOURCE_IRQ_RANGE> {
public:
    ResourceIRQRangeObject(TemplateCache* tpl_cache, Range<uint8_t> irq_range)
        :	JsObjectWrapper(tpl_cache),
            irq_range_(irq_range) { }

    DECLARE_NATIVE(Irq);

    void ObjectInit(ExportBuilder obj) {
        obj.SetCallback("irq", Irq);
    }
private:
    Range<uint8_t> irq_range_;
};

class ResourceIRQObject : public JsObjectWrapper<ResourceIRQObject,
        NativeTypeId::TYPEID_RESOURCE_IRQ> {
public:
    ResourceIRQObject(TemplateCache* tpl_cache, uint8_t irq_number)
        :	JsObjectWrapper(tpl_cache),
            irq_number_(irq_number) { }

    DECLARE_NATIVE(On);

    void ObjectInit(ExportBuilder obj) {
        obj.SetCallback("on", On);
    }
private:
    uint8_t irq_number_;
};

class ResourceMemoryBlockObject : public JsObjectWrapper<ResourceMemoryBlockObject,
        NativeTypeId::TYPEID_RESOURCE_MEMORY_BLOCK> {
public:
    ResourceMemoryBlockObject(TemplateCache* tpl_cache, MemoryBlock<uint32_t> memory_block)
        :	JsObjectWrapper(tpl_cache),
            memory_block_(memory_block) { }

    DECLARE_NATIVE(Buffer);
    DECLARE_NATIVE(Length);

    void ObjectInit(ExportBuilder obj) {
        obj.SetCallback("buffer", Buffer);
        obj.SetCallback("length", Length);
    }
private:
    MemoryBlock<uint32_t> memory_block_;
};

class IsolatesManagerObject : public JsObjectWrapper<IsolatesManagerObject,
    NativeTypeId::TYPEID_ISOLATES_MANAGER> {
public:
    IsolatesManagerObject(TemplateCache* tpl_cache)
        :	JsObjectWrapper(tpl_cache) {
    }

    DECLARE_NATIVE(Create);
    DECLARE_NATIVE(List);

    void ObjectInit(ExportBuilder obj) {
        obj.SetCallback("create", Create);
        obj.SetCallback("list", List);
    }
private:
};

class AllocatorObject : public JsObjectWrapper<AllocatorObject,
    NativeTypeId::TYPEID_ALLOCATOR> {
public:
    AllocatorObject(TemplateCache* tpl_cache)
        :	JsObjectWrapper(tpl_cache) {
    }

    DECLARE_NATIVE(AllocDMA);

    void ObjectInit(ExportBuilder obj) {
        obj.SetCallback("allocDMA", AllocDMA);
    }
private:
};

} // namespace rt
