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

   ============================
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!
   IT IS IN PROGRESS !!!!!!!!!!
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!
   ============================

SEE: ????????????

1) Add 0 into the middle of any Buffer
2) Do BOTH directions for Concatenation:
   - First argument - String
   - First argument - Buffer
3) Extend the test, if possible, for all the operators
4) add method m480 with the different objects creations.
5) change Name(ss08, "1234567890abCdeF")
   to     Name(ss08, "1234567830abCdeF")
6) do the same as m480() but use LocalX instead ArgX
   in Operators invocations:
          Store(Add(Local0, Local1, Local7), local7)
*/

// Methods for Conversion tests
//
// (low number of available arguments {Arg0-Arg6} complicates algorithms).
//
// Currently from the mask of exceptions to be forced are excluded bits
// corresponding to the following types ("dont know how" have to be added):
//
// - Method        (dont know how)
// - Thermal Zones (dont know how)
// - DDB Handle    (dont know how)
// - Debug Object  (impossible, Compiler refuses)
// - Uninitialized (update needed, currently the test is implemented incorrectly.
//                  Uninitialized type have to be passed immediately as operands
//                  in m480).
//
// Currently excluded from all the total scales of unacceptable types
// (to be added later):
//
//	0x0100 - Method
//	0x2000 - Thermal Zone
//	0x8000 - DDB Handle
//
// Total scale of acceptable types:
//
//	int - 0xc02e - Integer, String, Buffer, Field Unit, Buffer Field, DDB Handle
//

// NOTE: many entries are commented not to cause crashes.
//       Have to be uncommented after ACPICA will be fixed.
//

Name(z064, 64)

// Commutative two operands operation
// (CAUTION: dont forget to clean it)
Name(com2, 0)

// Flags exception expected
// (needed due to the lack of Arguments number)
Name(FLG0, 0x19283746)

// Flag - verify result with the contents of Package
Name(FLG1, 0)

// Package contains benchmarks of results
Name(PKG0, Package(1) {0x10000001})
Name(PKG1, Package(1) {0x11111111})
Name(PKG2, Package(1) {0x22222222})

Name(df00, 0)
Name(df01, 0)
Name(df02, 0)
Name(df03, 0)
Name(df04, 0)
Event(e000)
Mutex(mx00, 0)
Name(i000, 0x58765432)
Name(i001, 0xabcdefabaabbccdd)
Name(s000, "qwrt")
Name(b001, Buffer() {0x91,0x22,0x83})
Name(p08b, Package() {19,27})
Device(dv00) {}
Method(m4a3) { return (0) }
OperationRegion(rg00, SystemMemory, 0x100, 0x100)
Field(rg00, ByteAcc, NoLock, Preserve) { fr20, 7 }
PowerResource(pwr0, 1, 0) {Method(m000){return (0)}}
Processor(prc0, 0, 0xFFFFFFFF, 0) {}
Name(b002, Buffer(100) {})
CreateDWordField(b002, 3, bfz0)


