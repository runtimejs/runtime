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
var assertError = require('assert-error');
var typeutils = require('typeutils');
var IP4Address = require('./ip4-address');
var portUtils = require('./port-utils');
var PortPool = require('./port-pool');
var tcpTransmit = require('./tcp-transmit');
var route = require('./route');
var tcpHeader = require('./tcp-header');
var netError = require('./net-error');
var tcpTimer = require('./tcp-timer');
var tcpSocketState = require('./tcp-socket-state');

var ports = new PortPool();

var STATE_CLOSED = tcpSocketState.STATE_CLOSED;
var STATE_LISTEN = tcpSocketState.STATE_LISTEN;
var STATE_SYN_SENT = tcpSocketState.STATE_SYN_SENT;
var STATE_SYN_RECEIVED = tcpSocketState.STATE_SYN_RECEIVED;
var STATE_ESTABLISHED = tcpSocketState.STATE_ESTABLISHED;
var STATE_FIN_WAIT_1 = tcpSocketState.STATE_FIN_WAIT_1;
var STATE_FIN_WAIT_2 = tcpSocketState.STATE_FIN_WAIT_2;
var STATE_CLOSE_WAIT = tcpSocketState.STATE_CLOSE_WAIT;
var STATE_CLOSING = tcpSocketState.STATE_CLOSING;
var STATE_LAST_ACK = tcpSocketState.STATE_LAST_ACK;
var STATE_TIME_WAIT = tcpSocketState.STATE_TIME_WAIT;

function SEQ_INC(seq, value) { return (seq + (value >>> 0)) >>> 0; }
function SEQ_DIFF(a, b) { return Math.abs((a - b) | 0); }
function SEQ_OFFSET(a, b) { return ((a - b) | 0); }
function SEQ_LT(a, b) { return ((a - b) | 0) <  0; }
function SEQ_LTE(a, b) { return ((a - b) | 0) <= 0; }
function SEQ_GT(a, b) { return ((a - b) | 0) >  0; }
function SEQ_GTE(a, b) { return ((a - b) | 0) >= 0; }

var MSL_TIME = 15000;
var bufferedLimitHint = 64 * 1024; /* 64 KiB */

function sortFunction(a, b) {
  return a[0] - b[0];
}

var pow32 = Math.pow(2, 32);
function connHash(ip, port) {
  return pow32 * port + (((ip.a << 24) | (ip.b << 16) | (ip.c << 8) | ip.d) >>> 0);
}

class TCPSocket {
  constructor() {
    this._intf = null;
    this._port = 0;
    this._viaIP = null;
    this._destPort = 0;
    this._destIP = null;
    this._state = STATE_CLOSED;

    this._timeWaitTime = 0;

    // Transmit window for data transfer
    // Initial sequence number defined by sender (this machine) and window
    // size by receiver (other machine)
    this._transmitWindowEdge = 19999;
    this._transmitWindowSize = 0;
    this._transmitPosition = 19999;

    // Receive window for incoming data
    // Initial sequence number defined by sender (other machine) and window
    // size by receiver (this machine)
    this._receiveWindowEdge = 0;
    this._receiveWindowSize = 8192;

    this._queueTx = [];
    this._transmitQueue = [];
    this._receiveQueue = [];
    this._connections = null;

    // Events
    this.onopen = null;
    this.onend = null;
    this.ondata = null;
    this.onclose = null;
    this._onconnect = null;

    this._bufferedAmount = 0;
  }

  get bufferedAmount() { return this._bufferedAmount; }
  get port() { return this._port; }

  get readyState() {
    switch (this._state) {
    case STATE_CLOSED:
    case STATE_TIME_WAIT:
      return 'closed';
    case STATE_LISTEN:
    case STATE_ESTABLISHED:
      return 'open';
    case STATE_SYN_SENT:
    case STATE_SYN_RECEIVED:
      return 'connecting';
    case STATE_FIN_WAIT_1:
    case STATE_FIN_WAIT_2:
    case STATE_CLOSE_WAIT:
    case STATE_CLOSING:
    case STATE_LAST_ACK:
      return 'closing';
    }
  }

  open(ip, port) {
    if (typeutils.isString(ip)) {
      ip = IP4Address.parse(ip);
    }

    assertError(ip instanceof IP4Address, netError.E_IPADDRESS_EXPECTED);
    assertError(portUtils.isPort(port), netError.E_INVALID_PORT);

    this._destPort = port;
    this._destIP = ip;
    this._transmitWindowSlideInc(); // SYN counts as 1 byte
    this._state = STATE_SYN_SENT;
    this._sendSYN(false);
    tcpTimer.addConnectionSocket(this);
  }

