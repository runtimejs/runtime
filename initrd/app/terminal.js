// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// TODO: move eval scope into other context (thread)
// to provide isolation
var evalScope = (function() {
    "use strict";

    return {
        evaluate: function(text) {
            return (1, eval)(text);
        },
    };
})();

(function(args) {
    "use strict";

    /**
     * Input services client
     */
    var input = (function() {
        var keybd = args.keyboard;
        return {addKeyboardListener: keybd.addListener};
    })();

    /**
     * User interface
     */
    var gui = (function() {
        /**
         * Text video display service client
         */
        var video = (function() {
            var textVideo = args.textVideo;
            var canvasReady = false;

            var width = textVideo.info.width;
            var height = textVideo.info.height;

            function color(fg, bg) {
                if ('undefined' === textVideo.colors[fg]) {
                    fg = 'white';
                }

                if ('undefined' === textVideo.colors[bg]) {
                    bg = 'black';
                }

                var idF = textVideo.colors[fg];
                var idB = textVideo.colors[bg];
                return (((idB & 0xF) << 4) + (idF & 0xF)) >>> 0;
            };

            var drawBuf = null;
            var drawView = null;

            var drawQueue = (function() {
                var data = [];
                var timeoutEnabled = false;

                function flush() {
                    if (null === drawBuf) {
                        return;
                    }

                    if (0 === data.length) {
                        return;
                    }

                    data.forEach(function(cmd) {
                        for (var r = 0; r < cmd.repeat; ++r) {
                            var elements = cmd.text.length;
                            for (var i = 0; i < elements; ++i) {
                                var pos = (cmd.offset + i + elements * r) * 2;
                                drawView[pos] = cmd.text.charCodeAt(i);
                                drawView[pos + 1] = cmd.color;
                            }
                        }
                    });

                    while (data.length > 0) {
                        data.pop();
                    }

                    var buf = drawBuf;
                    drawBuf = null;
                    drawView = null;
                    return textVideo.drawBuffer(buf).then(function(buf) {
                        drawBuf = buf;
                        drawView = new Uint8Array(drawBuf);
                    }, function(err) {
                        rt.log(err.stack);
                    });
                }

                function onTimeout() {
                    flush();
                    timeoutEnabled = false;
                };

                return {
                    add: function(val) {
                        data.push(val);
                        if (!timeoutEnabled) {
                            rt.timeout(onTimeout, 10);
                        }
                    },
                };

            })();

            textVideo.allocBuffers(1).then(function(bufs) {
                drawBuf = bufs[0];
                drawView = new Uint8Array(drawBuf);
            })
            .catch(function(err) {
                rt.log(err.stack);
            });

            return {
                color: color,
                print: function(x, y, text, color, repeat) {
                    if (!repeat) {
                        repeat = 1;
                    }

                    drawQueue.add({
                        offset: y * width + x,
                        text: text,
                        color: color,
                        repeat: repeat,
                    });
                },
                width: width,
                height: height,
            };
        })();

        var color = video.color;
        var textAreaLines = 3;
        var showHeader = true;

        /**
         * Top header line element
         */
        var header = (function() {
            function draw(cons) {
                if (!showHeader) return;

                var name = cons.getName();
                var headerColor = color('lightgreen', 'green');
                video.print(0, 0, ' ', headerColor, video.width);
                video.print(0, 0, '# runtime.js console ' + name, headerColor);
            }

            return {
                draw: draw,
            };
        })();

        /**
         * Console output element
         */
        var outputArea = (function() {
            var firstLine = showHeader ? 1 : 0;
            var lastLine = video.height - textAreaLines;
            var visualLinesCount =  (lastLine - firstLine) >>> 0;
            var textColor = color('darkgray', 'black');
            var lineIndent = 2;
            var maxLineLength = video.width - lineIndent;

            function draw(cons) {
                var lines = cons.getState().lines;

                var firstLineIndex = 0;
                var firstAtTop = firstLine + visualLinesCount - lines.length;
                if (firstAtTop < firstLine) {
                    firstAtTop = firstLine;
                    firstLineIndex = lines.length - visualLinesCount;
                }

                for (var i = firstLine; i < lastLine; ++i) {
                    video.print(lineIndent, i, ' ', textColor, maxLineLength);
                }

                for (var i = firstAtTop; i < lastLine; ++i) {
                    var lineParts = lines[firstLineIndex++];
                    var written = 0;

                    for (var j = 0; j < lineParts.length; ++j) {
                        var part = lineParts[j];
                        video.print(lineIndent + written, i, part.t, part.c);
                        written += part.t.length;
                    }
                }
            }

            return {
                draw: draw,
                maxLineLength: maxLineLength,
            };
        })();

        /**
         * Editable multiline textbox element
         */
        var textArea = (function() {
            var areaLines = textAreaLines;
            var top = video.height - areaLines;
            var textIndent = 2;
            var maxWidth = video.width * areaLines - textIndent - 1;

            var markerColor = color('lightgreen', 'black');
            var textColor = color('white', 'black');
            var cursorColor = color('lightgreen', 'lightgreen');

            function draw(cons) {
                var textChars = cons.getState().textChars;

                var drawText = textChars.join('');
                if (drawText.length >= maxWidth) {
                    drawText = drawText.substr(0, maxWidth);
                }

                for (var i = 0; i < areaLines; ++i) {
                    video.print(0, top + i, ' ', textColor, video.width);
                }

                video.print(0, top, '>', markerColor);
                video.print(textIndent, top, drawText, textColor);
                video.print(drawText.length + textIndent, top, ' ', cursorColor);
            }

            return {
                draw: draw,
                maxWidth: maxWidth,
            };
        })();

        return {
            draw: function(cons) {
                header.draw(cons);
                textArea.draw(cons);
                outputArea.draw(cons);
            },
            outputMaxLineLength: outputArea.maxLineLength,
            editboxWidth: textArea.maxWidth,
            color: color,
        };
    })();

    /**
     * Instance of console. Supports editbox and output console.
     */
    function Console(name) {
        var state = {
            lines: [],
            textChars: [],
        };

        this.getState = function() { return state; }
        this.getName = function() { return name; }
    }

    /**
     * Write text to console using provided color
     */
    Console.prototype.write = function(text, color) {
        if (!this instanceof Console) return;

        var textLen = text.length;
        if (0 === textLen) {
            return;
        }

        var maxLineLength = gui.outputMaxLineLength;

        var lines = this.getState().lines;
        if (0 === lines.length) {
            lines.push([]);
        }

        var start = 0;
        var partCount = 0;
        var lastLineLen = computeLastLineLen();

        function computeLastLineLen() {
            var s = 0;
            lines[lines.length - 1].forEach(function(part) {
                s += part.t.length;
            });

            return s;
        };

        function appendLastLine(start, partCount) {
            lines[lines.length - 1].push({
                t: text.substr(start, partCount),
                c: color
            });
        };

        for (var i = 0; i < textLen; ++i) {
            ++partCount;

            var ca = text.charAt(i);
            if (lastLineLen + partCount >= maxLineLength || '\n' === ca) {
                var vp = partCount - (('\n' === ca) ? 1 : 0);
                if (vp > 0) {
                    appendLastLine(start, vp);
                }

                start = i + 1;
                partCount = 0;
                lines.push([]);
                lastLineLen = computeLastLineLen();
            }
        }

        if (partCount > 0) {
            appendLastLine(start, partCount);
        }
    };

    /**
     * Append symbol to console editbox
     */
    Console.prototype.editAppendChar = function(c) {
        if (!this instanceof Console) return;

        var textChars = this.getState().textChars;
        if (textChars.length >= gui.editboxWidth) {
            return;
        }

        textChars.push(c.charAt(0));
    };

    /**
     * Send backspace to console editbox
     */
    Console.prototype.editBackspace = function() {
        if (!this instanceof Console) return;

        var textChars = this.getState().textChars;
        textChars.pop();
    };

    /**
     * Clear editbox
     */
    Console.prototype.editClear = function() {
        if (!this instanceof Console) return;

        var textChars = this.getState().textChars;
        while (textChars.length > 0) {
            textChars.pop();
        }
    };

    /**
     * Get text from editbox
     */
    Console.prototype.editGetText = function() {
        if (!this instanceof Console) return;

        var textChars = this.getState().textChars;
        return textChars.join('');
    };

    /**
     * Manages multiple consoles
     */
    var terminal = (function() {
        var messageColor = gui.color('darkgray', 'black');
        var messageColorLight = gui.color('lightgray', 'black');
        var items = [];
        var activeConsole = 0;

        for (var i = 0; i < 10; ++i) {
            var name = '#' + i;
            var cons = new Console(name);
            cons.write('Welcome to ', messageColor);
            cons.write('runtime.js', messageColorLight);
            cons.write(' (console ' + name + ')\n\n', messageColor);
            items.push(cons);
        }

        function setConsole(index) {
            if (index >= items.length) {
                throw new Error('invalid console index');
            }

            activeConsole = index;
        }

        setConsole(0);

        function getActiveConsole() {
            return items[activeConsole];
        }

        return {
            setActiveConsoleIndex: setConsole,
            getActiveConsole: getActiveConsole,
        };
    })();

    /**
     * Callback for keyboard events
     */
    input.addKeyboardListener(function(data) {
        if ('pressed' !== data.action) {
            return;
        }

        var cons = terminal.getActiveConsole();

        switch (data.type) {
        case 'f1': terminal.setActiveConsoleIndex(0); break;
        case 'f2': terminal.setActiveConsoleIndex(1); break;
        case 'f3': terminal.setActiveConsoleIndex(2); break;
        case 'f4': terminal.setActiveConsoleIndex(3); break;
        case 'character':
            cons.editAppendChar(data.character);
            break;
        case 'backspace':
            cons.editBackspace();
            break;
        case 'enter':
            var text = cons.editGetText();
            if (0 === text.length) {
                break;
            }

            var textColorDefault = gui.color('darkgray', 'black');
            var textColorLight = gui.color('lightgray', 'black');
            var textColorError = gui.color('lightred', 'black');

            cons.write('> ' + text + '\n', textColorDefault);

            try {
                var result = evalScope.evaluate(text);
                cons.write(result + '\n\n', textColorLight);
            } catch(e) {
                cons.write(e.toString() + '\n\n', textColorError);
            }

            cons.editClear();
            break;
        }

        gui.draw(terminal.getActiveConsole());
    });

    terminal.setActiveConsoleIndex(0);
    gui.draw(terminal.getActiveConsole());

})(rt.args());
