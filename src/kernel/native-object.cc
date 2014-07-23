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

#include "native-object.h"
#include <kernel/x64/io-x64.h>
#include <kernel/acpi-manager.h>
#include <common/utils.h>
#include <kernel/v8utils.h>
#include <memory>
#include <accommon.h>
#include <kernel/process.h>
#include <kernel/engines.h>
#include <common/utils.h>
#include <kernel/platform.h>
#include <kernel/version.h>

namespace rt {

using ::common::Nullable;

template<typename T>
using SharedSTLVector = std::vector<T, DefaultSTLAlloc<T>>;

NATIVE_FUNCTION(NativesObject, CallHandler) {
    PROLOGUE_NOTHIS;

    if (args.IsConstructCall()) {
        THROW_ERROR("Constructor call is not allowed");
    }

    v8::Local<v8::Value> thisvalue { args.This() };
    RT_ASSERT(!thisvalue.IsEmpty());
    if (!thisvalue->IsObject()) return;

    v8::Local<v8::Object> obj { thisvalue->ToObject() };
    if (obj->InternalFieldCount() != 1) return;
    void* ptr = obj->GetAlignedPointerFromInternalField(0);
    if (nullptr == ptr) return;

    ExternalFunction* efn { static_cast<ExternalFunction*>(ptr) };
    RT_ASSERT(efn);

    Thread* recv { efn->recv().get()->thread() };
    RT_ASSERT(recv);

    TransportData data;
    {	TransportData::SerializeError err { data.MoveArgs(th, recv, args) };
        if (TransportData::ThrowError(iv8, err)) return;
    }

    v8::Local<v8::Promise::Resolver> promise_resolver {
        v8::Promise::Resolver::New(iv8) };
    uint32_t promise_index = th->AddPromise(
        v8::UniquePersistent<v8::Promise::Resolver>(iv8, promise_resolver));

    {	std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
            ThreadMessage::Type::FUNCTION_CALL,
            th->handle(),
            std::move(data), efn, promise_index));
        efn->recv().get()->PushMessage(std::move(msg));
    }

    args.GetReturnValue().Set(promise_resolver);
}

NATIVE_FUNCTION(NativesObject, CallResult) {
    PROLOGUE_NOTHIS;
    RT_ASSERT(4 == args.Length());
    USEARG(0);
    USEARG(1);
    USEARG(2);
    USEARG(3);
    RT_ASSERT(arg0->IsBoolean());
    RT_ASSERT(arg1->IsExternal());
    RT_ASSERT(arg2->IsUint32());

    v8::Local<v8::External> ext { v8::Local<v8::External>::Cast(arg1) };
    void* val { ext->Value() };
    RT_ASSERT(val);
    ResourceHandle<EngineThread> thread(static_cast<EngineThread*>(val));

    LockingPtr<EngineThread> lptr { thread.get() };
    Thread* recv { lptr->thread() };
    RT_ASSERT(recv);

    TransportData data;
    {	TransportData::SerializeError err { data.MoveValue(th, recv, arg3) };
        if (TransportData::ThrowError(iv8, err)) return;
    }

    {	std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
            arg0->BooleanValue() ?
                ThreadMessage::Type::FUNCTION_RETURN_RESOLVE :
                ThreadMessage::Type::FUNCTION_RETURN_REJECT,
            th->handle(),
            std::move(data), nullptr, arg2->Uint32Value()));
        lptr->PushMessage(std::move(msg));
    }
}

