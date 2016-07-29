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

const ip4header = require('./ip4-header');
const ip4receive = require('./ip4-receive');
const { timeNow } = require('../../utils');
const FRAGMENT_QUEUE_MAX_AGE_MS = 30000;
const FRAGMENT_QUEUE_MAX_COUNT = 100;

function fragmentHash(srcIP, destIP, protocolId, packetId) {
  return `${srcIP.toInteger()}-${destIP.toInteger()}-${(packetId + (protocolId << 16))}`;
}

function dropFragmentQueue(intf, hash) {
  return intf.fragments.delete(hash);
}

exports.addFragment = (intf, u8, headerOffset, fragmentOffset, isMoreFragments) => {
  const headerLength = ip4header.getHeaderLength(u8, headerOffset);
  const protocolId = ip4header.getProtocolId(u8, headerOffset);
  const srcIP = ip4header.getSrcIP(u8, headerOffset);
  const destIP = ip4header.getDestIP(u8, headerOffset);
  const packetId = ip4header.getIdentification(u8, headerOffset);
  const nextOffset = headerOffset + headerLength;

  const hash = fragmentHash(srcIP, destIP, packetId, protocolId);

  let firstFragment = false;
  let fragmentQueue = intf.fragments.get(hash);
  if (!fragmentQueue) {
    if (intf.fragments.size >= FRAGMENT_QUEUE_MAX_COUNT) {
      return;
    } // too many fragment queues

    firstFragment = true;
    fragmentQueue = {
      receivedLength: 0,
      totalLength: 0,
      createdAt: timeNow(),
      fragments: [],
    };
  }

  const fragmentLength = u8.length - nextOffset;
  if (fragmentLength <= 0) {
    return;
  }

  const fragmentEnd = fragmentOffset + fragmentLength;
  if (fragmentEnd > 0xffff) {
    return;
  }

  // Locate non overlapping portion of new fragment
  let newOffset = fragmentOffset;
  let newEnd = fragmentEnd;
  let newNextOffset = nextOffset;
  for (const fragment of fragmentQueue.fragments) {
    if (!fragment) {
      continue;
    }

    const fragBegin = fragment[0];
    const fragEnd = fragBegin + fragment[1];

    const overlapOffset = newOffset >= fragBegin && newOffset <= fragEnd;
    const overlapEnd = newEnd >= fragBegin && newEnd <= fragEnd;

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
  let removedIndex = -1;
  for (let i = 0, l = fragmentQueue.fragments.length; i < l; ++i) {
    const fragment = fragmentQueue.fragments[i];
    if (!fragment) {
      continue;
    }

    const fragBegin = fragment[0];
    const fragEnd = fragBegin + fragment[1];

    if (fragBegin >= newOffset && fragBegin <= newEnd && fragEnd >= newOffset && fragEnd <= newEnd) {
      // remove this old fragment
      fragmentQueue.fragments[i] = null;
      fragmentQueue.receivedLength -= fragment[1];
      removedIndex = i;
    }
  }

  const newLength = newEnd - newOffset;

  // fragment offset - fragement length - buffer data offset - buffer
  const newFragment = [newOffset, newLength, newNextOffset, u8];

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
      return;
    } // Wrong len
    fragmentQueue.totalLength = fragmentEnd;
  }

  if (firstFragment) {
    intf.fragments.set(hash, fragmentQueue);
  }

  if (fragmentQueue.totalLength === fragmentQueue.receivedLength) {
    const u8asm = new Uint8Array(fragmentQueue.totalLength);
    for (const fragment of fragmentQueue.fragments) {
      if (!fragment) {
        continue;
      }

      const itemOffset = fragment[0];
      const itemLength = fragment[1];
      const itemNextOffset = fragment[2];
      const itemBuffer = fragment[3];
      u8asm.set(itemBuffer.subarray(itemNextOffset, itemNextOffset + itemLength), itemOffset);
    }

    dropFragmentQueue(intf, hash);
    ip4receive(intf, srcIP, destIP, protocolId, u8asm, 0);
    return;
  }
};

/**
 * Timer tick
 *
 * @param {Interface} intf Network interface
 */
exports.tick = (intf) => {
  const time = timeNow();

  for (const pair of intf.fragments) {
    const hash = pair[0];
    const fragmentQueue = pair[1];
    if (fragmentQueue.createdAt + FRAGMENT_QUEUE_MAX_AGE_MS <= time) {
      dropFragmentQueue(intf, hash);
    }
  }
};
