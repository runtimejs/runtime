// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

rt.log('Device manager started.');

(function(args) {
    "use strict";

    var resources = args.resources;
    var procManager = resources.processManager;

    var memrange = resources.memoryRange;

    // Start text video driver on CGA buffer
    procManager.create(rt.initrdText("/driver/textvideo.js"), {
        resources: {
            videoMemory: memrange.block(0xb8000, 80 * 25 * 2),
            width: 80,
            height: 25
        },
    });

    // Start PCI bus driver
    procManager.create(rt.initrdText("/driver/pci.js"), {
        resources: resources,
    });
})(rt.args());
