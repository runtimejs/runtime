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

var checksum = require('net/checksum');

function NetBuffer(u8, len, offset) {
  this.u8 = u8 || null;
  this.len = len | 0;
  this.offset = offset | 0;
  this.next = null;
}

NetBuffer.prototype.checksum = function(sum) {
  sum = checksum.full(this.u8, this.offset, this.len, sum | 0);
  return this.next ? this.next.checksum(sum) : sum;
};

NetBuffer.prototype.length = function() {
  return (this.len - this.offset) + this.next ? this.next.length() : 0;
};

NetBuffer.prototype.setNext = function(netbuf) {
  this.next = netbuf;
};

module.exports = NetBuffer;
