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

#include "logger.h"
#include <kernel/utils.h>

// TODO: remove arch header
#include <kernel/x64/io-x64.h>

namespace rt {

LogWriterSerial::LogWriterSerial() {
  SerialPortX64::Init();
}

void LogWriterSerial::WriteChar(LogDataType type, char c) {
  SerialPortX64::WriteByte(c);
}

LogWriterVideo::LogWriterVideo()
  :	attribute_(0x0F),
    cursor_x_(0),
    cursor_y_(0) {
  // Hide cursor (X64)
  IoPortsX64::OutB(0x3d4, 0x0e);
  IoPortsX64::OutB(0x3d5, 0xff);
  IoPortsX64::OutB(0x3d4, 0x0f);
  IoPortsX64::OutB(0x3d5, 0xff);

  // Clean screen
  uint16_t blank = 0x20 | (kClearColor << 8);
  Utils::Memset16(display_buf_, blank, kWidth * kHeight);
  Utils::Memset16(reinterpret_cast<uint8_t*>(kVideo),
                  blank, kWidth * kHeight);
}

void LogWriterVideo::WriteChar(LogDataType type, char c) {
  switch (type) {
  case LogDataType::DBG:
    attribute_ = 0x0A;
    break;
  case LogDataType::ERR:
    attribute_ = 0x4F;
    break;
  case LogDataType::DEFAULT:
    attribute_ = 0x0F;
  default:
    break;
  }

  switch (c) {
  case '\n':
    NewLine();
    break;
  case '\t':
    cursor_x_ += 4;
    break;
  default:
    PutChar(c, attribute_, cursor_x_++, cursor_y_);
    break;
  }

  if (cursor_x_ >= kWidth) {
    NewLine();
  }
}

void LogWriterVideo::NewLine() {
  cursor_x_ = 0;
  ++cursor_y_;
  if (cursor_y_ >= kHeight) {
    uint16_t blank = 0x20 | (kClearColor << 8);
    memmove(display_buf_, display_buf_ + kWidth * 2, kWidth * (kHeight - 1) * 2);
    Utils::Memset16(display_buf_ + kWidth * (kHeight - 1) * 2, blank, kWidth);
    memcpy(reinterpret_cast<uint8_t*>(kVideo), display_buf_, kWidth * kHeight * 2);
    --cursor_y_;
  }
}

void LogWriterVideo::PutChar(char c, uint8_t color, uint32_t x, uint32_t y) {
  uint8_t* video = reinterpret_cast<uint8_t*>(kVideo);
  display_buf_[(y * kWidth + x) * 2] = c;
  display_buf_[(y * kWidth + x) * 2 + 1] = color;
  *(video + (y * kWidth + x) * 2) = static_cast<uint8_t>(c);
  *(video + (y * kWidth + x) * 2 + 1) = color;
}

void putp_printer(void* p, char c, size_t offset) {
  RT_ASSERT(p);
  Logger* prt = reinterpret_cast<Logger*>(p);
  prt->PutChar(c);
}

} // namespace rt

