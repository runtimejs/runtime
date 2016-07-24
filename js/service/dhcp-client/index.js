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
const dhcpPacket = require('./dhcp-packet');
const dhcpOptions = require('./dhcp-options');
const runtime = require('../../core');
const { IP4Address } = runtime.net;

const STATE_IDLE = 0;
const STATE_DISCOVER_SENT = 1;
const STATE_REQUEST_SENT = 2;
const STATE_ACK_RECEIVED = 2;
// const STATE_ERROR = 3;

function sendPacket(socket, srcMAC, type, serverIP, yourIP) {
  // Request info option
  const opt55 = {
    id: 55,
    bytes: [
      1, // subnet
      3, // router
      6, // dns
    ],
  };

  let options;
  if (serverIP && yourIP) {
    const opt54 = {
      id: 54,
      bytes: [serverIP.a, serverIP.b, serverIP.c, serverIP.d],
    };
    const opt50 = {
      id: 50,
      bytes: [yourIP.a, yourIP.b, yourIP.c, yourIP.d],
    };
    options = [opt55, opt54, opt50];
  } else {
    options = [opt55];
  }

  const u8 = dhcpPacket.create(type, srcMAC, options);
  socket.send(IP4Address.BROADCAST, 67, u8);
}

function checkPacket(u8) {
  const op = dhcpPacket.getOperation(u8);

  if (op !== dhcpPacket.OPERATION_RESPONSE) {
    return false;
  }
  if (!dhcpPacket.isValidMagicCookie(u8)) {
    return false;
  }

  return true;
}

function optionToIP(options, id) {
  const option = dhcpOptions.find(options, id, 4);
  if (!option) {
    return IP4Address.ANY;
  }

  return new IP4Address(option[0], option[1], option[2], option[3]);
}

function optionToIPsArray(options, id) {
  const selected = dhcpOptions.findAll(options, id, 4);
  const result = [];
  for (const sel of selected) {
    result.push(new IP4Address(sel[0], sel[1], sel[2], sel[3]));
  }

  return result;
}

function dhcpConfigure(intf, cb) {
  const macAddress = intf.getMACAddress();
  const socket = new runtime.net.UDPSocket();
  let clientState = STATE_IDLE;

  function handleOffer(serverIP, yourIP, options) {
    let serverId = optionToIP(options, dhcpOptions.OPTION_SERVER_ID);
    if (serverId.isAny()) {
      serverId = serverIP;
    }

    sendPacket(socket, macAddress, dhcpPacket.packetType.REQUEST, serverId, yourIP);
    clientState = STATE_REQUEST_SENT;
  }

  function handleAck(serverIP, yourIP, options) {
    clientState = STATE_ACK_RECEIVED;

    return cb({
      ip: yourIP,
      mask: optionToIP(options, dhcpOptions.OPTION_SUBNET_MASK),
      routers: optionToIPsArray(options, dhcpOptions.OPTION_ROUTER),
      dns: optionToIPsArray(options, dhcpOptions.OPTION_DOMAIN),
    });
  }

  function parseMessage(serverIP, u8) {
    if (!checkPacket(u8)) {
      return;
    }

    const options = dhcpPacket.getOptions(u8);
    const messageTypeOption = dhcpOptions.find(options, dhcpOptions.OPTION_MESSAGE_TYPE, 1);

    if (!messageTypeOption) {
      return;
    }

    const messageType = messageTypeOption[0];
    const yourIP = dhcpPacket.getYourIP(u8);

  // debug('GOT response', messageType, JSON.stringify(options));

    if (clientState === STATE_DISCOVER_SENT && messageType === dhcpPacket.packetType.OFFER) {
      handleOffer(serverIP, yourIP, options);
      return;
    }

    if (messageType === dhcpPacket.packetType.ACK) {
      handleAck(serverIP, yourIP, options);
      return;
    }
  }

/* function err(e) {
  clientState = STATE_ERROR;
  debug(e.stack);
}; */

  socket.onmessage = (ip, port, u8) => {
    debug('CLIENT OK', ip, port, u8);
    parseMessage(ip, u8);
  };

  socket.bindToInterface(intf, 68);
  sendPacket(socket, macAddress, dhcpPacket.packetType.DISCOVER, null, null);
  clientState = STATE_DISCOVER_SENT;
}

runtime.net.onInterfaceAdded.add((intf) => {
  debug('intf add');

  dhcpConfigure(intf, (config) => {
    debug('configure dhcp ok', JSON.stringify(config));
    intf.configure(config.ip, config.mask);

    const subnet = config.ip.and(config.mask);
    runtime.net.route.addSubnet(subnet, config.mask, null, intf);
    runtime.net.route.addDefault(config.routers[0], intf);
    intf.setNetworkEnabled(true);
  });
});
