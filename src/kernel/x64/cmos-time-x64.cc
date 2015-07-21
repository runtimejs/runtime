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

#include "cmos-time-x64.h"

namespace rt {

CMOSTime::CMOSTime() : second_(0), minute_(0), hour_(0), day_(0), month_(0), year_(0) {}

int CMOSTime::GetUpdateProgressFlag() {
  IoPortsX64::OutB((uint16_t)CMOSTimeRegisters::CMOSAddress, (uint8_t)0x0A);
  return ((int)IoPortsX64::InB((uint16_t)CMOSTimeRegisters::CMOSData) & 0x80);
};

int CMOSTime::GetRTCRegister(int reg) {
  IoPortsX64::OutB((uint16_t)CMOSTimeRegisters::CMOSAddress, (uint8_t)reg);
  return (int)IoPortsX64::InB((uint16_t)CMOSTimeRegisters::CMOSData);
};

uint64_t CMOSTime::GetCurrentMilliseconds()  {
  int last_second;
  int last_minute;
  int last_hour;
  int last_day;
  int last_month;
  int last_year;
  int registerB;

  while (GetUpdateProgressFlag());
  second_ = GetRTCRegister(0x00);
  minute_ = GetRTCRegister(0x02);
  hour_ = GetRTCRegister(0x04);
  day_ = GetRTCRegister(0x07);
  month_ = GetRTCRegister(0x08);
  year_ = GetRTCRegister(0x09);

  do {
    last_second = second_;
    last_minute = minute_;
    last_hour = hour_;
    last_day = day_;
    last_month = month_;
    last_year = year_;

    while (GetUpdateProgressFlag());
    second_ = GetRTCRegister(0x00);
    minute_ = GetRTCRegister(0x02);
    hour_ = GetRTCRegister(0x04);
    day_ = GetRTCRegister(0x07);
    month_ = GetRTCRegister(0x08);
    year_ = GetRTCRegister(0x09);
  } while ((last_second != second_) || (last_minute != minute_) || (last_hour != hour_) ||
           (last_day != day_) || (last_month != month_) || (last_year != year_));

  registerB = GetRTCRegister(0x0B);

  if (!(registerB & 0x04)) {
    second_ = (second_ & 0x0F) + ((second_ / 16) * 10);
    minute_ = (minute_ & 0x0F) + ((minute_ / 16) * 10);
    hour_= ((hour_ & 0x0F) + (((hour_ & 0x70) / 16) * 10)) | (hour_ & 0x80);
    day_ = (day_ & 0x0F) + ((day_ / 16) * 10);
    month_= (month_ & 0x0F) + ((month_ / 16) * 10);
    year_ = (year_ & 0x0F) + ((year_ / 16) * 10);
  }

  // Convert 12 hour clock to 24 hour clock if necessary

  if (!(registerB & 0x02) && (hour_ & 0x80)) {
        hour_ = ((hour_ & 0x7F) + 12) % 24;
  }

  // Get the full year
  year_ = year_ + 2000;

  // Calculate the time since 1970
  uint64_t milli = 0;

  // All to millisecond
  milli = milli + second_ * 1000;
  milli = milli + minute_ * 60000;
  milli = milli + hour_ * 3600000;
  milli = milli + day_ * 8640000;
  milli = milli + month_ * 259200000;
  milli = milli + year_ * 3110400000;

  milli = milli * 229.245;

  return milli;
};

} //namespace rt
