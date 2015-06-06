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
var MACAddress = runtime.net.MACAddress;
var Interface = runtime.net.Interface;

var virtioHeader = (function() {
  var OFFSET_FLAGS = 0;
  var OFFSET_GSO_TYPE = 1;
  var OFFSET_HDR_LEN = 2;
  var OFFSET_GSO_SIZE = 4;
  var OFFSET_CSUM_START = 6;
  var OFFSET_CSUM_OFFSET = 8;
  var optsEmpty = {};
  var offset = 0;

  function writeVirtioHeader(view, opts) {
    opts = opts || optsEmpty;
    view.setUint8(offset + OFFSET_FLAGS, opts.flags >>> 0);
    view.setUint8(offset + OFFSET_GSO_TYPE, opts.gsoType >>> 0);
    // view.setUint16(offset + OFFSET_HDR_LEN, opts.hdrLen >>> 0, true);
    // view.setUint16(offset + OFFSET_GSO_SIZE, opts.gsoSize >>> 0, true);
    view.setUint16(offset + OFFSET_CSUM_START, opts.csumStart >>> 0, false);
    view.setUint16(offset + OFFSET_CSUM_OFFSET, opts.csumOffset >>> 0, false);
  }

  return {
    write: writeVirtioHeader,
    length: 10,
  };
})();

function initializeNetworkDevice(pciDevice) {
  var ioSpace = pciDevice.getBAR(0).resource;
  var irq = pciDevice.getIRQ();
  var allocator = runtime.allocator;

  var features = {
    VIRTIO_NET_F_CSUM: 0,
    VIRTIO_NET_F_GUEST_CSUM: 1,
    VIRTIO_NET_F_MAC: 5,
    VIRTIO_NET_F_GSO: 6,
    VIRTIO_NET_F_GUEST_TSO4: 7,
    VIRTIO_NET_F_GUEST_TSO6: 8,
    VIRTIO_NET_F_GUEST_ECN: 9,
    VIRTIO_NET_F_GUEST_UFO: 10,
    VIRTIO_NET_F_HOST_TSO4: 11,
    VIRTIO_NET_F_HOST_TSO6: 12,
    VIRTIO_NET_F_HOST_ECN: 13,
    VIRTIO_NET_F_HOST_UFO: 14,
    VIRTIO_NET_F_MRG_RXBUF: 15,
    VIRTIO_NET_F_STATUS: 16,
    VIRTIO_NET_F_CTRL_VQ: 17,
    VIRTIO_NET_F_CTRL_RX: 18,
    VIRTIO_NET_F_CTRL_VLAN: 19,
    VIRTIO_NET_F_GUEST_ANNOUNCE: 21,

    VIRTIO_RING_F_EVENT_IDX: 29,
  };

  var dev = new VirtioDevice('net', ioSpace, allocator);
  dev.setDriverAck();

  var driverFeatures = {
    VIRTIO_NET_F_MAC: true,    // able to read MAC address
    VIRTIO_NET_F_STATUS: true, // able to check network status
    // VIRTIO_NET_F_CSUM: true,   // checksum offload
    // VIRTIO_NET_F_GUEST_CSUM: true,   // ok without cksum
    // VIRTIO_NET_F_GSO: true,
    VIRTIO_RING_F_EVENT_IDX: true, // able to suppress interrupts
  };

  var deviceFeatures = dev.readDeviceFeatures(features);
  debug(JSON.stringify(deviceFeatures));

  if (deviceFeatures.VIRTIO_NET_F_GSO) {
    // deviceFeatures.VIRTIO_NET_F_CSUM = true;
    // deviceFeatures.VIRTIO_NET_F_GUEST_CSUM = true;
  }

  if (!dev.writeGuestFeatures(features, driverFeatures, deviceFeatures)) {
    debug('[virtio] driver is unable to start');
    return;
  }

  var hwAddr = dev.netReadHWAddress();
  var status = dev.netReadStatus();

  if (!status) {
    return;
  }

  var QUEUE_ID_RECV = 0;
  var QUEUE_ID_TRANSMIT = 1;

  var recvQueue = dev.queueSetup(QUEUE_ID_RECV);
  var transmitQueue = dev.queueSetup(QUEUE_ID_TRANSMIT);
  // var networkInterface = null;

  function fillReceiveQueue() {
    while (recvQueue.descriptorTable.descriptorsAvailable) {
      recvQueue.placeBuffers([new Uint8Array(1536)], true);
    }

    dev.queueNotify(QUEUE_ID_RECV);
  }

  var mac = new MACAddress(hwAddr[0], hwAddr[1], hwAddr[2],
                           hwAddr[3], hwAddr[4], hwAddr[5]);
  var intf = new Interface(mac);
  intf.setBufferDataOffset(virtioHeader.length);
  intf.ontransmit = function(u8headers, u8data) {
    if (u8data) {
      transmitQueue.placeBuffers([u8headers, u8data], false);
    } else {
      transmitQueue.placeBuffers([u8headers], false);
    }

    dev.queueNotify(QUEUE_ID_TRANSMIT);
  };

  irq.on(function() {
    if (!dev.hasPendingIRQ()) {
      return;
    }

    var u8 = null;
    for (;;) {
      u8 = transmitQueue.getBuffer();
      if (null === u8) {
        break;
      }
    }

    u8 = null;
    for (;;) {
      u8 = recvQueue.getBuffer();
      if (null === u8) {
        break;
      }

      intf.receive(u8);
    }

    fillReceiveQueue();
  });

  dev.setDriverReady();
  fillReceiveQueue();

  runtime.net.interfaceAdd(intf);
}

module.exports = initializeNetworkDevice;
