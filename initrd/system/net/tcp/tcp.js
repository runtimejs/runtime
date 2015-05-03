// Copyright 2014 Runtime.JS project authors
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

var headerLength = 20;

var flags = {
  FIN: 1 << 0, // Finish
  SYN: 1 << 1, // Sync
  RST: 1 << 2, // Reset
  PSH: 1 << 3, // Push
  ACK: 1 << 4, // Ack
  URG: 1 << 5, // Urgent
};

function writeHeader(view, offset, opts) {
  var len = view.byteLength - offset;
  view.setUint16(offset + 0, opts.srcPort, false);
  view.setUint16(offset + 2, opts.destPort, false);
  view.setUint32(offset + 4, opts.seqNumber, false);
  view.setUint32(offset + 8, opts.ackNumber, false);
  var dataOffsetWords = 5;
  view.setUint8(offset + 12, dataOffsetWords << 4);
  view.setUint8(offset + 13, opts.flags);
  view.setUint16(offset + 14, opts.windowSize, false);
  view.setUint16(offset + 16, 0, false); // checksum
  view.setUint16(offset + 18, 0, false); // urgent ptr
}

function writeHeaderChecksum(view, headerOffset, value) {
  view.setUint16(headerOffset + 16, value & 0xffff, false);
}

function parse(reader) {
  var srcPort = reader.readUint16();
  var destPort = reader.readUint16();
  var seqNumber = reader.readUint32();
  var ackNumber = reader.readUint32();
  reader.readUint8();
  var flags = reader.readUint8();
  var windowSize = reader.readUint16();
  var csum = reader.readUint16();
  var urgentPtr = reader.readUint16();

  return {
    srcPort: srcPort,
    destPort: destPort,
    seqNumber: seqNumber,
    ackNumber: ackNumber,
    flags: flags,
    windowSize: windowSize,
  };
}

module.exports = {
  writeHeader: writeHeader,
  writeHeaderChecksum: writeHeaderChecksum,
  headerLength: headerLength,
  parse: parse,
  flags: flags,
  SEQ_INC: function(seq, value) { return (seq + (value >>> 0)) >>> 0; },
  SEQ_LT: function(a, b) { return ((a - b) | 0) <  0; },
  SEQ_LTE: function(a, b) { return ((a - b) | 0) <= 0; },
  SEQ_GT: function(a, b) { return ((a - b) | 0) >  0; },
  SEQ_GTE: function(a, b) { return ((a - b) | 0) >= 0; }
};
