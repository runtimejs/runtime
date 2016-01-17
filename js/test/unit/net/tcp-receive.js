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

function receiveTest(opts, cb) {
  var initialSequenceNumber = opts.initialSequenceNumber;
  var bufs = opts.bufs;

  var socket = new TCPSocket();
  var next = 0;

  var count = 0;
  for (let i = 0; i < bufs.length; ++i) {
    let seqOffset = bufs[i].seqOffset;
    let len = bufs[i].len;
    var maxSeq = seqOffset + len;
    if (maxSeq > count) {
      count = maxSeq;
    }
  }

  socket._transmit = function() {};
  socket.ondata = function(u8) {
    for (var z = 0; z < u8.length; ++z) {
      if (u8[z] !== ++next) {
        throw new Error('invalid byte received ' + u8[z] + ', expected ' + next);
      }

      if (next === count) {
        cb();
      }
    }
  };

  socket._receiveWindowEdge = initialSequenceNumber;

  var packets = [];
  for (let i = 0; i < bufs.length; ++i) {
    let seqOffset = bufs[i].seqOffset;
    let len = bufs[i].len;

    var b = new Uint8Array(len);
    for (var j = 0; j < len; ++j) {
      b[j] = seqOffset + j + 1;
    }

    packets.push({
      seq: (initialSequenceNumber + seqOffset) >>> 0,
      len: len,
      buf: b
    });
  }

  packets.forEach(function(pck) {
    socket._insertReceiveQueue(pck.seq, pck.len, pck.buf);
  });

  if (socket._receiveQueue.length !== 0) {
    console.log('='.repeat(50));
    console.log('Receive queue:');
    socket._receiveQueue.map(function(x) {
      console.log(`>> seq ${x[0]} len ${x[1]} buf ${JSON.stringify(x[2])}`);
    });
    console.log('='.repeat(50));
    throw new Error('receive queue should be empty');
  }
}

function receiveTestBatch(t, seqList, bufs) {
  t.plan(3 * seqList.length);
  seqList.forEach(function(seq) {
    var reversed = bufs.slice(0);
    var shuffled = bufs.slice(0);
    reversed.reverse();
    shuffled.sort(function() { return .5 - Math.random(); });

    receiveTest({
      initialSequenceNumber: seq,
      bufs: bufs
    }, function() { t.ok(true, 'default ordered, initial sequence number ' + seq); });
    receiveTest({
      initialSequenceNumber: seq,
      bufs: reversed
    }, function() { t.ok(true, 'reverse ordered, initial sequence number ' + seq); });
    receiveTest({
      initialSequenceNumber: seq,
      bufs: shuffled
    }, function() { t.ok(true, 'random ordered, initial sequence number ' + seq); });
  });
}

var sequenceNumbersList = [
  0, 1, Math.pow(2, 32) - 1, Math.pow(2, 32) - 2, Math.pow(2, 32) - 3, Math.pow(2, 32) - 9999
];

test('receive fast path (small sequence numbers)', function(t) {
  receiveTest({
    initialSequenceNumber: 1,
    bufs: [
      { seqOffset: 0, len: 3 },
      { seqOffset: 3, len: 2 },
      { seqOffset: 5, len: 1 }
    ]
  }, t.end.bind(t));
});

test('receive fast path (large sequence numbers) #1', function(t) {
  receiveTest({
    initialSequenceNumber: Math.pow(2, 32) - 4,
    bufs: [
      { seqOffset: 0, len: 3 },
      { seqOffset: 3, len: 2 },
      { seqOffset: 5, len: 1 },
      { seqOffset: 6, len: 4 },
      { seqOffset: 10, len: 5 },
      { seqOffset: 15, len: 1 },
      { seqOffset: 16, len: 8 },
      { seqOffset: 24, len: 1 },
      { seqOffset: 25, len: 1 }
    ]
  }, t.end.bind(t));
});

test('receive fast path (large sequence numbers) #2', function(t) {
  receiveTest({
    initialSequenceNumber: Math.pow(2, 32) - 3,
    bufs: [
      { seqOffset: 0, len: 3 },
      { seqOffset: 3, len: 2 },
      { seqOffset: 5, len: 1 },
      { seqOffset: 6, len: 4 }
    ]
  }, t.end.bind(t));
});

test('receive fast path (large sequence numbers) #3', function(t) {
  receiveTest({
    initialSequenceNumber: Math.pow(2, 32) - 1,
    bufs: [
      { seqOffset: 0, len: 1 },
      { seqOffset: 1, len: 2 },
      { seqOffset: 3, len: 3 },
      { seqOffset: 6, len: 4 }
    ]
  }, t.end.bind(t));
});

test('receive fast path (large sequence numbers) #4', function(t) {
  receiveTest({
    initialSequenceNumber: Math.pow(2, 32) - 1,
    bufs: [
      { seqOffset: 0, len: 10 },
      { seqOffset: 10, len: 1 }
    ]
  }, t.end.bind(t));
});

test('receive reverse order (small sequence numbers) #1', function(t) {
  receiveTest({
    initialSequenceNumber: 1,
    bufs: [
      { seqOffset: 0, len: 3 },
      { seqOffset: 3, len: 2 },
      { seqOffset: 5, len: 1 }
    ].reverse()
  }, t.end.bind(t));
});