NATIVE_FUNCTION(NativesObject, SetTimeout) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    USEARG(1);
    VALIDATEARG(0, FUNCTION, "setTimeout: argument 0 should be a function");
    RT_ASSERT(arg0->IsFunction());

    ResourceHandle<EngineThread> thread { th->handle() };
    RT_ASSERT(!thread.empty());

    uint32_t index { th->AddTimeoutData(v8::UniquePersistent<v8::Value>(iv8, arg0)) };
    th->SetTimeout(index, arg1->Uint32Value());
    args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(NativesObject, KernelLog) {
    int argc = args.Length();
    for (int i = 0; i < argc; ++i) {
        v8::Local<v8::Value> v = args[i];
        v8::Local<v8::String> s = v->ToString();

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

NATIVE_FUNCTION(NativesObject, InitrdText) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    RT_ASSERT(1 == args.Length());

    v8::Local<v8::String> filename = arg0->ToString();
    v8::String::Utf8Value filename_utf8(filename);
    const char* filename_buf = *filename_utf8;
    RT_ASSERT(filename_buf);

    InitrdFile file = GLOBAL_initrd()->Get(filename_buf);
    if (file.IsEmpty()) {
        args.GetReturnValue().SetNull();
        return;
    }

    v8::Local<v8::String> text { v8::String::NewFromUtf8(iv8,
        reinterpret_cast<const char*>(file.Data()),
        v8::String::kNormalString, file.Size()) };

    args.GetReturnValue().Set(text);
}

NATIVE_FUNCTION(NativesObject, InitrdList) {
    PROLOGUE_NOTHIS;
    size_t files_count { GLOBAL_initrd()->files_count() };
    v8::Local<v8::Array> arr { v8::Array::New(iv8, files_count) };

    LOCAL_V8STRING(s_name, "name");
    LOCAL_V8STRING(s_size, "size");

    v8::Local<v8::Object> tmp { v8::Object::New(iv8) };
    tmp->Set(s_name, v8::String::Empty(iv8));
    tmp->Set(s_size, v8::Uint32::NewFromUnsigned(iv8, 0));

    for (size_t i = 0; i < files_count; ++i) {
        InitrdFile file = GLOBAL_initrd()->GetByIndex(i);
        RT_ASSERT(!file.IsEmpty());

        RT_ASSERT(file.Size() < 0xffffffff && "Initrd file is too big");
        v8::Local<v8::Object> file_object { tmp->Clone() };
        file_object->Set(s_name, v8::String::NewFromUtf8(iv8, file.Name()));
        file_object->Set(s_size, v8::Uint32::NewFromUnsigned(iv8, file.Size() & 0xffffffff));
        arr->Set(i, file_object);
    }

    args.GetReturnValue().Set(arr);
}

NATIVE_FUNCTION(NativesObject, KernelLoaderCallback) {
    PROLOGUE_NOTHIS;
    USEARG(0);

    v8::String::Utf8Value filename_utf8(arg0->ToString());
    const char* filename_buf = *filename_utf8;
    RT_ASSERT(filename_buf);

    InitrdFile file = GLOBAL_initrd()->Get(filename_buf);
    if (file.IsEmpty()) {
        THROW_ERROR("Unable to load requested file");
        return;
    }

    v8::Local<v8::String> text { v8::String::NewFromUtf8(iv8,
        reinterpret_cast<const char*>(file.Data()),
        v8::String::kNormalString, file.Size()) };

    args.GetReturnValue().Set(text);
}

NATIVE_FUNCTION(NativesObject, Resources) {
    PROLOGUE_NOTHIS;

    LOCAL_V8STRING(s_memory_range, "memoryRange");
    LOCAL_V8STRING(s_io_range, "ioRange");
    LOCAL_V8STRING(s_irq_range, "irqRange");
    LOCAL_V8STRING(s_process_manager, "processManager");
    LOCAL_V8STRING(s_acpi, "acpi");
    LOCAL_V8STRING(s_allocator, "allocator");
    LOCAL_V8STRING(s_loader, "loader");
    LOCAL_V8STRING(s_natives, "natives");

    v8::Local<v8::Object> obj = v8::Object::New(iv8);

    ResourceHandle<ResourceMemoryRange> memory_range(new ResourceMemoryRange(0, 0xffffffff));
    obj->Set(s_memory_range, (new ResourceMemoryRangeObject(th->template_cache(), memory_range))
        ->GetInstance());

    ResourceHandle<ResourceIORange> io_range(new ResourceIORange(1, 0xffff));
    obj->Set(s_io_range, (new ResourceIORangeObject(th->template_cache(), io_range))
        ->GetInstance());

    ResourceHandle<ResourceIRQRange> irq_range(new ResourceIRQRange(1, 225));
    obj->Set(s_irq_range, (new ResourceIRQRangeObject(th->template_cache(), irq_range))
        ->GetInstance());

    ResourceHandle<ProcessManager> proc_manager(&GLOBAL_engines()->process_manager());
    obj->Set(s_process_manager, (new ProcessManagerHandleObject(th->template_cache(), proc_manager))
        ->GetInstance());

    obj->Set(s_acpi, (new AcpiManagerObject(th->template_cache(), GLOBAL_engines()->acpi_manager()))
        ->GetInstance());

    obj->Set(s_allocator, (new AllocatorObject(th->template_cache()))->GetInstance());

    obj->Set(s_loader, v8::Function::New(iv8, KernelLoaderCallback));

    obj->Set(s_natives, (new NativesObject(th->template_cache()))->GetInstance());

    args.GetReturnValue().Set(obj);
}

NATIVE_FUNCTION(NativesObject, Args) {
    PROLOGUE_NOTHIS;
    v8::Local<v8::Value> threadargs = th->args();
    RT_ASSERT(!threadargs.IsEmpty());
    args.GetReturnValue().Set(threadargs);
}

NATIVE_FUNCTION(NativesObject, Exit) {
    PROLOGUE_NOTHIS;
    v8::V8::TerminateExecution(iv8);
    th->SetTerminateFlag();
}

NATIVE_FUNCTION(NativesObject, Version) {
    PROLOGUE_NOTHIS;

    auto arr = v8::Array::New(iv8, 3);
    arr->Set(0, v8::Uint32::NewFromUnsigned(iv8, Version::getMajor()));
    arr->Set(1, v8::Uint32::NewFromUnsigned(iv8, Version::getMinor()));
    arr->Set(2, v8::Uint32::NewFromUnsigned(iv8, Version::getRev()));

    auto obj = v8::Object::New(iv8);
    LOCAL_V8STRING(s_runtime, "runtime");
    LOCAL_V8STRING(s_v8, "v8");
    LOCAL_V8STRING(s_v8ver, v8::V8::GetVersion());
    obj->Set(s_runtime, arr);
    obj->Set(s_v8, s_v8ver);

    args.GetReturnValue().Set(obj);
}

NATIVE_FUNCTION(NativesObject, InstallInternals) {
    PROLOGUE_NOTHIS;
    USEARG(0);

    RT_ASSERT(arg0->IsObject());
    v8::Local<v8::Object> obj { arg0->ToObject() };
    v8::Local<v8::String> call_wrapper_name { v8::String::NewFromUtf8(iv8, "callWrapper") };
    RT_ASSERT(obj->HasOwnProperty(call_wrapper_name));
    {	v8::Local<v8::Value> fnv { obj->Get(call_wrapper_name) };
        RT_ASSERT(fnv->IsFunction());
        v8::Local<v8::Function> fn { v8::Local<v8::Function>::Cast(fnv) };
        th->SetCallWrapper(fn);
    }
}

NATIVE_FUNCTION(NativesObject, Debug) {
    PROLOGUE_NOTHIS;

    uint32_t val_2 = *reinterpret_cast<uint32_t*>(0xfebd0000);
    printf("VAL_2 = %x\n", val_2);
    Cpu::HangSystem();


    RT_ASSERT(!"debug");
}

NATIVE_FUNCTION(NativesObject, StopVideoLog) {
    PROLOGUE_NOTHIS;
    GLOBAL_boot_services()->logger()->DisableVideo();
}

NATIVE_FUNCTION(IoPortX64Object, Write8) {
    PROLOGUE;
    USEARG(0);
    uint8_t value = arg0->Uint32Value() & 0xFF;
    IoPortsX64::OutB(that->port_number_, value);
    args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(IoPortX64Object, Write16) {
    PROLOGUE;
    USEARG(0);
    uint16_t value = arg0->Uint32Value() & 0xFFFF;
    IoPortsX64::OutW(that->port_number_, value);
    args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(IoPortX64Object, Write32) {
    PROLOGUE;
    USEARG(0);
    uint32_t value = arg0->Uint32Value();
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

    args.GetReturnValue().Set((new AcpiHandleObject(th->template_cache(), parent_handle))->GetInstance());
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
        v8::String::kNormalString, len - 1));
}

class WalkResourcesIrqContext {
public:
    WalkResourcesIrqContext(AcpiPciIrqRoutingTable* routes,
                            uint8_t device, uint8_t pin, uint8_t source_index)
        :	_routes(routes),
            _device(device),
            _pin(pin),
            _source_index(source_index) {
        RT_ASSERT(_routes);
    }
    AcpiPciIrqRoutingTable* routes() const { return _routes; }
    uint8_t device() const { return _device; }
    uint8_t pin() const { return _pin; }
    uint8_t source_index() const { return _source_index; }
private:
    AcpiPciIrqRoutingTable* _routes;
    uint8_t _device;
    uint8_t _pin;
    uint8_t _source_index;
};

ACPI_STATUS WalkResourcesCallback(ACPI_RESOURCE *res, void *context) {
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

    v8::Local<v8::String> str_device_id = v8::String::NewFromUtf8(iv8, "deviceId");
    v8::Local<v8::String> str_irq = v8::String::NewFromUtf8(iv8, "irq");
    v8::Local<v8::String> str_pin = v8::String::NewFromUtf8(iv8, "pin");

    v8::Local<v8::Array> arr = v8::Array::New(iv8, routes.size());
    for (size_t i = 0; i < routes.size(); ++i) {
        v8::Local<v8::Object> row = v8::Object::New(iv8);
        row->Set(str_device_id, v8::Uint32::New(iv8, routes.Get(i).device()));
        row->Set(str_irq, v8::Uint32::New(iv8, routes.Get(i).irq()));
        row->Set(str_pin, v8::Uint32::New(iv8, routes.Get(i).pin()));
        arr->Set(i, row);
    }

    args.GetReturnValue().Set(arr);
}

ACPI_STATUS WalkResourcesBusLookupCallback(ACPI_RESOURCE *res, void* context) {
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

NATIVE_FUNCTION(AcpiManagerObject, SystemReset) {
    PROLOGUE;
    AcpiReset();
}

NATIVE_FUNCTION(AcpiManagerObject, GetPciDevices) {
    PROLOGUE;

    AcpiObjectsList list = that->mgr_->GetPciDevices();
    v8::Local<v8::Array> arr = v8::Array::New(iv8, list.size());

    for (size_t i = 0; i < list.size(); ++i) {
        arr->Set(i, (new AcpiHandleObject(th->template_cache(), list.Get(i)))->GetInstance());
    }

    args.GetReturnValue().Set(arr);
}

NATIVE_FUNCTION(ResourceMemoryRangeObject, Start) {
    PROLOGUE;
    uint64_t start = that->obj_.get()->start();
    RT_ASSERT(common::Utils::IsSafeDouble(start));
    args.GetReturnValue().Set(v8::Number::New(iv8, start));
}

NATIVE_FUNCTION(ResourceMemoryRangeObject, End) {
    PROLOGUE;
    uint64_t end = that->obj_.get()->end();
    RT_ASSERT(common::Utils::IsSafeDouble(end));
    args.GetReturnValue().Set(v8::Number::New(iv8, end));
}

NATIVE_FUNCTION(ResourceMemoryRangeObject, Subrange) {
    PROLOGUE;
    USEARG(0);
    USEARG(1);
    VALIDATEARG(0, NUMBER, "subrange: Argument 0 should be a number.");
    VALIDATEARG(1, NUMBER, "subrange: Argument 1 should be a number.");

    uint64_t start = static_cast<uint64_t>(arg0->NumberValue());
    uint64_t end = static_cast<uint64_t>(arg1->NumberValue());
    if (start > end) {
        THROW_RANGE_ERROR("subrange: Invalid range (start > end).");
    }

    args.GetReturnValue().Set((new ResourceMemoryRangeObject(th->template_cache(),
        that->obj_.get()->Subrange(start, end)))->GetInstance());
}

NATIVE_FUNCTION(ResourceMemoryRangeObject, Block) {
    PROLOGUE;
    USEARG(0);
    USEARG(1);
    VALIDATEARG(0, NUMBER, "block: Argument 0 should be a number.");
    VALIDATEARG(1, NUMBER, "block: Argument 1 should be a number.");

    uint64_t base = static_cast<uint64_t>(arg0->NumberValue());
    uint64_t size = static_cast<uint64_t>(arg1->NumberValue());

    // TODO: add range checks

    args.GetReturnValue().Set((new ResourceMemoryBlockObject(th->template_cache(),
        that->obj_.get()->Block(base, size)))->GetInstance());
}

NATIVE_FUNCTION(ResourceIORangeObject, First) {
    PROLOGUE;
    uint16_t start = that->obj_.get()->first();
    args.GetReturnValue().Set(v8::Uint32::New(iv8, start));
}

NATIVE_FUNCTION(ResourceIORangeObject, Last) {
    PROLOGUE;
    uint16_t end = that->obj_.get()->last();
    args.GetReturnValue().Set(v8::Uint32::New(iv8, end));
}

NATIVE_FUNCTION(ResourceIORangeObject, Subrange) {
    PROLOGUE;
    USEARG(0);
    USEARG(1);
    VALIDATEARG(0, NUMBER, "subrange: Argument 0 should be a number.");
    VALIDATEARG(1, NUMBER, "subrange: Argument 1 should be a number.");

    uint32_t first = static_cast<uint32_t>(arg0->NumberValue());
    uint32_t last = static_cast<uint32_t>(arg1->NumberValue());
    if (first >= last) {
        THROW_RANGE_ERROR("subrange: Invalid range (first >= last).");
    }

    args.GetReturnValue().Set((new ResourceIORangeObject(th->template_cache(),
        that->obj_.get()->Subrange(first, last)))->GetInstance());
}

NATIVE_FUNCTION(ResourceIORangeObject, Port) {
    PROLOGUE;
    USEARG(0);
    USEARG(1);
    VALIDATEARG(0, NUMBER, "port: argument 0 should be a number (uint32).");

    uint32_t number = arg0->Uint32Value();
    if (number > 0xffff) {
        THROW_RANGE_ERROR("port: invalid port number (should be <= 0xffff).");
    }

    args.GetReturnValue().Set((new IoPortX64Object(th->template_cache(), number))->GetInstance());
}

NATIVE_FUNCTION(ResourceIORangeObject, OffsetPort) {
    PROLOGUE;
    USEARG(0);
    USEARG(1);
    VALIDATEARG(0, NUMBER, "offsetPort: argument 0 should be a number (uint32).");

    uint32_t number = arg0->Uint32Value();
    if (number > 0xffff) {
        THROW_RANGE_ERROR("offsetPort: invalid port number (should be <= 0xffff).");
    }

    LockingPtr<ResourceIORange> io { that->obj_.get() };
    uint32_t p = io->first() + number;
    if (p > io->last()) {
        THROW_RANGE_ERROR("offsetPort: offset out of range");
    }

    printf("[OFFSET PORT] base = %d, offset = %d, result = %d\n", io->first(), number, p);

    args.GetReturnValue().Set((new IoPortX64Object(th->template_cache(), p))->GetInstance());
}

NATIVE_FUNCTION(ResourceIRQRangeObject, Irq) {
    PROLOGUE;
    USEARG(0);
    USEARG(1);
    VALIDATEARG(0, NUMBER, "irq: argument 0 should be a number (uint32).");

    uint32_t number = arg0->Uint32Value();
    if (number > 255) {
        THROW_RANGE_ERROR("irq: invalid irq number (should be <= 255).");
    }

    args.GetReturnValue().Set((new ResourceIRQObject(th->template_cache(),
        that->obj_.get()->Irq(number & 0xff)))->GetInstance());
}

NATIVE_FUNCTION(ResourceIRQObject, On) {
    PROLOGUE;
    USEARG(0);
    VALIDATEARG(0, FUNCTION, "on: argument 0 should be a function");

    ResourceHandle<EngineThread> thread { th->handle() };
    RT_ASSERT(!thread.empty());

    size_t irq_number = that->obj_.get()->number();
    RT_ASSERT(irq_number <= 0xff);

    uint32_t index { th->AddIRQData(v8::UniquePersistent<v8::Value>(iv8, arg0)) };
    GLOBAL_platform()->irq_dispatcher().Bind(irq_number, thread, index);

    printf("[IRQ MANAGER] Bind %d (recv %d)\n", irq_number, index);
    args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(ResourceMemoryBlockObject, DBG) {
    PROLOGUE;

    void* ptr = nullptr;
    size_t length = 0;

    {	LockingPtr<ResourceMemoryBlock> block { that->obj_.get() };
        ptr = reinterpret_cast<void*>(block->base());
        length = block->size();
    }

    RT_ASSERT(ptr);
    RT_ASSERT(length > 0);

    printf("[DEBUG] ptr = %p, len = %d\n", ptr, length);
}

NATIVE_FUNCTION(ResourceMemoryBlockObject, Buffer) {
    PROLOGUE;

    void* ptr = nullptr;
    size_t length = 0;

    {	LockingPtr<ResourceMemoryBlock> block { that->obj_.get() };
        ptr = reinterpret_cast<void*>(block->base());
        length = block->size();
    }

    RT_ASSERT(ptr);
    RT_ASSERT(length > 0);

    args.GetReturnValue().Set(v8::ArrayBuffer::New(iv8, ptr, length));
}

NATIVE_FUNCTION(ResourceMemoryBlockObject, Length) {
    PROLOGUE;
    size_t length = that->obj_.get()->size();
    RT_ASSERT(length <= 0xffffffff);
    RT_ASSERT(length > 0);
    args.GetReturnValue().Set(v8::Uint32::New(iv8, length));
}

NATIVE_FUNCTION(ProcessManagerHandleObject, Create) {
    PROLOGUE;
    USEARG(0);
    USEARG(1);
    RT_ASSERT(arg0->IsString());
    RT_ASSERT(arg1->IsObject());

    RT_ASSERT(GLOBAL_engines()->execution_engines_count() > 0);
    Engine* first_engine = GLOBAL_engines()->execution_engine(0);
    RT_ASSERT(first_engine);

    TransportData td_code;
    {	TransportData::SerializeError err { td_code.MoveValue(th, nullptr, arg0) };
        if (TransportData::ThrowError(iv8, err)) return;
    }

    TransportData td_args;
    {	TransportData::SerializeError err { td_args.MoveValue(th, nullptr, arg1) };
        if (TransportData::ThrowError(iv8, err)) return;
    }

    ResourceHandle<Process> p = that->proc_mgr_.get()->CreateProcess();
    ResourceHandle<EngineThread> st = first_engine->threads().Create();

    {	LockingPtr<EngineThread> thread { st.get() };

        {	std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
                ThreadMessage::Type::SET_ARGUMENTS,
                ResourceHandle<EngineThread>(),
                std::move(td_args)));
            thread->PushMessage(std::move(msg));
        }

        {	std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
                ThreadMessage::Type::EVALUATE,
                ResourceHandle<EngineThread>(),
                std::move(td_code)));
            thread->PushMessage(std::move(msg));
        }
    }

    LockingPtr<Process> proc = p.get();
    proc->SetThread(st, 0);
    args.GetReturnValue().Set(proc->NewInstance(th));
}

NATIVE_FUNCTION(AllocatorObject, AllocDMA) {
    PROLOGUE;

    LOCAL_V8STRING(s_address, "address");
    LOCAL_V8STRING(s_size, "size");
    LOCAL_V8STRING(s_buffer, "buffer");

    void* ptr { GLOBAL_mem_manager()->AllocPage32() };
    RT_ASSERT(ptr);

    size_t ptrvalue { reinterpret_cast<size_t>(ptr) };
    RT_ASSERT(ptrvalue == (ptrvalue & 0xffffffff));

    size_t size { GLOBAL_mem_manager()->page_size() };
    RT_ASSERT(size > 0);

    printf("DMA allocated = %p, size %d\n", ptr, size);
    // Clean DMA buffer
    memset(ptr, 0, size);

    v8::Local<v8::Object> ret { v8::Object::New(iv8) };
    ret->Set(s_address, v8::Uint32::New(iv8, static_cast<uint32_t>(ptrvalue)));
    ret->Set(s_size, v8::Uint32::New(iv8, static_cast<uint32_t>(size)));
    ret->Set(s_buffer, v8::ArrayBuffer::New(iv8, ptr, size));

    args.GetReturnValue().Set(ret);
}

} // namespace rt

