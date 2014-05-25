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
 * Extract Portion of Buffer or String
 */

Name(z039, 39)

Name(s200, "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*")

// Verifying 3-parameters, 1-result operator
Method(m304, 6, Serialized)
{
	Store(0, Local5)
	Store(arg1, Local3)

	While(Local3) {

		// Operands

		Multiply(Local5, 3, Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local0)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local1)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local4)

		// Expected result

		Store(DeRefOf(Index(arg4, Local5)), Local2)

		switch (ToInteger (arg5)) {
			case (0) {
				Mid(Local0, Local1, Local4, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z039, 0, 0, 0, Local5, arg2)
				}
			}
			case (1) {
				Mid(s200, Local1, Local4, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z039, 1, 0, 0, Local5, arg2)
				}
			}
		}
		Increment(Local5)
		Decrement(Local3)
	}
}

// String
Name(p362, Package()
{
	// Length > 0

	"0123456789a",
	0, 6,			// Index == 0, Index + Length < Size
	"0123456789a",
	3, 7,			// Index < Size, Index + Length < Size
	"0123456789a",
	5, 6,			// Index < Size, Index + Length == Size
	"0123456789a",
	0, 11,		// Index == 0, Index + Length == Size
	"0123456789a",
	8, 8,			// Index < Size, Index + Length > Size
	"0123456789a",
	11, 3,		// Index == Size
	"0123456789a",
	14, 1,		// Index > Size
	"0123456789a",
	0, 14,		// Index == 0, Length > Size

	// Length == 0

	"0123456789a",
	0, 0,			// Index == 0
	"0123456789a",
	5, 0,			// Index < Size
	"0123456789a",
	11, 0,		// Index == Size
	"0123456789a",
	15, 0,		// Index > Size

	// Size == 0
	"",
	0, 1,
	"",
	300, 300,
})

Name(p363, Package()
{
	"012345",
	"3456789",
	"56789a",
	"0123456789a",
	"89a",
	"",
	"",
	"0123456789a",
	"",
	"",
	"",
	"",
	"",
	"",
})

// String, Size == 200, Length > 0
Name(p364, Package()
{
	0,
	0, 125,	// Index == 0, Index + Length < Size
	0,
	67, 67,	// Index < Size, Index + Length < Size
	0,
	93, 107,	// Index < Size, Index + Length == Size
	0,
	0, 200,	// Index == 0, Index + Length == Size
	0,
	127, 100,	// Index < Size, Index + Length > Size
	0,
	200, 3,	// Index == Size
	0,
	214, 1,	// Index > Size
	0,
	0, 201,	// Index == 0, Length > Size
})

Name(p365, Package()
{
	"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>",
	"defghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFG",
	"~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
	"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
	"ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
	"",
	"",
	"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
})

// Buffer
Name(p366, Package()
{
	// Length > 0

	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  7,  8, 9, 0},
	0, 6,			// Index == 0, Index + Length < Size
	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  7,  8, 9, 0},
	3, 7,			// Index < Size, Index + Length < Size
	Buffer(11) {0, 1,  2,  3,  4,  5,  0,  7,  8, 9, 0},
	3, 7,			// Index < Size, Index + Length < Size
	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  7,  8, 9, 0},
	5, 6,			// Index < Size, Index + Length == Size
	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  7,  8, 9, 0},
	0, 11,		// Index == 0, Index + Length == Size
	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  7,  8, 9, 0},
	8, 8,			// Index < Size, Index + Length > Size
	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  7,  8, 9, 0},
	0, 201,		// Index == 0, Length > Size

	// Length > 200
	Buffer(211) {
		  1,  2,  3,  4,  5,  6,  7,  8,  9,  0,  0,
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
		193,194,195,196,197,198,199,200},
	2, 203,
})

Name(p367, Package()
{
	Buffer(6) {0,  1,  2,  3,  4,  5},
	Buffer(7) {3,  4,  5,  6,  7,  8, 9},
	Buffer(7) {3,  4,  5,  0,  7,  8, 9},
	Buffer(6) {5,  6,  7,  8,  9, 0},
	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  7,  8, 9, 0},
	Buffer(3) {8, 9, 0},
	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  7,  8, 9, 0},
	Buffer(203) {
		  3,  4,  5,  6,  7,  8,  9,  0,  0,
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
		193,194},
})

// Buffer, Mid() results in Buffer(0){}
Name(p368, Package()
{
	// Length > 0
	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  7,  8, 9, 0},
	11, 3,			// Index == Size
	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  7,  8, 9, 0},
	14, 1,			// Index > Size

	// Length == 0
	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  7,  8, 9, 0},
	0, 0,				// Index == 0
	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  0,  8, 9, 0},
	5, 0,				// Index < Size
	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  7,  8, 9, 0},
	11, 0,			// Index == Size
	Buffer(11) {0, 1,  2,  3,  4,  5,  6,  7,  8, 9, 0},
	15, 0,			// Index > Size
})

// Run-method
Method(MID0,, Serialized)
{
	Name(ts, "MID0")

	Store("TEST: MID0, Extract Portion of Buffer or String", Debug)

	// String
	m304(ts, 14, "p362", p362, p363, 0)

	// String, Size == 200, Length > 0
	m304(ts, 8, "p364", p364, p365, 1)

	// Buffer
	m304(ts, 8, "p366", p366, p367, 0)

	// Prepare Package of Buffer(0){} elements
	Store(Package(6){}, Local5)
	Store(0, Local1)
	Store(0, Local0)
	While(LLess(Local0, 6)) {
		Store(Buffer(Local1) {}, Index(Local5, Local0))
		Increment(Local0)
	}

	// Buffer, Mid() results in Buffer(0){}
	m304(ts, 6, "p366", p368, Local5, 0)

	// Buffer, Mid(Buffer(0){})
	Mid(Buffer(Local1) {}, 0, 1, Local7)
	if (LNotEqual(Local7, Buffer(Local1) {})) {
		err(ts, z039, 2, 0, 0, 0, "Buffer(0)")
	}
	Mid(Buffer(Local1) {}, 300, 300, Local7)
	if (LNotEqual(Local7, Buffer(Local1) {})) {
		err(ts, z039, 3, 0, 0, 0, "Buffer(0)")
	}
}
