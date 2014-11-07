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

  var headerColor = 'yellow';
  var itemColor = 'white';

  isolate.system.kernel.isolatesInfo().then(function(info) {
    isolate.env.stdout('Isolate', {x: 0, fg: headerColor});
    isolate.env.stdout('Events count', {x: 20, fg: headerColor});
    isolate.env.stdout('Runtime (ms)', {x: 40, fg: headerColor});
    isolate.env.stdout('\n');

    for (var i = 0; i < info.length; ++i) {
      var item = info[i];
      var name = item.name;
      var color = itemColor;

      if (0 === i) {
        // Skip idle isolate
        continue;
      }

      if (1 === i) {
        name = 'kernel';
      }

      var ms = Number(item.runtime) / 1000;
      isolate.env.stdout(name, {x: 0, fg: color});
      isolate.env.stdout(item.eventsCount, {x: 20, fg: color});
      isolate.env.stdout(ms, {x: 40, fg: color});
      isolate.env.stdout('\n');
    }
  });
})();
