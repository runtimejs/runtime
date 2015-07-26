// Copyright 2015 runtime.js project authors
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
var EntropySource = require('./entropy-source');
var sources = require('./sources');

var source = new EntropySource('default');
source.ongetbytes = function(u8, cb) {
  for (var i = 0; i < u8.length; i++) {
    u8[i] = isaacRound(isaac.getByte());
  }
  cb();
};

sources.addEntropySource(source);
