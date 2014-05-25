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
 * Short Vendor Resource Descriptor
 */

Name (p40c, Package() {
	ResourceTemplate () {
		VendorShort () {}
	},
	ResourceTemplate () {
		VendorShort () {0xf1}
	},
	ResourceTemplate () {
		VendorShort () {0xe1, 0xf2}
	},
	ResourceTemplate () {
		VendorShort () {0xd1, 0xe2, 0xf3}
	},
	ResourceTemplate () {
		VendorShort () {0x00, 0xd2, 0xe3, 0xf4}
	},
	ResourceTemplate () {
		VendorShort () {0xb1, 0xc2, 0x00, 0xe4, 0xf5}
	},
	ResourceTemplate () {
		VendorShort () {0xa1, 0xb2, 0xc3, 0xd4, 0xe5, 0xf6}
	},
	ResourceTemplate () {
		VendorShort () {0x00, 0xa2, 0xb3, 0x76, 0xd5, 0xe6, 0xf7}
	},
})

/*
ACPI Specification, Revision 3.0, September 2, 2004
6.4.2.7   Vendor-Defined Descriptor

Vendor-Defined Descriptor layout:

Byte 0 (Tag Bits): Value = 01110nnnB (0x71-0x77)(Type = 0, small item name = 0xE, length = (1-7))

Byte 1 to 7 - Vendor defined
*/

Name (p40d, Package() {
	Buffer () {0x70, 0x79, 0x00},
	Buffer () {0x71, 0xf1, 0x79, 0x00},
	Buffer () {0x72, 0xe1, 0xf2, 0x79, 0x00},
	Buffer () {0x73, 0xd1, 0xe2, 0xf3, 0x79, 0x00},
	Buffer () {0x74, 0x00, 0xd2, 0xe3, 0xf4, 0x79, 0x00},
	Buffer () {0x75, 0xb1, 0xc2, 0x00, 0xe4, 0xf5, 0x79, 0x00},
	Buffer () {0x76, 0xa1, 0xb2, 0xc3, 0xd4, 0xe5, 0xf6, 0x79, 0x00},
	Buffer () {0x77, 0x00, 0xa2, 0xb3, 0x76, 0xd5, 0xe6, 0xf7, 0x79, 0x00},
})

Method(RT07,, Serialized)
{
	Name(ts, "RT07")

	// Emit test header, set the filename

	THDR (ts, "Short Vendor Resource Descriptor Macro", __FILE__)

    // Main test case for packages above

	m330(ts, 8, "p40c", p40c, p40d)
}
