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

#include <kernel/kernel.h>
#include <acpi.h>
#include <stdarg.h>
#include <stdio.h>
#include <kernel/engines.h>
#include <kernel/x64/io-x64.h>

using namespace rt;

extern "C" {

ACPI_STATUS AcpiOsInitialize (void) {
    return AE_OK;
}

ACPI_STATUS AcpiOsTerminate (void) {
    return AE_OK;
}

ACPI_STATUS AcpiOsCreateSemaphore(UINT32 MaxUnits, UINT32 InitialUnits, ACPI_SEMAPHORE *OutHandle) {
    return AE_OK;
}

ACPI_STATUS AcpiOsDeleteSemaphore(ACPI_SEMAPHORE Handle) {
    return AE_OK;
}

ACPI_STATUS AcpiOsWaitSemaphore(ACPI_SEMAPHORE Handle, UINT32 Units, UINT16 Timeout) {
    return AE_OK;
}

ACPI_STATUS AcpiOsSignalSemaphore(ACPI_SEMAPHORE Handle, UINT32 Units) {
    return AE_OK;
}

ACPI_STATUS AcpiOsCreateLock(ACPI_SPINLOCK *OutHandle) {
    return AE_OK;
}

void AcpiOsDeleteLock(ACPI_HANDLE Handle) {
    return;
}

ACPI_CPU_FLAGS AcpiOsAcquireLock(ACPI_SPINLOCK Handle) {
    return 1;
}

void AcpiOsReleaseLock(ACPI_SPINLOCK Handle, ACPI_CPU_FLAGS Flags) {
    return;
}

void AcpiOsStall(UINT32 Microseconds) {
    printf("[ACPICA] Stall %d microsec\n", Microseconds);
    GLOBAL_engines()->Sleep(Microseconds);
}

void AcpiOsSleep(UINT64 Milliseconds) {
    printf("[ACPICA] Sleep %d ms\n", Milliseconds);
    GLOBAL_engines()->Sleep(Milliseconds * 1000);
}

ACPI_STATUS AcpiOsInstallInterruptHandler(UINT32 InterruptLevel, ACPI_OSD_HANDLER Handler, void *Context) {
#ifdef RUNTIME_DEBUG
    printf("[ACPICA] Install IRQ # %d\n", InterruptLevel);
#endif
    return AE_OK;
}

ACPI_STATUS AcpiOsRemoveInterruptHandler(UINT32 InterruptNumber, ACPI_OSD_HANDLER Handler) {
    printf("[ACPICA] Remove IRQ # %d\n", InterruptNumber);
    return AE_OK;
}

void AcpiOsWaitEventsComplete() {
    RT_ASSERT(!"Not implemented");
    return;
}

ACPI_STATUS AcpiOsExecute(ACPI_EXECUTE_TYPE Type, ACPI_OSD_EXEC_CALLBACK Function, void *Context) {
    RT_ASSERT(!"Not implemented");
    return AE_OK;
}


ACPI_STATUS AcpiOsPredefinedOverride(const ACPI_PREDEFINED_NAMES* InitVal, ACPI_STRING* NewVal) {
    if (!InitVal || !NewVal) {
        return (AE_BAD_PARAMETER);
    }

    *NewVal = NULL;
    return AE_OK;
}

ACPI_STATUS AcpiOsReadPciConfiguration(ACPI_PCI_ID* pciid, UINT32 reg, UINT64* value, UINT32 Width) {
    uint64_t result = 0;
    switch (Width) {
    case 8:
        result = IoPortsX64::PciReadB(pciid->Bus, pciid->Device, pciid->Function, reg);
        break;
    case 16:
        result = IoPortsX64::PciReadW(pciid->Bus, pciid->Device, pciid->Function, reg);
        break;
    case 32:
        result = IoPortsX64::PciReadDW(pciid->Bus, pciid->Device, pciid->Function, reg);
        break;
    case 64:
        RT_ASSERT(!"AcpiOsReadPciConfiguration 64 bit is not supported.");
    default:
        return AE_BAD_PARAMETER;
        break;
    }

    *value = result;
    return AE_OK;
}

ACPI_STATUS AcpiOsWritePciConfiguration(ACPI_PCI_ID* pciid, UINT32 reg, UINT64 value, UINT32 Width) {
    switch (Width) {
    case 8:
        IoPortsX64::PciWriteB(pciid->Bus, pciid->Device, pciid->Function, reg, value & 0xff);
        break;
    case 16:
        IoPortsX64::PciWriteW(pciid->Bus, pciid->Device, pciid->Function, reg, value & 0xffff);
        break;
    case 32:
        IoPortsX64::PciWriteDW(pciid->Bus, pciid->Device, pciid->Function, reg, value & 0xffffffff);
        break;
    case 64:
        RT_ASSERT(!"AcpiOsWritePciConfiguration 64 bit is not supported.");
    default:
        return AE_BAD_PARAMETER;
        break;
    }

    return AE_OK;
}

ACPI_STATUS AcpiOsPhysicalTableOverride (ACPI_TABLE_HEADER* ExistingTable,
                                         ACPI_PHYSICAL_ADDRESS* NewAddress, UINT32* NewTableLength) {
    return AE_SUPPORT;
}

ACPI_STATUS AcpiOsSignal (UINT32 Function, void *Info) {
    return AE_OK;
}

UINT64 AcpiOsGetTimer(void) {
    RT_ASSERT(!"Not implemented.");
    return 1;
}

ACPI_STATUS AcpiOsTableOverride(ACPI_TABLE_HEADER* ExistingTable, ACPI_TABLE_HEADER** NewTable) {
    if (!ExistingTable || !NewTable) {
        return AE_BAD_PARAMETER;
    }

    *NewTable = NULL;
    return AE_NO_ACPI_TABLES;
}

ACPI_STATUS AcpiOsReadMemory(ACPI_PHYSICAL_ADDRESS address, UINT64* value, UINT32 Width) {
    RT_ASSERT(address <= 0xFFFFFFFF);
    uint64_t result = 0;

    switch (Width) {
    case 8:
        result = *reinterpret_cast<uint8_t*>(address);
        break;
    case 16:
        result = *reinterpret_cast<uint16_t*>(address);
        break;
    case 32:
        result = *reinterpret_cast<uint32_t*>(address);
        break;
    case 64:
        result = *reinterpret_cast<uint64_t*>(address);
        break;
    default:
        return AE_BAD_PARAMETER;
        break;
    }

    *value = result;
    return AE_OK;
}

ACPI_STATUS AcpiOsWriteMemory(ACPI_PHYSICAL_ADDRESS address, UINT64 value, UINT32 Width) {
    RT_ASSERT(address <= 0xFFFFFFFF);

    switch (Width) {
    case 8:
        *reinterpret_cast<uint8_t*>(address) = (uint8_t)value;
        break;
    case 16:
        *reinterpret_cast<uint16_t*>(address) = (uint16_t)value;
        break;
    case 32:
        *reinterpret_cast<uint32_t*>(address) = (uint32_t)value;
        break;
    case 64:
        *reinterpret_cast<uint64_t*>(address) = (uint64_t)value;
        break;
    default:
        return AE_BAD_PARAMETER;
        break;
    }

    return AE_OK;
}

ACPI_STATUS AcpiOsReadPort(ACPI_IO_ADDRESS address, UINT32* value, UINT32 Width) {
    uint32_t result;
    uint16_t port = (uint16_t)address;

    switch (Width) {
    case 8:
        result = IoPortsX64::InB(port);
        break;
    case 16:
        result = IoPortsX64::InW(port);
        break;
    case 32:
        result = IoPortsX64::InDW(port);
        break;
    default:
        return (AE_BAD_PARAMETER);
    }

    *value = result;
    return AE_OK;
}

ACPI_STATUS AcpiOsWritePort(ACPI_IO_ADDRESS address, UINT32 value, UINT32 Width) {
    uint16_t port = (uint16_t)address;

    switch (Width) {
    case 8:
        IoPortsX64::OutB(port, (uint8_t)value);
        break;
    case 16:
        IoPortsX64::OutW(port, (uint16_t)value);
        break;
    case 32:
        IoPortsX64::OutDW(port, (uint32_t)value);
        break;
    default:
        return AE_BAD_PARAMETER;
    }

    return AE_OK;
}

void* AcpiOsMapMemory(ACPI_PHYSICAL_ADDRESS PhysicalAddress, ACPI_SIZE Length) {
    RT_ASSERT(PhysicalAddress <= 0xFFFFFFFF);
    return reinterpret_cast<void*>(PhysicalAddress);
}

void AcpiOsUnmapMemory(void *where, ACPI_SIZE length) {
    return;
}

ACPI_STATUS AcpiOsGetPhysicalAddress(void *LogicalAddress, ACPI_PHYSICAL_ADDRESS *PhysicalAddress) {
    *PhysicalAddress = reinterpret_cast<UINT64>(LogicalAddress);
    return AE_OK;
}

ACPI_PHYSICAL_ADDRESS AcpiOsGetRootPointer() {
    ACPI_SIZE Ret;
    AcpiFindRootPointer(&Ret);
    return Ret;
}

void AcpiOsPrintf(const char* Fmt, ...) {
    printf("[ACPICA] :\n");
    va_list Args;
    va_start (Args, Fmt);
    vprintf (Fmt, Args);
    va_end (Args);

}

} // extern "C"
