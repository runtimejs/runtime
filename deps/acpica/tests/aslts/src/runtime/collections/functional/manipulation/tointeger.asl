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
 * Data type conversion and manipulation
 */

// Convert data to integer

Name(z047, 47)

// Integer

// 32-bit
Name(p300, Package()
{
	0,
	0x81,
	0x8232,
	0x76543201,
	0xf89abcde,
	0xffffffff,
})

// 64-bit
Name(p302, Package()
{
	0x8123456789,
	0x8cdae2376890,
	0x76543201f89abcde,
	0xf89abcde76543201,
	0xffffffffffffffff,
})

// Hexadecimal numeric String

// 32-bit
Name(p304, Package()
{
	"0x0",		// 0
	"0x00",
	"0x1",
	"0x83",
	"0x456",
	"0x8232",
	"0xbcdef",
	"0x123456",
	"0x789abcd",
	"0xffffffff",
	"0x01234567",	// 10
	"0X12345678",
	"0x23456789",
	"0x3456789a",
	"0x456789ab",
	"0x56789abc",
	"0x6789abcd",
	"0x789abcde",
	"0x89abcdef",
	"0x9abcdefA",
	"0xabcdefAB",	// 20
	"0xbcdefABC",
	"0xcdefABCD",
	"0xdefABCDE",
	"0xefABCDEF",
	"0xfABCDEF0",
	"0xABCDEF01",
	"0xBCDEF012",
	"0xCDEF0123",
	"0xDEF01234",
	"0xEF012345",	// 30
	"0xF0123456",
})

Name(p305, Package()
{
	0,
	0,
	0x1,
	0x83,
	0x456,
	0x8232,
	0xbcdef,
	0x123456,
	0x789abcd,
	0xffffffff,
	0X1234567,
	0x12345678,
	0x23456789,
	0x3456789a,
	0x456789ab,
	0x56789abc,
	0x6789abcd,
	0x789abcde,
	0x89abcdef,
	0x9abcdefa,
	0xabcdefab,
	0xbcdefabc,
	0xcdefabcd,
	0xdefabcde,
	0xefabcdef,
	0xfabcdef0,
	0xabcdef01,
	0xbcdef012,
	0xcdef0123,
	0xdef01234,
	0xef012345,
	0xf0123456,
})

// 64-bit
Name(p306, Package()
{
	"0x123456789",		// 0
	"0x8123456789",
	"0xabcdef01234",
	"0x876543210abc",
	"0x1234567abcdef",
	"0x8234567abcdef1",
	"0x6789abcdef01234",
	"0x76543201f89abcde",
	"0xf89abcde76543201",
	"0xffffffffffffffff",
	"0X0123456789abcdef",	// 10
	"0x123456789abcdefA",
	"0x23456789abcdefAB",
	"0x3456789abcdefABC",
	"0x456789abcdefABCD",
	"0x56789abcdefABCDE",
	"0x6789abcdefABCDEF",
	"0x789abcdefABCDEF0",
	"0x89abcdefABCDEF01",
	"0x9abcdefABCDEF012",
	"0xabcdefABCDEF0123",	// 20
	"0xbcdefABCDEF01234",
	"0xcdefABCDEF012345",
	"0xdefABCDEF0123456",
	"0xefABCDEF01234567",
	"0xfABCDEF012345678",
	"0xABCDEF0123456789",
	"0xBCDEF0123456789a",
	"0xCDEF0123456789ab",
	"0xDEF0123456789abc",
	"0xEF0123456789abcd",	// 30
	"0xF0123456789abcde",
})

Name(p307, Package()
{
	0x123456789,
	0x8123456789,
	0xabcdef01234,
	0x876543210abc,
	0x1234567abcdef,
	0x8234567abcdef1,
	0x6789abcdef01234,
	0x76543201f89abcde,
	0xf89abcde76543201,
	0xffffffffffffffff,
	0x0123456789abcdef,
	0x123456789abcdefa,
	0x23456789abcdefab,
	0x3456789abcdefabc,
	0x456789abcdefabcd,
	0x56789abcdefabcde,
	0x6789abcdefabcdef,
	0x789abcdefabcdef0,
	0x89abcdefabcdef01,
	0x9abcdefabcdef012,
	0xabcdefabcdef0123,
	0xbcdefabcdef01234,
	0xcdefabcdef012345,
	0xdefabcdef0123456,
	0xefabcdef01234567,
	0xfabcdef012345678,
	0xabcdef0123456789,
	0xbcdef0123456789a,
	0xcdef0123456789ab,
	0xdef0123456789abc,
	0xef0123456789abcd,
	0xf0123456789abcde,
})

// Decimal numeric String

// 32-bit
Name(p308, Package()
{
	"0",
	"12",
	"345",
	"6789",
	"12345",
	"678901",
	"2345678",
	"90123456",
	"789012345",
	"4294967295",	// == "0xffffffff"
	"4294967295",	// == "0xffffffff"
	"0123456789",
	"1234567890",
	"2345678901",
	"3456789012",
	"1567890123",
	"2678901234",
	"3789012345",
	"1890123456",
	"2901234567",
	"3012345678",
})

