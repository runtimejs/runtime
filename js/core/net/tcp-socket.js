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

/* eslint-disable new-cap */

'use strict';
const assertError = require('assert-error');
const typeutils = require('typeutils');
const IP4Address = require('./ip4-address');
const portUtils = require('./port-utils');
const PortAllocator = require('./port-allocator');
const tcpTransmit = require('./tcp-transmit');
const route = require('./route');
const tcpHeader = require('./tcp-header');
const netError = require('./net-error');
const tcpTimer = require('./tcp-timer');
const {
  STATE_CLOSED,
  STATE_LISTEN,
  STATE_SYN_SENT,
  STATE_SYN_RECEIVED,
  STATE_ESTABLISHED,
  STATE_FIN_WAIT_1,
  STATE_FIN_WAIT_2,
  STATE_CLOSE_WAIT,
  STATE_CLOSING,
  STATE_LAST_ACK,
  STATE_TIME_WAIT,
} = require('./tcp-socket-state');
const connHash = require('./tcp-hash');
const tcpStat = require('./tcp-stat');
const { timeNow } = require('../../utils');

const ports = new PortAllocator();

function SEQ_INC(seq, value) {
  return (seq + (value >>> 0)) >>> 0;
}

function SEQ_OFFSET(a, b) {
  return (a - b) | 0;
}

const MSL_TIME = 15000;
const bufferedLimitHint = 64 * 1024; /* 64 KiB */

class TCPSocket {
  constructor() {
    this._serverSocket = null;
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

    this._ackRequired = false;

    // Events
    this.onopen = null;
    this.onend = null;
    this.ondata = null;
    this.onclose = null;
    this._onconnect = null;

    this._bufferedAmount = 0;

    ++tcpStat.socketsCreated;
  }

