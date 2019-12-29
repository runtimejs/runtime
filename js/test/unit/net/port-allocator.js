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
const PortAllocator = require('/js/core/net/port-allocator');
const EPHEMERAL_PORT_FIRST = 49152;

test('ephemeral only: simple allocation', t => {
  const allocator = new PortAllocator();
  const socket = {};

  // alloc 10 ports
  for (let i = 0; i < 10; ++i) {
    t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + i);
  }

  // free first 3 ports
  allocator.free(EPHEMERAL_PORT_FIRST + 0);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  allocator.free(EPHEMERAL_PORT_FIRST + 2);

  // alloc the same 3 ports again
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 0);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 1);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 2);

  // alloc and realloc 11th port
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 10);
  allocator.free(EPHEMERAL_PORT_FIRST + 10);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 10);

  // alloc 12th port
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 11);
});

test('ephemeral only: allocate and free all ports', t => {
  const allocator = new PortAllocator();
  const socket = {};

  let next = 0;
  for (;;) {
    const port = allocator.allocEphemeral(socket);
    if (port === 0) {
      break;
    }

    if (port !== EPHEMERAL_PORT_FIRST + next++) {
      t.is(port, EPHEMERAL_PORT_FIRST + next++);
    }
  }

  t.is(next, 16000);
  t.is(allocator.allocatedCount, 16000);

  while (next-- > 0) {
    allocator.free(((16000 - next) - 1) + EPHEMERAL_PORT_FIRST);
  }

  t.is(allocator.allocatedCount, 0);
  t.is(allocator._sockets.length, 0);

  for (;;) {
    const port = allocator.allocEphemeral(socket);
    if (port === 0) {
      break;
    }
  }

  t.is(allocator.allocatedCount, 16000);
});

test('ephemeral only: handle double free', t => {
  const allocator = new PortAllocator();
  const socket = {};
  t.is(allocator.allocatedCount, 0);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 0);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 1);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 2);
  t.is(allocator.allocatedCount, 3);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  t.is(allocator.allocatedCount, 2);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  t.is(allocator.allocatedCount, 2);
});

test('alloc port', t => {
  const allocator = new PortAllocator();
  const socket = {};
  t.is(allocator.allocPort(80, socket), true);
  t.is(allocator.allocatedCount, 1);
  t.is(allocator.allocPort(8080, socket), true);
  t.is(allocator.allocatedCount, 2);
  allocator.free(80);
  t.is(allocator.allocatedCount, 1);
  allocator.free(8080);
  t.is(allocator.allocatedCount, 0);
});

test('directly alloc and free all ports', t => {
  const allocator = new PortAllocator();
  const socket = {};

  for (let i = 1; i < 65536; ++i) {
    allocator.allocPort(i, socket);
  }

  t.is(allocator.allocatedCount, 65535);

  for (let i = 1; i < 65536; ++i) {
    allocator.free(i);
  }

  t.is(allocator.allocatedCount, 0);
});

test('directly alloc all ports and try to get ephemeral', t => {
  const allocator = new PortAllocator();
  const socket = {};

  for (let i = 1; i < 65536; ++i) {
    allocator.allocPort(i, socket);
  }

  t.is(allocator.allocatedCount, 65535);
  t.is(allocator.allocEphemeral(socket), 0);
  t.is(allocator.allocatedCount, 65535);
  allocator.free(80);
  t.is(allocator.allocatedCount, 65534);
  t.is(allocator.allocEphemeral(socket), 0);
  allocator.free(EPHEMERAL_PORT_FIRST);
  t.is(allocator.allocatedCount, 65533);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST);
  t.is(allocator.allocatedCount, 65534);
  t.is(allocator.allocEphemeral(socket), 0);
  t.is(allocator.allocatedCount, 65534);
  allocator.free(EPHEMERAL_PORT_FIRST);
  t.is(allocator.allocatedCount, 65533);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST);
  t.is(allocator.allocatedCount, 65534);

  for (let i = 1; i < 65536; ++i) {
    allocator.free(i);
  }

  t.is(allocator.allocatedCount, 0);
});

test('cannot allocate port twice', t => {
  const allocator = new PortAllocator();
  const socket = {};
  t.is(allocator.allocatedCount, 0);
  t.is(allocator.allocPort(EPHEMERAL_PORT_FIRST + 2, socket), true);
  t.is(allocator.allocPort(EPHEMERAL_PORT_FIRST + 2, socket), false);
  t.is(allocator.allocPort(EPHEMERAL_PORT_FIRST + 2, socket), false);
  t.is(allocator.allocatedCount, 1);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 0);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 1);
  t.is(allocator.allocatedCount, 3);
  t.is(allocator.allocPort(EPHEMERAL_PORT_FIRST + 0, socket), false);
  t.is(allocator.allocPort(EPHEMERAL_PORT_FIRST + 1, socket), false);
  t.is(allocator.allocatedCount, 3);
});

test('skip directly allocated ephemeral port', t => {
  const allocator = new PortAllocator();
  const socket = {};
  t.is(allocator.allocatedCount, 0);
  t.is(allocator.allocPort(EPHEMERAL_PORT_FIRST, socket), true);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 1);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 2);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 3);
  t.is(allocator.allocatedCount, 4);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  t.is(allocator.allocatedCount, 3);
  allocator.free(EPHEMERAL_PORT_FIRST + 2);
  allocator.free(EPHEMERAL_PORT_FIRST + 3);
  allocator.free(EPHEMERAL_PORT_FIRST + 3);
  t.is(allocator.allocatedCount, 1);
  allocator.free(EPHEMERAL_PORT_FIRST);
  allocator.free(EPHEMERAL_PORT_FIRST);
  t.is(allocator.allocatedCount, 0);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 1);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 2);
  t.is(allocator.allocatedCount, 3);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  t.is(allocator.allocatedCount, 2);
  t.is(allocator.allocPort(EPHEMERAL_PORT_FIRST + 1, socket), true);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 3);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 4);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 5);
  t.is(allocator.allocatedCount, 6);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  t.is(allocator.allocEphemeral(socket), EPHEMERAL_PORT_FIRST + 1);
  t.is(allocator.allocatedCount, 6);
});

test('lookups', t => {
  const allocator = new PortAllocator();
  const socket1 = 'socket1';
  const socket2 = 'socket2';
  const socket3 = 'socket3';
  allocator.allocPort(EPHEMERAL_PORT_FIRST + 1, socket1);
  t.is(allocator.lookup(EPHEMERAL_PORT_FIRST + 1), socket1);
  const port1 = allocator.allocEphemeral(socket2);
  const port2 = allocator.allocEphemeral(socket3);
  t.is(port1, EPHEMERAL_PORT_FIRST + 0);
  t.is(port2, EPHEMERAL_PORT_FIRST + 2);
  t.is(allocator.lookup(port1), socket2);
  t.is(allocator.lookup(port2), socket3);
  t.is(allocator.lookup(EPHEMERAL_PORT_FIRST + 1), socket1);
  allocator.free(port1);
  t.is(allocator.lookup(port1), null);
  t.is(allocator.lookup(port2), socket3);
  allocator.free(port2);
  t.is(allocator.lookup(port1), null);
  t.is(allocator.lookup(port2), null);
  allocator.free(EPHEMERAL_PORT_FIRST + 1);
  t.is(allocator.lookup(EPHEMERAL_PORT_FIRST + 1), null);
});