// Return object of required type
//
// arg0 - type of object
Method(m484, 1, Serialized)
{
	Name(ts, "m484")

	Event(e001)
	Mutex(mx01, 0)

	Name(ss01, "svnmjkl")
	Name(ss02, "1234zyq")
	Name(ss03, "abcdefzyq")
	Name(ss04, "9876")
	Name(ss05, "aBcD")
	Name(ss06, "1234567890987654")
	Name(ss07, "daFeCBaabbddffee")
	Name(ss08, "1234567890abCdeF")
	Name(ss09, "FdeAcb0132547698")
	Name(ss0a, "12345678909876540")
	Name(ss0b, "fdeacb01325476980")
	Name(ss0c, "123456789011223344556677889998765432199983337744")
	Name(ss0d, "abcdefaAbbccddeeffffeeddccaabbddeeffaaaabbbbeeefffdd")
	Name(ss0e, "1234567890abcdef9876543210fedbca1122334455667788fdeacb")
	Name(ss0f, "defa1234567890abcdef9876543210fedbca1122334455667788fdeacb")
	Name(ss10, "123456789011223344556677889998765432199983337744z")
	Name(ss11, "0xF1dAB98e0D794Bc5")

	Name(bb01, Buffer() {0x80})
	Name(bb02, Buffer() {0x81,0x82})
	Name(bb03, Buffer() {0x83,0x84,0x85,0x86})
	Name(bb04, Buffer() {0x87,0x98,0x99,0x9a,0x9b})
	Name(bb05, Buffer() {0x9c,0x9d,0x9e,0x9f,0xa0,0xa1,0xa2,0xa3})
	Name(bb06, Buffer() {0xa4,0xa5,0xa6,0xa7,0xb8,0xb9,0xba,0xbb,0xbc})
	Name(bb07, Buffer(200) {
		 0x91, 0x92, 0x93, 0x94, 95, 96, 97, 98, 99, 10, 11, 12, 13, 14, 15, 16,
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
		193,194,195,196,197,198,199,200})
	Name(bb08, Buffer(257) {
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
		193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,
		209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,
		225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,
		241,242,243,244,245,246,247,248,249,250,251,252,253,254,255, 0, 1})

	// Field Units

	OperationRegion(r001, SystemMemory, 0x100, 0x100)

	Field(r001, ByteAcc, NoLock, Preserve) {
		f001, 3,
		f002, 8,
		f003, 16,
		f004, 32,
		f005, 33,//33
		f006, 63,//63
		f007, 64,//64
		f008, 65,//65
		f009, 127,
		f00a, 257,
		// f00b, 201*8, do it also
	}

	// Buffer Fields

	Name(bb09, Buffer(200) {})

	CreateField(bb09, 1, 3, bf01)
	CreateField(bb09, 4, 8, bf02)
	CreateField(bb09, 12, 16, bf03)
	CreateField(bb09, 28, 32, bf04)
	CreateField(bb09, 60, 33, bf05)
	CreateField(bb09, 93, 63, bf06)//93
	CreateField(bb09, 156, 64, bf07)//156
	CreateField(bb09, 220, 65, bf08)//220
	CreateField(bb09, 285, 127, bf09)//285
	CreateField(bb09, 412, 257, bf0a)//412

//	CreateField(bb09, xxx, 201*8, bf0b)

	CreateDWordField(bb09, 151, bf0b)

	/////////////////////////////////////////////////////////////////////

	Store(0xff, fr20)
	Store(0xff, f001)
	Store(0x8a8b8c8d, f002)
	Store(0x8a8b8c8d, f003)
	Store(0x8a8b8c8d, f004)
	Store(Buffer() {0xff,0xff,0xff,0xff,0xff}, f005)
	Store(Buffer() {0x58,0x46,0x37,0x88,0x19,0xfa,0xde,0xdc,0xfa}, f006)
	Store(Buffer() {0x58,0x9a,0x37,0x88,0x19,0xfa,0xde,0xdc,0xfa}, f007)
	Store(Buffer() {0x58,0xc7,0x37,0x88,0x19,0xfa,0xde,0xdc,0xfa}, f008)
	Store(Buffer() {0x82,0x34,0x56,0x78,0x90,0xab,0xcd,0xef,0x55}, f009)
	Store(Buffer() {0x93,0xab,0xcd,0xef,0x99,0x12,0xcd,0x52,0x87}, f00a)

	Store(0x918654ab, bfz0)
	Store(0xff, bf01)
	Store(0x8a8b8c8d, bf02)
	Store(0x8a8b8c8d, bf03)
	Store(0x8a8b8c8d, bf04)
	Store(Buffer() {0xff,0xff,0xff,0xff,0xff}, bf05)
	Store(Buffer() {0x58,0x46,0x37,0x88,0x19,0xfa,0xde,0xdc,0xfa}, bf06)
	Store(Buffer() {0x58,0x9a,0x37,0x88,0x19,0xfa,0xde,0xdc,0xfa}, bf07)
	Store(Buffer() {0x58,0xc7,0x37,0x88,0x19,0xfa,0xde,0xdc,0xfa}, bf08)
	Store(Buffer() {0x82,0x34,0x56,0x78,0x90,0xab,0xcd,0xef,0x55}, bf09)
	Store(Buffer() {0x93,0xab,0xcd,0xef,0x99,0x12,0xcd,0x52,0x87}, bf0a)

	Store(0xa2b3c4d5, bf0b)

	/////////////////////////////////////////////////////////////////////

	Name(pp01, Package() {19})
	Device(dv01) {}
	Method(m001) { return (0) }
	OperationRegion(r002, SystemMemory, 0x100, 0x100)
	PowerResource(pwr1, 1, 0) {Method(m000){return (0)}}
	Processor(pr01, 0, 0xFFFFFFFF, 0) {}

	Store(0, Local7)

	switch (ToInteger(Arg0)) {

		// Uninitialized

		/*
		 * case (0x000) {
		 * }
		 */

		// Integers

		case (0x100) {
			Store(i000, Local7)
		}
		case (0x101) {
			Store(i001, Local7)
		}
		case (0x102) {
			Store(0x12345678, Local7)
		}
		case (0x103) {
			Store(0xabedf18942345678, Local7)
		}
		case (0x104) {
			Store(Zero, Local7)
		}
		case (0x105) {
			Store(One, Local7)
		}
		case (0x106) {
			Store(Ones, Local7)
		}
		case (0x107) {
			Store(Revision, Local7)
		}
		case (0x108) {
			Store(0x123, Local7)
		}
		case (0x109) {
			Store(11, Local7)
		}

		// Strings

		case (0x200) {
			Store(s000, Local7)
		}
		case (0x201) {
			Store(ss01, Local7)
		}
		case (0x202) {
			Store(ss02, Local7)
		}
		case (0x203) {
			Store(ss03, Local7)
		}
		case (0x204) {
			Store(ss04, Local7)
		}
		case (0x205) {
			Store(ss05, Local7)
		}
		case (0x206) {
			Store(ss06, Local7)
		}
		case (0x207) {
			Store(ss07, Local7)
		}
		case (0x208) {
			Store(ss08, Local7)
		}
		case (0x209) {
			Store(ss09, Local7)
		}
		case (0x20a) {
			Store(ss0a, Local7)
		}
		case (0x20b) {
			Store(ss0b, Local7)
		}
		case (0x20c) {
			Store(ss0c, Local7)
		}
		case (0x20d) {
			Store(ss0d, Local7)
		}
		case (0x20e) {
			Store(ss0e, Local7)
		}
		case (0x20f) {
			Store(ss0f, Local7)
		}
		case (0x210) {
			Store(ss10, Local7)
		}
		case (0x211) {
			Store(ss11, Local7)
		}

		// Buffers

		case (0x300) {
			Store(b001, Local7)
		}
		case (0x301) {
			Store(bb01, Local7)
		}
		case (0x302) {
			Store(bb02, Local7)
		}
		case (0x303) {
			Store(bb03, Local7)
		}
		case (0x304) {
			Store(bb04, Local7)
		}
		case (0x305) {
			Store(bb05, Local7)
		}
		case (0x306) {
			Store(bb06, Local7)
		}
		case (0x307) {
			Store(bb07, Local7)
		}
		case (0x308) {
			Store(bb08, Local7)
		}

		// Packages

		case (0x400) {
			Store(p08b, Local7)
		}
		case (0x401) {
			Store(pp01, Local7)
		}

		// Field Units

		case (0x500) {
			Store(fr20, Local7)
		}
		case (0x501) {
			Store(f001, Local7)
		}
		case (0x502) {
			Store(f002, Local7)
		}
		case (0x503) {
			Store(f003, Local7)
		}
		case (0x504) {
			Store(f004, Local7)
		}
		case (0x505) {
			Store(f005, Local7)
		}
		case (0x506) {
			Store(f006, Local7)
		}
		case (0x507) {
			Store(f007, Local7)
		}
		case (0x508) {
			Store(f008, Local7)
		}
		case (0x509) {
			Store(f009, Local7)
		}
		case (0x50a) {
			Store(f00a, Local7)
		}

		// Devices

		case (0x600) {
			Store(dv00, Local7)
		}
		case (0x601) {
			Store(dv01, Local7)
		}

		// Events

		case (0x700) {
			Store(e000, Local7)
		}
		case (0x701) {
			Store(e001, Local7)
		}

		// Methods

		case (0x800) {
			Store(m4a3, Local7)
		}
		case (0x801) {
			Store(m001, Local7)
		}

		// Mutexes

		case (0x900) {
			Store(mx00, Local7)
		}
		case (0x901) {
			Store(mx01, Local7)
		}

		// Operation Regions

		case (0xa00) {
			Store(rg00, Local7)
		}
		case (0xa01) {
			Store(r001, Local7)
		}
		case (0xa02) {
			Store(r002, Local7)
		}

		// Power Resources

		case (0xb00) {
			Store(pwr0, Local7)
		}
		case (0xb01) {
			Store(pwr1, Local7)
		}

		// Processor

		case (0xc00) {
			Store(prc0, Local7)
		}
		case (0xc01) {
			Store(pr01, Local7)
		}

		// Thermal Zones

		/*
		 * case (0xd00) {
		 *		Store(Debug, Local7)
		 * }
		 */

		// Buffer Field

		case (0xe00) {
			Store(bfz0, Local7)
		}
		case (0xe01) {
			Store(bf01, Local7)
		}
		case (0xe02) {
			Store(bf02, Local7)
		}
		case (0xe03) {
			Store(bf03, Local7)
		}
		case (0xe04) {
			Store(bf04, Local7)
		}
		case (0xe05) {
			Store(bf05, Local7)
		}
		case (0xe06) {
			Store(bf06, Local7)
		}
		case (0xe07) {
			Store(bf07, Local7)
		}
		case (0xe08) {
			Store(bf08, Local7)
		}
		case (0xe09) {
			Store(bf09, Local7)
		}
		case (0xe0a) {
			Store(bf0a, Local7)
		}
		case (0xe0b) {
			Store(bf0b, Local7)
		}

		// DDB Handle

		/*
		 * case (0xf00) {
		 *		Store(Debug, Local7)
		 * }
		 */

		// Debug Object

		/*
		 * case (0x1000) {
		 *		Store(Debug, Local7)
		 * }
		 */

		default {
			if (LNotEqual(arg0, 0)) {
				err("----------- ERROR, m484: incorrect Arg0:", z064, 0, 0, 0, 0, 0)
				Store(arg0, Debug)
			}
		}
	}

	return (Local7)
}

