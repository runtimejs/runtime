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

// Virtio ring
var VRing = (function() {
    function DescriptorTable(buffer, byteOffset, ringSize) {
        this.view = new DataView(buffer, byteOffset, ringSize * DescriptorTable.SIZE);
        this.freeDescriptorHead = 0;
        this.descriptorsAvailable = ringSize;

        this.descriptorsBuffers = new Array(ringSize);
        for (var i = 0; i < ringSize; ++i) {
            this.descriptorsBuffers[i] = null;
        }

        for (var i = 0; i < ringSize - 1; ++i) {
            this.setNext(i, i + 1);
        }
    }

    DescriptorTable.OFFSET_ADDR = 0;
    DescriptorTable.OFFSET_LEN = 8;
    DescriptorTable.OFFSET_FLAGS = 12;
    DescriptorTable.OFFSET_NEXT = 14;
    DescriptorTable.SIZE = 16;
    DescriptorTable.VRING_DESC_F_NEXT = 1;
    DescriptorTable.VRING_DESC_F_WRITE = 2;

    DescriptorTable.prototype.get = function(descriptorId) {
        var self = this;
        var base = DescriptorTable.SIZE * descriptorId;
        var len = self.view.getUint32(base + DescriptorTable.OFFSET_LEN, true);
        var flags = self.view.getUint16(base + DescriptorTable.OFFSET_FLAGS, true);
        var next = self.view.getUint16(base + DescriptorTable.OFFSET_NEXT, true);

        return {
            len: len,
            flags: flags,
            next: next,
        };
    };

    DescriptorTable.prototype.setBuffer = function(descriptorId, buf, flags) {
        var self = this;
        var base = DescriptorTable.SIZE * descriptorId;
        var addr = runtime.bufferAddress(buf);
        self.view.setUint32(base + DescriptorTable.OFFSET_ADDR + 0, addr[0], true); // high
        self.view.setUint32(base + DescriptorTable.OFFSET_ADDR + 4, addr[1], true); // low
        self.view.setUint32(base + DescriptorTable.OFFSET_LEN, buf.byteLength >>> 0, true);
        self.view.setUint16(base + DescriptorTable.OFFSET_FLAGS, flags >>> 0, true);
    };

    DescriptorTable.prototype.getNext = function(descriptorId) {
        var self = this;
        var base = DescriptorTable.SIZE * descriptorId;
        return self.view.getUint16(base + DescriptorTable.OFFSET_NEXT, true);
    };

    DescriptorTable.prototype.setNext = function(descriptorId, next) {
        var self = this;
        var base = DescriptorTable.SIZE * descriptorId;
        self.view.setUint16(base + DescriptorTable.OFFSET_NEXT, next >>> 0, true);
    };

    DescriptorTable.prototype.placeBuffers = function(buffersData) {
        var self = this;
        if (self.descriptorsAvailable < buffersData.length) {
            return -1;
        }

        var count = buffersData.length;
        var head = self.freeDescriptorHead;
        var first = head;
        for (var i = 0; i < count; ++i) {
            var d = buffersData[i];
            var flags = 0;
            if (i + 1 !== count) {
                flags |= DescriptorTable.VRING_DESC_F_NEXT;
            }
            if (d.isWriteOnly) {
                flags |= DescriptorTable.VRING_DESC_F_WRITE;
            }

            self.setBuffer(head, d.buf, flags);
            self.descriptorsBuffers[head] = d.buf;
            head = self.getNext(head);
        }

        self.descriptorsAvailable -= count;
        self.freeDescriptorHead = head;
        return first;
    };

    DescriptorTable.prototype.getBuffer = function(descriptorId) {
        var self = this;
        var buffer = self.descriptorsBuffers[descriptorId];

        var descFlags = 0;
        var nextDescriptorId = descriptorId;
        var buffer = self.descriptorsBuffers[descriptorId];
        do {
            var desc = self.get(nextDescriptorId);
            self.descriptorsBuffers[nextDescriptorId] = null;
            ++self.descriptorsAvailable;
            descFlags = desc.flags;
            nextDescriptorId = desc.next;
        } while (descFlags & DescriptorTable.VRING_DESC_F_NEXT);

        self.freeDescriptorHead = descriptorId;
        return buffer;
    };

    function AvailableRing(buffer, byteOffset, ringSize) {
        this.availableRing = new Uint16Array(buffer, byteOffset, ringSize + 3);
        this.ringSize = ringSize;
        this.AVAILABLE_RING_INDEX_FLAGS = 0;
        this.AVAILABLE_RING_INDEX_IDX = 1;
        this.AVAILABLE_RING_INDEX_RING = 2;
        this.AVAILABLE_RING_INDEX_USED_EVENT = 2 + ringSize;
        this.added = 0;
    }

    AvailableRing.prototype.readIdx = function() {
        var self = this;
        return self.availableRing[self.AVAILABLE_RING_INDEX_IDX];
    };

    AvailableRing.prototype.incrementIdx = function() {
        var self = this;
        ++self.availableRing[self.AVAILABLE_RING_INDEX_IDX];
    };

    AvailableRing.prototype.setRing = function(index, value) {
        var self = this;
        self.availableRing[self.AVAILABLE_RING_INDEX_RING + index] = value;
    };

    AvailableRing.prototype.placeDescriptor = function(index) {
        var self = this;
        var available = (self.readIdx() & (self.ringSize - 1)) >>> 0;
        self.setRing(available, index);
        self.incrementIdx();
        ++self.added;
    };

    function UsedRing(buffer, byteOffset, ringSize) {
        this.OFFSET_BYTES_RING = 4;
        this.INDEX_IDX = 1;
        this.ringSize = ringSize;
        this.ringData = new Uint16Array(buffer, byteOffset, 2);
        this.ringElements = new Uint32Array(buffer, byteOffset + this.OFFSET_BYTES_RING, ringSize * 2);
        this.lastUsedIndex = 0;
    }

    UsedRing.ELEMENT_SIZE = 8;

    UsedRing.prototype.readElement = function(index) {
        var self = this;
        return {
            id: self.ringElements[index * 2],
            len: self.ringElements[index * 2 + 1],
        };
    };

    UsedRing.prototype.readIdx = function() {
        var self = this;
        return self.ringData[self.INDEX_IDX];
    }

    UsedRing.prototype.hasUnprocessedBuffers = function() {
        var self = this;
        return self.lastUsedIndex !== self.readIdx();
    }

    UsedRing.prototype.getUsedDescriptor = function() {
        var self = this;

        if (!self.hasUnprocessedBuffers()) {
            return null;
        }

        var last = (self.lastUsedIndex & (self.ringSize - 1)) >>> 0;
        var descriptorData = self.readElement(last);
        ++self.lastUsedIndex;
        return descriptorData;
    }

    var SIZEOF_UINT16 = 2;

    function VRing(mem, byteOffset, ringSize) {
        function align(value) {
            return ((value + 4095) & ~4095) >>> 0;
        }

        var baseAddress = mem.address + byteOffset;
        var offsetAvailableRing = DescriptorTable.SIZE * ringSize;
        var offsetUsedRing = align(offsetAvailableRing + SIZEOF_UINT16 * (3 + ringSize));
        var ringSizeBytes = offsetUsedRing + align(UsedRing.ELEMENT_SIZE * ringSize);
        this.address = baseAddress;
        this.size = ringSizeBytes;
        this.descriptorTable = new DescriptorTable(mem.buffer, byteOffset, ringSize);
        this.availableRing = new AvailableRing(mem.buffer, byteOffset + offsetAvailableRing, ringSize);
        this.usedRing = new UsedRing(mem.buffer, byteOffset + offsetUsedRing, ringSize);
    }


    /**
     * Supply buffers to the device
     *
     * @param buffersData {array} Array of buffers data elements
     *        {buf: ArrayBuffer, isWriteOnly: bool}
     */
    VRing.prototype.placeBuffers = function(buffersData) {
        var self = this;
        var VRING_DESC_F_NEXT = 1;
        var VRING_DESC_F_WRITE = 2;

        var first = self.descriptorTable.placeBuffers(buffersData);
        if (first < 0) {
            return false;
        }

        self.availableRing.placeDescriptor(first);
        return true;
    };

    VRing.prototype.getBuffer = function() {
        var self = this;
        var VRING_DESC_F_NEXT = 1;

        var used = self.usedRing.getUsedDescriptor();
        if (null === used) {
            return null;
        }

        var descriptorId = used.id;

        var buffer = self.descriptorTable.getBuffer(descriptorId);
        var len = used.len;

        //TODO: shrink buf
        return {
            buf: buffer,
            len: len
        };
    }

    return VRing;
})();

