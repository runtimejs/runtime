// Copyright 2014 Runtime.JS project authors
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

function IP4Address(a, b, c, d) {
  this.a = (a & 0xff) >>> 0;
  this.b = (b & 0xff) >>> 0;
  this.c = (c & 0xff) >>> 0;
  this.d = (d & 0xff) >>> 0;
}

IP4Address.prototype.toString = function() {
  return this.a + '.' + this.b + '.' + this.c + '.' + this.d;
};

IP4Address.prototype.equals = function(that) {
  return this.a === that.a && this.b === that.b &&
         this.c === that.c && this.d === that.d;
};

IP4Address.prototype.and = function(that) {
  return new IP4Address(this.a & that.a, this.b & that.b,
                        this.c & that.c, this.d & that.d)
}

IP4Address.ANY = new IP4Address(0, 0, 0, 0);
IP4Address.BROADCAST = new IP4Address(255, 255, 255, 255);
IP4Address.LOOPBACK = new IP4Address(127, 0, 0, 1);

module.exports = IP4Address;
