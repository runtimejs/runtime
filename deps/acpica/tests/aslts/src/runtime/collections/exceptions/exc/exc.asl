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
 * Initiate exceptional conditions by all the known ways.
 * Verify the reaction.
 *
 * Current max index of checking is 170
 */

Name(z058, 58)

// Divide by zero
Method(m140,, Serialized)
{
	Name(ts, "m140")

	CH03(ts, z058, 0, 0, 0)

	Store(1, Local1)
	Store(2, Local0)
	Divide(Local1, Local0, Local2)

	CH03(ts, z058, 1, 0, 0)

	Store(0, Local0)
	Divide(Local1, Local0, Local2)

	CH04(ts, 0, 56, z058, 2, 0, 0)	// AE_AML_DIVIDE_BY_ZERO

	Store(2, Local0)
	Divide(Local1, Local0, Local2)

	CH03(ts, z058, 3, 0, 0)
}

// Modulo divide by zero
Method(m141,, Serialized)
{
	Name(ts, "m141")

	CH03(ts, z058, 4, 0, 0)

	Store(1, Local1)
	Store(2, Local0)
	Mod(Local1, Local0, Local2)

	CH03(ts, z058, 5, 0, 0)

	Store(0, Local0)
	Mod(Local1, Local0, Local2)

	CH04(ts, 0, 56, z058, 6, 0, 0)	// AE_AML_DIVIDE_BY_ZERO

	Store(2, Local0)
	Mod(Local1, Local0, Local2)

	CH03(ts, z058, 7, 0, 0)
}

// Release ownership on a Mutex that is not currently owned
Method(m142,, Serialized)
{
	Name(ts, "m142")

	Mutex(MTX0, 0)

	CH03(ts, z058, 8, 0, 0)

	Release(MTX0)

	CH04(ts, 0, 65, z058, 9, 0, 0)	// AE_AML_MUTEX_NOT_ACQUIRED
}

// SizeOf for data types not an Integer, Buffer, String or Package object
Method(m143,, Serialized)
{
	Name(ts, "m143")

	// Method
	// DDB Handle
	// Debug Object
	// Uninitialized


	// Integer
	Name(INT0, 0)

	// String
	Name(STR0, "string")

	// Buffer
	Name(BUF0, Buffer(10) {0x00})

	// Package
	Name(PAC0, Package(1) {0})

	// Device
	Device(DEV0) {}

	// Event
	Event(EVE0)

	// Mutex
	Mutex(MTX0, 0)

	// Operation Region
	OperationRegion(OPR0, SystemMemory, 0, 4)

	// Power Resource
	PowerResource(PWR0, 0, 0) {}

	// Processor
	Processor(CPU0, 0x0, 0xFFFFFFFF, 0x0) {}

	// Thermal Zone
	ThermalZone(TZN0) {}

	// Buffer Field
	Index(BUF0, 0, Local0)

	CH03(ts, z058, 10, 0, 0)

	Store(SizeOf(STR0), Local5)
	Store(SizeOf(BUF0), Local5)
	Store(SizeOf(PAC0), Local5)
	Store(SizeOf(INT0), Local5)

	CH03(ts, z058, 11, 0, 0)

	if (INT0) {
		Store(0, Local1)
	}
	Store(SizeOf(Local1), Local5)
	CH04(ts, 1, 49, z058, 12, 0, 0)	// AE_AML_UNINITIALIZED_LOCAL

	Store(SizeOf(DEV0), Local5)
	CH04(ts, 1, 47, z058, 13, 0, 0)	// AE_AML_OPERAND_TYPE

	Store(SizeOf(EVE0), Local5)
	CH04(ts, 1, 47, z058, 14, 0, 0)	// AE_AML_OPERAND_TYPE

	Store(SizeOf(MTX0), Local5)
	CH04(ts, 1, 47, z058, 15, 0, 0)	// AE_AML_OPERAND_TYPE

	Store(SizeOf(OPR0), Local5)
	CH04(ts, 1, 47, z058, 16, 0, 0)	// AE_AML_OPERAND_TYPE

	Store(SizeOf(PWR0), Local5)
	CH04(ts, 1, 47, z058, 17, 0, 0)	// AE_AML_OPERAND_TYPE

	Store(SizeOf(CPU0), Local5)
	CH04(ts, 1, 47, z058, 18, 0, 0)	// AE_AML_OPERAND_TYPE

	Store(SizeOf(TZN0), Local5)
	CH04(ts, 1, 47, z058, 19, 0, 0)	// AE_AML_OPERAND_TYPE
}

// ToString() when the number of characters copied from buffer exceeds 200
Method(m144,, Serialized)
{
	Name(ts, "m144")

	Name(b000, Buffer(200){})

	Store(0, Local0)
	While (LLess(Local0, 200)) {
		Store(0xff, Index(b000, Local0))
		Increment(Local0)
	}

	CH03(ts, z058, 20, 0, 0)

	ToString(b000, Ones, Local5)

	CH03(ts, z058, 21, 0, 0)

	Name(b001, Buffer(201){})

	Store(0, Local0)
	While (LLess(Local0, 201)) {
		Store(0xff, Index(b001, Local0))
		Increment(Local0)
	}

	ToString(b001, Ones, Local5)

	/*
	 * CH04(ts, 0, 61, z058, 22, 0, 0)	// AE_AML_STRING_LIMIT
	 *
	 * 20.12.2005.
	 * No more limit of string size.
	 */
	CH03(ts, z058, 22, 0, 0)
}

