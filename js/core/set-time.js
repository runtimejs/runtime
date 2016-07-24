// Copyright 2014-present runtime.js project authors
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

runtime.dns.resolve('pool.ntp.org', {}, (err, res) => {
  if (err) {
    return runtime.stdio.defaultStdio.writeError(err);
  }

  const rawip = res.results[0].address;

  const data = new Uint8Array(48);
  data[0] = 0x1B;
  let i;
  for (i = 1; i < 48; i++) {
    data[i] = 0;
  }

  const socket = new runtime.net.UDPSocket();
  socket.onmessage = (ip, port, u8) => {
    const offset = 40;
    let intpart = 0;
    let fractpart = 0;

    for (i = 0; i <= 3; i++) {
      intpart = (256 * intpart) + u8[offset + i];
    }
    for (i = 4; i <= 7; i++) {
      fractpart = (256 * fractpart) + u8[offset + i];
    }

    const milli = ((intpart * 1000) + ((fractpart * 1000) / 0x100000000));

    const date = new Date('Jan 01 1900 GMT');

    __SYSCALL.setTime((date.getTime() + milli) * 1000);
  };

  const ip = new runtime.net.IP4Address(rawip[0], rawip[1], rawip[2], rawip[3]);

  setTimeout(() => socket.send(ip, 123, data), 1000);
});
