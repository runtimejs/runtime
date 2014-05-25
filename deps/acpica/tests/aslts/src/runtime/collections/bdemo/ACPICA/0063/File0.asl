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
 * ToInteger(<0x-hex-dec>)
 */
Method(mf92) {

	// Hex: 0x - dec

	CH03("", 0, 0x100, 0, 0)

	ToInteger("0x0", Local0)
	if (LNotEqual(Local0, 0x0)) {
		err("", zFFF, 0x101, 0, 0, Local0, 0x0)
	}

	ToInteger("0x0000000", Local0)
	if (LNotEqual(Local0, 0x0)) {
		err("", zFFF, 0x102, 0, 0, Local0, 0x0)
	}

	ToInteger("0x1", Local0)
	if (LNotEqual(Local0, 0x1)) {
		err("", zFFF, 0x103, 0, 0, Local0, 0x1)
	}

	ToInteger("0x12345678", Local0)
	if (LNotEqual(Local0, 0x12345678)) {
		err("", zFFF, 0x104, 0, 0, Local0, 0x12345678)
	}

	ToInteger("0x12345", Local0)
	if (LNotEqual(Local0, 0x12345)) {
		err("", zFFF, 0x105, 0, 0, Local0, 0x12345)
	}

	if (F64) {
		ToInteger("0x1234567890123456", Local0)
		if (LNotEqual(Local0, 0x1234567890123456)) {
			err("", zFFF, 0x106, 0, 0, Local0, 0x1234567890123456)
		}

		ToInteger("0x123456789012345", Local0)
		if (LNotEqual(Local0, 0x123456789012345)) {
			err("", zFFF, 0x107, 0, 0, Local0, 0x123456789012345)
		}
	}

	// Hex: 0x - hex

	ToInteger("0xabcdefef", Local0)
	if (LNotEqual(Local0, 0xabcdefef)) {
		err("", zFFF, 0x108, 0, 0, Local0, 0xabcdefef)
	}

	ToInteger("0xabcdef", Local0)
	if (LNotEqual(Local0, 0xabcdef)) {
		err("", zFFF, 0x109, 0, 0, Local0, 0xabcdef)
	}

	if (F64) {
		ToInteger("0xabcdefefadefbcdf", Local0)
		if (LNotEqual(Local0, 0xabcdefefadefbcdf)) {
			err("", zFFF, 0x10a, 0, 0, Local0, 0xabcdefefadefbcdf)
		}

		ToInteger("0xabcdefefadefbcd", Local0)
		if (LNotEqual(Local0, 0xabcdefefadefbcd)) {
			err("", zFFF, 0x10b, 0, 0, Local0, 0xabcdefefadefbcd)
		}
	}

	// Hex: 0x - dec/hex

	ToInteger("0x1ab2cd34", Local0)
	if (LNotEqual(Local0, 0x1ab2cd34)) {
		err("", zFFF, 0x10c, 0, 0, Local0, 0x1ab2cd34)
	}

	if (F64) {
		ToInteger("0x1ab2cd340fe05678", Local0)
		if (LNotEqual(Local0, 0x1ab2cd340fe05678)) {
			err("", zFFF, 0x10d, 0, 0, Local0, 0x1ab2cd340fe05678)
		}

		ToInteger("0x1ab2cd340fe0", Local0)
		if (LNotEqual(Local0, 0x1ab2cd340fe0)) {
			err("", zFFF, 0x10e, 0, 0, Local0, 0x1ab2cd340fe0)
		}
	}

	CH03("", 0, 0x219, 0, 0)
}

/*
 * ToInteger(<dec>)
 */
