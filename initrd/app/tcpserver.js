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

var requestCount = 0;
var expectRequests = 100;

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
function httpHandler(socket, writePipe, readPipe) {
  if (0 === requestCount) {
    kernel.startProfiling();
  }

  var enc = new TextEncoder('utf-8');
  var dec = new TextDecoder('utf-8');

  readPipe.pull(function(buffers) {
    for (var i = 0; i < buffers.length; ++i) {
      var buf = buffers[i];
      var message = dec.decode(buf);
      // isolate.env.stdout(message.split('\r\n').join('\n'));

      var response = enc.encode(cachedResponse).buffer;
      writePipe.push(response);
      writePipe.close();

      if (expectRequests === ++requestCount) {
        // Timeout to make sure system is done with a connection
        setTimeout(kernel.stopProfiling, 500);
      }
    }

  });
}

isolate.system.tcpSocket.createSocket().then(function(data) {
  var socket = data.socket;
  var pipe = data.pipe;

  pipe.pull(function pp(data) {
    var socket = data[0];
    var writePipe = data[1];
    var readPipe = data[2];
    httpHandler(socket, writePipe, readPipe);
    pipe.pull(pp);
  });

  return socket.listen(9000);
}).then(function() {
  console.log('tcp server listening to port 9000');
});
