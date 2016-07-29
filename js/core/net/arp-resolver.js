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
// const assert = require('assert');
const MACAddress = require('./mac-address');
const IP4Address = require('./ip4-address');
const arpTransmit = require('./arp-transmit');
const arpHeader = require('./arp-header');

class ARPResolver {
  constructor(intf) {
    this.intf = intf;
    this.table = new Map();
  }
  receive(u8, headerOffset) {
    const operation = arpHeader.getOperation(u8, headerOffset);
    const srcMAC = arpHeader.getSrcMAC(u8, headerOffset);
    const srcIP = arpHeader.getSrcIP(u8, headerOffset);
    const targetMAC = arpHeader.getTargetMAC(u8, headerOffset);
    const targetIP = arpHeader.getTargetIP(u8, headerOffset);
    const selfIP = this.intf.ipAddr;

    debug('recv ARP', operation, srcMAC, srcIP, targetMAC, targetIP, selfIP);

    switch (operation) {
      case arpHeader.OPERATION_REQEUST:
        // Somebody requested this machine IP
        if (!selfIP.equals(IP4Address.ANY) && selfIP.equals(targetIP)) {
          this.reply(srcMAC, targetIP);
        }
        break;
      case arpHeader.OPERATION_REPLY:
        this.table.set(srcIP.hash(), srcMAC);
        break;
      default:
        break;
    }
  }
  request(targetIP) {
    arpTransmit(this.intf, arpHeader.OPERATION_REQEUST,
      this.intf.macAddr, this.intf.ipAddr,
      MACAddress.ZERO, targetIP);
  }
  reply(targetMAC, targetIP) {
    arpTransmit(this.intf, arpHeader.OPERATION_REPLY,
      this.intf.macAddr, this.intf.ipAddr,
      targetMAC, targetIP);
  }
  get(ip) {
    return this.table.get(ip.hash()) || null;
  }
}

module.exports = ARPResolver;
