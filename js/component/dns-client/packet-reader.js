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

class PacketReader {
  constructor(buf, len = buf.byteLength, offset) {
    this.buf = buf;
    this.len = len;
    this.offset = 0;
    this.view = new DataView(buf, offset, len);
  }
  readUint8() {
    return this.view.getUint8(this.offset++);
  }
  readUint16() {
    const value = this.view.getUint16(this.offset, false);
    this.offset += 2;
    return value;
  }
  readUint32() {
    const value = this.view.getUint32(this.offset, false);
    this.offset += 4;
    return value;
  }
  getOffset() {
    return this.offset;
  }
  setOffset(offset) {
    this.offset = offset;
  }
}

module.exports = PacketReader;
