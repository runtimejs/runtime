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

const states = {
  PAUSED: 0,
  CORKED: 0,
  FLOWING: 1,
  UNCORKED: 1,
  ENDED: 2
}

class Readable extends EventEmitter {
  constructor() {
    super();
    this._readState = states.PAUSED;
    this._readBuffer = [];
    this._readBufferedLength = 0;
    this._pipes = [];
    this._readEncoding = null;
  }
  on(e, cb) {
    super.on(e, cb);
    if (this._readState === states.PAUSED && e === 'data') this._readState = states.FLOWING;
  }
  once(e, cb) {
    super.once(e, cb);
    if (this._readState === states.PAUSED && e === 'data') this._readState = states.FLOWING;
  }
  _read(size) {
    throw new Error('not implemented');
  }
  isPaused() {
    return this._readState === states.PAUSED;
  }
  pause() {
    this._readState = states.PAUSE;
    return this;
  }
  pipe(dest, opts) {
    opts = opts || {};
    opts.end = opts.end || true;
    const obj = {
      destination: dest,
      ondata: (data) => dest.write(data)
    }
    if (opts.end) obj.onend = () => dest.end();
    this._pipes.push(obj);
    this.on('data', obj.ondata);
    if (opts.end) this.on('end', obj.onend);
    dest.on('end', () => this.removeListener('data', obj.ondata));
    dest.emit('pipe', this);
  }
  read() {
    if (this._readBufferedLength === 0) return null;
    let concated = Buffer.concat(this._readBuffer, this._readBufferedLength);
    if (this._readEncoding) concated = concated.toString(this._readEncoding);
    this.emit('data', concated);
    console.log('mmmmmhhhmmm');
    this._readBuffer = [];
    this._readBufferedLength = 0;
    return concated;
  }
  resume() {
    this._readState = states.FLOWING;
    return this;
  }
  setEncoding(enc) {
    this._readEncoding = enc;
    return this;
  }
  unpipe(dest) {
    if (dest) {
      for (var i = 0, len = this._pipes.length; i < len; i++) {
        if (this._pipes[i].destination === dest) {
          this.removeListener('data', this._pipes[i].ondata);
          if (this._pipes[i].onend) this.removeListener('end', this._pipes[i].onend);
          this._pipes[i].destination.emit('unpipe', this);
          break;
        }
      }
    } else {
      for (var i = 0, len = this._pipes.length; i < len; i++) {
        this.removeListener('data', this._pipes[i].ondata);
        if (this._pipes[i].onend) this.removeListener('end', this._pipes[i].onend);
        this._pipes[i].destination.emit('unpipe', this);
      }
    }
  }
  unshift() {}
  wrap() {}
  push(chunk, encoding) {
    console.log('lkjdsaflkjdkljsa');
    encoding = encoding || this._readEncoding;
    if (!chunk) {
      this._readState = states.ENDED;
      this.emit('end');
      return false;
    }
    if (typeof chunk === 'string') chunk = new Buffer(chunk, encoding);
    this._readBuffer.push(chunk);
    if (this._readState === states.FLOWING) {
      this.read(); // flushes internal buffer and emits 'data' event.
      return true;
    } else {
      return false;
    }
  }
}

class Writable extends EventEmitter {
  constructor() {
    super();
    this._writeState = states.UNCORKED;
    this._writeBuffer = [];
    this._writeBufferedLength = 0;
    this._writeEncoding = null;
  }
  _write(chunk, encoding, callback) {
    throw new Error('not implemented');
  }
  _writev(chunks, callback) {
    callback(null);
  }
  cork() {
    this._writeState = states.CORKED;
  }
  setDefaultEncoding(encoding) {
    this._writeEncoding = encoding;
  }
  end(data, encoding, callback) {
    if (typeof data === 'function') {
      callback = data;
      data = null;
    }
    if (typeof encoding === 'function') {
      callback = encoding;
      encoding = null;
    }
    if (data) {
      this.write(data, encoding || this._writeEncoding);
    }
    if (callback) {
      this.on('finish', callback);
    }
    this._writeState = states.ENDED;
  }
  uncork() {
    this._flushWrite();
    this._writeState = states.UNCORKED;
  }
  _flushWrite() {
    this._writev(this._writeBuffer, (err) => {
      if (err) throw err;
      const restore = (chunk, encoding) => {
        this._writeBuffer.push({
          chunk: chunk,
          encoding: encoding
        });
        this._writeBufferedLength += chunk.length;
        if (callback) callback();
        return false;
      }
      const tmp = () => {
        if (!this._writeBuffer[0]) return this.emit('drain');
        const buf = this._writeBuffer.unshift();
        this._write(buf.chunk, buf.encoding, (err) => {
          if (err) restore();
          this._writeBufferedLength -= buf.chunk.length;
          tmp();
        });
      }
    });
  }
  write(chunk, encoding, callback) {
    if (this._writeState === states.ENDED) throw new Error('write after end');
    if (typeof encoding === 'function') {
      callback = encoding;
      encoding = null;
    }
    encoding = encoding || this._writeEncoding;
    if (typeof chunk === 'string') chunk = new Buffer(chunk, encoding);
    const storeInternally = () => {
      this._writeBuffer.push({
        chunk: chunk,
        encoding: encoding
      });
      this._writeBufferedLength += chunk.length;
      if (callback) callback();
      return false;
    }
    if (this._writeState.CORKED) {
      return storeInternally();
    } else {
      this._flushWrite();
      this._write(chunk, encoding, (err) => {
        if (err) {
          storeInternally();
          throw err;
        }
        if (callback) callback();
      });
      return true;
    }
  }
}

