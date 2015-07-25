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
var ARPResolver = require('./arp-resolver');
var ethernet = require('./ethernet');
var ip4 = require('./ip4');
var IP4Address = require('./ip4-address');
var EventController = require('event-controller');
var typeutils = require('typeutils');
var stat = require('./net-stat');

function Interface(macAddr) {
  assert(macAddr instanceof MACAddress);
  this.macAddr = macAddr;
  this.ontransmit = null;
  this.onNetworkUp = new EventController();
  this.onNetworkDown = new EventController();
  this.ipAddr = IP4Address.ANY;
  this.netmask = IP4Address.ANY;
  this.name = '';
  this.bufferDataOffset = 0;
  this.arp = new ARPResolver(this);
  this.isNetworkEnabled = false;
  this.fragments = new Map();
}

Interface.prototype.disableArp = function() {
  this.arp = null;
};

Interface.prototype.setNetworkEnabled = function(value) {
  assert(typeutils.isBoolean(value));
  if (this.isNetworkEnabled === value) {
    return;
  }

  this.isNetworkEnabled = value;
  if (value) {
    this.onNetworkUp.dispatch();
  } else {
    this.onNetworkDown.dispatch();
  }
};

Interface.prototype.getMACAddress = function() {
  return this.macAddr;
};

Interface.prototype.setName = function(name) {
  this.name = String(name);
};

Interface.prototype.setBufferDataOffset = function(offset) {
  assert((offset | 0) >= 0);
  this.bufferDataOffset = offset | 0;
};

Interface.prototype.configure = function(ip, mask) {
  assert(ip instanceof IP4Address);
  assert(mask instanceof IP4Address);
  this.ipAddr = ip;
  this.netmask = mask;
};

Interface.prototype.hasIP = function() {
  return !this.ipAddr.equals(IP4Address.ANY);
};

Interface.prototype.receive = function(u8) {
  ++stat.receiveCount;
  var etherType = ethernet.getEtherType(u8, this.bufferDataOffset);
  var nextOffset = this.bufferDataOffset + ethernet.headerLength;

  switch (etherType) {
  case 0x0800: return ip4.receive(this, u8, nextOffset);
  case 0x0806: return this.arp ? this.arp.receive(u8, nextOffset) : void 0;
  // case 0x8100: // 802.1Q
  // case 0x86dd: // ipv6
  }

  debug('receive called', etherType.toString(16));
};

Interface.prototype.sendRaw = function(u8) {
  ++stat.transmitCount;
  if (this.ontransmit) {
    this.ontransmit(u8, null);
  }
};

Interface.prototype.sendIP4 = function(viaIP, u8headers, u8data) {
  ++stat.transmitCount;
  var targetMAC;
  if (viaIP.isBroadcast()) {
    targetMAC = MACAddress.BROADCAST;
  } else if (this.arp) {
    targetMAC = this.arp.get(viaIP);
    if (!targetMAC) {
      this.arp.request(viaIP);
      return;
    }
  } else {
    targetMAC = MACAddress.ZERO;
  }

  ethernet.write(u8headers, this.bufferDataOffset, targetMAC,
    this.macAddr, 0x0800);
  if (this.ontransmit) {
    this.ontransmit(u8headers, u8data);
  }
};

module.exports = Interface;
