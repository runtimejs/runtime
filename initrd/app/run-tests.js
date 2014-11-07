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

  var nameRegex = /^.+\.js$/;

  isolate.system.fs.current({
    action: 'list',
    path: '/test',
  }).then(function(data) {
    data.forEach(function(name) {
      // TODO: stat every file
      if (!nameRegex.test(name)) {
        return;
      }

      isolate.env.stdout(' * ', {fg: 'yellow'});
      isolate.env.stdout(name, {fg: 'lightgray'});
      try {
        require('/test/' + name.replace(/\.js$/, ''));
        isolate.env.stdout(' ok\n', {fg: 'lightgreen'});
      } catch (err) {
        isolate.env.stdout(' <FAIL>\n', {fg: 'lightred'});
        console.error(err.stack);
      }

    });

  }).catch(function(err) {
    console.error(err.stack);
  });
})();
