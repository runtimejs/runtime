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
var runtime = require('../../core');

function DescriptorTable(buffer, byteOffset, ringSize) {
  this.mem = new Uint8Array(buffer, byteOffset, ringSize * DescriptorTable.SIZE);
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

DescriptorTable.OFFSET_ADDR = 0;
DescriptorTable.OFFSET_LEN = 8;
DescriptorTable.OFFSET_FLAGS = 12;
DescriptorTable.OFFSET_NEXT = 14;
DescriptorTable.SIZE = 16;
DescriptorTable.VRING_DESC_F_NEXT = 1;
DescriptorTable.VRING_DESC_F_WRITE = 2;

DescriptorTable.prototype.get = function(descriptorId) {
  var self = this;
  var base = DescriptorTable.SIZE * descriptorId;
  var len = u8view.getUint32LE(self.mem, base + DescriptorTable.OFFSET_LEN);
  var flags = u8view.getUint16LE(self.mem, base + DescriptorTable.OFFSET_FLAGS);
  var next = u8view.getUint16LE(self.mem, base + DescriptorTable.OFFSET_NEXT);

  return {
    len: len,
    flags: flags,
    next: next
  };
};

DescriptorTable.prototype.getDescriptorBuffer = function(descriptorId) {
  return this.descriptorsBuffers[descriptorId];
};

DescriptorTable.prototype.setBuffer = function(descriptorId, buf, len, flags) {
  var self = this;
  var base = DescriptorTable.SIZE * descriptorId;
  var addr = runtime.bufferAddress(buf);
  u8view.setUint32LE(self.mem, base + DescriptorTable.OFFSET_ADDR + 0, addr[1]); // high
  u8view.setUint32LE(self.mem, base + DescriptorTable.OFFSET_ADDR + 4, addr[2]); // low
  u8view.setUint32LE(self.mem, base + DescriptorTable.OFFSET_LEN, len >>> 0);
  u8view.setUint16LE(self.mem, base + DescriptorTable.OFFSET_FLAGS, flags >>> 0);
};

DescriptorTable.prototype.getNext = function(descriptorId) {
  var self = this;
  var base = DescriptorTable.SIZE * descriptorId;
  return u8view.getUint16LE(self.mem, base + DescriptorTable.OFFSET_NEXT);
};

DescriptorTable.prototype.setNext = function(descriptorId, next) {
  var self = this;
  var base = DescriptorTable.SIZE * descriptorId;
  u8view.setUint16LE(self.mem, base + DescriptorTable.OFFSET_NEXT, next >>> 0);
};

/**
 * Put buffers into free slots of descriptor table
 *
 * @param buffers {array} array of Uint8Array buffers
 * @param lengths {array} array of corresponding buffer lengths (same size as buffers)
 * @param isWriteOnly {bool} set writeOnly flag for each buffer
 */
DescriptorTable.prototype.placeBuffers = function(buffers, lengths, isWriteOnly) {
  var self = this;
  var count = buffers.length;
  if (self.descriptorsAvailable < count) {
    return -1;
  }

  var head = self.freeDescriptorHead;
  var first = head;
  for (var i = 0; i < count; ++i) {
    var d = buffers[i];
    var flags = 0;
    if (i + 1 !== count) {
      flags |= DescriptorTable.VRING_DESC_F_NEXT;
    }
    if (isWriteOnly) {
      flags |= DescriptorTable.VRING_DESC_F_WRITE;
    }

    self.setBuffer(head, d, lengths[i], flags);
    self.descriptorsBuffers[head] = d;
    head = self.getNext(head);
  }

  self.descriptorsAvailable -= count;
  self.freeDescriptorHead = head;
  return first;
};

DescriptorTable.prototype.getBuffer = function(descriptorId) {
  var self = this;
  var nextDescriptorId = descriptorId;
  var buffer = self.descriptorsBuffers[descriptorId];
  self.descriptorsBuffers[descriptorId] = null;

  var desc = self.get(descriptorId);
  while (desc.flags & DescriptorTable.VRING_DESC_F_NEXT) {
    nextDescriptorId = desc.next;
    desc = self.get(nextDescriptorId);
    ++self.descriptorsAvailable;
  }

  self.setNext(nextDescriptorId, self.freeDescriptorHead);
  self.freeDescriptorHead = descriptorId;
  ++self.descriptorsAvailable;
  return buffer;
};

function AvailableRing(buffer, byteOffset, ringSize) {
  this.availableRing = new Uint16Array(buffer, byteOffset, ringSize + 3);
  this.ringSize = ringSize;
  this.AVAILABLE_RING_INDEX_FLAGS = 0;
  this.AVAILABLE_RING_INDEX_IDX = 1;
  this.AVAILABLE_RING_INDEX_RING = 2;
  this.AVAILABLE_RING_INDEX_USED_EVENT = 2 + ringSize;
  this.VRING_AVAIL_F_NO_INTERRUPT = 1;
  this.availableRing[this.AVAILABLE_RING_INDEX_IDX] = 0;
}

AvailableRing.prototype.readIdx = function() {
  var self = this;
  return self.availableRing[self.AVAILABLE_RING_INDEX_IDX];
};

AvailableRing.prototype.incrementIdx = function() {
  var self = this;
  ++self.availableRing[self.AVAILABLE_RING_INDEX_IDX];
};

AvailableRing.prototype.setEventIdx = function(value) {
  var self = this;
  self.availableRing[self.AVAILABLE_RING_INDEX_USED_EVENT] = value >>> 0;
};

AvailableRing.prototype.setRing = function(index, value) {
  var self = this;
  self.availableRing[self.AVAILABLE_RING_INDEX_RING + index] = value;
};

AvailableRing.prototype.placeDescriptor = function(index) {
  var self = this;
  var available = (self.readIdx() & (self.ringSize - 1)) >>> 0;
  self.setRing(available, index);
  self.incrementIdx();
};

AvailableRing.prototype.readDescriptorAsDevice = function(idxIndex) {
  var self = this;
  return self.availableRing[self.AVAILABLE_RING_INDEX_RING + idxIndex];
};

AvailableRing.prototype.disableInterrupts = function() {
  this.availableRing[this.AVAILABLE_RING_INDEX_FLAGS] = this.VRING_AVAIL_F_NO_INTERRUPT;
};

AvailableRing.prototype.enableInterrupts = function() {
  this.availableRing[this.AVAILABLE_RING_INDEX_FLAGS] = 0;
};

function UsedRing(buffer, byteOffset, ringSize) {
  this.OFFSET_BYTES_RING = 4;
  this.INDEX_IDX = 1;
  this.ringSize = ringSize;
  this.ringData = new Uint16Array(buffer, byteOffset, 2);
  this.ringElements = new Uint32Array(buffer, byteOffset + this.OFFSET_BYTES_RING, ringSize * 2);
  this.lastUsedIndex = 0;
  this.ringData[this.INDEX_IDX] = 0;
}

UsedRing.ELEMENT_SIZE = 8;

UsedRing.prototype.readElement = function(index) {
  var self = this;
  return {
    id: self.ringElements[index * 2],
    len: self.ringElements[index * 2 + 1]
  };
};

UsedRing.prototype.readIdx = function() {
  var self = this;
  return self.ringData[self.INDEX_IDX];
};

UsedRing.prototype.placeDescriptorAsDevice = function(index, bufferLength) {
  var self = this;
  var used = (self.readIdx() & (self.ringSize - 1)) >>> 0;
  self.ringElements[index * 2] = used;
  self.ringElements[index * 2 + 1] = bufferLength;
  ++self.ringData[self.INDEX_IDX];
};

UsedRing.prototype.hasUnprocessedBuffers = function() {
  var self = this;
  return self.lastUsedIndex !== self.readIdx();
};

UsedRing.prototype.getUsedDescriptor = function() {
  var self = this;

  if (!self.hasUnprocessedBuffers()) {
    return null;
  }

  var last = (self.lastUsedIndex & (self.ringSize - 1)) >>> 0;
  var descriptorData = self.readElement(last);
  self.lastUsedIndex = (self.lastUsedIndex + 1) & 0xffff;
  return descriptorData;
};

var SIZEOF_UINT16 = 2;

function VRing(mem, byteOffset, ringSize) {
  assert(ringSize !== 0 && (ringSize & (ringSize - 1)) === 0, 'invalid ringSize = ' + ringSize);
  function align(value) {
    return ((value + 4095) & ~4095) >>> 0;
  }

  var baseAddress = mem.address + byteOffset;
  var offsetAvailableRing = DescriptorTable.SIZE * ringSize;
  var offsetUsedRing = align(offsetAvailableRing + SIZEOF_UINT16 * (3 + ringSize));
  var ringSizeBytes = offsetUsedRing + align(UsedRing.ELEMENT_SIZE * ringSize);
  this.address = baseAddress;
  this.size = ringSizeBytes;
  this.descriptorTable = new DescriptorTable(mem.buffer, byteOffset, ringSize);
  this.availableRing = new AvailableRing(mem.buffer, byteOffset + offsetAvailableRing, ringSize);
  this.usedRing = new UsedRing(mem.buffer, byteOffset + offsetUsedRing, ringSize);
  this.availableRing.setEventIdx(this.usedRing.lastUsedIndex);
  this.availableRing.enableInterrupts();
}


/**
 * Supply buffers to the device
 *
 * @param buffers {array} Array of buffers
 * @param isWriteOnly {bool} R/W buffers flag
 */
VRing.prototype.placeBuffers = function(buffers, isWriteOnly) {
  var self = this;

  // Single Uint8Array could use multiple physical pages
  // as its backing store
  var pageSplitBuffers = [];
  var lengths = [];
  for (var i = 0, l = buffers.length; i < l; ++i) {
    var u8 = buffers[i];
    var addr = runtime.bufferAddress(u8);
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
    }
  }

  var first = self.descriptorTable.placeBuffers(pageSplitBuffers, lengths, isWriteOnly);
  if (first < 0) {
    return false;
  }

  self.availableRing.placeDescriptor(first);
  return true;
};

VRing.prototype.getBuffer = function() {
  var self = this;
  self.availableRing.disableInterrupts();
  var hasUnprocessed = self.usedRing.hasUnprocessedBuffers();
  self.availableRing.enableInterrupts();

  if (!hasUnprocessed) {
    return null;
  }

  var used = self.usedRing.getUsedDescriptor();
  if (null === used) {
    return null;
  }

  self.availableRing.setEventIdx(self.usedRing.lastUsedIndex);

  var descriptorId = used.id;

  var buffer = self.descriptorTable.getBuffer(descriptorId);
  var len = used.len;

  if (!(buffer instanceof Uint8Array)) {
    // TODO: global vring errors handler
    console.log('VRING ERROR: buffer is not a Uint8Array');
    console.log('used.descriptor id ', descriptorId);
    console.log('used.len ', len);
    console.log('last used index ', self.usedRing.lastUsedIndex);
    return null;
  }

  return buffer.subarray(0, len);
};

module.exports = VRing;
