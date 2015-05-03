// Copyright 2014-2015 runtime.js project authors
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

var assert = require('assert');
var Interface = require('./interface');
var interfaces = require('./interfaces');
var route = require('./route');
var MACAddress = require('./mac-address');
var EventController = require('event-controller');
var UDPSocket = require('./udp-socket');
var IP4Address = require('./ip4-address');

var onInterfaceAdded = new EventController();
var onInterfaceRemoved = new EventController();

exports.interfaceAdd = function(intf) {
  assert(intf instanceof Interface);
  interfaces.add(intf);
  onInterfaceAdded.dispatch(intf);
  return intf;
};

exports.UDPSocket = UDPSocket;
exports.IP4Address = IP4Address;
exports.MACAddress = MACAddress;
exports.Interface = Interface;
exports.route = route;

exports.onInterfaceAdded = onInterfaceAdded;
exports.onInterfaceRemoved = onInterfaceRemoved;
