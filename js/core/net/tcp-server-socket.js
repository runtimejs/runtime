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
const TCPSocket = require('./tcp-socket');

class TCPServerSocket {
  constructor() {
    this.listeningSocket = new TCPSocket();
    this.onconnect = null;
    this.onlisten = null;
    this.onerror = null;
    this._port = 0;

    this.listeningSocket._onconnect = (socket) => {
      socket.onopen = () => (this.onconnect) && this.onconnect(socket);
    };
    this.listeningSocket.onerror = err => (this.onerror) && this.onerror(err);
    this.listeningSocket.onclose = () => (this.onclose) && this.onclose();
  }
  get localPort() {
    return this._port;
  }
  listen(port) {
    this.listeningSocket._listen(port);
    this._port = this.listeningSocket._port;
    if (this.onlisten) {
      this.onlisten(this._port);
    }
  }
  close() {
    this.listeningSocket.close();
  }
}

module.exports = TCPServerSocket;
