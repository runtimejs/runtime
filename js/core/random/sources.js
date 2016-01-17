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
var isaac = require('./isaac-wrapper');
var defaultSource = null;
var availableSources = Object.create(null);

exports.addEntropySource = function(source) {
  availableSources[source.getName()] = source;

  source.getBytes(new Uint8Array(8), function(u8) {
    isaac.seed(u8);
    console.log('[random] using entropy source', source.getName());
  });

  // Set this source as the default one
  defaultSource = source;
};

exports.getDefaultSource = function() {
  return defaultSource;
};
