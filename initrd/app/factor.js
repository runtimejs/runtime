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

(function() {
  "use strict";

  function readLine(cb) {
    isolate.env.stdin({
      mode: 'line',
      onData: function(data) {
        cb(data.text);
      }
    });
  }

  function factor(n) {
    var a = [],
      lim = ~~n,
      cofactor;
    for (var d = 2; d <= lim; d++) {
      cofactor = ~~(lim / d);
      if (cofactor * d === lim) {
        lim = cofactor;
        a.push(d--);
      }
    }
    return a;
  }

  var echo = function(data) {
    if (data) {
      console.log(data + ': ' + factor(data).join(' '));
    }
    readLine(echo);
  }

  echo();

})();
