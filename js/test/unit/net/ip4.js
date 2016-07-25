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
const runtime = require('../../..');
const ip4fragments = require('../../../core/net/ip4-fragments');
const interfaceMock = require('../lib/interface-mock');
const packetBuilder = require('../lib/packet-builder');

test('receive ip4 udp', (t) => {
  t.timeoutAfter(1000);
  t.plan(3);

  const intf = interfaceMock();

  const socket = new runtime.net.UDPSocket();
  socket.bind(65432);
  t.on('end', socket.close.bind(socket));

  socket.onmessage = (ip, port, u8) => {
    t.equal(ip.toString(), '33.44.55.66');
    t.equal(port, 999);
    t.deepEqual(u8, new Uint8Array([1, 2, 3, 4, 5]));
  };

  const udp = packetBuilder.createUDP(new Uint8Array([1, 2, 3, 4, 5]), {
    srcPort: 999,
    destPort: 65432,
  });
  const ip4 = packetBuilder.createEthernetIP4('udp', udp, {
    srcIP: '33.44.55.66',
  });
  intf.receive(ip4);
});

function ipFragmentsTest(t, name, length, slices, order, norecv) {
  t.test(name, (t2) => {
    t2.timeoutAfter(1000);
    t2.plan(norecv ? 1 : 4);

    const intf = interfaceMock();
    const socket = new runtime.net.UDPSocket();
    socket.bind(65432);

    socket.onmessage = (ip, port, u8) => {
      t2.equal(ip.toString(), '33.44.55.66');
      t2.equal(port, 999);
      t2.ok(packetBuilder.buffersEqual(u8, packetBuilder.makeBuffer(length)));
      socket.close();
    };

    const fragments = packetBuilder.createFragmentedIP4({
      srcPort: 999,
      destPort: 65432,
      srcIP: '33.44.55.66',
    }, length + 8 /* 8 bytes udp header */, slices);

    order.forEach((index) => intf.receive(fragments[index]));

    if (norecv) {
      t2.ok(intf.fragments.size > 0);
    } else {
      t2.equal(intf.fragments.size, 0);
    }
  });
}

test('receive ip4 fragmented non overlapped', (t) => {
  const slices = [
    { offset: 0, len: 8 },
    { offset: 8, len: 8 },
    { offset: 16, len: 16 },
    { offset: 32, len: 16 },
    { offset: 48, len: 24 },
  ];
  ipFragmentsTest(t, 'normal ordered', 64, slices, [0, 1, 2, 3, 4]);
  ipFragmentsTest(t, 'reverse ordered', 64, slices, [4, 3, 2, 1, 0]);
  ipFragmentsTest(t, 'mixed ordered', 64, slices, [2, 1, 4, 0, 3]);
  ipFragmentsTest(t, 'duplicated', 64, slices, [1, 1, 1, 2, 2, 3, 4, 0]);
  ipFragmentsTest(t, 'duplicated last', 64, slices, [0, 1, 2, 4, 4, 4, 4, 3]);
  t.end();
});

test('receive ip4 fragmented overlapped fragments', (t) => {
  const slices = [
    { offset: 0, len: 8 },
    { offset: 8, len: 8 },
    { offset: 16, len: 16 },
    { offset: 24, len: 16 },
    { offset: 24, len: 48 },
  ];
  ipFragmentsTest(t, 'fragments left edge overlap', 64, slices, [0, 1, 2, 3, 4]);
  ipFragmentsTest(t, 'fragments full and right edge overlap', 64, slices, [4, 3, 2, 1, 0]);
  ipFragmentsTest(t, 'mixed ordered (fragment 3 is unnecessary)', 64, slices, [2, 1, 4, 0]);
  ipFragmentsTest(t, 'mixed ordered (fragment 3 first)', 64, slices, [3, 2, 1, 4, 0]);
  ipFragmentsTest(t, 'duplicated', 64, slices, [1, 1, 1, 2, 2, 3, 4, 0]);
  ipFragmentsTest(t, 'duplicated last (fragment 3 is unnecessary)', 64, slices, [0, 1, 4, 4, 4, 4, 2]);
  ipFragmentsTest(t, 'duplicated last (fragment 3 first)', 64, slices, [3, 3, 0, 1, 4, 4, 4, 4, 2]);
  t.end();
});

test('receive ip4 fragmented overlapped fragments ladder 1', (t) => {
  const slices = [
    { offset: 8, len: 64 },    // [ ========]
    { offset: 16, len: 56 },   // [  =======]
    { offset: 24, len: 48 },   // [   ======]
    { offset: 32, len: 40 },   // [    =====]
    { offset: 40, len: 32 },   // [     ====]
    { offset: 48, len: 24 },   // [      ===]
    { offset: 56, len: 16 },   // [       ==]
    { offset: 64, len: 8 },    // [        =]
    { offset: 0, len: 8 },     // [=        ] (last piece)
  ];
  ipFragmentsTest(t, 'normal order', 64, slices, [0, 1, 2, 3, 4, 5, 6, 7, 8]);
  ipFragmentsTest(t, 'reverse order except last', 64, slices, [7, 6, 5, 4, 3, 2, 1, 0, 8]);
  ipFragmentsTest(t, 'reverse order including last', 64, slices, [8, 7, 6, 5, 4, 3, 2, 1, 0]);
  ipFragmentsTest(t, 'mixed order except last', 64, slices, [3, 2, 4, 7, 1, 6, 0, 5, 8]);
  ipFragmentsTest(t, 'last first 1', 64, slices, [8, 0]);
  ipFragmentsTest(t, 'last first 2', 64, slices, [8, 1, 0]);
  t.end();
});

