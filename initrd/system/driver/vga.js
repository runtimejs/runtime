// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

define('vga', ['driverUtils'],
function(driverUtils) {
    "use strict";

    // Take ownership of the display
    rt.stopVideoLog();

    var w = 80, h = 25, len = w * h;
    var buf = driverUtils.physicalMemory(0xb8000, len * 2).buffer();
    var b = new Uint8Array(buf);

    return {
        client: {
            drawBuffer: function(buf) {
                b.set(new Uint8Array(buf));
                return Promise.resolve(buf);
            },
            allocBuffers: function(count) {
                var a = new Array(count);
                for (var i = 0; i < count; ++i) {
                    a[i] = new ArrayBuffer(len * 2);
                }

                return Promise.resolve(a);
            },
            colors: {
                black: 0,
                blue: 1,
                green: 2,
                cyan: 3,
                red: 4,
                magenta: 5,
                brown: 6,
                lightgray: 7,
                darkgray: 8,
                lightblue: 9,
                lightgreen: 10,
                lightcyan: 11,
                lightred: 12,
                lightmagenta: 13,
                yellow: 14,
                white: 15
            },
            info: {
                width: w,
                height: h,
            },
        },
    };
});
