// Copyright 2015-present runtime.js project authors
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

const interfaces = require('../core/net/interfaces');

function mem() {
  return Math.pow(2, 32);
}

Object.assign(exports, {
  EOL: '\n',
  arch: () => process.arch,
  cpus: () => [],
  endianness: () => 'LE',
  freemem: mem,
  totalmem: mem,
  homedir: () => '/',
  hostname: () => 'runtime',
  loadavg: () => [0, 0, 0],
  networkInterfaces() {
    const ret = {};
    for (const intf of interfaces.getAll()) {
      ret[intf.name] = [{
        address: intf.ipAddr.toString(),
        netmask: intf.netmask.toString(),
        family: 'IPv4',
        mac: intf.macAddr.toString(),
        internal: false, // since it's unknown whether it's internal, let's go with false by default
      }];
    }
    return ret;
  },
  platform: () => process.platform,
  release: () => __SYSCALL.version().kernel,
  uptime: process.uptime,
  tmpdir: () => '/tmp',
  type: () => 'runtime',
});
