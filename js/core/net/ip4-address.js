// Copyright 2014-2015 runtime.js project authors
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

function IP4Address(a, b, c, d) {
  this.a = (a & 0xff) >>> 0;
  this.b = (b & 0xff) >>> 0;
  this.c = (c & 0xff) >>> 0;
  this.d = (d & 0xff) >>> 0;
}

IP4Address.prototype.toString = function() {
  return this.a + '.' + this.b + '.' + this.c + '.' + this.d;
};

IP4Address.prototype.toInteger = function() {
  return ((this.a << 24) | (this.b << 16) | (this.c << 8) | this.d) >>> 0;
};

IP4Address.prototype.equals = function(that) {
  return this.a === that.a && this.b === that.b &&
         this.c === that.c && this.d === that.d;
};

IP4Address.prototype.and = function(that) {
  return new IP4Address(this.a & that.a, this.b & that.b,
                        this.c & that.c, this.d & that.d)
}

IP4Address.prototype.hash = function() {
  return (this.a | (this.b << 8) | (this.c << 16) | (this.d << 24)) >>> 0;
};

IP4Address.prototype.isBroadcast = function() {
  return 255 === this.a && 255 === this.b &&
         255 === this.c && 255 === this.d;
};

IP4Address.prototype.isAny = function() {
  return 0 === this.a && 0 === this.b &&
         0 === this.c && 0 === this.d;
};

IP4Address.ANY = new IP4Address(0, 0, 0, 0);
IP4Address.BROADCAST = new IP4Address(255, 255, 255, 255);
IP4Address.LOOPBACK = new IP4Address(127, 0, 0, 1);

IP4Address.parse = function(str) {
  if ('string' !== typeof str) {
    return null;
  }

  var p = str.trim().split('.');
  if (4 !== p.length) {
    return null;
  }

  var a = new Array(4);
  for (var i = 0; i < 4; ++i) {
    var v = p[i] | 0;
    if (v !== +p[i] || v < 0 || v > 255) {
      return null;
    }

    a[i] = v;
  }

  return new IP4Address(a[0], a[1], a[2], a[3]);
};

module.exports = IP4Address;