  suspend() {
  }

  resume() {
  }

  _listen(port) {
    assertError(portUtils.isPort(port), netError.E_INVALID_PORT);
    if (!ports.alloc(port, this)) {
      throw netError.E_ADDRESS_IN_USE;
    }
    this._port = port;
    this._state = STATE_LISTEN;
    this._connections = new Map();
  }

  _destroy() {
    tcpTimer.removeConnectionSocket(this);
  }

  _transmit(seq, ack, flags, window, u8) {
    tcpTransmit(this._intf, this._destIP, this._viaIP,
                this._port, this._destPort,
                seq, ack, flags, window, u8);
  }

  _configure() {
    var intf = this._intf || null;
    var viaIP;

    if (this._destIP.isBroadcast()) {
      return false;
    }

    var routingEntry = route.lookup(this._destIP, intf);
    if (!routingEntry) {
      return false;
    }

    viaIP = routingEntry.gateway;
    if (!intf) {
      intf = routingEntry.intf;
    }

    if (!this._port) {
      this._port = ports.getEphemeral(this);
      if (!this._port) {
        return false;
      }
    }

    this._intf = intf;
    this._viaIP = viaIP;
    return true;
  }

  _sendSYN(isAck) {
    var flags = tcpHeader.FLAG_SYN;
    if (isAck) {
      flags |= tcpHeader.FLAG_ACK;
    }

    this._transmitQueue.push([0, Date.now(), this._getTransmitPosition(), 1, null, flags]);
    this._incTransmitPosition();

    if (!this._configure()) {
      return;
    }

    this._sendTransmitQueue(false);
  }

  _incTransmitPosition() {
    this._transmitPosition = SEQ_INC(this._transmitPosition, 1);
  }

  _allocTransmitPosition(length) {
    var end = SEQ_INC(this._transmitWindowEdge, this._transmitWindowSize);
    var spaceLeft = SEQ_OFFSET(end, this._transmitPosition);
    var spaceReserved = Math.min(spaceLeft, length, 536); /* TODO: move MSS (max segment size, data size) somewhere */
    this._transmitPosition = SEQ_INC(this._transmitPosition, spaceReserved);
    return spaceReserved;
  }

  _getTransmitPosition() {
    return this._transmitPosition;
  }

  _receiveWindowSlideTo(seq) {
    if (SEQ_GT(seq, this._receiveWindowEdge)) {
      this._receiveWindowEdge = seq;
    }
  }

  _receiveWindowSlideInc() {
    this._receiveWindowEdge = SEQ_INC(this._receiveWindowEdge, 1);
  }

  _transmitWindowSlideTo(seq) {
    if (SEQ_GT(seq, this._transmitWindowEdge)) {
      this._transmitWindowEdge = seq;
    }
  }

  _transmitWindowSlideInc() {
    this._transmitWindowEdge = SEQ_INC(this._transmitWindowEdge, 1);
  }

  _receiveWindowIsWithin(seq) {
    return SEQ_GTE(seq, this._receiveWindowEdge)
      && SEQ_LT(seq, SEQ_INC(this._receiveWindowEdge, this._receiveWindowSize));
  }

  _fillTransmitQueue() {
    var remove = 0;

    for (var i = 0, l = this._queueTx.length; i < l; ++i) {
      var buf = this._queueTx[i];
      var position = this._getTransmitPosition();

      if (buf) {
        var length = buf.length;
        var reserved = this._allocTransmitPosition(length);
        debug('send at ', position, 'len', reserved);
        if (0 === reserved) {
          break;
        }

        if (length === reserved) {
          this._transmitQueue.push([0, Date.now(), position, reserved, buf, tcpHeader.FLAG_ACK | tcpHeader.FLAG_PSH]);
          this._bufferedAmount -= reserved;
          ++remove;
        } else {
          this._transmitQueue.push([0, Date.now(), position, reserved, buf.subarray(0, reserved), tcpHeader.FLAG_ACK | tcpHeader.FLAG_PSH]);
          this._queueTx[i] = buf.subarray(reserved);
          this._bufferedAmount -= reserved;
          break;
        }

        if (0 === this._bufferedAmount && this.ondrain) {
          this.ondrain();
        }
      } else {
        debug('fill pos', position, 'fin');
        this._incTransmitPosition();
        this._transmitQueue.push([0, Date.now(), position, 1, null, tcpHeader.FLAG_ACK | tcpHeader.FLAG_FIN]);
        ++remove;
      }

    }

    while (remove --> 0) {
      this._queueTx.shift();
    }

    this._sendTransmitQueue(false);
  }

