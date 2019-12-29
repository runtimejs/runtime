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

const createSuite = require('estap');
const test = createSuite();
const random = require('/js/core/random');
const EntropySource = require('/js/core/random/entropy-source');

test.cb('EntropySource', t => {
  const source = new EntropySource('test-source');
  source.ongetbytes = (u8, cb) => {
    for (let i = 0; i < u8.length; ++i) {
      u8[i] = 0x33 + i;
    }
    cb();
  };

  const u8 = new Uint8Array(3);
  source.getBytes(u8, () => {
    t.is(u8[0], 0x33);
    t.is(u8[1], 0x34);
    t.is(u8[2], 0x35);
    t.end();
  });
});

test.cb('getTrueRandomValues buffer', t => {
  const u8 = new Uint8Array([0, 0, 0]);
  random.getTrueRandomValues(u8, (u8out) => {
    t.is(u8, u8out);
    t.end();
  });
});

test.cb('getTrueRandomValues length', t => {
  random.getTrueRandomValues(4, (u8) => {
    t.true(u8 instanceof Uint8Array);
    t.is(u8.length, 4);
    t.end();
  });
});

test('getRandomValues buffer', t => {
  const u8 = new Uint8Array([0, 0, 0]);
  const u8out = random.getRandomValues(u8);
  t.is(u8, u8out);
});

test('getRandomValues length', t => {
  const u8 = random.getRandomValues(10);
  t.true(u8 instanceof Uint8Array);
  t.is(u8.length, 10);
});
