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
const VRing = require('./vring');

const DEVICE_STATUS_RESET = 0;
const DEVICE_STATUS_ACKNOWLEDGE = 1;
const DEVICE_STATUS_DRIVER = 2;
const DEVICE_STATUS_DRIVER_OK = 4;

class VirtioDevice {
  constructor(deviceType, ioSpace) {
    this.mem = __SYSCALL.allocDMA();
    this.io = ((ioSpaceResource) => {
      const ioPorts = {
        // Common
        DEVICE_FEATURES: 0x00, // 32 bit r
        GUEST_FEATURES: 0x04, // 32 bit r+w
        QUEUE_ADDRESS: 0x08, // 32 bit r+w
        QUEUE_SIZE: 0x0c, // 16 bit r
        QUEUE_SELECT: 0x0e, // 16 bit r+w
        QUEUE_NOTIFY: 0x10, // 16 bit r+w
        DEVICE_STATUS: 0x12, //  8 bit r+w
        ISR_STATUS: 0x13, //  8 bit r
      };

      if (deviceType === 'net') {
        // Network card
        ioPorts.NETWORK_DEVICE_MAC0 = 0x14; // 8  bit r
        ioPorts.NETWORK_DEVICE_MAC1 = 0x15; // 8  bit r
        ioPorts.NETWORK_DEVICE_MAC2 = 0x16; // 8  bit r
        ioPorts.NETWORK_DEVICE_MAC3 = 0x17; // 8  bit r
        ioPorts.NETWORK_DEVICE_MAC4 = 0x18; // 8  bit r
        ioPorts.NETWORK_DEVICE_MAC5 = 0x19; // 8  bit r
        ioPorts.NETWORK_DEVICE_STATUS = 0x1A; // 16 bit r
      }

      if (deviceType === 'blk') {
        // Block device
        ioPorts.BLOCK_TOTAL_SECTOR_COUNT = 0x14; // 64 bit r
        ioPorts.BLOCK_MAX_SEGMENT_SIZE = 0x1c; // 32 bit r
        ioPorts.BLOCK_MAX_SEGMENT_COUNT = 0x20; // 32 bit r
        ioPorts.BLOCK_CYLINDER_COUNT = 0x24; // 16 bit r
        ioPorts.BLOCK_HEAD_COUNT = 0x26; // 8 bit r
        ioPorts.BLOCK_SECTOR_COUNT = 0x27; // 8 bit r
        ioPorts.BLOCK_BLOCK_LENGTH = 0x28; // 32 bit r
      }

      const ports = {};
      for (const portName of Object.keys(ioPorts)) {
        const portOffset = ioPorts[portName];
        ports[portName] = ioSpaceResource.offsetPort(portOffset);
      }

      return ports;
    })(ioSpace);
    this.nextRingOffset = 0;
  }
  readDeviceFeatures(features) {
    const deviceFeatures = this.io.DEVICE_FEATURES.read32();
    const result = {};

    for (const feature of Object.keys(features)) {
      const mask = 1 << features[feature];
      if (deviceFeatures & mask) {
        result[feature] = true;
      }
    }

    return result;
  }
  writeGuestFeatures(features, driverFeatures, deviceFeatures) {
    let value = 0;

    for (const feature of Object.keys(features)) {
      if (!driverFeatures[feature]) {
        continue;
      }
      if (!deviceFeatures[feature]) {
        return false;
      } // Device doesn't support required feature

      const mask = 1 << features[feature];
      value |= mask;
    }

    this.io.GUEST_FEATURES.write32(value >>> 0);
    return true;
  }
  queueSetup(queueIndex) {
    this.io.QUEUE_SELECT.write16(queueIndex >>> 0);
    const size = this.io.QUEUE_SIZE.read16();
    const ring = new VRing(this.mem, this.nextRingOffset, size);
    this.nextRingOffset += ring.size;
    this.io.QUEUE_ADDRESS.write32(ring.address >>> 12);
    return ring;
  }
  queueNotify(queueIndex) {
    return this.io.QUEUE_NOTIFY.write16(queueIndex >>> 0);
  }
  setDriverAck() {
    this.io.DEVICE_STATUS.write8(DEVICE_STATUS_ACKNOWLEDGE);
    this.io.DEVICE_STATUS.write8(DEVICE_STATUS_ACKNOWLEDGE | DEVICE_STATUS_DRIVER);
  }
  setDriverReady() {
    return this.io.DEVICE_STATUS.write8(DEVICE_STATUS_ACKNOWLEDGE |
      DEVICE_STATUS_DRIVER | DEVICE_STATUS_DRIVER_OK);
  }
  resetDevice() {
    return this.io.DEVICE_STATUS.write8(DEVICE_STATUS_RESET);
  }
  hasPendingIRQ() {
    return !!(1 & this.io.ISR_STATUS.read8());
  }
    // [network device]
  netReadHWAddress() {
    return [
      this.io.NETWORK_DEVICE_MAC0.read8(),
      this.io.NETWORK_DEVICE_MAC1.read8(),
      this.io.NETWORK_DEVICE_MAC2.read8(),
      this.io.NETWORK_DEVICE_MAC3.read8(),
      this.io.NETWORK_DEVICE_MAC4.read8(),
      this.io.NETWORK_DEVICE_MAC5.read8(),
    ];
  }
    // [network device]
  netReadStatus() {
    return !!(1 & this.io.NETWORK_DEVICE_STATUS.read16());
  }

    // [block device]
  blkReadSectorCount() {
    return this.io.BLOCK_SECTOR_COUNT.read8();
  }

    // [block device]
  blkReadTotalSectorCount() {
    return this.io.BLOCK_TOTAL_SECTOR_COUNT.read32();
  }
}

module.exports = VirtioDevice;
