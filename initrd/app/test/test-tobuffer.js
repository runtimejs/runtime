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

var expect = require('./lib/expect');

// ASCII subset of UTF-8 only
function compareCharcodes(ab, str) {
    var u8 = new Uint8Array(ab);
    for (var i = 0; i < str.length; ++i) {
        expect(u8[i]).to.equal(str.charCodeAt(i));
    }
}

function testNullTerminate(str) {
    var ab = runtime.toBuffer(str, true);
    expect(ab.byteLength).to.equal(str.length + 1);
    compareCharcodes(ab, str);
}

function testNoNullTerminate(str) {
    var ab = runtime.toBuffer(str);
    expect(ab.byteLength).to.equal(str.length)
    compareCharcodes(ab, str);
}

testNullTerminate('hello');
testNoNullTerminate('hello');