// arg0 - opcode of operation
// arg1 - type of 0-th argument
// arg2 - type of 1-th argument
// arg3 - type of 2-th argument
// arg4 - type of 3-th argument
// arg5 - type of 4-th argument
// arg6 - {Ones - flag of exception, otherwise - index of result pair}
Method(m485, 7, Serialized)
{
	if (0) {
		Store("##################################################################", Debug)
		Store(arg6, Debug)
	}

	Name(ts, "m485")
	Name(ex00, 0)
	Name(tmp0, 0)

	if (LEqual(arg6, FLG0)) {
		Store(1, ex00)
	} else {
		Store(m48c(PKG1, arg6), Local5)
		Store(ObjectType(Local5), Local7)
		if (LEqual(Local7, 2)) {
			if (LEqual(Local5, "Exc")) {
				Store(1, ex00)
			}
		}
	}

	Store(0, Local7)

	// m482:
	//
	// arg0-arg4 - parameters of operators
	// arg5      - miscellaneous
	// arg6      - opcode of operation


/*
 * //// ?????????????????????????
 * Uninitialized data should be passed to the operators immediately
 * in the m480 but not here to these Store opreations!!!!!!!!!!!!!!
 * But this will a few complicate m480 !!!!!!!!!!!!!!!!!!!!!!!!!!!!
 * //// ?????????????????????????
 */

	// Parameters (if not to save them Uninitialized)
	if (LNotEqual(arg1, 0xfff)) {
		Store(m484(arg1), Local0)
	}
	if (LNotEqual(arg2, 0xfff)) {
		Store(m484(arg2), Local1)
	}
	if (LNotEqual(arg3, 0xfff)) {
		Store(m484(arg3), Local2)
	}
	if (LNotEqual(arg4, 0xfff)) {
		Store(m484(arg4), Local3)
	}
	if (LNotEqual(arg5, 0xfff)) {
		Store(m484(arg5), Local4)
	}

	if (ex00) {
		Store(FLG2, tmp0)
		CH03(ts, z064, 0, 0, 0)
	}

	Store(m482(Local0, Local1, Local2, Local3, Local4, tmp0, arg0), Local7)

	if (ex00) {
		CH04(ts, 0, 0xff, z064, 1, 0, 0)
	} elseif (FLG1) {
		// Verify the first result
		m489(ts, Local7, Local5)
	}

	if (com2) {

		// The same operation but the first two arguments interchange

		if (LNotEqual(arg6, FLG0)) {
			if (LEqual(com2, 2)) {
				Store(0, ex00)
				Store(m48c(PKG2, arg6), Local5)
				Store(ObjectType(Local5), Local7)
				if (LEqual(Local7, 2)) {
					if (LEqual(Local5, "Exc")) {
						Store(1, ex00)
					}
				}
			}
		}

		if (ex00) {
			CH03(ts, z064, 2, 0, 0)
		}

		Store(m482(Local1, Local0, Local2, Local3, Local4, tmp0, arg0), Local7)

		if (ex00) {
			CH04(ts, 0, 0xff, z064, 3, 0, 0)
		} elseif (FLG1) {
			// Verify the second result
			m489(ts, Local7, Local5)
		}
	}

	return (Local7)
}

