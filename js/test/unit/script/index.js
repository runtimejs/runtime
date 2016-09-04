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

test('division by zero', t => {
  const v = 10;
  t.is(v / 0, Infinity, 'should not trigger CPU Divide Error exception');
});

test('basic math functions (may use embedded libc)', t => {
  t.is(Math.abs(-45.4), 45.4, 'Math.abs');
  t.is(Math.acos(-0.2).toFixed(2), '1.77', 'Math.acos');
  t.is((Math.atan2(1, 0) * 2).toFixed(2), '3.14', 'Math.atan2');
  t.is((Math.atan(1, 0) * 4).toFixed(2), '3.14', 'Math.atan');
  t.is(Math.pow(2, 10), 1024, 'Math.pow');
  t.is(Math.sqrt(81), 9, 'Math.sqrt');
  t.is(Math.exp(1).toFixed(2), '2.72', 'Math.exp');
});

test('Math.random', t => {
  t.is(typeof Math.random(), 'number', 'Math.random');
});

test('Date object', t => {
  t.is(typeof new Date(), 'object', 'can create Date() object');
});
