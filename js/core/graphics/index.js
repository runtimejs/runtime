'use strict';

const { ioPort } = require('../driver-utils');
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

module.exports = {
  graphicsAvailable() {
    const bgaVersion = readBgaRegister(constants.VBE_DISPI_INDEX_ID);
    for (const i of [0, 1, 2, 3, 4, 5]) {
      if (bgaVersion === constants[`VBE_DISPI_ID${i}`]) {
        return true;
      }
    }
    return false;
  },
  enableGraphics(width, height, bitDepth) {
    writeBgaRegister(constants.VBE_DISPI_INDEX_ENABLE, constants.VBE_DISPI_DISABLED);
    writeBgaRegister(constants.VBE_DISPI_INDEX_XRES, width);
    writeBgaRegister(constants.VBE_DISPI_INDEX_YRES, height);
    writeBgaRegister(constants.VBE_DISPI_INDEX_BPP, bitDepth);
    writeBgaRegister(constants.VBE_DISPI_INDEX_ENABLE, constants.VBE_DISPI_ENABLED | constants.VBE_DISPI_LFB_ENABLED);
  },
  disableGraphics() {
    writeBgaRegister(constants.VBE_DISPI_INDEX_ENABLE, constants.VBE_DISPI_DISABLED);
  },
  constants,
};
