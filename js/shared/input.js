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

const tty = runtime.tty;

module.exports = function() {
  this.inputText = '';
  this.inputPosition = 0;

  this.drawPrompt = function() {
    tty.print('$', 1, tty.color.YELLOW, tty.color.BLACK);
    tty.print(' ', 1, tty.color.WHITE, tty.color.BLACK);
  }

  this.drawCursor = function() {
    var char = ' ';
    if (this.inputPosition < this.inputText.length) {
      char = this.inputText[this.inputPosition];
    }

    tty.print(char, 1, tty.color.WHITE, tty.color.LIGHTGREEN);
    tty.moveOffset(-1);
  }

  this.removeCursor = function() {
    var char = ' ';
    if (this.inputPosition < this.inputText.length) {
      char = this.inputText[this.inputPosition];
    }

    tty.print(char, 1, tty.color.WHITE, tty.color.BLACK);
    tty.moveOffset(-1);
  }

  this.putChar = function(char) {
    this.removeCursor();
    if (this.inputPosition >= this.inputText.length) {
      this.inputText += char;
      tty.print(char);
    } else {
      var rightSide = this.inputText.slice(this.inputPosition);
      this.inputText = this.inputText.slice(0, this.inputPosition) + char + rightSide;
      tty.print(char);
      for (var i = 0; i < rightSide.length; ++i) {
        tty.print(rightSide[i]);
      }
      tty.moveOffset(-rightSide.length);
    }
    ++this.inputPosition;
    this.drawCursor();
  }

  this.removeChar = function() {
    if (this.inputPosition > 0) {
      this.removeCursor();
      if (this.inputPosition >= this.inputText.length) {
        this.inputText = this.inputText.slice(0, -1);
        tty.moveOffset(-1);
      } else {
        var rightSide = this.inputText.slice(this.inputPosition);
        this.inputText = this.inputText.slice(0, this.inputPosition - 1) + rightSide;
        tty.moveOffset(-1);
        for (var i = 0; i < rightSide.length; ++i) {
          tty.print(rightSide[i]);
        }
        tty.print(' ');
        tty.moveOffset(-rightSide.length - 1);
      }
      --this.inputPosition;
      this.drawCursor();
    }
  }

  this.moveCursorLeft = function() {
    if (this.inputPosition > 0) {
      this.removeCursor();
      --this.inputPosition;
      tty.moveOffset(-1);
      this.drawCursor();
    }
  }

  this.moveCursorRight = function() {
    if (this.inputPosition < this.inputText.length) {
      this.removeCursor();
      ++this.inputPosition;
      tty.moveOffset(1);
      this.drawCursor();
    }
  }

  this.clearInputBox = function() {
    while (this.inputPosition < this.inputText.length) {
      this.moveCursorRight();
    }
    while (this.inputPosition > 0) {
      this.removeChar();
    }
  }

  this.setInputBox = function(text) {
    this.removeCursor();
    this.clearInputBox();
    for (var i = 0; i < text.length; ++i) {
      this.inputText += text[i];
      tty.print(text[i]);
      this.inputPosition++;
    }
    this.drawCursor();
  }
}
