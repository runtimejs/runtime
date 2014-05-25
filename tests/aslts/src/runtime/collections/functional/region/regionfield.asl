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
 * Region Field objects definition and processing
 */

/*
 * On testing following issues should be covered:
 * - Operation Regions of different Region Space types application
 *   for Field objects definition,
 * - application of any allowed AccessType Keywords,
 * - application of any allowed LockRule Keywords,
 * - application of any allowed UpdateRule Keywords,
 * - application of the Offset macros in the FieldUnitList,
 * - application of the AccessAs macros in the FieldUnitList,
 * - on writing taking into account the Access Type in accord with
     the Update Rule,
 * - splitting of an field causes appropriate splitting of the spanned bits,
 * - AccessAs macros influence on the remaining FieldUnits within the list,
 * - integer/buffer representation of the Unit contents as depends on its
 *   Length and DSDT ComplianceRevision (32/64-bit Integer),
 * - Data Type Conversion Rules on storing to Region Fields.
 *
 * Can not be tested following issues:
 * - exact use of given Access Type alignment on Access to Field data,
 * - exact use of specific Conversion Rules on storing of Buffers or Strings.
 */

Name(z143, 143)

Name(RS00, 256)

// Generated benchmark buffers for comparison with

Name(br10, Buffer(RS00) {})
Name(br01, Buffer(RS00) {})
Name(brB0, Buffer(RS00) {})

// Buffer for filling the ground

Name(brG0, Buffer(RS00) {})

// Buffer for filling the field (over the ground)

Name(brF0, Buffer(RS00) {})

// Tested field unit offsets
Name(pfuo, Package(16) {0, 1, 2, 3, 4, 5, 6, 7, 8 ,9, 31, 32, 33, 63, 64, 65})

// Tested field unit length
Name(pful, Package(16) {1, 6, 7, 8, 9, 31, 32, 33, 63, 64, 65, 69, 129, 256, 1023, 1983})

// Dynamic Field test Control parameters Package
// Layout of Package:
// - <control flag>: 0 - none, 1 - IndexField, 2 - BankField,
// - <Refof to Field>,
// - <Benchmark value>
Name(fcp0, Package(3) {0})

// Testing parameters Packages
// Layout of Package:
// - <index of first offset>,
// - <num of offsets>,
// - <index of first length>,
// - <num of lengths>,
// - <testing parameters package>:
//    - opcode of buffer to fill the ground
//    - opcode of buffer to fill the field
//      Opcodes of buffers:
//        0 - all zeros
//        1 - all units
//        2 - some mix
//    - Access Type opcode
//        0 - AnyAcc, 1 - ByteAcc, 2 - WordAcc,
//        3 - DWordAcc, 4 - QWordAcc, 5 - BufferAcc
//    - Update Rule opcode
//        0 - Preserve, 1 - WriteAsOnes, 2 - WriteAsZeros
//    - Lock Rule opcode
//        0 - Lock, 1 - NoLock
//    - Method implementing creation of fields

// ByteAcc, NoLock, Preserve
Name(pp00, Package() {
// examines the whole range possible for the field's
// (off, len) in the underlying 256-byte Region:
		0, 4, 0, 4, Package(6){0, 1, 1, 0, 1, "m730"},
})

// ByteAcc, NoLock, WriteAsOnes
Name(pp01, Package() {
		0, 4, 4, 4, Package(6){0, 1, 1, 1, 1, "m731"},
})

// ByteAcc, NoLock, WriteAsZeros
Name(pp02, Package() {
		0, 4, 8, 4, Package(6){0, 2, 1, 2, 1, "m732"},
})

// WordAcc, NoLock, Preserve
Name(pp03, Package() {
		0, 4, 12, 4, Package(6){1, 0, 2, 0, 1, "m733"},
})

// WordAcc, NoLock, WriteAsOnes
Name(pp04, Package() {
		4, 4, 0, 4, Package(6){1, 0, 2, 1, 1, "m734"},
})

// WordAcc, NoLock, WriteAsZeros
Name(pp05, Package() {
		4, 4, 4, 4, Package(6){1, 2, 2, 2, 1, "m735"},
})

// DWordAcc, NoLock, Preserve
Name(pp06, Package() {
		4, 4, 8, 4, Package(6){2, 0, 3, 0, 1, "m736"},
})

// DWordAcc, NoLock, WriteAsOnes
Name(pp07, Package() {
		4, 4, 12, 4, Package(6){2, 1, 3, 1, 1, "m737"},
})

// DWordAcc, NoLock, WriteAsZeros
Name(pp08, Package() {
		8, 4, 0, 4, Package(6){2, 1, 3, 2, 1, "m738"},
})

// QWordAcc, NoLock, Preserve
Name(pp09, Package() {
		8, 4, 4, 4, Package(6){2, 0, 4, 0, 1, "m739"},
})

// QWordAcc, NoLock, WriteAsOnes
Name(pp0a, Package() {
		8, 4, 8, 4, Package(6){0, 1, 4, 1, 1, "m73a"},
})

// QWordAcc, NoLock, WriteAsZeros
Name(pp0b, Package() {
		8, 4, 12, 4, Package(6){0, 2, 4, 2, 1, "m73b"},
})

// AnyAcc, NoLock, Preserve
Name(pp0c, Package() {
		12, 4, 0, 4, Package(6){1, 0, 0, 0, 1, "m73c"},
})

// AnyAcc, NoLock, WriteAsOnes
Name(pp0d, Package() {
		12, 4, 4, 4, Package(6){2, 1, 0, 1, 1, "m73d"},
})

// AnyAcc, Lock, WriteAsZeros
Name(pp0e, Package() {
		12, 4, 8, 8, Package(6){1, 2, 0, 2, 0, "m73e"},
})

// Check common access: ByteAcc, NoLock, Preserve
// m710(CallChain)
// CallChain: String
Method(m710, 1)
{
	Concatenate(arg0, "-m710", arg0)

	Store("TEST: m710, Check Region Fields specified as (ByteAcc, NoLock, Preserve)", Debug)

	m72f(arg0, 1, "pp00", pp00)
}

// Check common access: ByteAcc, NoLock, WriteAsOnes
// m711(CallChain)
// CallChain: String
Method(m711, 1)
{
	Concatenate(arg0, "-m711", arg0)

	Store("TEST: m711, Check Region Fields specified as (ByteAcc, NoLock, WriteAsOnes)", Debug)

	m72f(arg0, 1, "pp01", pp01)
}

// Check common access: ByteAcc, NoLock, WriteAsZeros
// m712(CallChain)
// CallChain: String
Method(m712, 1)
{
	Concatenate(arg0, "-m712", arg0)

	Store("TEST: m712, Check Region Fields specified as (ByteAcc, NoLock, WriteAsZeros)", Debug)

	m72f(arg0, 1, "pp02", pp02)
}

// Check common access: WordAcc, NoLock, Preserve
// m713(CallChain)
// CallChain: String
Method(m713, 1)
{
	Concatenate(arg0, "-m713", arg0)

	Store("TEST: m713, Check Region Fields specified as (WordAcc, NoLock, Preserve)", Debug)

	m72f(arg0, 1, "pp03", pp03)
}

// Check common access: WordAcc, NoLock, WriteAsOnes
// m714(CallChain)
// CallChain: String
Method(m714, 1)
{
	Concatenate(arg0, "-m714", arg0)

	Store("TEST: m714, Check Region Fields specified as (WordAcc, NoLock, WriteAsOnes)", Debug)

	m72f(arg0, 1, "pp04", pp04)
}

// Check common access: WordAcc, NoLock, WriteAsZeros
// m715(CallChain)
// CallChain: String
Method(m715, 1)
{
	Concatenate(arg0, "-m715", arg0)

	Store("TEST: m715, Check Region Fields specified as (WordAcc, NoLock, WriteAsZeros)", Debug)

	m72f(arg0, 1, "pp05", pp05)
}

// Check common access: DWordAcc, NoLock, Preserve
// m716(CallChain)
// CallChain: String
Method(m716, 1)
{
	Concatenate(arg0, "-m716", arg0)

	Store("TEST: m716, Check Region Fields specified as (DWordAcc, NoLock, Preserve)", Debug)

	m72f(arg0, 1, "pp06", pp06)
}

// Check common access: DWordAcc, NoLock, WriteAsOnes
// m717(CallChain)
// CallChain: String
Method(m717, 1)
{
	Concatenate(arg0, "-m717", arg0)

	Store("TEST: m717, Check Region Fields specified as (DWordAcc, NoLock, WriteAsOnes)", Debug)

	m72f(arg0, 1, "pp07", pp07)
}


// Check common access: DWordAcc, NoLock, WriteAsZeros
// m718(CallChain)
// CallChain: String
Method(m718, 1)
{
	Concatenate(arg0, "-m718", arg0)

	Store("TEST: m718, Check Region Fields specified as (DWordAcc, NoLock, WriteAsZeros)", Debug)

	m72f(arg0, 1, "pp08", pp08)
}

// Check common access: QWordAcc, NoLock, Preserve
// m719(CallChain)
// CallChain: String
Method(m719, 1)
{
	Concatenate(arg0, "-m719", arg0)

	Store("TEST: m719, Check Region Fields specified as (QWordAcc, NoLock, Preserve)", Debug)

	m72f(arg0, 1, "pp09", pp09)
}

// Check common access: QWordAcc, NoLock, WriteAsOnes
// m71a(CallChain)
// CallChain: String
Method(m71a, 1)
{
	Concatenate(arg0, "-m71a", arg0)

	Store("TEST: m71a, Check Region Fields specified as (QWordAcc, NoLock, WriteAsOnes)", Debug)

	m72f(arg0, 1, "pp0a", pp0a)
}

// Check common access: QWordAcc, NoLock, WriteAsZeros
// m71b(CallChain)
// CallChain: String
Method(m71b, 1)
{
	Concatenate(arg0, "-m71b", arg0)

	Store("TEST: m71b, Check Region Fields specified as (QWordAcc, NoLock, WriteAsZeros)", Debug)

	m72f(arg0, 1, "pp0b", pp0b)
}

// Check common access: AnyAcc, NoLock, Preserve
// m71c(CallChain)
// CallChain: String
Method(m71c, 1)
{
	Concatenate(arg0, "-m71c", arg0)

	Store("TEST: m71c, Check Region Fields specified as (AnyAcc, NoLock, Preserve)", Debug)

	m72f(arg0, 1, "pp0c", pp0c)
}

// Check common access: AnyAcc, NoLock, WriteAsOnes
// m71d(CallChain)
// CallChain: String
Method(m71d, 1)
{
	Concatenate(arg0, "-m71d", arg0)

	Store("TEST: m71d, Check Region Fields specified as (AnyAcc, NoLock, WriteAsOnes)", Debug)

	m72f(arg0, 1, "pp0d", pp0d)
}

// Check common access: AnyAcc, Lock, WriteAsZeros
// m71e(CallChain)
// CallChain: String
Method(m71e, 1)
{
	Concatenate(arg0, "-m71e", arg0)

	Store("TEST: m71e, Check Region Fields specified as (AnyAcc, Lock, WriteAsZeros)", Debug)

	m72f(arg0, 1, "pp0e", pp0e)
}

// Check BufferAcc access for SMBus
// m71f(CallChain)
// CallChain: String
Method(m71f, 1)
{
	Concatenate(arg0, "-m71f", arg0)

	Store("TEST: m71f, Check SMBus Region Fields (BufferAcc access)", Debug)

	/*
	 * Examples from Acpi Spec (chapter 13.7 Using the SMBus Protocols)
	 */

	// Read/Write Quick (SMBQuick)
	m751(arg0)

	// Send/Receive Byte (SMBSendReceive)
	m752(arg0)

	// Read/Write Byte (SMBByte)
	m753(arg0)

	// Read/Write Word (SMBWord)
	m754(arg0)

	// Read/Write Block (SMBBlock)
	m755(arg0)

	// Word Process Call (SMBProcessCall)
	m756(arg0)

	// Block Process Call (SMBBlockProcessCall)
	m757(arg0)
}

// Read/Write Quick (SMBQuick)
// m751(CallChain)
// CallChain: String
Method(m751, 1, Serialized)
{
	Concatenate(arg0, "-m751", arg0)

	OperationRegion(SMBD, SMBus, 0x4200, 0x100)

	Field(SMBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, SMBQuick),	// Use the SMBus Read/Write Quick protocol
		FLD0, 8}						// Virtual register at command value 0.

	/* Create the SMBus data buffer */
	Name(BUFF, Buffer(34){})			// Create SMBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create SMBus result buffer
	CreateByteField(BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField(BUFF, 0x01, LEN0)	// Length (Byte)
	CreateByteField(BUFF, 0x02, DAT0)
	CreateByteField(BUFR, 0x00, OB11)
	CreateByteField(BUFR, 0x01, LEN1)
	CreateByteField(BUFR, 0x02, DAT1)

	/* Signal device (e.g. ON) */
	Store(Store(BUFF, FLD0), BUFR)		// Invoke Write Quick transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 4, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x00)) {
		err(arg0, z143, 8, 0, 0, LEN0, 0x00)
	}
	if (LNotEqual(DAT0, 0x00)) {
		err(arg0, z143, 12, 0, 0, DAT0, 0x00)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 16, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x00)) {
		err(arg0, z143, 20, 0, 0, LEN1, 0x00)
	}
	if (LNotEqual(DAT1, 0x00)) {
		err(arg0, z143, 24, 0, 0, DAT1, 0x00)
	}

	Store(0x00, OB10)
	Store(0xff, LEN0)
	Store(0x00, DAT0)

	/* Signal device (e.g. OFF) */
	Store(FLD0, BUFF)					// Invoke Read Quick transaction

	if (LNotEqual(OB10, 0x7A)) {
		err(arg0, z143, 28, 0, 0, OB10, 0x7A)
	}
	if (LNotEqual(LEN0, 0x01)) {
		err(arg0, z143, 32, 0, 0, LEN0, 0x01)
	}
	if (LNotEqual(DAT0, 0xA0)) {
		err(arg0, z143, 36, 0, 0, DAT0, 0xA0)
	}
}

