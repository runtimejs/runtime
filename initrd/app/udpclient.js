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

  var udpSocketApi = isolate.system.udpSocket;
  var udpSocket = null;

  function onMessage(data) {
    var str = runtime.bufferToString(data.buf);
    console.log(str);
    isolate.exit();
  }

  function send(str) {
    var buf = runtime.toBuffer(str);
    udpSocket.send('104.131.24.225' /* runtimetest.org TODO: use DNS resolver */, 9000, buf);
  }

  function onError() {
    isolate.error('System error');
    isolate.exit();
  }

  udpSocketApi.createSocket(onMessage, onError)
    .then(function(socket) {
      udpSocket = socket;
      return socket;
    })
    .catch(onError);

  function readLine(cb) {
    isolate.env.stdout('Enter your message: ');
    isolate.env.stdin({
      mode: 'line',
      onData: function(data) {
        cb(data.text);
      }
    });
  }

  readLine(function(text) {
    send(text);

    setTimeout(function() {
      console.error('Timed out');
      isolate.exit();
    }, 5000);
  });
})();
