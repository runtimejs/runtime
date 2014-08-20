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

define('arp', [],
function() {
    "use strict";

    var HARDWARE_TYPE_ETHERNET = 1;
    var PROTOCOL_IP4 = 0x0800;
    var OPERATION_REQEUST = 1;
    var OPERATION_REPLY = 2;

    var arpCache = {};
    var arpResolve = {};

    var sendARP = null;

    function parse(reader) {
        var hardwareType = reader.readUint16();
        var protocolType = reader.readUint16();
        var hardwareAddrLen = reader.readUint8();
        var protocolAddrLen = reader.readUint8();
        var op = reader.readUint16();

        if (HARDWARE_TYPE_ETHERNET !== hardwareType) {
            return;
        }

        if (PROTOCOL_IP4 !== protocolType) {
            return;
        }

        if (6 !== hardwareAddrLen) {
            return;
        }

        if (4 !== protocolAddrLen) {
            return;
        }

        var senderHardware = [reader.readUint8(), reader.readUint8(),
                              reader.readUint8(), reader.readUint8(),
                              reader.readUint8(), reader.readUint8()];

        var senderProtocol = [reader.readUint8(), reader.readUint8(),
                              reader.readUint8(), reader.readUint8()];

        var targetHardware = [reader.readUint8(), reader.readUint8(),
                              reader.readUint8(), reader.readUint8(),
                              reader.readUint8(), reader.readUint8()];

        var targetProtocol = [reader.readUint8(), reader.readUint8(),
                              reader.readUint8(), reader.readUint8()];

        isolate.log('ARP RECV');

        var cacheKey = senderProtocol.join('.');
        arpCache[cacheKey] = senderHardware;
        if ('undefined' !== typeof arpResolve[cacheKey]) {
            for (var i = 0; i < arpResolve[cacheKey].length; ++i) {
                arpResolve[cacheKey][i](senderHardware);
            }
            delete arpResolve[cacheKey];
        }

        return {
            senderHardware: senderHardware,
            senderProtocol: senderProtocol,
            targetHardware: targetHardware,
            targetProtocol: targetProtocol,
        };
    }

    function send(ifc, op, srcHwAddr, srcIpAddr, targetHwAddr, targetIpAddr) {
        var buf = new ArrayBuffer(28);
        var view = new DataView(buf);

        view.setUint16(0, HARDWARE_TYPE_ETHERNET, false);
        view.setUint16(2, PROTOCOL_IP4, false);
        view.setUint8(4, 6); // hwAddr len
        view.setUint8(5, 4); // protocol addr len
        view.setUint16(6, op, false); // operation

        var i, pos = 8;
        for (i = 0; i < 6; ++i) {
            view.setUint8(pos++, srcHwAddr[i], false);
        }
        for (i = 0; i < 4; ++i) {
            view.setUint8(pos++, srcIpAddr[i], false);
        }
        for (i = 0; i < 6; ++i) {
            view.setUint8(pos++, targetHwAddr[i], false);
        }
        for (i = 0; i < 4; ++i) {
            view.setUint8(pos++, targetIpAddr[i], false);
        }

        sendARP('eth0', buf, 0, buf.byteLength);
    }

    function requestHwAddr(ifc, srcHwAddr, srcIpAddr, targetIpAddr, resolve) {
        var cacheKey = targetIpAddr.join('.');
        if ('undefined' === typeof arpCache[cacheKey]) {
            if ('undefined' === typeof arpResolve[cacheKey]) {
                arpResolve[cacheKey] = [];
            }

            if (-1 === arpResolve[cacheKey].indexOf(resolve)) {
                arpResolve[cacheKey] .push(resolve);
            }

            send(ifc, OPERATION_REQEUST, srcHwAddr, srcIpAddr, [0, 0, 0, 0, 0, 0], targetIpAddr);
        } else {
            resolve(arpCache[cacheKey]);
        }
    }

    return {
        requestHwAddr: requestHwAddr,
        parse: parse,
        setup: function(opts) {
            sendARP = opts.sendARP;
        },
    };
});
