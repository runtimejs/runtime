// Copyright 2016-present runtime.js project authors
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

// Some code modified and adapted for use by runtime.js from http://forum.osdev.org/viewtopic.php?t=10247

'use strict';

const runtime = require('../../core');

const flags = {
  middle: false,
  right: false,
  left: false,
};

function splitByte(byte) {
  const ret = [];
  for (let i = 7; i >= 0; i--) ret.push(byte & (1 << i) ? 1 : 0);
  return ret;
}

function processPacket(packet) {
  const split = splitByte(packet[0]);
  const info = {
    yOverflow: split[0],
    xOverflow: split[1],
    ySign: split[2],
    xSign: split[3],
    alwaysOne: split[4],
    buttons: {
      middle: split[5],
      right: split[6],
      left: split[7],
    },
    xOffset: packet[1],
    yOffset: packet[2],
  };

  // just a sanity check:
  if (info.alwaysOne !== 1) return; // something's wrong with this packet

  if (flags.middle && info.buttons.middle === 0) {
    flags.middle = false;
    setImmediate(() => {
      runtime.mouse.onMouseup.dispatch(1);
    });
  } else if (!flags.middle && info.buttons.middle === 1) {
    flags.middle = true;
    setImmediate(() => {
      runtime.mouse.onMousedown.dispatch(1);
    });
  } else if (flags.right && info.buttons.right === 0) {
    flags.right = false;
    setImmediate(() => {
      runtime.mouse.onMouseup.dispatch(2);
    });
  } else if (!flags.right && info.buttons.right === 1) {
    flags.right = true;
    setImmediate(() => {
      runtime.mouse.onMousedown.dispatch(2);
    });
  } else if (flags.left && info.buttons.left === 0) {
    flags.left = false;
    setImmediate(() => {
      runtime.mouse.onMouseup.dispatch(0);
    });
  } else if (!flags.left && info.buttons.left === 1) {
    flags.left = true;
    setImmediate(() => {
      runtime.mouse.onMousedown.dispatch(0);
    });
  }

  if (info.xOffset !== 0 || info.yOffset !== 0) {
    setImmediate(() => {
      runtime.mouse.onMousemove.dispatch({
        x: (info.xSign) ? (info.xOffset | 0xffffff00) : info.xOffset,
        y: (info.ySign) ? (info.yOffset | 0xffffff00) : info.yOffset,
      });
    });
  }
}

const driver = {
  init(device) {
    const irq = device.irq;
    const [mainPort, port64] = device.ioPorts;

    function mouseWait(type) {
      return new Promise((outerResolve, outerReject) => {
        let maxIter = 1500;
        function loop() {
          return new Promise((resolve, reject) => {
            if (maxIter === 0) return resolve();
            if (type === 0) {
              if ((port64.read8() & 1) === 1) {
                return resolve();
              }
            } else {
              if ((port64.read8() & 2) === 0) {
                return resolve();
              }
            }
            maxIter--;
            setImmediate(() => {
              loop().then(resolve).catch(reject);
            });
          });
        }
        setImmediate(() => {
          loop().then(outerResolve).catch(outerReject);
        });
      });
    }

    function mouseWrite(data) {
      return mouseWait(1).then(() => {
        port64.write8(0xd4);
        return mouseWait(1);
      })
      .then(() => { mainPort.write8(data); });
    }

    function mouseRead() {
      return mouseWait(0).then(() => mainPort.read8());
    }

    let status;

    /* eslint-disable newline-per-chained-call */
    mouseWait(1).then(() => {
      port64.write8(0xa8); // enable the aux mouse device
      return mouseWait(1);
    }).then(() => {
      port64.write8(0x20); // use interupts
      return mouseWait(0);
    }).then(() => {
      status = (mainPort.read8() | 2);
      return mouseWait(1);
    }).then(() => {
      port64.write8(0x60);
      return mouseWait(1); // end use interupts
    }).then(() => {
      mainPort.write8(status);
      return mouseWrite(0xf6); // use defaults
    })
    .then(() => mouseRead()) // ACK
    .then(() => mouseWrite(0xf4)) // enable the mouse
    .then(() => mouseRead()) // ACK
    .then(() => {
      let cycle = 0;
      let packet = [];
      irq.on(() => {
        if (cycle === 0) {
          packet = [];
          packet[0] = mainPort.read8();
          cycle++;
        } else if (cycle === 1) {
          packet[1] = mainPort.read8();
          cycle++;
        } else if (cycle === 2) {
          packet[2] = mainPort.read8();
          cycle = 0;
          ((packetPersistent) => {
            setImmediate(() => {
              processPacket(packetPersistent);
            });
          })(packet);
        }
      });
    });
    /* eslint-enable newline-per-chained-call */
  },
  reset() {},
};

runtime.ps2.setMouseDriver(driver);
