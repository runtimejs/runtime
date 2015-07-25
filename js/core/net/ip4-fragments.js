// Copyright 2015 runtime.js project authors
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

var ip4header = require('./ip4-header');
var ip4receive = require('./ip4-receive');

function fragmentHash(srcIP, destIP, protocolId, packetId) {
  return srcIP.toInteger() + '-' + destIP.toInteger() + '-' + (packetId + (protocolId << 16));
}

function dropFragmentQueue(intf, hash) {
  intf.fragments.delete(hash);
}

exports.addFragment = function(intf, u8, headerOffset, fragmentOffset, isMoreFragments) {
  var headerLength = ip4header.getHeaderLength(u8, headerOffset);
  var protocolId = ip4header.getProtocolId(u8, headerOffset);
  var srcIP = ip4header.getSrcIP(u8, headerOffset);
  var destIP = ip4header.getDestIP(u8, headerOffset);
  var packetId = ip4header.getIdentification(u8, headerOffset);
  var nextOffset = headerOffset + headerLength;

  var hash = fragmentHash(srcIP, destIP, packetId, protocolId);

  var firstFragment = false;
  var fragmentQueue = intf.fragments.get(hash);
  if (!fragmentQueue) {
    firstFragment = true;
    fragmentQueue = {
      receivedLength: 0,
      totalLength: 0,
      fragments: []
    };
  }

  var fragmentLength = u8.length - nextOffset;
  if (fragmentLength <= 0) {
    return;
  }

  var fragmentEnd = fragmentOffset + fragmentLength;

  if (fragmentEnd > 0xffff) {
    return;
  }

  // Locate non overlapping portion of new fragment
  var newOffset = fragmentOffset;
  var newEnd = fragmentEnd;
  var newNextOffset = nextOffset;
  for (var i = 0, l = fragmentQueue.fragments.length; i < l; ++i) {
    var fragment = fragmentQueue.fragments[i];
    if (!fragment) {
      continue;
    }

    var fragBegin = fragment[0];
    var fragEnd = fragBegin + fragment[1];

    var overlapOffset = newOffset >= fragBegin && newOffset <= fragEnd;
    var overlapEnd = newEnd >= fragBegin && newEnd <= fragEnd;

    // New fragment is fully contained within another fragment,
    // just ignore it
    if (overlapOffset && overlapEnd) {
      return;
    }

    // First fragment byte is somewhere withing existing fragment
    if (overlapOffset && newOffset < fragEnd) {
      newNextOffset += fragEnd - newOffset;
      newOffset = fragEnd;
    }

    // Last fragment byte is somewhere withing existing fragment
    if (overlapEnd && newEnd > fragBegin) {
      newEnd = fragBegin;
    }
  }

  // Remove old fragments fully contained within the new one
  // By doing this we can avoid splitting big new fragments into
  // smaller chunks
  var removedIndex = -1;
  for (var i = 0, l = fragmentQueue.fragments.length; i < l; ++i) {
    var fragment = fragmentQueue.fragments[i];
    if (!fragment) {
      continue;
    }

    var fragBegin = fragment[0];
    var fragEnd = fragBegin + fragment[1];

    if (fragBegin >= newOffset && fragBegin <= newEnd &&
        fragEnd >= newOffset && fragEnd <= newEnd) {
      // remove this old fragment
      fragmentQueue.fragments[i] = null;
      fragmentQueue.receivedLength -= fragment[1];
      removedIndex = i;
    }
  }

  var newLength = newEnd - newOffset;

  // fragment offset - fragement length - buffer data offset - buffer
  var newFragment = [newOffset, newLength, newNextOffset, u8];

  if (removedIndex >= 0) {
    fragmentQueue.fragments[removedIndex] = newFragment;
  } else {
    fragmentQueue.fragments.push(newFragment);
  }

  fragmentQueue.receivedLength += newLength;

  // Last fragment?
  if (!isMoreFragments) {

    // Another last fragment?
    if (fragmentQueue.totalLength > fragmentEnd) {
      // Wrong len
      return;
    }

    fragmentQueue.totalLength = fragmentEnd;
  }

  if (firstFragment) {
    intf.fragments.set(hash, fragmentQueue);
  }

  if (fragmentQueue.totalLength === fragmentQueue.receivedLength) {
    var u8asm = new Uint8Array(fragmentQueue.totalLength);
    for (var i = 0, l = fragmentQueue.fragments.length; i < l; ++i) {
      var fragment = fragmentQueue.fragments[i];
      if (!fragment) {
        continue;
      }

      var itemOffset = fragment[0];
      var itemLength = fragment[1];
      var itemNextOffset = fragment[2];
      var itemBuffer = fragment[3];
      u8asm.set(itemBuffer.subarray(itemNextOffset, itemNextOffset + itemLength), itemOffset);
    }

    dropFragmentQueue(intf, hash);
    ip4receive(intf, srcIP, destIP, protocolId, u8asm, 0);
    return;
  }
};
