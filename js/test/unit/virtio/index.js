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
const test = require('tape');
const resources = require('../../../core/resources');
const mem = __SYSCALL.allocDMA();
const VRing = require('../../../driver/virtio/vring');
// const DescriptorTable = require('../../../driver/virtio/vring/descriptor-table');

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

test('ring place one physical page buffer', (t) => {
  const ring = new VRing(mem, 0, 16);
  t.equal(ring.descriptorTable.descriptorsAvailable, 16);
  t.equal(ring.availableRing.readIdx(), 0);
  ring.placeBuffers([getOnePageBuffer()], true);
  t.equal(ring.descriptorTable.descriptorsAvailable, 15);
  t.equal(ring.availableRing.readIdx(), 1);
  const descId = ring.availableRing.readDescriptorAsDevice(0);
  t.equal(descId, 0);
  const firstDesc = ring.descriptorTable.get(descId);
  const u8devWrite = ring.descriptorTable.getDescriptorBuffer(descId);
  bufferWriteNumbers(u8devWrite, 4);
  t.equal(firstDesc.flags, 2 /* no next flag, write only flag */);
  t.equal(firstDesc.len, 22);
  t.equal(firstDesc.next, 1);
  t.equal(ring.usedRing.readIdx(), 0);
  ring.usedRing.placeDescriptorAsDevice(descId, 5 /* bytes written */);
  t.equal(ring.usedRing.readIdx(), 1);
  const u8 = ring.getBuffer();
  t.equal(ring.descriptorTable.descriptorsAvailable, 16);
  t.ok(u8 instanceof Uint8Array);
  t.equal(u8.length, 5);
  t.equal(u8[0], 4);
  t.equal(u8[1], 5);
  t.equal(u8[2], 6);
  t.equal(u8[3], 7);
  t.equal(u8[4], 8);
  t.end();
});

test('ring place two physical page buffer', (t) => {
  const ring = new VRing(mem, 0, 16);
  t.equal(ring.descriptorTable.descriptorsAvailable, 16);
  t.equal(ring.availableRing.readIdx(), 0);
  ring.placeBuffers([getTwoPageBuffer()], false);
  t.equal(ring.descriptorTable.descriptorsAvailable, 14);
  t.equal(ring.availableRing.readIdx(), 1);
  const descId = ring.availableRing.readDescriptorAsDevice(0);
  t.equal(descId, 0);
  const firstDesc = ring.descriptorTable.get(descId);
  const u8devWrite = ring.descriptorTable.getDescriptorBuffer(descId);
  bufferWriteNumbers(u8devWrite, 4);
  t.equal(firstDesc.flags, 1 /* next flag */);
  t.equal(firstDesc.len, 12);
  t.equal(firstDesc.next, 1);
  const nextDescId = firstDesc.next;
  const secondDesc = ring.descriptorTable.get(nextDescId);
  const u8devWrite2 = ring.descriptorTable.getDescriptorBuffer(nextDescId);
  bufferWriteNumbers(u8devWrite2, 0);
  t.equal(secondDesc.flags, 0 /* no next flag */);
  t.equal(secondDesc.len, 10);
  t.equal(secondDesc.next, 2);
  t.equal(ring.usedRing.readIdx(), 0);
  ring.usedRing.placeDescriptorAsDevice(descId, 15 /* bytes written */);
  t.equal(ring.usedRing.readIdx(), 1);
  const u8 = ring.getBuffer();
  t.equal(ring.descriptorTable.descriptorsAvailable, 16);
  t.ok(u8 instanceof Uint8Array);
  t.equal(u8.length, 15);
  t.equal(u8[0], 4);
  t.equal(u8[11], 15);
  t.equal(u8[12], 0); // second subarray data
  t.equal(u8[13], 1);
  t.equal(u8[14], 2);
  t.end();
});

test('ring fill all slots and process', (t) => {
  const ring = new VRing(mem, 0, 4 /* slots */);
  let i;
  let descId;
  t.ok(ring.placeBuffers([bufferWriteNumbers(getOnePageBuffer(0), 1)], true));
  t.ok(ring.placeBuffers([bufferWriteNumbers(getOnePageBuffer(1), 2)], true));
  t.ok(ring.placeBuffers([bufferWriteNumbers(getOnePageBuffer(2), 3)], true));
  t.ok(ring.placeBuffers([bufferWriteNumbers(getOnePageBuffer(3), 4)], true));
  t.equal(ring.placeBuffers([getOnePageBuffer(4)], true), false);

  const currentIdx = ring.availableRing.readIdx();
  t.equal(currentIdx, 4);
  for (i = 0; i < 3; ++i) {
    descId = ring.availableRing.readDescriptorAsDevice(i);
    ring.usedRing.placeDescriptorAsDevice(descId, 5 /* bytes written */);
  }

  t.equal(ring.getBuffer()[0], 1);
  t.equal(ring.getBuffer()[0], 2);
  t.equal(ring.getBuffer()[0], 3);
  t.equal(ring.getBuffer(), null);
  t.equal(ring.getBuffer(), null);

  descId = ring.availableRing.readDescriptorAsDevice(3);
  ring.usedRing.placeDescriptorAsDevice(descId, 5 /* bytes written */);
  t.equal(ring.getBuffer()[0], 4);
  t.equal(ring.getBuffer(), null);
  t.end();
});

test('vring operation', (t) => {
  const ring = new VRing(mem, 0, 4);
  let devIndex = 0;
  let count = 0;

  function devProcessAll() {
    const bytesWritten = 3;
    let descId = 0;
    while (devIndex < ring.availableRing.readIdx()) {
      descId = ring.availableRing.readDescriptorAsDevice();
      ring.usedRing.placeDescriptorAsDevice(descId, bytesWritten);
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

  t.equal(count, 0);
  for (let i = 0; i < 4; ++i) {
    driverProcessAll();
    t.ok(count > 0);
    devProcessAll();
  }
  t.equal(count, 0);
  t.end();
});
