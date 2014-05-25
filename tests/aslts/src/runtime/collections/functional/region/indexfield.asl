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
 * IndexField objects definition and processing
 */

/*
 * On testing following issues should be covered:
 * - Operation Regions of different Region Space types application
 *   for index/data fields in IndexField objects definition,
 * - application of any allowed AccessType Keywords,
 * - application of any allowed LockRule Keywords,
 * - application of any allowed UpdateRule Keywords,
 * - application of the Offset macros in the FieldUnitList,
 * - application of the AccessAs macros in the FieldUnitList,
 * - on writing taking into account the Access Type in accord with
     the Update Rule,
 * - AccessAs macros influence on the remaining Field Units within the list,
 * - access to IndexField objects in accord with the index/data-style
 *   representation,
 * - access to IndexField objects located on boundary of AccessType Unit,
 * - integer/buffer representation of the Unit contents as depends on its
 *   Length and DSDT ComplianceRevision (32/64-bit Integer),
 * - Data Type Conversion Rules on storing to IndexFields.
 *
 * Can not be tested following issues:
 * - exact use of given Access Type alignment on Access to Unit data,
 * - exact functioning of data exchange based on IndexField functionality,
 * - exact use of specific Conversion Rules on storing of Buffers or Strings.
 */

Name(z144, 144)

OperationRegion(OPRk, SystemMemory, 0x200, 0x10)

Field(OPRk, ByteAcc, NoLock, Preserve) {
	fk32, 32,
}

Field(OPRk, ByteAcc, NoLock, Preserve) {
	fk64, 64,
}

Field(OPRk, ByteAcc, NoLock, Preserve) {
	fk28, 128,
}

Method(m770, 1, Serialized)
{
	Field(OPRk, ByteAcc, NoLock, Preserve) {
		idx0, 8,
		dta0, 8,
	}

	IndexField(idx0, dta0, ByteAcc, NoLock, Preserve) {
	    Offset (0x1A),
		reg0, 8,
		Offset (0x5B),
		reg1, 8,
		Offset (0x9C),
		reg2, 8,
		Offset (0xED),
		reg3, 8,
	}

	Name(i000, 0x1122)

	Concatenate(arg0, "-m770", arg0)

	Store("TEST: m770, initial IndexFields check", Debug)

    // Check object types

	Store(ObjectType(reg0), Local0)
	Store(c00d, Local1)
	if (LNotEqual(Local0, Local1)) {
		err(arg0, z144, 1, 0, 0, Local0, Local1)
	}

	Store(ObjectType(reg1), Local0)
	Store(c00d, Local1)
	if (LNotEqual(Local0, Local1)) {
		err(arg0, z144, 2, 0, 0, Local0, Local1)
	}

	Store(ObjectType(reg2), Local0)
	Store(c00d, Local1)
	if (LNotEqual(Local1, Local0)) {
		err(arg0, z144, 3, 0, 0, Local0, Local1)
	}

	Store(ObjectType(reg3), Local0)
	Store(c00d, Local1)
	if (LNotEqual(Local1, Local0)) {
		err(arg0, z144, 4, 0, 0, Local0, Local1)
	}

    // Check actual writes to the IndexField(s).
    // Uses fk32 overlay to check what exactly was written to the
    // Index/Data register pair.

	Store(i000, fk32)
	Store(0xF1, reg0)

	Store(fk32, Local0)
	Store(0xF11A, Local1)
	if (LNotEqual(Local1, Local0)) {
		err(arg0, z144, 5, 0, 0, Local0, Local1)
	}

	Store(i000, fk32)
	Store(0xD2, reg1)

	Store(fk32, Local0)
	Store(0xD25B, Local1)
	if (LNotEqual(Local1, Local0)) {
		err(arg0, z144, 6, 0, 0, Local0, Local1)
	}

	Store(i000, fk32)
	Store(0x93, reg2)

	Store(fk32, Local0)
	Store(0x939C, Local1)
	if (LNotEqual(Local1, Local0)) {
		err(arg0, z144, 7, 0, 0, Local0, Local1)
	}

	Store(i000, fk32)
	Store(0x54, reg3)

	Store(fk32, Local0)
	Store(0x54ED, Local1)
	if (LNotEqual(Local1, Local0)) {
		err(arg0, z144, 8, 0, 0, Local0, Local1)
	}
}

// Access to 1-bit IndexFields, ByteAcc
Method(m771, 1, Serialized)
{
	Concatenate(arg0, "-m771", arg0)

	Store("TEST: m771, Check Access to 1-bit IndexFields, ByteAcc", Debug)

	Field(OPRk, ByteAcc, NoLock, WriteAsZeros) {
		idx0, 16,
		dta0, 16,
	}
	IndexField(idx0, dta0, ByteAcc, NoLock, WriteAsZeros) {
		idf0, 1,
		    , 6,
		idf1, 1,
		idf2, 1,
		    , 6,
		idf3, 1,
		idf4, 1,
		    , 6,
		idf5, 1,
		idf6, 1,
		    , 6,
		idf7, 1,
	}

	m77e(arg0, 1, Refof(idf0), Refof(fk32), 0xffffffff, 0x00010000, 0)
	m77e(arg0, 1, Refof(idf1), Refof(fk32), 0xffffffff, 0x00800000, 1)
	m77e(arg0, 1, Refof(idf2), Refof(fk32), 0xffffffff, 0x00010001, 2)
	m77e(arg0, 1, Refof(idf3), Refof(fk32), 0xffffffff, 0x00800001, 3)
	m77e(arg0, 1, Refof(idf4), Refof(fk32), 0xffffffff, 0x00010002, 4)
	m77e(arg0, 1, Refof(idf5), Refof(fk32), 0xffffffff, 0x00800002, 5)
	m77e(arg0, 1, Refof(idf6), Refof(fk32), 0xffffffff, 0x00010003, 6)
	m77e(arg0, 1, Refof(idf7), Refof(fk32), 0xffffffff, 0x00800003, 7)
}

// Access to 1-bit IndexFields, WordAcc
Method(m772, 1, Serialized)
{
	Concatenate(arg0, "-m772", arg0)

	Store("TEST: m772, Check Access to 1-bit IndexFields, WordAcc", Debug)

	Field(OPRk, ByteAcc, NoLock, WriteAsZeros) {
		idx0, 16,
		dta0, 16,
	}
	IndexField(idx0, dta0, WordAcc, NoLock, WriteAsZeros) {
		idf0, 1, , 6, idf1, 1,
		idf2, 1, , 6, idf3, 1,
		idf4, 1, , 6, idf5, 1,
		idf6, 1, , 6, idf7, 1,
	}

	m77e(arg0, 1, Refof(idf0), Refof(fk32), 0xffffffff, 0x00010000, 0)
	m77e(arg0, 1, Refof(idf1), Refof(fk32), 0xffffffff, 0x00800000, 1)
	m77e(arg0, 1, Refof(idf2), Refof(fk32), 0xffffffff, 0x01000000, 2)
	m77e(arg0, 1, Refof(idf3), Refof(fk32), 0xffffffff, 0x80000000, 3)
	m77e(arg0, 1, Refof(idf4), Refof(fk32), 0xffffffff, 0x00010002, 4)
	m77e(arg0, 1, Refof(idf5), Refof(fk32), 0xffffffff, 0x00800002, 5)
	m77e(arg0, 1, Refof(idf6), Refof(fk32), 0xffffffff, 0x01000002, 6)
	m77e(arg0, 1, Refof(idf7), Refof(fk32), 0xffffffff, 0x80000002, 7)
}

// Access to 1-bit IndexFields, DWordAcc
Method(m773, 1, Serialized)
{
	Concatenate(arg0, "-m773", arg0)

	Store("TEST: m773, Check Access to 1-bit IndexFields, DWordAcc", Debug)

	Field(OPRk, ByteAcc, NoLock, WriteAsZeros) {
		idx0, 32,
		dta0, 32,
	}
	IndexField(idx0, dta0, DWordAcc, NoLock, WriteAsZeros) {
		idf0, 1, , 14, idf1, 1,
		idf2, 1, , 14, idf3, 1,
		idf4, 1, , 14, idf5, 1,
		idf6, 1, , 14, idf7, 1,
	}

	if (F64) {
		Store(0xffffffffffffffff, Local0)
	} else {
		Store(Buffer(8){0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}, Local0)
	}

	m77e(arg0, 1, Refof(idf0), Refof(fk64), Local0,
		Buffer(8){0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00}, 0)
	m77e(arg0, 1, Refof(idf1), Refof(fk64), Local0,
		Buffer(8){0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00}, 1)
	m77e(arg0, 1, Refof(idf2), Refof(fk64), Local0,
		Buffer(8){0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00}, 2)
	m77e(arg0, 1, Refof(idf3), Refof(fk64), Local0,
		Buffer(8){0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80}, 3)
	m77e(arg0, 1, Refof(idf4), Refof(fk64), Local0,
		Buffer(8){0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00}, 4)
	m77e(arg0, 1, Refof(idf5), Refof(fk64), Local0,
		Buffer(8){0x04, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00}, 5)
	m77e(arg0, 1, Refof(idf6), Refof(fk64), Local0,
		Buffer(8){0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00}, 6)
	m77e(arg0, 1, Refof(idf7), Refof(fk64), Local0,
		Buffer(8){0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80}, 7)
}

// Access to 1-bit IndexFields, QWordAcc
Method(m774, 1, Serialized)
{
	Concatenate(arg0, "-m774", arg0)

	Store("TEST: m774, Check Access to 1-bit IndexFields, QWordAcc", Debug)

	Field(OPRk, ByteAcc, NoLock, WriteAsZeros) {
		idx0, 64,
		dta0, 64,
	}
	IndexField(idx0, dta0, QWordAcc, NoLock, WriteAsZeros) {
		idf0, 1, , 30, idf1, 1,
		idf2, 1, , 30, idf3, 1,
		idf4, 1, , 30, idf5, 1,
		idf6, 1, , 30, idf7, 1,
	}

	Store(Buffer(16){
		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
		Local0)

	m77e(arg0, 1, Refof(idf0), Refof(fk28), Local0,
		Buffer(16){0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}, 0)
	m77e(arg0, 1, Refof(idf1), Refof(fk28), Local0,
		Buffer(16){0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00}, 1)
	m77e(arg0, 1, Refof(idf2), Refof(fk28), Local0,
		Buffer(16){0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00}, 2)
	m77e(arg0, 1, Refof(idf3), Refof(fk28), Local0,
		Buffer(16){0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80}, 3)
	m77e(arg0, 1, Refof(idf4), Refof(fk28), Local0,
		Buffer(16){0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}, 4)
	m77e(arg0, 1, Refof(idf5), Refof(fk28), Local0,
		Buffer(16){0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00}, 5)
	m77e(arg0, 1, Refof(idf6), Refof(fk28), Local0,
		Buffer(16){0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00}, 6)
	m77e(arg0, 1, Refof(idf7), Refof(fk28), Local0,
		Buffer(16){0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x80}, 7)
}

// Store to the IndexField and check Index/Data common Region Field
//m77e(CallChain, Source, IndexField, Common, Filler, BenchMark, ErrNum)
Method(m77e, 7)
{
	Concatenate(arg0, "-m77e", arg0)

	Store(Refof(arg2), Local0)
	Store(Refof(arg3), Local1)

	// Fill Index/Data common Region Field
	Store(arg4, Derefof(Local1))

	// Store to the IndexField
	Store(arg1, Derefof(Local0))

	// Retrieve Index/Data common Region Field
	Store(Derefof(arg3), Local2)

	if (LEqual(ObjectType(arg4), 1)) {
		ToInteger(arg5, arg5)
	}

	if (LNotEqual(arg5, Local2)) {
		err(arg0, z144, 9, z144, arg6, Local2, arg5)
	}

    // Fill then immediately read

	// Fill Index/Data common Region Field
	Store(arg4, Derefof(Local1))

	// Read from the IndexField
	Store(Derefof(arg2), Local2)

	if (LNotEqual(arg1, Local2)) {
		err(arg0, z144, 10, z144, arg6, Local2, arg1)
	}

/*
 * November 2011:
 * This code does not make sense. It fills the region overlay and then
 * reads the IndexField, and expects the resulting data to match the
 * compare value (BenchMark). Commented out.
 */
/*
	// Retrieve Index/Data common Region Field
	Store(Derefof(arg3), Local2)

	if (LNotEqual(arg5, Local2)) {
		err(arg0, z144, 11, z144, arg6, Local2, arg5)
	}
*/
}

// Splitting of IndexFields
// m775(CallChain)
Method(m775, 1, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 1000, 0x08)

	Store("TEST: m775, Check Splitting of IndexFields", Debug)

	Concatenate(arg0, "-m775", arg0)

	m780(arg0, OPR0)
	m781(arg0, OPR0)
	m782(arg0, OPR0)
	m783(arg0, OPR0)
	m784(arg0, OPR0)
	m785(arg0, OPR0)
	m786(arg0, OPR0)
	m787(arg0, OPR0)
	m788(arg0, OPR0)
	m789(arg0, OPR0)
}

