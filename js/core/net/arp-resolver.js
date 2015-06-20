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
var assert = require('assert');
var MACAddress = require('./mac-address');
var IP4Address = require('./ip4-address');
var arpTransmit = require('./arp-transmit');
var arpHeader = require('./arp-header');

function ARPResolver(intf) {
  this.intf = intf;
  this.table = new Map();
}

ARPResolver.prototype.receive = function(u8, headerOffset) {
  var operation = arpHeader.getOperation(u8, headerOffset);
  var srcMAC = arpHeader.getSrcMAC(u8, headerOffset);
  var srcIP = arpHeader.getSrcIP(u8, headerOffset);
  var targetMAC = arpHeader.getTargetMAC(u8, headerOffset);
  var targetIP = arpHeader.getTargetIP(u8, headerOffset);
  var selfIP = this.intf.ipAddr;

  debug('recv ARP', operation, srcMAC, srcIP, targetMAC, targetIP, selfIP);

  switch (operation) {
  case arpHeader.OPERATION_REQEUST:
    // Somebody requested this machine IP
    if (!selfIP.equals(IP4Address.ANY) && selfIP.equals(targetIP)) {
      this.reply(srcMAC, targetIP);
    }
    break;
  case arpHeader.OPERATION_REPLY:
    var key = srcIP.hash();
    this.table.set(key, srcMAC);
    break;
  }
};

ARPResolver.prototype.request = function(targetIP) {
  arpTransmit(this.intf, arpHeader.OPERATION_REQEUST,
    this.intf.macAddr, this.intf.ipAddr,
    MACAddress.ZERO, targetIP);
};

ARPResolver.prototype.reply = function(targetMAC, targetIP) {
  arpTransmit(this.intf, arpHeader.OPERATION_REPLY,
    this.intf.macAddr, this.intf.ipAddr,
    targetMAC, targetIP);
};

ARPResolver.prototype.get = function(ip) {
  return this.table.get(ip.hash()) || null;
};

module.exports = ARPResolver;
