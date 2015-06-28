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
  self.stdio.defaultio = new self.stdio.Interface();

  self.stdio.defaultio.fgcolor = self.tty.color.WHITE;
  self.stdio.defaultio.bgcolor = self.tty.color.BLACK;

  self.stdio.defaultio.onwrite = function(text) {
    self.tty.print(text, 1, self.stdio.defaultio.fgcolor, self.stdio.defaultio.bgcolor);
  }

  self.stdio.defaultio.onsetcolor = function(fg) {
    self.stdio.defaultio.fgcolor = fg;
  }

  self.stdio.defaultio.onsetbackgroundcolor = function(bg) {
    self.stdio.defaultio.bgcolor = bg;
  }

  self.stdio.defaultio.onread = function(cb) {
    self.tty.read(cb);
  }

  self.stdio.defaultio.onreadline = function(cb) {
    self.tty.readLine(cb);
  }

  self.stdio.defaultio.onwriteerror = function(error) {
    self.tty.print(error, 1, self.tty.color.RED);
  }
}
