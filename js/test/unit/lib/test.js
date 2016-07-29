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
const BufferBuilder = require('./buffer-builder');

test('build simple buffer', (t) => {
  const b = new BufferBuilder()
    .uint8(5)
    .uint8(10)
    .uint32(0xCCAAFFEE)
    .uint8(15)
    .uint16(0xAABB)
    .buffer();

  const ab = new Uint8Array([5, 10, 0xCC, 0xAA, 0xFF, 0xEE, 15, 0xAA, 0xBB]);
  t.deepEqual(b, ab);
  t.end();
});

test('empty buffer', (t) => {
  const b = new BufferBuilder().buffer();

  const ab = new Uint8Array(0);
  t.deepEqual(b, ab);
  t.end();
});

test('repeat uint8', (t) => {
  const b = new BufferBuilder()
    .uint8(5)
    .uint8(10)
    .repeat(4)
    .uint8(15)
    .buffer();

  const ab = new Uint8Array([5, 10, 10, 10, 10, 10, 15]);
  t.deepEqual(b, ab);
  t.end();
});

test('repeat uint16', (t) => {
  const b = new BufferBuilder()
    .uint8(5)
    .uint16(0xFFAA)
    .repeat(2)
    .uint8(15)
    .buffer();

  const ab = new Uint8Array([5, 0xFF, 0xAA, 0xFF, 0xAA, 0xFF, 0xAA, 15]);
  t.deepEqual(b, ab);
  t.end();
});

test('repeat uint32', (t) => {
  const b = new BufferBuilder()
    .uint8(5)
    .uint32(0xAABBCCDD)
    .repeat(1)
    .uint8(15)
    .buffer();

  const ab = new Uint8Array([5, 0xAA, 0xBB, 0xCC, 0xDD, 0xAA, 0xBB, 0xCC, 0xDD, 15]);
  t.deepEqual(b, ab);
  t.end();
});

test('align', (t) => {
  const b = new BufferBuilder()
    .uint8(5)
    .uint8(6)
    .uint8(7)
    .align(8)
    .uint8(1)
    .uint16(2)
    .align(4, 8)
    .buffer();

  const ab = new Uint8Array([5, 6, 7, 0, 0, 0, 0, 0, 1, 0, 2, 8]);
  t.deepEqual(b, ab);
  t.end();
});
