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

(function(args) {
    "use strict";

    function error(text) {
        console.error('cat: ' + text);
    }

    if ('string' !== typeof args.data.command) {
        console.error('cat: no input filenames');
        return;
    }

    var fileNames = args.data.command.split(' ');

    fileNames.forEach(function(filename) {
        args.system.fs.current({
            action: 'readFile',
            path: filename,
        }).then(function(fileContent) {
            args.env.stdout(fileContent);
        }, function(err) {
            var message = 'unknown error';
            switch(err.message) {
                case 'NOT_FOUND': message = 'file "' + filename + '" not found'; break;
            }

            error(message);
        });
    });
})(runtime.args());
