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

const createSuite = require('estap');
const test = createSuite();
const UDPSocket = require('/js/core/net/udp-socket');
const ip4fragments = require('/js/core/net/ip4-fragments');
const interfaceMock = require('../helpers/interface-mock');
const packetBuilder = require('../helpers/packet-builder');

test.cb('receive ip4 udp', (t) => {
  t.plan(3);

  const intf = interfaceMock();

  const socket = new UDPSocket();
  socket.bind(65432);

  t.after(socket.close.bind(socket));

  socket.onmessage = (ip, port, u8) => {
    t.is(ip.toString(), '33.44.55.66');
    t.is(port, 999);
    t.same(u8, new Uint8Array([1, 2, 3, 4, 5]));
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

function ipFragmentsTest(name, length, slices, order, norecv) {
  test.cb(name, t => {
    t.plan(norecv ? 1 : 4);

    const intf = interfaceMock();
    const socket = new UDPSocket();
    socket.bind();
    const socketPort = socket.port;

    socket.onmessage = (ip, port, u8) => {
      t.is(ip.toString(), '33.44.55.66', 'message ip address');
      t.is(port, 999, 'message port');
      t.true(packetBuilder.buffersEqual(u8, packetBuilder.makeBuffer(length)), 'message content');
      socket.close();
    };

    const fragments = packetBuilder.createFragmentedIP4({
      srcPort: 999,
      destPort: socketPort,
      srcIP: '33.44.55.66',
    }, length + 8 /* 8 bytes udp header */, slices);

    order.forEach((index) => intf.receive(fragments[index]));

    if (norecv) {
      t.true(intf.fragments.size > 0, 'fragments left in the queue');
    } else {
      t.is(intf.fragments.size, 0, 'fragment queue is empty');
    }
  });
}

(() => {
  const slices = [
    { offset: 0, len: 8 },
    { offset: 8, len: 8 },
    { offset: 16, len: 16 },
    { offset: 32, len: 16 },
    { offset: 48, len: 24 },
  ];
  ipFragmentsTest('receive ip4 fragmented non overlapped > normal ordered', 64, slices, [0, 1, 2, 3, 4]);
  ipFragmentsTest('receive ip4 fragmented non overlapped > reverse ordered', 64, slices, [4, 3, 2, 1, 0]);
  ipFragmentsTest('receive ip4 fragmented non overlapped > mixed ordered', 64, slices, [2, 1, 4, 0, 3]);
  ipFragmentsTest('receive ip4 fragmented non overlapped > duplicated', 64, slices, [1, 1, 1, 2, 2, 3, 4, 0]);
  ipFragmentsTest('receive ip4 fragmented non overlapped > duplicated last', 64, slices, [0, 1, 2, 4, 4, 4, 4, 3]);
})();

(() => {
  const slices = [
    { offset: 0, len: 8 },
    { offset: 8, len: 8 },
    { offset: 16, len: 16 },
    { offset: 24, len: 16 },
    { offset: 24, len: 48 },
  ];
  ipFragmentsTest('receive ip4 fragmented overlapped fragments > fragments left edge overlap', 64, slices, [0, 1, 2, 3, 4]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments > fragments full and right edge overlap', 64, slices, [4, 3, 2, 1, 0]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments > mixed ordered (fragment 3 is unnecessary)', 64, slices, [2, 1, 4, 0]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments > mixed ordered (fragment 3 first)', 64, slices, [3, 2, 1, 4, 0]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments > duplicated', 64, slices, [1, 1, 1, 2, 2, 3, 4, 0]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments > duplicated last (fragment 3 is unnecessary)', 64, slices, [0, 1, 4, 4, 4, 4, 2]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments > duplicated last (fragment 3 first)', 64, slices, [3, 3, 0, 1, 4, 4, 4, 4, 2]);
})();

(() => {
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
  ipFragmentsTest('receive ip4 fragmented overlapped fragments ladder 1 > normal order', 64, slices, [0, 1, 2, 3, 4, 5, 6, 7, 8]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments ladder 1 > reverse order except last', 64, slices, [7, 6, 5, 4, 3, 2, 1, 0, 8]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments ladder 1 > reverse order including last', 64, slices, [8, 7, 6, 5, 4, 3, 2, 1, 0]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments ladder 1 > mixed order except last', 64, slices, [3, 2, 4, 7, 1, 6, 0, 5, 8]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments ladder 1 > last first 1', 64, slices, [8, 0]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments ladder 1 > last first 2', 64, slices, [8, 1, 0]);
})();

(() => {
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
  ipFragmentsTest('receive ip4 fragmented overlapped fragments ladder 2 > normal order', 64, slices, [0, 1, 2, 3, 4, 5, 6, 7, 8]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments ladder 2 > reverse order except last', 64, slices, [7, 6, 5, 4, 3, 2, 1, 0, 8]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments ladder 2 > reverse order including last', 64, slices, [8, 7, 6, 5, 4, 3, 2, 1, 0]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments ladder 2 > mixed order except last', 64, slices, [3, 2, 4, 7, 1, 6, 0, 5, 8]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments ladder 2 > last first 1', 64, slices, [8, 0]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments ladder 2 > last first 2', 64, slices, [8, 1, 0]);
})();

(() => {
  const slices = [
    { offset: 8, len: 56 },    // [ ======= ]
    { offset: 16, len: 40 },   // [  =====  ]
    { offset: 24, len: 24 },   // [   ===   ]
    { offset: 32, len: 8 },    // [    =    ]
    { offset: 64, len: 8 },    // [        =]
    { offset: 0, len: 8 },     // [=        ]
  ];
  ipFragmentsTest('receive ip4 fragmented overlapped fragments pyramid > normal order', 64, slices, [0, 1, 2, 3, 4, 5]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments pyramid > reverse order except last two 1', 64, slices, [3, 2, 1, 0, 4, 5]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments pyramid > reverse order except last two 2', 64, slices, [3, 2, 1, 0, 5, 4]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments pyramid > reverse order except last two 3', 64, slices, [4, 5, 3, 2, 1, 0]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments pyramid > reverse order except last two 4', 64, slices, [5, 4, 3, 2, 1, 0]);
})();

(() => {
  const slices = [
    { offset: 0, len: 8 },  // [=        ]
    { offset: 16, len: 8 }, // [  =      ]
    { offset: 32, len: 8 }, // [    =    ]
    { offset: 48, len: 8 }, // [      =  ]
    { offset: 64, len: 8 }, // [        =]
    { offset: 8, len: 56 }, // [ ======= ]
  ];
  ipFragmentsTest('receive ip4 fragmented overlapped fragments small chunks > normal order', 64, slices, [0, 1, 2, 3, 4, 5]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments small chunks > reverse order', 64, slices, [5, 4, 3, 2, 1, 0]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments small chunks > reverse order duplicates', 64, slices, [5, 5, 4, 3, 3, 3, 2, 1, 1, 0]);
  ipFragmentsTest('receive ip4 fragmented overlapped fragments small chunks > mixed order', 64, slices, [2, 3, 1, 4, 0, 5]);
})();

(() => {
  const slices = [
    { offset: 0, len: 65528 },
    { offset: 65528, len: 7 },
  ];
  ipFragmentsTest('receive ip4 fragmented max offset and size', 65535 - 8, slices, [0, 1]);
})();

(() => {
  const slices = [
    { offset: 0, len: 65528 },
    { offset: 65528, len: 7 + 1 },
  ];
  ipFragmentsTest('receive ip4 fragmented too big (max-size + 1)', (65535 - 8) + 1, slices, [0, 1], true);
})();

test('too many fragment queues and timeouts', t => {
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

  t.is(intf.fragments.size, 100);

  performance.now = () => 20100;

  ip4fragments.tick(intf);
  t.is(intf.fragments.size, 100);

  performance.now = () => 30100;

  ip4fragments.tick(intf);
  t.is(intf.fragments.size, 0);

  performance.now = originalNow;
});