  _timerTick() {
    switch (this._state) {
      case STATE_TIME_WAIT:
        if (Date.now() > this._timeWaitTime + 2 * MSL_TIME) {
          this._state = STATE_CLOSED;
          this._destroy();
        }
        break;
      case STATE_SYN_SENT:
      case STATE_SYN_RECEIVED:
        if (!this._configure()) {
          return;
        }
        /* fall through */
      case STATE_ESTABLISHED:
      case STATE_FIN_WAIT_1:
        this._sendTransmitQueue(false);
        break;
    }
  }

  _sendTransmitQueue(ackRequired) {
    var now = Date.now();
    var sent = false;
    for (var i = 0, l = this._transmitQueue.length; i < l; ++i) {
      var item = this._transmitQueue[i];
      var retransmits = item[0];
      var timeAdded = item[1];
      var seq = item[2];
      var u8 = item[4];
      var flags = item[5];
      var interval = retransmits * 2000; /* 2 seconds each time in ms */

      if (retransmits === 0 || now > timeAdded + interval) {
        this._transmit(seq, this._receiveWindowEdge, flags, this._receiveWindowSize, u8);
        sent = true;
        ++item[0];
      }
    }

    if (!sent && ackRequired) {
      this._transmit(this._getTransmitPosition(), this._receiveWindowEdge,
                  tcpHeader.FLAG_ACK, this._receiveWindowSize, null);
    }
  }

  _cleanupTransmitQueue(ackNumber) {
    var deleteCount = 0;

    for (var i = 0, l = this._transmitQueue.length; i < l; ++i) {
      var item = this._transmitQueue[i];
      var seq = item[2];
      var len = item[3];
      var end = SEQ_INC(seq, len);
      if (SEQ_GTE(ackNumber, end)) {
        ++deleteCount;
      } else {
        break;
      }
    }

    while (deleteCount --> 0) {
      this._transmitQueue.shift();
    }
  }

  send(u8) {
    if (!(u8 instanceof Uint8Array)) {
      throw new Error('argument 0 is not a Uint8Array');
    }
    if (this._state !== STATE_ESTABLISHED && this._state !== STATE_CLOSE_WAIT) {
      throw new Error('socket is not connected');
    }
    this._bufferedAmount += u8.length;
    this._queueTx.push(u8);
    this._fillTransmitQueue();
    return this._bufferedAmount < bufferedLimitHint;
  }

  halfclose() {
    if (this._state === STATE_ESTABLISHED) {
      this._state = STATE_FIN_WAIT_1;
    } else if (this._state === STATE_CLOSE_WAIT) {
      this._state = STATE_LAST_ACK;
    } else {
      throw new Error('socket cannot be closed');
    }

    this._queueTx.push(null);
    this._fillTransmitQueue();
  }

  close() {
    if (this._state === STATE_ESTABLISHED) {
      this._state = STATE_FIN_WAIT_1;
    } else if (this._state === STATE_CLOSE_WAIT) {
      this._state = STATE_LAST_ACK;
    } else {
      throw new Error('socket cannot be closed');
    }

    this._queueTx.push(null);
    this._fillTransmitQueue();
  }

  _insertReceiveQueue(seq, len, u8) {
    this._receiveQueue.push([seq, len, u8]);
    this._receiveQueue.sort(sortFunction);

    var lastAck = this._receiveWindowEdge;
    var remove = 0;
    for (var i = 0, l = this._receiveQueue.length; i < l; ++i) {
      var item = this._receiveQueue[i];
      var seqNumber = item[0];
      var length = item[1];

      if (SEQ_LTE(seqNumber, lastAck)) {
        var diff = SEQ_DIFF(seqNumber, lastAck);
        if (lastAck === seqNumber) {
          lastAck = SEQ_INC(lastAck, length);
          ++remove;
        } else {
          if (diff < length) {
            item[0] = SEQ_INC(seqNumber, diff);
            item[1] = length - diff;
            item[2] = item[2].subarray(diff);
            lastAck = SEQ_INC(lastAck, length - diff);
          } else {
            item[2] = null;
          }
          ++remove;
        }
      } else {
        break;
      }
    }

    if (remove > 0) {
      while (remove --> 0) {
        var data = this._receiveQueue.shift();
        length = item[1];
        if (data[2]) {
          if (this.ondata) {
            this.ondata(data[2]);
          }
        }
      }

      this._receiveWindowSlideTo(lastAck);
      this._sendTransmitQueue(true);
    }
  }

