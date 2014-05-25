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
 * Logical operators
 */

Name(z035, 35)

// Verifying 2-parameters, 1-result operator
Method(m003, 6, Serialized)
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
				Store(LNotEqual(Local0, Local1), Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z035, 0, 0, 0, Local5, arg2)
				}
				Store(LNotEqual(Local1, Local0), Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z035, 1, 0, 0, Local5, arg2)
				}
			}
			case (1) {
				Store(LAnd(Local0, Local1), Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z035, 2, 0, 0, Local5, arg2)
				}
				Store(LAnd(Local1, Local0), Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z035, 3, 0, 0, Local5, arg2)
				}
			}
			case (2) {
				Store(LOr(Local0, Local1), Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z035, 4, 0, 0, Local5, arg2)
				}
				Store(LOr(Local1, Local0), Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z035, 5, 0, 0, Local5, arg2)
				}
			}
			case (3) {
				Store(LEqual(Local0, Local1), Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z035, 6, 0, 0, Local5, arg2)
				}
				Store(LEqual(Local1, Local0), Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z035, 7, 0, 0, Local5, arg2)
				}
			}
			case (4) {
				Store(LGreater(Local0, Local1), Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z035, 8, 0, 0, Local5, arg2)
				}
			}
			case (5) {
				Store(LGreaterEqual(Local0, Local1), Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z035, 9, 0, 0, Local5, arg2)
				}
			}
			case (6) {
				Store(LLess(Local0, Local1), Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z035, 10, 0, 0, Local5, arg2)
				}
			}
			case (7) {
				Store(LLessEqual(Local0, Local1), Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z035, 11, 0, 0, Local5, arg2)
				}
			}
		}

		if (0) {
			Store("==============:", Debug)
			Store(Local0, Debug)
			Store(Local1, Debug)
			Store(Local2, Debug)
			Store(Local7, Debug)
			Store("==============", Debug)
		}

		Increment(Local5)
		Decrement(Local3)
	}
}

// Verifying 1-parameter, 1-result operator
Method(m004, 6, Serialized)
{
	Store(0, Local5)
	Store(arg1, Local3)

	While(Local3) {

		// Operand

		Store(DeRefOf(Index(arg3, Local5)), Local0)

		// Expected result

		Store(DeRefOf(Index(arg4, Local5)), Local1)

		switch (ToInteger (arg5)) {
			case (0) {
				Store(LNot(Local0), Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z035, 12, 0, 0, Local5, arg2)
				}
			}
		}
		Increment(Local5)
		Decrement(Local3)
	}
}

// ====================================================== //
//    Generic operands utilized by different operators    //
// ====================================================== //

Name(p060, Package()
{
	// 32-bit integers

	0x12345678, 0x12345678,
	0xf2345678, 0xf2345678,
	0x00000000, 0x00000000,
	0xffffffff, 0xffffffff,
	0x04000000, 0x00000010,
	0x20000000, 0x40000000,
	0x80000000, 0x00000001,
	0x40000000, 0x80000000,
	0x04000000, 0x000000ff,
	0x000000ff, 0x00100000,
	0,          0x00000080,
	0,          0x00008000,
	0,          0x80000000,
})

Name(p061, Package()
{
	// 64-bit integers

	0x12345678bdefac98, 0x12345678bdefac98,
	0xf234567811994657, 0xf234567811994657,
	0, 0,
	0xffffffffffffffff, 0xffffffffffffffff,
	0x0400000000000000, 0x0000001000000000,
	0x2000000000000000, 0x4000000000000000,
	0x8000000000000000, 0x0000000000000001,
	0x4000000000000000, 0x8000000000000000,
	0x0400000000000000, 0x00000000000000ff,
	0x00000000000000ff, 0x0000000000100000,
	0,                  0x0000000080000000,
	0,                  0x8000000000000000,
})

Name(p062, Package()
{
	// 32-bit integers

	0,
	0xffffffff,
	0x000000ff,
	0x00000010,
	0x12334567,
	0x9bcdfe18,
})

Name(p063, Package()
{
	// 64-bit integers

	0,
	0xffffffffffffffff,
	0x12334567bdcfeb46,
	0xfbdec6709bcdfe18,
})

