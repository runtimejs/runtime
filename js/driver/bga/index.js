'use strict';

let buf = null;
const callbacks = [];

const driver = {
  init(device) {
    buf = device.bars[0].resource;
    for (const cb of callbacks) {
      cb();
    }
  },
  reset() {},
};

runtime.graphics.getDisplayBuffer = () => new Promise((resolve, reject) => {
  if (buf) {
    resolve(buf.buffer());
  } else {
    callbacks.push(() => {
      resolve(buf.buffer());
    });
  }
});
runtime.pci.addDriver(0x1234, 0x1111, driver);
