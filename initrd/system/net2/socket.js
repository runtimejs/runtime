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

var assert = require('assert');
var IP4Address = require('./ip4-address');
var portUtils = require('./port-utils');

function Socket() {
  this.srcPort = 0;
  this.destPort = 0;
  this.srcIP = IP4Address.ANY;
  this.destIP = IP4Address.ANY;
}

Socket.prototype.bind = function(port) {
  assert(portUtils.isPort(port));
  this.port = port;
};



module.exports = Socket;