// copy-paste from the above classes into Duplex (no multiple inheritance):
class Duplex extends EventEmitter {
  constructor() {
    super();
    this._readState = states.PAUSED;
    this._readBuffer = [];
    this._readBufferedLength = 0;
    this._pipes = [];
    this._readEncoding = null;
    this._writeState = states.UNCORKED;
    this._writeBuffer = [];
    this._writeBufferedLength = 0;
    this._writeEncoding = null;
  }
  on(e, cb) {
    super.on(e, cb);
    if (this._readState === states.PAUSED && e === 'data') this._readState = states.FLOWING;
  }
  once(e, cb) {
    super.once(e, cb);
    if (this._readState === states.PAUSED && e === 'data') this._readState = states.FLOWING;
  }
  _read(size) {
    throw new Error('not implemented');
  }
  isPaused() {
    return this._readState === states.PAUSED;
  }
  pause() {
    this._readState = states.PAUSE;
    return this;
  }
  pipe(dest, opts) {
    opts = opts || {};
    opts.end = opts.end || true;
    const obj = {
      destination: dest,
      ondata: (data) => dest.write(data)
    }
    if (opts.end) obj.onend = () => dest.end();
    this._pipes.push(obj);
    this.on('data', obj.ondata);
    if (opts.end) this.on('end', obj.onend);
    dest.on('end', () => this.removeListener('data', obj.ondata));
    dest.emit('pipe', this);
  }
  read() {
    if (this._readBufferedLength === 0) return null;
    let concated = Buffer.concat(this._readBuffer, this._readBufferedLength);
    if (this._readEncoding) concated = concated.toString(this._readEncoding);
    this.emit('data', concated);
    this._readBuffer = [];
    this._readBufferedLength = 0;
    return concated;
  }
  resume() {
    this._readState = states.FLOWING;
    this.read(); // flush internal buffer
    return this;
  }
  setEncoding(enc) {
    this._readEncoding = enc;
    return this;
  }
  unpipe(dest) {
    if (dest) {
      for (var i = 0, len = this._pipes.length; i < len; i++) {
        if (this._pipes[i].destination === dest) {
          this.removeListener('data', this._pipes[i].ondata);
          if (this._pipes[i].onend) this.removeListener('end', this._pipes[i].onend);
          this._pipes[i].destination.emit('unpipe', this);
          break;
        }
      }
    } else {
      for (var i = 0, len = this._pipes.length; i < len; i++) {
        this.removeListener('data', this._pipes[i].ondata);
        if (this._pipes[i].onend) this.removeListener('end', this._pipes[i].onend);
        this._pipes[i].destination.emit('unpipe', this);
      }
    }
  }
  unshift() {}
  wrap() {}
  push(chunk, encoding) {
    encoding = encoding || this._readEncoding;
    if (!chunk) {
      this._readState = states.ENDED;
      this.emit('end');
      return false;
    }
    if (typeof chunk === 'string') chunk = new Buffer(chunk, encoding);
    this._readBuffer.push(chunk);
    this._readBufferedLength += chunk.length;
    if (this._readState === states.FLOWING) {
      this.read(); // flushes internal buffer and emits 'data' event.
      return true;
    } else {
      return false;
    }
  }
  _write(chunk, encoding, callback) {
    throw new Error('not implemented');
  }
  _writev(chunks, callback) {
    callback(null);
  }
  cork() {
    this._writeState = states.CORKED;
  }
  setDefaultEncoding(encoding) {
    this._writeEncoding = encoding;
  }
  end(data, encoding, callback) {
    if (typeof data === 'function') {
      callback = data;
      data = null;
    }
    if (typeof encoding === 'function') {
      callback = encoding;
      encoding = null;
    }
    if (data) {
      this.write(data, encoding || this._writeEncoding);
    }
    if (callback) {
      this.on('finish', callback);
    }
    this._writeState = states.ENDED;
  }
  uncork() {
    this._flushWrite();
    this._writeState = states.UNCORKED;
  }
  _flushWrite() {
    this._writev(this._writeBuffer, (err) => {
      if (err) throw err;
      const restore = (chunk, encoding) => {
        this._writeBuffer.push({
          chunk: chunk,
          encoding: encoding
        });
        this._writeBufferedLength += chunk.length;
        if (callback) callback();
        return false;
      }
      const tmp = () => {
        if (!this._writeBuffer[0]) return this.emit('drain');
        const buf = this._writeBuffer.unshift();
        this._write(buf.chunk, buf.encoding, (err) => {
          if (err) restore();
          this._writeBufferedLength -= buf.chunk.length;
          tmp();
        });
      }
    });
  }
  write(chunk, encoding, callback) {
    if (this._writeState === states.ENDED) throw new Error('write after end');
    if (typeof encoding === 'function') {
      callback = encoding;
      encoding = null;
    }
    encoding = encoding || this._writeEncoding;
    if (typeof chunk === 'string') chunk = new Buffer(chunk, encoding);
    const storeInternally = () => {
      this._writeBuffer.push({
        chunk: chunk,
        encoding: encoding
      });
      this._writeBufferedLength += chunk.length;
      if (callback) callback();
      return false;
    }
    if (this._writeState.CORKED) {
      return storeInternally();
    } else {
      this._flushWrite();
      this._write(chunk, encoding, (err) => {
        if (err) {
          storeInternally();
          throw err;
        }
        if (callback) callback();
      });
      return true;
    }
  }
}

exports.Readable = Readable;
exports.Writable = Writable;
exports.Duplex = Duplex;
