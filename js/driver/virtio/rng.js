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
var VirtioDevice = require('./device');
var runtime = require('../../core');

function initializeRNGDevice(pciDevice) {
  var ioSpace = pciDevice.getBAR(0).resource;
  var irq = pciDevice.getIRQ();
  var allocator = runtime.allocator;

  var features = {};

  var dev = new VirtioDevice('rng', ioSpace, allocator);
  dev.setDriverAck();

  var driverFeatures = {};

  var deviceFeatures = dev.readDeviceFeatures(driverFeatures);

  if (!dev.writeGuestFeatures(features, driverFeatures, deviceFeatures)) {
    debug('[virtio] driver is unable to start');
    return;
  }

  var QUEUE_ID_REQ = 0;

  var reqQueue = dev.queueSetup(QUEUE_ID_REQ);

  function fillRequestQueue(length) {
    if (reqQueue.descriptorTable.descriptorsAvailable) {
      if (!reqQueue.placeBuffers([new Uint8Array(length || 1)], true)) {
        debug('[virtio rng] error placing descriptor buffers');
      }
    }

    if (reqQueue.isNotificationNeeded()) {
      dev.queueNotify(QUEUE_ID_REQ);
    }
  }

  dev.setDriverReady();

  fillRequestQueue(1);
  dev.hasPendingIRQ();

  var s1 = reqQueue.getBuffer();
  s1 = s1[0];

  fillRequestQueue(1);
  dev.hasPendingIRQ();

  var s2 = reqQueue.getBuffer();
  s2 = s2[0];

  function prng() {
    var tmp2 = 36969 * (s2 & 65535) + (s2 >> 16);
    var tmp1 = 18000 * (s1 & 65535) + (s1 >> 16);
    var tmp = (tmp2 << 16) + tmp1;
    if (tmp < 0) tmp = tmp * -1;
    while (tmp > 256) tmp = tmp / 4;
    tmp = Math.round(tmp);
    s1 = s2;
    s2 = tmp;
    return tmp;
  }

  runtime.driver.rng = {
    getRand: function(length, cb) {
      if (typeof length === 'function') {
        cb = length;
        length = 1;
      }
      fillRequestQueue(length || 1);
      dev.hasPendingIRQ();
      if (cb) {
        reqQueue.fetchBuffers(function(u8) {
          s1 = s2;
          s2 = u8[0];
          cb(u8);
        });
      } else {
        var result = reqQueue.getBuffer();
        s1 = s2;
        s2 = result[0];
        return result;
      }
    },
    getHybridRand: function(length, cb) {
      if (typeof length === 'function') {
        cb = length;
        length = 1;
      }

      fillRequestQueue(length || 1);
      dev.hasPendingIRQ();
      if (cb) {
        reqQueue.fetchBuffers(function(u8) {
          if (u8 === null) {
            var tmparr = [];
            for (var i = 0;i < length; i++) {
              tmparr.push(prng());
            }
            u8 = new Uint8Array(tmparr);
          }
          s1 = s2
          s2 = u8[0];
          cb(u8);
        });
      } else {
        var result = reqQueue.getBuffer();
        if (result === null) {
          var tmparr = [];
          for (var i = 0;i < length; i++) {
            tmparr.push(prng());
          }
          result = new Uint8Array(tmparr);
        }
        s1 = s2;
        s2 = result[0];
        return result;
      }
    }
  };
}

module.exports = initializeRNGDevice;
