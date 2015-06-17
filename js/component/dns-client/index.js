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
var assert = require('assert');
var typeutils = require('typeutils');
var dnsPacket = require('./dns-packet');
var IP4Address = runtime.net.IP4Address;
var UDPSocket = runtime.net.UDPSocket;

function DNSClient(serverIP, serverPort) {
  assert(this instanceof DNSClient);
  if (serverIP) {
    assert(serverIP instanceof IP4Address);
  }

  if (serverPort) {
    assert(isint.uint16(serverPort));
  }

  var self = this;
  self._socket = new UDPSocket();
  self._serverIP = serverIP || new IP4Address(8, 8, 8, 8);
  self._serverPort = serverPort || 53;
  self._requests = [];
  self._cache = {};

  self._socket.onmessage = function(ip, port, u8) {
    var data = dnsPacket.parseResponse(u8);
    if (!data) {
      return;
    }

    debug('DNS recv', ip, port, JSON.stringify(data));

    var requests = self._requests;
    var domain = data.hostname;
    for (var i = 0; i < requests.length; ++i) {
      var req = requests[i];
      if (!req) {
        continue;
      }

      if (req.domain === domain) {
        req.cb(null, data);
        self._cache[domain] = data;
        requests[i] = null;
      }
    }
  };

  setInterval(function() {
    var requests = self._requests;

    for (var i = 0; i < requests.length; ++i) {
      var req = requests[i];
      if (!req) {
        continue;
      }

      if (req.retry > 0) {
        self._sendQuery(req.domain);
        --req.retry;
      } else {
        req.cb(new Error('E_FAILED'));
        requests[i] = null;
      }
    }

    self._requests = requests
      .filter(function(x) { return x !== null; });
  }, 1000);
}

DNSClient.prototype._sendQuery = function(domain) {
  var query = dnsPacket.getQuery(domain);
  this._socket.send(this._serverIP, this._serverPort, query);
};

DNSClient.prototype.resolve = function(domain, opts, cb) {
  assert(this instanceof DNSClient);
  assert(typeutils.isString(domain));
  assert(typeutils.isFunction(cb));
  
  // if domain contains http:// or ftp:// or https:// (etc...), remove it.
  if (domain.indexOf("://") !== -1) {
    domain = domain.match(/[a-z]\:\/\/([a-zA-Z\-\.1-9]+)\/[a-zA-Z\-\.1-9\_\/]+/)[1];
  }

  this._sendQuery(domain);
  this._requests.push({
    domain: domain,
    retry: 3,
    opts: opts,
    cb: cb
  });
};

module.exports = DNSClient;
