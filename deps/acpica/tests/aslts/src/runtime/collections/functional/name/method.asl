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
 * Miscellaneous named object creation
 */

Name(z133, 133)

/*
 * This sub-test is intended to comprehensively verify
 * the Control Method declaration syntax implementation.
 *
 * Declare the Control Method Objects of different signature,
 * check that properly specified or default arguments values
 * provide required functionality.
 *
 *    17.5.75    Method (Declare Control Method)
 *    Syntax
 * Method (MethodName, NumArgs, SerializeRule, SyncLevel,
 *         ReturnType, ParameterTypes) {TermList}
 *
 *    Validated Assertions:
 *
 * - Control Method declaration creates an Object in the ACPI
 *   namespace which can be referred by the specified MethodName
 *   either to initiate its invocation or to obtain its AML Object
 *   type. Also MethodName can be used to save a copy of the Object
 *   or a reference to it in another AML Object.
 *
 * - ASL compiler should allow only a Namestring data type in the
 *   MethodName position.
 *
 * - ASL compiler should allow only an Type3Opcode (integer) constant
 *   expression of the value in the range 0-7 in the NumArgs position.
 *   NumArgs is optional argument.
 *
 * - ASL compiler should allow only the keywords 'NotSerialized'
 *   and 'Serialized' in the SerializeRule position. SerializeRule
 *   is optional argument.
 *
 * - ASL compiler should allow only an Type3Opcode (integer) constant
 *   expression of the value in the range 0-15 in the SyncLevel position.
 *   SyncLevel is optional argument. If no SyncLevel is specified, SyncLevel
 *   0 is assumed.
 *
 * - ASL compiler should allow only an ObjectTypeKeyword or
 *   a comma-separated ObjectTypeKeywords enclosed with curly
 *   brackets (OTK package) in the ReturnType position. ReturnType
 *   is optional argument. If no ReturnType is specified, ReturnType
 *   UnknownObj is assumed.
 *   ObjectTypeKeyword := UnknownObj | IntObj | StrObj | BuffObj |
 *                        PkgObj | FieldUnitObj | DeviceObj | EventObj |
 *                        MethodObj | MutexObj | OpRegionObj | PowerResObj |
 *                        ThermalZoneObj | BuffFieldObj | DDBHandleObj
 *
 * - Every ASL data type should have a respective unique ObjectType Keyword.
 *
 * - ASL compiler should report an error when an actual Object specified
 *   to be returned is of inappropriate type.
 *
 * - ASL compiler should report an error when there is at least one
 *   control path in the method that returns no any actual Object.
 *
 * - ASL compiler should report an error when some different from
 *   UnknownObj ObjectType Keyword specified in the ReturnType position
 *   but no any actual Object specified to be returned.
 *
 * - ASL compiler should allow only an OTK package or a package
 *   containing OTK packages along with ObjectTypeKeywords in the
 *   ParameterTypes position.
 *
 * - ASL compiler should report an error when ParameterTypes is specified
 *   and the number of members in the ParameterTypes package don't match
 *   NumArgs.
 *
 * - ASL compiler should report an error when an actual Object
 *   specified to be a respective argument of the Method is of
 *   inappropriate type.
 *
 * - System software should execute a control method by referencing
 *   the objects in the Method body in order.
 *
 * - Method opens a name scope. All namespace references that occur
 *   during the method execution are relative to the Method package
 *   location.
 *
 * - If the  method is declared as Serialized, it can be called
 *   recursively, maybe, through another auxiliary method.
 *
 * - One method declared as Serialized can call another
 *   one declared as Serialized too when the SyncLevel of
 *   the second method is not less than that of the first.
 *
 * - The method declared as Serialized can acquire an Mutex
 *   when the SyncLevel of the Mutex is not less than that of
 *   the method.
 *
 * - If some method acquired an Mutex it can call another one
 *   declared as Serialized when the SyncLevel of the called
 *   method is not less than that of the Mutex.
 *
 * - All Acquire terms must refer to a synchronization object
 *   with an equal or greater SyncLevel to the current Method level.
 *
 * - The method declared as Serialized can release an Mutex
 *   when the SyncLevel of the Mutex is not less than that of
 *   the method.
 *
 * - All namespace objects created by a method should be destroyed
 *   when method execution exits.
 *
 */

// Flags of types of Computational Data Objects
// (Fields and Integer, String, Buffer)
Name(bz00, Buffer() {0,1,1,1,0,1,0,0,0,0,0,0,0,0,1,0,0,0})

