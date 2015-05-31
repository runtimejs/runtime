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
var TCPSocket = require('./tcp-socket');

class TCPServerSocket {
  constructor() {
    this.listeningSocket = new TCPSocket();
    this.onconnect = null;
    this.onerror = null;

    var that = this;
    this.listeningSocket._onconnect = function(socket) {
      socket.onopen = function() {
        if (that.onconnect) {
          that.onconnect(socket);
        }
      };
    };
    this.listeningSocket.onerror = function(err) {
      if (that.onerror) {
        that.onerror(err);
      }
    };
  }

  listen(port) {
    var that = this;
    this.listeningSocket._listen(port);
  }

  close() {
    this.listeningSocket.close();
  }
}

module.exports = TCPServerSocket;