Name(p064, Package()
{
	// Strings

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

	"mnbvcxzlk\x48jhgf", "mnbvcxzlk\x48jhgf",
	"mnbvcxzlk\x48jhgf", "mnbvcxzlk\x49jhgf",
	"mnbvcxzlk\x49jhgf", "mnbvcxzlk\x48jhgf",

	"mnbvcxzlk\x48jhgf0", "mnbvcxzlk\x48jhgf",
	"mnbvcxzlk\x48jhgf0", "mnbvcxzlk\x49jhgf",
	"mnbvcxzlk\x49jhgf0", "mnbvcxzlk\x48jhgf",

	"mnbvcxzlk\x48jhgf", "mnbvcxzlk\x48jhgf0",
	"mnbvcxzlk\x48jhgf", "mnbvcxzlk\x49jhgf0",
	"mnbvcxzlk\x49jhgf", "mnbvcxzlk\x48jhgf0",

	"mnbvcxzlk\x49\x48jhgf", "mnbvcxzlk\x48\x49jhgf",
	"mnbvcxzlk\x48\x49jhgf", "mnbvcxzlk\x49\x48jhgf",
})

Name(p065, Package()
{
	// Buffers

	Buffer(){ 0, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },
	Buffer(){ 0, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },

	Buffer(){ 0, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },
	Buffer(){    0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },

	Buffer(){    0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },
	Buffer(){ 0, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },

	Buffer(){ 0, 0, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },
	Buffer(){    0, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },

	Buffer(){    0, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },
	Buffer(){ 0, 0, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },


	Buffer(){ 0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },
	Buffer(){ 0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },

	Buffer(){ 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0 },
	Buffer(){ 0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },

	Buffer(){ 0x20, 0x21, 0x22, 0x23, 0x24, 0x25 },
	Buffer(){ 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0 },

	Buffer(){ 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0, 0 },
	Buffer(){ 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0 },

	Buffer(){ 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0 },
	Buffer(){ 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0, 0 },


	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x25 },
	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x25 },

	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x25 },
	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x26 },

	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x26 },
	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x25 },

	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x25, 0 },
	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x25 },

	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x25 },
	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x25, 0 },


	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x25, 0, 0 },
	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x25, 0 },

	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x25, 0 },
	Buffer(){ 0x20, 0x21, 0x22, 0,    0x24, 0x25, 0, 0 },


	Buffer(100){},
	Buffer(100){},

	Buffer(100){},
	Buffer(101){},

	Buffer(100){},
	Buffer(99){},

	Buffer(){""},
	Buffer(){""},

	Buffer(){" "},
	Buffer(){""},

	Buffer(){""},
	Buffer(){" "},

	Buffer(){" "},
	Buffer(){" "},

	Buffer(){"  "},
	Buffer(){" "},

	Buffer(){" "},
	Buffer(){"  "},

	Buffer(){"a"},
	Buffer(){""},

	Buffer(){""},
	Buffer(){"a"},

	Buffer(){" a"},
	Buffer(){"a"},

	Buffer(){"a"},
	Buffer(){" a"},

	Buffer(){"a "},
	Buffer(){"a"},

	Buffer(){"a"},
	Buffer(){"a "},

	Buffer(){"a b"},
	Buffer(){"ab"},

	Buffer(){"ab"},
	Buffer(){"a b"},

	Buffer(){"a  b"},
	Buffer(){"a b"},

	Buffer(){"a b"},
	Buffer(){"a  b"},

	Buffer(){"abcDef"},
	Buffer(){"abcdef"},


	Buffer(){"asdfGHJKLIq0987654312"},
	Buffer(){"asdfGHJKLIq0987654312"},

	Buffer(){"asdfGHJKLIq0987654312"},
	Buffer(){"asdfGHJKLIq09876543123"},

	Buffer(){"asdfGHJKLIq0987654312"},
	Buffer(){"asdfGHJKLIq098765431"},

	Buffer(){"mnbvcxzlk\x48jhgf"},
	Buffer(){"mnbvcxzlk\x48jhgf"},

	Buffer(){"mnbvcxzlk\x48jhgf"},
	Buffer(){"mnbvcxzlk\x49jhgf"},

	Buffer(){"mnbvcxzlk\x49jhgf"},
	Buffer(){"mnbvcxzlk\x48jhgf"},


	Buffer(){"mnbvcxzlk\x48jhgf0"},
	Buffer(){"mnbvcxzlk\x48jhgf"},

	Buffer(){"mnbvcxzlk\x48jhgf0"},
	Buffer(){"mnbvcxzlk\x49jhgf"},

	Buffer(){"mnbvcxzlk\x49jhgf0"},
	Buffer(){"mnbvcxzlk\x48jhgf"},


	Buffer(){"mnbvcxzlk\x48jhgf"},
	Buffer(){"mnbvcxzlk\x48jhgf0"},

	Buffer(){"mnbvcxzlk\x48jhgf"},
	Buffer(){"mnbvcxzlk\x49jhgf0"},

	Buffer(){"mnbvcxzlk\x49jhgf"},
	Buffer(){"mnbvcxzlk\x48jhgf0"},

	Buffer(){"mnbvcxzlk\x49\x48jhgf"},
	Buffer(){"mnbvcxzlk\x48\x49jhgf"},

	Buffer(){"mnbvcxzlk\x48\x49jhgf"},
	Buffer(){"mnbvcxzlk\x49\x48jhgf"},
})

