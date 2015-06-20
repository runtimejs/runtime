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
var VRing = require('./vring');

function VirtioDevice(deviceType, ioSpace, allocator) {
  this.mem = allocator.allocDMA();
  this.io = (function(ioSpaceResource) {
    var ioPorts = {
      // Common
      DEVICE_FEATURES: 0x00, // 32 bit r
      GUEST_FEATURES: 0x04,  // 32 bit r+w
      QUEUE_ADDRESS: 0x08,   // 32 bit r+w
      QUEUE_SIZE: 0x0c,      // 16 bit r
      QUEUE_SELECT: 0x0e,    // 16 bit r+w
      QUEUE_NOTIFY: 0x10,    // 16 bit r+w
      DEVICE_STATUS: 0x12,   //  8 bit r+w
      ISR_STATUS: 0x13       //  8 bit r
    };

    if ('net' === deviceType) {
      // Network card
      ioPorts.NETWORK_DEVICE_MAC0 = 0x14;   // 8  bit r
      ioPorts.NETWORK_DEVICE_MAC1 = 0x15;   // 8  bit r
      ioPorts.NETWORK_DEVICE_MAC2 = 0x16;   // 8  bit r
      ioPorts.NETWORK_DEVICE_MAC3 = 0x17;   // 8  bit r
      ioPorts.NETWORK_DEVICE_MAC4 = 0x18;   // 8  bit r
      ioPorts.NETWORK_DEVICE_MAC5 = 0x19;   // 8  bit r
      ioPorts.NETWORK_DEVICE_STATUS = 0x1A; // 16 bit r
    }

    var ports = {};
    for (var portName in ioPorts) {
      if (!ioPorts.hasOwnProperty(portName)) {
        continue;
      }

      var portOffset = ioPorts[portName];
      ports[portName] = ioSpaceResource.offsetPort(portOffset);
    }

    return ports;
  })(ioSpace);
  this.nextRingOffset = 0;
}

VirtioDevice.prototype.readDeviceFeatures = function(features) {
  var deviceFeatures = this.io.DEVICE_FEATURES.read32();
  var result = {};

  for (var feature in features) {
    if (!features.hasOwnProperty(feature)) {
      continue;
    }

    var mask = 1 << features[feature];

    if (deviceFeatures & mask) {
      result[feature] = true;
    }
  }

  return result;
};

VirtioDevice.prototype.writeGuestFeatures = function(features, driverFeatures, deviceFeatures) {
  var value = 0;

  for (var feature in features) {
    if (!features.hasOwnProperty(feature)) {
      continue;
    }

    if (!driverFeatures[feature]) {
      continue;
    }

    if (!deviceFeatures[feature]) {
      // Device doesn't support required feature
      return false;
    }

    var mask = 1 << features[feature];
    value |= mask;
  }

  this.io.GUEST_FEATURES.write32(value >>> 0);
  return true;
};

VirtioDevice.prototype.queueSetup = function(queueIndex) {
  this.io.QUEUE_SELECT.write16(queueIndex >>> 0);
  var size = this.io.QUEUE_SIZE.read16();
  var ring = new VRing(this.mem, this.nextRingOffset, size);
  this.nextRingOffset += ring.size;
  this.io.QUEUE_ADDRESS.write32(ring.address >>> 12);
  return ring;
};

VirtioDevice.prototype.queueNotify = function(queueIndex) {
  return this.io.QUEUE_NOTIFY.write16(queueIndex >>> 0);
};

var DEVICE_STATUS_RESET = 0;
var DEVICE_STATUS_ACKNOWLEDGE = 1;
var DEVICE_STATUS_DRIVER = 2;
var DEVICE_STATUS_DRIVER_OK = 4;

VirtioDevice.prototype.setDriverAck = function() {
  this.io.DEVICE_STATUS.write8(DEVICE_STATUS_ACKNOWLEDGE);
  this.io.DEVICE_STATUS.write8(DEVICE_STATUS_ACKNOWLEDGE | DEVICE_STATUS_DRIVER);
};

VirtioDevice.prototype.setDriverReady = function() {
  return this.io.DEVICE_STATUS.write8(DEVICE_STATUS_ACKNOWLEDGE |
    DEVICE_STATUS_DRIVER | DEVICE_STATUS_DRIVER_OK);
};

VirtioDevice.prototype.resetDevice = function() {
  return this.io.DEVICE_STATUS.write8(DEVICE_STATUS_RESET);
};

VirtioDevice.prototype.hasPendingIRQ = function() {
  return !!(1 & this.io.ISR_STATUS.read8());
};

// [network device]
VirtioDevice.prototype.netReadHWAddress = function() {
  return [
    this.io.NETWORK_DEVICE_MAC0.read8(),
    this.io.NETWORK_DEVICE_MAC1.read8(),
    this.io.NETWORK_DEVICE_MAC2.read8(),
    this.io.NETWORK_DEVICE_MAC3.read8(),
    this.io.NETWORK_DEVICE_MAC4.read8(),
    this.io.NETWORK_DEVICE_MAC5.read8()
  ];
};

// [network device]
VirtioDevice.prototype.netReadStatus = function() {
  return !!(1 & this.io.NETWORK_DEVICE_STATUS.read16());
};

module.exports = VirtioDevice;
