// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

(function(args) {
    "use strict";

    var pciDrivers = rt.initrdRequire("/driver/pci-drivers.js");
    var resources = args.resources;
    var acpi = resources.acpi;
    var io = resources.ioRange;
    var irqRange = resources.irqRange;
    var procManager = resources.processManager;
    var memrange = resources.memoryRange;
    var allocator = resources.allocator;

    var pciDriverInterface = rt.interface({
        methods: {
            allocDMA: function() {
                return allocator.allocDMA();
            },
        },
    });

    var acpiDevices = acpi.getPciDevices();

    var address_port = io.port(0xCF8);
    var data_port = io.port(0xCFC);

    var sizeof = {
        BYTE: 1,
        UINT8: 1,
        UINT16: 2,
        UINT32: 4,
        UINT64: 8,
    };

    var pciAccessorFactory = (function(address_port, data_port) {
        var accessorCache = new Map();

        /**
         * Available PCI configuration space fields for all types
         * of devices
         */
        var fields = {
            VENDOR_ID:      {offset: 0x00, shift: 0, mask: 0xffff},
            DEVICE_ID:      {offset: 0x00, shift: 2, mask: 0xffff},

            COMMAND:        {offset: 0x04, shift: 0, mask: 0xffff},
            STATUS:         {offset: 0x04, shift: 2, mask: 0xffff},

            REVISION_ID:    {offset: 0x08, shift: 0, mask: 0xff},
            PROG_IF:        {offset: 0x08, shift: 1, mask: 0xff},
            SUBCLASS:       {offset: 0x08, shift: 2, mask: 0xff},
            CLASS_CODE:     {offset: 0x08, shift: 3, mask: 0xff},

            CACHE_LINESIZE: {offset: 0x0c, shift: 0, mask: 0xff},
            LATENCY_TIMER:  {offset: 0x0c, shift: 1, mask: 0xff},
            HEADER_TYPE:    {offset: 0x0c, shift: 2, mask: 0xff},
            BIST:           {offset: 0x0c, shift: 3, mask: 0xff},
        };

        /**
         * Available PCI configuration space fields for general devices
         * (header type 0x00)
         */
        var generalFields = {
            BAR:           [{offset: 0x10, shift: 0, mask: 0xffffffff},
                            {offset: 0x14, shift: 0, mask: 0xffffffff},
                            {offset: 0x18, shift: 0, mask: 0xffffffff},
                            {offset: 0x1c, shift: 0, mask: 0xffffffff},
                            {offset: 0x20, shift: 0, mask: 0xffffffff},
                            {offset: 0x24, shift: 0, mask: 0xffffffff}],

            INTERRUPT_LINE: {offset: 0x3c, shift: 0, mask: 0xff},
            INTERRUPT_PIN:  {offset: 0x3c, shift: 1, mask: 0xff},
        };

        /**
         * Available PCI configuration space fields for bridge devices
         * (header type 0x01 or 0x02)
         */
        var bridgeFields = {
            PRIMARY_BUS:    {offset: 0x18, shift: 0, mask: 0xff},
            SECONDARY_BUS:  {offset: 0x18, shift: 1, mask: 0xff},
            SUBORDINATE:    {offset: 0x18, shift: 2, mask: 0xff},
        };

        function setPort(bus, slot, func, offset) {
            var addr = (bus << 16) | (slot << 11) | (func << 8) |
                (offset & 0xfc) | 0x80000000;
            address_port.write32(addr);
        }

        function readRaw32(bus, slot, func, offset) {
            if (offset % sizeof.UINT32 !== 0) {
                throw new Error('unaligned pci space 32 bit read');
            }

            setPort(bus, slot, func, offset);
            return data_port.read32();
        }

        function dwToFieldValue(value, field) {
            return ((value >>> (8 * sizeof.BYTE * field.shift)) &
                    field.mask) >>> 0;
        }

        /**
         * Provides a way to read and write PCI Configuration space registers.
         * Uses internal cache to speed up reads of the same field. Address 
         * includes bus, slot and func of a device.
         */
        function PciAccessor(address) {
            var bus = address.bus >>> 0,
                slot = address.slot >>> 0,
                func = address.func >>> 0;

            if (bus > 255) {
                throw new Error('invalid bus value (expected 0-255)');
            }

            if (slot > 31) {
                throw new Error('invalid slot value (expected 0-31)');
            }

            if (func > 7) {
                throw new Error('invalid func value (expected 0-7)');
            }

            var offsetCache = new Map();

            function writeRaw32(offset, value) {
                if (offset % sizeof.UINT32 !== 0) {
                    throw new Error('unaligned pci space 32-bit write');
                }

                setPort(bus, slot, func, offset);
                return data_port.write32(value >>> 0);
            }

            function writeRaw16(offset, value) {
                if (offset % sizeof.UINT16 !== 0) {
                    throw new Error('unaligned pci space 16-bit write');
                }

                setPort(bus, slot, func, offset);
                return data_port.write16((value & 0xffff) >>> 0);
            }

            function writeRaw8(offset, value) {
                setPort(bus, slot, func, offset);
                return data_port.write8((value & 0xff) >>> 0);
            }

            /**
             * Read PCI configuration space field
             */
            this.read = function __read(field) {
                var value;

                if (offsetCache.has(field.offset)) {
                    value = offsetCache.get(field.offset);
                } else {
                    value = readRaw32(bus, slot, func, field.offset);
                    offsetCache.set(field.offset, value);
                }

                return dwToFieldValue(value, field);
            };

            /**
             * Write PCI configuration space field
             */
            this.write = function __write(field, value) {
                offsetCache.delete(field.offset);

                switch (field.mask) {
                    case 0xffffffff: writeRaw32(field.offset, value); break;
                    case 0xffff: writeRaw16(field.offset + field.shift, value); break;
                    case 0xff: writeRaw8(field.offset + field.shift, value); break;
                    default:
                        throw new Error('invalid pci space field mask');
                }
            };

            /**
             * Set of methods to get available accessor fields
             */
            this.fields = function __fields() { return fields; }
            this.generalFields = function __generalFields() { return generalFields; }
            this.bridgeFields = function __bridgeFields() { return bridgeFields; }
        }

        return {
            /**
             * Returns PCI accessor object for provided address
             */
            get: function __get(address) {
                var key = JSON.stringify([address.bus, address.slot, address.func]);
                if (accessorCache.has(key)) {
                    return accessorCache.get(key);
                }

                var value = new PciAccessor(address);
                accessorCache.set(key, value);
                return value;
            },
            /**
             * Check if PCI device at address exists
             */
            exists: function __exists(bus, slot, func) {
                var field = fields.VENDOR_ID;
                var value = readRaw32(bus, slot, func, field.offset);
                var vendor_id = dwToFieldValue(value, field);
                return 0xffff !== vendor_id;
            },
        };
    })(address_port, data_port);

    /**
     * Find ACPI PCI device bus, slot and function
     */
    function locateAcpiDevice(dev) {
        if (!dev.isDevice()) {
            return null;
        }

        var addr = dev.address();
        var slotId = ((addr >>> 16) & 0xffff) >>> 0;
        var funcId = (addr & 0xffff) >>> 0;

        if (dev.isRootBridge()) {
            var busId = dev.getRootBridgeBusNumber();

            return {
                bus: busId,
                slot: slotId,
                func: funcId,
            };
        }

        var parentDev = dev.parent();
        if (null === parentDev) {
            return null;
        }

        if (!parentDev.isDevice()) {
            return null;
        }

        if (parentDev.isRootBridge()) {
            var busId = parentDev.getRootBridgeBusNumber();

            return {
                bus: busId,
                slot: slotId,
                func: funcId,
            };
        }

        var parentLocation = locateAcpiDevice(parentDev);
        if (null === parentLocation) {
            return null;
        }

        var pciParent = pciAccessorFactory.get({
            bus: parentLocation.bus,
            slot: parentLocation.slot,
            func: parentLocation.func,
        });

        var header = pciParent.read(pciParent.fields().HEADER_TYPE);

        // Mask multifunction bit
        var headerType = (header & 0x7f) >>> 0;
        if (0x01 !== headerType && 0x02 !== headerType) {
            return null;
        }

        var bridgeBus = pciParent.read(pciParent.bridgeFields().SECONDARY_BUS);

        return {
            bus: bridgeBus,
            slot: slotId,
            func: funcId,
        };
    }

    /**
     * Provides enumeration services for the whole PCI configuration space
     */
    var pciSpace = (function(pciAccessorFactory) {
        function checkDevice(bus, slot, func, fn) {
            var addr = {bus: bus, slot:slot, func: func};
            var pciAccessor = pciAccessorFactory.get(addr);
            var vendorId = pciAccessor.read(pciAccessor.fields().VENDOR_ID);

            if (0xffff === vendorId) {
                return;
            }

            fn(addr, pciAccessor);
        }

        function checkDeviceFunctions(bus, slot, fn) {
            var func = 0;
            var pciAccessor = pciAccessorFactory.get({bus: bus, slot:slot, func: func});
            var headerType = pciAccessor.read(pciAccessor.fields().HEADER_TYPE);
            var isMultifunc = (headerType & 0x80) >>> 0;
            var funcCount = isMultifunc ? 8 : 1;

            for (func = 0; func < funcCount; ++func) {
                checkDevice(bus, slot, func, fn);
            }
        }

        return {
            eachDevice: function(fn) {
                var func = 0;

                for (var bus = 0; bus < 255; ++bus) {
                    for (var slot = 0; slot < 32; ++slot) {

                        if (!pciAccessorFactory.exists(bus, slot, func)) {
                            continue;
                        }

                        checkDeviceFunctions(bus, slot, fn);
                    }
                }
            },
        };
    })(pciAccessorFactory);

    /**
     * Service for converting PCI data codes to readable names
     */
    var codeNameResolver = (function() {
        var classCodes = [
            'Unclassified',
            'Mass Storage Controller',
            'Network Controller',
            'Display Controller',
            'Multimedia Controller',
            'Memory Controller',
            'Bridge Device',
            'Simple Communication Controller',
            'Base System Peripheral',
            'Input Device',
            'Docking Station',
            'Processor',
            'Serial Bus Controller',
            'Wireless Controller',
            'Intelligent I/O Controller',
            'Satellite Communication Controller',
            'Encryption/Decryption Controller',
            'Data Acquisition and Signal Processing Controller',
        ];

        return {
            /**
             * Get name for provided PCI device class code
             */
            classCodeToName: function(code) {
                if ('undefined' === typeof classCodes[code]) {
                    return classCodes[0];
                }

                return classCodes[code];
            },
        };
    })();

    /**
     * Represents PCI device of any type
     */
    function PciDevice(address, pciAccessor) {
        var vendorId = pciAccessor.read(pciAccessor.fields().VENDOR_ID);
        var deviceId = pciAccessor.read(pciAccessor.fields().DEVICE_ID);
        var header = pciAccessor.read(pciAccessor.fields().HEADER_TYPE);
        var isBridge = false;
        
        var headerType = (header & 0x7f) >>> 0;
        if (0x01 === headerType || 0x02 === headerType) {
            isBridge = true;
        }

        var that = {
            acpiDevice: null,
        };

        var irqVector = null;

        /**
         * Attach ACPI PCI device handle to current PCI device
         */
        this.attachAcpiDevice = function __attachAcpiDevice(acpiDevice) {
            if (null !== that.acpiDevice) {
                return;
            }

            that.acpiDevice = acpiDevice;
        };

        /**
         * Get 16bit vendor ID of current device
         */
        this.vendorId = function __vendorId() { return vendorId; };

        /**
         * Get 16bit device ID of current device
         */
        this.deviceId = function __deviceId() { return deviceId; };

        /**
         * Check if current device is a PCI-to-PCI or PCI-to-CardBus
         * bridge
         */
        this.isBridge = function __isBridge() { return isBridge; };

        /**
         * Get PCI device address (bus, slot and function)
         */
        this.address = function __address() { return address; };

        /**
         * Get bridge secondary bus number (bus number of current bridge)
         */
        this.getSecondaryBus = function __getSecondaryBus() {
            if (!isBridge) {
                throw new Error('device is not a bridge');
            }

            return pciAccessor.read(pciAccessor.bridgeFields().SECONDARY_BUS);
        };

        this.setCommandFlag = function __setCommandFlag(flag) {
            var value = pciAccessor.read(pciAccessor.fields().COMMAND);
            value |= (1 << flag) >>> 0;
            pciAccessor.write(pciAccessor.fields().COMMAND, value);
        };

        /**
         * Get current device IRQ vector
         */
        this.getIRQVector = function __getIRQVector(vector) {
            return irqVector;
        };

        /**
         * Set current device IRQ vector. May be called only once
         */
        this.setIRQVector = function __setIRQVector(vector) {
            if (null !== irqVector) {
                throw new Error('IRQ vector already set');
            }

            irqVector = vector >>> 0;
        };

        /**
         * Get interrupt pin of current device
         */
        this.interruptPin = function __interruptPin() {
            if (isBridge) {
                throw new Error('device is a bridge');
            }

            return pciAccessor.read(pciAccessor.generalFields().INTERRUPT_PIN);
        };

        /**
         * Get the class data of current device (class code, subclass,
         * class name)
         */
        this.classData = function __classData() {
            var classCode = pciAccessor.read(pciAccessor.fields().CLASS_CODE);
            var subclass = pciAccessor.read(pciAccessor.fields().SUBCLASS);
            var className = codeNameResolver.classCodeToName(classCode);

            return {
                classCode: classCode,
                className: className,
                subclass: subclass,
            };
        };

        /**
         * Read PCI base address register (BAR) and return resource type,
         * offset, size and object. Returns null is BAR is not valid
         */
        this.getBAR = function __getBAR(index) {
            if (isBridge) {
                throw new Error('device is a bridge');
            }

            var indexValue = index >>> 0;
            if (indexValue > 5) {
                throw new Error('invalid BAR register index (expected 0-5)');
            }

            var barFlag = {
                BAR_IO: 0x01,
                BAR_64: 0x04,
            };

            var barField = pciAccessor.generalFields().BAR[indexValue];
            var barAddr = pciAccessor.read(barField);
            if (!barAddr) {
                return null;
            }

            pciAccessor.write(barField, 0xffffffff);
            var barSize = pciAccessor.read(barField);

            // Restore original value
            pciAccessor.write(barField, barAddr >>> 0);

            if (!barSize) {
                return null;
            }

            var base = 0;
            var size = 0;
            var barType = null;
            var obj = null;

            if (barAddr & barFlag.BAR_64) {
                // TODO: 64bit bar support
                barType = 'mem64';

            } else if (barAddr & barFlag.BAR_IO) {
                // TODO: verify io base & size
                base = ((barAddr & ~0x3) & 0xffff) >>> 0;
                size = ((~(barSize & ~0x3) + 1) & 0xffff) >>> 0;
                barType = 'io';
                if (0 === size) {
                    return null;
                }

                obj = io.subrange(base, base + size - 1);
            } else {
                base = (barAddr & 0xfffffff0) >>> 0;
                size = (((~(barSize & 0xfffffff0) >>> 0) + 1) & 0xffffffff) >>> 0;

                if (0 === size) {
                    return null;
                }

                barType = 'mem32';
                obj = memrange.block(base, size);
            }

            if (null === barType || null === obj) {
                return null;
            }

            return {
                type: barType,
                base: base,
                size: size,
                resource: obj,
            };
        };
    }

    /**
     * PCI configuration space command register flags
     */
    PciDevice.commandFlags = {
        IOSpace: 0,
        MemorySpace: 1,
        BusMaster: 2,
        SpecialCycles: 3,
        MemoryWriteInvalidate: 4,
        VGAPaletteSnoop: 5,
        ParityError: 6,
        SERR: 8,
        BackToBack: 9,
        InterruptDisable: 10,
    };

    /**
     * Manages PCI devices
     */
    var pciManager = (function() {
        var devicesMap = new Map();

        function addressHash(address) {
            return JSON.stringify([address.bus, address.slot, address.func]);
        }

        function findDevice(address) {
            var key = addressHash(address);

            if (!devicesMap.has(key)) {
                return null;
            }

            return devicesMap.get(key);
        }

        return {
            /**
             * Add new PCI device using its address (bus, slot and function) and 
             * PCI configuration space accessor
             */
            addDevice: function(address, pciAccessor) {
                var key = addressHash(address);

                if (devicesMap.has(key)) {
                    throw new Error('device on the same address already exists' +
                        JSON.stringify(address));
                }

                devicesMap.set(key, new PciDevice(address, pciAccessor));
            },
            /**
             * Search for an existing device by its address
             */
            findDevice: findDevice,
            /**
             * Iterates over all devices
             */
            each: function(fn) {
                devicesMap.forEach(function(pciDevice) {
                    fn(pciDevice);
                });
            },
        };
    })();

    // Enumerate configuration space and create PCI devices
    pciSpace.eachDevice(function(address, pciAccessor) {
        pciManager.addDevice(address, pciAccessor);
    });

    // Collect bus ACPI device handles with their bus numbers
    var acpiDevicesBuses = [];
    acpiDevices.forEach(function(acpiDevice) {
        var address = locateAcpiDevice(acpiDevice);

        if (acpiDevice.isRootBridge()) {
            var busId = acpiDevice.getRootBridgeBusNumber();
            acpiDevicesBuses[busId] = acpiDevice;
        }

        // Check if unable to locate ACPI device on PCI bus
        if (null === address) {
            return;
        }

        var dev = pciManager.findDevice(address);

        // Check if unable to find device described in ACPI tables
        if (null === dev) {
            return;
        }

        dev.attachAcpiDevice(acpiDevice);

        if (dev.isBridge()) {
            var busId = dev.getSecondaryBus();
            acpiDevicesBuses[busId] = acpiDevice;
        }
    });

    // Extract IRQ routing information
    var busRouting = [];
    acpiDevicesBuses.forEach(function(acpiDevice, bus) {
        if ('undefined' === typeof acpiDevice) {
            return;
        }

        var routes = acpiDevice.getIrqRoutingTable();
        if (!Array.isArray(routes)) {
            return;
        }

        busRouting[bus] = routes;
    });

    // Set IRQs
    pciManager.each(function(pciDevice) {
        var address = pciDevice.address();

        // Skip bridges for now
        if (pciDevice.isBridge()) {
            return;
        }

        if ('undefined' === typeof busRouting[address.bus]) {
            // No ACPI routing for this current device bridge
            return;
        }

        var routing = busRouting[address.bus];
        var devicePin = pciDevice.interruptPin();
        var deviceIRQ = null;

        // Check if this device does not use an IRQ pin
        if (0 === devicePin) {
            return;
        }

        routing.forEach(function(route) {
            if (address.slot !== route.deviceId) {
                return;
            }

            // Plus 1 because routing data returns 0-base pin
            // numbers (0-A, 1-B, 2-C, 3-D)
            // PCI configuration space returns pins in format
            // (0-don't use, 1-A, 2-B, 3-C, 4-D)
            if (devicePin !== route.pin + 1) {
                return;
            }

            deviceIRQ = route.irq;
        });

        if (null !== deviceIRQ) {
            pciDevice.setIRQVector(deviceIRQ);
        }
    });

    // Start drivers
    pciManager.each(function(pciDevice) {
        var vendorId = pciDevice.vendorId();
        var deviceId = pciDevice.deviceId();
        var driverData = pciDrivers.findDevice(vendorId, deviceId);

        if (null === driverData || 'undefined' === typeof driverData.driver) {
            return;
        }

        var irqVector = pciDevice.getIRQVector();
        var irqObject = null;
        if (null !== irqVector) {
            irqObject = irqRange.irq(irqVector);
        }

        var argsBars = [];
        for (var i = 0; i < 6; ++i) {
            var bar = pciDevice.getBAR(i);
            var barData = null;

            if (null !== bar) {
                barData = {
                    type: bar.type,
                    resource: bar.resource,
                };
            }

            argsBars.push(barData);
        }

        if (driverData.busMaster) {
            pciDevice.setCommandFlag(PciDevice.commandFlags.BusMaster);
            pciDevice.setCommandFlag(PciDevice.commandFlags.MemorySpace);
        }

        var driverArgs = {
            pci: {
                bars: argsBars,
                irq: irqObject,
            },
            allocator: allocator,
        }

        procManager.create(rt.initrdText("/driver/" + driverData.driver),
            driverArgs);

        // Temporary for debugging
        return; 
        rt.log(JSON.stringify(driverData), JSON.stringify(argsBars));
    });

    // Print devices info, use for debugging
    /*
    pciManager.each(function(pciDevice) {
        var address = pciDevice.address();
        var vector = pciDevice.getIRQVector();
        var classData = pciDevice.classData();

        var devicePin = 0;
        if (!pciDevice.isBridge()) {
            devicePin = pciDevice.interruptPin();
        }

        var pins = ['dont use', 'A', 'B', 'C', 'D'];

        var info = address.bus.toString(16) + ':' + address.slot.toString(16) + '.' + address.func + ' ' +
            pciDevice.vendorId().toString(16) + ':' + pciDevice.deviceId().toString(16) + ' ' +
            classData.className + ' IRQ: ' + vector + ' PIN: ' + pins[devicePin];
        rt.log(info);
    });
    */

})(rt.args());
