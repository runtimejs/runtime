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

const nameSymbol = Symbol('name');

class GraphicsRenderer {
  constructor(name = '') {
    this[nameSymbol] = name;
    this.ongetbuffer = null;
    this.onenablegraphics = null;
    this.constants = {};
  }
  get name() {
    return this[nameSymbol];
  }
  get displayBuffer() {
    if (!this.ongetbuffer) {
      throw new Error('renderer not initialized');
    }
    return this.ongetbuffer();
  }
  enableGraphics(width, height, bitDepth) {
    if (!this.onenablegraphics) {
      throw new Error('renderer not initialized');
    }
    this.onenablegraphics(width, height, bitDepth);
  }
}

module.exports = GraphicsRenderer;