// Access out of Package
Method(m145,, Serialized)
{
	Name(ts, "m145")

	Name(p000, Package() {0,1,2})
	Name(p001, Package(3) {0,1,2})

	CH03(ts, z058, 23, 0, 0)

	// Package()

	Store(Index(p000, 2), Local5)

	CH03(ts, z058, 24, 0, 0)

	Store(Index(p000, 3), Local5)

	CH04(ts, 1, 55, z058, 25, 0, 0)	// AE_AML_PACKAGE_LIMIT

	Index(p000, 2, Local0)

	CH03(ts, z058, 26, 0, 0)

	Index(p000, 3, Local0)

	CH04(ts, 0, 55, z058, 27, 0, 0)	// AE_AML_PACKAGE_LIMIT

	// Package(3)

	Store(Index(p001, 2), Local5)

	CH03(ts, z058, 28, 0, 0)

	Index(p001, 3, Local5)

	CH04(ts, 0, 55, z058, 29, 0, 0)	// AE_AML_PACKAGE_LIMIT

	Index(p001, 2, Local0)

	CH03(ts, z058, 30, 0, 0)

	Index(p001, 3, Local0)

	CH04(ts, 0, 55, z058, 31, 0, 0)	// AE_AML_PACKAGE_LIMIT
}

// Access out of String
Method(m085,, Serialized)
{
	Name(ts, "m085")

	Name(s000, "123")

	CH03(ts, z058, 32, 0, 0)

	Index(s000, 2, Local5)

	CH03(ts, z058, 33, 0, 0)

	Index(s000, 3, Local5)

	// Bug 177, Bugzilla 5480.
	CH04(ts, 0, 61, z058, 34, 0, 0)	// AE_AML_STRING_LIMIT

	Index(s000, 2, Local0)

	CH03(ts, z058, 35, 0, 0)

	Index(s000, 3, Local0)

	CH04(ts, 0, 61, z058, 36, 0, 0)	// AE_AML_STRING_LIMIT
}

// Access out of Buffer
Method(m086,, Serialized)
{
	Name(ts, "m086")

	Name(b000, Buffer() {0,1,2})
	Name(b001, Buffer(3) {0,1,2})

	CH03(ts, z058, 37, 0, 0)

	// Buffer()

	Index(b000, 2, Local5)

	CH03(ts, z058, 38, 0, 0)

	Index(b000, 3, Local5)

	CH04(ts, 0, 54, z058, 39, 0, 0)	// AE_AML_BUFFER_LIMIT

	Index(b000, 2, Local0)

	CH03(ts, z058, 40, 0, 0)

	Index(b000, 3, Local0)

	CH04(ts, 0, 54, z058, 41, 0, 0)	// AE_AML_BUFFER_LIMIT

	// Buffer(3)

	Index(b001, 2, Local5)

	CH03(ts, z058, 42, 0, 0)

	Index(b001, 3, Local5)

	CH04(ts, 0, 54, z058, 43, 0, 0)	// AE_AML_BUFFER_LIMIT

	Index(b001, 2, Local0)

	CH03(ts, z058, 44, 0, 0)

	Index(b001, 3, Local0)

	CH04(ts, 0, 54, z058, 45, 0, 0)	// AE_AML_BUFFER_LIMIT
}

// ToInteger() passed with an image of a number which value
// exceeds the maximum of an integer for the current mode.
Method(m146,, Serialized)
{
	Name(ts, "m146")

	CH03(ts, z058, 46, 0, 0)

	if (LEqual(F64, 1)) {
		Store("0xffffffffffffffff", Local0)
	} else {
		Store("0xffffffff", Local0)
	}
	ToInteger(Local0, Local5)

	CH03(ts, z058, 47, 0, 0)

	if (LEqual(F64, 1)) {
		Store("0x11111111111111111", Local0)
	} else {
		Store("0x111111111", Local0)
	}
	ToInteger(Local0, Local5)

	CH04(ts, 0, 46, z058, 48, 0, 0)	// AE_AML_NO_OPERAND
}

// [Uninitialized] None.
// Causes a fatal error when used as a source
// operand in any ASL statement.
Method(m147, 1, Serialized)
{
	Name(ts, "m147")

	if (Arg0) {
		Store(0, Local0)
	}

	CH03(ts, z058, 49, 0, 0)

	Increment(Local0)

	CH04(ts, 0, 49, z058, 50, 0, 0)	// AE_AML_UNINITIALIZED_LOCAL
}

Method(m148)
{
	m147(0)
}

// Stall, Time parameter is too large (> 100)

Method(m149, 1, Serialized)
{
	Name(ts, "m149")

	CH03(ts, z058, 51, 0, 0)

	Stall(Arg0)

	CH03(ts, z058, 52, 0, 0)
}

Method(m14a, 1, Serialized)
{
	Name(ts, "m14a")

	CH03(ts, z058, 53, 0, 0)

	Stall(Arg0)

	// It is now bug 14.
	CH04(ts, 0, 48, z058, 54, 0, 0)	// AE_AML_OPERAND_VALUE
}

// Bug 14.
Method(m14b)
{
	m149(100)
	/*
	 * We are forced by Windows and BIOS code to increase the maximum stall
	 * time to 255, this is in violation of the ACPI specification.
	 * ACPI specification requires that Stall() does not relinquish the
	 * processor, and delays longer than 100 usec should use Sleep()
	 * instead. We allow stall up to 255 usec for compatibility with other
	 * interpreters and existing BIOS.
	 *
	 * So we remove this test from test suite.
	 *
	 * m14a(101)
	 */
}

