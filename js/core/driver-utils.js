// Copyright 2014-present runtime.js project authors
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

'use strict';
const resources = require('./resources');

exports.physicalMemory = (address, byteLength) => resources.memoryRange.block(address >>> 0, byteLength >>> 0); // eslint-disable-line max-len
exports.irq = number => resources.irqRange.irq(number >>> 0);
exports.ioPort = number => resources.ioRange.port(number >>> 0);
