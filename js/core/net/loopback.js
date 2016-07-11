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
const MACAddress = require('./mac-address');
const Interface = require('./interface');
const IP4Address = require('./ip4-address');
const route = require('./route');

const intf = new Interface(MACAddress.ZERO);
const ip = new IP4Address(127, 0, 0, 1);
const mask = new IP4Address(255, 0, 0, 0);
intf.disableArp();
intf.setName('loopback');
intf.configure(ip, mask);

intf.ontransmit = (u8headers, u8data) => {
  setTimeout(() => {
    if (u8data) {
      const u8 = new Uint8Array(u8headers.length + u8data.length);
      u8.set(u8headers, 0);
      u8.set(u8data, u8headers.length);
      intf.receive(u8);
    } else {
      intf.receive(u8headers);
    }
  }, 0);
};

const subnet = ip.and(mask);
route.addSubnet(subnet, mask, null, intf);

module.exports = intf;