// Concatenate() when the number of result characters in string exceeds 200
Method(m14c,, Serialized)
{
	Name(ts, "m14c")

	// 100 characters
	Store("0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789", Local0)

	// 101 characters
	Store("01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890", Local1)

	CH03(ts, z058, 55, 0, 0)

	Concatenate(Local0, Local0, Local5)

	CH03(ts, z058, 56, 0, 0)

	Concatenate(Local0, Local1, Local5)

	/*
	 * CH04(ts, 0, 61, z058, 57, 0, 0)	// AE_AML_STRING_LIMIT
	 *
	 * 20.12.2005.
	 * No more limit of string size.
	 */

	CH03(ts, z058, 57, 0, 0)
}

// ToDecimalString() when the number of result characters in string exceeds 200
Method(m14d,, Serialized)
{
	Name(ts, "m14d")

	// Results into 200 (99 * 2 + 2) characters
	Name(b000, Buffer() {
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 11})

	// Results into 201 (100 * 2 + 1) characters
	Name(b001, Buffer() {
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1})

	CH03(ts, z058, 58, 0, 0)

	ToDecimalString(b000, Local5)

	CH03(ts, z058, 59, 0, 0)

	ToDecimalString(b001, Local5)

	/*
	 * CH04(ts, 0, 61, z058, 60, 0, 0)	// AE_AML_STRING_LIMIT
	 *
	 * 20.12.2005.
	 * No more limit of string size.
	 */

	CH03(ts, z058, 60, 0, 0)
}

// ToBCD() when a specified integer overflows a number of the BCD format
Method(m14e,, Serialized)
{
	Name(ts, "m14e")

	CH03(ts, z058, 61, 0, 0)

	if (LEqual(F64, 1)) {
		ToBCD(9999999999999999, Local5)
	} else {
		ToBCD(99999999, Local5)
	}

	CH03(ts, z058, 62, 0, 0)

	if (LEqual(F64, 1)) {
		ToBCD(10000000000000000, Local5)
	} else {
		ToBCD(100000000, Local5)
	}

	CH04(ts, 0, 52, z058, 63, 0, 0)	// AE_AML_NUMERIC_OVERFLOW
}

// Create field out of buffer
Method(m14f,, Serialized)
{
	Name(ts, "m14f")

	Name(b001, Buffer(16) {})

	CH03(ts, z058, 64, 0, 0)
	CreateBitField(b001, 127, f000)
	CH03(ts, z058, 65, 0, 0)
	CreateBitField(b001, 128, f001)
	CH04(ts, 0, 54, z058, 66, 0, 0)	// AE_AML_BUFFER_LIMIT

	CH03(ts, z058, 67, 0, 0)
	CreateByteField(b001, 15, f002)
	CH03(ts, z058, 68, 0, 0)
	CreateByteField(b001, 16, f003)
	CH04(ts, 0, 54, z058, 69, 0, 0)	// AE_AML_BUFFER_LIMIT

	CH03(ts, z058, 70, 0, 0)
	CreateWordField(b001, 14, f004)
	CH03(ts, z058, 71, 0, 0)
	CreateWordField(b001, 15, f005)
	CH04(ts, 0, 54, z058, 72, 0, 0)	// AE_AML_BUFFER_LIMIT

	CH03(ts, z058, 73, 0, 0)
	CreateDWordField(b001, 12, f006)
	CH03(ts, z058, 74, 0, 0)
	CreateDWordField(b001, 13, f007)
	CH04(ts, 0, 54, z058, 75, 0, 0)	// AE_AML_BUFFER_LIMIT

	CH03(ts, z058, 76, 0, 0)
	CreateQWordField(b001, 8, f008)
	CH03(ts, z058, 77, 0, 0)
	CreateQWordField(b001, 9, f009)
	CH04(ts, 0, 54, z058, 78, 0, 0)	// AE_AML_BUFFER_LIMIT

	CH03(ts, z058, 79, 0, 0)
	CreateField(b001, 127, 1, f00a)
	CH03(ts, z058, 80, 0, 0)
	CreateField(b001, 128, 1, f00b)
	CH04(ts, 0, 54, z058, 81, 0, 0)	// AE_AML_BUFFER_LIMIT

	CH03(ts, z058, 82, 0, 0)
	CreateField(b001, 120, 8, f00c)
	CH03(ts, z058, 83, 0, 0)
	CreateField(b001, 120, 9, f00d)
	CH04(ts, 0, 54, z058, 84, 0, 0)	// AE_AML_BUFFER_LIMIT
}

// Access to uninitialized local
Method(m150, 1, Serialized)
{
	Name(ts, "m150")

	if (arg0) {
		Store(0, Local0)
	}

	CH03(ts, z058, 85, 0, 0)

	Index(Local0, 0, Local5)

	CH04(ts, 0, 49, z058, 86, 0, 0)	// AE_AML_UNINITIALIZED_LOCAL
}

// Access to an uninitialized element of package
Method(m151,, Serialized)
{
	Name(ts, "m151")

	Name(p000, Package(4) {0,1,2})

	CH03(ts, z058, 87, 0, 0)

	Store(DeRefOf(Index(p000, 2)), Local5)

	CH03(ts, z058, 88, 0, 0)

	Store(DeRefOf(Index(p000, 3)), Local5)

	/*
	 * Obsolete:
	 * CH04(ts, 0, 51, z058, 89, 0, 0)	// AE_AML_UNINITIALIZED_ELEMENT
	 *
	 * Updated according to Bug 85 fix: no exception is expected
	 * since the value is not processed.
	 */
	/*
	 * OBSOLETE July 2013. DerefOf on an empty package element now causes error
	 * CH04(ts, 0, 62, z058, 89, 0, 0)
	 */
	CH04(ts, 1, 51, z058, 89, 0, 0)	// AE_AML_UNINITIALIZED_ELEMENT

	Add(DeRefOf(Index(p000, 3)), 1, Local5)

	if (EXCV) {
		CH04(ts, 0, 51, z058, 169, 0, 0)	// AE_AML_UNINITIALIZED_ELEMENT
	} else {
		CH04(ts, 0, 0xff, z058, 169, 0, 0)
	}

	return (0)
}

