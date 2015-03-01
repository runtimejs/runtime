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

var net = require('net/net');
var net2 = require('net2/net');
var MACAddress = require('net2/mac-address');
var NetBuffer = require('net2/net-buffer');
var eth = require('net/eth');
var ip4 = require('net/ip4');
var tcp = require('net/tcp/tcp');
var VirtioDevice = require('./virtio/device');

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

function initializeNetworkDevice(pci, allocator) {
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

  var dev = new VirtioDevice('net', pci, allocator);
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
  isolate.log(JSON.stringify(deviceFeatures));

  if (deviceFeatures.VIRTIO_NET_F_GSO) {
    // deviceFeatures.VIRTIO_NET_F_CSUM = true;
    // deviceFeatures.VIRTIO_NET_F_GUEST_CSUM = true;
  }

  if (!dev.writeGuestFeatures(features, driverFeatures, deviceFeatures)) {
    console.log('[virtio] driver is unable to start');
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
  var networkInterface = null;

  function fillReceiveQueue() {
    while (recvQueue.descriptorTable.descriptorsAvailable) {
      recvQueue.placeBuffers([new ArrayBuffer(1536)], true);
    }

    dev.queueNotify(QUEUE_ID_RECV);
  }

  function networkInterfaceReady(ifc) {
    networkInterface = ifc;
    dev.setDriverReady();
    fillReceiveQueue();
    ifc.enable();
  }

  var intf = net2.interfaceAdd({
    macAddress: new MACAddress(hwAddr[0], hwAddr[1], hwAddr[2],
                               hwAddr[3], hwAddr[4], hwAddr[5]),
    bufferDataOffset: virtioHeader.length,
    transmit: function() {
      console.log('transmit called');
    }
  });

  pci.irq.on(function() {
    if (!dev.hasPendingIRQ()) {
      return;
    }

    var dat = null;
    for (;;) {
      dat = transmitQueue.getBuffer();
      if (null === dat) {
        break;
      }

      // isolate.log('[virtio] TRANSMIT OK');
    }

    dat = null;
    for (;;) {
      dat = recvQueue.getBuffer();
      if (null === dat) {
        break;
      }

      // isolate.log('[virtio] RECEIVE OK (' + dat.len + ' bytes)');

      if (networkInterface) {
        networkInterface.recv(dat.buf, dat.len, 0);
      }

      intf.receive(new Uint8Array(dat.buf, 0, dat.len));
    }

    fillReceiveQueue();
  });

  networkInterfaceReady(net.addNetworkInterface({
    hw: hwAddr,
    packetHeaderLength: virtioHeader.length,
    sendPacketTCP: function(packet) {
      // var VIRTIO_NET_HDR_F_NEEDS_CSUM = 1;
      // var ckOffset = eth.headerLength + ip4.getHeaderLength();
      // var ckLen = 16;
      var buf = packet;
      // virtioHeader.write(new DataView(buf), { flags: VIRTIO_NET_HDR_F_NEEDS_CSUM, csumStart: ckOffset, csumOffset: ckLen, gsoType: 1 });
      transmitQueue.placeBuffers([buf], false);
      dev.queueNotify(QUEUE_ID_TRANSMIT);
    },
    sendPacket: function(packet) {
      var buf = packet;
      // virtioHeader.write(new DataView(buf));
      transmitQueue.placeBuffers([buf], false);
      dev.queueNotify(QUEUE_ID_TRANSMIT);
    },
  }));
}

// Virtio devices driver

module.exports = function(args) {
  var pci = args.pci;
  var allocator = args.allocator;
  var subsystemId = pci.subsystemData.subsystemId;
  switch (subsystemId) {
    case 1: // Network card
      initializeNetworkDevice(pci, allocator);
      break;
    default:
      console.log('[virtio] unknown virtio device');
  }
};
