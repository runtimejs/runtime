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
const assert = require('assert');
const typeutils = require('typeutils');
const dnsPacket = require('./dns-packet');
const isint = require('isint');
const runtime = require('../../core');
const { IP4Address, UDPSocket } = runtime.net;

class DNSClient {
  constructor(serverIP, serverPort) {
    assert(this instanceof DNSClient);
    if (serverIP) {
      assert(serverIP instanceof IP4Address);
    }
    if (serverPort) {
      assert(isint.uint16(serverPort));
    }

    this._socket = new UDPSocket();
    this._serverIP = serverIP || new IP4Address(8, 8, 8, 8);
    this._serverPort = serverPort || 53;
    this._requests = [];
    this._cache = {};

    this._socket.onmessage = (ip, port, u8) => {
      const data = dnsPacket.parseResponse(u8);
      if (!data) {
        return;
      }

      debug('DNS recv', ip, port, JSON.stringify(data));

      const requests = this._requests;
      const domain = data.hostname;
      for (let i = 0; i < requests.length; i++) {
        const req = requests[i];
        if (!req) {
          continue;
        }

        if (req.domain === domain) {
          req.cb(null, data);
          this._cache[domain] = data;
          requests[i] = null;
        }
      }
    };

    setInterval(() => {
      const requests = this._requests;

      for (let i = 0; i < requests.length; i++) {
        const req = requests[i];
        if (!req) {
          continue;
        }

        if (req.retry > 0) {
          this._sendQuery(req.domain, req.opts.query || 'A');
          --req.retry;
        } else {
          req.cb(new Error('E_FAILED'));
          requests[i] = null;
        }
      }

      this._requests = requests.filter(x => x !== null);
    }, 1000);
  }
  _sendQuery(domain, type) {
    const query = dnsPacket.getQuery(domain, type);
    this._socket.send(this._serverIP, this._serverPort, query);
  }
  resolve(domain, opts, cb) {
    assert(this instanceof DNSClient);
    assert(typeutils.isString(domain));
    assert(typeutils.isFunction(cb));

    this._sendQuery(domain, opts.query || 'A');
    this._requests.push({
      domain,
      retry: 3,
      opts,
      cb,
    });
  }
}

module.exports = DNSClient;
