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

function checksum(u8, offset, len, extraSum) {
  const count = len >>> 1;
  let acc = (extraSum >>> 0);
  for (let i = 0; i < count; ++i) {
    acc += (u8[offset + (i * 2)] << 8) + u8[(offset + (i * 2)) + 1];
  }

  if (count * 2 !== len) {
    acc += u8[offset + (count * 2)] << 8;
  }

  acc = (acc & 0xffff) + (acc >>> 16);
  acc += (acc >>> 16);
  return ((~acc) & 0xffff) >>> 0;
}

module.exports = checksum;

module.exports.buffer = (u8, offset, len) => {
  const count = len >>> 1;
  let acc = 0;
  for (let i = 0; i < count; ++i) {
    acc += (u8[offset + (i * 2)] << 8) + u8[(offset + (i * 2)) + 1];
  }

  if (count * 2 !== len) {
    acc += u8[offset + (count * 2)] << 8;
  }

  return acc;
};

module.exports.result = (accOpt) => {
  let acc = (accOpt & 0xffff) + (accOpt >>> 16);
  acc += (acc >>> 16);
  return ((~acc) & 0xffff) >>> 0;
};
