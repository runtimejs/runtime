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
 * Test of the Object and Index References
 * and the call-by-reference convention.
 *
 * SPEC2 file contains specification of the tests.
 */


/*
??????????????????
SEE: current number of errors (17.04.2005): 0x26
SEE: report the name of each started test
SEE: q000,q001...
SEE: extend in every possible way the "total tests",
     see top of this spec, as far as fixing the bugs.
SEE: continue to work on "Package total"
SEE: extend the test "The chain of Index_References" after bug fixing
SEE: CURRENTLY: compiler failed, Too few arguments (M002 requires X)
SEE: test ref70 now works in accordance with the current behaviour -
     expects exceptions when dealing with ArgX-ORef & ArgX-IRef.
     should be re-dericted: when read autimatic dereference will
     be done properly.
??????????????????????
*/


Name(z111, 111)

// TEST 1: Read of ArgX-ORef with DerefOf
Method(m221,, Serialized)
{
	Name(ts, "m221")

	ts00(ts)

	m1ad(ts, 0, 1, 1, 1, 0)

	m341()

	if (c088) {
		m4d0()
	}
}

// TEST 2: Read of ArgX-ORef without DerefOf (automatic dereference)
Method(m222,, Serialized)
{
	Name(ts, "m222")

	ts00(ts)

	m1ad(ts, 0, 1, 1, 0, 0)

	if (y507) {
		m342()
		if (c088) {
			m4d0()
		}
	} else {
		m1ae(ts, "read of ArgX-ORef without DerefOf",
			"AE_AML_OPERAND_TYPE exception instead of automatic dereference")
	}
}

// TEST 3: Read of ArgX-IRef with DerefOf
Method(m223,, Serialized)
{
	Name(ts, "m223")

	ts00(ts)

	m1ad(ts, 0, 1, 1, 1, 0)

	m343()
	if (c088) {
		m4d1()
	}
}

// TEST 4: Read of ArgX-IRef without DerefOf
Method(m224,, Serialized)
{
	Name(ts, "m224")

	ts00(ts)

	m1ad(ts, 0, 1, 1, 0, 0)

	if (y507) {
		m344()
		if (c088) {
			m4d1()
		}
	} else {
		m1ae(ts, "read of ArgX-IRef without DerefOf",
			"AE_AML_OPERAND_TYPE exception instead of automatic dereference")
	}
}

// TEST 5.0: Store into ArgX-object doesn't change original data
Method(m225,, Serialized)
{
	Name(ts, "m225")

	ts00(ts)

	m1ad(ts, 1, 1, 0, 0, 0)
	m1c0()
}

// TEST 5.1: CopyObject into ArgX-object doesn't change original data
Method(m226,, Serialized)
{
	Name(ts, "m226")

	ts00(ts)
	m1ad(ts, 2, 1, 0, 0, 0)
	m1c0()
}

// TEST 6.0: Store into ArgX-ORef changes original data
Method(m227,, Serialized)
{
	Name(ts, "m227")

	ts00(ts)

	m362()
	m363()
	m364()

	if (c088) {
		m1ad(ts, 1, 1, 1, 1, 0)
		m4d0()
	}
}

// TEST 6.1: CopyObject into ArgX-ORef changes original data
Method(m228,, Serialized)
{
	Name(ts, "m228")

	ts00(ts)

	m1ad(ts, 2, 1, 1, 1, 0)
	m4d0()
}

// TEST 7.0: Store into ArgX-IRef
//
// ACTUALLY: doesn't write to the original object.
Method(m229,, Serialized)
{
	Name(ts, "m229")

	ts00(ts)

	m1ad(ts, 1, 1, 1, 1, 0)
	m4d1()
}

// TEST 7.1: CopyObject into ArgX-IRef
//
// ACTUALLY: doesn't write to the original object.
Method(m22a,, Serialized)
{
	Name(ts, "m22a")

	ts00(ts)

	m1ad(ts, 2, 1, 1, 1, 0)
	m4d1()
}

// TEST 8:
// ArgX-object is one of String, Buffer and Package.
// Create IRef to the elements of the
// ArgX-object inside the Method and write to them.
//
// ACTUALLY: writes to the original object.
Method(m22b)
{
	ts00("m22b")

	// Store and CopyObject

	m345()
}

// TEST 10: Check Buffer passed as a parameter.
// Create Buffer Field inside Method and write to it.
//
// ACTUALLY: writes to the original object.
Method(m22c,, Serialized)
{
	Name(ts, "m22c")

	if (y100) {
		ts00(ts)
	} else {
		Store(ts, Debug)
	}

	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(b010, Buffer(4) {1,0x77,3,4})

	Method(m000, 1)
	{
		CreateField(arg0, 8, 8, bf90)
		if (LNotEqual(bf90, 0x77)) {
			err(ts, z111, 0, 0, 0, bf90, 0x77)
		}
		Store(0x9999992b, bf90)
		if (LNotEqual(bf90, 0x2b)) {
			err(ts, z111, 1, 0, 0, bf90, 0x2b)
		}
	}

	Method(m001, 1)
	{
		CreateField(arg0, 8, 8, bf90)
		if (LNotEqual(bf90, 0x77)) {
			err(ts, z111, 2, 0, 0, bf90, 0x77)
		}
		Store(0x2b, bf90)

		CopyObject(0x9999992b, bf90)
		if (LNotEqual(bf90, 0x2b)) {
			err(ts, z111, 3, 0, 0, bf90, 0x2b)
		}
	}

	BEG0(z111, ts)

	m000(b000)
	if (X191) {
		m001(b010)
	}

	m386(ts, b000, 0, 4)
	if (X191) {
		m386(ts, b010, 0, 5)
	}

	END0()
}

// TEST 11: Check RefOf of ArgX-Object (ArgX is any type Object)
Method(m22d,, Serialized)
{
	Name(ts, "m22d")

	ts00(ts)

	m346()
	if (c088) {
		// RefOf
		Store(1, c08b) // do RefOf(ArgX) checkings
		m1ad(ts, 0, 1, 0, 0, 0)
		m1c0()

		// CondRefOf
		Store(2, c08b) // do RefOf(ArgX) checkings
		m1ad(ts, 0, 1, 0, 0, 0)
		m1c0()

		Store(0, c08b) // do RefOf(ArgX) checkings
	}
}

// TEST 12: Check DerefOf(RefOf) of ArgX-Object (ArgX is any type Object)
Method(m22e)
{
	ts00("m22e")

	m347()
}

// TEST 13: Check RefOf of ArgX-ORef
Method(m22f)
{
	ts00("m22f")

	m348()
}

// TEST 14: Check DerefOf(RefOf) of ArgX-ORef
//
// ACTUALLY: writes to the original object.
Method(m230)
{
	ts00("m230")

	m349()
}

// TEST 15: Check RefOf of ArgX-IRef
Method(m231)
{
	ts00("m231")

	m34a()
}

// TEST 16: Check DerefOf(RefOf) of ArgX-IRef
Method(m232)
{
	ts00("m232")

	m34b()
}

// TEST 17: Check RefOf of ArgX-String, ArgX-Buffer, ArgX-Package
//
// ACTUALLY:
//
// ArgX-String  - writes to the original String
// ArgX-Buffer  - doesnt
// ArgX-Package - doesnt
Method(m233)
{
	ts00("m233")

	m34c()
}

// TEST 19: Check RefOf of ArgX-Buffer (check its Buffer Field)
//
// ACTUALLY: doesn't write to the original object.
Method(m234,, Serialized)
{
	Name(ts, "m234")

	if (y100) {
		ts00(ts)
	} else {
		Store(ts, Debug)
	}

	Name(b000, Buffer(4) {1,0x77,3,4})

	Method(m000, 1)
	{
		Store(DerefOf(arg0), Local2)

		CreateField(Local2, 8, 8, bf90)
		if (LNotEqual(bf90, 0x77)) {
			err(ts, z111, 0, 0, 0, bf90, 0x77)
		}
		Store(0x9999992b, bf90)
		if (LNotEqual(bf90, 0x2b)) {
			err(ts, z111, 1, 0, 0, bf90, 0x2b)
		}
	}

	Method(m001, 1)
	{
		Store(DerefOf(arg0), Local2)

		CreateField(Local2, 8, 8, bf90)
		if (LNotEqual(bf90, 0x77)) {
			err(ts, z111, 2, 0, 0, bf90, 0x77)
		}
		CopyObject(0x9999992b, bf90)
		if (LNotEqual(bf90, 0x2b)) {
			err(ts, z111, 3, 0, 0, bf90, 0x2b)
		}
	}

	Method(m010, 2)
	{
		Store(RefOf(arg0), Local0)
		m000(Local0)

		if (LEqual(arg1, c00a)) {
			m381(ts, arg0, 0, 0x100)
		} elseif (LEqual(arg1, c00b)) {
			m382(ts, arg0, 0, 0x101)
		} elseif (LEqual(arg1, c00c)) {
			m383(ts, arg0, 0, 0x102)
		}
	}

	Method(m020, 2)
	{
		m000(RefOf(arg0))

		if (LEqual(arg1, c00a)) {
			m381(ts, arg0, 0, 0x103)
		} elseif (LEqual(arg1, c00b)) {
			m382(ts, arg0, 0, 0x104)
		} elseif (LEqual(arg1, c00c)) {
			m383(ts, arg0, 0, 0x105)
		}
	}

	Method(m011, 2)
	{
		Store(RefOf(arg0), Local0)
		m001(Local0)

		if (LEqual(arg1, c00a)) {
			m381(ts, arg0, 0, 0x106)
		} elseif (LEqual(arg1, c00b)) {
			m382(ts, arg0, 0, 0x107)
		} elseif (LEqual(arg1, c00c)) {
			m383(ts, arg0, 0, 0x108)
		}
	}

	Method(m021, 2)
	{
		m001(RefOf(arg0))

		if (LEqual(arg1, c00a)) {
			m381(ts, arg0, 0, 0x109)
		} elseif (LEqual(arg1, c00b)) {
			m382(ts, arg0, 0, 0x10a)
		} elseif (LEqual(arg1, c00c)) {
			m383(ts, arg0, 0, 0x10b)
		}
	}

	BEG0(z111, ts)

	m010(b000, c00b)
	m382(ts, b000, 0, 0x10c)

	m020(b000, c00b)
	m382(ts, b000, 0, 0x10d)

	if (X191) {
		m011(b000, c00b)
		m382(ts, b000, 0, 0x10e)
	}

	if (X191) {
		m021(b000, c00b)
		m382(ts, b000, 0, 0x10f)
	}

	END0()
}

/*
 * TEST 20: Check writing from ArgX to ArgY
 *
 * ACTUALLY:
 *
 *   '+' writes
 *   '-' not writes
 *   'e' exceptions occurs
 *
 *
 *   - from ArgX-Object to ArgY-Object
 *   + from ArgX-Object to ArgY-ORef
 *   - from ArgX-Object to ArgY-IRef
 *
 *   - from ArgX-ORef to ArgY-Object
 *   e from ArgX-ORef to ArgY-ORef
 *   - from ArgX-ORef to ArgY-IRef
 *
 *   - from ArgX-IRef to ArgY-Object
 *   e from ArgX-IRef to ArgY-ORef
 *   - from ArgX-IRef to ArgY-IRef
 */
Method(m235,, Serialized)
{
	Name(ts, "m235")

	if (y100) {
		ts00(ts)
	} else {
		Store(ts, Debug)
	}

	Name(i000, 0x77)
	Name(i010, 0x77)
	Name(i020, 0x77)
	Name(s000, "qwer0000")
	Name(s010, "qwer0000")

	Name(s021, "q+er0000")
	Name(s031, "q+er0000")

	Name(i001, 0x2b)
	Name(i011, 0x2b)
	Name(i021, 0x2b)
	Name(i031, 0x2b)
	Name(i041, 0x2b)
	Name(i051, 0x2b)
	Name(i061, 0x2b)

	Method(m000, 3)
	{
		Store(arg0, arg1)

		if (LEqual(arg2, c009)) {
			m380(ts, arg1, 0, 0)
		} elseif (LEqual(arg2, c00a)) {
			m381(ts, arg1, 0, 1)
		} elseif (LEqual(arg2, c00b)) {
			m382(ts, arg1, 0, 2)
		} elseif (LEqual(arg2, c00c)) {
			m383(ts, arg1, 0, 3)
		}
	}

	Method(m001, 3)
	{
		CopyObject(arg0, arg1)

		if (LEqual(arg2, c009)) {
			m380(ts, arg1, 0, 4)
		} elseif (LEqual(arg2, c00a)) {
			m381(ts, arg1, 0, 5)
		} elseif (LEqual(arg2, c00b)) {
			m382(ts, arg1, 0, 6)
		} elseif (LEqual(arg2, c00c)) {
			m383(ts, arg1, 0, 7)
		}
	}

	Method(m002, 3)
	{
		Store(arg0, arg1)

		Store(DerefOf(arg1), Local2)

		if (LEqual(arg2, c009)) {
			m380(ts, Local2, 0, 8)
		} elseif (LEqual(arg2, c00a)) {
			m381(ts, Local2, 0, 9)
		} elseif (LEqual(arg2, c00b)) {
			m382(ts, Local2, 0, 10)
		} elseif (LEqual(arg2, c00c)) {
			m383(ts, Local2, 0, 11)
		}
	}

	Method(m003, 3)
	{
		CopyObject(arg0, arg1)

		Store(DerefOf(arg1), Local2)

		if (LEqual(arg2, c009)) {
			m380(ts, Local2, 0, 12)
		} elseif (LEqual(arg2, c00a)) {
			m381(ts, Local2, 0, 13)
		} elseif (LEqual(arg2, c00b)) {
			m382(ts, Local2, 0, 14)
		} elseif (LEqual(arg2, c00c)) {
			m383(ts, Local2, 0, 15)
		}
	}

	Method(m004, 2)
	{
		Store(arg0, arg1)

		m380(ts, arg1, 0, 16)
	}

	Method(m005, 2)
	{
		Store(arg0, arg1)
	}

	BEG0(z111, ts)

	// ArgX-Object -->> ArgY-Object

	m000(i000, i001, c009)
	m380(ts, i000, 0, 17)
	m384(ts, i001, 0, 18)

	m001(i000, i001, c009)
	m380(ts, i000, 0, 19)
	m384(ts, i001, 0, 20)

	// ArgX-Object -->> ArgY-ORef

	m002(i000, RefOf(i001), c009)
	m380(ts, i000, 0, 21)
	m380(ts, i001, 0, 22)

	m003(i000, RefOf(i021), c009)
	m380(ts, i000, 0, 23)
	m380(ts, i021, 0, 24)

	Store(RefOf(i031), Local0)
	m002(i000, Local0, c009)
	m380(ts, i000, 0, 25)
	m380(ts, i031, 0, 26)
	Store(DerefOf(Local0), Local2)
	m380(ts, Local2, 0, 27)

	Store(RefOf(i041), Local0)
	m003(i000, Local0, c009)
	m380(ts, i000, 0, 28)
	m380(ts, i041, 0, 29)
	Store(DerefOf(Local0), Local2)
	m380(ts, Local2, 0, 30)

	// ArgX-Object -->> ArgY-IRef

	m004(i000, Index(s021, 1, Local0))
	m380(ts, i000, 0, 31)
	m385(ts, s021, 0, 32)
	Store(DerefOf(Local0), Local2)
	m384(ts, Local2, 0, 33)

	Store(Index(s021, 1, Local0), Local1)

	m004(i000, Local0)
	m380(ts, i000, 0, 34)
	m385(ts, s021, 0, 35)
	Store(DerefOf(Local0), Local2)
	m384(ts, Local2, 0, 36)

	m004(i000, Local1)
	m380(ts, i000, 0, 37)
	m385(ts, s021, 0, 38)
	Store(DerefOf(Local1), Local2)
	m384(ts, Local2, 0, 39)

	// ArgX-ORef -->> ArgY-Object

	m005(RefOf(i000), s000)
	m380(ts, i000, 0, 40)
	m381(ts, s000, 0, 41)

	m005(RefOf(i000), i051)
	m380(ts, i000, 0, 42)
	m384(ts, i051, 0, 43)

	Store(RefOf(i000), Local0)

	m005(Local0, s000)
	m380(ts, i000, 0, 44)
	m381(ts, s000, 0, 45)

	m005(Local0, i051)
	m380(ts, i000, 0, 46)
	m384(ts, i051, 0, 47)

	// ArgX-IRef -->> ArgY-Object

	m005(Index(s000, 1, Local0), i000)
	m381(ts, s000, 0, 48)
	m380(ts, i000, 0, 49)

	// The entire expression (exercised below):
	// m005(Index(s021, 1, Local0), RefOf(i010))
	// here is executed step by step:

	m385(ts, s021, 0, 50)
	m380(ts, i010, 0, 51)
	m005(Index(s021, 1, Local0), i010)
	m385(ts, s021, 0, 52)
	m380(ts, i010, 0, 53)
	m005(i051, RefOf(i010))
	m385(ts, s021, 0, 54)
	m384(ts, i051, 0, 55)
	m384(ts, i010, 0, 56)

	if (y513) {
		// ArgX-IRef -->> ArgY-ORef

		m005(Index(s021, 1, Local0), RefOf(i020))
		m385(ts, s021, 0, 57)
		m384(ts, i020, 0, 58)

		Store(DerefOf(Local0), Local1)
		m384(ts, Local1, 0, 59)
	}

	// ArgX-IRef -->> ArgY-IRef

	m005(Index(s021, 1, Local0), Index(s010, 1, Local1))
	m385(ts, s021, 0, 60)
	m381(ts, s010, 0, 61)

	Store(DerefOf(Local0), Local2)
	m384(ts, Local2, 0, 62)

	Store(DerefOf(Local1), Local2)
	m380(ts, Local2, 0, 63)

	if (y513) {
		// ArgX-ORef -->> ArgY-ORef

		m005(RefOf(i000), RefOf(i061))
		m380(ts, i000, 0, 64)
		m380(ts, i061, 0, 65)
	}

	// ArgX-ORef -->> ArgY-IRef

	m005(RefOf(i000), Index(s031, 1, Local0))
	m380(ts, i000, 0, 66)
	m385(ts, s031, 0, 67)
	Store(DerefOf(Local0), Local2)
	m384(ts, Local2, 0, 68)

	END0()
}

