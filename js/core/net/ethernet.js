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
const u8view = require('u8-view');

exports.ETHERTYPE_IP4 = 0x0800;
exports.ETHERTYPE_ARP = 0x0806;

exports.getDestMAC = (u8, headerOffset) => (new MACAddress(u8[headerOffset + 0],
                                                           u8[headerOffset + 1],
                                                           u8[headerOffset + 2],
                                                           u8[headerOffset + 3],
                                                           u8[headerOffset + 4],
                                                           u8[headerOffset + 5]));

exports.getSrcMAC = (u8, headerOffset) => (new MACAddress(u8[headerOffset + 6],
                                                          u8[headerOffset + 7],
                                                          u8[headerOffset + 8],
                                                          u8[headerOffset + 9],
                                                          u8[headerOffset + 10],
                                                          u8[headerOffset + 11]));

exports.getEtherType = (u8, headerOffset) => ((u8[headerOffset + 12] << 8) + u8[headerOffset + 13]) >>> 0;

exports.write = (u8, headerOffset, destMAC, srcMAC, etherType) => {
  u8[headerOffset + 0] = destMAC.a;
  u8[headerOffset + 1] = destMAC.b;
  u8[headerOffset + 2] = destMAC.c;
  u8[headerOffset + 3] = destMAC.d;
  u8[headerOffset + 4] = destMAC.e;
  u8[headerOffset + 5] = destMAC.f;
  u8[headerOffset + 6] = srcMAC.a;
  u8[headerOffset + 7] = srcMAC.b;
  u8[headerOffset + 8] = srcMAC.c;
  u8[headerOffset + 9] = srcMAC.d;
  u8[headerOffset + 10] = srcMAC.e;
  u8[headerOffset + 11] = srcMAC.f;
  u8view.setUint16BE(u8, headerOffset + 12, etherType);
};

exports.headerLength = 14;
