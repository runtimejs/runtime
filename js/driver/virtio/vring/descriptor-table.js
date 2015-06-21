// Copyright 2014-2015 runtime.js project authors
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

var assert = require('assert');
var u8view = require('u8-view');
var runtime = require('../../../core');
var OFFSET_ADDR = 0;
var OFFSET_LEN = 8;
var OFFSET_FLAGS = 12;
var OFFSET_NEXT = 14;
var SIZE = 16;
var VRING_DESC_F_NEXT = 1;
var VRING_DESC_F_WRITE = 2;

class DescriptorTable {
  constructor(buffer, byteOffset, ringSize) {
    this.mem = new Uint8Array(buffer, byteOffset, ringSize * SIZE);
    this.freeDescriptorHead = 0;
    this.descriptorsAvailable = ringSize;
    this.descriptorsBuffers = new Array(ringSize);

    var i;
    for (i = 0; i < ringSize; ++i) {
      this.descriptorsBuffers[i] = null;
    }

    for (i = 0; i < ringSize - 1; ++i) {
      this.setNext(i, i + 1);
    }
  }

  static getDescriptorSizeBytes() {
    return SIZE;
  }

  get(descriptorId) {
    var base = SIZE * descriptorId;
    var len = u8view.getUint32LE(this.mem, base + OFFSET_LEN);
    var flags = u8view.getUint16LE(this.mem, base + OFFSET_FLAGS);
    var next = u8view.getUint16LE(this.mem, base + OFFSET_NEXT);

    return {
      len: len,
      flags: flags,
      next: next
    };
  }

  getDescriptorBuffer(descriptorId) {
    return this.descriptorsBuffers[descriptorId];
  }

  setBuffer(descriptorId, buf, len, flags) {
    var base = SIZE * descriptorId;
    var addr = runtime.bufferAddress(buf);
    u8view.setUint32LE(this.mem, base + OFFSET_ADDR + 0, addr[1]); // high
    u8view.setUint32LE(this.mem, base + OFFSET_ADDR + 4, addr[2]); // low
    u8view.setUint32LE(this.mem, base + OFFSET_LEN, len >>> 0);
    u8view.setUint16LE(this.mem, base + OFFSET_FLAGS, flags >>> 0);
  }

  getNext(descriptorId) {
    var base = SIZE * descriptorId;
    return u8view.getUint16LE(this.mem, base + OFFSET_NEXT);
  }

  setNext(descriptorId, next) {
    var base = SIZE * descriptorId;
    u8view.setUint16LE(this.mem, base + OFFSET_NEXT, next >>> 0);
  }

  /**
   * Put buffers into free slots of descriptor table
   *
   * @param buffers {array} array of Uint8Array buffers
   * @param lengths {array} array of corresponding buffer lengths (same size as buffers)
   * @param isWriteOnly {bool} set writeOnly flag for each buffer
   */
  placeBuffers(buffers, lengths, isWriteOnly) {
    var count = buffers.length;
    if (this.descriptorsAvailable < count) {
      return -1;
    }

    var head = this.freeDescriptorHead;
    var first = head;
    for (var i = 0; i < count; ++i) {
      var d = buffers[i];
      var flags = 0;
      if (i + 1 !== count) {
        flags |= VRING_DESC_F_NEXT;
      }
      if (isWriteOnly) {
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
    var nextDescriptorId = descriptorId;
    var buffer = this.descriptorsBuffers[descriptorId];
    this.descriptorsBuffers[descriptorId] = null;

    var desc = this.get(descriptorId);
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
}

module.exports = DescriptorTable;
