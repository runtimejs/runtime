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

(function(args) {
    rt.log('net service welcomes you');

    args.fn(1,2,3,[10,20,30]).then(function(val) {
        rt.log('fn returns resolve', val);
    }, function(val) {
        rt.log('fn returns reject', val);
    });
})(rt.args());
