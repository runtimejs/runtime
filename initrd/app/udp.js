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

(function() {
    "use strict";

    function ab2str(buf) {
        return String.fromCharCode.apply(null, new Uint8Array(buf));
    }

    function str2ab(str) {
        var buf = new ArrayBuffer(str.length);
        var bufView = new Uint8Array(buf);
        for (var i = 0, l = str.length; i < l; ++i) {
            bufView[i] = str.charCodeAt(i);
        }

        return buf;
    }

    function onMessage(data) {
        isolate.env.stdout(ab2str(data.buf));
    }

    function onError() {
        isolate.log('error')
    }

    var udpSocketApi = isolate.system.udpSocket;
    var udpSocket = null;

    udpSocketApi.createSocket(onMessage, onError)
        .then(function(socket) {
            udpSocket = socket;
            return udpSocketApi.bindSocket(socket, 9000);
        })
        .then(function(socket) {
            isolate.env.stdout('bind to UDP port 9000\n', {fg: 'lightgreen'});
            return socket;
        })
        .catch(function(err) {
            isolate.log(err.stack);
        });

    function readLine(cb) {
        isolate.env.stdin({
            mode: 'line',
            onData: function(data) {
                cb(data.text);
            }
        });
    }

    readLine(function again(text) {
        if (null === udpSocket) {
            return;
        }

        var buf = str2ab(text);
        udpSocketApi.send(udpSocket, '127.0.0.1', 9000, buf);
        readLine(again);
    });

})();