Method(mf93) {

	CH03("", 0, 0x10f, 0, 0)

	ToInteger("0", Local0)
	if (LNotEqual(Local0, 0)) {
		err("", zFFF, 0x110, 0, 0, Local0, 0)
	}

	ToInteger("0000000", Local0)
	if (LNotEqual(Local0, 0)) {
		err("", zFFF, 0x111, 0, 0, Local0, 0)
	}

	ToInteger("000000000000000", Local0)
	if (LNotEqual(Local0, 0)) {
		err("", zFFF, 0x112, 0, 0, Local0, 0)
	}

	ToInteger("000000000000000000000000000000000000000000", Local0)
	if (LNotEqual(Local0, 0)) {
		err("", zFFF, 0x113, 0, 0, Local0, 0)
	}

	ToInteger("1", Local0)
	if (LNotEqual(Local0, 1)) {
		err("", zFFF, 0x114, 0, 0, Local0, 1)
	}

	ToInteger("1234567890", Local0)
	if (LNotEqual(Local0, 1234567890)) {
		err("", zFFF, 0x115, 0, 0, Local0, 1234567890)
	}

	ToInteger("1234567", Local0)
	if (LNotEqual(Local0, 1234567)) {
		err("", zFFF, 0x116, 0, 0, Local0, 1234567)
	}

	ToInteger("4294967295", Local0)
	if (LNotEqual(Local0, 4294967295)) {
		err("", zFFF, 0x117, 0, 0, Local0, 4294967295)
	}

	if (F64) {
		ToInteger("18446744073709551615", Local0)
		if (LNotEqual(Local0, 18446744073709551615)) {
			err("", zFFF, 0x118, 0, 0, Local0, 18446744073709551615)
		}
	}

	CH03("", 0, 0x119, 0, 0)
}

/*
 * White space before image of Data is skipped
 * (all examples above).
 */
Method(mf94) {

	CH03("", 0, 0x11a, 0, 0)

	ToInteger("                    0x0", Local0)
	if (LNotEqual(Local0, 0x0)) {
		err("", zFFF, 0x11b, 0, 0, Local0, 0x0)
	}

	ToInteger("                    0x00000", Local0)
	if (LNotEqual(Local0, 0x0)) {
		err("", zFFF, 0x11c, 0, 0, Local0, 0x0)
	}

	ToInteger(" 0x1", Local0)
	if (LNotEqual(Local0, 0x1)) {
		err("", zFFF, 0x11d, 0, 0, Local0, 0x1)
	}

	ToInteger("  0x12345678", Local0)
	if (LNotEqual(Local0, 0x12345678)) {
		err("", zFFF, 0x11e, 0, 0, Local0, 0x12345678)
	}

	ToInteger("   0x12345", Local0)
	if (LNotEqual(Local0, 0x12345)) {
		err("", zFFF, 0x11f, 0, 0, Local0, 0x12345)
	}

	if (F64) {
		ToInteger("    0x1234567890123456", Local0)
		if (LNotEqual(Local0, 0x1234567890123456)) {
			err("", zFFF, 0x120, 0, 0, Local0, 0x1234567890123456)
		}

		ToInteger("    0x123456789012345", Local0)
		if (LNotEqual(Local0, 0x123456789012345)) {
			err("", zFFF, 0x121, 0, 0, Local0, 0x123456789012345)
		}
	}

	ToInteger("     0xabcdefef", Local0)
	if (LNotEqual(Local0, 0xabcdefef)) {
		err("", zFFF, 0x122, 0, 0, Local0, 0xabcdefef)
	}

	ToInteger("      0xabcdef", Local0)
	if (LNotEqual(Local0, 0xabcdef)) {
		err("", zFFF, 0x123, 0, 0, Local0, 0xabcdef)
	}

	ToInteger("	0xabcdef", Local0)
	if (LNotEqual(Local0, 0xabcdef)) {
		err("", zFFF, 0x124, 0, 0, Local0, 0xabcdef)
	}

	if (F64) {
		ToInteger("       0xabcdefefadefbcdf", Local0)
		if (LNotEqual(Local0, 0xabcdefefadefbcdf)) {
			err("", zFFF, 0x125, 0, 0, Local0, 0xabcdefefadefbcdf)
		}

		ToInteger("       0xabcdefefadefbcd", Local0)
		if (LNotEqual(Local0, 0xabcdefefadefbcd)) {
			err("", zFFF, 0x126, 0, 0, Local0, 0xabcdefefadefbcd)
		}
	}

	ToInteger("        0x1ab2cd34", Local0)
	if (LNotEqual(Local0, 0x1ab2cd34)) {
		err("", zFFF, 0x127, 0, 0, Local0, 0x1ab2cd34)
	}

	if (F64) {
		ToInteger("         0x1ab2cd340fe05678", Local0)
		if (LNotEqual(Local0, 0x1ab2cd340fe05678)) {
			err("", zFFF, 0x128, 0, 0, Local0, 0x1ab2cd340fe05678)
		}

		ToInteger("         0x1ab2cd340fe0", Local0)
		if (LNotEqual(Local0, 0x1ab2cd340fe0)) {
			err("", zFFF, 0x129, 0, 0, Local0, 0x1ab2cd340fe0)
		}
	}

	ToInteger("          0", Local0)
	if (LNotEqual(Local0, 0)) {
		err("", zFFF, 0x12a, 0, 0, Local0, 0)
	}

	ToInteger(" 	0000000", Local0)
	if (LNotEqual(Local0, 0)) {
		err("", zFFF, 0x12b, 0, 0, Local0, 0)
	}

	ToInteger("	000000000000000", Local0)
	if (LNotEqual(Local0, 0)) {
		err("", zFFF, 0x12c, 0, 0, Local0, 0)
	}

	ToInteger(" 000000000000000000000000000000000000000000", Local0)
	if (LNotEqual(Local0, 0)) {
		err("", zFFF, 0x12d, 0, 0, Local0, 0)
	}

	ToInteger("           1", Local0)
	if (LNotEqual(Local0, 1)) {
		err("", zFFF, 0x12e, 0, 0, Local0, 1)
	}

	ToInteger("            1234567890", Local0)
	if (LNotEqual(Local0, 1234567890)) {
		err("", zFFF, 0x12f, 0, 0, Local0, 1234567890)
	}

	ToInteger("	1234567890", Local0)
	if (LNotEqual(Local0, 1234567890)) {
		err("", zFFF, 0x130, 0, 0, Local0, 1234567890)
	}

	ToInteger("									1234567890", Local0)
	if (LNotEqual(Local0, 1234567890)) {
		err("", zFFF, 0x131, 0, 0, Local0, 1234567890)
	}

	ToInteger("  	           1234567", Local0)
	if (LNotEqual(Local0, 1234567)) {
		err("", zFFF, 0x132, 0, 0, Local0, 1234567)
	}

	ToInteger("     	         4294967295", Local0)
	if (LNotEqual(Local0, 4294967295)) {
		err("", zFFF, 0x133, 0, 0, Local0, 4294967295)
	}

	if (F64) {
		ToInteger("               	18446744073709551615", Local0)
		if (LNotEqual(Local0, 18446744073709551615)) {
			err("", zFFF, 0x134, 0, 0, Local0, 18446744073709551615)
		}
	}

	CH03("", 0, 0x135, 0, 0)
}

