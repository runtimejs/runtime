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

module.exports = {
  isPortValid: function(port) {
    if ('number' !== typeof port) {
      return false;
    }

    if (port <= 0 || port > 65535) {
      return false;
    }

    return true;
  },
  parseIpAddressString: function(ipAddress) {
    var parts = String(ipAddress).split('.').map(function(x) {
      return +x;
    });

    if (4 !== parts.length) {
      return null;
    }

    for (var i = 0; i < 4; ++i) {
      if ((parts[i] & 0xff) !== parts[i]) {
        return null;
      }
    }

    return parts;
  },
};