// ===================================== LAnd

Name(p05d, Package()
{
	Ones, Ones, Zero, Ones, Ones, Ones, Ones,
	Ones, Ones, Ones, Zero, Zero, Zero,
})

Name(p05e, Package()
{
	Ones, Ones, Zero, Ones, Ones, Ones,
	Ones, Ones, Ones, Ones, Zero, Zero,
})

Method(LAN0,, Serialized)
{
	Name(ts, "LAN0")

	Store("TEST: LAN0, Logical And", Debug)

	// Integers

	if (LEqual(F64, 1)) {
		m003(ts, c002, "p060", p060, p05d, 1)
		m003(ts, c003, "p061", p061, p05e, 1)
	} else {
		m003(ts, c002, "p060", p060, p05d, 1)
	}
}

// ===================================== LNot

Name(p05f, Package()
{
	Ones, Zero, Zero, Zero, Zero, Zero,
})

Name(p070, Package()
{
	Ones, Zero, Zero, Zero,
})

Method(LN00,, Serialized)
{
	Name(ts, "LN00")

	Store("TEST: LN00, Logical Not", Debug)

	// Integers

	if (LEqual(F64, 1)) {
		m004(ts, c004, "p062", p062, p05f, 0)
		m004(ts, c005, "p063", p063, p070, 0)
	} else {
		m004(ts, c004, "p062", p062, p05f, 0)
	}
}

// ===================================== LOr

Name(p071, Package()
{
	Ones, Ones, Zero, Ones, Ones, Ones, Ones,
	Ones, Ones, Ones, Ones, Ones, Ones,
})

Name(p072, Package()
{
	Ones, Ones, Zero, Ones, Ones, Ones,
	Ones, Ones, Ones, Ones, Ones, Ones,
})

Method(LOR0,, Serialized)
{
	Name(ts, "LOR0")

	Store("TEST: LOR0, Logical Or", Debug)

	// Integers

	if (LEqual(F64, 1)) {
		m003(ts, c002, "p060", p060, p071, 2)
		m003(ts, c003, "p061", p061, p072, 2)
	} else {
		m003(ts, c002, "p060", p060, p071, 2)
	}
}

// ===================================== LEqual

Name(p073, Package()
{
	Ones, Ones, Ones, Ones, Zero, Zero, Zero,
	Zero, Zero, Zero, Zero, Zero, Zero,
})

Name(p074, Package()
{
	Ones, Ones, Ones, Ones, Zero, Zero, Zero,
	Zero, Zero, Zero, Zero, Zero,
})

Name(p075, Package()
{
	Ones, Zero, Zero, Ones, Zero, Zero, Ones, Zero,
	Zero, Zero, Zero, Zero, Zero, Zero, Zero, Zero,
	Zero, Zero, Zero, Zero, Ones, Zero, Zero, Zero,
	Zero, Zero, Zero, Zero, Zero, Zero, Zero,
})

