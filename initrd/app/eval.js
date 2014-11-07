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
  isolate.exit();
}

(function() {
  "use strict";

  if ('string' === typeof isolate.data.command && '' !== isolate.data.command) {
    evalLine(isolate.data.command);
    return;
  }

  isolate.env.stdout('JavaScript REPL (special commands: exit)\n', {fg: 'darkgray'});

  function readLine(cb) {
    isolate.env.stdout('> ', {fg: 'lightgreen'});
    isolate.env.stdin({
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
      isolate.env.stdout(result + '\n', {fg: 'lightgray'});
    } catch (err) {
      console.error(err.toString());
    }
  }

  readLine(function onData(text) {
    if ('exit' === text.trim()) {
      isolate.exit();
    }

    evalLine(text);
    readLine(onData);
  });

})();
