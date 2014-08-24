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

define('net', ['vfs', 'net/eth', 'net/ip4', 'net/udp', 'net/socket', 'net/dhcp', 'net/arp'],
function(vfs, eth, ip4, udp, socket, dhcp, arp) {
    "use strict";

    var ethIndex = 0;
    var interfaces = [];
    var interfaceByName = {};

    // TODO: replace this with routing table
    var GLOBAL_routerIP = null;
    var GLOBAL_netmask = null;
    var GLOBAL_myIP = null;
    function applyMask(ip, mask) {
        return [ip[0] & mask[0], ip[1] & mask[1], ip[2] & mask[2], ip[3] & mask[3]];
    }

    function compareIPs(ip1, ip2) {
        return ip1[0] === ip2[0] && ip1[1] === ip2[1] &&
            ip1[2] === ip2[2] && ip1[3] === ip2[3];
    }

    function route(destIP) {
        if (null === GLOBAL_routerIP || null === GLOBAL_netmask) {
            // send directly
            return destIP;
        }

        // Are we one the same network?
        if (compareIPs(applyMask(destIP, GLOBAL_netmask), applyMask(GLOBAL_myIP, GLOBAL_netmask))) {
            // send directly
            return destIP;
        }

        // Send through router
        return GLOBAL_routerIP;
    }

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
        this.arpResolver = new arp.ARPResolver(this);
        this.ip = null;
        this.netmask = null;
        this.gateway = null;
        this.dnsArray = null;
        this.ip6 = null;
        this.netmask6 = null;
        this.sendPacket = sendPacket;
        this.packetHeaderLength = 0;
        this.enabled = false;

        // Packets without full ethernet header
        this.sendQueue = [];
    }

    Interface.prototype.matchHwAddr = function(hwAddr) {
        var a = this.hwAddr, b = hwAddr;
        return a[0] === b[0] && a[1] === b[1] && a[2] === b[2] &&
            a[3] === b[3] && a[4] === b[4] && a[5] === b[5];
    };

    Interface.prototype.matchIPAddr = function(ip) {
        var a = this.ip, b = ip;
        return a[0] === b[0] && a[1] === b[1] && a[2] === b[2] &&
            a[3] === b[3];
    };

    Interface.prototype.sendEthBroadcast = function(etherType, sendBuf) {
        var self = this;
        var view = new DataView(sendBuf);

        eth.writeHeader(view, self.packetHeaderLength, {
            destMac: [0xff, 0xff, 0xff, 0xff, 0xff, 0xff],
            srcMac: self.hwAddr,
            etherType: etherType,
        });

        self.sendPacket(sendBuf);
    };

    Interface.prototype.sendEthUnicast = function(destIP, viaIP, sendBuf) {
        var self = this;
        var view = new DataView(sendBuf);

        if (!self.ip) {
            isolate.log('[send] drop packet, no ip assigned');
            return;
        }

        self.arpResolver.getAddressForIP(viaIP, function(destHW) {
            eth.writeHeader(view, self.packetHeaderLength, {
                destMac: destHW,
                srcMac: self.hwAddr,
                etherType: eth.etherType.IPv4,
            });

            self.sendPacket(sendBuf);
        });
    };

    Interface.prototype.sendIP4Broadcast = function(protocol, sendBuf) {
        var self = this;
        var view = new DataView(sendBuf);

        ip4.writeHeader(view, self.packetHeaderLength + eth.headerLength, {
            protocol: protocol,
            srcIP: self.ip || [0, 0, 0, 0],
            destIP: [255, 255, 255, 255],
        });

        self.sendEthBroadcast(eth.etherType.IPv4, sendBuf);
    };

    Interface.prototype.sendIP4Unicast = function(protocol, destIP, viaIP, sendBuf) {
        var self = this;
        var view = new DataView(sendBuf);

        ip4.writeHeader(view, self.packetHeaderLength + eth.headerLength, {
            protocol: protocol,
            srcIP: self.ip || [0, 0, 0, 0],
            destIP: destIP,
        });

        self.sendEthUnicast(destIP, viaIP, sendBuf);
    };

    Interface.prototype.sendIP4 = function(protocol, destIP, sendBuf) {
        var self = this;
        var b0 = Number(destIP[0]);

        if (0 === b0) {
            isolate.log('drop 0.x.x.x');
            return;
        }

        // Multicast
        if (b0 >= 224 && b0 <= 239) {
            isolate.log('drop multicast / not implemented');
            return;
        }

        // Broadcast
        if (255 === b0 && 255 === Number(destIP[1]) &&
            255 === Number(destIP[2]) && 255 === Number(destIP[3])) {
            return self.sendIP4Broadcast(protocol, sendBuf);
        }

        // TODO: use routing table
        var viaIP = route(destIP);

        return self.sendIP4Unicast(protocol, destIP, viaIP, sendBuf);
    }

    Interface.prototype.createEthPacket = function(buf) {
        var self = this;
        var dataLength = buf.byteLength >>> 0;
        var headersLength = self.packetHeaderLength + eth.headerLength;
        var totalLength = headersLength + dataLength;

        var sendBuf = new ArrayBuffer(totalLength);
        new Uint8Array(sendBuf).set(new Uint8Array(buf), headersLength);
        return sendBuf;
    };

    Interface.prototype.createUDPPacket = function(srcPort, destPort, buf) {
        var self = this;

        var dataLength = buf.byteLength >>> 0;
        var ipHeadersLength = self.packetHeaderLength + eth.headerLength + ip4.getHeaderLength();
        var headersLength = ipHeadersLength + udp.headerLength;
        var totalLength = headersLength + dataLength;

        var sendBuf = new ArrayBuffer(totalLength);
        var view = new DataView(sendBuf);

        udp.writeHeader(view, ipHeadersLength, {
            srcPort: srcPort,
            destPort: destPort,
        });

        new Uint8Array(sendBuf).set(new Uint8Array(buf), headersLength);
        return sendBuf;
    };

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

    function getInterfaceByName(intfName) {
        var intf = null;
        if ('string' !== typeof intfName) {
            return null;
        }

        if ('undefined' === typeof interfaceByName[intfName]) {
            return null;
        }

        return interfaceByName[intfName];
    }

    socket.setup({getInterfaceByName: getInterfaceByName});

    Interface.prototype.recv = function(buf, len, offset) {
        var self = this;
        isolate.log('[net] RECV ', len);
        var reader = new PacketReader(buf, len, offset + self.packetHeaderLength);
        var ethHeader = eth.parse(reader);

        if (null === ethHeader) {
            return;
        }

        switch (ethHeader.etherType) {
            case 'IPv4':
                parseIPv4(reader);
                break;
            case 'ARP':
                self.arpResolver.recv(reader);
                break;
            default:
                isolate.log('drop unknown packet');

        }
    };

    Interface.prototype.configure = function(ip, netmask, gateway, dnsArray) {
        this.ip = ip;
        this.netmask = netmask;
        this.gateway = gateway;
        this.dnsArray = dnsArray;
        this.enabled = true;

        // TODO: Put into routing table
        GLOBAL_routerIP = gateway;
        GLOBAL_netmask = netmask;
        GLOBAL_myIP = ip;
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
            new dhcp.DHCPClient(ifc.name, ifc.hwAddr, function(config) {
                isolate.log('DHCP autoconfig', JSON.stringify(config));
                ifc.configure(config.yourIP, config.subnetMask, config.routerIPList[0], config.dnsIPList)
            }, function(err) {
                isolate.log(err.stack);
            }).start();
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
