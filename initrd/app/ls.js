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

    // TODO: fix hardcoded view width
    var width = 80;
    var columns = 4;

    var jsRegex = /\.js$/;

    function printFiles(data) {
        data.sort();

        for (var i = 0; i < data.length; ++i) {
            var name = data[i];
            var color = 'white';

            // TODO: stat every entry
            if (jsRegex.test(name)) {
                color = 'lightred';
            }

            isolate.env.stdout(name, {fg: color, x: (i % columns) * width / columns});
            if (((columns - 1) === (i % columns)) && (i !== data.length - 1)) {
                isolate.env.stdout('\n');
            }
        }

        isolate.env.stdout('\n');
    }

    function error(err) {
        console.error(err.message);
        isolate.exit();
    }

    isolate.system.fs.current({
        action: 'list',
        path: '/',
    }).then(printFiles, error);
})();
