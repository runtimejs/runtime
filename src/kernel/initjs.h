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

#pragma once

const char INIT_JS[] = R"JAVASCRIPT(
// JS code to prepare runtime.js environment
var console = (function() {
  var times = {};

  return {
    log: __SYSCALL.log,
    error: __SYSCALL.log,
    time: function(label) {
      times['l' + label] = Date.now();
    },
    timeEnd: function(label) {
      var time = times['l' + label];
      if ('undefined' === typeof time) {
        return;
      }

      var d = Date.now() - time;
      __SYSCALL.log(label + ': ' + d/1000 + 'ms' + '\n');
      times['l' + label] = void 0;
    },
  };
})();
// No more code here
)JAVASCRIPT";
