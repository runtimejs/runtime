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
var Interface = require('./interface');

var intfs = [];

exports.interfaceAdd = function(opts) {
  var intf = new Interface(opts.macAddress)
  intf.setName('intf' + intfs.length);
  intf.setBufferDataOffset(opts.bufferDataOffset);
  intfs.push(intf);
  return intf;
};
