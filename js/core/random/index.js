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
var isaac = require('./isaac-wrapper');
var EntropySource = require('./entropy-source');
var sources = require('./sources');
var typeutils = require('typeutils');
var getDefaultSource = sources.getDefaultSource;
require('./js-random-source');

exports.EntropySource = EntropySource;
exports.addEntropySource = sources.addEntropySource;

/**
 * Request random bytes from the best available entropy source. This
 * function is asynchronous bacause it might take some time to gather
 * enough entropy from the source. This is similar to /dev/random
 * in Unix.
 *
 * @param {number|Uint8Array} value Number of bytes to request or buffer to fill
 * @param {function} cb Callback with the resulting Uint8Array buffer argument
 */
exports.getRandomValues = function(value, cb) {
  var u8 = null;
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

  if (!typeutils.isFunction(cb)) {
    throw new Error('getRandomValues: argument 1 is not a function');
  }

  var defaultSource = getDefaultSource();
  if (!defaultSource) {
    throw new Error('getRandomValues: no entropy source available');
  }

  defaultSource.getBytes(u8, function() {
    isaac.seed(u8);
    cb(u8);
  });
};

/**
 * Request random bytes from the immediately available entropy source. This
 * function is synchronous, but the output may contain less entropy than
 * getRandomValues() output. This is similar to Unix's /dev/urandom.
 *
 * @param {number|Uint8Array} value Number of bytes to request or buffer to fill
 * @return {Uint8Array} Buffer filled with random data
 */
exports.getPseudoRandomValues = function(value) {
  var u8 = null;
  if (typeutils.isNumber(value)) {
    u8 = new Uint8Array(value);
  }

  if (value instanceof Uint8Array) {
    u8 = value;
  }

  if (!u8) {
    throw new Error('getPseudoRandomValues: argument 0 is not a number or Uint8Array');
  }

  if (u8.length === 0) {
    throw new Error('getPseudoRandomValues: buffer length must be greater than 0');
  }

  for (var i = 0; i < u8.length; i++) {
    u8[i] = isaac.getByte();
  }

  return u8;
};
