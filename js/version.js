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
var kernelVersion = kernel.version().runtime; // Format [major, minor, rev]
var requiredVersionMin = [0, 1, 6];
var requiredVersionMax = [0, 1, 7];

if (kernelVersion[0] < requiredVersionMin[0] ||
    kernelVersion[1] < requiredVersionMin[1] ||
    kernelVersion[2] < requiredVersionMin[2] ||
    kernelVersion[0] > requiredVersionMax[0] ||
    kernelVersion[1] > requiredVersionMax[1] ||
    kernelVersion[2] > requiredVersionMax[2]) {
  console.log('='.repeat(60))
  console.log('Loaded runtimejs core module requires runtime version');
  console.log('      >= ', requiredVersionMin.join('.'));
  console.log('      <= ', requiredVersionMax.join('.'));
  console.log(' current ', kernelVersion.join('.'));
  console.log('');
  console.log('Update with "npm install runtime-tools@latest"');
  console.log('='.repeat(60))
  throw new Error('invalid runtime version');
}
