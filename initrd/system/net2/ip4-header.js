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

var IP4Address = require('./ip4-address');

exports.getSrcIP = function(u8, headerOffset) {
  return new IP4Address(u8[headerOffset + 12],
                        u8[headerOffset + 13],
                        u8[headerOffset + 14],
                        u8[headerOffset + 15]);
};

exports.getDestIP = function(u8, headerOffset) {
  return new IP4Address(u8[headerOffset + 16],
                        u8[headerOffset + 17],
                        u8[headerOffset + 18],
                        u8[headerOffset + 19]);
};

exports.getProtocolId = function(u8, headerOffset) {
  return u8[headerOffset + 9];
};

exports.getHeaderLength = function(u8, headerOffset) {
  return (u8[headerOffset] & 0xf) << 2;
};
