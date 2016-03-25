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

class Console {
  constructor(stdout, stderr) {
    if (!stdout) throw new Error('Console: Must provide a stdout stream to the constructor.');
    this._stdout = stdout;
    if (stderr) this._stderr = stderr;
    this._labels = {};
  }
  assert(val, ...data) {
    if (!val) throw new Error(util.format(...data));
  }
  dir(obj, opts) {
    opts = opts || {};
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
  time(label) {
    if (!label) label = 'undefined';
    this._labels[label] = Date.now();
  }
  timeEnd(label) {
    if (!label) label = 'undefined'
    if (!this._labels[label]) throw new Error('Console.timeEnd: Label does not exist.');
    this._stdout.write(`${label}: ${Date.now()-this._labels[label]}ms\n`);
  }
  trace(...data) {
    let trace = (new Error()).stack;
    let arr = trace.split('\n');
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

module.exports = Console;
global.console = new Console(process.stdout, process.stderr);
