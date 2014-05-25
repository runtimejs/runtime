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
 * Long Vendor Resource Descriptor
 */

Name (p410, Package() {
	ResourceTemplate () {
		VendorLong () {0x8f,
			0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
			0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff}
	},
	ResourceTemplate () {
		VendorLong () {0x9f,
			0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
			0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
			0x00, 0x01, 0x02, 0x03}
	},

	ResourceTemplate () {
		VendorLong () {0xaf,
			0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
			0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
			// 257 bytes
			  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
			 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
			 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
			 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
			 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
			 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
			 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,
			113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,
			129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,
			145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,
			161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,
			177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,
			193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,
			209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,
			225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,
			241,242,243,244,245,246,247,248,249,250,251,252,253,254,255, 0, 1}
	},

	// next cases might produce compiler warnings or errors
	ResourceTemplate () {
		VendorLong () {}
	},
	ResourceTemplate () {
		VendorLong () {0xbf}
	},
	ResourceTemplate () {
		VendorLong () {0xcf,
			0xf0}
	},
	ResourceTemplate () {
		VendorLong () {0xdf,
			0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
			0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe}
	},
})

/*
ACPI Specification, Revision 3.0, September 2, 2004
6.4.3.2   Vendor-Defined Descriptor

Large Vendor-Defined Descriptor layout:

Byte 0 (Tag Bits): Value = 10000100B (0X84) (Type = 1, Large item name = 0x4)
Byte 1 (Length, bits[7:0]): Lower eight bits of data length (UUIID & vendor defined data)
Byte 2 (Length, bits[15:8]): Upper eight bits of data length (UUID & vendor defined data)
Byte 3 (UUID specific descriptor sub type): UUID specific descriptor sub type value
Byte 4-19 (UUID): UUID Value
Byte 20-(Length+2) (Vendor Defined Data): Vendor defined data bytes
*/

Name (p411, Package() {
	Buffer () {
		0x84, 0x11, 0x00, 0x8f,
		0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
		0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff, 0x79, 0x00},
	Buffer () {
		0x84, 0x15, 0x00, 0x9f,
		0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
		0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
		0x00, 0x01, 0x02, 0x03, 0x79, 0x00},
	Buffer () {
		0x84, 0x12, 0x01, 0xaf,
		0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
		0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
		// 257 bytes
		  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
		 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
		 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
		 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
		 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
		 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
		 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,
		113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,
		129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,
		145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,
		161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,
		177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,
		193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,
		209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,
		225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,
		241,242,243,244,245,246,247,248,249,250,251,252,253,254,255, 0, 1,
		0x79, 0x00},

	Buffer () {
		0x84, 0x00, 0x00, 0x79, 0x00},
	Buffer () {
		0x84, 0x01, 0x00, 0xbf, 0x79, 0x00},
	Buffer () {
		0x84, 0x02, 0x00, 0xcf,
		0xf0, 0x79, 0x00},
	Buffer () {
		0x84, 0x10, 0x00, 0xdf,
		0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
		0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0x79, 0x00},
})

Method(RT09,, Serialized)
{
	Name(ts, "RT09")

	// Emit test header, set the filename

	THDR (ts, "Long Vendor Resource Descriptor Macro", __FILE__)

    // Main test case for packages above

	m330(ts, 7, "p410", p410, p411)

	// VendorLong has DescriptorName
	// but has not fields in it.

	Store (
		ResourceTemplate () {
			VendorLong (VL00) {0x8f,
			0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
			0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff}
		}, Local0)
}
