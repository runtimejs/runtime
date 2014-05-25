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
 * Interrupt() Interrupt Resource Descriptor Macro
 */

Name(z017, 17)

Name (p434, Package() {

	// Byte 3 (Interrupt Vector Flags) of Extended Interrupt Descriptor

	ResourceTemplate () {
		Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive) {
			0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceProducer, Level, ActiveHigh, Shared) {
			0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceProducer, Level, ActiveLow, Exclusive) {
			0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceProducer, Level, ActiveLow, Shared) {
			0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceProducer, Edge, ActiveHigh, Exclusive) {
			0xecedeeef,
			0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceProducer, Edge, ActiveHigh, Shared) {
			0xe8e9eaeb, 0xecedeeef,
			0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceProducer, Edge, ActiveLow, Exclusive) {
			0xe4e5e6e7, 0xe8e9eaeb, 0xecedeeef,
			0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceProducer, Edge, ActiveLow, Shared) {
			0xe0e1e2e3, 0xe4e5e6e7, 0xe8e9eaeb, 0xecedeeef,
			0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) {
			0xdcdddedf,
			0xe0e1e2e3, 0xe4e5e6e7, 0xe8e9eaeb, 0xecedeeef,
			0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceConsumer, Level, ActiveHigh, Shared) {
			0xd8d9dadb, 0xdcdddedf,
			0xe0e1e2e3, 0xe4e5e6e7, 0xe8e9eaeb, 0xecedeeef,
			0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive) {
			0xd4d5d6d7, 0xd8d9dadb, 0xdcdddedf,
			0xe0e1e2e3, 0xe4e5e6e7, 0xe8e9eaeb, 0xecedeeef,
			0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceConsumer, Level, ActiveLow, Shared) {
			0xd0d1d2d3, 0xd4d5d6d7, 0xd8d9dadb, 0xdcdddedf,
			0xe0e1e2e3, 0xe4e5e6e7, 0xe8e9eaeb, 0xecedeeef,
			0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive) {
			0xcccdcecf,
			0xd0d1d2d3, 0xd4d5d6d7, 0xd8d9dadb, 0xdcdddedf,
			0xe0e1e2e3, 0xe4e5e6e7, 0xe8e9eaeb, 0xecedeeef,
			0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceConsumer, Edge, ActiveHigh, Shared) {
			0xc8c9cacb, 0xcccdcecf,
			0xd0d1d2d3, 0xd4d5d6d7, 0xd8d9dadb, 0xdcdddedf,
			0xe0e1e2e3, 0xe4e5e6e7, 0xe8e9eaeb, 0xecedeeef,
			0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceConsumer, Edge, ActiveLow, Exclusive) {
			0xc4c5c6c7, 0xc8c9cacb, 0xcccdcecf,
			0xd0d1d2d3, 0xd4d5d6d7, 0xd8d9dadb, 0xdcdddedf,
			0xe0e1e2e3, 0xe4e5e6e7, 0xe8e9eaeb, 0xecedeeef,
			0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceConsumer, Edge, ActiveLow, Shared) {
			0xc0c1c2c3, 0xc4c5c6c7, 0xc8c9cacb, 0xcccdcecf,
			0xd0d1d2d3, 0xd4d5d6d7, 0xd8d9dadb, 0xdcdddedf,
			0xe0e1e2e3, 0xe4e5e6e7, 0xe8e9eaeb, 0xecedeeef,
			0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff}
	},

	ResourceTemplate () {
		Interrupt (ResourceConsumer, Edge, ActiveLow, Shared) {
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
			241,242,243,244,245,246,247,248,249,250,251,252,253,254,255}
	},

	// Resource Source

	ResourceTemplate () {
		Interrupt (ResourceConsumer, Edge, ActiveLow, Shared,
			0x01, "") {0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceConsumer, Edge, ActiveLow, Shared,
			0x0f, "P") {0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceConsumer, Edge, ActiveLow, Shared,
			0xf0, "PATH") {0xfcfdfeff}
	},
	ResourceTemplate () {
		Interrupt (ResourceConsumer, Edge, ActiveLow, Shared,
			0xff,
			"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"
			) {0xfcfdfeff}
	},

	// Particular cases

	ResourceTemplate () {
		Interrupt (ResourceConsumer, Edge, ActiveLow, Shared,
			0xff,
			"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
			INT0) {
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
			241,242,243,244,245,246,247,248,249,250,251,252,253,254,255}
	},

	// 20051021, relaxation for omitted ResourceSource (bug-fix 70 rejection)
	ResourceTemplate () {
		Interrupt (ResourceConsumer, Edge, ActiveLow, Shared,
			0x0f) {0xfcfdfeff}
	},
})

