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

exports.STATE_CLOSED = 0;
exports.STATE_LISTEN = 1;
exports.STATE_SYN_SENT = 2;
exports.STATE_SYN_RECEIVED = 3;
exports.STATE_ESTABLISHED = 4;
exports.STATE_FIN_WAIT_1 = 5;
exports.STATE_FIN_WAIT_2 = 6;
exports.STATE_CLOSE_WAIT = 7;
exports.STATE_CLOSING = 8;
exports.STATE_LAST_ACK = 9;
exports.STATE_TIME_WAIT = 10;
