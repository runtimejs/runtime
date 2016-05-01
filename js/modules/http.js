'use strict';
//
// this entire file feels extremly hackish, but whatever
//

const EventEmitter = require('events');
const stream = require('stream');
const eshttp = require('eshttp');
const net = require('net');
const url = require('url');
const dns = require('dns');

const or = (...objs) => {
  for (let obj of objs) if (obj !== undefined && obj !== null) return obj;
}

class ClientRequest extends stream.Writable {
  constructor() {
    super();
    this._body = '';
    this._aborted = false;
    this._method = '';
    this._path = '';
    this._headers = {};
    this._handle = null;
    this._interalListeners = [];
    this._resolved = false;
  }
  _emitInterals() {
    this._resolved = true;
    let listener = null;
    while (listener = this._interalListeners.shift()) listener();
  }
  _write(chunk, encoding, callback) {
    const cb = () => {
      this._body += chunk;
      callback();
    }
    if (this._resolved) {
      cb();
    } else {
      this._interalListeners.push(cb);
    }
  }
  end(data, encoding, callback) {
    const cb = () => {
      super.end(data, encoding, callback);
      this._handle.request(new eshttp.HttpRequest(this._method, this._path, this._headers), (err, response) => {
        if (this._aborted) return;
        if (err) return this.emit('error', err);
        this.emit('response', new IncomingMessage(false, response));
      });
      this._handle.close();
    }
    if (this._resolved) {
      cb();
    } else {
      this._interalListeners.push(cb);
    }
  }
  abort() {
    const cb = () => this._handle.close();
    if (this._resolved) {
      cb();
    } else {
      this._interalListeners.push(cb);
    }
  }
  flushHeaders() {
    // to be implemented
  }
  setNoDelay(noDelay) {
    // to be implemented
  }
  setSocketKeepAlive(enable, initialDelay) {
    // to be implemented
  }
  setTimeout(timeout, callback) {
    // to be implemented
  }
}

class Server extends net.Server {
  constructor() {
    super();
    this._handle2 = new eshttp.HttpServer();
    this.on('connection', (socket) => {
      socket.on('data', (data) => this._handle2._dataHandler(socket._handle, data));
      socket.on('end', () => this._handle2._endHandler(socket._handle));
      socket.on('close', () => this._handle2._closeHandler(socket._handle));
      socket.on('error', () => null);
      this._handle2._connectionHandler(socket._handle);
    });
    this._handle2._handle = this._handle;
    this._handle2.onrequest = (req) => this.emit('request', new IncomingMessage(true, req), new ServerResponse(req));
  }
}

class ServerResponse extends stream.Writable {
  constructor(request) {
    super();
    this._handle = new eshttp.HttpResponse(200, {}, '');
    this._reqHandle = request;
    this.finished = false;
    this.sendDate = true; // doesn't matter what it's set to, eshttp always appends the date header
    this._sent = false;
  }
  _write(chunk, encoding, cb) {
    this._handle._body += String(chunk);
    if (!this._sent) {
      this._sent = true;
      this.writeHead(this.statusCode, this.statusMessage);
    }
    cb(null);
  }
  end(data, encoding, cb) {
    super.end(data, encoding, cb);
    this._reqHandle.respondWith(this._handle);
    this.finished = true;
  }
  addTrailers(headers) {
    if (this._handle._parser) for (let key of Object.keys(headers)) this._handle._parser._addTrailer(key, headers[key]);
  }
  getHeader(name) {
    return this._handle._headers.get(name);
  }
  get headersSent() {
    return this._sent;
  }
  removeHeader(name) {
    this._handle._headers.delete(name);
  }
  setHeader(name, val) {
    this._handle._headers.set(name, val);
  }
  get statusCode() {
    return this._handle.statusCode;
  }
  get statusMessage() {
    return this._handle.statusMessage;
  }
  set statusCode(code) {
    this._handle._code = code;
  }
  set statusMessage(msg) {
    if (this._handle._parser) this._handle._parser._phrase = statusMessage || this.statusMessage;
  }
  writeHead(statusCode, statusMessage, headers) {
    this._handle._code = statusCode || this.statusCode;
    if (this._handle._parser) this._handle._parser._phrase = statusMessage || this.statusMessage;
    if (headers) for (let key of Objects.keys(headers)) this._handle._headers.set(key, headers[key]);
  }
}

class IncomingMessage extends stream.Readable {
  constructor(server, reqOrRes) {
    super();
    this._handle = reqOrRes;
    this._ms = null;
    this._ontimeout = () => null;
    this._server = server;
    if (!this._server) {
      this._handle.ondata = (data) => this.push(new Buffer(data));
      this._handle.onend = () => this.push(null);
    }
  }
  _read(size) {
    // just like net, we can't force a read. do nothing.
  }
  get headers() {
    const headers = {};
    for (let header of this._handle._headers) headers[header[0]] = header[1];
    return headers;
  }
  get httpVersion() {
    return this._handle.httpVersion;
  }
  get method() {
    return (this._server) ? this._handle.method : undefined;
  }
  get rawHeaders() {
    const headers = [];
    for (let header of this._handle._headers) headers.push(header[0], header[1]);
    return headers;
  }
  get rawTrailers() {
    return []; // for now
  }
  setTimeout(ms, cb) {
    this._ms = ms;
    this._ontimeout = cb;
  }
  get statusCode() {
    return (!this._server) ? this._handle.statusCode : undefined;
  }
  get statusMessage() {
    return (!this._server) ? this._handle.statusMessage : undefined;
  }
  get socket() {
    return null; // for now
  }
  get trailers() {
    return (!this._server) ? this._handle.trailers : undefined;
  }
  get url() {
    return (this._server) ? this._handle.path : undefined;
  }
}

exports.ClientRequest = ClientRequest;
exports.Server = Server;
exports.ServerResponse = ServerResponse;
exports.IncomingMessage = IncomingMessage;
exports.createServer = (cb) => {
  const server = new Server();
  if (cb) server.on('request', cb);
  return server;
}
exports.request = (opt, cb) => {
  if (typeof opt === 'string') opt = url.parse(opt);
  let protocol = or(opt.protocol, 'http:');
  if (protocol !== 'http:') throw new Error(`Protocol "${protcol}" not supported. Expected "http:"`);
  let ip = or(opt.hostname, opt.host, 'localhost');
  let port = or(opt.port, 80);
  let req = new ClientRequest();
  req._headers = or(opt.headers, {});
  req._method = or(opt.method, 'GET');
  req._path = or(opt.path, '/');
  let onresolved = () => {
    req._handle = new eshttp.HttpClient(ip, port);
    req._emitInterals();
  }
  if (net.isIP(ip)) {
    onresolved();
  } else {
    dns.lookup(opt.host, (err, address) => {
      if (err) return req.emit('error', err);
      ip = address;
      onresolved();
    });
  }
  if (cb) req.on('response', cb);
  return req;
}
