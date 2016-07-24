// Copyright 2015-present runtime.js project authors
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
const vga = require('./vga');
const buffer = vga.allocBuffer();
buffer.clear(vga.color.BLACK);

let posCurrent = 0;
const w = vga.WIDTH;
const h = vga.HEIGHT;

function refresh() {
  vga.draw(buffer);
}

function scrollUp() {
  buffer.scrollUp(vga.color.BLACK);
  posCurrent -= w;
}

refresh();

exports.color = vga.color;

exports.print = (textOpt = '', repeat = 1, fg = vga.color.WHITE, bg = vga.color.BLACK) => {
  // fix issue #53 where non-strings (ints, etc...) would not get printed
  const text = String(textOpt);

  for (let j = 0; j < repeat; ++j) {
    for (const c of text) {
      if (c === '\n') {
        posCurrent -= (posCurrent % w) - w;
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

exports.moveOffset = (offsetOpt) => {
  const offset = offsetOpt | 0;
  let newPos = posCurrent + offset;
  if (newPos < 0) {
    newPos = 0;
  }

  if (newPos >= w * h) {
    newPos = (w * h) - 1;
  }

  posCurrent = newPos;
};

exports.moveTo = (xOpt, yOpt) => {
  let x = xOpt;
  let y = yOpt;
  if (x < 0) {
    x = 0;
  }
  if (x >= w) {
    x = w - 1;
  }
  if (y < 0) {
    y = 0;
  }
  if (y >= h) {
    y = h - 1;
  }
  posCurrent = (y * w) + x;
};
