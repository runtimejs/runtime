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

var test = require('tape');
var assert = require('assert');
var TCPSocket = require('../../../core/net/tcp-socket');
var TCPServerSocket = require('../../../core/net/tcp-server-socket');
var IP4Address = require('../../../core/net/ip4-address');
var tcpHeader = require('../../../core/net/tcp-header');
var tcpSocketState = require('../../../core/net/tcp-socket-state');

function createTcpPacket(seq, ack, flags, window, u8data) {
  window = window || 8192;
  u8data = u8data || null;
  var u8 = new Uint8Array(tcpHeader.headerLength + (u8data ? u8data.length : 0));
  tcpHeader.write(u8, 0, 55, 55, seq, ack, flags, window);
  if (u8data) {
    u8.set(u8data, tcpHeader.headerLength);
  }

  return u8;
}

function getEstablished(cb) {
  var socket = new TCPSocket();
  var txSeq = 1;
  var rxSeq = 0;

  function SYN(seq, ack, flags, window, u8) {
    assert.equal(flags, tcpHeader.FLAG_SYN);
    assert.equal(u8, null);
    socket._transmit = ACK;

    var synack = createTcpPacket(txSeq, seq + 1, tcpHeader.FLAG_SYN | tcpHeader.FLAG_ACK);
    rxSeq = seq + 1;
    socket._receive(synack, IP4Address.ANY, 45001, 0);
  }

  function ACK(seq, ack, flags, window, u8) {
    assert.equal(flags, tcpHeader.FLAG_ACK);
    assert.equal(u8, null);
    assert.equal(ack, txSeq + 1);
    socket._transmit = function() {};
    socket._state = tcpSocketState.STATE_ESTABLISHED;
    cb(socket, txSeq, rxSeq, function() {
      socket._destroy();
    });
  }

  assert.equal(socket._state, tcpSocketState.STATE_CLOSED);
  socket._transmit = SYN;
  socket.open('127.0.0.1', 80);
}

test('tcp connect', function(t) {
  t.plan(6);
  var socket = new TCPSocket();
  var serverSeq = 1;

  function testSYN(seq, ack, flags, window, u8) {
    t.equal(flags, tcpHeader.FLAG_SYN, 'SYN flag set');
    t.equal(u8, null, 'no buffer in SYN packet');
    socket._transmit = testACK;

    var synack = createTcpPacket(serverSeq, seq + 1, tcpHeader.FLAG_SYN | tcpHeader.FLAG_ACK);
    socket._receive(synack, IP4Address.ANY, 45001, 0);
  }

  function testACK(seq, ack, flags, window, u8) {
    t.equal(flags, tcpHeader.FLAG_ACK, 'ACK flag set');
    t.equal(u8, null, 'no buffer in ACK packet');
    t.equal(ack, serverSeq + 1, 'seq number is valid');
    socket._destroy();
  }

  t.equal(socket._state, tcpSocketState.STATE_CLOSED, 'initial state is closed');
  socket._transmit = testSYN;
  socket.open('127.0.0.1', 80);
});

function transmitQueueItemLength(a) {
  return a[3];
}

function transmitQueueItemBuffer(a) {
  return a[4];
}

test('tcp transmit queue', function(t) {
  var socket = new TCPSocket();
  socket._transmit = function() {};
  socket._state = tcpSocketState.STATE_ESTABLISHED;
  socket._transmitWindowSize = 20;
  socket.send(new Uint8Array(1));
  socket.send(new Uint8Array(30));
  t.equal(socket._transmitQueue.length, 2);
  t.equal(transmitQueueItemLength(socket._transmitQueue[0]), 1);
  t.equal(transmitQueueItemLength(socket._transmitQueue[1]), 19);
  t.equal(transmitQueueItemBuffer(socket._transmitQueue[0]).length, 1);
  t.equal(transmitQueueItemBuffer(socket._transmitQueue[1]).length, 19);
  socket._acceptACK(socket._getTransmitPosition(), 20);
  t.equal(socket._transmitQueue.length, 1);
  t.end();
});

