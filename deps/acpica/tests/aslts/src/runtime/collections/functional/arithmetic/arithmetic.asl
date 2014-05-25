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
 * Integer arithmetic
 */

Name(z083, 83)

// Verifying 2-parameters, 1-result operator
Method(m000, 6, Serialized)
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
				Add(Local0, Local1, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 0, 0, 0, Local5, arg2)
				}
				Add(Local1, Local0, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 1, 0, 0, Local5, arg2)
				}
			}
			case (1) {
				Subtract(Local0, Local1, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 2, 0, 0, Local5, arg2)
				}
			}
			case (2) {
				Multiply(Local0, Local1, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 3, 0, 0, Local5, arg2)
				}
				Multiply(Local1, Local0, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 4, 0, 0, Local5, arg2)
				}
			}
			case (3) {
				And(Local0, Local1, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 5, 0, 0, Local5, arg2)
				}
				And(Local1, Local0, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 6, 0, 0, Local5, arg2)
				}
			}
			case (4) {
				Nand(Local0, Local1, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 7, 0, 0, Local5, arg2)
				}
				Nand(Local1, Local0, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 8, 0, 0, Local5, arg2)
				}
			}
			case (5) {
				Nor(Local0, Local1, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 9, 0, 0, Local5, arg2)
				}
				Nor(Local1, Local0, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 10, 0, 0, Local5, arg2)
				}
			}
			case (6) {
				Or(Local0, Local1, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 11, 0, 0, Local5, arg2)
				}
				Or(Local1, Local0, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 12, 0, 0, Local5, arg2)
				}
			}
			case (7) {
				Xor(Local0, Local1, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 13, 0, 0, Local5, arg2)
				}
				Xor(Local1, Local0, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 14, 0, 0, Local5, arg2)
				}
			}
			case (8) {
				Mod(Local0, Local1, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 15, 0, 0, Local5, arg2)
				}
			}
			case (9) {
				ShiftLeft(Local0, Local1, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 16, 0, 0, Local5, arg2)
				}
			}
			case (10) {
				ShiftRight(Local0, Local1, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 17, 0, 0, Local5, arg2)
				}
			}
		}
		Increment(Local5)
		Decrement(Local3)
	}
}

// Verifying 2-parameters, 2-results operator
Method(m001, 6, Serialized)
{
	Store(0, Local5)
	Store(arg1, Local4)

	While(Local4) {

		// Operands

		Multiply(Local5, 2, Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local0)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local1)

		// Expected result

		Multiply(Local5, 2, Local6)
		Store(DeRefOf(Index(arg4, Local6)), Local2)
		Increment(Local6)
		Store(DeRefOf(Index(arg4, Local6)), Local3)

		switch (ToInteger (arg5)) {
			case (0) {
				Divide(Local0, Local1, Local6, Local7)
				if (LNotEqual(Local7, Local2)) {
					err(arg0, z083, 18, 0, 0, Local5, arg2)
				}
				if (LNotEqual(Local6, Local3)) {
					err(arg0, z083, 19, 0, 0, Local5, arg2)
				}
			}
		}
		Increment(Local5)
		Decrement(Local4)
	}
}

// Verifying 1-parameter, 1-result operator
Method(m002, 6, Serialized)
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
				Increment(Local0)
				if (LNotEqual(Local0, Local1)) {
					err(arg0, z083, 20, 0, 0, Local5, arg2)
				}
			}
			case (1) {
				Decrement(Local0)
				if (LNotEqual(Local0, Local1)) {
					err(arg0, z083, 21, 0, 0, Local5, arg2)
				}
			}
			case (2) {
				Not(Local0, Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z083, 22, 0, 0, Local5, arg2)
				}
			}
			case (3) {
				FindSetLeftBit(Local0, Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z083, 23, 0, 0, Local5, arg2)
				}
			}
			case (4) {
				FindSetRightBit(Local0, Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z083, 24, 0, 0, Local5, arg2)
				}
			}
		}
		Increment(Local5)
		Decrement(Local3)
	}
}

// =================================== //
//          Bitwise operands           //
//                                     //
//  (utilized by different operators)  //
// =================================== //

Name(p030, Package()
{
	0, 0,
	0, 0xffffffff,
	0xffffffff, 0xffffffff,
	0xf0f0f0f0, 0xffffffff,
	0x0f0f0f0f, 0xffffffff,
	0xf0f0f0f0, 0,
	0x0f0f0f0f, 0,
	0xf0f0f0f0, 0x11111111,
	0x0f0f0f0f, 0x11111111,
	0x87654321, 0x90abcdfe,
})