// Create IndexFields that spans the same bits
// and check possible inconsistence, 0-bit offset.
// m780(CallChain, OpRegion)
Method(m780, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0x100, 0x08)

	Concatenate(arg0, "-m780", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, ByteAcc, NoLock, Preserve) {
		IDX0, 16,
		DAT0, 16,
	}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 0, // 0-bit offset
			IF00, 0x3}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 0,
			IF10, 0x1,
			IF11, 0x1,
			IF12, 0x1}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 0,
			IF20, 0x1,
			IF21, 0x2}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 0,
			IF30, 0x2,
			IF31, 0x1}

	Store(8, Local0)

	Store(Package(){IF10, IF11, IF12, IF20, IF21, IF30, IF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, IF00)

		if (y118) {
		} else {
			Store(IF10, Index(Local1, 0))
			Store(IF11, Index(Local1, 1))
			Store(IF12, Index(Local1, 2))
			Store(IF20, Index(Local1, 3))
			Store(IF21, Index(Local1, 4))
			Store(IF30, Index(Local1, 5))
			Store(IF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create IndexFields that spans the same bits
// and check possible inconsistence, 1-bit offset.
// m781(CallChain, OpRegion)
Method(m781, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)

	Concatenate(arg0, "-m781", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, WordAcc, NoLock, Preserve) {
		IDX0, 16,
		DAT0, 16,
	}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 1, // 1-bit offset
			IF00, 0x3}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 1,
			IF10, 0x1,
			IF11, 0x1,
			IF12, 0x1}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 1,
			IF20, 0x1,
			IF21, 0x2}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 1,
			IF30, 0x2,
			IF31, 0x1}

	Store(8, Local0)

	Store(Package(){IF10, IF11, IF12, IF20, IF21, IF30, IF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, IF00)

		if (y118) {
		} else {
			Store(IF10, Index(Local1, 0))
			Store(IF11, Index(Local1, 1))
			Store(IF12, Index(Local1, 2))
			Store(IF20, Index(Local1, 3))
			Store(IF21, Index(Local1, 4))
			Store(IF30, Index(Local1, 5))
			Store(IF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create IndexFields that spans the same bits
// and check possible inconsistence, 2-bit offset.
// m782(CallChain, OpRegion)
Method(m782, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)

	Concatenate(arg0, "-m782", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, DWordAcc, NoLock, Preserve) {
		IDX0, 32,
		DAT0, 32,
	}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 2, // 2-bit offset
			IF00, 0x3}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 2,
			IF10, 0x1,
			IF11, 0x1,
			IF12, 0x1}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 2,
			IF20, 0x1,
			IF21, 0x2}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 2,
			IF30, 0x2,
			IF31, 0x1}

	Store(8, Local0)

	Store(Package(){IF10, IF11, IF12, IF20, IF21, IF30, IF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, IF00)

		if (y118) {
		} else {
			Store(IF10, Index(Local1, 0))
			Store(IF11, Index(Local1, 1))
			Store(IF12, Index(Local1, 2))
			Store(IF20, Index(Local1, 3))
			Store(IF21, Index(Local1, 4))
			Store(IF30, Index(Local1, 5))
			Store(IF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create IndexFields that spans the same bits
// and check possible inconsistence, 3-bit offset.
// m783(CallChain, OpRegion)
Method(m783, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)

	Concatenate(arg0, "-m783", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, ByteAcc, NoLock, WriteAsOnes) {
		IDX0, 16,
		DAT0, 16,
	}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 3, // 3-bit offset
			IF00, 0x3}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 3,
			IF10, 0x1,
			IF11, 0x1,
			IF12, 0x1}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 3,
			IF20, 0x1,
			IF21, 0x2}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 3,
			IF30, 0x2,
			IF31, 0x1}

	Store(8, Local0)

	Store(Package(){IF10, IF11, IF12, IF20, IF21, IF30, IF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, IF00)

		if (y118) {
		} else {
			Store(IF10, Index(Local1, 0))
			Store(IF11, Index(Local1, 1))
			Store(IF12, Index(Local1, 2))
			Store(IF20, Index(Local1, 3))
			Store(IF21, Index(Local1, 4))
			Store(IF30, Index(Local1, 5))
			Store(IF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create IndexFields that spans the same bits
// and check possible inconsistence, 4-bit offset.
// m784(CallChain, OpRegion)
Method(m784, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)

	Concatenate(arg0, "-m784", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, WordAcc, NoLock, WriteAsOnes) {
		IDX0, 16,
		DAT0, 16,
	}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 4, // 4-bit offset
			IF00, 0x3}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 4,
			IF10, 0x1,
			IF11, 0x1,
			IF12, 0x1}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 4,
			IF20, 0x1,
			IF21, 0x2}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 4,
			IF30, 0x2,
			IF31, 0x1}

	Store(8, Local0)

	Store(Package(){IF10, IF11, IF12, IF20, IF21, IF30, IF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, IF00)

		if (y118) {
		} else {
			Store(IF10, Index(Local1, 0))
			Store(IF11, Index(Local1, 1))
			Store(IF12, Index(Local1, 2))
			Store(IF20, Index(Local1, 3))
			Store(IF21, Index(Local1, 4))
			Store(IF30, Index(Local1, 5))
			Store(IF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create IndexFields that spans the same bits
// and check possible inconsistence, 5-bit offset.
// m785(CallChain, OpRegion)
Method(m785, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)

	Concatenate(arg0, "-m785", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, DWordAcc, NoLock, WriteAsOnes) {
		IDX0, 32,
		DAT0, 32,
	}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 5, // 5-bit offset
			IF00, 0x3}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 5,
			IF10, 0x1,
			IF11, 0x1,
			IF12, 0x1}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 5,
			IF20, 0x1,
			IF21, 0x2}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 5,
			IF30, 0x2,
			IF31, 0x1}

	Store(8, Local0)

	Store(Package(){IF10, IF11, IF12, IF20, IF21, IF30, IF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, IF00)

		if (y118) {
		} else {
			Store(IF10, Index(Local1, 0))
			Store(IF11, Index(Local1, 1))
			Store(IF12, Index(Local1, 2))
			Store(IF20, Index(Local1, 3))
			Store(IF21, Index(Local1, 4))
			Store(IF30, Index(Local1, 5))
			Store(IF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create IndexFields that spans the same bits
// and check possible inconsistence, 6-bit offset.
// m786(CallChain, OpRegion)
Method(m786, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)

	Concatenate(arg0, "-m786", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, ByteAcc, NoLock, WriteAsZeros) {
		IDX0, 16,
		DAT0, 16,
	}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 6, // 6-bit offset
			IF00, 0x3}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 6,
			IF10, 0x1,
			IF11, 0x1,
			IF12, 0x1}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 6,
			IF20, 0x1,
			IF21, 0x2}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 6,
			IF30, 0x2,
			IF31, 0x1}

	Store(8, Local0)

	Store(Package(){IF10, IF11, IF12, IF20, IF21, IF30, IF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, IF00)

		if (y118) {
		} else {
			Store(IF10, Index(Local1, 0))
			Store(IF11, Index(Local1, 1))
			Store(IF12, Index(Local1, 2))
			Store(IF20, Index(Local1, 3))
			Store(IF21, Index(Local1, 4))
			Store(IF30, Index(Local1, 5))
			Store(IF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create IndexFields that spans the same bits
// and check possible inconsistence, 7-bit offset.
// m787(CallChain, OpRegion)
Method(m787, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)

	Concatenate(arg0, "-m787", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, WordAcc, NoLock, WriteAsZeros) {
		IDX0, 16,
		DAT0, 16,
	}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 7, // 7-bit offset
			IF00, 0x3}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 7,
			IF10, 0x1,
			IF11, 0x1,
			IF12, 0x1}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 7,
			IF20, 0x1,
			IF21, 0x2}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 7,
			IF30, 0x2,
			IF31, 0x1}

	Store(8, Local0)

	Store(Package(){IF10, IF11, IF12, IF20, IF21, IF30, IF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, IF00)

		if (y118) {
		} else {
			Store(IF10, Index(Local1, 0))
			Store(IF11, Index(Local1, 1))
			Store(IF12, Index(Local1, 2))
			Store(IF20, Index(Local1, 3))
			Store(IF21, Index(Local1, 4))
			Store(IF30, Index(Local1, 5))
			Store(IF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create IndexFields that spans the same bits
// and check possible inconsistence, 8-bit offset.
// m788(CallChain, OpRegion)
Method(m788, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)

	Concatenate(arg0, "-m788", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, DWordAcc, NoLock, WriteAsZeros) {
		IDX0, 32,
		DAT0, 32,
	}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 8, // 8-bit offset
			IF00, 0x3}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 8,
			IF10, 0x1,
			IF11, 0x1,
			IF12, 0x1}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 8,
			IF20, 0x1,
			IF21, 0x2}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 8,
			IF30, 0x2,
			IF31, 0x1}

	Store(8, Local0)

	Store(Package(){IF10, IF11, IF12, IF20, IF21, IF30, IF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, IF00)

		if (y118) {
		} else {
			Store(IF10, Index(Local1, 0))
			Store(IF11, Index(Local1, 1))
			Store(IF12, Index(Local1, 2))
			Store(IF20, Index(Local1, 3))
			Store(IF21, Index(Local1, 4))
			Store(IF30, Index(Local1, 5))
			Store(IF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create IndexFields that spans the same bits
// and check possible inconsistence, 2046-bit offset.
// m789(CallChain, OpRegion)
Method(m789, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)

	Concatenate(arg0, "-m789", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, WordAcc, NoLock, Preserve) {
		IDX0, 16,
		DAT0, 16,
	}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 2046, // 2046-bit offset
			IF00, 0x3}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 2046,
			IF10, 0x1,
			IF11, 0x1,
			IF12, 0x1}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 2046,
			IF20, 0x1,
			IF21, 0x2}

	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
			, 2046,
			IF30, 0x2,
			IF31, 0x1}

	Store(8, Local0)

	Store(Package(){IF10, IF11, IF12, IF20, IF21, IF30, IF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, IF00)

		if (y118) {
		} else {
			Store(IF10, Index(Local1, 0))
			Store(IF11, Index(Local1, 1))
			Store(IF12, Index(Local1, 2))
			Store(IF20, Index(Local1, 3))
			Store(IF21, Index(Local1, 4))
			Store(IF30, Index(Local1, 5))
			Store(IF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Testing parameters Packages
// Layout see in regionfield.asl
// (ByteAcc, NoLock, Preserve)
Name(pp10, Package() {
		0, 8, 0, 8, Package(6){0, 1, 1, 0, 1, "m790"},
})

// (WordAcc, NoLock, WriteAsOnes)
Name(pp11, Package() {
		0, 8, 8, 8, Package(6){1, 0, 2, 1, 1, "m791"},
})

// (DWordAcc, NoLock, WriteAsZeros)
Name(pp12, Package() {
		8, 8, 0, 8, Package(6){2, 1, 3, 2, 1, "m792"},
})

// (QWordAcc, NoLock, Preserve)
Name(pp13, Package() {
		8, 4, 8, 8, Package(6){1, 2, 4, 0, 1, "m793"},
})

// (AnyAcc, Lock, Preserve)
Name(pp14, Package() {
		12, 4, 8, 8, Package(6){1, 0, 0, 0, 0, "m794"},
})

// Check IndexField access: ByteAcc, NoLock, Preserve
// m776(CallChain)
Method(m776, 1)
{
	Concatenate(arg0, "-m776", arg0)

	Store("TEST: m776, Check IndexFields specified as (ByteAcc, NoLock, Preserve)", Debug)

	m72f(arg0, 1, "pp10", pp10)
}

// Check IndexField access: WordAcc, NoLock, WriteAsOnes
// m777(CallChain)
Method(m777, 1)
{
	Concatenate(arg0, "-m777", arg0)

	Store("TEST: m777, Check IndexFields specified as (WordAcc, NoLock, WriteAsOnes)", Debug)

	m72f(arg0, 1, "pp11", pp11)
}

// Check IndexField access: DWordAcc, NoLock, WriteAsZeros
// m778(CallChain)
Method(m778, 1)
{
	Concatenate(arg0, "-m778", arg0)

	Store("TEST: m778, Check IndexFields specified as (DWordAcc, NoLock, WriteAsZeros)", Debug)

	m72f(arg0, 1, "pp12", pp12)
}

// Check IndexField access: QWordAcc, NoLock, Preserve
// m779(CallChain)
Method(m779, 1)
{
	Concatenate(arg0, "-m779", arg0)

	Store("TEST: m779, Check IndexFields specified as (QWordAcc, NoLock, Preserve)", Debug)

	m72f(arg0, 1, "pp13", pp13)
}

// Check IndexField access: AnyAcc, Lock, Preserve
// m77a(CallChain)
Method(m77a, 1)
{
	Concatenate(arg0, "-m77a", arg0)

	Store("TEST: m77a, Check IndexFields specified as (AnyAcc, Lock, Preserve)", Debug)

	m72f(arg0, 1, "pp14", pp14)
}

// Create IndexField Unit
// (ByteAcc, NoLock, Preserve)
Method(m790, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 3000, 135)

	/*
	 * Consider different attributes of index/data fields
	 * taking into account the following restrictions:
	 * - the fields spanning the same access unit interfere,
	 * - the fields exceeding 64 bits cause AE_BUFFER_OVERFLOW,
	 * - index field exceeding 32 bits unexpectedly cause
	 *   AE_BUFFER_OVERFLOW too,
	 * - data field exceeding IndexField's Access Width
	 *   causes overwriting of next memory bytes.
	 */

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		IDX0, 8,
		DAT0, 8,
	}
	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
		g000, 2048,
	}

	Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
		Offset(3),
		IDX1, 8,
		DAT1, 8,
	}
	IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
		Offset(7),
		IDX2, 16,
		DAT2, 8,
	}
	IndexField(IDX2, DAT2, ByteAcc, NoLock, Preserve) {
		g002, 2048,
	}

	Field(OPR0, WordAcc, NoLock, Preserve) {
		Offset(11),
		IDX3, 8,
		DAT3, 8,
	}
	IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
		g003, 2048,
	}

	Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
		Offset(14),
		IDX4, 16,
		DAT4, 8,
	}
	IndexField(IDX4, DAT4, ByteAcc, NoLock, Preserve) {
		g004, 2048,
	}

	Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
		Offset(18),
		IDX5, 32,
		DAT5, 8,
	}
	IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
		g005, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, Preserve) {
		Offset(26),
		IDX6, 8,
		Offset(28),
		DAT6, 8,
	}
	IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
		g006, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
		Offset(32),
		IDX7, 32,
		DAT7, 8,
	}
	IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
		g007, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
		Offset(40),
		IDX8, 32,
		DAT8, 8,
	}
	IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
		g008, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, Preserve) {
		Offset(56),
		IDX9, 8,
		Offset(64),
		DAT9, 8,
	}
	IndexField(IDX9, DAT9, ByteAcc, NoLock, Preserve) {
		g009, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
		Offset(72),
		// Index field exceeding 32 bits causes AE_BUFFER_OVERFLOW
		// IDXA, 64,
		// Do not allow index/data interference
		, 32, IDXA, 32,
		DATA, 8,
	}
	IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
		g00a, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
		Offset(88),
		IDXB, 32,
		Offset(96),
		DATB, 8,
	}
	IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
		g00b, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, Preserve) {
		Offset(104),
		IDXC, 8,
		DATC, 8,
	}
	IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
		g00c, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
		Offset(107),
		// Index field exceeding 32 bits causes AE_BUFFER_OVERFLOW
		// IDXD, 64,
		IDXD, 32,
		DATD, 8,
	}
	IndexField(IDXD, DATD, ByteAcc, NoLock, Preserve) {
		g00d, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, WriteAsZeros) {
		Offset(123),
		IDXE, 32,
		DATE, 8,
	}
	IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
		g00e, 2048,
	}

	Concatenate(arg0, "-m790", arg0)

