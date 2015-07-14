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

// Using code adapted from http://wiki.osdev.org/CMOS#Reading_All_RTC_Time_and_Date_Registers
// OSDev disclaimer: http://wiki.osdev.org/OSDev_Wiki:General_disclaimer

#include "cmos-time.h"
#include <stdio.h>

namespace rt {

int CMOSTime::GetUpdateProgressFlag() {
  IoPortsX64::OutB((uint16_t)CMOSTimeRegisters::CMOSAddress, (uint8_t)0x0A);
  return ((int)IoPortsX64::InB((uint16_t)CMOSTimeRegisters::CMOSData) & 0x80);
};

int CMOSTime::GetRTCRegister(int reg) {
  IoPortsX64::OutB((uint16_t)CMOSTimeRegisters::CMOSAddress, (uint8_t)reg);
  return (int)IoPortsX64::InB((uint16_t)CMOSTimeRegisters::CMOSData);
};

uint64_t CMOSTime::GetCurrentMilliseconds()  {
  int century;
  int last_second;
  int last_minute;
  int last_hour;
  int last_day;
  int last_month;
  int last_year;
  int last_century;
  int registerB;

  while (GetUpdateProgressFlag());
  second = GetRTCRegister(0x00);
  minute = GetRTCRegister(0x02);
  hour = GetRTCRegister(0x04);
  day = GetRTCRegister(0x07);
  month = GetRTCRegister(0x08);
  year = GetRTCRegister(0x09);

  century = GetRTCRegister(century_register);

  do {
    last_second = second;
    last_minute = minute;
    last_hour = hour;
    last_day = day;
    last_month = month;
    last_year = year;
    last_century = century;

    while (GetUpdateProgressFlag());
    second = GetRTCRegister(0x00);
    minute = GetRTCRegister(0x02);
    hour = GetRTCRegister(0x04);
    day = GetRTCRegister(0x07);
    month = GetRTCRegister(0x08);
    year = GetRTCRegister(0x09);
    century = GetRTCRegister(century_register);
  } while ((last_second != second) || (last_minute != minute) || (last_hour != hour) ||
           (last_day != day) || (last_month != month) || (last_year != year) ||
           (last_century != century));

  registerB = GetRTCRegister(0x0B);

  if (!(registerB & 0x04)) {
    second = (second & 0x0F) + ((second / 16) * 10);
    minute = (minute & 0x0F) + ((minute / 16) * 10);
    hour = ( (hour & 0x0F) + (((hour & 0x70) / 16) * 10) ) | (hour & 0x80);
    day = (day & 0x0F) + ((day / 16) * 10);
    month = (month & 0x0F) + ((month / 16) * 10);
    year = (year & 0x0F) + ((year / 16) * 10);
    if (century_register != 0) {
      century = (century & 0x0F) + ((century / 16) * 10);
    }
  }

  // Convert 12 hour clock to 24 hour clock if necessary

  if (!(registerB & 0x02) && (hour & 0x80)) {
        hour = ((hour & 0x7F) + 12) % 24;
  }

  // Calculate the time since 1970
  uint64_t milli = 0;

  milli = milli + second * 1000;
  milli = milli + minute * 60000;
  milli = milli + hour * 3600000;
  milli = milli + day * 8640000;
  milli = milli + month * 259200000;
  milli = milli + year * 3110400000;
  milli = milli + 21 * 3110400000000;

  milli = milli * 21.98300000;

  return milli;
};

} //namespace rt
