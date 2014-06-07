// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

define('driverUtils', ['resources'],
function(resources) {
    "use strict";

    return {
        physicalMemory: function(address, byteLength) {
            return resources.memoryRange.block(address >>> 0,
                                               byteLength >>> 0);
        },
        irq: function(number) {
            return resources.irqRange.irq(number >>> 0);
        },
        ioPort: function(number) {
            return resources.ioRange.port(number >>> 0);
        },
    };
});
