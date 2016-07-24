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
const isint = require('isint');
const portUtils = require('./port-utils');

const EPHEMERAL_PORT_FIRST = 49152;
const EPHEMERAL_PORT_COUNT = 16000;
assert(isint.uint16(EPHEMERAL_PORT_FIRST + EPHEMERAL_PORT_COUNT));

class PortAllocator {
  constructor() {
    this._searchStart = 0;
    this._allocated = 0;
    this._sockets = [];
    this._map = null;
  }

  get allocatedCount() {
    return this._allocated;
  }

  isEphemeralRange(port) {
    return port >= EPHEMERAL_PORT_FIRST && port < EPHEMERAL_PORT_FIRST + EPHEMERAL_PORT_COUNT;
  }

  allocEphemeral(socket) {
    if (this._searchStart < this._sockets.length) {
      for (let i = this._searchStart, l = this._sockets.length; i < l; ++i) {
        if ((this._sockets[i] === null) && ((this._map !== null) ? !this._map.has(EPHEMERAL_PORT_FIRST + i) : true)) {
          this._sockets[i] = socket;
          ++this._allocated;
          this._searchStart = i + 1;
          return EPHEMERAL_PORT_FIRST + i;
        }
      }
    }

    while (this._sockets.length < EPHEMERAL_PORT_COUNT) {
      if (this._map !== null && this._map.has(EPHEMERAL_PORT_FIRST + this._sockets.length)) {
        this._sockets.push(null);
        continue;
      }

      this._sockets.push(socket);
      ++this._allocated;
      this._searchStart = this._sockets.length;
      return (EPHEMERAL_PORT_FIRST + this._sockets.length) - 1;
    }

    return 0;
  }

  allocPort(port, socket) {
    assert(portUtils.isPort(port));
    if (this.lookup(port)) {
      return false;
    }
    if (this._map === null) {
      this._map = new Map();
    }

    this._map.set(port, socket);
    ++this._allocated;
    return true;
  }

  free(port) {
    assert(portUtils.isPort(port));

    if ((this._map !== null) && this._map.has(port)) {
      this._map.delete(port);
      --this._allocated;
      if (this.isEphemeralRange(port)) {
        if (port - EPHEMERAL_PORT_FIRST < this._searchStart) {
          this._searchStart = port - EPHEMERAL_PORT_FIRST;
        }
      }
      return;
    }

    if (this.isEphemeralRange(port)) {
      const index = port - EPHEMERAL_PORT_FIRST;
      if (index >= this._sockets.length) {
        return;
      }

      if (this._sockets[index] === null) {
        return;
      }

      this._sockets[index] = null;
      if (index < this._searchStart) {
        this._searchStart = index;
      }
      --this._allocated;
      if (this._allocated === 0) {
        this._sockets = [];
        this._searchStart = 0;
      }
    }
  }

  lookup(port) {
    if ((this._map !== null) && this._map.has(port)) {
      return this._map.get(port);
    }

    if (this.isEphemeralRange(port)) {
      const index = port - EPHEMERAL_PORT_FIRST;
      if (index >= this._sockets.length) {
        return null;
      }
      return this._sockets[index];
    }

    return null;
  }
}

module.exports = PortAllocator;
