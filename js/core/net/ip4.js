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

'use strict';
var IP4Address = require('./ip4-address');
var ip4header = require('./ip4-header');
var udp = require('./udp');
var tcp = require('./tcp');
var icmp = require('./icmp');

exports.receive = function(intf, u8, headerOffset) {
  var headerLength = ip4header.getHeaderLength(u8, headerOffset);
  var protocolId = ip4header.getProtocolId(u8, headerOffset);
  var srcIP = ip4header.getSrcIP(u8, headerOffset);
  var destIP = ip4header.getDestIP(u8, headerOffset);
  var nextOffset = headerOffset + headerLength;

  switch (protocolId) {
  case 0x01: return icmp.receive(intf, u8, nextOffset);
  case 0x06: return tcp.receive(intf, srcIP, destIP, u8, nextOffset);
  case 0x11: return udp.receive(intf, srcIP, destIP, u8, nextOffset);
  }
};
