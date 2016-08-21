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

'use strict';
let defaultDriver = null;
const availableDrivers = Object.create(null);

function deepFreeze(obj) {
  const keys = Object.getOwnPropertyNames(obj);
  for (const key of keys) {
    const prop = obj[key];
    if (typeof prop === 'object' && prop !== null) deepFreeze(prop);
  }
  return Object.freeze(obj);
}

exports.addDriver = (driver) => {
  availableDrivers[driver.name] = driver;

  console.log(`[disk] using driver ${driver.name}`);

  // Set this driver as the default one
  defaultDriver = driver;
};

exports.getDefaultDriver = () => defaultDriver;
exports.getCopyOfDrivers = () => {
  const copy = Object.create(null);
  Object.assign(copy, availableDrivers);
  return deepFreeze(copy);
};
