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
 * Miscellaneous not systematized tests
 */

Name(z054, 54)

// Looks like Default is at all not implemented

Method(m110, 1, Serialized)
{
	Store(0, Local0)
	Store(0, Local1)

	// Bug XXX. This Switch code below causes ASL-compiler to fail
	// for full.asl file with the diagnostics like this:
	// nssearch-0397: *** Error: NsSearchAndEnter:
	//                    Bad character in ACPI Name: 5B5F545F
	// and fall into recursion:
	// Remark   3040 -     Recursive method call ^  (ERR_)
	// Note: (0x5B5F545F is equal to "[_T_")
	Switch (ToInteger (Local1)) {
		Case (5) {
			Store(5, Local0)
		}
		Default {
			Store(1, Local0)
		}
	}

	if (LNotEqual(Local0, 1)) {
		err(arg0, z054, 0, 0, 0, Local0, 0)
	}
}

// Concatenate operator affects the object passed as Source2 parameter

Method(m111, 1) {
	Store(Concatenate("qwertyuiop", arg0), Local5)
}

Method(m112, 1)
{
	Store(0, Local0)
	m111(Local0)
	if (LNotequal(Local0, 0)) {
		err(arg0, z054, 1, 0, 0, Local0, 0)
	}

	Store(0, Local0)
	Store(Concatenate("qwertyuiop", Local0), Local5)
	if (LNotequal(Local0, 0)) {
		err(arg0, z054, 2, 0, 0, Local0, 0)
	}
}

// Unexpected value returned by ObjectType for Field Unit objects

// The field passed as explicit reference (RefOf)
Method(m113, 1, Serialized)
{
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field (r000, ByteAcc, NoLock, Preserve) {
		f000, 32
	}

	Store(ObjectType(RefOf(f000)), Local0)
	if (LNotEqual(Local0, 5)) {
		err(arg0, z054, 3, 0, 0, Local0, 0)
	}
}

// The BankField corrupts the contents of OperationRegion

Method(m114, 1, Serialized)
{
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field (r000, ByteAcc, NoLock, Preserve) {
		bnk0, 8
	}

	BankField (r000, bnk0, 0, ByteAcc, NoLock, Preserve) {
		Offset(16),
		bf00, 8,
	}

	BankField (r000, bnk0, 1, ByteAcc, NoLock, Preserve) {
		Offset(17),
		bf01, 8,
	}

	// Deal with 0-th bank layout:

	Store(0, bnk0)
	if (LNotEqual(bnk0, 0)) {
		err(arg0, z054, 4, 0, 0, bnk0, 0)
	}

	Store(0x87, bf00)
	if (LNotEqual(bnk0, 0)) {
		err(arg0, z054, 5, 0, 0, bnk0, 0)
	}

	if (LNotEqual(bf00, 0x87)) {
		err(arg0, z054, 6, 0, 0, bf00, 0x87)
	}

	// Deal with 1-th bank layout:

	Store(1, bnk0)
	if (LNotEqual(bnk0, 1)) {
		err(arg0, z054, 7, 0, 0, bnk0, 1)
	}

	Store(0x96, bf01)

	if (X192) {
		if (LNotEqual(bnk0, 1)) {
			err(arg0, z054, 8, 0, 0, bnk0, 1)
		}
	}

	if (LNotEqual(bf01, 0x96)) {
		err(arg0, z054, 9, 0, 0, bf01, 0x96)
	}
}

// ToBuffer caused destroying of source buffer passed by Data parameter
Method(m115, 1)
{
	Store(Buffer(4){10, 11, 12, 13}, Local0)
	Store(ObjectType(Local0), Local1)

	if (LNotEqual(Local1, c00b)) {
		err(arg0, z054, 9, 0, 0, Local1, 0)
	}

	ToBuffer(Local0, Local2)

	Store(0xaa, Local3)

	Store(ObjectType(Local0), Local3)

	if (LNotEqual(Local3, c00b)) {
		err(arg0, z054, 10, 0, 0, Local3, 0)
	}
}

// ObjectType() operator should be allowed to deal with the
// uninitialized objects.

// Uncomment this when the problem will be fixed and compile
// will not fail in this case like it do now: "Method local
// variable is not initialized (Local0)".
Method(m116, 1)
{
	Store(ObjectType(Local0), Local1)
}

// Now, this cause exception but should not
Method(m117, 2, Serialized)
{
	Name(ts, "m117")

	if (arg1) {
		Store(0, Local0)
	}

	CH03(ts, z054, 0x100, 0, 0)

	Store(ObjectType(Local0), Local1)

	if (LNotEqual(Local1, 0)) {
		err(arg0, z054, 11, 0, 0, Local1, 0)
	}

	CH03(ts, z054, 0x101, 0, 0)
}

