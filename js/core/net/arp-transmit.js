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
var ethernet = require('./ethernet');
var arpHeader = require('./arp-header');
var MACAddress = require('./mac-address');

module.exports = function(intf, operation, srcMAC, srcIP, targetMAC, targetIP) {
  var ethOffset = intf.bufferDataOffset;
  var arpOffset = ethOffset + ethernet.headerLength;
  var len = arpOffset + arpHeader.headerLength;
  var u8 = new Uint8Array(len);
  ethernet.write(u8, ethOffset, MACAddress.BROADCAST,
    intf.macAddr, ethernet.ETHERTYPE_ARP);
  arpHeader.write(u8, arpOffset, operation, srcMAC, srcIP, targetMAC, targetIP);
  intf.sendRaw(u8);
};
