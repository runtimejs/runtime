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
 * Bug 63:
 *
 * SUMMARY
 *
 * String to Integer conversion contradicts new April 2005 Conversion Rules
 *
 * EXAMPLES
 *
 *    Add("0x1111", 0) returns 0x1111 but 0 is expected
 *    Add("12345678901234560", 0x1111111111111111) causes AE_BAD_HEX_CONSTANT
 *    Add("00000000000012345678", 0) returns 0x12345678 but 0x1234 is expected
 *
 * ROOT CAUSE
 *
 * SPECS (NEW, March 12 2005)
 *
 * String --> Integer
 *
 * If no integer object exists, a new integer is created.
 * The integer is initialized to the value zero and the ASCII
 * string is interpreted as a hexadecimal constant. Each string
 * character is interpreted as a hexadecimal value (‘0’-‘9’, ‘A’-‘F’, ‘a’-‘f’),
 * starting with the first character as the most significant digit and ending
 * with the first non-hexadecimal character, end-of-string, or when the size
 * of an integer is reached (8 characters for 32-bit integers and 16 characters
 * for 64-bit integers). Note: the first non-hex character terminates the
 * conversion without error, and a “0x” prefix is not allowed.	
 */

/*
 * To be completed !!!!!!!
 *
 * What to do else below:
 *
 * 1. Set correct results in 32 and 64 bit modes (now it is not done!)
 * 2. Change places of operands, that is use both:
	Add("12345678", 0x11111111, Local0)
	Add(0x11111111, "12345678", Local0)

 * 3. Pass operators by parameters !!!!
 * 4. Issues:
 *    1) octal - 01232211
 *    2) zeros at the beginning - 0000000abcdef
 *    3) large hex image - abcdef123456789123456789
 */
/*
Store("VVVVVVVVVVVVVVVVVVVVVVVVVV", Debug)
Store(0123, Debug)
Store(83, Debug)
Add(0x1234, 83, Local0)
Store(Local0, Debug)
return
*/

/*
 * All the possible attempts to confuse calculation
 */
