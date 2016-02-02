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

const net = require('net');
const stream = require('stream');
const EventEmitter = require('events');
const url = require('url');

function pipeEvent(e, source, dest) {
  source.on(e, (...args) => dest.emit(e, ...args));
}

function headerParse(data, createdByServer) {
  var headers = {};
  var rawHeaders = [];
  var reqOrStatLine = {};
  data = String(data);
  const lines = data.split('\n'); // not \r\n, because some programs don't follow RFC spec
  for (var lineNum in lines) {
    lineNum = parseInt(lineNum);
    var line = lines[lineNum];
    if (lineNum === 0) {
      if (line.substr(line.length-1) === '\r') line = line.substr(0, line.length-1);
      // request/status line:
      var tmp = line.split(' ');
      var method; // from client
      var url; // from client
      var httpVersion; // shared
      var statusCode; // from server
      var statusMessage; // from server
      if (createdByServer) {
        // then parse the incoming request from the client
        method = tmp[0]; // GET or POST or PUT or DELETE, etc.
        url = tmp[1]; // / or /index.html or /whatever-you-want
        httpVersion = tmp[2].split('/')[1]; // HTTP/1.1 -> 1.1 or 1.0
      } else {
        // otherwise, parse the incoming response from the server
        httpVersion = tmp[0].split('/')[1]; // HTTP/1.1 -> 1.1 or 1.0
        statusCode = parseInt(tmp[1]);
        statusMessage = tmp[2];
      }
      if (method) reqOrStatLine.method = method;
      if (url) reqOrStatLine.url = url;
      if (httpVersion) {
        reqOrStatLine.httpVersion = httpVersion;
        tmp = httpVersion.split('.');
        reqOrStatLine.httpVersionMajor = parseInt(tmp[0]);
        reqOrStatLine.httpVersionMinor = parseInt(tmp[1]);
      }
      if (statusCode) reqOrStatLine.statusCode = statusCode;
      if (statusMessage) reqOrStatLine.statusMessage = statusMessage;
      if (lines.length === 1) {
        const sliced = lines.slice(lineNum+1);
        if (sliced.length === 0 || (sliced.length === 1 && sliced[0] === '')) return [headers, rawHeaders, reqOrStatLine]; // don't emit any data if the body is empty.
        this.push(new Buffer(sliced.join('\n')));
        return [headers, rawHeaders, reqOrStatLine, sliced];
      }
    } else {
      // headers:
      if (line === '\r' || line === '') {
        // end of headers
        const sliced = lines.slice(lineNum+1);
        if (sliced.length === 0 || (sliced.length === 1 && sliced[0] === '')) return [headers, rawHeaders, reqOrStatLine]; // don't emit any data if the body is empty.
        this.push(new Buffer(sliced.join('\n')));
        return [headers, rawHeaders, reqOrStatLine, sliced];
      }
      if (line.substr(line.length-1) === '\r') line = line.substr(0, line.length-1);
      var tmp = line.split(':');
      const header = tmp[0];
      var value = tmp[1];
      if (value.substr(0, 1) === ' ') value = value.substr(1);
      rawHeaders.push(header);
      rawHeaders.push(value);
      tmp = value.split(',');
      headers[header.toLowerCase()] = (tmp.length === 1) ? value : tmp.join(',');
    }
  }
}

class Agent {
  constructor(opts) {
    this._socketPool = [];
    this._requestPool = [];
  }
  destroy() {
    for (var socket of this._socketPool) socket.close();
  }
  get freeSockets() {
    return [];
  }
  getName(opts) {
    return `${opts.host}:${opts.port}:${opts.localAddress}`;
  }
  get maxFreeSockets() {
    return 256;
  }
  get maxSockets() {
    return Infinity;
  }
  get requests() {
    return this._requestPool;
  }
  get sockets() {
    return this._socketPool;
  }
}