Name(p309, Package()
{
	0,
	12,
	345,
	6789,
	12345,
	678901,
	2345678,
	90123456,
	789012345,
	4294967295,
	0xffffffff,
	123456789,
	1234567890,
	2345678901,
	3456789012,
	1567890123,
	2678901234,
	3789012345,
	1890123456,
	2901234567,
	3012345678,
})

// 64-bit
Name(p310, Package()
{
	"30123456790",
	"123456789012",
	"3456789012345",
	"26789012346789",
	"123456789012345",
	"3789012345678901",
	"23456789012345678",
	"301234567890123456",
	"1890123456789012345",
	"18446744073709551615",	// == "0xffffffffffffffff"
	"18446744073709551615",	// == "0xffffffffffffffff"
	"01234567890123456789",
	"12345678901234567890",
	"13456789012345678901",
	"14567890123456789012",
	"15678901231567890123",
	"16789012342678901234",
	"17890123453789012345",
	"18301234561890123456",
	"18012345672901234567",
	"10123456783012345678",
})

Name(p311, Package()
{
	30123456790,
	123456789012,
	3456789012345,
	26789012346789,
	123456789012345,
	3789012345678901,
	23456789012345678,
	301234567890123456,
	1890123456789012345,
	18446744073709551615,
	0xffffffffffffffff,
	1234567890123456789,
	12345678901234567890,
	13456789012345678901,
	14567890123456789012,
	15678901231567890123,
	16789012342678901234,
	17890123453789012345,
	18301234561890123456,
	18012345672901234567,
	10123456783012345678,
})

// Buffer

// 32-bit
Name(p312, Package()
{
	// buffer, 32-bit integer
	Buffer(1) {0x81},
	Buffer(2) {0x82, 0x83},
	Buffer(3) {0x84, 0x85, 0x86},
	Buffer(4) {0x87, 0x88, 0x89, 0x8a},
	// for 32-bit mode only
	Buffer(5) {0x8b, 0x8c, 0x8d, 0x8e, 0x8f},
})

Name(p313, Package()
{
	0x81,
	0x8382,
	0x868584,
	0x8a898887,
	0x8e8d8c8b,
})

// 64-bit
Name(p314, Package()
{
	Buffer(5) {0x85, 0x84, 0x83, 0x82, 0x81},
	Buffer(6) {0x8b, 0x8a, 0x89, 0x88, 0x87, 0x86},
	Buffer(7) {0x82, 0x81, 0x80, 0x8f, 0x8e, 0x8d, 0x8c},
	Buffer(8) {0x8a, 0x89, 0x88, 0x87, 0x86, 0x85, 0x84, 0x83},
	Buffer(9) {0x83, 0x82, 0x81, 0x80, 0x8f, 0x8e, 0x8d, 0x8c, 0x8b},
})

Name(p315, Package()
{
	// buffer, 32-bit integer
	0x8182838485,
	0x868788898a8b,
	0x8c8d8e8f808182,
	0x838485868788898a,
	0x8c8d8e8f80818283,
})

// Run-method
Method(TOI0,, Serialized)
{
	Name(ts, "TOI0")

	Store("TEST: TOI0, Convert data to integer", Debug)

	// From integer
	if (LEqual(F64, 1)) {
		m302(ts, 6, "p300", p300, p300, 0)
		m302(ts, 5, "p302", p302, p302, 0)
	} else {
		m302(ts, 6, "p300", p300, p300, 0)
	}

	// From hexadecimal numeric string
	if (LEqual(F64, 1)) {
		m302(ts, 32, "p304", p304, p305, 0)
		m302(ts, 32, "p306", p306, p307, 0)
	} else {
		m302(ts, 32, "p304", p304, p305, 0)
	}

	// From decimal numeric string
	if (LEqual(F64, 1)) {
		m302(ts, 21, "p308", p308, p309, 0)
		m302(ts, 21, "p310", p310, p311, 0)
	} else {
		m302(ts, 21, "p308", p308, p309, 0)
	}

	// From buffer
	if (LEqual(F64, 1)) {
		m302(ts, 4, "p312", p312, p313, 0)
		m302(ts, 5, "p314", p314, p315, 0)
	} else {
		m302(ts, 5, "p312", p312, p313, 0)
	}

	// Suppression of zeroes

	if (y602) {
		CH03(ts, z047, 0, 0, 0)
		Store("0x0123456789abcdefa", Local0)
		ToInteger(Local0, Local2)
		CH04(ts, 0, 34, z047, 1, 0, 0)

		CH03(ts, z047, 2, 0, 0)
		Store("0x000123456789abcdefa", Local0)
		ToInteger(Local0, Local2)
		CH04(ts, 0, 34, z047, 3, 0, 0)
	} else {
		Store("0x0123456789abcdefa", Local0)
		Store(0x123456789abcdefa, Local1)
		ToInteger(Local0, Local2)
		if (LNotEqual(Local2, Local1)) {
			err(ts, z047, 4, 0, 0, Local0, 0)
		}

		Store("0x000123456789abcdefa", Local0)
		ToInteger(Local0, Local2)
		if (LNotEqual(Local2, Local1)) {
			err(ts, z047, 5, 0, 0, Local0, 0)
		}
	}
}
