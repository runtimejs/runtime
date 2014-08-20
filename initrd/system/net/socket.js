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

define('socket', ['udp'],
function(udp) {
    "use strict";

    function UDPSocket(ip, eventFn) {
        this.ip = null;
        this.eventFn = eventFn;
    }

    // Network layer callbacks
    var sendUDP4 = null;
    var getInterfaceByName

    var socketsUDP = [];
    var bindTableUDP4 = [];

    function validateIpAddressString(ipString) {
        var parts = String(ipString).split('.');
        if (4 !== parts.length) {
            return false;
        }

        for (var i = 0; i < 4; ++i) {
            if ((parts[i] & 0xff) !== +parts[i]) {
                return false;
            }
        }

        return true;
    }

    function createUDPSocket(socketOpts) {
        var sock = new UDPSocket(null, socketOpts.event || null);
        socketsUDP.push(sock);

        if (socketOpts.bindPort) {
            if ('number' !== typeof socketOpts.bindPort) {
                throw new Error('PORT_REQUIRED');
            }

            if (socketOpts.bindPort <= 0 || socketOpts.bindPort > 0xffff) {
                throw new Error('INVALID_PORT');
            }

            var port = socketOpts.bindPort >>> 0;
            if ('undefined' !== typeof bindTableUDP4[port]) {
                throw new Error('ADDRESS_IN_USE');
            }

            bindTableUDP4[port] = sock;
        }

        function send(sendOpts) {
            if ('number' !== typeof sendOpts.port) {
                throw new Error('PORT_REQUIRED');
            }

            if (sendOpts.port <= 0 || sendOpts.port > 0xffff) {
                throw new Error('INVALID_PORT');
            }

            if (!validateIpAddressString(sendOpts.address)) {
                throw new Error('INVALID_ADDRESS');
            }

            if (!validateIpAddressString(sendOpts.sourceAddress)) {
                throw new Error('INVALID_ADDRESS');
            }

            if (!(sendOpts.buf instanceof ArrayBuffer)) {
                throw new Error('INVALID_BUFFER');
            }

            var port = sendOpts.port >>> 0;
            var sourcePort = sendOpts.sourcePort >>> 0;
            var address = sendOpts.address.split('.');
            var sourceAddress = sendOpts.sourceAddress.split('.');
            var buf = sendOpts.buf;
            var length = (sendOpts.length >>> 0) || buf.byteLength;
            var offset = (sendOpts.offset >>> 0) || 0;
            var ifc = String(sendOpts.ifc) || null;

            if (null === sendUDP4) {
                throw new Error('INTERNAL_ERROR');
            }

            sendUDP4(ifc, buf, offset, length, address, port, sourceAddress, sourcePort);
        }

        return function(opts) {
            switch (opts.action) {
                case 'send': return send(opts);
            }
        };
    }

    return {
        createSocket: function(type, opts) {
            switch (type) {
                case 'udp': return Promise.resolve(createUDPSocket(opts));
                default: throw new Error('NOT_SUPPORTED_PROTOCOL');
            }
        },
        recvUDP4: function(ip4Header, udpHeader, buf, len, dataOffset) {
            var port = udpHeader.destPort;

            if ('undefined' === typeof bindTableUDP4[port]) {
                return;
            }

            var sock = bindTableUDP4[port];
            var dataLength = udpHeader.dataLength - udp.headerLength;
            sock.eventFn('message', {
                buf: buf.slice(dataOffset, dataOffset + dataLength), // TODO: optimize out this copy
                family: 'IPv4',
                port: udpHeader.srcPort,
                address: ip4Header.srcIP.join('.'),
                size: dataLength,
            });
        },
        setup: function(opts) {
            sendUDP4 = opts.sendUDP4;
        },
    };
});
