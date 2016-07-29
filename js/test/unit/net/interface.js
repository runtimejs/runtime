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

const test = require('tape');
const Interface = require('../../../core/net/interface');
const MACAddress = require('../../../core/net/mac-address');
// const IP4Address = require('../../../core/net/ip4-address');
// const checksum = require('../../../core/net/checksum');
// const BufferBuilder = require('../lib/buffer-builder');

test('create interface', (t) => {
  const intf = new Interface(MACAddress.ZERO);
  intf.ontransmit = () => {};
  t.end();
});

/*
  test.skip('interface handle echo request', function(t) {
  t.plan(1);
  var intf = new Interface(MACAddress.ZERO);
  intf.disableArp();
  intf.configure(new IP4Address(127, 0, 0, 1), new IP4Address(255, 0, 0, 0));

  var reply = makeIP4('icmp',
    new BufferBuilder()
      .uint8(0)         // icmp type = echo reply
      .uint8(0)         // icmp code = 0
      .checksum(cksum)  // icmp checksum
      .uint8(440)       // icmp id
      .uint8(1)         // icmp seq
      .array([1, 2, 3]) // icmp payload
      .repeat(5)
      .buffer(),
    new IP4Address(127, 0, 0, 1),
    new IP4Address(127, 0, 0, 2));

  var request = makeIP4('icmp',
    new BufferBuilder()
      .uint8(8)         // icmp type = echo request
      .uint8(0)         // icmp code = 0
      .checksum(cksum)  // icmp checksum
      .uint8(440)       // icmp id
      .uint8(1)         // icmp seq
      .array([1, 2, 3]) // icmp payload
      .repeat(5)
      .buffer(),
    new IP4Address(127, 0, 0, 2),
    new IP4Address(127, 0, 0, 1));

  intf.ontransmit = function(u8) {
    t.deepEqual(u8, reply);
  };

  intf.receive(request);
});
*/