Name(p076, Package()
{
	Ones, Zero, Zero, Zero, Zero, Ones, Zero, Zero,
	Zero, Zero, Ones, Zero, Zero, Zero, Zero, Zero,
	Zero,

	Ones, Zero, Zero, Ones, Zero, Zero, Ones, Zero,
	Zero, Zero, Zero, Zero, Zero, Zero, Zero, Zero,
	Zero, Zero, Zero, Zero, Ones, Zero, Zero, Ones,
	Zero, Zero, Zero, Zero, Zero, Zero, Zero, Zero,
	Zero, Zero,
})

Method(LEQ0,, Serialized)
{
	Name(ts, "LEQ0")

	Store("TEST: LEQ0, Logical Equal", Debug)

	// Integers

	if (LEqual(F64, 1)) {
		m003(ts, c002, "p060", p060, p073, 3)
		m003(ts, c003, "p061", p061, p074, 3)
	} else {
		m003(ts, c002, "p060", p060, p073, 3)
	}

	// Strings

	m003(ts, c006, "p064", p064, p075, 3)

	Store(LEqual(BIG0, BIG0), Local0)
	if (LNotEqual(Local0, Ones)) {
		err(ts, z035, 13, 0, 0, 0, 0)
	}

	// Buffers

	m003(ts, c007, "p065", p065, p076, 3)
}

// ===================================== LGreater

Name(p077, Package()
{
	Zero, Zero, Zero, Zero, Ones, Zero, Ones,
	Zero, Ones, Zero, Zero, Zero, Zero,
})

Name(p078, Package()
{
	Zero, Zero, Zero, Zero, Ones, Zero, Ones,
	Zero, Ones, Zero, Zero, Zero,
})

Name(p079, Package()
{
	Zero, Zero, Ones, Zero, Ones, Zero, Zero, Ones,
	Zero, Ones, Zero, Zero, Ones, Ones, Zero, Zero,
	Ones, Zero, Ones, Zero, Zero, Zero, Ones, Ones,
	Zero, Ones, Zero, Zero, Ones, Ones, Zero,
})

Name(p07a, Package()
{
	Zero, Zero, Ones, Zero, Ones, Zero, Ones, Zero,
	Ones, Zero, Zero, Zero, Ones, Ones, Zero, Ones,
	Zero,

	Zero, Zero, Ones, Zero, Ones, Zero, Zero, Ones,
	Zero, Ones, Zero, Zero, Ones, Ones, Zero, Zero,
	Ones, Zero, Ones, Zero, Zero, Zero, Ones, Zero,
	Zero, Ones, Ones, Zero, Ones, Zero, Zero, Ones,
	Ones, Zero,
})

Method(LGR0,, Serialized)
{
	Name(ts, "LGR0")

	Store("TEST: LGR0, Logical Greater", Debug)

	// Integers

	if (LEqual(F64, 1)) {
		m003(ts, c002, "p060", p060, p077, 4)
		m003(ts, c003, "p061", p061, p078, 4)
	} else {
		m003(ts, c002, "p060", p060, p077, 4)
	}

	// Strings

	m003(ts, c006, "p064", p064, p079, 4)

	Store(LGreater(BIG0, BIG0), Local0)
	if (LNotEqual(Local0, Zero)) {
		err(ts, z035, 14, 0, 0, 0, 0)
	}

	// Buffers

	m003(ts, c007, "p065", p065, p07a, 4)
}

// ===================================== LGreaterEqual

Name(p07b, Package()
{
	Ones, Ones, Ones, Ones, Ones, Zero, Ones,
	Zero, Ones, Zero, Zero, Zero, Zero,
})

Name(p07c, Package()
{
	Ones, Ones, Ones, Ones, Ones, Zero, Ones,
	Zero, Ones, Zero, Zero, Zero,
})

Name(p07d, Package()
{
	Ones, Zero, Ones, Ones, Ones, Zero, Ones, Ones,
	Zero, Ones, Zero, Zero, Ones, Ones, Zero, Zero,
	Ones, Zero, Ones, Zero, Ones, Zero, Ones, Ones,
	Zero, Ones, Zero, Zero, Ones, Ones, Zero,
})

