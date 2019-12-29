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

// The properties `width`, `height`, and `bitDepth` are
// Symbols because they shouldn't be set.
const symbols = {
  width: Symbol('width'),
  height: Symbol('height'),
  bitDepth: Symbol('bitDepth'),
  init: Symbol('init'),
  reset: Symbol('reset'),
  initialized: Symbol('initialized'),
  renderer: Symbol('renderer'),
};

class Screen {
  constructor() {
    this[symbols.reset]();
  }
  [symbols.init](width, height, bitDepth, renderer) {
    this[symbols.width] = width;
    this[symbols.height] = height;
    this[symbols.bitDepth] = bitDepth;
    this[symbols.renderer] = renderer;
    this[symbols.initialized] = true;
  }
  [symbols.reset]() {
    this[symbols.width] = 0;
    this[symbols.height] = 0;
    this[symbols.bitDepth] = 0;
    this[symbols.renderer] = null;
    this[symbols.initialized] = false;
  }
  get width() {
    return this[symbols.width];
  }
  get height() {
    return this[symbols.height];
  }
  get bitDepth() {
    return this[symbols.bitDepth];
  }
  get bufferFormat() {
    return this[symbols.renderer].name;
  }
}

module.exports = {
  Screen,
  symbols,
};
