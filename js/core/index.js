// Copyright 2014-present runtime.js project authors
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

var resources = require('./resources');
require('./polyfill');

var random = require('./random');
var keyboard = require('./keyboard');
var ps2 = require('./ps2');
var pci = require('./pci');
var net = require('./net');
var stdio = require('./stdio');

function Runtime() {
  this.random = random;
  this.keyboard = keyboard;
  this.pci = pci;
  this.ps2 = ps2;
  this.allocator = resources.allocator;
  this.net = net;
  this.stdio = stdio;
  this.machine = {
    reboot: __SYSCALL.reboot,
    shutdown: function() {
      __SYSCALL.acpiEnterSleepState(5);
    }
  };
}

global.runtime = module.exports = new Runtime();
