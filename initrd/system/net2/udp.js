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

var udpHeader = require('./udp-header');
var PortPool = require('./port-pool');

var ports = new PortPool();

exports.receive = function(intf, u8, headerOffset) {
  var srcPort = udpHeader.getSrcPort(u8, headerOffset);
  var destPort = udpHeader.getDestPort(u8, headerOffset);
  var dataLength = udpHeader.getDataLength(u8, headerOffset);
  console.log('recv UDP over IP4', srcPort, destPort, dataLength);
};
