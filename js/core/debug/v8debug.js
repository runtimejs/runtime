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

 /* eslint-disable camelcase, no-new-func, new-cap */
// V8 specific code
const NATIVE_GetOptimizationStatus = new Function('f', 'return %GetOptimizationStatus(f)');
const NATIVE_OptimizeFunctionOnNextCall = new Function('f', '%OptimizeFunctionOnNextCall(f)');

exports.getOptimizationStatus = (fn) => {
  switch (NATIVE_GetOptimizationStatus(fn)) {
    case 1: return 'optimized';
    case 2: return 'not optimized';
    case 3: return 'always optimized';
    case 4: return 'never optimized';
    case 6: return 'maybe deoptimized';
    default: return 'unknown';
  }
};

exports.optimizeFunctionOnNextCall = NATIVE_OptimizeFunctionOnNextCall;
/* eslint-enable camelcase, no-new-func, new-cap */
