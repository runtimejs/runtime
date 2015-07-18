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
var test = require('tape');

/* global isolate */
/* global TextEncoder */
/* global TextDecoder */

test('isolate.eval valid code', function(t) {
  global.a = 10;
  isolate.eval('a++');
  t.equal(global.a, 11);
  t.end();
});

test('isolate.eval invalid code', function(t) {
  t.plan(1);

  try {
    isolate.eval('not a js');
  } catch (e) {
    t.ok(e instanceof SyntaxError, 'throws on syntax error');
  }
});

test('isolate.eval throws', function(t) {
  t.plan(2);

  try {
    isolate.eval('throw new Error("some error")');
  } catch (e) {
    t.ok(e instanceof Error, 'caught error thrown from the script');
    t.ok(e.message.indexOf('some error') >= 0, 'error object is valid');
  }
});

test('TextEncoder and TextDecoder', function(t) {
  var encoder = new TextEncoder('utf-8');
  var decoder = new TextDecoder('utf-8');
  var u8 = encoder.encode('test string');
  t.ok(u8 instanceof Uint8Array);
  t.equal(decoder.decode(u8), 'test string');
  t.end();
});

test('TextEncoder and TextDecoder call as a function', function(t) {
  t.throws(function() {
    TextEncoder('utf-8');
  });

  t.throws(function() {
    TextDecoder('utf-8');
  });

  t.end();
});
