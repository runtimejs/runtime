// Copyright 2014-2015 runtime.js project authors
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

'use strict';

/* global runtime */

var resources = require('./resources');
var rawip = null;

runtime.dns.resolve('pool.ntp.org', {}, function(err, res) {
  if (err) return runtime.stdio.defaultStdio.writeError(err);

  rawip = res.results[0].address;

  var ip = new runtime.net.IP4Address(rawip[0], rawip[1], rawip[2], rawip[3]);

  var data = new Uint8Array(48);
  data[0] = 0x1B;
  for (var i = 1; i < 48; i++) {
    data[i] = 0;
  }

  var socket = new runtime.net.UDPSocket();
  socket.onmessage = function(ip, port, u8) {
    var offset = 40;
    var intpart = 0;
    var fractpart = 0;

    for (let i = 0; i <= 3; i++) {
      intpart = 256 * intpart + u8[offset + i];
    }

    for (let i = 4; i <= 7; i++) {
      fractpart = 256 * fractpart + u8[offset + i];
    }

    var milli = (intpart * 1000 + (fractpart * 1000) / 0x100000000);

    var date = new Date('Jan 01 1900 GMT');

    __SYSCALL.setTime((date.getTime() + milli) * 1000);
  }
  setTimeout(function() {
    socket.send(ip, 123, data);
  }, 1000);
});
