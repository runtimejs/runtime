// Copyright 2015-present runtime.js project authors
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
const scan = require('./scan');
const PciDevice = require('./pci-device');
const typeutils = require('typeutils');
const isint = require('isint');

const deviceList = [];

function init() {
  for (const pciData of scan()) {
    deviceList.push(new PciDevice(pciData));
  }
}

function setupDeviceDriver(vendorId, deviceId, driver) {
  assert(isint.uint16(vendorId));
  assert(isint.uint16(deviceId) || typeutils.isFunction(deviceId));

  for (const device of deviceList) {
    if (device.hasDriver()) {
      continue;
    }
    if (device.vendorId !== vendorId) {
      continue;
    }
    if (typeutils.isFunction(deviceId)) {
      if (!deviceId(device.deviceId)) {
        continue;
      }
    } else {
      if (device.deviceId !== deviceId) {
        continue;
      }
    }

    device.setDriver(driver);
  }
}

init();

exports.addDriver = (vendorId, deviceId, opts) => setupDeviceDriver(vendorId, deviceId, opts);