/*
 * TEST 21: Check writing from ArgX to LocalX
 *
 * ACTUALLY:
 *
 *   - from ArgX-Object to LocalX
 *   - from ArgX-ORef to LocalX
 *   - from ArgX-IRef to LocalX
 */
Method(m236,, Serialized)
{
	Name(ts, "m236")

	if (y100) {
		ts00(ts)
	} else {
		Store(ts, Debug)
	}

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Name(i001, 0x2b)
	Name(s001, "q+er0000")

	Method(m000, 2)
	{
		Store(arg0, Local0)

		if (LEqual(arg1, c009)) {
			m380(ts, Local0, 0, 0)
		} elseif (LEqual(arg1, c00a)) {
			m381(ts, Local0, 0, 1)
		} elseif (LEqual(arg1, c00b)) {
			m382(ts, Local0, 0, 2)
		} elseif (LEqual(arg1, c00c)) {
			m383(ts, Local0, 0, 3)
		}

		// Overwrite LocalX which contains either
		// Object or ORef or IRef.

		Store(0x11, Local0)
	}

	Method(m001, 2)
	{
		Store(arg0, Local0)

		Store(ObjectType(arg0), Local0)

		if (LNotEqual(Local0, arg1)) {
			err(ts, z111, 8, 0, 0, Local0, arg1)
		}

		// Overwrite LocalX which contains either
		// Object or ORef or IRef.

		Store(0x11, Local0)
	}

	BEG0(z111, ts)

	// ArgX-Object -->> LocalX

	m000(i000, c009)
	m000(s000, c00a)
	m000(b000, c00b)
	m000(p000, c00c)

	m380(ts, i000, 0, 4)
	m381(ts, s000, 0, 5)
	m382(ts, b000, 0, 6)
	m383(ts, p000, 0, 7)

	// ArgX-ORef -->> LocalX

	m001(RefOf(i000), c009)
	m001(RefOf(s000), c00a)
	m001(RefOf(b000), c00b)
	m001(RefOf(p000), c00c)

	m380(ts, i000, 0, 8)
	m381(ts, s000, 0, 9)
	m382(ts, b000, 0, 10)
	m383(ts, p000, 0, 11)

	// ArgX-IRef -->> LocalX

	m001(Index(s000, 1), c016)
	m001(Index(b000, 1), c016)
	m001(Index(p000, 1), c009)

	m380(ts, i000, 0, 12)
	m381(ts, s000, 0, 13)
	m382(ts, b000, 0, 14)
	m383(ts, p000, 0, 15)

	END0()
}

/*
 * TEST 23: Generate LocalX-ORef and write to it
 *
 * ACTUALLY: doesn't write to the original object
 */
Method(m237,, Serialized)
{
	Name(ts, "m237")

	if (y100) {
		ts00(ts)
	} else {
		Store(ts, Debug)
	}

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	// Overwrite LocalX-ORef
	Method(m000, 1)
	{
		Store(RefOf(arg0), Local0)
		Store(0x11, Local0)

		Store(RefOf(i000), Local0)
		Store(0x11, Local0)

		Store(RefOf(s000), Local0)
		Store(0x11, Local0)

		Store(RefOf(b000), Local0)
		Store(0x11, Local0)

		Store(RefOf(p000), Local0)
		Store(0x11, Local0)
	}

	BEG0(z111, ts)

	m000(i000)
	m000(s000)
	m000(b000)
	m000(p000)

	m380(ts, i000, 0, 0)
	m381(ts, s000, 0, 1)
	m382(ts, b000, 0, 2)
	m383(ts, p000, 0, 3)

	END0()
}

/*
 * TEST 24: Generate LocalX-IRef and write to it
 *
 * ACTUALLY: doesn't write to the original object
 */
Method(m238,, Serialized)
{
	Name(ts, "m238")

	if (y100) {
		ts00(ts)
	} else {
		Store(ts, Debug)
	}

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	// Overwrite LocalX-ORef

	Method(m000, 1)
	{
		Store(Index(arg0, 1, Local0), Local1)
		Store(0x11, Local0)
		Store(0x22, Local1)

		Store(Index(s000, 1, Local0), Local1)
		Store(0x11, Local0)
		Store(0x22, Local1)

		Store(Index(b000, 1, Local0), Local1)
		Store(0x11, Local0)
		Store(0x22, Local1)

		Store(Index(p000, 1, Local0), Local1)
		Store(0x11, Local0)
		Store(0x22, Local1)
	}

	Method(m001, 1)
	{
		Store(Index(arg0, 1, Local0), Local1)
		CopyObject(0x11, Local0)
		CopyObject(0x22, Local1)

		Store(Index(s000, 1, Local0), Local1)
		CopyObject(0x11, Local0)
		CopyObject(0x22, Local1)

		Store(Index(b000, 1, Local0), Local1)
		CopyObject(0x11, Local0)
		CopyObject(0x22, Local1)

		Store(Index(p000, 1, Local0), Local1)
		CopyObject(0x11, Local0)
		CopyObject(0x22, Local1)
	}

	BEG0(z111, ts)

	m000(s000)
	m000(b000)
	m000(p000)

	m380(ts, i000, 0, 0)
	m381(ts, s000, 0, 1)
	m382(ts, b000, 0, 2)
	m383(ts, p000, 0, 3)

	m001(s000)
	m001(b000)
	m001(p000)

	m380(ts, i000, 0, 4)
	m381(ts, s000, 0, 5)
	m382(ts, b000, 0, 6)
	m383(ts, p000, 0, 7)

	END0()
}

/*
 * TEST 25: Generate ORef to global Object into ArgX and write to it
 *
 * ACTUALLY:
 *
 *    - doesn't write to the original object
 *    - the repeated attempts to overwrite ORef-ArgX cause exceptions
 */
Method(m239,, Serialized)
{
	Name(ts, "m239")

	if (y100) {
		ts00(ts)
	} else {
		Store(ts, Debug)
	}

	// Local Objects

	Method(m000, 2)
	{
		Store(RefOf(arg0), arg1)
		Store(0x11, arg1)
	}

	Method(m001, 2)
	{
		Store(RefOf(arg0), arg1)
		Store(0x11, arg1)

		Store(RefOf(ia00), arg1)
		Store(0x11, arg1)

		Store(RefOf(sa00), arg1)
		Store(0x11, arg1)

		Store(RefOf(ba00), arg1)
		Store(0x11, arg1)

		Store(RefOf(pa00), arg1)
		Store(0x11, arg1)
	}

	Method(m002, 2)
	{
		Store(RefOf(arg0), arg1)
		CopyObject(0x11, arg1)

		Store(RefOf(ia00), arg1)
		CopyObject(0x11, arg1)

		Store(RefOf(sa00), arg1)
		CopyObject(0x11, arg1)

		Store(RefOf(ba00), arg1)
		CopyObject(0x11, arg1)

		Store(RefOf(pa00), arg1)
		CopyObject(0x11, arg1)
	}

	Method(m003, 2)
	{
		CopyObject(RefOf(arg0), arg1)
		CopyObject(0x11, arg1)

		CopyObject(RefOf(ia00), arg1)
		CopyObject(0x11, arg1)

		CopyObject(RefOf(sa00), arg1)
		CopyObject(0x11, arg1)

		CopyObject(RefOf(ba00), arg1)
		CopyObject(0x11, arg1)

		CopyObject(RefOf(pa00), arg1)
		CopyObject(0x11, arg1)
	}

	BEG0(z111, ts)

	// m000

	m000(ia00, ia10)
	m000(sa00, sa10)
	m000(ba00, ba10)
	m000(pa00, pa10)

	m380(ts, ia00, 0, 0)
	m381(ts, sa00, 0, 1)
	m382(ts, ba00, 0, 2)
	m383(ts, pa00, 0, 3)

	m380(ts, ia10, 0, 4)
	m381(ts, sa10, 0, 5)
	m382(ts, ba10, 0, 6)
	m383(ts, pa10, 0, 7)

	if (y514) {
		// m001

		m001(ia00, ia10)
		m001(sa00, sa10)
		m001(ba00, ba10)
		m001(pa00, pa10)

		m380(ts, ia00, 0, 8)
		m381(ts, sa00, 0, 9)
		m382(ts, ba00, 0, 10)
		m383(ts, pa00, 0, 11)

		m380(ts, ia10, 0, 12)
		m381(ts, sa10, 0, 13)
		m382(ts, ba10, 0, 14)
		m383(ts, pa10, 0, 15)

		// m002

		m002(ia00, ia10)
		m002(sa00, sa10)
		m002(ba00, ba10)
		m002(pa00, pa10)

		m380(ts, ia00, 0, 16)
		m381(ts, sa00, 0, 17)
		m382(ts, ba00, 0, 18)
		m383(ts, pa00, 0, 19)

		m380(ts, ia10, 0, 20)
		m381(ts, sa10, 0, 21)
		m382(ts, ba10, 0, 22)
		m383(ts, pa10, 0, 23)
	}

	// m003

	m003(ia00, ia10)
	m003(sa00, sa10)
	m003(ba00, ba10)
	m003(pa00, pa10)

	m380(ts, ia00, 0, 24)
	m381(ts, sa00, 0, 25)
	m382(ts, ba00, 0, 26)
	m383(ts, pa00, 0, 27)

	m380(ts, ia10, 0, 28)
	m381(ts, sa10, 0, 29)
	m382(ts, ba10, 0, 30)
	m383(ts, pa10, 0, 31)

	END0()
}

/*
 * TEST 26: Generate ORef to local Object into ArgX and write to it
 *
 * ACTUALLY:
 *
 *    - doesn't write to the original object
 *    - the repeated attempts to overwrite ORef-ArgX cause exceptions
 */
Method(m23a,, Serialized)
{
	Name(ts, "m23a")

	if (y100) {
		ts00(ts)
	} else {
		Store(ts, Debug)
	}

	// Local Objects

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Name(i010, 0x77)
	Name(s010, "qwer0000")
	Name(b010, Buffer(4) {1,0x77,3,4})
	Name(p010, Package(3) {5,0x77,7})

	Method(m000, 2)
	{
		Store(RefOf(arg0), arg1)
		Store(0x11, arg1)
	}

	Method(m001, 2)
	{
		Store(RefOf(arg0), arg1)
		Store(0x11, arg1)

		Store(RefOf(i000), arg1)
		Store(0x11, arg1)

		Store(RefOf(s000), arg1)
		Store(0x11, arg1)

		Store(RefOf(b000), arg1)
		Store(0x11, arg1)

		Store(RefOf(p000), arg1)
		Store(0x11, arg1)
	}

	Method(m002, 2)
	{
		Store(RefOf(arg0), arg1)
		CopyObject(0x11, arg1)

		Store(RefOf(i000), arg1)
		CopyObject(0x11, arg1)

		Store(RefOf(s000), arg1)
		CopyObject(0x11, arg1)

		Store(RefOf(b000), arg1)
		CopyObject(0x11, arg1)

		Store(RefOf(p000), arg1)
		CopyObject(0x11, arg1)
	}

	Method(m003, 2)
	{
		CopyObject(RefOf(arg0), arg1)
		CopyObject(0x11, arg1)

		CopyObject(RefOf(i000), arg1)
		CopyObject(0x11, arg1)

		CopyObject(RefOf(s000), arg1)
		CopyObject(0x11, arg1)

		CopyObject(RefOf(b000), arg1)
		CopyObject(0x11, arg1)

		CopyObject(RefOf(p000), arg1)
		CopyObject(0x11, arg1)
	}

	BEG0(z111, ts)

	// m000

	m000(i000, i010)
	m000(s000, s010)
	m000(b000, b010)
	m000(p000, p010)

	m380(ts, i000, 0, 0)
	m381(ts, s000, 0, 1)
	m382(ts, b000, 0, 2)
	m383(ts, p000, 0, 3)

	m380(ts, i010, 0, 4)
	m381(ts, s010, 0, 5)
	m382(ts, b010, 0, 6)
	m383(ts, p010, 0, 7)

	if (y514) {
		// m001

		m001(i000, i010)
		m001(s000, s010)
		m001(b000, b010)
		m001(p000, p010)

		m380(ts, i000, 0, 8)
		m381(ts, s000, 0, 9)
		m382(ts, b000, 0, 10)
		m383(ts, p000, 0, 11)

		m380(ts, i010, 0, 12)
		m381(ts, s010, 0, 13)
		m382(ts, b010, 0, 14)
		m383(ts, p010, 0, 15)

		// m002

		m002(i000, i010)
		m002(s000, s010)
		m002(b000, b010)
		m002(p000, p010)

		m380(ts, i000, 0, 16)
		m381(ts, s000, 0, 17)
		m382(ts, b000, 0, 18)
		m383(ts, p000, 0, 19)

		m380(ts, i010, 0, 20)
		m381(ts, s010, 0, 21)
		m382(ts, b010, 0, 22)
		m383(ts, p010, 0, 23)
	}

	// m003

	m003(i000, i010)
	m003(s000, s010)
	m003(b000, b010)
	m003(p000, p010)

	m380(ts, i000, 0, 24)
	m381(ts, s000, 0, 25)
	m382(ts, b000, 0, 26)
	m383(ts, p000, 0, 27)

	m380(ts, i010, 0, 28)
	m381(ts, s010, 0, 29)
	m382(ts, b010, 0, 30)
	m383(ts, p010, 0, 31)

	END0()
}

/*
 * TEST 27: Check CopyObject to LocalX
 *
 * Local0-Local7 can be written with any type object without any conversion
 *
 * Check each type after each one
 */
Method(m23b)
{
	ts00("m23b")

	m1b1()
}

/*
 * TEST 28: Check Store to LocalX
 *
 * Local0-Local7 can be written without any conversion
 *
 * Check each type after each one
 */
Method(m23c)
{
	ts00("m23c")

	m1b2()
}

/*
 * TEST 29: CopyObject the result of RefOf to LocalX
 *
 * References to any type Objects are available.
 */
Method(m23d)
{
	ts00("m23d")

	m1b4()
}

/*
 * TEST 30: Store the result of RefOf to LocalX
 *
 * ACTUALLY: references to any type Objects are available
 */
Method(m23e)
{
	ts00("m23e")

	m1b5()
}

/*
 * TEST 31: CopyObject the result of Index to LocalX
 */
Method(m23f)
{
	ts00("m23f")

	m1b6()
}

/*
 * TEST 32: Store the result of Index to LocalX
 */
Method(m250)
{
	ts00("m250")

	m1b7()
}

/*
 * TEST 33: mix of all the legal ways (enumerated in
 *          tests TEST 27 - TEST 35) of initializing
 *          the LocalX.
 */
Method(m251)
{
	ts00("m251")

	// Strategies:
	// 1 - mix of groups, 2 - Mod-6 strategy, otherwise - linear

	m1e0(1)
}

/*
 * TEST 34: Obtain the NamedX objects of all the types
 *          and check their {type,size,value}.
 *
 * SEE: it is implemented in name/name.asl
 */

/*
 * TEST 35
 *
 * Obtain and verify the ORef
 * and IRef to named objects
 * {type,size,value}.
 */
Method(m252,, Serialized)
{
	Name(ts, "m252")

	ts00(ts)

	m1ad(ts, 0, 1, 1, 1, 0)

	// NamedX-ORef
	m4d2()

	// NamedX-IRef
	m4d3()
}

/*
 * TEST 36: Check ArgX-ORef being passed further to another Method
 *
 * ACTUALLY: writes to the original object
 *           Object:RefOf:ORef:ArgX-ORef:M2:M3:...:M*:write
 *           ^ Changed
 *
 * A set of available for Store types for to write into is restricted
 */
Method(m253)
{
	ts00("m253")

	// Store
	m34d(0)

	// CopyObject
	m34d(1)
}

/*
 * TEST 37: Check ArgX-IRef being passed further to another Method
 *
 * ACTUALLY: doesn't write to the original object
 */
Method(m254)
{
	ts00("m254")

	// Store
	m34e(0)

	// CopyObject
	m34e(1)
}

/*
 * TEST 38: Check write(x, RefOf(y))
 */
Method(m255)
{
	ts00("m255")

	// Store
	m34f()

	// CopyObject
	// CURRENTLY: compiler failed CopyObject(xx, RefOf(xx))
	// m350()
}

/*
 * TEST 39: Check write(x, Index(String))
 */
Method(m256,, Serialized)
{
	Name(ts, "m256")

	ts00(ts)

	Name(s000, "qwer0000")
	Name(s010, "qwer0000")

	BEG0(z111, ts)

	// Store

	Store(0x2b, Index(s000, 1))
	m385(ts, s000, 0, 0)

	Store(0x2b, Index(s010, 1, Local0))
	m385(ts, s010, 0, 1)

	// CopyObject
	// CURRENTLY: compiler failed CopyObject(xx, Index(xx,xx))
	// CopyObject(0x2b, Index(s020, 1))
	// m385(ts, s020, 0, 2)

	END0()
}

/*
 * TEST 40: Check write(x, Index(Buffer))
 */
Method(m257,, Serialized)
{
	Name(ts, "m257")

	ts00(ts)

	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(b010, Buffer(4) {1,0x77,3,4})

	BEG0(z111, ts)

	// Store

	Store(0x2b, Index(b000, 1))
	m386(ts, b000, 0, 0)

	Store(0x2b, Index(b010, 1, Local0))
	m386(ts, b010, 0, 1)

	END0()
}

/*
 * TEST 41: Check Store(Object, Index(Package(){Uninitialized}))
 */