// ToHexString() when the number of result characters in string exceeds 200
Method(m152,, Serialized)
{
	Name(ts, "m152")

	// Results into 200 (67 * 3 - 1) characters
	Name(b000, Buffer() {
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1})

	// Results into 203 (68 * 3 - 1) characters
	Name(b001, Buffer() {
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 1})

	CH03(ts, z058, 90, 0, 0)

	ToHexString(b000, Local5)

	CH03(ts, z058, 91, 0, 0)

	ToHexString(b001, Local5)

	/*
	 * CH04(ts, 0, 61, z058, 92, 0, 0)	// AE_AML_STRING_LIMIT
	 *
	 * 20.12.2005.
	 * No more limit of string size.
	 */

	CH03(ts, z058, 92, 0, 0)
}

// StartIndex in Match greater than the package size
Method(m153,, Serialized)
{
	Name(ts, "m153")

	Name(PAC0, Package(1) {0})

	CH03(ts, z058, 93, 0, 0)

	Store(Match(PAC0, MTR, 0, MTR, 0, 0), Local5)

	CH03(ts, z058, 94, 0, 0)

	Store(Match(PAC0, MTR, 0, MTR, 0, 1), Local5)

	CH04(ts, 1, 55, z058, 95, 0, 0)	// AE_AML_PACKAGE_LIMIT
}

// Exeptional conditions of ConcatenateResTemplate
Method(m154,, Serialized)
{
	Name(ts, "m154")

	Name(RT00, ResourceTemplate () {
		IRQNoFlags () {1}})

	// Empty buffer

	Store(0, Local0)
	Store(Buffer(Local0){}, Local2)

	CH03(ts, z058, 96, 0, 0)

	ConcatenateResTemplate(RT00, RT00, Local5)

	CH03(ts, z058, 97, 0, 0)

	ConcatenateResTemplate(RT00, Local2, Local5)

	// Bug 188.
	CH03(ts, z058, 98, 0, 0)
	// CH04(ts, 0, 71, z058, 98, 0, 0)	// AE_AML_NO_RESOURCE_END_TAG

	// One-element buffer

	Store(Buffer(){0}, Local2)

	ConcatenateResTemplate(RT00, Local2, Local5)

	/*
	 * Note: As for there is not a separate type for ResourceTemplate,
	 * ResourceTemplate is in fact a buffer but interpreted as
	 * ResourceTemplate. If the buffer has no complete END_TAG descriptor,
	 * we get AE_AML_NO_RESOURCE_END_TAG instead of AE_AML_OPERAND_TYPE.
	 */
	if (EXCV) {
		CH04(ts, 0, 71, z058, 100, 0, 0) // AE_AML_NO_RESOURCE_END_TAG
	} else {
		CH04(ts, 0, 0xff, z058, 100, 0, 0)
	}

	// One-element 0x79 buffer

	Store(Buffer(){0x79}, Local2)

	ConcatenateResTemplate(RT00, Local2, Local5)

	// Bug 189.
	CH04(ts, 0, 71, z058, 101, 0, 0)	// AE_AML_NO_RESOURCE_END_TAG

	// Not resource template buffer

	Store(Buffer(){0x2a, 0x04, 0x02}, Local2)

	ConcatenateResTemplate(RT00, Local2, Local5)

	if (EXCV) {
		CH04(ts, 0, 71, z058, 102, 0, 0) // AE_AML_NO_RESOURCE_END_TAG
	} else {
		CH04(ts, 0, 0xff, z058, 102, 0, 0)
	}

	// Nearly resource template buffer

	Store(Buffer(){0x2a, 0x10, 0x05, 0x79}, Local2)

	ConcatenateResTemplate(RT00, Local2, Local5)

	// Bug 190.
	CH04(ts, 0, 71, z058, 103, 0, 0)	// AE_AML_NO_RESOURCE_END_TAG

	// Like resource template buffer

	Store(Buffer(){0x00, 0x00, 0x00, 0x79, 0x00}, Local2)

	ConcatenateResTemplate(RT00, Local2, Local5)

	if (EXCV) {
		CH04(ts, 0, 71, z058, 104, 0, 0) // AE_AML_NO_RESOURCE_END_TAG
	} else {
		CH04(ts, 0, 0xff, z058, 104, 0, 0)
	}

	CH03(ts, z058, 171, 0, 0)
}

/*
 * Obsolete:
 * Bug 63: The following operation should initiate
 * AE_BAD_HEX_CONSTANT exception
 *
 *
 * Bug 63, Bugzilla 5329.
 *
 * Updated specs 12.03.05:
 * "Note: the first non-hex character terminates the conversion
 * without error, and a '0x' prefix is not allowed."
 */
Method(m155,, Serialized)
{
	Name(ts, "m155")

	CH03(ts, z058, 105, 0, 0)

	Add("0x1111", 0, Local0)

	/*
	 * Obsolete:
	 * CH04(ts, 0, 34, z058, 106, 0, 0)	// AE_BAD_HEX_CONSTANT
	 *
	 * New:
	 */
	CH03(ts, z058, 106, 0, 0)
	if (LNotEqual(Local0, 0)) {
		// Bug 63, Bugzilla 5329.
		err(ts, z058, 170, 0, 0, Local0, 0)
	}
}

