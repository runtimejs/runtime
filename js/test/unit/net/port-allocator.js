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
// const assert = require('assert');
const PortAllocator = require('../../../core/net/port-allocator');
const EPHEMERAL_PORT_FIRST = 49152;

test('ephemeral only: simple allocation', (t) => {
  const allocator = new PortAllocator();
  const socket = {};

  // alloc 10 ports
  for (let i = 0; i < 10; ++i) {
    t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + i);
  }

  // free first 3 ports
  allocator.free(EPHEMERAL_PORT_FIRST + 0);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  allocator.free(EPHEMERAL_PORT_FIRST + 2);

  // alloc the same 3 ports again
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 0);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 1);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 2);

  // alloc and realloc 11th port
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 10);
  allocator.free(EPHEMERAL_PORT_FIRST + 10);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 10);

  // alloc 12th port
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 11);

  t.end();
});

test('ephemeral only: allocate and free all ports', (t) => {
  const allocator = new PortAllocator();
  const socket = {};

  let next = 0;
  for (;;) {
    const port = allocator.allocEphemeral(socket);
    if (port === 0) {
      break;
    }

    if (port !== EPHEMERAL_PORT_FIRST + next++) {
      t.equal(port, EPHEMERAL_PORT_FIRST + next++);
    }
  }

  t.equal(next, 16000);
  t.equal(allocator.allocatedCount, 16000);

  while (next-- > 0) {
    allocator.free(((16000 - next) - 1) + EPHEMERAL_PORT_FIRST);
  }

  t.equal(allocator.allocatedCount, 0);
  t.equal(allocator._sockets.length, 0);

  for (;;) {
    const port = allocator.allocEphemeral(socket);
    if (port === 0) {
      break;
    }
  }

  t.equal(allocator.allocatedCount, 16000);
  t.end();
});

test('ephemeral only: handle double free', (t) => {
  const allocator = new PortAllocator();
  const socket = {};
  t.equal(allocator.allocatedCount, 0);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 0);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 1);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 2);
  t.equal(allocator.allocatedCount, 3);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  t.equal(allocator.allocatedCount, 2);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  t.equal(allocator.allocatedCount, 2);
  t.end();
});

test('alloc port', (t) => {
  const allocator = new PortAllocator();
  const socket = {};
  t.equal(allocator.allocPort(80, socket), true);
  t.equal(allocator.allocatedCount, 1);
  t.equal(allocator.allocPort(8080, socket), true);
  t.equal(allocator.allocatedCount, 2);
  allocator.free(80);
  t.equal(allocator.allocatedCount, 1);
  allocator.free(8080);
  t.equal(allocator.allocatedCount, 0);
  t.end();
});

test('directly alloc and free all ports', (t) => {
  const allocator = new PortAllocator();
  const socket = {};

  for (let i = 1; i < 65536; ++i) {
    allocator.allocPort(i, socket);
  }

  t.equal(allocator.allocatedCount, 65535);

  for (let i = 1; i < 65536; ++i) {
    allocator.free(i);
  }

  t.equal(allocator.allocatedCount, 0);
  t.end();
});

test('directly alloc all ports and try to get ephemeral', (t) => {
  const allocator = new PortAllocator();
  const socket = {};

  for (let i = 1; i < 65536; ++i) {
    allocator.allocPort(i, socket);
  }

  t.equal(allocator.allocatedCount, 65535);
  t.equal(allocator.allocEphemeral(socket), 0);
  t.equal(allocator.allocatedCount, 65535);
  allocator.free(80);
  t.equal(allocator.allocatedCount, 65534);
  t.equal(allocator.allocEphemeral(socket), 0);
  allocator.free(EPHEMERAL_PORT_FIRST);
  t.equal(allocator.allocatedCount, 65533);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST);
  t.equal(allocator.allocatedCount, 65534);
  t.equal(allocator.allocEphemeral(socket), 0);
  t.equal(allocator.allocatedCount, 65534);
  allocator.free(EPHEMERAL_PORT_FIRST);
  t.equal(allocator.allocatedCount, 65533);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST);
  t.equal(allocator.allocatedCount, 65534);

  for (let i = 1; i < 65536; ++i) {
    allocator.free(i);
  }

  t.equal(allocator.allocatedCount, 0);
  t.end();
});

test('cannot allocate port twice', (t) => {
  const allocator = new PortAllocator();
  const socket = {};
  t.equal(allocator.allocatedCount, 0);
  t.equal(allocator.allocPort(EPHEMERAL_PORT_FIRST + 2, socket), true);
  t.equal(allocator.allocPort(EPHEMERAL_PORT_FIRST + 2, socket), false);
  t.equal(allocator.allocPort(EPHEMERAL_PORT_FIRST + 2, socket), false);
  t.equal(allocator.allocatedCount, 1);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 0);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 1);
  t.equal(allocator.allocatedCount, 3);
  t.equal(allocator.allocPort(EPHEMERAL_PORT_FIRST + 0, socket), false);
  t.equal(allocator.allocPort(EPHEMERAL_PORT_FIRST + 1, socket), false);
  t.equal(allocator.allocatedCount, 3);
  t.end();
});

test('skip directly allocated ephemeral port', (t) => {
  const allocator = new PortAllocator();
  const socket = {};
  t.equal(allocator.allocatedCount, 0);
  t.equal(allocator.allocPort(EPHEMERAL_PORT_FIRST, socket), true);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 1);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 2);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 3);
  t.equal(allocator.allocatedCount, 4);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  t.equal(allocator.allocatedCount, 3);
  allocator.free(EPHEMERAL_PORT_FIRST + 2);
  allocator.free(EPHEMERAL_PORT_FIRST + 3);
  allocator.free(EPHEMERAL_PORT_FIRST + 3);
  t.equal(allocator.allocatedCount, 1);
  allocator.free(EPHEMERAL_PORT_FIRST);
  allocator.free(EPHEMERAL_PORT_FIRST);
  t.equal(allocator.allocatedCount, 0);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 1);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 2);
  t.equal(allocator.allocatedCount, 3);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  t.equal(allocator.allocatedCount, 2);
  t.equal(allocator.allocPort(EPHEMERAL_PORT_FIRST + 1, socket), true);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 3);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 4);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 5);
  t.equal(allocator.allocatedCount, 6);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  t.equal(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 1);
  t.equal(allocator.allocatedCount, 6);
  t.end();
});

test('lookups', (t) => {
  const allocator = new PortAllocator();
  const socket1 = 'socket1';
  const socket2 = 'socket2';
  const socket3 = 'socket3';
  allocator.allocPort(EPHEMERAL_PORT_FIRST + 1, socket1);
  t.equal(allocator.lookup(EPHEMERAL_PORT_FIRST + 1), socket1);
  const port1 = allocator.allocEphemeral(socket2);
  const port2 = allocator.allocEphemeral(socket3);
  t.equal(port1, EPHEMERAL_PORT_FIRST + 0);
  t.equal(port2, EPHEMERAL_PORT_FIRST + 2);
  t.equal(allocator.lookup(port1), socket2);
  t.equal(allocator.lookup(port2), socket3);
  t.equal(allocator.lookup(EPHEMERAL_PORT_FIRST + 1), socket1);
  allocator.free(port1);
  t.equal(allocator.lookup(port1), null);
  t.equal(allocator.lookup(port2), socket3);
  allocator.free(port2);
  t.equal(allocator.lookup(port1), null);
  t.equal(allocator.lookup(port2), null);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  t.equal(allocator.lookup(EPHEMERAL_PORT_FIRST + 1), null);
  t.end();
});