Name(p07e, Package()
{
	Ones, Zero, Ones, Zero, Ones, Ones, Ones, Zero,
	Ones, Zero, Ones, Zero, Ones, Ones, Zero, Ones,
	Zero,

	Ones, Zero, Ones, Ones, Ones, Zero, Ones, Ones,
	Zero, Ones, Zero, Zero, Ones, Ones, Zero, Zero,
	Ones, Zero, Ones, Zero, Ones, Zero, Ones, Ones,
	Zero, Ones, Ones, Zero, Ones, Zero, Zero, Ones,
	Ones, Zero,
})

Method(LGE0,, Serialized)
{
	Name(ts, "LGE0")

	Store("TEST: LGE0, Logical Greater Than Or Equal", Debug)

	// Integers

	if (LEqual(F64, 1)) {
		m003(ts, c002, "p060", p060, p07b, 5)
		m003(ts, c003, "p061", p061, p07c, 5)
	} else {
		m003(ts, c002, "p060", p060, p07b, 5)
	}

	// Strings

	m003(ts, c006, "p064", p064, p07d, 5)

	Store(LGreaterEqual(BIG0, BIG0), Local0)
	if (LNotEqual(Local0, Ones)) {
		err(ts, z035, 15, 0, 0, 0, 0)
	}

	// Buffers

	m003(ts, c007, "p065", p065, p07e, 5)
}

// ===================================== LLess

Name(p07f, Package()
{
	Zero, Zero, Zero, Zero, Zero, Ones, Zero,
	Ones, Zero, Ones, Ones, Ones, Ones,
})

Name(p080, Package()
{
	Zero, Zero, Zero, Zero, Zero, Ones, Zero,
	Ones, Zero, Ones, Ones, Ones,
})

Name(p081, Package()
{
	Zero, Ones, Zero, Zero, Zero, Ones, Zero, Zero,
	Ones, Zero, Ones, Ones, Zero, Zero, Ones, Ones,
	Zero, Ones, Zero, Ones, Zero, Ones, Zero, Zero,
	Ones, Zero, Ones, Ones, Zero, Zero, Ones,
})

Name(p082, Package()
{
	Zero, Ones, Zero, Ones, Zero, Zero, Zero, Ones,
	Zero, Ones, Zero, Ones, Zero, Zero, Ones, Zero,
	Ones,

	Zero, Ones, Zero, Zero, Zero, Ones, Zero, Zero,
	Ones, Zero, Ones, Ones, Zero, Zero, Ones, Ones,
	Zero, Ones, Zero, Ones, Zero, Ones, Zero, Zero,
	Ones, Zero, Zero, Ones, Zero, Ones, Ones, Zero,
	Zero, Ones,
})

Method(LL00,, Serialized)
{
	Name(ts, "LL00")

	Store("TEST: LL00, Logical Less", Debug)

	// Integers

	if (LEqual(F64, 1)) {
		m003(ts, c002, "p060", p060, p07f, 6)
		m003(ts, c003, "p061", p061, p080, 6)
	} else {
		m003(ts, c002, "p060", p060, p07f, 6)
	}

	// Strings

	m003(ts, c006, "p064", p064, p081, 6)

	Store(LLess(BIG0, BIG0), Local0)
	if (LNotEqual(Local0, Zero)) {
		err(ts, z035, 16, 0, 0, 0, 0)
	}

	// Buffers

	m003(ts, c007, "p065", p065, p082, 6)
}

// ===================================== LLessEqual

Name(p083, Package()
{
	Ones, Ones, Ones, Ones, Zero, Ones, Zero,
	Ones, Zero, Ones, Ones, Ones, Ones,
})

Name(p084, Package()
{
	Ones, Ones, Ones, Ones, Zero, Ones, Zero,
	Ones, Zero, Ones, Ones, Ones,
})

