// Copyright 2015-present runtime.js project authors
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

exports.getRandomUint32 = () => Math.floor(Math.random() * 0x100000000) >>> 0;
exports.getRandomUint16 = () => Math.floor(Math.random() * 0x10000) >>> 0;
exports.getRandomUint8 = () => Math.floor(Math.random() * 0x100) >>> 0;

/**
 * Get linearly increasing counter value in ms
 * (monotonic clock)
 */
exports.timeNow = () => Math.floor(performance.now());

exports.assert = (value, message) => {
  if (!value) {
    throw new Error(`AssertionError ${message ? (`: ${message}`) : ''}`);
  }
};