Name(p031, Package()
{
	0, 0,
	0, 0xffffffffffffffff,
	0xffffffffffffffff, 0xffffffffffffffff,
	0xf0f0f0f0f0f0f0f0, 0xffffffffffffffff,
	0x0f0f0f0f0f0f0f0f, 0xffffffffffffffff,
	0xf0f0f0f0f0f0f0f0, 0,
	0x0f0f0f0f0f0f0f0f, 0,
	0xf0f0f0f0f0f0f0f0, 0x1111111111111111,
	0x0f0f0f0f0f0f0f0f, 0x1111111111111111,
	0x8765432199118822, 0x90ab66887799cdfe,
})

Name(p032, Package()
{
	0,
	0xffffffff,
	0xf0f0f0f0,
	0x0f0f0f0f,
	0x12345678,
})

Name(p033, Package()
{
	0,
	0xffffffffffffffff,
	0xf0f0f0f0f0f0f0f0,
	0x0f0f0f0f0f0f0f0f,
	0x123456780af9bced,
})

// ===================================== Add

Name(p000, Package()
{
	0x12345678, 0x6bcdef01,
	0x62345678, 0x4bcdef01,
	0x00000000, 0x00000000,
	0x10000000, 0x90000000,
	0x00000000, 0x000000ff,
	0x00000000, 0x0000ffff,
	0x00000000, 0xffffffff,

	// 32-overflow
	0x12345678, 0xf0000000,
	0xffffffff, 0xffffffff,
	0x00000001, 0xffffffff,
})

Name(p001, Package()
{
	0x7E024579,
	0xAE024579,
	0x00000000,
	0xa0000000,
	0x000000ff,
	0x0000ffff,
	0xffffffff,

	// 32-overflow
	0x02345678,
	0xfffffffe,
	0x00000000,
})

Name(p002, Package()
{
	// 32-overflow
	0x12345678, 0xf0000000,
	0xffffffff, 0xffffffff,

	0x12345678dcabef98, 0x6bcdef0119283746,
	0x72345678dcabef98, 0x5bcdef0119283746,
	0, 0,
	0x1000000000000000, 0x9000000000000000,
	0, 0x0ff,
	0, 0x0ffff,
	0, 0x0ffffffff,
	0, 0xffffffffffffffff,

	// 64-overflow
	0x12345678dcabef98, 0xf000000000000000,
	0xffffffffffffffff, 0xffffffffffffffff,
	1, 0xffffffffffffffff,
})

Name(p003, Package()
{
	// 32-overflow
	0x102345678,
	0x1fffffffe,

	0x7E024579F5D426DE,
	0xCE024579F5D426DE,
	0,
	0xa000000000000000,
	0x0ff,
	0x0ffff,
	0x0ffffffff,
	0xffffffffffffffff,

	// 64-overflow
	0x02345678DCABEF98,
	0xfffffffffffffffe,
	0,
})

Method(ADD0,, Serialized)
{
	Name(ts, "ADD0")

	Store("TEST: ADD0, Integer Add", Debug)

	if (LEqual(F64, 1)) {
		m000(ts, 7, "p000", p000, p001, 0)
		m000(ts, 13, "p002", p002, p003, 0)
	} else {
		m000(ts, 10, "p000", p000, p001, 0)
	}
}

// ===================================== Subtract

Name(p004, Package()
{
	0x62345678, 0x4bcdef01,
	0x00000000, 0x00000000,
	0x90000000, 0x10000000,
	0x000000ff, 0x00000000,
	0x0000ffff, 0x00000000,
	0xffffffff, 0xffffffff,
	0xffffffff, 0x00000000,

	// 32-overflow
	0x00000000, 0x87654321,
	0x12345678, 0x6bcdef01,
	0x10000000, 0x90000000,
	0x00000000, 0x000000ff,
	0x00000000, 0x0000ffff,
})

Name(p005, Package()
{
	0x16666777,
	0x00000000,
	0x80000000,
	0x000000ff,
	0x0000ffff,
	0x00000000,
	0xffffffff,

	// 32-overflow
	0x789ABCDF,
	0xA6666777,
	0x80000000,
	0xFFFFFF01,
	0xFFFF0001
})

