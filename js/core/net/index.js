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
const assert = require('assert');
const Interface = require('./interface');
const interfaces = require('./interfaces');
const route = require('./route');
const MACAddress = require('./mac-address');
const EventController = require('event-controller');
const UDPSocket = require('./udp-socket');
const IP4Address = require('./ip4-address');
const loopback = require('./loopback');
const TCPSocket = require('./tcp-socket');
const TCPServerSocket = require('./tcp-server-socket');
const Ping = require('./ping');
const stat = require('./net-stat');

const onInterfaceAdded = new EventController();
const onInterfaceRemoved = new EventController();

function interfaceAdd(intf) {
  assert(intf instanceof Interface);
  interfaces.add(intf);
  onInterfaceAdded.dispatch(intf);
  return intf;
}

// Add loopback interface
interfaces.add(loopback);

exports.interfaceAdd = interfaceAdd;
exports.TCPSocket = TCPSocket;
exports.TCPServerSocket = TCPServerSocket;
exports.UDPSocket = UDPSocket;
exports.IP4Address = IP4Address;
exports.MACAddress = MACAddress;
exports.Interface = Interface;
exports.Ping = Ping;
exports.route = route;
exports.stat = stat;

exports.onInterfaceAdded = onInterfaceAdded;
exports.onInterfaceRemoved = onInterfaceRemoved;
