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

#include <kernel/engines.h>
#include <kernel/acpi-manager.h>
#include <kernel/platform.h>

namespace rt {

bool EntropySource(unsigned char* buffer, size_t length) {
  for (size_t i = 0; i < length; ++i) {
    buffer[i] = GLOBAL_platform()->BootTimeMicroseconds() & 0xFF;
  }
  return true;
}

AcpiManager* Engines::acpi_manager() {
  if (nullptr == _acpi_manager) {
    _acpi_manager = new AcpiManager();
  }

  RT_ASSERT(_acpi_manager);
  return _acpi_manager;
}

} // namespace rt
