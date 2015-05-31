var test = require('tape');
var assert = require('assert');
var TCPSocket = require('runtimejs/core/net/tcp-socket');
var IP4Address = require('runtimejs/core/net/ip4-address');
var tcpHeader = require('runtimejs/core/net/tcp-header');
var tcpSocketState = require('runtimejs/core/net/tcp-socket-state');

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
    t.equal(flags, tcpHeader.FLAG_SYN);
    t.equal(u8, null);
    socket._transmit = testACK;

    var synack = createTcpPacket(serverSeq, seq + 1, tcpHeader.FLAG_SYN | tcpHeader.FLAG_ACK);
    socket._receive(synack, IP4Address.ANY, 45001, 0);
  }

  function testACK(seq, ack, flags, window, u8) {
    t.equal(flags, tcpHeader.FLAG_ACK);
    t.equal(u8, null);
    t.equal(ack, serverSeq + 1);
    socket._destroy();
  }

  t.equal(socket._state, tcpSocketState.STATE_CLOSED);
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
  socket._transmitWindow.resize(20);
  socket.send(new Uint8Array(1));
  socket.send(new Uint8Array(30));
  t.equal(socket._transmitQueue.length, 2);
  t.equal(transmitQueueItemLength(socket._transmitQueue[0]), 1);
  t.equal(transmitQueueItemLength(socket._transmitQueue[1]), 19);
  t.equal(transmitQueueItemBuffer(socket._transmitQueue[0]).length, 1);
  t.equal(transmitQueueItemBuffer(socket._transmitQueue[1]).length, 19);
  socket._transmitWindow.slideTo(socket._transmitWindow.getPosition());
  socket._transmitQueue = [];
  socket._fillTransmitQueue(false);
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