/*
ACPI Specification, Revision 3.0, September 2, 2004
6.4.3.6   Extended Interrupt Descriptor

Extended Interrupt Descriptor layout:

Byte 0	Extended Interrupt Descriptor	Value=10001001B (0x89) (Type = 1, Large item name = 0x9)
Byte 1	Length, bits[7:0]	Variable: Value = 6 (minimum)
Byte 2	Length, bits[15:8]	Variable: Value = 0 (minimum)
Byte 3	Interrupt Vector Flags	Interrupt Vector Information.
	Bit[7:4]	Reserved (must be 0)
	Bit[3]		Interrupt is shareable, _SHR
	Bit[2] 		Interrupt Polarity, _LL
			0	Active-High: This interrupt is sampled
				when the signal is high, or true.
			1	Active-Low: This interrupt is sampled
				when the signal is low, or false.
	Bit[1] 		Interrupt Mode, _HE
			0	Level-Triggered: Interrupt is triggered in response
				to the signal being in either a high or low state.
			1	Edge-Triggered: This interrupt is
				triggered in response to a change in signal
				state, either high to low or low to high.
	Bit[0] 		Consumer/Producer:
			1-This device consumes this resource
		        0-This device produces and consumes this resource

Byte 4	Interrupt table length	Indicates the number of interrupt numbers that follow.
				When this descriptor is returned from _CRS, or when OSPM
				passes this descriptor to _SRS, this field must be set to 1.
Byte 4n+5	Interrupt Number, _INT bits [7:0]	Interrupt number
Byte 4n+6	Interrupt Number, _INT bits [15:8]	
Byte 4n+7	Interrupt Number, _INT bits [23:16]	
Byte 4n+8	Interrupt Number, _INT bits [31:24]	
            Additional interrupt numbers
Byte x	Resource Source Index	(Optional) Only present if Resource Source (below) is present.
				This field gives an index to the specific resource descriptor
				that this device consumes from in the current resource template
				for the device object pointed to in Resource Source.
String	Resource Source	(Optional)  If present, the device that uses this descriptor consumes its
				resources from the resources produces by the named device object.
				If not present, the device consumes its resources out of a global
				pool. If not present, the device consumes this resource from its
				hierarchical parent.
*/

