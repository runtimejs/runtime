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

  dev.setDriverReady();

  var randobj = {
    queue: [],
    init: function() {
      reqQueue.placeBuffers([new Uint8Array(1)], true);
      if (reqQueue.isNotificationNeeded()) {
        dev.queueNotify(QUEUE_ID_REQ);
      }

      var u8 = reqQueue.getBuffer();
      // If it was requested too fast, fallback to Math.random instead.
      if (u8 === null) {
        var foo = Math.round(Math.random() * 0xffffffff);
        if (foo < 0) foo = -foo;
        while (foo > 256) foo /= 4;
        foo = Math.round(foo);
        u8 = [foo];
      }
      return u8[0];
    },
    fillQueue: function(cb) {
      var array = [];
      for (var i = 0; i < randobj.queue.length; i++) {
        array.push(randobj.queue[i].array);
      }

      reqQueue.placeBuffers(array, true);

      if (reqQueue.isNotificationNeeded()) {
        dev.queueNotify(QUEUE_ID_REQ);
      }

      irq.on(function() {
        if (!dev.hasPendingIRQ()) {
          return;
        }

        var j = 0;

        reqQueue.fetchBuffers(function(u8) {
          randobj.queue[j].array = u8;
          if (j === randobj.queue.length - 1) {
            cb();
          }
        });
      });
    }
  }

  var random = runtime.random.addSource('virtio-rng', randobj);
  runtime.random.setDefault('virtio-rng');
}

module.exports = initializeRNGDevice;
