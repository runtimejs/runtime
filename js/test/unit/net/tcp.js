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

/* eslint-disable no-param-reassign */

'use strict';

const createSuite = require('estap');
const test = createSuite();
const TCPSocket = require('/js/core/net/tcp-socket');
const TCPServerSocket = require('/js/core/net/tcp-server-socket');
const IP4Address = require('/js/core/net/ip4-address');
const tcpHeader = require('/js/core/net/tcp-header');
const tcpSocketState = require('/js/core/net/tcp-socket-state');

function createTcpPacket(seq, ack, flags, window = 8192, u8data = null) {
  const u8 = new Uint8Array(tcpHeader.headerLength + (u8data ? u8data.length : 0));
  tcpHeader.write(u8, 0, 55, 55, seq, ack, flags, window);
  if (u8data) {
    u8.set(u8data, tcpHeader.headerLength);
  }

  return u8;
}

let nextPort = 81;

function getEstablished(t, cb) {
  const socket = new TCPSocket();
  const txSeq = 1;
  let rxSeq = 0;

  function ACK(seq, ack, flags, window, u8) {
    t.is(flags, tcpHeader.FLAG_ACK);
    t.is(u8, null);
    t.is(ack, txSeq + 1);
    socket._transmit = () => {};
    socket._state = tcpSocketState.STATE_ESTABLISHED;
    cb(socket, txSeq, rxSeq, () => {
      socket._destroy();
    });
  }

  function SYN(seq, ack, flags, window, u8) {
    t.is(flags, tcpHeader.FLAG_SYN);
    t.is(u8, null);
    socket._transmit = ACK;

    const synack = createTcpPacket(txSeq, seq + 1, tcpHeader.FLAG_SYN | tcpHeader.FLAG_ACK);
    rxSeq = seq + 1;
    socket._receive(synack, IP4Address.ANY, 45001, 0);
  }

  t.is(socket._state, tcpSocketState.STATE_CLOSED);
  socket._transmit = SYN;
  socket.open('127.0.0.1', nextPort++);
}

getEstablished.plan = 6;

test.cb('tcp connect', t => {
  t.plan(6);
  const socket = new TCPSocket();
  const serverSeq = 1;

  function testACK(seq, ack, flags, window, u8) {
    t.is(flags, tcpHeader.FLAG_ACK, 'ACK flag set');
    t.is(u8, null, 'no buffer in ACK packet');
    t.is(ack, serverSeq + 1, 'seq number is valid');
    socket._destroy();
  }

  function testSYN(seq, ack, flags, window, u8) {
    t.is(flags, tcpHeader.FLAG_SYN, 'SYN flag set');
    t.is(u8, null, 'no buffer in SYN packet');
    socket._transmit = testACK;

    const synack = createTcpPacket(serverSeq, seq + 1, tcpHeader.FLAG_SYN | tcpHeader.FLAG_ACK);
    socket._receive(synack, IP4Address.ANY, 45001, 0);
  }

  t.is(socket._state, tcpSocketState.STATE_CLOSED, 'initial state is closed');
  socket._transmit = testSYN;
  socket.open('127.0.0.1', 80);
});

function transmitQueueItemLength(a) {
  return a[3];
}

function transmitQueueItemBuffer(a) {
  return a[4];
}

test('tcp transmit queue', (t) => {
  const socket = new TCPSocket();
  socket._transmit = () => {};
  socket._state = tcpSocketState.STATE_ESTABLISHED;
  socket._transmitWindowSize = 20;
  socket.send(new Uint8Array(1));
  socket.send(new Uint8Array(30));
  t.is(socket._transmitQueue.length, 2);
  t.is(transmitQueueItemLength(socket._transmitQueue[0]), 1);
  t.is(transmitQueueItemLength(socket._transmitQueue[1]), 19);
  t.is(transmitQueueItemBuffer(socket._transmitQueue[0]).length, 1);
  t.is(transmitQueueItemBuffer(socket._transmitQueue[1]).length, 19);
  socket._acceptACK(socket._getTransmitPosition(), 20);
  t.is(socket._transmitQueue.length, 1);
});

