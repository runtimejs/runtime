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

exports.getSrcPort = (u8, headerOffset) => u8view.getUint16BE(u8, headerOffset);
exports.getDestPort = (u8, headerOffset) => u8view.getUint16BE(u8, headerOffset + 2);
exports.getSeqNumber = (u8, headerOffset) => u8view.getUint32BE(u8, headerOffset + 4) >>> 0;
exports.getAckNumber = (u8, headerOffset) => u8view.getUint32BE(u8, headerOffset + 8);
exports.getDataOffset = (u8, headerOffset) => (u8[headerOffset + 12] >>> 4) * 4;
exports.getFlags = (u8, headerOffset) => u8[headerOffset + 13];
exports.getWindowSize = (u8, headerOffset) => u8view.getUint16BE(u8, headerOffset + 14);

exports.headerLength = 20;

exports.FLAG_FIN = 1 << 0; // Finish
exports.FLAG_SYN = 1 << 1; // Sync
exports.FLAG_RST = 1 << 2; // Reset
exports.FLAG_PSH = 1 << 3; // Push
exports.FLAG_ACK = 1 << 4; // Ack
exports.FLAG_URG = 1 << 5; // Urgent

exports.write = (u8, headerOffset, srcPort, destPort, seqNumber, ackNumber, flags, windowSize) => {
  const dataOffsetWords = 5;
  u8view.setUint16BE(u8, headerOffset, srcPort);
  u8view.setUint16BE(u8, headerOffset + 2, destPort);
  u8view.setUint32BE(u8, headerOffset + 4, seqNumber);
  u8view.setUint32BE(u8, headerOffset + 8, ackNumber);
  u8[headerOffset + 12] = dataOffsetWords << 4;
  u8[headerOffset + 13] = flags;
  u8view.setUint16BE(u8, headerOffset + 14, windowSize);
  u8view.setUint16BE(u8, headerOffset + 16, 0); // checksum
  u8view.setUint16BE(u8, headerOffset + 18, 0); // urgent ptr
};

exports.writeChecksum = (u8, headerOffset, checksum) => u8view.setUint16BE(u8, headerOffset + 16, checksum);
