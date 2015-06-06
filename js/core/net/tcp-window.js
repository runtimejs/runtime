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

function SEQ_INC(seq, value) { return (seq + (value >>> 0)) >>> 0; }
function SEQ_OFFSET(a, b) { return ((a - b) | 0); }
function SEQ_LT(a, b) { return ((a - b) | 0) <  0; }
function SEQ_LTE(a, b) { return ((a - b) | 0) <= 0; }
function SEQ_GT(a, b) { return ((a - b) | 0) >  0; }
function SEQ_GTE(a, b) { return ((a - b) | 0) >= 0; }

class TCPWindow {
  constructor() {
    this._begin = 0;
    this._end = 0;
    this._size = 0;
  }

  slideTo(seq) {
    if (SEQ_GT(seq, this._begin)) {
      this._begin = seq;
      this._end = SEQ_INC(this._begin, this._size);
    }
  }

  slideOffset(seqOffset) {
    this._begin = SEQ_INC(this._begin, seqOffset);
    this._end = SEQ_INC(this._end, seqOffset);
  }

  getSeqBegin() {
    return this._begin;
  }

  getSize() {
    return this._size;
  }

  resize(size) {
    this._size = size;
    this._end = SEQ_INC(this._begin, this._size);
  }

  isInWindow(seq) {
    return SEQ_GTE(seq, this._begin) && SEQ_LT(seq, this._end);
  }
}

module.exports = TCPWindow;