Name(p006, Package()
{
	// 32-overflow
	0x00000000, 0x87654321,
	0x12345678, 0x6bcdef01,
	0x10000000, 0x90000000,
	0x00000000, 0x000000ff,
	0x00000000, 0x0000ffff,

	0x12345678dcabef98, 0x6bcdef0119283746,
	0x72345678dcabef98, 0x5bcdef0119283746,
	0, 0,
	0xffffffffffffffff, 0,
	0, 0xffffffffffffffff,
	0x9000000000000000, 0x1000000000000000,
	0x1000000000000000, 0x9000000000000000,
	0x0ff,       0,
	0,           0x0ff,
	0x0ffff,     0,
	0,           0x0ffff,
	0x0ffffffff, 0,
	0,           0x0ffffffff,
	0xffffffffffffffff, 0xffffffffffffffff,
	0x12345678dcabef98, 0xf000000000000000,
})

Name(p007, Package()
{
	// 32-overflow
	0xFFFFFFFF789ABCDF,
	0xFFFFFFFFA6666777,
	0xFFFFFFFF80000000,
	0xFFFFFFFFFFFFFF01,
	0xFFFFFFFFFFFF0001,

	0xA6666777C383B852,
	0x16666777C383B852,
	0,
	0xffffffffffffffff,
	1,
	0x8000000000000000,
	0x8000000000000000,
	0x0ff,
	0xFFFFFFFFFFFFFF01,
	0x0ffff,
	0xFFFFFFFFFFFF0001,
	0x0ffffffff,
	0xFFFFFFFF00000001,
	0,
	0x22345678DCABEF98
})

Method(SUB0,, Serialized)
{
	Name(ts, "SUB0")

	Store("TEST: SUB0, Integer Subtract", Debug)

	if (LEqual(F64, 1)) {
		m000(ts, 7, "p004", p004, p005, 1)
		m000(ts, 20, "p006", p006, p007, 1)
	} else {
		m000(ts, 12, "p004", p004, p005, 1)
	}
}

// ===================================== Multiply

Name(p008, Package()
{
	0, 0,
	0, 0xffffffff,
	0x00012345, 0x00007abc,
	0x00000012, 0x00000034,
	0x00000001, 0x000000ff,
	0x00000001, 0x0000ffff,
	0x00000001, 0xffffffff,

	// bit-size of multiplicand
	0x67812345, 2,

	// bit-size of multiplier
	3, 0x45678123,

	0xffffffff, 0xffffffff,

	// ACPI: Overflow conditions are ignored and results are undefined.
})

Name(p009, Package()
{
	0,
	0,
	0x8BA4C8AC,
	0x000003a8,
	0x000000ff,
	0x0000ffff,
	0xffffffff,

	// bit-size of multiplicand
	0xCF02468A,

	// bit-size of multiplier
	0xD0368369,

	0x00000001

	// ACPI: Overflow conditions are ignored and results are undefined.
})

Name(p00a, Package()
{
	0x092345678, 0x0abcdef68,
	0x0f2345678, 0x0abcdef68,

	0, 0xffffffffffffffff,

	1, 0xffffffffffffffff,

	// bit-size of multiplicand
	0x6781234511992288, 2,

	// bit-size of multiplier
	3, 0x4567812377665544,

	0xffffffffffffffff, 0xffffffffffffffff,

	// ACPI: Overflow conditions are ignored and results are undefined.
})

Name(p00b, Package()
{
	0x621E9265A81528C0,
	0xA28BCC2CA81528C0,
	0,

	0xffffffffffffffff,

	// bit-size of multiplicand
	0xCF02468A23324510,

	// bit-size of multiplier
	0xD036836A6632FFCC,

	0x0000000000000001

	// ACPI: Overflow conditions are ignored and results are undefined.
})

Method(MTP0,, Serialized)
{
	Name(ts, "MTP0")

	Store("TEST: MTP0, Integer Multiply", Debug)

	if (LEqual(F64, 1)) {
		m000(ts, 9, "p008", p008, p009, 2)
		m000(ts, 7, "p00a", p00a, p00b, 2)
	} else {
		m000(ts, 10, "p008", p008, p009, 2)
	}
}

// ===================================== Divide

