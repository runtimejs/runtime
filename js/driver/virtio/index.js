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
const virtioNet = require('./net');
const virtioBlk = require('./blk');
const virtioRNG = require('./rng');
const VIRTIO_SUBSYSTEM_NETWORK = 1;
const VIRTIO_SUBSYSTEM_BLOCK = 2;
const VIRTIO_SUBSYSTEM_RNG = 4;
const runtime = require('../../core');

const driver = {
  init(pciDevice) {
    const subsystemId = pciDevice.subsystem.subsystemId;

    if (subsystemId === VIRTIO_SUBSYSTEM_NETWORK) {
      return virtioNet(pciDevice);
    }
    if (subsystemId === VIRTIO_SUBSYSTEM_BLOCK) {
      return virtioBlk(pciDevice);
    }
    if (subsystemId === VIRTIO_SUBSYSTEM_RNG) {
      return virtioRNG(pciDevice);
    }

    debug(`[virtio] unknown virtio device (subsystem id ${subsystemId})`);
  },
  reset() {},
};

function testDeviceId(deviceId) {
  return deviceId >= 0x1000 && deviceId <= 0x103f;
}

runtime.pci.addDriver(0x1af4, testDeviceId, driver);
