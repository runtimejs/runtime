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

var Packet = require('net2/packet');
var checksum = require('net/checksum.js');

var kHeaderSize = 8;
var kIP4MinHeaderLength = 20;
var kEthHeaderLength = 14;
var kUdpHeaderLength = 8;

var nextId = 0;
var kIPAny = [0, 0, 0, 0];

function putWordBE(u8, offset, value) {
  u8[offset] = value >>> 8;
  u8[offset + 1] = value >>> 0;
}

function putDWordBE(u8, offset, value) {
  u8[offset] = value >>> 24;
  u8[offset + 1] = value >>> 16;
  u8[offset + 2] = value >>> 8;
  u8[offset + 3] = value >>> 0;
}

function putIP4(u8, offset, protocolId, srcIP, destIP, packetLength) {
  var version = 4; // IPv4
  var IHL = kIP4MinHeaderLength >>> 2;
  var byte0 = ((version << 4) | IHL) >>> 0;

  u8[offset] = byte0;
  u8[offset + 1] = 0; // ToS
  putWordBE(u8, offset + 2, packetLength);
  putWordBE(u8, offset + 4, ++nextId); // ID
  putWordBE(u8, offset + 6, 0); // No fragmantation
  u8[offset + 8] = 64; // TTL
  u8[offset + 9] = protocolId; // Protocol ID
  putWordBE(u8, offset + 10, 0); // Checksum 0
  u8[offset + 12] = srcIP[0];
  u8[offset + 13] = srcIP[1];
  u8[offset + 14] = srcIP[2];
  u8[offset + 15] = srcIP[3];
  u8[offset + 16] = destIP[0];
  u8[offset + 17] = destIP[1];
  u8[offset + 18] = destIP[2];
  u8[offset + 19] = destIP[3];
  putWordBE(u8, offset + 10, checksum.full(u8, offset, kIP4MinHeaderLength, 0));
}

function putICMP(u8, offset, type, code, id, seq, dataChecksum) {
  u8[offset] = type;
  u8[offset + 1] = code;
  putWordBE(u8, offset + 2, 0); // Checksum 0
  putWordBE(u8, offset + 4, id);
  putWordBE(u8, offset + 6, seq)
  putWordBE(u8, offset + 2, checksum.full(u8, offset, kHeaderSize, dataChecksum));
}

function sendICMP(intf, destIP, type, code, id, seq, dataPacket) {

  // +------------------------------+
  // | intarface packet header      |
  // | ethernet header              |
  // | ip4 header                   |
  // | icmp header                  |
  // | data                         |
  // +------------------------------+

  var len = intf.packetHeaderLength + kEthHeaderLength + kIP4MinHeaderLength + kHeaderSize;

  var kProtocolICMP = 1;
  var srcIP = intf.ip || kIPAny;
  var u8 = new Uint8Array(len);

  var ipLength = dataPacket.length() + kIP4MinHeaderLength + kHeaderSize;

  putIP4(u8, intf.packetHeaderLength + kEthHeaderLength, kProtocolICMP, srcIP, destIP, ipLength);
  putICMP(u8, intf.packetHeaderLength + kEthHeaderLength + kIP4MinHeaderLength,
          type, code, id, seq, dataPacket ? dataPacket.checksum(0) : 0);

  var packet = new Packet(u8, len, 0);
  if (dataPacket) {
    packet.setNext(dataPacket);
  }

  return packet;
}

// function sendUDP(intf, destIP, srcPort, destPort) {
//   var len = intf.packetHeaderLength + kEthHeaderLength + kIP4MinHeaderLength + kUdpHeaderLength;
//
// }
