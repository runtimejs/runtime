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

class StdioInterface {
  constructor() {
    this.onread = function() {};
    this.onwrite = function() {};
    this.onwriteerror = function() {};
    this.onsetcolor = function() {};
    this.onsetbackgroundcolor = function() {};
  }

  // stdout
  write() {
    var text = [];
    for (var i = 0; i < arguments.length; i++) {
      text[i] = String(arguments[i]);
    }
    this.onwrite(text.join(' '));
  }

  writeLine() {
    var text = [];
    for (var i = 0; i < arguments.length; i++) {
      text[i] = String(arguments[i]);
    }
    this.onwrite(text.join(' ') + '\n');
  }

  setColor(fg) {
    this.onsetcolor(fg);
  }

  setBackgroundColor(bg) {
    this.onsetbackgroundcolor(bg);
  }

  // stdin
  read(cb) {
    this.onread(cb);
  }

  readLine(cb) {
    // If there's onreadline, use it.
    if (this.onreadline) {
      this.onreadline(cb);
    } else {
      // Else, use onread.
      // Downside: no cusor moving or backspace.
      // TODO: Fix downside.
      var text = '';
      this.onread(function addinput(char) {
        if (char !== '\n') {
          text += char;
          this.onread(addinput);
        } else {
          cb(text);
        }
      });
    }
  }

  // stderr
  writeError() {
    if (typeof arguments[0] === 'string') {
      var text = [];
      for (var i = 0; i < arguments.length; i++) {
        text[i] = arguments[i];
      }
      this.onwriteerror(text.join(' '));
    } else {
      this.onwriteerror(arguments[0].stack);
    }
  }
}

module.exports = StdioInterface;
