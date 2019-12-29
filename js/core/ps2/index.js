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

'use strict';
const driverUtils = require('../driver-utils');
const assert = require('assert');
const typeutils = require('typeutils');

exports.setKeyboardDriver = (driver) => {
  assert(typeutils.isFunction(driver.init));
  assert(typeutils.isFunction(driver.reset));

  driver.init({
    irq: driverUtils.irq(1),
    ioPort: driverUtils.ioPort(0x60),
  });
};

exports.setMouseDriver = (driver) => {
  assert(typeutils.isFunction(driver.init));
  assert(typeutils.isFunction(driver.reset));

  driver.init({
    irq: driverUtils.irq(12),
    ioPorts: [driverUtils.ioPort(0x60), driverUtils.ioPort(0x64)],
  });
};
