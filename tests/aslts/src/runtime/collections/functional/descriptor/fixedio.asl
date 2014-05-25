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
 * Fixed IO Resource Descriptor Macro
 */

Name (p40a, Package() {
	ResourceTemplate () {
		FixedIO (0x03f1, 0xf2)
	},
	ResourceTemplate () {
		FixedIO (0, 0)
	},
})

/*
ACPI Specification, Revision 3.0, September 2, 2004
6.4.2.6   Fixed Location I/O Port Descriptor

Fixed Location I/O Port Descriptor layout:

Byte 0 (Tag Bits): Value = 01001011B (0x4b)(Type = 0, Small item name = 0x9, Length = 3)

Byte 1 (Range base address, _BAS bits[7:0])
Byte 2 (Range base address, _BAS bits[9:8])

Byte 3 (Range length, _LEN)
*/

Name (p40b, Package() {
	Buffer () {0x4b, 0xf1, 0x03, 0xf2, 0x79, 0x00},
	Buffer () {0x4b, 0x00, 0x00, 0x00, 0x79, 0x00},
})

Method(RT06,, Serialized)
{
	Name(ts, "RT06")

	// Emit test header, set the filename

	THDR (ts, "FixedIO Resource Descriptor Macro", __FILE__)

    // Main test case for packages above

	m330(ts, 2, "p40a", p40a, p40b)

    // Check resource descriptor tag offsets

	Store (
		ResourceTemplate () {
			FixedIO (0x0001, 0xff, FIO0)
			FixedIO (0x0001, 0xff, FIO1)
		}, Local0)

	m331(ts, 1, FIO0._BAS, 0x08, FIO1._BAS, 0x28, "_BAS")
	m331(ts, 2, FIO0._LEN, 0x18, FIO1._LEN, 0x38, "_LEN")
}
