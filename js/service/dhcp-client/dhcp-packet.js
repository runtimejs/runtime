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

var u8view = require('u8-view');
var IP4Address = runtime.net.IP4Address;

var OPERATION_REQUEST = 1;
var OPERATION_RESPONSE = 2;

var OPTIONS_OFFSET = 28 + 16 + 192;
var magicCookie = 0x63825363;

exports.packetType = {
  DISCOVER: 1,
  OFFER: 2,
  REQUEST: 3,
  DECLINE: 4,
  ACK: 5,
  NAK: 6,
  RELEASE: 7,
  INFORM: 8
};

exports.create = function(type, srcMAC, options) {
  var i, j;
  options = options || [];

  var optionsLength = 8; // cookie (4b), type (3b) and 0xff (1b)
  for (i = 0; i < options.length; ++i) {
    optionsLength += options[i].bytes.length + 2; // id (1b) and len (1b)
  }

  var u8 = new Uint8Array(OPTIONS_OFFSET + optionsLength);
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

  var optionsOffset = OPTIONS_OFFSET + 4;

  // Option: DHCP Message
  u8[optionsOffset++] = 53; // id
  u8[optionsOffset++] = 1;  // len
  u8[optionsOffset++] = type;

  // Other options
  for (i = 0; i < options.length; ++i) {
    var option = options[i];
    u8[optionsOffset++] = option.id; // id
    u8[optionsOffset++] = option.bytes.length & 0xff;  // len
    for (j = 0; j < option.bytes.length; ++j) {
      u8[optionsOffset++] = option.bytes[j] >>> 0;
    }
  }

  u8[optionsOffset] = 255; // end of option list
  return u8;
};

exports.getOperation = function(u8) {
  return u8[0];
};

exports.getRequestId = function(u8) {
  return u8view.getUint32BE(u8, 4);
};

exports.getYourIP = function(u8) {
  return new IP4Address(u8[16], u8[17], u8[18], u8[19]);
};

exports.getServerIP = function(u8) {
  return new IP4Address(u8[20], u8[21], u8[22], u8[23]);
};

exports.isValidMagicCookie = function(u8) {
  return magicCookie === u8view.getUint32BE(u8, OPTIONS_OFFSET);
};

exports.getOptions = function(u8) {
  var i, j;
  var options = [];
  for (i = OPTIONS_OFFSET + 4; i < u8.length; ++i) {
    var optId = u8[i++];
    var optLen = u8[i++];

    if (0xff === optId) {
      break;
    }

    if (0x00 === optId) {
      continue;
    }

    var bytes = [];
    for (j = 0; j < optLen; ++j) {
      bytes.push(u8[i++]);
    }

    options.push({
      id: optId,
      bytes: bytes
    });

    --i;
  }

  return options;
};

exports.OPERATION_REQUEST = OPERATION_REQUEST;
exports.OPERATION_RESPONSE = OPERATION_RESPONSE;
