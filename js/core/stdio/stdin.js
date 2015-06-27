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

class Stdin {
  constructor() {
    this.onread = function() {};
  }

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
      function addinput(char) {
        if (char !== '\n') {
          text += char;
          this.onread(addinput);
        } else {
          cb(text);
        }
      }
      this.onread(addinput);
    }
  }
}

module.exports = Stdin;
