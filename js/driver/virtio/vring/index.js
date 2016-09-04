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

const assert = require('assert');
const DescriptorTable = require('./descriptor-table');
const AvailableRing = require('./available-ring');
const UsedRing = require('./used-ring');
const { memoryBarrier } = require('../../../core/atomic');
const SIZEOF_UINT16 = 2;

class VRing {
  constructor(mem, byteOffset, ringSize) {
    assert(ringSize !== 0 && (ringSize & (ringSize - 1)) === 0, `invalid ringSize = ${ringSize}`);

    function align(value) {
      return ((value + 4095) & ~4095) >>> 0;
    }

    const baseAddress = mem.address + byteOffset;
    const offsetAvailableRing = DescriptorTable.getDescriptorSizeBytes() * ringSize;
    const offsetUsedRing = align(offsetAvailableRing + (SIZEOF_UINT16 * (3 + ringSize)));
    const ringSizeBytes = offsetUsedRing + align(UsedRing.getElementSize() * ringSize);
    this.ringSize = ringSize;
    this.address = baseAddress;
    this.size = ringSizeBytes;
    this.suppressInterrupts = false;
    this.descriptorTable = new DescriptorTable(mem.buffer, byteOffset, ringSize);
    this.availableRing = new AvailableRing(mem.buffer, byteOffset + offsetAvailableRing, ringSize);
    this.usedRing = new UsedRing(mem.buffer, byteOffset + offsetUsedRing, ringSize);
    this.availableRing.setEventIdx(this.usedRing.lastUsedIndex);
    this.availableRing.enableInterrupts();
  }
  fetchBuffers(fn) {
    let count = 0;

    for (;;) {
      if (!this.suppressInterrupts) {
        this.availableRing.disableInterrupts();
      }

      for (;;) {
        const u8 = this.getBuffer();
        if (u8 === null) {
          break;
        }

        count++;
        if (fn) setImmediate(() => fn(u8));
      }

      if (!this.suppressInterrupts) {
        this.availableRing.enableInterrupts();

        // Make sure we read the latest index written by the
        // device, otherwise we can miss interrupts
        memoryBarrier();
      }

      if (!this.usedRing.hasUnprocessedBuffers()) {
        break;
      }
    }

    return count;
  }
  /**
   * Supply buffers to the device
   *
   * @param buffers {array} Array of buffers
   * @param isWriteOnly {bool} R/W buffers flag
   * @param isWriteOnlyArray {array} optional array of 'isWriteOnly's, one for each buffer
   */
  placeBuffers(buffers, isWriteOnly, isWriteOnlyArray) {
    if (this.suppressInterrupts) {
      this.fetchBuffers(null);
    }

    // Single Uint8Array could use multiple physical pages
    // as its backing store
    const pageSplitBuffers = [];
    const lengths = [];
    for (const u8 of buffers) {
      const addr = __SYSCALL.bufferAddress(u8);
      if (addr[3] === 0) {
        pageSplitBuffers.push(u8);
        lengths.push(addr[0]);
      } else {
        // push entire u8 here but set shorter length
        // this way we can receive the same buffer as a single item later
        pageSplitBuffers.push(u8);
        pageSplitBuffers.push(u8.subarray(addr[0]));
        lengths.push(addr[0]);
        lengths.push(addr[3]);
        debug('virtio: multipage buffer\n');
      }
    }

    const first = this.descriptorTable.placeBuffers(pageSplitBuffers, lengths, isWriteOnly, isWriteOnlyArray);
    if (first < 0) {
      debug('virtio: no descriptors\n');
      return false;
    }

    // Barrier is needed to make sure device would be able to see
    // updated descriptors in descriptor table before we're going
    // to update index
    memoryBarrier();

    this.availableRing.placeDescriptor(first);
    return true;
  }
  getBuffer() {
    const hasUnprocessed = this.usedRing.hasUnprocessedBuffers();
    if (!hasUnprocessed) {
      return null;
    }

    const used = this.usedRing.getUsedDescriptor();
    if (used === null) {
      return null;
    }

    const descriptorId = used.id;
    const buffer = this.descriptorTable.getBuffer(descriptorId);
    const len = used.len;

    this.availableRing.setEventIdx(this.usedRing.lastUsedIndex + 1);

    if (!(buffer instanceof Uint8Array)) {
      // TODO: global vring errors handler
      console.log('VRING ERROR: buffer is not a Uint8Array');
      console.log('used.descriptor id ', descriptorId);
      console.log('used.len ', len);
      console.log('last used index ', this.usedRing.lastUsedIndex);
      return null;
    }

    return buffer.subarray(0, len);
  }
  isNotificationNeeded() {
    // Barrier to make sure we've updated index before
    // checking notifications flag
    memoryBarrier();
    return this.usedRing.isNotificationNeeded();
  }
  suppressUsedBuffers() {
    this.availableRing.disableInterrupts();
    this.suppressInterrupts = true;
  }
}

module.exports = VRing;