BreakPoint


	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f001, 6}
				Store(Refof(f001), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				IndexField(IDX2, DAT2, ByteAcc, NoLock, Preserve) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f003, 8}
				Store(Refof(f003), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				IndexField(IDX4, DAT4, ByteAcc, NoLock, Preserve) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f005, 31}
				Store(Refof(f005), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f007, 33}
				Store(Refof(f007), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				IndexField(IDX9, DAT9, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f009, 64}
				Store(Refof(f009), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				IndexField(IDXD, DATD, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z144, 12, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(0), , 1, f010, 1}
				Store(Refof(f010), Local3)
				Store(Refof(g001), Local4)
			}
			case (6) {
				IndexField(IDX2, DAT2, ByteAcc, NoLock, Preserve) {
					Offset(0), , 1, f011, 6}
				Store(Refof(f011), Local3)
				Store(Refof(g002), Local4)
			}
			case (7) {
				IndexField(IDX3, DAT3, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(0), , 1, f012, 7}
				Store(Refof(f012), Local3)
				Store(Refof(g003), Local4)
			}
			case (8) {
				IndexField(IDX4, DAT4, ByteAcc, NoLock, Preserve) {
					Offset(0), , 1, f013, 8}
				Store(Refof(f013), Local3)
				Store(Refof(g004), Local4)
			}
			case (9) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(0), , 1, f014, 9}
				Store(Refof(f014), Local3)
				Store(Refof(g005), Local4)
			}
			case (31) {
				IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
					Offset(0), , 1, f015, 31}
				Store(Refof(f015), Local3)
				Store(Refof(g006), Local4)
			}
			case (32) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(0), , 1, f016, 32}
				Store(Refof(f016), Local3)
				Store(Refof(g007), Local4)
			}
			case (33) {
				IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
					Offset(0), , 1, f017, 33}
				Store(Refof(f017), Local3)
				Store(Refof(g008), Local4)
			}
			case (63) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(0), , 1, f018, 63}
				Store(Refof(f018), Local3)
				Store(Refof(g009), Local4)
			}
			case (64) {
				IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
					Offset(0), , 1, f019, 64}
				Store(Refof(f019), Local3)
				Store(Refof(g00a), Local4)
			}
			case (65) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(0), , 1, f01a, 65}
				Store(Refof(f01a), Local3)
				Store(Refof(g00b), Local4)
			}
			case (69) {
				IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
					Offset(0), , 1, f01b, 69}
				Store(Refof(f01b), Local3)
				Store(Refof(g00c), Local4)
			}
			case (129) {
				IndexField(IDXD, DATD, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(0), , 1, f01c, 129}
				Store(Refof(f01c), Local3)
				Store(Refof(g00d), Local4)
			}
			case (256) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					Offset(0), , 1, f01d, 256}
				Store(Refof(f01d), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1023) {
				IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(0), , 1, f01e, 1023}
				Store(Refof(f01e), Local3)
				Store(Refof(g000), Local4)
			}
			case (1983) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					Offset(0), , 1, f01f, 1983}
				Store(Refof(f01f), Local3)
				Store(Refof(g001), Local4)
			}
			default {
				err(arg0, z144, 13, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX2, DAT2, ByteAcc, NoLock, Preserve) {
					, 2, f020, 1}
				Store(Refof(f020), Local3)
				Store(Refof(g002), Local4)
			}
			case (6) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f021, 6}
				Store(Refof(f021), Local3)
				Store(Refof(g003), Local4)
			}
			case (7) {
				IndexField(IDX4, DAT4, ByteAcc, NoLock, Preserve) {
					, 2, f022, 7}
				Store(Refof(f022), Local3)
				Store(Refof(g004), Local4)
			}
			case (8) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f023, 8}
				Store(Refof(f023), Local3)
				Store(Refof(g005), Local4)
			}
			case (9) {
				IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
					, 2, f024, 9}
				Store(Refof(f024), Local3)
				Store(Refof(g006), Local4)
			}
			case (31) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f025, 31}
				Store(Refof(f025), Local3)
				Store(Refof(g007), Local4)
			}
			case (32) {
				IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
					, 2, f026, 32}
				Store(Refof(f026), Local3)
				Store(Refof(g008), Local4)
			}
			case (33) {
				IndexField(IDX9, DAT9, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f027, 33}
				Store(Refof(f027), Local3)
				Store(Refof(g009), Local4)
			}
			case (63) {
				IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
					, 2, f028, 63}
				Store(Refof(f028), Local3)
				Store(Refof(g00a), Local4)
			}
			case (64) {
				IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f029, 64}
				Store(Refof(f029), Local3)
				Store(Refof(g00b), Local4)
			}
			case (65) {
				IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
					, 2, f02a, 65}
				Store(Refof(f02a), Local3)
				Store(Refof(g00c), Local4)
			}
			case (69) {
				IndexField(IDXD, DATD, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f02b, 69}
				Store(Refof(f02b), Local3)
				Store(Refof(g00d), Local4)
			}
			case (129) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					, 2, f02c, 129}
				Store(Refof(f02c), Local3)
				Store(Refof(g00e), Local4)
			}
			case (256) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f02d, 256}
				Store(Refof(f02d), Local3)
				Store(Refof(g000), Local4)
			}
			case (1023) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					, 2, f02e, 1023}
				Store(Refof(f02e), Local3)
				Store(Refof(g001), Local4)
			}
			case (1983) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f02f, 1983}
				Store(Refof(f02f), Local3)
				Store(Refof(g002), Local4)
			}
			default {
				err(arg0, z144, 14, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX3, DAT3, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f030, 1}
				Store(Refof(f030), Local3)
				Store(Refof(g003), Local4)
			}
			case (6) {
				IndexField(IDX4, DAT4, ByteAcc, NoLock, Preserve) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
				Store(Refof(g004), Local4)
			}
			case (7) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f032, 7}
				Store(Refof(f032), Local3)
				Store(Refof(g005), Local4)
			}
			case (8) {
				IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
				Store(Refof(g006), Local4)
			}
			case (9) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f034, 9}
				Store(Refof(f034), Local3)
				Store(Refof(g007), Local4)
			}
			case (31) {
				IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
				Store(Refof(g008), Local4)
			}
			case (32) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f036, 32}
				Store(Refof(f036), Local3)
				Store(Refof(g009), Local4)
			}
			case (33) {
				IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
				Store(Refof(g00a), Local4)
			}
			case (63) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f038, 63}
				Store(Refof(f038), Local3)
				Store(Refof(g00b), Local4)
			}
			case (64) {
				IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
				Store(Refof(g00c), Local4)
			}
			case (65) {
				IndexField(IDXD, DATD, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
				Store(Refof(g00d), Local4)
			}
			case (69) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
				Store(Refof(g00e), Local4)
			}
			case (129) {
				IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
				Store(Refof(g000), Local4)
			}
			case (256) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
				Store(Refof(g001), Local4)
			}
			case (1023) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
				Store(Refof(g002), Local4)
			}
			case (1983) {
				IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
				Store(Refof(g003), Local4)
			}
			default {
				err(arg0, z144, 15, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX4, DAT4, ByteAcc, NoLock, Preserve) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
				Store(Refof(g004), Local4)
			}
			case (6) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f041, 6}
				Store(Refof(f041), Local3)
				Store(Refof(g005), Local4)
			}
			case (7) {
				IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
				Store(Refof(g006), Local4)
			}
			case (8) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f043, 8}
				Store(Refof(f043), Local3)
				Store(Refof(g007), Local4)
			}
			case (9) {
				IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
				Store(Refof(g008), Local4)
			}
			case (31) {
				IndexField(IDX9, DAT9, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f045, 31}
				Store(Refof(f045), Local3)
				Store(Refof(g009), Local4)
			}
			case (32) {
				IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
				Store(Refof(g00a), Local4)
			}
			case (33) {
				IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f047, 33}
				Store(Refof(f047), Local3)
				Store(Refof(g00b), Local4)
			}
			case (63) {
				IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
				Store(Refof(g00c), Local4)
			}
			case (64) {
				IndexField(IDXD, DATD, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f049, 64}
				Store(Refof(f049), Local3)
				Store(Refof(g00d), Local4)
			}
			case (65) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
				Store(Refof(g00e), Local4)
			}
			case (69) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
				Store(Refof(g000), Local4)
			}
			case (129) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
				Store(Refof(g001), Local4)
			}
			case (256) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
				Store(Refof(g002), Local4)
			}
			case (1023) {
				IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
				Store(Refof(g003), Local4)
			}
			case (1983) {
				IndexField(IDX4, DAT4, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
				Store(Refof(g004), Local4)
			}
			default {
				err(arg0, z144, 16, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f050, 1}
				Store(Refof(f050), Local3)
				Store(Refof(g005), Local4)
			}
			case (6) {
				IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
				Store(Refof(g006), Local4)
			}
			case (7) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f052, 7}
				Store(Refof(f052), Local3)
				Store(Refof(g007), Local4)
			}
			case (8) {
				IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
				Store(Refof(g008), Local4)
			}
			case (9) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f054, 9}
				Store(Refof(f054), Local3)
				Store(Refof(g009), Local4)
			}
			case (31) {
				IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
				Store(Refof(g00a), Local4)
			}
			case (32) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f056, 32}
				Store(Refof(f056), Local3)
				Store(Refof(g00b), Local4)
			}
			case (33) {
				IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
				Store(Refof(g00c), Local4)
			}
			case (63) {
				IndexField(IDXD, DATD, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f058, 63}
				Store(Refof(f058), Local3)
				Store(Refof(g00d), Local4)
			}
			case (64) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
				Store(Refof(g00e), Local4)
			}
			case (65) {
				IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
				Store(Refof(g000), Local4)
			}
			case (69) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
				Store(Refof(g001), Local4)
			}
			case (129) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
				Store(Refof(g002), Local4)
			}
			case (256) {
				IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
				Store(Refof(g003), Local4)
			}
			case (1023) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
				Store(Refof(g004), Local4)
			}
			case (1983) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
				Store(Refof(g005), Local4)
			}
			default {
				err(arg0, z144, 17, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
				Store(Refof(g006), Local4)
			}
			case (6) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f061, 6}
				Store(Refof(f061), Local3)
				Store(Refof(g007), Local4)
			}
			case (7) {
				IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
				Store(Refof(g008), Local4)
			}
			case (8) {
				IndexField(IDX9, DAT9, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f063, 8}
				Store(Refof(f063), Local3)
				Store(Refof(g009), Local4)
			}
			case (9) {
				IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
				Store(Refof(g00a), Local4)
			}
			case (31) {
				IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f065, 31}
				Store(Refof(f065), Local3)
				Store(Refof(g00b), Local4)
			}
			case (32) {
				IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
				Store(Refof(g00c), Local4)
			}
			case (33) {
				IndexField(IDXD, DATD, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f067, 33}
				Store(Refof(f067), Local3)
				Store(Refof(g00d), Local4)
			}
			case (63) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
				Store(Refof(g00e), Local4)
			}
			case (64) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f069, 64}
				Store(Refof(f069), Local3)
				Store(Refof(g000), Local4)
			}
			case (65) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
				Store(Refof(g001), Local4)
			}
			case (69) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
				Store(Refof(g002), Local4)
			}
			case (129) {
				IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
				Store(Refof(g003), Local4)
			}
			case (256) {
				IndexField(IDX4, DAT4, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
				Store(Refof(g004), Local4)
			}
			case (1023) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
				Store(Refof(g005), Local4)
			}
			case (1983) {
				IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
				Store(Refof(g006), Local4)
			}
			default {
				err(arg0, z144, 18, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f070, 1}
				Store(Refof(f070), Local3)
				Store(Refof(g007), Local4)
			}
			case (6) {
				IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
				Store(Refof(g008), Local4)
			}
			case (7) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f072, 7}
				Store(Refof(f072), Local3)
				Store(Refof(g009), Local4)
			}
			case (8) {
				IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
				Store(Refof(g00a), Local4)
			}
			case (9) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f074, 9}
				Store(Refof(f074), Local3)
				Store(Refof(g00b), Local4)
			}
			case (31) {
				IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
				Store(Refof(g00c), Local4)
			}
			case (32) {
				IndexField(IDXD, DATD, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f076, 32}
				Store(Refof(f076), Local3)
				Store(Refof(g00d), Local4)
			}
			case (33) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
				Store(Refof(g00e), Local4)
			}
			case (63) {
				IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f078, 63}
				Store(Refof(f078), Local3)
				Store(Refof(g000), Local4)
			}
			case (64) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
				Store(Refof(g001), Local4)
			}
			case (65) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
				Store(Refof(g002), Local4)
			}
			case (69) {
				IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
				Store(Refof(g003), Local4)
			}
			case (129) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
				Store(Refof(g004), Local4)
			}
			case (256) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
				Store(Refof(g005), Local4)
			}
			case (1023) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
				Store(Refof(g006), Local4)
			}
			case (1983) {
				IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
				Store(Refof(g007), Local4)
			}
			default {
				err(arg0, z144, 19, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
				Store(Refof(g008), Local4)
			}
			case (6) {
				IndexField(IDX9, DAT9, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
				Store(Refof(g009), Local4)
			}
			case (7) {
				IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
				Store(Refof(g00a), Local4)
			}
			case (8) {
				IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
				Store(Refof(g00b), Local4)
			}
			case (9) {
				IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
				Store(Refof(g00c), Local4)
			}
			case (31) {
				IndexField(IDXD, DATD, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
				Store(Refof(g00d), Local4)
			}
			case (32) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
				Store(Refof(g00e), Local4)
			}
			case (33) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
				Store(Refof(g000), Local4)
			}
			case (63) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
				Store(Refof(g001), Local4)
			}
			case (64) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
				Store(Refof(g002), Local4)
			}
			case (65) {
				IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
				Store(Refof(g003), Local4)
			}
			case (69) {
				IndexField(IDX4, DAT4, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
				Store(Refof(g004), Local4)
			}
			case (129) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
				Store(Refof(g005), Local4)
			}
			case (256) {
				IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
				Store(Refof(g006), Local4)
			}
			case (1023) {
				IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
				Store(Refof(g007), Local4)
			}
			case (1983) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
				Store(Refof(g008), Local4)
			}
			default {
				err(arg0, z144, 20, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f090, 1}
				Store(Refof(f090), Local3)
				Store(Refof(g009), Local4)
			}
			case (6) {
				IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
				Store(Refof(g00a), Local4)
			}
			case (7) {
				IndexField(IDXB, DATB, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f092, 7}
				Store(Refof(f092), Local3)
				Store(Refof(g00b), Local4)
			}
			case (8) {
				IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
				Store(Refof(g00c), Local4)
			}
			case (9) {
				IndexField(IDXD, DATD, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f094, 9}
				Store(Refof(f094), Local3)
				Store(Refof(g00d), Local4)
			}
			case (31) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
				Store(Refof(g00e), Local4)
			}
			case (32) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f096, 32}
				Store(Refof(f096), Local3)
				Store(Refof(g000), Local4)
			}
			case (33) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
				Store(Refof(g001), Local4)
			}
			case (63) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f098, 63}
				Store(Refof(f098), Local3)
				Store(Refof(g002), Local4)
			}
			case (64) {
				IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
				Store(Refof(g003), Local4)
			}
			case (65) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
				Store(Refof(g004), Local4)
			}
			case (69) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
				Store(Refof(g005), Local4)
			}
			case (129) {
				IndexField(IDX6, DAT6, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
				Store(Refof(g006), Local4)
			}
			case (256) {
				IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
				Store(Refof(g007), Local4)
			}
			case (1023) {
				IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
				Store(Refof(g008), Local4)
			}
			case (1983) {
				IndexField(IDX9, DAT9, ByteAcc, NoLock, Preserve) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
				Store(Refof(g009), Local4)
			}
			default {
				err(arg0, z144, 21, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
				Store(Refof(g00a), Local4)
			}
			case (6) {
				IndexField(IDXB, DATB, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
				Store(Refof(g00b), Local4)
			}
			case (7) {
				IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
				Store(Refof(g00c), Local4)
			}
			case (8) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
				Store(Refof(g00d), Local4)
			}
			case (9) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
				Store(Refof(g00e), Local4)
			}
			case (31) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
				Store(Refof(g000), Local4)
			}
			case (32) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
				Store(Refof(g001), Local4)
			}
			case (33) {
				IndexField(IDX2, DAT2, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
				Store(Refof(g002), Local4)
			}
			case (63) {
				IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
				Store(Refof(g003), Local4)
			}
			case (64) {
				IndexField(IDX4, DAT4, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
				Store(Refof(g004), Local4)
			}
			case (65) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
				Store(Refof(g005), Local4)
			}
			case (69) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
				Store(Refof(g006), Local4)
			}
			case (129) {
				IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
				Store(Refof(g007), Local4)
			}
			case (256) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
				Store(Refof(g008), Local4)
			}
			case (1023) {
				IndexField(IDX9, DAT9, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
				Store(Refof(g009), Local4)
			}
			case (1983) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
				Store(Refof(g00a), Local4)
			}
			default {
				err(arg0, z144, 22, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXB, DATB, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
				Store(Refof(g00b), Local4)
			}
			case (6) {
				IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
				Store(Refof(g00c), Local4)
			}
			case (7) {
				IndexField(IDXD, DATD, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
				Store(Refof(g00d), Local4)
			}
			case (8) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
				Store(Refof(g00e), Local4)
			}
			case (9) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
				Store(Refof(g000), Local4)
			}
			case (31) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
				Store(Refof(g001), Local4)
			}
			case (32) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
				Store(Refof(g002), Local4)
			}
			case (33) {
				IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
				Store(Refof(g003), Local4)
			}
			case (63) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
				Store(Refof(g004), Local4)
			}
			case (64) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
				Store(Refof(g005), Local4)
			}
			case (65) {
				IndexField(IDX6, DAT6, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
				Store(Refof(g006), Local4)
			}
			case (69) {
				IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
				Store(Refof(g007), Local4)
			}
			case (129) {
				IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
				Store(Refof(g008), Local4)
			}
			case (256) {
				IndexField(IDX9, DAT9, ByteAcc, NoLock, Preserve) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
				Store(Refof(g009), Local4)
			}
			case (1023) {
				IndexField(IDXA, DATA, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1983) {
				IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
				Store(Refof(g00b), Local4)
			}
			default {
				err(arg0, z144, 23, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
				Store(Refof(g00c), Local4)
			}
			case (6) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
				Store(Refof(g00d), Local4)
			}
			case (7) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
				Store(Refof(g00e), Local4)
			}
			case (8) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
				Store(Refof(g000), Local4)
			}
			case (9) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
				Store(Refof(g001), Local4)
			}
			case (31) {
				IndexField(IDX2, DAT2, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
				Store(Refof(g002), Local4)
			}
			case (32) {
				IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
				Store(Refof(g003), Local4)
			}
			case (33) {
				IndexField(IDX4, DAT4, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
				Store(Refof(g004), Local4)
			}
			case (63) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
				Store(Refof(g005), Local4)
			}
			case (64) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
				Store(Refof(g006), Local4)
			}
			case (65) {
				IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
				Store(Refof(g007), Local4)
			}
			case (69) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
				Store(Refof(g008), Local4)
			}
			case (129) {
				IndexField(IDX9, DAT9, ByteAcc, NoLock, Preserve) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
				Store(Refof(g009), Local4)
			}
			case (256) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1023) {
				IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1983) {
				IndexField(IDXC, DATC, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
				Store(Refof(g00c), Local4)
			}
			default {
				err(arg0, z144, 24, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXD, DATD, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
				Store(Refof(g00d), Local4)
			}
			case (6) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
				Store(Refof(g00e), Local4)
			}
			case (7) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
				Store(Refof(g000), Local4)
			}
			case (8) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
				Store(Refof(g001), Local4)
			}
			case (9) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
				Store(Refof(g002), Local4)
			}
			case (31) {
				IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
				Store(Refof(g003), Local4)
			}
			case (32) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
				Store(Refof(g004), Local4)
			}
			case (33) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
				Store(Refof(g005), Local4)
			}
			case (63) {
				IndexField(IDX6, DAT6, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
				Store(Refof(g006), Local4)
			}
			case (64) {
				IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
				Store(Refof(g007), Local4)
			}
			case (65) {
				IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
				Store(Refof(g008), Local4)
			}
			case (69) {
				IndexField(IDX9, DAT9, ByteAcc, NoLock, Preserve) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
				Store(Refof(g009), Local4)
			}
			case (129) {
				IndexField(IDXA, DATA, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
				Store(Refof(g00a), Local4)
			}
			case (256) {
				IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1023) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1983) {
				IndexField(IDXD, DATD, ByteAcc, NoLock, Preserve) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
				Store(Refof(g00d), Local4)
			}
			default {
				err(arg0, z144, 25, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
				Store(Refof(g00e), Local4)
			}
			case (6) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
				Store(Refof(g000), Local4)
			}
			case (7) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
				Store(Refof(g001), Local4)
			}
			case (8) {
				IndexField(IDX2, DAT2, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
				Store(Refof(g002), Local4)
			}
			case (9) {
				IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
				Store(Refof(g003), Local4)
			}
			case (31) {
				IndexField(IDX4, DAT4, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
				Store(Refof(g004), Local4)
			}
			case (32) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
				Store(Refof(g005), Local4)
			}
			case (33) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
				Store(Refof(g006), Local4)
			}
			case (63) {
				IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
				Store(Refof(g007), Local4)
			}
			case (64) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
				Store(Refof(g008), Local4)
			}
			case (65) {
				IndexField(IDX9, DAT9, ByteAcc, NoLock, Preserve) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
				Store(Refof(g009), Local4)
			}
			case (69) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
				Store(Refof(g00a), Local4)
			}
			case (129) {
				IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
				Store(Refof(g00b), Local4)
			}
			case (256) {
				IndexField(IDXC, DATC, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1023) {
				IndexField(IDXD, DATD, ByteAcc, NoLock, Preserve) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1983) {
				IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
				Store(Refof(g00e), Local4)
			}
			default {
				err(arg0, z144, 26, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				IndexField(IDX6, DAT6, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				IndexField(IDX9, DAT9, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				IndexField(IDXA, DATA, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				IndexField(IDXD, DATD, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z144, 27, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z144, 28, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Local4)
}

// Create IndexField Unit
// (WordAcc, NoLock, WriteAsOnes)
Method(m791, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 4000, 135)

	/*
	 * Consider different attributes of index/data fields
	 * taking into account the following restrictions:
	 * - the fields spanning the same access unit interfere,
	 * - the fields exceeding 64 bits cause AE_BUFFER_OVERFLOW,
	 * - index field exceeding 32 bits unexpectedly cause
	 *   AE_BUFFER_OVERFLOW too,
	 * - data field exceeding IndexField's Access Width
	 *   causes overwriting of next memory bytes.
	 */

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		IDX0, 8,
		DAT0, 16,
	}
	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
		g000, 2048,
	}

	Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
		Offset(3),
		IDX1, 8,
		DAT1, 16,
	}
	IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
		Offset(7),
		IDX2, 16,
		DAT2, 16,
	}
	IndexField(IDX2, DAT2, ByteAcc, NoLock, Preserve) {
		g002, 2048,
	}

	Field(OPR0, WordAcc, NoLock, Preserve) {
		Offset(11),
		IDX3, 8,
		DAT3, 16,
	}
	IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
		g003, 2048,
	}

	Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
		Offset(14),
		IDX4, 16,
		DAT4, 16,
	}
	IndexField(IDX4, DAT4, ByteAcc, NoLock, Preserve) {
		g004, 2048,
	}

	Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
		Offset(18),
		IDX5, 32,
		DAT5, 16,
	}
	IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
		g005, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, Preserve) {
		Offset(26),
		IDX6, 8,
		Offset(28),
		DAT6, 16,
	}
	IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
		g006, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
		Offset(32),
		IDX7, 32,
		DAT7, 16,
	}
	IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
		g007, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
		Offset(40),
		IDX8, 32,
		DAT8, 16,
	}
	IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
		g008, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, Preserve) {
		Offset(56),
		IDX9, 8,
		Offset(64),
		DAT9, 16,
	}
	IndexField(IDX9, DAT9, ByteAcc, NoLock, Preserve) {
		g009, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
		Offset(72),
		// Index field exceeding 32 bits causes AE_BUFFER_OVERFLOW
		// IDXA, 64,
		// Do not allow index/data interference
		, 32, IDXA, 32,
		DATA, 16,
	}
	IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
		g00a, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
		Offset(88),
		IDXB, 32,
		Offset(96),
		DATB, 16,
	}
	IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
		g00b, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, Preserve) {
		Offset(104),
		IDXC, 8,
		DATC, 16,
	}
	IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
		g00c, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
		Offset(107),
		// Index field exceeding 32 bits causes AE_BUFFER_OVERFLOW
		// IDXD, 64,
		IDXD, 32,
		DATD, 16,
	}
	IndexField(IDXD, DATD, ByteAcc, NoLock, Preserve) {
		g00d, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, WriteAsZeros) {
		Offset(123),
		IDXE, 32,
		DATE, 16,
	}
	IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
		g00e, 2048,
	}

	Concatenate(arg0, "-m791", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z144, 29, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f010, 1}
				Store(Refof(f010), Local3)
				Store(Refof(g001), Local4)
			}
			case (6) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f011, 6}
				Store(Refof(f011), Local3)
				Store(Refof(g002), Local4)
			}
			case (7) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f012, 7}
				Store(Refof(f012), Local3)
				Store(Refof(g003), Local4)
			}
			case (8) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f013, 8}
				Store(Refof(f013), Local3)
				Store(Refof(g004), Local4)
			}
			case (9) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f014, 9}
				Store(Refof(f014), Local3)
				Store(Refof(g005), Local4)
			}
			case (31) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f015, 31}
				Store(Refof(f015), Local3)
				Store(Refof(g006), Local4)
			}
			case (32) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f016, 32}
				Store(Refof(f016), Local3)
				Store(Refof(g007), Local4)
			}
			case (33) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f017, 33}
				Store(Refof(f017), Local3)
				Store(Refof(g008), Local4)
			}
			case (63) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f018, 63}
				Store(Refof(f018), Local3)
				Store(Refof(g009), Local4)
			}
			case (64) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f019, 64}
				Store(Refof(f019), Local3)
				Store(Refof(g00a), Local4)
			}
			case (65) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f01a, 65}
				Store(Refof(f01a), Local3)
				Store(Refof(g00b), Local4)
			}
			case (69) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f01b, 69}
				Store(Refof(f01b), Local3)
				Store(Refof(g00c), Local4)
			}
			case (129) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f01c, 129}
				Store(Refof(f01c), Local3)
				Store(Refof(g00d), Local4)
			}
			case (256) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f01d, 256}
				Store(Refof(f01d), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1023) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f01e, 1023}
				Store(Refof(f01e), Local3)
				Store(Refof(g000), Local4)
			}
			case (1983) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 1, f01f, 1983}
				Store(Refof(f01f), Local3)
				Store(Refof(g001), Local4)
			}
			default {
				err(arg0, z144, 30, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					, 2, f020, 1}
				Store(Refof(f020), Local3)
				Store(Refof(g002), Local4)
			}
			case (6) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					, 2, f021, 6}
				Store(Refof(f021), Local3)
				Store(Refof(g003), Local4)
			}
			case (7) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					, 2, f022, 7}
				Store(Refof(f022), Local3)
				Store(Refof(g004), Local4)
			}
			case (8) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					, 2, f023, 8}
				Store(Refof(f023), Local3)
				Store(Refof(g005), Local4)
			}
			case (9) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					, 2, f024, 9}
				Store(Refof(f024), Local3)
				Store(Refof(g006), Local4)
			}
			case (31) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					, 2, f025, 31}
				Store(Refof(f025), Local3)
				Store(Refof(g007), Local4)
			}
			case (32) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					, 2, f026, 32}
				Store(Refof(f026), Local3)
				Store(Refof(g008), Local4)
			}
			case (33) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					, 2, f027, 33}
				Store(Refof(f027), Local3)
				Store(Refof(g009), Local4)
			}
			case (63) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					, 2, f028, 63}
				Store(Refof(f028), Local3)
				Store(Refof(g00a), Local4)
			}
			case (64) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					, 2, f029, 64}
				Store(Refof(f029), Local3)
				Store(Refof(g00b), Local4)
			}
			case (65) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					, 2, f02a, 65}
				Store(Refof(f02a), Local3)
				Store(Refof(g00c), Local4)
			}
			case (69) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					, 2, f02b, 69}
				Store(Refof(f02b), Local3)
				Store(Refof(g00d), Local4)
			}
			case (129) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					, 2, f02c, 129}
				Store(Refof(f02c), Local3)
				Store(Refof(g00e), Local4)
			}
			case (256) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					, 2, f02d, 256}
				Store(Refof(f02d), Local3)
				Store(Refof(g000), Local4)
			}
			case (1023) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					, 2, f02e, 1023}
				Store(Refof(f02e), Local3)
				Store(Refof(g001), Local4)
			}
			case (1983) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					, 2, f02f, 1983}
				Store(Refof(f02f), Local3)
				Store(Refof(g002), Local4)
			}
			default {
				err(arg0, z144, 31, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
				Store(Refof(g003), Local4)
			}
			case (6) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
				Store(Refof(g004), Local4)
			}
			case (7) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
				Store(Refof(g005), Local4)
			}
			case (8) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
				Store(Refof(g006), Local4)
			}
			case (9) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
				Store(Refof(g007), Local4)
			}
			case (31) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
				Store(Refof(g008), Local4)
			}
			case (32) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
				Store(Refof(g009), Local4)
			}
			case (33) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
				Store(Refof(g00a), Local4)
			}
			case (63) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
				Store(Refof(g00b), Local4)
			}
			case (64) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
				Store(Refof(g00c), Local4)
			}
			case (65) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
				Store(Refof(g00d), Local4)
			}
			case (69) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
				Store(Refof(g00e), Local4)
			}
			case (129) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
				Store(Refof(g000), Local4)
			}
			case (256) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
				Store(Refof(g001), Local4)
			}
			case (1023) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
				Store(Refof(g002), Local4)
			}
			case (1983) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
				Store(Refof(g003), Local4)
			}
			default {
				err(arg0, z144, 32, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
				Store(Refof(g004), Local4)
			}
			case (6) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
				Store(Refof(g005), Local4)
			}
			case (7) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
				Store(Refof(g006), Local4)
			}
			case (8) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
				Store(Refof(g007), Local4)
			}
			case (9) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
				Store(Refof(g008), Local4)
			}
			case (31) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
				Store(Refof(g009), Local4)
			}
			case (32) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
				Store(Refof(g00a), Local4)
			}
			case (33) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
				Store(Refof(g00b), Local4)
			}
			case (63) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
				Store(Refof(g00c), Local4)
			}
			case (64) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
				Store(Refof(g00d), Local4)
			}
			case (65) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
				Store(Refof(g00e), Local4)
			}
			case (69) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
				Store(Refof(g000), Local4)
			}
			case (129) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
				Store(Refof(g001), Local4)
			}
			case (256) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
				Store(Refof(g002), Local4)
			}
			case (1023) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
				Store(Refof(g003), Local4)
			}
			case (1983) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
				Store(Refof(g004), Local4)
			}
			default {
				err(arg0, z144, 33, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
				Store(Refof(g005), Local4)
			}
			case (6) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
				Store(Refof(g006), Local4)
			}
			case (7) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
				Store(Refof(g007), Local4)
			}
			case (8) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
				Store(Refof(g008), Local4)
			}
			case (9) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
				Store(Refof(g009), Local4)
			}
			case (31) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
				Store(Refof(g00a), Local4)
			}
			case (32) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
				Store(Refof(g00b), Local4)
			}
			case (33) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
				Store(Refof(g00c), Local4)
			}
			case (63) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
				Store(Refof(g00d), Local4)
			}
			case (64) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
				Store(Refof(g00e), Local4)
			}
			case (65) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
				Store(Refof(g000), Local4)
			}
			case (69) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
				Store(Refof(g001), Local4)
			}
			case (129) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
				Store(Refof(g002), Local4)
			}
			case (256) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
				Store(Refof(g003), Local4)
			}
			case (1023) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
				Store(Refof(g004), Local4)
			}
			case (1983) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
				Store(Refof(g005), Local4)
			}
			default {
				err(arg0, z144, 34, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
				Store(Refof(g006), Local4)
			}
			case (6) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
				Store(Refof(g007), Local4)
			}
			case (7) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
				Store(Refof(g008), Local4)
			}
			case (8) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
				Store(Refof(g009), Local4)
			}
			case (9) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
				Store(Refof(g00a), Local4)
			}
			case (31) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
				Store(Refof(g00b), Local4)
			}
			case (32) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
				Store(Refof(g00c), Local4)
			}
			case (33) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
				Store(Refof(g00d), Local4)
			}
			case (63) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
				Store(Refof(g00e), Local4)
			}
			case (64) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
				Store(Refof(g000), Local4)
			}
			case (65) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
				Store(Refof(g001), Local4)
			}
			case (69) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
				Store(Refof(g002), Local4)
			}
			case (129) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
				Store(Refof(g003), Local4)
			}
			case (256) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
				Store(Refof(g004), Local4)
			}
			case (1023) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
				Store(Refof(g005), Local4)
			}
			case (1983) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
				Store(Refof(g006), Local4)
			}
			default {
				err(arg0, z144, 35, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
				Store(Refof(g007), Local4)
			}
			case (6) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
				Store(Refof(g008), Local4)
			}
			case (7) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
				Store(Refof(g009), Local4)
			}
			case (8) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
				Store(Refof(g00a), Local4)
			}
			case (9) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
				Store(Refof(g00b), Local4)
			}
			case (31) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
				Store(Refof(g00c), Local4)
			}
			case (32) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
				Store(Refof(g00d), Local4)
			}
			case (33) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
				Store(Refof(g00e), Local4)
			}
			case (63) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
				Store(Refof(g000), Local4)
			}
			case (64) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
				Store(Refof(g001), Local4)
			}
			case (65) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
				Store(Refof(g002), Local4)
			}
			case (69) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
				Store(Refof(g003), Local4)
			}
			case (129) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
				Store(Refof(g004), Local4)
			}
			case (256) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
				Store(Refof(g005), Local4)
			}
			case (1023) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
				Store(Refof(g006), Local4)
			}
			case (1983) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
				Store(Refof(g007), Local4)
			}
			default {
				err(arg0, z144, 36, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
				Store(Refof(g008), Local4)
			}
			case (6) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
				Store(Refof(g009), Local4)
			}
			case (7) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
				Store(Refof(g00a), Local4)
			}
			case (8) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
				Store(Refof(g00b), Local4)
			}
			case (9) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
				Store(Refof(g00c), Local4)
			}
			case (31) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
				Store(Refof(g00d), Local4)
			}
			case (32) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
				Store(Refof(g00e), Local4)
			}
			case (33) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
				Store(Refof(g000), Local4)
			}
			case (63) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
				Store(Refof(g001), Local4)
			}
			case (64) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
				Store(Refof(g002), Local4)
			}
			case (65) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
				Store(Refof(g003), Local4)
			}
			case (69) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
				Store(Refof(g004), Local4)
			}
			case (129) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
				Store(Refof(g005), Local4)
			}
			case (256) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
				Store(Refof(g006), Local4)
			}
			case (1023) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
				Store(Refof(g007), Local4)
			}
			case (1983) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
				Store(Refof(g008), Local4)
			}
			default {
				err(arg0, z144, 37, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
				Store(Refof(g009), Local4)
			}
			case (6) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
				Store(Refof(g00a), Local4)
			}
			case (7) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
				Store(Refof(g00b), Local4)
			}
			case (8) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
				Store(Refof(g00c), Local4)
			}
			case (9) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
				Store(Refof(g00d), Local4)
			}
			case (31) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
				Store(Refof(g00e), Local4)
			}
			case (32) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
				Store(Refof(g000), Local4)
			}
			case (33) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
				Store(Refof(g001), Local4)
			}
			case (63) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
				Store(Refof(g002), Local4)
			}
			case (64) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
				Store(Refof(g003), Local4)
			}
			case (65) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
				Store(Refof(g004), Local4)
			}
			case (69) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
				Store(Refof(g005), Local4)
			}
			case (129) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
				Store(Refof(g006), Local4)
			}
			case (256) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
				Store(Refof(g007), Local4)
			}
			case (1023) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
				Store(Refof(g008), Local4)
			}
			case (1983) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
				Store(Refof(g009), Local4)
			}
			default {
				err(arg0, z144, 38, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
				Store(Refof(g00a), Local4)
			}
			case (6) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
				Store(Refof(g00b), Local4)
			}
			case (7) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
				Store(Refof(g00c), Local4)
			}
			case (8) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
				Store(Refof(g00d), Local4)
			}
			case (9) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
				Store(Refof(g00e), Local4)
			}
			case (31) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
				Store(Refof(g000), Local4)
			}
			case (32) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
				Store(Refof(g001), Local4)
			}
			case (33) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
				Store(Refof(g002), Local4)
			}
			case (63) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
				Store(Refof(g003), Local4)
			}
			case (64) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
				Store(Refof(g004), Local4)
			}
			case (65) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
				Store(Refof(g005), Local4)
			}
			case (69) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
				Store(Refof(g006), Local4)
			}
			case (129) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
				Store(Refof(g007), Local4)
			}
			case (256) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
				Store(Refof(g008), Local4)
			}
			case (1023) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
				Store(Refof(g009), Local4)
			}
			case (1983) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
				Store(Refof(g00a), Local4)
			}
			default {
				err(arg0, z144, 39, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
				Store(Refof(g00b), Local4)
			}
			case (6) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
				Store(Refof(g00c), Local4)
			}
			case (7) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
				Store(Refof(g00d), Local4)
			}
			case (8) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
				Store(Refof(g00e), Local4)
			}
			case (9) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
				Store(Refof(g000), Local4)
			}
			case (31) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
				Store(Refof(g001), Local4)
			}
			case (32) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
				Store(Refof(g002), Local4)
			}
			case (33) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
				Store(Refof(g003), Local4)
			}
			case (63) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
				Store(Refof(g004), Local4)
			}
			case (64) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
				Store(Refof(g005), Local4)
			}
			case (65) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
				Store(Refof(g006), Local4)
			}
			case (69) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
				Store(Refof(g007), Local4)
			}
			case (129) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
				Store(Refof(g008), Local4)
			}
			case (256) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
				Store(Refof(g009), Local4)
			}
			case (1023) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1983) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
				Store(Refof(g00b), Local4)
			}
			default {
				err(arg0, z144, 40, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
				Store(Refof(g00c), Local4)
			}
			case (6) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
				Store(Refof(g00d), Local4)
			}
			case (7) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
				Store(Refof(g00e), Local4)
			}
			case (8) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
				Store(Refof(g000), Local4)
			}
			case (9) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
				Store(Refof(g001), Local4)
			}
			case (31) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
				Store(Refof(g002), Local4)
			}
			case (32) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
				Store(Refof(g003), Local4)
			}
			case (33) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
				Store(Refof(g004), Local4)
			}
			case (63) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
				Store(Refof(g005), Local4)
			}
			case (64) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
				Store(Refof(g006), Local4)
			}
			case (65) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
				Store(Refof(g007), Local4)
			}
			case (69) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
				Store(Refof(g008), Local4)
			}
			case (129) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
				Store(Refof(g009), Local4)
			}
			case (256) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1023) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1983) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
				Store(Refof(g00c), Local4)
			}
			default {
				err(arg0, z144, 41, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
				Store(Refof(g00d), Local4)
			}
			case (6) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
				Store(Refof(g00e), Local4)
			}
			case (7) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
				Store(Refof(g000), Local4)
			}
			case (8) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
				Store(Refof(g001), Local4)
			}
			case (9) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
				Store(Refof(g002), Local4)
			}
			case (31) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
				Store(Refof(g003), Local4)
			}
			case (32) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
				Store(Refof(g004), Local4)
			}
			case (33) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
				Store(Refof(g005), Local4)
			}
			case (63) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
				Store(Refof(g006), Local4)
			}
			case (64) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
				Store(Refof(g007), Local4)
			}
			case (65) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
				Store(Refof(g008), Local4)
			}
			case (69) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
				Store(Refof(g009), Local4)
			}
			case (129) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
				Store(Refof(g00a), Local4)
			}
			case (256) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1023) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1983) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
				Store(Refof(g00d), Local4)
			}
			default {
				err(arg0, z144, 42, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
				Store(Refof(g00e), Local4)
			}
			case (6) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
				Store(Refof(g000), Local4)
			}
			case (7) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
				Store(Refof(g001), Local4)
			}
			case (8) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
				Store(Refof(g002), Local4)
			}
			case (9) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
				Store(Refof(g003), Local4)
			}
			case (31) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
				Store(Refof(g004), Local4)
			}
			case (32) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
				Store(Refof(g005), Local4)
			}
			case (33) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
				Store(Refof(g006), Local4)
			}
			case (63) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
				Store(Refof(g007), Local4)
			}
			case (64) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
				Store(Refof(g008), Local4)
			}
			case (65) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
				Store(Refof(g009), Local4)
			}
			case (69) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
				Store(Refof(g00a), Local4)
			}
			case (129) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
				Store(Refof(g00b), Local4)
			}
			case (256) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1023) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1983) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
				Store(Refof(g00e), Local4)
			}
			default {
				err(arg0, z144, 43, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				IndexField(IDX1, DAT1, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				IndexField(IDX2, DAT2, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				IndexField(IDX3, DAT3, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				IndexField(IDX4, DAT4, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				IndexField(IDX5, DAT5, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				IndexField(IDX6, DAT6, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				IndexField(IDX7, DAT7, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				IndexField(IDX8, DAT8, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				IndexField(IDX9, DAT9, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				IndexField(IDXA, DATA, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				IndexField(IDXB, DATB, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				IndexField(IDXC, DATC, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				IndexField(IDXD, DATD, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				IndexField(IDXE, DATE, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				IndexField(IDX0, DAT0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z144, 44, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z144, 45, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Local4)
}

// Create IndexField Unit
// (DWordAcc, NoLock, WriteAsZeros)
Method(m792, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 5000, 135)

	/*
	 * Consider different attributes of index/data fields
	 * taking into account the following restrictions:
	 * - the fields spanning the same access unit interfere,
	 * - the fields exceeding 64 bits cause AE_BUFFER_OVERFLOW,
	 * - index field exceeding 32 bits unexpectedly cause
	 *   AE_BUFFER_OVERFLOW too,
	 * - data field exceeding IndexField's Access Width
	 *   causes overwriting of next memory bytes.
	 */

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		IDX0, 8,
		DAT0, 32,
	}
	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
		g000, 2048,
	}

	Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
		Offset(4),
		IDX1, 8,
		DAT1, 32,
	}
	IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
		Offset(8),
		IDX2, 16,
		DAT2, 32,
	}
	IndexField(IDX2, DAT2, ByteAcc, NoLock, Preserve) {
		g002, 2048,
	}

	Field(OPR0, WordAcc, NoLock, Preserve) {
		Offset(14),
		IDX3, 16,
		DAT3, 32,
	}
	IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
		g003, 2048,
	}

	Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
		Offset(20),
		IDX4, 16,
		DAT4, 32,
	}
	IndexField(IDX4, DAT4, ByteAcc, NoLock, Preserve) {
		g004, 2048,
	}

	Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
		Offset(26),
		IDX5, 32,
		DAT5, 32,
	}
	IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
		g005, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, Preserve) {
		Offset(34),
		IDX6, 8,
		Offset(36),
		DAT6, 32,
	}
	IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
		g006, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
		Offset(40),
		IDX7, 32,
		DAT7, 32,
	}
	IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
		g007, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
		Offset(48),
		IDX8, 32,
		DAT8, 32,
	}
	IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
		g008, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, Preserve) {
		Offset(60),
		IDX9, 8,
		Offset(64),
		DAT9, 32,
	}
	IndexField(IDX9, DAT9, ByteAcc, NoLock, Preserve) {
		g009, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
		Offset(72),
		// Index field exceeding 32 bits causes AE_BUFFER_OVERFLOW
		// IDXA, 64,
		// Do not allow index/data interference
		, 32, IDXA, 32,
		DATA, 32,
	}
	IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
		g00a, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
		Offset(88),
		IDXB, 32,
		Offset(96),
		DATB, 32,
	}
	IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
		g00b, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, Preserve) {
		Offset(104),
		IDXC, 8,
		DATC, 32,
	}
	IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
		g00c, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
		Offset(108),
		// Index field exceeding 32 bits causes AE_BUFFER_OVERFLOW
		// IDXD, 64,
		IDXD, 32,
		DATD, 32,
	}
	IndexField(IDXD, DATD, ByteAcc, NoLock, Preserve) {
		g00d, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, WriteAsZeros) {
		Offset(123),
		IDXE, 32,
		DATE, 32,
	}
	IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
		g00e, 2048,
	}

	Concatenate(arg0, "-m792", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z144, 46, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f010, 1}
				Store(Refof(f010), Local3)
				Store(Refof(g001), Local4)
			}
			case (6) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f011, 6}
				Store(Refof(f011), Local3)
				Store(Refof(g002), Local4)
			}
			case (7) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f012, 7}
				Store(Refof(f012), Local3)
				Store(Refof(g003), Local4)
			}
			case (8) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f013, 8}
				Store(Refof(f013), Local3)
				Store(Refof(g004), Local4)
			}
			case (9) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f014, 9}
				Store(Refof(f014), Local3)
				Store(Refof(g005), Local4)
			}
			case (31) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f015, 31}
				Store(Refof(f015), Local3)
				Store(Refof(g006), Local4)
			}
			case (32) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f016, 32}
				Store(Refof(f016), Local3)
				Store(Refof(g007), Local4)
			}
			case (33) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f017, 33}
				Store(Refof(f017), Local3)
				Store(Refof(g008), Local4)
			}
			case (63) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f018, 63}
				Store(Refof(f018), Local3)
				Store(Refof(g009), Local4)
			}
			case (64) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f019, 64}
				Store(Refof(f019), Local3)
				Store(Refof(g00a), Local4)
			}
			case (65) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f01a, 65}
				Store(Refof(f01a), Local3)
				Store(Refof(g00b), Local4)
			}
			case (69) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f01b, 69}
				Store(Refof(f01b), Local3)
				Store(Refof(g00c), Local4)
			}
			case (129) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f01c, 129}
				Store(Refof(f01c), Local3)
				Store(Refof(g00d), Local4)
			}
			case (256) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f01d, 256}
				Store(Refof(f01d), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1023) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f01e, 1023}
				Store(Refof(f01e), Local3)
				Store(Refof(g000), Local4)
			}
			case (1983) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 1, f01f, 1983}
				Store(Refof(f01f), Local3)
				Store(Refof(g001), Local4)
			}
			default {
				err(arg0, z144, 47, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f020, 1}
				Store(Refof(f020), Local3)
				Store(Refof(g002), Local4)
			}
			case (6) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f021, 6}
				Store(Refof(f021), Local3)
				Store(Refof(g003), Local4)
			}
			case (7) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f022, 7}
				Store(Refof(f022), Local3)
				Store(Refof(g004), Local4)
			}
			case (8) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f023, 8}
				Store(Refof(f023), Local3)
				Store(Refof(g005), Local4)
			}
			case (9) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f024, 9}
				Store(Refof(f024), Local3)
				Store(Refof(g006), Local4)
			}
			case (31) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f025, 31}
				Store(Refof(f025), Local3)
				Store(Refof(g007), Local4)
			}
			case (32) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f026, 32}
				Store(Refof(f026), Local3)
				Store(Refof(g008), Local4)
			}
			case (33) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f027, 33}
				Store(Refof(f027), Local3)
				Store(Refof(g009), Local4)
			}
			case (63) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f028, 63}
				Store(Refof(f028), Local3)
				Store(Refof(g00a), Local4)
			}
			case (64) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f029, 64}
				Store(Refof(f029), Local3)
				Store(Refof(g00b), Local4)
			}
			case (65) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f02a, 65}
				Store(Refof(f02a), Local3)
				Store(Refof(g00c), Local4)
			}
			case (69) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f02b, 69}
				Store(Refof(f02b), Local3)
				Store(Refof(g00d), Local4)
			}
			case (129) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f02c, 129}
				Store(Refof(f02c), Local3)
				Store(Refof(g00e), Local4)
			}
			case (256) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f02d, 256}
				Store(Refof(f02d), Local3)
				Store(Refof(g000), Local4)
			}
			case (1023) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f02e, 1023}
				Store(Refof(f02e), Local3)
				Store(Refof(g001), Local4)
			}
			case (1983) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f02f, 1983}
				Store(Refof(f02f), Local3)
				Store(Refof(g002), Local4)
			}
			default {
				err(arg0, z144, 48, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
				Store(Refof(g003), Local4)
			}
			case (6) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
				Store(Refof(g004), Local4)
			}
			case (7) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
				Store(Refof(g005), Local4)
			}
			case (8) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
				Store(Refof(g006), Local4)
			}
			case (9) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
				Store(Refof(g007), Local4)
			}
			case (31) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
				Store(Refof(g008), Local4)
			}
			case (32) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
				Store(Refof(g009), Local4)
			}
			case (33) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
				Store(Refof(g00a), Local4)
			}
			case (63) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
				Store(Refof(g00b), Local4)
			}
			case (64) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
				Store(Refof(g00c), Local4)
			}
			case (65) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
				Store(Refof(g00d), Local4)
			}
			case (69) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
				Store(Refof(g00e), Local4)
			}
			case (129) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
				Store(Refof(g000), Local4)
			}
			case (256) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
				Store(Refof(g001), Local4)
			}
			case (1023) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
				Store(Refof(g002), Local4)
			}
			case (1983) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
				Store(Refof(g003), Local4)
			}
			default {
				err(arg0, z144, 49, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
				Store(Refof(g004), Local4)
			}
			case (6) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
				Store(Refof(g005), Local4)
			}
			case (7) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
				Store(Refof(g006), Local4)
			}
			case (8) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
				Store(Refof(g007), Local4)
			}
			case (9) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
				Store(Refof(g008), Local4)
			}
			case (31) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
				Store(Refof(g009), Local4)
			}
			case (32) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
				Store(Refof(g00a), Local4)
			}
			case (33) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
				Store(Refof(g00b), Local4)
			}
			case (63) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
				Store(Refof(g00c), Local4)
			}
			case (64) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
				Store(Refof(g00d), Local4)
			}
			case (65) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
				Store(Refof(g00e), Local4)
			}
			case (69) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
				Store(Refof(g000), Local4)
			}
			case (129) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
				Store(Refof(g001), Local4)
			}
			case (256) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
				Store(Refof(g002), Local4)
			}
			case (1023) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
				Store(Refof(g003), Local4)
			}
			case (1983) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
				Store(Refof(g004), Local4)
			}
			default {
				err(arg0, z144, 50, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
				Store(Refof(g005), Local4)
			}
			case (6) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
				Store(Refof(g006), Local4)
			}
			case (7) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
				Store(Refof(g007), Local4)
			}
			case (8) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
				Store(Refof(g008), Local4)
			}
			case (9) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
				Store(Refof(g009), Local4)
			}
			case (31) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
				Store(Refof(g00a), Local4)
			}
			case (32) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
				Store(Refof(g00b), Local4)
			}
			case (33) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
				Store(Refof(g00c), Local4)
			}
			case (63) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
				Store(Refof(g00d), Local4)
			}
			case (64) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
				Store(Refof(g00e), Local4)
			}
			case (65) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
				Store(Refof(g000), Local4)
			}
			case (69) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
				Store(Refof(g001), Local4)
			}
			case (129) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
				Store(Refof(g002), Local4)
			}
			case (256) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
				Store(Refof(g003), Local4)
			}
			case (1023) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
				Store(Refof(g004), Local4)
			}
			case (1983) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
				Store(Refof(g005), Local4)
			}
			default {
				err(arg0, z144, 51, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
				Store(Refof(g006), Local4)
			}
			case (6) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
				Store(Refof(g007), Local4)
			}
			case (7) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
				Store(Refof(g008), Local4)
			}
			case (8) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
				Store(Refof(g009), Local4)
			}
			case (9) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
				Store(Refof(g00a), Local4)
			}
			case (31) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
				Store(Refof(g00b), Local4)
			}
			case (32) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
				Store(Refof(g00c), Local4)
			}
			case (33) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
				Store(Refof(g00d), Local4)
			}
			case (63) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
				Store(Refof(g00e), Local4)
			}
			case (64) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
				Store(Refof(g000), Local4)
			}
			case (65) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
				Store(Refof(g001), Local4)
			}
			case (69) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
				Store(Refof(g002), Local4)
			}
			case (129) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
				Store(Refof(g003), Local4)
			}
			case (256) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
				Store(Refof(g004), Local4)
			}
			case (1023) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
				Store(Refof(g005), Local4)
			}
			case (1983) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
				Store(Refof(g006), Local4)
			}
			default {
				err(arg0, z144, 52, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
				Store(Refof(g007), Local4)
			}
			case (6) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
				Store(Refof(g008), Local4)
			}
			case (7) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
				Store(Refof(g009), Local4)
			}
			case (8) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
				Store(Refof(g00a), Local4)
			}
			case (9) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
				Store(Refof(g00b), Local4)
			}
			case (31) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
				Store(Refof(g00c), Local4)
			}
			case (32) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
				Store(Refof(g00d), Local4)
			}
			case (33) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
				Store(Refof(g00e), Local4)
			}
			case (63) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
				Store(Refof(g000), Local4)
			}
			case (64) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
				Store(Refof(g001), Local4)
			}
			case (65) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
				Store(Refof(g002), Local4)
			}
			case (69) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
				Store(Refof(g003), Local4)
			}
			case (129) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
				Store(Refof(g004), Local4)
			}
			case (256) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
				Store(Refof(g005), Local4)
			}
			case (1023) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
				Store(Refof(g006), Local4)
			}
			case (1983) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
				Store(Refof(g007), Local4)
			}
			default {
				err(arg0, z144, 53, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
				Store(Refof(g008), Local4)
			}
			case (6) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
				Store(Refof(g009), Local4)
			}
			case (7) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
				Store(Refof(g00a), Local4)
			}
			case (8) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
				Store(Refof(g00b), Local4)
			}
			case (9) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
				Store(Refof(g00c), Local4)
			}
			case (31) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
				Store(Refof(g00d), Local4)
			}
			case (32) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
				Store(Refof(g00e), Local4)
			}
			case (33) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
				Store(Refof(g000), Local4)
			}
			case (63) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
				Store(Refof(g001), Local4)
			}
			case (64) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
				Store(Refof(g002), Local4)
			}
			case (65) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
				Store(Refof(g003), Local4)
			}
			case (69) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
				Store(Refof(g004), Local4)
			}
			case (129) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
				Store(Refof(g005), Local4)
			}
			case (256) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
				Store(Refof(g006), Local4)
			}
			case (1023) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
				Store(Refof(g007), Local4)
			}
			case (1983) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
				Store(Refof(g008), Local4)
			}
			default {
				err(arg0, z144, 54, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
				Store(Refof(g009), Local4)
			}
			case (6) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
				Store(Refof(g00a), Local4)
			}
			case (7) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
				Store(Refof(g00b), Local4)
			}
			case (8) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
				Store(Refof(g00c), Local4)
			}
			case (9) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
				Store(Refof(g00d), Local4)
			}
			case (31) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
				Store(Refof(g00e), Local4)
			}
			case (32) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
				Store(Refof(g000), Local4)
			}
			case (33) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
				Store(Refof(g001), Local4)
			}
			case (63) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
				Store(Refof(g002), Local4)
			}
			case (64) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
				Store(Refof(g003), Local4)
			}
			case (65) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
				Store(Refof(g004), Local4)
			}
			case (69) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
				Store(Refof(g005), Local4)
			}
			case (129) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
				Store(Refof(g006), Local4)
			}
			case (256) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
				Store(Refof(g007), Local4)
			}
			case (1023) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
				Store(Refof(g008), Local4)
			}
			case (1983) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
				Store(Refof(g009), Local4)
			}
			default {
				err(arg0, z144, 55, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
				Store(Refof(g00a), Local4)
			}
			case (6) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
				Store(Refof(g00b), Local4)
			}
			case (7) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
				Store(Refof(g00c), Local4)
			}
			case (8) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
				Store(Refof(g00d), Local4)
			}
			case (9) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
				Store(Refof(g00e), Local4)
			}
			case (31) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
				Store(Refof(g000), Local4)
			}
			case (32) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
				Store(Refof(g001), Local4)
			}
			case (33) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
				Store(Refof(g002), Local4)
			}
			case (63) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
				Store(Refof(g003), Local4)
			}
			case (64) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
				Store(Refof(g004), Local4)
			}
			case (65) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
				Store(Refof(g005), Local4)
			}
			case (69) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
				Store(Refof(g006), Local4)
			}
			case (129) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
				Store(Refof(g007), Local4)
			}
			case (256) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
				Store(Refof(g008), Local4)
			}
			case (1023) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
				Store(Refof(g009), Local4)
			}
			case (1983) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
				Store(Refof(g00a), Local4)
			}
			default {
				err(arg0, z144, 56, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
				Store(Refof(g00b), Local4)
			}
			case (6) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
				Store(Refof(g00c), Local4)
			}
			case (7) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
				Store(Refof(g00d), Local4)
			}
			case (8) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
				Store(Refof(g00e), Local4)
			}
			case (9) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
				Store(Refof(g000), Local4)
			}
			case (31) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
				Store(Refof(g001), Local4)
			}
			case (32) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
				Store(Refof(g002), Local4)
			}
			case (33) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
				Store(Refof(g003), Local4)
			}
			case (63) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
				Store(Refof(g004), Local4)
			}
			case (64) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
				Store(Refof(g005), Local4)
			}
			case (65) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
				Store(Refof(g006), Local4)
			}
			case (69) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
				Store(Refof(g007), Local4)
			}
			case (129) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
				Store(Refof(g008), Local4)
			}
			case (256) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
				Store(Refof(g009), Local4)
			}
			case (1023) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1983) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
				Store(Refof(g00b), Local4)
			}
			default {
				err(arg0, z144, 57, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
				Store(Refof(g00c), Local4)
			}
			case (6) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
				Store(Refof(g00d), Local4)
			}
			case (7) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
				Store(Refof(g00e), Local4)
			}
			case (8) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
				Store(Refof(g000), Local4)
			}
			case (9) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
				Store(Refof(g001), Local4)
			}
			case (31) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
				Store(Refof(g002), Local4)
			}
			case (32) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
				Store(Refof(g003), Local4)
			}
			case (33) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
				Store(Refof(g004), Local4)
			}
			case (63) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
				Store(Refof(g005), Local4)
			}
			case (64) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
				Store(Refof(g006), Local4)
			}
			case (65) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
				Store(Refof(g007), Local4)
			}
			case (69) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
				Store(Refof(g008), Local4)
			}
			case (129) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
				Store(Refof(g009), Local4)
			}
			case (256) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1023) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1983) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
				Store(Refof(g00c), Local4)
			}
			default {
				err(arg0, z144, 58, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
				Store(Refof(g00d), Local4)
			}
			case (6) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
				Store(Refof(g00e), Local4)
			}
			case (7) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
				Store(Refof(g000), Local4)
			}
			case (8) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
				Store(Refof(g001), Local4)
			}
			case (9) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
				Store(Refof(g002), Local4)
			}
			case (31) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
				Store(Refof(g003), Local4)
			}
			case (32) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
				Store(Refof(g004), Local4)
			}
			case (33) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
				Store(Refof(g005), Local4)
			}
			case (63) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
				Store(Refof(g006), Local4)
			}
			case (64) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
				Store(Refof(g007), Local4)
			}
			case (65) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
				Store(Refof(g008), Local4)
			}
			case (69) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
				Store(Refof(g009), Local4)
			}
			case (129) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
				Store(Refof(g00a), Local4)
			}
			case (256) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1023) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1983) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
				Store(Refof(g00d), Local4)
			}
			default {
				err(arg0, z144, 59, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
				Store(Refof(g00e), Local4)
			}
			case (6) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
				Store(Refof(g000), Local4)
			}
			case (7) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
				Store(Refof(g001), Local4)
			}
			case (8) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
				Store(Refof(g002), Local4)
			}
			case (9) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
				Store(Refof(g003), Local4)
			}
			case (31) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
				Store(Refof(g004), Local4)
			}
			case (32) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
				Store(Refof(g005), Local4)
			}
			case (33) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
				Store(Refof(g006), Local4)
			}
			case (63) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
				Store(Refof(g007), Local4)
			}
			case (64) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
				Store(Refof(g008), Local4)
			}
			case (65) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
				Store(Refof(g009), Local4)
			}
			case (69) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
				Store(Refof(g00a), Local4)
			}
			case (129) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
				Store(Refof(g00b), Local4)
			}
			case (256) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1023) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1983) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
				Store(Refof(g00e), Local4)
			}
			default {
				err(arg0, z144, 60, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				IndexField(IDX1, DAT1, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				IndexField(IDX2, DAT2, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				IndexField(IDX3, DAT3, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				IndexField(IDX4, DAT4, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				IndexField(IDX5, DAT5, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				IndexField(IDX6, DAT6, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				IndexField(IDX7, DAT7, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				IndexField(IDX8, DAT8, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				IndexField(IDX9, DAT9, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				IndexField(IDXA, DATA, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				IndexField(IDXB, DATB, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				IndexField(IDXC, DATC, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				IndexField(IDXD, DATD, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				IndexField(IDXE, DATE, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				IndexField(IDX0, DAT0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z144, 61, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z144, 62, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Local4)
}

// Create IndexField Unit
// (QWordAcc, NoLock, Preserve)
Method(m793, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 6000, 168)

	/*
	 * Consider different attributes of index/data fields
	 * taking into account the following restrictions:
	 * - the fields spanning the same access unit interfere,
	 * - the fields exceeding 64 bits cause AE_BUFFER_OVERFLOW,
	 * - index field exceeding 32 bits unexpectedly cause
	 *   AE_BUFFER_OVERFLOW too,
	 * - data field exceeding IndexField's Access Width
	 *   causes overwriting of next memory bytes.
	 */

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		IDX0, 8,
		DAT0, 64,
	}
	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
		g000, 2048,
	}

	Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
		Offset(7),
		IDX1, 8,
		DAT1, 64,
	}
	IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
		Offset(14),
		IDX2, 16,
		DAT2, 64,
	}
	IndexField(IDX2, DAT2, ByteAcc, NoLock, Preserve) {
		g002, 2048,
	}

	Field(OPR0, WordAcc, NoLock, Preserve) {
		Offset(24),
		IDX3, 16,
		DAT3, 64,
	}
	IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
		g003, 2048,
	}

	Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
		Offset(34),
		IDX4, 16,
		DAT4, 64,
	}
	IndexField(IDX4, DAT4, ByteAcc, NoLock, Preserve) {
		g004, 2048,
	}

	Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
		Offset(44),
		IDX5, 32,
		DAT5, 64,
	}
	IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
		g005, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, Preserve) {
		Offset(56),
		IDX6, 8,
		Offset(60),
		DAT6, 64,
	}
	IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
		g006, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
		Offset(68),
		IDX7, 32,
		DAT7, 64,
	}
	IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
		g007, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
		Offset(70),
		IDX8, 32,
		DAT8, 64,
	}
	IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
		g008, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, Preserve) {
		Offset(82),
		IDX9, 8,
		Offset(88),
		DAT9, 64,
	}
	IndexField(IDX9, DAT9, ByteAcc, NoLock, Preserve) {
		g009, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
		Offset(96),
		// Index field exceeding 32 bits causes AE_BUFFER_OVERFLOW
		// IDXA, 64,
		// Do not allow index/data interference
		, 32, IDXA, 32,
		DATA, 64,
	}
	IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
		g00a, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
		Offset(112),
		IDXB, 32,
		Offset(120),
		DATB, 64,
	}
	IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
		g00b, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, Preserve) {
		Offset(128),
		IDXC, 8,
		DATC, 64,
	}
	IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
		g00c, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
		Offset(136),
		// Index field exceeding 32 bits causes AE_BUFFER_OVERFLOW
		// IDXD, 64,
		IDXD, 32,
		Offset(144),
		DATD, 64,
	}
	IndexField(IDXD, DATD, ByteAcc, NoLock, Preserve) {
		g00d, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, WriteAsZeros) {
		Offset(152),
		IDXE, 32,
		Offset(160),
		DATE, 64,
	}
	IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
		g00e, 2048,
	}

	Concatenate(arg0, "-m793", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z144, 63, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f010, 1}
				Store(Refof(f010), Local3)
				Store(Refof(g001), Local4)
			}
			case (6) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f011, 6}
				Store(Refof(f011), Local3)
				Store(Refof(g002), Local4)
			}
			case (7) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f012, 7}
				Store(Refof(f012), Local3)
				Store(Refof(g003), Local4)
			}
			case (8) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f013, 8}
				Store(Refof(f013), Local3)
				Store(Refof(g004), Local4)
			}
			case (9) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f014, 9}
				Store(Refof(f014), Local3)
				Store(Refof(g005), Local4)
			}
			case (31) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f015, 31}
				Store(Refof(f015), Local3)
				Store(Refof(g006), Local4)
			}
			case (32) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f016, 32}
				Store(Refof(f016), Local3)
				Store(Refof(g007), Local4)
			}
			case (33) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f017, 33}
				Store(Refof(f017), Local3)
				Store(Refof(g008), Local4)
			}
			case (63) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f018, 63}
				Store(Refof(f018), Local3)
				Store(Refof(g009), Local4)
			}
			case (64) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f019, 64}
				Store(Refof(f019), Local3)
				Store(Refof(g00a), Local4)
			}
			case (65) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f01a, 65}
				Store(Refof(f01a), Local3)
				Store(Refof(g00b), Local4)
			}
			case (69) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f01b, 69}
				Store(Refof(f01b), Local3)
				Store(Refof(g00c), Local4)
			}
			case (129) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f01c, 129}
				Store(Refof(f01c), Local3)
				Store(Refof(g00d), Local4)
			}
			case (256) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f01d, 256}
				Store(Refof(f01d), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1023) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f01e, 1023}
				Store(Refof(f01e), Local3)
				Store(Refof(g000), Local4)
			}
			case (1983) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					Offset(0), , 1, f01f, 1983}
				Store(Refof(f01f), Local3)
				Store(Refof(g001), Local4)
			}
			default {
				err(arg0, z144, 64, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					, 2, f020, 1}
				Store(Refof(f020), Local3)
				Store(Refof(g002), Local4)
			}
			case (6) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					, 2, f021, 6}
				Store(Refof(f021), Local3)
				Store(Refof(g003), Local4)
			}
			case (7) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					, 2, f022, 7}
				Store(Refof(f022), Local3)
				Store(Refof(g004), Local4)
			}
			case (8) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					, 2, f023, 8}
				Store(Refof(f023), Local3)
				Store(Refof(g005), Local4)
			}
			case (9) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					, 2, f024, 9}
				Store(Refof(f024), Local3)
				Store(Refof(g006), Local4)
			}
			case (31) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					, 2, f025, 31}
				Store(Refof(f025), Local3)
				Store(Refof(g007), Local4)
			}
			case (32) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					, 2, f026, 32}
				Store(Refof(f026), Local3)
				Store(Refof(g008), Local4)
			}
			case (33) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					, 2, f027, 33}
				Store(Refof(f027), Local3)
				Store(Refof(g009), Local4)
			}
			case (63) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					, 2, f028, 63}
				Store(Refof(f028), Local3)
				Store(Refof(g00a), Local4)
			}
			case (64) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					, 2, f029, 64}
				Store(Refof(f029), Local3)
				Store(Refof(g00b), Local4)
			}
			case (65) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					, 2, f02a, 65}
				Store(Refof(f02a), Local3)
				Store(Refof(g00c), Local4)
			}
			case (69) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					, 2, f02b, 69}
				Store(Refof(f02b), Local3)
				Store(Refof(g00d), Local4)
			}
			case (129) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					, 2, f02c, 129}
				Store(Refof(f02c), Local3)
				Store(Refof(g00e), Local4)
			}
			case (256) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					, 2, f02d, 256}
				Store(Refof(f02d), Local3)
				Store(Refof(g000), Local4)
			}
			case (1023) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					, 2, f02e, 1023}
				Store(Refof(f02e), Local3)
				Store(Refof(g001), Local4)
			}
			case (1983) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					, 2, f02f, 1983}
				Store(Refof(f02f), Local3)
				Store(Refof(g002), Local4)
			}
			default {
				err(arg0, z144, 65, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
				Store(Refof(g003), Local4)
			}
			case (6) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
				Store(Refof(g004), Local4)
			}
			case (7) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
				Store(Refof(g005), Local4)
			}
			case (8) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
				Store(Refof(g006), Local4)
			}
			case (9) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
				Store(Refof(g007), Local4)
			}
			case (31) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
				Store(Refof(g008), Local4)
			}
			case (32) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
				Store(Refof(g009), Local4)
			}
			case (33) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
				Store(Refof(g00a), Local4)
			}
			case (63) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
				Store(Refof(g00b), Local4)
			}
			case (64) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
				Store(Refof(g00c), Local4)
			}
			case (65) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
				Store(Refof(g00d), Local4)
			}
			case (69) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
				Store(Refof(g00e), Local4)
			}
			case (129) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
				Store(Refof(g000), Local4)
			}
			case (256) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
				Store(Refof(g001), Local4)
			}
			case (1023) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
				Store(Refof(g002), Local4)
			}
			case (1983) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
				Store(Refof(g003), Local4)
			}
			default {
				err(arg0, z144, 66, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
				Store(Refof(g004), Local4)
			}
			case (6) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
				Store(Refof(g005), Local4)
			}
			case (7) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
				Store(Refof(g006), Local4)
			}
			case (8) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
				Store(Refof(g007), Local4)
			}
			case (9) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
				Store(Refof(g008), Local4)
			}
			case (31) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
				Store(Refof(g009), Local4)
			}
			case (32) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
				Store(Refof(g00a), Local4)
			}
			case (33) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
				Store(Refof(g00b), Local4)
			}
			case (63) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
				Store(Refof(g00c), Local4)
			}
			case (64) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
				Store(Refof(g00d), Local4)
			}
			case (65) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
				Store(Refof(g00e), Local4)
			}
			case (69) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
				Store(Refof(g000), Local4)
			}
			case (129) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
				Store(Refof(g001), Local4)
			}
			case (256) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
				Store(Refof(g002), Local4)
			}
			case (1023) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
				Store(Refof(g003), Local4)
			}
			case (1983) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
				Store(Refof(g004), Local4)
			}
			default {
				err(arg0, z144, 67, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
				Store(Refof(g005), Local4)
			}
			case (6) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
				Store(Refof(g006), Local4)
			}
			case (7) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
				Store(Refof(g007), Local4)
			}
			case (8) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
				Store(Refof(g008), Local4)
			}
			case (9) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
				Store(Refof(g009), Local4)
			}
			case (31) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
				Store(Refof(g00a), Local4)
			}
			case (32) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
				Store(Refof(g00b), Local4)
			}
			case (33) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
				Store(Refof(g00c), Local4)
			}
			case (63) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
				Store(Refof(g00d), Local4)
			}
			case (64) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
				Store(Refof(g00e), Local4)
			}
			case (65) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
				Store(Refof(g000), Local4)
			}
			case (69) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
				Store(Refof(g001), Local4)
			}
			case (129) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
				Store(Refof(g002), Local4)
			}
			case (256) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
				Store(Refof(g003), Local4)
			}
			case (1023) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
				Store(Refof(g004), Local4)
			}
			case (1983) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
				Store(Refof(g005), Local4)
			}
			default {
				err(arg0, z144, 68, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
				Store(Refof(g006), Local4)
			}
			case (6) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
				Store(Refof(g007), Local4)
			}
			case (7) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
				Store(Refof(g008), Local4)
			}
			case (8) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
				Store(Refof(g009), Local4)
			}
			case (9) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
				Store(Refof(g00a), Local4)
			}
			case (31) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
				Store(Refof(g00b), Local4)
			}
			case (32) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
				Store(Refof(g00c), Local4)
			}
			case (33) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
				Store(Refof(g00d), Local4)
			}
			case (63) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
				Store(Refof(g00e), Local4)
			}
			case (64) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
				Store(Refof(g000), Local4)
			}
			case (65) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
				Store(Refof(g001), Local4)
			}
			case (69) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
				Store(Refof(g002), Local4)
			}
			case (129) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
				Store(Refof(g003), Local4)
			}
			case (256) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
				Store(Refof(g004), Local4)
			}
			case (1023) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
				Store(Refof(g005), Local4)
			}
			case (1983) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
				Store(Refof(g006), Local4)
			}
			default {
				err(arg0, z144, 69, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
				Store(Refof(g007), Local4)
			}
			case (6) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
				Store(Refof(g008), Local4)
			}
			case (7) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
				Store(Refof(g009), Local4)
			}
			case (8) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
				Store(Refof(g00a), Local4)
			}
			case (9) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
				Store(Refof(g00b), Local4)
			}
			case (31) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
				Store(Refof(g00c), Local4)
			}
			case (32) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
				Store(Refof(g00d), Local4)
			}
			case (33) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
				Store(Refof(g00e), Local4)
			}
			case (63) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
				Store(Refof(g000), Local4)
			}
			case (64) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
				Store(Refof(g001), Local4)
			}
			case (65) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
				Store(Refof(g002), Local4)
			}
			case (69) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
				Store(Refof(g003), Local4)
			}
			case (129) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
				Store(Refof(g004), Local4)
			}
			case (256) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
				Store(Refof(g005), Local4)
			}
			case (1023) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
				Store(Refof(g006), Local4)
			}
			case (1983) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
				Store(Refof(g007), Local4)
			}
			default {
				err(arg0, z144, 70, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
				Store(Refof(g008), Local4)
			}
			case (6) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
				Store(Refof(g009), Local4)
			}
			case (7) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
				Store(Refof(g00a), Local4)
			}
			case (8) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
				Store(Refof(g00b), Local4)
			}
			case (9) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
				Store(Refof(g00c), Local4)
			}
			case (31) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
				Store(Refof(g00d), Local4)
			}
			case (32) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
				Store(Refof(g00e), Local4)
			}
			case (33) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
				Store(Refof(g000), Local4)
			}
			case (63) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
				Store(Refof(g001), Local4)
			}
			case (64) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
				Store(Refof(g002), Local4)
			}
			case (65) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
				Store(Refof(g003), Local4)
			}
			case (69) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
				Store(Refof(g004), Local4)
			}
			case (129) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
				Store(Refof(g005), Local4)
			}
			case (256) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
				Store(Refof(g006), Local4)
			}
			case (1023) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
				Store(Refof(g007), Local4)
			}
			case (1983) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
				Store(Refof(g008), Local4)
			}
			default {
				err(arg0, z144, 71, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
				Store(Refof(g009), Local4)
			}
			case (6) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
				Store(Refof(g00a), Local4)
			}
			case (7) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
				Store(Refof(g00b), Local4)
			}
			case (8) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
				Store(Refof(g00c), Local4)
			}
			case (9) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
				Store(Refof(g00d), Local4)
			}
			case (31) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
				Store(Refof(g00e), Local4)
			}
			case (32) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
				Store(Refof(g000), Local4)
			}
			case (33) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
				Store(Refof(g001), Local4)
			}
			case (63) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
				Store(Refof(g002), Local4)
			}
			case (64) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
				Store(Refof(g003), Local4)
			}
			case (65) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
				Store(Refof(g004), Local4)
			}
			case (69) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
				Store(Refof(g005), Local4)
			}
			case (129) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
				Store(Refof(g006), Local4)
			}
			case (256) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
				Store(Refof(g007), Local4)
			}
			case (1023) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
				Store(Refof(g008), Local4)
			}
			case (1983) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
				Store(Refof(g009), Local4)
			}
			default {
				err(arg0, z144, 72, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
				Store(Refof(g00a), Local4)
			}
			case (6) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
				Store(Refof(g00b), Local4)
			}
			case (7) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
				Store(Refof(g00c), Local4)
			}
			case (8) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
				Store(Refof(g00d), Local4)
			}
			case (9) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
				Store(Refof(g00e), Local4)
			}
			case (31) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
				Store(Refof(g000), Local4)
			}
			case (32) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
				Store(Refof(g001), Local4)
			}
			case (33) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
				Store(Refof(g002), Local4)
			}
			case (63) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
				Store(Refof(g003), Local4)
			}
			case (64) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
				Store(Refof(g004), Local4)
			}
			case (65) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
				Store(Refof(g005), Local4)
			}
			case (69) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
				Store(Refof(g006), Local4)
			}
			case (129) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
				Store(Refof(g007), Local4)
			}
			case (256) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
				Store(Refof(g008), Local4)
			}
			case (1023) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
				Store(Refof(g009), Local4)
			}
			case (1983) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
				Store(Refof(g00a), Local4)
			}
			default {
				err(arg0, z144, 73, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
				Store(Refof(g00b), Local4)
			}
			case (6) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
				Store(Refof(g00c), Local4)
			}
			case (7) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
				Store(Refof(g00d), Local4)
			}
			case (8) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
				Store(Refof(g00e), Local4)
			}
			case (9) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
				Store(Refof(g000), Local4)
			}
			case (31) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
				Store(Refof(g001), Local4)
			}
			case (32) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
				Store(Refof(g002), Local4)
			}
			case (33) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
				Store(Refof(g003), Local4)
			}
			case (63) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
				Store(Refof(g004), Local4)
			}
			case (64) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
				Store(Refof(g005), Local4)
			}
			case (65) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
				Store(Refof(g006), Local4)
			}
			case (69) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
				Store(Refof(g007), Local4)
			}
			case (129) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
				Store(Refof(g008), Local4)
			}
			case (256) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
				Store(Refof(g009), Local4)
			}
			case (1023) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1983) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
				Store(Refof(g00b), Local4)
			}
			default {
				err(arg0, z144, 74, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
				Store(Refof(g00c), Local4)
			}
			case (6) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
				Store(Refof(g00d), Local4)
			}
			case (7) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
				Store(Refof(g00e), Local4)
			}
			case (8) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
				Store(Refof(g000), Local4)
			}
			case (9) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
				Store(Refof(g001), Local4)
			}
			case (31) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
				Store(Refof(g002), Local4)
			}
			case (32) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
				Store(Refof(g003), Local4)
			}
			case (33) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
				Store(Refof(g004), Local4)
			}
			case (63) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
				Store(Refof(g005), Local4)
			}
			case (64) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
				Store(Refof(g006), Local4)
			}
			case (65) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
				Store(Refof(g007), Local4)
			}
			case (69) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
				Store(Refof(g008), Local4)
			}
			case (129) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
				Store(Refof(g009), Local4)
			}
			case (256) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1023) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1983) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
				Store(Refof(g00c), Local4)
			}
			default {
				err(arg0, z144, 75, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
				Store(Refof(g00d), Local4)
			}
			case (6) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
				Store(Refof(g00e), Local4)
			}
			case (7) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
				Store(Refof(g000), Local4)
			}
			case (8) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
				Store(Refof(g001), Local4)
			}
			case (9) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
				Store(Refof(g002), Local4)
			}
			case (31) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
				Store(Refof(g003), Local4)
			}
			case (32) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
				Store(Refof(g004), Local4)
			}
			case (33) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
				Store(Refof(g005), Local4)
			}
			case (63) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
				Store(Refof(g006), Local4)
			}
			case (64) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
				Store(Refof(g007), Local4)
			}
			case (65) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
				Store(Refof(g008), Local4)
			}
			case (69) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
				Store(Refof(g009), Local4)
			}
			case (129) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
				Store(Refof(g00a), Local4)
			}
			case (256) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1023) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1983) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
				Store(Refof(g00d), Local4)
			}
			default {
				err(arg0, z144, 76, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
				Store(Refof(g00e), Local4)
			}
			case (6) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
				Store(Refof(g000), Local4)
			}
			case (7) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
				Store(Refof(g001), Local4)
			}
			case (8) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
				Store(Refof(g002), Local4)
			}
			case (9) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
				Store(Refof(g003), Local4)
			}
			case (31) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
				Store(Refof(g004), Local4)
			}
			case (32) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
				Store(Refof(g005), Local4)
			}
			case (33) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
				Store(Refof(g006), Local4)
			}
			case (63) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
				Store(Refof(g007), Local4)
			}
			case (64) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
				Store(Refof(g008), Local4)
			}
			case (65) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
				Store(Refof(g009), Local4)
			}
			case (69) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
				Store(Refof(g00a), Local4)
			}
			case (129) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
				Store(Refof(g00b), Local4)
			}
			case (256) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1023) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1983) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
				Store(Refof(g00e), Local4)
			}
			default {
				err(arg0, z144, 77, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				IndexField(IDX1, DAT1, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				IndexField(IDX2, DAT2, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				IndexField(IDX3, DAT3, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				IndexField(IDX4, DAT4, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				IndexField(IDX5, DAT5, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				IndexField(IDX6, DAT6, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				IndexField(IDX7, DAT7, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				IndexField(IDX8, DAT8, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				IndexField(IDX9, DAT9, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				IndexField(IDXA, DATA, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				IndexField(IDXB, DATB, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				IndexField(IDXC, DATC, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				IndexField(IDXD, DATD, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				IndexField(IDXE, DATE, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				IndexField(IDX0, DAT0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z144, 78, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z144, 79, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Local4)
}

// Create IndexField Unit
// (AnyAcc, Lock, Preserve)
Method(m794, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 7000, 135)

	/*
	 * Consider different attributes of index/data fields
	 * taking into account the following restrictions:
	 * - the fields spanning the same access unit interfere,
	 * - the fields exceeding 64 bits cause AE_BUFFER_OVERFLOW,
	 * - index field exceeding 32 bits unexpectedly cause
	 *   AE_BUFFER_OVERFLOW too,
	 * - data field exceeding IndexField's Access Width
	 *   causes overwriting of next memory bytes.
	 */

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		IDX0, 8,
		DAT0, 8,
	}
	IndexField(IDX0, DAT0, ByteAcc, NoLock, Preserve) {
		g000, 2048,
	}

	Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
		Offset(3),
		IDX1, 8,
		DAT1, 8,
	}
	IndexField(IDX1, DAT1, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
		Offset(7),
		IDX2, 16,
		DAT2, 8,
	}
	IndexField(IDX2, DAT2, ByteAcc, NoLock, Preserve) {
		g002, 2048,
	}

	Field(OPR0, WordAcc, NoLock, Preserve) {
		Offset(11),
		IDX3, 8,
		DAT3, 8,
	}
	IndexField(IDX3, DAT3, ByteAcc, NoLock, Preserve) {
		g003, 2048,
	}

	Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
		Offset(14),
		IDX4, 16,
		DAT4, 8,
	}
	IndexField(IDX4, DAT4, ByteAcc, NoLock, Preserve) {
		g004, 2048,
	}

	Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
		Offset(18),
		IDX5, 32,
		DAT5, 8,
	}
	IndexField(IDX5, DAT5, ByteAcc, NoLock, Preserve) {
		g005, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, Preserve) {
		Offset(26),
		IDX6, 8,
		Offset(28),
		DAT6, 8,
	}
	IndexField(IDX6, DAT6, ByteAcc, NoLock, Preserve) {
		g006, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
		Offset(32),
		IDX7, 32,
		DAT7, 8,
	}
	IndexField(IDX7, DAT7, ByteAcc, NoLock, Preserve) {
		g007, 2048,
	}

	Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
		Offset(40),
		IDX8, 32,
		DAT8, 8,
	}
	IndexField(IDX8, DAT8, ByteAcc, NoLock, Preserve) {
		g008, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, Preserve) {
		Offset(56),
		IDX9, 8,
		Offset(64),
		DAT9, 8,
	}
	IndexField(IDX9, DAT9, ByteAcc, NoLock, Preserve) {
		g009, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
		Offset(72),
		// Index field exceeding 32 bits causes AE_BUFFER_OVERFLOW
		// IDXA, 64,
		// Do not allow index/data interference
		, 32, IDXA, 32,
		DATA, 8,
	}
	IndexField(IDXA, DATA, ByteAcc, NoLock, Preserve) {
		g00a, 2048,
	}

	Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
		Offset(88),
		IDXB, 32,
		Offset(96),
		DATB, 8,
	}
	IndexField(IDXB, DATB, ByteAcc, NoLock, Preserve) {
		g00b, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, Preserve) {
		Offset(104),
		IDXC, 8,
		DATC, 8,
	}
	IndexField(IDXC, DATC, ByteAcc, NoLock, Preserve) {
		g00c, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
		Offset(107),
		// Index field exceeding 32 bits causes AE_BUFFER_OVERFLOW
		// IDXD, 64,
		IDXD, 32,
		DATD, 8,
	}
	IndexField(IDXD, DATD, ByteAcc, NoLock, Preserve) {
		g00d, 2048,
	}

	Field(OPR0, AnyAcc, NoLock, WriteAsZeros) {
		Offset(123),
		IDXE, 32,
		DATE, 8,
	}
	IndexField(IDXE, DATE, ByteAcc, NoLock, Preserve) {
		g00e, 2048,
	}

	Concatenate(arg0, "-m794", arg0)

BreakPoint

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z144, 80, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f010, 1}
				Store(Refof(f010), Local3)
				Store(Refof(g001), Local4)
			}
			case (6) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f011, 6}
				Store(Refof(f011), Local3)
				Store(Refof(g002), Local4)
			}
			case (7) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f012, 7}
				Store(Refof(f012), Local3)
				Store(Refof(g003), Local4)
			}
			case (8) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f013, 8}
				Store(Refof(f013), Local3)
				Store(Refof(g004), Local4)
			}
			case (9) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f014, 9}
				Store(Refof(f014), Local3)
				Store(Refof(g005), Local4)
			}
			case (31) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f015, 31}
				Store(Refof(f015), Local3)
				Store(Refof(g006), Local4)
			}
			case (32) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f016, 32}
				Store(Refof(f016), Local3)
				Store(Refof(g007), Local4)
			}
			case (33) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f017, 33}
				Store(Refof(f017), Local3)
				Store(Refof(g008), Local4)
			}
			case (63) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f018, 63}
				Store(Refof(f018), Local3)
				Store(Refof(g009), Local4)
			}
			case (64) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f019, 64}
				Store(Refof(f019), Local3)
				Store(Refof(g00a), Local4)
			}
			case (65) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f01a, 65}
				Store(Refof(f01a), Local3)
				Store(Refof(g00b), Local4)
			}
			case (69) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f01b, 69}
				Store(Refof(f01b), Local3)
				Store(Refof(g00c), Local4)
			}
			case (129) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f01c, 129}
				Store(Refof(f01c), Local3)
				Store(Refof(g00d), Local4)
			}
			case (256) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f01d, 256}
				Store(Refof(f01d), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1023) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f01e, 1023}
				Store(Refof(f01e), Local3)
				Store(Refof(g000), Local4)
			}
			case (1983) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					Offset(0), , 1, f01f, 1983}
				Store(Refof(f01f), Local3)
				Store(Refof(g001), Local4)
			}
			default {
				err(arg0, z144, 81, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					, 2, f020, 1}
				Store(Refof(f020), Local3)
				Store(Refof(g002), Local4)
			}
			case (6) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					, 2, f021, 6}
				Store(Refof(f021), Local3)
				Store(Refof(g003), Local4)
			}
			case (7) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					, 2, f022, 7}
				Store(Refof(f022), Local3)
				Store(Refof(g004), Local4)
			}
			case (8) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					, 2, f023, 8}
				Store(Refof(f023), Local3)
				Store(Refof(g005), Local4)
			}
			case (9) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					, 2, f024, 9}
				Store(Refof(f024), Local3)
				Store(Refof(g006), Local4)
			}
			case (31) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					, 2, f025, 31}
				Store(Refof(f025), Local3)
				Store(Refof(g007), Local4)
			}
			case (32) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					, 2, f026, 32}
				Store(Refof(f026), Local3)
				Store(Refof(g008), Local4)
			}
			case (33) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					, 2, f027, 33}
				Store(Refof(f027), Local3)
				Store(Refof(g009), Local4)
			}
			case (63) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					, 2, f028, 63}
				Store(Refof(f028), Local3)
				Store(Refof(g00a), Local4)
			}
			case (64) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					, 2, f029, 64}
				Store(Refof(f029), Local3)
				Store(Refof(g00b), Local4)
			}
			case (65) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					, 2, f02a, 65}
				Store(Refof(f02a), Local3)
				Store(Refof(g00c), Local4)
			}
			case (69) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					, 2, f02b, 69}
				Store(Refof(f02b), Local3)
				Store(Refof(g00d), Local4)
			}
			case (129) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					, 2, f02c, 129}
				Store(Refof(f02c), Local3)
				Store(Refof(g00e), Local4)
			}
			case (256) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					, 2, f02d, 256}
				Store(Refof(f02d), Local3)
				Store(Refof(g000), Local4)
			}
			case (1023) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					, 2, f02e, 1023}
				Store(Refof(f02e), Local3)
				Store(Refof(g001), Local4)
			}
			case (1983) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					, 2, f02f, 1983}
				Store(Refof(f02f), Local3)
				Store(Refof(g002), Local4)
			}
			default {
				err(arg0, z144, 82, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
				Store(Refof(g003), Local4)
			}
			case (6) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
				Store(Refof(g004), Local4)
			}
			case (7) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
				Store(Refof(g005), Local4)
			}
			case (8) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
				Store(Refof(g006), Local4)
			}
			case (9) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
				Store(Refof(g007), Local4)
			}
			case (31) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
				Store(Refof(g008), Local4)
			}
			case (32) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
				Store(Refof(g009), Local4)
			}
			case (33) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
				Store(Refof(g00a), Local4)
			}
			case (63) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
				Store(Refof(g00b), Local4)
			}
			case (64) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
				Store(Refof(g00c), Local4)
			}
			case (65) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
				Store(Refof(g00d), Local4)
			}
			case (69) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
				Store(Refof(g00e), Local4)
			}
			case (129) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
				Store(Refof(g000), Local4)
			}
			case (256) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
				Store(Refof(g001), Local4)
			}
			case (1023) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
				Store(Refof(g002), Local4)
			}
			case (1983) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
				Store(Refof(g003), Local4)
			}
			default {
				err(arg0, z144, 83, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
				Store(Refof(g004), Local4)
			}
			case (6) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
				Store(Refof(g005), Local4)
			}
			case (7) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
				Store(Refof(g006), Local4)
			}
			case (8) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
				Store(Refof(g007), Local4)
			}
			case (9) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
				Store(Refof(g008), Local4)
			}
			case (31) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
				Store(Refof(g009), Local4)
			}
			case (32) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
				Store(Refof(g00a), Local4)
			}
			case (33) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
				Store(Refof(g00b), Local4)
			}
			case (63) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
				Store(Refof(g00c), Local4)
			}
			case (64) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
				Store(Refof(g00d), Local4)
			}
			case (65) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
				Store(Refof(g00e), Local4)
			}
			case (69) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
				Store(Refof(g000), Local4)
			}
			case (129) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
				Store(Refof(g001), Local4)
			}
			case (256) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
				Store(Refof(g002), Local4)
			}
			case (1023) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
				Store(Refof(g003), Local4)
			}
			case (1983) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
				Store(Refof(g004), Local4)
			}
			default {
				err(arg0, z144, 84, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
				Store(Refof(g005), Local4)
			}
			case (6) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
				Store(Refof(g006), Local4)
			}
			case (7) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
				Store(Refof(g007), Local4)
			}
			case (8) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
				Store(Refof(g008), Local4)
			}
			case (9) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
				Store(Refof(g009), Local4)
			}
			case (31) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
				Store(Refof(g00a), Local4)
			}
			case (32) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
				Store(Refof(g00b), Local4)
			}
			case (33) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
				Store(Refof(g00c), Local4)
			}
			case (63) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
				Store(Refof(g00d), Local4)
			}
			case (64) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
				Store(Refof(g00e), Local4)
			}
			case (65) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
				Store(Refof(g000), Local4)
			}
			case (69) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
				Store(Refof(g001), Local4)
			}
			case (129) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
				Store(Refof(g002), Local4)
			}
			case (256) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
				Store(Refof(g003), Local4)
			}
			case (1023) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
				Store(Refof(g004), Local4)
			}
			case (1983) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
				Store(Refof(g005), Local4)
			}
			default {
				err(arg0, z144, 85, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
				Store(Refof(g006), Local4)
			}
			case (6) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
				Store(Refof(g007), Local4)
			}
			case (7) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
				Store(Refof(g008), Local4)
			}
			case (8) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
				Store(Refof(g009), Local4)
			}
			case (9) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
				Store(Refof(g00a), Local4)
			}
			case (31) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
				Store(Refof(g00b), Local4)
			}
			case (32) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
				Store(Refof(g00c), Local4)
			}
			case (33) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
				Store(Refof(g00d), Local4)
			}
			case (63) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
				Store(Refof(g00e), Local4)
			}
			case (64) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
				Store(Refof(g000), Local4)
			}
			case (65) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
				Store(Refof(g001), Local4)
			}
			case (69) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
				Store(Refof(g002), Local4)
			}
			case (129) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
				Store(Refof(g003), Local4)
			}
			case (256) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
				Store(Refof(g004), Local4)
			}
			case (1023) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
				Store(Refof(g005), Local4)
			}
			case (1983) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
				Store(Refof(g006), Local4)
			}
			default {
				err(arg0, z144, 86, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
				Store(Refof(g007), Local4)
			}
			case (6) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
				Store(Refof(g008), Local4)
			}
			case (7) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
				Store(Refof(g009), Local4)
			}
			case (8) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
				Store(Refof(g00a), Local4)
			}
			case (9) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
				Store(Refof(g00b), Local4)
			}
			case (31) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
				Store(Refof(g00c), Local4)
			}
			case (32) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
				Store(Refof(g00d), Local4)
			}
			case (33) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
				Store(Refof(g00e), Local4)
			}
			case (63) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
				Store(Refof(g000), Local4)
			}
			case (64) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
				Store(Refof(g001), Local4)
			}
			case (65) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
				Store(Refof(g002), Local4)
			}
			case (69) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
				Store(Refof(g003), Local4)
			}
			case (129) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
				Store(Refof(g004), Local4)
			}
			case (256) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
				Store(Refof(g005), Local4)
			}
			case (1023) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
				Store(Refof(g006), Local4)
			}
			case (1983) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
				Store(Refof(g007), Local4)
			}
			default {
				err(arg0, z144, 87, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
				Store(Refof(g008), Local4)
			}
			case (6) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
				Store(Refof(g009), Local4)
			}
			case (7) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
				Store(Refof(g00a), Local4)
			}
			case (8) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
				Store(Refof(g00b), Local4)
			}
			case (9) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
				Store(Refof(g00c), Local4)
			}
			case (31) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
				Store(Refof(g00d), Local4)
			}
			case (32) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
				Store(Refof(g00e), Local4)
			}
			case (33) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
				Store(Refof(g000), Local4)
			}
			case (63) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
				Store(Refof(g001), Local4)
			}
			case (64) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
				Store(Refof(g002), Local4)
			}
			case (65) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
				Store(Refof(g003), Local4)
			}
			case (69) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
				Store(Refof(g004), Local4)
			}
			case (129) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
				Store(Refof(g005), Local4)
			}
			case (256) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
				Store(Refof(g006), Local4)
			}
			case (1023) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
				Store(Refof(g007), Local4)
			}
			case (1983) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
				Store(Refof(g008), Local4)
			}
			default {
				err(arg0, z144, 88, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
				Store(Refof(g009), Local4)
			}
			case (6) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
				Store(Refof(g00a), Local4)
			}
			case (7) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
				Store(Refof(g00b), Local4)
			}
			case (8) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
				Store(Refof(g00c), Local4)
			}
			case (9) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
				Store(Refof(g00d), Local4)
			}
			case (31) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
				Store(Refof(g00e), Local4)
			}
			case (32) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
				Store(Refof(g000), Local4)
			}
			case (33) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
				Store(Refof(g001), Local4)
			}
			case (63) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
				Store(Refof(g002), Local4)
			}
			case (64) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
				Store(Refof(g003), Local4)
			}
			case (65) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
				Store(Refof(g004), Local4)
			}
			case (69) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
				Store(Refof(g005), Local4)
			}
			case (129) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
				Store(Refof(g006), Local4)
			}
			case (256) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
				Store(Refof(g007), Local4)
			}
			case (1023) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
				Store(Refof(g008), Local4)
			}
			case (1983) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
				Store(Refof(g009), Local4)
			}
			default {
				err(arg0, z144, 89, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
				Store(Refof(g00a), Local4)
			}
			case (6) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
				Store(Refof(g00b), Local4)
			}
			case (7) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
				Store(Refof(g00c), Local4)
			}
			case (8) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
				Store(Refof(g00d), Local4)
			}
			case (9) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
				Store(Refof(g00e), Local4)
			}
			case (31) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
				Store(Refof(g000), Local4)
			}
			case (32) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
				Store(Refof(g001), Local4)
			}
			case (33) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
				Store(Refof(g002), Local4)
			}
			case (63) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
				Store(Refof(g003), Local4)
			}
			case (64) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
				Store(Refof(g004), Local4)
			}
			case (65) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
				Store(Refof(g005), Local4)
			}
			case (69) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
				Store(Refof(g006), Local4)
			}
			case (129) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
				Store(Refof(g007), Local4)
			}
			case (256) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
				Store(Refof(g008), Local4)
			}
			case (1023) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
				Store(Refof(g009), Local4)
			}
			case (1983) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
				Store(Refof(g00a), Local4)
			}
			default {
				err(arg0, z144, 90, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
				Store(Refof(g00b), Local4)
			}
			case (6) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
				Store(Refof(g00c), Local4)
			}
			case (7) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
				Store(Refof(g00d), Local4)
			}
			case (8) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
				Store(Refof(g00e), Local4)
			}
			case (9) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
				Store(Refof(g000), Local4)
			}
			case (31) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
				Store(Refof(g001), Local4)
			}
			case (32) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
				Store(Refof(g002), Local4)
			}
			case (33) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
				Store(Refof(g003), Local4)
			}
			case (63) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
				Store(Refof(g004), Local4)
			}
			case (64) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
				Store(Refof(g005), Local4)
			}
			case (65) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
				Store(Refof(g006), Local4)
			}
			case (69) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
				Store(Refof(g007), Local4)
			}
			case (129) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
				Store(Refof(g008), Local4)
			}
			case (256) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
				Store(Refof(g009), Local4)
			}
			case (1023) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1983) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
				Store(Refof(g00b), Local4)
			}
			default {
				err(arg0, z144, 91, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
				Store(Refof(g00c), Local4)
			}
			case (6) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
				Store(Refof(g00d), Local4)
			}
			case (7) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
				Store(Refof(g00e), Local4)
			}
			case (8) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
				Store(Refof(g000), Local4)
			}
			case (9) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
				Store(Refof(g001), Local4)
			}
			case (31) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
				Store(Refof(g002), Local4)
			}
			case (32) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
				Store(Refof(g003), Local4)
			}
			case (33) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
				Store(Refof(g004), Local4)
			}
			case (63) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
				Store(Refof(g005), Local4)
			}
			case (64) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
				Store(Refof(g006), Local4)
			}
			case (65) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
				Store(Refof(g007), Local4)
			}
			case (69) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
				Store(Refof(g008), Local4)
			}
			case (129) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
				Store(Refof(g009), Local4)
			}
			case (256) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1023) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1983) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
				Store(Refof(g00c), Local4)
			}
			default {
				err(arg0, z144, 92, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
				Store(Refof(g00d), Local4)
			}
			case (6) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
				Store(Refof(g00e), Local4)
			}
			case (7) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
				Store(Refof(g000), Local4)
			}
			case (8) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
				Store(Refof(g001), Local4)
			}
			case (9) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
				Store(Refof(g002), Local4)
			}
			case (31) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
				Store(Refof(g003), Local4)
			}
			case (32) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
				Store(Refof(g004), Local4)
			}
			case (33) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
				Store(Refof(g005), Local4)
			}
			case (63) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
				Store(Refof(g006), Local4)
			}
			case (64) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
				Store(Refof(g007), Local4)
			}
			case (65) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
				Store(Refof(g008), Local4)
			}
			case (69) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
				Store(Refof(g009), Local4)
			}
			case (129) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
				Store(Refof(g00a), Local4)
			}
			case (256) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1023) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1983) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
				Store(Refof(g00d), Local4)
			}
			default {
				err(arg0, z144, 93, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
				Store(Refof(g00e), Local4)
			}
			case (6) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
				Store(Refof(g000), Local4)
			}
			case (7) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
				Store(Refof(g001), Local4)
			}
			case (8) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
				Store(Refof(g002), Local4)
			}
			case (9) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
				Store(Refof(g003), Local4)
			}
			case (31) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
				Store(Refof(g004), Local4)
			}
			case (32) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
				Store(Refof(g005), Local4)
			}
			case (33) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
				Store(Refof(g006), Local4)
			}
			case (63) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
				Store(Refof(g007), Local4)
			}
			case (64) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
				Store(Refof(g008), Local4)
			}
			case (65) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
				Store(Refof(g009), Local4)
			}
			case (69) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
				Store(Refof(g00a), Local4)
			}
			case (129) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
				Store(Refof(g00b), Local4)
			}
			case (256) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1023) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1983) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
				Store(Refof(g00e), Local4)
			}
			default {
				err(arg0, z144, 94, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				IndexField(IDX1, DAT1, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				IndexField(IDX2, DAT2, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				IndexField(IDX3, DAT3, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				IndexField(IDX4, DAT4, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				IndexField(IDX5, DAT5, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				IndexField(IDX6, DAT6, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				IndexField(IDX7, DAT7, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				IndexField(IDX8, DAT8, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				IndexField(IDX9, DAT9, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				IndexField(IDXA, DATA, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				IndexField(IDXB, DATB, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				IndexField(IDXC, DATC, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				IndexField(IDXD, DATD, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				IndexField(IDXE, DATE, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				IndexField(IDX0, DAT0, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z144, 95, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z144, 100, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Local4)
}

// Run-method
Method(IFC0,, Serialized)
{
	Name(ts, "IFC0")

	SRMT("m770")
	m770(ts)

	// Access to 1-bit IndexFields, ByteAcc
	SRMT("m771")
    m771(ts)

	// Access to 1-bit IndexFields, WordAcc
	SRMT("m772")
    m772(ts)

	// Access to 1-bit IndexFields, DWordAcc
	SRMT("m773")
    m773(ts)

	// Access to 1-bit IndexFields, QWordAcc
	SRMT("m774")
	if (y215) {
		m774(ts)
	} else {
		BLCK()
	}

	// Splitting of IndexFields
	SRMT("m775")
    m775(ts)

	// Check IndexField access: ByteAcc, NoLock, Preserve
	SRMT("m776")
	if (y224) {
		m776(ts)
	} else {
		BLCK()
	}

	// Check IndexField access: WordAcc, NoLock, WriteAsOnes
	SRMT("m777")
	if (y224) {
		m777(ts)
	} else {
		BLCK()
	}

	// Check IndexField access: DWordAcc, NoLock, WriteAsZeros
	SRMT("m778")
	if (y224) {
		m778(ts)
	} else {
		BLCK()
	}

	// Check IndexField access: QWordAcc, NoLock, Preserve
	SRMT("m779")
	if (y224) {
		m779(ts)
	} else {
		BLCK()
	}

	// Check IndexField access: AnyAcc, Lock, Preserve
	SRMT("m77a")
	if (y224) {
		m77a(ts)
	} else {
		BLCK()
	}
}
