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

const ELEMENT_SIZE = 8;
const OFFSET_BYTES_RING = 4;
const INDEX_FLAGS = 0;
const INDEX_IDX = 1;
const VRING_USED_F_NO_NOTIFY = 1;

class UsedRing {
  constructor(buffer, byteOffset, ringSize) {
    this.ringSize = ringSize;
    this.ringData = new Uint16Array(buffer, byteOffset, 2);
    this.ringElements = new Uint32Array(buffer, byteOffset + OFFSET_BYTES_RING, ringSize * 2);
    this.lastUsedIndex = 0;
    this.ringData[INDEX_IDX] = 0;
  }

  static getElementSize() {
    return ELEMENT_SIZE;
  }

  readElement(index) {
    return {
      id: this.ringElements[index * 2],
      len: this.ringElements[(index * 2) + 1],
    };
  }

  readIdx() {
    return this.ringData[INDEX_IDX];
  }

  placeDescriptorAsDevice(index, bufferLength) {
    const used = (this.readIdx() & (this.ringSize - 1)) >>> 0;
    this.ringElements[index * 2] = used;
    this.ringElements[(index * 2) + 1] = bufferLength;
    ++this.ringData[INDEX_IDX];
  }

  hasUnprocessedBuffers() {
    return this.lastUsedIndex !== this.readIdx();
  }

  getUsedDescriptor() {
    const last = (this.lastUsedIndex & (this.ringSize - 1)) >>> 0;
    const descriptorData = this.readElement(last);
    this.lastUsedIndex = (this.lastUsedIndex + 1) & 0xffff;
    return descriptorData;
  }

  isNotificationNeeded() {
    return !(this.ringData[INDEX_FLAGS] & VRING_USED_F_NO_NOTIFY);
  }

  printDebug() {
    console.log('USED RING:');
    console.log(`  idx = ${this.readIdx()}, wrapped ${this.readIdx() & (this.ringSize - 1)}`);
    console.log(`  last_used_index = ${this.lastUsedIndex}, wrapped ${this.lastUsedIndex & (this.ringSize - 1)}`); // eslint-disable-line max-len
    console.log(`  has_unproc_buffers = ${this.hasUnprocessedBuffers()}`);
    console.log(`  notif_needed = ${this.isNotificationNeeded()}`);
  }
}

module.exports = UsedRing;
