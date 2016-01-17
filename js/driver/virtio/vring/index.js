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

var assert = require('assert');
var u8view = require('u8-view');
var runtime = require('../../../core');
var DescriptorTable = require('./descriptor-table');
var AvailableRing = require('./available-ring');
var UsedRing = require('./used-ring');
var memoryBarrier = require('../../../core/atomic').memoryBarrier;
var SIZEOF_UINT16 = 2;

function VRing(mem, byteOffset, ringSize) {
  assert(ringSize !== 0 && (ringSize & (ringSize - 1)) === 0, 'invalid ringSize = ' + ringSize);
  function align(value) {
    return ((value + 4095) & ~4095) >>> 0;
  }

  var baseAddress = mem.address + byteOffset;
  var offsetAvailableRing = DescriptorTable.getDescriptorSizeBytes() * ringSize;
  var offsetUsedRing = align(offsetAvailableRing + SIZEOF_UINT16 * (3 + ringSize));
  var ringSizeBytes = offsetUsedRing + align(UsedRing.getElementSize() * ringSize);
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

VRing.prototype.fetchBuffers = function(fn) {
  var count = 0;

  for (;;) {
    if (!this.suppressInterrupts) {
      this.availableRing.disableInterrupts();
    }

    for (;;) {
      let u8 = this.getBuffer();
      if (null === u8) {
        break;
      }

      count++;
      if (fn) {
        setImmediate(function() {
          fn(u8);
        });
      }
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
};

/**
 * Supply buffers to the device
 *
 * @param buffers {array} Array of buffers
 * @param isWriteOnly {bool} R/W buffers flag
 */
VRing.prototype.placeBuffers = function(buffers, isWriteOnly) {
  if (this.suppressInterrupts) {
    this.fetchBuffers(null);
  }

  var self = this;

  // Single Uint8Array could use multiple physical pages
  // as its backing store
  var pageSplitBuffers = [];
  var lengths = [];
  for (var i = 0, l = buffers.length; i < l; ++i) {
    var u8 = buffers[i];
    var addr = __SYSCALL.bufferAddress(u8);
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

  var first = self.descriptorTable.placeBuffers(pageSplitBuffers, lengths, isWriteOnly);
  if (first < 0) {
    debug('virtio: no descriptors\n');
    return false;
  }

  // Barrier is needed to make sure device would be able to see
  // updated descriptors in descriptor table before we're going
  // to update index
  memoryBarrier();

  self.availableRing.placeDescriptor(first);
  return true;
};

VRing.prototype.getBuffer = function() {
  var self = this;
  var hasUnprocessed = self.usedRing.hasUnprocessedBuffers();
  if (!hasUnprocessed) {
    return null;
  }

  var used = self.usedRing.getUsedDescriptor();
  if (null === used) {
    return null;
  }

  var descriptorId = used.id;
  var buffer = self.descriptorTable.getBuffer(descriptorId);
  var len = used.len;

  this.availableRing.setEventIdx(this.usedRing.lastUsedIndex + 1);

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

VRing.prototype.isNotificationNeeded = function() {
  // Barrier to make sure we've updated index before
  // checking notifications flag
  memoryBarrier();
  return this.usedRing.isNotificationNeeded();
};

VRing.prototype.suppressUsedBuffers = function() {
  this.availableRing.disableInterrupts();
  this.suppressInterrupts = true;
};

module.exports = VRing;