// Check Result of operation on equal to Benchmark value
// m680(<method name>,
//	<internal type of error if it occurs>,
//	<Result>,
//	<Benchmark value>)
Method(m205, 4)
{
	Store(ObjectType(arg2), Local0)
	Store(ObjectType(arg3), Local1)
	if (LNotEqual(Local0, Local1)) {
		err(Concatenate(arg0, "-OType"), z133, arg1, 0, 0, Local0, Local1)
		Return (1)
	} elseif (Derefof(Index(bz00, Local0))) {
		if (LNot(y119)) {
			if (LEqual(Local1, 1)) {
				// Cast 64-bit to 32-bit
				if (LNot(F64)) {
					Store(arg3, arg3)
				}
			}
		}
		if (LNotEqual(arg2, arg3)) {
			err(arg0, z133, arg1, 0, 0, arg2, arg3)
			Return (1)
		}
	} elseif (LEqual(Local0, 8)) {
		// Methods, compare the results of them
		Store(m209(Concatenate(arg0, "-Method"), arg1, arg2, arg3), Local2)
		Return (Local2)
	} elseif (LEqual(Local0, 4)) {
		// Packages
		Store(m20a(Concatenate(arg0, "-Pack"), arg1, arg2, arg3), Local2)
		Return (Local2)
	}
	Return (0)
}

// Check that Results of the Methods are equal each other
Method(m209, 4, Serialized)
{
	Name(MMM0, 0)
	Name(MMM1, 0)

	CopyObject(arg2, MMM0)
	CopyObject(arg3, MMM1)

	Return (m205(arg0, arg1, MMM0, MMM1))
}

// Check that two Packages are equal each other
Method(m20a, 4)
{
	Store(Sizeof(arg3), Local0)
	if (LNotEqual(Sizeof(arg2), Local0)) {
		err(Concatenate(arg0, "-Size"), z133, arg1, 0, 0, Sizeof(arg2), Local0)
		Return (1)
	}
	While (Local0) {
		Decrement(Local0)
		Store(ObjectType(Derefof(Index(arg2, Local0))), Local1)
		Store(ObjectType(Derefof(Index(arg3, Local0))), Local2)
		if (LNotEqual(Local1, Local2)) {
			// ObjectType is corrupted
			err(Concatenate(arg0, "-OType"), z133, arg1, 0, 0, Local1, Local2)
			Return (1)
		} elseif (Derefof(Index(bz00, Local1))) {
			// the computational data type
			if (LNotEqual(
					Derefof(Index(arg2, Local0)),
					Derefof(Index(arg3, Local0)))) {
				// The value is corrupted
				err(arg0, z133, arg1, 0, 0, Derefof(Index(arg2, Local0)), Derefof(Index(arg3, Local0)))
				Return (1)
			}
		}
	}
	Return (0)
}

Scope(\_SB){
	Method(m206){}
}