Method(m118, 1)
{
	m117(arg0, 0)
}

/*
 * Bug 12, Bugzilla 5360.
 * DerefOf. If the Source evaluates to a string, the string is evaluated
 * as an ASL name (relative to the current scope) and the contents of that
 * object are returned.
 */
Method(m119, 1, Serialized)
{
	Name(b000, Buffer(){ 1, 2, 3, 4, 5, 6, 7, 8 })

	Store("b000", Local0)

	Store("================ 0:", Debug)

	Store(DerefOf(Local0), Local1)

	Store("================ 1:", Debug)

	Store(ObjectType(Local1), Local2)

	if (LNotEqual(Local2, 3)) {
		err(arg0, z054, 12, 0, 0, Local2, 0)
	}

	Store("================ 2:", Debug)

	Store(Local1, Debug)
	Store(Local2, Debug)

	CH03(arg0, z054, 0x102, 0, 0)

	return (0)
}

/*
// Currently, incorrect test
// The size of Strings in Package is determined incorrectly
Method(m11a, 1)
{
	Name(p000, Package() {
		"012",
		"0123456789abcdef",
		Buffer() {17,28,69,11,22,34,35,56,67,11},
		"012345",
	})

	Store(DeRefOf(Index(p000, 1)), Local0)
	Store(0, Index(Local0, 5))

	Store(0, Index(p000, 1))

	Store(DeRefOf(Index(p000, 1)), Local0)
//	Store(0, Index(Local0, 5))

	Store("=================:", Debug)
	Store(Local0, Debug)

	// 0
	Store(DeRefOf(Index(p000, 0)), Local2)
	Store(SizeOf(Local2), Local3)

	Store(Local3, Debug)

	if (LNotEqual(Local3, 3)) {
		err(arg0, z054, 13, 0, 0, Local3, 3)
	}

	// 1
	Store(DeRefOf(Index(p000, 1)), Local2)
	Store(SizeOf(Local2), Local3)

	Store(Local3, Debug)

	if (LNotEqual(Local3, 9)) {
		err(arg0, z054, 14, 0, 0, Local3, 9)
	}

	// 2
	Store(DeRefOf(Index(p000, 2)), Local2)
	Store(SizeOf(Local2), Local3)

	Store(Local3, Debug)

	if (LNotEqual(Local3, 6)) {
		err(arg0, z054, 15, 0, 0, Local3, 6)
	}

	Store(SizeOf(p000), Local0)

	Store(Local0, Debug)

	if (LNotEqual(Local0, 3)) {
		err(arg0, z054, 16, 0, 0, Local0, 3)
	}
}
*/

/*
// ATTENTION: such type tests have to be added and extended
Method(m11b, 1)
{
	Name(p000, Package() {
		0x12345678, 0x90abcdef,
	})
	Name(b000, Buffer() {0x78,0x56,0x34,0x12, 0xef,0xcd,0xab,0x90})

	Store(DeRefOf(Index(p000, 0)), Local7)

	if (LEqual(b000, Local7)) {
		err(arg0, z054, 17, 0, 0, b000, Local7)
	}

	if (LEqual(Local7, b000)) {
		err(arg0, z054, 18, 0, 0, Local7, b000)
	}

	return (0)
}
*/


// Bug 54: All the ASL Operators which deal with at least two Buffer type
// objects cause unexpected exceptions in cases when both Buffer type objects
// are passed immediately
Method(m11c, 1, Serialized)
{
	Name(ts, "m11c")

	CH03(ts, z054, 0x103, 0, 0)

	Store(Add( Buffer() {0x79}, Buffer() {0x79} ), Local5)

	CH03(ts, z054, 0x104, 0, 0)
}

// Bug 57: The empty Return operator (without specifying the returning value)
// is processed incorrectly
Method(m11d, 1) {

	Method(m11e, 2) {

		if (arg1) {
			return (0x1234)

			// ASL-compiler report Warning in this case
			// Store("ERROR 0: m121, after Return !!!", Debug)
		}
		err(arg0, z054, 19, 0, 0, 0, 0)

		return (0x5678)
	}

	Method(m11f, 2) {

		if (arg1) {

			return

			// ASL-compiler DOESN'T report Warning in this case!!!
			// And the Store operator below is actually processed!!!

			err(arg0, z054, 20, 0, 0, 0, 0)
		}

		err(arg0, z054, 21, 0, 0, 0, 0)

		return
	}

	Store(m11e(arg0, 1), Local7)

	m11f(arg0, 1)

	return (0)
}

