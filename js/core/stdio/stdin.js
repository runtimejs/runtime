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

class StdIn {
  constructor() {

  }

  readln(cb) {
    var input = require('../../shared/input');
    var inputEnabled = true;
    var history = [''];
    var historyPosition = 0;

    function newLine() {
      var text = input.inputText;
      input.inputEnabled = false;
      historyPosition = 0;
      input.removeCursor();
      runtime.tty.print('\n');

      input.inputText = '';
      input.inputPosition = 0;

      var result = text.trim();

      var currentIndex = history.indexOf(result);
      if (currentIndex >= 0) {
        history.splice(currentIndex, 1);
      }
      history.splice(1, 0, result);
      inputEnabled = true;
      cb(result);
    }

    function addinput(keyinfo) {
      if (!inputEnabled) {
        return;
      }

      switch (keyinfo.type) {
      case 'kpup':
        if (historyPosition < history.length - 1) {
          input.setInputBox(history[++historyPosition]);
        }
        break;
      case 'kpdown':
        if (historyPosition > 0) {
          input.setInputBox(history[--historyPosition]);
        }
        break;
      case 'kpleft':
        historyPosition = 0;
        input.moveCursorLeft();
        break;
      case 'kpright':
        historyPosition = 0;
        input.moveCursorRight();
        break;
      case 'character':
        historyPosition = 0;
        input.putChar(keyinfo.character);
        break;
      case 'backspace':
        historyPosition = 0;
        input.removeChar();
        break;
      case 'enter':
        newLine();
        break;
      }
    }

    runtime.keyboard.onKeydown.add(addinput);

    input.drawCursor();
  }
}



module.exports = StdIn;
