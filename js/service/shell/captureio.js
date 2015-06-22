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
exports.io.acceptInput = false;
exports.io.stdin = {};
exports.io.stdout = {};

exports.events.on('stdin', function(text) {
  if (exports.io.acceptInput) {
    exports.events.callback(text);
    exports.io.acceptInput = false;
  }
});

exports.io.stdin.readln = function(cb) {
  exports.events.acceptInput = true;
  exports.events.callback = cb;
  exports.events.emit('feed');
}

exports.io.stdout.write = function(text, fg, bg) {
  exports.events.emit('stdout', {
    text: text,
    color: {
      fg: fg,
      bg: bg
    }
  });
}

exports.io.stdout.writeln = function(text, fg, bg) {
  exports.events.emit('stdout', {
    text: text + '\n',
    color: {
      fg: fg,
      bg: bg
    }
  });
}
