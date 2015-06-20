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

exports.get = function(cb) {
  var tty = runtime.tty;
  var inputText = '';
  var inputPosition = 0;
  var history = [''];
  var historyPosition = 0;
  var done = false;
  var inputEnabled = true;
  var endresult = '';

  function drawCursor() {
    var char = ' ';
    if (inputPosition < inputText.length) {
      char = inputText[inputPosition];
    }

    tty.print(char, 1, tty.color.WHITE, tty.color.LIGHTGREEN);
    tty.moveOffset(-1);
  }

  function removeCursor() {
    var char = ' ';
    if (inputPosition < inputText.length) {
      char = inputText[inputPosition];
    }

    tty.print(char, 1, tty.color.WHITE, tty.color.BLACK);
    tty.moveOffset(-1);
  }

  function putChar(char) {
    removeCursor();
    if (inputPosition >= inputText.length) {
      inputText += char;
      tty.print(char);
    } else {
      var rightSide = inputText.slice(inputPosition);
      inputText = inputText.slice(0, inputPosition) + char + rightSide;
      tty.print(char);
      for (var i = 0; i < rightSide.length; ++i) {
        tty.print(rightSide[i]);
      }
      tty.moveOffset(-rightSide.length);
    }
    ++inputPosition;
    drawCursor();
  }

  function removeChar() {
    if (inputPosition > 0) {
      removeCursor();
      if (inputPosition >= inputText.length) {
        inputText = inputText.slice(0, -1);
        tty.moveOffset(-1);
      } else {
        var rightSide = inputText.slice(inputPosition);
        inputText = inputText.slice(0, inputPosition - 1) + rightSide;
        tty.moveOffset(-1);
        for (var i = 0; i < rightSide.length; ++i) {
          tty.print(rightSide[i]);
        }
        tty.print(' ');
        tty.moveOffset(-rightSide.length - 1);
      }
      --inputPosition;
      drawCursor();
    }
  }

  function newLine() {
    var text = inputText;
    inputEnabled = false;
    historyPosition = 0;
    removeCursor();
    tty.print('\n');

    inputText = '';
    inputPosition = 0;

    var result = text.trim();
    if (result.length > 0) {
      var currentIndex = history.indexOf(result);
      if (currentIndex >= 0) {
        history.splice(currentIndex, 1);
      }
      history.splice(1, 0, result);

      runtime.keyboard.onKeydown.remove(addinput);
      if (cb) {
        cb(result);
      }
    } else {
      runtime.keyboard.onKeydown.remove(addinput);
      if (cb) {
        cb(result);
      }
    }
  }

  function addinput(keyinfo) {
    if (!inputEnabled) {
      return;
    }

    switch (keyinfo.type) {
    case 'kpup':
      if (historyPosition < history.length - 1) {
        setInputBox(history[++historyPosition]);
      }
      break;
    case 'kpdown':
      if (historyPosition > 0) {
        setInputBox(history[--historyPosition]);
      }
      break;
    case 'kpleft':
      historyPosition = 0;
      moveCursorLeft();
      break;
    case 'kpright':
      historyPosition = 0;
      moveCursorRight();
      break;
    case 'character':
      historyPosition = 0;
      putChar(keyinfo.character);
      break;
    case 'backspace':
      historyPosition = 0;
      removeChar();
      break;
    case 'enter':
      newLine();
      break;
    }
  }

  runtime.keyboard.onKeydown.add(addinput);

  drawCursor();
}