/*
 * Obsolete:
 * Bug 59: The String to Buffer Rule from the Table 17-8 "Object Conversion
 * Rules" says "If the string is shorter than the buffer, the buffer size is
 * reduced".
 * Updated specs 12.03.05:
 * "If the string is shorter than the buffer,
 * the remaining buffer bytes are set to zero".
 */
Method(m11e, 1, Serialized) {
	Name(str0, "\x01\x02")
	Name(buf0, Buffer(){0x03, 0x04, 0x05, 0x06})

	Store(str0, buf0)

	/*
	 * Obsolete:
	 *
	 * if (LNotEqual(Sizeof(buf0), 3)) {
	 *	// Error: length of the buffer not reduced to the stored string
	 *	err(arg0, z054, 22, 0, 0, 0, 0)
	 * }
	 *
	 * New:
	 */
	if (LNotEqual(buf0, Buffer(){0x01, 0x02, 0, 0})) {
		err(arg0, z054, 22, 0, 0, buf0, Buffer(){0x01, 0x02, 0, 0})
	}
	return (0)
}

// Bug 65: The Buffer Field type objects should be passed
// to Methods without any conversion, but instead
// they are converted to Buffers or Integers depending
// on the size of the Buffer Field object and the
// run mode (32-bit or 64/bit mode).
//
// CANCELED: now it should perform opposite assertion because
// this bug was canceled.
Method(m11f, 1, Serialized) {
	Name(b000, Buffer(200) {})
	CreateField(b000, 0,  31, bf00)
	CreateField(b000, 31, 32, bf01)
	CreateField(b000, 63, 33, bf02)

	CreateField(b000, 96,  63, bf03)
	CreateField(b000, 159, 64, bf04)
	CreateField(b000, 223, 65, bf05)

	Method(m000, 4)
	{
		Store(ObjectType(arg1), Local0)
		if (LNotEqual(Local0, arg2)) {
			err(arg0, z054, 23, 0, 0, Local0, arg2)
		}

		Store(SizeOf(arg1), Local0)
		if (LNotEqual(Local0, arg3)) {
			err(arg0, z054, 24, 0, 0, Local0, arg3)
		}
	}

	Method(m001, 1)
	{
		Store(ObjectType(bf00), Local0)
		if (LNotEqual(Local0, 14)) {
			err(arg0, z054, 25, 0, 0, Local0, 14)
		}
		Store(ObjectType(bf01), Local0)
		if (LNotEqual(Local0, 14)) {
			err(arg0, z054, 26, 0, 0, Local0, 14)
		}
		Store(ObjectType(bf02), Local0)
		if (LNotEqual(Local0, 14)) {
			err(arg0, z054, 27, 0, 0, Local0, 14)
		}
		Store(ObjectType(bf03), Local0)
		if (LNotEqual(Local0, 14)) {
			err(arg0, z054, 28, 0, 0, Local0, 14)
		}
		Store(ObjectType(bf04), Local0)
		if (LNotEqual(Local0, 14)) {
			err(arg0, z054, 29, 0, 0, Local0, 14)
		}
		Store(ObjectType(bf05), Local0)
		if (LNotEqual(Local0, 14)) {
			err(arg0, z054, 30, 0, 0, Local0, 14)
		}

		if (F64) {
			m000(arg0, bf00, 1, 8)
			m000(arg0, bf01, 1, 8)
			m000(arg0, bf02, 1, 8)
			m000(arg0, bf03, 1, 8)
			m000(arg0, bf04, 1, 8)
			m000(arg0, bf05, 3, 9)
		} else {
			m000(arg0, bf00, 1, 4)
			m000(arg0, bf01, 1, 4)
			m000(arg0, bf02, 3, 5)
			m000(arg0, bf03, 3, 8)
			m000(arg0, bf04, 3, 8)
			m000(arg0, bf05, 3, 9)
		}
	}

	m001(arg0)
}

