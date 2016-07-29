// Copyright 2015-present runtime.js project authors
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

const assertError = require('assert-error');
const IP4Address = require('./ip4-address');
const icmpTransmit = require('./icmp-transmit');
const icmpHeader = require('./icmp-header');
const route = require('./route');
const netError = require('./net-error');
const pingListeners = new Map();

function createPingBuffer(size) {
  const u8 = new Uint8Array(size);
  for (let i = 0; i < size; ++i) {
    u8[i] = 0x61 + (i % 26);
  } // ASCII a-z
  return u8;
}

let nextPingId = 1;
const defaultPingData = createPingBuffer(56);

class Ping {
  constructor() {
    this._pingId = (nextPingId++) & 0xffff;
    this._nextSeq = 0;
    this._data = defaultPingData;
    this.onreply = null;
  }

  /**
   * Send ICMP echo request (ping) to specified address. Returns request
   * sequence number.
   */
  send(ip) {
    const destIP = IP4Address.parse(ip);
    assertError(destIP instanceof IP4Address, netError.E_IPADDRESS_EXPECTED);

    const seq = this._nextSeq++;
    if (this._nextSeq > 0xffff) {
      this._nextSeq = 0;
    }

    const routingEntry = route.lookup(destIP);
    if (!routingEntry) {
      debug(`[ICMP] no route to send ICMP request to ${destIP}`);
      return seq;
    }

    if (!pingListeners.has(this._pingId)) {
      pingListeners.set(this._pingId, this);
    }

    const intf = routingEntry.intf;
    const viaIP = routingEntry.gateway;
    icmpTransmit(intf, destIP, viaIP, icmpHeader.ICMP_TYPE_ECHO_REQUEST, 0,
      icmpHeader.headerValueEcho(this._pingId, seq), this._data);

    return seq;
  }

  _receive(srcIP, seq, u8, dataOffset) {
    const dataLength = u8.length - dataOffset;
    if (dataLength !== this._data.length) {
      return;
    }

    for (let i = 0, l = dataLength; i < l; ++i) {
      if (u8[dataOffset + i] !== this._data[i]) {
        return;
      }
    }

    if (this.onreply) {
      this.onreply(srcIP, seq);
    }
  }

  /**
   * Stop listening to echo replies.
   */
  close() {
    if (pingListeners.has(this._pingId)) {
      pingListeners.delete(this._pingId);
    }
  }

  static _receiveLookup(pingId) {
    return pingListeners.get(pingId) || null;
  }
}

module.exports = Ping;
