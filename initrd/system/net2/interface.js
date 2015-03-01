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

var assert = require('assert');
var MACAddress = require('./mac-address');
var ARPResolver = require('./arp-resolver');
var ethernet = require('./ethernet');
var ip4 = require('./ip4');

function Interface(macAddr) {
  assert(macAddr instanceof MACAddress);
  this.macAddr = macAddr;
  this.name = '';
  this.bufferDataOffset = 0;
  this.arp = new ARPResolver();
}

Interface.prototype.setName = function(name) {
  this.name = String(name);
};

Interface.prototype.setBufferDataOffset = function(offset) {
  assert((offset | 0) >= 0);
  this.bufferDataOffset = offset | 0;
};

Interface.prototype.receive = function(u8) {
  var etherType = ethernet.getEtherType(u8, this.bufferDataOffset);
  var nextOffset = this.bufferDataOffset + ethernet.headerLength;

  switch (etherType) {
  case 0x0800: return ip4.receive(this, u8, nextOffset);
  case 0x0806: return this.arp.receive(this, u8, nextOffset);
  // case 0x8100: // 802.1Q
  // case 0x86dd: // ipv6
  }

  console.log('receive called', etherType.toString(16));
  // runtime.debug(u8);
};

module.exports = Interface;
