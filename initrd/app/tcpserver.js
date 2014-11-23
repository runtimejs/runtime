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
 * This is HTTP server example
 */

// Some profiler data
var requestCount = 0;
var expectRequests = 100;

// Cached body
var body = '<html><body>Hello World!</body></html>';
var response = [
  'HTTP/1.1 200 OK',
  'Content-Type: text/html',
  'Connection: close',
  'Content-Length: ' + body.length,
  '',
  body
];

var cachedResponse = response.join('\r\n');

/**
 * Handle HTTP request
 */
function httpHandler(socket, netsend, netrecv) {
  // Profiler (should be enabled in kernel, otherwise noop)
  if (0 === requestCount) {
    kernel.startProfiling();
  }

  // Very limited binary data encoder/decoder support
  // https://encoding.spec.whatwg.org/
  var enc = new TextEncoder('utf-8');
  var dec = new TextDecoder('utf-8');

  // Pull next (and single) buffer from receive pipe
  netrecv.pull(function(buf) {

    // Decode ArrayBuffer into string
    var message = dec.decode(buf);

    // Print some log data
    // isolate.env.stdout(message.split('\r\n').join('\n'));

    // Prepare response buffer
    var response = enc.encode(cachedResponse).buffer;

    // Push response and close pipe
    netsend.push(response);
    netsend.close();

    // Profiler (should be enabled in kernel, otherwise noop)
    if (expectRequests === ++requestCount) {
      // Timeout to make sure system is done with a connection
      setTimeout(kernel.stopProfiling, 500);
    }
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
    httpHandler(socket, netsend, netrecv);

    // Pull next connection again
    pipe.pull(pp);
  });

  // Listen to TCP port
  return socket.listen(9000);
}).then(function() {
  console.log('tcp server listening to port 9000');
});
