// Copyright 2014 Runtime.JS project authors
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


(function() {
  "use strict";

  if (isolate.env && isolate.env.stdout && isolate.env.stderr) {
    isolate.env.stderr('shell: nested shells are not supported\n');
    return;
  }

  if (!isolate.data.terminal) {
    throw new Error('shell requires a terminal to output data');
  }

  if (!isolate.data.keyboard) {
    throw new Error('shell requires a keyboard');
  }

  var terminal = isolate.data.terminal;
  var keyboard = isolate.data.keyboard;

  /**
   * Output string to terminal
   * @param {string} text - text to putput
   * @param {string} opts.fg [optional] - text color
   * @param {string} opts.bg [optional] - background color
   * @param {int} opts.repeat [optional] - number of times to repeat output
   * @param {int} opts.x [optional] - move to position (x)
   * @param {int} opts.y [optional] - move to position (y)
   * @param {int} opts.offset [optional] - move position offset (linear)
   * @param {bool} opts.cursor [optional] - print cursor after output
   */
  function print(text, opts) {
    var fg = 'white';
    var bg = 'black';
    var repeat = 1;
    var x, y, offset, cursor, clear;

    if (Object(opts) === opts) {
      if ('string' === typeof opts.fg) {
        fg = opts.fg;
      }

      if ('string' === typeof opts.bg) {
        bg = opts.bg;
      }

      if (opts.repeat) {
        repeat = opts.repeat;
      }

      x = opts.x;
      y = opts.y;
      offset = opts.offset;
      cursor = !!opts.cursor;
      clear = !!opts.clear;
    }

    terminal({
      text: String(text),
      fg: fg,
      bg: bg,
      repeat: repeat >>> 0,
      x: x,
      y: y,
      offset: offset,
      cursor: cursor,
      clear: clear
    });
  }

  var isProgramActive = null;
  var stdinOpts = {
    mode: 'line',
    onData: null
  };

  var prompt = (function() {
    var inputText = '';
    var inputEnteredFn = null;

    function printPrompt() {
      print('/ ', {cursor: true, fg: 'yellow'});
      print('$ ', {cursor: true, fg: 'lightgreen'});
    }

    keyboard.addListener(function(data) {
      if (isProgramActive && null === stdinOpts.onData) {
        return;
      }

      if ('pressed' !== data.action) {
        return;
      }

      switch (data.type) {
      case 'f1':
      case 'f2':
      case 'f3':
      case 'f4':
        break;
      case 'character':
        inputText += data.character;
        print(data.character, {fg: 'white', cursor: true});
        break;
      case 'backspace':
        if (inputText.length > 0) {
          inputText = inputText.slice(0, -1);
          print('', {cursor: true, offset: -1});
        }
        break;
      case 'enter':
        print('\n', {cursor: true});
        if (stdinOpts.onData) {
          stdinOpts.onData({text: inputText});
          stdinOpts.onData = null;
          stdinOpts.mode = 'line';
        } else if (inputEnteredFn) {
          inputEnteredFn(inputText);
        }
        inputText = '';
        break;
      }
    });

    return {
      setInputHandler: function(fn) {
        inputEnteredFn = fn;
      },
      display: function() {
        printPrompt();
      }
    };
  })();

  var shellEnv = {
    stdout: function(text, opts) {
      print(text, opts);
    },
    stderr: function(text, opts) {
      // Ensure object
      if (Object(opts) !== opts) {
        opts = {};
      }

      // Use red color for stderr messages by default
      if ('string' !== typeof opts.fg) {
        opts.fg = 'lightred';
      }

      print(text, opts);
    },
    stdin: function(opts) {
      if (!opts.onData) {
        return;
      }

      if ('string' !== opts.mode) {
        opts.mode = 'line';
      }

      stdinOpts.onData = opts.onData;
      stdinOpts.mode = opts.mode;
      print('', {cursor: true});
    },
  };

  function disablePrompt() {
    isProgramActive = true;
  }

  function restorePrompt() {
    isProgramActive = false;
    stdinOpts.mode = 'line';
    stdinOpts.onData = null;
    prompt.display();
  }

  function shellError(text) {
    print('shell: ' + text + '\n', {fg: 'lightred'});
  }

  function inputHandler(text) {
    disablePrompt();
    text = text.trim();

    if ('' === text) {
      restorePrompt();
      return;
    }

    var programName = '';
    var programArgs = '';

    var firstSpaceIndex = text.indexOf(' ');
    if (-1 !== firstSpaceIndex) {
      programName = text.slice(0, firstSpaceIndex);
      programArgs = text.slice(firstSpaceIndex + 1);
    } else {
      programName = text;
    }

    isolate.system.fs.current({
      action: 'spawn',
      path: '/' + programName + '.js',
      data: {
        command: programArgs
      },
      env: shellEnv,
      onExit: function(result) {
        restorePrompt();
      }
    }).then(function() {}, function(err) {
      var message = 'unknown error';
      switch(err.message) {
        case 'NOT_FOUND': message = 'command "' + programName + '" not found'; break;
      }

      shellError(message);
      restorePrompt();
    });
  }

  prompt.setInputHandler(inputHandler);
  prompt.display();

  var cmd = kernel.getCommandLine().trim().split(' ');
  if (cmd.length > 1) {
    var command = cmd.slice(1).map(function(x) {
      return String(x).replace(/"/g, '');
    }).join(' ');
    print('Starting ' + command + '\n');
    inputHandler(command);
  }
})();
