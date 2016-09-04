// Copyright 2014-present runtime.js project authors
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
const resources = require('/js/core/resources');

test('__SYSCALL.bufferAddress buffer crosses page boundary', t => {
  // allocate on the page boundary
  const buf = resources.memoryRange.block(0x3200000 - 12, 24).buffer();
  const u8 = new Uint8Array(buf);
  for (let i = 0; i < u8.length; i++) {
    u8[i] = i;
  }

  const addr = __SYSCALL.bufferAddress(u8);
  const b1 = u8.subarray(0, addr[0]);
  const b2 = u8.subarray(addr[0]);
  t.is(b1.length, 12, 'first part length');
  t.is(b1[0], 0, 'first part first byte');
  t.is(b2.length, 12, 'second part length');
  t.is(b2[0], 12, 'second part first byte');
});

test('__SYSCALL.bufferAddress buffer does not cross page boundary', t => {
  const buf = resources.memoryRange.block(0x3200000, 24).buffer();
  const u8 = new Uint8Array(buf);
  for (let i = 0; i < u8.length; i++) {
    u8[i] = i;
  }

  const addr = __SYSCALL.bufferAddress(u8);
  const b1 = u8.subarray(0, addr[0]);
  t.is(b1.length, u8.length, 'buffer length');
  t.is(addr[3], 0, 'buffer first byte');
});