test('receive ip4 fragmented overlapped fragments ladder 2', (t) => {
  const slices = [
    { offset: 0, len: 64 },  // [======== ]
    { offset: 0, len: 56 },  // [=======  ]
    { offset: 0, len: 48 },  // [======   ]
    { offset: 0, len: 40 },  // [=====    ]
    { offset: 0, len: 32 },  // [====     ]
    { offset: 0, len: 24 },  // [===      ]
    { offset: 0, len: 16 },  // [==       ]
    { offset: 0, len: 8 },   // [=        ]
    { offset: 64, len: 8 },  // [        =] (last piece)
  ];
  ipFragmentsTest(t, 'normal order', 64, slices, [0, 1, 2, 3, 4, 5, 6, 7, 8]);
  ipFragmentsTest(t, 'reverse order except last', 64, slices, [7, 6, 5, 4, 3, 2, 1, 0, 8]);
  ipFragmentsTest(t, 'reverse order including last', 64, slices, [8, 7, 6, 5, 4, 3, 2, 1, 0]);
  ipFragmentsTest(t, 'mixed order except last', 64, slices, [3, 2, 4, 7, 1, 6, 0, 5, 8]);
  ipFragmentsTest(t, 'last first 1', 64, slices, [8, 0]);
  ipFragmentsTest(t, 'last first 2', 64, slices, [8, 1, 0]);
  t.end();
});

test('receive ip4 fragmented overlapped fragments pyramid', (t) => {
  const slices = [
    { offset: 8, len: 56 },    // [ ======= ]
    { offset: 16, len: 40 },   // [  =====  ]
    { offset: 24, len: 24 },   // [   ===   ]
    { offset: 32, len: 8 },    // [    =    ]
    { offset: 64, len: 8 },    // [        =]
    { offset: 0, len: 8 },     // [=        ]
  ];
  ipFragmentsTest(t, 'normal order', 64, slices, [0, 1, 2, 3, 4, 5]);
  ipFragmentsTest(t, 'reverse order except last two 1', 64, slices, [3, 2, 1, 0, 4, 5]);
  ipFragmentsTest(t, 'reverse order except last two 2', 64, slices, [3, 2, 1, 0, 5, 4]);
  ipFragmentsTest(t, 'reverse order except last two 3', 64, slices, [4, 5, 3, 2, 1, 0]);
  ipFragmentsTest(t, 'reverse order except last two 4', 64, slices, [5, 4, 3, 2, 1, 0]);
  t.end();
});

test('receive ip4 fragmented overlapped fragments small chunks', (t) => {
  const slices = [
    { offset: 0, len: 8 },  // [=        ]
    { offset: 16, len: 8 }, // [  =      ]
    { offset: 32, len: 8 }, // [    =    ]
    { offset: 48, len: 8 }, // [      =  ]
    { offset: 64, len: 8 }, // [        =]
    { offset: 8, len: 56 }, // [ ======= ]
  ];
  ipFragmentsTest(t, 'normal order', 64, slices, [0, 1, 2, 3, 4, 5]);
  ipFragmentsTest(t, 'reverse order', 64, slices, [5, 4, 3, 2, 1, 0]);
  ipFragmentsTest(t, 'reverse order duplicates', 64, slices, [5, 5, 4, 3, 3, 3, 2, 1, 1, 0]);
  ipFragmentsTest(t, 'mixed order', 64, slices, [2, 3, 1, 4, 0, 5]);
  t.end();
});

test('receive ip4 fragmented max offset and size', (t) => {
  const slices = [
    { offset: 0, len: 65528 },
    { offset: 65528, len: 7 },
  ];
  ipFragmentsTest(t, 'max size', 65535 - 8, slices, [0, 1]);
  t.end();
});

test('receive ip4 fragmented too big', (t) => {
  const slices = [
    { offset: 0, len: 65528 },
    { offset: 65528, len: 7 + 1 },
  ];
  ipFragmentsTest(t, 'max-size + 1', (65535 - 8) + 1, slices, [0, 1], true);
  t.end();
});

test('too many fragment queues and timeouts', (t) => {
  t.timeoutAfter(1000);
  const intf = interfaceMock();
  const originalNow = performance.now;

  performance.now = () => 100;

  for (let i = 0; i < 150; ++i) {
    const fragments = packetBuilder.createFragmentedIP4({
      srcPort: 999,
      destPort: 65432,
      srcIP: `33.44.55.${String(i)}`,
    }, 64 + 8 /* 8 bytes udp header */, [{
      offset: 0,
      len: 8,
    }]);
    intf.receive(fragments[0]);
  }

  t.equal(intf.fragments.size, 100);

  performance.now = () => 20100;

  ip4fragments.tick(intf);
  t.equal(intf.fragments.size, 100);

  performance.now = () => 30100;

  ip4fragments.tick(intf);
  t.equal(intf.fragments.size, 0);

  performance.now = originalNow;
  t.end();
});
