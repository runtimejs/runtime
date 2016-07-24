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
const udpHeader = require('./udp-header');
const UDPSocket = require('./udp-socket');
// const portUtils = require('./port-utils');
// const IP4Address = require('./ip4-address');
// const interfaces = require('./interfaces');
// const netError = require('./net-error');

function receive(intf, srcIP, destIP, u8, headerOffset) {
  const srcPort = udpHeader.getSrcPort(u8, headerOffset);
  const destPort = udpHeader.getDestPort(u8, headerOffset);
  const dataLength = udpHeader.getDataLength(u8, headerOffset) - udpHeader.headerLength;
  const dataOffset = headerOffset + udpHeader.headerLength;
  debug('recv UDP over IP4', srcPort, destPort, dataLength);

  const socket = UDPSocket.lookupReceive(destPort);
  if (!socket) {
    return;
  }

  const u8data = u8.subarray(dataOffset);
  if (socket.onmessage) setImmediate(() => socket.onmessage(srcIP, srcPort, u8data));
}

exports.receive = receive;