/*
 * Bug 64: The following operations should initiate exceptions.
 * AE_BAD_HEX_CONSTANT is the most appropreate, but it was decided
 * to weaken demands - it is enough that some exception arises
 * even if it is not the most appropreate one.
 * See 111,112,113.
 */
Method(m156,, Serialized)
{
	Name(ts, "m156")

	Store(0, Local0)
	Name(b000, Buffer(Local0) {})

	CH03(ts, z058, 107, 0, 0)

	// Add, empty String
	Add("", 0, Local5)

//	CH04(ts, 0, 34, z058, 108, 0, 0)	// AE_BAD_HEX_CONSTANT
	CH03(ts, z058, 108, 0, 0)

	// Add, String filled with blanks
	Add("                 ", 0, Local5)

//	CH04(ts, 0, 34, z058, 109, 0, 0)	// AE_BAD_HEX_CONSTANT
	CH03(ts, z058, 109, 0, 0)

	// ToInteger, empty String
	ToInteger("", Local5)

	CH04(ts, 0, 36, z058, 110, 0, 0)	// AE_BAD_DECIMAL_CONSTANT

	// ToInteger, String filled with blanks
	ToInteger("                 ", Local5)

//	CH04(ts, 0, 34, z058, 111, 0, 0)	// AE_BAD_HEX_CONSTANT
	CH04(ts, 0, 36, z058, 111, 0, 0)	// AE_BAD_DECIMAL_CONSTANT

	// Add, zero-length Buffer
	Add(b000, 0, Local5)

//	CH04(ts, 0, 34, z058, 112, 0, 0)	// AE_BAD_HEX_CONSTANT
	CH04(ts, 0, 54, z058, 112, 0, 0)	// AE_AML_BUFFER_LIMIT

	// ToInteger, zero-length Buffer
	ToInteger(b000, Local5)

//	CH04(ts, 0, 34, z058, 113, 0, 0)	// AE_BAD_HEX_CONSTANT
	CH04(ts, 0, 54, z058, 113, 0, 0)	// AE_AML_BUFFER_LIMIT
}

// //////////////////////////////////////////////////////////
//
// Attempt to generate references upon an arbitrary addresses
//
// //////////////////////////////////////////////////////////

// Index(Integer)
Method(m157,, Serialized)
{
	Name(ts, "m157")

	Name(i000, 0xaaaaaaaa)

	CH03(ts, z058, 114, 0, 0)

	Store(Index(i000, 0), Local5)

	CH04(ts, 1, 47, z058, 115, 0, 0)	// AE_AML_OPERAND_TYPE

	Index(i000, 0, Local0)

	CH04(ts, 0, 47, z058, 116, 0, 0)	// AE_AML_OPERAND_TYPE

	Store(Index(i000, 0), Local0)

	CH04(ts, 0, 0xff, z058, 117, 0, 0)

	Store(Index(i000, 0, Local0), Local1)

	CH04(ts, 0, 0xff, z058, 118, 0, 0)
}

// Bug 83
// DerefOf(Integer)
Method(m158,, Serialized)
{
	Name(ts, "m158")

	Name(i000, 0xaaaaaaaa)

	CH03(ts, z058, 119, 0, 0)

	// Bug 83, Bugzilla 5387.
	Store(DerefOf(i000), Local5)

	CH04(ts, 0, 0xff, z058, 120, 0, 0)

	Store(DerefOf(i000), Local0)

	// Bug 83, Bugzilla 5387.
	CH04(ts, 0, 0xff, z058, 121, 0, 0)
}

// Index(Local7-Integer)
// DerefOf(Integer)
Method(m087,, Serialized)
{
	Name(ts, "m087")

	Name(i000, 0xaaaaaaaa)

	Store(i000, Local7)

	CH03(ts, z058, 122, 0, 0)

	// Index(Integer)

	Store(Index(Local7, 0), Local5)

	CH04(ts, 1, 47, z058, 123, 0, 0)	// AE_AML_OPERAND_TYPE

	Index(Local7, 0, Local0)

	CH04(ts, 0, 47, z058, 124, 0, 0)	// AE_AML_OPERAND_TYPE

	Store(Index(Local7, 0), Local0)

	CH04(ts, 0, 0xff, z058, 125, 0, 0)

	Store(Index(Local7, 0, Local0), Local1)

	CH04(ts, 0, 0xff, z058, 126, 0, 0)

	// DerefOf(Integer)

	Store(DerefOf(Local7), Local5)

	CH04(ts, 0, 0xff, z058, 127, 0, 0)

	Store(DerefOf(Local7), Local0)

	CH04(ts, 0, 0xff, z058, 128, 0, 0)
}

// Index(Buffer Field)
Method(m159,, Serialized)
{
	Name(ts, "m159")

	Name(b000, Buffer() {1,2,3,4,5,6,7,8,9})
	CreateField(b000, 0, 8, bf00)

	CH03(ts, z058, 129, 0, 0)

	Store(Index(bf00, 0), Local5)

	CH04(ts, 1, 47, z058, 130, 0, 0)	// AE_AML_OPERAND_TYPE

	Index(bf00, 0, Local0)

	CH04(ts, 0, 47, z058, 131, 0, 0)	// AE_AML_OPERAND_TYPE

	Store(Index(bf00, 0), Local0)

	CH04(ts, 0, 0xff, z058, 132, 0, 0)

	Store(Index(bf00, 0), Local0)

	CH04(ts, 0, 0xff, z058, 133, 0, 0)

	Store(Index(bf00, 0, Local0), Local1)

	CH04(ts, 0, 0xff, z058, 134, 0, 0)
}

