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

/* global kernel */
var kernelVersion = kernel.version().runtime; // Format [major, minor, rev]
var requiredVersionMin = [0, 1]; // 0.1.x
var requiredVersionMax = [0, 1]; // 0.1.x

if (kernelVersion[0] < requiredVersionMin[0] ||
    kernelVersion[1] < requiredVersionMin[1] ||
    kernelVersion[0] > requiredVersionMax[0] ||
    kernelVersion[1] > requiredVersionMax[1]) {
  console.log('='.repeat(60));
  console.log('Loaded runtimejs core module requires runtime version');
  console.log(`      >= ${requiredVersionMin.join('.')}.x`);
  console.log(`      <= ${requiredVersionMax.join('.')}.x`);
  console.log(` current ${kernelVersion.join('.')}`);
  console.log('');
  console.log('Update with "npm install runtime-tools@latest"');
  console.log('='.repeat(60));
  throw new Error('invalid runtime version');
}

console.log(`v${kernelVersion.join('.')} kernel (v8 ${kernel.version().v8})`);