/*
 * Zeros before significant characters in image without '0x' are skipped).
 */
Method(mf95) {

	CH03("", 0, 0x136, 0, 0)

	ToInteger("          0", Local0)
	if (LNotEqual(Local0, 0)) {
		err("", zFFF, 0x137, 0, 0, Local0, 0)
	}

	ToInteger("          2", Local0)
	if (LNotEqual(Local0, 2)) {
		err("", zFFF, 0x138, 0, 0, Local0, 2)
	}

	ToInteger("          0xa", Local0)
	if (LNotEqual(Local0, 0xa)) {
		err("", zFFF, 0x139, 0, 0, Local0, 0xa)
	}

	ToInteger("          04294967295", Local0)
	if (LNotEqual(Local0, 4294967295)) {
		err("", zFFF, 0x13a, 0, 0, Local0, 4294967295)
	}

	ToInteger("04294967295", Local0)
	if (LNotEqual(Local0, 4294967295)) {
		err("", zFFF, 0x13b, 0, 0, Local0, 4294967295)
	}

	ToInteger("000000000000000000004294967295", Local0)
	if (LNotEqual(Local0, 4294967295)) {
		err("", zFFF, 0x13c, 0, 0, Local0, 4294967295)
	}

	ToInteger(" 000000000000000000004294967295", Local0)
	if (LNotEqual(Local0, 4294967295)) {
		err("", zFFF, 0x13d, 0, 0, Local0, 4294967295)
	}

	ToInteger("	000000000000000000004294967295", Local0)
	if (LNotEqual(Local0, 4294967295)) {
		err("", zFFF, 0x13e, 0, 0, Local0, 4294967295)
	}

	ToInteger("	 	 	 	 	000000000000000000004294967295", Local0)
	if (LNotEqual(Local0, 4294967295)) {
		err("", zFFF, 0x13f, 0, 0, Local0, 4294967295)
	}

	ToInteger("	 	 	 	 	04294967295", Local0)
	if (LNotEqual(Local0, 4294967295)) {
		err("", zFFF, 0x140, 0, 0, Local0, 4294967295)
	}

	ToInteger("	 	 	 	 	0123456789", Local0)
	if (LNotEqual(Local0, 123456789)) {
		err("", zFFF, 0x141, 0, 0, Local0, 123456789)
	}

	ToInteger("0123456789", Local0)
	if (LNotEqual(Local0, 123456789)) {
		err("", zFFF, 0x142, 0, 0, Local0, 123456789)
	}

	ToInteger("00123456789", Local0)
	if (LNotEqual(Local0, 123456789)) {
		err("", zFFF, 0x143, 0, 0, Local0, 123456789)
	}

	if (F64) {
		ToInteger("               	018446744073709551615", Local0)
		if (LNotEqual(Local0, 18446744073709551615)) {
			err("", zFFF, 0x144, 0, 0, Local0, 18446744073709551615)
		}

		ToInteger("018446744073709551615", Local0)
		if (LNotEqual(Local0, 18446744073709551615)) {
			err("", zFFF, 0x145, 0, 0, Local0, 18446744073709551615)
		}

		ToInteger("000000000000000000000000000000000000000018446744073709551615", Local0)
		if (LNotEqual(Local0, 18446744073709551615)) {
			err("", zFFF, 0x146, 0, 0, Local0, 18446744073709551615)
		}
	}

	CH03("", 0, 0x219, 0, 0)
}