Method(m258, 1, Serialized)
{
	Name(ts, "m258")

	ts00(ts)

	Name(p100, Package(18) {})

	Store(0, Index(p100, 0))
	Store(i900, Index(p100, 1))
	Store(s900, Index(p100, 2))
	Store(b900, Index(p100, 3))
	Store(p953, Index(p100, 4))
	Store(f900, Index(p100, 5))

	if (arg0) {
		// Check these for exceptions but not there
		Store(d900, Index(p100, 6))
		Store(e900, Index(p100, 7))
		Store(m914, Index(p100, 8))
		Store(mx90, Index(p100, 9))
		Store(r900, Index(p100, 10))
		Store(pw90, Index(p100, 11))
		Store(pr90, Index(p100, 12))
		Store(tz90, Index(p100, 13))
	}

	Store(bf90, Index(p100, 14))

	Store(15, Index(p100, 15))
	Store(16, Index(p100, 16))

	// Verify p955-like Package

	m1af(p100, 0, 0, 0)

	m1a6()
}

/*
 * TEST 42: Check CopyObject(Object, Index(Package(){Uninitialized}))
 *
 * CURRENTLY: compiler failed CopyObject(xx, Index(xx,xx))
 */
Method(m259,, Serialized)
{
	ts00("m259")

	Name(p100, Package(18) {})

/*
 *	CopyObject(i900, Index(p100, 1))
 *	CopyObject(s900, Index(p100, 2))
 *	CopyObject(b900, Index(p100, 3))
 *	CopyObject(p953, Index(p100, 4))
 *	CopyObject(f900, Index(p100, 5))
 *	CopyObject(d900, Index(p100, 6))
 *	CopyObject(e900, Index(p100, 7))
 *	CopyObject(m914, Index(p100, 8))
 *	CopyObject(mx90, Index(p100, 9))
 *	CopyObject(r900, Index(p100, 10))
 *	CopyObject(pw90, Index(p100, 11))
 *	CopyObject(pr90, Index(p100, 12))
 *	CopyObject(tz90, Index(p100, 13))
 *	CopyObject(bf90, Index(p100, 14))
 *
 *	m1af(p100, 1, 0, 0)
 *
 *
 *	m1a6()
 */
}

/*
 * TEST 43: Check Store(RefOf(Object), Index(Package(){Uninitialized}))
 */
Method(m25a,, Serialized)
{
	ts00("m25a")

	Name(p100, Package(18) {})

	m352(p100)

	m1af(p100, 1, 1, 1)

	m1a6()
}

/*
 * TEST 44: Check Store(Index(Object,x), Index(Package(){Uninitialized}))
 */
Method(m25b,, Serialized)
{
	ts00("m25b")

	Name(p100, Package(18) {})

	// Store IRef (Index(p955, x)) into Package
	m353(p100, 0)

	// Verify p955-like Package
	m1af(p100, 1, 0, 1)

	m1a6()
}

/*
 * TEST 45: Check write(x, Index(Package(){Constant}))
 */
Method(m25c,, Serialized)
{
	Name(ts, "m25c")

	ts00(ts)

	Name(p000, Package(3) {5,0x77,7})
	Name(p010, Package(3) {5,0x77,7})

	BEG0(z111, ts)

	// Store

	Store(0x2b, Index(p000, 1))
	m387(ts, p000, 0, 0)

	Store(0x2b, Index(p010, 1, Local0))
	m387(ts, p010, 0, 1)

	END0()
}

/*
 * TEST 46: Check write(x, Index(Package(){NamedX}))
 */
Method(m25d)
{
	ts00("m25d")

	// Write Integer into Package and verify the obtained contents
	m351(p955)

	// Restore p955 Package
	m1c6()

	// Check that the original data (i900,...)
	// are unchanged:

	m1a6()
}

/*
 * TEST 47: Check Store(Object, Index(Package(){ORef}))
 */
Method(m25e,, Serialized)
{
	ts00("m25e")

	Name(p100, Package(18) {})

	// Prepare Package with ORef elements
	// pointing to the global *9** data:

	m352(p100)

	// Verify p955-like Package
	m1af(p100, 1, 1, 1)

	// Check the global *9** data are safe:

	m1a6()

	// Write Integer into Package over the ORef
	// and verify the obtained contents

	m351(p100)

	// Check the global *9** data are safe:

	m1a6()
}

/*
 * TEST 48: Check Store(Object, Index(Package(){IRef}))
 */
Method(m25f,, Serialized)
{
	ts00("m25f")

	Name(p100, Package(18) {})

	// Store IRef (Index(p955, x)) into Package
	// (p955 belongs to *9** data):
	m353(p100, 0)

	// Verify p955-like Package
	m1af(p100, 1, 0, 1)

	m1a6()

	// Write Integer into Package over the IRef
	// and verify the obtained contents

	m351(p100)

	// Check the global *9** data are safe:

	m1a6()
}

/*
 * TEST 49: ORef-LocalX
 */
Method(m260)
{
	ts00("m260")

	// Store

	m354()

	// CopyObject

	m355()
}

Method(m354,, Serialized)
{
	Name(ts, "m354")

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Device(d000) { Name(i000, 0xabcd0017) }

	Method(m000,1)
	{
		Store(0x2b, arg0)
	}

	BEG0(z111, ts)

	Store(RefOf(i000), Local0)
	if (0) {
		// This is a reference
		CH03(ts, 0, 0, 0, 0)
		Add(Local0, 1, Local7)
		CH04(ts, 0, 0xff, 0, 0, 0, 0)
	}
	m1a3(Local0, c009, 0, 0, 2)
	m380(ts, DerefOf(Local0), 0, 3)
	m000(Local0)
	m384(ts, DerefOf(Local0), 0, 4)

	Store(RefOf(s000), Local0)
	m1a3(Local0, c00a, 0, 0, 5)
	m381(ts, DerefOf(Local0), 0, 6)
	m000(Local0)
	m384(ts, DerefOf(Local0), 0, 7)

	Store(RefOf(b000), Local0)
	m1a3(Local0, c00b, 0, 0, 8)
	m382(ts, DerefOf(Local0), 0, 9)
	m000(Local0)
	m384(ts, DerefOf(Local0), 0, 10)

	Store(RefOf(p000), Local0)
	m1a3(Local0, c00c, 0, 0, 11)
	m383(ts, DerefOf(Local0), 0, 12)
	m000(Local0)
	m384(ts, DerefOf(Local0), 0, 13)

	Store(RefOf(d000), Local0)
	m1a3(Local0, c00e, 0, 0, 14)
	m000(Local0)
	m384(ts, DerefOf(Local0), 0, 15)

	END0()
}

Method(m355,, Serialized)
{
	Name(ts, "m355")

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Device(d000) { Name(i000, 0xabcd0017) }

	Method(m000,1)
	{
		CopyObject(0x2b, arg0)
	}

	BEG0(z111, ts)

	CopyObject(RefOf(i000), Local0)
	if (0) {
		// This is a reference
		CH03(ts, 0, 2, 0, 0)
		Add(Local0, 1, Local7)
		CH04(ts, 0, 0xff, 0, 1, 0, 0)
	}
	m1a3(Local0, c009, 0, 0, 0)
	m380(ts, DerefOf(Local0), 0, 1)
	m000(Local0)
	m384(ts, DerefOf(Local0), 0, 2)

	CopyObject(RefOf(s000), Local0)
	m1a3(Local0, c00a, 0, 0, 3)
	m381(ts, DerefOf(Local0), 0, 4)
	m000(Local0)
	m384(ts, DerefOf(Local0), 0, 5)

	CopyObject(RefOf(b000), Local0)
	m1a3(Local0, c00b, 0, 0, 6)
	m382(ts, DerefOf(Local0), 0, 7)
	m000(Local0)
	m384(ts, DerefOf(Local0), 0, 8)

	CopyObject(RefOf(p000), Local0)
	m1a3(Local0, c00c, 0, 0, 9)
	m383(ts, DerefOf(Local0), 0, 10)
	m000(Local0)
	m384(ts, DerefOf(Local0), 0, 11)

	CopyObject(RefOf(d000), Local0)
	m1a3(Local0, c00e, 0, 0, 12)
	m000(Local0)
	m384(ts, DerefOf(Local0), 0, 13)

	END0()
}

/*
 * TEST 50: ORef-ArgX
 */
Method(m261,, Serialized)
{
	Name(ts, "m261")

	ts00(ts)

	Name(i000, 0x77)
	Name(i001, 0x77)

	BEG0(z111, ts)

	// Store

	if (y519) {
		m356(i000)
		m380(ts, i000, 0, 0)
	} else {
		m1ae(ts, "Store ORef to ArgX", "AE_AML_OPERAND_TYPE exception occurs")
	}

	// CopyObject

	if (y520) {
		m357(i001)
		m380(ts, i001, 0, 1)
	} else {
		m1ae(ts, "CopyObject ORef to ArgX", "AE_AML_OPERAND_TYPE exception occurs")
	}

	END0()
}

Method(m356, 1, Serialized)
{
	Name(ts, "m356")

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Device(d000) { Name(i000, 0xabcd0017) }

	Method(m000,1)
	{
		Store(0x2b, arg0)
	}

	BEG0(z111, ts)

	Store(RefOf(i000), arg0)
	if (0) {
		// This is a reference
		CH03(ts, 0, 4, 0, 0)
		Add(arg0, 1, Local7)
		CH04(ts, 0, 0xff, 0, 2, 0, 0)
	}
	m1a3(arg0, c009, 0, 0, 0)
	m380(ts, DerefOf(arg0), 0, 1)
	m000(arg0)
	m384(ts, DerefOf(arg0), 0, 2)

	Store(RefOf(s000), arg0)
	m1a3(arg0, c00a, 0, 0, 3)
	m381(ts, DerefOf(arg0), 0, 4)
	m000(arg0)
	m384(ts, DerefOf(arg0), 0, 5)

	Store(RefOf(b000), arg0)
	m1a3(arg0, c00b, 0, 0, 6)
	m382(ts, DerefOf(arg0), 0, 7)
	m000(arg0)
	m384(ts, DerefOf(arg0), 0, 8)

	Store(RefOf(p000), arg0)
	m1a3(arg0, c00c, 0, 0, 9)
	m383(ts, DerefOf(arg0), 0, 10)
	m000(arg0)
	m384(ts, DerefOf(arg0), 0, 11)

	Store(RefOf(d000), arg0)
	m1a3(arg0, c00e, 0, 0, 12)
	m000(arg0)
	m384(ts, DerefOf(arg0), 0, 13)

	END0()
}

Method(m357, 1, Serialized)
{
	Name(ts, "m357")

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Device(d000) { Name(i000, 0xabcd0017) }

	Method(m000,1)
	{
		CopyObject(0x2b, arg0)
	}

	BEG0(z111, ts)

	CopyObject(RefOf(i000), arg0)
	if (0) {
		// This is a reference
		CH03(ts, 0, 6, 0, 0)
		Add(arg0, 1, Local7)
		CH04(ts, 0, 0xff, 0, 3, 0, 0)
	}
	m1a3(arg0, c009, 0, 0, 0)
	m380(ts, DerefOf(arg0), 0, 1)
	m000(arg0)
	m384(ts, DerefOf(arg0), 0, 2)

	CopyObject(RefOf(s000), arg0)
	m1a3(arg0, c00a, 0, 0, 3)
	m381(ts, DerefOf(arg0), 0, 4)
	m000(arg0)
	m384(ts, DerefOf(arg0), 0, 5)

	CopyObject(RefOf(b000), arg0)
	m1a3(arg0, c00b, 0, 0, 6)
	m382(ts, DerefOf(arg0), 0, 7)
	m000(arg0)
	m384(ts, DerefOf(arg0), 0, 8)

	CopyObject(RefOf(p000), arg0)
	m1a3(arg0, c00c, 0, 0, 9)
	m383(ts, DerefOf(arg0), 0, 10)
	m000(arg0)
	m384(ts, DerefOf(arg0), 0, 11)

	CopyObject(RefOf(d000), arg0)
	m1a3(arg0, c00e, 0, 0, 12)
	m000(arg0)
	m384(ts, DerefOf(arg0), 0, 13)

	END0()
}

/*
 * TEST 51: ORef-NamedX
 */
Method(m262,, Serialized)
{
	Name(ts, "m262")

	ts00(ts)

	// Store

	if (y521) {
		m358()
	} else {
		m1ae(ts, "Store ORef to NamedX", "AE_AML_OPERAND_TYPE exception occurs")
	}

	// CopyObject

	if (y522) {
		m359()
	} else {
		m1ae(ts, "CopyObject ORef to NamedX", "AE_AML_OPERAND_TYPE exception occurs")
	}
}

Method(m358,, Serialized)
{
	Name(ts, "m358")

	Name(iii0, 0)

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Device(d000) { Name(i000, 0xabcd0017) }

	Method(m000,1)
	{
		Store(0x2b, arg0)
	}

	BEG0(z111, ts)

	Store(RefOf(i000), iii0)
	if (0) {
		// This is a reference
		CH03(ts, 0, 8, 0, 0)
		Add(iii0, 1, Local7)
		CH04(ts, 0, 0xff, 0, 4, 0, 0)
	}
	m1a3(iii0, c009, 0, 0, 0)
	m380(ts, DerefOf(iii0), 0, 1)
	m000(iii0)
	m384(ts, DerefOf(iii0), 0, 2)

	Store(RefOf(s000), iii0)
	m1a3(iii0, c00a, 0, 0, 3)
	m381(ts, DerefOf(iii0), 0, 4)
	m000(iii0)
	m384(ts, DerefOf(iii0), 0, 5)

	Store(RefOf(b000), iii0)
	m1a3(iii0, c00b, 0, 0, 6)
	m382(ts, DerefOf(iii0), 0, 7)
	m000(iii0)
	m384(ts, DerefOf(iii0), 0, 8)

	Store(RefOf(p000), iii0)
	m1a3(iii0, c00c, 0, 0, 9)
	m383(ts, DerefOf(iii0), 0, 10)
	m000(iii0)
	m384(ts, DerefOf(iii0), 0, 11)

	Store(RefOf(d000), iii0)
	m1a3(iii0, c00e, 0, 0, 12)
	m000(iii0)
	m384(ts, DerefOf(iii0), 0, 13)

	END0()
}

Method(m359,, Serialized)
{
	Name(ts, "m359")

	Name(iii0, 0)

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Device(d000) { Name(i000, 0xabcd0017) }

	Method(m000,1)
	{
		CopyObject(0x2b, arg0)
	}

	BEG0(z111, ts)

	CopyObject(RefOf(i000), iii0)
	if (0) {
		// This is a reference
		CH03(ts, 0, 10, 0, 0)
		Add(iii0, 1, Local7)
		CH04(ts, 0, 0xff, 0, 5, 0, 0)
	}
	m1a3(iii0, c009, 0, 0, 0)
	m380(ts, DerefOf(iii0), 0, 1)
	m000(iii0)
	m384(ts, DerefOf(iii0), 0, 2)

	CopyObject(RefOf(s000), iii0)
	m1a3(iii0, c00a, 0, 0, 3)
	m381(ts, DerefOf(iii0), 0, 4)
	m000(iii0)
	m384(ts, DerefOf(iii0), 0, 5)

	CopyObject(RefOf(b000), iii0)
	m1a3(iii0, c00b, 0, 0, 6)
	m382(ts, DerefOf(iii0), 0, 7)
	m000(iii0)
	m384(ts, DerefOf(iii0), 0, 8)

	CopyObject(RefOf(p000), iii0)
	m1a3(iii0, c00c, 0, 0, 9)
	m383(ts, DerefOf(iii0), 0, 10)
	m000(iii0)
	m384(ts, DerefOf(iii0), 0, 11)

	CopyObject(RefOf(d000), iii0)
	m1a3(iii0, c00e, 0, 0, 12)
	m000(iii0)
	m384(ts, DerefOf(iii0), 0, 13)

	END0()
}

/*
 * TEST 52: ORef-El_of_Package
 */
Method(m263)
{
	ts00("m263")

	// Store

	m35a()

	// CopyObject

	m35b()
}

Method(m35a,, Serialized)
{
	Name(ts, "m35a")

	Name(ppp0, Package(5) {})

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Device(d000) { Name(i000, 0xabcd0017) }

	BEG0(z111, ts)

	Store(RefOf(i000), Index(ppp0, 0))
	Store(RefOf(s000), Index(ppp0, 1))
	Store(RefOf(b000), Index(ppp0, 2))
	Store(RefOf(p000), Index(ppp0, 3))
	Store(RefOf(d000), Index(ppp0, 4))

	Store(DerefOf(Index(ppp0, 0)), Local0)
	m1a3(Local0, c009, 0, 0, 0)
	m380(ts, DerefOf(Local0), 0, 1)

	Store(DerefOf(Index(ppp0, 1)), Local0)
	m1a3(Local0, c00a, 0, 0, 2)
	m381(ts, DerefOf(Local0), 0, 3)

	Store(DerefOf(Index(ppp0, 2)), Local0)
	m1a3(Local0, c00b, 0, 0, 4)
	m382(ts, DerefOf(Local0), 0, 5)

	Store(DerefOf(Index(ppp0, 3)), Local0)
	m1a3(Local0, c00c, 0, 0, 6)
	m383(ts, DerefOf(Local0), 0, 7)

	Store(DerefOf(Index(ppp0, 4)), Local0)
	m1a3(Local0, c00e, 0, 0, 8)

	// Replace

	Store(RefOf(i000), Index(ppp0, 0))
	Store(DerefOf(Index(ppp0, 0)), Local0)
	m1a3(Local0, c009, 0, 0, 9)
	m380(ts, DerefOf(Local0), 0, 10)

	Store(RefOf(s000), Index(ppp0, 0))
	Store(DerefOf(Index(ppp0, 0)), Local0)
	m1a3(Local0, c00a, 0, 0, 11)
	m381(ts, DerefOf(Local0), 0, 12)

	Store(RefOf(b000), Index(ppp0, 0))
	Store(DerefOf(Index(ppp0, 0)), Local0)
	m1a3(Local0, c00b, 0, 0, 13)
	m382(ts, DerefOf(Local0), 0, 14)

	Store(RefOf(p000), Index(ppp0, 0))
	Store(DerefOf(Index(ppp0, 0)), Local0)
	m1a3(Local0, c00c, 0, 0, 15)
	m383(ts, DerefOf(Local0), 0, 16)

	Store(RefOf(d000), Index(ppp0, 0))
	Store(DerefOf(Index(ppp0, 0)), Local0)
	m1a3(Local0, c00e, 0, 0, 17)

	END0()
}

