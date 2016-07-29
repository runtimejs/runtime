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

const AVAILABLE_RING_INDEX_FLAGS = 0;
const AVAILABLE_RING_INDEX_IDX = 1;
const AVAILABLE_RING_INDEX_RING = 2;
const VRING_AVAIL_F_NO_INTERRUPT = 1;

class AvailableRing {
  constructor(buffer, byteOffset, ringSize) {
    this.availableRing = new Uint16Array(buffer, byteOffset, ringSize + 3);
    this.ringSize = ringSize;
    this.AVAILABLE_RING_INDEX_USED_EVENT = 2 + ringSize;
    this.availableRing[AVAILABLE_RING_INDEX_IDX] = 0;
  }

  readIdx() {
    return this.availableRing[AVAILABLE_RING_INDEX_IDX];
  }

  incrementIdx() {
    ++this.availableRing[AVAILABLE_RING_INDEX_IDX];
  }

  setEventIdx(value) {
    this.availableRing[this.AVAILABLE_RING_INDEX_USED_EVENT] = value >>> 0;
  }

  setRing(index, value) {
    this.availableRing[AVAILABLE_RING_INDEX_RING + index] = value;
  }

  placeDescriptor(index) {
    const available = (this.readIdx() & (this.ringSize - 1)) >>> 0;
    this.setRing(available, index);
    this.incrementIdx();
  }

  readDescriptorAsDevice(idxIndex) {
    return this.availableRing[AVAILABLE_RING_INDEX_RING + idxIndex];
  }

  disableInterrupts() {
    this.availableRing[AVAILABLE_RING_INDEX_FLAGS] = VRING_AVAIL_F_NO_INTERRUPT;
  }

  enableInterrupts() {
    this.availableRing[AVAILABLE_RING_INDEX_FLAGS] = 0;
  }

  printDebug() {
    console.log('AVAILABLE RING:');
    console.log(`  idx = ${this.readIdx()}, wrapped ${this.readIdx() & (this.ringSize - 1)}`);
    for (let i = 0; i < this.ringSize; ++i) console.log(`  ${i}: descriptor = ${this.readDescriptorAsDevice(i)}`); // eslint-disable-line max-len
  }
}

module.exports = AvailableRing;
