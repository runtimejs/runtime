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

/* global TextEncoder */
/* global TextDecoder */

test('__SYSCALL.eval valid code', t => {
  global.a = 10;
  __SYSCALL.eval('a++');
  t.is(global.a, 11, 'eval works');
});

test('__SYSCALL.eval invalid code', t => {
  t.plan(1);

  try {
    __SYSCALL.eval('not a js');
  } catch (e) {
    t.is(e instanceof SyntaxError, true, 'throws on syntax error');
  }
});

test('__SYSCALL.eval throws', t => {
  t.plan(2);

  try {
    __SYSCALL.eval('throw new Error("some error")');
  } catch (e) {
    t.is(e instanceof Error, true, 'caught error thrown from the script');
    t.true(e.message.indexOf('some error') >= 0, 'error object is valid');
  }
});

test('TextEncoder and TextDecoder', t => {
  const encoder = new TextEncoder('utf-8');
  const decoder = new TextDecoder('utf-8');
  const u8 = encoder.encode('test string');
  t.true(u8 instanceof Uint8Array, 'encoded result is u8 array');
  t.is(decoder.decode(u8), 'test string', 'decoded result is a string');
});

test('TextEncoder and TextDecoder call as a function', t => {
  t.throws(() => TextEncoder('utf-8'), // eslint-disable-line new-cap
    [Error, 'constructor cannot be called as a function'],
    'TextEncoder() throws');
  t.throws(() => TextDecoder('utf-8'), // eslint-disable-line new-cap
    [Error, 'constructor cannot be called as a function'],
    'TextDecoder() throws');
});

test('module globals', t => {
  t.true(typeof require.resolve === 'function', 'require.resolve exists');
  t.is(require.resolve('../index'), '/js/test/unit/index.js', 'require.resolve can resolve path');
  t.is(__filename, '/js/test/unit/platform/index.js', '__filename global');
  t.is(__dirname, '/js/test/unit/platform', '__dirname global');
  t.truthy(module, 'module global');
});