// Read/Write Quick (SMBQuick)
// m752(CallChain)
// CallChain: String
Method(m752, 1, Serialized)
{
	Concatenate(arg0, "-m752", arg0)

	OperationRegion(SMBD, SMBus, 0x4200, 0x100)

	Field(SMBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, SMBSendReceive),// Use the SMBus Send/Receive Byte protocol
		FLD0, 8}							// Virtual register at command value 0.

	/* Create the SMBus data buffer */
	Name(BUFF, Buffer(34){})			// Create SMBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create SMBus result buffer
	CreateByteField(BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField(BUFF, 0x01, LEN0)	// Length (Byte)
	CreateByteField(BUFF, 0x02, DAT0)
	CreateByteField(BUFR, 0x00, OB11)
	CreateByteField(BUFR, 0x01, LEN1)
	CreateByteField(BUFR, 0x02, DAT1)

	/* Send the byte '0x16' to the device */
	Store(0x00, OB10)
	Store(0x00, LEN0)
	Store(0x16, DAT0)					// Save 0x16 into the data buffer
	Store(Store(BUFF, FLD0), BUFR)		// Invoke a Send Byte transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 40, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x00)) {
		err(arg0, z143, 44, 0, 0, LEN0, 0x00)
	}
	if (LNotEqual(DAT0, 0x16)) {
		err(arg0, z143, 48, 0, 0, DAT0, 0x16)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 52, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x00)) {
		err(arg0, z143, 56, 0, 0, LEN1, 0x00)
	}
	if (LNotEqual(DAT1, 0x16)) {
		err(arg0, z143, 60, 0, 0, DAT1, 0x00)
	}

	/* Receive a byte of data from the device */
	Store(FLD0, BUFF)					// Invoke a Receive Byte transaction

	if (LNotEqual(OB10, 0x7A)) {
		err(arg0, z143, 64, 0, 0, OB10, 0x7A)
	}
	if (LNotEqual(LEN0, 0x01)) {
		err(arg0, z143, 68, 0, 0, LEN0, 0x01)
	}
	if (LNotEqual(DAT0, 0xA0)) {
		err(arg0, z143, 72, 0, 0, DAT0, 0xA0)
	}
}

// Read/Write Byte (SMBByte)
// m753(CallChain)
// CallChain: String
Method(m753, 1, Serialized)
{
	Concatenate(arg0, "-m753", arg0)

	OperationRegion(SMBD, SMBus, 0x4200, 0x100)

	Field(SMBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, SMBByte),	// Use the SMBus Read/Write Byte protocol
		FLD0, 8,						// Virtual register at command value 0.
		FLD1, 8,						// Virtual register at command value 1.
		FLD2, 8}						// Virtual register at command value 2.

	/* Create the SMBus data buffer */
	Name(BUFF, Buffer(34){})			// Create SMBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create SMBus result buffer
	CreateByteField(BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField(BUFF, 0x01, LEN0)	// Length (Byte)
	CreateByteField(BUFF, 0x02, DAT0)
	CreateByteField(BUFR, 0x00, OB11)
	CreateByteField(BUFR, 0x01, LEN1)
	CreateByteField(BUFR, 0x02, DAT1)

	/* Write the byte '0x16' to the device using command value 2 */
	Store(0x00, OB10)
	Store(0x00, LEN0)
	Store(0x16, DAT0)					// Save 0x16 into the data buffer
	Store(Store(BUFF, FLD2), BUFR)		// Invoke a Write Byte transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 76, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x00)) {
		err(arg0, z143, 80, 0, 0, LEN0, 0x00)
	}
	if (LNotEqual(DAT0, 0x16)) {
		err(arg0, z143, 84, 0, 0, DAT0, 0x16)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 88, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x00)) {
		err(arg0, z143, 92, 0, 0, LEN1, 0x00)
	}
	if (LNotEqual(DAT1, 0x16)) {
		err(arg0, z143, 96, 0, 0, DAT1, 0x00)
	}

	/* Read a byte of data from the device using command value 1 */
	Store(FLD1, BUFF)					// Invoke a Read Byte transaction

	if (LNotEqual(OB10, 0x7A)) {
		err(arg0, z143, 100, 0, 0, OB10, 0x7A)
	}
	if (LNotEqual(LEN0, 0x01)) {
		err(arg0, z143, 104, 0, 0, LEN0, 0x01)
	}
	if (LNotEqual(DAT0, 0xA0)) {
		err(arg0, z143, 108, 0, 0, DAT0, 0xA0)
	}
}

// Read/Write Word (SMBWord)
// m754(CallChain)
// CallChain: String
Method(m754, 1, Serialized)
{
	Concatenate(arg0, "-m754", arg0)

	OperationRegion(SMBD, SMBus, 0x4200, 0x100)

	Field(SMBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, SMBWord),	// Use the SMBus Read/Write Word protocol
		FLD0, 8,						// Virtual register at command value 0.
		FLD1, 8,						// Virtual register at command value 1.
		FLD2, 8}						// Virtual register at command value 2.

	/* Create the SMBus data buffer */
	Name(BUFF, Buffer(34){})			// Create SMBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create SMBus result buffer
	CreateByteField(BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField(BUFF, 0x01, LEN0)	// Length (Byte)
	CreateWordField(BUFF, 0x02, DAT0)
	CreateByteField(BUFR, 0x00, OB11)
	CreateByteField(BUFR, 0x01, LEN1)
	CreateWordField(BUFR, 0x02, DAT1)

	/* Write the word '0x5416' to the device using command value 2 */
	Store(0x00, OB10)
	Store(0x00, LEN0)
	Store(0x5416, DAT0)					// Save 0x5416 into the data buffer
	Store(Store(BUFF, FLD2), BUFR)		// Invoke a Write Word transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 112, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x00)) {
		err(arg0, z143, 116, 0, 0, LEN0, 0x00)
	}
	if (LNotEqual(DAT0, 0x5416)) {
		err(arg0, z143, 120, 0, 0, DAT0, 0x16)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 124, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x00)) {
		err(arg0, z143, 128, 0, 0, LEN1, 0x00)
	}
	if (LNotEqual(DAT1, 0x5416)) {
		err(arg0, z143, 132, 0, 0, DAT1, 0x00)
	}

	/* Read two bytes of data from the device using command value 1 */
	Store(FLD1, BUFF)					// Invoke a Read Word transaction

	if (LNotEqual(OB10, 0x7A)) {
		err(arg0, z143, 136, 0, 0, OB10, 0x7A)
	}
	if (LNotEqual(LEN0, 0x02)) {
		err(arg0, z143, 140, 0, 0, LEN0, 0x02)
	}
	if (LNotEqual(DAT0, 0xA1A0)) {
		err(arg0, z143, 144, 0, 0, DAT0, 0xA1A0)
	}
}

// Read/Write Block (SMBBlock)
// m755(CallChain)
// CallChain: String
Method(m755, 1, Serialized)
{
	Concatenate(arg0, "-m755", arg0)

	OperationRegion(SMBD, SMBus, 0x4200, 0x100)

	Field(SMBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, SMBBlock),	// Use the SMBus Read/Write Block protocol
		FLD0, 8,						// Virtual register at command value 0.
		FLD1, 8,						// Virtual register at command value 1.
		FLD2, 8}						// Virtual register at command value 2.

	/* Create the SMBus data buffer */
	Name(BUFF, Buffer(34){})			// Create SMBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create SMBus result buffer
	CreateByteField(BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField(BUFF, 0x01, LEN0)	// Length (Byte)
	CreateField(BUFF, 0x10, 0x100, DAT0)
	CreateByteField(BUFR, 0x00, OB11)
	CreateByteField(BUFR, 0x01, LEN1)
	CreateField(BUFR, 0x10, 0x100, DAT1)

	/* Write the block 'TEST' to the device using command value 2 */
	Store(0x00, OB10)
	Store(0x04, LEN0)
	Store("TEST", DAT0)					// Save 'TEST' into the data buffer
	Store(Store(BUFF, FLD2), BUFR)		// Invoke a Write Block transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 148, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x04)) {
		err(arg0, z143, 152, 0, 0, LEN0, 0x04)
	}
	Store(Buffer(0x20){"TEST"}, Local0)
	if (LNotEqual(DAT0, Local0)) {
		err(arg0, z143, 156, 0, 0, DAT0, Local0)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 160, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x00)) {
		err(arg0, z143, 164, 0, 0, LEN1, 0x00)
	}
	if (LNotEqual(DAT1, Local0)) {
		err(arg0, z143, 168, 0, 0, DAT1, Local0)
	}

	/* Read block of data from the device using command value 1 */
	Store(FLD1, BUFF)					// Invoke a Read Block transaction

	if (LNotEqual(OB10, 0x7A)) {
		err(arg0, z143, 172, 0, 0, OB10, 0x7A)
	}
	if (LNotEqual(LEN0, 0x20)) {
		err(arg0, z143, 176, 0, 0, LEN0, 0x20)
	}
	Store(Buffer(0x20){
			0xA0, 0xA1, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7,
			0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE, 0xAF,
			0xB0, 0xB1, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7,
			0xB8, 0xB9, 0xBA, 0xBB, 0xBC, 0xBD, 0xBE, 0xBF},
		Local1)
	if (LNotEqual(DAT0, Local1)) {
		err(arg0, z143, 180, 0, 0, DAT0, Local1)
	}
}

// Word Process Call (SMBProcessCall)
// m756(CallChain)
// CallChain: String
Method(m756, 1, Serialized)
{
	Concatenate(arg0, "-m756", arg0)

	OperationRegion(SMBD, SMBus, 0x4200, 0x100)

	Field(SMBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, SMBProcessCall), // Use the SMBus Process Call protocol
		FLD0, 8,						// Virtual register at command value 0.
		FLD1, 8,						// Virtual register at command value 1.
		FLD2, 8}						// Virtual register at command value 2.

	/* Create the SMBus data buffer */
	Name(BUFF, Buffer(34){})			// Create SMBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create SMBus result buffer
	CreateByteField(BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField(BUFF, 0x01, LEN0)	// Length (Byte)
	CreateWordField(BUFF, 0x02, DAT0)
	CreateByteField(BUFR, 0x00, OB11)
	CreateByteField(BUFR, 0x01, LEN1)
	CreateWordField(BUFR, 0x02, DAT1)

	/* Process Call with input value '0x5416' to the device using command value 1 */
	Store(0x00, OB10)
	Store(0x00, LEN0)
	Store(0x5416, DAT0)					// Save 0x5416 into the data buffer
	Store(Store(BUFF, FLD1), BUFR)		// Invoke a Process Call transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 184, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x00)) {
		err(arg0, z143, 188, 0, 0, LEN0, 0x00)
	}
	if (LNotEqual(DAT0, 0x5416)) {
		err(arg0, z143, 192, 0, 0, DAT0, 0x16)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 196, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x02)) {
		err(arg0, z143, 200, 0, 0, LEN1, 0x02)
	}
	if (LNotEqual(DAT1, 0xA1A0)) {
		err(arg0, z143, 204, 0, 0, DAT1, 0xA1A0)
	}
}

// Block Process Call (SMBBlockProcessCall)
// m757(CallChain)
// CallChain: String
Method(m757, 1, Serialized)
{
	Concatenate(arg0, "-m757", arg0)

	OperationRegion(SMBD, SMBus, 0x4200, 0x100)

	Field(SMBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, SMBBlockProcessCall), // Use the Block Process Call protocol
		FLD0, 8,						// Virtual register at command value 0.
		FLD1, 8}						// Virtual register at command value 1.

	/* Create the SMBus data buffer */
	Name(BUFF, Buffer(34){})			// Create SMBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create SMBus result buffer
	CreateByteField(BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField(BUFF, 0x01, LEN0)	// Length (Byte)
	CreateField(BUFF, 0x10, 0x100, DAT0)
	CreateByteField(BUFR, 0x00, OB11)
	CreateByteField(BUFR, 0x01, LEN1)
	CreateField(BUFR, 0x10, 0x100, DAT1)

	/* Process Call with input value "TEST" to the device using command value 1 */
	Store(0x00, OB10)
	Store(0x04, LEN0)
	Store("TEST", DAT0)					// Save 'TEST' into the data buffer
	Store(Store(BUFF, FLD1), BUFR)		// Invoke a Write Block transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 208, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x04)) {
		err(arg0, z143, 212, 0, 0, LEN0, 0x04)
	}
	Store(Buffer(0x20){"TEST"}, Local0)
	if (LNotEqual(DAT0, Local0)) {
		err(arg0, z143, 216, 0, 0, DAT0, Local0)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 220, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x20)) {
		err(arg0, z143, 224, 0, 0, LEN1, 0x20)
	}
	Store(Buffer(0x20){
			0xA0, 0xA1, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7,
			0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE, 0xAF,
			0xB0, 0xB1, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7,
			0xB8, 0xB9, 0xBA, 0xBB, 0xBC, 0xBD, 0xBE, 0xBF},
		Local1)
	if (LNotEqual(DAT1, Local1)) {
		err(arg0, z143, 228, 0, 0, DAT1, Local1)
	}
}

//**** GenericSerialBus (ACPI 5.0) - similar to SMBUS ****************************

Device (\GSB1) {}

// Check BufferAcc access for GenericSerialBus
// m740(CallChain)
// CallChain: String
Method(m740, 1)
{
	Concatenate(arg0, "-m740", arg0)

	Store("TEST: m740, Check GenericSerialBus Region Fields (BufferAcc access)", Debug)

	/*
	 * Examples from Acpi Spec (Using the GenericSerialBus Protocols)
	 */

	// Read/Write Quick (AttribQuick)
	m758(arg0)

	// Send/Receive Byte (AttribSendReceive)
	m759(arg0)

	// Read/Write Byte (AttribByte)
	m75a(arg0)

	// Read/Write Word (AttribWord)
	m75b(arg0)

	// Read/Write Block (AttribBlock)
	m75c(arg0)

	// Word Process Call (AttribProcessCall)
	m75d(arg0)

	// Block Process Call (AttribBlockProcessCall)
	m75e(arg0)

	// Next 3 types are used for GenericSerialBus only

    // Read/Write N Bytes (AttribBytes)
	m75f(arg0)

    // Raw Read/Write N Bytes (AttribRawBytes)
    m760(Arg0)

    // Raw Process Call (AttribRawProcessBytes)
    m761(Arg0)
}