  get bufferedAmount() {
    return this._bufferedAmount;
  }
  get remoteAddress() {
    return this._destIP ? this._destIP.toString() : '0.0.0.0';
  }
  get remotePort() {
    return this._destPort;
  }
  get localAddress() {
    return '0.0.0.0';
  }
  get localPort() {
    return this._port;
  }

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
      default:
        break;
    }
  }

  open(ipOpt, port) {
    let ip = ipOpt;
    if (typeutils.isString(ip)) {
      ip = IP4Address.parse(ip);
    }

    assertError(ip instanceof IP4Address, netError.E_IPADDRESS_EXPECTED);
    assertError(portUtils.isPort(port), netError.E_INVALID_PORT);

    this._destPort = port;
    this._destIP = ip;
    this._state = STATE_SYN_SENT;
    this._sendSYN(false);
    tcpTimer.addConnectionSocket(this);
  }

  suspend() {}
  resume() {}

  _listen(portOpt) {
    let port = portOpt;
    if (!port) {
      port = ports.allocEphemeral(this);
    } else {
      assertError(portUtils.isPort(port), netError.E_INVALID_PORT);
      if (!ports.allocPort(port, this)) {
        throw netError.E_ADDRESS_IN_USE;
      }
    }

    this._port = port;
    this._state = STATE_LISTEN;
    this._connections = new Map();
  }

  _destroy() {
    tcpTimer.removeConnectionSocket(this);
    if (this._serverSocket) {
      const hash = connHash(this._destIP, this._destPort);
      this._serverSocket._connections.delete(hash);
    }
    this._transmitQueue = [];
    this._receiveQueue = [];
    this._queueTx = [];
  }

  _transmit(seq, ack, flags, window, u8) {
    tcpTransmit(this._intf, this._destIP, this._viaIP,
      this._port, this._destPort,
      seq, ack, flags, window, u8);
  }

  _configure() {
    let intf = this._intf || null;

    if (this._destIP.isBroadcast()) {
      return false;
    }

    const routingEntry = route.lookup(this._destIP, intf);
    if (!routingEntry) {
      return false;
    }

    const viaIP = routingEntry.gateway;
    if (!intf) {
      intf = routingEntry.intf;
    }

    if (!this._port) {
      this._port = ports.allocEphemeral(this);
      if (!this._port) {
        return false;
      }
    }

    this._intf = intf;
    this._viaIP = viaIP;
    return true;
  }

  _emitData(u8) {
    setImmediate(() => this.ondata(u8));
  }

  _emitEnd() {
    setImmediate(() => this.onend());
  }

  _emitOpen() {
    this.onopen();
  }

  _emitClose() {
    setImmediate(() => this.onclose());
  }

  _sendSYN(isAck) {
    let flags = tcpHeader.FLAG_SYN;
    if (isAck) {
      flags |= tcpHeader.FLAG_ACK;
    }

    this._transmitQueue.push([0, timeNow(), this._getTransmitPosition(), 1, null, flags]);
    this._incTransmitPosition();

    if (!this._configure()) {
      return;
    }

    this._sendTransmitQueue();
  }

  _incTransmitPosition() {
    this._transmitPosition = SEQ_INC(this._transmitPosition, 1);
  }

  _allocTransmitPosition(length) {
    const end = SEQ_INC(this._transmitWindowEdge, this._transmitWindowSize);
    const spaceLeft = SEQ_OFFSET(end, this._transmitPosition);
    const spaceReserved = Math.min(spaceLeft, length, 536); /* TODO: move MSS (max segment size, data size) somewhere */
    this._transmitPosition = SEQ_INC(this._transmitPosition, spaceReserved);
    return spaceReserved;
  }

  _getTransmitPosition() {
    return this._transmitPosition;
  }

  _receiveWindowSlideTo(seq) {
    this._receiveWindowEdge = seq >>> 0;
  }

  _receiveWindowSlideInc() {
    this._receiveWindowEdge = SEQ_INC(this._receiveWindowEdge, 1);
  }

  _receiveWindowIsWithin(seq, edge) {
    if (this._receiveWindowSize === 0) {
      return false;
    }

    const leftEdge = edge;
    const rightEdge = SEQ_INC(edge, this._receiveWindowSize);
    if (leftEdge < rightEdge) {
      return seq >= leftEdge && seq < rightEdge;
    }
    return seq >= leftEdge || seq < rightEdge;
  }

  _fillTransmitQueue() {
    let remove = 0;

    for (let i = 0, l = this._queueTx.length; i < l; ++i) {
      const buf = this._queueTx[i];
      const position = this._getTransmitPosition();

      if (buf) {
        const length = buf.length;
        const reserved = this._allocTransmitPosition(length);
        debug('send at ', position, 'len', reserved);
        if (reserved === 0) {
          break;
        }

        if (length === reserved) {
          this._transmitQueue.push([0, timeNow(), position, reserved, buf, tcpHeader.FLAG_ACK | tcpHeader.FLAG_PSH]);
          this._bufferedAmount -= reserved;
          ++remove;
        } else {
          this._transmitQueue.push([0, timeNow(), position, reserved, buf.subarray(0, reserved), tcpHeader.FLAG_ACK | tcpHeader.FLAG_PSH]);
          this._queueTx[i] = buf.subarray(reserved);
          this._bufferedAmount -= reserved;
          break;
        }

        if (this._bufferedAmount === 0 && this.ondrain) {
          this.ondrain();
        }
      } else {
        debug('fill pos', position, 'fin');
        this._incTransmitPosition();
        this._transmitQueue.push([0, timeNow(), position, 1, null, tcpHeader.FLAG_ACK | tcpHeader.FLAG_FIN]);
        ++remove;
      }
    }

    while (remove-- > 0) {
      this._queueTx.shift();
    }

    this._sendTransmitQueue();
  }

  _timerTick() {
    switch (this._state) {
      case STATE_TIME_WAIT:
        if (timeNow() > this._timeWaitTime + (2 * MSL_TIME)) {
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
        this._sendTransmitQueue();
        break;
      default:
        break;
    }
  }

  _sendTransmitQueue() {
    const now = timeNow();

    if (this._transmitQueue.length > 0) {
      for (const item of this._transmitQueue) {
        const retransmits = item[0];
        const timeAdded = item[1];
        const seq = item[2];
        const u8 = item[4];
        const flags = item[5];
        const interval = retransmits * 2000; // 2 seconds each time in ms

        if (retransmits > 7) {
          this._resetConnection();
          return;
        }

        if (retransmits === 0 || now > timeAdded + interval) {
          this._ackRequired = false;
          this._transmit(seq, this._receiveWindowEdge, flags, this._receiveWindowSize, u8);
          ++item[0];
        }
      }
    }

    if (this._ackRequired) {
      this._ackRequired = false;
      this._transmit(this._getTransmitPosition(), this._receiveWindowEdge,
        tcpHeader.FLAG_ACK, this._receiveWindowSize, null);
    }
  }

  _cleanupTransmitQueue() {
    let deleteCount = 0;

    if (this._transmitQueue.length === 0) {
      return;
    }

    for (const item of this._transmitQueue) {
      const seq = item[2];
      const len = item[3];
      const end = SEQ_INC(seq, len);

      if (!this._isTransmittedUnacked(end)) {
        ++deleteCount;
      } else {
        break;
      }
    }

    while (deleteCount-- > 0) {
      this._transmitQueue.shift();
    }
  }

  _resetConnection() {
    this._state = STATE_CLOSED;
    this._destroy();
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

  /**
   * Close socket for writes but keep receiving new data
   */
  halfclose() {
    switch (this._state) {
      case STATE_ESTABLISHED:
        this._state = STATE_FIN_WAIT_1;
        break;
      case STATE_CLOSE_WAIT:
        this._state = STATE_LAST_ACK;
        break;
      default:
        throw netError.E_CANNOT_CLOSE;
    }

    this._queueTx.push(null);
    this._fillTransmitQueue();
  }

  /**
   * Close socket for writes and reads (TODO)
   * Close listening socket and all connections
   */
  close() {
    if (this._state === STATE_LISTEN) {
      this._state = STATE_CLOSED;
      ports.free(this._port);
      this._destroy();
      // TODO: close all connections
      if (this.onclose) {
        this._emitClose();
      }
      return;
    }

    switch (this._state) {
      case STATE_ESTABLISHED:
        this._state = STATE_FIN_WAIT_1;
        break;
      case STATE_CLOSE_WAIT:
        this._state = STATE_LAST_ACK;
        break;
      default:
        throw netError.E_CANNOT_CLOSE;
    }

    this._queueTx.push(null);
    this._fillTransmitQueue();
  }

  _insertReceiveQueue(seq, len, u8) {
    // Fast path for ordered data
    if (seq === this._receiveWindowEdge) {
      if (u8 && this.ondata) {
        this._emitData(u8);
      }

      this._receiveWindowSlideTo(SEQ_INC(seq, len));
      this._ackRequired = true;
      this._sendTransmitQueue();

      if (this._receiveQueue.length === 0) {
        return;
      }
    } else {
      this._receiveQueue.push([seq, len, u8]);
    }

    this._processReceiveQueue();
  }

  _processReceiveQueue() {
    let lastAck = this._receiveWindowEdge;
    let removed = 0;
    const queueLength = this._receiveQueue.length;

    for (let j = 0; j < queueLength; ++j) {
      let iterRemoved = false;
      for (let i = 0; i < queueLength - removed; ++i) {
        const item = this._receiveQueue[i];
        const seqNumber = item[0];
        const length = item[1];
        let removeItem = false;
        if (length === 0) {
          continue;
        }

        if (lastAck === seqNumber) {
          lastAck = SEQ_INC(lastAck, length);
          removeItem = true;
        } else if (!this._receiveWindowIsWithin(seqNumber, lastAck)) {
          // order [ seqNumber -- lastAck -- seqNumberEnd ]
          const diff = ((lastAck - seqNumber) >>> 0);
          if (diff < length) {
            item[0] = SEQ_INC(seqNumber, diff);
            item[1] = length - diff;
            item[2] = item[2].subarray(diff);
            lastAck = SEQ_INC(lastAck, length - diff);
          } else {
            item[2] = null;
          }
          removeItem = true;
        }

        if (removeItem) {
          ++removed;

          if (i < queueLength - removed) {
            const t = this._receiveQueue[i];
            this._receiveQueue[i] = this._receiveQueue[queueLength - removed];
            this._receiveQueue[queueLength - removed] = t;
          }

          iterRemoved = true;
          break;
        }
      }

      if (!iterRemoved) {
        break;
      }
    }

    if (removed > 0) {
      while (removed-- > 0) {
        const removedItem = this._receiveQueue.pop();
        if (removedItem[2] && this.ondata) {
          this._emitData(removedItem[2]);
        }
      }

      this._receiveWindowSlideTo(lastAck);
      this._ackRequired = true;
      this._sendTransmitQueue();
    }
  }

  _isTransmittedUnacked(seq) {
    const leftEdge = this._transmitWindowEdge;
    const rightEdge = this._transmitPosition;

    if (leftEdge === rightEdge) {
      return false;
    }

    if (leftEdge < rightEdge) {
      return seq > leftEdge && seq <= rightEdge;
    }
    return seq > leftEdge || seq <= rightEdge;
  }

  _acceptACK(ackNumber, windowSize) {
    this._transmitWindowSize = windowSize;
    if (this._transmitWindowEdge !== ackNumber && this._isTransmittedUnacked(ackNumber)) {
      this._transmitWindowEdge = ackNumber;
      this._cleanupTransmitQueue(ackNumber);
      this._fillTransmitQueue();
    }
  }

  _receive(u8, srcIP, srcPort, headerOffset) {
    const dataOffset = headerOffset + tcpHeader.getDataOffset(u8, headerOffset);
    const flags = tcpHeader.getFlags(u8, headerOffset);
    const seqNumber = tcpHeader.getSeqNumber(u8, headerOffset);
    const ackNumber = tcpHeader.getAckNumber(u8, headerOffset);
    const windowSize = tcpHeader.getWindowSize(u8, headerOffset);
    const dataLength = u8.length - dataOffset;

    switch (this._state) {
      case STATE_LISTEN:
        {
          const hash = connHash(srcIP, srcPort);
          let socket = this._connections.get(hash);
          if (socket) {
            socket._receive(u8, srcIP, srcPort, headerOffset);
            return;
          }
          if (flags & tcpHeader.FLAG_SYN) {
            socket = new TCPSocket();
            socket._serverSocket = this;
            socket._intf = this._intf;
            socket._viaIP = this._viaIP;
            socket._receiveWindowSlideTo(seqNumber);
            socket._receiveWindowSlideInc(); // SYN counts as 1 byte
            socket._state = STATE_SYN_RECEIVED;
            socket._destIP = srcIP;
            socket._destPort = srcPort;
            socket._port = this._port;
            socket._sendSYN(true);
            tcpTimer.addConnectionSocket(socket);
            this._connections.set(hash, socket);
            this._onconnect(socket);
          }
          return;
        }
      case STATE_SYN_SENT:
        this._acceptACK(ackNumber, windowSize);
        if (flags & (tcpHeader.FLAG_SYN | tcpHeader.FLAG_ACK)) {
          this._receiveWindowSlideTo(seqNumber);
          this._receiveWindowSlideInc(); // SYN counts as 1 byte
          this._ackRequired = true;
          this._sendTransmitQueue();
          this._state = STATE_ESTABLISHED;
          if (this.onopen) {
            this._emitOpen();
          }
        }
        break;
      case STATE_SYN_RECEIVED:
        this._acceptACK(ackNumber, windowSize);
        if (flags & tcpHeader.FLAG_ACK) {
          this._state = STATE_ESTABLISHED;
          if (this.onopen) {
            this._emitOpen();
          }
        }
        break;
      case STATE_LAST_ACK:
        this._acceptACK(ackNumber, windowSize);
        if (this._getTransmitPosition() === ackNumber) {
          this._state = STATE_CLOSED;
          if (this.onclose) {
            this._emitClose();
          }
          this._destroy();
        }
        break;
      case STATE_FIN_WAIT_1:
        this._acceptACK(ackNumber, windowSize);
        if (this._getTransmitPosition() === ackNumber) {
          this._state = STATE_FIN_WAIT_2;
        }
        /* fall through */
      case STATE_FIN_WAIT_2:
      case STATE_ESTABLISHED:
        this._acceptACK(ackNumber, windowSize);
        if (dataLength > 0 && this._receiveWindowIsWithin(SEQ_INC(seqNumber, dataLength - 1), this._receiveWindowEdge)) {
          this._insertReceiveQueue(seqNumber, dataLength, u8.subarray(dataOffset));
        }
        break;
      default:
        break;
    }

    if (flags & tcpHeader.FLAG_FIN) {
      this._insertReceiveQueue(SEQ_INC(seqNumber, dataLength), 1, null);

      if (this._state === STATE_FIN_WAIT_2) {
        this._state = STATE_TIME_WAIT;
        this._timeWaitTime = timeNow();
        if (this.onend) {
          this._emitEnd();
        }
        if (this.onclose) {
          this._emitClose();
        }
      }

      if (this._state === STATE_ESTABLISHED) {
        this._state = STATE_CLOSE_WAIT;
        if (this.onend) {
          this._emitEnd();
        }
      }
    }
  }

  static lookupReceive(destPort) {
    return ports.lookup(destPort);
  }
}

module.exports = TCPSocket;

/* eslint-enable new-cap */
