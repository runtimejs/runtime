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

// List PCI devices
(function() {
    "use strict";

    function error(message) {
        console.error('lspci: ' + message);
    }

    isolate.system.kernel.lspci().then(function(data) {
        for (var i = 0; i < data.length; ++i) {
            var dev = data[i];
            console.log(dev.bus.toString(16) + ':' + dev.slot.toString(16) + '.' + dev.func + ' ' +
                dev.vendorId.toString(16) + ':' + dev.deviceId.toString(16) + ' ' +
                dev.className + ' IRQ: ' + dev.irq + ' PIN: ' + dev.pin);
        }
    }, function(err) {
        if (!(err instanceof Error)) {
            return;
        }

        switch (err.message) {
            case 'NOT_READY':
                error('PCI subsystem is not ready.');
                break;
            default:
                error('Unknown PCI subsystem error.');
                break;
        }
    });
})();
