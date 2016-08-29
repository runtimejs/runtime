// Copyright 2016-present runtime.js project authors
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
const VirtioDevice = require('./device');
const runtime = require('../../core');
const { Uint64LE } = require('int64-buffer');

const VIRTIO_BLK_T_IN = 0;
const VIRTIO_BLK_T_OUT = 1;

function initializeBlockDevice(pciDevice) {
  const ioSpace = pciDevice.getBAR(0).resource;
  const irq = pciDevice.getIRQ();

  const features = {
    VIRTIO_BLK_F_SIZE_MAX: 1,
    VIRTIO_BLK_F_SEG_MAX: 2,
    VIRTIO_BLK_F_GEOMETRY: 4,
    VIRTIO_BLK_F_RO: 5,
    VIRTIO_BLK_F_BLK_SIZE: 6,
    VIRTIO_BLK_F_FLUSH: 9,
    VIRTIO_BLK_F_TOPOLOGY: 10,
    VIRTIO_BLK_F_CONFIG_WCE: 11,
  };

  const dev = new VirtioDevice('blk', ioSpace);
  dev.setDriverAck();

  const driverFeatures = {
    // VIRTIO_BLK_F_SIZE_MAX: true,
    VIRTIO_BLK_F_SEG_MAX: true,
    VIRTIO_BLK_F_GEOMETRY: true,
    VIRTIO_BLK_F_BLK_SIZE: true,
    VIRTIO_BLK_F_TOPOLOGY: true,
  };

  const deviceFeatures = dev.readDeviceFeatures(features);
  debug(JSON.stringify(deviceFeatures));

  if (!dev.writeGuestFeatures(features, driverFeatures, deviceFeatures)) {
    debug('[virtio] blk driver is unable to start');
    return;
  }

  const QUEUE_ID_REQ = 0;

  const reqQueue = dev.queueSetup(QUEUE_ID_REQ);
  const promiseQueue = [];

  const sectorSize = 512;
  const sectorCount = dev.blkReadSectorCount();
  const totalSectorCount = dev.blkReadTotalSectorCount();

  function buildHeader(type, sector) {
    const u8 = new Uint8Array(16);
    const view = new DataView(u8.buffer);
    view.setUint32(0, type, true);
    view.setUint32(4, 0, true); // priority: low
    u8.set((new Uint64LE(sector)).toArray(), 8);
    return u8;
  }

  const diskDriver = new runtime.block.BlockDeviceInterface('virtio', {
    read(sector, data) {
      return new Promise((resolve, reject) => {
        if (sector > totalSectorCount) {
          reject(new RangeError(`sector ${sector} out of bounds (max ${totalSectorCount}, non-inclusive)`));
          return;
        }
        const status = new Uint8Array(1);
        promiseQueue.push([resolve, reject, VIRTIO_BLK_T_IN, data, status]);
        reqQueue.placeBuffers([buildHeader(VIRTIO_BLK_T_IN, sector), data, status], false, [false, true, true]);

        if (reqQueue.isNotificationNeeded()) {
          dev.queueNotify(QUEUE_ID_REQ);
        }
      });
    },
    write(sector, data) {
      return new Promise((resolve, reject) => {
        const status = new Uint8Array(1);
        promiseQueue.push([resolve, reject, VIRTIO_BLK_T_OUT, data, status]);
        reqQueue.placeBuffers([buildHeader(VIRTIO_BLK_T_OUT, sector), data, status], false, [false, false, true]);

        if (reqQueue.isNotificationNeeded()) {
          dev.queueNotify(QUEUE_ID_REQ);
        }
      });
    },
    formatInfo: {
      sectorSize,
      sectorCount,
      totalSectorCount,
    },
    isOnline() {
      return true; // TODO: actually check if the disk is online or not
    },
  });

  runtime.block.registerDevice(diskDriver);

  function recvBuffer() {
    if (promiseQueue.length === 0) {
      return;
    }
    const [resolve, reject, type, data, status] = promiseQueue.shift();
    setImmediate(() => {
      if (status[0] !== 0) return reject(new Error('IO error'));
      if (type === VIRTIO_BLK_T_IN) {
        resolve(data);
      } else {
        resolve();
      }
    });
  }

  irq.on(() => {
    if (!dev.hasPendingIRQ()) {
      return;
    }
    reqQueue.fetchBuffers(recvBuffer);
  });

  dev.setDriverReady();
}

module.exports = initializeBlockDevice;
