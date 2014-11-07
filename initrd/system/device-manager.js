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

define('deviceManager', ['kernelLoader'],
function(kernelLoader) {
  "use strict";

  /**
   * TODO: move drivers out of the kernel
   */
  kernelLoader.load('/system/driver/ps2kbd.js');
  kernelLoader.load('/driver/pci.js');
  kernelLoader.load('/driver/pci-drivers.js');

  return {};
});
