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

define('net/dhcp', ['net/socket'],
function(netSocket) {
  "use strict";

  var magicCookie = 0x63825363;
  var packetType = {
    DISCOVER: 1,
    OFFER: 2,
    REQUEST: 3,
    DECLINE: 4,
    ACK: 5,
    NAK: 6,
    RELEASE: 7,
    INFORM: 8
  };

  function createPacket(opts) {
    var optionsLength = 8; // cookie (4b), type (3b) and 0xff (1b)
    for (i = 0; i < opts.options.length; ++i) {
      optionsLength += opts.options[i].bytes.length + 2; // id (1b) and len (1b)
    }

    var buf = new ArrayBuffer(28 + 16 + 192 + optionsLength);
    var view = new DataView(buf);
    var offset = 0;
    var i, j;

    view.setUint8(offset + 0, 1); // request
    view.setUint8(offset + 1, 1); // over ethernet
    view.setUint8(offset + 2, 6); // hw address 6 bytes
    view.setUint8(offset + 3, 0);
    view.setUint32(offset + 4, 0x112233, false); // random id
    view.setUint16(offset + 8, 0, false); // secs
    view.setUint16(offset + 10, 0, false); // flags
    view.setUint32(offset + 12, 0, false); // client ip
    view.setUint32(offset + 16, 0, false); // your ip
    view.setUint32(offset + 20, 0, false); // server ip
    view.setUint32(offset + 24, 0, false); // gateway ip
    var pos = 28;
    for (i = 0; i < 6; ++i) {
      view.setUint8(offset + pos++, opts.srcMac[i]);
    }
    var optionsOffset = offset + 28 + 16 + 192;
    view.setUint32(optionsOffset, magicCookie, false);
    optionsOffset += 4;

    // Option: DHCP Message = Discover
    view.setUint8(optionsOffset++, 53); // id
    view.setUint8(optionsOffset++, 1);  // len
    view.setUint8(optionsOffset++, opts.type >>> 0);

    // Other options
    for (i = 0; i < opts.options.length; ++i) {
      var option = opts.options[i];
      view.setUint8(optionsOffset++, option.id); // id
      view.setUint8(optionsOffset++, option.bytes.length & 0xff);  // len
      for (j = 0; j < option.bytes.length; ++j) {
        view.setUint8(optionsOffset++, option.bytes[j] >>> 0);
      }
    }

    view.setUint8(optionsOffset, 255); // end of option list
    return buf;
  }

  function parseDHCP(buf, expectedRequestId) {
    var offset = 0;
    var view = new DataView(buf);
    var op = view.getUint8(offset + 0);

    // 2 = response
    if (2 !== op) {
      return null;
    }

    var requestId = view.getUint32(offset + 4, false);
    if (requestId !== expectedRequestId) {
      return null;
    }

    var i, pos = offset + 12 + 4;
    var yourIP = [];
    var serverIP = [];
    var subnetMask = [];
    var routerIPList = [];
    var dnsIPList = [];
    var leaseTimeSeconds = 0;
    var serverIdentifierIP = [];
    var messageType = 0;

    yourIP[0] = view.getUint8(pos++);
    yourIP[1] = view.getUint8(pos++);
    yourIP[2] = view.getUint8(pos++);
    yourIP[3] = view.getUint8(pos++);
    serverIP[0] = view.getUint8(pos++);
    serverIP[1] = view.getUint8(pos++);
    serverIP[2] = view.getUint8(pos++);
    serverIP[3] = view.getUint8(pos++);

    var optionsOffset = offset + 28 + 16 + 192;
    var magic = view.getUint32(optionsOffset, false);
    if (magic !== magicCookie) {
      return null;
    }

    optionsOffset += 4;

    for (i = optionsOffset; i < buf.byteLength; ++i) {
      var optId = view.getUint8(i++);
      var optLen = view.getUint8(i++);

      if (0xff === optId) {
        break;
      }

      if (0x00 === optId) {
        continue;
      }

      switch (optId) {
        case 1:
          subnetMask[0] = view.getUint8(i + 0);
          subnetMask[1] = view.getUint8(i + 1);
          subnetMask[2] = view.getUint8(i + 2);
          subnetMask[3] = view.getUint8(i + 3);
          break;
        case 3:
          var routerIP = [];
          routerIP[0] = view.getUint8(i + 0);
          routerIP[1] = view.getUint8(i + 1);
          routerIP[2] = view.getUint8(i + 2);
          routerIP[3] = view.getUint8(i + 3);
          routerIPList.push(routerIP);
          // TODO: could be more than 1 router here
          break;
        case 6:
          var dnsIP = [];
          dnsIP[0] = view.getUint8(i + 0);
          dnsIP[1] = view.getUint8(i + 1);
          dnsIP[2] = view.getUint8(i + 2);
          dnsIP[3] = view.getUint8(i + 3);
          dnsIPList.push(dnsIP);
          // TODO: could be more than 1 DNS here
          break;
        case 51:
          leaseTimeSeconds = view.getUint32(i);
          break;
        case 53:
          messageType = view.getUint8(i);
          break;
        case 54:
          serverIdentifierIP[0] = view.getUint8(i + 0);
          serverIdentifierIP[1] = view.getUint8(i + 1);
          serverIdentifierIP[2] = view.getUint8(i + 2);
          serverIdentifierIP[3] = view.getUint8(i + 3);
          break;
      }

      i += optLen - 1;
    }

    // Debug
    // isolate.log('DHCP offer:');
    // isolate.log('Your IP', yourIP.join('.'));
    // isolate.log('Server IP', serverIP.join('.'));
    // isolate.log('Subnet mask', subnetMask.join('.'));
    // isolate.log('Router IP(s)', routerIPList.map(function(x) { return x.join('.') }).join(', '));
    // isolate.log('DNS IP(s)', dnsIPList.map(function(x) { return x.join('.') }).join(', '));
    // isolate.log('Server identifier IP', serverIdentifierIP.join('.'));
    // isolate.log('Lease time ' + leaseTimeSeconds + ' sec');

    return {
      yourIP: yourIP,
      serverIP: serverIP,
      subnetMask: subnetMask,
      routerIPList: routerIPList,
      dnsIPList: dnsIPList,
      leaseTimeSeconds: leaseTimeSeconds,
      serverIdentifierIP: serverIdentifierIP,
      messageType: messageType,
    };
  }

  /**
   * DHCP client
   *
   * @param {string} intfName Interface name
   * @param {array(6)} intfHWAddr Hardware address
   * @param {function} success DHCP success callback
   * @param {function} failed DHCP failed callback
   */
  function DHCPClient(intfName, intfHWAddr, success, failed) {
    this.intfName = intfName;
    this.intfHWAddr = intfHWAddr;
    this.socket = null;
    this.requestId = 0x112233;
    this.success = success;
    this.failed = failed;
    this.enabled = false;
  }

  DHCPClient.prototype._sendPacket = function(type, serverIp) {
    if (!(this instanceof DHCPClient)) {
      throw new Error('instanceof check failed');
    }

    var self = this;
    if (null === self.socket) {
      throw new Error('socket is not ready');
    }

    // Request info option
    var opt0 = {id: 55, bytes: [
      1, // subnet
      3, // router
      6  // dns
    ]};

    var options = null;
    if (serverIp) {
      options = [opt0, {id: 54, bytes: serverIp}];
    } else {
      options = [opt0];
    }

    var packetBuf = createPacket({
      type: type,
      srcMac: self.intfHWAddr,
      requestId: self.requestId,
      options: options,
    });

    return self.socket.send('255.255.255.255', 67, packetBuf);
  };

  DHCPClient.prototype._sendDiscoverPacket = function() {
    if (!(this instanceof DHCPClient)) {
      throw new Error('instanceof check failed');
    }

    return this._sendPacket(packetType.DISCOVER, null);
  };

  DHCPClient.prototype._sendRequestPacket = function(serverIp) {
    if (!(this instanceof DHCPClient)) {
      throw new Error('instanceof check failed');
    }

    return this._sendPacket(packetType.REQUEST, serverIp);
  };

  DHCPClient.prototype._onMessage = function(data) {
    if (!(this instanceof DHCPClient)) {
      throw new Error('instanceof check failed');
    }

    var self = this;
    var dhcpResponse = parseDHCP(data.buf, self.requestId)

    if (null === dhcpResponse) {
      return;
    }

    var serverIp = null;

    if (packetType.OFFER === dhcpResponse.messageType) {
      if (dhcpResponse.serverIdentifierIP && dhcpResponse.serverIdentifierIP.length > 0) {
        serverIp = dhcpResponse.serverIdentifierIP;
      } else {
        // Use source IP address
        serverIp = data.srcIP.split('.');
      }

      self._sendRequestPacket(serverIp);
      return;
    }

    if (packetType.ACK === dhcpResponse.messageType) {
      if (self.success) {
        self.success(dhcpResponse);
      }

      return;
    }
  };

  DHCPClient.prototype._onError = function(err) {
    if (!(this instanceof DHCPClient)) {
      throw new Error('instanceof check failed');
    }

    var self = this;
    if (self.failed) {
      self.failed(err);
    }
  }

  /**
   * Start DHCP service
   */
  DHCPClient.prototype.start = function() {
    if (!(this instanceof DHCPClient)) {
      throw new Error('instanceof check failed');
    }

    var self = this;

    if (self.enabled) {
      return;
    }

    self.enabled = true;
    netSocket.udpSocketApi.createSocket(
      function(data) { self._onMessage(data) },
      function(err) { self._onError(err) }
    )
      .then(function(socket) {
        self.socket = socket;
        return socket.bind(68);
      })
      .then(function(socket) {
        self._sendDiscoverPacket();
      })
      .catch(function(err) { self._onError(err) });
  };

  return {
    DHCPClient: DHCPClient,
  };
});
