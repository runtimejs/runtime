// Copyright 2015 runtime.js project authors
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
var u8view = require('u8-view');

exports.headerLength = 8;

exports.getType = function(u8, headerOffset) {
  return u8[headerOffset];
};

exports.getCode = function(u8, headerOffset) {
  return u8[headerOffset + 1];
};

exports.getEchoRequestIdentifier = function(u8, headerOffset) {
  return u8view.getUint16BE(u8, headerOffset + 4);
};

exports.getEchoRequestSequence = function(u8, headerOffset) {
  return u8view.getUint16BE(u8, headerOffset + 6);
};

exports.write = function(u8, headerOffset, type, code, headerValue) {
  u8[headerOffset] = type;
  u8[headerOffset + 1] = code;
  u8view.setUint32BE(u8, headerOffset + 4, headerValue);
};

exports.writeChecksum = function(u8, headerOffset, checksum) {
  u8view.setUint16BE(u8, headerOffset + 2, checksum);
};

exports.headerValueEcho = function(id, seq) {
  return (((id & 0xffff) << 16) | (seq & 0xffff)) >>> 0;
};