// Bug 83
// DerefOf(Buffer Field)
Method(m15a,, Serialized)
{
	Name(ts, "m15a")

	Name(b000, Buffer() {1,2,3,4,5,6,7,8,9})
	CreateField(b000, 0, 8, bf00)

	CH03(ts, z058, 135, 0, 0)

	Store(DerefOf(bf00), Local5)

	// Bug 83, Bugzilla 5387.
	CH04(ts, 0, 0xff, z058, 136, 0, 0)

	Store(DerefOf(bf00), Local0)

	// Bug 83, Bugzilla 5387.
	CH04(ts, 0, 0xff, z058, 137, 0, 0)
}

// Index(Field Unit)
Method(m15d,, Serialized)
{
	Name(ts, "m15d")

	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field(r000, ByteAcc, NoLock, Preserve) {f000,8}
	Field(r000, ByteAcc, NoLock, Preserve) {bnk0,8,f00a,8,f00b,8}
	BankField(r000, bnk0, 0, ByteAcc, NoLock, Preserve) {bkf0,4}
	IndexField(f00a, f00b, ByteAcc, NoLock, Preserve) {if00,1,if01,1}

	CH03(ts, z058, 138, 0, 0)

	// Field

	Store(Index(f000, 0), Local5)

	CH04(ts, 1, 47, z058, 139, 0, 0)	// AE_AML_OPERAND_TYPE

	Index(f000, 0, Local0)

	CH04(ts, 0, 47, z058, 140, 0, 0)	// AE_AML_OPERAND_TYPE

	Store(Index(f000, 0), Local0)

	CH04(ts, 0, 0xff, z058, 141, 0, 0)

	Store(Index(f000, 0), Local0)

	CH04(ts, 0, 0xff, z058, 142, 0, 0)

	Store(Index(f000, 0, Local0), Local1)

	CH04(ts, 0, 0xff, z058, 143, 0, 0)

	// BankField

	Store(Index(bkf0, 0), Local5)

	CH04(ts, 1, 47, z058, 144, 0, 0)	// AE_AML_OPERAND_TYPE

	Index(bkf0, 0, Local0)

	CH04(ts, 0, 47, z058, 145, 0, 0)	// AE_AML_OPERAND_TYPE

	Store(Index(bkf0, 0), Local0)

	CH04(ts, 0, 0xff, z058, 146, 0, 0)

	Store(Index(bkf0, 0), Local0)

	CH04(ts, 0, 0xff, z058, 147, 0, 0)

	Store(Index(bkf0, 0, Local0), Local1)

	CH04(ts, 0, 0xff, z058, 148, 0, 0)

	// IndexField

	Store(Index(if00, 0), Local5)

	CH04(ts, 1, 47, z058, 149, 0, 0)	// AE_AML_OPERAND_TYPE

	Index(if00, 0, Local0)

	CH04(ts, 0, 47, z058, 150, 0, 0)	// AE_AML_OPERAND_TYPE

	Store(Index(if00, 0), Local0)

	CH04(ts, 0, 0xff, z058, 151, 0, 0)

	Store(Index(if00, 0), Local0)

	CH04(ts, 0, 0xff, z058, 152, 0, 0)

	Store(Index(if00, 0, Local0), Local1)

	CH04(ts, 0, 0xff, z058, 153, 0, 0)
}

// Bug 83
// DerefOf(Field Unit)
Method(m15e,, Serialized)
{
	Name(ts, "m15e")

	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field(r000, ByteAcc, NoLock, Preserve) {f000,8}
	Field(r000, ByteAcc, NoLock, Preserve) {bnk0,8,f00a,8,f00b,8}
	BankField(r000, bnk0, 0, ByteAcc, NoLock, Preserve) {bkf0,4}
	IndexField(f00a, f00b, ByteAcc, NoLock, Preserve) {if00,1,if01,1}

	CH03(ts, z058, 154, 0, 0)

	// Field

	Store(DerefOf(f000), Local5)

	// Bug 83, Bugzilla 5387.
	CH04(ts, 0, 0xff, z058, 155, 0, 0)

	Store(DerefOf(f000), Local0)

	// Bug 83, Bugzilla 5387.
	CH04(ts, 0, 0xff, z058, 156, 0, 0)

	// BankField

	Store(DerefOf(bkf0), Local5)

	// Bug 83, Bugzilla 5387.
	CH04(ts, 0, 0xff, z058, 157, 0, 0)

	Store(DerefOf(bkf0), Local0)

	// Bug 83, Bugzilla 5387.
	CH04(ts, 0, 0xff, z058, 158, 0, 0)

	// IndexField

	Store(DerefOf(if00), Local5)

	// Bug 83, Bugzilla 5387.
	CH04(ts, 0, 0xff, z058, 159, 0, 0)

	Store(DerefOf(if00), Local0)

	// Bug 83, Bugzilla 5387.
	CH04(ts, 0, 0xff, z058, 160, 0, 0)
}

// UPDATE exc.m084: Implement this test for all the types of objects
//                  (see for example ref.asl files about objects) and
//                  all the types of operators.
Method(m084, 1, Serialized)
{
	Name(ts, "m084")

	if (Arg0) {
		Name(i000, 0x12345678)
		Name(s000, "12345678")
		Name(b000, Buffer() {0x12})
		Name(p000, Package() {0x12345678})
	}

	CH03(ts, z058, 161, 0, 0)

/*
Discuss: now the ObjectType doesnt cause exception!
Is it correct? Understand and discuss it.

		Store(ObjectType(i000), Local0)
		CH04(ts, 0, 46, z058, 162, 0, 0)	// AE_AML_NO_OPERAND

		Store(ObjectType(s000), Local0)
		CH04(ts, 0, 46, z058, 163, 0, 0)	// AE_AML_NO_OPERAND

		Store(ObjectType(b000), Local0)
		CH04(ts, 0, 46, z058, 164, 0, 0)	// AE_AML_NO_OPERAND

		Store(ObjectType(p000), Local0)
		CH04(ts, 0, 46, z058, 165, 0, 0)	// AE_AML_NO_OPERAND
*/

		Store(Index(p000, 0), Local0)
		if (LNot(Arg0)) {
			CH04(ts, 0, 0xFF, z058, 166, 0, 0)
		} else {
			CH03(ts, z058, 167, 0, 0)
		}

	CH03(ts, z058, 168, 0, 0)
}

