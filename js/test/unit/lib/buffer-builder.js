// Copyright 2015 runtime.js project authors
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

class BufferBuilder {
  constructor() {
    this._p = [];
    this._repeatFirst = 0;
    this._repeatLast = 0;
    this._ck = null;
    this._checksumFirst = 0;
    this._checksumLast = 0;
    this._checksumOffset = 0;
  }

  uint8(value) {
    value = (value >>> 0) & 0xff;
    this._p.push(value);
    this._repeatFirst = this._p.length - 1;
    this._repeatLast = this._p.length;
    return this;
  }

  uint16(value) {
    value = value >>> 0;
    this.uint8((value >>> 8) & 0xff);
    this.uint8(value & 0xff);
    this._repeatFirst = this._p.length - 2;
    this._repeatLast = this._p.length;
    return this;
  }

  beginChecksum() {
    this._checksumFirst = this._p.length;
    return this;
  }

  endChecksum() {
    this._checksumLast = this._p.length;
    return this;
  }

  checksum(fn) {
    this._checksumOffset = this._p.length;
    this._ck = fn;
    return this.uint16(0);
  }

  uint32(value) {
    value = value >>> 0;
    this.uint8((value >>> 24) & 0xff);
    this.uint8((value >>> 16) & 0xff);
    this.uint8((value >>> 8) & 0xff);
    this.uint8(value & 0xff);
    this._repeatFirst = this._p.length - 4;
    this._repeatLast = this._p.length;
    return this;
  }

  align(alignment, value) {
    alignment = alignment || 0;
    value = value || 0;
    while ((this._p.length % alignment) !== 0) {
      this.uint8(value);
    }
    return this;
  }

  array(u8) {
    for (var i = 0; i < u8.length; ++i) {
      this.uint8(u8[i] & 0xff);
    }
    this._repeatFirst = this._p.length - u8.length;
    this._repeatLast = this._p.length;
    return this;
  }

  repeat(times) {
    times = times || 0;
    for (var t = 0; t < times; ++t) {
      for (var i = this._repeatFirst; i < this._repeatLast; ++i) {
        this._p.push(this._p[i]);
      }
    }
    return this;
  }

  buffer() {
    var buf = new Uint8Array(this._p);
    if (this._ck) {
      if (this._checksumLast === 0) {
        this._checksumLast = this._p.length;
      }
      var sub = buf.subarray(this._checksumFirst, this._checksumLast);
      var cksum = this._ck(sub);
      buf[this._checksumOffset] = (cksum >>> 8) & 0xff;
      buf[this._checksumOffset + 1] = cksum & 0xff;
    }
    return buf;
  }
}

module.exports = BufferBuilder;
