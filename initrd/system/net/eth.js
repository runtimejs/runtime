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

define('eth', [],
function() {
    "use strict";

    var headerLength = 14;

    function writeHeader(view, offset, opts) {
        var i = 0, pos = 0;
        for (i = 0; i < 6; ++i) {
            view.setUint8(offset + pos++, opts.destMac[i]);
        }
        for (i = 0; i < 6; ++i) {
            view.setUint8(offset + pos++, opts.srcMac[i]);
        }
        // EtherType (Ethernet 2 frame)
        view.setUint8(offset + pos++, 0x08);
        view.setUint8(offset + pos++, 0x00);
    }

    function parse(reader) {
        var destMac = [0, 0, 0, 0, 0, 0];
        var srcMac = [0, 0, 0, 0, 0, 0];
        var i;
        for (i = 0; i < 6; ++i) {
            destMac[i] = reader.readUint8();
        }
        for (i = 0; i < 6; ++i) {
            srcMac[i] = reader.readUint8();
        }

        var etherTypeId = reader.readUint16();
        var etherType = '';
        switch (etherTypeId) {
            case 0x0800: etherType = 'IPv4'; break;
            case 0x0806: etherType = 'ARP'; break;
            case 0x8100: etherType = '802.1Q'; break;
            case 0x86dd: etherType = 'IPv6'; break;
            default: return null;
        }

        return {
            destMac: destMac,
            srcMac: srcMac,
            etherType: etherType,
        };
    }

    return {
        writeHeader: writeHeader,
        headerLength: headerLength,
        parse: parse,
    };
});