Name(p00c, Package()
{
	// divident divisor
	0x12345678, 0x1000,
	0xffffffff, 0x400000,
	// bit-size of operands
	0x78123456, 0x80000000,
	0x78123456, 2,
	0,          1,
	0x78123456, 0x11223344,
	// bit-size of result
	0xffffffff, 1,
	// bit-size of remainder
	0xffffffff, 0x80000000,
})

Name(p00d, Package()
{
	// result   remainder
	0x12345,    0x678,
	0x3ff,      0x3fffff,
	0,          0x78123456,
	0x3C091A2B, 0,
	0,          0,
	7,          0x22cd7a,
	0xffffffff, 0,
	1,          0x7fffffff,
})

Name(p00e, Package()
{
	// divident         divisor

	0x1234567811223344, 0x1000,
	0xffffffffffffffff, 0x4000000000000000,
	0x7812345699887766, 0x8000000000000000,
	0x7812345600448866, 2,
	0,                  1,
	0x78123456aabbccdd, 0x110022bd33ca4784,
	0xffffffffffffffff, 1,
	0xffffffffffffffff, 0x8000000000000000,
})

Name(p00f, Package()
{
	// result           remainder
	0x0001234567811223, 0x344,
	3,                  0x3FFFFFFFFFFFFFFF,
	0,                  0x7812345699887766,
	0x3C091A2B00224433, 0,
	0,                  0,
	7,                  0x0111412A4033D841,
	0xffffffffffffffff, 0,
	1,                  0x7FFFFFFFFFFFFFFF,
})

Method(DVD0,, Serialized)
{
	Name(ts, "DVD0")

	Store("TEST: DVD0, Integer Divide", Debug)

	if (LEqual(F64, 1)) {
		m001(ts, 8, "p00c", p00c, p00d, 0)
		m001(ts, 8, "p00e", p00e, p00f, 0)
	} else {
		m001(ts, 8, "p00c", p00c, p00d, 0)
	}
}

// ===================================== Increment

Name(p014, Package()
{
	0,
	0xfffffffe,
	0x12334579,
	0x7fffffff,
	0x80000000,
	0xffffffff,
})

Name(p015, Package()
{
	1,
	0xffffffff,
	0x1233457a,
	0x80000000,
	0x80000001,
	0,
})

Name(p016, Package()
{
	0xffffffff,

	0xfffffffffffffffe,
	0x1233457988339042,
	0x7fffffffffffffff,
	0x8000000000000000,
	0xffffffffffffffff,
})

Name(p017, Package()
{
	0x100000000,

	0xffffffffffffffff,
	0x1233457988339043,
	0x8000000000000000,
	0x8000000000000001,
	0,
})

Method(ICR0,, Serialized)
{
	Name(ts, "ICR0")

	Store("TEST: ICR0, Increment an Integer", Debug)

	if (LEqual(F64, 1)) {
		m002(ts, 5, "p014", p014, p015, 0)
		m002(ts, 6, "p016", p016, p017, 0)
	} else {
		m002(ts, 6, "p014", p014, p015, 0)
	}
}

// ===================================== Decrement

Name(p018, Package()
{
	0xffffffff,
	0x12334579,
	0x80000000,
	0x7fffffff,
	0x80000001,
	0,
})

Name(p019, Package()
{
	0xfffffffe,
	0x12334578,
	0x7fffffff,
	0x7ffffffe,
	0x80000000,
	0xffffffff,
})

Name(p01a, Package()
{
	0,
	0xffffffffffffffff,
	0x1233457966887700,
	0x8000000000000000,
	0x7fffffffffffffff,
	0x8000000000000001,
})

Name(p01b, Package()
{
	0xffffffffffffffff,
	0xfffffffffffffffe,
	0x12334579668876ff,
	0x7fffffffffffffff,
	0x7ffffffffffffffe,
	0x8000000000000000,
})

Method(DCR0,, Serialized)
{
	Name(ts, "DCR0")

	Store("TEST: DCR0, Decrement an Integer", Debug)

	if (LEqual(F64, 1)) {
		m002(ts, 5, "p018", p018, p019, 1)
		m002(ts, 6, "p01a", p01a, p01b, 1)
	} else {
		m002(ts, 6, "p018", p018, p019, 1)
	}
}

// ===================================== And

Name(p01c, Package()
{
	0,
	0,
	0xffffffff,
	0xf0f0f0f0,
	0x0f0f0f0f,
	0,
	0,
	0x10101010,
	0x01010101,
	0x80214120,
})

