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

/**
 * Connection handler
 *
 * @param {handle} socket - client socket
 * @param {pipe} netsend - network send pipe for data output
 * @param {pipe} netrecv - network receive pipe for data input
 */
function connectionHandler(socket, netsend, netrecv) {

   // Pull next buffer from receive pipe
  netrecv.pull(function pf(buf) {

    // Push received buffer into output
    netsend.push(buf);

    // Pull next buffer again
    netrecv.pull(pf);
  });
}

// Create TCP listening socket
isolate.system.tcpSocket.createSocket().then(function(data) {
  // This is the listening socket itself
  var socket = data.socket;

  // This is the new connections pipe
  var pipe = data.pipe;

  // Pull next connection from pipe
  pipe.pull(function pp(data) {

    // Unpack data and call connection handler
    var socket = data[0];
    var netsend = data[1];
    var netrecv = data[2];
    connectionHandler(socket, netsend, netrecv);

    // Pull next connection again
    pipe.pull(pp);
  });

  // Listen to TCP port
  return socket.listen(9000);
}).then(function() {
  console.log('tcp echo server listening to port 9000');
});