// Bug 66: The Field Unit type objects should be passed
// to Methods without any conversion, but instead
// they are converted to Buffers or Integers depending
// on the size of the Buffer Field object and the
// run mode (32-bit or 64/bit mode).
//
// CANCELED: now it should perform opposite assertion because
// this bug was canceled.
Method(m120, 1, Serialized) {
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field(r000, ByteAcc, NoLock, Preserve) {
		f000, 31,
		f001, 32,
		f002, 33,
		f003, 63,
		f004, 64,
		f005, 65
	}

	Method(m000, 4)
	{
		Store(ObjectType(arg1), Local0)
		if (LNotEqual(Local0, arg2)) {
			err(arg0, z054, 31, 0, 0, Local0, arg2)
		}

		Store(SizeOf(arg1), Local0)
		if (LNotEqual(Local0, arg3)) {
			err(arg0, z054, 32, 0, 0, Local0, arg3)
		}
	}

	Method(m001, 1)
	{
		Store(ObjectType(f000), Local0)
		if (LNotEqual(Local0, 5)) {
			err(arg0, z054, 33, 0, 0, Local0, 5)
		}
		Store(ObjectType(f001), Local0)
		if (LNotEqual(Local0, 5)) {
			err(arg0, z054, 34, 0, 0, Local0, 5)
		}
		Store(ObjectType(f002), Local0)
		if (LNotEqual(Local0, 5)) {
			err(arg0, z054, 35, 0, 0, Local0, 5)
		}
		Store(ObjectType(f003), Local0)
		if (LNotEqual(Local0, 5)) {
			err(arg0, z054, 36, 0, 0, Local0, 5)
		}
		Store(ObjectType(f004), Local0)
		if (LNotEqual(Local0, 5)) {
			err(arg0, z054, 37, 0, 0, Local0, 5)
		}
		Store(ObjectType(f005), Local0)
		if (LNotEqual(Local0, 5)) {
			err(arg0, z054, 38, 0, 0, Local0, 5)
		}

		if (F64) {
			m000(arg0, f000, 1, 8)
			m000(arg0, f001, 1, 8)
			m000(arg0, f002, 1, 8)
			m000(arg0, f003, 1, 8)
			m000(arg0, f004, 1, 8)
			m000(arg0, f005, 3, 9)
		} else {
			m000(arg0, f000, 1, 4)
			m000(arg0, f001, 1, 4)
			m000(arg0, f002, 3, 5)
			m000(arg0, f003, 3, 8)
			m000(arg0, f004, 3, 8)
			m000(arg0, f005, 3, 9)
		}
	}

	m001(arg0)
}

// Bug 67: The Buffer Field type objects should be RETURNED
// by Methods without any conversion, but instead
// they are converted to Buffers or Integers depending
// on the size of the Buffer Field object and the
// run mode (32-bit or 64/bit mode).
//
// CANCELED: now it should perform opposite assertion because
// this bug was canceled.
Method(m121, 1, Serialized) {
	Name(b000, Buffer(200) {})
	CreateField(b000, 0,  31, bf00)
	CreateField(b000, 31, 32, bf01)
	CreateField(b000, 63, 33, bf02)

	CreateField(b000, 96,  63, bf03)
	CreateField(b000, 159, 64, bf04)
	CreateField(b000, 223, 65, bf05)

	Method(m000, 1)
	{
		if (LEqual(arg0, 0)) {
			return (bf00)
		} elseif (LEqual(arg0, 1)) {
			return (bf01)
		} elseif (LEqual(arg0, 2)) {
			return (bf02)
		} elseif (LEqual(arg0, 3)) {
			return (bf03)
		} elseif (LEqual(arg0, 4)) {
			return (bf04)
		} elseif (LEqual(arg0, 5)) {
			return (bf05)
		}
		return ("qw")
	}

	Method(m001, 4)
	{
		Store(m000(arg1), Local1)
		Store(ObjectType(Local1), Local0)
		if (LNotEqual(Local0, arg2)) {
			err(arg0, z054, 39, 0, 0, Local0, arg2)
		}

		Store(SizeOf(Local1), Local0)
		if (LNotEqual(Local0, arg3)) {
			err(arg0, z054, 40, 0, 0, Local0, arg3)
		}
	}

	Method(m002, 1)
	{
		if (F64) {
			m001(arg0, 0, 1, 8)
			m001(arg0, 1, 1, 8)
			m001(arg0, 2, 1, 8)
			m001(arg0, 3, 1, 8)
			m001(arg0, 4, 1, 8)
			m001(arg0, 5, 3, 9)
		} else {
			m001(arg0, 0, 1, 4)
			m001(arg0, 1, 1, 4)
			m001(arg0, 2, 3, 5)
			m001(arg0, 3, 3, 8)
			m001(arg0, 4, 3, 8)
			m001(arg0, 5, 3, 9)
		}
	}

	m002(arg0)
}

