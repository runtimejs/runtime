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

var exports = module.exports;
const tty = runtime.tty;

exports.inputText = '';
exports.inputPosition = 0;

exports.drawPrompt = function() {
  tty.print('$', 1, tty.color.YELLOW, tty.color.BLACK);
  tty.print(' ', 1, tty.color.WHITE, tty.color.BLACK);
}

exports.drawCursor = function() {
  var char = ' ';
  if (exports.inputPosition < exports.inputText.length) {
    char = exports.inputText[exports.inputPosition];
  }

  tty.print(char, 1, tty.color.WHITE, tty.color.LIGHTGREEN);
  tty.moveOffset(-1);
}

exports.removeCursor = function() {
  var char = ' ';
  if (exports.inputPosition < exports.inputText.length) {
    char = exports.inputText[exports.inputPosition];
  }

  tty.print(char, 1, tty.color.WHITE, tty.color.BLACK);
  tty.moveOffset(-1);
}

exports.putChar = function(char) {
  exports.removeCursor();
  if (exports.inputPosition >= exports.inputText.length) {
    exports.inputText += char;
    tty.print(char);
  } else {
    var rightSide = exports.inputText.slice(exports.inputPosition);
    exports.inputText = exports.inputText.slice(0, exports.inputPosition) + char + rightSide;
    tty.print(char);
    for (var i = 0; i < rightSide.length; ++i) {
      tty.print(rightSide[i]);
    }
    tty.moveOffset(-rightSide.length);
  }
  ++exports.inputPosition;
  exports.drawCursor();
}

exports.removeChar = function() {
  if (exports.inputPosition > 0) {
    exports.removeCursor();
    if (exports.inputPosition >= exports.inputText.length) {
      exports.inputText = exports.inputText.slice(0, -1);
      tty.moveOffset(-1);
    } else {
      var rightSide = exports.inputText.slice(exports.inputPosition);
      exports.inputText = exports.inputText.slice(0, exports.inputPosition - 1) + rightSide;
      tty.moveOffset(-1);
      for (var i = 0; i < rightSide.length; ++i) {
        tty.print(rightSide[i]);
      }
      tty.print(' ');
      tty.moveOffset(-rightSide.length - 1);
    }
    --exports.inputPosition;
    exports.drawCursor();
  }
}

exports.moveCursorLeft = function() {
  if (exports.inputPosition > 0) {
    exports.removeCursor();
    --exports.inputPosition;
    tty.moveOffset(-1);
    exports.drawCursor();
  }
}

exports.moveCursorRight = function() {
  if (exports.inputPosition < exports.inputText.length) {
    exports.removeCursor();
    ++exports.inputPosition;
    tty.moveOffset(1);
    exports.drawCursor();
  }
}

exports.clearInputBox = function() {
  while (exports.inputPosition < exports.inputText.length) {
    exports.moveCursorRight();
  }
  while (exports.inputPosition > 0) {
    exports.removeChar();
  }
}

exports.setInputBox = function(text) {
  exports.removeCursor();
  exports.clearInputBox();
  for (var i = 0; i < text.length; ++i) {
    exports.inputText += text[i];
    tty.print(text[i]);
    exports.inputPosition++;
  }
  exports.drawCursor();
}