test.cb('tcp receive', t => {
  t.plan(getEstablished.plan + 4);
  getEstablished(t, (socket, txSeq, rxSeq, done) => {
    t.after(done);
    const data = new Uint8Array([1, 2, 3]);

    socket.ondata = (u8) => {
      t.true(u8 instanceof Uint8Array);
      t.is(u8[0], 1);
      t.is(u8[1], 2);
      t.is(u8[2], 3);
    };

    const packet = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data);
    socket._receive(packet, IP4Address.ANY, 45001, 0);
  });
});

test.cb('tcp receive filter full duplicates', t => {
  t.plan(getEstablished.plan + 4);
  getEstablished(t, (socket, txSeq, rxSeq, done) => {
    t.after(done);
    const data = new Uint8Array([1, 2, 3]);

    socket.ondata = (u8) => {
      t.true(u8 instanceof Uint8Array);
      t.is(u8[0], 1);
      t.is(u8[1], 2);
      t.is(u8[2], 3);
    };

    const packet = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data);
    socket._receive(packet, IP4Address.ANY, 45001, 0);
    socket._receive(packet, IP4Address.ANY, 45001, 0);
  });
});

test.cb('tcp receive in order', t => {
  t.plan(getEstablished.plan + 8);
  getEstablished(t, (socket, txSeq, rxSeq, done) => {
    t.after(done);
    const data1 = new Uint8Array([1, 2, 3]);
    const data2 = new Uint8Array([4, 5, 6]);

    let index = 0;
    socket.ondata = (u8) => {
      t.true(u8 instanceof Uint8Array);
      t.is(u8[0], ++index);
      t.is(u8[1], ++index);
      t.is(u8[2], ++index);
    };

    const packet1 = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data1);
    const packet2 = createTcpPacket(txSeq + 4, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data2);
    socket._receive(packet2, IP4Address.ANY, 45001, 0);
    socket._receive(packet1, IP4Address.ANY, 45001, 0);
  });
});

test.cb('tcp receive in order and filter full duplicates', t => {
  t.plan(getEstablished.plan + 9);
  getEstablished(t, (socket, txSeq, rxSeq, done) => {
    t.after(done);
    const data1 = new Uint8Array([1, 2, 3]);
    const data2 = new Uint8Array([4, 5, 6]);

    let lastAck = 0;
    socket._transmit = (seq, ack) => {
      lastAck = ack;
    };

    let index = 0;
    socket.ondata = (u8) => {
      t.true(u8 instanceof Uint8Array);
      t.is(u8[0], ++index);
      t.is(u8[1], ++index);
      t.is(u8[2], ++index);
    };

    const packet1 = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data1);
    const packet2 = createTcpPacket(txSeq + 4, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data2);
    socket._receive(packet2, IP4Address.ANY, 45001, 0);
    socket._receive(packet2, IP4Address.ANY, 45001, 0);
    socket._receive(packet2, IP4Address.ANY, 45001, 0);
    socket._receive(packet1, IP4Address.ANY, 45001, 0);
    socket._receive(packet1, IP4Address.ANY, 45001, 0);
    t.is(lastAck, 8);
  });
});

test.cb('tcp receive partial duplicates', (t) => {
  t.plan(getEstablished.plan + 9);
  getEstablished(t, (socket, txSeq, rxSeq, done) => {
    t.after(done);
    const data1 = new Uint8Array([1, 2, 3]);
    const data2 = new Uint8Array([3, 4, 5, 6]);
    const data3 = new Uint8Array([2, 3]);

    let lastAck = 0;
    socket._transmit = (seq, ack) => {
      lastAck = ack;
    };

    let index = 0;
    socket.ondata = (u8) => {
      t.true(u8 instanceof Uint8Array);
      t.is(u8[0], ++index);
      t.is(u8[1], ++index);
      t.is(u8[2], ++index);
    };

    const packet1 = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data1);
    const packet2 = createTcpPacket(txSeq + 3, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data2);
    const packet3 = createTcpPacket(txSeq + 2, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data3);
    socket._receive(packet2, IP4Address.ANY, 45001, 0);
    socket._receive(packet1, IP4Address.ANY, 45001, 0);
    socket._receive(packet3, IP4Address.ANY, 45001, 0);
    socket._receive(packet3, IP4Address.ANY, 45001, 0);
    t.is(lastAck, 8);
  });
});