// CURRENTLY: compiler failed CopyObject(xx, Index(xx,xx))
Method(m35b)
{
/*
	Name(ts, "m35b")

	Name(ppp0, Package(5) {})

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Device(d000) { Name(i000, 0xabcd0017) }

	BEG0(z111, ts)

	CopyObject(RefOf(i000), Index(ppp0, 0))
	CopyObject(RefOf(s000), Index(ppp0, 1))
	CopyObject(RefOf(b000), Index(ppp0, 2))
	CopyObject(RefOf(p000), Index(ppp0, 3))
	CopyObject(RefOf(d000), Index(ppp0, 4))

	CopyObject(DerefOf(Index(ppp0, 0)), Local0)
	m1a3(Local0, c009, 0, 0, 0)
	m380(ts, DerefOf(Local0), 0, 1)

	CopyObject(DerefOf(Index(ppp0, 1)), Local0)
	m1a3(Local0, c00a, 0, 0, 2)
	m381(ts, DerefOf(Local0), 0, 3)

	CopyObject(DerefOf(Index(ppp0, 2)), Local0)
	m1a3(Local0, c00b, 0, 0, 4)
	m382(ts, DerefOf(Local0), 0, 5)

	CopyObject(DerefOf(Index(ppp0, 3)), Local0)
	m1a3(Local0, c00c, 0, 0, 6)
	m383(ts, DerefOf(Local0), 0, 7)

	CopyObject(DerefOf(Index(ppp0, 4)), Local0)
	m1a3(Local0, c00e, 0, 0, 8)

	// Replace

	CopyObject(RefOf(i000), Index(ppp0, 0))
	CopyObject(DerefOf(Index(ppp0, 0)), Local0)
	m1a3(Local0, c009, 0, 0, 9)
	m380(ts, DerefOf(Local0), 0, 10)

	CopyObject(RefOf(s000), Index(ppp0, 0))
	CopyObject(DerefOf(Index(ppp0, 0)), Local0)
	m1a3(Local0, c00a, 0, 0, 11)
	m381(ts, DerefOf(Local0), 0, 12)

	CopyObject(RefOf(b000), Index(ppp0, 0))
	CopyObject(DerefOf(Index(ppp0, 0)), Local0)
	m1a3(Local0, c00b, 0, 0, 13)
	m382(ts, DerefOf(Local0), 0, 14)

	CopyObject(RefOf(p000), Index(ppp0, 0))
	CopyObject(DerefOf(Index(ppp0, 0)), Local0)
	m1a3(Local0, c00c, 0, 0, 15)
	m383(ts, DerefOf(Local0), 0, 16)

	CopyObject(RefOf(d000), Index(ppp0, 0))
	CopyObject(DerefOf(Index(ppp0, 0)), Local0)
	m1a3(Local0, c00e, 0, 0, 17)

	END0()
*/
}

/*
 * TEST 53: IRef-LocalX
 */
Method(m264)
{
	ts00("m264")

	// Store

	m35c()

	// CopyObject

	m35d()
}

Method(m35c,, Serialized)
{
	Name(ts, "m35c")

	Name(p000, Package(18) {})

	BEG0(z111, ts)

	// Construct the p955-like Package p000 applying LocalX-IRef

	Store(Index(p956, 0), Local0)
	Store(Local0, Index(p000, 0))

	Store(Index(p956, 1), Local0)
	Store(Local0, Index(p000, 1))

	Store(Index(p956, 2), Local0)
	Store(Local0, Index(p000, 2))

	Store(Index(p956, 3), Local0)
	Store(Local0, Index(p000, 3))

	Store(Index(p956, 4), Local0)
	Store(Local0, Index(p000, 4))

	Store(Index(p956, 5), Local0)
	Store(Local0, Index(p000, 5))

	Store(Index(p956, 6), Local0)
	Store(Local0, Index(p000, 6))

	Store(Index(p956, 7), Local0)
	Store(Local0, Index(p000, 7))

	Store(Index(p956, 8), Local0)
	Store(Local0, Index(p000, 8))

	Store(Index(p956, 9), Local0)
	Store(Local0, Index(p000, 9))

	Store(Index(p956, 10), Local0)
	Store(Local0, Index(p000, 10))

	Store(Index(p956, 11), Local0)
	Store(Local0, Index(p000, 11))

	Store(Index(p956, 12), Local0)
	Store(Local0, Index(p000, 12))

	Store(Index(p956, 13), Local0)
	Store(Local0, Index(p000, 13))

	Store(Index(p956, 14), Local0)
	Store(Local0, Index(p000, 14))

	Store(Index(p956, 15), Local0)
	Store(Local0, Index(p000, 15))

	Store(Index(p956, 16), Local0)
	Store(Local0, Index(p000, 16))

	Store(0, Index(p000, 0))
	Store(15, Index(p000, 15))
	Store(16, Index(p000, 16))

	// Verify p955-like Package

	m1af(p000, 1, 0, 1)

	m1a6()

	END0()
}

// CURRENTLY: compiler failed CopyObject(xx, Index(xx,xx))
Method(m35d)
{
/*
	Name(ts, "m35d")

	Name(p000, Package(18) {})

	BEG0(z111, ts)

	// Construct the p955-like Package p000 applying LocalX-IRef

	CopyObject(Index(p956, 0), Local0)
	CopyObject(Local0, Index(p000, 0))

	CopyObject(Index(p956, 1), Local0)
	CopyObject(Local0, Index(p000, 1))

	CopyObject(Index(p956, 2), Local0)
	CopyObject(Local0, Index(p000, 2))

	CopyObject(Index(p956, 3), Local0)
	CopyObject(Local0, Index(p000, 3))

	CopyObject(Index(p956, 4), Local0)
	CopyObject(Local0, Index(p000, 4))

	CopyObject(Index(p956, 5), Local0)
	CopyObject(Local0, Index(p000, 5))

	CopyObject(Index(p956, 6), Local0)
	CopyObject(Local0, Index(p000, 6))

	CopyObject(Index(p956, 7), Local0)
	CopyObject(Local0, Index(p000, 7))

	CopyObject(Index(p956, 8), Local0)
	CopyObject(Local0, Index(p000, 8))

	CopyObject(Index(p956, 9), Local0)
	CopyObject(Local0, Index(p000, 9))

	CopyObject(Index(p956, 10), Local0)
	CopyObject(Local0, Index(p000, 10))

	CopyObject(Index(p956, 11), Local0)
	CopyObject(Local0, Index(p000, 11))

	CopyObject(Index(p956, 12), Local0)
	CopyObject(Local0, Index(p000, 12))

	CopyObject(Index(p956, 13), Local0)
	CopyObject(Local0, Index(p000, 13))

	CopyObject(Index(p956, 14), Local0)
	CopyObject(Local0, Index(p000, 14))

	CopyObject(Index(p956, 15), Local0)
	CopyObject(Local0, Index(p000, 15))

	CopyObject(Index(p956, 16), Local0)
	CopyObject(Local0, Index(p000, 16))

	CopyObject(0, Index(p000, 0))
	CopyObject(15, Index(p000, 15))
	CopyObject(16, Index(p000, 16))

	// Verify p955-like Package

	m1af(p000, 1, 0, 1)

	m1a6()

	END0()
*/
}

/*
 * TEST 54: IRef-ArgX
 */
Method(m265,, Serialized)
{
	Name(ts, "m265")

	ts00(ts)

	Name(i000, 0x77)
	Name(i010, 0x77)

	// Store

	m35e(i000)
	m380(ts, i000, z111, 0)

	// CopyObject

	m35f(i010)
	m380(ts, i010, z111, 1)
}

Method(m35e, 1, Serialized)
{
	Name(ts, "m35e")

	Name(p000, Package(18) {})

	BEG0(z111, ts)

	// Construct the p955-like Package p000 applying LocalX-IRef

	Store(Index(p956, 0), Arg0)
	Store(Arg0, Index(p000, 0))

	Store(Index(p956, 1), Arg0)
	Store(Arg0, Index(p000, 1))

	Store(Index(p956, 2), Arg0)
	Store(Arg0, Index(p000, 2))

	Store(Index(p956, 3), Arg0)
	Store(Arg0, Index(p000, 3))

	Store(Index(p956, 4), Arg0)
	Store(Arg0, Index(p000, 4))

	Store(Index(p956, 5), Arg0)
	Store(Arg0, Index(p000, 5))

	Store(Index(p956, 6), Arg0)
	Store(Arg0, Index(p000, 6))

	Store(Index(p956, 7), Arg0)
	Store(Arg0, Index(p000, 7))

	Store(Index(p956, 8), Arg0)
	Store(Arg0, Index(p000, 8))

	Store(Index(p956, 9), Arg0)
	Store(Arg0, Index(p000, 9))

	Store(Index(p956, 10), Arg0)
	Store(Arg0, Index(p000, 10))

	Store(Index(p956, 11), Arg0)
	Store(Arg0, Index(p000, 11))

	Store(Index(p956, 12), Arg0)
	Store(Arg0, Index(p000, 12))

	Store(Index(p956, 13), Arg0)
	Store(Arg0, Index(p000, 13))

	Store(Index(p956, 14), Arg0)
	Store(Arg0, Index(p000, 14))

	Store(Index(p956, 15), Arg0)
	Store(Arg0, Index(p000, 15))

	Store(Index(p956, 16), Arg0)
	Store(Arg0, Index(p000, 16))

	Store(0, Index(p000, 0))
	Store(15, Index(p000, 15))
	Store(16, Index(p000, 16))

	// Verify p955-like Package

	m1af(p000, 1, 0, 1)

	m1a6()

	END0()
}

// CURRENTLY: compiler failed CopyObject(xx, Index(xx,xx))
Method(m35f, 1)
{
/*
	Name(ts, "m35f")

	Name(p000, Package(18) {})

	BEG0(z111, ts)

	// Construct the p955-like Package p000 applying LocalX-IRef

	CopyObject(Index(p956, 0), Arg0)
	CopyObject(Arg0, Index(p000, 0))

	CopyObject(Index(p956, 1), Arg0)
	CopyObject(Arg0, Index(p000, 1))

	CopyObject(Index(p956, 2), Arg0)
	CopyObject(Arg0, Index(p000, 2))

	CopyObject(Index(p956, 3), Arg0)
	CopyObject(Arg0, Index(p000, 3))

	CopyObject(Index(p956, 4), Arg0)
	CopyObject(Arg0, Index(p000, 4))

	CopyObject(Index(p956, 5), Arg0)
	CopyObject(Arg0, Index(p000, 5))

	CopyObject(Index(p956, 6), Arg0)
	CopyObject(Arg0, Index(p000, 6))

	CopyObject(Index(p956, 7), Arg0)
	CopyObject(Arg0, Index(p000, 7))

	CopyObject(Index(p956, 8), Arg0)
	CopyObject(Arg0, Index(p000, 8))

	CopyObject(Index(p956, 9), Arg0)
	CopyObject(Arg0, Index(p000, 9))

	CopyObject(Index(p956, 10), Arg0)
	CopyObject(Arg0, Index(p000, 10))

	CopyObject(Index(p956, 11), Arg0)
	CopyObject(Arg0, Index(p000, 11))

	CopyObject(Index(p956, 12), Arg0)
	CopyObject(Arg0, Index(p000, 12))

	CopyObject(Index(p956, 13), Arg0)
	CopyObject(Arg0, Index(p000, 13))

	CopyObject(Index(p956, 14), Arg0)
	CopyObject(Arg0, Index(p000, 14))

	CopyObject(Index(p956, 15), Arg0)
	CopyObject(Arg0, Index(p000, 15))

	CopyObject(Index(p956, 16), Arg0)
	CopyObject(Arg0, Index(p000, 16))

	CopyObject(0, Index(p000, 0))
	CopyObject(15, Index(p000, 15))
	CopyObject(16, Index(p000, 16))

	// Verify p955-like Package

	m1af(p000, 1, 0, 1)

	m1a6()

	END0()
*/
}

/*
 * TEST 55: IRef-NamedX
 */
Method(m266,, Serialized)
{
	Name(ts, "m266")

	ts00(ts)

	// Store

	if (y521) {
		m360()
	} else {
		m1ae(ts, "Store IRef to NamedX", "AE_AML_OPERAND_TYPE exception occurs")
	}

	// CopyObject

	m361()
}

Method(m360,, Serialized)
{
	Name(ts, "m360")

	Name(iii0, 0)

	Name(p000, Package(18) {})

	BEG0(z111, ts)

	// Construct the p955-like Package p000 applying LocalX-IRef

	Store(Index(p956, 0), iii0)
	Store(iii0, Index(p000, 0))

	Store(Index(p956, 1), iii0)
	Store(iii0, Index(p000, 1))

	Store(Index(p956, 2), iii0)
	Store(iii0, Index(p000, 2))

	Store(Index(p956, 3), iii0)
	Store(iii0, Index(p000, 3))

	Store(Index(p956, 4), iii0)
	Store(iii0, Index(p000, 4))

	Store(Index(p956, 5), iii0)
	Store(iii0, Index(p000, 5))

	Store(Index(p956, 6), iii0)
	Store(iii0, Index(p000, 6))

	Store(Index(p956, 7), iii0)
	Store(iii0, Index(p000, 7))

	Store(Index(p956, 8), iii0)
	Store(iii0, Index(p000, 8))

	Store(Index(p956, 9), iii0)
	Store(iii0, Index(p000, 9))

	Store(Index(p956, 10), iii0)
	Store(iii0, Index(p000, 10))

	Store(Index(p956, 11), iii0)
	Store(iii0, Index(p000, 11))

	Store(Index(p956, 12), iii0)
	Store(iii0, Index(p000, 12))

	Store(Index(p956, 13), iii0)
	Store(iii0, Index(p000, 13))

	Store(Index(p956, 14), iii0)
	Store(iii0, Index(p000, 14))

	Store(Index(p956, 15), iii0)
	Store(iii0, Index(p000, 15))

	Store(Index(p956, 16), iii0)
	Store(iii0, Index(p000, 16))

	Store(0, Index(p000, 0))
	Store(15, Index(p000, 15))
	Store(16, Index(p000, 16))

	// Verify p955-like Package

	m1af(p000, 1, 0, 1)

	m1a6()

	END0()
}

// CURRENTLY: compiler failed CopyObject(xx, Index(xx,xx))
Method(m361)
{
/*
	Name(ts, "m361")

	Name(iii0, 0)

	Name(p000, Package(18) {})

	BEG0(z111, ts)

	// Construct the p955-like Package p000 applying LocalX-IRef

	CopyObject(Index(p956, 0), iii0)
	CopyObject(iii0, Index(p000, 0))

	CopyObject(Index(p956, 1), iii0)
	CopyObject(iii0, Index(p000, 1))

	CopyObject(Index(p956, 2), iii0)
	CopyObject(iii0, Index(p000, 2))

	CopyObject(Index(p956, 3), iii0)
	CopyObject(iii0, Index(p000, 3))

	CopyObject(Index(p956, 4), iii0)
	CopyObject(iii0, Index(p000, 4))

	CopyObject(Index(p956, 5), iii0)
	CopyObject(iii0, Index(p000, 5))

	CopyObject(Index(p956, 6), iii0)
	CopyObject(iii0, Index(p000, 6))

	CopyObject(Index(p956, 7), iii0)
	CopyObject(iii0, Index(p000, 7))

	CopyObject(Index(p956, 8), iii0)
	CopyObject(iii0, Index(p000, 8))

	CopyObject(Index(p956, 9), iii0)
	CopyObject(iii0, Index(p000, 9))

	CopyObject(Index(p956, 10), iii0)
	CopyObject(iii0, Index(p000, 10))

	CopyObject(Index(p956, 11), iii0)
	CopyObject(iii0, Index(p000, 11))

	CopyObject(Index(p956, 12), iii0)
	CopyObject(iii0, Index(p000, 12))

	CopyObject(Index(p956, 13), iii0)
	CopyObject(iii0, Index(p000, 13))

	CopyObject(Index(p956, 14), iii0)
	CopyObject(iii0, Index(p000, 14))

	CopyObject(Index(p956, 15), iii0)
	CopyObject(iii0, Index(p000, 15))

	CopyObject(Index(p956, 16), iii0)
	CopyObject(iii0, Index(p000, 16))

	CopyObject(0, Index(p000, 0))
	CopyObject(15, Index(p000, 15))
	CopyObject(16, Index(p000, 16))

	// Verify p955-like Package

	m1af(p000, 1, 0, 1)

	m1a6()

	END0()
*/
}

/*
 * TEST 56: IRef-El_of_Package
 */
Method(m267,, Serialized)
{
	ts00("m267")

	Name(p100, Package(18) {})

	// Store

	m25b()

	if (q003) {
		// CopyObject

		// CopyObject IRef (Index(p955, x)) into Package
		m353(p100, 1)

		// Verify p955-like Package
		m1af(p100, 1, 0, 1)

		m1a6()
	}
}

/*
 * TEST 57: Store total
 */
Method(m268)
{
	m1ae("m268", "Store total", "Not implemented yet")
}

/*
 * TEST 58: CopyObject total
 */
Method(m269)
{
	m1ae("m269", "CopyObject total", "Not implemented yet")
}

/*
 * TEST 59: Mix of Store and CopyObject total
 */
Method(m26a)
{
	m1ae("m26a", "Mix of Store and CopyObject total",
					"Not implemented yet")
}

/*
 * TEST 60: Package total
 */
