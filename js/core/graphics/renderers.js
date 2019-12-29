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

let defaultRenderer = null;
const availableRenderers = new Map();

module.exports = {
  addRenderer(renderer) {
    availableRenderers.set(renderer.name, renderer);

    console.log(`[graphics] using renderer ${renderer.name}`);

    defaultRenderer = renderer;
  },
  renderersAvailable() {
    return availableRenderers.size !== 0;
  },
  getDefaultRenderer() {
    return defaultRenderer;
  },
  getConstants() {
    const consts = {};
    for (const renderer of availableRenderers.values()) {
      Object.assign(consts, renderer.constants);
    }
    return consts;
  },
};
