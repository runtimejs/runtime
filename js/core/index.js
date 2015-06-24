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

/* global isolate, runtime */
console.log = isolate.log;
var resources = require('./resources');
require('./polyfill');

var tty = require('./tty');
var keyboard = require('./keyboard');
var ps2 = require('./ps2');
var pci = require('./pci');
var net = require('./net');
var stdio = require('./stdio');
var initio = require('./initio');

function copy(source, dest) {
  for (var obj in source) {
    dest[obj] = source[obj];
  }
}

function Runtime() {
  var self = this;
  this.tty = {
    StdOut: stdio.StdOut,
    StdIn: stdio.StdIn
  };
  // Copy everything from `tty` to `this.tty`
  copy(tty, this.tty);
  this.keyboard = keyboard;
  this.pci = pci;
  this.ps2 = ps2;
  this.allocator = resources.allocator;
  this.net = net;
  this.bufferAddress = runtime.bufferAddress; // fixme
  this.debug = runtime.debug; // fixme
  this.machine = {
    reboot: resources.natives.reboot,
    shutdown: function() {
      resources.acpi.enterSleepState(5);
    }
  };
}

global.runtime = module.exports = new Runtime();

runtime.tty.stdout = new runtime.tty.StdOut();
runtime.tty.stdin = new runtime.tty.StdIn();
initio(runtime);

runtime.stdio = {
  stdout: runtime.tty.stdout,
  stdin: runtime.tty.stdin,
  StdIn: runtime.tty.StdIn,
  StdOut: runtime.tty.StdOut,
  createOut: function(funcs) {
    if (funcs) {
      funcs.onwrite = funcs.onwrite || runtime.stdio.stdout.onwrite;
      funcs.onsetcolor = funcs.onsetcolor || runtime.stdio.stdout.onsetcolor;
      funcs.onsetbackgroundcolor = funcs.onsetbackgroundcolor || runtime.stdio.stdout.onsetbackgroundcolor;
    }

    var newout = new runtime.stdio.StdOut();
    newout.onwrite = funcs.onwrite;
    newout.onsetcolor = funcs.onsetcolor;
    newout.onsetbackgroundcolor = funcs.onsetbackgroundcolor;
    return newout;
  },
  createIn: function(funcs) {
    if (funcs) {
      funcs.onread = funcs.onread || runtime.stdio.stdin.onread;
      funcs.onreadline = funcs.onreadline || runtime.stdio.stdin.onreadline;
    }

    var newin = new runtime.stdio.StdIn();
    newin.onread = funcs.onread;
    newin.onreadline = funcs.onreadline;

    return newin;
  }
};

global.env = {
  stdout: runtime.stdio.stdout,
  stdin: runtime.stdio.stdin
};