Name(p085, Package()
{
	Ones, Ones, Zero, Ones, Zero, Ones, Ones, Zero,
	Ones, Zero, Ones, Ones, Zero, Zero, Ones, Ones,
	Zero, Ones, Zero, Ones, Ones, Ones, Zero, Zero,
	Ones, Zero, Ones, Ones, Zero, Zero, Ones,
})

Name(p086, Package()
{
	Ones, Ones, Zero, Ones, Zero, Ones, Zero, Ones,
	Zero, Ones, Ones, Ones, Zero, Zero, Ones, Zero,
	Ones,

	Ones, Ones, Zero, Ones, Zero, Ones, Ones, Zero,
	Ones, Zero, Ones, Ones, Zero, Zero, Ones, Ones,
	Zero, Ones, Zero, Ones, Ones, Ones, Zero, Ones,
	Ones, Zero, Zero, Ones, Zero, Ones, Ones, Zero,
	Zero, Ones,
})

Method(LLE0,, Serialized)
{
	Name(ts, "LLE0")

	Store("TEST: LLE0, Logical Less Than Or Equal", Debug)

	// Integers

	if (LEqual(F64, 1)) {
		m003(ts, c002, "p060", p060, p083, 7)
		m003(ts, c003, "p061", p061, p084, 7)
	} else {
		m003(ts, c002, "p060", p060, p083, 7)
	}

	// Strings

	m003(ts, c006, "p064", p064, p085, 7)

	Store(LLessEqual(BIG0, BIG0), Local0)
	if (LNotEqual(Local0, Ones)) {
		err(ts, z035, 17, 0, 0, 0, 0)
	}

	// Buffers

	m003(ts, c007, "p065", p065, p086, 7)
}

// ===================================== LNotEqual

Name(p087, Package()
{
	Zero, Zero, Zero, Zero, Ones, Ones, Ones,
	Ones, Ones, Ones, Ones, Ones, Ones,
})

Name(p088, Package()
{
	Zero, Zero, Zero, Zero, Ones, Ones, Ones,
	Ones, Ones, Ones, Ones, Ones,
})

Name(p089, Package()
{
	Zero, Ones, Ones, Zero, Ones, Ones, Zero, Ones,
	Ones, Ones, Ones, Ones, Ones, Ones, Ones, Ones,
	Ones, Ones, Ones, Ones, Zero, Ones, Ones, Ones,
	Ones, Ones, Ones, Ones, Ones, Ones, Ones,
})

Name(p08a, Package()
{
	Zero, Ones, Ones, Ones, Ones, Zero, Ones, Ones,
	Ones, Ones, Zero, Ones, Ones, Ones, Ones, Ones,
	Ones,

	Zero, Ones, Ones, Zero, Ones, Ones, Zero, Ones,
	Ones, Ones, Ones, Ones, Ones, Ones, Ones, Ones,
	Ones, Ones, Ones, Ones, Zero, Ones, Ones, Zero,
	Ones, Ones, Ones, Ones, Ones, Ones, Ones, Ones,
	Ones, Ones,
})

Method(LNE0,, Serialized)
{
	Name(ts, "LNE0")

	Store("TEST: LNE0, Logical Not equal", Debug)

	// Integers

	if (LEqual(F64, 1)) {
		m003(ts, c002, "p060", p060, p087, 0)
		m003(ts, c003, "p061", p061, p088, 0)
	} else {
		m003(ts, c002, "p060", p060, p087, 0)
	}

	// Strings

	m003(ts, c006, "p064", p064, p089, 0)

	Store(LNotEqual(BIG0, BIG0), Local0)
	if (LNotEqual(Local0, Zero)) {
		err(ts, z035, 18, 0, 0, 0, 0)
	}

	// Buffers

	m003(ts, c007, "p065", p065, p08a, 0)
}

// Run-method
Method(LOG0)
{
	SRMT("LAN0")
	LAN0()
	SRMT("LN00")
	LN00()
	SRMT("LOR0")
	LOR0()
	SRMT("LEQ0")
	LEQ0()
	SRMT("LGR0")
	LGR0()
	SRMT("LGE0")
	LGE0()
	SRMT("LL00")
	LL00()
	SRMT("LLE0")
	LLE0()
	SRMT("LNE0")
	LNE0()
}
