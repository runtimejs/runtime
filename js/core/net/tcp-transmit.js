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
const tcpHeader = require('./tcp-header');
// const route = require('./route');

module.exports = (intf, destIP, viaIP, srcPort, destPort, seqNumber, ackNumber, flags, windowSize, u8data) => {
  const ipOffset = intf.bufferDataOffset + ethernet.headerLength;
  const tcpOffset = ipOffset + ip4header.minHeaderLength;
  const headerLength = tcpOffset + tcpHeader.headerLength;
  const u8headers = new Uint8Array(headerLength);
  const dataLength = u8data ? u8data.length : 0;
  const datagramLength = dataLength + tcpHeader.headerLength;

  const srcIP = intf.ipAddr;

  ip4header.write(u8headers, ipOffset, ip4header.PROTOCOL_TCP, srcIP, destIP,
    ip4header.minHeaderLength + tcpHeader.headerLength + dataLength);
  tcpHeader.write(u8headers, tcpOffset, srcPort, destPort, seqNumber, ackNumber, flags, windowSize);

  const sum = ((destIP.a << 8) | destIP.b) + ((destIP.c << 8) | destIP.d) +
      ((srcIP.a << 8) | srcIP.b) + ((srcIP.c << 8) | srcIP.d) +
      datagramLength + ip4header.PROTOCOL_TCP;

  const ckHeader = checksum.buffer(u8headers, tcpOffset, tcpHeader.headerLength);
  const ckData = u8data ? checksum.buffer(u8data, 0, u8data.length) : 0;
  const ck = checksum.result(ckHeader + ckData + sum);

  tcpHeader.writeChecksum(u8headers, tcpOffset, ck);

  intf.sendIP4(viaIP || destIP, u8headers, u8data);
};
