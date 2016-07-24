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

class IP4Address {
  constructor(a, b, c, d) {
    this.a = (a & 0xff) >>> 0;
    this.b = (b & 0xff) >>> 0;
    this.c = (c & 0xff) >>> 0;
    this.d = (d & 0xff) >>> 0;
  }
  toString() {
    return `${this.a}.${this.b}.${this.c}.${this.d}`;
  }
  toInteger() {
    return ((this.a << 24) | (this.b << 16) | (this.c << 8) | this.d) >>> 0;
  }
  equals(that) {
    return this.a === that.a && this.b === that.b &&
      this.c === that.c && this.d === that.d;
  }
  and(that) {
    return new IP4Address(this.a & that.a, this.b & that.b,
      this.c & that.c, this.d & that.d);
  }
  hash() {
    return (this.a | (this.b << 8) | (this.c << 16) | (this.d << 24)) >>> 0;
  }
  isBroadcast() {
    return this.a === 255 && this.b === 255 &&
      this.c === 255 && this.d === 255;
  }
  isAny() {
    return this.a === 0 && this.b === 0 &&
      this.c === 0 && this.d === 0;
  }
  static parse(str) {
    if (str instanceof IP4Address) {
      return str;
    }
    if (typeof str !== 'string') {
      return null;
    }

    const p = str.trim().split('.');
    if (p.length !== 4) {
      return null;
    }

    const a = new Array(4);
    for (let i = 0; i < 4; ++i) {
      const v = p[i] | 0;
      if (v !== +p[i] || v < 0 || v > 255) {
        return null;
      }
      a[i] = v;
    }

    return new IP4Address(a[0], a[1], a[2], a[3]);
  }
}

IP4Address.ANY = new IP4Address(0, 0, 0, 0);
IP4Address.BROADCAST = new IP4Address(255, 255, 255, 255);
IP4Address.LOOPBACK = new IP4Address(127, 0, 0, 1);

module.exports = IP4Address;