Method(m26b,, Serialized)
{
	Name(ts, "m26b")

	ts00(ts)

	Name(i000, 0x77)
	Name(i001, 0x77)


	// READ


	// m1c1 & m1c2 - perform all the ways reading
	// element of Package passed by ArgX.

	// Read immediate image element of Package
	//
	// Package specified by the immediate
	// images of {Integer, String, Buffer, Package}.
	m1c1()

	// Read NamedX element of Package
	// {Integer, String, Buffer, Package}.
	m1c2()

	// Read any type named object element of Package
	m1af(p955, 1, 1, 0)

	// Check Uninitialized element of Package
	m1c4()

	// The chain of Index_References
	m1c5()

	// Access to the Method named object element of Package
	m1c7()
	m1c8()

	// Read automatic dereference expected
	// when accessing element of Package.
	m1ce()
	if (X132) {
		m1cf() // bug 132
		m1d0() // bug 132
	}


	// WRITE


	// Write to element of Package specified as
	// immediate IRef passed to method.
	if (X133) {
		m1d9() // bug 133
		m1da() // bug 133
	}


	// EXCEPTIONS


	// No read automatic dereference expected
	m1d1()
	if (X127) {
		m1d2() // bug 127
	}
	m1d3(i000, i001)
	m380(ts, i000, 0, 0)
	m380(ts, i001, 0, 1)
	if (X127) {
		m1d4(i000, i001) // bug 127
	}
	m380(ts, i000, 0, 2)
	m380(ts, i001, 0, 3)
	if (X127) {
		m1d5() // bug 127
		m1d6() // bug 127
		m1db() // bug 127
	}

	// Other
	m1d7()
	m1d8()

	// DerefOf of the Method named object element of Package
	m1c9()

	// Size of Package

	// m1ca: bug 129 (not a bug, in case of
	// dynamically created Package non-limited
	// size Package is allowed. Handled by the
	// particular AML opcode VarPackage).
	m1ca()
	m1cb()
}

/*
 * TEST 61: String total
 */
Method(m26c)
{
	m1ae("m26c", "String total", "Not implemented yet")
}

/*
 * TEST 62: Buffer total
 */
Method(m26d)
{
	CH03("m26d", 0, 0, 0, 0)
	m1ae("m26d", "Buffer total", "Not implemented yet")
	CH03("m26d", 0, 1, 0, 0)
}

/*
 * TEST 63: All the legal ways of WRITING ORef reference to some target location
 */
Method(m26e,, Serialized)
{
	Name(ts, "m26e")

	if (y100) {
		ts00(ts)
	} else {
		Store(ts, Debug)
	}

	CH03(ts, 0, 0, 0, 0)

	// Store
	m365()

	// CopyObject
	m366()

	CH03(ts, 0, 1, 0, 0)
}

Method(m365,, Serialized)
{
	Name(ts, "m365")

	Name(i000, 0x77)
	Name(i001, 0x77)
	Name(i002, 0x77)
	Name(i003, 0)
	Name(i004, 0x77)

	Name(iii0, 0x11)
	Name(iii1, 0x22)
	Name(iii2, 0x33)
	Name(iii3, 0x44)
	Name(iii4, 0x55)
	Name(iii5, 0x66)
	Name(iii6, 0x88)
	Name(iii7, 0x99)

	Name(ppp0, Package(1) {0x11})
	Name(ppp1, Package(1) {})

	Method(m000, 1, Serialized)
	{
		Name(i002, 0x77)

		Store(RefOf(i002), arg0)
		m380(ts, DerefOf(arg0), 0, 0)
		m380(ts, i002, 0, 1)
	}

	Method(m001, 1)
	{
		Store(RefOf(i000), arg0)
	}

	Method(m002, 2)
	{
		Store(0, arg0)
		m001(RefOf(arg0))
		Store(DerefOf(arg0), arg1)
		m380(ts, arg1, 0, 2)
	}

	Method(m003)
	{
		Store(RefOf(iii1), Local0)
		return (Local0)
	}

	Method(m004, 1)
	{
		Store(RefOf(iii2), Local0)
		return (Local0)
	}

	Method(m009)
	{
		return (RefOf(iii7))
	}

	Method(m005, 1)
	{
		Store(RefOf(i000), DerefOf(arg0))
	}

	Method(m006, 2)
	{
		Store(0, arg0)
		m005(RefOf(arg0))
		Store(DerefOf(arg0), arg1)
		m380(ts, arg1, 0, 3)
	}

	Method(m007, 1)
	{
		Store(RefOf(i004), arg0)
	}

	Method(m008, 1)
	{
		Store(RefOf(i004), DerefOf(arg0))
	}

	BEG0(z111, ts)

	// 1.
	Store(RefOf(i000), Local0)
	Store(DerefOf(Local0), Local1)
	m380(ts, Local1, 0, 4)
	m380(ts, i000, 0, 5)

	// 2.
	m000(i001)
	m380(ts, i001, 0, 6)

	// 3.
	CopyObject(RefOf(i000), iii0)
	Store(RefOf(i001), iii0)
	Store(DerefOf(iii0), Local1)
	m380(ts, i001, 0, 7)
	if (y523) {
		m380(ts, Local1, 0, 8)
	}

	// 4.
	Store(0, Local0)
	m001(RefOf(Local0))
	Store(DerefOf(Local0), Local1)
	m380(ts, Local1, 0, 9)

	// 5.
	m002(i001, i002)
	m380(ts, i001, 0, 10)
	m380(ts, i002, 0, 11)

	// 6.
	if (y526) {
		CopyObject(RefOf(i003), iii5)
		m007(RefOf(iii5))
		Store(DerefOf(iii5), Local1)
		m380(ts, Local1, 0, 12)
	}

	// 7.
	if (y113) {
		m001(Index(ppp0, 0))
		Store(Index(ppp0, 0), Local0)
		Store(DerefOf(Local0), Local1)
		Store(DerefOf(Local1), Local2)
		m380(ts, Local2, 0, 13)
	}

	// 8.
	if (y525) {
		CopyObject(RefOf(iii3), iii4)
		Store(RefOf(i000), RefOf(iii4))
		Store(DerefOf(iii4), Local1)
		m380(ts, i000, 0, 14)
		m380(ts, Local1, 0, 15)
	}

	// 9.
	Store(RefOf(i000), Index(ppp1, 0))
	Store(DerefOf(Index(ppp1, 0)), Local2)
	Store(DerefOf(Local2), Local1)
	m380(ts, Local1, 0, 16)
	m380(ts, i000, 0, 17)

	// 10.
	/*
	 * There are some statements try to pass a value of an integer to a LocalX via reference,
	 * But they all use the wrong expression, so they are removed from here.
	 */

	// 11.

	// 12.
	if (y524) {
		Store(0x12, Local7)
		Store(RefOf(Local7), Local6)
		Store(RefOf(i000), DerefOf(Local6))
		Store(DerefOf(Local7), Local0)
		m380(ts, Local0, 0, 24)
		m380(ts, i000, 0, 25)
	}

	// Particular cases of (12):

	if (y524) {

		// 13. (4)
		Store(0, Local0)
		m005(RefOf(Local0))
		Store(DerefOf(Local0), Local1)
		m380(ts, Local1, 0, 26)

		// 14. (5)
		m006(i001, i002)
		m380(ts, i001, 0, 27)
		m380(ts, i002, 0, 28)

		// 15. (6)
		if (y526) {
			CopyObject(RefOf(i003), iii6)
			m008(RefOf(iii6))
			Store(DerefOf(iii6), Local1)
			m380(ts, Local1, 0, 29)
		}

		// 16. (7)
		if (y113) {
			m005(Index(ppp0, 0))
			Store(Index(ppp0, 0), Local0)
			Store(DerefOf(Local0), Local1)
			Store(DerefOf(Local1), Local2)
			m380(ts, Local2, 0, 30)
		}

		// 17. (8)
		if (y525) {
			CopyObject(RefOf(iii3), iii4)
			Store(RefOf(i000), DerefOf(RefOf(iii4)))
			Store(DerefOf(iii4), Local1)
			m380(ts, i000, 0, 31)
			m380(ts, Local1, 0, 32)
		}

		// 18. (9)
		Store(RefOf(i000), DerefOf(Index(ppp1, 0)))
		Store(DerefOf(Index(ppp1, 0)), Local2)
		Store(DerefOf(Local2), Local1)
		m380(ts, Local1, 0, 33)
		m380(ts, i000, 0, 34)

		// 19. (10)
		Store(RefOf(i000), DerefOf(m003()))
		Store(DerefOf(iii1), Local1)
		m380(ts, i000, 0, 35)
		m380(ts, Local1, 0, 36)

		// 20. (11)
		Store(RefOf(i000), DerefOf(m004(0)))
		Store(DerefOf(iii2), Local1)
		m380(ts, i000, 0, 37)
		m380(ts, Local1, 0, 38)
	}

	END0()
}

Method(m366,, Serialized)
{
	Name(ts, "m366")

	Name(i000, 0x77)
	Name(i001, 0x77)
	Name(i002, 0x77)

	Name(iii0, 0)
	Name(iii1, 0)
	Name(ppp0, Package(1) {})
	Name(ppp1, Package(1) {0})

	Method(m000, 1, Serialized)
	{
		Name(i002, 0x77)

		CopyObject(RefOf(i002), arg0)
		m380(ts, DerefOf(arg0), 0, 0)
		m380(ts, i002, 0, 1)
	}

	Method(m001, 1)
	{
		CopyObject(RefOf(i000), arg0)
	}

	Method(m002, 2)
	{
		Store(0, arg0)
		m001(RefOf(arg0))
		Store(DerefOf(arg0), arg1)
		m380(ts, arg1, 0, 2)
	}

	BEG0(z111, ts)

	// 21.
	CopyObject(RefOf(i000), Local0)
	Store(DerefOf(Local0), Local1)
	m380(ts, Local1, 0, 3)
	m380(ts, i000, 0, 4)

	// 22.
	m000(i001)
	m380(ts, i001, 0, 5)

	// 23.
	if (y128) {
		CopyObject(RefOf(i000), iii0)
		Store(DerefOf(iii0), Local1)
		m380(ts, Local1, 0, 6)
		m380(ts, i000, 0, 7)
	}

	// 24.
	Store(0, Local0)
	m001(RefOf(Local0))
	Store(DerefOf(Local0), Local1)
	m380(ts, Local1, 0, 8)

	// 25.
	m002(i001, i002)
	m380(ts, i001, 0, 9)
	m380(ts, i002, 0, 10)

	// 26.
	if (y526) {
		Store(0, iii1)
		m001(RefOf(iii1))
		Store(DerefOf(iii1), Local1)
		m380(ts, Local1, 0, 11)
	}

	// 27.
	if (y113) {
		m001(Index(ppp1, 0))
		Store(Index(ppp1, 0), Local0)
		Store(DerefOf(Local0), Local1)
		Store(DerefOf(Local1), Local2)
		m380(ts, Local2, 0, 12)
	}

	/*
	 * 28. (Compiler failed)
	 *
	 * CopyObject(RefOf(i000), Index(ppp0, 0))
	 * Store(DerefOf(Index(ppp0, 0)), Local2)
	 * Store(DerefOf(Local2), Local1)
	 * m380(ts, Local1, 0, 13)
	 * m380(ts, i000, 0, 14)
	 */

	END0()
}

/*
 * TEST 64: All the legal ways of WRITING IRef reference to some target location
 */
Method(m26f)
{
	CH03("m26f", 0, 0, 0, 0)

	m1ae("m26f", "All the legal ways of writing IRef reference to some target location",
		"Not implemented yet")

	CH03("m26f", 0, 1, 0, 0)
}

/*
 * TEST 65: All the legal SOURCES of references (both ORef and IRef)
 */
Method(m270,, Serialized)
{
	Name(ts, "m270")

	CH03(ts, 0, 0, 0, 0)

	if (y100) {
		ts00(ts)
	} else {
		Store(ts, Debug)
	}

	CH03(ts, 0, 1, 0, 0)

	// Store
	m367()

	CH03(ts, 0, 2, 0, 0)

	// CopyObject
	m368()

	CH03(ts, 0, 3, 0, 0)

	m1ae("m270", "All the legal sources of references (ORef and IRef)",
		"Started, but not implemented yet")

	CH03(ts, 0, 4, 0, 0)
}

Method(m367,, Serialized)
{
	Name(ts, "m367")

	Name(i000, 0x77)
	Name(i001, 0x77)
	Name(i002, 0x77)
	Name(i003, 0x77)
	Name(i004, 0x77)
	Name(i005, 0x77)
	Name(i006, 0x77)

	Name(iii0, 0x11)
	Name(iii1, 0x22)

	Method(m001, 7)
	{
		Store(RefOf(i000), Local0)
		Store(Local0, arg0)
		Store(Local0, arg1)
		Store(Local0, arg2)
		Store(Local0, arg3)
		Store(Local0, arg4)
		Store(Local0, arg5)
		Store(Local0, arg6)

		Store(DerefOf(arg0), Local7)
		m380(ts, Local7, 0, 0)
		Store(DerefOf(arg1), Local7)
		m380(ts, Local7, 0, 1)
		Store(DerefOf(arg2), Local7)
		m380(ts, Local7, 0, 2)
		Store(DerefOf(arg3), Local7)
		m380(ts, Local7, 0, 3)
		Store(DerefOf(arg4), Local7)
		m380(ts, Local7, 0, 4)
		Store(DerefOf(arg5), Local7)
		m380(ts, Local7, 0, 5)
		Store(DerefOf(arg6), Local7)
		m380(ts, Local7, 0, 6)
	}

	Method(m002, 7)
	{
		Store(RefOf(i000), arg0)
		Store(arg0, arg1)
		Store(arg1, arg2)
		Store(arg2, arg3)
		Store(arg3, arg4)
		Store(arg4, arg5)
		Store(arg5, arg6)

		m380(ts, DerefOf(arg6), 0, 7)
		Store(DerefOf(arg0), arg6)
		m380(ts, arg6, 0, 8)
		Store(DerefOf(arg1), arg6)
		m380(ts, arg6, 0, 9)
		Store(DerefOf(arg2), arg6)
		m380(ts, arg6, 0, 10)
		Store(DerefOf(arg3), arg6)
		m380(ts, arg6, 0, 11)
		Store(DerefOf(arg4), arg6)
		m380(ts, arg6, 0, 12)
		Store(DerefOf(arg5), arg6)
		m380(ts, arg6, 0, 13)
	}

	BEG0(z111, ts)

	// 1. ORef-LocalX
	Store(RefOf(i000), Local0)
	Store(Local0, Local1)
	Store(Local1, Local2)
	Store(Local2, Local3)
	Store(Local3, Local4)
	Store(Local4, Local5)
	Store(Local5, Local6)
	Store(Local6, Local7)

	m380(ts, DerefOf(Local7), 0, 14)
	Store(DerefOf(Local0), Local7)
	m380(ts, Local7, 0, 15)
	Store(DerefOf(Local1), Local7)
	m380(ts, Local7, 0, 16)
	Store(DerefOf(Local2), Local7)
	m380(ts, Local7, 0, 17)
	Store(DerefOf(Local3), Local7)
	m380(ts, Local7, 0, 18)
	Store(DerefOf(Local4), Local7)
	m380(ts, Local7, 0, 19)
	Store(DerefOf(Local5), Local7)
	m380(ts, Local7, 0, 20)
	Store(DerefOf(Local6), Local7)
	m380(ts, Local7, 0, 21)

	// 2. ORef-LocalX
	m001(i000,i001,i002,i003,i004,i005,i006)
	m380(ts, i000, 0, 22)
	m380(ts, i001, 0, 23)
	m380(ts, i002, 0, 24)
	m380(ts, i003, 0, 25)
	m380(ts, i004, 0, 26)
	m380(ts, i005, 0, 27)
	m380(ts, i006, 0, 28)

	if (y134) {
		// 2. ORef-ArgX
		m002(i000,i001,i002,i003,i004,i005,i006)
		m380(ts, i000, 0, 29)
		m380(ts, i001, 0, 30)
		m380(ts, i002, 0, 31)
		m380(ts, i003, 0, 32)
		m380(ts, i004, 0, 33)
		m380(ts, i005, 0, 34)
		m380(ts, i006, 0, 35)
	}

	// 3. ORef-LocalX

	if (X128) {

		// This operation causes Bug 128
		CopyObject(RefOf(iii1), iii0)

		Store(RefOf(i000), Local0)
		Store(Local0, iii0)
		Store(DerefOf(iii0), Local1)
		m380(ts, i000, 0, 36)
		if (y523) {
			m380(ts, Local1, 0, 37)
		}
	}

	END0()
}

Method(m368,, Serialized)
{
	Name(ts, "m368")

	Name(i000, 0x77)

	BEG0(z111, ts)

	// 21. ORef-LocalX
	CopyObject(RefOf(i000), Local0)
	CopyObject(Local0, Local1)
	CopyObject(Local1, Local2)
	CopyObject(Local2, Local3)
	CopyObject(Local3, Local4)
	CopyObject(Local4, Local5)
	CopyObject(Local5, Local6)
	CopyObject(Local6, Local7)

	m380(ts, DerefOf(Local7), 0, 0)
	CopyObject(DerefOf(Local0), Local7)
	m380(ts, Local7, 0, 1)
	CopyObject(DerefOf(Local1), Local7)
	m380(ts, Local7, 0, 2)
	CopyObject(DerefOf(Local2), Local7)
	m380(ts, Local7, 0, 3)
	CopyObject(DerefOf(Local3), Local7)
	m380(ts, Local7, 0, 4)
	CopyObject(DerefOf(Local4), Local7)
	m380(ts, Local7, 0, 5)
	CopyObject(DerefOf(Local5), Local7)
	m380(ts, Local7, 0, 6)
	CopyObject(DerefOf(Local6), Local7)
	m380(ts, Local7, 0, 7)

	END0()
}

/*
 * Separately (though such are already):
 * put reference into element of Package
 * and then write another reference into
 * that element of that Package.
 * No any correlation must be.
 */

