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

const createSuite = require('estap');
const test = createSuite();

test.cb('setTimeout', t => {
  t.plan(1);

  setTimeout(() => {
    t.pass('setTimeout callback');
  }, 0);
});

test.cb('setImmediate', t => {
  t.plan(1);

  setImmediate(() => {
    t.pass('setImmediate callback');
  });
});

test.cb('clearTimeout', t => {
  const timer = setTimeout(() => {
    t.fail('should not call the callback');
  }, 0);
  clearTimeout(timer);
  setTimeout(() => {
    t.pass('cleared timeout');
    t.end();
  }, 0);
});

test.cb('clearInterval', t => {
  const timer = setInterval(() => {
    t.fail('should not call the callback');
  }, 0);
  clearInterval(timer);
  setTimeout(() => {
    t.pass('cleared interval');
    t.end();
  }, 0);
});

test.cb('setInterval multiple calls', t => {
  let i = 0;
  const timer = setInterval(() => {
    if (++i === 3) {
      clearInterval(timer);
      t.pass('wait for 3 intervals');
      t.end();
    }
  }, 100);
});

test.cb('cleared setTimeout should not keep its ref', t => {
  const timer = setTimeout(() => {
    t.fail('should not call the callback');
  }, 1000000);
  clearTimeout(timer);
  t.end();
});

test.cb('unrefTimer with long setTimeout', t => {
  const timer = setTimeout(() => {
    t.fail('should not call the callback');
  }, 1000000);
  __SYSCALL.unrefTimer(timer);
  t.end();
});

test.cb('unrefTimer with long setInterval', t => {
  const timer = setInterval(() => {
    t.fail('should not call the callback');
  }, 1000000);
  __SYSCALL.unrefTimer(timer);
  t.end();
});

test.cb('unrefTimer with clearTimeout', t => {
  t.plan(2);

  const timer1 = setTimeout(() => {
    t.pass('this should fire');
  }, 0);

  const timer2 = setTimeout(() => {
    t.fail('this should not fire');
  }, 10);

  setTimeout(() => {
    t.pass('this should fire');
  }, 100);

  __SYSCALL.unrefTimer(timer1);
  __SYSCALL.unrefTimer(timer2);
  clearTimeout(timer2);
});
