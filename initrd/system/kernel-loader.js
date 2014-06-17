// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

define('kernelLoader', ['resources'],
function(resources) {
    "use strict";

    var load = resources.loader;
    var files = {
        // Files that require native runtime functions
        runtime: [
            '/lib/runtime/0.1.0/platform.js',
        ],
        // Standard kernel files
        standard: [
            '/system/device-manager.js',
            '/system/driver-utils.js',
            '/system/keyboard.js',
            '/system/vfs.js',
            '/system/driver/vga.js',
            '/utils.js',
        ],
    };

    function loadRuntimeFn(name) {
        var fn = new Function('define', 'RUNTIME', load(name));
        fn(define, resources.natives);
    }

    function loadFn(name) {
        var fn = new Function('define', load(name));
        fn(define);
    }

    files.runtime.forEach(loadRuntimeFn);
    files.standard.forEach(loadFn);

    return {
        load: loadFn,
    };
});
