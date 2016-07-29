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

class EntropySource {
  constructor(name = '') {
    this._name = name;
    this.ongetbytes = null;
  }
  getName() {
    return this._name;
  }
    /**
     * Request randomness from this entropy source
     */
  getBytes(u8, cb) {
    if (!this.ongetbytes) {
      throw new Error('entropy source was not initialized');
    }
    this.ongetbytes(u8, cb);
  }
}

module.exports = EntropySource;
