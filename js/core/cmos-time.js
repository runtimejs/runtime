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

// Using code adapted and modified from http://wiki.osdev.org/CMOS#Reading_All_RTC_Time_and_Date_Registers
// OSDev's disclaimer: http://wiki.osdev.org/OSDev_Wiki:General_disclaimer

'use strict';

var resources = require('./resources');
var ports = resources.ioRange;

var second = 0;
var minute = 0;
var hour = 0;
var day = 0;
var month = 0;
var year = 0;

var cmosAddress = 0x70;
var cmosData = 0x71;

var port = ports.port(cmosAddress);
var dataPort = ports.port(cmosData);

function getUpdateInProgressFlag() {
  port.write8(0x0A);
  return (dataPort.read8() & 0x80);
}

function getRTCRegister(reg) {
  port.write8(reg);
  return dataPort.read8();
}

// set the time:

var lastSecond = 0;
var lastMinute = 0;
var lastHour = 0;
var lastDay = 0;
var lastMonth = 0;
var lastYear = 0;
var registerB = 0;

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

var utc = Date.UTC(year, month - 1, day, hour, minute, second, 0);
resources.natives.setTime(utc * 1000);
