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

define('net/tcpconn', ['net/utils', 'net/tcp'],
function(netUtils, tcp) {
    "use strict";

    var socketState = {
        CLOSED: 0,
        LISTEN: 1,
        SYN_SENT: 2,
        SYN_RECEIVED: 3,
        ESTABLISHED: 4,
        FIN_WAIT_1: 5,
        FIN_WAIT_2: 6,
        CLOSE_WAIT: 7,
        CLOSING: 8,
        LAST_ACK: 9,
        TIME_WAIT: 10,
    };

    function TCPConnectionSocket(intf) {
        this.intf = intf;
        this.state = socketState.CLOSED;
        this.remoteIP = null;
        this.remotePort = 0;
        this.localPort = 0;

        this.remoteWindow = {
            ackedSeqNumber: 0,
            size: 0
        };

        this.localWindow = {
            ackedSeqNumber: 19999,
            nextSeqNumber: 19999,
            size: 8192
        };

        this.bufferedData = [];
        this.bufferedDataLength = 0;
        this.awaitingReadCallback = null;

        this.bufferedSendData = [];
        this.bufferedSendDataLength = 0;
    }

    TCPConnectionSocket.prototype.connect = function(remoteIP, remotePort) {
        if (!(this instanceof TCPConnectionSocket)) throw new Error('instanceof check failed');

        // TODO: implement
    };

    TCPConnectionSocket.prototype.accept = function(remoteIP, remotePort, localPort, seqNumber, windowSize) {
        if (!(this instanceof TCPConnectionSocket)) throw new Error('instanceof check failed');
        this.remoteIP = remoteIP;
        this.remotePort = remotePort;
        this.localPort = localPort;
        this.remoteWindow.ackedSeqNumber = tcp.SEQ_INC(seqNumber, 1);
        this.remoteWindow.size = windowSize;
        this.setState(socketState.SYN_RECEIVED);
        this.sendSYNACK();
    };

    TCPConnectionSocket.prototype.sendACK = function() {
        if (!(this instanceof TCPConnectionSocket)) throw new Error('instanceof check failed');
        this.send(tcp.flags.ACK, null);
    };

    TCPConnectionSocket.prototype.sendSYNACK = function() {
        if (!(this instanceof TCPConnectionSocket)) throw new Error('instanceof check failed');
        this.send(tcp.flags.SYN | tcp.flags.ACK, null);
    };

    TCPConnectionSocket.prototype.sendFIN = function() {
        if (!(this instanceof TCPConnectionSocket)) throw new Error('instanceof check failed');
        this.send(tcp.flags.FIN | tcp.flags.ACK, null);
    };

    TCPConnectionSocket.prototype.send = function(flags, buffer, offset, length) {
        if (!(this instanceof TCPConnectionSocket)) throw new Error('instanceof check failed');

        if (null === buffer) {
            length = 0;
            offset = 0;
        } else {
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
        }

        var tcpOpts = {
            srcPort: this.localPort,
            destPort: this.remotePort,
            seqNumber: this.localWindow.nextSeqNumber,
            ackNumber: this.remoteWindow.ackedSeqNumber,
            flags: flags,
            windowSize: this.localWindow.size,
        };

        var packet = this.intf.createTCPPacket(tcpOpts, buffer);
        this.intf.sendIP4('TCP', this.remoteIP, packet);
    };

    TCPConnectionSocket.prototype.setState = function(state) {
        if (!(this instanceof TCPConnectionSocket)) throw new Error('instanceof check failed');

        if ((state >>> 0) !== state) {
            throw new Error('invalid state');
        }

        this.state = state;
    };

    TCPConnectionSocket.prototype.getState = function() {
        if (!(this instanceof TCPConnectionSocket)) throw new Error('instanceof check failed');
        return this.state;
    };

    TCPConnectionSocket.prototype.sendData = function(buf) {
        if (!(this instanceof TCPConnectionSocket)) throw new Error('instanceof check failed');
        this.bufferedSendData.push(buf);
        this.bufferedSendDataLength += buf.byteLength;

        this.flushSendData();
    };

    TCPConnectionSocket.prototype.close = function() {
        if (!(this instanceof TCPConnectionSocket)) throw new Error('instanceof check failed');
        this.bufferedSendData.push(null);
        this.bufferedSendDataLength += 1;

        this.flushSendData();
    };

    TCPConnectionSocket.prototype.flushSendData = function() {
        if (!(this instanceof TCPConnectionSocket)) throw new Error('instanceof check failed');

        var state = this.getState();
        if (socketState.ESTABLISHED !== state) {
            return;
        }

        if (0 === this.bufferedSendDataLength) {
            return;
        }

        for (var i = 0; i < this.bufferedSendData.length; ++i) {
            var buf = this.bufferedSendData[i];
            if (null === buf) {
                // this.send(tcp.flags.FIN, null);
                // this.sendFIN();
                // this.setState(socketState.FIN_WAIT_1);
                // ++this.localWindow.nextSeqNumber;
            } else {
                this.send(tcp.flags.PSH | tcp.flags.ACK, buf);
                this.localWindow.nextSeqNumber = tcp.SEQ_INC(this.localWindow.nextSeqNumber, buf.byteLength);
            }
        }

        this.bufferedSendDataLength = 0;
        this.bufferedSendData = [];
    };

    TCPConnectionSocket.prototype.recv = function(ip4Header, tcpHeader, buf, len, dataOffset) {
        if (!(this instanceof TCPConnectionSocket)) throw new Error('instanceof check failed');
        var state = this.getState();

        switch (state) {
            case socketState.CLOSED:
                break;
            case socketState.SYN_SENT:
                break;
            case socketState.SYN_RECEIVED:
                if (tcpHeader.flags & tcp.flags.ACK) {
                    this.localWindow.ackedSeqNumber = tcpHeader.ackNumber;
                    this.localWindow.nextSeqNumber = tcpHeader.ackNumber;
                    this.setState(socketState.ESTABLISHED);
                }
                break;
            case socketState.ESTABLISHED:
                var dataLength = len - dataOffset;
                var fin = !!(tcpHeader.flags & tcp.flags.FIN);
                this.insertPacket(tcpHeader.seqNumber, buf, dataOffset, dataLength, fin);

                if (fin) {
                    this.setState(socketState.CLOSE_WAIT);

                    // Assume that application wants to close this connection too
                    this.sendFIN();
                    this.setState(socketState.LAST_ACK);
                }

                if (tcpHeader.flags & tcp.flags.ACK) {
                    this.localWindow.ackedSeqNumber = tcpHeader.ackNumber;
                }
                break;
            case socketState.FIN_WAIT_1:
                break;
            case socketState.FIN_WAIT_2:
                break;
            case socketState.CLOSE_WAIT:
                break;
            case socketState.CLOSING:
                break;
            case socketState.LAST_ACK:
                if (tcpHeader.flags & tcp.flags.ACK) {
                    isolate.log('Socket closed')
                    this.setState(socketState.CLOSED);
                }
                break;
            case socketState.TIME_WAIT:
                break;
            default:
                break;
        }
    };

    TCPConnectionSocket.prototype.insertPacket = function(seq, buf, dataOffset, dataLen, fin) {
        if (!(this instanceof TCPConnectionSocket)) throw new Error('instanceof check failed');

        var seqEnd = tcp.SEQ_INC(seq, dataLen + (fin ? 1 : 0));

        if (seqEnd === seq) {
            return;
        }


        isolate.log('**** INSERT PACKET : seq', seq, 'len', dataLen);

        // Drop packets outside of the receive window
        var windowFrom = this.remoteWindow.ackedSeqNumber;
        var windowTo = tcp.SEQ_INC(this.remoteWindow.ackedSeqNumber, this.remoteWindow.size);
        if (tcp.SEQ_LT(seq, windowFrom) || tcp.SEQ_GTE(seq, windowTo)) {
            isolate.log('[TCP] drop packet outside of window with seq ', seq, 'window from ', windowFrom, 'to', windowTo);
            return;
        }

        // Next expected packet (no reorder)
        if (seq === this.remoteWindow.ackedSeqNumber) {
            if (dataLen > 0) {
                // TODO: avoid this copy, shrink buffer inplace
                this.bufferedData.push(buf.slice(dataOffset, dataOffset + dataLen));
                this.bufferedDataLength += dataLen;
            }

            this.remoteWindow.ackedSeqNumber = seqEnd;
            this.sendACK();
        } else {
           // TODO: handle packet reorder
        }

        this.pushBuffersToApplication();
    };

    TCPConnectionSocket.prototype.pushBuffersToApplication = function() {
        if (null === this.awaitingReadCallback) {
            return;
        }

        if (0 === this.bufferedDataLength) {
            return;
        }

        this.awaitingReadCallback(this.bufferedData);
        this.bufferedData = [];
        this.bufferedDataLength = 0;
        this.awaitingReadCallback = null;
    };

    TCPConnectionSocket.prototype.read = function(resolve, reject) {
        this.awaitingReadCallback = resolve;
        this.pushBuffersToApplication();
    };

    return {
        TCPConnectionSocket: TCPConnectionSocket,
    };
});
