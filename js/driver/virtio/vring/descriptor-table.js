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

const u8view = require('u8-view');
const OFFSET_ADDR = 0;
const OFFSET_LEN = 8;
const OFFSET_FLAGS = 12;
const OFFSET_NEXT = 14;
const SIZE = 16;
const VRING_DESC_F_NEXT = 1;
const VRING_DESC_F_WRITE = 2;

class DescriptorTable {
  constructor(buffer, byteOffset, ringSize) {
    this.mem = new Uint8Array(buffer, byteOffset, ringSize * SIZE);
    this.freeDescriptorHead = 0;
    this.descriptorsAvailable = ringSize;
    this.descriptorsBuffers = new Array(ringSize);

    for (let i = 0; i < ringSize; ++i) {
      this.descriptorsBuffers[i] = null;
    }
    for (let i = 0; i < ringSize - 1; ++i) {
      this.setNext(i, i + 1);
    }
  }

  static getDescriptorSizeBytes() {
    return SIZE;
  }

  get(descriptorId) {
    const base = SIZE * descriptorId;
    const len = u8view.getUint32LE(this.mem, base + OFFSET_LEN);
    const flags = u8view.getUint16LE(this.mem, base + OFFSET_FLAGS);
    const next = u8view.getUint16LE(this.mem, base + OFFSET_NEXT);

    return {
      len,
      flags,
      next,
    };
  }

  getDescriptorBuffer(descriptorId) {
    return this.descriptorsBuffers[descriptorId];
  }

  setBuffer(descriptorId, buf, len, flags) {
    const base = SIZE * descriptorId;
    const addr = __SYSCALL.bufferAddress(buf);
    u8view.setUint32LE(this.mem, base + OFFSET_ADDR + 0, addr[1]); // high
    u8view.setUint32LE(this.mem, base + OFFSET_ADDR + 4, addr[2]); // low
    u8view.setUint32LE(this.mem, base + OFFSET_LEN, len >>> 0);
    u8view.setUint16LE(this.mem, base + OFFSET_FLAGS, flags >>> 0);
  }

  getNext(descriptorId) {
    const base = SIZE * descriptorId;
    return u8view.getUint16LE(this.mem, base + OFFSET_NEXT);
  }

  setNext(descriptorId, next) {
    const base = SIZE * descriptorId;
    u8view.setUint16LE(this.mem, base + OFFSET_NEXT, next >>> 0);
  }

  /**
   * Put buffers into free slots of descriptor table
   *
   * @param buffers {array} array of Uint8Array buffers
   * @param lengths {array} array of corresponding buffer lengths (same size as buffers)
   * @param isWriteOnly {bool} set writeOnly flag for each buffer
   * @param isWriteOnlyArray {array} optional array of writeOnly flags, one value for each buffer
   */
  placeBuffers(buffers, lengths, isWriteOnly, isWriteOnlyArray) {
    const count = buffers.length;
    if (this.descriptorsAvailable < count) {
      return -1;
    }

    let head = this.freeDescriptorHead;
    const first = head;
    for (let i = 0; i < count; ++i) {
      const d = buffers[i];
      let bufWriteOnly = false;
      if (isWriteOnlyArray) {
        bufWriteOnly = isWriteOnlyArray[i];
      } else {
        bufWriteOnly = isWriteOnly;
      }
      let flags = 0;
      if (count !== i + 1) {
        flags |= VRING_DESC_F_NEXT;
      }
      if (bufWriteOnly) {
        flags |= VRING_DESC_F_WRITE;
      }

      this.setBuffer(head, d, lengths[i], flags);
      this.descriptorsBuffers[head] = d;
      head = this.getNext(head);
    }

    this.descriptorsAvailable -= count;
    this.freeDescriptorHead = head;
    return first;
  }

  getBuffer(descriptorId) {
    let nextDescriptorId = descriptorId;
    const buffer = this.descriptorsBuffers[descriptorId];
    this.descriptorsBuffers[descriptorId] = null;

    let desc = this.get(descriptorId);
    while (desc.flags & VRING_DESC_F_NEXT) {
      nextDescriptorId = desc.next;
      desc = this.get(nextDescriptorId);
      ++this.descriptorsAvailable;
    }

    this.setNext(nextDescriptorId, this.freeDescriptorHead);
    this.freeDescriptorHead = descriptorId;
    ++this.descriptorsAvailable;
    return buffer;
  }

  printDebug() {
    console.log('DESCRIPTOR TABLE:');
    this.descriptorsBuffers.forEach((buf, i) => console.log(`  ${i}: ${buf ? (`<Uint8Array:${buf.length}>`) : '-'}, next ${this.getNext(i)}`));  // eslint-disable-line max-len
  }
}

module.exports = DescriptorTable;
