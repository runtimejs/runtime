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

/* global TextEncoder */
/* global TextDecoder */

test('__SYSCALL.eval valid code', (t) => {
  global.a = 10;
  __SYSCALL.eval('a++');
  t.equal(global.a, 11);
  t.end();
});

test('__SYSCALL.eval invalid code', (t) => {
  t.plan(1);

  try {
    __SYSCALL.eval('not a js');
  } catch (e) {
    t.ok(e instanceof SyntaxError, 'throws on syntax error');
  }
});

test('__SYSCALL.eval throws', (t) => {
  t.plan(2);

  try {
    __SYSCALL.eval('throw new Error("some error")');
  } catch (e) {
    t.ok(e instanceof Error, 'caught error thrown from the script');
    t.ok(e.message.indexOf('some error') >= 0, 'error object is valid');
  }
});

test('TextEncoder and TextDecoder', (t) => {
  const encoder = new TextEncoder('utf-8');
  const decoder = new TextDecoder('utf-8');
  const u8 = encoder.encode('test string');
  t.ok(u8 instanceof Uint8Array);
  t.equal(decoder.decode(u8), 'test string');
  t.end();
});

test('TextEncoder and TextDecoder call as a function', (t) => {
  t.throws(() => TextEncoder('utf-8')); // eslint-disable-line new-cap
  t.throws(() => TextDecoder('utf-8')); // eslint-disable-line new-cap
  t.end();
});
