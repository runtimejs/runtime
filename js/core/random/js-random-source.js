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
const isaac = require('./isaac-wrapper');
const EntropySource = require('./entropy-source');
const sources = require('./sources');

// Low quality entropy source based on Math.random() seed
// and isaac CSPRNG
const source = new EntropySource('js-random');
source.ongetbytes = (u8, cb) => {
  for (let i = 0; i < u8.length; i++) {
    u8[i] = isaac.getByte();
  } // eslint-disable-line no-param-reassign
  cb();
};

sources.addEntropySource(source);
