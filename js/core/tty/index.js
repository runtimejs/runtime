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

/* eslint-disable quotes */
const terminal = require('./terminal');
const { DARKGRAY, LIGHTGRAY, BLACK } = terminal.color;

terminal.print(`
                    _   _                   _
   _ __ _   _ _ __ | |_(_)_ __ ___   ___   (_)___
  | '__| | | | '_ \\| __| | '_ \` _ \\ / _ \\  | / __|
  | |  | |_| | | | | |_| | | | | | |  __/_ | \\__ \\
  |_|   \\__,_|_| |_|\\__|_|_| |_| |_|\\___(_)/ |___/
                                         |__/

`);

terminal.print('\n# Welcome to ', 1, DARKGRAY, BLACK);
terminal.print('runtime.js\n\n', 1, LIGHTGRAY, BLACK);

module.exports = terminal;
