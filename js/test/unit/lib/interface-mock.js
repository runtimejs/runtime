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

const Interface = require('../../../core/net/interface');
const MACAddress = require('../../../core/net/mac-address');
const IP4Address = require('../../../core/net/ip4-address');

module.exports = (opts = {}) => {
  const ip = opts.ip || new IP4Address(127, 0, 0, 1);
  const mask = opts.mask || new IP4Address(255, 0, 0, 0);
  const mac = opts.mac || new MACAddress(1, 2, 3, 4, 5, 6);
  const intf = new Interface(mac);
  intf.disableArp();
  intf.configure(ip, mask);
  intf.ontransmit = () => {};
  return intf;
};
