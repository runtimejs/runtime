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
const assertError = require('assert-error');
const IP4Address = require('./ip4-address');
const portUtils = require('./port-utils');
const PortAllocator = require('./port-allocator');
const udpTransmit = require('./udp-transmit');
const netError = require('./net-error');
const typeutils = require('typeutils');
const route = require('./route');

const ports = new PortAllocator();

class UDPSocket {
  constructor(protocol = 'ip4') {
    this._protocol = protocol;
    this._intf = null;
    this._port = 0;
    this.onmessage = null;
  }

  send(ipOpt, port, u8) {
    let ip = ipOpt;
    if (typeutils.isString(ip)) {
      ip = IP4Address.parse(ip);
    }

    assertError(ip instanceof IP4Address, netError.E_IPADDRESS_EXPECTED);
    assertError(portUtils.isPort(port), netError.E_INVALID_PORT);
    assertError(u8 instanceof Uint8Array, netError.E_TYPEDARRAY_EXPECTED);

    let intf = this._intf || null;

    let viaIP;
    if (ip.isBroadcast()) {
      viaIP = ip;
    } else {
      const routingEntry = route.lookup(ip);
      if (!routingEntry) return console.log(`[UDP] no route to ${ip}`);

      viaIP = routingEntry.gateway;
      if (!intf) {
        intf = routingEntry.intf;
      }
    }

    if (!this._port) {
      this._port = ports.allocEphemeral(this);
      if (!this._port) {
        throw netError.E_NO_FREE_PORT;
      }
    }

    udpTransmit(intf, ip, viaIP, this._port, port, u8);
  }

  bind(port) {
    assertError(portUtils.isPort(port), netError.E_INVALID_PORT);

    if (!ports.allocPort(port, this)) {
      throw netError.E_ADDRESS_IN_USE;
    }

    this._port = port;
  }

  bindToInterface(intf, port) {
    if (!intf) {
      throw netError.E_INTERFACE_EXPECTED;
    }

    this._intf = intf;
    if (port) {
      this.bind(port);
    }
  }

  close() {
    if (this._port) {
      ports.free(this._port);
    }
  }

  static lookupReceive(destPort) {
    return ports.lookup(destPort);
  }
}

module.exports = UDPSocket;
