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

var resources = require('../resources')();
var driverUtils = require('../driver-utils');

// Take ownership of the display
resources.natives.stopVideoLog();

var w = 80, h = 25, len = w * h;
var buf = driverUtils.physicalMemory(0xb8000, len * 2).buffer();
var b = new Uint8Array(buf);

module.exports = {
  client: {
    drawBuffer: function(buf) {
      b.set(new Uint8Array(buf));
      return Promise.resolve(buf);
    },
    allocBuffers: function(count) {
      var a = new Array(count);
      for (var i = 0; i < count; ++i) {
        a[i] = new ArrayBuffer(len * 2);
      }

      return Promise.resolve(a);
    },
    colors: {
      black: 0,
      blue: 1,
      green: 2,
      cyan: 3,
      red: 4,
      magenta: 5,
      brown: 6,
      lightgray: 7,
      darkgray: 8,
      lightblue: 9,
      lightgreen: 10,
      lightcyan: 11,
      lightred: 12,
      lightmagenta: 13,
      yellow: 14,
      white: 15
    },
    info: {
      width: w,
      height: h,
    },
  },
};