Name( i003, 0x12345678)
Name( p090, Package(9) {})
Name( p091, Package(9) {1,2,3,4,5,6,7,8,9})

Method(m271, 2)
{
	Store ( arg0, Index(p090, arg1))
}

// IRef upon IRef
Method(m272)
{
	m271(Index(p091, 1), 3)
	m271(Index(p091, 1), 3)
}

// IRef upon ORef
Method(m273)
{
	m271(Refof(i003), 4)
	m271(Index(p091, 1), 4)
}

// ORef upon IRef
Method(m274)
{
	m271(Index(p091, 1), 5)
	m271(Refof(i003), 5)
}

// ORef upon ORef
Method(m275)
{
	m271(Refof(i003), 6)
	m271(Refof(i003), 6)
}

Method(m276)
{
	m272()
	m273()
	m274()
	m275()
}


/*
 *
 * Simple Tests
 *
 */


// Simple TEST 1: read of ArgX-ORef with DerefOf
Method(m341,, Serialized)
{
	Name(ts, "m341")

	Name(i000, 0x19283746)
	Store(RefOf(i000), Local0)

	Method(m000, 1)
	{
		Store(DerefOf(Arg0), Local0)
		Add(Local0, 5, Local7)
		if (LNotEqual(Local7, 0x1928374b)) {
			err(ts, z111, 9, 0, 0, Local7, 0x1928374b)
		}
	}

	m000(Local0)
}

// Simple TEST 2: read of ArgX-ORef without DerefOf
Method(m342,, Serialized)
{
	Name(ts, "m342")

	Name(i000, 0)

	BEG0(z111, ts)

	Store(RefOf(i000), Local0)

	m1cc(ts, Local0, 1, 0)
	m1cd(ts, Local0, 1, 0)

	m1cc(ts, RefOf(i000), 1, 0)
	m1cd(ts, RefOf(i000), 1, 0)

	END0()
}

// Simple TEST 3: read of ArgX-IRef with DerefOf
Method(m343,, Serialized)
{
	Name(ts, "m343")

	Name(p000, Package () {11, 12, 13, 14, 15})
	Store(Index(p000, 3), Local0)

	Method(m000, 1)
	{
		Store(DerefOf(Arg0), Local0)
		Add(Local0, 5, Local7)
		if (LNotEqual(Local7, 19)) {
			err(ts, z111, 10, 0, 0, Local7, 19)
		}
	}

	m000(Local0)
}

// Simple TEST 4: read of ArgX-IRef without DerefOf
Method(m344,, Serialized)
{
	Name(ts, "m344")

	Name(p000, Package () {11, 12, 13, 14, 15})
	Store(Index(p000, 3), Local0)

	Method(m000, 1)
	{
		Add(Arg0, 5, Local7)
		if (LNotEqual(Local7, 19)) {
			err(ts, z111, 11, 0, 0, Local7, 19)
		}
	}

	m000(Local0)
}

// Simple TEST 8
Method(m345,, Serialized)
{
	Name(ts, "m345")

	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Name(s010, "qwer0000")
	Name(b010, Buffer(4) {1,0x77,3,4})
	Name(p010, Package(3) {5,0x77,7})

	// Store to reference keeping in LocalX
	Method(m000, 1)
	{
		Store(Index(arg0, 1, Local0), Local1)

		Store(0x90, Local0)
		if (LNotEqual(Local0, 0x90)) {
			err(ts, z111, 12, 0, 0, Local0, 0x90)
		}
		Store(0x91, Local1)
		if (LNotEqual(Local1, 0x91)) {
			err(ts, z111, 13, 0, 0, Local1, 0x91)
		}
	}

	// CopyObject to reference keeping in LocalX
	Method(m001, 1)
	{
		Store(Index(arg0, 1, Local0), Local1)

		CopyObject(0x94, Local0)
		if (LNotEqual(Local0, 0x94)) {
			err(ts, z111, 14, 0, 0, Local0, 0x94)
		}
		CopyObject(0x95, Local1)
		if (LNotEqual(Local1, 0x95)) {
			err(ts, z111, 15, 0, 0, Local1, 0x95)
		}
	}

	// Store to reference immediately
	Method(m002, 1)
	{
		Store(0x2b, Index(arg0, 1))
	}

	// Store to reference immediately
	Method(m003, 1)
	{
		Store(0x2b, Index(arg0, 1, Local0))
	}

	// CopyObject to reference immediately
	Method(m004, 1)
	{
		// CopyObject(0x96, Index(arg0, 1))
		// CopyObject(0x97, Index(arg0, 1, Local0))
	}

	BEG0(z111, ts)

	m000(s000)
	m000(b000)
	m000(p000)

	m381(ts, s000, 0, 0)
	m382(ts, b000, 0, 1)
	m383(ts, p000, 0, 2)

	m001(s000)
	m001(b000)
	m001(p000)

	m381(ts, s000, 0, 3)
	m382(ts, b000, 0, 4)
	m383(ts, p000, 0, 5)

	m002(s000)
	m002(b000)
	m002(p000)

	m385(ts, s000, 0, 6)
	m386(ts, b000, 0, 7)
	m387(ts, p000, 0, 8)

	m003(s010)
	m003(b010)
	m003(p010)

	m385(ts, s010, 0, 9)
	m386(ts, b010, 0, 10)
	m387(ts, p010, 0, 11)

	END0()
}

Method(m346,, Serialized)
{
	Name(ts, "m346")

	Name(i000, 0xabcd0000)

	Method(m000, 1)
	{
		Store(RefOf(arg0), Local0)
		Store(DerefOf(Local0), Local6)

		Store(0x11111111, RefOf(arg0))
		// CopyObject(0x11111111, RefOf(arg0))

		Store(DerefOf(Local0), Local7)

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c009)) {
			err(ts, z111, 16, 0, 0, Local1, c009)
		} else {
			Store(SizeOf(Local0), Local1)
			if (LNotEqual(Local1, ISZ0)) {
				err(ts, z111, 17, 0, 0, Local1, ISZ0)
			}
			if (LNotEqual(Local6, 0xabcd0000)) {
				err(ts, z111, 18, 0, 0, Local6, 0xabcd0000)
			}
			if (LNotEqual(Local7, 0x11111111)) {
				err(ts, z111, 19, 0, 0, Local7, 0x11111111)
			}
		}
	}

	m000(i000)
	if (LNotEqual(i000, 0xabcd0000)) {
		err(ts, z111, 20, 0, 0, i000, 0xabcd0000)
	}
}

Method(m347,, Serialized)
{
	Name(ts, "m347")

	Name(i000, 0xabcd0000)

	Method(m000, 1)
	{
		Store(DerefOf(RefOf(arg0)), Local0)
		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c009)) {
			err(ts, z111, 21, 0, 0, Local1, c009)
		} else {
			Store(SizeOf(Local0), Local1)
			if (LNotEqual(Local1, ISZ0)) {
				err(ts, z111, 22, 0, 0, Local1, ISZ0)
			}
			if (LNotEqual(Local0, 0xabcd0000)) {
				err(ts, z111, 23, 0, 0, Local0, 0xabcd0000)
			}
		}
	}

	m000(i000)
	if (LNotEqual(i000, 0xabcd0000)) {
		err(ts, z111, 24, 0, 0, i000, 0xabcd0000)
	}
}

Method(m348,, Serialized)
{
	Name(ts, "m348")

	Name(i000, 0xabcd0000)

	Method(m000, 1)
	{
		Store(RefOf(arg0), Local0)
		Store(DeRefOf(Local0), Local1)
		Store(DeRefOf(Local1), Local2)
		if (LNotEqual(Local2, 0xabcd0000)) {
			err(ts, z111, 25, 0, 0, Local2, 0xabcd0000)
		}

		Store(0x11111111, RefOf(arg0))
		Store(RefOf(arg0), Local0)
		Store(0x11111111, Local0)

		if (LNotEqual(Local0, 0x11111111)) {
			err(ts, z111, 26, 0, 0, Local0, 0x11111111)
		}
	}

	m000(RefOf(i000))
	if (LNotEqual(i000, 0xabcd0000)) {
		err(ts, z111, 27, 0, 0, i000, 0xabcd0000)
	}

	Store(RefOf(i000), Local0)
	m000(Local0)
	if (LNotEqual(i000, 0xabcd0000)) {
		err(ts, z111, 28, 0, 0, i000, 0xabcd0000)
	}
	Store(DeRefOf(Local0), Local2)
	if (LNotEqual(Local2, 0xabcd0000)) {
		err(ts, z111, 29, 0, 0, Local2, 0xabcd0000)
	}
}

Method(m349,, Serialized)
{
	Name(ts, "m349")

	Name(i000, 0xabcd0000)
	Name(i001, 0xabcd0001)

	Method(m000, 1)
	{
		Store(DeRefOf(RefOf(arg0)), Local1)
		Store(DeRefOf(Local1), Local2)
		if (LNotEqual(Local2, 0xabcd0000)) {
			err(ts, z111, 30, 0, 0, Local2, 0xabcd0000)
		}
	}

	Method(m001, 1)
	{
		Store(0x11111111, DerefOf(RefOf(arg0)))
		// CopyObject(0x11111111, DerefOf(RefOf(arg0)))
	}

	// Reading

	m000(RefOf(i000))
	if (LNotEqual(i000, 0xabcd0000)) {
		err(ts, z111, 31, 0, 0, i000, 0xabcd0000)
	}

	Store(RefOf(i000), Local0)
	m000(Local0)
	if (LNotEqual(i000, 0xabcd0000)) {
		err(ts, z111, 32, 0, 0, i000, 0xabcd0000)
	}
	if (y512) {
		Store(DeRefOf(Local0), Local2)
		if (LNotEqual(Local2, 0xabcd0000)) {
			err(ts, z111, 33, 0, 0, Local2, 0xabcd0000)
		}
	}

	// Writing

	m001(RefOf(i001))
	if (LNotEqual(i001, 0x11111111)) {
		err(ts, z111, 34, 0, 0, i001, 0x11111111)
	}

	Store(RefOf(i001), Local0)
	m001(Local0)
	if (LNotEqual(i001, 0x11111111)) {
		err(ts, z111, 35, 0, 0, i001, 0x11111111)
	}
	if (y512) {
		Store(DeRefOf(Local0), Local2)
		if (LNotEqual(Local2, 0x11111111)) {
			err(ts, z111, 36, 0, 0, Local2, 0x11111111)
		}
	}
}

Method(m34a,, Serialized)
{
	Name(ts, "m34a")

	Name(b000, Buffer() {1,2,0x69,4,5})

	Method(m000, 1)
	{
		Store(DeRefOf(arg0), Local2)
		if (LNotEqual(Local2, 0x69)) {
			err(ts, z111, 37, 0, 0, Local2, 0x69)
		}
	}

	// The same but use RefOf and than back DerefOf
	Method(m001, 1)
	{
		Store(RefOf(arg0), Local0)
		Store(DeRefOf(Local0), Local1)

		Store(DeRefOf(Local1), Local2)
		if (LNotEqual(Local2, 0x69)) {
			err(ts, z111, 38, 0, 0, Local2, 0x69)
		}
	}

	Method(m002, 1)
	{
		Store(0x11111111, RefOf(arg0))
		Store(RefOf(arg0), Local0)
		Store(0x11111111, Local0)

		if (LNotEqual(Local0, 0x11111111)) {
			err(ts, z111, 39, 0, 0, Local0, 0x11111111)
		}
	}

	// m000

	m000(Index(b000, 2))
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 40, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}

	Store(Index(b000, 2), Local0)
	m000(Local0)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 41, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	Store(DeRefOf(Local0), Local2)
	if (LNotEqual(Local2, 0x69)) {
		err(ts, z111, 42, 0, 0, Local2, 0x69)
	}

	Store(Index(b000, 2, Local0), Local1)
	m000(Local0)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 43, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	Store(DeRefOf(Local0), Local2)
	if (LNotEqual(Local2, 0x69)) {
		err(ts, z111, 44, 0, 0, Local2, 0x69)
	}
	m000(Local1)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 45, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	Store(DeRefOf(Local1), Local2)
	if (LNotEqual(Local2, 0x69)) {
		err(ts, z111, 46, 0, 0, Local2, 0x69)
	}

	// m001

	m001(Index(b000, 2))
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 47, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}

	Store(Index(b000, 2), Local0)
	m001(Local0)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 48, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	Store(DeRefOf(Local0), Local2)
	if (LNotEqual(Local2, 0x69)) {
		err(ts, z111, 49, 0, 0, Local2, 0x69)
	}

	Store(Index(b000, 2, Local0), Local1)
	m001(Local0)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 50, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	Store(DeRefOf(Local0), Local2)
	if (LNotEqual(Local2, 0x69)) {
		err(ts, z111, 51, 0, 0, Local2, 0x69)
	}
	m001(Local1)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 52, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	Store(DeRefOf(Local1), Local2)
	if (LNotEqual(Local2, 0x69)) {
		err(ts, z111, 53, 0, 0, Local2, 0x69)
	}

	// m002

	m002(Index(b000, 2))
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 54, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}

	Store(Index(b000, 2), Local0)
	m002(Local0)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 55, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	Store(DeRefOf(Local0), Local2)
	if (LNotEqual(Local2, 0x69)) {
		err(ts, z111, 56, 0, 0, Local2, 0x69)
	}

	Store(Index(b000, 2, Local0), Local1)
	m002(Local0)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 57, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	Store(DeRefOf(Local0), Local2)
	if (LNotEqual(Local2, 0x69)) {
		err(ts, z111, 58, 0, 0, Local2, 0x69)
	}
	m002(Local1)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 59, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	Store(DeRefOf(Local1), Local2)
	if (LNotEqual(Local2, 0x69)) {
		err(ts, z111, 60, 0, 0, Local2, 0x69)
	}
}

Method(m34b,, Serialized)
{
	Name(ts, "m34b")

	Name(b000, Buffer() {1,2,0x69,4,5})
	Name(b001, Buffer() {1,2,0x69,4,5})

	Method(m000, 1)
	{
		Store(DeRefOf(arg0), Local2)
		if (LNotEqual(Local2, 0x69)) {
			err(ts, z111, 61, 0, 0, Local2, 0x69)
		}
	}

	// The same but use RefOf and than back DerefOf
	Method(m001, 1)
	{
		Store(DeRefOf(RefOf(arg0)), Local1)

		Store(DeRefOf(Local1), Local2)
		if (LNotEqual(Local2, 0x69)) {
			err(ts, z111, 62, 0, 0, Local2, 0x69)
		}
	}

	Method(m002, 1)
	{
		Store(0x11111111, DerefOf(RefOf(arg0)))
		// CopyObject(0x11111111, DerefOf(RefOf(arg0)))
	}

	// m000

	m000(Index(b000, 2))
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 63, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}

	Store(Index(b000, 2), Local0)
	m000(Local0)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 64, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	Store(DeRefOf(Local0), Local2)
	if (LNotEqual(Local2, 0x69)) {
		err(ts, z111, 65, 0, 0, Local2, 0x69)
	}

	Store(Index(b000, 2, Local0), Local1)
	m000(Local0)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 66, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	Store(DeRefOf(Local0), Local2)
	if (LNotEqual(Local2, 0x69)) {
		err(ts, z111, 67, 0, 0, Local2, 0x69)
	}
	m000(Local1)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 68, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	Store(DeRefOf(Local1), Local2)
	if (LNotEqual(Local2, 0x69)) {
		err(ts, z111, 69, 0, 0, Local2, 0x69)
	}

	// m001

	m001(Index(b000, 2))
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 70, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}

	Store(Index(b000, 2), Local0)
	m001(Local0)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 71, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	if (y512) {
		Store(DeRefOf(Local0), Local2)
		if (LNotEqual(Local2, 0x69)) {
			err(ts, z111, 72, 0, 0, Local2, 0x69)
		}
	}

	Store(Index(b000, 2, Local0), Local1)
	m001(Local0)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 73, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	if (y512) {
		Store(DeRefOf(Local0), Local2)
		if (LNotEqual(Local2, 0x69)) {
			err(ts, z111, 74, 0, 0, Local2, 0x69)
		}
	}
	m001(Local1)
	if (LNotEqual(b000, Buffer() {1,2,0x69,4,5})) {
		err(ts, z111, 75, 0, 0, b000, Buffer() {1,2,0x69,4,5})
	}
	if (y512) {
		Store(DeRefOf(Local1), Local2)
		if (LNotEqual(Local2, 0x69)) {
			err(ts, z111, 76, 0, 0, Local2, 0x69)
		}
	}

	// m002

	m002(Index(b000, 2))
	if (LNotEqual(b000, Buffer() {1,2,0x11,4,5})) {
		err(ts, z111, 77, 0, 0, b000, Buffer() {1,2,0x11,4,5})
	}

	Store(Index(b000, 2), Local0)
	m002(Local0)
	if (LNotEqual(b000, Buffer() {1,2,0x11,4,5})) {
		err(ts, z111, 78, 0, 0, b000, Buffer() {1,2,0x11,4,5})
	}
	if (y512) {
		Store(DeRefOf(Local0), Local2)
		if (LNotEqual(Local2, 0x11)) {
			err(ts, z111, 79, 0, 0, Local2, 0x11)
		}
	}

	Store(Index(b000, 2, Local0), Local1)
	m002(Local0)
	if (LNotEqual(b000, Buffer() {1,2,0x11,4,5})) {
		err(ts, z111, 80, 0, 0, b000, Buffer() {1,2,0x11,4,5})
	}
	if (y512) {
		Store(DeRefOf(Local0), Local2)
		if (LNotEqual(Local2, 0x11)) {
			err(ts, z111, 81, 0, 0, Local2, 0x11)
		}
	}
	m002(Local1)
	if (LNotEqual(b000, Buffer() {1,2,0x11,4,5})) {
		err(ts, z111, 82, 0, 0, b000, Buffer() {1,2,0x11,4,5})
	}
	if (y512) {
		Store(DeRefOf(Local1), Local2)
		if (LNotEqual(Local2, 0x11)) {
			err(ts, z111, 83, 0, 0, Local2, 0x11)
		}
	}
}

