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

exports.getSrcPort = (u8, headerOffset) => ((u8[headerOffset] << 8) + u8[headerOffset + 1]) >>> 0;
exports.getDestPort = (u8, headerOffset) => ((u8[headerOffset + 2] << 8) + u8[headerOffset + 3]) >>> 0;
exports.getDataLength = (u8, headerOffset) => ((u8[headerOffset + 4] << 8) + u8[headerOffset + 5]) >>> 0;

exports.headerLength = 8;

exports.write = (u8, headerOffset, srcPort, destPort, dataLength) => {
  u8view.setUint16BE(u8, headerOffset, srcPort);
  u8view.setUint16BE(u8, headerOffset + 2, destPort);
  u8view.setUint16BE(u8, headerOffset + 4, dataLength);
  u8view.setUint16BE(u8, headerOffset + 6, 0);
};

exports.writeChecksum = (u8, headerOffset, checksum) => u8view.setUint16BE(u8, headerOffset + 6, checksum);
