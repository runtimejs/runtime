// Copyright 2015 runtime.js project authors
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
var checksum = require('./checksum');
var ethernet = require('./ethernet');
var ip4header = require('./ip4-header');
var icmpHeader = require('./icmp-header');
var route = require('./route');

module.exports = function(intf, destIP, viaIP, type, code, headerValue, u8data) {
  var ipOffset = intf.bufferDataOffset + ethernet.headerLength;
  var icmpOffset = ipOffset + ip4header.minHeaderLength;
  var headerLength = icmpOffset + icmpHeader.headerLength;
  var u8headers = new Uint8Array(headerLength);

  var srcIP = intf.ipAddr;

  ip4header.write(u8headers, ipOffset, ip4header.PROTOCOL_ICMP, srcIP, destIP,
    ip4header.minHeaderLength + icmpHeader.headerLength + u8data.length);
  icmpHeader.write(u8headers, icmpOffset, type, code, headerValue);

  var ckHeader = checksum.buffer(u8headers, icmpOffset, icmpHeader.headerLength);
  var ckData = u8data ? checksum.buffer(u8data, 0, u8data.length) : 0;
  var ck = checksum.result(ckHeader + ckData);
  icmpHeader.writeChecksum(u8headers, icmpOffset, ck);

  intf.sendIP4(viaIP || destIP, u8headers, u8data);
};