test('receive reverse order (small sequence numbers) #2', function(t) {
  receiveTest({
    initialSequenceNumber: 1,
    bufs: [
      { seqOffset: 0, len: 3 },
      { seqOffset: 3, len: 2 },
      { seqOffset: 5, len: 1 },
      { seqOffset: 6, len: 4 },
      { seqOffset: 10, len: 5 },
      { seqOffset: 15, len: 1 },
      { seqOffset: 16, len: 8 },
      { seqOffset: 24, len: 1 },
      { seqOffset: 25, len: 1 }
    ].reverse()
  }, t.end.bind(t));
});

test('receive reverse order (large sequence numbers) #1', function(t) {
  receiveTest({
    initialSequenceNumber: Math.pow(2, 32) - 4,
    bufs: [
      { seqOffset: 0, len: 1 },
      { seqOffset: 1, len: 3 },
      { seqOffset: 4, len: 5 },
      { seqOffset: 9, len: 2 }
    ].reverse()
  }, t.end.bind(t));
});

test('receive reverse order (large sequence numbers) #2', function(t) {
  receiveTest({
    initialSequenceNumber: Math.pow(2, 32) - 4,
    bufs: [
      { seqOffset: 0, len: 3 },
      { seqOffset: 3, len: 2 },
      { seqOffset: 5, len: 1 },
      { seqOffset: 6, len: 4 },
      { seqOffset: 10, len: 5 },
      { seqOffset: 15, len: 1 },
      { seqOffset: 16, len: 8 },
      { seqOffset: 24, len: 1 },
      { seqOffset: 25, len: 1 }
    ].reverse()
  }, t.end.bind(t));
});

test('receive reverse order (large sequence numbers) #3', function(t) {
  receiveTest({
    initialSequenceNumber: Math.pow(2, 32) - 3,
    bufs: [
      { seqOffset: 0, len: 3 },
      { seqOffset: 3, len: 2 },
      { seqOffset: 5, len: 1 },
      { seqOffset: 6, len: 4 }
    ].reverse()
  }, t.end.bind(t));
});

test('receive reverse order (large sequence numbers) #4', function(t) {
  receiveTest({
    initialSequenceNumber: Math.pow(2, 32) - 1,
    bufs: [
      { seqOffset: 0, len: 1 },
      { seqOffset: 1, len: 2 },
      { seqOffset: 3, len: 3 },
      { seqOffset: 6, len: 4 }
    ].reverse()
  }, t.end.bind(t));
});

test('receive reverse order (large sequence numbers) #5', function(t) {
  receiveTest({
    initialSequenceNumber: Math.pow(2, 32) - 1,
    bufs: [
      { seqOffset: 0, len: 10 },
      { seqOffset: 10, len: 1 }
    ].reverse()
  }, t.end.bind(t));
});

test('receive mixed fast path and reverse order', function(t) {
  receiveTestBatch(t, sequenceNumbersList, [
    { seqOffset: 25, len: 1 },
    { seqOffset: 24, len: 1 },
    { seqOffset: 0, len: 3 },
    { seqOffset: 5, len: 1 },
    { seqOffset: 16, len: 8 },
    { seqOffset: 6, len: 4 },
    { seqOffset: 10, len: 5 },
    { seqOffset: 3, len: 2 },
    { seqOffset: 15, len: 1 }
  ]);
});

test('receive fast path duplicates', function(t) {
  receiveTestBatch(t, sequenceNumbersList, [
    { seqOffset: 0, len: 1 },
    { seqOffset: 0, len: 1 },
    { seqOffset: 0, len: 1 },
    { seqOffset: 1, len: 2 },
    { seqOffset: 1, len: 2 },
    { seqOffset: 3, len: 3 },
    { seqOffset: 3, len: 3 },
    { seqOffset: 6, len: 4 },
    { seqOffset: 6, len: 4 },
    { seqOffset: 6, len: 4 }
  ]);
});

test('receive overlapped duplicated data', function(t) {
  receiveTestBatch(t, sequenceNumbersList, [
    { seqOffset: 0, len: 8 },
    { seqOffset: 1, len: 7 },
    { seqOffset: 2, len: 6 },
    { seqOffset: 3, len: 5 },
    { seqOffset: 4, len: 4 },
    { seqOffset: 5, len: 3 },
    { seqOffset: 6, len: 2 },
    { seqOffset: 7, len: 1 }
  ]);
});

test('receive mixed overlapped duplicated and non-duplicated data', function(t) {
  receiveTestBatch(t, sequenceNumbersList, [
    { seqOffset: 0, len: 8 },
    { seqOffset: 1, len: 7 },
    { seqOffset: 2, len: 6 },
    { seqOffset: 2, len: 6 },
    { seqOffset: 3, len: 5 },
    { seqOffset: 4, len: 4 },
    { seqOffset: 5, len: 3 },
    { seqOffset: 5, len: 3 },
    { seqOffset: 6, len: 2 },
    { seqOffset: 7, len: 1 },
    { seqOffset: 8, len: 5 },
    { seqOffset: 13, len: 2 }
  ]);
});
