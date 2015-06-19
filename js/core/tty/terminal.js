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
var vga = require('./vga');
var EventController = require('event-controller');
var buffer = vga.allocBuffer();
buffer.clear(vga.color.BLACK);

var posCurrent = 0;
var w = vga.WIDTH;
var h = vga.HEIGHT;

function refresh() {
  vga.draw(buffer);
}

function scrollUp() {
  buffer.scrollUp(vga.color.BLACK);
  posCurrent -= w;
}

refresh();

exports.color = vga.color;

exports.print = function(text, repeat, fg, bg) {
  // fix issue #53 where non-strings (ints, etc...) would not get printed
  text = String(text);

  repeat = repeat || 1;

  if (typeof fg === 'undefined') {
    fg = vga.color.WHITE;
  }

  if (typeof bg === 'undefined') {
    bg = vga.color.BLACK;
  }

  for (var j = 0; j < repeat; ++j) {
    for (var i = 0, l = text.length; i < l; ++i) {
      var c = text.charAt(i);
      if ('\n' === c) {
        posCurrent -= posCurrent % w - w;
        if (posCurrent >= w * h) {
          scrollUp();
        }
      } else {
        if (posCurrent >= w * h) {
          scrollUp();
        }
        buffer.setOffset(posCurrent++, c, fg, bg);
      }
    }
  }

  refresh();
};

exports.get = function() {
  var tty = runtime.tty;
  var inputText = '';
  var inputPosition = 0;
  var history = [''];
  var historyPosition = 0;
  var done = false;
  var inputEnabled = true;
  var endresult = '';
  var controller = new EventController();

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
      controller.dispatch(result);
    } else {
      runtime.keyboard.onKeydown.remove(addinput);
      controller.dispatch(result);
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

  return controller;
}

exports.moveOffset = function(offset) {
  offset = offset | 0;
  var newPos = posCurrent + offset;
  if (newPos < 0) {
    newPos = 0;
  }

  if (newPos >= w * h) {
    newPos = w * h - 1;
  }

  posCurrent = newPos;
};

exports.moveTo = function(x, y) {
  if (x < 0) { x = 0; }
  if (x >= w) { x = w - 1; }
  if (y < 0) { y = 0; }
  if (y >= h) { y = h - 1; }
  posCurrent = y * w + x;
};
