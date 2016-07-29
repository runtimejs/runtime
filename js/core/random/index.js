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
const isaac = require('./isaac-wrapper');
const EntropySource = require('./entropy-source');
const sources = require('./sources');
const typeutils = require('typeutils');
const getDefaultSource = sources.getDefaultSource;
require('./js-random-source');

exports.EntropySource = EntropySource;
exports.addEntropySource = sources.addEntropySource;

/**
 * Request random bytes from the best available entropy source. This
 * function is asynchronous bacause it might take some time to gather
 * enough entropy from the source. This might use /dev/random as a backend
 * in KVM and might be extremely slow depending on the buffer size and
 * the amount of available entropy.
 *
 * @param {number|Uint8Array} value Number of bytes to request or buffer to fill
 * @param {function} cb Callback with the resulting Uint8Array buffer argument
 */
exports.getTrueRandomValues = (value, cb) => {
  let u8 = null;
  if (typeutils.isNumber(value)) {
    u8 = new Uint8Array(value);
  }
  if (value instanceof Uint8Array) {
    u8 = value;
  }

  if (!u8) {
    throw new Error('getTrueRandomValues: argument 0 is not a number or Uint8Array');
  }
  if (u8.length === 0) {
    throw new Error('getTrueRandomValues: buffer length must be greater than 0');
  }

  if (!typeutils.isFunction(cb)) {
    throw new Error('getTrueRandomValues: argument 1 is not a function');
  } // eslint-disable-line max-len

  const defaultSource = getDefaultSource();
  if (!defaultSource) {
    throw new Error('getTrueRandomValues: no entropy source available');
  }

  defaultSource.getBytes(u8, () => {
    isaac.seed(u8);
    cb(u8);
  });
};

/**
 * Request random bytes from the CSPRNG seeded with enough entropy.
 *
 * @param {number|Uint8Array} value Number of bytes to request or buffer to fill
 * @return {Uint8Array} Buffer filled with random data
 */
exports.getRandomValues = (value) => {
  let u8 = null;
  if (typeutils.isNumber(value)) {
    u8 = new Uint8Array(value);
  }
  if (value instanceof Uint8Array) {
    u8 = value;
  }

  if (!u8) {
    throw new Error('getRandomValues: argument 0 is not a number or Uint8Array');
  }
  if (u8.length === 0) {
    throw new Error('getRandomValues: buffer length must be greater than 0');
  }

  for (let i = 0; i < u8.length; i++) {
    u8[i] = isaac.getByte();
  }

  return u8;
};
