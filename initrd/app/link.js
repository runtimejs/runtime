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

(function() {
    "use strict";

    function error(message) {
        console.error('lspci: ' + message);
    }

    isolate.system.kernel.listNetworkInterfaces().then(function(data) {
        data.forEach(function(ifc) {
            isolate.env.stdout(ifc.name + '\n', {fg: 'yellow'});

            if (ifc.hwAddr) {
                var hw = ifc.hwAddr.map(function(x) {
                    return (x < 0x10) ? '0' + x.toString(16) : x.toString(16);
                }).join(':');
                console.log('  hw ' + hw);
            }

            if (ifc.ip && ifc.netmask) {
                var ip = ifc.ip.join('.');
                var mask = ifc.netmask.join('.');
                console.log('  ip ' + ip + ' netmask ' + mask);
            }

            if (ifc.gateway) {
                var gateway = ifc.gateway.join('.');
                console.log('  router ' + gateway);
            }
        });
    }, function(err) {
        if (!(err instanceof Error)) {
            return;
        }

        switch (err.message) {
            case 'NOT_READY':
                error('Network subsystem is not ready.');
                break;
            default:
                error('Unknown network subsystem error.');
                break;
        }
    });
})();
