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

#include "acpi-manager.h"
#include <stdio.h>
#include <kernel/cpu.h>

namespace rt {

AcpiManager::AcpiManager() {
  if (!Init()) {
    return;
  }

  if (!SetInterruptRoutingMode()) {
    return;
  }
}

bool AcpiManager::SetInterruptRoutingMode() {
  // 0 = PIC
  // 1 = APIC
  // 2 = SAPIC (not supported on x86?)
  uint64_t mode = 1;

  ACPI_OBJECT arg1;
  arg1.Type = ACPI_TYPE_INTEGER;
  arg1.Integer.Value = mode;

  ACPI_OBJECT_LIST args;
  args.Count = 1;
  args.Pointer = &arg1;

  char method[] = "_PIC";

  ACPI_STATUS ret;
  ret = AcpiEvaluateObject(ACPI_ROOT_OBJECT, method, &args, NULL);
  if (ACPI_FAILURE(ret)) {
#ifdef RUNTIME_DEBUG
    printf("SetInterruptRoutingMode failed.");
#endif
    return false;
  }
  return true;
}

bool AcpiManager::Init() {
  ACPI_STATUS ret;

  ret = AcpiInitializeSubsystem();
  if (ACPI_FAILURE(ret)) {
    printf("AcpiInitializeSubsystem failed.");
    return false;
  }

  ret = AcpiInitializeTables(NULL, 16, FALSE);
  if (ACPI_FAILURE(ret)) {
    printf("AcpiInitializeTables failed.");
    return false;
  }

  ret = AcpiLoadTables();
  if (ACPI_FAILURE(ret)) {
    printf("AcpiInitializeTables failed.");
    return false;
  }

  ret = AcpiEnableSubsystem(ACPI_FULL_INITIALIZATION);
  if (ACPI_FAILURE(ret)) {
    printf("AcpiInitializeTables failed.");
    return false;
  }

  ret = AcpiInitializeObjects(ACPI_FULL_INITIALIZATION);
  if (ACPI_FAILURE(ret)) {
    printf("AcpiInitializeTables failed.");
    return false;
  }

  return true;
}

ACPI_STATUS WalkCallback(ACPI_HANDLE object, UINT32 nesting_level, void* data, void** returns) {
  RT_ASSERT(data);
  AcpiObjectsList* list = reinterpret_cast<AcpiObjectsList*>(data);
  list->Push(object);
  return AE_OK;
}

AcpiObjectsList AcpiManager::GetPciDevices() {
  void* ptr = nullptr;
  AcpiObjectsList devlist;
  AcpiGetDevices(NULL, WalkCallback, &devlist, &ptr);
  return devlist;
}

} // namespace rt
