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
const VirtioDevice = require('./device');
const runtime = require('../../core');
const { MACAddress, Interface } = runtime.net;

const virtioHeader = (() => {
  const OFFSET_FLAGS = 0;
  const OFFSET_GSO_TYPE = 1;
  // const OFFSET_HDR_LEN = 2;
  // const OFFSET_GSO_SIZE = 4;
  const OFFSET_CSUM_START = 6;
  const OFFSET_CSUM_OFFSET = 8;
  const optsEmpty = {};
  const offset = 0;

  return {
    write(view, opts = optsEmpty) {
      view.setUint8(offset + OFFSET_FLAGS, opts.flags >>> 0);
      view.setUint8(offset + OFFSET_GSO_TYPE, opts.gsoType >>> 0);
      // view.setUint16(offset + OFFSET_HDR_LEN, opts.hdrLen >>> 0, true);
      // view.setUint16(offset + OFFSET_GSO_SIZE, opts.gsoSize >>> 0, true);
      view.setUint16(offset + OFFSET_CSUM_START, opts.csumStart >>> 0, false);
      view.setUint16(offset + OFFSET_CSUM_OFFSET, opts.csumOffset >>> 0, false);
    },
    length: 10,
  };
})();

function initializeNetworkDevice(pciDevice) {
  const ioSpace = pciDevice.getBAR(0).resource;
  const irq = pciDevice.getIRQ();

  const features = {
    // Device specific
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

    // VRing
    VIRTIO_RING_F_NOTIFY_ON_EMPTY: 24,
    VIRTIO_RING_F_EVENT_IDX: 29,
  };

  const dev = new VirtioDevice('net', ioSpace);
  dev.setDriverAck();

  const driverFeatures = {
    VIRTIO_NET_F_MAC: true, // able to read MAC address
    VIRTIO_NET_F_STATUS: true, // able to check network status
    // VIRTIO_RING_F_NOTIFY_ON_EMPTY: true
    // VIRTIO_NET_F_CSUM: true,   // checksum offload
    // VIRTIO_NET_F_GUEST_CSUM: true,   // ok without cksum
    // VIRTIO_NET_F_GSO: true,
    // VIRTIO_RING_F_EVENT_IDX: true // using index to suppress interrupts
  };

  const deviceFeatures = dev.readDeviceFeatures(features);
  debug(JSON.stringify(deviceFeatures));

  if (deviceFeatures.VIRTIO_NET_F_GSO) {
    // deviceFeatures.VIRTIO_NET_F_CSUM = true;
    // deviceFeatures.VIRTIO_NET_F_GUEST_CSUM = true;
  }

  if (!dev.writeGuestFeatures(features, driverFeatures, deviceFeatures)) {
    debug('[virtio] driver is unable to start');
    return;
  }

  const hwAddr = dev.netReadHWAddress();
  const status = dev.netReadStatus();

  if (!status) {
    return;
  }

  const QUEUE_ID_RECV = 0;
  const QUEUE_ID_TRANSMIT = 1;

  const recvQueue = dev.queueSetup(QUEUE_ID_RECV);
  const transmitQueue = dev.queueSetup(QUEUE_ID_TRANSMIT);
  transmitQueue.suppressUsedBuffers();

  function fillReceiveQueue() {
    while (recvQueue.descriptorTable.descriptorsAvailable) {
      if (!recvQueue.placeBuffers([new Uint8Array(1536)], true)) {
        break;
      }
    }

    if (recvQueue.isNotificationNeeded()) {
      dev.queueNotify(QUEUE_ID_RECV);
    }
  }

  const mac = new MACAddress(hwAddr[0], hwAddr[1], hwAddr[2],
  hwAddr[3], hwAddr[4], hwAddr[5]);
  const intf = new Interface(mac);
  intf.setBufferDataOffset(virtioHeader.length);
  intf.ontransmit = (u8headers, u8data) => {
    if (u8data) {
      transmitQueue.placeBuffers([u8headers, u8data], false);
    } else {
      transmitQueue.placeBuffers([u8headers], false);
    }

    if (transmitQueue.isNotificationNeeded()) {
      dev.queueNotify(QUEUE_ID_TRANSMIT);
    }
  };

  function recvBuffer(u8) {
    intf.receive(u8);
  }

  irq.on(() => {
    if (!dev.hasPendingIRQ()) {
      return;
    }

    recvQueue.fetchBuffers(recvBuffer);
    fillReceiveQueue();
  });

// Under high load we're missing interrupts. This needs to be fixed.
// This setInterval hack clears pending IRQ flag and rechecks queues.
  setInterval(() => {
    dev.hasPendingIRQ();
    recvQueue.fetchBuffers(recvBuffer);
    fillReceiveQueue();
  }, 100);

  dev.setDriverReady();
  fillReceiveQueue();

  runtime.net.interfaceAdd(intf);
}

module.exports = initializeNetworkDevice;
