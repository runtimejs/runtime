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

define('net/udp', [],
function() {
    "use strict";

    var headerLength = 8;

    function writeHeader(view, offset, opts) {
        var len = view.byteLength - offset;
        view.setUint16(offset + 0, opts.srcPort, false);
        view.setUint16(offset + 2, opts.destPort, false);
        view.setUint16(offset + 4, len, false);
        view.setUint16(offset + 6, 0, false); // no checksum
    }

    function parse(reader) {
        var srcPort = reader.readUint16();
        var destPort = reader.readUint16();
        var dataLength = reader.readUint16();
        reader.readUint16(); // Checksum
        // TODO: verify checksum

        return {
            srcPort: srcPort,
            destPort: destPort,
            dataLength: dataLength
        };
    }

    return {
        writeHeader: writeHeader,
        headerLength: headerLength,
        parse: parse,
    };
});
