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

const test = require('tape');

test('setTimeout', t => setTimeout(t.end.bind(t), 0));

test('setImmediate', t => setImmediate(t.end.bind(t)));

test('clearTimeout', (t) => {
  const timer = setTimeout(() => {
    t.fail('should not call callback');
    throw new Error('should not call callback');
  }, 0);
  clearTimeout(timer);
  setTimeout(t.end.bind(t), 0);
});

test('clearInterval', (t) => {
  function timer() {
    setInterval(() => {
      t.fail('should not call callback');
      throw new Error('should not call callback');
    }, 0);
  }
  clearInterval(timer);
  setTimeout(t.end.bind(t), 0);
});
