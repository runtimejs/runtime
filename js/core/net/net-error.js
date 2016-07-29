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

const errs = [
  'E_NO_INTERFACE',
  'E_INVALID_PORT',
  'E_NO_FREE_PORT',
  'E_ADDRESS_IN_USE',
  'E_NO_ROUTE_TO_HOST',
  'E_TYPEDARRAY_EXPECTED',
  'E_IPADDRESS_EXPECTED',
  'E_INTERFACE_EXPECTED',
  'E_CANNOT_CLOSE',
];

for (const err of errs) {
  exports[err] = new Error(err);
}
