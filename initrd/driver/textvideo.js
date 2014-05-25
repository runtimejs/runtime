// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/**
 * Text video driver which operates on fixed memory buffer to output data
 * Each text cell represented by 2 bytes (char code and color)
 *
 * Arguments format: {
 *   resources: {
 *     videoMemory: {ResourceMemoryBlock} output buffer
 *     width: {integer} buffer width
 *     height: {integer} buffer height
 *   }
 * }
 *
 */

var colors = {
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
    magenta: 13,
    yellow: 14,
    white: 15
};

function Color(fg, bg) {
    this.fg = function() { return fg; }
    this.bg = function() { return bg; }
}

function ColorFormatter() {
    this.color = function __color(color) {
        var fg = colors.white;
        var bg = colors.black;
        var fgcolor = color.fg();
        var bgcolor = color.bg();

        if (colors[fgcolor]) {
            fg = colors[fgcolor];
        }
        if (colors[bgcolor]) {
            bg = colors[bgcolor];
        }

        return ((bg & 0xF) << 4) + (fg & 0xF);
    };
}

function VideoBuffer(arraybuffer, w, h, colorformatter) {
    var view = new Uint8Array(arraybuffer);

    this.set = function __set(x, y, c, color) {
        var offset = y * w + x;
        view[offset * 2] = c.charCodeAt(0);
        view[offset * 2 + 1] = colorformatter.color(color);
    };
}

var args = rt.args();
var resources = args.resources;

var membuf = resources.videoMemory.buffer();
var w = resources.width;
var h = resources.height;

var colorformatter = new ColorFormatter();
var devb = new VideoBuffer(membuf, w, h, colorformatter);
var tmpb = new VideoBuffer(new ArrayBuffer(membuf.length), w, h, colorformatter);

devb.set(0, 0, 'A', new Color('red', 'yellow'));

// view[0] = 'A'.charCodeAt(0);
// view[1] = colors.yellow;

