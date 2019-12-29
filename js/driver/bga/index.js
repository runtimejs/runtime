'use strict';

const { ioPort } = require('../../core/driver-utils');
const constants = require('./constants');
const vbeDispiIoportIndex = ioPort(constants.VBE_DISPI_IOPORT_INDEX);
const vbeDispiIoportData = ioPort(constants.VBE_DISPI_IOPORT_DATA);

function writeBgaRegister(index, data) {
  vbeDispiIoportIndex.write16(index >>> 0);
  vbeDispiIoportData.write16(data >>> 0);
}
function readBgaRegister(index) {
  vbeDispiIoportIndex.write16(index >>> 0);
  return vbeDispiIoportData.read16();
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

if (bgaAvailable()) {
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
      renderer.ongetbuffer = () => buf;
      renderer.constants = constants;
      runtime.graphics.addRenderer(renderer);
    },
    reset() {},
  };

  runtime.pci.addDriver(0x1234, 0x1111, driver);
}