Name(p01d, Package()
{
	0,
	0,
	0xffffffffffffffff,
	0xf0f0f0f0f0f0f0f0,
	0x0f0f0f0f0f0f0f0f,
	0,
	0,
	0x1010101010101010,
	0x0101010101010101,
	0x8021420011118822,
})

Method(AND0,, Serialized)
{
	Name(ts, "AND0")

	Store("TEST: AND0, Integer Bitwise And", Debug)

	if (LEqual(F64, 1)) {
		m000(ts, c000, "p030", p030, p01c, 3)
		m000(ts, c000, "p031", p031, p01d, 3)
	} else {
		m000(ts, c000, "p030", p030, p01c, 3)
	}
}

// ===================================== Nand

Name(p01e, Package() {0x9a3353ac, 0x39a966ca})
Name(p01f, Package() {0xE7DEBD77})
Name(p020, Package() {0xffffffffE7DEBD77})
Name(p021, Package() {0x9a3353ac395c9353, 0x39a966caa36a3a66})
Name(p022, Package() {0xE7DEBD77DEB7EDBD})

Name(p023, Package()
{
	0xffffffff,
	0xffffffff,
	0,
	0x0f0f0f0f,
	0xf0f0f0f0,
	0xffffffff,
	0xffffffff,
	0xefefefef,
	0xfefefefe,
	0x7FDEBEDF,
})

Name(p024, Package()
{
	0xffffffffffffffff,
	0xffffffffffffffff,
	0xffffffff00000000,
	0xffffffff0f0f0f0f,
	0xfffffffff0f0f0f0,
	0xffffffffffffffff,
	0xffffffffffffffff,
	0xffffffffefefefef,
	0xfffffffffefefefe,
	0xFFFFFFFF7FDEBEDF,
})

Name(p025, Package()
{
	0xffffffffffffffff,
	0xffffffffffffffff,
	0,
	0x0f0f0f0f0f0f0f0f,
	0xf0f0f0f0f0f0f0f0,
	0xffffffffffffffff,
	0xffffffffffffffff,
	0xefefefefefefefef,
	0xfefefefefefefefe,
	0x7FDEBDFFEEEE77DD,
})

Method(NAN0,, Serialized)
{
	Name(ts, "NAN0")

	Store("TEST: NAN0, Integer Bitwise Nand", Debug)

	if (LEqual(F64, 1)) {
		m000(ts, 1, "p01e", p01e, p020, 4)
		m000(ts, 1, "p021", p021, p022, 4)
		m000(ts, c000, "p030", p030, p024, 4)
		m000(ts, c000, "p031", p031, p025, 4)
	} else {
		m000(ts, 1, "p01e", p01e, p01f, 4)
		m000(ts, c000, "p030", p030, p023, 4)
	}
}

// ===================================== Nor

Name(p026, Package() {0x9a3353ac, 0x39a966ca})
Name(p027, Package() {0x44448811})
Name(p028, Package() {0xffffffff44448811})
Name(p029, Package() {0x9a3353ac993ca39c, 0x39a966ca3356a5c9})
Name(p02a, Package() {0x4444881144815822})

Name(p02b, Package()
{
	0xffffffff,
	0,
	0,
	0,
	0,
	0x0f0f0f0f,
	0xf0f0f0f0,
	0x0e0e0e0e,
	0xe0e0e0e0,
	0x68103000,
})

Name(p02c, Package()
{
	0xffffffffffffffff,
	0xffffffff00000000,
	0xffffffff00000000,
	0xffffffff00000000,
	0xffffffff00000000,
	0xffffffff0f0f0f0f,
	0xfffffffff0f0f0f0,
	0xffffffff0e0e0e0e,
	0xffffffffe0e0e0e0,
	0xFFFFFFFF68103000,
})

Name(p02d, Package()
{
	0xffffffffffffffff,
	0,
	0,
	0,
	0,
	0x0f0f0f0f0f0f0f0f,
	0xf0f0f0f0f0f0f0f0,
	0x0e0e0e0e0e0e0e0e,
	0xe0e0e0e0e0e0e0e0,
	0x6810985600663201,
})

