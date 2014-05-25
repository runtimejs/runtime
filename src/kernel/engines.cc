// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "engines.h"
#include <kernel/acpi-manager.h>

namespace rt {

AcpiManager* Engines::acpi_manager() {
    if (nullptr == _acpi_manager) {
        _acpi_manager = new AcpiManager();
    }

    RT_ASSERT(_acpi_manager);
    return _acpi_manager;
}

} // namespace rt