class ClientRequest extends stream.Writable {
  constructor(opts, socket) {
    super();
    this._headerBuffer = opts.headers || {};
    if (!this._headerBuffer['Host']) this._headerBuffer['Host'] = opts.hostname || 'localhost';
    this._method = opts.method || 'GET';
    this._path = opts.path || '/';
    this._flushed = false;
    this._socket = socket;
    this._connected = false;
    this._socket.once('connect', () => {
      console.log('CONNECTION!');
      this._connected = true;
      var headersParsed = false;
      this._socket.on('data', (data) => {
        if (!headersParsed) {
          const headerObject = headerParse(data, false);
          this.emit('response', new IncomingMessage(socket, false, headerObject));
          headersParsed = true;
        }
      });
      this._socket.setNoDelay(this._noDelay);
    });
    this.emit('socket', this._socket);
  }
  _write(chunk, encoding, callback) {
    const cb = () => this._socket.write(chunk, encoding);
    if (!this._connected) {
      this._socket.once('connect', cb);
    } else {
      cb();
    }
    callback();
  }
  abort() {
    this.emit('abort');
  }
  flushHeaders() {
    if (!this._flushed) {
      var buf = '';
      buf += `${this._method.toUpperCase()} ${this._path} HTTP/1.1\r\n`;
      for (var headerName in this._headerBuffer) buf += `${headerName}: ${this._headerBuffer[headerName]}\r\n`;
      buf += '\r\n';
      this._headerBuffer = [];
      this._flushed = true;
      this.write(buf);
      console.log('written');
    }
  }
  end(data, encoding, callback) {
    if (!this._flushed) this.flushHeaders();
    super.end(data, encoding, callback);
  }
  write(chunk, encoding, callback) {
    if (!this._flushed) this.flushHeaders();
    super.write(chunk, encoding, callback);
  }
  setNoDelay(noDelay=true) {
    this._noDelay = noDelay;
  }
  setSocketKeepAlive() {}
  setTimeout() {}
}

class Server extends EventEmitter {
  constructor() {
    super();
    this._handle = new net.Server();
    pipeEvent('close', this._handle, this);
    pipeEvent('connection', this._handle, this);
    this._handle.on('connection', (socket) => {
      var headersParsed = false;
      socket.on('data', (data) => {
        if (!headersParsed) {
          const headerObject = headerParse(data, true);
          this.emit('request', new IncomingMessage(socket, true, headerObject), new ServerResponse(socket));
          headersParsed = true;
        }
      });
    });
    this.timeout = 0;
  }
  close(cb) {
    this._handle.close(cb);
  }
  listen(port, hostname, backlog, callback) {
    this._handle.listen(port, hostname, backlog, callback);
  }
}

class ServerResponse extends stream.Writable {
  constructor(socket) {
    super();
    this._handle = socket;
    this._resHeaders = {};
    this._implicit = true;
    this._finished = false;
    this._multiWrite = false;
    this._headersSent = false;
    this.sendDate = true;
    this.statusCode = 200;
    this.statusMessage = undefined;
  }
  addTrailers() {}
  getHeader(name) {
    return this._resHeaders[name];
  }
  get finished() {
    return this._finished;
  }
  end(chunk, encoding, callback) {
    super.end(chunk, encoding, callback);
    this._finished = true;
    this.emit('finish');
    this._handle.end();
  }
  get headersSent() {
    return this._headersSent;
  }
  removeHeader(name) {
    delete this._resHeaders[name];
  }
  setHeader(name, value) {
    this._implicit = false;
    this._resHeaders[name] = value;
  }
  setTimeout() {}
  _write(chunk, encoding, callback) {
    this._handle.write(chunk, encoding);
    callback();
  }
  write(chunk, encoding, callback) {
    if (this._implicit) {
      if (!this._multiWrite) {
        this._resHeaders['Content-Length'] = Buffer.byteLength(chunk);
      } else {
        this._resHeaders['Transfer-Encoding'] = 'chunked';
      }
      this._resHeaders['Date'] = (new Date()).toGMTString();
      this._resHeaders['Connection'] = 'close';
    }
    if (!this._multiWrite) this._multiWrite = true;
    if (!this._headersSent) this.writeHead(this.statusCode);
    super.write(chunk, encoding, callback);
  }
  writeContinue() {}
  writeHead(statusCode, statusMessage=this.statusMessage, headers) {
    if (typeof statusMessage !== 'string' || !(statusMessage instanceof String)) {
      headers = statusMessage;
      statusMessage = this.statusMessage;
    }
    if (!statusMessage) statusMessage = this.statusMessage || exports.STATUS_CODES[statusCode];
    headers = headers || this._resHeaders;
    var resData = '';
    resData += `HTTP/1.1 ${statusCode} ${statusMessage}\r\n`;
    for (var headerName in headers) resData += `${headerName}: ${headers[headerName]}\r\n`;
    resData += '\r\n';
    this._headersSent = true;
    this.write(resData);
  }
}

