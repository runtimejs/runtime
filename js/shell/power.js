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

runtime.shell.setCommand('poweroff', function(args, env, cb) {
  env.stdio.writeLine('Going down, now!');
  runtime.machine.shutdown();
  cb(0);
});

runtime.shell.setCommand('reboot', function(args, env, cb) {
  env.stdio.writeLine('Restarting, now!');
  runtime.machine.reboot();
  cb(0);
});