// Read/Write Quick (AttribQuick)
// m758(CallChain)
// CallChain: String
Method(m758, 1, Serialized)
{
	Concatenate(arg0, "-m758", arg0)

	OperationRegion(GSBD, GenericSerialBus, 0x4400, 0x100)

	Field(GSBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, AttribQuick),	// Use the GenericSerialBus Read/Write Quick protocol

        // A Connection is required
        Connection (
            I2cSerialBus (0x1234, DeviceInitiated, 0x88775544,
            AddressingMode10Bit, "\\GPI1", 0xEE,
            ResourceConsumer)),

		FLD0, 8}						    // Virtual register at command value 0.

	/* Create the GenericSerialBus data buffer */
	Name(BUFF, Buffer(34){})			// Create GenericSerialBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create GenericSerialBus result buffer
	CreateByteField(BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField(BUFF, 0x01, LEN0)	// Length (Byte)
	CreateByteField(BUFF, 0x02, DAT0)
	CreateByteField(BUFR, 0x00, OB11)
	CreateByteField(BUFR, 0x01, LEN1)
	CreateByteField(BUFR, 0x02, DAT1)

	/* Signal device (e.g. ON) */
	Store(Store(BUFF, FLD0), BUFR)		// Invoke Write Quick transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 232, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x00)) {
		err(arg0, z143, 236, 0, 0, LEN0, 0x00)
	}
	if (LNotEqual(DAT0, 0x00)) {
		err(arg0, z143, 240, 0, 0, DAT0, 0x00)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 244, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x00)) {
		err(arg0, z143, 248, 0, 0, LEN1, 0x00)
	}
	if (LNotEqual(DAT1, 0x00)) {
		err(arg0, z143, 252, 0, 0, DAT1, 0x00)
	}

	Store(0x00, OB10)
	Store(0xff, LEN0)
	Store(0x00, DAT0)

	/* Signal device (e.g. OFF) */
	Store(FLD0, BUFF)					// Invoke Read Quick transaction

	if (LNotEqual(OB10, 0x7A)) {
		err(arg0, z143, 256, 0, 0, OB10, 0x7A)
	}
	if (LNotEqual(LEN0, 0x01)) {
		err(arg0, z143, 260, 0, 0, LEN0, 0x01)
	}
	if (LNotEqual(DAT0, 0xA0)) {
		err(arg0, z143, 264, 0, 0, DAT0, 0xA0)
	}
}

// Read/Write Quick (AttribQuick)
// m759(CallChain)
// CallChain: String
Method(m759, 1, Serialized)
{
	Concatenate(arg0, "-m759", arg0)

	OperationRegion(GSBD, GenericSerialBus, 0x5400, 0x100)

	Field(GSBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, AttribSendReceive), // Use the GenericSerialBus Send/Receive Byte protocol

        // A Connection is required
        Connection (
            I2cSerialBus (0x1234, DeviceInitiated, 0x88775544,
            AddressingMode10Bit, "\\GPI1", 0xEE,
            ResourceConsumer)),

		FLD0, 8}							    // Virtual register at command value 0.

	/* Create the GenericSerialBus data buffer */
	Name(BUFF, Buffer(34){})			// Create GenericSerialBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create GenericSerialBus result buffer
	CreateByteField (BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField (BUFF, 0x01, LEN0)	// Length (Byte)
	CreateByteField (BUFF, 0x02, DAT0)
	CreateByteField (BUFR, 0x00, OB11)
	CreateByteField (BUFR, 0x01, LEN1)
	CreateByteField (BUFR, 0x02, DAT1)

	/* Send the byte '0x16' to the device */
	Store(0x00, OB10)
	Store(0x00, LEN0)
	Store(0x16, DAT0)					// Save 0x16 into the data buffer
	Store(Store(BUFF, FLD0), BUFR)		// Invoke a Send Byte transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 268, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x00)) {
		err(arg0, z143, 272, 0, 0, LEN0, 0x00)
	}
	if (LNotEqual(DAT0, 0x16)) {
		err(arg0, z143, 276, 0, 0, DAT0, 0x16)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 280, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x00)) {
		err(arg0, z143, 284, 0, 0, LEN1, 0x00)
	}
	if (LNotEqual(DAT1, 0x16)) {
		err(arg0, z143, 288, 0, 0, DAT1, 0x00)
	}

	/* Receive a byte of data from the device */
	Store(FLD0, BUFF)					// Invoke a Receive Byte transaction

	if (LNotEqual(OB10, 0x7A)) {
		err(arg0, z143, 292, 0, 0, OB10, 0x7A)
	}
	if (LNotEqual(LEN0, 0x01)) {
		err(arg0, z143, 296, 0, 0, LEN0, 0x01)
	}
	if (LNotEqual(DAT0, 0xA0)) {
		err(arg0, z143, 300, 0, 0, DAT0, 0xA0)
	}
}

// Read/Write Byte (AttribByte)
// m75a(CallChain)
// CallChain: String
Method(m75a, 1, Serialized)
{
	Concatenate(arg0, "-m75a", arg0)

	OperationRegion(GSBD, GenericSerialBus, 0x6400, 0x100)

	Field(GSBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, AttribByte),// Use the GenericSerialBus Read/Write Byte protocol

        // A Connection is required
        Connection (
            I2cSerialBus (0x1234, DeviceInitiated, 0x88775544,
            AddressingMode10Bit, "\\GPI1", 0xEE,
            ResourceConsumer)),

		FLD0, 8,						// Virtual register at command value 0.
		FLD1, 8,						// Virtual register at command value 1.
		FLD2, 8}						// Virtual register at command value 2.

	/* Create the GenericSerialBus data buffer */
	Name(BUFF, Buffer(34){})			// Create GenericSerialBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create GenericSerialBus result buffer
	CreateByteField (BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField (BUFF, 0x01, LEN0)	// Length (Byte)
	CreateByteField (BUFF, 0x02, DAT0)
	CreateByteField (BUFR, 0x00, OB11)
	CreateByteField (BUFR, 0x01, LEN1)
	CreateByteField (BUFR, 0x02, DAT1)

	/* Write the byte '0x16' to the device using command value 2 */
	Store(0x00, OB10)
	Store(0x00, LEN0)
	Store(0x16, DAT0)					// Save 0x16 into the data buffer
	Store(Store(BUFF, FLD2), BUFR)		// Invoke a Write Byte transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 304, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x00)) {
		err(arg0, z143, 308, 0, 0, LEN0, 0x00)
	}
	if (LNotEqual(DAT0, 0x16)) {
		err(arg0, z143, 312, 0, 0, DAT0, 0x16)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 316, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x00)) {
		err(arg0, z143, 320, 0, 0, LEN1, 0x00)
	}
	if (LNotEqual(DAT1, 0x16)) {
		err(arg0, z143, 324, 0, 0, DAT1, 0x00)
	}

	/* Read a byte of data from the device using command value 1 */
	Store(FLD1, BUFF)					// Invoke a Read Byte transaction

	if (LNotEqual(OB10, 0x7A)) {
		err(arg0, z143, 328, 0, 0, OB10, 0x7A)
	}
	if (LNotEqual(LEN0, 0x01)) {
		err(arg0, z143, 332, 0, 0, LEN0, 0x01)
	}
	if (LNotEqual(DAT0, 0xA0)) {
		err(arg0, z143, 336, 0, 0, DAT0, 0xA0)
	}
}

// Read/Write Word (AttribWord)
// m75b(CallChain)
// CallChain: String
Method(m75b, 1, Serialized)
{
	Concatenate(arg0, "-m75b", arg0)

	OperationRegion(GSBD, GenericSerialBus, 0x7400, 0x100)

	Field(GSBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, AttribWord),// Use the GenericSerialBus Read/Write Word protocol

        // A Connection is required
        Connection (
            I2cSerialBus (0x1234, DeviceInitiated, 0x88775544,
            AddressingMode10Bit, "\\GPI1", 0xEE,
            ResourceConsumer)),

		FLD0, 8,						// Virtual register at command value 0.
		FLD1, 8,						// Virtual register at command value 1.
		FLD2, 8}						// Virtual register at command value 2.

	/* Create the GenericSerialBus data buffer */
	Name(BUFF, Buffer(34){})			// Create GenericSerialBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create GenericSerialBus result buffer
	CreateByteField (BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField (BUFF, 0x01, LEN0)	// Length (Byte)
	CreateWordField (BUFF, 0x02, DAT0)
	CreateByteField (BUFR, 0x00, OB11)
	CreateByteField (BUFR, 0x01, LEN1)
	CreateWordField (BUFR, 0x02, DAT1)

	/* Write the word '0x5416' to the device using command value 2 */
	Store(0x00, OB10)
	Store(0x00, LEN0)
	Store(0x5416, DAT0)					// Save 0x5416 into the data buffer
	Store(Store(BUFF, FLD2), BUFR)		// Invoke a Write Word transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 340, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x00)) {
		err(arg0, z143, 344, 0, 0, LEN0, 0x00)
	}
	if (LNotEqual(DAT0, 0x5416)) {
		err(arg0, z143, 348, 0, 0, DAT0, 0x16)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 352, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x00)) {
		err(arg0, z143, 356, 0, 0, LEN1, 0x00)
	}
	if (LNotEqual(DAT1, 0x5416)) {
		err(arg0, z143, 360, 0, 0, DAT1, 0x00)
	}

	/* Read two bytes of data from the device using command value 1 */
	Store(FLD1, BUFF)					// Invoke a Read Word transaction

	if (LNotEqual(OB10, 0x7A)) {
		err(arg0, z143, 364, 0, 0, OB10, 0x7A)
	}
	if (LNotEqual(LEN0, 0x02)) {
		err(arg0, z143, 368, 0, 0, LEN0, 0x02)
	}
	if (LNotEqual(DAT0, 0xA1A0)) {
		err(arg0, z143, 372, 0, 0, DAT0, 0xA1A0)
	}
}

// Read/Write Block (AttribBlock)
// m75c(CallChain)
// CallChain: String
Method(m75c, 1, Serialized)
{
	Concatenate(arg0, "-m75c", arg0)

	OperationRegion(GSBD, GenericSerialBus, 0x8400, 0x100)

	Field(GSBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, AttribBlock),	// Use the GenericSerialBus Read/Write Block protocol

        // A Connection is required
        Connection (
            I2cSerialBus (0x1234, DeviceInitiated, 0x88775544,
            AddressingMode10Bit, "\\GPI1", 0xEE,
            ResourceConsumer)),

		FLD0, 8,						    // Virtual register at command value 0.
		FLD1, 8,						    // Virtual register at command value 1.
		FLD2, 8}						    // Virtual register at command value 2.

	/* Create the GenericSerialBus data buffer */
	Name(BUFF, Buffer(34){})			// Create GenericSerialBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create GenericSerialBus result buffer
	CreateByteField (BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField (BUFF, 0x01, LEN0)	// Length (Byte)
	CreateField     (BUFF, 0x10, 0x100, DAT0)
	CreateByteField (BUFR, 0x00, OB11)
	CreateByteField (BUFR, 0x01, LEN1)
	CreateField     (BUFR, 0x10, 0x100, DAT1)

	/* Write the block 'TEST' to the device using command value 2 */
	Store(0x00, OB10)
	Store(0x04, LEN0)
	Store("TEST", DAT0)					// Save 'TEST' into the data buffer
	Store(Store(BUFF, FLD2), BUFR)		// Invoke a Write Block transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 376, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x04)) {
		err(arg0, z143, 380, 0, 0, LEN0, 0x04)
	}
	Store(Buffer(0x20){"TEST"}, Local0)
	if (LNotEqual(DAT0, Local0)) {
		err(arg0, z143, 384, 0, 0, DAT0, Local0)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 388, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x00)) {
		err(arg0, z143, 392, 0, 0, LEN1, 0x00)
	}
	if (LNotEqual(DAT1, Local0)) {
		err(arg0, z143, 396, 0, 0, DAT1, Local0)
	}

	/* Read block of data from the device using command value 1 */
	Store(FLD1, BUFF)					// Invoke a Read Block transaction

	if (LNotEqual(OB10, 0x7A)) {
		err(arg0, z143, 400, 0, 0, OB10, 0x7A)
	}
	if (LNotEqual(LEN0, 0x20)) {
		err(arg0, z143, 404, 0, 0, LEN0, 0x20)
	}
	Store(Buffer(0x20){
			0xA0, 0xA1, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7,
			0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE, 0xAF,
			0xB0, 0xB1, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7,
			0xB8, 0xB9, 0xBA, 0xBB, 0xBC, 0xBD, 0xBE, 0xBF},
		Local1)
	if (LNotEqual(DAT0, Local1)) {
		err(arg0, z143, 408, 0, 0, DAT0, Local1)
	}
}

// Word Process Call (AttribProcessCall)
// m75d(CallChain)
// CallChain: String
Method(m75d, 1, Serialized)
{
	Concatenate(arg0, "-m75d", arg0)

	OperationRegion(GSBD, GenericSerialBus, 0x9400, 0x100)

	Field(GSBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, AttribProcessCall), // Use the GenericSerialBus Process Call protocol

        // A Connection is required
        Connection (
            I2cSerialBus (0x1234, DeviceInitiated, 0x88775544,
            AddressingMode10Bit, "\\GPI1", 0xEE,
            ResourceConsumer)),

		FLD0, 8,						        // Virtual register at command value 0.
		FLD1, 8,						        // Virtual register at command value 1.
		FLD2, 8}						        // Virtual register at command value 2.

	/* Create the GenericSerialBus data buffer */
	Name(BUFF, Buffer(34){})			// Create GenericSerialBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create GenericSerialBus result buffer
	CreateByteField (BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField (BUFF, 0x01, LEN0)	// Length (Byte)
	CreateWordField (BUFF, 0x02, DAT0)
	CreateByteField (BUFR, 0x00, OB11)
	CreateByteField (BUFR, 0x01, LEN1)
	CreateWordField (BUFR, 0x02, DAT1)

	/* Process Call with input value '0x5416' to the device using command value 1 */
	Store(0x00, OB10)
	Store(0x00, LEN0)
	Store(0x5416, DAT0)					// Save 0x5416 into the data buffer
	Store(Store(BUFF, FLD1), BUFR)		// Invoke a Process Call transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 412, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x00)) {
		err(arg0, z143, 416, 0, 0, LEN0, 0x00)
	}
	if (LNotEqual(DAT0, 0x5416)) {
		err(arg0, z143, 420, 0, 0, DAT0, 0x16)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 424, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x02)) {
		err(arg0, z143, 428, 0, 0, LEN1, 0x02)
	}
	if (LNotEqual(DAT1, 0xA1A0)) {
		err(arg0, z143, 432, 0, 0, DAT1, 0xA1A0)
	}
}

