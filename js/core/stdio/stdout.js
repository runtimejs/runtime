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

class StdOut {
  constructor() {
    this.onwrite = function() {};
    this.onsetcolor = function() {};
    this.onsetbackgroundcolor = function() {};
    this.fgcolor = runtime.tty.color.WHITE;
    this.bgcolor = runtime.tty.color.BLACK;
  }

  write() {
    var text = [];
    for (var i = 0; i < arguments.length; i++) {
      text[i] = arguments[i];
    }
    this.onwrite(text.join(' '));
  }

  writeLine() {
    var text = [];
    for (var i = 0; i < arguments.length; i++) {
      text[i] = arguments[i];
    }
    this.onwrite(text.join(' ') + '\n');
  }

  setColor(fg) {
    this.onsetcolor(fg);
  }

  setBackgroundColor(bg) {
    this.onsetbackgroundcolor(bg);
  }
}

module.exports = StdOut;
