// Copyright 2014-2015 runtime.js project authors
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

var controlKeys = [
/* 0x00 */  0, 'escape', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'backspace', 'tab',
/* 0x10 */  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'enter', 'leftctrl', 0, 0,
/* 0x20 */  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'leftshift', 0, 0, 0, 0, 0,
/* 0x30 */  0, 0, 0, 0, 0, 0, 'rightshift', 0, 'leftalt', 0, 'capslock', 'f1', 'f2', 'f3', 'f4', 'f5',
/* 0x40 */  'f6', 'f7', 'f8', 'f9', 'f10', 'numlock', 'scrllock', 'kphome', 'kpup', 'kppageup', 0, 'kpleft', 'kp5', 'kpright', 0, 'kpend',
/* 0x50 */  'kpdown', 'kppagedown', 'kpinsert', 'kpdel', 'sysreq', 0, 0, 'f11', 'f12', 0, 0, 0, 0, 0, 0, 0,
/* 0x60 */  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
/* 0x70 */  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
/* 0x80 */  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
/* 0x90 */  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'enter', 'rightctrl', 0, 0,
/* 0xA0 */  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
/* 0xB0 */  0, 0, 0, 0, 0, 'kpslash', 0, 'prntscrn', 'rightalt', 0, 0, 0, 0, 0, 0, 0,
/* 0xC0 */  0, 0, 0, 0, 0, 0, 0, 'home', 'up', 'pageup', 0, 'left', 0, 'right', 0, 'end',
/* 0xD0 */  'down', 'pagedown', 'insert', 'del', 0, 0, 0, 0, 0, 0, 0, 'leftsup', 'rightsup', 'menu', 0, 0,
/* 0xE0 */  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
/* 0xF0 */  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
];

var keymapNormal = [
  '', '', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '', '\t',
  'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n', '', 'a', 's',
  'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`', '', '\\', 'z', 'x', 'c', 'v',
  'b', 'n', 'm', ',', '.', '/', '', '', '', ' ', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
  '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''
];

var keymapShift = [
  '', '', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '', '\t',
  'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '\n', '', 'A', 'S',
  'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"', '~', '', '|', 'Z', 'X', 'C', 'V',
  'B', 'N', 'M', '<', '>', '?', '', '', '', ' ', '', '', '', '', '', '', '', '', '', '',
  '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''
];

var keymapCaps = [
  '', '', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '', '\t',
  'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '[', ']', '\n', '', 'A', 'S',
  'D', 'F', 'G', 'H', 'J', 'K', 'L', ';', '\'', '`', '', '\\', 'Z', 'X', 'C', 'V',
  'B', 'N', 'M', ',', '.', '/', '', '', '', ' ', '', '', '', '', '', '', '', '', '', '',
  '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''
];

var statuses = {
  leftshift: false,
  rightshift: false,
  leftctrl: false,
  rightctrl: false,
  leftalt: false,
  rightalt: false,
  capslock: false,
  numlock: false,
  scrllock: false,
};

function keyEvent(code, isPressed) {
  var cmd = controlKeys[code & 0xFF];
  var character = '';
  code &= 0x7F;

  if (0 === cmd) {
    cmd = controlKeys[code];
  }

  if (0 === cmd) {
    cmd = 'character';
    if (statuses.leftshift || statuses.rightshift) {
      character = keymapShift[code];
    } else {
      if (statuses.capslock) {
        character = keymapCaps[code];
      } else {
        character = keymapNormal[code];
      }
    }
  } else {
    switch (cmd) {
    case 'leftalt':
      statuses.leftalt = isPressed;
      break;
    case 'rightalt':
      statuses.rightalt = isPressed;
      break;
    case 'leftctrl':
      statuses.leftctrl = isPressed;
      break;
    case 'rightctrl':
      statuses.rightctrl = isPressed;
      break;
    case 'leftshift':
      statuses.leftshift = isPressed;
      break;
    case 'rightshift':
      statuses.rightshift = isPressed;
      break;
    case 'capslock':
      if (isPressed) statuses.capslock = !statuses.capslock;
      break;
    case 'numlock':
      if (isPressed) statuses.numlock = !statuses.numlock;
      break;
    case 'scrllock':
      if (isPressed) statuses.scrllock = !statuses.scrllock;
      break;
    }
  }

  var event = {
    type: cmd,
    character: character,
    altKey: (statuses.leftalt || statuses.rightalt),
    shiftKey: statuses.leftshift || statuses.rightshift,
    ctrlKey: statuses.leftctrl || statuses.rightctrl,
    // TODO: Figure out if this makes sense to support
    metaKey: false
  };

  if (isPressed) {
    runtime.keyboard.onkeydown.dispatch(event);
  } else {
    runtime.keyboard.onkeyup.dispatch(event);
  }
}

var driver = {
  init: function(device) {
    var irq = device.irq;
    var port = device.ioPort;

    function init() {
      var v1 = port.read8();
      var v2 = 0;
      while (v1 !== v2) {
        v2 = v1;
        v1 = port.read8();
      }
    }

    var escaped = false;

    irq.on(function() {
      var code = port.read8();

      if (0xe0 === code) {
        escaped = true;
      } else {
        if (code & 0x80) {
          if (escaped) {
            keyEvent(code, false);
          } else {
            keyEvent(code & 0x7f, false);
          }
        } else {
          if (escaped) {
            keyEvent(code | 0x80, true);
          } else {
            keyEvent(code, true);
          }
        }
      }

      escaped = false;
    });

    init();
  },
  reset: function() {}
};

runtime.ps2.setKeyboardDriver(driver);
