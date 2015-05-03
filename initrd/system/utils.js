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

define('utils', [],
function() {
  function waitFor(conditionFunc, delay, maxRetry) {
    if ('undefined' ===  typeof delay) {
      delay = 1;
    }

    if ('undefined' ===  typeof maxRetry) {
      maxRetry = 0;
    }

    return new Promise(function(resolve, reject) {
      var count = 0;

      if (conditionFunc()) {
        resolve();
        return;
      }

      var timeoutFunc = function() {
        ++count;

        if (0 !== maxRetry && count > maxRetry) {
          reject();
          return;
        }

        if (conditionFunc()) {
          resolve();
          return;
        }

        setTimeout(timeoutFunc, delay);
      };

      setTimeout(timeoutFunc, delay);
    });
  };

  var crc32 = (function() {
    function makeTable() {
      var c, table = new Uint32Array(256);
      for (var n = 0; n < 256; ++n) {
        c = n;
        for (var k = 0; k < 8; ++k) {
          c = ((c & 1) ? (0xedb88320 ^ (c >>> 1)) : (c >>> 1));
        }
        table[n] = c;
      }
      return table;
    }

    var table = makeTable();

    return function(buf, offset) {
      var crc = 0 ^ (-1);
      for (var i = offset >>> 0, l = buf.length; i < l; ++i) {
        crc = (crc >>> 8) ^ table[(crc ^ buf[i]) & 0xff];
      }

      return (crc ^ -1) >>> 0;
    };
  })();

  // if (2240272485 !== crc32(new Uint8Array([97, 98, 99, 100, 101]))) {
  //     throw new Error('crc32 test failed');
  // }

  return {
    waitFor: waitFor,
    crc32: crc32,
  };
});
