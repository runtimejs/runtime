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

var tcpHeader = require('./tcp-header');
var TCPSocket = require('./tcp-socket');

exports.receive = function(intf, srcIP, destIP, u8, headerOffset) {
  var srcPort = tcpHeader.getSrcPort(u8, headerOffset);
  var destPort = tcpHeader.getDestPort(u8, headerOffset);
  var dataOffset = headerOffset + tcpHeader.getDataOffset(u8, headerOffset);

  var socket = TCPSocket.lookupReceive(destPort);
  if (!socket) {
    return;
  }

  if (!socket._intf) {
    socket._intf = intf;
  }

  socket._receive(u8, srcIP, srcPort, headerOffset);
};
