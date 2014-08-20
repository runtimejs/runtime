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
        // Standard kernel files
        standard: [
            '/system/device-manager.js',
            '/system/driver-utils.js',
            '/system/keyboard.js',
            '/system/vfs.js',
            '/system/driver/vga.js',
            '/system/net/net.js',
            '/system/net/eth.js',
            '/system/net/ip4.js',
            '/system/net/udp.js',
            '/system/net/socket.js',
            '/system/net/dhcp.js',
            '/system/net/arp.js',
            '/utils.js',
        ],
    };

    files.standard.forEach(load);

    return {
        load: load,
    };
});
