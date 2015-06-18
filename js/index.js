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
var packagejson = require('./package.json');
require('module-singleton')(packagejson);
require('./version');

console.log(`v${packagejson.version} core library`);
console.log('loading...');

var isDebug = packagejson.runtimejs.debug;
global.debug = isDebug ? isolate.log : function() {};

// Load runtime.js core
require('./core');

// Start services
require('./service/dhcp-client');

runtime.shell = require('./service/shell');
runtime.dns = require('./service/dns-resolver');
runtime.debug = isDebug;

// Example shell command
runtime.shell.setCommand('1', function(args, cb) {
  runtime.tty.print('OK.\n');
  runtime.dns.resolve('www.google.com', {}, function(err, data) {
    if (err) return cb();
    console.log(JSON.stringify(data));
    cb();
  });
});

// Builtin functions
require('./shell/clear')(runtime);
require('./shell/echo')(runtime);
require('./shell/power')(runtime);

// Start device drivers
require('./driver/ps2');
require('./driver/virtio');

module.exports = runtime;