test('tcp receive', function(t) {
  t.plan(4);
  getEstablished(function(socket, txSeq, rxSeq, done) {
    t.on('end', done);
    var data = new Uint8Array([1, 2, 3]);

    socket.ondata = function(u8) {
      t.ok(u8 instanceof Uint8Array);
      t.equal(u8[0], 1);
      t.equal(u8[1], 2);
      t.equal(u8[2], 3);
    };

    var packet = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data);
    socket._receive(packet, IP4Address.ANY, 45001, 0);
  });
});

test('tcp receive filter full duplicates', function(t) {
  t.plan(4);
  getEstablished(function(socket, txSeq, rxSeq, done) {
    t.on('end', done);
    var data = new Uint8Array([1, 2, 3]);

    socket.ondata = function(u8) {
      t.ok(u8 instanceof Uint8Array);
      t.equal(u8[0], 1);
      t.equal(u8[1], 2);
      t.equal(u8[2], 3);
    };

    var packet = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data);
    socket._receive(packet, IP4Address.ANY, 45001, 0);
    socket._receive(packet, IP4Address.ANY, 45001, 0);
  });
});

test('tcp receive in order', function(t) {
  t.plan(8);
  getEstablished(function(socket, txSeq, rxSeq, done) {
    t.on('end', done);
    var data1 = new Uint8Array([1, 2, 3]);
    var data2 = new Uint8Array([4, 5, 6]);

    var index = 0;
    socket.ondata = function(u8) {
      t.ok(u8 instanceof Uint8Array);
      t.equal(u8[0], ++index);
      t.equal(u8[1], ++index);
      t.equal(u8[2], ++index);
    };

    var packet1 = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data1);
    var packet2 = createTcpPacket(txSeq + 4, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data2);
    socket._receive(packet2, IP4Address.ANY, 45001, 0);
    socket._receive(packet1, IP4Address.ANY, 45001, 0);
  });
});

test('tcp receive in order and filter full duplicates', function(t) {
  t.plan(9);
  getEstablished(function(socket, txSeq, rxSeq, done) {
    t.on('end', done);
    var data1 = new Uint8Array([1, 2, 3]);
    var data2 = new Uint8Array([4, 5, 6]);

    var lastAck = 0;
    socket._transmit = function(seq, ack, flags, window, u8) {
      lastAck = ack;
    };

    var index = 0;
    socket.ondata = function(u8) {
      t.ok(u8 instanceof Uint8Array);
      t.equal(u8[0], ++index);
      t.equal(u8[1], ++index);
      t.equal(u8[2], ++index);
    };

    var packet1 = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data1);
    var packet2 = createTcpPacket(txSeq + 4, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data2);
    socket._receive(packet2, IP4Address.ANY, 45001, 0);
    socket._receive(packet2, IP4Address.ANY, 45001, 0);
    socket._receive(packet2, IP4Address.ANY, 45001, 0);
    socket._receive(packet1, IP4Address.ANY, 45001, 0);
    socket._receive(packet1, IP4Address.ANY, 45001, 0);
    t.equal(lastAck, 8);
  });
});

test('tcp receive partial duplicates', function(t) {
  t.plan(9);
  getEstablished(function(socket, txSeq, rxSeq, done) {
    t.on('end', done);
    var data1 = new Uint8Array([1, 2, 3]);
    var data2 = new Uint8Array([3, 4, 5, 6]);
    var data3 = new Uint8Array([2, 3]);

    var lastAck = 0;
    socket._transmit = function(seq, ack, flags, window, u8) {
      lastAck = ack;
    };

    var index = 0;
    socket.ondata = function(u8) {
      t.ok(u8 instanceof Uint8Array);
      t.equal(u8[0], ++index);
      t.equal(u8[1], ++index);
      t.equal(u8[2], ++index);
    };

    var packet1 = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data1);
    var packet2 = createTcpPacket(txSeq + 3, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data2);
    var packet3 = createTcpPacket(txSeq + 2, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data3);
    socket._receive(packet2, IP4Address.ANY, 45001, 0);
    socket._receive(packet1, IP4Address.ANY, 45001, 0);
    socket._receive(packet3, IP4Address.ANY, 45001, 0);
    socket._receive(packet3, IP4Address.ANY, 45001, 0);
    t.equal(lastAck, 8);
  });
});

