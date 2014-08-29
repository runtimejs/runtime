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

var expect = require('./lib/expect');

// Variable in global scope
var var1 = { a: 143 };

function fn() {
  // Global variables in function scope
  a = 10;
  b = { hello: 'world' };

  // Local variable
  var c = {r: 10};

  expect(global.a).to.equal(a);
  expect(global.b).to.equal(b);
  expect(global.b.hello).to.equal(b.hello);
  expect(global.c).to.equal(undefined);

  return true;
}

expect(fn()).to.equal(true);
expect(global.var1).to.equal(var1);
