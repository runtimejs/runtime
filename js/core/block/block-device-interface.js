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

const typeutils = require('typeutils');

const busHandle = Symbol('bus');
const formatInfoHandle = Symbol('formatInfo');
const nameHandle = Symbol('name');
const setNameHandle = Symbol('setName');

class BlockDeviceInterface {
  constructor(bus = '', init = {}) {
    this[busHandle] = bus;
    this[formatInfoHandle] = {};
    this.onread = null;
    this.onwrite = null;
    this.ongetonline = null;
    if (typeutils.isObject(init)) {
      if (typeutils.isFunction(init.read)) {
        this.onread = init.read;
      }
      if (typeutils.isFunction(init.write)) {
        this.write = init.write;
      }
      if (typeutils.isObject(init.formatInfo)) {
        this[formatInfoHandle] = init.formatInfo;
      }
      if (typeutils.isFunction(init.isOnline)) {
        this.ongetonline = init.isOnline;
      }
    }
  }
  get name() {
    return this[nameHandle];
  }
  get bus() {
    return this[busHandle];
  }
  [setNameHandle](newName) {
    this[nameHandle] = newName;
  }
  read(sector, u8) {
    if (!this.onread) {
      throw new Error('driver was not initialized');
    }
    return this.onread(sector, u8);
  }
  write(sector, u8) {
    if (!this.onwrite) {
      throw new Error('driver was not initialized');
    }
    return this.onwrite(sector, u8);
  }
  get formatInfo() {
    return this[formatInfoHandle];
  }
  get isOnline() {
    if (!this.ongetonline) {
      throw new Error('driver was not initialized');
    }
    return this.ongetonline();
  }
}

module.exports = {
  BlockDeviceInterface,
  setNameHandle,
};
