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

    var udpSocketApi = isolate.system.udpSocket;
    var udpSocket = null;

    var version = kernel.version();

    function onMessage(data) {
        var str = runtime.bufferToString(data.buf);

        if (str.length > 1) {
            isolate.env.stdout('message from ');
            isolate.env.stdout(data.address + ' ', {fg: 'yellow'});
            isolate.env.stdout(str, {fg: 'green'});
        }

        var lines = [
            '======================================================================',
            'Hello! This is Runtime.JS version ' + version.runtime.join('.') + ' on V8 ' + version.v8,
            '\n',
            'Your IP: ' + data.address,
            'Source port: ' + data.port,
            'Boot time: ' + (Date.now() / 1000) + 's',
            'Your message: ' + str.replace('\n', ''),
            '\n'
        ];

        var message = lines.join('\n');

        var buf = runtime.toBuffer(message);
        udpSocket.send(data.address, data.port, buf);
    }

    function onError() {
        isolate.log('error')
    }

    udpSocketApi.createSocket(onMessage, onError)
        .then(function(socket) {
            udpSocket = socket;
            return socket.bind(9000);
        })
        .then(function(socket) {
            isolate.env.stdout('listening to UDP port 9000\n', {fg: 'lightgreen'});
            return socket;
        })
        .catch(function(err) {
            isolate.log(err.stack);
        });
})();
