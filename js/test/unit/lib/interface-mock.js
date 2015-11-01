// Copyright 2015 runtime.js project authors
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

var Interface = require('../../../core/net/interface');
var MACAddress = require('../../../core/net/mac-address');
var IP4Address = require('../../../core/net/ip4-address');

module.exports = function(opts) {
  opts = opts || {};
  var ip = opts.ip || new IP4Address(127, 0, 0, 1);
  var mask = opts.mask || new IP4Address(255, 0, 0, 0);
  var mac = opts.mac || new MACAddress(1, 2, 3, 4, 5, 6);
  var intf = new Interface(mac);
  intf.disableArp();
  intf.configure(ip, mask);
  intf.ontransmit = function() {};
  return intf;
};
