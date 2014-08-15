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

    var foo = require('test-modules/module1').foo;
    var foo2 = require('test-modules/module1').foo;
    console.log(foo());
    console.log(foo2());

    var bar = require('test-modules/module2').bar;
    console.log(bar('world'));

    var baz = require('test-modules/module3')();
    console.log(baz);
})();
