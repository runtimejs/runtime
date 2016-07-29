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
const tcpHeader = require('./tcp-header');
const TCPSocket = require('./tcp-socket');
const tcpSocketState = require('./tcp-socket-state');
const connHash = require('./tcp-hash');
const STATE_LISTEN = tcpSocketState.STATE_LISTEN;

function connectionSocket(socket, srcIP, srcPort) {
  return socket._connections.get(connHash(srcIP, srcPort)) || socket;
}

exports.receive = (intf, srcIP, destIP, u8, headerOffset) => {
  const srcPort = tcpHeader.getSrcPort(u8, headerOffset);
  const destPort = tcpHeader.getDestPort(u8, headerOffset);
  // const dataOffset = headerOffset + tcpHeader.getDataOffset(u8, headerOffset);

  let socket = TCPSocket.lookupReceive(destPort);

  if (!socket) {
    return;
  }
  if (socket._state === STATE_LISTEN) {
    socket = connectionSocket(socket, srcIP, srcPort);
  }
  if (!socket._intf) {
    socket._intf = intf;
  }

  socket._receive(u8, srcIP, srcPort, headerOffset);
};
