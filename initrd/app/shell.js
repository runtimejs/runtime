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


(function(args) {
    "use strict";

    if (!args.data.terminal) {
        throw new Error('shell requires a terminal to output data');
    }

    if (!args.data.keyboard) {
        throw new Error('shell requires a keyboard');
    }

    var terminal = args.data.terminal;
    var keyboard = args.data.keyboard;

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
        var x, y, offset, cursor;

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
        }

        terminal({
            text: text,
            fg: fg,
            bg: bg,
            repeat: repeat >>> 0,
            x: x,
            y: y,
            offset: offset,
            cursor: cursor
        });
    }

    var isProgramActive = null;

    var prompt = (function() {
        var inputText = '';
        var inputEnteredFn = null;

        function printPrompt() {
            print('$ ', {cursor: true});
        }

        keyboard.addListener(function(data) {
            if (isProgramActive) {
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
                if (inputEnteredFn) {
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
            print(text, opts);
        }
    };

    prompt.setInputHandler(function(text) {
        if ('' === text) {
            prompt.display();
            return;
        }

        isProgramActive = true;
        args.system.process.spawn('/test.js', {}, {}, shellEnv, function(value) {
            isProgramActive = false;
            prompt.display();
        });
    });

    prompt.display();

})(runtime.args());
