// Copyright 2014 Runtime.JS project authors
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

var table = [];

function Entry(ip, mask, gateway, intf, metric) {
  this.ip = ip;
  this.mask = mask;
  this.gateway = gateway;
  this.intf = intf;
  this.metric = metric;
}

function ipAND(ip1, ip2) {
  return [ip1[0] & ip2[0], ip1[1] & ip2[1],
    ip1[2] & ip2[2], ip1[3] & ip2[3]];
}

function ipEQUAL(ip1, ip2) {
  return ip1[0] === ip2[0] && ip1[1] === ip2[1] &&
    ip1[2] === ip2[2] && ip1[3] === ip2[3];
}

exports.add = function(ip, mask, gateway, intf) {
  table.push(new Entry(ip, mask, gateway, intf));
}

exports.get = function(destIP) {
}
