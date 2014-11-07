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

  /**
   * Text video display service client
   */
  var video = (function() {
    var textVideo = isolate.env.textVideo;
    var canvasReady = false;

    var width = textVideo.info.width;
    var height = textVideo.info.height;

    var posCurrent = 0;

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

    var cursorColor = color('lightgreen', 'lightgreen');
    var clearColor = color('black', 'black');
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
          // Always clear cursor before output
          drawView[posCurrent * 2] = ' ';
          drawView[posCurrent * 2 + 1] = clearColor;

          if (cmd.clear) {
            for (var t = 0; t < height * width * 2; ++t) {
              drawView[t] = 0;
            }
          }

          if ('number' === typeof cmd.x) {
            posCurrent -= posCurrent % width - cmd.x;
          }

          if ('number' === typeof cmd.y) {
            posCurrent = posCurrent % width + cmd.y * width;
          }

          if ('undefined' !== typeof cmd.offset) {
            posCurrent += cmd.offset;
          }

          if ('undefined' === typeof cmd.repeat) {
            cmd.repeat = 0;
          }

          if ('string' !== typeof cmd.text) {
            cmd.text = '';
          }

          function ensureScrolled() {
            if (posCurrent >= width * height) {
              drawView.set(drawView.subarray(width * 2, width * height * 2));

              for (var t = 0; t < width * 2; ++t) {
                drawView[width * (height - 1) * 2 + t] = 0;
              }

              posCurrent -= width;
            }
          }

          for (var r = 0; r < cmd.repeat; ++r) {
            var elements = cmd.text.length;
            for (var i = 0; i < elements; ++i) {
              var ccode = cmd.text.charCodeAt(i);
              var cr = cmd.text.charAt(i);

              // Newline handling
              if ('\n' === cr) {
                posCurrent -= posCurrent % width - width;
                ensureScrolled();
                continue;
              }

              ensureScrolled();

              // Write data into memory
              drawView[posCurrent * 2] = ccode;
              drawView[posCurrent * 2 + 1] = color(cmd.fg, cmd.bg);
              ++posCurrent;
            }
          }

          if (cmd.cursor) {
            drawView[posCurrent * 2] = ' ';
            drawView[posCurrent * 2 + 1] = cursorColor;
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
          isolate.log(err.stack);
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
            setTimeout(onTimeout, 10);
          }
        },
      };

    })();

    textVideo.allocBuffers(1).then(function(bufs) {
      drawBuf = bufs[0];
      drawView = new Uint8Array(drawBuf);
    })
    .catch(function(err) {
      isolate.log(err.stack);
    });

    return {
      color: color,
      moveTo: function(x, y) {
        drawQueue.add({
          x: x,
          y: y,
        });
      },
      moveOffset: function(offset) {
        drawQueue.add({offset: offset});
      },
      print: function(text, repeat, fg, bg) {
        if (!repeat) {
          repeat = 1;
        }

        if (!fg) {
          fg = 'white';
        }

        if (!bg) {
          bg = 'black';
        }

        drawQueue.add({
          text: text,
          repeat: repeat,
          fg: fg,
          bg: bg,
        });
      },
      command: function(cmd) {
        if ('string' !== typeof cmd.fg) {
          cmd.fg = 'white';
        }

        if ('string' !== typeof cmd.bg) {
          cmd.bg = 'black';
        }

        if ('number' !== typeof cmd.repeat) {
          cmd.repeat = 1;
        }

        drawQueue.add(cmd);
      },
      width: width,
      height: height,
    };
  })();

  var version = kernel.version();

  video.print('\n', 1, 'darkgray', 'black');
  video.print('# Welcome to ', 1, 'darkgray', 'black');
  video.print('runtime.js ', 1, 'lightgray', 'black');
  video.print('v' + version.runtime.join('.') + ' on', 1, 'darkgray', 'black');
  video.print(' V8 ', 1, 'lightgray', 'black');
  video.print(version.v8 + '\n\n', 1, 'darkgray', 'black');

  function createTerminalAccessor() {
    return function(cmd) {
      return new Promise(function(resolve, reject) {
        if (Object(cmd) !== cmd) {
          return reject(new Error('invalid options object'));
        }

        video.command(cmd);
        resolve(true);
      });
    };
  }

  isolate.system.fs.current({
    action: 'spawn',
    path: '/shell.js',
    data: {
      terminal: createTerminalAccessor(),
      keyboard: isolate.env.keyboard
    },
  });
})();