test.cb('tcp receive partial duplicate with acked data and small window', t => {
  t.plan(getEstablished.plan + 9);
  getEstablished(t, (socket, txSeq, rxSeq, done) => {
    t.after(done);
    const data1 = new Uint8Array([1, 2, 3]);
    const data2 = new Uint8Array([1, 2, 3, 4, 5, 6]);

    let lastAck = 0;
    socket._transmit = (seq, ack) => {
      lastAck = ack;
    };

    let index = 0;
    socket.ondata = (u8) => {
      t.true(u8 instanceof Uint8Array);
      t.is(u8[0], ++index);
      t.is(u8[1], ++index);
      t.is(u8[2], ++index);
    };

    const packet1 = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data1);
    const packet2 = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data2);
    socket._receiveWindowSize = 6;
    socket._receive(packet1, IP4Address.ANY, 45001, 0);
    socket._receiveWindowSize = 3;
    socket._receive(packet2, IP4Address.ANY, 45001, 0);
    t.is(lastAck, 8);
  });
});

test.cb('tcp send FIN', (t) => {
  t.plan(getEstablished.plan + 6);
  getEstablished(t, (socket, txSeq, rxSeq, done) => {
    t.after(done);

    function recvACK(seq, ack, flags) {
      t.truthy(flags & tcpHeader.FLAG_ACK);
    }

    function recvACKFIN(seq, ack, flags) {
      let packet;
      socket._transmit = recvACK;
      t.truthy(flags & tcpHeader.FLAG_FIN);
      t.is(socket._state, tcpSocketState.STATE_FIN_WAIT_1);
      packet = createTcpPacket(txSeq, seq + 1, tcpHeader.FLAG_ACK);
      socket._receive(packet, IP4Address.ANY, 45001, 0);
      t.is(socket._state, tcpSocketState.STATE_FIN_WAIT_2);
      packet = createTcpPacket(txSeq, seq + 1, tcpHeader.FLAG_FIN);
      socket._receive(packet, IP4Address.ANY, 45001, 0);
      t.is(socket._state, tcpSocketState.STATE_TIME_WAIT);
    }

    socket._transmit = recvACKFIN;
    socket.close();
    t.is(socket._state, tcpSocketState.STATE_TIME_WAIT);
  });
});

test.cb('tcp receive FIN', t => {
  t.plan(getEstablished.plan + 5);
  getEstablished(t, (socket, txSeq, rxSeq, done) => {
    t.after(done);

    function onRecvFIN(seq, ack, flags) {
      socket._transmit = () => {};
      t.truthy(flags & tcpHeader.FLAG_ACK);
    }

    function onSentFIN(seq, ack, flags) {
      socket._transmit = () => {};
      t.truthy(flags & tcpHeader.FLAG_FIN);
      t.is(socket._state, tcpSocketState.STATE_LAST_ACK);
      const packet = createTcpPacket(txSeq, seq + 1, tcpHeader.FLAG_ACK);
      socket._receive(packet, IP4Address.ANY, 45001, 0);
    }

    socket._transmit = onRecvFIN;
    const packet = createTcpPacket(txSeq, rxSeq, tcpHeader.FLAG_FIN | tcpHeader.FLAG_ACK);
    socket._receive(packet, IP4Address.ANY, 45001, 0);
    t.is(socket._state, tcpSocketState.STATE_CLOSE_WAIT);
    socket._transmit = onSentFIN;
    socket.close();
    t.is(socket._state, tcpSocketState.STATE_CLOSED);
  });
});

