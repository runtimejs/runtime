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

const test = require('tape');
const stream = test.createStream();
const { shutdown } = require('../../').machine;

stream.on('data', (vOpt) => {
  let v = vOpt;
  if (v[v.length - 1] === '\n') {
    v = v.slice(0, -1);
  }
  console.log(v);
});

stream.on('end', shutdown);

require('./script');
require('./lib/test');
require('./buffers');
require('./platform');
require('./timers');
require('./virtio');
require('./random');
require('./net');
