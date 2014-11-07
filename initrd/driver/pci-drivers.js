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

/**
 * Device and driver info for PCI devices. PCI bus driver uses this data
 * to load required device drivers
 */
define('pciDrivers', [], function() {
  "use strict";

  var virtioDevice = {
    name: 'Virtio device',
    driver: 'virtio.js',
    busMaster: true,
    enabled: true,
  };

  /**
   * PCI vendors and devices data
   */
  var data = {
    0x10ec: {
      name: 'Realtek Semiconductor Corp',
      devices: {
        0x8139: {
          name: 'Realtek RTL-8139/8139C/8139C+ PCI Fast Ethernet NIC',
          driver: 'rtl8139.js',
          busMaster: true,
          enabled: false,
        },
      },
    },
  };

  /**
   * Search for device with provided PCI Vendor and Device IDs. Returns
   * null in case device not found. Valid device info includes name
   * and driver properties (driver is filename of driver startup file)
   */
  function findDevice(vendorId, deviceId) {
    // Check if this is a virtio device
    if (0x1af4 === vendorId && deviceId >= 0x1000 && deviceId <= 0x103f) {
      return virtioDevice;
    }

    if ('undefined' === typeof data[vendorId]) {
      return null;
    }

    var vendorData = data[vendorId];
    if ('undefined' === typeof vendorData.devices[deviceId]) {
      return null;
    }

    return vendorData.devices[deviceId];
  }

  return {
    findDevice: findDevice,
  };
});
