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

const test = require('tape');

test('div by zero should not trigger CPU Divide Error exception', (t) => {
  const v = 10;
  t.equal(v / 0, Infinity);
  t.end();
});

test('some math functions (in case they rely on embedded libc)', (t) => {
  t.equal(Math.abs(-45.4), 45.4);
  t.equal(Math.acos(-0.2).toFixed(2), '1.77');
  t.equal((Math.atan2(1, 0) * 2).toFixed(2), '3.14');
  t.equal((Math.atan(1, 0) * 4).toFixed(2), '3.14');
  t.equal(Math.pow(2, 10), 1024);
  t.equal(Math.sqrt(81), 9);
  t.equal(Math.exp(1).toFixed(2), '2.72');
  t.end();
});

test('Math.random', (t) => {
  t.equal(typeof Math.random(), 'number');
  t.end();
});

test('Date object', (t) => {
  t.equal(typeof new Date(), 'object');
  t.end();
});
