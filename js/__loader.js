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

__SYSCALL.loaderSetupBuiltins({
  assert: 'assert',
  events: 'events',
  buffer: 'buffer',
  process: './modules/process.js',
  console: './modules/console.js',
  constants: 'constants-browserify',
  fs: './modules/fs.js',
  os: './modules/os.js',
  net: './modules/net.js',
  dns: './modules/dns.js',
  punycode: 'punycode',
  querystring: 'querystring-es3',
  string_decoder: 'string_decoder',
  path: 'path-browserify',
  url: 'url',
  stream: './modules/stream.js',
  inherits: './modules/inherits.js',
  sys: 'util/util.js',
  util: 'util/util.js',
});

require('./index');

global.process = require('process');
global.Buffer = require('buffer').Buffer;

const stream = require('stream');

class StdoutStream extends stream.Writable {
  _write(chunk, encoding, callback) {
    __SYSCALL.write(String(chunk));
    callback();
  }
}
class StderrStream extends stream.Writable {
  _write(chunk, encoding, callback) {
    __SYSCALL.write(String(chunk));
    callback();
  }
}
class TermoutStream extends stream.Writable {
  _write(chunk, encoding, callback) {
    runtime.stdio.defaultStdio.write(String(chunk));
    callback();
  }
}
class TermerrStream extends stream.Writable {
  _write(chunk, encoding, callback) {
    runtime.stdio.defaultStdio.writeError(String(chunk));
    callback();
  }
}

process.stdout = new StdoutStream();
process.stderr = new StderrStream();
process.termout = new TermoutStream();
process.termerr = new TermerrStream();

require('console');
