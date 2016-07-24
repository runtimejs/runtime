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

// Using code adapted and modified from http://wiki.osdev.org/CMOS#Reading_All_RTC_Time_and_Date_Registers
// OSDev's disclaimer: http://wiki.osdev.org/OSDev_Wiki:General_disclaimer

'use strict';

const resources = require('./resources');
const ports = resources.ioRange;

let second = 0;
let minute = 0;
let hour = 0;
let day = 0;
let month = 0;
let year = 0;

const cmosAddress = 0x70;
const cmosData = 0x71;

const port = ports.port(cmosAddress);
const dataPort = ports.port(cmosData);

function getUpdateInProgressFlag() {
  port.write8(0x0A);
  return (dataPort.read8() & 0x80);
}

function getRTCRegister(reg) {
  port.write8(reg);
  return dataPort.read8();
}

// set the time:

let lastSecond = 0;
let lastMinute = 0;
let lastHour = 0;
let lastDay = 0;
let lastMonth = 0;
let lastYear = 0;
let registerB = 0;

while (getUpdateInProgressFlag()) {
  second = getRTCRegister(0x00);
  minute = getRTCRegister(0x02);
  hour = getRTCRegister(0x04);
  day = getRTCRegister(0x07);
  month = getRTCRegister(0x08);
  year = getRTCRegister(0x09);
}

do {
  lastSecond = second;
  lastMinute = minute;
  lastHour = hour;
  lastDay = day;
  lastMonth = month;
  lastYear = year;

  while (getUpdateInProgressFlag());
  second = getRTCRegister(0x00);
  minute = getRTCRegister(0x02);
  hour = getRTCRegister(0x04);
  day = getRTCRegister(0x07);
  month = getRTCRegister(0x08);
  year = getRTCRegister(0x09);
} while ((lastSecond !== second) || (lastMinute !== minute) || (lastHour !== hour) ||
  (lastDay !== day) || (lastMonth !== month) || (lastYear !== year));

registerB = getRTCRegister(0x0B);

if (!(registerB & 0x04)) {
  second = (second & 0x0F) + ((second >>> 4) * 10);
  minute = (minute & 0x0F) + ((minute >>> 4) * 10);
  hour = ((hour & 0x0F) + (((hour & 0x70) >>> 4) * 10)) | (hour & 0x80);
  day = (day & 0x0F) + ((day >>> 4) * 10);
  month = (month & 0x0F) + ((month >>> 4) * 10);
  year = (year & 0x0F) + ((year >>> 4) * 10);
}

year = year + 2000;

const utc = Date.UTC(year, month - 1, day, hour, minute, second, 0);
__SYSCALL.setTime(utc * 1000);
