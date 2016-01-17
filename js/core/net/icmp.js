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

var icmpHeader = require('./icmp-header');
var icmpTransmit = require('./icmp-transmit');
var route = require('./route');
var Ping = require('./ping');

function handleEchoRequest(intf, srcIP, u8, headerOffset) {
  if (srcIP.isBroadcast() || srcIP.isAny()) {
    return;
  }

  var routingEntry = route.lookup(srcIP);
  if (!routingEntry) {
    debug('[ICMP] no route for ICMP reply to ' + srcIP);
    return;
  }

  var viaIP = routingEntry.gateway;
  var id = icmpHeader.getEchoRequestIdentifier(u8, headerOffset);
  var seq = icmpHeader.getEchoRequestSequence(u8, headerOffset);

  icmpTransmit(intf, srcIP, viaIP, icmpHeader.ICMP_TYPE_ECHO_REPLY, 0,
               icmpHeader.headerValueEcho(id, seq),
               u8.subarray(headerOffset + icmpHeader.headerLength));
}

function handleEchoReply(intf, srcIP, u8, headerOffset) {
  var id = icmpHeader.getEchoRequestIdentifier(u8, headerOffset);
  var seq = icmpHeader.getEchoRequestSequence(u8, headerOffset);
  var ping = Ping._receiveLookup(id);
  if (ping) {
    ping._receive(srcIP, seq, u8, headerOffset + icmpHeader.headerLength);
  }
}

exports.receive = function(intf, srcIP, destIP, u8, headerOffset) {
  debug('recv ICMP over IP4');

  var type = icmpHeader.getType(u8, headerOffset);
  var code = icmpHeader.getCode(u8, headerOffset);

  if (type === icmpHeader.ICMP_TYPE_ECHO_REQUEST) {
    handleEchoRequest(intf, srcIP, u8, headerOffset);
    return;
  }

  if (type === icmpHeader.ICMP_TYPE_ECHO_REPLY) {
    handleEchoReply(intf, srcIP, u8, headerOffset);
    return;
  }
};