// Block Process Call (AttribBlockProcessCall)
// m75e(CallChain)
// CallChain: String
Method(m75e, 1, Serialized)
{
	Concatenate(arg0, "-m75e", arg0)

	OperationRegion(GSBD, GenericSerialBus, 0xa400, 0x100)

	Field(GSBD, BufferAcc, NoLock, Preserve) {
		AccessAs(BufferAcc, AttribBlockProcessCall),// Use the Block Process Call protocol

        // A Connection is required
        Connection (
            I2cSerialBus (0x1234, DeviceInitiated, 0x88775544,
            AddressingMode10Bit, "\\GPI1", 0xEE,
            ResourceConsumer)),

		FLD0, 8,						            // Virtual register at command value 0.
		FLD1, 8}						            // Virtual register at command value 1.

	/* Create the GenericSerialBus data buffer */
	Name(BUFF, Buffer(34){})			// Create GenericSerialBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create GenericSerialBus result buffer
	CreateByteField (BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField (BUFF, 0x01, LEN0)	// Length (Byte)
	CreateField     (BUFF, 0x10, 0x100, DAT0)
	CreateByteField (BUFR, 0x00, OB11)
	CreateByteField (BUFR, 0x01, LEN1)
	CreateField     (BUFR, 0x10, 0x100, DAT1)

	/* Process Call with input value "TEST" to the device using command value 1 */
	Store(0x00, OB10)
	Store(0x04, LEN0)
	Store("TEST", DAT0)					// Save 'TEST' into the data buffer
	Store(Store(BUFF, FLD1), BUFR)		// Invoke a Write Block transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 436, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x04)) {
		err(arg0, z143, 440, 0, 0, LEN0, 0x04)
	}
	Store(Buffer(0x20){"TEST"}, Local0)
	if (LNotEqual(DAT0, Local0)) {
		err(arg0, z143, 444, 0, 0, DAT0, Local0)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 448, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x20)) {
		err(arg0, z143, 452, 0, 0, LEN1, 0x20)
	}
	Store(Buffer(0x20){
			0xA0, 0xA1, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7,
			0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE, 0xAF,
			0xB0, 0xB1, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7,
			0xB8, 0xB9, 0xBA, 0xBB, 0xBC, 0xBD, 0xBE, 0xBF},
		Local1)
	if (LNotEqual(DAT1, Local1)) {
		err(arg0, z143, 456, 0, 0, DAT1, Local1)
	}
}

// Read/Write N Bytes (AttribBytes)
// m75f(CallChain)
// CallChain: String
Method(m75f, 1, Serialized)
{
	Concatenate(arg0, "-m75f", arg0)

	OperationRegion(GSBD, GenericSerialBus, 0xB400, 0x100)

	Field(GSBD, BufferAcc, NoLock, Preserve) {
        AccessAs (BufferAcc, AttribBytes (34)),

        // A Connection is required
        Connection (
            I2cSerialBus (0x1234, DeviceInitiated, 0x88775544,
            AddressingMode10Bit, "\\GPI1", 0xEE,
            ResourceConsumer)),

		FLD0, 8,					    // Virtual register at command value 0.
		FLD1, 8}					    // Virtual register at command value 1.

	/* Create the GenericSerialBus data buffer */
	Name(BUFF, Buffer(34){})			// Create GenericSerialBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create GenericSerialBus result buffer

	CreateByteField (BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField (BUFF, 0x01, LEN0)	// Length (Byte)
	CreateField     (BUFF, 0x10, 0x100, DAT0)

	CreateByteField (BUFR, 0x00, OB11)
	CreateByteField (BUFR, 0x01, LEN1)
	CreateField     (BUFR, 0x10, 0x100, DAT1)

	/* Process Call with input value "TEST" to the device using command value 1 */
	Store(0x00, OB10)
	Store(0x04, LEN0)
	Store("TEST", DAT0)					// Save 'TEST' into the data buffer
	Store(Store(BUFF, FLD1), BUFR)		// Invoke a Write Block transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 460, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x04)) {
		err(arg0, z143, 464, 0, 0, LEN0, 0x04)
	}
	Store(Buffer(0x20){"TEST"}, Local0)
	if (LNotEqual(DAT0, Local0)) {
		err(arg0, z143, 468, 0, 0, DAT0, Local0)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 472, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x20)) {
		err(arg0, z143, 476, 0, 0, LEN1, 0x20)
	}
	Store(Buffer(0x20){
			0xA0, 0xA1, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7,
			0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE, 0xAF,
			0xB0, 0xB1, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7,
			0xB8, 0xB9, 0xBA, 0xBB, 0xBC, 0xBD, 0xBE, 0xBF},
		Local1)
	if (LNotEqual(DAT1, Local1)) {
		err(arg0, z143, 480, 0, 0, DAT1, Local1)
	}
}

// Raw Read/Write N Bytes (AttribRawBytes)
// m760(CallChain)
// CallChain: String
Method(m760, 1, Serialized)
{
	Concatenate(arg0, "-m760", arg0)

	OperationRegion(GSBD, GenericSerialBus, 0xB400, 0x100)

	Field(GSBD, BufferAcc, NoLock, Preserve) {
        AccessAs (BufferAcc, AttribRawBytes (34)),

        // A Connection is required
        Connection (
            I2cSerialBus (0x1234, DeviceInitiated, 0x88775544,
            AddressingMode10Bit, "\\GPI1", 0xEE,
            ResourceConsumer)),

		FLD0, 8,					    // Virtual register at command value 0.
		FLD1, 8}					    // Virtual register at command value 1.

	/* Create the GenericSerialBus data buffer */
	Name(BUFF, Buffer(34){})			// Create GenericSerialBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create GenericSerialBus result buffer

	CreateByteField (BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField (BUFF, 0x01, LEN0)	// Length (Byte)
	CreateField     (BUFF, 0x10, 0x100, DAT0)

	CreateByteField (BUFR, 0x00, OB11)
	CreateByteField (BUFR, 0x01, LEN1)
	CreateField     (BUFR, 0x10, 0x100, DAT1)

	/* Process Call with input value "TEST" to the device using command value 1 */
	Store(0x00, OB10)
	Store(0x04, LEN0)
	Store("TEST", DAT0)					// Save 'TEST' into the data buffer
	Store(Store(BUFF, FLD1), BUFR)		// Invoke a Write Block transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 484, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x04)) {
		err(arg0, z143, 488, 0, 0, LEN0, 0x04)
	}
	Store(Buffer(0x20){"TEST"}, Local0)
	if (LNotEqual(DAT0, Local0)) {
		err(arg0, z143, 492, 0, 0, DAT0, Local0)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 496, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x20)) {
		err(arg0, z143, 500, 0, 0, LEN1, 0x20)
	}
	Store(Buffer(0x20){
			0xA0, 0xA1, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7,
			0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE, 0xAF,
			0xB0, 0xB1, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7,
			0xB8, 0xB9, 0xBA, 0xBB, 0xBC, 0xBD, 0xBE, 0xBF},
		Local1)
	if (LNotEqual(DAT1, Local1)) {
		err(arg0, z143, 504, 0, 0, DAT1, Local1)
	}
}

// Raw Process Call (AttribRawProcessBytes)
// m761(CallChain)
// CallChain: String
Method(m761, 1, Serialized)
{
	Concatenate(arg0, "-m761", arg0)

	OperationRegion(GSBD, GenericSerialBus, 0xB400, 0x100)

	Field(GSBD, BufferAcc, NoLock, Preserve) {
        AccessAs (BufferAcc, AttribRawProcessBytes (34)),

        // A Connection is required
        Connection (
            I2cSerialBus (0x1234, DeviceInitiated, 0x88775544,
            AddressingMode10Bit, "\\GPI1", 0xEE,
            ResourceConsumer)),

		FLD0, 8,					    // Virtual register at command value 0.
		FLD1, 8}					    // Virtual register at command value 1.

	/* Create the GenericSerialBus data buffer */
	Name(BUFF, Buffer(34){})			// Create GenericSerialBus data buffer as BUFF
	Name(BUFR, Buffer(34){})			// Create GenericSerialBus result buffer

	CreateByteField (BUFF, 0x00, OB10)	// Status (Byte)
	CreateByteField (BUFF, 0x01, LEN0)	// Length (Byte)
	CreateField     (BUFF, 0x10, 0x100, DAT0)

	CreateByteField (BUFR, 0x00, OB11)
	CreateByteField (BUFR, 0x01, LEN1)
	CreateField     (BUFR, 0x10, 0x100, DAT1)

	/* Process Call with input value "TEST" to the device using command value 1 */
	Store(0x00, OB10)
	Store(0x04, LEN0)
	Store("TEST", DAT0)					// Save 'TEST' into the data buffer
	Store(Store(BUFF, FLD1), BUFR)		// Invoke a Write Block transaction

	if (LNotEqual(OB10, 0x00)) {
		err(arg0, z143, 508, 0, 0, OB10, 0x00)
	}
	if (LNotEqual(LEN0, 0x04)) {
		err(arg0, z143, 512, 0, 0, LEN0, 0x04)
	}
	Store(Buffer(0x20){"TEST"}, Local0)
	if (LNotEqual(DAT0, Local0)) {
		err(arg0, z143, 516, 0, 0, DAT0, Local0)
	}

	if (LNotEqual(OB11, 0x7A)) {
		err(arg0, z143, 520, 0, 0, OB11, 0x7A)
	}
	if (LNotEqual(LEN1, 0x20)) {
		err(arg0, z143, 524, 0, 0, LEN1, 0x20)
	}
	Store(Buffer(0x20){
			0xA0, 0xA1, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7,
			0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE, 0xAF,
			0xB0, 0xB1, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7,
			0xB8, 0xB9, 0xBA, 0xBB, 0xBC, 0xBD, 0xBE, 0xBF},
		Local1)
	if (LNotEqual(DAT1, Local1)) {
		err(arg0, z143, 528, 0, 0, DAT1, Local1)
	}
}


//**** GeneralPurposeIo (ACPI 5.0) **************************************

//
// Test the use of Connection() operator and simple ByteAcc
//
Method(m764, 1, Serialized)
{
	Concatenate(arg0, "-m764", arg0)

	Store("TEST: m764, Check GeneralPurposeIo Region Fields (ByteAcc access)", Debug)

    //...Other required stuff for this device
    Name (GMOD, ResourceTemplate ()     //An existing GPIO Connection (to be used later)
    {
        //2 Outputs that define the Power mode of the device
        GpioIo (Exclusive, PullDown, , , , "\\_SB.GPI2") {10, 12}
    })

    // Offset is ignored (From ACPI spec)

    OperationRegion (GPO2, GeneralPurposeIO, 0, 64)
    Method(_REG,2) {}
    Name(_DEP, Package() {\_SB})

    // Update rule must be Preserve

    Field(GPO2, ByteAcc, NoLock, Preserve)
    {
        Connection (GMOD),      // Reuse an existing connection (defined above)
        MODE, 2,                // Power Mode

        Connection (GpioIo (Exclusive, PullUp, , , , "\\_SB.GPI2") {7}),
        STAT, 1,                // e.g. Status signal from the device

        Connection (GpioIo (Exclusive, PullUp, , , , "\\_SB.GPI2") {9}),
        RSET, 1,                 // e.g. Reset signal to the device

        Offset (32),
        BUFF, 128
    }

    Store(0x03, MODE)    //Set both MODE bits. Power Mode 3
    Store (MODE, Local0)
	if (LNotEqual(Local0, 0x03)) {
		err(arg0, z143, 532, 0, 0, Local0, 0x03)
	}

    Store(0x01, MODE)
    Store (MODE, Local0)
	if (LNotEqual(Local0, 0x01)) {
		err(arg0, z143, 536, 0, 0, Local0, 0x01)
	}

    Store(0x01, STAT)
    Store (STAT, Local0)
	if (LNotEqual(Local0, 0x01)) {
		err(arg0, z143, 540, 0, 0, Local0, 0x01)
	}

	Name (TBUF, Buffer(0x10) {
        0xA0, 0xA1, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7,
        0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE, 0xAF})

    Store(TBUF, BUFF)
    Store (BUFF, Local0)
	if (LNotEqual(Local0, TBUF)) {
		err(arg0, z143, 544, 0, 0, Local0, TBUF)
	}
}


//**** IPMI (ACPI 4.0) - bidirectional buffer ****************************

Method(m768, 1, Serialized)
{
	Concatenate(arg0, "-m768", arg0)

	Store("TEST: m768, Check IPMI Region Fields (BufferAcc access)", Debug)

    OperationRegion(POWR, IPMI, 0x3000, 0x100) // Power network function
    Field(POWR, BufferAcc, NoLock, Preserve)
    {
        Offset(0xC1),   // Skip to command value 0xC1
        SPWL, 8,        // Set power limit [command value 0xC1]
        GPWL, 8,        // Get power limit [command value 0xC2]
        Offset(0xC8),   // Skip to command value 0xC8
        GPMM, 8         // Get power meter measurement [command value 0xC8]
    }

    /* Create the IPMI data buffer - ALWAYS 66 bytes */

    Name(BUFF, Buffer(66){})            // Create IPMI data buffer as BUFF

    CreateByteField(BUFF, 0x00, STAT)   // STAT = Status (Byte)
    CreateByteField(BUFF, 0x01, LENG)   // LENG = Length (Byte)
    CreateByteField(BUFF, 0x02, MODE)   // MODE = Mode (Byte)
    CreateByteField(BUFF, 0x03, RESV)   // RESV = Reserved (Byte)

    Store(0x2, LENG)                    // Request message is 2 bytes long
    Store(0x1, MODE)                    // Set Mode to 1

    Store(Store(BUFF, GPMM), BUFF)      // Write the request into the GPMM command,
                                        // then read the results
    CreateByteField(BUFF, 0x02, CMPC)   // CMPC = Completion code (Byte)
    CreateWordField(BUFF, 0x03, RSVD)   // Reserved

    /* Buffer expected back from ACPIEXEC utility */

    Store (Buffer(66) {0, 0x40, 0, 0,
        0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,
        0x0C,0x0D,0x0E,0x0F,0x10,0x11,0x12,0x13,
        0x14,0x15,0x16,0x17,0x18,0x19,0x1A,0x1B,
        0x1C,0x1D,0x1E,0x1F,0x20,0x21,0x22,0x23,
        0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,
        0x2C,0x2D,0x2E,0x2F,0x30,0x31,0x32,0x33,
        0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,
        0x3C,0x3D,0x3E,0x3F,0x40,0x41}, Local1)

    If (LNotEqual (STAT, 0))
    {
		err(arg0, z143, 548, 0, 0, STAT, 0)
    }
    If (LNotEqual (CMPC, 0))
    {
		err(arg0, z143, 552, 0, 0, CMPC, 0)
    }
    If (LNotEqual (BUFF, Local1))
    {
		err(arg0, z143, 556, 0, 0, Local1, BUFF)
    }
}


