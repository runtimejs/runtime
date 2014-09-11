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

function PacketReader(buf, len, offset) {
    this.buf = buf;
    this.len = len || buf.byteLength;
    this.offset = offset || 0;
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

PacketReader.prototype.readUint32 = function() {
    var value = this.view.getUint32(this.offset, false);
    this.offset += 4;
    return value;
}

PacketReader.prototype.getOffset = function() {
    return this.offset;
};

PacketReader.prototype.setOffset = function(offset) {
    this.offset = offset;
};

function DNSClient() {
    this.socket = null;
    this.randomId = 0x3322;
    this.requests = new Map();
}

DNSClient.prototype._createDNSQuery = function(hostname) {
    var self = this;
    var bufferLength = 17;
    var i,j;

    var labels = hostname.split('.');
    for (i = 0; i < labels.length; ++i) {
        var label = labels[i];
        bufferLength += label.length + 1;
    }

    var buf = new ArrayBuffer(bufferLength)
    var view = new DataView(buf);

    var requestFlags = 0x0100; // query, standard, not truncated, recursive

    view.setUint16(0, self.randomId, false);
    view.setUint16(2, requestFlags, false);
    view.setUint16(4, 1, false); // 1 question
    view.setUint16(6, 0, false); // 0 answers
    view.setUint16(8, 0, false); // 0 ns records
    view.setUint16(10, 0, false); // 0 additional records

    var offset = 12;

    for (i = 0; i < labels.length; ++i) {
        var label = labels[i];
        view.setUint8(offset++, label.length);
        for (j = 0; j < label.length; ++j) {
            view.setUint8(offset++, label.charCodeAt(j));
        }
    }
    view.setUint8(offset++, 0);

    view.setUint16(offset + 0, 1, false); // Type A query (host address)
    view.setUint16(offset + 2, 1, false); // Query IN (Internet address)
    return buf;
};

var POINTER_VALUE = 0xc0;
function isPointer(value) {
    return (value & POINTER_VALUE) === POINTER_VALUE;
}

function readHostname(reader) {
    var labels = [];

    for (var z = reader.getOffset(); z < reader.len; ++z) {
        var len = reader.readUint8();
        if (0 === len) {
            break;
        }

        if (isPointer(len)) {
            var ptrOffset = ((len - POINTER_VALUE) << 8) + reader.readUint8();
            var pos = reader.getOffset();
            reader.setOffset(ptrOffset);
            labels = labels.concat(readHostname(reader));
            reader.setOffset(pos);
            break;
        } else {
            var label = '';
            for (var i = 0; i < len; ++i) {
                label += String.fromCharCode(reader.readUint8());
            }

            labels.push(label);
        }
    }

    return labels;
}

DNSClient.prototype._parseDNSResponse = function(buf) {
    var self = this;
    var reader = new PacketReader(buf);
    var randomId = reader.readUint16();

    if (randomId != self.randomId) {
        return null;
    }

    var flags = reader.readUint16();
    var questionsCount = reader.readUint16();
    var answersCount = reader.readUint16();
    var nsRecordsCount = reader.readUint16();
    var additionalCount = reader.readUint16();

    if (1 !== questionsCount) {
        return null;
    }

    // Read question
    var hostname = readHostname(reader).join('.');
    reader.readUint16(); // skip type
    reader.readUint16(); // skip class

    var results = [];

    // Read answers
    for (var z = 0; z < answersCount; ++z) {
        var host = readHostname(reader).join('.');

        var recordType = reader.readUint16();
        var recordClass = reader.readUint16();
        var ttl = reader.readUint32();
        var rdLen = reader.readUint16();

        var bytes = [];

        switch (recordType) {
            case 1: // A record
                if (4 !== rdLen) {
                    return null;
                }

                results.push({hostname: host, record: 'A', address: [reader.readUint8(), reader.readUint8(),
                    reader.readUint8(), reader.readUint8()]});
                break;
            case 5: // CNAME record
                results.push({hostname: host, record: 'CNAME', name: readHostname(reader).join('.')});
                break;
            default:
                for (var b = 0; b < rdLen; ++b) {
                    reader.readUint8();
                }
                break;
        }
    }

    return {
        hostname: hostname,
        results: results,
    };
};

DNSClient.prototype._onMessage = function(data) {
    var self = this;
    var dnsResponse = self._parseDNSResponse(data.buf);
    if (null === dnsResponse) {
        return;
    }

    var hostname = dnsResponse.hostname;
    var results = dnsResponse.results;
    self._setResult(hostname, true, results);
};

DNSClient.prototype._setResult = function(hostname, isResolved, value) {
    var self = this;
    var list = self.requests.get(hostname);
    for (var i = 0; i < list.length; ++i) {
        var elem = list[i];
        elem[isResolved ? 0 : 1](value);
    }

    self.requests.delete(hostname);
};

DNSClient.prototype._onError = function(err) {
    self._setResult(hostname, false, new Error('NETWORK_ERROR'));
};

DNSClient.prototype._getSocket = function() {
    var self = this;
    if (null === self.socket) {
        return isolate.system.udpSocket.createSocket(
            function(data) { self._onMessage(data) },
            function(err) { self._onError(err) }
        )
        .then(function(socket) {
            self.socket = socket;
        });
    }

    return Promise.resolve(self.socket);
};

DNSClient.prototype.resolve = function(hostname) {
    var self = this;

    var fnResolve, fnReject;
    var promise = new Promise(function(resolve, reject) {
        fnResolve = resolve;
        fnReject = reject;
    });

    var list = self.requests.get(hostname);
    if (!list) {
        list = [];
        self.requests.set(hostname, list);
    }

    list.push([fnResolve, fnReject]);

    self._getSocket().then(function(socket) {
        var buf = self._createDNSQuery(hostname);

        setTimeout(function() {
            self._setResult(hostname, false, new Error('TIMEOUT'));
        }, 5000);

        return isolate.system.udpSocket.send(self.socket, '8.8.8.8', 53, buf);
    }).catch(function(err) {
        self._setResult(hostname, false, new Error('INTERNAL_ERROR'));
    });

    return promise;
};

/**
 * Returns null is string in not a valid hostname
 */
function formatHostname(hostname) {
    if ('string' !== typeof hostname) {
        return null;
    }

    hostname = hostname.trim();
    if (hostname.length > 255) {
        return null;
    }

    var hostnameRegex = /^[a-z0-9.-]+$/;
    if (!hostnameRegex.test(hostname)) {
        return null;
    }

    var labels = hostname.split('.');
    for (var i = 0; i < labels.length; ++i) {
        var label = labels[i];
        if (label.length < 1 || label.length > 63) {
            return null;
        }
    }

    return hostname.toLowerCase();
}

(function() {
    "use strict";

    function printResults(results) {
        if (0 === results.length) {
            console.log('No results.');
        }

        for (var i = 0; i < results.length; ++i) {
            var res = results[i];
            switch (res.record) {
                case 'A': console.log(res.hostname, 'has A:', res.address.join('.')); break;
                case 'CNAME': console.log(res.hostname, 'has CNAME:', res.name); break;
            }
        }

        isolate.exit();
    }

    var command = isolate.data.command;
    if ('string' !== typeof command) {
        return;
    }

    var hostname = formatHostname(command);
    if (!hostname) {
        console.error('host: invalid hostname');
        return;
    }

    var dnsClient = new DNSClient();
    console.log('Lookup ' + hostname + '...');
    dnsClient.resolve(hostname).then(printResults, function(err) {
        switch (err.message) {
            case 'TIMEOUT': console.error('Request timed out'); break;
            case 'NETWORK_ERROR': console.error('Network subsystem error'); break;
            case 'INTERNAL_ERROR': console.error('Internal system error'); break;
            default: console.error(err.message);
        }

        isolate.exit();
    });
})();
