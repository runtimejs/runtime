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
