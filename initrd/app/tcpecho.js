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

"use strict";

/**
 * This is simple TCP echo server example
 */

function readloop(pipe, fn) {
  pipe.read(function f(val) {
    fn(val);
    pipe.read(f);
  });
}

/**
 * Connection handler
 * @param {handle} socket - client socket
 */
function connectionHandler(socket) {
  readloop(socket, function(buf) {

    // Echo data back
    socket.write(buf);
  });
}

function init() {
  var socket = isolate.sync(isolate.system.tcpSocket.createSocket());
  readloop(socket, connectionHandler);
  isolate.sync(socket.listen(9000));
  console.log('tcp echo server listening to port 9000');
}

init();
