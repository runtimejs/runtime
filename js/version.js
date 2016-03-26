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

/* global __SYSCALL */
if (!global.__SYSCALL) {
  throw 'error: this program requires runtime.js environment';
}

var requiredKernelVersion = require('../runtimecorelib.json').kernelVersion;
var currentKernelVersion = __SYSCALL.version().kernel;

if (currentKernelVersion !== requiredKernelVersion) {
  throw `error: required kernel version number ${requiredKernelVersion}, current ${currentKernelVersion}`;
}

console.log(`Kernel build #${currentKernelVersion} (v8 ${__SYSCALL.version().v8})`);
