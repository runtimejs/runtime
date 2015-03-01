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

var eth = require('./eth');
var ipAddress = require('./ip-address');

var HARDWARE_TYPE_ETHERNET = 1;
var PROTOCOL_IP4 = 0x0800;
var OPERATION_REQEUST = 1;
var OPERATION_REPLY = 2;

function parse(reader) {
  var hardwareType = reader.readUint16();
  var protocolType = reader.readUint16();
  var hardwareAddrLen = reader.readUint8();
  var protocolAddrLen = reader.readUint8();
  var op = reader.readUint16();

  if (HARDWARE_TYPE_ETHERNET !== hardwareType) {
    return;
  }

  if (PROTOCOL_IP4 !== protocolType) {
    return;
  }

  if (6 !== hardwareAddrLen) {
    return;
  }

  if (4 !== protocolAddrLen) {
    return;
  }

  var senderHardware = [reader.readUint8(), reader.readUint8(),
              reader.readUint8(), reader.readUint8(),
              reader.readUint8(), reader.readUint8()];

  var senderProtocol = [reader.readUint8(), reader.readUint8(),
              reader.readUint8(), reader.readUint8()];

  var targetHardware = [reader.readUint8(), reader.readUint8(),
              reader.readUint8(), reader.readUint8(),
              reader.readUint8(), reader.readUint8()];

  var targetProtocol = [reader.readUint8(), reader.readUint8(),
              reader.readUint8(), reader.readUint8()];

  // isolate.log('ARP RECV');

  return {
    senderHardware: senderHardware,
    senderProtocol: senderProtocol,
    targetHardware: targetHardware,
    targetProtocol: targetProtocol,
    operation: op
  };
}

function createARPPacket(op, srcHwAddr, srcIpAddr, targetHwAddr, targetIpAddr) {
  var buf = new ArrayBuffer(28);
  var view = new DataView(buf);

  view.setUint16(0, HARDWARE_TYPE_ETHERNET, false);
  view.setUint16(2, PROTOCOL_IP4, false);
  view.setUint8(4, 6); // hwAddr len
  view.setUint8(5, 4); // protocol addr len
  view.setUint16(6, op, false); // operation

  var i, pos = 8;
  for (i = 0; i < 6; ++i) {
    view.setUint8(pos++, srcHwAddr[i], false);
  }
  for (i = 0; i < 4; ++i) {
    view.setUint8(pos++, srcIpAddr[i], false);
  }
  for (i = 0; i < 6; ++i) {
    view.setUint8(pos++, targetHwAddr[i], false);
  }
  for (i = 0; i < 4; ++i) {
    view.setUint8(pos++, targetIpAddr[i], false);
  }

  return buf;
};

function ipToInt(ip) {
  return ((((((+ip[0]) * 0x100) +
             (+ip[1])) * 0x100) +
             (+ip[2])) * 0x100) +
             (+ip[3]);
}

function ARPResolver(intf) {
  this.intf = intf;
  this.arpCacheTable = new Map();
  this.arpRequests = new Map();
}

ARPResolver.prototype.getAddressForIPNoRequest = function(targetIpAddr) {
  var key = ipToInt(targetIpAddr);
  var result = this.arpCacheTable.get(key);
  return result || null;
};

ARPResolver.prototype.getAddressForIP = function(targetIpAddr, cb) {
  var self = this;
  var result = this.getAddressForIPNoRequest(targetIpAddr);
  if (result) {
    return cb(result);
  }

  var key = ipToInt(targetIpAddr);
  var requestInfo = self.arpRequests.get(key);
  if (!requestInfo) {
    requestInfo = [];
    self.arpRequests.set(key, requestInfo);
  }

  isolate.log('[arp] request ' + key)
  requestInfo.push(cb);
  var packet = self.intf.createEthPacket(
    createARPPacket(OPERATION_REQEUST, self.intf.hwAddr,
            self.intf.ip, [0, 0, 0, 0, 0, 0], targetIpAddr));
  self.intf.sendEthBroadcast(eth.etherType.ARP, packet);
};

ARPResolver.prototype.reply = function(targetHW, targetIpAddr) {
  var self = this;
  var packet = self.intf.createEthPacket(
    createARPPacket(OPERATION_REPLY, self.intf.hwAddr,
            self.intf.ip, targetHW, targetIpAddr));
  self.intf.sendEthBroadcast(eth.etherType.ARP, packet);
};

ARPResolver.prototype.recv = function(reader) {
  var self = this;
  var result = parse(reader);
  if (!result) {
    return;
  }

  var senderHw = result.senderHardware;
  var senderIP = result.senderProtocol;
  var targetIP = result.targetProtocol;
  var selfIP = self.intf.ip;
  var key = ipToInt(senderIP);

  switch (result.operation) {
  case OPERATION_REQEUST:
    // Somebody requested this machine IP
    if (selfIP && ipAddress.compareIP4(selfIP, targetIP)) {
      self.reply(senderHw, targetIP);
    }
    break;
  case OPERATION_REPLY:
    // Update cache
    self.arpCacheTable.set(key, senderHw);

    // Resolve all pending requests
    var requestInfo = self.arpRequests.get(key);
    if (requestInfo) {
      for (var i = 0; i < requestInfo.length; ++i) {
        requestInfo[i](senderHw);
      }

      self.arpRequests.delete(key);
    }
    break;
  }

  // isolate.log(JSON.stringify(result));
}

module.exports = {
  ARPResolver: ARPResolver,
};