test.cb('tcp receive FIN, then send more data', t => {
  t.plan(getEstablished.plan + 4);
  getEstablished(t, (socket, txSeq, rxSeq, done) => {
    t.after(done);

    function handleLastAck(seq, ack, flags) {
      socket._transmit = () => {};
      t.truthy(flags & tcpHeader.FLAG_FIN);
      t.is(socket._state, tcpSocketState.STATE_LAST_ACK);
      const packet = createTcpPacket(txSeq, seq + 1, tcpHeader.FLAG_ACK);
      socket._receive(packet, IP4Address.ANY, 45001, 0);
    }

    socket._transmit = () => {};
    socket.send(new Uint8Array([1, 2, 3]));
    const packet = createTcpPacket(txSeq, rxSeq, tcpHeader.FLAG_FIN | tcpHeader.FLAG_ACK);
    socket._receive(packet, IP4Address.ANY, 45001, 0);
    t.is(socket._state, tcpSocketState.STATE_CLOSE_WAIT);
    socket.send(new Uint8Array([4, 5, 6]));
    socket.send(new Uint8Array([7, 8, 9]));
    socket._transmit = handleLastAck;
    socket.close();
    t.is(socket._state, tcpSocketState.STATE_CLOSED);
  });
});

test.cb('cannot send more data after close', (t) => {
  getEstablished(t, (socket, txSeq, rxSeq, done) => {
    t.after(done);
    socket._transmit = () => {};
    socket.send(new Uint8Array([1, 2, 3]));
    socket.close();
    t.throws(() => socket.send(new Uint8Array([4, 5, 6])));
    t.end();
  });
});

test.cb('server socket listening', t => {
  t.plan(6);
  const socket = new TCPServerSocket();

  socket.onlisten = (port) => {
    t.is(port, 100);
    t.pass();
  };

  socket.onclose = () => t.pass();

  socket.listen(100);
  t.is(socket.localPort, 100);
  t.throws(() => {
    socket.localPort = 200;
  });
  t.is(socket.localPort, 100);
  socket.close();
});

test('server socket can reuse port', () => {
  const socket = new TCPServerSocket();
  socket.listen(200);
  socket.close();
  socket.listen(200);
  socket.close();
  socket.listen(200);
  socket.close();
});

test.cb('server socket can listen to random port', (t) => {
  t.plan(2);
  const socket = new TCPServerSocket();
  socket.onlisten = port => t.true(port > 0);
  socket.listen(0);
  t.true(socket.localPort > 0);
  socket.close();
});

test.cb('localhost echo server', t => {
  t.plan(8);
  const server = new TCPServerSocket();
  server.listen(71);
  server.onconnect = (socket) => {
    socket.ondata = (u8) => socket.send(u8);
    socket.onend = () => {
      socket.close();
      server.close();
      t.pass();
    };
  };

  const client = new TCPSocket();
  let recvIndex = 0;
  client.onopen = () => {
    client.send(new Uint8Array([1, 2, 3]));
    client.send(new Uint8Array([4, 5, 6]));
  };
  client.ondata = (u8) => {
    for (let i = 0; i < u8.length; ++i) {
      t.is(u8[i], ++recvIndex);
    }

    if (recvIndex === 6) {
      client.close();
      t.pass();
    }
  };
  client.open('127.0.0.1', 71);
});

test.cb('small sequence numbers', t => {
  t.plan(4);

  const server = new TCPServerSocket();
  t.after(server.close.bind(server));

  let next = 0;
  server.onconnect = (socket) => {
    socket.ondata = (u8) => {
      for (let i = 0; i < u8.length; ++i) {
        t.is(u8[i], ++next);
      }
    };
  };

  server.listen(72);

  const client = new TCPSocket();
  client._transmitWindowEdge = 1;
  client._transmitPosition = 1;

  client.onopen = () => {
    client.send(new Uint8Array([1, 2, 3]));
    client.close();
    t.pass();
  };

  client.open('127.0.0.1', 72);
});

test.cb('large sequence numbers and wrap around', t => {
  t.plan(4);

  const server = new TCPServerSocket();
  t.after(server.close.bind(server));

  let next = 0;
  server.onconnect = (socket) => {
    socket.ondata = (u8) => {
      for (let i = 0; i < u8.length; ++i) {
        t.is(u8[i], ++next);
      }
    };
  };

  server.listen(73);

  const client = new TCPSocket();
  client._transmitWindowEdge = Math.pow(2, 32) - 1;
  client._transmitPosition = Math.pow(2, 32) - 1;

  client.onopen = () => {
    client.send(new Uint8Array([1, 2, 3]));
    client.close();
    t.pass();
  };

  client.open('127.0.0.1', 73);
});
