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
var runtime = require('../../../core');
var EntropySource = require('../../../core/random/entropy-source');

test('EntropySource', function(t) {
  t.timeoutAfter(1000);

  var source = new EntropySource('test-source');
  source.ongetbytes = function(u8, cb) {
    for (var i = 0; i < u8.length; ++i) {
      u8[i] = 0x33 + i;
    }
    cb();
  };

  var u8 = new Uint8Array(3);
  source.getBytes(u8, function() {
    t.equal(u8[0], 0x33);
    t.equal(u8[1], 0x34);
    t.equal(u8[2], 0x35);
    t.end();
  });
});

test('getTrueRandomValues buffer', function(t) {
  t.timeoutAfter(1000);
  var u8 = new Uint8Array([0, 0, 0]);
  runtime.random.getTrueRandomValues(u8, function(u8out) {
    t.equal(u8, u8out);
    t.end();
  });
});

test('getTrueRandomValues length', function(t) {
  t.timeoutAfter(1000);
  runtime.random.getTrueRandomValues(4, function(u8) {
    t.ok(u8 instanceof Uint8Array);
    t.equal(u8.length, 4);
    t.end();
  });
});

test('getRandomValues buffer', function(t) {
  var u8 = new Uint8Array([0, 0, 0]);
  var u8out = runtime.random.getRandomValues(u8);
  t.equal(u8, u8out);
  t.end();
});

test('getRandomValues length', function(t) {
  var u8 = runtime.random.getRandomValues(10);
  t.ok(u8 instanceof Uint8Array);
  t.equal(u8.length, 10);
  t.end();
});