Method(mf9d)
{
	Method(m000)
	{
		Store(0, Local7)
		Divide(1, Local7, Local2)
		if (LNotEqual(Local2, 0)) {
			m002()
		}
	}

	Method(m001)
	{
		Store(0, Local7)
		if (Divide(1, Local7, Local2)) {
			m002()
		}
	}

	Method(m002)
	{
	}

	CH03("mf9d", z058, 171, 0, 0)

	m000()

	CH04("mf9d", 0, 0xff, z058, 172, 0, 0)

	CH03("mf9d", z058, 173, 0, 0)

	m001()

	CH04("mf9d", 0, 0xff, z058, 174, 0, 0)
}

// Access out of OpRegion and DataTableRegion
Method(m708,, Serialized)
{
	Name(ts, "m708")

	Method(m000, 1)
	{
		OperationRegion(RGN0, SystemMemory, 0, arg0)
		OperationRegion(RGN1, SystemIO, 0x200, arg0)

		// UserDefRegionSpace
		OperationRegion(RGN2, 0x80, 0xd00, arg0)

		DataTableRegion (DR00, "SSDT", "", "")

		Field(RGN0, ByteAcc, NoLock, Preserve) {
			FU00, 0x801}
		Field(RGN1, ByteAcc, NoLock, Preserve) {
			FU01, 0x801}
		Field(RGN2, ByteAcc, NoLock, Preserve) {
			FU02, 0x801}
		Field(DR00, AnyAcc, NoLock, Preserve) {
			FU03, 0x1F1}            /* 0x1F0 == length of SSDT */

		Store(4, Local0)
		Store(0, Local1)

		While (Local0) {
			switch(Local1) {
				case(0) { Store(Refof(FU00), Local2) }
				case(1) { Store(Refof(FU01), Local2) }
				case(2) { Store(Refof(FU02), Local2) }
				case(3) { Store(Refof(FU03), Local2) }
			}

			Store(Refof(Local2), Local3)

			CH03(ts, z058, Add(175, Local1), 0, 0)

			// Write: except DataTableRegion
			if (LLess(Local1, 3)) {
				Store(0x12345678, DeRefof(Local3))
				CH04(ts, 0, 53, z058, Add(179, Local1), 0, 0)// AE_AML_REGION_LIMIT
			}

			// Read
			Store(DeRefof(Local2), Local4)

			/* July 2013
			 *
			 * The Store above should actually cause two errors
			 * 1) AE_AML_REGION_LIMIT
			 * 2) AE_AML_NO_RETURN_VALUE
			 *
			 * Indicate we only care about the first by placing a 1
			 * in the second argument
			 */
			CH04(ts, 1, 53, z058, Add(183, Local1), 0, 0)	// AE_AML_REGION_LIMIT

			Decrement(Local0)
			Increment(Local1)
		}
	}

	m000(0x100)
}

// Try non-copmputational data OpRegion arguments
Method(m709,, Serialized)
{
	Name(ts, "m709")

	Name(offp, Package(1){0xfedcba987654321f})
	Name(lenp, Package(1){0x123})
	Name(i000, 0x100)

	Method(m000,, Serialized) {
		OperationRegion(OPR0, SystemMemory, offp, 1)
	}
	
	CH03(ts, z058, 188, 0, 0)

	m000()

	CH04(ts, 0, 47, z058, 189, 0, 0)	// AE_AML_OPERAND_TYPE

	OperationRegion(OPR1, SystemMemory, 1, lenp)

	CH04(ts, 0, 47, z058, 190, 0, 0)	// AE_AML_OPERAND_TYPE
}

// Try OpRegion arguments when Offset + Length > MaxInteger
Method(m70a,, Serialized)
{
	Name(ts, "m70a")

	Name(off0, 0xfffffffffffffff0)
	Name(len0, 0x11)

	OperationRegion(OPR0, SystemMemory, off0, len0)

	//17+1 > 17.
	Field(OPR0, AnyAcc, NoLock, Preserve) {
		Offset(0x11), FU00, 8}
	//16+2 > 17.
	Field(OPR0, WordAcc, NoLock, Preserve) {
		Offset(0x10), FU01, 8}

	CH03(ts, z058, 191, 0, 0)

	Store(0x12, FU00)

	CH04(ts, 0, 53, z058, 192, 0, 0)	// AE_AML_REGION_LIMIT

	Store(0x12, FU01)

	CH04(ts, 0, 53, z058, 193, 0, 0)	// AE_AML_REGION_LIMIT
}

// Attempt to write into DataTableRegion
Method(m70b,, Serialized)
{
	Name(ts, "m70b")

	DataTableRegion (DR00, "SSDT", "", "")

	Field(DR00, AnyAcc, NoLock, Preserve) {
		FU00, 0x180}

	Store(FU00, Local0)

	CH03(ts, z058, 194, 0, 0)

	Store(0, FU00)

	CH04(ts, 0, 16, z058, 195, 0, 0)	// AE_SUPPORT
}

