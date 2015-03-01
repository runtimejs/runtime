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

function readloop(pipe, fn) {
  pipe.read(function f(val) {
    fn(val);
    pipe.read(f);
  });
}

// Some profiler data
var requestCount = 0;
var expectRequests = 200;

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

// Very limited binary data encoder/decoder support
// https://encoding.spec.whatwg.org/
var enc = new TextEncoder('utf-8');
var dec = new TextDecoder('utf-8');

var responseBuffer = enc.encode(response.join('\r\n')).buffer;

/**
 * Handle HTTP request
 */
function httpHandler(socket) {
  // Profiler (should be enabled in kernel, otherwise noop)
  if (100 === requestCount) {
    kernel.startProfiling();
  }

  // Pull next (and single) buffer from socket
  socket.read(function(buf) {

    // Decode ArrayBuffer into string
    var message = dec.decode(buf);

    // Print some log data
    // isolate.env.stdout(message.split('\r\n').join('\n'));

    // Push response and close pipe
    socket.write(responseBuffer.slice(0));
    socket.close();

    // Profiler (should be enabled in kernel, otherwise noop)
    if (expectRequests === ++requestCount) {
      // Timeout to make sure system is done with a connection
      setTimeout(kernel.stopProfiling, 500);
    }
  });
}

function init() {
  var socket = isolate.sync(isolate.system.tcpSocket.createSocket());
  readloop(socket, httpHandler);
  isolate.sync(socket.listen(9000));
  console.log('tcp server listening to port 9000');
}

init();
