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

Name(z134, 134)

/*
 * This sub-test is intended to comprehensively verify
 * the Function declaration syntax implementation.
 *
 * Declare the Function Control Method Objects of different,
 * signature check that properly specified or default arguments
 * values provide required functionality.
 *
 * The overall functionality of the Function Objects is indirectly
 * verified by other tests as far as "Functions are equivalent to a
 * Method that specifies NotSerialized".
 *
 *    17.5.49    Function (Declare Control Method)
 *    Syntax
 * Function (FunctionName, ReturnType, ParameterTypes) {TermList}
 *
 *    Validated Assertions:
 *
 * - Function declaration creates an Object in the ACPI
 *   namespace which can be referred by the specified FunctionName
 *   either to initiate its invocation or to obtain its AML Object
 *   type. Also FunctionName can be used to save a copy of the Object
 *   or a reference to it in another AML Object.
 *
 * - ASL compiler should allow only a Namestring data type in the
 *   FunctionName position.
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
 *   and the number of members in the ParameterTypes package exceeds 7.
 *
 * - If ParameterTypes is not specified, then the number of parameters
 *   is Zero.
 *
 * - ASL compiler should report an error when an actual Object
 *   specified to be a respective argument of the Method is of
 *   inappropriate type.
 *
 * - System software should execute a Function control method
 *   by referencing the objects in the Function body in order.
 *
 * - Function opens a name scope. All namespace references that occur
 *   during the method execution are relative to the Function package
 *   location.
 *
 * - All namespace objects created by a Function should be destroyed
 *   when Function execution exits.
 *
 */

Scope(\_SB){
	Function(m20d){}
}

