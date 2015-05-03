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

var resources = require('../resources');
var driverUtils = require('../driver-utils');

// Take ownership of the display
resources.natives.stopVideoLog();

var w = 80;
var h = 25;
var len = w * h;
var buf = driverUtils.physicalMemory(0xb8000, len * 2).buffer();
var b = new Uint8Array(buf);

exports.WIDTH = w;
exports.HEIGHT = h;

var color = {
  BLACK: 0,
  BLUE: 1,
  GREEN: 2,
  CYAN: 3,
  RED: 4,
  MAGENTA: 5,
  BROWN: 6,
  LIGHTGRAY: 7,
  DARKGRAY: 8,
  LIGHTBLUE: 9,
  LIGHTGREEN: 10,
  LIGHTCYAN: 11,
  LIGHTRED: 12,
  LIGHTMAGENTA: 13,
  YELLOW: 14,
  WHITE: 15
};

exports.color = color;

function getColor(fg, bg) {
  return (((bg & 0xF) << 4) + (fg & 0xF)) >>> 0;
};

function setCharXY(u8, x, y, char, fg, bg) {
  if (x < 0 || x >= w) {
    throw new Error('vga error: x is out of bounds');
  }

  if (y < 0 || y >= h) {
    throw new Error('vga error: y is out of bounds');
  }

  var offset = y * w + x;
  setCharOffset(u8, offset, char, fg >>> 0, bg >>> 0);
}

function setCharOffset(u8, offset, char, fg, bg) {
  if (offset < 0 || offset >= w * h) {
    throw new Error('vga error: offset is out of bounds');
  }

  u8[offset * 2] = char.charCodeAt(0);
  u8[offset * 2 + 1] = getColor(fg, bg);
}

function VGABuffer() {
  this.b = new Uint8Array(len * 2);
}

function testInstance(obj) {
  if (!(obj instanceof VGABuffer)) {
    throw new Error('VGABuffer instance required');
  }
}

function testColor(value, def) {
  if ((value >>> 0) !== value) {
    throw new Error('invalid color value');
  }
}

VGABuffer.prototype.setXY = function(x, y, char, fg, bg) {
  testInstance(this);
  testColor(fg);
  testColor(bg);
  setCharXY(this.b, x, y, String(char), fg, bg);
};

VGABuffer.prototype.setOffset = function(offset, char, fg, bg) {
  testInstance(this);
  testColor(fg);
  testColor(bg);
  setCharOffset(this.b, offset, String(char), fg, bg);
};

VGABuffer.prototype.clear = function(bg) {
  testInstance(this);
  testColor(bg);
  for (var i = 0; i < w * h; ++i) {
    setCharOffset(this.b, i, ' ', bg, bg);
  }
};

VGABuffer.prototype.scrollUp = function(bg) {
  testInstance(this);
  testColor(bg);
  this.b.set(this.b.subarray(w * 2, w * h * 2));
  for (var t = 0; t < w; ++t) {
    setCharXY(this.b, t, h - 1, ' ', bg, bg);
  }
};

exports.draw = function(buf) {
  testInstance(buf);
  b.set(buf.b);
};

exports.allocBuffer = function() {
  return new VGABuffer();
};