// Splitting of Fields
// m742(CallChain)
Method(m742, 1, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, 0x257)

	Concatenate(arg0, "-m742", arg0)

	Store("TEST: m742, Check Splitting of Fields", Debug)

	m720(arg0, OPR0)
	m721(arg0, OPR0)
	m722(arg0, OPR0)
	m723(arg0, OPR0)
	m724(arg0, OPR0)
	m725(arg0, OPR0)
	m726(arg0, OPR0)
	m727(arg0, OPR0)
	m728(arg0, OPR0)
	m729(arg0, OPR0)
}

// Create Region Fields that spans the same bits
// and check possible inconsistence, 0-bit offset.
// m720(CallChain, OpRegion)
Method(m720, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x1000)

	Concatenate(arg0, "-m720", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 0, // 0-bit offset
			FU00, 0x3}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 0,
			FU10, 0x1,
			FU11, 0x1,
			FU12, 0x1}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 0,
			FU20, 0x1,
			FU21, 0x2}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 0,
			FU30, 0x2,
			FU31, 0x1}

	Store(8, Local0)

	Store(Package(){FU10, FU11, FU12, FU20, FU21, FU30, FU31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, FU00)

		if (y118) {
		} else {
			Store(FU10, Index(Local1, 0))
			Store(FU11, Index(Local1, 1))
			Store(FU12, Index(Local1, 2))
			Store(FU20, Index(Local1, 3))
			Store(FU21, Index(Local1, 4))
			Store(FU30, Index(Local1, 5))
			Store(FU31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create Region Fields that spans the same bits
// and check possible inconsistence, 1-bit offset.
// m721(CallChain, OpRegion)
Method(m721, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x1000)

	Concatenate(arg0, "-m721", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 1, // 1-bit offset
			FU00, 0x3}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 1,
			FU10, 0x1,
			FU11, 0x1,
			FU12, 0x1}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 1,
			FU20, 0x1,
			FU21, 0x2}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 1,
			FU30, 0x2,
			FU31, 0x1}

	Store(8, Local0)

	Store(Package(){FU10, FU11, FU12, FU20, FU21, FU30, FU31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, FU00)

		if (y118) {
		} else {
			Store(FU10, Index(Local1, 0))
			Store(FU11, Index(Local1, 1))
			Store(FU12, Index(Local1, 2))
			Store(FU20, Index(Local1, 3))
			Store(FU21, Index(Local1, 4))
			Store(FU30, Index(Local1, 5))
			Store(FU31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create Region Fields that spans the same bits
// and check possible inconsistence, 2-bit offset.
// m722(CallChain, OpRegion)
Method(m722, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x1000)

	Concatenate(arg0, "-m722", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 2, // 2-bit offset
			FU00, 0x3}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 2,
			FU10, 0x1,
			FU11, 0x1,
			FU12, 0x1}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 2,
			FU20, 0x1,
			FU21, 0x2}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 2,
			FU30, 0x2,
			FU31, 0x1}

	Store(8, Local0)

	Store(Package(){FU10, FU11, FU12, FU20, FU21, FU30, FU31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, FU00)

		if (y118) {
		} else {
			Store(FU10, Index(Local1, 0))
			Store(FU11, Index(Local1, 1))
			Store(FU12, Index(Local1, 2))
			Store(FU20, Index(Local1, 3))
			Store(FU21, Index(Local1, 4))
			Store(FU30, Index(Local1, 5))
			Store(FU31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create Region Fields that spans the same bits
// and check possible inconsistence, 3-bit offset.
// m723(CallChain, OpRegion)
Method(m723, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x1000)

	Concatenate(arg0, "-m723", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 3, // 3-bit offset
			FU00, 0x3}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 3,
			FU10, 0x1,
			FU11, 0x1,
			FU12, 0x1}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 3,
			FU20, 0x1,
			FU21, 0x2}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 3,
			FU30, 0x2,
			FU31, 0x1}

	Store(8, Local0)

	Store(Package(){FU10, FU11, FU12, FU20, FU21, FU30, FU31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, FU00)

		if (y118) {
		} else {
			Store(FU10, Index(Local1, 0))
			Store(FU11, Index(Local1, 1))
			Store(FU12, Index(Local1, 2))
			Store(FU20, Index(Local1, 3))
			Store(FU21, Index(Local1, 4))
			Store(FU30, Index(Local1, 5))
			Store(FU31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create Region Fields that spans the same bits
// and check possible inconsistence, 4-bit offset.
// m724(CallChain, OpRegion)
Method(m724, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x1000)

	Concatenate(arg0, "-m724", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 4, // 4-bit offset
			FU00, 0x3}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 4,
			FU10, 0x1,
			FU11, 0x1,
			FU12, 0x1}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 4,
			FU20, 0x1,
			FU21, 0x2}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 4,
			FU30, 0x2,
			FU31, 0x1}

	Store(8, Local0)

	Store(Package(){FU10, FU11, FU12, FU20, FU21, FU30, FU31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, FU00)

		if (y118) {
		} else {
			Store(FU10, Index(Local1, 0))
			Store(FU11, Index(Local1, 1))
			Store(FU12, Index(Local1, 2))
			Store(FU20, Index(Local1, 3))
			Store(FU21, Index(Local1, 4))
			Store(FU30, Index(Local1, 5))
			Store(FU31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create Region Fields that spans the same bits
// and check possible inconsistence, 5-bit offset.
// m725(CallChain, OpRegion)
Method(m725, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x1000)

	Concatenate(arg0, "-m725", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 5, // 5-bit offset
			FU00, 0x3}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 5,
			FU10, 0x1,
			FU11, 0x1,
			FU12, 0x1}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 5,
			FU20, 0x1,
			FU21, 0x2}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 5,
			FU30, 0x2,
			FU31, 0x1}

	Store(8, Local0)

	Store(Package(){FU10, FU11, FU12, FU20, FU21, FU30, FU31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, FU00)

		if (y118) {
		} else {
			Store(FU10, Index(Local1, 0))
			Store(FU11, Index(Local1, 1))
			Store(FU12, Index(Local1, 2))
			Store(FU20, Index(Local1, 3))
			Store(FU21, Index(Local1, 4))
			Store(FU30, Index(Local1, 5))
			Store(FU31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create Region Fields that spans the same bits
// and check possible inconsistence, 6-bit offset.
// m726(CallChain, OpRegion)
Method(m726, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x1000)

	Concatenate(arg0, "-m726", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 6, // 6-bit offset
			FU00, 0x3}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 6,
			FU10, 0x1,
			FU11, 0x1,
			FU12, 0x1}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 6,
			FU20, 0x1,
			FU21, 0x2}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 6,
			FU30, 0x2,
			FU31, 0x1}

	Store(8, Local0)

	Store(Package(){FU10, FU11, FU12, FU20, FU21, FU30, FU31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, FU00)

		if (y118) {
		} else {
			Store(FU10, Index(Local1, 0))
			Store(FU11, Index(Local1, 1))
			Store(FU12, Index(Local1, 2))
			Store(FU20, Index(Local1, 3))
			Store(FU21, Index(Local1, 4))
			Store(FU30, Index(Local1, 5))
			Store(FU31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create Region Fields that spans the same bits
// and check possible inconsistence, 7-bit offset.
// m727(CallChain, OpRegion)
Method(m727, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x1000)

	Concatenate(arg0, "-m727", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 7, // 7-bit offset
			FU00, 0x3}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 7,
			FU10, 0x1,
			FU11, 0x1,
			FU12, 0x1}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 7,
			FU20, 0x1,
			FU21, 0x2}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 7,
			FU30, 0x2,
			FU31, 0x1}

	Store(8, Local0)

	Store(Package(){FU10, FU11, FU12, FU20, FU21, FU30, FU31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, FU00)

		if (y118) {
		} else {
			Store(FU10, Index(Local1, 0))
			Store(FU11, Index(Local1, 1))
			Store(FU12, Index(Local1, 2))
			Store(FU20, Index(Local1, 3))
			Store(FU21, Index(Local1, 4))
			Store(FU30, Index(Local1, 5))
			Store(FU31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create Region Fields that spans the same bits
// and check possible inconsistence, 8-bit offset.
// m728(CallChain, OpRegion)
Method(m728, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x1000)

	Concatenate(arg0, "-m728", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 8, // 8-bit offset
			FU00, 0x3}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 8,
			FU10, 0x1,
			FU11, 0x1,
			FU12, 0x1}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 8,
			FU20, 0x1,
			FU21, 0x2}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 8,
			FU30, 0x2,
			FU31, 0x1}

	Store(8, Local0)

	Store(Package(){FU10, FU11, FU12, FU20, FU21, FU30, FU31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, FU00)

		if (y118) {
		} else {
			Store(FU10, Index(Local1, 0))
			Store(FU11, Index(Local1, 1))
			Store(FU12, Index(Local1, 2))
			Store(FU20, Index(Local1, 3))
			Store(FU21, Index(Local1, 4))
			Store(FU30, Index(Local1, 5))
			Store(FU31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create Region Fields that spans the same bits
// and check possible inconsistence, 2046-bit offset.
// m729(CallChain, OpRegion)
Method(m729, 2, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x1000)

	Concatenate(arg0, "-m729", arg0)

	CopyObject(arg1, OPRm)

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 2046, // 2046-bit offset
			FU00, 0x3}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 2046,
			FU10, 0x1,
			FU11, 0x1,
			FU12, 0x1}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 2046,
			FU20, 0x1,
			FU21, 0x2}

	Field(OPRm, ByteAcc, NoLock, Preserve) {
			, 2046,
			FU30, 0x2,
			FU31, 0x1}

	Store(8, Local0)

	Store(Package(){FU10, FU11, FU12, FU20, FU21, FU30, FU31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, FU00)

		if (y118) {
		} else {
			Store(FU10, Index(Local1, 0))
			Store(FU11, Index(Local1, 1))
			Store(FU12, Index(Local1, 2))
			Store(FU20, Index(Local1, 3))
			Store(FU21, Index(Local1, 4))
			Store(FU30, Index(Local1, 5))
			Store(FU31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Supports bunch of m720-m729 methods
// checking splitting fields
// m72a(CallChain, CheckInt, FieldsPkg)
Method(m72a, 3)
{
	Concatenate(arg0, "-m72a", arg0)

	Store(arg1, Local3)
	
	And(ShiftRight(Local3, 0), 0x1, Local0)
	And(ShiftRight(Local3, 1), 0x1, Local1)
	And(ShiftRight(Local3, 2), 0x1, Local2)

	// 1-1-1
	Store(Derefof(Index(arg2, 0)), Local4)
	if(LNotEqual(Local4, Local0)) {
		err(arg0, z143, 560, z143, Local3, Local4, Local0)
	}
	Store(Derefof(Index(arg2, 1)), Local4)
	if(LNotEqual(Local4, Local1)) {
		err(arg0, z143, 564, z143, Local3, Local4, Local1)
	}
	Store(Derefof(Index(arg2, 2)), Local4)
	if(LNotEqual(Local4, Local2)) {
		err(arg0, z143, 568, z143, Local3, Local4, Local2)
	}

	// 1-2
	Store(Derefof(Index(arg2, 3)), Local4)
	if(LNotEqual(Local4, Local0)) {
		err(arg0, z143, 572, z143, Local3, Local4, Local0)
	}
	Store(Derefof(Index(arg2, 4)), Local4)
	Or(Local1, ShiftLeft(Local2, 1), Local5)
	if(LNotEqual(Local4, Local5)) {
		err(arg0, z143, 576, z143, Local3, Local4, Local5)
	}

	// 2-1
	Store(Derefof(Index(arg2, 5)), Local4)
	Or(Local0, ShiftLeft(Local1, 1), Local5)
	if(LNotEqual(Local4, Local5)) {
		err(arg0, z143, 580, z143, Local3, Local4, Local5)
	}
	Store(Derefof(Index(arg2, 6)), Local4)
	if(LNotEqual(Local4, Local2)) {
		err(arg0, z143, 584, z143, Local3, Local4, Local2)
	}
}

Method(m72f, 4, Serialized)
{
	Concatenate(arg0, "-m72f", arg0)

	// For loop 0
	Name(lpN0, 0)
	Name(lpC0, 0)

	// For loop 1
	Name(lpN1, 0)
	Name(lpC1, 0)

	// For loop 2
	Name(lpN2, 0)
	Name(lpC2, 0)

	// Index of offset
	Name(ib00, 0)

	// Number of offsets
	Name(nb00, 0)

	Store(arg1, lpN0)
	Store(0, lpC0)
	While(lpN0) {

		// Operands

		Multiply(lpC0, 5, Local6)
		Store(DeRefOf(Index(arg3, Local6)), ib00)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), lpN1)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local0)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local1)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local2)

		Store(0, lpC1)
		While (lpN1) {
			Store(Local0, nb00)
			Store(Local1, lpN2)
			Store(0, lpC2)

			Store(Derefof(Index(pfuo, ib00)), Local6)

			While (lpN2) {
				Store(Derefof(Index(pful, nb00)), Local7)

				// Integer source
				m72e(Concatenate(arg0, "-BInt"), arg2, Local6,
					Local7, Local2, 0)

				if (LGreater(Local7, 8)) {
					// Buffer source, shorter than field
					Store(Divide(Subtract(Local7, 1), 8), Local4)
					m72e(Concatenate(arg0, "-BShort"), arg2, Local6,
						Local7, Local2, Local4)
				}

				Divide(Local7, 8, Local5, Local4)

				if (Local5) {
					// Buffer source, longer than field, the same last byte
					m72e(Concatenate(arg0, "-BLast"), arg2, Local6,
						Local7, Local2, Add(Local4, 1))
				} else {
					// Buffer source, equal to field in length
					m72e(Concatenate(arg0, "-BEqual"), arg2, Local6,
						Local7, Local2, Local4)
				}


				// Buffer source, one byte longer than field
				if (Local5) {
					m72e(Concatenate(arg0, "-BLong"), arg2, Local6,
						Local7, Local2, Add(Local4, 2))
				} else {
					m72e(Concatenate(arg0, "-BLong"), arg2, Local6,
						Local7, Local2, Add(Local4, 1))
				}

				Increment(nb00)

				Decrement(lpN2)
				Increment(lpC2)
			}

			Increment(ib00)

			Decrement(lpN1)
			Increment(lpC1)
		}

		Increment(lpC0)
		Decrement(lpN0)
	}
}

