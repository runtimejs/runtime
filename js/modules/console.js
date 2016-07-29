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

const util = require('util');
const stream = require('stream');

class Console {
  constructor(stdout, stderr) {
    if (!stdout || (!(stdout instanceof stream.Writable) && !(stdout instanceof stream.Duplex))) {
      throw new TypeError('Console expects a writable stream instance');
    }
    this._stdout = stdout;
    if (stderr) {
      if (!(stderr instanceof stream.Writable) && !(stderr instanceof stream.Duplex)) {
        throw new TypeError('Console expects writable stream instances');
      }
      this._stderr = stderr;
    }
    this._labels = {};
  }
  assert(val, ...data) {
    if (!val) {
      throw new Error(util.format(...data));
    }
  }
  dir(obj, optsOpt = {}) {
    const opts = optsOpt;
    opts.customInspect = true;
    this._stdout.write(util.inspect(obj, opts));
  }
  error(...data) {
    const out = this._stderr || this._stdout;
    out.write(`${util.format(...data)}\n`);
  }
  log(...data) {
    this._stdout.write(`${util.format(...data)}\n`);
  }
  time(label = 'undefined') {
    this._labels[label] = Date.now();
  }
  timeEnd(label = 'undefined') {
    if (!this._labels[label]) process.emitWarning(`No such label ${label} for console.timeEnd()`);
    this._stdout.write(`${label}: ${Date.now() - this._labels[label]}ms\n`);
  }
  trace(...data) {
    let trace = (new Error()).stack;
    const arr = trace.split('\n');
    arr[0] = 'Trace';
    if (data.length > 0) arr[0] += `: ${util.format(...data)}`;
    trace = arr.join('\n');
    this._stdout.write(`${trace}\n`);
  }
  info(...data) {
    this.log(...data);
  }
  warn(...data) {
    this.error(...data);
  }
}

global.console = new Console(process.stdout, process.stderr);

const bound = [
  'assert',
  'dir',
  'error',
  'log',
  'time',
  'timeEnd',
  'trace',
  'info',
  'warn',
];
for (const item of bound) {
  module.exports[item] = console[item].bind(console);
}
module.exports.Console = Console;