test('tcp receive partial duplicate with acked data and small window', function(t) {
  t.plan(9);
  getEstablished(function(socket, txSeq, rxSeq, done) {
    t.on('end', done);
    var data1 = new Uint8Array([1, 2, 3]);
    var data2 = new Uint8Array([1, 2, 3, 4, 5, 6]);

    var lastAck = 0;
    socket._transmit = function(seq, ack, flags, window, u8) {
      lastAck = ack;
    };

    var index = 0;
    socket.ondata = function(u8) {
      t.ok(u8 instanceof Uint8Array);
      t.equal(u8[0], ++index);
      t.equal(u8[1], ++index);
      t.equal(u8[2], ++index);
    };

    var packet1 = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data1);
    var packet2 = createTcpPacket(txSeq + 1, rxSeq, tcpHeader.FLAG_PSH | tcpHeader.FLAG_ACK, 8192, data2);
    socket._receiveWindowSize = 6;
    socket._receive(packet1, IP4Address.ANY, 45001, 0);
    socket._receiveWindowSize = 3;
    socket._receive(packet2, IP4Address.ANY, 45001, 0);
    t.equal(lastAck, 8);
  });
});

test('tcp send FIN', function(t) {
  t.plan(6);
  getEstablished(function(socket, txSeq, rxSeq, done) {
    t.on('end', done);

    function recvACKFIN(seq, ack, flags, window, u8) {
      var packet;
      socket._transmit = recvACK;
      t.ok(flags & tcpHeader.FLAG_FIN);
      t.equal(socket._state, tcpSocketState.STATE_FIN_WAIT_1);
      packet = createTcpPacket(txSeq, seq + 1, tcpHeader.FLAG_ACK);
      socket._receive(packet, IP4Address.ANY, 45001, 0);
      t.equal(socket._state, tcpSocketState.STATE_FIN_WAIT_2);
      packet = createTcpPacket(txSeq, seq + 1, tcpHeader.FLAG_FIN);
      socket._receive(packet, IP4Address.ANY, 45001, 0);
      t.equal(socket._state, tcpSocketState.STATE_TIME_WAIT);
    }

    function recvACK(seq, ack, flags, window, u8) {
      t.ok(flags & tcpHeader.FLAG_ACK);
    }

    socket._transmit = recvACKFIN;
    socket.close();
    t.equal(socket._state, tcpSocketState.STATE_TIME_WAIT);
  });
});

test('tcp receive FIN', function(t) {
  t.plan(5);
  getEstablished(function(socket, txSeq, rxSeq, done) {
    t.on('end', done);

    function onRecvFIN(seq, ack, flags, window, u8) {
      socket._transmit = function() {};
      t.ok(flags & tcpHeader.FLAG_ACK);
    }

    function onSentFIN(seq, ack, flags, window, u8) {
      socket._transmit = function() {};
      t.ok(flags & tcpHeader.FLAG_FIN);
      t.equal(socket._state, tcpSocketState.STATE_LAST_ACK);
      var packet = createTcpPacket(txSeq, seq + 1, tcpHeader.FLAG_ACK);
      socket._receive(packet, IP4Address.ANY, 45001, 0);
    }

    socket._transmit = onRecvFIN;
    var packet = createTcpPacket(txSeq, rxSeq, tcpHeader.FLAG_FIN | tcpHeader.FLAG_ACK);
    socket._receive(packet, IP4Address.ANY, 45001, 0);
    t.equal(socket._state, tcpSocketState.STATE_CLOSE_WAIT);
    socket._transmit = onSentFIN;
    socket.close();
    t.equal(socket._state, tcpSocketState.STATE_CLOSED);
  });
});

test('tcp receive FIN, then send more data', function(t) {
  t.plan(4);
  getEstablished(function(socket, txSeq, rxSeq, done) {
    t.on('end', done);

    function handleLastAck(seq, ack, flags, window, u8) {
      socket._transmit = function() {};
      t.ok(flags & tcpHeader.FLAG_FIN);
      t.equal(socket._state, tcpSocketState.STATE_LAST_ACK);
      var packet = createTcpPacket(txSeq, seq + 1, tcpHeader.FLAG_ACK);
      socket._receive(packet, IP4Address.ANY, 45001, 0);
    }

    socket._transmit = function() {};
    socket.send(new Uint8Array([1, 2, 3]));
    var packet = createTcpPacket(txSeq, rxSeq, tcpHeader.FLAG_FIN | tcpHeader.FLAG_ACK);
    socket._receive(packet, IP4Address.ANY, 45001, 0);
    t.equal(socket._state, tcpSocketState.STATE_CLOSE_WAIT);
    socket.send(new Uint8Array([4, 5, 6]));
    socket.send(new Uint8Array([7, 8, 9]));
    socket._transmit = handleLastAck;
    socket.close();
    t.equal(socket._state, tcpSocketState.STATE_CLOSED);
  });
});