Method(m207,, Serialized)
{
	Name(ts, "m207")

	Method(m240)
	{
		Method(mm00) {Return ("\\m207.m240.mm00")}
		Method(\_SB.m206.mm00) {Return ("\\_SB.m206.mm00")}
	
		m205(ts, 1, ObjectType(mm00), 8)
		m205(ts, 2, mm00(), "\\m207.m240.mm00")

		m205(ts, 3, ObjectType(\m207.m240.mm00), 8)
		m205(ts, 4, \m207.m240.mm00(), "\\m207.m240.mm00")

		m205(ts, 5, ObjectType(^m240.mm00), 8)
		m205(ts, 6, ^m240.mm00(), "\\m207.m240.mm00")

		m205(ts, 7, ObjectType(\_SB.m206.mm00), 8)
		m205(ts, 8, \_SB.m206.mm00(), "\\_SB.m206.mm00")
	}

	Method(m241)
	{
		Method(mm10) {Return ("\\m207.m241.mm10")}
		Method(mm20, ) {Return ("\\m207.m241.mm20")}
		Method(mm30, , ) {Return ("\\m207.m241.mm30")}
		Method(mm40, , , ) {Return ("\\m207.m241.mm40")}
		Method(mm50, , , , ) {Return ("\\m207.m241.mm50")}
		Method(mm60, , , , , ) {Return ("\\m207.m241.mm60")}

		Method(mm00, 0) {Return ("\\m207.m241.mm00")}
		Method(mm01, 1) {Return ("\\m207.m241.mm01")}
		Method(mm02, 2) {Return ("\\m207.m241.mm02")}
		Method(mm03, 3) {Return ("\\m207.m241.mm03")}
		Method(mm04, 4) {Return ("\\m207.m241.mm04")}
		Method(mm05, 5) {Return ("\\m207.m241.mm05")}
		Method(mm06, 6) {Return ("\\m207.m241.mm06")}
		Method(mm07, 7) {Return ("\\m207.m241.mm07")}

		// Numargs as Type3Opcode (integer) constant expression
// Invalid checksum warning
//		Method(mm09, Add(6, 1)) {Return ("\\m207.m241.mm09")}

		m205(ts,  9, ObjectType(mm10), 8)
		m205(ts, 10, mm10(), "\\m207.m241.mm10")

		m205(ts, 11, ObjectType(mm20), 8)
		m205(ts, 12, mm20(), "\\m207.m241.mm20")

		m205(ts, 13, ObjectType(mm30), 8)
		m205(ts, 14, mm30(), "\\m207.m241.mm30")

		m205(ts, 15, ObjectType(mm40), 8)
		m205(ts, 16, mm40(), "\\m207.m241.mm40")

		m205(ts, 17, ObjectType(mm50), 8)
		m205(ts, 18, mm50(), "\\m207.m241.mm50")

		m205(ts, 19, ObjectType(mm60), 8)
		
		if (y157) {
			m205(ts, 20, mm60(), "\\m207.m241.mm60")
		}

		m205(ts, 21, ObjectType(mm00), 8)
		m205(ts, 22, mm00(), "\\m207.m241.mm00")

		m205(ts, 23, ObjectType(mm01), 8)
		m205(ts, 24, mm01(0), "\\m207.m241.mm01")

		m205(ts, 25, ObjectType(mm02), 8)
		m205(ts, 26, mm02(0, 1), "\\m207.m241.mm02")

		m205(ts, 27, ObjectType(mm03), 8)
		m205(ts, 28, mm03(0, 1, 2), "\\m207.m241.mm03")

		m205(ts, 29, ObjectType(mm04), 8)
		m205(ts, 30, mm04(0, 1, 2, 3), "\\m207.m241.mm04")

		m205(ts, 31, ObjectType(mm05), 8)
		m205(ts, 32, mm05(0, 1, 2, 3, 4), "\\m207.m241.mm05")

		m205(ts, 33, ObjectType(mm06), 8)
		m205(ts, 34, mm06(0, 1, 2, 3, 4, 5), "\\m207.m241.mm06")

		m205(ts, 35, ObjectType(mm07), 8)
		m205(ts, 36, mm07(0, 1, 2, 3, 4, 5, 6), "\\m207.m241.mm07")

// Invalid checksum warning
//		m205(ts, 37, ObjectType(mm09), 8)
// Too many arguments ^  (MM09 requires 0)
//		m205(ts, 38, mm09(0, 1, 2, 3, 4, 5, 6), "\\m207.m241.mm09")
	}

	Method(m242)
	{
		Method(mm10, , NotSerialized) {Return ("\\m207.m242.mm10")}
		Method(mm20, , Serialized) {Return ("\\m207.m242.mm20")}
		Method(mm30, , NotSerialized, ) {Return ("\\m207.m242.mm30")}
		Method(mm40, , Serialized, , ) {Return ("\\m207.m242.mm40")}
		Method(mm50, , NotSerialized, , , ) {Return ("\\m207.m242.mm50")}
		Method(mm60, , Serialized, , , ) {Return ("\\m207.m242.mm60")}

		Method(mm00, 0, Serialized, 0) {Return ("\\m207.m242.mm00")}
		Method(mm01, 1, Serialized, 1) {Return ("\\m207.m242.mm01")}
		Method(mm02, 2, Serialized, 2) {Return ("\\m207.m242.mm02")}
		Method(mm03, 3, Serialized, 3) {Return ("\\m207.m242.mm03")}
		Method(mm04, 4, Serialized, 4) {Return ("\\m207.m242.mm04")}
		Method(mm05, 5, Serialized, 5) {Return ("\\m207.m242.mm05")}
		Method(mm06, 6, Serialized, 6) {Return ("\\m207.m242.mm06")}
		Method(mm07, 7, Serialized, 7) {Return ("\\m207.m242.mm07")}
		Method(mm08, 0, Serialized, 8) {Return ("\\m207.m242.mm08")}
		Method(mm09, 1, Serialized, 9) {Return ("\\m207.m242.mm09")}
		Method(mm0a, 2, Serialized, 10) {Return ("\\m207.m242.mm0a")}
		Method(mm0b, 3, Serialized, 11) {Return ("\\m207.m242.mm0b")}
		Method(mm0c, 4, Serialized, 12) {Return ("\\m207.m242.mm0c")}
		Method(mm0d, 5, Serialized, 13) {Return ("\\m207.m242.mm0d")}
		Method(mm0e, 6, Serialized, 14) {Return ("\\m207.m242.mm0e")}
		Method(mm0f, 7, Serialized, 15) {Return ("\\m207.m242.mm0f")}

		// Numargs as Type3Opcode (integer) constant expression
// Invalid checksum warning
//		Method(mm70, Add(6, 1), NotSerialized) {Return ("\\m207.m242.mm70")}

		// SyncLevel as Type3Opcode (integer) constant expression
		Method(mm80, 7, Serialized, Add(14, 1)) {Return ("\\m207.m242.mm80")}

		// Both Numargs and SyncLevel as Type3Opcode (integer) constant expressions
// Invalid checksum warning
//		Method(mm90, Add(6, 1), Serialized, Add(14, 1)) {Return ("\\m207.m242.mm90")}

		m205(ts, 39, ObjectType(mm10), 8)
		m205(ts, 40, mm10(), "\\m207.m242.mm10")

		m205(ts, 41, ObjectType(mm10), 8)
		m205(ts, 42, mm20(), "\\m207.m242.mm20")

		m205(ts, 43, ObjectType(mm10), 8)
		m205(ts, 44, mm30(), "\\m207.m242.mm30")

		m205(ts, 45, ObjectType(mm10), 8)
		m205(ts, 46, mm40(), "\\m207.m242.mm40")

		m205(ts, 47, ObjectType(mm10), 8)
		if (y157) {
			m205(ts, 48, mm50(), "\\m207.m242.mm50")
		}

		m205(ts, 49, ObjectType(mm10), 8)
		if (y157) {
			m205(ts, 50, mm60(), "\\m207.m242.mm60")
		}

		m205(ts, 51, ObjectType(mm00), 8)
		m205(ts, 52, mm00(), "\\m207.m242.mm00")

		m205(ts, 53, ObjectType(mm01), 8)
		m205(ts, 54, mm01(0), "\\m207.m242.mm01")

		m205(ts, 55, ObjectType(mm02), 8)
		m205(ts, 56, mm02(0, 1), "\\m207.m242.mm02")

		m205(ts, 57, ObjectType(mm03), 8)
		m205(ts, 58, mm03(0, 1, 2), "\\m207.m242.mm03")

		m205(ts, 59, ObjectType(mm04), 8)
		m205(ts, 60, mm04(0, 1, 2, 3), "\\m207.m242.mm04")

		m205(ts, 61, ObjectType(mm05), 8)
		m205(ts, 62, mm05(0, 1, 2, 3, 4), "\\m207.m242.mm05")

		m205(ts, 63, ObjectType(mm06), 8)
		m205(ts, 64, mm06(0, 1, 2, 3, 4, 5), "\\m207.m242.mm06")

		m205(ts, 65, ObjectType(mm07), 8)
		m205(ts, 66, mm07(0, 1, 2, 3, 4, 5, 6), "\\m207.m242.mm07")

		m205(ts, 67, ObjectType(mm00), 8)
		m205(ts, 68, mm08(), "\\m207.m242.mm08")

		m205(ts, 69, ObjectType(mm01), 8)
		m205(ts, 70, mm09(0), "\\m207.m242.mm09")

		m205(ts, 71, ObjectType(mm02), 8)
		m205(ts, 72, mm0a(0, 1), "\\m207.m242.mm0a")

		m205(ts, 73, ObjectType(mm03), 8)
		m205(ts, 74, mm0b(0, 1, 2), "\\m207.m242.mm0b")

		m205(ts, 75, ObjectType(mm04), 8)
		m205(ts, 76, mm0c(0, 1, 2, 3), "\\m207.m242.mm0c")

		m205(ts, 77, ObjectType(mm05), 8)
		m205(ts, 78, mm0d(0, 1, 2, 3, 4), "\\m207.m242.mm0d")

		m205(ts, 79, ObjectType(mm06), 8)
		m205(ts, 80, mm0e(0, 1, 2, 3, 4, 5), "\\m207.m242.mm0e")

		m205(ts, 81, ObjectType(mm07), 8)
		m205(ts, 82, mm0f(0, 1, 2, 3, 4, 5, 6), "\\m207.m242.mm0f")

// Invalid checksum warning
//		m205(ts, 83, ObjectType(mm70), 8)
//	Too many arguments ^  (MM70 requires 0)
//		m205(ts, 84, mm70(0, 1, 2, 3, 4, 5, 6), "\\m207.m242.mm70")

		m205(ts, 85, ObjectType(mm80), 8)
// Outstanding allocations
//		m205(ts, 86, mm80(0, 1, 2, 3, 4, 5, 6), "\\m207.m242.mm80")

// Invalid checksum warning
//		m205(ts, 87, ObjectType(mm90), 8)
//	Too many arguments ^  (MM90 requires 0)
//		m205(ts, 88, mm90(0, 1, 2, 3, 4, 5, 6), "\\m207.m242.mm90")
	}

	// Integer
	Name(INT0, 0xfedcba9876543210)

	// String
	Name(STR0, "source string")

	// Buffer
	Name(BUF0, Buffer(9){9,8,7,6,5,4,3,2,1})

	// Initializer of Fields
	Name(BUF2, Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15})

	// Base of Buffer Fields
	Name(BUFZ, Buffer(48){})

	// Package
	Name(PAC0, Package(3) {
		0xfedcba987654321f,
		"test package",
		Buffer(9){19,18,17,16,15,14,13,12,11},
	})

	// Operation Region
	OperationRegion(OPR0, SystemMemory, 0, 48)

	// Field Unit
	Field(OPR0, ByteAcc, NoLock, Preserve) {
		FLU0, 69,
		FLU2, 64,
		FLU4, 32,
	}

	// Device
	Device(DEV0) {Name(s000, "DEV0")}

	// Event
	Event(EVE0)

	// Method
	Method(MMM0) {Return ("ff0X")}

	// Mutex
	Mutex(MTX0, 0)

	// Power Resource
	PowerResource(PWR0, 0, 0) {Name(s000, "PWR0")}

	// Processor
	Processor(CPU0, 0x0, 0xFFFFFFFF, 0x0) {Name(s000, "CPU0")}

	// Thermal Zone
	ThermalZone(TZN0) {Name(s000, "TZN0")}

	// Buffer Field
	Createfield(BUFZ,   0, 69, BFL0)
	Createfield(BUFZ,  80, 64, BFL2)
	Createfield(BUFZ, 160, 32, BFL4)

	// DDBHandle
	Name(DDB0, Ones)

	// Reference
	Name(ORF0, "ORF0")
	Name(REF0, Package(1){})

	Method(m243)
	{
		Method(mm00, 1, , , UnknownObj) {Add(Derefof(arg0), 1, arg0)}

		Method(mm01, , , , IntObj) {Return (INT0)}
		Method(mm11, , , , StrObj) {Return (INT0)}
		Method(mm02, , , , StrObj) {Return (STR0)}
		Method(mm03, , , , BuffObj) {Return (BUF0)}
		Method(mm04, , , , PkgObj) {Return (PAC0)}
		Method(mm05, , , , FieldUnitObj) {Return (FLU0)}
		Method(mm06, , , , DeviceObj) {Return (DEV0)}
		Method(mm07, , , , EventObj) {Return (EVE0)}
		Method(mm08, , , , MethodObj) {
			CopyObject(MMM0, Local0)
			Return (Local0)
		}
		Method(mm09, , , , MutexObj) {Return (MTX0)}
		Method(mm0a, , , , OpRegionObj) {Return (OPR0)}
		Method(mm0b, , , , PowerResObj) {Return (PWR0)}
		Method(mm0c, , , , ProcessorObj) {Return (CPU0)}
		Method(mm0d, , , , ThermalZoneObj) {Return (TZN0)}
		Method(mm0e, , , , BuffFieldObj) {Return (BFL0)}
		Method(mm0f, , , , DDBHandleObj) {Return (DDB0)}

		// Formal declaration
		// Method(mm0g, , , , DebugObj) {Return (Debug)}

		Method(mm0h, , , , IntObj) {Return (Refof(ORF0))}

		Store(0xfedcba9876543210, Local0)
		m205(ts, 89, ObjectType(mm00), 8)
		mm00(Refof(Local0))
		m205(ts, 90, Local0, 0xfedcba9876543211)

		m205(ts, 91, ObjectType(mm01), 8)
		m205(ts, 92, mm01(), INT0)

		m205(ts, 93, ObjectType(mm02), 8)
		m205(ts, 94, mm02(), STR0)

		m205(ts, 95, ObjectType(mm03), 8)
		m205(ts, 96, mm03(), BUF0)

		m205(ts, 97, ObjectType(mm04), 8)
		m205(ts, 98, mm04(), PAC0)

		m205(ts, 99, ObjectType(mm05), 8)
		m205(ts, 100, mm05(), FLU0)

		m205(ts, 101, ObjectType(mm06), 8)
		m205(ts, 102, mm06(), DEV0)

		m205(ts, 103, ObjectType(mm07), 8)
		m205(ts, 104, mm07(), EVE0)

		m205(ts, 105, ObjectType(mm08), 8)
		CopyObject(MMM0, Local0)
		m205(ts, 106, mm08(), Local0)

		m205(ts, 107, ObjectType(mm09), 8)
		m205(ts, 108, mm09(), MTX0)

		m205(ts, 109, ObjectType(mm0a), 8)
		m205(ts, 110, mm0a(), OPR0)

		m205(ts, 111, ObjectType(mm0b), 8)
		m205(ts, 112, mm0b(), PWR0)

		m205(ts, 113, ObjectType(mm0c), 8)
		m205(ts, 114, mm0c(), CPU0)

		m205(ts, 115, ObjectType(mm0d), 8)
		
		if (y350) {
			m205(ts, 116, mm0d(), TZN0)
		}

		m205(ts, 117, ObjectType(mm0e), 8)
		m205(ts, 118, mm0e(), BFL0)

		m205(ts, 119, ObjectType(mm0f), 8)
		m205(ts, 120, mm0f(), DDB0)

		/*
			m205(ts, 121, ObjectType(mm0g), 8)
			m205(ts, 122, mm0g(), Debug)
		*/

		m205(ts, 123, ObjectType(mm0h), 8)
		m205(ts, 124, DeRefof(mm0h()), ORF0)
	}

	Method(m244)
	{
		Method(mm00, , , , {IntObj, StrObj}) {Return (STR0)}
		Method(mm01, , , , {IntObj, StrObj, BuffObj, PkgObj,
								FieldUnitObj, DeviceObj, EventObj, MethodObj,
								MutexObj, OpRegionObj, PowerResObj, /*ProcessorObj,*/
								ThermalZoneObj, BuffFieldObj, DDBHandleObj})
			{Return (INT0)}

		m205(ts, 125, ObjectType(mm00), 8)
		m205(ts, 126, mm00(), STR0)

		m205(ts, 127, ObjectType(mm01), 8)
		m205(ts, 128, mm01(), INT0)
	}

	Method(m245,, Serialized)
	{
		Name(Flag, Ones)

		// List of types of the parameters contains the same keyword
		Method(mm00, 1, , , , IntObj) {Store(0, Flag)}
		Method(mm01, 1, , , , {IntObj}) {Store(1, Flag)}
		Method(mm02, 2, , , , {IntObj, IntObj}) {Store(2, Flag)}
		Method(mm03, 3, , , , {IntObj, IntObj, IntObj}) {Store(3, Flag)}
		Method(mm04, 4, , , , {IntObj, IntObj, IntObj, IntObj}) {Store(4, Flag)}
		Method(mm05, 5, , , , {IntObj, IntObj, IntObj, IntObj,
				IntObj}) {Store(5, Flag)}
		Method(mm06, 6, , , , {IntObj, IntObj, IntObj, IntObj,
				IntObj, IntObj}) {Store(6, Flag)}
		Method(mm07, 7, , , , {IntObj, IntObj, IntObj, IntObj,
				IntObj, IntObj, IntObj}) {Store(7, Flag)}

		// List of types of the parameters contains the UnknownObj keyword
		Method(mm08, 1, , , , UnknownObj) {Store(8, Flag)}
		Method(mm09, 1, , , , {UnknownObj}) {Store(9, Flag)}
		Method(mm0a, 7, , , , {UnknownObj, UnknownObj, UnknownObj, UnknownObj,
				UnknownObj, UnknownObj, UnknownObj}) {Store(10, Flag)}

		// List of types of the parameters contains different keywords
		Method(mm10, 2, , , , {IntObj, StrObj}) {Store(16, Flag)}
		Method(mm11, 2, , , , {IntObj, BuffObj}) {Store(17, Flag)}
		Method(mm12, 2, , , , {StrObj, BuffObj}) {Store(18, Flag)}
		Method(mm13, 3, , , , {IntObj, StrObj, BuffObj}) {Store(19, Flag)}
		Method(mm14, 4, , , , {IntObj, StrObj, BuffObj, PkgObj}) {Store(20, Flag)}
		Method(mm15, 5, , , , {IntObj, StrObj, BuffObj, PkgObj,
				FieldUnitObj}) {Store(21, Flag)}
		Method(mm16, 6, , , , {IntObj, StrObj, BuffObj, PkgObj,
				FieldUnitObj, DeviceObj}) {Store(22, Flag)}
		Method(mm17, 7, , , , {IntObj, StrObj, BuffObj, PkgObj,
				FieldUnitObj, DeviceObj, EventObj}) {Store(23, Flag)}
		Method(mm18, 7, , , , {MethodObj, MutexObj, OpRegionObj, PowerResObj,
				ThermalZoneObj, BuffFieldObj, DDBHandleObj}) {Store(24, Flag)}

		// List of types of the parameters contains keyword packages
		// along with different keywords
		Method(mm20, 1, , , , {{IntObj}}) {Store(32, Flag)}
		Method(mm21, 1, , , , {{IntObj, StrObj}}) {Store(33, Flag)}
/*
// Bug 148
		Method(mm22, 1, , , , {{IntObj, StrObj, BuffObj, PkgObj,
				FieldUnitObj, DeviceObj, EventObj, MethodObj,
				MutexObj, OpRegionObj, PowerResObj, //ProcessorObj,
				ThermalZoneObj, BuffFieldObj, DDBHandleObj}}) {Store(34, Flag)}
*/
		Method(mm23, 2, , , , {{IntObj}, IntObj}) {Store(35, Flag)}
		Method(mm24, 2, , , , {{IntObj}, StrObj}) {Store(36, Flag)}
		Method(mm25, 2, , , , {{IntObj}, BuffObj}) {Store(37, Flag)}
		Method(mm26, 2, , , , {{IntObj}, {IntObj}}) {Store(38, Flag)}
		Method(mm27, 2, , , , {{IntObj}, {StrObj}}) {Store(39, Flag)}
		Method(mm28, 2, , , , {{IntObj}, {BuffObj}}) {Store(40, Flag)}
		Method(mm29, 2, , , , {{StrObj}, {BuffObj}}) {Store(41, Flag)}
/*
// Bug 148
		Method(mm2a, 7, , , , {
			{IntObj, StrObj, BuffObj, PkgObj, FieldUnitObj, DeviceObj, EventObj, MethodObj,
			 MutexObj, OpRegionObj, PowerResObj, ThermalZoneObj, BuffFieldObj, DDBHandleObj},
			{IntObj, StrObj, BuffObj, PkgObj, FieldUnitObj, DeviceObj, EventObj, MethodObj,
			 MutexObj, OpRegionObj, PowerResObj, ThermalZoneObj, BuffFieldObj, DDBHandleObj},
			{IntObj, StrObj, BuffObj, PkgObj, FieldUnitObj, DeviceObj, EventObj, MethodObj,
			 MutexObj, OpRegionObj, PowerResObj, ThermalZoneObj, BuffFieldObj, DDBHandleObj},
			{IntObj, StrObj, BuffObj, PkgObj, FieldUnitObj, DeviceObj, EventObj, MethodObj,
			 MutexObj, OpRegionObj, PowerResObj, ThermalZoneObj, BuffFieldObj, DDBHandleObj},
			{IntObj, StrObj, BuffObj, PkgObj, FieldUnitObj, DeviceObj, EventObj, MethodObj,
			 MutexObj, OpRegionObj, PowerResObj, ThermalZoneObj, BuffFieldObj, DDBHandleObj},
			{IntObj, StrObj, BuffObj, PkgObj, FieldUnitObj, DeviceObj, EventObj, MethodObj,
			 MutexObj, OpRegionObj, PowerResObj, ThermalZoneObj, BuffFieldObj, DDBHandleObj},
			{IntObj, StrObj, BuffObj, PkgObj, FieldUnitObj, DeviceObj, EventObj, MethodObj,
			 MutexObj, OpRegionObj, PowerResObj, ThermalZoneObj, BuffFieldObj, DDBHandleObj},
		}) {Store(42, Flag)}
*/

		// List of types of the parameters contains the same keyword

		m205(ts, 129, ObjectType(mm00), 8)
		mm00(1)
		m205(ts, 130, Flag, 0)

		m205(ts, 131, ObjectType(mm01), 8)
		mm01(1)
		m205(ts, 132, Flag, 1)

		m205(ts, 133, ObjectType(mm02), 8)
		mm02(1, 2)
		m205(ts, 134, Flag, 2)

		m205(ts, 135, ObjectType(mm03), 8)
		mm03(1, 2, 3)
		m205(ts, 136, Flag, 3)

		m205(ts, 137, ObjectType(mm04), 8)
		mm04(1, 2, 3, 4)
		m205(ts, 138, Flag, 4)

		m205(ts, 139, ObjectType(mm05), 8)
		mm05(1, 2, 3, 4, 5)
		m205(ts, 140, Flag, 5)

		m205(ts, 141, ObjectType(mm06), 8)
		mm06(1, 2, 3, 4, 5, 6)
		m205(ts, 142, Flag, 6)

		m205(ts, 143, ObjectType(mm07), 8)
		mm07(1, 2, 3, 4, 5, 6, 7)
		m205(ts, 144, Flag, 7)


		// List of types of the parameters contains the UnknownObj keyword

		m205(ts, 145, ObjectType(mm08), 8)
		mm08(1)
		m205(ts, 146, Flag, 8)

		m205(ts, 147, ObjectType(mm09), 8)
		mm09(1)
		m205(ts, 148, Flag, 9)

		m205(ts, 149, ObjectType(mm0a), 8)
		mm0a(1, 2, 3, 4, 5, 6, 7)
		m205(ts, 150, Flag, 10)

		// List of types of the parameters contains different keywords

		m205(ts, 151, ObjectType(mm10), 8)
		mm10(1, 2)
		m205(ts, 152, Flag, 16)

		m205(ts, 153, ObjectType(mm11), 8)
		mm11(1, 2)
		m205(ts, 154, Flag, 17)

		m205(ts, 155, ObjectType(mm12), 8)
		mm12(1, 2)
		m205(ts, 156, Flag, 18)

		m205(ts, 157, ObjectType(mm13), 8)
		mm13(1, 2, 3)
		m205(ts, 158, Flag, 19)

		m205(ts, 159, ObjectType(mm14), 8)
		mm14(1, 2, 3, 4)
		m205(ts, 160, Flag, 20)

		m205(ts, 161, ObjectType(mm15), 8)
		mm15(1, 2, 3, 4, 5)
		m205(ts, 162, Flag, 21)

		m205(ts, 163, ObjectType(mm16), 8)
		mm16(1, 2, 3, 4, 5, 6)
		m205(ts, 164, Flag, 22)

		m205(ts, 165, ObjectType(mm17), 8)
		mm17(1, 2, 3, 4, 5, 6, 7)
		m205(ts, 166, Flag, 23)

		m205(ts, 167, ObjectType(mm18), 8)
		mm18(1, 2, 3, 4, 5, 6, 7)
		m205(ts, 168, Flag, 24)


		// List of types of the parameters contains keyword packages
		// along with different keywords

		m205(ts, 169, ObjectType(mm20), 8)
		mm20(1)
		m205(ts, 170, Flag, 32)

		m205(ts, 171, ObjectType(mm21), 8)
		mm21(1)
		m205(ts, 172, Flag, 33)

/*
// Bug 148
		m205(ts, 173, ObjectType(mm22), 8)
		mm22(1)
		m205(ts, 174, Flag, 34)
*/

		m205(ts, 175, ObjectType(mm23), 8)
		mm23(1, 2)
		m205(ts, 176, Flag, 35)

		m205(ts, 177, ObjectType(mm24), 8)
		mm24(1, 2)
		m205(ts, 178, Flag, 36)

		m205(ts, 179, ObjectType(mm25), 8)
		mm25(1, 2)
		m205(ts, 180, Flag, 37)

		m205(ts, 181, ObjectType(mm26), 8)
		mm26(1, 2)
		m205(ts, 182, Flag, 38)

		m205(ts, 183, ObjectType(mm27), 8)
		mm27(1, 2)
		m205(ts, 184, Flag, 39)

		m205(ts, 185, ObjectType(mm28), 8)
		mm28(1, 2)
		m205(ts, 186, Flag, 40)

		m205(ts, 187, ObjectType(mm29), 8)
		mm29(1, 2)
		m205(ts, 188, Flag, 41)

/*
// Bug 148
		m205(ts, 189, ObjectType(mm2a), 8)
		mm2a(1, 2, 3, 4, 5, 6, 7)
		m205(ts, 190, Flag, 42)
*/
	}

	// UnSerialized Method can be invoked recursively
	Method(m246,, Serialized)
	{
		Name(i000, 0)

		Method(mm00, 1)
		{
			Increment(i000)

			if (arg0) {
				mm01()
			}
		}

		Method(mm01) {mm00(0)}

		Store(0, i000)
		mm00(0)
		m205(ts, 191, i000, 1)

		Store(0, i000)
		mm00(1)
		m205(ts, 192, i000, 2)
	}

	// Serialized Method can be invoked recursively
	Method(m247,, Serialized)
	{
		Name(i000, 0)

		Method(mm00, 1, Serialized, 0)
		{
			Increment(i000)

			if (arg0) {
				mm01()
			}
		}

		Method(mm01) {mm00(0)}

		Store(0, i000)
		mm00(0)
		m205(ts, 193, i000, 1)

		Store(0, i000)
		mm00(1)
		m205(ts, 194, i000, 2)
	}

	// Serialized Method can invoke another Serialized One
	// if SyncLevel is not lowered
	Method(m248,, Serialized)
	{
		Name(i000, 0)

		Method(mm00, 1, Serialized, 0)
		{
			Increment(i000)

			if (arg0) {
				mm01()
			}
		}

		Method(mm01, 0, Serialized, 15)
		{
			Increment(i000)
		}

		Store(0, i000)
		mm00(0)
		m205(ts, 195, i000, 1)

		Store(0, i000)
		mm00(1)
		m205(ts, 196, i000, 2)
	}

	// Serialized Method can acquire an Mutex
	// if SyncLevel is not lowered
	Method(m249,, Serialized)
	{
		Mutex(MTX0, 15)
		Name(i000, 0)

		Method(mm00, 1, Serialized, 0)
		{
			Increment(i000)

			if (arg0) {
				Store(Acquire(MTX0, 0), Local0)
				if (LNot(m205(ts, 197, Local0, Zero))) {
					Increment(i000)
					Release(MTX0)
				}
			}
		}

		Store(0, i000)
		mm00(0)
		m205(ts, 198, i000, 1)

		Store(0, i000)
		mm00(1)
		m205(ts, 199, i000, 2)
	}

	// When Serialized Method calls another one then
	// the last can acquire an Mutex if SyncLevel is not lowered
	Method(m24a,, Serialized)
	{
		Mutex(MTX1, 15)
		Name(i000, 0)

		Method(mm00, 1, Serialized, 0)
		{
			Increment(i000)

			if (arg0) {
				mm01()
			}
		}

		Method(mm01)
		{
			Store(Acquire(MTX1, 0), Local0)
			if (LNot(m205(ts, 200, Local0, Zero))) {
				Increment(i000)
				Release(MTX1)
			}
		}

		Store(0, i000)
		mm00(0)
		m205(ts, 201, i000, 1)

		Store(0, i000)
		mm00(1)
		m205(ts, 202, i000, 2)
	}

	// UnSerialized Method acquiring an Mutex can invoke
	// another Serialized One if SyncLevel is not lowered
	Method(m24b,, Serialized)
	{
		Mutex(MTX0, 0)
		Name(i000, 0)

		Method(mm00, 1)
		{
			Store(Acquire(MTX0, 0), Local0)
			if (LNot(m205(ts, 203, Local0, Zero))) {
				Increment(i000)

				if (arg0) {
					mm01()
				}
				Release(MTX0)
			}
		}

		Method(mm01, 0, Serialized, 15)
		{
			Increment(i000)
		}

		Store(0, i000)
		mm00(0)
		m205(ts, 204, i000, 1)

		Store(0, i000)
		mm00(1)
		m205(ts, 205, i000, 2)
	}

	// When UnSerialized Method acquiring an Mutex invokes
	// another Serialized One then the last can release the
	// Mutex if Mutex's SyncLevel is not lower than the Method's
	Method(m24c,, Serialized)
	{
		Mutex(MTX0, 0)
		Name(i000, 0)

		Method(mm00, 1)
		{
			Store(Acquire(MTX0, 0), Local0)
			if (LNot(m205(ts, 206, Local0, Zero))) {
				Increment(i000)

				if (arg0) {
					mm01()
				} else {
					Release(MTX0)
				}
			}
		}

		Method(mm01, 0, Serialized)
		{
			Increment(i000)
			Release(MTX0)
		}

		Store(0, i000)
		mm00(0)
		m205(ts, 207, i000, 1)

		Store(0, i000)
		mm00(1)
		m205(ts, 208, i000, 2)
	}

	SRMT("m240")
	m240()
	SRMT("m241")
	m241()
	SRMT("m242")
	m242()
	SRMT("m243")
	m243()
	SRMT("m244")
	m244()
	SRMT("m245")
	m245()
	SRMT("m246")
	m246()

	SRMT("m247")
	if (y349) {
		m247()
	} else {
		BLCK()
	}

	SRMT("m248")
	m248()
	SRMT("m249")
	m249()
	SRMT("m24a")
	m24a()
	SRMT("m24b")
	m24b()
	SRMT("m24c")
	m24c()
}

// Run-method
Method(NM01)
{
	Store("TEST: NM01, Declare Control Method Named Object", Debug)

	m207()

	CH03("NM01", z133, 209, 0, 0)
}
