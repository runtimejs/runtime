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
const VRing = require('/js/driver/virtio/vring');

function clearBuffer(u8) {
  for (let i = 0; i < u8.length; ++i) {
    u8[i] = 0;
  }
}

function bufferWriteNumbers(u8, value) {
  for (let i = 0; i < u8.length; ++i) {
    u8[i] = i + value;
  }
  return u8;
}

function getOnePageBuffer(indexOpt) {
  const index = indexOpt | 0;
  const b = new Uint8Array(resources.memoryRange.block(0x2000000 + (index * 22), 22).buffer());
  clearBuffer(b);
  return b;
}

function getTwoPageBuffer() {
  const b = new Uint8Array(resources.memoryRange.block(0x2000000 - 12, 22).buffer());
  clearBuffer(b);
  return b;
}

test('ring place one physical page buffer', t => {
  const mem = __SYSCALL.allocDMA();
  const ring = new VRing(mem, 0, 16);
  t.is(ring.descriptorTable.descriptorsAvailable, 16);
  t.is(ring.availableRing.readIdx(), 0);
  ring.placeBuffers([getOnePageBuffer()], true);
  t.is(ring.descriptorTable.descriptorsAvailable, 15);
  t.is(ring.availableRing.readIdx(), 1);
  const descId = ring.availableRing.readDescriptorAsDevice(0);
  t.is(descId, 0);
  const firstDesc = ring.descriptorTable.get(descId);
  const u8devWrite = ring.descriptorTable.getDescriptorBuffer(descId);
  bufferWriteNumbers(u8devWrite, 4);
  t.is(firstDesc.flags, 2 /* no next flag, write only flag */);
  t.is(firstDesc.len, 22);
  t.is(firstDesc.next, 1);
  t.is(ring.usedRing.readIdx(), 0);
  ring.usedRing.placeDescriptorAsDevice(descId, 5 /* bytes written */);
  t.is(ring.usedRing.readIdx(), 1);
  const u8 = ring.getBuffer();
  t.is(ring.descriptorTable.descriptorsAvailable, 16);
  t.true(u8 instanceof Uint8Array);
  t.is(u8.length, 5);
  t.is(u8[0], 4);
  t.is(u8[1], 5);
  t.is(u8[2], 6);
  t.is(u8[3], 7);
  t.is(u8[4], 8);
});

test('ring place two physical page buffer', t => {
  const mem = __SYSCALL.allocDMA();
  const ring = new VRing(mem, 0, 16);
  t.is(ring.descriptorTable.descriptorsAvailable, 16);
  t.is(ring.availableRing.readIdx(), 0);
  ring.placeBuffers([getTwoPageBuffer()], false);
  t.is(ring.descriptorTable.descriptorsAvailable, 14);
  t.is(ring.availableRing.readIdx(), 1);
  const descId = ring.availableRing.readDescriptorAsDevice(0);
  t.is(descId, 0);
  const firstDesc = ring.descriptorTable.get(descId);
  const u8devWrite = ring.descriptorTable.getDescriptorBuffer(descId);
  bufferWriteNumbers(u8devWrite, 4);
  t.is(firstDesc.flags, 1 /* next flag */);
  t.is(firstDesc.len, 12);
  t.is(firstDesc.next, 1);
  const nextDescId = firstDesc.next;
  const secondDesc = ring.descriptorTable.get(nextDescId);
  const u8devWrite2 = ring.descriptorTable.getDescriptorBuffer(nextDescId);
  bufferWriteNumbers(u8devWrite2, 0);
  t.is(secondDesc.flags, 0 /* no next flag */);
  t.is(secondDesc.len, 10);
  t.is(secondDesc.next, 2);
  t.is(ring.usedRing.readIdx(), 0);
  ring.usedRing.placeDescriptorAsDevice(descId, 15 /* bytes written */);
  t.is(ring.usedRing.readIdx(), 1);
  const u8 = ring.getBuffer();
  t.is(ring.descriptorTable.descriptorsAvailable, 16);
  t.true(u8 instanceof Uint8Array);
  t.is(u8.length, 15);
  t.is(u8[0], 4);
  t.is(u8[11], 15);
  t.is(u8[12], 0); // second subarray data
  t.is(u8[13], 1);
  t.is(u8[14], 2);
});

test('ring fill all slots and process', t => {
  const mem = __SYSCALL.allocDMA();
  const ring = new VRing(mem, 0, 4 /* slots */);
  let i;
  let descId;
  t.true(ring.placeBuffers([bufferWriteNumbers(getOnePageBuffer(0), 1)], true));
  t.true(ring.placeBuffers([bufferWriteNumbers(getOnePageBuffer(1), 2)], true));
  t.true(ring.placeBuffers([bufferWriteNumbers(getOnePageBuffer(2), 3)], true));
  t.true(ring.placeBuffers([bufferWriteNumbers(getOnePageBuffer(3), 4)], true));
  t.is(ring.placeBuffers([getOnePageBuffer(4)], true), false);

  const currentIdx = ring.availableRing.readIdx();
  t.is(currentIdx, 4);
  for (i = 0; i < 3; ++i) {
    descId = ring.availableRing.readDescriptorAsDevice(i);
    ring.usedRing.placeDescriptorAsDevice(descId, 5 /* bytes written */);
  }

  t.is(ring.getBuffer()[0], 1);
  t.is(ring.getBuffer()[0], 2);
  t.is(ring.getBuffer()[0], 3);
  t.is(ring.getBuffer(), null);
  t.is(ring.getBuffer(), null);

  descId = ring.availableRing.readDescriptorAsDevice(3);
  ring.usedRing.placeDescriptorAsDevice(descId, 5 /* bytes written */);
  t.is(ring.getBuffer()[0], 4);
  t.is(ring.getBuffer(), null);
});

test('vring operation', t => {
  const mem = __SYSCALL.allocDMA();
  const ring = new VRing(mem, 0, 4);
  let devIndex = 0;
  let count = 0;

  function devProcessAll() {
    const bytesWritten = 3;
    let descId = 0;
    t.false(ring.usedRing.hasUnprocessedBuffers(), 'no unprocessed buffers for the driver');
    while (devIndex < ring.availableRing.readIdx()) {
      descId = ring.availableRing.readDescriptorAsDevice(devIndex);
      ring.usedRing.placeDescriptorAsDevice(descId, bytesWritten);
      t.true(ring.usedRing.hasUnprocessedBuffers(), 'new unprocessed buffers');
      --count;
      ++devIndex;
    }
  }

  function driverProcessAll() {
    ring.fetchBuffers(null);
    while (ring.descriptorTable.descriptorsAvailable) {
      if (!ring.placeBuffers([getOnePageBuffer(0)], true)) {
        break;
      }
      ++count;
    }
  }

  t.is(count, 0, 'no unhandled buffers');
  for (let i = 0; i < 4; ++i) {
    driverProcessAll();
    t.true(count > 0, 'unhandled buffers are ready');
    devProcessAll();
  }
  t.is(count, 0, 'no unhandled buffers');
});
