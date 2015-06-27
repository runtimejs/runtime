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

module.exports = function(runtime) {
  runtime.shell.setCommand('clear', function(args, env, cb) {
    // TODO: print according to screen height.
    env.stdout.setColor(runtime.tty.color.BLACK);
    env.stdout.setBackgroundColor(runtime.tty.color.BLACK);
    for (var i = 0; i < 80; i++) {
      env.stdout.write('\n');
    }
    runtime.tty.moveTo(0, 0);
    cb(0);
  });
};
