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

var IP4Address = require('./ip4-address');
var interfaces = require('./interfaces');
var assert = require('assert');
var bitTwiddle = require('bit-twiddle');
var table = [];

function Entry(ip, mask, gateway, intf) {
  assert(ip instanceof IP4Address);
  assert(mask instanceof IP4Address);
  assert(null === gateway || (gateway instanceof IP4Address));

  this.ip = ip;
  this.mask = mask;
  this.maskBits = bitTwiddle.popCount(mask.toInteger());
  this.gateway = gateway;
  this.intf = intf;

  debug('[ ADD ROUTE', ip.toString() + '/' + this.maskBits, 'via', gateway, intf.name, ']');
}

exports.addSubnet = function(ip, mask, gateway, intf) {
  table.push(new Entry(ip, mask, gateway, intf));
};

exports.addDefault = function(gateway, intf) {
  table.push(new Entry(IP4Address.ANY, IP4Address.ANY, gateway, intf));
};

exports.lookup = function(destIP, intf) {
  var result = null;
  var maxMaskBits = 0;
  for (var i = 0, l = table.length; i < l; ++i) {
    var entry = table[i];

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