Method(md74,, Serialized) {

	Name(ts, "md74")

	// 8 decimal
	Add("12345678", 0x11111111, Local0)
	if (LNotEqual(Local0, 0x23456789)) {
		err("", zFFF, 0x000, 0, 0, Local0, 0x23456789)
	}

	// 8 hex
	Add("abcdefab", 0x11111111, Local0)
	if (LNotEqual(Local0, 0xbcdf00bc)) {
		err("", zFFF, 0x001, 0, 0, Local0, 0xbcdf00bc)
	}

	// 16 decimal
	Add("1234567890876543", 0x1111111111111111, Local0)
	if (LNotEqual(Local0, 0x23456789a1987654)) {
		err("", zFFF, 0x002, 0, 0, Local0, 0x23456789a1987654)
	}

	// 16 hex
	Add("abcdefababcdfead", 0x1111111111111111, Local0)
	if (LNotEqual(Local0, 0xbcdf00bcbcdf0fbe)) {
		err("", zFFF, 0x003, 0, 0, Local0, 0xbcdf00bcbcdf0fbe)
	}

	// 17 hex
	Add("1234567890123456z", 0x1111111111111111, Local0)
	if (LNotEqual(Local0, 0x23456789a1234567)) {
		err("", zFFF, 0x004, 0, 0, Local0, 0x23456789a1234567)
	}

	// 17 hex (caused AE_BAD_HEX_CONSTANT, 28.09.2005)
	Add("12345678901234560", 0x1111111111111111, Local0)
	if (LNotEqual(Local0, 0x23456789a1234567)) {
		err("", zFFF, 0x005, 0, 0, Local0, 0x23456789a1234567)
	}

	// Looks like octal, but should be treated as hex
	Add("01111", 0x2222, Local0)
	if (LNotEqual(Local0, 0x3333)) {
		err("", zFFF, 0x006, 0, 0, Local0, 0x3333)
	}

	// The first zeros each must be put into value

	Add("000010234", 0, Local0)
	if (LNotEqual(Local0, 0x10234)) {
		err("", zFFF, 0x007, 0, 0, Local0, 0x10234)
	}

	Add("000000000000000010234", 0, Local0)
	if (LNotEqual(Local0, 0x10234)) {
		err("", zFFF, 0x008, 0, 0, Local0, 0x10234)
	}

	Add("00000000000000010234", 0, Local0)
	if (LNotEqual(Local0, 0x10234)) {
		err("", zFFF, 0x009, 0, 0, Local0, 0x10234)
	}

	Add("0000000010234", 0, Local0)
	if (LNotEqual(Local0, 0x10234)) {
		err("", zFFF, 0x00a, 0, 0, Local0, 0x10234)
	}

	Add("000000010234", 0, Local0)
	if (LNotEqual(Local0, 0x10234)) {
		err("", zFFF, 0x00b, 0, 0, Local0, 0x10234)
	}

	// Non-complete 4 hex, should be extended with zeros
	Add("abcd", 0x1111, Local0)
	if (LNotEqual(Local0, 0xbcde)) {
		err("", zFFF, 0x00c, 0, 0, Local0, 0xbcde)
	}

	// Non-complete 5 decimal, should be extended with zeros
	Add("12345", 0x1111, Local0)
	if (LNotEqual(Local0, 0x13456)) {
		err("", zFFF, 0x00d, 0, 0, Local0, 0x13456)
	}

	CH03(ts, zFFF, 0x100, 0, 0)

	// Too large, all hex, should be trancated
	Add("abcdef0123456789112233445566778890", 0, Local0)
	if (F64) {
		if (LNotEqual(Local0, 0xabcdef0123456789)) {
			err("", zFFF, 0x00e, 0, 0, Local0, 0xabcdef0123456789)
		}
	} else {
		if (LNotEqual(Local0, 0xabcdef01)) {
			err("", zFFF, 0x00f, 0, 0, Local0, 0xabcdef01)
		}
	}

	CH03(ts, zFFF, 0x101, 0, 0)

	// Large, all hex, looks like octal, should be trancated
	Add("0abcdef0123456789112233445566778890", 0x1234, Local0)
	if (F64) {
		if (LNotEqual(Local0, 0xabcdef0123456789)) {
			err("", zFFF, 0x010, 0, 0, Local0, 0xabcdef0123456789)
		}
	} else {
		if (LNotEqual(Local0, 0xabcdef01)) {
			err("", zFFF, 0x011, 0, 0, Local0, 0xabcdef01)
		}
	}

	CH03(ts, zFFF, 0x102, 0, 0)

	// Looks like usual hex, but 'x' terminates conversion
	Add("0x1111", 0x2222, Local0)
	if (LNotEqual(Local0, 0x2222)) {
		err("", zFFF, 0x012, 0, 0, Local0, 0x2222)
	}

	CH03(ts, zFFF, 0x103, 0, 0)

	// Empty string, no action - the relevant parameter of Add remains zero
	Add("", 222, Local0)
	if (LNotEqual(Local0, 222)) {
		err("", zFFF, 0x013, 0, 0, Local0, 222)
	}

	CH03(ts, zFFF, 0x104, 0, 0)

	// Blank string, no action - the relevant parameter of Add remains zero
	Add(" ", 0x333, Local0)
	if (LNotEqual(Local0, 0x333)) {
		err("", zFFF, 0x014, 0, 0, Local0, 0x333)
	}

	CH03(ts, zFFF, 0x105, 0, 0)

	// Blank string, no action - the relevant parameter of Add remains zero
	Add("                                ", 0222, Local0)
	if (LNotEqual(Local0, 0222)) {
		err("", zFFF, 0x015, 0, 0, Local0, 0222)
	}

	CH03(ts, zFFF, 0x106, 0, 0)

	// Conversion is terminated just by the first symbol (non-hex) though followed by hex-es, remains zero
	Add("k1234567", 489, Local0)
	if (LNotEqual(Local0, 489)) {
		err("", zFFF, 0x016, 0, 0, Local0, 489)
	}

	// Conversion is terminated just by the first symbol (non-hex), single
	Add("k", 0xabcdef0000, Local0)
	if (LNotEqual(Local0, 0xabcdef0000)) {
		err("", zFFF, 0x017, 0, 0, Local0, 0xabcdef0000)
	}

	CH03(ts, zFFF, 0x107, 0, 0)

	// Looks like designation of hex (terminated by x)
	Add("0x", 0x12345678, Local0)
	if (LNotEqual(Local0, 0x12345678)) {
		err("", zFFF, 0x018, 0, 0, Local0, 0x12345678)
	}

	CH03(ts, zFFF, 0x108, 0, 0)

	// Special symbol in the hex designation (terminated by x)
	Add("x", 12345678, Local0)
	if (LNotEqual(Local0, 12345678)) {
		err("", zFFF, 0x019, 0, 0, Local0, 12345678)
	}

	// Starts with the special symbol in the hex designation (terminated by x)
	Add("x12345", 111, Local0)
	if (LNotEqual(Local0, 111)) {
		err("", zFFF, 0x01a, 0, 0, Local0, 111)
	}

	// No one hex, conversion is terminated just by the first symbol Z
	Add("ZZZZ", 123456, Local0)
	if (LNotEqual(Local0, 123456)) {
		err("", zFFF, 0x01b, 0, 0, Local0, 123456)
	}

	// Short <= 8, conversion is terminated by non-hex symbol Z
	Add("abcdZZZZ", 0x11, Local0)
	if (LNotEqual(Local0, 0xabde)) {
		err("", zFFF, 0x01c, 0, 0, Local0, 0xabde)
	}

	// Short <= 8, hex in the middle (terminated by Z)
	Add("ZQ123MMM", 123456, Local0)
	if (LNotEqual(Local0, 123456)) {
		err("", zFFF, 0x01d, 0, 0, Local0, 123456)
	}

	// Short <= 8, hex at the end (terminated by Z)
	Add("ZQMMM123", 123456, Local0)
	if (LNotEqual(Local0, 123456)) {
		err("", zFFF, 0x01e, 0, 0, Local0, 123456)
	}

	// Long exceeding 16, no one hex
	Add("zxswqrrrrrrrrrrrrrrtttttttttttttttttttttttttyyyyyyyyyyyyyyyyyyuuuuuuuuuuuuuuuuuuuuuuu", 123, Local0)
	if (LNotEqual(Local0, 123)) {
		err("", zFFF, 0x01f, 0, 0, Local0, 123)
	}

	// Long exceeding 16, hex at the beginning
	Add("1234zxswqrrrrrrrrrrrrrrtttttttttttttttttttttttttyyyyyyyyyyyyyyyyyyuuuuuuuuuuuuuuuuuuuuuuu", 0123, Local0)
	if (LNotEqual(Local0, 0x1287)) {
		err("", zFFF, 0x020, 0, 0, Local0, 0x1287)
	}

	// Long exceeding 16, hex everywhere
	Add("123z4s5qr6rr7rrrrrrrrr8ttttttt9ttttttattttbttttcyyyydyyeyyyyyyyyuuuuuuuuuuuuuuuuuuuuf", 0123, Local0)
	if (LNotEqual(Local0, 0x176)) {
		err("", zFFF, 0x021, 0, 0, Local0, 0x176)
	}

	// Long exceeding 16, hex at the end
	Add("zxswqrrrrrrrrrrrrrrtttttttttttttttttttttttttyyyyyyyyyyyyyyyyyyuuuuuuuuuuuuuuuuuuuuuuu1234", 012321, Local0)
	if (LNotEqual(Local0, 012321)) {
		err("", zFFF, 0x022, 0, 0, Local0, 012321)
	}

	// Long exceeding 16, hex in the middle inside the possible Integer
	Add("zx1234swqrrrrrrrrrrrrrrtttttttttttttttttttttttttyyyyyyyyyyyyyyyyyyuuuuuuuuuuuuuuuuuuuuuuu", 0x12321, Local0)
	if (LNotEqual(Local0, 0x12321)) {
		err("", zFFF, 0x023, 0, 0, Local0, 0x12321)
	}

	// Long exceeding 16, hex in the middle beyond the bounds of the possible Integer
	Add("zxswqrrrrrrrrrrrrrrtttttttttttttttttttttttttyyyyyyyyyyyyyyyyyyuuuuuuuuuuuuuuuuuuuuu1234uu", 12321, Local0)
	if (LNotEqual(Local0, 12321)) {
		err("", zFFF, 0x024, 0, 0, Local0, 12321)
	}

	CH03(ts, zFFF, 0x109, 0, 0)

	// Only decimal, much more than 16
	Store(Add("123456789012345601112223334446667788990087654", 0), Local1)
	if (F64) {
		if (LNotEqual(Local0, 0x1234567890123456)) {
			err("", zFFF, 0x025, 0, 0, Local0, 0x1234567890123456)
		}
	} else {
		if (LNotEqual(Local0, 0x12345678)) {
			err("", zFFF, 0x026, 0, 0, Local0, 0x12345678)
		}
	}

	CH03(ts, zFFF, 0x10a, 0, 0)

	// Only hex, much more than 16
	Store(Add("abcdefabcdefabcdefabcdefabcdefabcdefabcdefabc", 0), Local1)
	if (F64) {
		if (LNotEqual(Local0, 0xabcdefabcdefabcd)) {
			err("", zFFF, 0x027, 0, 0, Local0, 0xabcdefabcdefabcd)
		}
	} else {
		if (LNotEqual(Local0, 0xabcdefab)) {
			err("", zFFF, 0x028, 0, 0, Local0, 0xabcdefab)
		}
	}

	CH03(ts, zFFF, 0x10b, 0, 0)

	// Only decimal, much more than 16, non-hex at the end
	Store(Add("123456789012345601112223334446667788990087654ZZZZ", 0), Local1)
	if (F64) {
		if (LNotEqual(Local0, 0x1234567890123456)) {
			err("", zFFF, 0x029, 0, 0, Local0, 0x1234567890123456)
		}
	} else {
		if (LNotEqual(Local0, 0x12345678)) {
			err("", zFFF, 0x02a, 0, 0, Local0, 0x12345678)
		}
	}

	CH03(ts, zFFF, 0x10c, 0, 0)

	// Only hex, much more than 16, non-hex at the end
	Store(Add("abcdefabcdefabcdefabcdefabcdefabcdefabcdefabcZZZZ", 0), Local1)
	if (F64) {
		if (LNotEqual(Local0, 0xabcdefabcdefabcd)) {
			err("", zFFF, 0x02b, 0, 0, Local0, 0xabcdefabcdefabcd)
		}
	} else {
		if (LNotEqual(Local0, 0xabcdefab)) {
			err("", zFFF, 0x02c, 0, 0, Local0, 0xabcdefab)
		}
	}

	CH03(ts, zFFF, 0x10d, 0, 0)
}

Method(md75) {
	// Do here the same as md74 but store Result by Store
}

Method(md76,, Serialized) {

	Name(ts, "md76")

	CH03(ts, zFFF, 0x10e, 0, 0)
	md74()
	CH03(ts, zFFF, 0x10f, 0, 0)
	md75()
	CH03(ts, zFFF, 0x110, 0, 0)
}
