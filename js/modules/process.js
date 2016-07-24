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

const EventEmitter = require('events');

class Warning extends Error {
  constructor(msg, name) {
    super();
    this.name = name;
    this.message = msg;
  }
}

class Process extends EventEmitter {
  constructor() {
    super();
    Object.assign(this, {
      abort() {
        throw new Error('abort()');
      },
      arch: 'x64', // since runtime.js only runs in qemu-system-x86_64, it's an x64 system.
      argv: [],
      binding(name) {
        throw new Error(`no such module: ${name}`);
      },
      chdir() {
        throw new Error('chdir is not supported');
      },
      config: {},
      connected: false,
      cwd: () => '/',
      disconnect() {},
      emitWarning: (msgOpt, name = 'Warning') => {
        let msg = msgOpt;
        if (!(msg instanceof Error)) {
          msg = new Warning(msg, name);
        }
        if (this.listenerCount('warning') !== 0) {
          return this.emit('warning', msg);
        }
        console.error(`(runtime) ${msg.name}${msg.message ? `: ${msg.message}` : ''}`);
      },
      env: {},
      execArgv: [],
      execPath: '',
      exit() {
        throw new Error('exit()');
      },
      exitCode: 0,
      hrtime(prev) {
        const now = performance.now();
        const time = now / 1000;
        let seconds = Math.round(time);
        let nanoseconds = Math.floor((time % 1) * 1e9);

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
      kill() {},
      mainModule: void 0,
      memoryUsage: () => ({
        rss: 0,
        heapTotal: 0,
        heapUsed: 0,
      }),
      nextTick: (fn, ...args) => setImmediate(() => fn(...args)),
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
      umask: () => 0,
      uptime: () => Math.round(performance.now() / 1000),
      version: '0.0.0',
      versions: {},
    });
  }
}

module.exports = new Process();