// Bug 68: The Field Unit type objects should be RETURNED
// by Methods without any conversion, but instead
// they are converted to Buffers or Integers depending
// on the size of the Buffer Field object and the
// run mode (32-bit or 64/bit mode).
//
// CANCELED: now it should perform opposite assertion because
// this bug was canceled.
Method(m122, 1, Serialized) {
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field(r000, ByteAcc, NoLock, Preserve) {
		f000, 31,
		f001, 32,
		f002, 33,
		f003, 63,
		f004, 64,
		f005, 65
	}

	Method(m000, 1)
	{
		if (LEqual(arg0, 0)) {
			return (f000)
		} elseif (LEqual(arg0, 1)) {
			return (f001)
		} elseif (LEqual(arg0, 2)) {
			return (f002)
		} elseif (LEqual(arg0, 3)) {
			return (f003)
		} elseif (LEqual(arg0, 4)) {
			return (f004)
		} elseif (LEqual(arg0, 5)) {
			return (f005)
		}
		return ("qw")
	}

	Method(m001, 4)
	{
		Store(m000(arg1), Local1)
		Store(ObjectType(Local1), Local0)
		if (LNotEqual(Local0, arg2)) {
			err(arg0, z054, 41, 0, 0, Local0, arg2)
		}

		Store(SizeOf(Local1), Local0)
		if (LNotEqual(Local0, arg3)) {
			err(arg0, z054, 42, 0, 0, Local0, arg3)
		}
	}

	Method(m002, 1)
	{
		if (F64) {
			m001(arg0, 0, 1, 8)
			m001(arg0, 1, 1, 8)
			m001(arg0, 2, 1, 8)
			m001(arg0, 3, 1, 8)
			m001(arg0, 4, 1, 8)
			m001(arg0, 5, 3, 9)
		} else {
			m001(arg0, 0, 1, 4)
			m001(arg0, 1, 1, 4)
			m001(arg0, 2, 3, 5)
			m001(arg0, 3, 3, 8)
			m001(arg0, 4, 3, 8)
			m001(arg0, 5, 3, 9)
		}
	}

	m002(arg0)
}

// Bug 30. This test may be removed there after
// the Field relative tests will be implemented.
// Caused crash.
Method(m123, 1)
{
	Method(m000,, Serialized)
	{
		// Field Unit
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field(r000, ByteAcc, NoLock, Preserve) {
			f000, 8,
			f001, 16,
			f002, 32,
			f003, 33,
			f004, 1,
			f005, 64,
		}

		Store("------------ Fields:", Debug)
		Store(f000, Debug)
		Store(f001, Debug)
		Store(f002, Debug)
		Store(f003, Debug)
		Store(f004, Debug)
		Store(f005, Debug)
		Store("------------.", Debug)

		return (0)
	}

	Method(m001,, Serialized)
	{
		// Field Unit
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field(r000, ByteAcc, NoLock, Preserve) {
			f000, 8,
			f001, 16,
			f002, 32,
			f003, 33,
			f004, 7,
			f005, 64,
		}

		Store("------------ Fields:", Debug)
		Store(f000, Debug)
		Store(f001, Debug)
		Store(f002, Debug)
		Store(f003, Debug)
		Store(f004, Debug)
		Store(f005, Debug)
		Store("------------.", Debug)

		return (0)
	}

	m000()
	m001()
	return (0)
}

// Bug 81.
Method(m124, 1)
{
	Method(m000)
	{
		return (0x12345678)
	}

	Method(m001, 1)
	{
		return (0x12345678)
	}

	CH03(arg0, z054, 0x105, 0, 0)

	Store(ObjectType(m000), Local0)
	if (LNotEqual(Local0, c010)) {
		err(arg0, z054, 43, 0, 0, Local0, c010)
	}

	// Bug 81.
	/*
	 * Removed, invalid test.
	 * Compiler disallow method invocation as an operand to ObjectType.
	 */
    /* Nov. 2012: Method invocation as arg to ObjectType is now illegal */

	//Store(ObjectType(m000()), Local0)
	//if (LNotEqual(Local0, c009)) {
	//	err(arg0, z054, 44, 0, 0, Local0, c009)
	//}
	//
	//Store(ObjectType(m001(123)), Local1)
	//if (LNotEqual(Local1, c009)) {
	//	err(arg0, z054, 45, 0, 0, Local1, c009)
	//}
	//
	//CH03(arg0, z054, 0x106, 0, 0)
}

/*
 * Bug 117. Modification of the duplicated String
 * modifies the initial String Object also.
 *
 * This test should be a part of another complex test.
 *
 * New objects creation and safety of the source
 * objects referred as parameters to operators.
 */
