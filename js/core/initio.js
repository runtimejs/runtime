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
  self.stdio.defaultStdio = new self.stdio.StdioInterface();

  self.stdio.defaultStdio.fgcolor = self.tty.color.WHITE;
  self.stdio.defaultStdio.bgcolor = self.tty.color.BLACK;

  self.stdio.defaultStdio.onwrite = function(text) {
    self.tty.print(text, 1, self.stdio.defaultStdio.fgcolor, self.stdio.defaultStdio.bgcolor);
  }

  self.stdio.defaultStdio.onsetcolor = function(fg) {
    self.stdio.defaultStdio.fgcolor = fg;
  }

  self.stdio.defaultStdio.onsetbackgroundcolor = function(bg) {
    self.stdio.defaultStdio.bgcolor = bg;
  }

  self.stdio.defaultStdio.onread = function(cb) {
    self.tty.read(cb);
  }

  self.stdio.defaultStdio.onreadline = function(cb) {
    self.tty.readLine(cb);
  }

  self.stdio.defaultStdio.onwriteerror = function(error) {
    self.tty.print(error, 1, self.tty.color.RED);
  }
}
