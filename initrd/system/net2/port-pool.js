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
var portUtils = require('./port-utils');

var portEphemeralFirst = 49152;
var portEphemeralLast = 65535;

// TODO: randomize
var portEphemeralCurrent = portEphemeralFirst;

function PortPool() {
  this.allocated = new Set();
}

PortPool.prototype.alloc = function(port) {
  assert(portUtils.isPort(port));
  if (this.allocated.has(port)) {
    return false;
  }

  this.allocated.add(port);
  return true;
};

PortPool.prototype.free = function() {
  assert(portUtils.isPort(port));
  this.allocated.delete(port);
};

PortPool.prototype.getEphemeral = function() {
  for (var i = 0; i < 1000; ++i) {
    if (this.alloc(portEphemeralCurrent)) {
      return portEphemeralCurrent++;
    } else {
      if (++portEphemeralCurrent > portEphemeralLast) {
        portEphemeralCurrent = portEphemeralFirst;
      }
    }
  }

  return 0;
};

module.exports = PortPool;
