// Copyright 2015-present runtime.js project authors
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
const icmpHeader = require('./icmp-header');
// const route = require('./route');

module.exports = (intf, destIP, viaIP, type, code, headerValue, u8data) => {
  const ipOffset = intf.bufferDataOffset + ethernet.headerLength;
  const icmpOffset = ipOffset + ip4header.minHeaderLength;
  const headerLength = icmpOffset + icmpHeader.headerLength;
  const u8headers = new Uint8Array(headerLength);

  const srcIP = intf.ipAddr;

  ip4header.write(u8headers, ipOffset, ip4header.PROTOCOL_ICMP, srcIP, destIP,
    ip4header.minHeaderLength + icmpHeader.headerLength + u8data.length);
  icmpHeader.write(u8headers, icmpOffset, type, code, headerValue);

  const ckHeader = checksum.buffer(u8headers, icmpOffset, icmpHeader.headerLength);
  const ckData = u8data ? checksum.buffer(u8data, 0, u8data.length) : 0;
  const ck = checksum.result(ckHeader + ckData);
  icmpHeader.writeChecksum(u8headers, icmpOffset, ck);

  intf.sendIP4(viaIP || destIP, u8headers, u8data);
};
