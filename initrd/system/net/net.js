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

define('net', ['vfs', 'eth', 'ip4', 'udp', 'socket', 'dhcp', 'arp'],
function(vfs, eth, ip4, udp, socket, dhcp, arp) {
    "use strict";

    var ethIndex = 0;
    var interfaces = [];
    var interfaceByName = {};

    function PacketReader(buf, len, offset) {
        this.buf = buf;
        this.len = len;
        this.offset = offset;
        this.view = new DataView(buf);
    }

    PacketReader.prototype.readUint8 = function() {
        return this.view.getUint8(this.offset++);
    }

    PacketReader.prototype.readUint16 = function() {
        var value = this.view.getUint16(this.offset, false);
        this.offset += 2;
        return value;
    }

    function Interface(name, hwAddr, sendPacket) {
        this.name = name;
        this.hwAddr = hwAddr;
        this.ip = null;
        this.netmask = null;
        this.gateway = null;
        this.dnsArray = null;
        this.ip6 = null;
        this.netmask6 = null;
        this.sendPacket = sendPacket;
        this.packetHeaderLength = 0;
    }

    function parseIPv4(reader) {
        var ip4Header = ip4.parse(reader);
        if (null === ip4Header) {
            return;
        }

        switch (ip4Header.protocol) {
            case 'UDP':
                var udpHeader = udp.parse(reader);
                isolate.log(JSON.stringify(ip4Header), JSON.stringify(udpHeader));
                socket.recvUDP4(ip4Header, udpHeader, reader.buf, reader.len, reader.offset);
                break;
            case 'TCP':
            case 'ICMP':
            default: return null;
        }
    }

    // function resolveHwAddrByIp4(ip) {
    //     
    // }

    // TODO: implement routing table

    function sendARP(ifcName, buf, offset, length) {
        var ifc = null;
        if (String(ifcName)) {
            if ('undefined' === typeof interfaceByName[ifcName]) {
                throw new Error('INVALID_INTERFACE');
            }

            ifc = interfaceByName[ifcName];
        } else {
            // TODO: use routing table
            ifc = interfaces[1];
        }

        var dataLength = (length - offset) >>> 0;

        var ifcHeaderLength = ifc.packetHeaderLength;
        var ethHeaderLength = eth.headerLength;

        var headersLength = ifcHeaderLength + ethHeaderLength;
        var totalLength = headersLength + dataLength;

        var sendBuf = new ArrayBuffer(totalLength);
        var view = new DataView(sendBuf);

        eth.writeHeader(view, ifcHeaderLength, {
            destMac: [0xff, 0xff, 0xff, 0xff, 0xff, 0xff],
            srcMac: ifc.hwAddr,
        });

        // 1 data copy (TODO: find a way to optimize this)
        new Uint8Array(sendBuf).set(new Uint8Array(buf), headersLength);
        runtime.debug(sendBuf);
        ifc.send(sendBuf);
    }

    function getHwAddrByIp(ifc, srcIP, destIP, resolve) {
        if (0xff == destIP[0] && 0xff == destIP[1] && 0xff == destIP[2] && 0xff == destIP[3]) {
            // Broadcast IP -> broadcast HW
            return resolve([0xff, 0xff, 0xff, 0xff, 0xff, 0xff]);
        }

        arp.requestHwAddr(ifc, ifc.hwAddr, srcIP, destIP, function(destHwAddr) {
            isolate.log('-------------------------GOT DEST ', destHwAddr.join(':'));
            return resolve(destHwAddr);
        });
    }

    function sendUDP4(ifcName, buf, offset, length, destIP, destPort, srcIP, srcPort) {
        var ifc = null;
        if (String(ifcName)) {
            if ('undefined' === typeof interfaceByName[ifcName]) {
                throw new Error('INVALID_INTERFACE');
            }

            ifc = interfaceByName[ifcName];
        } else {
            // TODO: use routing table
            ifc = interfaces[1];
        }

        // arp.requestHwAddr(ifc, ifc.hwAddr, srcIP, destIP, function(destHwAddr) {
        //     isolate.log('-------------------------GOT DEST ', destHwAddr.join(':'));
        // });

        getHwAddrByIp(ifc, srcIP, destIP, function(destHwAddr) {
            var dataLength = (length - offset) >>> 0;

            var ifcHeaderLength = ifc.packetHeaderLength;
            var ethHeaderLength = eth.headerLength;
            var ip4HeaderLength = ip4.getHeaderLength();
            var udpHeaderLength = udp.headerLength;

            var headersLength = ifcHeaderLength + ethHeaderLength + ip4HeaderLength + udpHeaderLength;
            var totalLength = headersLength + dataLength;

            var sendBuf = new ArrayBuffer(totalLength);
            var view = new DataView(sendBuf);

            // TODO: use ARP to find dest HW address
            eth.writeHeader(view, ifcHeaderLength, {
                destMac: [0xff, 0xff, 0xff, 0xff, 0xff, 0xff],
                srcMac: ifc.hwAddr,
            });

            ip4.writeHeader(view, ifcHeaderLength + ethHeaderLength, {
                protocol: 'UDP',
                srcIP: srcIP,
                destIP: destIP,
            });

            udp.writeHeader(view, ifcHeaderLength + ethHeaderLength + ip4HeaderLength, {
                srcPort: srcPort,
                destPort: destPort,
            });

            // 1 data copy (TODO: find a way to optimize this)
            new Uint8Array(sendBuf).set(new Uint8Array(buf), headersLength);
            ifc.send(sendBuf);
        });

    }

    socket.setup({sendUDP4: sendUDP4});
    arp.setup({sendARP: sendARP});

    Interface.prototype.recv = function(buf, len, offset) {
        isolate.log('[net] RECV ', len);
        var reader = new PacketReader(buf, len, offset + this.packetHeaderLength);
        var ethHeader = eth.parse(reader);

        if (null === ethHeader) {
            return;
        }

        switch (ethHeader.etherType) {
            case 'IPv4':
                parseIPv4(reader);
                break;
            case 'ARP':
                arp.parse(reader);
                break;
            default:
                isolate.log('[net] ip4');

        }

    };

    Interface.prototype.configure = function(ip, netmask, gateway, dnsArray) {
        this.ip = ip;
        this.netmask = netmask;
        this.gateway = gateway;
        this.dnsArray = dnsArray;
    }

    Interface.prototype.send = function(buf, len) {
        return this.sendPacket(buf, len);
    };

    function addInterface(name, hwAddr, sendPacket) {
        var ifc = new Interface(name, hwAddr, sendPacket);
        interfaces.push(ifc);
        interfaceByName[name] = ifc;

        return ifc;
    }

    function enableInterface(ifc) {
        if (null !== ifc.hwAddr) {
            dhcp.run(ifc, sendUDP4).then(function(config) {
                isolate.log('conf', JSON.stringify(config));
                ifc.configure(config.yourIP, config.subnetMask, config.routerIPList[0], config.dnsIPList)
            });
        }
    }

    function listInterfaces() {
        var result = [];
        for (var i = 0; i < interfaces.length; ++i) {
            var ifc = interfaces[i];

            result.push({
                name: ifc.name,
                hwAddr: ifc.hwAddr,
                ip: ifc.ip,
                netmask: ifc.netmask,
                gateway: ifc.gateway,
            });
        }

        return result;
    }

    // Loopback interface
    var loopback = addInterface('loopback', null, function() {});
    loopback.configure([127, 0, 0, 1], [255, 0, 0, 0], null, null);

    // Expose network management functions
    vfs.setKernelValue('listNetworkInterfaces', listInterfaces);
    vfs.setKernelValue('createSocket', socket.createSocket);
    vfs.setKernelValue('addNetworkInterface', function(opts) {
        // Hardware address
        var hw = opts.hw || null;

        // Send packet handler function
        var sendPacket = opts.sendPacket || function() { throw new Error('unable to send packet') };

        // Extra space required for network interface packet header
        // in every buffer (useful for virio 10 bytes header)
        var packetHeaderLength = opts.packetHeaderLength || 0;

        var ifc = addInterface('eth' + ethIndex++, hw, sendPacket);
        ifc.packetHeaderLength = packetHeaderLength;

        var result = {
            recv: function(buf, len, offset) {
                return ifc.recv(buf, len, offset);
            },
            enable: function() {
                enableInterface(ifc);
            },
        };

        return Promise.resolve(result);
    });

    return {};
});
