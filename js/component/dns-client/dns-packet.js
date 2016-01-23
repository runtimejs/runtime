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
var assert = require('assert');
var isDomain = require('./is-domain');
var PacketReader = require('./packet-reader');
var randomId = 0x3322;

var queries = {
  'A': 0x01,
  'NS': 0x02,
  'CNAME': 0x05,
  'PTR': 0x0C,
  'MX': 0x0F,
  'SRV': 0x21,
  'SOA': 0x06,
  'TXT': 0x0A
}

exports.getQuery = function(domain, query) {
  // query isn't used (for now)
  assert(isDomain(domain));

  var bufferLength = 17;
  var i, j, label;

  var labels = domain.split('.');
  for (i = 0; i < labels.length; ++i) {
    label = labels[i];
    bufferLength += label.length + 1;
  }

  var u8 = new Uint8Array(bufferLength);
  var view = new DataView(u8.buffer);

  var requestFlags = 0x0100; // query, standard, not truncated, recursive

  view.setUint16(0, randomId, false);
  view.setUint16(2, requestFlags, false);
  view.setUint16(4, 1, false); // 1 question
  view.setUint16(6, 0, false); // 0 answers
  view.setUint16(8, 0, false); // 0 ns records
  view.setUint16(10, 0, false); // 0 additional records

  var offset = 12;

  for (i = 0; i < labels.length; ++i) {
    label = labels[i];
    view.setUint8(offset++, label.length);
    for (j = 0; j < label.length; ++j) {
      view.setUint8(offset++, label.charCodeAt(j));
    }
  }
  view.setUint8(offset++, 0); // null terminator

  view.setUint16(offset + 0, queries[query], false); // Type A query (host address)
  view.setUint16(offset + 2, 1, false); // Query IN (Internet address)
  return u8;
};

var POINTER_VALUE = 0xc0;
function isPointer(value) {
  return (value & POINTER_VALUE) === POINTER_VALUE;
}

function readHostname(reader) {
  var labels = [];

  for (var z = reader.getOffset(); z < reader.len; ++z) {
    var len = reader.readUint8();
    if (0 === len) {
      break;
    }

    if (isPointer(len)) {
      var ptrOffset = ((len - POINTER_VALUE) << 8) + reader.readUint8();
      var pos = reader.getOffset();
      reader.setOffset(ptrOffset);
      labels = labels.concat(readHostname(reader));
      reader.setOffset(pos);
      break;
    } else {
      var label = '';
      for (var i = 0; i < len; ++i) {
        label += String.fromCharCode(reader.readUint8());
      }

      labels.push(label);
    }
  }

  return labels;
}

exports.parseResponse = function(u8) {
  var reader = new PacketReader(u8.buffer, u8.byteLength, u8.byteOffset);
  var responseRandomId = reader.readUint16();

  if (responseRandomId !== randomId) {
    return null;
  }

  var flags = reader.readUint16();
  var questionsCount = reader.readUint16();
  var answersCount = reader.readUint16();
  var nsRecordsCount = reader.readUint16();
  var additionalCount = reader.readUint16();

  if (1 !== questionsCount) {
    return null;
  }

  // Read question
  var hostname = readHostname(reader).join('.');
  reader.readUint16(); // skip type
  reader.readUint16(); // skip class

  var results = [];

  // Read answers
  for (var z = 0; z < answersCount; ++z) {
    var host = readHostname(reader).join('.');

    var recordType = reader.readUint16();
    var recordClass = reader.readUint16();
    var ttl = reader.readUint32();
    var rdLen = reader.readUint16();

    var bytes = [];

    switch (recordType) {
    case queries.A: // A record
      if (4 !== rdLen) {
        return null;
      }

      results.push({hostname: host, record: 'A', address: [reader.readUint8(), reader.readUint8(),
        reader.readUint8(), reader.readUint8()], ttl: ttl });
      break;
    case queries.CNAME: // CNAME record
      results.push({hostname: host, record: 'CNAME', name: readHostname(reader).join('.')});
      break;
    case queries.MX:
      console.log(reader.readUint8());
      break;
    default:
      for (var b = 0; b < rdLen; ++b) {
        reader.readUint8();
      }
      break;
    }
  }

  return {
    hostname: hostname,
    results: results
  };
};