Method(NOR0,, Serialized)
{
	Name(ts, "NOR0")

	Store("TEST: NOR0, Integer Bitwise Nor", Debug)

	if (LEqual(F64, 1)) {
		m000(ts, 1, "p026", p026, p028, 5)
		m000(ts, 1, "p029", p029, p02a, 5)
		m000(ts, c000, "p030", p030, p02c, 5)
		m000(ts, c000, "p031", p031, p02d, 5)
	} else {
		m000(ts, 1, "p026", p026, p027, 5)
		m000(ts, c000, "p030", p030, p02b, 5)
	}
}

// ===================================== Not

Name(p02e, Package()
{
	0xffffffff,
	0,
	0x0f0f0f0f,
	0xf0f0f0f0,
	0xEDCBA987,
})

Name(p02f, Package()
{
	0xffffffffffffffff,
	0xffffffff00000000,
	0xffffffff0f0f0f0f,
	0xfffffffff0f0f0f0,
	0xffffffffEDCBA987,
})

Name(p040, Package()
{
	0xffffffffffffffff,
	0,
	0x0f0f0f0f0f0f0f0f,
	0xf0f0f0f0f0f0f0f0,
	0xEDCBA987F5064312,
})

Method(NOT0,, Serialized)
{
	Name(ts, "NOT0")

	Store("TEST: NOT0, Integer Bitwise Not", Debug)

	if (LEqual(F64, 1)) {
		m002(ts, c001, "p032", p032, p02f, 2)
		m002(ts, c001, "p033", p033, p040, 2)
	} else {
		m002(ts, c001, "p032", p032, p02e, 2)
	}
}

// ===================================== Or

Name(p041, Package() {0x9a3353ac, 0x39a966ca})
Name(p042, Package() {0xBBBB77EE})
Name(p043, Package() {0x9a3353ac99a3dceb, 0x39a966ca12887634})
Name(p044, Package() {0xBBBB77EE9BABFEFF})

Name(p045, Package()
{
	0,
	0xffffffff,
	0xffffffff,
	0xffffffff,
	0xffffffff,
	0xf0f0f0f0,
	0x0f0f0f0f,
	0xf1f1f1f1,
	0x1f1f1f1f,
	0x97EFCFFF,
})

Name(p046, Package()
{
	0,
	0xffffffffffffffff,
	0xffffffffffffffff,
	0xffffffffffffffff,
	0xffffffffffffffff,
	0xf0f0f0f0f0f0f0f0,
	0x0f0f0f0f0f0f0f0f,
	0xf1f1f1f1f1f1f1f1,
	0x1f1f1f1f1f1f1f1f,
	0x97EF67A9FF99CDFE,
})

Method(OR00,, Serialized)
{
	Name(ts, "OR00")

	Store("TEST: OR00, Integer Bitwise Or", Debug)

	if (LEqual(F64, 1)) {
		m000(ts, 1, "p041", p041, p042, 6)
		m000(ts, 1, "p043", p043, p044, 6)
		m000(ts, c000, "p030", p030, p045, 6)
		m000(ts, c000, "p031", p031, p046, 6)
	} else {
		m000(ts, 1, "p041", p041, p042, 6)
		m000(ts, c000, "p030", p030, p045, 6)
	}
}

// ===================================== Xor

Name(p047, Package() {0x9a3653ac, 0x39a966ca})
Name(p048, Package() {0xA39F3566})
Name(p049, Package() {0x9a3653ac19283745, 0x39a966cabbaaef45})
Name(p04a, Package() {0xA39F3566A282D800})

Name(p04b, Package()
{
	0,
	0xffffffff,
	0,
	0x0f0f0f0f,
	0xf0f0f0f0,
	0xf0f0f0f0,
	0x0f0f0f0f,
	0xe1e1e1e1,
	0x1e1e1e1e,
	0x17CE8EDF,
})

Name(p04c, Package()
{
	0,
	0xffffffffffffffff,
	0,
	0x0f0f0f0f0f0f0f0f,
	0xf0f0f0f0f0f0f0f0,
	0xf0f0f0f0f0f0f0f0,
	0x0f0f0f0f0f0f0f0f,
	0xe1e1e1e1e1e1e1e1,
	0x1e1e1e1e1e1e1e1e,
	0x17CE25A9EE8845DC,
})

Name(p04d, Package()
{
	0,
	0xffffffff,
	0,
	0x0f0f0f0f,
	0xf0f0f0f0,
	0xf0f0f0f0,
	0x0f0f0f0f,
	0xe1e1e1e1,
	0x1e1e1e1e,
	0x17CE8EDF,
})

