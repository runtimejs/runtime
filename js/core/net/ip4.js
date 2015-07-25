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
var IP4Address = require('./ip4-address');
var ip4header = require('./ip4-header');
var ip4fragments = require('./ip4-fragments');
var ip4receive = require('./ip4-receive');

function handleReceive(intf, u8, headerOffset) {
  var headerLength = ip4header.getHeaderLength(u8, headerOffset);
  var protocolId = ip4header.getProtocolId(u8, headerOffset);
  var srcIP = ip4header.getSrcIP(u8, headerOffset);
  var destIP = ip4header.getDestIP(u8, headerOffset);
  var nextOffset = headerOffset + headerLength;
  ip4receive(intf, srcIP, destIP, protocolId, u8, nextOffset);
}

exports.receive = function(intf, u8, headerOffset) {
  var fragmentData = ip4header.getFragmentationData(u8, headerOffset);
  var isMoreFragments = ip4header.fragmentationDataIsMoreFragments(fragmentData);
  var fragmentOffset = ip4header.fragmentationDataOffset(fragmentData);

  if (!isMoreFragments && fragmentOffset === 0) {
    handleReceive(intf, u8, headerOffset);
    return;
  }

  ip4fragments.addFragment(intf, u8, headerOffset, fragmentOffset, isMoreFragments);
};
