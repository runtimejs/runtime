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

const EventEmitter = require('events');
const Duplex = require('stream').Duplex;
const dns = require('dns');

function rmFromArrayByVal(array, val) {
  const i = array.indexOf(val);
  if (i !== -1) array.splice(i, 1);
}

class Server extends EventEmitter {
  constructor(runtimeServer) {
    super();
    this._handle = runtimeServer || new runtime.net.TCPServerSocket();
    this._connections = [];
    this._handle.onconnect = (runtimeSocket) => {
      const socket = new Socket(runtimeSocket);
      this.emit('connection', socket);
      socket.once('close', () => rmFromArrayByVal(this._connections, socket));
      this._connections.push(socket);
    }
    this._handle.onclose = () => this.emit('close');
    this._handle.onerror = (err) => {
      this.emit('error', err);
      this.close();
    }
    this._handle.onlisten = () => this.emit('listening');
  }
  address() {
    return {
      port: this._handle.localPort,
      family: 'IPv4',
      address: '127.0.0.1'
    }
  }
  close(cb) {
    this.once('close', cb);
    this._handle.close();
  }
  get connections() {
    return this._connections.length;
  }
  getConnections(cb) {
    if (cb) cb(null, this._connections.length);
  }
  listen(port, hostname, backlog, callback) {
    let options = {};
    if (typeof hostname === 'function') {
      callback = hostname;
      hostname = null;
    }
    if (typeof backlog === 'function') {
      callback = backlog;
      backlog = null;
    }
    if (typeof port === 'object') {
      options = port;
      port = options.port || null;
    }
    if (typeof port === 'function') {
      callback = port;
      port = null;
    }
    options.port = port;
    this.once('listening', function() {
      if (callback) callback();
    });
    this._handle.listen(options.port);
  }

  // ref and unref do nothing, since runtime isn't a process
  ref() {}
  unref() {}
}

class Socket extends Duplex {
  constructor(opts, runtimeSocket) {
    super();
    if (opts instanceof runtime.net.TCPSocket) {
      runtimeSocket = opts;
      opts = null;
    }
    this._handle = runtimeSocket;
    this._handle.ondata = (u8) => this.push(new Buffer(u8));
    this._handle.onopen = () => this.emit('connect');
    this._handle.onend = () => this.push(null);
    this._handle.onclose = () => this.emit('close', false);
    this.bufferSize = 0;
    this.bytesRead = 0
    this.bytesWritten = 0;
  }
  address() {
    return {
      port: null,
      family: null,
      address: null
    }
  }
  connect(port, host, cb) {
    let opts = {};
    if (typeof port === 'object') {
      opts = port;
      port = opts.port || null;
      host = opts.host || 'localhost';
    }
    if (typeof host === 'function') {
      cb = host;
      host = 'localhost';
    }
    if (!port || typeof port === 'function') {
      const err = new Error('Socket.connect: Must provide a port.');
      if (cb) cb(err);
      return;
    }
    host = host || 'localhost';
    this.once('connect', function() {
      if (cb) cb();
    });
    dns.lookup(host, (err, data) => {
      if (err) return this.emit('lookup', err, null, null);
      this.emit('lookup', null, data[0], data[1]);
      this._handle.open(data[0], port);
    });
  }
  destroy() {
    this._handle.close();
  }
  end(data, encoding) {
    if (data) {
      this.write(data, encoding);
    }
    this._handle.halfclose();
  }
  get localAddress() {
    return this._handle.localAddress;
  }
  get localPort() {
    return this._handle.localPort;
  }
  ref() {}
  get remoteAddress() {
    return this._handle.remoteAddress;
  }
  get remoteFamily() {
    return 'IPv4';
  }
  get remotePort() {
    return this._handle.remotePort;
  }
  setKeepAlive() {}
  setNoDelay() {}
  setTimeout() {}
  unref() {}
  _read(size) {
    // can't force a read. do nothing.
  }
  _write(chunk, encoding, callback) {
    if (!(chunk instanceof Buffer)) {
      chunk = new Buffer(chunk);
    }
    this._handle.send(new Uint8Array(chunk));
    callback(null);
  }
}

exports.Server = Server;
exports.Socket = Socket;

exports.createConnection = function(host, port, cb) {
  const socket = new Socket();
  socket.connect(host, port, cb);
  return socket;
}

exports.createServer = function(opts, cb) {
  if (typeof opts === 'function') {
    cb = opts;
    opts = {};
  }
  opts = opts || {};
  const server = new Server();
  server.on('connection', cb);
  return server;
}

exports.isIPv4 = function(ip) {
  var arr = ip.split('.');
  if (arr.length !== 4) return false;
  // check if it contains non-number characters or exceeds the maximum length:
  for (var i = 0, len = arr.length; i < len; i++) if (parseInt(arr[i]) === NaN || arr[i].length > 3) return false;
  return true;
}

exports.isIPv6 = function(ip) {
  if (ip.length > 45) return false;
  var arr = ip.split(':');
  if (arr.length !== 6) return false;
  // check if it contains only letters and numbers (or is empty):
  for (var i = 0, len = arr.length; i < len; i++) if (arr[i].search(/[a-zA-Z0-9]*/) === -1) return false;
  return true;
}

exports.isIP = function(ip) {
  if (exports.isIPv4(ip)) return 4;
  if (exports.isIPv6(ip)) return 6;
  return 0;
}

exports.connect = exports.createConnection;
