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
 *
 * Concatenate two strings, integers or buffers
 */

/*
// !!!!!!!!!!!!!!!!!!!!!!!!!! ???????????????????
// SEE: (Compare two buffers)
// Remove (?) this method and replace it with the
// LNotEqual, LEqual............ ????? !!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/

Name(z036, 36)


// Compare two buffers
//
// Arg0 - name
// Arg1 - buffer1
// Arg2 - buffer2
// Arg3 - length
Method(m310, 4)
{
	Store(0, Local0)
	While (LLess(Local0, arg3)) {
		Store(Derefof(Index(arg1, Local0)), Local1)
		Store(Derefof(Index(arg2, Local0)), Local2)
		if (LNotEqual(Local1, Local2)) {
			return (Ones)
		}
		Increment(Local0)
	}

	return (Zero)
}

// Compare two buffers
//
// Arg0 - name
// Arg1 - buffer1
// Arg2 - buffer2
Method(m311, 3)
{
	if (LNotequal(ObjectType(arg1), 3)) {
		err("m311: unexpected type of Arg1", z036, 0, 0, 0, 0, 0)
		return (Ones)
	}

	if (LNotequal(ObjectType(arg2), 3)) {
		err("m311: unexpected type of Arg2", z036, 1, 0, 0, 0, 0)
		return (Ones)
	}

	Store(Sizeof(arg1), Local0)

	if (LNotEqual(Local0, Sizeof(arg2))) {
		return (Ones)
	}

	if (m310(Arg0, Arg1, Arg2, Local0)) {
		return (Ones)
	}

	return (Zero)
}

// Verifying 2-parameters, 1-result operator
Method(m312, 6, Serialized)
{
	Store(0, Local5)
	Store(arg1, Local3)

	While(Local3) {

		// Operands

		Multiply(Local5, 2, Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local0)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local1)

		// Expected result

		Store(DeRefOf(Index(arg4, Local5)), Local2)

		switch (ToInteger (arg5)) {
			case (0) {
				// Results in buffer
				Concatenate(Local0, Local1, Local7)

				if (m311(Arg0, Local7, Local2)) {
					err(arg0, z036, 2, 0, 0, Local5, arg2)
				}
			}
			case (1) {
				// Results in string

				Concatenate(Local0, Local1, Local7)

				if (LNotequal(ObjectType(Local7), 2)) {
					err(arg0, z036, 3, 0, 0, Local7, arg2)
				} elseif (LNotequal(ObjectType(Local2), 2)) {
					err(arg0, z036, 4, 0, 0, Local2, arg2)
				} elseif (LNotEqual(Local7, Local2)) {
					err(arg0, z036, 5, 0, 0, Local7, arg2)
				}
			}
		}

		Increment(Local5)
		Decrement(Local3)
	}
}

// Integers
Method(m313,, Serialized)
{
	Name(ts, "m313")

	Name(p000, Package()
	{
		0, 0,
		0xffffffff, 0xffffffff,
		0, 0xffffffff,
		0, 0x81,
		0, 0x9ac6,
		0, 0xab012345,
		0x92, 0x81,
		0x93, 0x8476,
		0xab, 0xdc816778,
		0xac93, 0x8476,
		0xf63b, 0x8c8fc2da,
		0x8790f6a4, 0x98de45ba,
	})

	Name(p001, Package()
	{
		Buffer() { 0, 0, 0, 0, 0, 0, 0, 0 },
		Buffer() { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
		Buffer() { 0, 0, 0, 0, 0xff, 0xff, 0xff, 0xff },
		Buffer() { 0, 0, 0, 0, 0x81, 0, 0, 0 },
		Buffer() { 0, 0, 0, 0, 0xc6, 0x9a, 0, 0 },
		Buffer() { 0, 0, 0, 0, 0x45, 0x23, 0x01, 0xab },
		Buffer() { 0x92, 0, 0, 0, 0x81, 0, 0, 0 },
		Buffer() { 0x93, 0, 0, 0, 0x76, 0x84, 0, 0 },
		Buffer() { 0xab, 0, 0, 0, 0x78, 0x67, 0x81, 0xdc },
		Buffer() { 0x93, 0xac, 0, 0, 0x76, 0x84, 0, 0 },
		Buffer() { 0x3b, 0xf6, 0, 0, 0xda, 0xc2, 0x8f, 0x8c },
		Buffer() { 0xa4, 0xf6, 0x90, 0x87, 0xba, 0x45, 0xde, 0x98 },
	})

	Name(p002, Package()
	{
		Buffer() { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		Buffer() { 0xff, 0xff, 0xff, 0xff, 0, 0, 0, 0, 0xff, 0xff, 0xff, 0xff, 0, 0, 0, 0 },
		Buffer() { 0, 0, 0, 0, 0, 0, 0, 0, 0xff, 0xff, 0xff, 0xff, 0, 0, 0, 0 },
		Buffer() { 0, 0, 0, 0, 0, 0, 0, 0, 0x81, 0, 0, 0, 0, 0, 0, 0 },
		Buffer() { 0, 0, 0, 0, 0, 0, 0, 0, 0xc6, 0x9a, 0, 0, 0, 0, 0, 0 },
		Buffer() { 0, 0, 0, 0, 0, 0, 0, 0, 0x45, 0x23, 0x01, 0xab, 0, 0, 0, 0 },
		Buffer() { 0x92, 0, 0, 0, 0, 0, 0, 0, 0x81, 0, 0, 0, 0, 0, 0, 0 },
		Buffer() { 0x93, 0, 0, 0, 0, 0, 0, 0, 0x76, 0x84, 0, 0, 0, 0, 0, 0 },
		Buffer() { 0xab, 0, 0, 0, 0, 0, 0, 0, 0x78, 0x67, 0x81, 0xdc, 0, 0, 0, 0 },
		Buffer() { 0x93, 0xac, 0, 0, 0, 0, 0, 0, 0x76, 0x84, 0, 0, 0, 0, 0, 0 },
		Buffer() { 0x3b, 0xf6, 0, 0, 0, 0, 0, 0, 0xda, 0xc2, 0x8f, 0x8c, 0, 0, 0, 0 },
		Buffer() { 0xa4, 0xf6, 0x90, 0x87, 0, 0, 0, 0, 0xba, 0x45, 0xde, 0x98, 0, 0, 0, 0 },
	})

	Name(p003, Package()
	{
		0xffffffffffffffff, 0xffffffffffffffff,
		0x1234567890abcdef, 0x1122334455667788,
	})

	Name(p004, Package()
	{
		Buffer() { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
		Buffer() { 0xef, 0xcd, 0xab, 0x90, 0x78, 0x56, 0x34, 0x12,
				0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11 },
	})


	if (LEqual(F64, 1)) {
		m312(ts, 12, "p000", p000, p002, 0)
		m312(ts, 2, "p003", p003, p004, 0)
	} else {
		m312(ts, 12, "p000", p000, p001, 0)
	}
}

// Strings
Method(m314,, Serialized)
{
	Name(ts, "m314")

	Name(p000, Package()
	{
		"qwertyuiop", "qwertyuiop",
		"qwertyuiop", "qwertyuiop0",
		"qwertyuiop", "qwertyuio",

		"", "",
		" ", "",
		"", " ",
		" ", " ",
		"  ", " ",
		" ", "  ",

		"a", "",
		"", "a",
		" a", "a",
		"a", " a",
		"a ", "a",
		"a", "a ",
		"a b", "ab",
		"ab", "a b",
		"a  b", "a b",
		"a b", "a  b",
		"abcDef", "abcdef",

		// 100 + 100
		"0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789",
		"0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789",

		"0", "",
	})

	Name(p001, Package()
	{
		"qwertyuiopqwertyuiop",
		"qwertyuiopqwertyuiop0",
		"qwertyuiopqwertyuio",

		"",
		" ",
		" ",
		"  ",
		"   ",
		"   ",

		"a",
		"a",
		" aa",
		"a a",
		"a a",
		"aa ",
		"a bab",
		"aba b",
		"a  ba b",
		"a ba  b",
		"abcDefabcdef",
		"01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789",
	})

	m312(ts, 21, "p000", p000, p001, 1)
}

// Buffers
Method(m315,, Serialized)
{
	Name(ts, "m314")

	Name(p000, Package()
	{
		Buffer(100){},
		Buffer(101){},
	})

	Name(p001, Package()
	{
		Buffer(201){},
	})

	Name(p002, Package()
	{
	Buffer() {1, 1,  2,  3,  4},
	Buffer() {1,  2,  3,  4,  5,  6,  7,  8,
		  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
		 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
		 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
		 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
		 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
		 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
		 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,
		113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128},
	Buffer() {
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
		193,194,195,196,197,198,199,200,
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
		241,242,243,244,245,246,247,248,249,250,251,252,253,254,255, 0, 1},
	})

	m312(ts, 1, "p000", p000, p001, 0)
	m312(ts, 3, "p325", p325, p002, 0)
}

// Run-method
Method(CCT0)
{
	Store("TEST: CCT0, Concatenate two strings, integers or buffers", Debug)

	m313()
	m314()
	m315()
}


