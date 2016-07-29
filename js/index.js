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

const packagejson = require('../package.json');
require('module-singleton')(packagejson);
require('./version');

console.log(`runtime.js v${packagejson.version}`);
console.log('loading...');

const isDebug = packagejson.runtimejs.debug;
global.debug = isDebug ? console.log : () => {};

// Load runtime.js core
const runtime = require('./core');

// Start services
require('./service/dhcp-client');

runtime.shell = require('./service/shell');
runtime.dns = require('./service/dns-resolver');

runtime.debug = isDebug;

// Example shell command
runtime.shell.setCommand('1', (args, env, cb) => {
  env.stdio.writeLine('OK.');
  runtime.dns.resolve('www.google.com', {}, (err, data) => {
    if (err) {
      return cb(1);
    }
    console.log(JSON.stringify(data));
    cb(0);
  });
});

runtime.shell.setCommand('poweroff', (args, env, cb) => {
  env.stdio.writeLine('Going down, now!');
  runtime.machine.shutdown();
  cb(0);
});

runtime.shell.setCommand('reboot', (args, env, cb) => {
  env.stdio.writeLine('Restarting, now!');
  runtime.machine.reboot();
  cb(0);
});


// Start device drivers
require('./driver/ps2');
require('./driver/virtio');

// Set time
require('./core/cmos-time'); // load cmos
require('./core/set-time'); // fetch NTP

module.exports = runtime;