Method(m125, 1)
{
	Method(m001, 1, Serialized)
	{
		Name(s000, "String")

		Store(s000, Local0)

		Store(0x61, Index(Local0, 3))

		if (LNotEqual(Local0, "Strang")) {
			err(arg0, z054, 46, 0, 0, Local0, "Strang")
		}
		if (LNotEqual(s000, "String")) {
			err(arg0, z054, 47, 0, 0, s000, "String")
		}
	}

	Method(m002, 1, Serialized)
	{
		Name(b000, Buffer(){0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5})

		Store(b000, Local0)

		Store(0x61, Index(Local0, 3))

		if (LNotEqual(Local0, Buffer(){0xa0, 0xa1, 0xa2, 0x61, 0xa4, 0xa5})) {
			err(arg0, z054, 48, 0, 0, Local0, Buffer(){0xa0, 0xa1, 0xa2, 0x61, 0xa4, 0xa5})
		}
		if (LNotEqual(b000, Buffer(){0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5})) {
			err(arg0, z054, 49, 0, 0, b000, Buffer(){0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5})
		}
	}

	Method(m003, 1, Serialized)
	{
		Name(p000, Package(){0xfff0, 0xfff1, 0xfff2, 0xfff3, 0xfff4, 0xfff5})

		Store(p000, Local0)

		Store(0x61, Index(Local0, 3))

		if (LNotEqual(Derefof(Index(Local0, 0)), 0xfff0)) {
			err(arg0, z054, 50, 0, 0, Derefof(Index(Local0, 0)), 0xfff0)
		}
		if (LNotEqual(Derefof(Index(Local0, 1)), 0xfff1)) {
			err(arg0, z054, 51, 0, 0, Derefof(Index(Local0, 1)), 0xfff1)
		}
		if (LNotEqual(Derefof(Index(Local0, 2)), 0xfff2)) {
			err(arg0, z054, 52, 0, 0, Derefof(Index(Local0, 2)), 0xfff2)
		}
		if (LNotEqual(Derefof(Index(Local0, 3)), 0x61)) {
			err(arg0, z054, 53, 0, 0, Derefof(Index(Local0, 3)), 0x61)
		}
		if (LNotEqual(Derefof(Index(Local0, 4)), 0xfff4)) {
			err(arg0, z054, 54, 0, 0, Derefof(Index(Local0, 4)), 0xfff4)
		}
		if (LNotEqual(Derefof(Index(Local0, 5)), 0xfff5)) {
			err(arg0, z054, 55, 0, 0, Derefof(Index(Local0, 5)), 0xfff5)
		}

		if (LNotEqual(Derefof(Index(p000, 0)), 0xfff0)) {
			err(arg0, z054, 56, 0, 0, Derefof(Index(p000, 0)), 0xfff0)
		}
		if (LNotEqual(Derefof(Index(p000, 1)), 0xfff1)) {
			err(arg0, z054, 57, 0, 0, Derefof(Index(p000, 1)), 0xfff1)
		}
		if (LNotEqual(Derefof(Index(p000, 2)), 0xfff2)) {
			err(arg0, z054, 58, 0, 0, Derefof(Index(p000, 2)), 0xfff2)
		}
		if (LNotEqual(Derefof(Index(p000, 3)), 0xfff3)) {
			err(arg0, z054, 59, 0, 0, Derefof(Index(p000, 3)), 0xfff3)
		}
		if (LNotEqual(Derefof(Index(p000, 4)), 0xfff4)) {
			err(arg0, z054, 60, 0, 0, Derefof(Index(p000, 4)), 0xfff4)
		}
		if (LNotEqual(Derefof(Index(p000, 5)), 0xfff5)) {
			err(arg0, z054, 61, 0, 0, Derefof(Index(p000, 5)), 0xfff5)
		}
	}

	m001(arg0)
	m002(arg0)
	m003(arg0)
}

// No exception should arisen.
Method(mf74, , Serialized)
{
	Store(0, Local0)
	switch (ToInteger (Local0)) {
		case (101) {
			Device(d000) {}
			Method(m002) {}
		}
	}
}

Method(mf75, 1)
{
	Method(mm00, ,Serialized)
	{
		Store(0, Local0)
		switch (ToInteger (Local0)) {
			case (101) {
				Method(m000) {}
				Method(m001) {}
			}
		}
	}

	Method(mm01, ,Serialized)
	{
		Store(0, Local0)
		switch (ToInteger (Local0)) {
			case (101) {
				Method(m002) {}
				Device(dv00) {}
			}
		}
	}

	Method(mm02, ,Serialized)
	{
		Store(0, Local0)
		switch (ToInteger (Local0)) {
			case (101) {
				Device(dv01) {}
				Method(m003) {}
			}
		}
	}

	Method(mm03, ,Serialized)
	{
		Store(0, Local0)
		switch (ToInteger (Local0)) {
			case (101) {
				Device(dv02) {}
				Device(dv03) {}
			}
		}
	}

	CH03(arg0, z054, 0x107, 0, 0)
	mf74()
	CH03(arg0, z054, 0x108, 0, 0)

	CH03(arg0, z054, 0x109, 0, 0)
	mm00()
	CH03(arg0, z054, 0x10a, 0, 0)

	CH03(arg0, z054, 0x10b, 0, 0)
	mm01()
	CH03(arg0, z054, 0x10c, 0, 0)

	CH03(arg0, z054, 0x10d, 0, 0)
	mm02()
	CH03(arg0, z054, 0x10e, 0, 0)

	CH03(arg0, z054, 0x10f, 0, 0)
	mm03()
	CH03(arg0, z054, 0x110, 0, 0)
}


