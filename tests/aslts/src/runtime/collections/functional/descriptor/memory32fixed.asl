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
 * Memory32Fixed() Memory Resource Descriptor Macro
 */

Name (p414, Package() {
	ResourceTemplate () {
		Memory32Fixed (ReadOnly, 0xf0f1f2f3, 0xf4f5f6f7)
	},
	ResourceTemplate () {
		Memory32Fixed (ReadWrite, 0xf0f1f2f3, 0xf4f5f6f7)
	},
	ResourceTemplate () {
		Memory32Fixed ( , 0, 0)
	},
})

/*
ACPI Specification, Revision 3.0, September 2, 2004
6.4.3.4   32-Bit Fixed Memory Range Descriptor

32-Bit Fixed Memory Range Descriptor layout:

Byte 0 (Tag Bits): Value = 10000110B (0x86) (Type = 1, Large item name = 6)
Byte 1 (Length, bits[7:0]): Value = 00001001B (9)
Byte 2 (Length, bits[15:8]): Value = 00000000B (0)
Byte 3 (Information):
	Bit[7:1]	Ignored
	Bit[0]		Write status, _RW
			1	writeable (read/write)
			0	non-writeable (read-only)
Byte 4 (Range base address, _BAS, bits[7:0])
Byte 5 (Range base address, _BAS, bits[15:8])
Byte 6 (Range base address, _BAS, bits[23:16])
Byte 7 (Range base address, _BAS, bits[31:24])
Byte 8 (Range length, _LEN bits[7:0])
Byte 9 (Range length, _LEN, bits[15:8])
Byte 10 (Range length, _LEN, bits[23:16])
Byte 11 (Range length, _LEN, bits[31:24])
*/

Name (p415, Package() {
	Buffer () {0x86, 0x09, 0x00, 0x00,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4, 0x79, 0x00},
	Buffer () {0x86, 0x09, 0x00, 0x01,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4, 0x79, 0x00},
	Buffer () {0x86, 0x09, 0x00, 0x01,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x79, 0x00},
})

Method(RT0b,, Serialized)
{
	Name(ts, "RT0b")

	// Emit test header, set the filename

	THDR (ts, "Memory32Fixed Resource Descriptor Macro", __FILE__)

    // Main test case for packages above

	m330(ts, 3, "p414", p414, p415)

    // Check resource descriptor tag offsets

	Store (
		ResourceTemplate () {
			Memory32Fixed (ReadOnly, 0xf0f1f2f3, 0xf4f5f6f7, M3F0)
			Memory32Fixed (ReadOnly, 0xf0f1f2f3, 0xf4f5f6f7, M3F1)
		}, Local0)

	m331(ts, 1, M3F0._RW,  0x18, M3F1._RW,  0x78, "_RW")
	m331(ts, 2, M3F0._BAS, 0x20, M3F1._BAS, 0x80, "_BAS")
	m331(ts, 3, M3F0._LEN, 0x40, M3F1._LEN, 0xA0, "_LEN")
}
