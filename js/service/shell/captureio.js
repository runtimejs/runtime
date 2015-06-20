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

var events = require('events');
exports.events = new events.EventEmitter();
exports.io = {};

exports.io.readline = function(cb) {
  runtime.tty.get(cb);
}

exports.io.write = function(text, fg, bg) {
  exports.events.emit('data', {
    text: text,
    color: {
      fg: fg,
      bg: bg
    }
  });
}

exports.io.writeline = function(text, fg, bg) {
  exports.events.emit('data', {
    text: text + '\n',
    color: {
      fg: fg,
      bg: bg
    }
  });
}
