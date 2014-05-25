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
 * IRQ() Interrupt Resource Descriptor Macro
 */

Name (p400, Package() {
	ResourceTemplate () {
		IRQ (Level, ActiveHigh, Exclusive) {0}
	},
	ResourceTemplate () {
		IRQ (Level, ActiveHigh, Shared) {1}
	},
	ResourceTemplate () {
		IRQ (Level, ActiveLow, Exclusive) {2}
	},
	ResourceTemplate () {
		IRQ (Level, ActiveLow, Shared) {3}
	},
	ResourceTemplate () {
		IRQ (Edge, ActiveHigh, Exclusive) {4}
	},
	ResourceTemplate () {
		IRQ (Edge, ActiveHigh, Shared) {5}
	},
	ResourceTemplate () {
		IRQ (Edge, ActiveLow, Exclusive) {6}
	},
	ResourceTemplate () {
		IRQ (Edge, ActiveLow, Shared) {7}
	},
	ResourceTemplate () {
		IRQ (Level, ActiveHigh, Exclusive) {8}
	},
	ResourceTemplate () {
		IRQ (Level, ActiveHigh, Shared) {9}
	},
	ResourceTemplate () {
		IRQ (Level, ActiveLow, Exclusive) {10}
	},
	ResourceTemplate () {
		IRQ (Level, ActiveLow, Shared) {11}
	},
	ResourceTemplate () {
		IRQ (Edge, ActiveHigh, Exclusive) {12}
	},
	ResourceTemplate () {
		IRQ (Edge, ActiveHigh, Shared) {13}
	},
	ResourceTemplate () {
		IRQ (Edge, ActiveLow, Exclusive) {14}
	},
	ResourceTemplate () {
		IRQ (Edge, ActiveLow, Shared) {15}
	},
	ResourceTemplate () {
		IRQ (Edge, ActiveLow) {}
	},
	ResourceTemplate () {
		IRQ (Level, ActiveHigh) {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
	},
})

/*
ACPI Specification, Revision 3.0, September 2, 2004
6.4.2.1   IRQ Descriptor

IRQ Descriptor layout (length = 3):

Byte 0 (Tag Bits): Value = 00100011B (0x23) (Type = 0, small item name = 0x4, length = 3),

Byte 1 (IRQ mask bits[7:0]): IRQ0 <=> bit[0]

Byte 2 (IRQ mask bits[15:8]): IRQ8 <=> bit[0]

Byte 3 (IRQ Information):
Bit[4] 		Interrupt is sharable, _SHR
Bit[3]		Interrupt Polarity, _LL
			0	Active-High - This interrupt is sampled when the signal is high, or true
			1	Active-Low - This interrupt is sampled when the signal is low, or false.
Bit[0]		Interrupt Mode, _HE
			0	Level-Triggered - Interrupt is triggered in response to signal in a low state.
			1	Edge-Triggered - Interrupt is triggered in response to a change in signal state
			        from low to high.
*/

Name (p401, Package() {
	Buffer () {0x23, 0x01, 0x00, 0x00, 0x79, 0x00},
	Buffer () {0x23, 0x02, 0x00, 0x10, 0x79, 0x00},
	Buffer () {0x23, 0x04, 0x00, 0x08, 0x79, 0x00},
	Buffer () {0x23, 0x08, 0x00, 0x18, 0x79, 0x00},
	Buffer () {0x23, 0x10, 0x00, 0x01, 0x79, 0x00},
	Buffer () {0x23, 0x20, 0x00, 0x11, 0x79, 0x00},
	Buffer () {0x23, 0x40, 0x00, 0x09, 0x79, 0x00},
	Buffer () {0x23, 0x80, 0x00, 0x19, 0x79, 0x00},
	Buffer () {0x23, 0x00, 0x01, 0x00, 0x79, 0x00},
	Buffer () {0x23, 0x00, 0x02, 0x10, 0x79, 0x00},
	Buffer () {0x23, 0x00, 0x04, 0x08, 0x79, 0x00},
	Buffer () {0x23, 0x00, 0x08, 0x18, 0x79, 0x00},
	Buffer () {0x23, 0x00, 0x10, 0x01, 0x79, 0x00},
	Buffer () {0x23, 0x00, 0x20, 0x11, 0x79, 0x00},
	Buffer () {0x23, 0x00, 0x40, 0x09, 0x79, 0x00},
	Buffer () {0x23, 0x00, 0x80, 0x19, 0x79, 0x00},
	Buffer () {0x23, 0x00, 0x00, 0x09, 0x79, 0x00},
	Buffer () {0x23, 0xff, 0xff, 0x00, 0x79, 0x00},
})

Method(RT01,, Serialized)
{
	Name(ts, "RT01")

	// Emit test header, set the filename

	THDR (ts, "IRQ Resource Descriptor Macro", __FILE__)

    // Main test case for packages above

	m330(ts, 18, "p400", p400, p401)

	Store (
		ResourceTemplate () {
			IRQ (Edge, ActiveLow, Shared, IRQ0) {}
			IRQ (Edge, ActiveLow, Shared, IRQ1) {}
		}, Local0)

	m331(ts, 1, IRQ0._HE, 0x18, IRQ1._HE, 0x38, "_HE")
	m331(ts, 2, IRQ0._LL, 0x1b, IRQ1._LL, 0x3b, "_LL")
	m331(ts, 3, IRQ0._SHR, 0x1c, IRQ1._SHR, 0x3c, "_SHR")
}
