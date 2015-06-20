// Copyright 2014-2015 runtime.js project authors
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

var stdout = require('./stdout');
var stdin = require('./stdin');

var combined = {};

for (var obj in stdin) {
  combined[obj] = stdin[obj];
}

for (var obj2 in stdout) {
  combined[obj2] = stdout[obj2];
}

exports = combined;
