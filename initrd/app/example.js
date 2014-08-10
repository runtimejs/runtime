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

var libfs = function(fs) {
    return {
        readFile: function(path, opts) {
            return fs({
                action: 'readFile',
                path: path,
            });
        },
        stat: function(path) {
            return fs({
                action: 'stat',
                path: path,
            });
        },
    };
};

(function() {
    "use strict";

    // Object 'fs.default' provides access to process working directory
    // filesystem subtree and this is the only subtree that is visible
    // through this object to current process.
    // It's possible to provide 'fs.root' for trusted processes.
    var fs = libfs(isolate.system.fs.current);

    console.log('This is the example application');

    setTimeout(function() {
        console.log('timeout test!');
    }, 2000);

    // open existing file
    fs.readFile('/test.json').then(function(data) {
        console.log(data);
    }, function(err) {
        console.log(err.message);
    });

    // open non-existing file
    fs.readFile('/DOES_NOT_EXIST.json').then(function(data) {
        console.log(data);
    }, function(err) {
        console.log(err.message);
    });

})();
