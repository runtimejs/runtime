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
const u8view = require('u8-view');
const IP4Address = require('./ip4-address');
const MACAddress = require('./mac-address');

const HARDWARE_TYPE_ETHERNET = 1;
const PROTOCOL_IP4 = 0x0800;

exports.OPERATION_REQEUST = 1;
exports.OPERATION_REPLY = 2;

exports.getSrcMAC = (u8, headerOffset) => (new MACAddress(u8[headerOffset + 8],
                                                          u8[headerOffset + 9],
                                                          u8[headerOffset + 10],
                                                          u8[headerOffset + 11],
                                                          u8[headerOffset + 12],
                                                          u8[headerOffset + 13]));

exports.getSrcIP = (u8, headerOffset) => (new IP4Address(u8[headerOffset + 14],
                                                         u8[headerOffset + 15],
                                                         u8[headerOffset + 16],
                                                         u8[headerOffset + 17]));

exports.getTargetMAC = (u8, headerOffset) => (new MACAddress(u8[headerOffset + 18],
                                                             u8[headerOffset + 19],
                                                             u8[headerOffset + 20],
                                                             u8[headerOffset + 21],
                                                             u8[headerOffset + 22],
                                                             u8[headerOffset + 23]));

exports.getTargetIP = (u8, headerOffset) => (new IP4Address(u8[headerOffset + 24],
                                                            u8[headerOffset + 25],
                                                            u8[headerOffset + 26],
                                                            u8[headerOffset + 27]));

exports.getOperation = (u8, headerOffset) => u8view.getUint16BE(u8, headerOffset + 6);

exports.write = (u8, headerOffset, operation, srcMAC, srcIP, targetMAC, targetIP) => {
  u8view.setUint16BE(u8, headerOffset, HARDWARE_TYPE_ETHERNET);
  u8view.setUint16BE(u8, headerOffset + 2, PROTOCOL_IP4);
  u8[headerOffset + 4] = 6;
  u8[headerOffset + 5] = 4;
  u8view.setUint16BE(u8, headerOffset + 6, operation);
  u8[headerOffset + 8] = srcMAC.a;
  u8[headerOffset + 9] = srcMAC.b;
  u8[headerOffset + 10] = srcMAC.c;
  u8[headerOffset + 11] = srcMAC.d;
  u8[headerOffset + 12] = srcMAC.e;
  u8[headerOffset + 13] = srcMAC.f;
  u8[headerOffset + 14] = srcIP.a;
  u8[headerOffset + 15] = srcIP.b;
  u8[headerOffset + 16] = srcIP.c;
  u8[headerOffset + 17] = srcIP.d;
  u8[headerOffset + 18] = targetMAC.a;
  u8[headerOffset + 19] = targetMAC.b;
  u8[headerOffset + 20] = targetMAC.c;
  u8[headerOffset + 21] = targetMAC.d;
  u8[headerOffset + 22] = targetMAC.e;
  u8[headerOffset + 23] = targetMAC.f;
  u8[headerOffset + 24] = targetIP.a;
  u8[headerOffset + 25] = targetIP.b;
  u8[headerOffset + 26] = targetIP.c;
  u8[headerOffset + 27] = targetIP.d;
};

exports.headerLength = 28;
