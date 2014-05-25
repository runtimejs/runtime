// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/**
 * Device and driver info for PCI devices. PCI bus driver uses this data
 * to load specific device drivers
 */
var pciDeviceInfo = (function(exports) {
    "use strict";

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
})(exports);

exports.findDevice = pciDeviceInfo.findDevice;