/*
 * ToInteger, exceptions
 */
Method(mf96) {

	// 5. "1234cd" (non-decimal character in dec-image)
	CH03("", 0, 0x147, 0, 0)
	ToInteger("1234cd", Local0)
	CH04("", 0, 0xff, 0, 0x148, 0, 0)

	// 6. "000x1234" (non-decimal character in dec-image)
	CH03("", 0, 0x149, 0, 0)
	ToInteger("000x1234", Local0)
	CH04("", 0, 0xff, 0, 0x14a, 0, 0)

	// 7. "0x1234cdQ" (non-hex character in '0x'-image)
	CH03("", 0, 0x14b, 0, 0)
	ToInteger("0x1234cdQ", Local0)
	CH04("", 0, 0xff, 0, 0x14c, 0, 0)

	CH03("", 0, 0x14d, 0, 0)
	ToInteger("0x0x12345", Local0)
	CH04("", 0, 0xff, 0, 0x14e, 0, 0)

	// 8. "1234 " (white space in dec image)
	CH03("", 0, 0x14f, 0, 0)
	ToInteger("1234 ", Local0)
	CH04("", 0, 0xff, 0, 0x150, 0, 0)

	// 9. "0x1234cd " (white space in '0x'-image)
	CH03("", 0, 0x151, 0, 0)
	ToInteger("0x1234cd ", Local0)
	CH04("", 0, 0xff, 0, 0x152, 0, 0)

	// 10. "0x 1234cdQ" (white space after '0x')
	CH03("", 0, 0x153, 0, 0)
	ToInteger("0x 1234", Local0)
	CH04("", 0, 0xff, 0, 0x154, 0, 0)

	CH03("", 0, 0x155, 0, 0)
	ToInteger("0x0x 1234", Local0)
	CH04("", 0, 0xff, 0, 0x156, 0, 0)

	CH03("", 0, 0x157, 0, 0)
	ToInteger("0x0x 0x 1234", Local0)
	CH04("", 0, 0xff, 0, 0x158, 0, 0)

	CH03("", 0, 0x159, 0, 0)
	ToInteger("0x 0x 1234", Local0)
	CH04("", 0, 0xff, 0, 0x15a, 0, 0)

	// 11. (decimal image exceeding maximal)
	//     32-bit mode – the value exceeding "4294967295"
	if (LNot(F64)) {
		CH03("", 0, 0x15b, 0, 0)
		ToInteger("4294967296", Local0)
		CH04("", 0, 0xff, 0, 0x15c, 0, 0)

		CH03("", 0, 0x15d, 0, 0)
		ToInteger("123456789012345678904294967296", Local0)
		CH04("", 0, 0xff, 0, 0x15e, 0, 0)

		CH03("", 0, 0x15f, 0, 0)
		ToInteger(" 	 		00004294967296", Local0)
		CH04("", 0, 0xff, 0, 0x160, 0, 0)

		CH03("", 0, 0x161, 0, 0)
		ToInteger("	0123456789012345678904294967296", Local0)
		CH04("", 0, 0xff, 0, 0x162, 0, 0)

		CH03("", 0, 0x163, 0, 0)
		ToInteger("0123456789012345678904294967296", Local0)
		CH04("", 0, 0xff, 0, 0x164, 0, 0)

		CH03("", 0, 0x165, 0, 0)
		ToInteger(" 123456789012345678904294967296", Local0)
		CH04("", 0, 0xff, 0, 0x166, 0, 0)

		CH03("", 0, 0x167, 0, 0)
		ToInteger("	123456789012345678904294967296", Local0)
		CH04("", 0, 0xff, 0, 0x168, 0, 0)
	}

	//     64-bit mode – the value exceeding "18446744073709551615"
	CH03("", 0, 0x169, 0, 0)
	ToInteger("18446744073709551616", Local0)
	CH04("", 0, 0xff, 0, 0x16a, 0, 0)

	CH03("", 0, 0x16b, 0, 0)
	ToInteger("	18446744073709551616", Local0)
	CH04("", 0, 0xff, 0, 0x16c, 0, 0)

	CH03("", 0, 0x16d, 0, 0)
	ToInteger(" 18446744073709551616", Local0)
	CH04("", 0, 0xff, 0, 0x16e, 0, 0)

	CH03("", 0, 0x16f, 0, 0)
	ToInteger("018446744073709551616", Local0)
	CH04("", 0, 0xff, 0, 0x170, 0, 0)

	CH03("", 0, 0x171, 0, 0)
	ToInteger(" 	000000000018446744073709551616", Local0)
	CH04("", 0, 0xff, 0, 0x172, 0, 0)

	// 12. "0x12345678901234567" (hex image exceeding maximal)
	CH03("", 0, 0x173, 0, 0)
	ToInteger("0x12345678901234567", Local0)
	CH04("", 0, 0xff, 0, 0x174, 0, 0)

	// 13. "0x00000000000001234" (hex image exceeding maximal; no matter that zeros)
	CH03("", 0, 0x175, 0, 0)
	ToInteger("0x00000000000001234", Local0)
	CH04("", 0, 0xff, 0, 0x176, 0, 0)

	CH03("", 0, 0x178, 0, 0)
	ToInteger("0x0000000000000000000001234", Local0)
	CH04("", 0, 0xff, 0, 0x179, 0, 0)

	// 14. "0x123456789" (hex image exceeding maximal; for 32-bit mode only)
	if (LNot(F64)) {
		CH03("", 0, 0x17a, 0, 0)
		ToInteger("0x123456789", Local0)
		CH04("", 0, 0xff, 0, 0x17b, 0, 0)
	}

	// 15. "0x" (incomplete '0x' image)
	CH03("", 0, 0x17c, 0, 0)
	ToInteger("0x", Local0)
	CH04("", 0, 0xff, 0, 0x17d, 0, 0)

	CH03("", 0, 0x17e, 0, 0)
	ToInteger("0x ", Local0)
	CH04("", 0, 0xff, 0, 0x17f, 0, 0)

	CH03("", 0, 0x180, 0, 0)
	ToInteger("0x	", Local0)
	CH04("", 0, 0xff, 0, 0x181, 0, 0)

	CH03("", 0, 0x182, 0, 0)
	ToInteger("0x 1234", Local0)
	CH04("", 0, 0xff, 0, 0x183, 0, 0)

	CH03("", 0, 0x184, 0, 0)
	ToInteger("0x	1234", Local0)
	CH04("", 0, 0xff, 0, 0x185, 0, 0)

	// 16. Empty string
	CH03("", 0, 0x186, 0, 0)
	ToInteger("", Local0)
	CH04("", 0, 0xff, 0, 0x187, 0, 0)
}


