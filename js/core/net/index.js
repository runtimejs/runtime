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
var assert = require('assert');
var Interface = require('./interface');
var interfaces = require('./interfaces');
var route = require('./route');
var MACAddress = require('./mac-address');
var EventController = require('event-controller');
var UDPSocket = require('./udp-socket');
var IP4Address = require('./ip4-address');
var loopback = require('./loopback');
var TCPSocket = require('./tcp-socket');
var TCPServerSocket = require('./tcp-server-socket');
var Ping = require('./ping');
var stat = require('./net-stat');

var onInterfaceAdded = new EventController();
var onInterfaceRemoved = new EventController();

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
