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
 * FixedDma Resource Descriptor Macro
 */

Name (p450, Package() {
	ResourceTemplate () {
		FixedDma (0xf1f2, 0x1234, Width8Bit)
	},
	ResourceTemplate () {
		FixedDma (0xe1e2, 0x000F, Width16Bit)
	},
	ResourceTemplate () {
		FixedDma (0xd1d2, 0x00F0, Width32Bit)
	},
	ResourceTemplate () {
		FixedDma (0xc1c2, 0x0F00, Width64Bit)
	},
	ResourceTemplate () {
		FixedDma (0xb1b2, 0xF000, Width128Bit)
	},
	ResourceTemplate () {
		FixedDma (0xa1a2, 0xFFFF, Width256Bit)
	},
	
	// Default DMA width is Width32Bit
	
	ResourceTemplate () {
		FixedDma (0x9192, 4567)
	},

	ResourceTemplate () {
		FixedDma (0x8182, 4567, , TDMA)
	},
})


Name (p451, Package() {
	Buffer () {0x55, 0xF2, 0xF1, 0x34, 0x12, 0x00, 0x79, 0x00},
	Buffer () {0x55, 0xE2, 0xE1, 0x0F, 0x00, 0x01, 0x79, 0x00},
	Buffer () {0x55, 0xD2, 0xD1, 0xF0, 0x00, 0x02, 0x79, 0x00},
	Buffer () {0x55, 0xC2, 0xC1, 0x00, 0x0F, 0x03, 0x79, 0x00},
	Buffer () {0x55, 0xB2, 0xB1, 0x00, 0xF0, 0x04, 0x79, 0x00},
	Buffer () {0x55, 0xA2, 0xA1, 0xFF, 0xFF, 0x05, 0x79, 0x00},
	Buffer () {0x55, 0x92, 0x91, 0xD7, 0x11, 0x02, 0x79, 0x00},
	Buffer () {0x55, 0x82, 0x81, 0xD7, 0x11, 0x02, 0x79, 0x00},
})

Method(RT20,, Serialized)
{
	Name(ts, "RT20")

	// Emit test header, set the filename

	THDR (ts, "FixedDMA Resource Descriptor Macro", __FILE__)

    // The main test packages must have the same number of entries

    If (LNotEqual (SizeOf (p450), SizeOf (p451)))
    {
        err (ts, 177, 0, 0, 0, 0, "Incorrect package length")
        Return ()
    }

    // Main test case for packages above

	m330(ts, SizeOf (p450), "p450", p450, p451)
	
    // Check resource descriptor tag offsets

	Store (
	    ResourceTemplate () {
		    FixedDma (0xe1e2, 0x000F, Width16Bit, DMA0)
		    FixedDma (0xd1d2, 0x00F0, Width32Bit, DMA1)
	    }, Local0)

	m331(ts, 1, DMA0._DMA, 0x08, DMA1._DMA, 0x38, "_DMA")
	m331(ts, 2, DMA0._TYP, 0x18, DMA1._TYP, 0x48, "_TYP")
	m331(ts, 3, DMA0._SIZ, 0x28, DMA1._SIZ, 0x58, "_SIZ")
}