// Init all parameters as non-usable
Method(m486)
{
	Store(0, df00)
	Store(0, df01)
	Store(0, df02)
	Store(0, df03)
	Store(0, df04)
}

// Return the object of required type.
// Allowed types are {1-12,14}, == 0x5fff.
// Returned 0xfff is flag of "Uninitialized".
//
// These have to be implemented:
//
//	Method, Thermal Zone, DDB Handle
//
Method(m487, 1, Serialized)
{
	switch (ToInteger (Arg0)) {

		case (0) {
			// Uninitialized
			Store(0xfff, Local7)
		}
		case (1) {
			// Integers
			Store(0x100, Local7)
		}
		case (2) {
			// Strings
			Store(0x204, Local7)
		}
		case (3) {
			// Buffers
			Store(0x300, Local7)
		}
		case (4) {
			// Packages
			Store(0x400, Local7)
		}
		case (5) {
			// Field Units
			Store(0x500, Local7)
		}
		case (6) {
			// Devices
			Store(0x600, Local7)
		}
		case (7) {
			// Events
			Store(0x700, Local7)
		}
		case (8) {
			// Methods
			Store(0x800, Local7)
		}
		case (9) {
			// Mutexes
			Store(0x900, Local7)
		}
		case (10) {
			// Operation Regions
			Store(0xa00, Local7)
		}
		case (11) {
			// Power Resources
			Store(0xb00, Local7)
		}
		case (12) {
			// Processor
			Store(0xc00, Local7)
		}
		/*
		 * case (0xd00) {
		 *	// Thermal Zones
		 *	Store(Debug, Local7)
		 * }
		 */
		case (14) {
			// Buffer Field
			Store(0xe00, Local7)
		}
		/*
		 * case (0xf00) {
		 *	// DDB Handle
		 *	Store(Debug, Local7)
		 * }
		 *
		 *
		 * case (0x1000) {
		 *	// Debug Object
		 *	Store(Debug, Local7)
		 * }
		 */

		default {
			if (LNotEqual(arg0, 0)) {
				err("----------- ERROR, m487: incorrect Arg0:", z064, 1, 0, 0, 0, 0)
				Store(arg0, Debug)
				Store(0, Local7)
			}
		}
	}

	return (Local7)
}

