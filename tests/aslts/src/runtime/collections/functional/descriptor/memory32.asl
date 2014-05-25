/*
 * Some or all of this work - Copyright (c) 2006 - 2014, Intel Corp.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * Neither the name of Intel Corporation nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * Resource Descriptor macros
 *
 * Memory32() Memory Resource Descriptor Macro
 */

Name (p412, Package() {
	ResourceTemplate () {
		Memory32 (ReadOnly, 0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff)
	},
	ResourceTemplate () {
		Memory32 (ReadWrite, 0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff)
	},
	ResourceTemplate () {
		Memory32 ( , 0, 0, 0, 0)
	},
})

/*
ACPI Specification, Revision 3.0, September 2, 2004
6.4.3.3   32-Bit Memory Range Descriptor

32-Bit Memory Range Descriptor layout:

Byte 0 (Tag Bits): Value = 10000101B (0x85) (Type = 1, Large item name = 0x5)
Byte 1 (Length, bits[7:0]): Value = 00010001B (17)
Byte 2 (Length, bits[15:8]): Value = 00000000B (0)
Byte 3 (Information):
	Bit[7:1]	Ignored
	Bit[0]		Write status, _RW
			1	writeable (read/write)
			0	non-writeable (read-only)
Byte 4 (Range minimum base address, _MIN, bits[7:0])
Byte 5 (Range minimum base address, _MIN, bits[15:8]
Byte 6 (Range minimum base address, _MIN, bits[23:16])
Byte 7 (Range minimum base address, _MIN, bits[31:24])
Byte 8 (Range maximum base address, _MAX, bits[7:0])
Byte 9 (Range maximum base address, _MAX, bits[15:8])
Byte 10 (Range maximum base address, _MAX, bits[23:16])
Byte 11 (Range maximum base address, _MAX, bits[31:24])
Byte 12 (Base alignment, _ALN bits[7:0])
Byte 13 (Base alignment, _ALN bits[15:8])
Byte 14 (Base alignment, _ALN bits[23:16])
Byte 15 (Base alignment, _ALN bits[31:24])
Byte 16 (Range length, _LEN bits[7:0])
Byte 17 (Range length, _LEN, bits[15:8])
Byte 18 (Range length, _LEN, bits[23:16])
Byte 19 (Range length, _LEN, bits[31:24])
*/

Name (p413, Package() {
	Buffer () {0x85, 0x11, 0x00, 0x00,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x85, 0x11, 0x00, 0x01,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x85, 0x11, 0x00, 0x01,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x79, 0x00},
})

Method(RT0a,, Serialized)
{
	Name(ts, "RT0a")

	// Emit test header, set the filename

	THDR (ts, "Memory32 Resource Descriptor Macro", __FILE__)

    // Main test case for packages above

	m330(ts, 3, "p412", p412, p413)

    // Check resource descriptor tag offsets

	Store (
		ResourceTemplate () {
			Memory32 (ReadOnly, 0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff, M320)
			Memory32 (ReadOnly, 0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff, M321)
		}, Local0)

	m331(ts, 1, M320._RW,  0x18, M321._RW,  0xB8, "_RW")
	m331(ts, 2, M320._MIN, 0x20, M321._MIN, 0xC0, "_MIN")
	m331(ts, 3, M320._MAX, 0x40, M321._MAX, 0xE0, "_MAX")
	m331(ts, 4, M320._ALN, 0x60, M321._ALN, 0x0100, "_ALN")
	m331(ts, 5, M320._LEN, 0x80, M321._LEN, 0x0120, "_LEN")
}
