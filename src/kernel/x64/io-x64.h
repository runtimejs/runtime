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

namespace rt {

/**
 * Functions to read and write IO ports
 */
class IoPortsX64 {
public:
    inline static void OutB(uint16_t port, uint8_t value) {
        asm volatile("outb %b0,%w1":: "a"(value), "d"(port));
    }

    inline static void OutW(uint16_t port, uint16_t value) {
        asm volatile("outw %w0,%w1":: "a"(value), "d"(port));
    }

    inline static void OutDW(uint16_t port, uint32_t value) {
        asm volatile("outl %0,%w1":: "a"(value), "Nd"(port));
    }

    inline static uint8_t InB(uint16_t port) {
        uint8_t value;
        asm volatile("inb %w1, %b0": "=a"(value): "d"(port));
        return value;
    }

    inline static uint16_t InW(uint16_t port) {
        uint16_t value;
        asm volatile("inw %w1, %w0": "=a"(value): "d"(port));
        return value;
    }

    inline static uint32_t InDW(uint16_t port) {
        uint32_t value;
        asm volatile("inl %w1, %0": "=a"(value): "Nd"(port));
        return value;
    }

    inline static uint8_t PciReadB(uint8_t bus, uint8_t slot, uint8_t func, uint8_t offset) {
        PciWriteAddr(bus, slot, func, offset);
        return (uint8_t)((InDW(kPciDataPort) >> ((offset & 3) * 8)) & 0xff);
    }

    inline static uint16_t PciReadW(uint8_t bus, uint8_t slot, uint8_t func, uint8_t offset) {
        RT_ASSERT((offset & 1) == 0); // aligned check
        PciWriteAddr(bus, slot, func, offset);
        return (uint16_t)((InDW(kPciDataPort) >> ((offset & 2) * 8)) & 0xffff);
    }

    inline static uint32_t PciReadDW(uint8_t bus, uint8_t slot, uint8_t func, uint8_t offset) {
        RT_ASSERT((offset & 3) == 0); // aligned check
        PciWriteAddr(bus, slot, func, offset);
        return (uint32_t)InDW(kPciDataPort);
    }

    inline static void PciWriteB(uint8_t bus, uint8_t slot, uint8_t func, uint8_t offset, uint8_t value) {
        PciWriteAddr(bus, slot, func, offset);
        OutB(kPciDataPort + (offset & 3), value);
    }

    inline static void PciWriteW(uint8_t bus, uint8_t slot, uint8_t func, uint8_t offset, uint16_t value) {
        RT_ASSERT((offset & 1) == 0); // aligned check
        PciWriteAddr(bus, slot, func, offset);
        OutW(kPciDataPort + (offset & 2), value);
    }

    inline static void PciWriteDW(uint8_t bus, uint8_t slot, uint8_t func, uint8_t offset, uint32_t value) {
        RT_ASSERT((offset & 3) == 0); // aligned check
        PciWriteAddr(bus, slot, func, offset);
        OutDW(kPciDataPort, value);
    }
private:
    static const uint32_t kPciAddressPort = 0xCF8;
    static const uint32_t kPciDataPort = 0xCFC;

    static void PciWriteAddr(uint8_t bus, uint8_t slot, uint8_t func, uint8_t offset) {
        RT_ASSERT(slot < 32);
        RT_ASSERT(func < 8);
        uint32_t addr = (uint32_t)(((uint32_t)bus << 16) | ((uint32_t)slot << 11) |
            ((uint32_t)func << 8) | (offset & 0xfc) | ((uint32_t)0x80000000));
        OutDW(kPciAddressPort, addr);
    }
};

/**
 * Serial port output
 */
class SerialPortX64 {
public:
    inline static void Init() {
        port_ = 0x3F8;						  // COM1
        IoPortsX64::OutB(port_ + 1, 0x00);    // Disable all interrupts
        IoPortsX64::OutB(port_ + 3, 0x80);    // Enable DLAB (set baud rate divisor)
        IoPortsX64::OutB(port_ + 0, 0x03);    // Set divisor to 3 (lo byte) 38400 baud
        IoPortsX64::OutB(port_ + 1, 0x00);    //                  (hi byte)
        IoPortsX64::OutB(port_ + 3, 0x03);    // 8 bits, no parity, one stop bit
        IoPortsX64::OutB(port_ + 2, 0xC7);    // Enable FIFO, clear them, with 14-byte threshold
        IoPortsX64::OutB(port_ + 4, 0x0B);    // IRQs enabled, RTS/DSR set
    }

    inline static void WriteByte(char a) {
        write_serial(a);
    }

    inline static int is_transmit_empty() {
       return IoPortsX64::InB(port_ + 5) & 0x20;
    }

    inline static void write_serial(char a) {
       while (is_transmit_empty() == 0);
       IoPortsX64::OutB(port_, a);
    }
private:
    static int port_;
};

} // namespace rt