// Simple TEST 17
Method(m34c,, Serialized)
{
	Name(ts, "m34c")

	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Name(s010, "qwer0000")
	Name(b010, Buffer(4) {1,0x77,3,4})
	Name(p010, Package(3) {5,0x77,7})

	Name(s020, "qwer0000")
	Name(b020, Buffer(4) {1,0x77,3,4})
	Name(p020, Package(3) {5,0x77,7})

	Name(s030, "qwer0000")
	Name(b030, Buffer(4) {1,0x77,3,4})
	Name(p030, Package(3) {5,0x77,7})

	// Store to reference keeping in LocalX
	Method(m000, 2)
	{
		Store(DerefOf(arg0), Local2)

		Store(ObjectType(Local2), Local3)
		if (LNotEqual(Local3, arg1)) {
			err(ts, z111, 84, 0, 0, Local3, arg1)
		}

		Store(Index(Local2, 1, Local0), Local1)

		Store(0x90, Local0)
		if (LNotEqual(Local0, 0x90)) {
			err(ts, z111, 85, 0, 0, Local0, 0x90)
		}
		Store(0x91, Local1)
		if (LNotEqual(Local1, 0x91)) {
			err(ts, z111, 86, 0, 0, Local1, 0x91)
		}
	}

	// CopyObject to reference keeping in LocalX
	Method(m001, 1)
	{
		Store(DerefOf(arg0), Local2)

		Store(Index(Local2, 1, Local0), Local1)

		CopyObject(0x94, Local0)
		if (LNotEqual(Local0, 0x94)) {
			err(ts, z111, 87, 0, 0, Local0, 0x94)
		}
		CopyObject(0x95, Local1)
		if (LNotEqual(Local1, 0x95)) {
			err(ts, z111, 88, 0, 0, Local1, 0x95)
		}
	}

	// Store to reference immediately
	Method(m002, 2)
	{
		Store(DerefOf(arg0), Local2)

		Store(0x2b, Index(Local2, 1))

		if (LEqual(arg1, c00a)) {
			m385(ts, Local2, 0, 0)
		} elseif (LEqual(arg1, c00b)) {
			m386(ts, Local2, 0, 1)
		} elseif (LEqual(arg1, c00c)) {
			m387(ts, Local2, 0, 2)
		}
	}

	// Store to reference immediately
	Method(m003, 2)
	{
		Store(DerefOf(arg0), Local2)

		Store(0x2b, Index(Local2, 1, Local0))

		if (LEqual(arg1, c00a)) {
			m385(ts, Local2, 0, 3)
		} elseif (LEqual(arg1, c00b)) {
			m386(ts, Local2, 0, 4)
		} elseif (LEqual(arg1, c00c)) {
			m387(ts, Local2, 0, 5)
		}

		Store(DerefOf(Local0), Local2)
		if (LNotEqual(Local2, 0x2b)) {
			err(ts, z111, 89, 0, 0, Local2, 0x2b)
		}
	}

	Method(m010, 2)
	{
		Store(RefOf(arg0), Local0)
		m000(Local0, arg1)

		m000(RefOf(arg0), arg1)

		if (LEqual(arg1, c00a)) {
			m381(ts, arg0, 0, 6)
		} elseif (LEqual(arg1, c00b)) {
			m382(ts, arg0, 0, 7)
		} elseif (LEqual(arg1, c00c)) {
			m383(ts, arg0, 0, 8)
		}
	}

	Method(m011, 2)
	{
		Store(RefOf(arg0), Local0)
		m001(Local0)

		m001(RefOf(arg0))

		if (LEqual(arg1, c00a)) {
			m381(ts, arg0, 0, 9)
		} elseif (LEqual(arg1, c00b)) {
			m382(ts, arg0, 0, 10)
		} elseif (LEqual(arg1, c00c)) {
			m383(ts, arg0, 0, 11)
		}
	}

	Method(m012, 2)
	{
		Store(RefOf(arg0), Local0)
		m002(Local0, arg1)

		if (LEqual(arg1, c00a)) {
			m381(ts, arg0, 0, 12)
		} elseif (LEqual(arg1, c00b)) {
			m382(ts, arg0, 0, 13)
		} elseif (LEqual(arg1, c00c)) {
			m383(ts, arg0, 0, 14)
		}
	}

	Method(m022, 2)
	{
		m002(RefOf(arg0), arg1)

		if (LEqual(arg1, c00a)) {
			m381(ts, arg0, 0, 15)
		} elseif (LEqual(arg1, c00b)) {
			m382(ts, arg0, 0, 16)
		} elseif (LEqual(arg1, c00c)) {
			m383(ts, arg0, 0, 17)
		}
	}

	Method(m013, 2)
	{
		Store(RefOf(arg0), Local0)
		m003(Local0, arg1)

		if (LEqual(arg1, c00a)) {
			m381(ts, arg0, 0, 18)
		} elseif (LEqual(arg1, c00b)) {
			m382(ts, arg0, 0, 19)
		} elseif (LEqual(arg1, c00c)) {
			m383(ts, arg0, 0, 20)
		}
	}

	Method(m023, 2)
	{
		m003(RefOf(arg0), arg1)

		if (LEqual(arg1, c00a)) {
			m381(ts, arg0, 0, 21)
		} elseif (LEqual(arg1, c00b)) {
			m382(ts, arg0, 0, 22)
		} elseif (LEqual(arg1, c00c)) {
			m383(ts, arg0, 0, 23)
		}
	}

	BEG0(z111, ts)

	m010(s000, c00a)
	m010(b000, c00b)
	m010(p000, c00c)

	m381(ts, s000, 0, 24)
	m382(ts, b000, 0, 25)
	m383(ts, p000, 0, 26)

	m011(s000, c00a)
	m011(b000, c00b)
	m011(p000, c00c)

	m381(ts, s000, 0, 27)
	m382(ts, b000, 0, 28)
	m383(ts, p000, 0, 29)

	m012(s000, c00a)
	m012(b000, c00b)
	m012(p000, c00c)

	m381(ts, s000, 0, 30)
	m382(ts, b000, 0, 31)
	m383(ts, p000, 0, 32)

	m022(s010, c00a)
	m022(b010, c00b)
	m022(p010, c00c)

	m381(ts, s010, 0, 33)
	m382(ts, b010, 0, 34)
	m383(ts, p010, 0, 35)

	m013(s020, c00a)
	m013(b020, c00b)
	m013(p020, c00c)

	m381(ts, s020, 0, 36)
	m382(ts, b020, 0, 37)
	m383(ts, p020, 0, 38)

	m023(s030, c00a)
	m023(b030, c00b)
	m023(p030, c00c)

	m381(ts, s030, 0, 39)
	m382(ts, b030, 0, 40)
	m383(ts, p030, 0, 41)

	END0()
}

Method(m34d, 1, Serialized)
{
	Name(ts, "m34d")

	Name(op00, 0)
	Name(op01, 1)
	Store(arg0, op00)

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Name(i010, 0x77)
	Name(s010, "qwer0000")
	Name(b010, Buffer(4) {1,0x77,3,4})
	Name(p010, Package(3) {5,0x77,7})

	Name(i020, 0x77)
	Name(s020, "qwer0000")
	Name(b020, Buffer(4) {1,0x77,3,4})
	Name(p020, Package(3) {5,0x77,7})

	Name(i030, 0x77)
	Name(s030, "qwer0000")
	Name(b030, Buffer(4) {1,0x77,3,4})
	Name(p030, Package(3) {5,0x77,7})

	Name(i040, 0x77)
	Name(s040, "qwer0000")
	Name(b040, Buffer(4) {1,0x77,3,4})
	Name(p040, Package(3) {5,0x77,7})

	Name(i050, 0x77)
	Name(s050, "qwer0000")
	Name(b050, Buffer(4) {1,0x77,3,4})
	Name(p050, Package(3) {5,0x77,7})

	Name(i060, 0x77)
	Name(s060, "qwer0000")
	Name(b060, Buffer(4) {1,0x77,3,4})
	Name(p060, Package(3) {5,0x77,7})

	Name(i070, 0x77)
	Name(s070, "qwer0000")
	Name(b070, Buffer(4) {1,0x77,3,4})
	Name(p070, Package(3) {5,0x77,7})

	Name(i001, 0x2b)
	Name(s001, "q+er0000")
	Name(b001, Buffer(4) {1,0x2b,3,4})
	Name(p001, Package(3) {5,0x2b,7})

	Method(m000, 3)
	{
		Method(m000, 3)
		{
			Method(m000, 3)
			{
				Method(m000, 3)
				{
					Store(ObjectType(arg0), Local0)
					if (LNotEqual(Local0, arg2)) {
						err(ts, z111, 90, 0, 0, Local0, arg2)
					}

					if (op00) {

					// CopyObject

					if (LEqual(arg1, c009)) {
						CopyObject(0x2b, arg0)
					} elseif (LEqual(arg1, c00a)) {
						CopyObject("q+er0000", arg0)
					} elseif (LEqual(arg1, c00b)) {
						CopyObject(Buffer(4) {1,0x2b,3,4}, arg0)
					} elseif (LEqual(arg1, c00c)) {
						CopyObject(Package(3) {5,0x2b,7}, arg0)
					}

					} else {

					// Store

					if (LEqual(arg1, c009)) {
						Store(0x2b, arg0)
					} elseif (LEqual(arg1, c00a)) {
						Store("q+er0000", arg0)
					} elseif (LEqual(arg1, c00b)) {
						Store(Buffer(4) {1,0x2b,3,4}, arg0)
					} elseif (LEqual(arg1, c00c)) {
						Store(Package(3) {5,0x2b,7}, arg0)
					}

					}

					Store(DerefOf(arg0), Local0)
					m391(Local0, arg1, 0, 0)
				}

				m000(arg0, arg1, arg2)
				Store(DerefOf(arg0), Local0)
				m391(Local0, arg1, 0, 1)
			}

			m000(arg0, arg1, arg2)
			Store(DerefOf(arg0), Local0)
			m391(Local0, arg1, 0, 2)
		}
		m000(arg0, arg1, arg2)
		Store(DerefOf(arg0), Local0)
		m391(Local0, arg1, 0, 3)
	}

	BEG0(z111, ts)

	// Write Integer

	Store(RefOf(i000), Local0)
	m000(Local0, c009, c009)
	m391(i000, c009, 0, 4)
	Store(DerefOf(Local0), Local2)
	m391(Local2, c009, 0, 5)

	Store(RefOf(s000), Local0)
	m000(Local0, c009, c00a)
	m391(s000, c009, 0, 6)
	Store(DerefOf(Local0), Local2)
	m391(Local2, c009, 0, 7)

	Store(RefOf(b000), Local0)
	m000(Local0, c009, c00b)
	m391(b000, c009, 0, 8)
	Store(DerefOf(Local0), Local2)
	m391(Local2, c009, 0, 9)

	Store(RefOf(p000), Local0)
	m000(Local0, c009, c00c)
	m391(p000, c009, 0, 10)
	Store(DerefOf(Local0), Local2)
	m391(Local2, c009, 0, 11)

	// Write String

	Store(RefOf(i010), Local0)
	m000(Local0, c00a, c009)
	m391(i010, c00a, 0, 12)
	Store(DerefOf(Local0), Local2)
	m391(Local2, c00a, 0, 13)

	Store(RefOf(s010), Local0)
	m000(Local0, c00a, c00a)
	m391(s010, c00a, 0, 14)
	Store(DerefOf(Local0), Local2)
	m391(Local2, c00a, 0, 15)

	Store(RefOf(b010), Local0)
	m000(Local0, c00a, c00b)
	m391(b010, c00a, 0, 16)
	Store(DerefOf(Local0), Local2)
	m391(Local2, c00a, 0, 17)

	Store(RefOf(p010), Local0)
	m000(Local0, c00a, c00c)
	m391(p010, c00a, 0, 18)
	Store(DerefOf(Local0), Local2)
	m391(Local2, c00a, 0, 19)

	// Write Buffer

	Store(RefOf(i020), Local0)
	m000(Local0, c00b, c009)
	m391(i020, c00b, 0, 20)
	Store(DerefOf(Local0), Local2)
	m391(Local2, c00b, 0, 21)

	Store(RefOf(s020), Local0)
	m000(Local0, c00b, c00a)
	m391(s020, c00b, 0, 22)
	Store(DerefOf(Local0), Local2)
	m391(Local2, c00b, 0, 23)

	Store(RefOf(b020), Local0)
	m000(Local0, c00b, c00b)
	m391(b020, c00b, 0, 24)
	Store(DerefOf(Local0), Local2)
	m391(Local2, c00b, 0, 25)

	Store(RefOf(p020), Local0)
	m000(Local0, c00b, c00c)
	m391(p020, c00b, 0, 26)
	Store(DerefOf(Local0), Local2)
	m391(Local2, c00b, 0, 27)

	// Write Package

	if (LNot(op00)) {
		if (LNot(y516)) {
			Store(0, op01)
		}
	}

	if (op01) {
		Store(RefOf(i030), Local0)
		m000(Local0, c00c, c009)
		m391(i030, c00c, 0, 28)
		Store(DerefOf(Local0), Local2)
		m391(Local2, c00c, 0, 29)

		Store(RefOf(s030), Local0)
		m000(Local0, c00c, c00a)
		m391(s030, c00c, 0, 30)
		Store(DerefOf(Local0), Local2)
		m391(Local2, c00c, 0, 31)

		Store(RefOf(b030), Local0)
		m000(Local0, c00c, c00b)
		m391(b030, c00c, 0, 32)
		Store(DerefOf(Local0), Local2)
		m391(Local2, c00c, 0, 33)

		Store(RefOf(p030), Local0)
		m000(Local0, c00c, c00c)
		m391(p030, c00c, 0, 34)
		Store(DerefOf(Local0), Local2)
		m391(Local2, c00c, 0, 35)
	}

	// Write Integer

	m000(RefOf(i040), c009, c009)
	m391(i040, c009, 0, 36)
	m000(RefOf(s040), c009, c00a)
	m391(i040, c009, 0, 37)
	m000(RefOf(b040), c009, c00b)
	m391(i040, c009, 0, 38)
	m000(RefOf(p040), c009, c00c)
	m391(i040, c009, 0, 39)

	// Write String

	m000(RefOf(i050), c00a, c009)
	m391(i050, c00a, 0, 40)
	m000(RefOf(s050), c00a, c00a)
	m391(i050, c00a, 0, 41)
	m000(RefOf(b050), c00a, c00b)
	m391(i050, c00a, 0, 42)
	m000(RefOf(p050), c00a, c00c)
	m391(i050, c00a, 0, 43)

	// Write Bufer

	m000(RefOf(i060), c00b, c009)
	m391(i060, c00b, 0, 44)
	m000(RefOf(s060), c00b, c00a)
	m391(i060, c00b, 0, 45)
	m000(RefOf(b060), c00b, c00b)
	m391(i060, c00b, 0, 46)
	m000(RefOf(p060), c00b, c00c)
	m391(i060, c00b, 0, 47)

	// Write Package
	if (op01) {
		m000(RefOf(i070), c00c, c009)
		m391(i070, c00c, 0, 48)
		m000(RefOf(s070), c00c, c00a)
		m391(i070, c00c, 0, 49)
		m000(RefOf(b070), c00c, c00b)
		m391(i070, c00c, 0, 50)
		m000(RefOf(p070), c00c, c00c)
		m391(i070, c00c, 0, 51)
	}

	END0()
}

Method(m34e, 1, Serialized)
{
	Name(ts, "m34e")

	Name(op00, 0)
	Store(arg0, op00)

	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Method(m000, 3)
	{
		Method(m000, 3)
		{
			Method(m000, 3)
			{
				Method(m000, 3)
				{
					Store(ObjectType(arg0), Local0)
					if (LNotEqual(Local0, arg2)) {
						err(ts, z111, 91, 0, 0, Local0, arg2)
					}
					if (op00) {
						CopyObject(0x2b, arg0)
					} else {
						Store(0x2b, arg0)
					}

					m391(arg0, arg1, 0, 0)
				}

				m000(arg0, arg1, arg2)
				Store(DerefOf(arg0), Local0)
				m390(Local0, arg1, 0, 1)
			}

			m000(arg0, arg1, arg2)
			Store(DerefOf(arg0), Local0)
			m390(Local0, arg1, 0, 2)
		}
		m000(arg0, arg1, arg2)
		Store(DerefOf(arg0), Local0)
		m390(Local0, arg1, 0, 3)
	}

	BEG0(z111, ts)

	// String

	Store(Index(s000, 1), Local0)
	m000(Local0, c009, c016)
	m390(s000, c00a, 0, 4)
	Store(DerefOf(Local0), Local2)
	m380(ts, Local2, 0, 5)

	// Buffer

	Store(Index(b000, 1), Local0)
	m000(Local0, c009, c016)
	m390(b000, c00b, 0, 6)
	Store(DerefOf(Local0), Local2)
	m380(ts, Local2, 0, 7)

	// Package

	Store(Index(p000, 1), Local0)
	m000(Local0, c009, c009)
	m390(p000, c00c, 0, 8)
	Store(DerefOf(Local0), Local2)
	m380(ts, Local2, 0, 9)

	END0()
}

Method(m34f,, Serialized)
{
	Name(ts, "m34f")

	BEG0(z111, ts)

	Store(0x77, RefOf(i900))
	m380(ts, i900, 0, 0)
	Store(0x77, RefOf(s900))
	m4c0(ts, s900, "0000000000000077", "00000077")
	Store(0x77, RefOf(b900))
	m1aa(ts, b900, c00b, Buffer(4) {0x77,0,0,0,0}, 1)
	Store(0x77, RefOf(p953))
	m380(ts, p953, 0, 2)
	Store(0x77, RefOf(e900))
	m380(ts, e900, 0, 3)
	Store(0x77, RefOf(mx90))
	m380(ts, mx90, 0, 4)
	Store(0x77, RefOf(d900))
	m380(ts, d900, 0, 5)
	if (y508) {
		Store(0x77, RefOf(tz90))
		m380(ts, tz90, 0, 6)
	}
	Store(0x77, RefOf(pr90))
	m380(ts, pr90, 0, 7)
	if (y510) {
		Store(0x77, RefOf(r900))
		m380(ts, r900, 0, 8)
	}
	Store(0x77, RefOf(pw90))
	m380(ts, pw90, 0, 9)

	m1ac()

	m1a6()

	END0()
}

