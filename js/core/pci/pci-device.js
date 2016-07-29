// Copyright 2015-present runtime.js project authors
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
const assert = require('assert');
const typeutils = require('typeutils');
const isint = require('isint');

class PciDevice {
  constructor(opts) {
    assert(typeutils.isObject(opts));
    assert(isint.uint16(opts.vendorId));
    assert(isint.uint16(opts.deviceId));
    assert(isint.uint8(opts.bus));
    assert(isint.uint8(opts.slot));
    assert(isint.uint8(opts.func));
    assert(typeutils.isObject(opts.pciAccessor));
    assert(typeutils.isArray(opts.bars));

    this.vendorId = opts.vendorId;
    this.deviceId = opts.deviceId;
    this.pciAccessor = opts.pciAccessor;
    this.subsystem = opts.subsystemData;
    this.bars = opts.bars;
    this.irq = opts.irq;

    this.driver = null;
  }
  getBAR(index) {
    assert(Number.isInteger(index) && index >= 0 && index <= 6);
    return this.bars[index] || null;
  }
  getIRQ() {
    return this.irq;
  }
  setPciCommandFlag(flag) {
    assert(Number.isInteger(flag) && flag >= 0 && flag < 16);
    let t = this.pciAccessor.read(this.pciAccessor.fields().COMMAND);
    t |= (1 << flag) >>> 0;
    this.pciAccessor.write(this.pciAccessor.fields().COMMAND, t);
  }
  setDriver(driver) {
    assert(typeutils.isObject(driver));
    assert(typeutils.isFunction(driver.init));
    this.driver = driver;
    driver.init(this);
  }
  hasDriver() {
    return this.driver !== null;
  }
  static get commandFlag() {
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

module.exports = PciDevice;
