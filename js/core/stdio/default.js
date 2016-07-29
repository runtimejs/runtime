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

const tty = require('../tty');
const StdioInterface = require('./interface');
const defaultStdio = new StdioInterface();

let fgcolor = tty.color.WHITE;
let bgcolor = tty.color.BLACK;

defaultStdio.onwrite = text => tty.print(text, 1, fgcolor, bgcolor);

defaultStdio.onsetcolor = (fg) => {
  if (!fg) {
    fgcolor = tty.color.WHITE;
    return;
  }

  fgcolor = tty.color[String(fg).toUpperCase()];
};

defaultStdio.onsetbackgroundcolor = (bg) => {
  if (!bg) {
    bgcolor = tty.color.BLACK;
    return;
  }

  bgcolor = tty.color[String(bg).toUpperCase()];
};

defaultStdio.onread = cb => tty.read(cb);

defaultStdio.onreadline = cb => tty.readLine(cb);

defaultStdio.onwriteerror = error => tty.print(error, 1, tty.color.RED);

module.exports = defaultStdio;
