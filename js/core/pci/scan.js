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

/* eslint-disable key-spacing */
'use strict';

const resources = require('../resources');
const io = resources.ioRange;
const irqRange = resources.irqRange;
const memrange = resources.memoryRange;
const allocator = resources.allocator;
const acpiDevices = __SYSCALL.acpiGetPciDevices();
const addressPortResource = io.port(0xCF8);
const dataPortResource = io.port(0xCFC);

const sizeof = {
  BYTE: 1,
  UINT8: 1,
  UINT16: 2,
  UINT32: 4,
  UINT64: 8,
};

const pciAccessorFactory = ((addressPort, dataPort) => {
  const accessorCache = new Map();

  /**
   * Available PCI configuration space fields for all types
   * of devices
   */
  const fields = {
    VENDOR_ID: {
      offset: 0x00,
      shift: 0,
      mask: 0xffff,
    },
    DEVICE_ID: {
      offset: 0x00,
      shift: 2,
      mask: 0xffff,
    },

    COMMAND: {
      offset: 0x04,
      shift: 0,
      mask: 0xffff,
    },
    STATUS: {
      offset: 0x04,
      shift: 2,
      mask: 0xffff,
    },

    REVISION_ID: {
      offset: 0x08,
      shift: 0,
      mask: 0xff,
    },
    PROG_IF: {
      offset: 0x08,
      shift: 1,
      mask: 0xff,
    },
    SUBCLASS: {
      offset: 0x08,
      shift: 2,
      mask: 0xff,
    },
    CLASS_CODE: {
      offset: 0x08,
      shift: 3,
      mask: 0xff,
    },

    CACHE_LINESIZE: {
      offset: 0x0c,
      shift: 0,
      mask: 0xff,
    },
    LATENCY_TIMER: {
      offset: 0x0c,
      shift: 1,
      mask: 0xff,
    },
    HEADER_TYPE: {
      offset: 0x0c,
      shift: 2,
      mask: 0xff,
    },
    BIST: {
      offset: 0x0c,
      shift: 3,
      mask: 0xff,
    },
  };

  /**
   * Available PCI configuration space fields for general devices
   * (header type 0x00)
   */
  const generalFields = {
    BAR: [{
      offset: 0x10,
      shift: 0,
      mask: 0xffffffff,
    }, {
      offset: 0x14,
      shift: 0,
      mask: 0xffffffff,
    }, {
      offset: 0x18,
      shift: 0,
      mask: 0xffffffff,
    }, {
      offset: 0x1c,
      shift: 0,
      mask: 0xffffffff,
    }, {
      offset: 0x20,
      shift: 0,
      mask: 0xffffffff,
    }, {
      offset: 0x24,
      shift: 0,
      mask: 0xffffffff,
    }],

    SUBSYS_VENDOR: {
      offset: 0x2c,
      shift: 0,
      mask: 0xffff,
    },
    SUBSYS_ID: {
      offset: 0x2c,
      shift: 2,
      mask: 0xffff,
    },

    INTERRUPT_LINE: {
      offset: 0x3c,
      shift: 0,
      mask: 0xff,
    },
    INTERRUPT_PIN: {
      offset: 0x3c,
      shift: 1,
      mask: 0xff,
    },
  };

  /**
   * Available PCI configuration space fields for bridge devices
   * (header type 0x01 or 0x02)
   */
  const bridgeFields = {
    PRIMARY_BUS: {
      offset: 0x18,
      shift: 0,
      mask: 0xff,
    },
    SECONDARY_BUS: {
      offset: 0x18,
      shift: 1,
      mask: 0xff,
    },
    SUBORDINATE: {
      offset: 0x18,
      shift: 2,
      mask: 0xff,
    },
  };

  function setPort(bus, slot, func, offset) {
    const addr = ((bus << 16) | (slot << 11) | (func << 8) |
      (offset & 0xfc) | 0x80000000) >>> 0;
    addressPort.write32(addr);
  }

  function readRaw32(bus, slot, func, offset) {
    if (offset % sizeof.UINT32 !== 0) {
      throw new Error('unaligned pci space 32 bit read');
    }

    setPort(bus, slot, func, offset);
    return dataPort.read32();
  }

  function dwToFieldValue(value, field) {
    return ((value >>> (8 * sizeof.BYTE * field.shift)) & field.mask) >>> 0;
  } // eslint-disable-line max-len

  /**
   * Provides a way to read and write PCI Configuration space registers.
   * Uses internal cache to speed up reads of the same field. Address
   * includes bus, slot and func of a device.
   */
  class PciAccessor {
    constructor(address) {
      const bus = address.bus >>> 0;
      const slot = address.slot >>> 0;
      const func = address.func >>> 0;

      if (bus > 255) {
        throw new Error('invalid bus value (expected 0-255)');
      }
      if (slot > 31) {
        throw new Error('invalid slot value (expected 0-31)');
      }
      if (func > 7) {
        throw new Error('invalid func value (expected 0-7)');
      }

      const offsetCache = new Map();

      function writeRaw32(offset, value) {
        if (offset % sizeof.UINT32 !== 0) {
          throw new Error('unaligned pci space 32-bit write');
        }

        setPort(bus, slot, func, offset);
        return dataPort.write32(value >>> 0);
      }

      function writeRaw16(offset, value) {
        if (offset % sizeof.UINT16 !== 0) {
          throw new Error('unaligned pci space 16-bit write');
        }

        setPort(bus, slot, func, offset);
        return dataPort.write16((value & 0xffff) >>> 0);
      }

      function writeRaw8(offset, value) {
        setPort(bus, slot, func, offset);
        return dataPort.write8((value & 0xff) >>> 0);
      }

      /**
       * Read PCI configuration space field
       */
      this.read = (field) => {
        let value;

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
      this.write = (field, value) => {
        offsetCache.delete(field.offset);

        switch (field.mask) {
          case 0xffffffff:
            writeRaw32(field.offset, value);
            break;
          case 0xffff:
            writeRaw16(field.offset + field.shift, value);
            break;
          case 0xff:
            writeRaw8(field.offset + field.shift, value);
            break;
          default:
            throw new Error('invalid pci space field mask');
        }
      };

      /**
       * Set of methods to get available accessor fields
       */
      this.fields = () => fields;
      this.generalFields = () => generalFields;
      this.bridgeFields = () => bridgeFields;
    }
  }

  return {
    /**
     * Returns PCI accessor object for provided address
     */
    get(address) {
      const key = JSON.stringify([address.bus, address.slot, address.func]);
      if (accessorCache.has(key)) {
        return accessorCache.get(key);
      }

      const value = new PciAccessor(address);
      accessorCache.set(key, value);
      return value;
    },
    /**
     * Check if PCI device at address exists
     */
    exists(bus, slot, func) {
      const field = fields.VENDOR_ID;
      const value = readRaw32(bus, slot, func, field.offset);
      const vendorId = dwToFieldValue(value, field);
      return vendorId !== 0xffff;
    },
  };
})(addressPortResource, dataPortResource);

/**
 * Find ACPI PCI device bus, slot and function
 */
function locateAcpiDevice(dev) {
  if (!dev.isDevice()) {
    return null;
  }

  const addr = dev.address();
  const slotId = ((addr >>> 16) & 0xffff) >>> 0;
  const funcId = (addr & 0xffff) >>> 0;
  let busId = 0;

  if (dev.isRootBridge()) {
    busId = dev.getRootBridgeBusNumber();

    return {
      bus: busId,
      slot: slotId,
      func: funcId,
    };
  }

  const parentDev = dev.parent();
  if (parentDev === null) {
    return null;
  }

  if (!parentDev.isDevice()) {
    return null;
  }

  if (parentDev.isRootBridge()) {
    busId = parentDev.getRootBridgeBusNumber();

    return {
      bus: busId,
      slot: slotId,
      func: funcId,
    };
  }

  const parentLocation = locateAcpiDevice(parentDev);
  if (parentLocation === null) {
    return null;
  }

  const pciParent = pciAccessorFactory.get({
    bus: parentLocation.bus,
    slot: parentLocation.slot,
    func: parentLocation.func,
  });

  const header = pciParent.read(pciParent.fields().HEADER_TYPE);

  // Mask multifunction bit
  const headerType = (header & 0x7f) >>> 0;
  if (headerType !== 0x01 && headerType !== 0x02) {
    return null;
  }

  const bridgeBus = pciParent.read(pciParent.bridgeFields().SECONDARY_BUS);

  return {
    bus: bridgeBus,
    slot: slotId,
    func: funcId,
  };
}

/**
 * Provides enumeration services for the whole PCI configuration space
 */
const pciSpace = ((pciAccessorFactoryArg) => {
  function checkDevice(bus, slot, func, fn) {
    const addr = {
      bus,
      slot,
      func,
    };
    const pciAccessor = pciAccessorFactoryArg.get(addr);
    const vendorId = pciAccessor.read(pciAccessor.fields().VENDOR_ID);

    if (vendorId === 0xffff) {
      return;
    }

    fn(addr, pciAccessor);
  }

  function checkDeviceFunctions(bus, slot, fn) {
    let func = 0;
    const pciAccessor = pciAccessorFactoryArg.get({
      bus,
      slot,
      func,
    });
    const headerType = pciAccessor.read(pciAccessor.fields().HEADER_TYPE);
    const isMultifunc = (headerType & 0x80) >>> 0;
    const funcCount = isMultifunc ? 8 : 1;

    for (func = 0; func < funcCount; ++func) {
      checkDevice(bus, slot, func, fn);
    }
  }

  return {
    eachDevice(fn) {
      const func = 0;

      for (let bus = 0; bus < 255; ++bus) {
        for (let slot = 0; slot < 32; ++slot) {
          if (!pciAccessorFactoryArg.exists(bus, slot, func)) {
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
const codeNameResolver = (() => {
  const classCodes = [
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
    classCodeToName(code) {
      if (typeof classCodes[code] === 'undefined') {
        return classCodes[0];
      }
      return classCodes[code];
    },
  };
})();

/**
 * Represents PCI device of any type
 */
class PciDevice {
  constructor(address, pciAccessor) {
    this.pciAccessor = pciAccessor;
    const vendorId = pciAccessor.read(pciAccessor.fields().VENDOR_ID);
    const deviceId = pciAccessor.read(pciAccessor.fields().DEVICE_ID);
    const header = pciAccessor.read(pciAccessor.fields().HEADER_TYPE);
    let isBridge = false;

    const headerType = (header & 0x7f) >>> 0;
    if (headerType === 0x01 || headerType === 0x02) {
      isBridge = true;
    }

    const that = {
      acpiDevice: null,
    };

    let irqVector = null;

      /**
       * Attach ACPI PCI device handle to current PCI device
       */
    this.attachAcpiDevice = (acpiDevice) => {
      if (that.acpiDevice !== null) {
        return;
      }
      that.acpiDevice = acpiDevice;
    };

      /**
       * Get 16bit vendor ID of current device
       */
    this.vendorId = () => vendorId;

      /**
       * Get 16bit device ID of current device
       */
    this.deviceId = () => deviceId;

      /**
       * Check if current device is a PCI-to-PCI or PCI-to-CardBus
       * bridge
       */
    this.isBridge = () => isBridge;

      /**
       * Get PCI device address (bus, slot and function)
       */
    this.address = () => address;

      /**
       * Get bridge secondary bus number (bus number of current bridge)
       */
    this.getSecondaryBus = () => {
      if (!isBridge) {
        throw new Error('device is not a bridge');
      }
      return pciAccessor.read(pciAccessor.bridgeFields().SECONDARY_BUS);
    };

    this.setCommandFlag = (flag) => {
      let value = pciAccessor.read(pciAccessor.fields().COMMAND);
      value |= (1 << flag) >>> 0;
      pciAccessor.write(pciAccessor.fields().COMMAND, value);
    };

      /**
       * Get current device IRQ vector
       */
    this.getIRQVector = () => irqVector;

      /**
       * Set current device IRQ vector. May be called only once
       */
    this.setIRQVector = (vector) => {
      if (irqVector !== null) {
        throw new Error('IRQ vector already set');
      }
      irqVector = vector >>> 0;
    };

      /**
       * Get interrupt pin of current device
       */
    this.interruptPin = () => {
      if (isBridge) {
        throw new Error('device is a bridge');
      }
      return pciAccessor.read(pciAccessor.generalFields().INTERRUPT_PIN);
    };

      /**
       * Get the class data of current device (class code, subclass,
       * class name)
       */
    this.classData = () => {
      const classCode = pciAccessor.read(pciAccessor.fields().CLASS_CODE);
      return {
        classCode,
        className: pciAccessor.read(pciAccessor.fields().SUBCLASS),
        subclass: codeNameResolver.classCodeToName(classCode),
      };
    };

    this.subsystemData = () => {
      if (isBridge) {
        throw new Error('device is a bridge');
      }
      return {
        subsystemId: pciAccessor.read(pciAccessor.generalFields().SUBSYS_ID),
        subsystemVendor: pciAccessor.read(pciAccessor.generalFields().SUBSYS_VENDOR),
      };
    };

      /**
       * Read PCI base address register (BAR) and return resource type,
       * offset, size and object. Returns null is BAR is not valid
       */
    this.getBAR = (index) => {
      if (isBridge) {
        throw new Error('device is a bridge');
      }

      const indexValue = index >>> 0;
      if (indexValue > 5) {
        throw new Error('invalid BAR register index (expected 0-5)');
      }

      const barFlag = {
        BAR_IO: 0x01,
        BAR_64: 0x04,
      };

      const barField = pciAccessor.generalFields().BAR[indexValue];
      const barAddr = pciAccessor.read(barField);
      if (!barAddr) {
        return null;
      }

      pciAccessor.write(barField, 0xffffffff);
      const barSize = pciAccessor.read(barField);

        // Restore original value
      pciAccessor.write(barField, barAddr >>> 0);

      if (!barSize) {
        return null;
      }

      let base = 0;
      let size = 0;
      let barType = null;
      let obj = null;

      if (barAddr & barFlag.BAR_64) {
          // TODO: 64bit bar support
        barType = 'mem64';
      } else if (barAddr & barFlag.BAR_IO) {
          // TODO: verify io base & size
        base = ((barAddr & ~0x3) & 0xffff) >>> 0;
        size = ((~(barSize & ~0x3) + 1) & 0xffff) >>> 0;
        barType = 'io';
        if (size === 0) {
          return null;
        }

          // Base IO address 0 is probably an error, ignore it
        if (base === 0) {
          return null;
        }

        obj = io.subrange(base, (base + size) - 1);
      } else {
        base = (barAddr & 0xfffffff0) >>> 0;
        size = (((~(barSize & 0xfffffff0) >>> 0) + 1) & 0xffffffff) >>> 0;

        if (size === 0) {
          return null;
        }

        barType = 'mem32';
        obj = memrange.block(base, size);
      }

      if (barType === null || obj === null) {
        return null;
      }

      return {
        type: barType,
        base,
        size,
        resource: obj,
      };
    };
  }
    /**
     * PCI configuration space command register flags
     */
  static get commandFlags() {
    return {
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
  }
}

/**
 * Manages PCI devices
 */
const pciManager = (() => {
  const devicesMap = new Map();

  function addressHash(address) {
    return JSON.stringify([address.bus, address.slot, address.func]);
  }

  return {
    /**
     * Add new PCI device using its address (bus, slot and function) and
     * PCI configuration space accessor
     */
    addDevice(address, pciAccessor) {
      const key = addressHash(address);
      if (devicesMap.has(key)) throw new Error(`device on the same address already exists ${JSON.stringify(address)}`); // eslint-disable-line max-len
      devicesMap.set(key, new PciDevice(address, pciAccessor));
    },
    /**
     * Search for an existing device by its address
     */
    findDevice(address) {
      const key = addressHash(address);
      if (!devicesMap.has(key)) {
        return null;
      }
      return devicesMap.get(key);
    },
    /**
     * Iterates over all devices
     */
    each: (fn) => devicesMap.forEach(fn),
  };
})();

// Enumerate configuration space and create PCI devices
pciSpace.eachDevice(pciManager.addDevice);

// Collect bus ACPI device handles with their bus numbers
const acpiDevicesBuses = [];
acpiDevices.forEach((acpiDevice) => {
  const address = locateAcpiDevice(acpiDevice);
  let busId = 0;

  if (acpiDevice.isRootBridge()) {
    busId = acpiDevice.getRootBridgeBusNumber();
    acpiDevicesBuses[busId] = acpiDevice;
  }

  // Check if unable to locate ACPI device on PCI bus
  if (address === null) {
    return;
  }

  const dev = pciManager.findDevice(address);

  // Check if unable to find device described in ACPI tables
  if (dev === null) {
    return;
  }

  dev.attachAcpiDevice(acpiDevice);

  if (dev.isBridge()) {
    busId = dev.getSecondaryBus();
    acpiDevicesBuses[busId] = acpiDevice;
  }
});

// Extract IRQ routing information
const busRouting = [];
acpiDevicesBuses.forEach((acpiDevice, bus) => {
  if (typeof acpiDevice === 'undefined') {
    return;
  }

  const routes = acpiDevice.getIrqRoutingTable();
  if (!Array.isArray(routes)) {
    return;
  }

  busRouting[bus] = routes;
});

// Set IRQs
pciManager.each((pciDevice) => {
  const address = pciDevice.address();

  // Skip bridges for now
  if (pciDevice.isBridge()) {
    return;
  }

  if (typeof busRouting[address.bus] === 'undefined') {
    return;
  } // No ACPI routing for this current device bridge

  const routing = busRouting[address.bus];
  const devicePin = pciDevice.interruptPin();
  let deviceIRQ = null;

  // Check if this device does not use an IRQ pin
  if (devicePin === 0) {
    return;
  }

  routing.forEach((route) => {
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

  if (deviceIRQ !== null) {
    pciDevice.setIRQVector(deviceIRQ);
  }
});

// Start drivers
pciManager.each((pciDevice) => {
  // const vendorId = pciDevice.vendorId();
  // const deviceId = pciDevice.deviceId();
  const driverData = null;

  if (driverData === null || typeof driverData.driver === 'undefined' || !driverData.enabled) {
    return;
  } // eslint-disable-line max-len

  const irqVector = pciDevice.getIRQVector();
  let irqObject = null;
  if (irqVector !== null) {
    irqObject = irqRange.irq(irqVector);
  }

  const argsBars = [];
  for (let i = 0; i < 6; ++i) {
    const bar = pciDevice.getBAR(i);
    let barData = null;

    if (bar !== null) {
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

  const driverArgs = {
    pci: {
      bars: argsBars,
      irq: irqObject,
      classData: pciDevice.classData(),
      subsystemData: pciDevice.subsystemData(),
    },
    allocator,
  };

  require(`driver/${driverData.driver}`)(driverArgs);

  // Debug
  /*
  isolate.log(JSON.stringify(driverData), JSON.stringify(argsBars));

  vfs.getInitrdRoot()({
    action: 'spawn',
    path: '/driver/' + driverData.driver,
    data: driverArgs,
    env: {}
  }).then(() => {}, function(err) {
    isolate.log(err);
  });
  */
});

// Print PCI devices debug info
pciManager.each((pciDevice) => {
  const address = pciDevice.address();
  const vector = pciDevice.getIRQVector();
  const classData = pciDevice.classData();

  let devicePin = 0;
  if (!pciDevice.isBridge()) {
    devicePin = pciDevice.interruptPin();
  }

  const pins = ['dont use', 'A', 'B', 'C', 'D'];

  const info = `${address.bus.toString(16)}: ${address.slot.toString(16)}.${address.func} ${pciDevice.vendorId().toString(16)}: ${pciDevice.deviceId().toString(16)} ${classData.className} IRQ: ${vector} PIN: ${pins[devicePin]}`;
  debug(info);
});

function listPciDevices() {
  const results = [];

  pciManager.each((pciDevice) => {
    if (pciDevice.isBridge()) {
      return;
    }

    const address = pciDevice.address();
    const irqVector = pciDevice.getIRQVector();
    const classData = pciDevice.classData();
    const subsystemData = pciDevice.subsystemData();

    let devicePin = 0;
    if (!pciDevice.isBridge()) {
      devicePin = pciDevice.interruptPin();
    }

    let irqObject = null;
    if (irqVector !== null) {
      irqObject = irqRange.irq(irqVector);
    }

    const bars = [];
    for (let i = 0; i < 6; ++i) {
      const bar = pciDevice.getBAR(i);
      let barData = null;

      if (bar !== null) {
        barData = {
          type: bar.type,
          resource: bar.resource,
        };
      }

      bars.push(barData);
    }

    const pins = [null, 'A', 'B', 'C', 'D'];

    results.push({
      bus: address.bus,
      slot: address.slot,
      func: address.func,
      vendorId: pciDevice.vendorId(),
      deviceId: pciDevice.deviceId(),
      className: classData.className,
      subsystemData,
      irqVector,
      pin: pins[devicePin],
      pciAccessor: pciDevice.pciAccessor,
      irq: irqObject,
      bars,
    });
  });

  return results;
}

module.exports = listPciDevices;
