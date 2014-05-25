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
 * DMA Resource Descriptor Macro
 */

Name (p404, Package() {
	ResourceTemplate () {
		DMA (Compatibility, NotBusMaster, Transfer8) {0}
	},
	ResourceTemplate () {
		DMA (Compatibility, NotBusMaster, Transfer8_16) {1}
	},
	ResourceTemplate () {
		DMA (Compatibility, NotBusMaster, Transfer16) {2}
	},
	ResourceTemplate () {
		DMA (Compatibility, BusMaster, Transfer8) {3}
	},
	ResourceTemplate () {
		DMA (Compatibility, BusMaster, Transfer8_16) {4}
	},
	ResourceTemplate () {
		DMA (Compatibility, BusMaster, Transfer16) {5}
	},
	ResourceTemplate () {
		DMA (TypeA, NotBusMaster, Transfer8) {6}
	},
	ResourceTemplate () {
		DMA (TypeA, NotBusMaster, Transfer8_16) {7}
	},
	ResourceTemplate () {
		DMA (TypeA, NotBusMaster, Transfer16) {0}
	},
	ResourceTemplate () {
		DMA (TypeA, BusMaster, Transfer8) {1}
	},
	ResourceTemplate () {
		DMA (TypeA, BusMaster, Transfer8_16) {2}
	},
	ResourceTemplate () {
		DMA (TypeA, BusMaster, Transfer16) {3}
	},
	ResourceTemplate () {
		DMA (TypeB, NotBusMaster, Transfer8) {4}
	},
	ResourceTemplate () {
		DMA (TypeB, NotBusMaster, Transfer8_16) {5}
	},
	ResourceTemplate () {
		DMA (TypeB, NotBusMaster, Transfer16) {6}
	},
	ResourceTemplate () {
		DMA (TypeB, BusMaster, Transfer8) {7}
	},
	ResourceTemplate () {
		DMA (TypeB, BusMaster, Transfer8_16) {0}
	},
	ResourceTemplate () {
		DMA (TypeB, BusMaster, Transfer16) {1}
	},
	ResourceTemplate () {
		DMA (TypeF, NotBusMaster, Transfer8) {2}
	},
	ResourceTemplate () {
		DMA (TypeF, NotBusMaster, Transfer8_16) {3}
	},
	ResourceTemplate () {
		DMA (TypeF, NotBusMaster, Transfer16) {4}
	},
	ResourceTemplate () {
		DMA (TypeF, BusMaster, Transfer8) {5}
	},
	ResourceTemplate () {
		DMA (TypeF, BusMaster, Transfer8_16) {6}
	},
	ResourceTemplate () {
		DMA (TypeF, BusMaster, Transfer16) {7}
	},

	ResourceTemplate () {
		DMA (TypeF, BusMaster, Transfer16) {}
	},
	ResourceTemplate () {
		DMA (TypeF, BusMaster, Transfer16) {0, 1, 2, 3, 4, 5, 6, 7}
	},

	// IsBusMaster: if nothing is specifies, then BusMaster is assumed
	ResourceTemplate () {
		DMA (TypeF, , Transfer8) {5}
	},
})

/*
ACPI Specification, Revision 3.0, September 2, 2004
6.4.2.2   DMA Descriptor

DMA Descriptor layout:

Byte 0 (Tag Bits): Value = 00101010B (0x2a) (Type = 0, small item name = 0x5, length = 2)

Byte 1 (DMA channel mask bits[7:0]): DMA0 <=> bit[0]

Byte 2 (DMA Information):
Bits[6:5]	DMA channel speed supported, _TYP
			00	Indicates compatibility mode
			01	Indicates Type A DMA as described in the EISA
			10	Indicates Type B DMA
			11	Indicates Type F
Bit[2] 		Logical device bus master status, _BM
			0	Logical device is not a bus master
			1	Logical device is a bus master
Bits[1:0]	DMA transfer type preference, _SIZ
			00	8-bit only
			01	8- and 16-bit
			10	16-bit only
			11	Reserved
*/

Name (p405, Package() {
	Buffer () {0x2a, 0x01, 0x00, 0x79, 0x00},
	Buffer () {0x2a, 0x02, 0x01, 0x79, 0x00},
	Buffer () {0x2a, 0x04, 0x02, 0x79, 0x00},
	Buffer () {0x2a, 0x08, 0x04, 0x79, 0x00},
	Buffer () {0x2a, 0x10, 0x05, 0x79, 0x00},
	Buffer () {0x2a, 0x20, 0x06, 0x79, 0x00},
	Buffer () {0x2a, 0x40, 0x20, 0x79, 0x00},
	Buffer () {0x2a, 0x80, 0x21, 0x79, 0x00},
	Buffer () {0x2a, 0x01, 0x22, 0x79, 0x00},
	Buffer () {0x2a, 0x02, 0x24, 0x79, 0x00},
	Buffer () {0x2a, 0x04, 0x25, 0x79, 0x00},
	Buffer () {0x2a, 0x08, 0x26, 0x79, 0x00},
	Buffer () {0x2a, 0x10, 0x40, 0x79, 0x00},
	Buffer () {0x2a, 0x20, 0x41, 0x79, 0x00},
	Buffer () {0x2a, 0x40, 0x42, 0x79, 0x00},
	Buffer () {0x2a, 0x80, 0x44, 0x79, 0x00},
	Buffer () {0x2a, 0x01, 0x45, 0x79, 0x00},
	Buffer () {0x2a, 0x02, 0x46, 0x79, 0x00},
	Buffer () {0x2a, 0x04, 0x60, 0x79, 0x00},
	Buffer () {0x2a, 0x08, 0x61, 0x79, 0x00},
	Buffer () {0x2a, 0x10, 0x62, 0x79, 0x00},
	Buffer () {0x2a, 0x20, 0x64, 0x79, 0x00},
	Buffer () {0x2a, 0x40, 0x65, 0x79, 0x00},
	Buffer () {0x2a, 0x80, 0x66, 0x79, 0x00},

	Buffer () {0x2a, 0x00, 0x66, 0x79, 0x00},
	Buffer () {0x2a, 0xff, 0x66, 0x79, 0x00},

	Buffer () {0x2a, 0x20, 0x64, 0x79, 0x00},
})

Method(RT03,, Serialized)
{
	Name(ts, "RT03")

	// Emit test header, set the filename

	THDR (ts, "DMA Resource Descriptor Macro", __FILE__)

    // Main test case for packages above

	m330(ts, 27, "p404", p404, p405)

	Store (
		ResourceTemplate () {
			DMA (Compatibility, NotBusMaster, Transfer8, DMA0) {}
			DMA (Compatibility, NotBusMaster, Transfer8, DMA1) {}
		}, Local0)

	m331(ts, 1, DMA0._TYP, 0x15, DMA1._TYP, 0x2d, "_TYP")
	m331(ts, 2, DMA0._BM, 0x12, DMA1._BM, 0x2a, "_BM")
	m331(ts, 3, DMA0._SIZ, 0x10, DMA1._SIZ, 0x28, "_SIZ")
}
