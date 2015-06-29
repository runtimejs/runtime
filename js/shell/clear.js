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

var runtime = require('../core');

runtime.shell.setCommand('clear', function(args, env, cb) {
  // TODO: print according to screen height.
  env.stdio.setColor('black');
  env.stdio.setBackgroundColor('black');
  for (var i = 0; i < 80; i++) {
    env.stdio.write('\n');
  }
  env.stdio.setColor('white');
  cb(0);
});
