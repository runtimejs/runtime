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

const BufferBuilder = require('./buffer-builder');
const IP4Address = require('../../../core/net/ip4-address');
const MACAddress = require('../../../core/net/mac-address');
const checksum = require('../../../core/net/checksum');

function cksum(u8) {
  return checksum(u8, 0, u8.length, 0);
}

exports.createEthernetIP4 = (protocol, payload, opts = {}) => {
  const srcIP = IP4Address.parse(opts.srcIP) || new IP4Address(127, 0, 0, 1);
  const destIP = IP4Address.parse(opts.destIP) || IP4Address.ANY;
  const srcMAC = MACAddress.parse(opts.srcMAC) || MACAddress.ZERO;
  const destMAC = MACAddress.parse(opts.destMAC) || MACAddress.ZERO;
  const etherType = opts.etherType || 0x0800;
  const tos = opts.tos || 0;
  const id = opts.id || 0;
  const dontFragment = opts.dontFragment || false;
  const moreFragments = opts.moreFragments || false;
  const fragmentOffsetBytes = opts.fragmentOffsetBytes || 0;
  const ttl = opts.ttl || 64;

  let fragmentData = (opts.fragmentOffsetBytes >>> 3) & 0x1fff;

  if ((fragmentData << 3) !== fragmentOffsetBytes) {
    throw new Error(`invalid fragment offset ${fragmentOffsetBytes} byte(s)`);
  }

  if (dontFragment) {
    fragmentData |= (1 << 14);
  }
  if (moreFragments) {
    fragmentData |= (1 << 13);
  }

  let protocolId = 0;
  switch (protocol) {
    case 'icmp':
      protocolId = 0x01;
      break;
    case 'tcp':
      protocolId = 0x06;
      break;
    case 'udp':
      protocolId = 0x11;
      break;
    default:
      throw new Error('unknown protocol');
  }

  return new BufferBuilder()
    .uint8(destMAC.a) // ethernet destMAC
    .uint8(destMAC.b) // ethernet destMAC
    .uint8(destMAC.c) // ethernet destMAC
    .uint8(destMAC.d) // ethernet destMAC
    .uint8(destMAC.e) // ethernet destMAC
    .uint8(destMAC.f) // ethernet destMAC
    .uint8(srcMAC.a) // ethernet srcMAC
    .uint8(srcMAC.b) // ethernet srcMAC
    .uint8(srcMAC.c) // ethernet srcMAC
    .uint8(srcMAC.d) // ethernet srcMAC
    .uint8(srcMAC.e) // ethernet srcMAC
    .uint8(srcMAC.f) // ethernet srcMAC
    .uint16(etherType) // ethernet etherType
    .beginChecksum()
    .uint8((4 << 4) | (20 >>> 2)) // ip4 version & header length
    .uint8(tos) // ip4 ToS
    .uint16(payload.length) // ip4 length
    .uint16(id) // ip4 ID
    .uint16(fragmentData) // ip4 fragmentation
    .uint8(ttl) // ip4 TTL
    .uint8(protocolId) // ip4 protocol ID
    .checksum(cksum) // ip4 checksum
    .uint8(srcIP.a) // ip4 src ip
    .uint8(srcIP.b) // ip4 src ip
    .uint8(srcIP.c) // ip4 src ip
    .uint8(srcIP.d) // ip4 src ip
    .uint8(destIP.a) // ip4 dest ip
    .uint8(destIP.b) // ip4 dest ip
    .uint8(destIP.c) // ip4 dest ip
    .uint8(destIP.d) // ip4 dest ip
    .endChecksum()
    .array(payload)
    .buffer();
};

exports.createUDP = (payload, opts = {}) => {
  const srcPort = opts.srcPort || 1;
  const destPort = opts.destPort || 1;

  return new BufferBuilder()
    .uint16(srcPort)
    .uint16(destPort)
    .uint16(payload.length)
    .uint16(0) // skip checksum
    .array(payload)
    .buffer();
};

exports.splitBuffer = (u8Opt, chunks) => {
  let u8 = u8Opt;
  const results = [];
  for (const chunkLength of chunks) {
    if (u8.length < chunkLength) {
      throw new Error('need bigger buffer to produce chunks');
    }
    results.push(u8.subarray(0, chunkLength));
    u8 = u8.subarray(chunkLength);
  }

  if (u8.length > 0) {
    results.push(u8);
  }

  return results;
};

exports.makeBuffer = (length, firstValueOpt = 0) => {
  let firstValue = firstValueOpt;
  const u8 = new Uint8Array(length);
  for (let i = 0; i < u8.length; ++i) {
    u8[i] = firstValue++;
  }
  return u8;
};

exports.buffersEqual = (a, b) => {
  if (!(a instanceof Uint8Array) || !(b instanceof Uint8Array)) {
    return false;
  }
  if (a.length !== b.length) {
    return false;
  }

  for (let i = 0; i < a.length; ++i) {
    if (a[i] !== b[i]) {
      return false;
    }

    return true;
  }
};

exports.makeBufferSlices = (u8, slices) => {
  const results = [];
  for (const slice of slices) {
    results.push(u8.subarray(slice.offset, slice.offset + slice.len));
  }
  return results;
};

exports.createFragmentedIP4 = (optsOpt, payloadLength, slices) => {
  const opts = optsOpt;
  if (payloadLength < 8) {
    throw new Error('no space for udp header in fragmented buffers');
  }

  const dataBuffer = exports.makeBuffer(payloadLength - 8);
  const udp = exports.createUDP(dataBuffer, opts);
  const fragments = exports.makeBufferSlices(udp, slices);

  const ip4fragments = [];
  for (let i = 0; i < fragments.length; ++i) {
    const fragment = fragments[i];
    opts.fragmentOffsetBytes = slices[i].offset;
    opts.moreFragments = payloadLength !== slices[i].offset + slices[i].len;
    ip4fragments.push(exports.createEthernetIP4('udp', fragment, opts));
  }

  return ip4fragments;
};