Method(m20e,, Serialized)
{
	Name(ts, "m20e")

	Method(m316)
	{
		Function(mm00) {Return ("\\m20e.m316.mm00")}
		Method(\_SB.m20d.mm00) {Return ("\\_SB.m20d.mm00")}
	
		m205(ts, 1, ObjectType(mm00), 8)
		m205(ts, 2, mm00(), "\\m20e.m316.mm00")

		m205(ts, 3, ObjectType(\m20e.m316.mm00), 8)
		m205(ts, 4, \m20e.m316.mm00(), "\\m20e.m316.mm00")

		m205(ts, 5, ObjectType(^m316.mm00), 8)
		m205(ts, 6, ^m316.mm00(), "\\m20e.m316.mm00")

		m205(ts, 7, ObjectType(\_SB.m20d.mm00), 8)
		m205(ts, 8, \_SB.m20d.mm00(), "\\_SB.m20d.mm00")
	}

	Method(m317)
	{
		Function(mm10) {Return ("\\m20e.m317.mm10")}
		Function(mm20, ) {Return ("\\m20e.m317.mm20")}
		Function(mm30, , ) {Return ("\\m20e.m317.mm30")}

		m205(ts,  9, ObjectType(mm10), 8)
		m205(ts, 10, mm10(), "\\m20e.m317.mm10")

		m205(ts, 11, ObjectType(mm20), 8)
		m205(ts, 12, mm20(), "\\m20e.m317.mm20")

		m205(ts, 13, ObjectType(mm30), 8)
		if (y157) {
			m205(ts, 14, mm30(), "\\m20e.m317.mm30")
		}
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
	Function(mmM0) {Return ("ff0X")}

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

	Method(m318)
	{
		Function(mm00, UnknownObj, {IntObj}) {Add(Derefof(arg0), 1, arg0)}

		Function(mm01, IntObj) {Return (INT0)}
		Function(mm11, StrObj) {Return (INT0)}
		Function(mm02, StrObj) {Return (STR0)}
		Function(mm03, BuffObj) {Return (BUF0)}
		Function(mm04, PkgObj) {Return (PAC0)}
		Function(mm05, FieldUnitObj) {Return (FLU0)}
		Function(mm06, DeviceObj) {Return (DEV0)}
		Function(mm07, EventObj) {Return (EVE0)}
		Function(mm08, MethodObj) {
			CopyObject(MMM0, Local0)
			Return (Local0)
		}
		Function(mm09, MutexObj) {Return (MTX0)}
		Function(mm0a, OpRegionObj) {Return (OPR0)}
		Function(mm0b, PowerResObj) {Return (PWR0)}
		Function(mm0c, ProcessorObj) {Return (CPU0)}
		Function(mm0d, ThermalZoneObj) {Return (TZN0)}
		Function(mm0e, BuffFieldObj) {Return (BFL0)}
		Function(mm0f, DDBHandleObj) {Return (DDB0)}

// Formal declaration
//		Function(mm0g, DebugObj) {Return (Debug)}

		Function(mm0h, IntObj) {Return (Refof(ORF0))}

		Store(0xfedcba9876543210, Local0)
		m205(ts, 15, ObjectType(mm00), 8)
/*
// Bug 148
		mm00(Refof(Local0))
		m205(ts, 16, Local0, 0xfedcba9876543211)
*/

		m205(ts, 17, ObjectType(mm01), 8)
		m205(ts, 18, mm01(), INT0)

		m205(ts, 19, ObjectType(mm02), 8)
		m205(ts, 20, mm02(), STR0)

		m205(ts, 21, ObjectType(mm03), 8)
		m205(ts, 22, mm03(), BUF0)

		m205(ts, 23, ObjectType(mm04), 8)
		m205(ts, 24, mm04(), PAC0)

		m205(ts, 25, ObjectType(mm05), 8)
		m205(ts, 26, mm05(), FLU0)

		m205(ts, 27, ObjectType(mm06), 8)
		m205(ts, 28, mm06(), DEV0)

		m205(ts, 29, ObjectType(mm07), 8)
		m205(ts, 30, mm07(), EVE0)

		m205(ts, 31, ObjectType(mm08), 8)
		CopyObject(MMM0, Local0)
		m205(ts, 32, mm08(), Local0)

		m205(ts, 33, ObjectType(mm09), 8)
		m205(ts, 34, mm09(), MTX0)

		m205(ts, 35, ObjectType(mm0a), 8)
		m205(ts, 36, mm0a(), OPR0)

		m205(ts, 37, ObjectType(mm0b), 8)
		m205(ts, 38, mm0b(), PWR0)

		m205(ts, 39, ObjectType(mm0c), 8)
		m205(ts, 40, mm0c(), CPU0)

		m205(ts, 41, ObjectType(mm0d), 8)
		if (y350) {
			m205(ts, 42, mm0d(), TZN0)
		}

		m205(ts, 43, ObjectType(mm0e), 8)
		m205(ts, 44, mm0e(), BFL0)

		m205(ts, 45, ObjectType(mm0f), 8)
		m205(ts, 46, mm0f(), DDB0)

/*
		m205(ts, 47, ObjectType(mm0g), 8)
		m205(ts, 48, mm0g(), Debug)
*/

		m205(ts, 49, ObjectType(mm0h), 8)
		m205(ts, 50, DeRefof(mm0h()), ORF0)
	}

	Method(m319)
	{
		Function(mm00, {IntObj, StrObj}) {Return (STR0)}
		Function(mm01, {IntObj, StrObj, BuffObj, PkgObj,
								FieldUnitObj, DeviceObj, EventObj, MethodObj,
								MutexObj, OpRegionObj, PowerResObj, ProcessorObj,
								ThermalZoneObj, BuffFieldObj, DDBHandleObj})
			{Return (INT0)}

		m205(ts, 51, ObjectType(mm00), 8)
		m205(ts, 52, mm00(), STR0)

		m205(ts, 53, ObjectType(mm01), 8)
		m205(ts, 54, mm01(), INT0)
	}

	Method(m31a,, Serialized)
	{
		Name(Flag, Ones)

		// List of types of the parameters contains the same keyword
		Function(mm00, , IntObj) {Store(0, Flag)}
		Function(mm01, , {IntObj}) {Store(1, Flag)}
		Function(mm02, , {IntObj, IntObj}) {Store(2, Flag)}

		Function(mm03, , {IntObj, IntObj, IntObj}) {Store(3, Flag)}
		Function(mm04, , {IntObj, IntObj, IntObj, IntObj}) {Store(4, Flag)}
		Function(mm05, , {IntObj, IntObj, IntObj, IntObj,
				IntObj}) {Store(5, Flag)}
		Function(mm06, , {IntObj, IntObj, IntObj, IntObj,
				IntObj, IntObj}) {Store(6, Flag)}
		Function(mm07, , {IntObj, IntObj, IntObj, IntObj,
				IntObj, IntObj, IntObj}) {Store(7, Flag)}

		// List of types of the parameters contains the UnknownObj keyword
		Function(mm08, , UnknownObj) {Store(8, Flag)}
		Function(mm09, , {UnknownObj}) {Store(9, Flag)}
		Function(mm0a, , {UnknownObj, UnknownObj, UnknownObj, UnknownObj,
				UnknownObj, UnknownObj, UnknownObj}) {Store(10, Flag)}

		// List of types of the parameters contains different keywords
		Function(mm10, , {IntObj, StrObj}) {Store(16, Flag)}
		Function(mm11, , {IntObj, BuffObj}) {Store(17, Flag)}
		Function(mm12, , {StrObj, BuffObj}) {Store(18, Flag)}
		Function(mm13, , {IntObj, StrObj, BuffObj}) {Store(19, Flag)}
		Function(mm14, , {IntObj, StrObj, BuffObj, PkgObj}) {Store(20, Flag)}
		Function(mm15, , {IntObj, StrObj, BuffObj, PkgObj,
				FieldUnitObj}) {Store(21, Flag)}
		Function(mm16, , {IntObj, StrObj, BuffObj, PkgObj,
				FieldUnitObj, DeviceObj}) {Store(22, Flag)}
		Function(mm17, , {IntObj, StrObj, BuffObj, PkgObj,
				FieldUnitObj, DeviceObj, EventObj}) {Store(23, Flag)}
		Function(mm18, , {MethodObj, MutexObj, OpRegionObj, PowerResObj,
				ThermalZoneObj, BuffFieldObj, DDBHandleObj}) {Store(24, Flag)}

		// List of types of the parameters contains keyword packages
		// along with different keywords
		Function(mm20, , {{IntObj}}) {Store(32, Flag)}
		Function(mm21, , {{IntObj, StrObj}}) {Store(33, Flag)}
/*
// Bug 148
		Function(mm22, , {{IntObj, StrObj, BuffObj, PkgObj,
				FieldUnitObj, DeviceObj, EventObj, MethodObj,
				MutexObj, OpRegionObj, PowerResObj, ProcessorObj,
				ThermalZoneObj, BuffFieldObj, DDBHandleObj}}) {Store(34, Flag)}
*/
		Function(mm23, , {{IntObj}, IntObj}) {Store(35, Flag)}
		Function(mm24, , {{IntObj}, StrObj}) {Store(36, Flag)}
		Function(mm25, , {{IntObj}, BuffObj}) {Store(37, Flag)}
		Function(mm26, , {{IntObj}, {IntObj}}) {Store(38, Flag)}
		Function(mm27, , {{IntObj}, {StrObj}}) {Store(39, Flag)}
		Function(mm28, , {{IntObj}, {BuffObj}}) {Store(40, Flag)}
		Function(mm29, , {{StrObj}, {BuffObj}}) {Store(41, Flag)}

/*
// Bug 148
		Function(mm3a, , {
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

/*
// Bug 148
		// List of types of the parameters contains the same keyword

		m205(ts, 55, ObjectType(mm00), 8)
		mm00(1)
		m205(ts, 56, Flag, 0)

		m205(ts, 57, ObjectType(mm01), 8)
		mm01(1)
		m205(ts, 58, Flag, 1)

		m205(ts, 59, ObjectType(mm02), 8)
		mm02(1, 2)
		m205(ts, 60, Flag, 2)

		m205(ts, 61, ObjectType(mm03), 8)
		mm03(1, 2, 3)
		m205(ts, 62, Flag, 3)

		m205(ts, 63, ObjectType(mm04), 8)
		mm04(1, 2, 3, 4)
		m205(ts, 64, Flag, 4)

		m205(ts, 65, ObjectType(mm05), 8)
		mm05(1, 2, 3, 4, 5)
		m205(ts, 66, Flag, 5)

		m205(ts, 67, ObjectType(mm06), 8)
		mm06(1, 2, 3, 4, 5, 6)
		m205(ts, 68, Flag, 6)

		m205(ts, 69, ObjectType(mm07), 8)
		mm07(1, 2, 3, 4, 5, 6, 7)
		m205(ts, 70, Flag, 7)

		// List of types of the parameters contains the UnknownObj keyword

		m205(ts, 71, ObjectType(mm08), 8)
		mm08(1)
		m205(ts, 72, Flag, 8)

		m205(ts, 73, ObjectType(mm09), 8)
		mm09(1)
		m205(ts, 74, Flag, 9)

		m205(ts, 75, ObjectType(mm0a), 8)
		mm08(1, 2, 3, 4, 5, 6, 7)
		m205(ts, 76, Flag, 10)

		// List of types of the parameters contains different keywords

		m205(ts, 77, ObjectType(mm10), 8)
		mm10(1, 2)
		m205(ts, 78, Flag, 16)

		m205(ts, 79, ObjectType(mm11), 8)
		mm11(1, 2)
		m205(ts, 80, Flag, 17)

		m205(ts, 81, ObjectType(mm12), 8)
		mm12(1, 2)
		m205(ts, 82, Flag, 18)

		m205(ts, 83, ObjectType(mm13), 8)
		mm13(1, 2, 3)
		m205(ts, 84, Flag, 19)

		m205(ts, 85, ObjectType(mm14), 8)
		mm14(1, 2, 3, 4)
		m205(ts, 86, Flag, 20)

		m205(ts, 87, ObjectType(mm15), 8)
		mm15(1, 2, 3, 4, 5)
		m205(ts, 88, Flag, 21)

		m205(ts, 89, ObjectType(mm16), 8)
		mm16(1, 2, 3, 4, 5, 6)
		m205(ts, 90, Flag, 22)

		m205(ts, 91, ObjectType(mm17), 8)
		mm17(1, 2, 3, 4, 5, 6, 7)
		m205(ts, 92, Flag, 23)

		m205(ts, 93, ObjectType(mm18), 8)
		mm18(1, 2, 3, 4, 5, 6, 7)
		m205(ts, 94, Flag, 24)

		// List of types of the parameters contains keyword packages
		// along with different keywords

		m205(ts, 95, ObjectType(mm20), 8)
		mm20(1)
		m205(ts, 96, Flag, 32)

		m205(ts, 97, ObjectType(mm21), 8)
		mm21(1)
		m205(ts, 98, Flag, 33)

		m205(ts, 99, ObjectType(mm22), 8)
		mm22(1)
		m205(ts, 100, Flag, 34)

		m205(ts, 101, ObjectType(mm23), 8)
		mm23(1, 2)
		m205(ts, 102, Flag, 35)

		m205(ts, 103, ObjectType(mm24), 8)
		mm24(1, 2)
		m205(ts, 104, Flag, 36)

		m205(ts, 105, ObjectType(mm25), 8)
		mm25(1, 2)
		m205(ts, 106, Flag, 37)

		m205(ts, 107, ObjectType(mm26), 8)
		mm26(1, 2)
		m205(ts, 108, Flag, 38)

		m205(ts, 109, ObjectType(mm27), 8)
		mm27(1, 2)
		m205(ts, 110, Flag, 39)

		m205(ts, 149, ObjectType(mm28), 8)
		mm28(1, 2)
		m205(ts, 111, Flag, 40)

		m205(ts, 112, ObjectType(mm29), 8)
		mm29(1, 2)
		m205(ts, 113, Flag, 41)

		m205(ts, 114, ObjectType(mm2a), 8)
		mm2a(1, 2, 3, 4, 5, 6, 7)
		m205(ts, 115, Flag, 42)
*/
	}

	SRMT("m316")
	m316()
	SRMT("m317")
	m317()
	SRMT("m318")
	m318()
	SRMT("m319")
	m319()
	SRMT("m31a")
	m31a()
}

// Run-method
Method(NM02)
{
	Store("TEST: NM02, Declare Function Control Method Named Object", Debug)

	m20e()

	CH03("NM02", z134, 116, 0, 0)
}