// Initiate exception by inappropreate operand
Method(m488, 6, Serialized)
{
	Store(0, Local7)

	Name(lpN0, 0)
	Name(lpC0, 0)

	if (And(arg1, 0x5fff)) {
		Store(16, lpN0)
		Store(0, lpC0)
		While (lpN0) {
			ShiftLeft(1, lpC0, Local6)
			if (And(arg1, Local6)) {
				Store(m487(lpC0), Local5)
				Store(m485(arg0, Local5, df01, df02, df03, df04, FLG0), Local7)
			}
			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	if (And(arg2, 0x5fff)) {
		Store(16, lpN0)
		Store(0, lpC0)
		While (lpN0) {
			ShiftLeft(1, lpC0, Local6)
			if (And(arg2, Local6)) {
				Store(m487(lpC0), Local5)
				Store(m485(arg0, df00, Local5, df02, df03, df04, FLG0), Local7)
			}
			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	if (And(arg3, 0x5fff)) {
		Store(16, lpN0)
		Store(0, lpC0)
		While (lpN0) {
			ShiftLeft(1, lpC0, Local6)
			if (And(arg3, Local6)) {
				Store(m487(lpC0), Local5)
				Store(m485(arg0, df00, df01, Local5, df03, df04, FLG0), Local7)
			}
			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	if (And(arg4, 0x5fff)) {
		Store(16, lpN0)
		Store(0, lpC0)
		While (lpN0) {
			ShiftLeft(1, lpC0, Local6)
			if (And(arg4, Local6)) {
				Store(m487(lpC0), Local5)
				Store(m485(arg0, df00, df01, df02, Local5, df04, FLG0), Local7)
			}
			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	if (And(arg5, 0x5fff)) {
		Store(16, lpN0)
		Store(0, lpC0)
		While (lpN0) {
			ShiftLeft(1, lpC0, Local6)
			if (And(arg5, Local6)) {
				Store(m487(lpC0), Local5)
				Store(m485(arg0, df00, df01, df02, df03, Local5, FLG0), Local7)
			}
			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	return (Local7)
}

Method(m489, 3)
{
	Store(ObjectType(arg1), Local0)
	Store(ObjectType(arg2), Local1)

	if (LNotEqual(Local0, Local1)) {
		err(arg0, z064, 2, 0, 0, Local0, Local1)
	} elseif (LNotEqual(arg1, arg2)) {
		err(arg0, z064, 3, 0, 0, arg1, arg2)
	}
}

// Verify result
// <name>,<results>,<result>,<index of result pair>
Method(m48a, 4)
{
	Multiply(arg3, 2, Local0)
	Store(DeRefOf(Index(arg1, Local0)), Local7)
	Increment(Local0)
	Store(DeRefOf(Index(arg1, Local0)), Local6)

	if (F64) {
		if (LNotEqual(arg2, Local7)) {
			err(arg0, z064, 4, 0, 0, arg2, Local7)
		}
	} else {
		if (LNotEqual(arg2, Local6)) {
			err(arg0, z064, 5, 0, 0, arg2, Local6)
		}
	}
}

// Integer two operands operation
// <operation>,<type of first operand>
//
// NOTE: now it work only by particular parts,
//       all together produce crashes. Uncomment
//       in future.
Method(m48b, 2)
{
	// X - Integer

	Store(m485(arg0, arg1, 0x100, 0, 0, 0, 0), Local7)

	// X - String

	Store(m485(arg0, arg1, 0x200, 0, 0, 0, 1), Local7)
	Store(m485(arg0, arg1, 0x201, 0, 0, 0, 2), Local7)
	Store(m485(arg0, arg1, 0x202, 0, 0, 0, 3), Local7)
	Store(m485(arg0, arg1, 0x203, 0, 0, 0, 4), Local7)
	Store(m485(arg0, arg1, 0x204, 0, 0, 0, 5), Local7)
	Store(m485(arg0, arg1, 0x205, 0, 0, 0, 6), Local7)
	Store(m485(arg0, arg1, 0x206, 0, 0, 0, 7), Local7)
	Store(m485(arg0, arg1, 0x207, 0, 0, 0, 8), Local7)
	Store(m485(arg0, arg1, 0x208, 0, 0, 0, 9), Local7)
	Store(m485(arg0, arg1, 0x209, 0, 0, 0, 10), Local7)
	Store(m485(arg0, arg1, 0x20a, 0, 0, 0, 11), Local7)
	Store(m485(arg0, arg1, 0x20b, 0, 0, 0, 12), Local7)
	Store(m485(arg0, arg1, 0x20c, 0, 0, 0, 13), Local7)
	Store(m485(arg0, arg1, 0x20d, 0, 0, 0, 14), Local7)
	Store(m485(arg0, arg1, 0x20e, 0, 0, 0, 15), Local7)
	Store(m485(arg0, arg1, 0x20f, 0, 0, 0, 16), Local7)
	Store(m485(arg0, arg1, 0x210, 0, 0, 0, 17), Local7)

	// X - Buffer

	Store(m485(arg0, arg1, 0x300, 0, 0, 0, 18), Local7)
	Store(m485(arg0, arg1, 0x301, 0, 0, 0, 19), Local7)
	Store(m485(arg0, arg1, 0x302, 0, 0, 0, 20), Local7)
	Store(m485(arg0, arg1, 0x303, 0, 0, 0, 21), Local7)
	Store(m485(arg0, arg1, 0x304, 0, 0, 0, 22), Local7)
	Store(m485(arg0, arg1, 0x305, 0, 0, 0, 23), Local7)
	Store(m485(arg0, arg1, 0x306, 0, 0, 0, 24), Local7)
	Store(m485(arg0, arg1, 0x307, 0, 0, 0, 25), Local7)
	Store(m485(arg0, arg1, 0x308, 0, 0, 0, 26), Local7)

	// X - Field Unit

	Store(m485(arg0, arg1, 0x500, 0, 0, 0, 27), Local7)
	Store(m485(arg0, arg1, 0x501, 0, 0, 0, 28), Local7)
	Store(m485(arg0, arg1, 0x502, 0, 0, 0, 29), Local7)
	Store(m485(arg0, arg1, 0x503, 0, 0, 0, 30), Local7)
	Store(m485(arg0, arg1, 0x504, 0, 0, 0, 31), Local7)
	Store(m485(arg0, arg1, 0x505, 0, 0, 0, 32), Local7)
	Store(m485(arg0, arg1, 0x506, 0, 0, 0, 33), Local7)
	Store(m485(arg0, arg1, 0x507, 0, 0, 0, 34), Local7)
	Store(m485(arg0, arg1, 0x508, 0, 0, 0, 35), Local7)
	Store(m485(arg0, arg1, 0x509, 0, 0, 0, 36), Local7)
	Store(m485(arg0, arg1, 0x50a, 0, 0, 0, 37), Local7)

	// X - Buffer Field

	Store(m485(arg0, arg1, 0xe00, 0, 0, 0, 38), Local7)
	Store(m485(arg0, arg1, 0xe01, 0, 0, 0, 39), Local7)
	Store(m485(arg0, arg1, 0xe02, 0, 0, 0, 40), Local7)
	Store(m485(arg0, arg1, 0xe03, 0, 0, 0, 41), Local7)
	Store(m485(arg0, arg1, 0xe04, 0, 0, 0, 42), Local7)
	Store(m485(arg0, arg1, 0xe05, 0, 0, 0, 43), Local7)
	Store(m485(arg0, arg1, 0xe06, 0, 0, 0, 44), Local7)
	Store(m485(arg0, arg1, 0xe07, 0, 0, 0, 45), Local7)
	Store(m485(arg0, arg1, 0xe08, 0, 0, 0, 46), Local7)
	Store(m485(arg0, arg1, 0xe09, 0, 0, 0, 47), Local7)
	Store(m485(arg0, arg1, 0xe0a, 0, 0, 0, 48), Local7)
}

// Return element of Package
// <Package>,<index of elements-pair>
// pair: {F64-element, F32-element}
Method(m48c, 2)
{
	Multiply(arg1, 2, Local0)

	if (F64) {
		Store(DeRefOf(Index(arg0, Local0)), Local7)
	} else {
		Increment(Local0)
		Store(DeRefOf(Index(arg0, Local0)), Local7)
	}
	return (Local7)
}

// arg0 - opcode of operation
//
// arg1 - type of 0-th argument
// arg2 - type of 1-th argument
// arg3 - type of 2-th argument
// arg4 - type of 3-th argument
//
// arg5 - expected 64-bit result
// arg6 - expected 32-bit result
Method(m48d, 7, Serialized)
{
	Name(ts, "m48d")
	Name(tmp0, 0)

	if (0) {
		Store("##################################################################", Debug)
		Store(arg6, Debug)
	}

	Name(ex00, 0)

	if (F64) {
		Store(ObjectType(arg5), Local0)
		if (LEqual(Local0, 2)) {
			if (LEqual(arg5, "Exc")) {
				Store(1, ex00)
			}
		}
	} else {
		Store(ObjectType(arg6), Local0)
		if (LEqual(Local0, 2)) {
			if (LEqual(arg6, "Exc")) {
				Store(1, ex00)
			}
		}
	}

	Store(0, Local7)

	// m482:
	//
	// arg0-arg4 - parameters of operators
	// arg5      - miscellaneous
	// arg6      - opcode of operation

	Store(m484(arg1), Local0)
	Store(m484(arg2), Local1)
	Store(m484(arg3), Local2)
	Store(m484(arg4), Local3)

	if (ex00) {
		Store(FLG2, tmp0)
		CH03(ts, z064, 4, 0, 0)
	}

	Store(m482(Local0, Local1, Local2, Local3, 0, tmp0, arg0), Local7)

	if (ex00) {
		CH04(ts, 0, 0xff, z064, 5, 0, 0)
	} else {

		// Verify the result

		if (F64) {
			m489(ts, Local7, arg5)
		} else {
			m489(ts, Local7, arg6)
		}
	}

	return (Local7)
}