/*
 * Bug 153, Bugzilla 5314.
 * The corresponding bug has been fixed.
 * This is an invalid test, should be removed from test suite.
 * Method mf77 will fail on ABBU unexpectedly even without Method mf76.
 *
 * Method(mf76, 1)
 * {
 *	if (LNotEqual(arg0, "Strang")) {
 *		err(arg0, z054, 72, 0, 0, arg0, "Strang")
 *	}
 * }
 *
 * Method(mf77, 1)
 * {
 *	Name(s000, "String")
 *	Name(p000, Package(){0})
 *
 *	Store(s000, p000)
 *
 *	Store(s000, Debug)
 *	Store(p000, Debug)
 *
 *	Store (0x61, Index(p000, 3))
 *
 *	mf76(p000)
 *	if (LNotEqual(s000, "String")) {
 *		err(arg0, z054, 73, 0, 0, s000, "String")
 *	}
 * }
 */

/* Bug 196 */
Method(mf86, 1)
{
	CH03("mf86", z054, 74, 0, 0)

	ToInteger("0x0x12345678", Local0)
	if (LNotEqual(Local0, 0)) {
		err(arg0, z054, 75, 0, 0, Local0, 0)
	}

	CH04("mf86", 0, 0xff, z054, 2, 0, 0)
}

Method(mf87, 1)
{
	CH03("mf87", z054, 0, 0, 0)

	Add("0x0xabcdef", 0x10234, Local0)
	if (LNotEqual(Local0, 0x10234)) {
		err(arg0, z054, 77, 0, 0, Local0, 0x10234)
	}

	CH03("mf87", z054, 1, 0, 0)

	Add(0x10234, "0x0xabcdef", Local0)
	if (LNotEqual(Local0, 0x10234)) {
		err(arg0, z054, 78, 0, 0, Local0, 0x10234)
	}

	CH03("mf87", z054, 2, 0, 0)
}