Method(XOR0,, Serialized)
{
	Name(ts, "XOR0")

	Store("TEST: XOR0, Integer Bitwise Xor", Debug)

	if (LEqual(F64, 1)) {
		m000(ts, 1, "p047", p047, p048, 7)
		m000(ts, 1, "p049", p049, p04a, 7)
		m000(ts, c000, "p030", p030, p04b, 7)


		m000(ts, 1, "p031", p031, p04c, 7)
		m000(ts, c000, "p031", p031, p04c, 7)
	} else {
		m000(ts, 1, "p047", p047, p048, 7)
		m000(ts, c000, "p030", p030, p04d, 7)
	}
}

// ===================================== Mod

Name(p04e, Package()
{
	// remainder
	0x678,
	0x3fffff,
	0x78123456,
	0,
	0,
	0x22cd7a,
	0,
	0x7fffffff,
})

Name(p04f, Package()
{
	// remainder
	0x344,
	0x3FFFFFFFFFFFFFFF,
	0x7812345699887766,
	0,
	0,
	0x0111412A4033D841,
	0,
	0x7FFFFFFFFFFFFFFF,
})

Method(MOD0,, Serialized)
{
	Name(ts, "MOD0")

	Store("TEST: MOD0, Integer Modulo", Debug)

	if (LEqual(F64, 1)) {
		m000(ts, 8, "p00c", p00c, p04e, 8)
		m000(ts, 8, "p00e", p00e, p04f, 8)
	} else {
		m000(ts, 8, "p00c", p00c, p04e, 8)
	}
}

// ===================================== ShiftLeft

Name(p050, Package()
{
	0, 0,
	0, 1,
	0, 17,
	0, 31,
	0, 32,
	0, 33,
	0, 64,
	0, 65,

	0xffffffff, 0,
	0xffffffff, 1,
	0xffffffff, 14,
	0xffffffff, 31,
	0xffffffff, 32,
	0xffffffff, 33,
	0xffffffff, 64,
	0xffffffff, 65,

	0xf0f0f0f0, 0,
	0xf0f0f0f0, 1,
	0xf0f0f0f0, 17,
	0xf0f0f0f0, 31,
	0xf0f0f0f0, 32,

	0x87654321, 0,
	0x87654321, 1,
	0x87654321, 17,
	0x87654321, 31,
	0x87654321, 32,
})

Name(p051, Package()
{
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,

	0xffffffff,
	0xfffffffe,
	0xFFFFC000,
	0x80000000,
	0,
	0,
	0,
	0,

	0xf0f0f0f0,
	0xe1e1e1e0,
	0xE1E00000,
	0,
	0,

	0x87654321,
	0x0ECA8642,
	0x86420000,
	0x80000000,
	0,
})

Name(p052, Package()
{
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,

	0x00000000ffffffff,
	0x00000001fffffffe,
	0x00003FFFFFFFC000,
	0x7fffffff80000000,
	0xFFFFFFFF00000000,
	0xFFFFFFFE00000000,
	0,
	0,

	0xf0f0f0f0,
	0x00000001E1E1E1E0,
	0x0001E1E1E1E00000,
	0x7878787800000000,
	0xF0F0F0F000000000,

	0x87654321,
	0x000000010ECA8642,
	0x00010ECA86420000,
	0x43B2A19080000000,
	0x8765432100000000,
})

Name(p053, Package()
{
	0xffffffffffffffff, 0,
	0xffffffffffffffff, 1,
	0xffffffffffffffff, 17,
	0xffffffffffffffff, 49,
	0xffffffffffffffff, 64,
	0xffffffffffffffff, 65,

	0xf0f0f0f0f0f0f0f0, 15,
	0xf0f0f0f0f0f0f0f0, 35,

	0x87654321bcdef098, 11,
	0x87654321bcdef098, 50,
})

Name(p054, Package()
{
	0xffffffffffffffff,
	0xfffffffffffffffe,
	0xFFFFFFFFFFFE0000,
	0xFFFE000000000000,
	0,
	0,

	0x7878787878780000,
	0x8787878000000000,

	0x2A190DE6F784C000,
	0xC260000000000000,
})

