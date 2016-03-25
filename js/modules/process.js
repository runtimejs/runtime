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

module.exports = {
  abort: function() {
    throw new Error('abort()');
  },
  arch: 'x64', // since runtime.js only runs in qemu-system-x86_64, it's an x64 system.
  argv: [],
  binding: function(name) {
    throw new Error('no such module: ' + name);
  },
  chdir: function() {
    throw new Error('chdir is not supported');
  },
  config: {},
  connected: false,
  cwd: function() {
    return '/';
  },
  disconnect: function() {},
  env: {},
  execArgv: [],
  execPath: '',
  exit: function() {
    throw new Error('exit()');
  },
  exitCode: 0,
  hrtime: function(prev) {
    var now = performance.now();
    var time = now / 1000;
    var seconds = Math.round(time);
    var nanoseconds = Math.floor((time % 1) * 1e9);

    if (prev) {
      seconds -= prev[0];
      nanoseconds -= prev[1];
      if (nanoseconds < 0) {
        seconds -= 1;
        nanoseconds += 1e9;
      }
    }

    return [seconds, nanoseconds];
  },
  kill: function() {},
  mainModule: void 0,
  memoryUsage: function() {
    return {
      rss: 0,
      heapTotal: 0,
      heapUsed: 0
    };
  },
  nextTick: function nextTick(fn, ...args) {
    setImmediate(function() {
      fn(...args);
    });
  },
  pid: 1,
  platform: 'runtime',
  release: {
    name: 'runtime',
  },
  send: void 0,
  stderr: null,
  stdin: null,
  stdout: null,
  title: '',
  umask: function() {
    return 0;
  },
  uptime: function() {
    return Math.round(performance.now() / 1000);
  },
  version: '0.0.0',
  versions: {}
};