// CURRENTLY: compiler failed CopyObject(xx, RefOf(xx))
Method(m350,, Serialized)
{
	Name(ts, "m350")

	// CopyObject(0x77, RefOf(i900))
}

// Write Integer into Package and verify the obtained contents
// arg0 - Package
Method(m351, 1, Serialized)
{
	Name(ts, "m351")

	Name(lpN0, 17)
	Name(lpC0, 0)

	Store(0x10, Local6)

	While (lpN0) {
		Store(Local6, Index(arg0, lpC0))
		Increment(Local6)

		Decrement(lpN0)
		Increment(lpC0)
	}

	// Check that elements of Package are properly changed

	Store(17, lpN0)
	Store(0, lpC0)

	Store(0x10, Local6)

	While (lpN0) {
		Store(Index(arg0, lpC0), Local0)
		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c009)) {
			err(ts, z111, 92, 0, 0, Local1, c009)
		} else {
			Store(DerefOf(Local0), Local1)
			if (LNotEqual(Local1, Local6)) {
				err(ts, z111, 93, 0, 0, Local1, Local6)
			}
		}
		Increment(Local6)

		Decrement(lpN0)
		Increment(lpC0)
	}
}

// Write ORef into Package
// arg0 - Package
Method(m352, 1)
{
	Store(0, Index(arg0, 0))

	Store(RefOf(i900), Index(arg0, 1))
	Store(RefOf(s900), Index(arg0, 2))
	Store(RefOf(b900), Index(arg0, 3))
	Store(RefOf(p953), Index(arg0, 4))
	Store(RefOf(f900), Index(arg0, 5))

	Store(RefOf(d900), Index(arg0, 6))
	Store(RefOf(e900), Index(arg0, 7))
	Store(RefOf(m914), Index(arg0, 8))
	Store(RefOf(mx90), Index(arg0, 9))
	Store(RefOf(r900), Index(arg0, 10))
	Store(RefOf(pw90), Index(arg0, 11))
	Store(RefOf(pr90), Index(arg0, 12))
	Store(RefOf(tz90), Index(arg0, 13))

	Store(RefOf(bf90), Index(arg0, 14))

	Store(15, Index(arg0, 15))
	Store(16, Index(arg0, 16))
}

// Write IRef (Index(p955, x)) into Package
// arg0 - Package
// arg1 - 0 - Store, otherwise - CopyObject
Method(m353, 2, Serialized)
{
	Name(lpN0, 17)
	Name(lpC0, 0)

	if (arg1) {
		/*
		 * While (lpN0) {
		 *	CopyObject(Index(p955, lpC0), Index(arg0, lpC0))
		 *	Decrement(lpN0)
		 *	Increment(lpC0)
		 * }
		 * CopyObject(0, Index(arg0, 0))
		 * CopyObject(15, Index(arg0, 15))
		 * CopyObject(16, Index(arg0, 16))
		 */
	} else {
		While (lpN0) {
			Store(Index(p955, lpC0), Index(arg0, lpC0))
			Decrement(lpN0)
			Increment(lpC0)
		}
		Store(0, Index(arg0, 0))
		Store(15, Index(arg0, 15))
		Store(16, Index(arg0, 16))
	}
}

Method(m362,, Serialized)
{
	Name(i000, 0)

	Method(m000, 1)
	{
		Add(0x76, 1, Local0)
		Store(Local0, arg0)
	}

	m000(RefOf(i000))
	m380("m362", i000, z111, 0)
}

Method(m363,, Serialized)
{
	Name(i000, 0)

	Method(m000, 1)
	{
		Add(0x76, 1, arg0)
	}

	m000(RefOf(i000))
	m380("m363", i000, z111, 0)
}


Method(m364,, Serialized)
{
	Name(i000, 0)

	Method(m000, 1)
	{
		Add(0x76, 1, arg0)
	}

	Store(RefOf(i000), Local0)
	m000(Local0)
	m380("m364", i000, z111, 0)
}


/*
 *
 * Auxiliary Methods
 *
 */


// Run all the ORef relevant Methods of ref1-ref4
Method(m4d0)
{
	m16f(0, 0, 1, 1, 1, 0, 0)
	m175(0, 1, 1)
	m185(0, 1, 1)
	m195(0, 1, 1, 1, 0)
}

// Run all the IRef relevant Methods of ref1-ref4
Method(m4d1)
{
	m16f(1, 1, 0, 0, 0, 1, 1)
	m175(1, 0, 0)
	m185(1, 0, 0)
	m195(1, 0, 0, 0, 1)
}

// Run all the NamedX-ORef relevant Methods of ref1-ref4
Method(m4d2)
{
	m16f(0, 0, 1, 1, 1, 0, 0)
	m175(0, 1, 1)
	m185(0, 1, 1)
	m195(0, 1, 1, 1, 0)
}

// Run all the NamedX-IRef relevant Methods of ref1-ref4
Method(m4d3)
{
	m16f(0, 1, 0, 0, 0, 0, 1)
	m175(1, 0, 0)
	m185(1, 0, 0)
	m195(1, 0, 0, 0, 1)
}

/*
Method(m4d0) {}
Method(m4d1) {}
Method(m4d2) {}
Method(m4d3) {}
Method(m1e0, 1) {}
*/

Method(mfab,, Serialized)
{
	/*
	 * Update required: do this test for different type target objects
	 * and reference elements (Iref/Oref; LocalX/ArgX/NamedX/...).
	 */

	Name(pp00, Package() {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87})
	Name(p000, Package() {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,
					0x08,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0f})

	// Over Integers

	Store(RefOf(pp00), Index(p000, 0))
	Store(Index(p000,  0), Index(p000, 1))
	Store(Index(p000,  1), Index(p000, 2))
	Store(Index(p000,  2), Index(p000, 3))
	Store(Index(p000,  3), Index(p000, 4))
	Store(Index(p000,  4), Index(p000, 5))
	Store(Index(p000,  5), Index(p000, 6))
	Store(Index(p000,  6), Index(p000, 7))
	Store(Index(p000,  7), Index(p000, 8))
	Store(Index(p000,  8), Index(p000, 9))
	Store(Index(p000,  9), Index(p000, 10))
	Store(Index(p000, 10), Index(p000, 11))
	Store(Index(p000, 11), Index(p000, 12))
	Store(Index(p000, 12), Index(p000, 13))
	Store(Index(p000, 13), Index(p000, 14))
	Store(Index(p000, 14), Index(p000, 15))

	Index(p000, 15, Local0)
	Store(ObjectType(Local0), Local1)
	if (LNotEqual(Local1, c01c)) {
		err("mfab", z111, 94, 0, 0, Local1, c01c)
	}

	Store(ObjectType(DerefOf(Local0)), Local1)
	if (LNotEqual(Local1, c01c)) {
		err("mfab", z111, 95, 0, 0, Local1, c01c)
	}
}

Method(mfad,, Serialized)
{
	/*
	 * Update required: do this test for different type target objects
	 * and reference elements (Iref/Oref; LocalX/ArgX/NamedX/...).
	 */

	Name(i000, 0xabcd0000)
	Name(p000, Package() {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,
					0x08,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0f})

	// Over Integers

	Store(RefOf(i000), Index(p000, 0))
	Store(Index(p000,  0), Index(p000, 1))
	Store(Index(p000,  1), Index(p000, 2))
	Store(Index(p000,  2), Index(p000, 3))
	Store(Index(p000,  3), Index(p000, 4))
	Store(Index(p000,  4), Index(p000, 5))
	Store(Index(p000,  5), Index(p000, 6))
	Store(Index(p000,  6), Index(p000, 7))
	Store(Index(p000,  7), Index(p000, 8))
	Store(Index(p000,  8), Index(p000, 9))
	Store(Index(p000,  9), Index(p000, 10))
	Store(Index(p000, 10), Index(p000, 11))
	Store(Index(p000, 11), Index(p000, 12))
	Store(Index(p000, 12), Index(p000, 13))
	Store(Index(p000, 13), Index(p000, 14))
	Store(Index(p000, 14), Index(p000, 15))
	Store(Index(p000, 15), Index(p000, 0))

	Index(p000, 15, Local0)

	Store(Local0, Debug)

	if (0) {
		Store(ObjectType(Local0), Local1)
		Store(Local1, Debug)
		if (LNotEqual(Local1, c01c)) {
			err("mfad", z111, 96, 0, 0, Local1, c01c)
		}
	} else {
		/*
		 * ObjectType here falls into the infinitive loop.
		 * Sort this out!
		 */
		err("mfad", z111, 97, 0, 0, 0, 0)
	}
}

Method(mfc3,, Serialized)
{
	/*
	 * Update required: do this test for different type target objects
	 * and reference elements (Iref/Oref; LocalX/ArgX/NamedX/...).
	 */

	Name(i000, 0xabcd0000)
	Name(p000, Package() {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,
					0x08,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0f})

	// Over Integers

	Store(RefOf(i000), Index(p000, 0))
	Store(Index(p000,  0), Index(p000, 1))
	Store(Index(p000,  1), Index(p000, 2))
	Store(Index(p000,  2), Index(p000, 3))
	Store(Index(p000,  3), Index(p000, 4))
	Store(Index(p000,  4), Index(p000, 5))
	Store(Index(p000,  5), Index(p000, 6))
	Store(Index(p000,  6), Index(p000, 7))
	Store(Index(p000,  7), Index(p000, 8))
	Store(Index(p000,  8), Index(p000, 9))
	Store(Index(p000,  9), Index(p000, 10))
	Store(Index(p000, 10), Index(p000, 11))
	Store(Index(p000, 11), Index(p000, 12))
	Store(Index(p000, 12), Index(p000, 13))
	Store(Index(p000, 13), Index(p000, 14))
	Store(Index(p000, 14), Index(p000, 15))
	Store(Index(p000, 15), Index(p000, 0))

	Index(p000, 15, Local0)

	Store(Local0, Debug)

	if (0) {
		Store(SizeOf(Local0), Local1)
		Store(Local1, Debug)
		if (LNotEqual(Local1, 100)) {
			err("mfc3", z111, 98, 0, 0, Local1, 100)
		}
	} else {
		/*
		 * SizeOf here falls into the infinitive loop.
		 * Sort this out!
		 */
		err("mfc3", z111, 99, 0, 0, 0, 0)
	}
}


Method(mfc4,, Serialized)
{
	/*
	 * Update required: do this test for different type target objects
	 * and reference elements (Iref/Oref; LocalX/ArgX/NamedX/...).
	 */

	Name(i000, 0xabcd0000)
	Name(p000, Package() {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,
					0x08,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0f})

	// Over Integers

	Store(RefOf(i000), Index(p000, 0))
	Store(Index(p000,  0), Index(p000, 1))
	Store(Index(p000,  1), Index(p000, 2))
	Store(Index(p000,  2), Index(p000, 3))
	Store(Index(p000,  3), Index(p000, 4))
	Store(Index(p000,  4), Index(p000, 5))
	Store(Index(p000,  5), Index(p000, 6))
	Store(Index(p000,  6), Index(p000, 7))
	Store(Index(p000,  7), Index(p000, 8))
	Store(Index(p000,  8), Index(p000, 9))
	Store(Index(p000,  9), Index(p000, 10))
	Store(Index(p000, 10), Index(p000, 11))
	Store(Index(p000, 11), Index(p000, 12))
	Store(Index(p000, 12), Index(p000, 13))
	Store(Index(p000, 13), Index(p000, 14))
	Store(Index(p000, 14), Index(p000, 15))
	Store(Index(p000, 15), Index(p000, 0))

	Index(p000, 15, Local0)

	Store(Local0, Debug)

	if (1) {
		Store(DerefOf(Local0), Local1)
		Store(Local1, Debug)
		if (LNotEqual(Local1, 100)) {
			err("mfc4", z111, 100, 0, 0, Local1, 100)
		}
	} else {
		/*
		 * SizeOf here falls into the infinitive loop.
		 * Sort this out!
		 */
		err("mfc4", z111, 101, 0, 0, 0, 0)
	}
}

/*

!!!!!!!!!!!!!!!!!!!!!!!
Do this test, like this - run Derefof for the chain of references (IR/OR)
and for ring of them.
I dont remember if we have already such test.
!!!!!!!!!!!!!!!!!!!!!!!

	Method(m000)
	{
		 *
		 * Printing excluded while bug 206 (Store-to-Debug operation
		 * falls into infinite loop for ring of RefOf references) is
		 * not fixed.
		 *

		Store(RefOf(Local0), Local1)
		Store(RefOf(Local1), Local2)
		Store(RefOf(Local2), Local0)

		Store(DerefOf(Local0), Local7)
		Store(Local7, Debug)

		Store(DerefOf(Local7), Local6)
		Store(Local6, Debug)

		Store(DerefOf(Local6), Local5)
		Store(Local5, Debug)
	}
*/

// Run-method
Method(REF9)
{
	Store("TEST: REF9, Object and Index References and the call-by-reference convention", Debug)

	Store(1, c085) // create the chain of references to LocalX, then dereference them
	Store(0, c086) // flag, run test till the first error
	Store(1, c088) // test run mode
	Store(0, c089) // flag of Reference, object otherwise
	Store(0, c08b) // do RefOf(ArgX) checkings

	if (LNot(c088)) {
		Store("A T T E N T I O N: simple mode!", Debug)
	}

if (1) {

	SRMT("m221")
	m221()
	SRMT("m222")
	m222()
	SRMT("m223")
	m223()
	SRMT("m224")
	m224()
	SRMT("m225")
	m225()
	SRMT("m226")
	m226()
	SRMT("m227")
	m227()
	SRMT("m228")
	m228()
	SRMT("m229")
	m229()
	SRMT("m22a")
	m22a()
	SRMT("m22b")
	m22b()
	SRMT("m22c")
	m22c()
	SRMT("m22d")
	if (y164) {
		m22d()
	} else {
		BLCK()
	}
	SRMT("m22e")
	m22e()
	SRMT("m22f")
	m22f()
	SRMT("m230")
	m230()
	SRMT("m231")
	m231()
	SRMT("m232")
	m232()
	SRMT("m233")
	m233() // bug 130 (m34c)
	SRMT("m234")
	m234()
	SRMT("m235")
	m235()
	SRMT("m236")
	m236()
	SRMT("m237")
	m237()
	SRMT("m238")
	m238()
	SRMT("m239")
	m239()
	SRMT("m23a")
	m23a()
	SRMT("m23b")
	m23b()
	SRMT("m23c")
	m23c()
	SRMT("m23d")
	m23d()
	SRMT("m23e")
	m23e()
	SRMT("m23f")
	m23f()
	SRMT("m250")
	m250()
	SRMT("m251")
	m251()
	SRMT("m252")
	m252()
	SRMT("m253")
	m253()
	SRMT("m254")
	m254()
	SRMT("m255")
	m255()
	SRMT("m256")
	m256()
	SRMT("m257")
	m257()
	SRMT("m258")
	m258(0)
	SRMT("m259")
	m259()
	SRMT("m25a")
	m25a()
	SRMT("m25b")
	m25b()
	SRMT("m25c")
	m25c()
	SRMT("m25d")
	m25d()
	SRMT("m25e")
	m25e()
	SRMT("m25f")
	m25f()
	SRMT("m260")
	m260()
	SRMT("m261")
	m261()
	SRMT("m262")
	m262()
	SRMT("m263")
	m263()
	SRMT("m264")
	m264()
	SRMT("m265")
	m265()
	SRMT("m266")
	m266()
	SRMT("m267")
	m267()
	SRMT("m268")
	m268()
	SRMT("m269")
	m269()
	SRMT("m26a")
	m26a()
	SRMT("m26b")
	if (y164) {
		m26b() // bugs, see inside
	} else {
		BLCK()
	}
	SRMT("m26c")
	m26c()
	SRMT("m26d")
	m26d()
	SRMT("m26e")
	m26e() // bug 131 (m365)
	SRMT("m26f")
	m26f()

	SRMT("m270")
	m270() // bug 134
	SRMT("m276")
	m276()

	SRMT("mfab")
	if (y603) {
		mfab()
	} else {
		BLCK()
	}

	SRMT("mfad")
	if (y603) {
		mfad()
	} else {
		BLCK()
	}

	SRMT("mfc3")
	if (y603) {
		mfc3()
	} else {
		BLCK()
	}

	SRMT("mfc4")
	if (y603) {
		mfc4()
	} else {
		BLCK()
	}

} else {

	// To run particular sub-tests here

	SRMT("m1d5")
	m1d5()


/*
	SRMT("m23b")
	m23b()

	SRMT("m251")
	m251()
*/

/*
	SRMT("mfab")
	mfab()

	SRMT("mfad")
	mfad()

	SRMT("mfc3")
	mfc3()

	SRMT("mfc4")
	mfc4()

//	SRMT("m234")
//	m234()
//	SRMT("m26b")
//	m26b()
//	m251()
//	m22d()
//	m26b()
//	m276()
*/
}


// SEE and do these below:

/*
1. See bug 130, add this checking:
   see this when worked on m233()

	Method(m000, 1)
	{
//		Store(DerefOf(arg0), Local2)
//		Store(0x2b, Index(Local2, 1))

		Store(0x2b, Index(DerefOf(arg0), 1))
	}
2. do many enclosed method calls
   to show that index to Str,Buf,Pckg
   changes the intial object nevertheless

*/
/*
Method (M001)
{
Name(P004, Package(Add (128, 3)) {})
Name(P005, Package(Add (128, 1024)) {})
}
*/
/*
Use the same object in several operands and results
*/

}


