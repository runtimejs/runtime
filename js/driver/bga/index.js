'use strict';

const { ioPort } = require('../../core/driver-utils');
const constants = require('./constants');
const vbe_dispi_ioport_index = ioPort(constants.VBE_DISPI_IOPORT_INDEX);
const vbe_dispi_ioport_data = ioPort(constants.VBE_DISPI_IOPORT_DATA);

function writeBgaRegister(index, data) {
  vbe_dispi_ioport_index.write16(index >>> 0);
  vbe_dispi_ioport_data.write16(data >>> 0);
}
function readBgaRegister(index) {
  vbe_dispi_ioport_index.write16(index >>> 0);
  return vbe_dispi_ioport_data.read16();
}
function bgaAvailable() {
  const bgaVersion = readBgaRegister(constants.VBE_DISPI_INDEX_ID);
  for (const i of [0, 1, 2, 3, 4, 5]) {
    if (bgaVersion === constants[`VBE_DISPI_ID${i}`]) {
      return true;
    }
  }
  return false;
}

const driver = {
  init(device) {
    const buf = new Uint8Array(device.bars[0].resource.buffer());
    const renderer = new runtime.graphics.GraphicsRenderer('bga');
    renderer.onenablegraphics = (width, height, bitDepth) => {
      writeBgaRegister(constants.VBE_DISPI_INDEX_ENABLE, constants.VBE_DISPI_DISABLED);
      writeBgaRegister(constants.VBE_DISPI_INDEX_XRES, width);
      writeBgaRegister(constants.VBE_DISPI_INDEX_YRES, height);
      writeBgaRegister(constants.VBE_DISPI_INDEX_BPP, bitDepth);
      writeBgaRegister(constants.VBE_DISPI_INDEX_ENABLE, constants.VBE_DISPI_ENABLED | constants.VBE_DISPI_LFB_ENABLED);
    };
    renderer.ongetpixel = (x, y) => {
      const where = ((y * runtime.graphics.screen.width) + x) * (runtime.graphics.screen.bitDepth / 8);
      return {
        get r() {
          return buf[where + 2];
        },
        get g() {
          return buf[where + 1];
        },
        get b() {
          return buf[where];
        },
        set r(val) {
          buf[where + 2] = val;
        },
        set g(val) {
          buf[where + 1] = val;
        },
        set b(val) {
          buf[where] = val;
        },
      };
    };
    renderer.constants = constants;
    runtime.graphics.addRenderer(renderer);
  },
  reset() {},
};

runtime.pci.addDriver(0x1234, 0x1111, driver);
