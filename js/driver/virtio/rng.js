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
const VirtioDevice = require('./device');
const runtime = require('../../core');

function initializeRNGDevice(pciDevice) {
  const ioSpace = pciDevice.getBAR(0).resource;
  const irq = pciDevice.getIRQ();
  const allocator = runtime.allocator;

  const features = {};

  const dev = new VirtioDevice('rng', ioSpace, allocator);
  dev.setDriverAck();

  const driverFeatures = {};
  const deviceFeatures = dev.readDeviceFeatures(driverFeatures);

  if (!dev.writeGuestFeatures(features, driverFeatures, deviceFeatures)) {
    return debug('[virtio] driver is unable to start');
  }

  const QUEUE_ID_REQ = 0;

  const reqQueue = dev.queueSetup(QUEUE_ID_REQ);
  const cbqueue = [];

  function recvBuffer() {
    if (cbqueue.length === 0) {
      return;
    }
    cbqueue.shift()();
  }

  irq.on(() => {
    if (!dev.hasPendingIRQ()) {
      return;
    }
    reqQueue.fetchBuffers(recvBuffer);
  });

  dev.setDriverReady();

  const source = new runtime.random.EntropySource('virtio-rng');

  source.ongetbytes = (u8, cb) => {
    cbqueue.push(cb);
    reqQueue.placeBuffers([u8], true);

    if (reqQueue.isNotificationNeeded()) {
      dev.queueNotify(QUEUE_ID_REQ);
    }
  };

  runtime.random.addEntropySource(source);
}

module.exports = initializeRNGDevice;
