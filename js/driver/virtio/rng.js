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
        break;
      }
    }

    if (reqQueue.isNotificationNeeded()) {
      dev.queueNotify(QUEUE_ID_REQ);
    }
  }

  dev.setDriverReady();

  var randobj = {
    queue: [],
    init: function() {},
    seed: function() {
      fillRequestQueue();
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
      var no_ret = true;
      var pos = randobj.queue.length - 1;
      function fillItUp() {
        fillRequestQueue();
        reqQueue.fetchBuffers(function(u8) {
          if (typeof randobj.queue[pos] !== 'undefined') {
            if (randobj.queue[pos].missing === 0 && no_ret === true) {
              no_ret = false;
              return cb();
            }
            if (u8.length < randobj.queue[pos].missing && no_ret === true) {
              for (let obj in u8) {
                randobj.queue[pos].array[randobj.queue[pos].array.length - randobj.queue[pos].missing] = u8[obj];
                randobj.queue[pos].missing -= 1;
              }
              fillItUp();
            } else if (no_ret === true) {
              for (var j = 0; j < randobj.queue[0].missing; j++) {
                randobj.queue[pos].array[randobj.queue[pos].array.length - randobj.queue[pos].missing] = u8[j];
                randobj.queue[pos].missing -= 1;
              }
            }
          }
        });
      }
      fillItUp();
    }
  }

  var random = runtime.random.addSource('virtio-rng', randobj);
  runtime.random.setDefault('virtio-rng');
}

module.exports = initializeRNGDevice;