Method(m15b,, Serialized)
{
	Name(ts, "m15b")

	/* **************** Definitions **************** */

	Method(mm00)
	{
		return (0xabcd0000)
	}

	Name(p000, Package() {0xabcd0001, mm00, 0xabcd0002})

	/* **************** Run checkings **************** */

	/* Store */

	Method(m000)
	{
		Store(mm00, Local0)
		if (LNotEqual(Local0, 0xabcd0000)) {
			err(ts, z054, 0x000, 0, 0, Local0, 0xabcd0000)
		}
	}

	Method(m001)
	{
		CH03(ts, z054, 0x001, 0, 0)
		Store(DerefOf(RefOf(mm00)), Local0)
		if (SLCK) {
			CH03(ts, z054, 0x002, 0, 0)
			Store(ObjectType(Local0), Local1)
			if (LNotEqual(Local1, c010)) {
				err(ts, z054, 0x003, 0, 0, Local1, c010)
			}
		} else {
			CH04(ts, 0, 47, z054, 0x004, 0, 0) // AE_AML_OPERAND_TYPE
		}
	}

	Method(m002)
	{
		CH03(ts, z054, 0x005, 0, 0)
		Store(DerefOf(Index(p000, 1)), Local0)
		if (SLCK) {
			CH03(ts, z054, 0x006, 0, 0)
			Store(ObjectType(Local0), Local1)
			if (LNotEqual(Local1, c010)) {
				err(ts, z054, 0x007, 0, 0, Local1, c010)
			}
		} else {
			CH04(ts, 0, 47, z054, 0x008, 0, 0) // AE_AML_OPERAND_TYPE
		}
	}

	Method(m003)
	{
		CH03(ts, z054, 0x009, 0, 0)
		Store(DerefOf("mm00"), Local0)
		if (SLCK) {
			CH03(ts, z054, 0x00a, 0, 0)
			Store(ObjectType(Local0), Local1)
			if (LNotEqual(Local1, c010)) {
				err(ts, z054, 0x00b, 0, 0, Local1, c010)
			}
		} else {
			CH04(ts, 0, 47, z054, 0x00c, 0, 0) // AE_AML_OPERAND_TYPE
		}
	}

	/* CopyObject */

	Method(m004)
	{
		CopyObject(mm00, Local0)
		if (LNotEqual(Local0, 0xabcd0000)) {
			err(ts, z054, 0x00d, 0, 0, Local0, 0xabcd0000)
		}
	}

	Method(m005)
	{
		CH03(ts, z054, 0x00e, 0, 0)
		CopyObject(DerefOf(RefOf(mm00)), Local0)
		CH03(ts, z054, 0x00f, 0, 0)

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c010)) {
			err(ts, z054, 0x010, 0, 0, Local1, c010)
		}
	}

	Method(m006)
	{
		CH03(ts, z054, 0x011, 0, 0)
		CopyObject(DerefOf(Index(p000, 1)), Local0)
		CH03(ts, z054, 0x012, 0, 0)

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c010)) {
			err(ts, z054, 0x013, 0, 0, Local1, c010)
		}
	}

	Method(m007)
	{
		CH03(ts, z054, 0x014, 0, 0)
		CopyObject(DerefOf("mm00"), Local0)
		CH03(ts, z054, 0x015, 0, 0)

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c010)) {
			err(ts, z054, 0x016, 0, 0, Local1, c010)
		}
	}

	/* Add */

	Method(m008)
	{
		Add(mm00, 1, Local0)
		if (LNotEqual(Local0, 0xabcd0001)) {
			err(ts, z054, 0x017, 0, 0, Local0, 0xabcd0001)
		}
	}

	Method(m009)
	{
		CH03(ts, z054, 0x018, 0, 0)
		Add(DerefOf(RefOf(mm00)), 2, Local0)
		CH04(ts, 0, 47, z054, 0x019, 0, 0) // AE_AML_OPERAND_TYPE
	}

	Method(m00a)
	{
		CH03(ts, z054, 0x01a, 0, 0)
		Add(DerefOf(Index(p000, 1)), 3, Local0)
		CH04(ts, 0, 47, z054, 0x01b, 0, 0) // AE_AML_OPERAND_TYPE
	}

	Method(m00b)
	{
		CH03(ts, z054, 0x01c, 0, 0)
		Add(DerefOf("mm00"), 4, Local0)
		CH04(ts, 0, 47, z054, 0x01d, 0, 0) // AE_AML_OPERAND_TYPE
	}

	/* ObjectType */

	Method(m00c)
	{
		Store(ObjectType(mm00), Local0)
		if (LNotEqual(Local0, c010)) {
			err(ts, z054, 0x01e, 0, 0, Local0, c010)
		}
	}

	Method(m00d)
	{
		Store(ObjectType(DerefOf(RefOf(mm00))), Local0)
		if (LNotEqual(Local0, c010)) {
			err(ts, z054, 0x01f, 0, 0, Local0, c010)
		}
	}

	Method(m00e)
	{
		Store(ObjectType(DerefOf(Index(p000, 1))), Local0)
		if (LNotEqual(Local0, c010)) {
			err(ts, z054, 0x020, 0, 0, Local0, c010)
		}
	}

	Method(m00f)
	{
		Store(ObjectType(DerefOf("mm00")), Local0)
		if (LNotEqual(Local0, c010)) {
			err(ts, z054, 0x021, 0, 0, Local0, c010)
		}
	}

	Method(m100)
	{
		SRMT("m15b-0")
		m000()
		SRMT("m15b-1")
		m001()
		SRMT("m15b-2")
		m002()
		SRMT("m15b-3")
		m003()
		SRMT("m15b-4")
		m004()
		SRMT("m15b-5")
		m005()
		SRMT("m15b-6")
		m006()
		SRMT("m15b-7")
		m007()
		SRMT("m15b-8")
		m008()
		SRMT("m15b-9")
		m009()
		SRMT("m15b-a")
		m00a()
		SRMT("m15b-b")
		m00b()
		SRMT("m15b-c")
		m00c()
		SRMT("m15b-d")
		m00d()
		SRMT("m15b-e")
		m00e()
		SRMT("m15b-f")
		m00f()
	}

	m100()
}

// Run-method
Method(MSC0,, Serialized)
{
	Name(ts, "MSC0")

	SRMT("m110")
	m110(ts)
	SRMT("m112")
	m112(ts)
	SRMT("m113")
	m113(ts)
	SRMT("m114")
	m114(ts)
	SRMT("m115")
	m115(ts)
	SRMT("m116")
	m116(ts)
	SRMT("m118")
	m118(ts)
	SRMT("m119")
	m119(ts)
	SRMT("m11c")
	m11c(ts)
	SRMT("m11d")
	m11d(ts)
	SRMT("m11e")
	m11e(ts)
	SRMT("m11f")
	m11f(ts)
	SRMT("m120")
	m120(ts)
	SRMT("m121")
	m121(ts)
	SRMT("m122")
	m122(ts)
	SRMT("m123")
	m123(ts)
	SRMT("m124")
	m124(ts)
	SRMT("m125")
	m125(ts)
	SRMT("mf75")
	mf75(ts)
	//SRMT("mf77")
	//mf77(ts)
	SRMT("mf86")
	mf86(ts)
	SRMT("mf87")
	mf87(ts)

	m15b()
}