Name (p435, Package() {

	// Byte 3 (Interrupt Vector Flags) of Extended Interrupt Descriptor

	Buffer () {0x89, 0x06, 0x00, 0x00, 0x01,
		0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x0a, 0x00, 0x08, 0x02,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x0e, 0x00, 0x04, 0x03,
		0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x12, 0x00, 0x0c, 0x04,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x16, 0x00, 0x02, 0x05,
		0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x1a, 0x00, 0x0a, 0x06,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x1e, 0x00, 0x06, 0x07,
		0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x22, 0x00, 0x0e, 0x08,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x26, 0x00, 0x01, 0x09,
		0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x2a, 0x00, 0x09, 0x0a,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x2e, 0x00, 0x05, 0x0b,
		0xd7, 0xd6, 0xd5, 0xd4,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x32, 0x00, 0x0d, 0x0c,
		0xd3, 0xd2, 0xd1, 0xd0, 0xd7, 0xd6, 0xd5, 0xd4,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x36, 0x00, 0x03, 0x0d,
		0xcf, 0xce, 0xcd, 0xcc,
		0xd3, 0xd2, 0xd1, 0xd0, 0xd7, 0xd6, 0xd5, 0xd4,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x3a, 0x00, 0x0b, 0x0e,
		0xcb, 0xca, 0xc9, 0xc8, 0xcf, 0xce, 0xcd, 0xcc,
		0xd3, 0xd2, 0xd1, 0xd0, 0xd7, 0xd6, 0xd5, 0xd4,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x3e, 0x00, 0x07, 0x0f,
		0xc7, 0xc6, 0xc5, 0xc4,
		0xcb, 0xca, 0xc9, 0xc8, 0xcf, 0xce, 0xcd, 0xcc,
		0xd3, 0xd2, 0xd1, 0xd0, 0xd7, 0xd6, 0xd5, 0xd4,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},
	Buffer () {0x89, 0x42, 0x00, 0x0f, 0x10,
		0xc3, 0xc2, 0xc1, 0xc0, 0xc7, 0xc6, 0xc5, 0xc4,
		0xcb, 0xca, 0xc9, 0xc8, 0xcf, 0xce, 0xcd, 0xcc,
		0xd3, 0xd2, 0xd1, 0xd0, 0xd7, 0xd6, 0xd5, 0xd4,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00},

	// At the moment returning
	// Buffer () {0x89, 0x06, 0x00, 0x0f, 0x01, 0x00, 0x00, 0x00, 0x00, 0x79, 0x00},

	Buffer () {0x89, 0xfe, 0x03, 0x0f, 0xff,
		  1,  0,  0,  0,  2,  0,  0,  0,  3,  0,  0,  0,  4,  0,  0,  0,
		  5,  0,  0,  0,  6,  0,  0,  0,  7,  0,  0,  0,  8,  0,  0,  0,
		  9,  0,  0,  0, 10,  0,  0,  0, 11,  0,  0,  0, 12,  0,  0,  0,
		 13,  0,  0,  0, 14,  0,  0,  0, 15,  0,  0,  0, 16,  0,  0,  0,
		 17,  0,  0,  0, 18,  0,  0,  0, 19,  0,  0,  0, 20,  0,  0,  0,
		 21,  0,  0,  0, 22,  0,  0,  0, 23,  0,  0,  0, 24,  0,  0,  0,
		 25,  0,  0,  0, 26,  0,  0,  0, 27,  0,  0,  0, 28,  0,  0,  0,
		 29,  0,  0,  0, 30,  0,  0,  0, 31,  0,  0,  0, 32,  0,  0,  0,
		 33,  0,  0,  0, 34,  0,  0,  0, 35,  0,  0,  0, 36,  0,  0,  0,
		 37,  0,  0,  0, 38,  0,  0,  0, 39,  0,  0,  0, 40,  0,  0,  0,
		 41,  0,  0,  0, 42,  0,  0,  0, 43,  0,  0,  0, 44,  0,  0,  0,
		 45,  0,  0,  0, 46,  0,  0,  0, 47,  0,  0,  0, 48,  0,  0,  0,
		 49,  0,  0,  0, 50,  0,  0,  0, 51,  0,  0,  0, 52,  0,  0,  0,
		 53,  0,  0,  0, 54,  0,  0,  0, 55,  0,  0,  0, 56,  0,  0,  0,
		 57,  0,  0,  0, 58,  0,  0,  0, 59,  0,  0,  0, 60,  0,  0,  0,
		 61,  0,  0,  0, 62,  0,  0,  0, 63,  0,  0,  0, 64,  0,  0,  0,
		 65,  0,  0,  0, 66,  0,  0,  0, 67,  0,  0,  0, 68,  0,  0,  0,
		 69,  0,  0,  0, 70,  0,  0,  0, 71,  0,  0,  0, 72,  0,  0,  0,
		 73,  0,  0,  0, 74,  0,  0,  0, 75,  0,  0,  0, 76,  0,  0,  0,
		 77,  0,  0,  0, 78,  0,  0,  0, 79,  0,  0,  0, 80,  0,  0,  0,
		 81,  0,  0,  0, 82,  0,  0,  0, 83,  0,  0,  0, 84,  0,  0,  0,
		 85,  0,  0,  0, 86,  0,  0,  0, 87,  0,  0,  0, 88,  0,  0,  0,
		 89,  0,  0,  0, 90,  0,  0,  0, 91,  0,  0,  0, 92,  0,  0,  0,
		 93,  0,  0,  0, 94,  0,  0,  0, 95,  0,  0,  0, 96,  0,  0,  0,
		 97,  0,  0,  0, 98,  0,  0,  0, 99,  0,  0,  0,100,  0,  0,  0,
		101,  0,  0,  0,102,  0,  0,  0,103,  0,  0,  0,104,  0,  0,  0,
		105,  0,  0,  0,106,  0,  0,  0,107,  0,  0,  0,108,  0,  0,  0,
		109,  0,  0,  0,110,  0,  0,  0,111,  0,  0,  0,112,  0,  0,  0,
		113,  0,  0,  0,114,  0,  0,  0,115,  0,  0,  0,116,  0,  0,  0,
		117,  0,  0,  0,118,  0,  0,  0,119,  0,  0,  0,120,  0,  0,  0,
		121,  0,  0,  0,122,  0,  0,  0,123,  0,  0,  0,124,  0,  0,  0,
		125,  0,  0,  0,126,  0,  0,  0,127,  0,  0,  0,128,  0,  0,  0,
		129,  0,  0,  0,130,  0,  0,  0,131,  0,  0,  0,132,  0,  0,  0,
		133,  0,  0,  0,134,  0,  0,  0,135,  0,  0,  0,136,  0,  0,  0,
		137,  0,  0,  0,138,  0,  0,  0,139,  0,  0,  0,140,  0,  0,  0,
		141,  0,  0,  0,142,  0,  0,  0,143,  0,  0,  0,144,  0,  0,  0,
		145,  0,  0,  0,146,  0,  0,  0,147,  0,  0,  0,148,  0,  0,  0,
		149,  0,  0,  0,150,  0,  0,  0,151,  0,  0,  0,152,  0,  0,  0,
		153,  0,  0,  0,154,  0,  0,  0,155,  0,  0,  0,156,  0,  0,  0,
		157,  0,  0,  0,158,  0,  0,  0,159,  0,  0,  0,160,  0,  0,  0,
		161,  0,  0,  0,162,  0,  0,  0,163,  0,  0,  0,164,  0,  0,  0,
		165,  0,  0,  0,166,  0,  0,  0,167,  0,  0,  0,168,  0,  0,  0,
		169,  0,  0,  0,170,  0,  0,  0,171,  0,  0,  0,172,  0,  0,  0,
		173,  0,  0,  0,174,  0,  0,  0,175,  0,  0,  0,176,  0,  0,  0,
		177,  0,  0,  0,178,  0,  0,  0,179,  0,  0,  0,180,  0,  0,  0,
		181,  0,  0,  0,182,  0,  0,  0,183,  0,  0,  0,184,  0,  0,  0,
		185,  0,  0,  0,186,  0,  0,  0,187,  0,  0,  0,188,  0,  0,  0,
		189,  0,  0,  0,190,  0,  0,  0,191,  0,  0,  0,192,  0,  0,  0,
		193,  0,  0,  0,194,  0,  0,  0,195,  0,  0,  0,196,  0,  0,  0,
		197,  0,  0,  0,198,  0,  0,  0,199,  0,  0,  0,200,  0,  0,  0,
		201,  0,  0,  0,202,  0,  0,  0,203,  0,  0,  0,204,  0,  0,  0,
		205,  0,  0,  0,206,  0,  0,  0,207,  0,  0,  0,208,  0,  0,  0,
		209,  0,  0,  0,210,  0,  0,  0,211,  0,  0,  0,212,  0,  0,  0,
		213,  0,  0,  0,214,  0,  0,  0,215,  0,  0,  0,216,  0,  0,  0,
		217,  0,  0,  0,218,  0,  0,  0,219,  0,  0,  0,220,  0,  0,  0,
		221,  0,  0,  0,222,  0,  0,  0,223,  0,  0,  0,224,  0,  0,  0,
		225,  0,  0,  0,226,  0,  0,  0,227,  0,  0,  0,228,  0,  0,  0,
		229,  0,  0,  0,230,  0,  0,  0,231,  0,  0,  0,232,  0,  0,  0,
		233,  0,  0,  0,234,  0,  0,  0,235,  0,  0,  0,236,  0,  0,  0,
		237,  0,  0,  0,238,  0,  0,  0,239,  0,  0,  0,240,  0,  0,  0,
		241,  0,  0,  0,242,  0,  0,  0,243,  0,  0,  0,244,  0,  0,  0,
		245,  0,  0,  0,246,  0,  0,  0,247,  0,  0,  0,248,  0,  0,  0,
		249,  0,  0,  0,250,  0,  0,  0,251,  0,  0,  0,252,  0,  0,  0,
		253,  0,  0,  0,254,  0,  0,  0,255,  0,  0,  0,
		0x79, 0x00},

	// Resource Source

	Buffer () {0x89, 0x08, 0x00, 0x0f, 0x01, 0xff, 0xfe, 0xfd, 0xfc,
		0x01, 0x00, 0x79, 0x00},
	Buffer () {0x89, 0x09, 0x00, 0x0f, 0x01, 0xff, 0xfe, 0xfd, 0xfc,
		0x0f, 0x50, 0x00, 0x79, 0x00},
	Buffer () {0x89, 0x0c, 0x00, 0x0f, 0x01, 0xff, 0xfe, 0xfd, 0xfc,
		0xf0, 0x50, 0x41, 0x54, 0x48, 0x00, 0x79, 0x00},
	Buffer () {0x89, 0xd0, 0x00, 0x0f, 0x01, 0xff, 0xfe, 0xfd, 0xfc,
		0xff,
		0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
		0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30,
		0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
		0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40,
		0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48,
		0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50,
		0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
		0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x60,
		0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
		0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70,
		0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
		0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x20, 0x21,
		0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29,
		0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31,
		0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39,
		0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40, 0x41,
		0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49,
		0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50, 0x51,
		0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59,
		0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x60, 0x61,
		0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69,
		0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71,
		0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79,
		0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x20, 0x21, 0x22,
		0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a,
		0x00, 0x79, 0x00},

	// Particular cases

	Buffer () {0x89, 0xc8, 0x04, 0x0f, 0xff,
		  1,  0,  0,  0,  2,  0,  0,  0,  3,  0,  0,  0,  4,  0,  0,  0,
		  5,  0,  0,  0,  6,  0,  0,  0,  7,  0,  0,  0,  8,  0,  0,  0,
		  9,  0,  0,  0, 10,  0,  0,  0, 11,  0,  0,  0, 12,  0,  0,  0,
		 13,  0,  0,  0, 14,  0,  0,  0, 15,  0,  0,  0, 16,  0,  0,  0,
		 17,  0,  0,  0, 18,  0,  0,  0, 19,  0,  0,  0, 20,  0,  0,  0,
		 21,  0,  0,  0, 22,  0,  0,  0, 23,  0,  0,  0, 24,  0,  0,  0,
		 25,  0,  0,  0, 26,  0,  0,  0, 27,  0,  0,  0, 28,  0,  0,  0,
		 29,  0,  0,  0, 30,  0,  0,  0, 31,  0,  0,  0, 32,  0,  0,  0,
		 33,  0,  0,  0, 34,  0,  0,  0, 35,  0,  0,  0, 36,  0,  0,  0,
		 37,  0,  0,  0, 38,  0,  0,  0, 39,  0,  0,  0, 40,  0,  0,  0,
		 41,  0,  0,  0, 42,  0,  0,  0, 43,  0,  0,  0, 44,  0,  0,  0,
		 45,  0,  0,  0, 46,  0,  0,  0, 47,  0,  0,  0, 48,  0,  0,  0,
		 49,  0,  0,  0, 50,  0,  0,  0, 51,  0,  0,  0, 52,  0,  0,  0,
		 53,  0,  0,  0, 54,  0,  0,  0, 55,  0,  0,  0, 56,  0,  0,  0,
		 57,  0,  0,  0, 58,  0,  0,  0, 59,  0,  0,  0, 60,  0,  0,  0,
		 61,  0,  0,  0, 62,  0,  0,  0, 63,  0,  0,  0, 64,  0,  0,  0,
		 65,  0,  0,  0, 66,  0,  0,  0, 67,  0,  0,  0, 68,  0,  0,  0,
		 69,  0,  0,  0, 70,  0,  0,  0, 71,  0,  0,  0, 72,  0,  0,  0,
		 73,  0,  0,  0, 74,  0,  0,  0, 75,  0,  0,  0, 76,  0,  0,  0,
		 77,  0,  0,  0, 78,  0,  0,  0, 79,  0,  0,  0, 80,  0,  0,  0,
		 81,  0,  0,  0, 82,  0,  0,  0, 83,  0,  0,  0, 84,  0,  0,  0,
		 85,  0,  0,  0, 86,  0,  0,  0, 87,  0,  0,  0, 88,  0,  0,  0,
		 89,  0,  0,  0, 90,  0,  0,  0, 91,  0,  0,  0, 92,  0,  0,  0,
		 93,  0,  0,  0, 94,  0,  0,  0, 95,  0,  0,  0, 96,  0,  0,  0,
		 97,  0,  0,  0, 98,  0,  0,  0, 99,  0,  0,  0,100,  0,  0,  0,
		101,  0,  0,  0,102,  0,  0,  0,103,  0,  0,  0,104,  0,  0,  0,
		105,  0,  0,  0,106,  0,  0,  0,107,  0,  0,  0,108,  0,  0,  0,
		109,  0,  0,  0,110,  0,  0,  0,111,  0,  0,  0,112,  0,  0,  0,
		113,  0,  0,  0,114,  0,  0,  0,115,  0,  0,  0,116,  0,  0,  0,
		117,  0,  0,  0,118,  0,  0,  0,119,  0,  0,  0,120,  0,  0,  0,
		121,  0,  0,  0,122,  0,  0,  0,123,  0,  0,  0,124,  0,  0,  0,
		125,  0,  0,  0,126,  0,  0,  0,127,  0,  0,  0,128,  0,  0,  0,
		129,  0,  0,  0,130,  0,  0,  0,131,  0,  0,  0,132,  0,  0,  0,
		133,  0,  0,  0,134,  0,  0,  0,135,  0,  0,  0,136,  0,  0,  0,
		137,  0,  0,  0,138,  0,  0,  0,139,  0,  0,  0,140,  0,  0,  0,
		141,  0,  0,  0,142,  0,  0,  0,143,  0,  0,  0,144,  0,  0,  0,
		145,  0,  0,  0,146,  0,  0,  0,147,  0,  0,  0,148,  0,  0,  0,
		149,  0,  0,  0,150,  0,  0,  0,151,  0,  0,  0,152,  0,  0,  0,
		153,  0,  0,  0,154,  0,  0,  0,155,  0,  0,  0,156,  0,  0,  0,
		157,  0,  0,  0,158,  0,  0,  0,159,  0,  0,  0,160,  0,  0,  0,
		161,  0,  0,  0,162,  0,  0,  0,163,  0,  0,  0,164,  0,  0,  0,
		165,  0,  0,  0,166,  0,  0,  0,167,  0,  0,  0,168,  0,  0,  0,
		169,  0,  0,  0,170,  0,  0,  0,171,  0,  0,  0,172,  0,  0,  0,
		173,  0,  0,  0,174,  0,  0,  0,175,  0,  0,  0,176,  0,  0,  0,
		177,  0,  0,  0,178,  0,  0,  0,179,  0,  0,  0,180,  0,  0,  0,
		181,  0,  0,  0,182,  0,  0,  0,183,  0,  0,  0,184,  0,  0,  0,
		185,  0,  0,  0,186,  0,  0,  0,187,  0,  0,  0,188,  0,  0,  0,
		189,  0,  0,  0,190,  0,  0,  0,191,  0,  0,  0,192,  0,  0,  0,
		193,  0,  0,  0,194,  0,  0,  0,195,  0,  0,  0,196,  0,  0,  0,
		197,  0,  0,  0,198,  0,  0,  0,199,  0,  0,  0,200,  0,  0,  0,
		201,  0,  0,  0,202,  0,  0,  0,203,  0,  0,  0,204,  0,  0,  0,
		205,  0,  0,  0,206,  0,  0,  0,207,  0,  0,  0,208,  0,  0,  0,
		209,  0,  0,  0,210,  0,  0,  0,211,  0,  0,  0,212,  0,  0,  0,
		213,  0,  0,  0,214,  0,  0,  0,215,  0,  0,  0,216,  0,  0,  0,
		217,  0,  0,  0,218,  0,  0,  0,219,  0,  0,  0,220,  0,  0,  0,
		221,  0,  0,  0,222,  0,  0,  0,223,  0,  0,  0,224,  0,  0,  0,
		225,  0,  0,  0,226,  0,  0,  0,227,  0,  0,  0,228,  0,  0,  0,
		229,  0,  0,  0,230,  0,  0,  0,231,  0,  0,  0,232,  0,  0,  0,
		233,  0,  0,  0,234,  0,  0,  0,235,  0,  0,  0,236,  0,  0,  0,
		237,  0,  0,  0,238,  0,  0,  0,239,  0,  0,  0,240,  0,  0,  0,
		241,  0,  0,  0,242,  0,  0,  0,243,  0,  0,  0,244,  0,  0,  0,
		245,  0,  0,  0,246,  0,  0,  0,247,  0,  0,  0,248,  0,  0,  0,
		249,  0,  0,  0,250,  0,  0,  0,251,  0,  0,  0,252,  0,  0,  0,
		253,  0,  0,  0,254,  0,  0,  0,255,  0,  0,  0,
		0xff,
		0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
		0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30,
		0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
		0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40,
		0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48,
		0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50,
		0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
		0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x60,
		0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
		0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70,
		0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
		0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x20, 0x21,
		0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29,
		0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31,
		0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39,
		0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40, 0x41,
		0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49,
		0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50, 0x51,
		0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59,
		0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x60, 0x61,
		0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69,
		0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71,
		0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79,
		0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x20, 0x21, 0x22,
		0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a,
		0x00, 0x79, 0x00},

	// 20051021, relaxation for omitted ResourceSource (bug-fix 70 rejection)
	Buffer () {0x89, 0x07, 0x00, 0x0f, 0x01, 0xff, 0xfe, 0xfd, 0xfc,
		0x0f, 0x79, 0x00},
})

Method(RT18,, Serialized)
{
	Name(ts, "RT18")

	// Emit test header, set the filename

	THDR (ts, "Interrupt Resource Descriptor Macro", __FILE__)

    // Main test case for packages above

	m330(ts, 23, "p434", p434, p435)

    // Check resource descriptor tag offsets

	Store (
		ResourceTemplate () {
			Interrupt (ResourceProducer, Edge, ActiveLow, Shared, , , INT0) {0xfcfdfeff}
			Interrupt (ResourceProducer, Edge, ActiveLow, Shared, , , INT1) {0xfcfdfeff}
		}, Local0)

	m331(ts, 1, INT0._HE,  0x19, INT1._HE,  0x61, "_HE")
	m331(ts, 2, INT0._LL,  0x1a, INT1._LL,  0x62, "_LL")
	m331(ts, 3, INT0._SHR, 0x1b, INT1._SHR, 0x63, "_SHR")
	m331(ts, 4, INT0._INT, 0x28, INT1._INT, 0x70, "_INT")

	CH03(ts, z017, 0x123, 0, 0)
}
