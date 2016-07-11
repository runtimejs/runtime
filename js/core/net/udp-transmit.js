// Copyright 2014-present runtime.js project authors
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

'use strict';
const checksum = require('./checksum');
const ethernet = require('./ethernet');
const ip4header = require('./ip4-header');
const udpHeader = require('./udp-header');
// const route = require('./route');

module.exports = (intf, destIP, viaIP, srcPort, destPort, u8data) => {
  const ipOffset = intf.bufferDataOffset + ethernet.headerLength;
  const udpOffset = ipOffset + ip4header.minHeaderLength;
  const headerLength = udpOffset + udpHeader.headerLength;
  const u8headers = new Uint8Array(headerLength);
  const datagramLength = u8data.length + udpHeader.headerLength;

  const srcIP = intf.ipAddr;

  ip4header.write(u8headers, ipOffset, ip4header.PROTOCOL_UDP, srcIP, destIP,
    ip4header.minHeaderLength + udpHeader.headerLength + u8data.length);
  udpHeader.write(u8headers, udpOffset, srcPort, destPort, datagramLength);

  const sum = ((destIP.a << 8) | destIP.b) + ((destIP.c << 8) | destIP.d) +
      ((srcIP.a << 8) | srcIP.b) + ((srcIP.c << 8) | srcIP.d) +
      datagramLength + ip4header.PROTOCOL_UDP +
      srcPort + destPort + datagramLength;

  const ck = checksum(u8data, 0, u8data.length, sum);
  udpHeader.writeChecksum(u8headers, udpOffset, ck);

  intf.sendIP4(viaIP || destIP, u8headers, u8data);
};
