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
// const IP4Address = require('./ip4-address');
const ip4header = require('./ip4-header');
const ip4fragments = require('./ip4-fragments');
const ip4receive = require('./ip4-receive');
const timers = require('../timers');
const interfaces = require('./interfaces');

timers.scheduleTask5s(() => interfaces.forEach(ip4fragments.tick));

function handleReceive(intf, u8, headerOffset) {
  const headerLength = ip4header.getHeaderLength(u8, headerOffset);
  const protocolId = ip4header.getProtocolId(u8, headerOffset);
  const srcIP = ip4header.getSrcIP(u8, headerOffset);
  const destIP = ip4header.getDestIP(u8, headerOffset);
  const nextOffset = headerOffset + headerLength;
  ip4receive(intf, srcIP, destIP, protocolId, u8, nextOffset);
}

exports.receive = (intf, u8, headerOffset) => {
  const fragmentData = ip4header.getFragmentationData(u8, headerOffset);
  const isMoreFragments = ip4header.fragmentationDataIsMoreFragments(fragmentData);
  const fragmentOffset = ip4header.fragmentationDataOffset(fragmentData);

  if (!isMoreFragments && fragmentOffset === 0) {
    handleReceive(intf, u8, headerOffset);
    return;
  }

  ip4fragments.addFragment(intf, u8, headerOffset, fragmentOffset, isMoreFragments);
};
