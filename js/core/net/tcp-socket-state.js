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

const states = [
  'STATE_CLOSED',
  'STATE_LISTEN',
  'STATE_SYN_SENT',
  'STATE_SYN_RECEIVED',
  'STATE_ESTABLISHED',
  'STATE_FIN_WAIT_1',
  'STATE_FIN_WAIT_2',
  'STATE_CLOSE_WAIT',
  'STATE_CLOSING',
  'STATE_LAST_ACK',
  'STATE_TIME_WAIT',
];

for (const num of Object.keys(states)) exports[states[num]] = num;
