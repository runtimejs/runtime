// Copyright 2015 Runtime.JS project authors
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

var icmpType = {
  echoRequest: 8
};

var kHeaderLen = 8;

exports.recv = function(intf, ip4Header, reader) {
  var dataLength = reader.len - reader.offset - kHeaderLen;
  var buf = reader.buf;

  if (dataLength < 0) {
    console.log('[icmp] invalid packet size');
    return;
  }

  var type = reader.readUint8();
  var code = reader.readUint8();
  var cksum = reader.readUint16();

  if (type === icmpType.echoRequest) {
    var echoId = reader.readUint16();
    var echoSeq = reader.readUint16();
  }

}
