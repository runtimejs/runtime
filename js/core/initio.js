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

module.exports = function(self) {
  self.tty.stdout.onwrite = function(text) {
    self.tty.print(text, 1, self.tty.stdout.fgcolor, self.tty.stdout.bgcolor);
  }

  self.tty.stdout.onsetcolor = function(fg) {
    self.tty.stdout.fgcolor = fg;
  }

  self.tty.stdout.onsetbackgroundcolor = function(bg) {
    self.tty.stdout.bgcolor = bg;
  }

  self.tty.stdin.onread = function(cb) {
    self.tty.read(cb);
  }

  self.tty.stdin.onreadline = function(cb) {
    self.tty.readLine(cb);
  }
}
