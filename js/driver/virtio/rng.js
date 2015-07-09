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

  function fillRequestQueue() {
    while (reqQueue.descriptorTable.descriptorsAvailable) {
      if (!reqQueue.placeBuffers([new Uint8Array(256)], true)) {

      }
    }

    if (reqQueue.isNotificationNeeded()) {
      dev.queueNotify(QUEUE_ID_REQ);
    }
  }

  dev.setDriverReady();

  var randobj = {
    queue: [],
    init: function() {
      fillRequestQueue();
      for (;;) {
        var u8 = reqQueue.getBuffer();
        if (u8 === null) {
          break;
        }
        for (let obj of u8) {
          randobj.queue.push(obj);
        }
      }
    },
    realRand: function(cb) {
      fillRequestQueue();
      for (;;) {
        var u8 = reqQueue.getBuffer();
        if (u8 === null) {
          cb();
          break;
        }
        for (let obj of u8) {
          randobj.queue.push(obj);
        }
      }
    },
    seed: function() {
      fillRequestQueue();
      var u8 = reqQueue.getBuffer();
      return u8[0];
    },
    fillQueue: function() {
      // This function must block,
      // It's called after the queue is drained
      fillRequestQueue();
      for (;;) {
        var u8 = reqQueue.getBuffer();
        if (u8 === null) {
          break;
        }
        for (let obj of u8) {
          randobj.queue.push(obj);
        }
      }
    }
  }

  var random = runtime.random.addSource('virtio-rng', randobj);
  runtime.random.setDefault('virtio-rng');
}

module.exports = initializeRNGDevice;