  _receive(u8, srcIP, srcPort, headerOffset) {
    var dataOffset = headerOffset + tcpHeader.getDataOffset(u8, headerOffset);
    var flags = tcpHeader.getFlags(u8, headerOffset);
    var seqNumber = tcpHeader.getSeqNumber(u8, headerOffset);
    var ackNumber = tcpHeader.getAckNumber(u8, headerOffset);
    var windowSize = tcpHeader.getWindowSize(u8, headerOffset);
    var dataLength = u8.length - dataOffset;

    this._transmitWindowSize = windowSize;
    this._transmitWindowSlideTo(ackNumber);

    this._cleanupTransmitQueue(ackNumber);
    this._fillTransmitQueue();

    debug('socket recv seq = ', seqNumber, ' ack = ', ackNumber);

    switch (this._state) {
      case STATE_LISTEN:
        var hash = connHash(srcIP, srcPort);
        var socket = this._connections.get(hash);
        if (socket) {
          return socket._receive(u8, srcIP, srcPort, headerOffset);
        } else {
          if (flags & tcpHeader.FLAG_SYN) {
            socket = new TCPSocket();
            socket._intf = this._intf;
            socket._viaIP = this._viaIP;
            socket._receiveWindowSlideTo(seqNumber);
            socket._receiveWindowSlideInc(); // SYN counts as 1 byte
            socket._transmitWindowSlideInc(); // SYN counts as 1 byte
            socket._state = STATE_SYN_RECEIVED;
            socket._destIP = srcIP;
            socket._destPort = srcPort;
            socket._port = this._port;
            socket._sendSYN(true);
            tcpTimer.addConnectionSocket(socket);
            this._connections.set(hash, socket);
            this._onconnect(socket);
          }
        }
        break;
      case STATE_SYN_SENT:
        if (flags & (tcpHeader.FLAG_SYN | tcpHeader.FLAG_ACK)) {
          this._receiveWindowSlideTo(seqNumber);
          this._receiveWindowSlideInc(); // SYN counts as 1 byte
          this._sendTransmitQueue(true);
          this._state = STATE_ESTABLISHED;
          if (this.onopen) {
            this.onopen();
          }
        }
        break;
      case STATE_SYN_RECEIVED:
        if (flags & tcpHeader.FLAG_ACK) {
          this._state = STATE_ESTABLISHED;
          if (this.onopen) {
            this.onopen();
          }
        }
        break;
      case STATE_LAST_ACK:
        if (this._getTransmitPosition() === ackNumber) {
          this._state = STATE_CLOSED;
          if (this.onclose) {
            this.onclose();
          }
          this._destroy();
        }
        break;
      case STATE_FIN_WAIT_1:
        if (this._getTransmitPosition() === ackNumber) {
          this._state = STATE_FIN_WAIT_2;
        }
        /* fall through */
      case STATE_FIN_WAIT_2:
      case STATE_ESTABLISHED:
        if (dataLength > 0 && this._receiveWindowIsWithin(seqNumber)) {
          this._insertReceiveQueue(seqNumber, dataLength, u8.subarray(dataOffset));
        }
        break;
    }

    if (flags & tcpHeader.FLAG_FIN) {
      this._insertReceiveQueue(SEQ_INC(seqNumber, dataLength), 1, null);

      if (this._state === STATE_FIN_WAIT_2) {
        this._state = STATE_TIME_WAIT;
        this._timeWaitTime = Date.now();
        if (this.onend) {
          this.onend();
        }
        if (this.onclose) {
          this.onclose();
        }
      }

      if (this._state === STATE_ESTABLISHED) {
        this._state = STATE_CLOSE_WAIT;
        if (this.onend) {
          this.onend();
        }
      }
    }
  }

  static lookupReceive(destPort) {
    return ports.get(destPort) || null;
  }
}

module.exports = TCPSocket;