var virtioHeader = (function() {
    var OFFSET_FLAGS = 0;
    var OFFSET_GSO_TYPE = 1;
    var OFFSET_HDR_LEN = 2;
    var OFFSET_GSO_SIZE = 4;
    var OFFSET_CSUM_START = 6;
    var OFFSET_CSUM_OFFSET = 8;
    var opts = {};
    var offset = 0;

    function writeVirtioHeader(view) {
        view.setUint8(offset + OFFSET_FLAGS, opts.flags >>> 0);
        view.setUint8(offset + OFFSET_GSO_TYPE, opts.gsoType >>> 0);
        view.setUint16(offset + OFFSET_HDR_LEN, opts.hdrLen >>> 0, true);
        view.setUint16(offset + OFFSET_GSO_SIZE, opts.gsoSize >>> 0, true);
        view.setUint16(offset + OFFSET_CSUM_START, opts.csumStart >>> 0, true);
        view.setUint16(offset + OFFSET_CSUM_OFFSET, opts.csumOffset >>> 0, true);
    }

    return {
        write: writeVirtioHeader,
        length: 10,
    };
})();

var VirtioDevice = (function() {
    function VirtioDevice(deviceType, pci, allocator) {
        var ioSpace = pci.bars[0].resource;
        this.mem = allocator.allocDMA();
        this.io = (function(ioSpace) {
            var ioPorts = {
                // Common
                DEVICE_FEATURES: 0x00, // 32 bit r
                GUEST_FEATURES: 0x04,  // 32 bit r+w
                QUEUE_ADDRESS: 0x08,   // 32 bit r+w
                QUEUE_SIZE: 0x0c,      // 16 bit r
                QUEUE_SELECT: 0x0e,    // 16 bit r+w
                QUEUE_NOTIFY: 0x10,    // 16 bit r+w
                DEVICE_STATUS: 0x12,   //  8 bit r+w
                ISR_STATUS: 0x13,      //  8 bit r
            };

            if ('net' === deviceType) {
                // Network card
                ioPorts.NETWORK_DEVICE_MAC0 = 0x14;   // 8  bit r
                ioPorts.NETWORK_DEVICE_MAC1 = 0x15;   // 8  bit r
                ioPorts.NETWORK_DEVICE_MAC2 = 0x16;   // 8  bit r
                ioPorts.NETWORK_DEVICE_MAC3 = 0x17;   // 8  bit r
                ioPorts.NETWORK_DEVICE_MAC4 = 0x18;   // 8  bit r
                ioPorts.NETWORK_DEVICE_MAC5 = 0x19;   // 8  bit r
                ioPorts.NETWORK_DEVICE_STATUS = 0x1A; // 16 bit r
            }

            var ports = {};
            for (var portName in ioPorts) {
                if (!ioPorts.hasOwnProperty(portName)) {
                    continue;
                }

                var portOffset = ioPorts[portName];
                ports[portName] = ioSpace.offsetPort(portOffset);
            }

            return ports;
        })(ioSpace);
        this.nextRingOffset = 0;
    }

    VirtioDevice.prototype.readDeviceFeatures = function(features) {
        var deviceFeatures = this.io.DEVICE_FEATURES.read32();
        var result = {};

        for (var feature in features) {
            if (!features.hasOwnProperty(feature)) {
                continue;
            }

            var mask = 1 << features[feature];

            if (deviceFeatures & mask) {
                result[feature] = true;
            }
        }

        return result;
    };

    VirtioDevice.prototype.writeGuestFeatures = function(features, driverFeatures, deviceFeatures) {
        var value = 0;

        for (var feature in features) {
            if (!features.hasOwnProperty(feature)) {
                continue;
            }

            if (!driverFeatures[feature]) {
                continue;
            }

            if (!deviceFeatures[feature]) {
                // Device doesn't support required feature
                return false;
            }

            var mask = 1 << features[feature];
            value |= mask;
        }

        this.io.GUEST_FEATURES.write32(value >>> 0);
        return true;
    };

    VirtioDevice.prototype.queueSetup = function(queueIndex) {
        this.io.QUEUE_SELECT.write16(queueIndex >>> 0);
        var size = this.io.QUEUE_SIZE.read16();
        var ring = new VRing(this.mem, this.nextRingOffset, size)
        this.nextRingOffset += ring.size;
        this.io.QUEUE_ADDRESS.write32(ring.address >>> 12);
        return ring;
    };

    VirtioDevice.prototype.queueNotify = function(queueIndex) {
        return this.io.QUEUE_NOTIFY.write16(queueIndex >>> 0);
    };

    var DEVICE_STATUS_RESET = 0;
    var DEVICE_STATUS_ACKNOWLEDGE = 1;
    var DEVICE_STATUS_DRIVER = 2;
    var DEVICE_STATUS_DRIVER_OK = 4;

    VirtioDevice.prototype.setDriverAck = function() {
        this.io.DEVICE_STATUS.write8(DEVICE_STATUS_ACKNOWLEDGE);
        this.io.DEVICE_STATUS.write8(DEVICE_STATUS_ACKNOWLEDGE | DEVICE_STATUS_DRIVER);
    };

    VirtioDevice.prototype.setDriverReady = function() {
        return this.io.DEVICE_STATUS.write8(DEVICE_STATUS_ACKNOWLEDGE |
            DEVICE_STATUS_DRIVER | DEVICE_STATUS_DRIVER_OK);
    };

    VirtioDevice.prototype.resetDevice = function() {
        return this.io.DEVICE_STATUS.write8(DEVICE_STATUS_RESET);
    };

    VirtioDevice.prototype.hasPendingIRQ = function() {
        return !!(1 & this.io.ISR_STATUS.read8());
    };

    // [network device]
    VirtioDevice.prototype.netReadHWAddress = function() {
        return [
            this.io.NETWORK_DEVICE_MAC0.read8(),
            this.io.NETWORK_DEVICE_MAC1.read8(),
            this.io.NETWORK_DEVICE_MAC2.read8(),
            this.io.NETWORK_DEVICE_MAC3.read8(),
            this.io.NETWORK_DEVICE_MAC4.read8(),
            this.io.NETWORK_DEVICE_MAC5.read8()
        ];
    };

    // [network device]
    VirtioDevice.prototype.netReadStatus = function() {
        return !!(1 & this.io.NETWORK_DEVICE_STATUS.read16());
    };

    return VirtioDevice;
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
    };

    var dev = new VirtioDevice('net', pci, allocator);
    dev.setDriverAck();

    var driverFeatures = {
        VIRTIO_NET_F_MAC: true,    // able to read MAC address
        VIRTIO_NET_F_STATUS: true, // able to check network status
    };

    var deviceFeatures = dev.readDeviceFeatures(features);
    if (!dev.writeGuestFeatures(features, driverFeatures, deviceFeatures)) {
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
            recvQueue.placeBuffers([{
                buf: new ArrayBuffer(1536),
                isWriteOnly: true
            }]);
        }

        dev.queueNotify(QUEUE_ID_RECV);
    }

    function networkInterfaceReady(ifc) {
        networkInterface = ifc;
        dev.setDriverReady();
        fillReceiveQueue();
        ifc.enable();
    }

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

            isolate.log('[virtio] TRANSMIT OK');
        }

        dat = null;
        for (;;) {
            dat = recvQueue.getBuffer();
            if (null === dat) {
                break;
            }

            isolate.log('[virtio] RECEIVE OK (' + dat.len + ' bytes)');
            if (networkInterface) {
                networkInterface.recv(dat.buf, dat.len, 0);
            }
        }

        fillReceiveQueue();
    });

    isolate.system.kernel.addNetworkInterface({
        hw: hwAddr,
        packetHeaderLength: virtioHeader.length,
        sendPacket: function(buf, offset, len) {
            virtioHeader.write(new DataView(buf));
            transmitQueue.placeBuffers([{buf: buf, isWriteOnly: false}]);
            dev.queueNotify(QUEUE_ID_TRANSMIT);
        },
    }).then(networkInterfaceReady);
}

// Virtio devices driver
(function() {
    "use strict";
    isolate.log('[virtio] driver started');

    var subsystemId = isolate.data.pci.subsystemData.subsystemId;
    var pci = isolate.data.pci;
    var allocator = isolate.data.allocator;

    switch (subsystemId) {
        case 1: // Network card
            initializeNetworkDevice(pci, allocator);
            break;
        default:
            throw new Error('unknown virtio device');
    }
})();
