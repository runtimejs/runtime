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
const assert = require('assert');
const isDomain = require('./is-domain');
const PacketReader = require('./packet-reader');
const randomId = 0x3322;

const queries = {
  A: 0x01,
  NS: 0x02,
  CNAME: 0x05,
  PTR: 0x0C,
  MX: 0x0F,
  SRV: 0x21,
  SOA: 0x06,
  TXT: 0x0A,
};

exports.getQuery = (domain, query) => {
  // query isn't used (for now)
  assert(isDomain(domain));

  let bufferLength = 17;

  const labels = domain.split('.');
  for (const label of labels) {
    bufferLength += label.length + 1;
  }

  const u8 = new Uint8Array(bufferLength);
  const view = new DataView(u8.buffer);

  const requestFlags = 0x0100; // query, standard, not truncated, recursive

  view.setUint16(0, randomId, false);
  view.setUint16(2, requestFlags, false);
  view.setUint16(4, 1, false); // 1 question
  view.setUint16(6, 0, false); // 0 answers
  view.setUint16(8, 0, false); // 0 ns records
  view.setUint16(10, 0, false); // 0 additional records

  let offset = 12;

  for (const label of labels) {
    view.setUint8(offset++, label.length);
    for (let j = 0; j < label.length; ++j) {
      view.setUint8(offset++, label.charCodeAt(j));
    }
  }
  view.setUint8(offset++, 0); // null terminator

  view.setUint16(offset + 0, queries[query], false); // Type A query (host address)
  view.setUint16(offset + 2, 1, false); // Query IN (Internet address)
  return u8;
};

const POINTER_VALUE = 0xc0;

function isPointer(value) {
  return (value & POINTER_VALUE) === POINTER_VALUE;
}

function readHostname(reader) {
  let labels = [];

  for (let z = reader.getOffset(); z < reader.len; ++z) {
    const len = reader.readUint8();
    if (len === 0) {
      break;
    }

    if (isPointer(len)) {
      const ptrOffset = ((len - POINTER_VALUE) << 8) + reader.readUint8();
      const pos = reader.getOffset();
      reader.setOffset(ptrOffset);
      labels = labels.concat(readHostname(reader));
      reader.setOffset(pos);
      break;
    } else {
      let label = '';
      for (let i = 0; i < len; ++i) {
        label += String.fromCharCode(reader.readUint8());
      }

      labels.push(label);
    }
  }

  return labels;
}

exports.parseResponse = (u8) => {
  const reader = new PacketReader(u8.buffer, u8.byteLength, u8.byteOffset);
  const responseRandomId = reader.readUint16();

  if (responseRandomId !== randomId) {
    return null;
  }

  /* eslint-disable no-unused-vars */
  const flags = reader.readUint16();
  const questionsCount = reader.readUint16();
  const answersCount = reader.readUint16();
  const nsRecordsCount = reader.readUint16();
  const additionalCount = reader.readUint16();
  /* eslint-enable no-unused-vars */

  if (questionsCount !== 1) {
    return null;
  }

  // Read question
  const hostname = readHostname(reader).join('.');
  reader.readUint16(); // skip type
  reader.readUint16(); // skip class

  const results = [];

  // Read answers
  for (let z = 0; z < answersCount; ++z) {
    const host = readHostname(reader).join('.');

    const recordType = reader.readUint16();
    const recordClass = reader.readUint16(); // eslint-disable-line no-unused-vars
    const ttl = reader.readUint32();
    const rdLen = reader.readUint16();

    // const bytes = [];

    switch (recordType) {
      case queries.A: // A record
        if (rdLen !== 4) {
          return null;
        }

        results.push({
          hostname: host,
          record: 'A',
          address: [
            reader.readUint8(),
            reader.readUint8(),
            reader.readUint8(),
            reader.readUint8(),
          ],
          ttl,
        });
        break;
      case queries.CNAME: // CNAME record
        results.push({
          hostname: host,
          record: 'CNAME',
          name: readHostname(reader).join('.'),
        });
        break;
      default:
        for (let b = 0; b < rdLen; ++b) {
          reader.readUint8();
        }
        break;
    }
  }

  return {
    hostname,
    results,
  };
};
