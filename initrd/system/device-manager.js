// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

define('deviceManager', ['kernelLoader'],
function(kernelLoader) {
    "use strict";

    /**
     * TODO: move drivers out of the kernel
     */
    kernelLoader.load('/system/driver/ps2kbd.js');
    kernelLoader.load('/driver/pci.js');
    kernelLoader.load('/driver/pci-drivers.js');

    // Start PCI bus driver
    // procManager.create(rt.initrdText("/driver/pci.js"), {
    //     resources: resources,
    // });

    return {};
});