Method(SHL0,, Serialized)
{
	Name(ts, "SHL0")

	Store("TEST: SHL0, Integer shift value left", Debug)

	if (LEqual(F64, 1)) {
		m000(ts, 26, "p050", p050, p052, 9)
		m000(ts, 10, "p053", p053, p054, 9)
	} else {
		m000(ts, 26, "p050", p050, p051, 9)
	}
}

// ===================================== ShiftRight

Name(p055, Package()
{
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,

	0xffffffff,
	0x7fffffff,
	0x0003FFFF,
	0x00000001,
	0,
	0,
	0,
	0,

	0xf0f0f0f0,
	0x78787878,
	0x00007878,
	0x00000001,
	0,

	0x87654321,
	0x43B2A190,
	0x000043B2,
	0x00000001,
	0,
})

Name(p056, Package()
{
	0xffffffffffffffff,
	0x7fffffffffffffff,
	0x00007FFFFFFFFFFF,
	0x0000000000007FFF,
	0,
	0,

	0x0001E1E1E1E1E1E1,
	0x000000001E1E1E1E,

	0x0010ECA864379BDE,
	0x00000000000021D9,
})

Method(SHR0,, Serialized)
{
	Name(ts, "SHR0")

	Store("TEST: SHR0, Integer shift value right", Debug)

	if (LEqual(F64, 1)) {
		m000(ts, 26, "p050", p050, p055, 10)
		m000(ts, 10, "p053", p053, p056, 10)
	} else {
		m000(ts, 26, "p050", p050, p055, 10)
	}
}

// ===================================== FindSetLeftBit

Name(p057, Package()
{
	0,
	0xffffffff,
	0x80000000,
	0x00000001,
	0x02a0fd40,
	0x0456f200,
})

Name(p058, Package()
{
	0,
	32,
	32,
	1,
	26,
	27,
})

Name(p059, Package()
{
	0,
	0xffffffffffffffff,
	0x8000000000000000,
	0x0000000000000001,
	0x02a0fd4119fd0560,
	0x0456f2007ced8400,
})

Name(p05a, Package()
{
	0,
	64,
	64,
	1,
	58,
	59,
})

Method(FSL0,, Serialized)
{
	Name(ts, "FSL0")

	Store("TEST: FSL0, Index of first least significant bit set", Debug)

	if (LEqual(F64, 1)) {
		m002(ts, 6, "p057", p057, p058, 3)
		m002(ts, 6, "p059", p059, p05a, 3)
	} else {
		m002(ts, 6, "p057", p057, p058, 3)
	}

	if (LEqual(F64, 1)) {
		Store(64, Local0)
	} else {
		Store(32, Local0)
	}
	Store(0, Local1)
	Store(0, Local5)

	While (Local0) {
		if (LEqual(Local1, 0)) {
			Store(1, Local2)
		} else {
			ShiftLeft(3, Local5, Local2)
			Increment(Local5)
		}
		FindSetLeftBit(Local2, Local3)
		Add(Local1, 1, Local4)
		if (LNotEqual(Local3, Local4)) {
			err(ts, z083, 25, 0, 0, Local0, 0)
		}
		Increment(Local1)
		Decrement(Local0)
	}
}

// ===================================== FindSetRightBit

Name(p05b, Package()
{
	0,
	1,
	32,
	1,
	7,
	10,
})

Name(p05c, Package()
{
	0,
	1,
	64,
	1,
	6,
	11,
})

Method(FSR0,, Serialized)
{
	Name(ts, "FSR0")

	Store("TEST: FSR0, Index of first most significant bit set", Debug)

	if (LEqual(F64, 1)) {
		m002(ts, 6, "p057", p057, p05b, 4)
		m002(ts, 6, "p059", p059, p05c, 4)
	} else {
		m002(ts, 6, "p057", p057, p05b, 4)
	}

	if (LEqual(F64, 1)) {
		Store(64, Local0)
	} else {
		Store(32, Local0)
	}
	Store(0, Local1)
	Store(0, Local5)

	While (Local0) {
		if (LEqual(Local1, 0)) {
			Store(1, Local2)
			Store(1, Local4)
		} else {
			ShiftLeft(3, Local5, Local2)
			Store(Local1, Local4)
			Increment(Local5)
		}
		FindSetRightBit(Local2, Local3)
		if (LNotEqual(Local3, Local4)) {
			err(ts, z083, 26, 0, 0, Local0, 0)
		}
		Increment(Local1)
		Decrement(Local0)
	}
}
