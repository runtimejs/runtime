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
// const tcpSocketState = require('./tcp-socket-state');
const connections = new Set();

function timeoutHandler() {
  for (const connSocket of connections) {
    connSocket._timerTick();
  }
  initTimeout();
}

function initTimeout() {
  setTimeout(timeoutHandler, 500);
}

initTimeout();

exports.addConnectionSocket = (connSocket) => connections.add(connSocket);
exports.removeConnectionSocket = (connSocket) => connections.delete(connSocket);
