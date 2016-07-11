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

const udp = require('./udp');
const tcp = require('./tcp');
const icmp = require('./icmp');

module.exports = (intf, srcIP, destIP, protocolId, u8, nextOffset) => {
  switch (protocolId) {
    case 0x01: return icmp.receive(intf, srcIP, destIP, u8, nextOffset);
    case 0x06: return tcp.receive(intf, srcIP, destIP, u8, nextOffset);
    case 0x11: return udp.receive(intf, srcIP, destIP, u8, nextOffset);
    default:
      break;
  }
};
