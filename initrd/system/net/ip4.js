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

var checksum = require('./checksum');
var minHeaderLength = 20;
var nextId = 0;

var protocol = {
  ICMP: 0x01,
  TCP: 0x06,
  UDP: 0x11,
};

var protocolReverse = {
  0x01: 'ICMP',
  0x06: 'TCP',
  0x11: 'UDP',
};

function writeHeader(view, offset, protocolId, srcIP, destIP) {
  var hdrLength = minHeaderLength;
  var version = 4; // IPv4
  var IHL = hdrLength >>> 2;
  var byte0 = ((version << 4) | IHL) >>> 0;
  view.setUint8(offset + 0, byte0);
  view.setUint8(offset + 1, 0); // ToS

  var len = view.byteLength - offset;// - 4;
  // view.setUint16(offset + 2, dataLength + hdrLength, false); // Total length
  view.setUint16(offset + 2, len, false); // Total length

  view.setUint16(offset + 4, ++nextId, false); // ID
  view.setUint16(offset + 6, 0, false); // No fragmantation
  view.setUint8(offset + 8, 64); // TTL

  var protocolId = protocol[protocolId];
  if ('undefined' === typeof protocolId) {
    throw new Error('unknown protocol');
  }
  view.setUint8(offset + 9, protocolId);
  view.setUint16(offset + 10, 0, false); // set header checksum to 0
  var i, pos = 12;
  for (i = 0; i < 4; ++i) {
    view.setUint8(offset + pos++, srcIP[i]);
  }
  for (i = 0; i < 4; ++i) {
    view.setUint8(offset + pos++, destIP[i]);
  }

  var cksum = checksum.full(new Uint8Array(view.buffer), offset, hdrLength, 0);
  view.setUint16(offset + 10, cksum, false); // set header checksum
}

function parse(reader) {
  var ipVersion = reader.readUint8() >>> 4;
  if (4 !== ipVersion) {
    return null;
  }

  reader.readUint8(); // ToS
  var dataLength = reader.readUint16();

  reader.readUint16(); // ID
  reader.readUint16(); // Fragments data
  reader.readUint8(); // TTL

  var protocolId = reader.readUint8();
  if ('string' !== typeof protocolReverse[protocolId]) {
    // Unknown protocol
    return null;
  }

  var protocolName = protocolReverse[protocolId];
  var cksum = reader.readUint16(); // Checksum
  // TODO: verify checksum

  var srcIP = [reader.readUint8(), reader.readUint8(),
         reader.readUint8(), reader.readUint8()];

  var destIP = [reader.readUint8(), reader.readUint8(),
          reader.readUint8(), reader.readUint8()];

  return {
    dataLength: dataLength,
    protocol: protocolName,
    srcIP: srcIP,
    destIP: destIP,
  };
}

module.exports = {
  writeHeader: writeHeader,
  getHeaderLength: function(opts) {
    // IP packet options are not supported (yet)
    return minHeaderLength;
  },
  parse: parse,
};
