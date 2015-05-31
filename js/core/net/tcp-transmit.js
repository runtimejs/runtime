// Copyright 2014-2015 runtime.js project authors
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
var ethernet = require('./ethernet');
var ip4header = require('./ip4-header');
var tcpHeader = require('./tcp-header');
var route = require('./route');

module.exports = function(intf, destIP, viaIP, srcPort, destPort, seqNumber, ackNumber, flags, windowSize, u8data) {
  var ipOffset = intf.bufferDataOffset + ethernet.headerLength;
  var tcpOffset = ipOffset + ip4header.minHeaderLength;
  var headerLength = tcpOffset + tcpHeader.headerLength;
  var u8headers = new Uint8Array(headerLength);
  var dataLength = u8data ? u8data.length : 0;
  var datagramLength = dataLength + tcpHeader.headerLength;

  var srcIP = intf.ipAddr;

  ip4header.write(u8headers, ipOffset, ip4header.PROTOCOL_TCP, srcIP, destIP,
    ip4header.minHeaderLength + tcpHeader.headerLength + dataLength);
  tcpHeader.write(u8headers, tcpOffset, srcPort, destPort, seqNumber, ackNumber, flags, windowSize);

  var sum = ((destIP.a << 8) | destIP.b) + ((destIP.c << 8) | destIP.d) +
      ((srcIP.a << 8) | srcIP.b) + ((srcIP.c << 8) | srcIP.d) +
      datagramLength + ip4header.PROTOCOL_TCP;

  var ckHeader = checksum.buffer(u8headers, tcpOffset, tcpHeader.headerLength);
  var ckData = u8data ? checksum.buffer(u8data, 0, u8data.length) : 0;
  var ck = checksum.result(ckHeader + ckData + sum);

  tcpHeader.writeChecksum(u8headers, tcpOffset, ck);

  intf.sendIP4(viaIP || destIP, u8headers, u8data);
};