test('cannot send more data after close', function(t) {
  getEstablished(function(socket, txSeq, rxSeq, done) {
    t.on('end', done);
    socket._transmit = function() {};
    socket.send(new Uint8Array([1, 2, 3]));
    socket.close();
    t.throws(function() {
      socket.send(new Uint8Array([4, 5, 6]));
    });
    t.end();
  });
});

test('server socket listening', function(t) {
  t.plan(6);
  var socket = new TCPServerSocket();

  socket.onlisten = function(port) {
    t.equal(port, 100);
    t.ok(true);
  };

  socket.onclose = function() {
    t.ok(true);
  };

  socket.listen(100);
  t.equal(socket.localPort, 100);
  t.throws(function() {
    socket.localPort = 200;
  });
  t.equal(socket.localPort, 100);
  socket.close();
});

test('server socket can reuse port', function(t) {
  var socket = new TCPServerSocket();
  socket.listen(200);
  socket.close();
  socket.listen(200);
  socket.close();
  var socket2 = new TCPServerSocket();
  socket.listen(200);
  socket.close();
  t.end();
});

test('server socket can listen to random port', function(t) {
  t.plan(2);
  var socket = new TCPServerSocket();
  socket.onlisten = function(port) {
    t.ok(port > 0);
  };
  socket.listen(0);
  t.ok(socket.localPort > 0);
  socket.close();
});

test('localhost echo server', function(t) {
  t.plan(8);
  var server = new TCPServerSocket();
  server.listen(71);
  server.onconnect = function(socket) {
    socket.ondata = function(u8) {
      socket.send(u8);
    };
    socket.onend = function() {
      socket.close();
      server.close();
      t.ok(true);
    };
  };

  var client = new TCPSocket();
  var recvIndex = 0;
  client.onopen = function() {
    client.send(new Uint8Array([1, 2, 3]));
    client.send(new Uint8Array([4, 5, 6]));
  };
  client.ondata = function(u8) {
    for (var i = 0; i < u8.length; ++i) {
      t.equal(u8[i], ++recvIndex);
    }

    if (6 === recvIndex) {
      client.close();
      t.ok(true);
    }
  };
  client.open('127.0.0.1', 71);
});

test('small sequence numbers', function(t) {
  t.plan(4);

  var server = new TCPServerSocket();
  t.on('end', server.close.bind(server));

  var next = 0;
  server.onconnect = function(socket) {
    socket.ondata = function(u8) {
      for (var i = 0; i < u8.length; ++i) {
        t.equal(u8[i], ++next);
      }
    };
  };

  server.listen(71);

  var client = new TCPSocket();
  client._transmitWindowEdge = 1;
  client._transmitPosition = 1;

  client.onopen = function() {
    client.send(new Uint8Array([1, 2, 3]));
    client.close();
    t.ok(true);
  };

  client.open('127.0.0.1', 71);
});

test('large sequence numbers and wrap around', function(t) {
  t.plan(4);

  var server = new TCPServerSocket();
  t.on('end', server.close.bind(server));

  var next = 0;
  server.onconnect = function(socket) {
    socket.ondata = function(u8) {
      for (var i = 0; i < u8.length; ++i) {
        t.equal(u8[i], ++next);
      }
    };
  };

  server.listen(71);

  var client = new TCPSocket();
  client._transmitWindowEdge = Math.pow(2, 32) - 1;
  client._transmitPosition = Math.pow(2, 32) - 1;

  client.onopen = function() {
    client.send(new Uint8Array([1, 2, 3]));
    client.close();
    t.ok(true);
  };

  client.open('127.0.0.1', 71);
});
