// Copyright 2014 Runtime.JS project authors
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

"use strict";

function DescriptorTable(buffer, byteOffset, ringSize) {
  this.view = new DataView(buffer, byteOffset, ringSize * DescriptorTable.SIZE);
  this.freeDescriptorHead = 0;
  this.descriptorsAvailable = ringSize;

  this.descriptorsBuffers = new Array(ringSize);
  for (var i = 0; i < ringSize; ++i) {
    this.descriptorsBuffers[i] = null;
  }

  for (var i = 0; i < ringSize - 1; ++i) {
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
  var len = self.view.getUint32(base + DescriptorTable.OFFSET_LEN, true);
  var flags = self.view.getUint16(base + DescriptorTable.OFFSET_FLAGS, true);
  var next = self.view.getUint16(base + DescriptorTable.OFFSET_NEXT, true);

  return {
    len: len,
    flags: flags,
    next: next,
  };
};

DescriptorTable.prototype.setBuffer = function(descriptorId, buf, flags) {
  var self = this;
  var base = DescriptorTable.SIZE * descriptorId;
  var addr = runtime.bufferAddress(buf);
  self.view.setUint32(base + DescriptorTable.OFFSET_ADDR + 0, addr[0], true); // high
  self.view.setUint32(base + DescriptorTable.OFFSET_ADDR + 4, addr[1], true); // low
  self.view.setUint32(base + DescriptorTable.OFFSET_LEN, buf.byteLength >>> 0, true);
  self.view.setUint16(base + DescriptorTable.OFFSET_FLAGS, flags >>> 0, true);
};

DescriptorTable.prototype.getNext = function(descriptorId) {
  var self = this;
  var base = DescriptorTable.SIZE * descriptorId;
  return self.view.getUint16(base + DescriptorTable.OFFSET_NEXT, true);
};

DescriptorTable.prototype.setNext = function(descriptorId, next) {
  var self = this;
  var base = DescriptorTable.SIZE * descriptorId;
  self.view.setUint16(base + DescriptorTable.OFFSET_NEXT, next >>> 0, true);
};

DescriptorTable.prototype.placeBuffers = function(buffers, isWriteOnly) {
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

    self.setBuffer(head, d, flags);
    self.descriptorsBuffers[head] = d;
    head = self.getNext(head);
  }

  self.descriptorsAvailable -= count;
  self.freeDescriptorHead = head;
  return first;
};

DescriptorTable.prototype.getBuffer = function(descriptorId) {
  var self = this;
  var descFlags = 0;

  var nextDescriptorId = descriptorId;
  var buffer = self.descriptorsBuffers[descriptorId];

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
  this.added = 0;
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
  ++self.added;
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
}

UsedRing.ELEMENT_SIZE = 8;

UsedRing.prototype.readElement = function(index) {
  var self = this;
  return {
    id: self.ringElements[index * 2],
    len: self.ringElements[index * 2 + 1],
  };
};

UsedRing.prototype.readIdx = function() {
  var self = this;
  return self.ringData[self.INDEX_IDX];
}

UsedRing.prototype.hasUnprocessedBuffers = function() {
  var self = this;
  return self.lastUsedIndex !== self.readIdx();
}

UsedRing.prototype.getUsedDescriptor = function() {
  var self = this;

  if (!self.hasUnprocessedBuffers()) {
    return null;
  }

  var last = (self.lastUsedIndex & (self.ringSize - 1)) >>> 0;
  var descriptorData = self.readElement(last);
  ++self.lastUsedIndex;
  return descriptorData;
}

var SIZEOF_UINT16 = 2;

function VRing(mem, byteOffset, ringSize) {
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
  var VRING_DESC_F_NEXT = 1;
  var VRING_DESC_F_WRITE = 2;

  var first = self.descriptorTable.placeBuffers(buffers, isWriteOnly);
  if (first < 0) {
    return false;
  }

  self.availableRing.placeDescriptor(first);
  return true;
};

VRing.prototype.getBuffer = function() {
  var self = this;
  var VRING_DESC_F_NEXT = 1;

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

  if (!(buffer instanceof ArrayBuffer)) {
    // TODO: global vring errors handler
    isolate.log('VRING ERROR: buffer is not an ArrayBuffer');
    return null;
  }

  //TODO: shrink buf
  return {
    buf: buffer,
    len: len
  };
}

module.exports = VRing;
