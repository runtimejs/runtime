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

'use strict';
var dhcpPacket = require('./dhcp-packet');
var dhcpOptions = require('./dhcp-options');
var runtime = require('../../core');
var IP4Address = runtime.net.IP4Address;

var STATE_IDLE = 0;
var STATE_DISCOVER_SENT = 1;
var STATE_REQUEST_SENT = 2;
var STATE_ACK_RECEIVED = 2;
var STATE_ERROR = 3;

function sendPacket(socket, srcMAC, type, serverIP, yourIP) {
  // Request info option
  var opt55 = {id: 55, bytes: [
    1, // subnet
    3, // router
    6  // dns
  ]};

  var options;
  if (serverIP && yourIP) {
    var opt54 = {id: 54, bytes: [serverIP.a, serverIP.b, serverIP.c, serverIP.d]};
    var opt50 = {id: 50, bytes: [yourIP.a, yourIP.b, yourIP.c, yourIP.d]};
    options = [opt55, opt54, opt50];
  } else {
    options = [opt55];
  }

  var u8 = dhcpPacket.create(type, srcMAC, options);
  socket.send(IP4Address.BROADCAST, 67, u8);
}

function checkPacket(u8) {
  var op = dhcpPacket.getOperation(u8);
  if (op !== dhcpPacket.OPERATION_RESPONSE) {
    return false;
  }

  if (!dhcpPacket.isValidMagicCookie(u8)) {
    return false;
  }

  return true;
}

function optionToIP(options, id) {
  var option = dhcpOptions.find(options, id, 4);
  if (!option) {
    return IP4Address.ANY;
  }

  return new IP4Address(option[0], option[1], option[2], option[3]);
}

function optionToIPsArray(options, id) {
  var selected = dhcpOptions.findAll(options, id, 4);
  var result = [];
  for (var i = 0, l = selected.length; i < l; ++i) {
    result.push(new IP4Address(selected[i][0], selected[i][1], selected[i][2], selected[i][3]));
  }

  return result;
}

function dhcpConfigure(intf, cb) {
  var macAddress = intf.getMACAddress();
  var socket = new runtime.net.UDPSocket();
  var clientState = STATE_IDLE;

  function handleOffer(serverIP, yourIP, options) {
    var serverId = optionToIP(options, dhcpOptions.OPTION_SERVER_ID);
    if (serverId.isAny()) {
      serverId = serverIP;
    }

    sendPacket(socket, macAddress, dhcpPacket.packetType.REQUEST, serverId, yourIP);
    clientState = STATE_REQUEST_SENT;
  }

  function handleAck(serverIP, yourIP, options) {
    clientState = STATE_ACK_RECEIVED;
    var subnetMask = optionToIP(options, dhcpOptions.OPTION_SUBNET_MASK);
    var routerIPs = optionToIPsArray(options, dhcpOptions.OPTION_ROUTER);
    var dnsIPs = optionToIPsArray(options, dhcpOptions.OPTION_DOMAIN);

    return cb({
      ip: yourIP,
      mask: subnetMask,
      routers: routerIPs,
      dns: dnsIPs
    });
  }

  function parseMessage(serverIP, u8) {
    if (!checkPacket(u8)) {
      return;
    }

    var options = dhcpPacket.getOptions(u8);
    var messageTypeOption = dhcpOptions.find(options, dhcpOptions.OPTION_MESSAGE_TYPE, 1);

    if (!messageTypeOption) {
      return;
    }

    var messageType = messageTypeOption[0];
    var yourIP = dhcpPacket.getYourIP(u8);

    // debug('GOT response', messageType, JSON.stringify(options));

    if (clientState === STATE_DISCOVER_SENT &&
        messageType === dhcpPacket.packetType.OFFER) {
      handleOffer(serverIP, yourIP, options);
      return;
    }

    if (messageType === dhcpPacket.packetType.ACK) {
      handleAck(serverIP, yourIP, options);
      return;
    }
  }

  function err(e) {
    clientState = STATE_ERROR;
    debug(e.stack);
  }

  socket.onmessage = function(ip, port, u8) {
    debug('CLIENT OK', ip, port, u8);
    parseMessage(ip, u8);
  };

  socket.bindToInterface(intf, 68);
  sendPacket(socket, macAddress, dhcpPacket.packetType.DISCOVER, null, null);
  clientState = STATE_DISCOVER_SENT;
}

runtime.net.onInterfaceAdded.add(function(intf) {
  debug('intf add');

  dhcpConfigure(intf, function(config) {
    debug('configure dhcp ok', JSON.stringify(config));
    intf.configure(config.ip, config.mask);

    var subnet = config.ip.and(config.mask);
    runtime.net.route.addSubnet(subnet, config.mask, null, intf);
    runtime.net.route.addDefault(config.routers[0], intf);
    intf.setNetworkEnabled(true);
  });
});
