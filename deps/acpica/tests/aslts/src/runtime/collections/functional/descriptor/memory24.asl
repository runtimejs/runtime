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
 * Memory24() Memory Resource Descriptor Macro
 */

Name (p40e, Package() {
	ResourceTemplate () {
		Memory24 (ReadOnly, 0xf0f1, 0xf2f3, 0xf4f5, 0xf6f7)
	},
	ResourceTemplate () {
		Memory24 (ReadWrite, 0xf0f1, 0xf2f3, 0xf4f5, 0xf6f7)
	},
	ResourceTemplate () {
		Memory24 ( , 0, 0, 0, 0)
	},
})

/*
ACPI Specification, Revision 3.0, September 2, 2004
6.4.3.1   24-Bit Memory Range Descriptor

24-Bit Memory Range Descriptor layout:

Byte 0 (Tag Bits): Value = 10000001B (0x81) (Type = 1, Large item name = 0x1)
Byte 1 (Length, bits[7:0]): Value = 00001001B (9)
Byte 2 (Length, bits[15:8]): Value = 00000000B (0)
Byte 3 (Information):
	Bit[7:1]	Ignored
	Bit[0]		Write status, _RW
			1	writeable (read/write)
			0	non-writeable (read-only)
Byte 4 (Range minimum base address, _MIN, bits[7:0]):
	Address bits[15:8] of the minimum base memory address
	for which the card may be configured.
Byte 5 (Range minimum base address, _MIN, bits[15:8]):
	Address bits[23:16] of the minimum base memory address
	for which the card may be configured
Byte 6 (Range maximum base address, _MAX, bits[7:0]):
	Address bits[15:8] of the maximum base memory address
	for which the card may be configured.
Byte 7 (Range maximum base address, _MAX, bits[15:8]):
	Address bits[23:16] of the maximum base memory address
	for which the card may be configured
Byte 8 (Base alignment, _ALN, bits[7:0]):
	This field contains the lower eight bits of the base alignment.
	The base alignment provides the increment for the minimum base
	address. (0x0000 = 64 KB)
Byte 9 (Base alignment, _ALN, bits[15:8]):
	This field contains the upper eight bits of the base alignment.
Byte 10 (Range length, _LEN, bits[7:0]):
	This field contains the lower eight bits of the memory range length.
	The range length provides the length of the memory range in 256 byte blocks.
Byte 11 (Range length, _LEN, bits[15:8]):
	This field contains the upper eight bits of the memory range length.

*/

Name (p40f, Package() {
	Buffer () {0x81, 0x09, 0x00, 0x00, 0xf1, 0xf0, 0xf3, 0xf2, 0xf5, 0xf4, 0xf7, 0xf6, 0x79, 0x00},
	Buffer () {0x81, 0x09, 0x00, 0x01, 0xf1, 0xf0, 0xf3, 0xf2, 0xf5, 0xf4, 0xf7, 0xf6, 0x79, 0x00},
	Buffer () {0x81, 0x09, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x79, 0x00},
})

Method(RT08,, Serialized)
{
	Name(ts, "RT08")

	// Emit test header, set the filename

	THDR (ts, "Memory24 Resource Descriptor Macro", __FILE__)

    // Main test case for packages above

	m330(ts, 3, "p40e", p40e, p40f)

    // Check resource descriptor tag offsets

	Store (
		ResourceTemplate () {
			Memory24 (ReadOnly, 0xf0f1, 0xf2f3, 0xf4f5, 0xf6f7, M240)
			Memory24 (ReadOnly, 0xf0f1, 0xf2f3, 0xf4f5, 0xf6f7, M241)
		}, Local0)

	m331(ts, 1, M240._RW,  0x18, M241._RW,  0x78, "_RW")
	m331(ts, 2, M240._MIN, 0x20, M241._MIN, 0x80, "_MIN")
	m331(ts, 3, M240._MAX, 0x30, M241._MAX, 0x90, "_MAX")
	m331(ts, 4, M240._ALN, 0x40, M241._ALN, 0xA0, "_ALN")
	m331(ts, 5, M240._LEN, 0x50, M241._LEN, 0xB0, "_LEN")
}
