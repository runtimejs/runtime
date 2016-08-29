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

const { setNameHandle } = require('./block-device-interface');
const availableBuses = Object.create(null); // not using a Map because the buses should be easy to access directly
const availableDevices = [];

module.exports = {
  registerDevice(device) {
    if (!availableBuses[device.bus]) availableBuses[device.bus] = [];
    const i = availableDevices.push(device) - 1;
    device[setNameHandle](`${device.bus}${i}`);
    availableBuses[device.bus].push(device);

    console.log(`[block] registered block device ${device.name}`);
  },
  getDevices() {
    return availableDevices;
  },
  getBuses() {
    return availableBuses;
  },
};