class IncomingMessage extends stream.Readable {
  constructor(socket, createdByServer, headerObject) {
    super();
    this._handle = socket;
    this._headers = headerObject[0];
    this._rawHeaders = headerObject[1];
    this._method = headerObject[2].method;
    this._httpVersion = headerObject[2].httpVersion;
    this._httpVersionMajor = headerObject[2].httpVersionMajor;
    this._httpVersionMinor = headerObject[2].httpVersionMinor;
    this._url = headerObject[2].url;
    this._statusCode = headerObject[2].statusCode;
    this._statusMessage = headerObject[2].statusMessage;
    if (headerObject[3]) this.push(headerObject[3]);
    this._handle.on('data', (data) => this.push(data));
    this._handle.on('end', () => this.push(null));
  }
  _read() {}
  get headers() {
    return this._headers;
  }
  get rawHeaders() {
    return this._rawHeaders;
  }
  get method() {
    return this._method;
  }
  get httpVersion() {
    return this._httpVersion;
  }
  get httpVersionMajor() {
    return this._httpVersionMajor;
  }
  get httpVersionMinor() {
    return this._httpVersionMinor;
  }
  get statusCode() {
    return this._statusCode;
  }
  get statusMessage() {
    return this._statusMessage;
  }
  get socket() {
    return this._handle;
  }
  get url() {
    return this._url;
  }
}

exports.METHODS = [
  'GET',
  'POST',
  'PUT',
  'DELETE',
  'CONTINUE',
  'UPGRADE',
  'OPTIONS',
  'HEAD',
  'TRACE',
  'CONNECT'
]

exports.STATUS_CODES = {
  200: 'OK',
  404: 'Not Found',
  500: 'Internal Server Error',
  400: 'Bad Request'
}

exports.globalAgent = new Agent();

exports.createServer = function(onreq) {
  const server = new Server();
  if (onreq) server.on('request', onreq);
  return server;
}

exports.get = function(opts, cb) {
  if (typeof opts === 'string') opts = url.parse(opts);
  opts.method = 'GET';
  var req = exports.request(opts, cb);
  req.end();
  return req;
}

exports.request = function(opts, cb) {
  if (typeof opts === 'string') opts = url.parse(opts);
  opts.protocol = opts.protocol || 'http:';
  opts.method = opts.method || 'GET';
  if (!opts.hostname && opts.host) {
    opts.hostname = opts.host;
    if (opts.port) opts.hostname += opts.port;
  }
  if (!opts.hostname && !opts.hosts) opts.hostname = 'localhost';
  opts.port = opts.port || 80;
  const socket = new net.Socket();
  const req = new ClientRequest(opts, socket);
  if (cb) req.on('response', cb);
  socket.connect(parseInt(opts.port), opts.hostname);
  return req;
}
