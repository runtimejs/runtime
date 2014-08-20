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

    function ab2str(buf) {
        return String.fromCharCode.apply(null, new Uint8Array(buf));
    }

    var sock = isolate.system.kernel.createSocket('udp', {
        bindPort: 9000,
        event: function(type, data) {
            if ('message' === type) {
                isolate.env.stdout(ab2str(data.buf));
            }
        },
    });

    isolate.env.stdout('Listening to UDP port 9000\n', {fg: 'lightgreen'});
})();
