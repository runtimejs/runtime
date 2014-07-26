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

function exit() {
    runtime.exit();
}

(function(args) {
    "use strict";

    if ('string' === typeof args.data.command && '' !== args.data.command) {
        evalLine(args.data.command);
        return;
    }

    args.env.stdout('JavaScript REPL (special commands: exit)\n', {fg: 'darkgray'});

    function readLine(cb) {
        args.env.stdout('> ', {fg: 'lightgreen'});
        args.env.stdin({
            mode: 'line',
            onData: function(data) {
                cb(data.text);
            }
        });
    }

    function evalLine(text) {
        text = text.trim();

        if ('' === text) {
            return;
        }

        try {
            var result = (1, eval)(text);
            args.env.stdout(result + '\n', {fg: 'lightgray'});
        } catch (err) {
            console.error(err.toString());
        }
    }

    readLine(function onData(text) {
        if ('exit' === text.trim()) {
            runtime.exit();
        }

        evalLine(text);
        readLine(onData);
    });

})(runtime.args());
