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
const { IP4Address } = require('../../core').net;

const OPERATION_REQUEST = 1;
const OPERATION_RESPONSE = 2;

const OPTIONS_OFFSET = 28 + 16 + 192;
const magicCookie = 0x63825363;

exports.packetType = {
  DISCOVER: 1,
  OFFER: 2,
  REQUEST: 3,
  DECLINE: 4,
  ACK: 5,
  NAK: 6,
  RELEASE: 7,
  INFORM: 8,
};

exports.create = (type, srcMAC, options = []) => {
  let optionsLength = 8; // cookie (4b), type (3b) and 0xff (1b)
  for (const opt of options) {
    optionsLength += opt.bytes.length + 2;
  } // id (1b) and len (1b)

  const u8 = new Uint8Array(OPTIONS_OFFSET + optionsLength);
  u8[0] = OPERATION_REQUEST; // request
  u8[1] = 1; // over ethernet
  u8[2] = 6; // hw address 6 bytes
  u8[3] = 0;
  u8view.setUint32BE(u8, 4, 0x112233); // random id
  u8view.setUint16BE(u8, 8, 0); // secs
  u8view.setUint16BE(u8, 10, 0); // flags
  u8view.setUint32BE(u8, 12, 0); // client ip
  u8view.setUint32BE(u8, 16, 0); // your ip
  u8view.setUint32BE(u8, 20, 0); // server ip
  u8view.setUint32BE(u8, 24, 0); // gateway ip
  u8[28] = srcMAC.a;
  u8[29] = srcMAC.b;
  u8[30] = srcMAC.c;
  u8[31] = srcMAC.d;
  u8[32] = srcMAC.e;
  u8[33] = srcMAC.f;
  u8view.setUint32BE(u8, OPTIONS_OFFSET, magicCookie);

  let optionsOffset = OPTIONS_OFFSET + 4;

  // Option: DHCP Message
  u8[optionsOffset++] = 53; // id
  u8[optionsOffset++] = 1; // len
  u8[optionsOffset++] = type;

  // Other options
  for (const option of options) {
    u8[optionsOffset++] = option.id; // id
    u8[optionsOffset++] = option.bytes.length & 0xff; // len
    for (const byte of option.bytes) {
      u8[optionsOffset++] = byte >>> 0;
    }
  }

  u8[optionsOffset] = 255; // end of option list
  return u8;
};

exports.getOperation = u8 => u8[0];
exports.getRequestId = u8 => u8view.getUint32BE(u8, 4);
exports.getYourIP = u8 => new IP4Address(u8[16], u8[17], u8[18], u8[19]);
exports.getServerIP = u8 => new IP4Address(u8[20], u8[21], u8[22], u8[23]);
exports.isValidMagicCookie = u8 => magicCookie === u8view.getUint32BE(u8, OPTIONS_OFFSET);

exports.getOptions = (u8) => {
  const options = [];
  for (let i = OPTIONS_OFFSET + 4; i < u8.length; ++i) {
    const optId = u8[i++];
    const optLen = u8[i++];

    if (optId === 0xff) {
      break;
    }
    if (optId === 0x00) {
      continue;
    }

    const bytes = [];
    for (let j = 0; j < optLen; ++j) {
      bytes.push(u8[i++]);
    }

    options.push({
      id: optId,
      bytes,
    });

    --i;
  }

  return options;
};

exports.OPERATION_REQUEST = OPERATION_REQUEST;
exports.OPERATION_RESPONSE = OPERATION_RESPONSE;
