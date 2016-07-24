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
const IP4Address = require('./ip4-address');
// const interfaces = require('./interfaces');
const assert = require('assert');
const bitTwiddle = require('bit-twiddle');
const table = [];

class Entry {
  constructor(ip, mask, gateway, intf) {
    assert(ip instanceof IP4Address);
    assert(mask instanceof IP4Address);
    assert(gateway === null || (gateway instanceof IP4Address));

    this.ip = ip;
    this.mask = mask;
    this.maskBits = bitTwiddle.popCount(mask.toInteger());
    this.gateway = gateway;
    this.intf = intf;

    debug(`[ ADD ROUTE ${ip.toString()}/${this.maskBits} via ${gateway} ${intf.name} ]`);
  }
}

exports.addSubnet = (ip, mask, gateway, intf) => table.push(new Entry(ip, mask, gateway, intf));

exports.addDefault = (gateway, intf) => table.push(new Entry(IP4Address.ANY, IP4Address.ANY, gateway, intf));

exports.lookup = (destIP, intf) => {
  let result = null;
  let maxMaskBits = 0;
  for (const entry of table) {
    if (intf && entry.intf !== intf) {
      continue;
    }

    if (destIP.and(entry.mask).equals(entry.ip) && entry.maskBits >= maxMaskBits) {
      result = entry;
      maxMaskBits = entry.maskBits;
    }
  }

  return result;
};
