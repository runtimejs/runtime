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

define('net/socket', ['net/udp', 'net/utils', 'interface'],
function(udp, netUtils, intfc) {
    "use strict";

    var getInterfaceByName = null;
    var emptyFunction = function() {};

    /**
     * UDP datagram sockets
     */
    var udpSockets = (function() {
        var nextRandomPort = 49152;

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

        var udpSocketPool = intfc.createHandlePool();
        var sockets = [];
        var bindTable = [];

        function getSocketByHandle(socketHandle) {
            if (!udpSocketPool.has(socketHandle)) {
                throw new Error('INVALID_HANDLE');
            }

            return sockets[socketHandle.index()];
        }

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
                sockets[socketHandle.index()] = new UDPSocket(onMessage, onError);
                return Promise.resolve(socketHandle);
            },
            /**
             * Bind socket to port
             *
             * @param {socketHandle} socketHandle Handle created using createSocket
             * @param {number} port Port number
             */
            bindSocket: function(socketHandle, port) {
                if (!netUtils.isPortValid(port)) {
                    throw new Error('INVALID_PORT');
                }

                var socket = getSocketByHandle(socketHandle);
                socket.bind(port);
                return Promise.resolve(socketHandle);
            },
            /**
             * Send datagram
             *
             * @param {socketHandle} socketHandle Handle created using createSocket
             * @param {string} ipAddress Receiver IP address
             * @param {number} port Receiver port number
             * @param {ArrayBuffer} buffer Data buffer
             * @param {number} offset [optional] Buffer offset or 0
             * @param {number} length [optional] Buffer length or entire buffer
             */
            send: function(socketHandle, ipAddress, port, buffer, offset, length) {
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

                var socket = getSocketByHandle(socketHandle);
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

    return {
        udpSocketApi: udpSockets.api,
        recvUDP4: udpSockets.recv,
        setup: function(opts) {
            getInterfaceByName = opts.getInterfaceByName;
        },
    };
});
