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
#include <acpi.h>
#include <vector>
#include <stdio.h>

namespace rt {

class AcpiObjectsList {
public:
  AcpiObjectsList() { }

  void Push(ACPI_HANDLE object) {
    RT_ASSERT(object);
    _objects.push_back(object);
  }

  ACPI_HANDLE Get(size_t index) const {
    RT_ASSERT(index < _objects.size());
    return _objects[index];
  }

  size_t size() const {
    return _objects.size();
  }


private:
  std::vector<ACPI_HANDLE> _objects;
};

class AcpiPciIrqRoute {
public:
  AcpiPciIrqRoute(uint8_t device, uint8_t pin, uint8_t irq)
    :	_device(device),
      _pin(pin),
      _irq(irq) { }
  uint8_t device() const {
    return _device;
  }
  uint8_t pin() const {
    return _pin;
  }
  uint8_t irq() const {
    return _irq;
  }
private:
  uint8_t _device;
  uint8_t _pin;
  uint8_t _irq;
};

class AcpiPciIrqRoutingTable {
public:
  AcpiPciIrqRoutingTable() { }

  void AddRoute(AcpiPciIrqRoute route) {
    _routes.push_back(route);
  }

  AcpiPciIrqRoute Get(size_t index) const {
    RT_ASSERT(index < _routes.size());
    return _routes[index];
  }

  size_t size() const {
    return _routes.size();
  }
private:
  std::vector<AcpiPciIrqRoute> _routes;
};


class AcpiManager {
public:
  AcpiManager();
  AcpiObjectsList GetPciDevices();
private:
  bool Init();
  bool SetInterruptRoutingMode();
  DELETE_COPY_AND_ASSIGN(AcpiManager);
};

} // namespace rt