// Check non-String DataTableRegion *String arguments
Method(m7f5,, Serialized)
{
	Name(ts, "m7f5")

	Name(b000, Buffer(1){0x12})
	Name(i000, 0x12)
	Name(p000, Package(1){0x12})

	CH03(ts, z058, 193, 0, 0)

	DataTableRegion (DR00, b000, "", "")
	CH04(ts, 0, 5, z058, 196, 0, 0)	// AE_NOT_FOUND

	DataTableRegion (DR01, "SSDT", b000, "")
	CH04(ts, 0, 5, z058, 197, 0, 0)	// AE_NOT_FOUND

	DataTableRegion (DR02, "SSDT", "", b000)
	CH04(ts, 0, 5, z058, 198, 0, 0)	// AE_NOT_FOUND

	DataTableRegion (DR03, i000, "", "")
	CH04(ts, 0, 5, z058, 199, 0, 0)	// AE_NOT_FOUND

	DataTableRegion (DR04, "SSDT", i000, "")
	CH04(ts, 0, 5, z058, 200, 0, 0)	// AE_NOT_FOUND

	DataTableRegion (DR05, "SSDT", "", i000)
	CH04(ts, 0, 5, z058, 201, 0, 0)	// AE_NOT_FOUND

	DataTableRegion (DR06, p000, "", i000)
	CH04(ts, 0, 47, z058, 202, 0, 0)	// AE_AML_OPERAND_TYPE

	DataTableRegion (DR07, "SSDT", p000, "")
	CH04(ts, 0, 47, z058, 203, 0, 0)	// AE_AML_OPERAND_TYPE

	DataTableRegion (DR08, "SSDT", "", p000)
	CH04(ts, 0, 47, z058, 204, 0, 0)	// AE_AML_OPERAND_TYPE
}

// Check SMBus OpRegion restictions
Method(m7f6,, Serialized)
{
	Name(ts, "m7f6")

	OperationRegion(SMBD, SMBus, 0x4200, 0x100)

	Field(SMBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, SMBQuick),
		FLD0, 8
	}

	// Create improper SMBus data buffer
	Name(BUFF, Buffer(33){})

	CH03(ts, z058, 205, 0, 0)

	// Invoke Write Quick transaction
	Store(BUFF, FLD0)

	CH04(ts, 0, 54, z058, 206, 0, 0)	// AE_AML_BUFFER_LIMIT
}

/* Name space issues */
Method(m0bc,, Serialized)
{
	Name(ts, "m0bc")

	Method(m000)
	{
		return (0xabcd0000)
	}

	Method(m001)
	{
		Store(m000(), Local0)

		Method(m000)
		{
			return (0xabcd0001)
		}

		Store(m000(), Local1)

		if (LNotEqual(Local0, 0xabcd0000)) {
			err(ts, z058, 0x0ce, 0, 0, Local0, 0xabcd0000)
		}

		if (LNotEqual(Local1, 0xabcd0001)) {
			err(ts, z058, 0x0cf, 0, 0, Local1, 0xabcd0001)
		}
	}

	Method(m002)
	{
		CH03(ts, z058, 0x0d0, 0, 0)
		m004()
		CH04(ts, 0, 5, z058, 0x0d1, 0, 0) // AE_NOT_FOUND

		Method(m004)
		{
			return (0xabcd0002)
		}
	}

	Method(m003)
	{
		/* Recursion */
		CH03(ts, z058, 0x0d0, 0, 0)
		m003()
		CH04(ts, 0, 84, z058, 0x0d1, 0, 0) // AE_AML_METHOD_LIMIT

		Method(m003)
		{
			return (0xabcd0002)
		}
	}

	m001()
	m002()
	// m003()
}

// Run-method
Method(EXCP)
{
	SRMT("m140")
	m140()
	SRMT("m141")
	m141()
	SRMT("m142")
	m142()
	SRMT("m143")
	m143()
	SRMT("m144")
	m144()
	SRMT("m145")
	m145()
	SRMT("m085")
	m085()
	SRMT("m086")
	m086()
	SRMT("m148")
	m148()
	SRMT("m14b")
	m14b()
	SRMT("m14c")
	m14c()
	SRMT("m14d")
	m14d()
	SRMT("m14e")
	m14e()
	SRMT("m14f")
	m14f()
	SRMT("m150")
	m150(0)
	SRMT("m151")
	m151()
	SRMT("m152")
	m152()
	SRMT("m153")
	m153()
	SRMT("m154")
	m154()
	SRMT("m155")
	m155()
	SRMT("m156")
	m156()
	SRMT("m157")
	m157()
	SRMT("m158")
	m158()
	SRMT("m087")
	m087()
	SRMT("m159")
	m159()
	SRMT("m15a")
	m15a()
	SRMT("m15d")
	m15d()
	SRMT("m15e")
	m15e()

	// The sequence of calls below is important,
	// since not initialized names can refer to
	// the objects moved improperly into the cash
	// between two calls to the same Method:

	SRMT("m084-0")
	m084(0)
	SRMT("m084-1")
	m084(1)
	SRMT("m084-0-2")
	m084(0)

	SRMT("m1b3")
	m1b3()

	SRMT("mf9d")
	if (y200) {
		mf9d()
	} else {
		BLCK()
	}

	SRMT("m708")
	m708()
	SRMT("m709")
	m709()
	SRMT("m70a")
	m70a()
	SRMT("m70b")
	m70b()
	SRMT("m7f5")
	if (y223) {
		m7f5()
	} else {
		BLCK()
	}
	SRMT("m7f6")
	m7f6()

	SRMT("m0bc")
	m0bc()
}