// <test name>,
// <name of test-package>,
// <index of bit>,
// <num of bits>,
// <ext param package>:
//   <opcode of buffer to fill the ground>
//   <opcode of buffer to fill the field>
//   <Access Type opcode>
//       0 - AnyAcc, 1 - ByteAcc, 2 - WordAcc,
//       3 - DWordAcc, 4 - QWordAcc, 5 - BufferAcc
//   <Update Rule opcode>
//       0 - Preserve, 1 - WriteAsOnes, 2 - WriteAsZeros
//   <Lock Rule opcode>
//       0 - Lock, 1 - NoLock
// <size of source object in bytes>
//   Opcodes of size:
//     0 - Integer
//     <=256 - Buffer
//     >256  - String (size-256)
Method(m72e, 6, Serialized)
{
	Name(pr00, 0)

	// For loop 1
	Name(lpN1, 0)
	Name(lpC1, 0)

	// For loop 2
	Name(lpN2, 0)
	Name(lpC2, 0)

	// byte size of field
	Name(bsf0, 0)

	// byte size of region affected by field
	Name(bsr0, 0)

	// index of the first byte of field in the region
	Name(fb00, 0)

	// index of the last byte of field in the region
	Name(lb00, 0)

	Concatenate(arg0, "-m72e", arg0)

	// Num of bits have to be non-zero

	if (LEqual(arg3, 0)) {
		err(arg0, z143, 588, 0, 0, 0, 0)
		return (Ones)
	}

	Store(MBS0(arg2, arg3), bsr0)

	// =========================================
	// Prepare the buffer for filling the ground
	// =========================================

	m72c(Derefof(Index(arg4, 0)), brG0)

	// ==========================================================
	// Prepare the buffer for filling the field (over the ground)
	// ==========================================================

	m72c(Derefof(Index(arg4, 1)), brF0)

	// ======================================================
	// Prepare the benchmark buffer for Field COMPARISON with
	// Result in Local6
	// ======================================================

	// lpN1 - number of bytes minus one

	Store(arg3, Local0)
	Decrement(Local0)
	Divide(Local0, 8, Local7, lpN1)
	Divide(arg3, 8, Local7, Local0)

	Store(lpN1, bsf0)
	Increment(bsf0)
	Store(Buffer(bsf0) {}, Local6)

	if (arg5) {
		Store(arg5, Local5)
	} elseif (F64) {
		Store(8, Local5)
	} else {
		Store(4, Local5)
	}

	if (LLess(Multiply(Local5, 8), arg3)) {
		Store(Local5, lpN1)
	} else {
		Store(DeRefOf(Index(brF0, lpN1)), Local0)
		if (Local7) {
			Subtract(8, Local7, Local1)
			ShiftLeft(Local0, Local1, Local2)
			And(Local2, 0xff, Local3)
			ShiftRight(Local3, Local1, Local0)
		}
		Store(Local0, Index(Local6, lpN1))
	}

	Store(Derefof(Index(arg4, 2)), Local4) // Access Type
	Store(Derefof(Index(arg4, 3)), Local5) // Update Rule

	Store(0, lpC1)

	While (lpN1) {
		Store(DeRefOf(Index(brF0, lpC1)), Local0)
		Store(Local0, Index(Local6, lpC1))
		Decrement(lpN1)
		Increment(lpC1)
	}

	// ================================================
	// Prepare the benchmark buffer for comparison with
	// ================================================

	Store(brG0, brB0)

	Divide(arg2, 8, Local1, fb00)
	Store(DeRefOf(Index(brB0, fb00)), Local2)

	Store(bsr0, lb00)
	Decrement(lb00)
	Store(DeRefOf(Index(brB0, lb00)), Local3)

	// Take into account Update Rule
	if (Local5) {

		// Update Rule filler: 0xff or 0
		Multiply(0xff, Subtract(2, Local5), Local7)

		// Take into account Access Type
		if (LAnd(LGreater(Local4, 1), LLess(Local4, 5))) {

			// Access Width
			ShiftLeft(1, Subtract(Local4, 1), Local2)

			// Number of bytes touched by Access BEFORE field
			Divide(fb00, Local2, Local2)
			
			// Apply Rule
			Store(fb00, Local3)
			while (Local2) {
				Decrement(Local2)
				Decrement(Local3)
				Store(Local7, Index(brB0, Local3))
			}

			// Number of bytes touched by Access AFTER field
			ShiftLeft(1, Subtract(Local4, 1), Local2)
			Divide(bsr0, Local2, Local3)
			if (Local3) {
				Subtract(Local2, Local3, Local2)

				// Apply Rule
				Store(lb00, Local3)
				while (Local2) {
					Decrement(Local2)
					Increment(Local3)
					if (LEqual(Local3, RS00)) {
						break
					}
					Store(Local7, Index(brB0, Local3))
				}
			}				
		}
		Store(Local7, Local2)
		Store(Local7, Local3)
	}

	Store(sft1(Local6, Local1, arg3, Local2, Local3), Local0)
	
	Store(fb00, Local2)
	Store(Sizeof(Local0), lpN2)
	Store(0, lpC2)
	While (lpN2) {

		Store(DeRefOf(Index(Local0, lpC2)), Local1)
		Store(Local1, Index(brB0, Local2))

		Increment(Local2)

		Decrement(lpN2)
		Increment(lpC2)
	}

	if (LOr(LLess(arg3, 33), LAnd(F64, LLess(arg3, 65)))) {
		ToInteger(Local6, Local6)
	}

	switch (ToString (Mid(Derefof(Index(arg4, 5)), 1, 3))) {
	case ("730") {
			// (ByteAcc, NoLock, Preserve)
			m730(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("731") {
			// (ByteAcc, NoLock, WriteAsOnes)
			m731(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("732") {
			// (ByteAcc, NoLock, WriteAsZeros)
			m732(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("733") {
			// (WordAcc, NoLock, Preserve)
			m733(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("734") {
			// (WordAcc, NoLock, WriteAsOnes)
			m734(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("735") {
			// (WordAcc, NoLock, WriteAsZeros)
			m735(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("736") {
			// (DWordAcc, NoLock, Preserve)
			m736(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("737") {
			// (DWordAcc, NoLock, WriteAsOnes)
			m737(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("738") {
			// (DWordAcc, NoLock, WriteAsZeros)
			m738(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("739") {
			// (QWordAcc, NoLock, Preserve)
			m739(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("73a") {
			// (QWordAcc, NoLock, WriteAsOnes)
			m73a(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("73b") {
			// (QWordAcc, NoLock, WriteAsZeros)
			m73b(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("73c") {
			// (AnyAcc, NoLock, Preserve)
			m73c(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("73d") {
			// (AnyAcc, NoLock, WriteAsOnes)
			m73d(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("73e") {
			// (AnyAcc, Lock, WriteAsZeros)
			m73e(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("790") {
			// IndexFields (ByteAcc, NoLock, Preserve)
			m790(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("791") {
			// IndexFields (WordAcc, NoLock, WriteAsOnes)
			m791(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("792") {
			// IndexFields (DWordAcc, NoLock, WriteAsZeros)
			m792(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("793") {
			// IndexFields (QWordAcc, NoLock, Preserve)
			m793(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("794") {
			// IndexFields (AnyAcc, Lock, Preserve)
			m794(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("7d0") {
			// BankFields (ByteAcc, NoLock, Preserve)
			m7d0(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("7d1") {
			// BankFields (WordAcc, NoLock, WriteAsOnes)
			m7d1(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("7d2") {
			// BankFields (DWordAcc, NoLock, WriteAsZeros)
			m7d2(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("7d3") {
			// BankFields (QWordAcc, NoLock, Preserve)
			m7d3(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	case ("7d4") {
			// BankFields (AnyAcc, Lock, Preserve)
			m7d4(arg0, arg1, arg2, arg3, arg5, Local6)
		}
	default {
			err(arg0, z143, 592, 0, 0, Local4, Local5)
			return (Ones)
		}
	}

	return (Zero)
}

// Create Region Field Unit
// (ByteAcc, NoLock, Preserve)
//
// <test name>,
// <name of test-package>,
// <index of bit>,
// <num of bits>,
// <size of source object in bytes>
//   Opcodes of size:
//     0 - Integer
//     <=256 - Buffer
//     >256  - String (size-256)
// <the benchmark buffer for Field comparison with>
Method(m730, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m730", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 596, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 600, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 604, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 608, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 612, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 616, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 620, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 624, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 628, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 632, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 636, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 640, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 644, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 648, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 652, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 656, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 660, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (ByteAcc, NoLock, WriteAsOnes)
Method(m731, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m731", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 664, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 668, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 672, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 676, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 680, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 684, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 688, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 692, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 696, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 700, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 704, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 708, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 712, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 716, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 720, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 724, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 728, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (ByteAcc, NoLock, WriteAsZeros)
Method(m732, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m732", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 732, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 736, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 740, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 744, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 748, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 752, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 756, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 760, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 764, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 768, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 772, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 776, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 780, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 784, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 788, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 792, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 796, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (WordAcc, NoLock, Preserve)
Method(m733, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m733", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 800, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 804, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 808, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 812, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 816, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 820, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 824, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 828, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 832, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 836, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 840, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 844, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 848, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 852, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 856, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 860, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 864, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (WordAcc, NoLock, WriteAsOnes)
Method(m734, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m734", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 868, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 872, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 876, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 880, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 884, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 888, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 892, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 896, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 900, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 904, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 908, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 912, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 916, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 920, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 924, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 928, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 932, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (WordAcc, NoLock, WriteAsZeros)
Method(m735, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m735", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 936, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 940, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 944, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 948, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 952, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 956, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 960, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 964, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 968, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 972, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 976, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 980, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 984, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 988, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 992, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 996, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 1000, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (DWordAcc, NoLock, Preserve)
Method(m736, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m736", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 1004, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 1008, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 1012, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 1016, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 1020, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 1024, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 1028, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 1032, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 1036, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 1040, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 1044, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 1048, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 1052, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 1056, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 1060, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 1064, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 1068, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (DWordAcc, NoLock, WriteAsOnes)
Method(m737, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m737", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 1072, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 1076, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 1080, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 1084, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 1088, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 1092, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 1096, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 1100, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 1104, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 1108, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 1112, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 1116, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 1120, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 1124, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 1128, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 1132, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 1136, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (DWordAcc, NoLock, WriteAsZeros)
Method(m738, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m738", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 1140, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 1144, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 1148, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 1152, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 1156, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 1160, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 1164, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 1168, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 1172, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 1176, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 1180, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 1184, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 1188, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 1192, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 1196, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 1200, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 1204, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (QWordAcc, NoLock, Preserve)
Method(m739, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m739", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 1208, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 1212, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 1216, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 1220, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 1224, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 1228, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 1232, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 1236, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 1240, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 1244, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 1248, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 1252, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 1256, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 1260, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 1264, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 1268, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 1272, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (QWordAcc, NoLock, WriteAsOnes)
Method(m73a, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m73a", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 1276, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 1280, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 1284, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 1288, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 1292, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 1296, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 1300, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 1304, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 1308, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 1312, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 1316, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 1320, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 1324, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 1328, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 1332, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 1336, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 1340, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (QWordAcc, NoLock, WriteAsZeros)
Method(m73b, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m73b", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 1344, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 1348, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 1352, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 1356, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 1360, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 1364, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 1368, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 1372, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 1376, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 1380, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 1384, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 1388, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 1392, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 1396, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 1400, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, QWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 1404, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 1408, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (AnyAcc, NoLock, Preserve)
Method(m73c, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m73c", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 1412, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 1416, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 1420, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 1424, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 1428, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 1432, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 1436, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 1440, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 1444, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 1448, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 1452, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 1456, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 1460, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 1464, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 1468, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, Preserve) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 1472, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 1476, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (AnyAcc, NoLock, WriteAsOnes)
Method(m73d, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m73d", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 1480, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 1484, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 1488, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 1492, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 1496, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 1500, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 1504, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 1508, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 1512, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 1516, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 1520, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 1524, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 1528, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 1532, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 1536, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 1540, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 1544, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Create Region Field Unit
// (AnyAcc, Lock, WriteAsZeros)
Method(m73e, 6, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, RS00)

	Field(OPR0, ByteAcc, Lock, Preserve) {
		g001, 2048,
	}

	Concatenate(arg0, "-m73e", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f001, 6}
				Store(Refof(f001), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f003, 8}
				Store(Refof(f003), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f005, 31}
				Store(Refof(f005), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f007, 33}
				Store(Refof(f007), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f009, 64}
				Store(Refof(f009), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
			}
			default {
				err(arg0, z143, 1548, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f010, 1}
				Store(Refof(f010), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f012, 7}
				Store(Refof(f012), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f014, 9}
				Store(Refof(f014), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f016, 32}
				Store(Refof(f016), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f018, 63}
				Store(Refof(f018), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
			}
			default {
				err(arg0, z143, 1552, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f020, 1}
				Store(Refof(f020), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f021, 6}
				Store(Refof(f021), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f022, 7}
				Store(Refof(f022), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f023, 8}
				Store(Refof(f023), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f024, 9}
				Store(Refof(f024), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f025, 31}
				Store(Refof(f025), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f026, 32}
				Store(Refof(f026), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f027, 33}
				Store(Refof(f027), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f028, 63}
				Store(Refof(f028), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f029, 64}
				Store(Refof(f029), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f02a, 65}
				Store(Refof(f02a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f02b, 69}
				Store(Refof(f02b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f02c, 129}
				Store(Refof(f02c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f02d, 256}
				Store(Refof(f02d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f02e, 1023}
				Store(Refof(f02e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(0), , 2, f02f, 1983}
				Store(Refof(f02f), Local3)
			}
			default {
				err(arg0, z143, 1556, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f030, 1}
				Store(Refof(f030), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f032, 7}
				Store(Refof(f032), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f034, 9}
				Store(Refof(f034), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f036, 32}
				Store(Refof(f036), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f038, 63}
				Store(Refof(f038), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
			}
			default {
				err(arg0, z143, 1560, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f041, 6}
				Store(Refof(f041), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f043, 8}
				Store(Refof(f043), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f045, 31}
				Store(Refof(f045), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f047, 33}
				Store(Refof(f047), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f049, 64}
				Store(Refof(f049), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
			}
			default {
				err(arg0, z143, 1564, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f050, 1}
				Store(Refof(f050), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f052, 7}
				Store(Refof(f052), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f054, 9}
				Store(Refof(f054), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f056, 32}
				Store(Refof(f056), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f058, 63}
				Store(Refof(f058), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
			}
			default {
				err(arg0, z143, 1568, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f061, 6}
				Store(Refof(f061), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f063, 8}
				Store(Refof(f063), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f065, 31}
				Store(Refof(f065), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f067, 33}
				Store(Refof(f067), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f069, 64}
				Store(Refof(f069), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
			}
			default {
				err(arg0, z143, 1572, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f070, 1}
				Store(Refof(f070), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f072, 7}
				Store(Refof(f072), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f074, 9}
				Store(Refof(f074), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f076, 32}
				Store(Refof(f076), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f078, 63}
				Store(Refof(f078), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
			}
			default {
				err(arg0, z143, 1576, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
			}
			default {
				err(arg0, z143, 1580, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f090, 1}
				Store(Refof(f090), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f092, 7}
				Store(Refof(f092), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f094, 9}
				Store(Refof(f094), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f096, 32}
				Store(Refof(f096), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f098, 63}
				Store(Refof(f098), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
			}
			default {
				err(arg0, z143, 1584, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
			}
			default {
				err(arg0, z143, 1588, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
			}
			default {
				err(arg0, z143, 1592, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
			}
			default {
				err(arg0, z143, 1596, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
			}
			default {
				err(arg0, z143, 1600, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
			}
			default {
				err(arg0, z143, 1604, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
			}
			case (6) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
			}
			case (7) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
			}
			case (8) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
			}
			case (9) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
			}
			case (31) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
			}
			case (32) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
			}
			case (33) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
			}
			case (63) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
			}
			case (64) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
			}
			case (65) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
			}
			case (69) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
			}
			case (129) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
			}
			case (256) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
			}
			case (1023) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
			}
			case (1983) {
				Field(OPR0, AnyAcc, Lock, WriteAsZeros) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
			}
			default {
				err(arg0, z143, 1608, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z143, 1612, 0, 0, arg2, arg3)
		return}
	}

	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Refof(g001))
}

// Check Region Field Unit
Method(m72d, 7, Serialized)
{
	Name(pr00, 0) // Debug print flag
	Name(pr01, 0) // Index/Bank fields additional control flag

	Store(Derefof(Index(fcp0, 0)), pr01)

	if (pr00) {
		Store("==Off:Len==:", Debug)
		Store(arg2, Debug)
		Store(arg3, Debug)
	}

	Name(INT0, 0) // Expected Type
	Name(INT1, 0)

	Concatenate(arg0, "-m72d", arg0)

	// Expected type

	if (LLessEqual(arg3, 32)) {
		Store(c009, INT0)
	} elseif (LGreater(arg3, 64)) {
		Store(c00b, INT0)
	} elseif (F64) {
		Store(c009, INT0)
	} else {
		Store(c00b, INT0)
	}

	// Fill the entire region (ground)

	switch(ToInteger (pr01)) {
		case(2) {
			// Write some predefined value to Bank selection register

			Store(0xa5, Derefof(Index(fcp0, 1)))

			Store(Derefof(Derefof(Index(fcp0, 1))), Local0)
			if (LNotEqual(Local0, 0xa5)) {
				err(arg0, z143, 1616, 0, 0, Local0, 0xa5)
			}
		}
	}

	Store(Refof(arg6), Local1)
	Store(brG0, Derefof(Local1))

	switch(ToInteger (pr01)) {
		case(2) {
			// Check Bank selection register value

			Store(Derefof(Derefof(Index(fcp0, 1))), Local0)
			if (LNotEqual(Local0, Derefof(Index(fcp0, 2)))) {
				err(arg0, z143, 1620, 0, 0, Local0, Derefof(Index(fcp0, 2)))
			}
		}
	}

	if (pr00) {
		Store("==Ground==:", Debug)
		Store(Derefof(arg6), Debug)
	}

	// Fill into the field of region

	switch(ToInteger (pr01)) {
		case(2) {
			// Write some predefined value to Bank selection register

			Store(0xa5, Derefof(Index(fcp0, 1)))

			Store(Derefof(Derefof(Index(fcp0, 1))), Local0)
			if (LNotEqual(Local0, 0xa5)) {
				err(arg0, z143, 1624, 0, 0, Local0, 0xa5)
			}
		}
	}

	Store(Refof(arg1), Local1)
	if (arg4) {
		Name(b001, Buffer(arg4) {})
		Store(brF0, b001)

		Store(b001, Derefof(Local1))
	} else {
		Store(brF0, INT1)

		Store(INT1, Derefof(Local1))
	}

	switch(ToInteger (pr01)) {
		case(2) {
			// Check Bank selection register value

			Store(Derefof(Derefof(Index(fcp0, 1))), Local0)
			if (LNotEqual(Local0, Derefof(Index(fcp0, 2)))) {
				err(arg0, z143, 1628, 0, 0, Local0, Derefof(Index(fcp0, 2)))
			}
		}
	}

	// Check Type

	Store(ObjectType(arg1), Local0)
	if (LNotEqual(Local0, c00d)) {
		err(arg0, z143, 1632, 0, 0, Local0, c00d)
	}

	// Retrieve the field back

	switch(ToInteger (pr01)) {
		case(2) {
			// Write some predefined value to Bank selection register

			Store(0xa5, Derefof(Index(fcp0, 1)))

			Store(Derefof(Derefof(Index(fcp0, 1))), Local0)
			if (LNotEqual(Local0, 0xa5)) {
				err(arg0, z143, 1636, 0, 0, Local0, 0xa5)
			}
		}
	}

	Store(Derefof(arg1), Local0)

	if (pr00) {
		Store("==W:R:C==:", Debug)
		if (arg4) {
			Store(brF0, Debug)
		} else {
			Store(INT1, Debug)
		}
		Store(Local0, Debug)
		Store(arg5, Debug)
	}

	// Check Type

	Store(ObjectType(Local0), Local1)
	if (LNotEqual(Local1, INT0)) {
		err(arg0, z143, 1640, 0, 0, Local1, INT0)
	}

	if (LNotEqual(Local0, arg5)) {
			err(arg0, z143, 1644, 0, 0, Local0, arg5)
	}

	switch(ToInteger (pr01)) {
		case(2) {
			// Check Bank selection register value

			Store(Derefof(Derefof(Index(fcp0, 1))), Local0)
			if (LNotEqual(Local0, Derefof(Index(fcp0, 2)))) {
				err(arg0, z143, 1648, 0, 0, Local0, Derefof(Index(fcp0, 2)))
			}
		}
	}

	// Check Contents of Region

	switch(ToInteger (pr01)) {
		case(2) {
			// Write some predefined value to Bank selection register

			Store(0xa5, Derefof(Index(fcp0, 1)))

			Store(Derefof(Derefof(Index(fcp0, 1))), Local0)
			if (LNotEqual(Local0, 0xa5)) {
				err(arg0, z143, 1652, 0, 0, Local0, 0xa5)
			}
		}
	}

	Store(Derefof(arg6), Local1)

	switch(ToInteger (pr01)) {
		case(2) {
			// Check Bank selection register value

			Store(Derefof(Derefof(Index(fcp0, 1))), Local0)
			if (LNotEqual(Local0, Derefof(Index(fcp0, 2)))) {
				err(arg0, z143, 1656, 0, 0, Local0, Derefof(Index(fcp0, 2)))
			}
		}
	}

	if (LNotEqual(Local1, brB0)) {
		err(arg0, z143, 1660, 0, 0, Local1, brB0)
	} elseif (pr00) {
		Store("==PostGround==:", Debug)
		Store(Local1, Debug)
	}
}

// Fill the buffer
//
// <source: 0 - Zero, 1 - 0xff, else - index>
// <the target buffer for filling>
Method(m72c, 2, Serialized)
{
	Store(Sizeof(arg1), Local0)

	while(Local0) {
		Decrement(Local0)

		switch(ToInteger (arg0)) {
			case (0) {
				Store(0, Index(arg1, Local0))
			}
			case (1) {
				Store(0xff, Index(arg1, Local0))
			}
			default {
				Store(Local0, Index(arg1, Local0))
			}
		}
	}
}

// Long List of Fields
// m743(CallChain)
Method(m743, 1, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, 0x800)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		g001, 0x4000,
	}

	// Benchmark package
	Name(p000, Package(){
		//         Offset, FirstBit, NumBits, AccType
		// 0x00 - 0x0f
		Package(5){0x0000,        0,       1,       1},
		Package(5){0x0021,        7,       1,       1},
		Package(5){0x0042,        0,       2,       2},
		Package(5){0x0063,        7,       2,       2},
		Package(5){0x0084,        1,       3,       3},
		Package(5){0x00a5,        5,       3,       3},
		Package(5){0x00c6,        1,       4,       4},
		Package(5){0x00e7,        5,       4,       4},
		Package(5){0x0107,        2,       5,       0},
		Package(5){0x0126,        3,       5,       0},
		Package(5){0x0145,        2,       6,       4},
		Package(5){0x0164,        3,       6,       4},
		Package(5){0x0183,        3,       7,       3},
		Package(5){0x01a2,        1,       7,       3},
		Package(5){0x01c1,        3,       8,       2},
		Package(5){0x01e0,        1,       8,       2},

		// 0x10 - 0x1f
		Package(5){0x0200,        0,      11,       1},
		Package(5){0x0221,        7,      11,       1},
		Package(5){0x0242,        0,      12,       2},
		Package(5){0x0263,        7,      12,       2},
		Package(5){0x0284,        1,      13,       3},
		Package(5){0x02a5,        5,      13,       3},
		Package(5){0x02c6,        1,      14,       4},
		Package(5){0x02e7,        5,      14,       4},
		Package(5){0x0307,        2,      15,       0},
		Package(5){0x0326,        3,      15,       0},
		Package(5){0x0345,        2,      16,       4},
		Package(5){0x0364,        3,      16,       4},
		Package(5){0x0383,        3,      17,       3},
		Package(5){0x03a2,        1,      17,       3},
		Package(5){0x03c1,        3,      18,       2},
		Package(5){0x03e0,        1,      18,       2},

		// 0x20 - 0x2f
		Package(5){0x0400,        0,      21,       1},
		Package(5){0x0421,        7,      21,       1},
		Package(5){0x0442,        0,      22,       2},
		Package(5){0x0463,        7,      22,       2},
		Package(5){0x0484,        1,      23,       3},
		Package(5){0x04a5,        5,      23,       3},
		Package(5){0x04c6,        1,      24,       4},
		Package(5){0x04e7,        5,      24,       4},
		Package(5){0x0507,        2,      25,       0},
		Package(5){0x0526,        3,      25,       0},
		Package(5){0x0545,        2,      26,       4},
		Package(5){0x0564,        3,      26,       4},
		Package(5){0x0583,        3,      27,       3},
		Package(5){0x05a2,        1,      27,       3},
		Package(5){0x05c1,        3,      28,       2},
		Package(5){0x05e0,        1,      28,       2},

		// 0x30 - 0x3f
		Package(5){0x0600,        0,      31,       1},
		Package(5){0x0621,        7,      31,       1},
		Package(5){0x0642,        0,      32,       2},
		Package(5){0x0663,        7,      32,       2},
		Package(5){0x0684,        1,      31,       3},
		Package(5){0x06a5,        5,      30,       3},
		Package(5){0x06c6,        1,      29,       4},
		Package(5){0x06e7,        5,      28,       4},
		Package(5){0x0707,        2,      27,       0},
		Package(5){0x0726,        3,      26,       0},
		Package(5){0x0745,        2,      25,       4},
		Package(5){0x0764,        3,      24,       4},
		Package(5){0x0783,        3,      23,       3},
		Package(5){0x07a2,        1,      22,       3},
		Package(5){0x07c1,        3,      21,       2},
		Package(5){0x07e0,        1,      20,       2},
	})

	Name(i000, 0)

	Concatenate(arg0, "-m743", arg0)

	Store("TEST: m743, Check Long List of Fields", Debug)

	Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {

		// 0x00 - 0x0f
		// AccessAs(ByteAcc),
		Offset(0x0000), , 0, f000, 1,
		Offset(0x0021), , 7, f001, 1,
		AccessAs(WordAcc),
		Offset(0x0042), , 0, f002, 2,
		Offset(0x0063), , 7, f003, 2,
		AccessAs(DWordAcc),
		Offset(0x0084), , 1, f004, 3,
		Offset(0x00a5), , 5, f005, 3,
		AccessAs(QWordAcc),
		Offset(0x00c6), , 1, f006, 4,
		Offset(0x00e7), , 5, f007, 4,
		AccessAs(AnyAcc),
		Offset(0x0107), , 2, f008, 5,
		Offset(0x0126), , 3, f009, 5,
		AccessAs(QWordAcc),
		Offset(0x0145), , 2, f00a, 6,
		Offset(0x0164), , 3, f00b, 6,
		AccessAs(DWordAcc),
		Offset(0x0183), , 3, f00c, 7,
		Offset(0x01a2), , 1, f00d, 7,
		AccessAs(WordAcc),
		Offset(0x01c1), , 3, f00e, 8,
		Offset(0x01e0), , 1, f00f, 8,

		// 0x10 - 0x1f
		AccessAs(ByteAcc),
		Offset(0x0200), , 0, f010, 11,
		Offset(0x0221), , 7, f011, 11,
		AccessAs(WordAcc),
		Offset(0x0242), , 0, f012, 12,
		Offset(0x0263), , 7, f013, 12,
		AccessAs(DWordAcc),
		Offset(0x0284), , 1, f014, 13,
		Offset(0x02a5), , 5, f015, 13,
		AccessAs(QWordAcc),
		Offset(0x02c6), , 1, f016, 14,
		Offset(0x02e7), , 5, f017, 14,
		AccessAs(AnyAcc),
		Offset(0x0307), , 2, f018, 15,
		Offset(0x0326), , 3, f019, 15,
		AccessAs(QWordAcc),
		Offset(0x0345), , 2, f01a, 16,
		Offset(0x0364), , 3, f01b, 16,
		AccessAs(DWordAcc),
		Offset(0x0383), , 3, f01c, 17,
		Offset(0x03a2), , 1, f01d, 17,
		AccessAs(WordAcc),
		Offset(0x03c1), , 3, f01e, 18,
		Offset(0x03e0), , 1, f01f, 18,

		// 0x20 - 0x2f
		AccessAs(ByteAcc),
		Offset(0x0400), , 0, f020, 21,
		Offset(0x0421), , 7, f021, 21,
		AccessAs(WordAcc),
		Offset(0x0442), , 0, f022, 22,
		Offset(0x0463), , 7, f023, 22,
		AccessAs(DWordAcc),
		Offset(0x0484), , 1, f024, 23,
		Offset(0x04a5), , 5, f025, 23,
		AccessAs(QWordAcc),
		Offset(0x04c6), , 1, f026, 24,
		Offset(0x04e7), , 5, f027, 24,
		AccessAs(AnyAcc),
		Offset(0x0507), , 2, f028, 25,
		Offset(0x0526), , 3, f029, 25,
		AccessAs(QWordAcc),
		Offset(0x0545), , 2, f02a, 26,
		Offset(0x0564), , 3, f02b, 26,
		AccessAs(DWordAcc),
		Offset(0x0583), , 3, f02c, 27,
		Offset(0x05a2), , 1, f02d, 27,
		AccessAs(WordAcc),
		Offset(0x05c1), , 3, f02e, 28,
		Offset(0x05e0), , 1, f02f, 28,

		// 0x30 - 0x3f
		AccessAs(ByteAcc),
		Offset(0x0600), , 0, f030, 31,
		Offset(0x0621), , 7, f031, 31,
		AccessAs(WordAcc),
		Offset(0x0642), , 0, f032, 32,
		Offset(0x0663), , 7, f033, 32,
		AccessAs(DWordAcc),
		Offset(0x0684), , 1, f034, 31,
		Offset(0x06a5), , 5, f035, 30,
		AccessAs(QWordAcc),
		Offset(0x06c6), , 1, f036, 29,
		Offset(0x06e7), , 5, f037, 28,
		AccessAs(AnyAcc),
		Offset(0x0707), , 2, f038, 27,
		Offset(0x0726), , 3, f039, 26,
		AccessAs(QWordAcc),
		Offset(0x0745), , 2, f03a, 25,
		Offset(0x0764), , 3, f03b, 24,
		AccessAs(DWordAcc),
		Offset(0x0783), , 3, f03c, 23,
		Offset(0x07a2), , 1, f03d, 22,
		AccessAs(WordAcc),
		Offset(0x07c1), , 3, f03e, 21,
		Offset(0x07e0), , 1, f03f, 20,
	}

	// Region field Zeroing
	Store(0, g001)

	Store(4, Local0)
	Store(0, Local1)

	while(Local0) {
		Store(16, Local2)
		Store(0, Local3)

		while(Local2) {
			switch(ToInteger (Local1)) {
				case (0) {
					switch(ToInteger (Local3)) {
						case (0) { Store(Refof(f000), Local4) }
						case (1) { Store(Refof(f001), Local4) }
						case (2) { Store(Refof(f002), Local4) }
						case (3) { Store(Refof(f003), Local4) }
						case (4) { Store(Refof(f004), Local4) }
						case (5) { Store(Refof(f005), Local4) }
						case (6) { Store(Refof(f006), Local4) }
						case (7) { Store(Refof(f007), Local4) }
						case (8) { Store(Refof(f008), Local4) }
						case (9) { Store(Refof(f009), Local4) }
						case (10) { Store(Refof(f00a), Local4) }
						case (11) { Store(Refof(f00b), Local4) }
						case (12) { Store(Refof(f00c), Local4) }
						case (13) { Store(Refof(f00d), Local4) }
						case (14) { Store(Refof(f00e), Local4) }
						case (15) { Store(Refof(f00f), Local4) }
						default {
							err(arg0, z143, 1664, 0, 0, Local1, Local3)
							return
						}
					}
				}
				case (1) {
					switch(ToInteger (Local3)) {
						case (0) { Store(Refof(f010), Local4) }
						case (1) { Store(Refof(f011), Local4) }
						case (2) { Store(Refof(f012), Local4) }
						case (3) { Store(Refof(f013), Local4) }
						case (4) { Store(Refof(f014), Local4) }
						case (5) { Store(Refof(f015), Local4) }
						case (6) { Store(Refof(f016), Local4) }
						case (7) { Store(Refof(f017), Local4) }
						case (8) { Store(Refof(f018), Local4) }
						case (9) { Store(Refof(f019), Local4) }
						case (10) { Store(Refof(f01a), Local4) }
						case (11) { Store(Refof(f01b), Local4) }
						case (12) { Store(Refof(f01c), Local4) }
						case (13) { Store(Refof(f01d), Local4) }
						case (14) { Store(Refof(f01e), Local4) }
						case (15) { Store(Refof(f01f), Local4) }
						default {
							err(arg0, z143, 1668, 0, 0, Local1, Local3)
							return
						}
					}
				}
				case (2) {
					switch(ToInteger (Local3)) {
						case (0) { Store(Refof(f020), Local4) }
						case (1) { Store(Refof(f021), Local4) }
						case (2) { Store(Refof(f022), Local4) }
						case (3) { Store(Refof(f023), Local4) }
						case (4) { Store(Refof(f024), Local4) }
						case (5) { Store(Refof(f025), Local4) }
						case (6) { Store(Refof(f026), Local4) }
						case (7) { Store(Refof(f027), Local4) }
						case (8) { Store(Refof(f028), Local4) }
						case (9) { Store(Refof(f029), Local4) }
						case (10) { Store(Refof(f02a), Local4) }
						case (11) { Store(Refof(f02b), Local4) }
						case (12) { Store(Refof(f02c), Local4) }
						case (13) { Store(Refof(f02d), Local4) }
						case (14) { Store(Refof(f02e), Local4) }
						case (15) { Store(Refof(f02f), Local4) }
						default {
							err(arg0, z143, 1672, 0, 0, Local1, Local3)
							return
						}
					}
				}
				case (3) {
					switch(ToInteger (Local3)) {
						case (0) { Store(Refof(f030), Local4) }
						case (1) { Store(Refof(f031), Local4) }
						case (2) { Store(Refof(f032), Local4) }
						case (3) { Store(Refof(f033), Local4) }
						case (4) { Store(Refof(f034), Local4) }
						case (5) { Store(Refof(f035), Local4) }
						case (6) { Store(Refof(f036), Local4) }
						case (7) { Store(Refof(f037), Local4) }
						case (8) { Store(Refof(f038), Local4) }
						case (9) { Store(Refof(f039), Local4) }
						case (10) { Store(Refof(f03a), Local4) }
						case (11) { Store(Refof(f03b), Local4) }
						case (12) { Store(Refof(f03c), Local4) }
						case (13) { Store(Refof(f03d), Local4) }
						case (14) { Store(Refof(f03e), Local4) }
						case (15) { Store(Refof(f03f), Local4) }
						default {
							err(arg0, z143, 1676, 0, 0, Local1, Local3)
							return
						}
					}
				}
				default {
					err(arg0, z143, 1680, 0, 0, Local1, Local3)
					return
				}
			}

			Store(Refof(Local4), Local5)

			// Fill the field
			Store(0x5555555555555555, DeRefof(Local5))

			Increment(Local3)
			Decrement(Local2)
		}
		Increment(Local1)
		Decrement(Local0)
	}

	// Retrieve Region field
	Store(g001, Local6)

	// Check Region field

	Store(4, Local0)
	Store(0, Local1)

	while(Local0) {
		Store(16, Local2)
		Store(0, Local3)

		while(Local2) {

			// Take Benchmark subpackage
			Store(Derefof(Index(p000, Add(Multiply(16, Local1), Local3))), Local4)

			// Check contents of the field

			// Get Benchmark buffer
			Store(
				sft1(Buffer(){0x55,0x55,0x55,0x55,0x55,0x55,0x55,0x55},
					Derefof(Index(Local4, 1)), Derefof(Index(Local4, 2)), 0xff, 0xff),
				Local5)

			// Get Resulting subbuffer
			Mid(Local6, Derefof(Index(Local4, 0)), Sizeof (Local5), Local7)

			if (LNotEqual(Local7, Local5)) {
				err(arg0, z143, 1684, z143, Add(Multiply(16, Local1), Local3), Local7, Local5)
			}

			// Check contents of the external accessed memory

			// Access alignment
			Store(1, Local5)
			if (LEqual(Derefof(Index(Local4, 3)), 2)) {
				Add(Local5, 1, Local5)
			} elseif (LEqual(Derefof(Index(Local4, 3)), 3)) {
				Add(Local5, 3, Local5)
			} elseif (LEqual(Derefof(Index(Local4, 3)), 4)) {
				Add(Local5, 7, Local5)
			}

			Divide(Derefof(Index(Local4, 0)), Local5, Local7)

			// Check the last byte in the previous access unit
			if (Subtract(Derefof(Index(Local4, 0)), Local7)) {
				if (LNotEqual(
						Derefof(Index(Local6,
							Subtract(Subtract(Derefof(Index(Local4, 0)), Local7), 1))),
						0x00)) {
					err(arg0, z143, 1688, z143, Add(Multiply(16, Local1), Local3),
						Derefof(Index(Local6, Subtract(Derefof(Index(Local4, 0)), Local7))),
						0x00
					)
				}
			}

			// Check the bytes in the first access unit
			while (Local7) {
				if (LNotEqual(
						Derefof(Index(Local6, Subtract(Derefof(Index(Local4, 0)), Local7))),
						0xff)) {
					err(arg0, z143, 1692, z143, Add(Multiply(16, Local1), Local3),
						Derefof(Index(Local6, Subtract(Derefof(Index(Local4, 0)), Local7))),
						0xff
					)
				}
				Decrement(Local7)
			}

			Add(Derefof(Index(Local4, 1)), Derefof(Index(Local4, 2)), Local7)
			Divide(Local7, 8, Local7, i000)

			if (Local7) {
				Increment(i000)
			}
			Add(Derefof(Index(Local4, 0)), i000, i000)

			Divide(i000, Local5, Local7)

			if (Local7) {
				Subtract(Local5, Local7, Local7)
			}

			// Check the first byte in the next access unit
			if (LNotEqual(
					Derefof(Index(Local6, Add(i000, Local7))),
					0x00)) {
				err(arg0, z143, 1696, z143, Add(Multiply(16, Local1), Local3),
					Derefof(Index(Local6, Add(i000, Local7))),
					0x00
				)
			}

			// Check the bytes in the last access unit
			while (Local7) {
				Decrement(Local7)
				if (LNotEqual(
						Derefof(Index(Local6, Add(i000, Local7))),
						0xff)) {
					err(arg0, z143, 1700, z143, Add(Multiply(16, Local1), Local3),
						Derefof(Index(Local6, Add(i000, Local7))),
						0xff
					)
				}
			}

			Increment(Local3)
			Decrement(Local2)
		}
		Increment(Local1)
		Decrement(Local0)
	}
}

// Large Offset
// m744(CallChain)
Method(m744, 1, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, 0x2000000)

	// The next Offset value (0x2000000) causes crash of iASL
	Field(OPR0, ByteAcc, NoLock, Preserve) {
		Offset(0x1ffffff), f000, 8,
	}

	// The next offset bit (0xffffffc) causes crash of iASL
	Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
		, 0xffffffb, f001, 1,
	}

	// The next bits length (0xffffffc) causes crash of iASL
	Field(OPR0, ByteAcc, NoLock, WriteAsOnes) {
		f002, 0xffffffb,
	}

	Concatenate(arg0, "-m744", arg0)

	Store("TEST: m744, Check large Field offsets", Debug)

	Store(0x1, f001)
	if (LNotEqual(f000, 0x08)) {
		err(arg0, z143, 1704, 0, 0, f000, 0x08)
    }
}

// Run-method
Method(RFC0,, Serialized)
{
	Name(ts, "RFC0")

	// Check common access: ByteAcc, NoLock, Preserve
	SRMT("m710")
	m710(ts)

	// Check common access: ByteAcc, NoLock, WriteAsOnes
	SRMT("m711")
	m711(ts)

	// Check common access: ByteAcc, NoLock, WriteAsZeros
	SRMT("m712")
	m712(ts)

	// Check common access: WordAcc, NoLock, Preserve
	SRMT("m713")
	m713(ts)

	// Check common access: WordAcc, NoLock, WriteAsOnes
	SRMT("m714")
	m714(ts)

	// Check common access: WordAcc, NoLock, WriteAsZeros
	SRMT("m715")
	m715(ts)

	// Check common access: DWordAcc, NoLock, Preserve
	SRMT("m716")
	m716(ts)

	// Check common access: DWordAcc, NoLock, WriteAsOnes
	SRMT("m717")
	m717(ts)

	// Check common access: DWordAcc, NoLock, WriteAsZeros
	SRMT("m718")
	m718(ts)

	// Check common access: QWordAcc, NoLock, Preserve
	SRMT("m719")
	m719(ts)

	// Check common access: QWordAcc, NoLock, WriteAsOnes
	SRMT("m71a")
	m71a(ts)

	// Check common access: QWordAcc, NoLock, WriteAsZeros
	SRMT("m71b")
	m71b(ts)

	// Check common access: AnyAcc, NoLock, Preserve
	SRMT("m71c")
	m71c(ts)

	// Check common access: AnyAcc, NoLock, WriteAsOnes
	SRMT("m71d")
	m71d(ts)

	// Check common access: AnyAcc, NoLock, WriteAsZeros
	SRMT("m71e")
	m71e(ts)

	// Check SMBus/BufferAcc access
	SRMT("m71f")
	m71f(ts)

	// Check GeneralPurposeIo/ByteAcc access
	SRMT("m764")
	m764(ts)

	// Check IPMI/BufferAcc access
	SRMT("m768")
	m768(ts)

	// Check GenericSerialBus/BufferAcc access
	SRMT("m740")
	m740(ts)

	// Splitting of Fields
	SRMT("m742")
	m742(ts)

	// Long List of Fields
	SRMT("m743")
	m743(ts)

	// Large Offset
	SRMT("m744")
	m744(ts)
}
