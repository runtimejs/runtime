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

define('net/tcpsocket', ['net/utils', 'net/tcpconn', 'net/tcp', 'interface', 'resources'],
function(netUtils, tcpConn, tcp, intfc, resources) {
    "use strict";

    /**
     * Maps handle -> socket
     */
    var tcpConnections = new Map();

    /**
     * Handle pool for connection sockets
     */
    var tcpConnectionsSocketPool = intfc.createHandlePool({
        read: function() {
            var socket = tcpConnections.get(this);
            return new Promise(function(resolve, reject) {
                socket.read(resolve, reject);
            });
        },
        write: function(buf) {
            var socket = tcpConnections.get(this);
            socket.sendData(buf);
        },
        close: function() {
            var socket = tcpConnections.get(this);
            socket.close();
        }
    });

    /**
     * Note: No listening to IP address support (0.0.0.0 assumed)
     */
    var listeningTable = (function() {
        var table = Object.create(null);

        return {
            set: function(port, socket) {
                if (table[port]) {
                    throw new Error('ADDR_IN_USE');
                }

                table[port] = socket;
            },
            get: function(port) {
                var socket = table[port];

                if (!socket) {
                    return null;
                }

                return socket;
            },
            delete: function(port) {
                delete table[port];
            }
        };
    })();

    function TCPServerSocket(onConnection) {
        this.onConnection = onConnection || emptyFunction;
        this.listeningPort = 0;
        this.isListening = false;
        this.connections = Object.create(null);
    }

    TCPServerSocket.prototype.listen = function(port) {
        if (!(this instanceof TCPServerSocket)) throw new Error('instanceof check failed');

        if (this.isListening) {
            throw new Error('ALREADY_LISTENING');
        }

        this.listeningPort = port;
        this.isListening = true;

        listeningTable.set(port, this);
    };

    TCPServerSocket.prototype.close = function() {
        if (!(this instanceof TCPServerSocket)) throw new Error('instanceof check failed');

        if (!this.isListening) {
            return;
        }

        listeningTable.delete(this.listeningPort);
        this.isListening = false;
        this.listeningPort = 0;
    };

    TCPServerSocket.prototype.accept = function(intf, remoteIP, remotePort, seqNumber, windowSize) {
        if (!(this instanceof TCPServerSocket)) throw new Error('instanceof check failed');

        if (!this.isListening) {
            return null;
        }

        var socket = new tcpConn.TCPConnectionSocket(intf);
        socket.accept(remoteIP, remotePort, this.listeningPort, seqNumber, windowSize);
        this.connections[remoteIP + ':' + remotePort] = socket;
        return socket;
    };

    TCPServerSocket.prototype.recv = function(intf, ip4Header, tcpHeader, buf, len, dataOffset) {
        if (!(this instanceof TCPServerSocket)) throw new Error('instanceof check failed');

        var remoteIP = ip4Header.srcIP;
        var remotePort = tcpHeader.srcPort;

        var conn = this.connections[remoteIP + ':' + remotePort];
        if (conn) {
            conn.recv(ip4Header, tcpHeader, buf, len, dataOffset);
            return;
        }

        if (!this.isListening) {
            // TODO: Send reset
            return;
        }

        if (tcpHeader.flags & tcp.flags.SYN) {
            var socket = this.accept(intf, remoteIP, remotePort, tcpHeader.seqNumber, tcpHeader.windowSize);

            if (socket) {
                var socketHandle = tcpConnectionsSocketPool.createHandle();
                tcpConnections.set(socketHandle, socket);
                this.onConnection(socketHandle);
            }

            return;
        }
    };

    return {
        TCPServerSocket: TCPServerSocket,
        getListeningSocket: function(port) {
            return listeningTable.get(port);
        },
    };
});
