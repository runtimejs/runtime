'use strict';
//
// this entire file feels extremly hackish, but whatever
//

const EventEmitter = require('events');
const stream = require('stream');
const eshttp = require('eshttp');
const net = require('net');

class ClientRequest extends stream.Writable {
  constructor() {
    super();
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
    if (this._handle._parser) for (var key of Object.keys(headers)) this._handle._parser._addTrailer(key, headers[key]);
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
    if (headers) for (var key of Objects.keys(headers)) this._handle._headers.set(key, headers[key]);
  }
}

class IncomingMessage extends stream.Readable {
  constructor(server, reqOrRes) {
    super();
    this._handle = reqOrRes;
    this._ms = null;
    this._ontimeout = () => null;
    this._server = server;
  }
  _read(size) {
    // just like net, we can't force a read. do nothing.
  }
  get headers() {
    var headers = {};
    for (var header of this._handle._headers) headers[header[0]] = header[1];
    return headers;
  }
  get httpVersion() {
    return this._handle.httpVersion;
  }
  get method() {
    return (this._server) ? this._handle.method : undefined;
  }
  get rawHeaders() {
    var headers = [];
    for (var header of this._handle._headers) headers.push(header[0], header[1]);
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
  var server = new Server();
  if (cb) server.on('request', cb);
  return server;
}
