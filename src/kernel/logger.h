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

#pragma once

#include <kernel/kernel.h>
#include <printf.h>
#include <kernel/spinlock.h>
#include <stdarg.h>
#include <memory>
#include <array>

// No memory allocation allowed in this file. This is part of boot
// services, runs before memory manager initialization.

namespace rt {

enum class LogDataType {
    DEFAULT,
    DBG,
    ERR,
    SNAPSHOT
};

enum class LoggerMode {
    SILENT,
    VIDEO,
    CONSOLE,
    VIDEOANDCONSOLE,
    SNAPSHOT,
    TEST
};

class LogWriter {
public:
    virtual void WriteChar(LogDataType type, char c) = 0;
    void Lock() { Spinlock(lock_).lock(); }
    void Unlock() { Spinlock(lock_).unlock(); }
private:
    Locker lock_;
};

class LogWriterSerial : public LogWriter {
public:
    LogWriterSerial();
    void WriteChar(LogDataType type, char c);
};

class LogWriterVideo : public LogWriter {
public:
    LogWriterVideo();
    void WriteChar(LogDataType type, char c);
private:
    static const uint32_t kWidth = 80;
    static const uint32_t kHeight = 25;
    static const uint8_t kClearColor = 0x0F;
    static const uintptr_t kVideo = 0xb8000;

    uint8_t display_buf_[kWidth * kHeight * 2];
    uint8_t attribute_;
    uint32_t cursor_x_;
    uint32_t cursor_y_;

    void NewLine();
    void PutChar(char c, uint8_t color, uint32_t x, uint32_t y);
};

void putp_printer(void* p, char c, size_t offset);

class Logger {
    friend class BootServices;
    friend class LoggerPrinter;
    friend void putp_printer(void* p, char c, size_t offset);
public:
    int Printf(LogDataType type, const char* fmt, ...) {
        va_list va;
        va_start(va, fmt);
        int count = PrintFormat(type, fmt, va);
        va_end(va);
        return count;
    }

    int VPrintf(LogDataType type, const char* fmt, va_list va) {
        return PrintFormat(type, fmt, va);
    }

    void SetMode(LoggerMode mode) {
        mode_ = mode;
    }

    void PutCharSnapshot(char c) {
        RT_ASSERT(!console_enabled_);
        serial_writer_.Lock();
        serial_writer_.WriteChar(LogDataType::SNAPSHOT, c);
        serial_writer_.Unlock();
    }

    void __tmp_Lock() {
        video_writer_.Lock();
    }
    void __tmp_Unlock() {
        video_writer_.Unlock();
    }
    void __tmp_Putch(char c) {
        video_writer_.WriteChar(LogDataType::ERR, c);
    }

    void EnableConsole() {
        console_enabled_ = true;
    }

    void DisableVideo() {
        video_enabled_ = false;
    }
private:
    Logger()
        :	mode_(LoggerMode::VIDEO),
            console_enabled_(false), //false
            video_enabled_(true),
            type_(LogDataType::DEFAULT) { }
    ~Logger() {}

    int PrintFormat(LogDataType type, const char* fmt, va_list va) {
        bool video = video_enabled_;
        bool console = console_enabled_;

        if (video) video_writer_.Lock();
        if (console) serial_writer_.Lock();

        type_ = type;
        int count = tfp_format(this, putp_printer, fmt, va);

        if (console) serial_writer_.Unlock();
        if (video) video_writer_.Unlock();

        return count;
    }

    void PutChar(char c) {
        bool video = video_enabled_;
        bool console = console_enabled_;

        if (video) video_writer_.WriteChar(type_, c);
        if (console) serial_writer_.WriteChar(type_, c);
    }

    LoggerMode mode_;
    bool console_enabled_;
    bool video_enabled_;
    LogWriterVideo video_writer_;
    LogWriterSerial serial_writer_;
    LogDataType type_;
};

} // namespace rt
