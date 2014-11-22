// Copyright 2014 Runtime.JS project authors
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

var resources = require('resources.js')();
var udp = require('net/udp.js');
var tcp = require('net/tcp.js');
var netUtils = require('net/utils.js');
var intfc = require('interface.js');
var tcpSocket = require('net/tcpsocket.js');
var tcpConn = require('net/tcpconn.js');

"use strict";

var getInterfaceByName = null;
var emptyFunction = function() {};

function SocketTable() {
  this._table = new Map();
}

SocketTable.prototype._key = function(remotePort, remoteIP) {
  return remotePort + '-' + remoteIP;
};

SocketTable.prototype.get = function(remotePort, remoteIP) {
  if (!(this instanceof SocketTable)) throw new Error('instanceof check failed');
  var key = this._key(remotePort, remoteIP);
  var socket = this._table.get(key);
  if ('undefined' === typeof socket) {
    return null;
  }

  return socket;
};

SocketTable.prototype.set = function(remotePort, remoteIP, socket) {
  if (!(this instanceof SocketTable)) throw new Error('instanceof check failed');
  var key = this._key(remotePort, remoteIP);
  this._table.set(key, socket);
};

/**
 * TCP sockets
 */
var tcpSockets = (function() {
  var nextRandomPort = 49152;
  var bindTable = new Map();
  var sockets = new Map();

  var tcpListenersSocketPool = intfc.createHandlePool({
    /**
     * Bind socket to port
     *
     * @param {number} port Port number
     */
    listen: function(port) {
      var socket = sockets.get(this);
      if (!netUtils.isPortValid(port)) {
        throw new Error('INVALID_PORT');
      }

      socket.listen(port);
      return Promise.resolve(this);
    }
  });

  function recvPacket(intf, ip4Header, tcpHeader, buf, len, dataOffset) {
    var port = tcpHeader.destPort;

    var listeningSocket = tcpSocket.getListeningSocket(port);
    if (!listeningSocket) {
      return;
    }
    listeningSocket.recv(intf, ip4Header, tcpHeader, buf, len, dataOffset);
  }

  var api = {
    /**
     * Create new TCP socket
     *
     * @param {function} onMessage Message received callback
     * @param {function} onError Socket error callback
     */
    createSocket: function(onConnection, onError) {
      var socketHandle = tcpListenersSocketPool.createHandle();
      var connPipe = isolate.createPipe();
      sockets.set(socketHandle, new tcpSocket.TCPServerSocket(onConnection, connPipe));
      return Promise.resolve({ socket: socketHandle, pipe: connPipe });
    },
  };

  intfc.registerInterface('tcpSocket', api);

  return {
    recv: recvPacket,
    api: api
  };
})();

/**
 * UDP datagram sockets
 */
var udpSockets = (function() {
  var nextRandomPort = 49152;
  var bindTable = [];

  function UDPSocket(onMessage, onError) {
    this.onMessage = onMessage || emptyFunction;
    this.onError = onError || emptyFunction;
    this.port = 0;
  }

  UDPSocket.prototype.bind = function(port) {
    if (!(this instanceof UDPSocket)) {
      throw new Error('instanceof check failed');
    }

    if (!port) {
      // TODO: ensure port is free to use
      port = nextRandomPort++;
    }

    bindTable[port] = this;
    this.port = port;
  };

  var sockets = new Map();
  var udpSocketPool = intfc.createHandlePool({
    /**
     * Bind socket to port
     *
     * @param {number} port Port number
     */
    bind: function(port) {
      var socket = sockets.get(this);
      if (!netUtils.isPortValid(port)) {
        throw new Error('INVALID_PORT');
      }

      socket.bind(port);
      return Promise.resolve(socket);
    },
    /**
     * Send datagram
     *
     * @param {string} ipAddress Receiver IP address
     * @param {number} port Receiver port number
     * @param {ArrayBuffer} buffer Data buffer
     * @param {number} offset [optional] Buffer offset or 0
     * @param {number} length [optional] Buffer length or entire buffer
     */
    send: function(ipAddress, port, buffer, offset, length) {
      var socket = sockets.get(this);
      if (!netUtils.isPortValid(port)) {
        throw new Error('INVALID_PORT');
      }

      var ip = netUtils.parseIpAddressString(ipAddress);
      if (!ip) {
        throw new Error('INVALID_ADDRESS');
      }

      if (!(buffer instanceof ArrayBuffer)) {
        throw new Error('INVALID_BUFFER');
      }

      if ('undefined' === typeof offset) {
        offset = 0;
      }

      if ('undefined' === typeof length) {
        length = buffer.byteLength;
      }

      offset = offset >>> 0;
      length = length >>> 0;

      if (!socket.port) {
        socket.bind(0);
      }

      // TODO: buffer offset/length
      // TODO: use routing table, currently it always uses the first interface
      var intf = getInterfaceByName('eth0');
      var packet = intf.createUDPPacket(socket.port, port, buffer);
      intf.sendIP4('UDP', ip, packet);
      return Promise.resolve();
    }
  });

  /**
   * UDP socket APIs exported to user applications. Return values are
   * automatically wrapped into promises on the user side. To use this
   * API from kernel code it's recommended to wrap return values into
   * promises manually (using Promise.resolve() for example)
   */
  var api = {
    /**
     * Create new UDP socket
     *
     * @param {function} onMessage Message received callback
     * @param {function} onError Socket error callback
     */
    createSocket: function(onMessage, onError) {
      var socketHandle = udpSocketPool.createHandle();
      sockets.set(socketHandle, new UDPSocket(onMessage, onError));
      return Promise.resolve(socketHandle);
    }
  };

  function recvPacket(ip4Header, udpHeader, buf, len, dataOffset) {
    var port = udpHeader.destPort;
    if ('undefined' === typeof bindTable[port]) {
      return;
    }

    var socket = bindTable[port];
    var dataLength = udpHeader.dataLength - udp.headerLength;

    socket.onMessage({
      buf: buf.slice(dataOffset, dataOffset + dataLength), // TODO: optimize out this copy
      port: udpHeader.srcPort,
      address: ip4Header.srcIP.join('.'),
      size: dataLength,
    });
  }

  intfc.registerInterface('udpSocket', api);

  return {
    recv: recvPacket,
    api: api,
  };
})();

module.exports = {
  udpSocketApi: udpSockets.api,
  tcpSocketApi: tcpSockets.api,
  recvUDP4: udpSockets.recv,
  recvTCP4: tcpSockets.recv,
  setup: function(opts) {
    getInterfaceByName = opts.getInterfaceByName;
  },
};
