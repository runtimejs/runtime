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
 * Data type conversion and manipulation
 */

/*
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SEE: to be a few updated, see below
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/


// ObjectType, Type of object

// Check ObjectType operator for:
// - all the Types of objects,
// - all the ways Obtaining those objects,
// - all the ways Passing objects to ObjectType.
//
// Types     - {0-16}, see specs.
// Obtaining - different creating operators,...
// Passing   - immediately local, immediately global,
//             by ArgX, by LocalX,...


Name(z040, 40)

// Global objects

Name(n002, 0x90801020)
Name(n003, 0x9189192989396949)
Name(n005, "9876")
Name(b003, Buffer(4) {12, 13, 14, 15})

// Exercise all the ways creating the source objects of different types
//
//  0 - Uninitialized
//
//  Integers
//
//      One, Ones, Zero, Revision, Timer          (compile error)
//      immediate 32-bit Integer constant imagine (compile error)
//      immediate 64-bit Integer constant imagine (compile error)
//
//  1 - 32-bit Integers
//
//      32-bit Integer passed by LocalX
//      32-bit Integer passed by ArgX
//      32-bit Integer passed by local Name
//      32-bit Integer passed by global Name
//
//  2 - 64-bit Integers
//
//      64-bit Integer passed by LocalX
//      64-bit Integer passed by ArgX
//      64-bit Integer passed by local Name
//      64-bit Integer passed by global Name
//
// String
//
//  3 - String
//
// Field Units
//
//  4 - Field Unit created by Field
//  5 - Field Unit created by BankField
//  6 - Field Unit created by IndexField
//
// Buffers
//
//    - buffer passed immediately (compile error)
//  7 - buffer passed by LocalX
//  8 - buffer passed by ArgX
//  9 - buffer passed by local Name
// 10 - buffer passed by global Name
//
// Buffer Fields
//
// 11 - CreateBitField          (bit field)
// 12 - CreateByteField         (byte field)
// 13 - CreateDWordField        (DWord field)
// 14 - CreateField      32-bit (arbitrary length bit field)
// 15 - CreateField      64-bit (arbitrary length bit field)
// 16 - CreateField      65-bit (arbitrary length bit field)
// 17 - CreateQWordField        (QWord field)
// 18 - CreateWordField         (Word field)
//
// 19 - Index, Index with String   (reference to Buffer Fields)
// 20 - Index, Index with Buffer   (reference to Buffer Fields)
// 21 - Index, Index with Package  (reference to object in Package)
//
// 22 - Data Table Operation Region
// 23 - Debug Object
// 24 - Device
// 25 - Event
// 26 - Method
// 27 - Function
// 28 - Mutex
// 29 - Operation Region
// 30 - Package
// 31 - Power Resource
// 32 - Processor
// 33 - Thermal Zone
// 34 - DDB Handle
//
//
// Name - add all other objects by the name and so on ... !!!!!!!!!!!!!!!!!
//
//
// Local7 - returned result
//
Method(m0f1, 7, Serialized)
{
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	OperationRegion(r001, SystemMemory, 0x100, 0x100)

	if (arg1) {
		Store(0, Local7)
	}

	switch (ToInteger (arg1)) {
		case (0) {

			// Uninitialized

			/*
			 * Bug 9 fixed.
			 * if (arg1) {
			 *	Store(0, Local0)
			 *	Store(0, Local1)
			 *	Store(0, Local2)
			 *	Store(0, Local3)
			 *	Store(0, Local4)
			 *	Store(0, Local5)
			 *	Store(0, Local6)
			 *	Store(0, Local7)
			 * }
			 */

			Store(ObjectType(Local0), Local7)
			if (LNotEqual(Local7, c008)) {
				err(arg0, z040, 0, 0, 0, Local7, c008)
			}
			Store(ObjectType(Local1), Local7)
			if (LNotEqual(Local7, c008)) {
				err(arg0, z040, 1, 0, 0, Local7, c008)
			}
			Store(ObjectType(Local2), Local7)
			if (LNotEqual(Local7, c008)) {
				err(arg0, z040, 2, 0, 0, Local7, c008)
			}
			Store(ObjectType(Local3), Local7)
			if (LNotEqual(Local7, c008)) {
				err(arg0, z040, 3, 0, 0, Local7, c008)
			}
			Store(ObjectType(Local4), Local7)
			if (LNotEqual(Local7, c008)) {
				err(arg0, z040, 4, 0, 0, Local7, c008)
			}
			Store(ObjectType(Local5), Local7)
			if (LNotEqual(Local7, c008)) {
				err(arg0, z040, 5, 0, 0, Local7, c008)
			}
			Store(ObjectType(Local6), Local7)
			if (LNotEqual(Local7, c008)) {
				err(arg0, z040, 6, 0, 0, Local7, c008)
			}
		}
		case (1) {

			// 32-bit Integers

			// By LocalX

			Store(0x12345678, Local0)
			Store(ObjectType(Local0), Local7)
			if (LNotEqual(Local7, c009)) {
				err(arg0, z040, 7, 0, 0, Local7, c009)
			}
			if (LNotEqual(Local0, 0x12345678)) {
				err(arg0, z040, 8, 0, 0, Local0, 0x12345678)
			}

			// By ArgX

			Store(ObjectType(Arg2), Local7)
			if (LNotEqual(Local7, c009)) {
				err(arg0, z040, 9, 0, 0, Local7, c009)
			}
			if (LNotEqual(Arg2, 0x81223344)) {
				err(arg0, z040, 10, 0, 0, Arg2, 0x81223344)
			}

			// By Name locally

			Name(n000, 0x98127364)
			Store(ObjectType(n000), Local7)
			if (LNotEqual(Local7, c009)) {
				err(arg0, z040, 11, 0, 0, Local7, c009)
			}
			if (LNotEqual(n000, 0x98127364)) {
				err(arg0, z040, 12, 0, 0, n000, 0x98127364)
			}

			// By Name globally

			Store(ObjectType(n002), Local7)
			if (LNotEqual(Local7, c009)) {
				err(arg0, z040, 13, 0, 0, Local7, c009)
			}
			if (LNotEqual(n002, 0x90801020)) {
				err(arg0, z040, 14, 0, 0, n002, 0x90801020)
			}

			// Not a Buffer in 32-bit mode

			Store(0xa1b2c3d4e5c6e7f8, Local0)
			Store(ObjectType(Local0), Local7)
			if (LNotEqual(Local7, c009)) {
				err(arg0, z040, 15, 0, 0, Local7, c009)
			}
		}
		case (2) {

			// 64-bit Integers

			if (LEqual(F64, 1)) {

				// By LocalX

				Store(0xa1b2c3d4e5c6e7f8, Local0)
				Store(ObjectType(Local0), Local7)
				if (LNotEqual(Local7, c009)) {
					err(arg0, z040, 16, 0, 0, Local7, c009)
				}
				if (LNotEqual(Local0, 0xa1b2c3d4e5c6e7f8)) {
					err(arg0, z040, 17, 0, 0, Local0, 0xa1b2c3d4e5c6e7f8)
				}

				// By ArgX

				Store(ObjectType(Arg2), Local7)
				if (LNotEqual(Local7, c009)) {
					err(arg0, z040, 18, 0, 0, Local7, c009)
				}
				if (LNotEqual(Arg2, 0xfabefac489501248)) {
					err(arg0, z040, 19, 0, 0, Arg2, 0xfabefac489501248)
				}

				// By Name locally

				Name(n001, 0x9081122384356647)
				Store(ObjectType(n001), Local7)
				if (LNotEqual(Local7, c009)) {
					err(arg0, z040, 20, 0, 0, Local7, c009)
				}
				if (LNotEqual(n001, 0x9081122384356647)) {
					err(arg0, z040, 21, 0, 0, n001, 0x9081122384356647)
				}

				// By Name globally

				Store(ObjectType(n003), Local7)
				if (LNotEqual(Local7, c009)) {
					err(arg0, z040, 22, 0, 0, Local7, c009)
				}
				if (LNotEqual(n003, 0x9189192989396949)) {
					err(arg0, z040, 23, 0, 0, n003, 0x9189192989396949)
				}
			}
		}
		case (3) {

			// String

			// By LocalX

			Store("", Local0)
			Store(ObjectType(Local0), Local7)
			if (LNotEqual(Local7, c00a)) {
				err(arg0, z040, 24, 0, 0, Local7, c00a)
			}

			Store("1", Local0)
			Store(ObjectType(Local0), Local7)
			if (LNotEqual(Local7, c00a)) {
				err(arg0, z040, 25, 0, 0, Local7, c00a)
			}

			Store("abcd", Local0)
			Store(ObjectType(Local0), Local7)
			if (LNotEqual(Local7, c00a)) {
				err(arg0, z040, 26, 0, 0, Local7, c00a)
			}

			Store("qwrt", Local0)
			Store(ObjectType(Local0), Local7)
			if (LNotEqual(Local7, c00a)) {
				err(arg0, z040, 27, 0, 0, Local7, c00a)
			}

			// By ArgX

			Store(ObjectType(Arg2), Local7)
			if (LNotEqual(Local7, c00a)) {
				err(arg0, z040, 28, 0, 0, Local7, c00a)
			}
			if (LNotEqual(Arg2, "zxcvbnm0912345678ok")) {
				err(arg0, z040, 29, 0, 0, Arg2, "zxcvbnm0912345678ok")
			}

			// By Name locally

			Name(n004, "")
			Store(ObjectType(n004), Local7)
			if (LNotEqual(Local7, c00a)) {
				err(arg0, z040, 30, 0, 0, Local7, c00a)
			}
			if (LNotEqual(n004, "")) {
				err(arg0, z040, 31, 0, 0, n004, "")
			}

			// By Name globally

			Store(ObjectType(n005), Local7)
			if (LNotEqual(Local7, c00a)) {
				err(arg0, z040, 32, 0, 0, Local7, c00a)
			}
			if (LNotEqual(n005, "9876")) {
				err(arg0, z040, 33, 0, 0, n005, "9876")
			}

		}
		case (4) {

			// Field Unit

			// OperationRegion(r000, SystemMemory, 0x100, 0x100)
			Field(r000, ByteAcc, NoLock, Preserve) {
				f000, 8,
				f222, 32,
				f223, 57,
				f224, 64,
				f225, 71
			}
			Store(0x8d, f000)

			Store(ObjectType(f000), Local7)
			if (LNotEqual(Local7, c00d)) {
				err(arg0, z040, 34, 0, 0, Local7, c00d)
			}
			if (LNotEqual(f000, 0x8d)) {
				err(arg0, z040, 35, 0, 0, f000, 0x8d)
			}

			Store(ObjectType(f222), Local7)
			if (LNotEqual(Local7, c00d)) {
				err(arg0, z040, 36, 0, 0, Local7, c00d)
			}
			Store(ObjectType(f223), Local7)
			if (LNotEqual(Local7, c00d)) {
				err(arg0, z040, 37, 0, 0, Local7, c00d)
			}
			Store(ObjectType(f224), Local7)
			if (LNotEqual(Local7, c00d)) {
				err(arg0, z040, 38, 0, 0, Local7, c00d)
			}
			Store(ObjectType(f225), Local7)
			if (LNotEqual(Local7, c00d)) {
				err(arg0, z040, 39, 0, 0, Local7, c00d)
			}
		}
		case (5) {

			// BankField

			// OperationRegion(r001, SystemMemory, 0x100, 0x100)
			Field(r001, ByteAcc, NoLock, Preserve) {
				bnk0, 8
			}
			BankField(r001, bnk0, 0, ByteAcc, NoLock, Preserve) {
				Offset(16),
				bkf0, 8,
			}
			Store(0x95, bkf0)

			Store(ObjectType(bkf0), Local7)
			if (LNotEqual(Local7, c00d)) {
				err(arg0, z040, 40, 0, 0, Local7, c00d)
			}
			if (LNotEqual(bkf0, 0x95)) {
				err(arg0, z040, 41, 0, 0, bkf0, 0x95)
			}
		}
		case (6) {

			// IndexField

			OperationRegion(r002, SystemMemory, 0x100, 0x100)
			Field(r002, ByteAcc, NoLock, Preserve) {
				f00a, 16,
				f00b, 16
			}
			IndexField (f00a, f00b, ByteAcc, NoLock, Preserve) {
				if00, 8,
				if01, 8
			}

			Store(0xa0, f00a)
			Store(0xa1, f00b)
			Store(0xa2, if00)
			Store(0xa3, if01)

			Store(ObjectType(f00a), Local7)
			if (LNotEqual(Local7, c00d)) {
				err(arg0, z040, 42, 0, 0, Local7, c00d)
			}
			Store(ObjectType(f00b), Local7)
			if (LNotEqual(Local7, c00d)) {
				err(arg0, z040, 43, 0, 0, Local7, c00d)
			}
			Store(ObjectType(if00), Local7)
			if (LNotEqual(Local7, c00d)) {
				err(arg0, z040, 44, 0, 0, Local7, c00d)
			}
			Store(ObjectType(if01), Local7)
			if (LNotEqual(Local7, c00d)) {
				err(arg0, z040, 45, 0, 0, Local7, c00d)
			}
		}
		case (7) {

			// Buffer

			Store(Buffer(4) {0, 1, 2, 3}, Local0)
			Store(ObjectType(Local0), Local7)
			if (LNotEqual(Local7, c00b)) {
				err(arg0, z040, 46, 0, 0, Local7, c00b)
			}
			if (LNotEqual(Local0, Buffer(4) {0, 1, 2, 3})) {
				err(arg0, z040, 47, 0, 0, 0, 0)
			}
		}
		case (8) {

			// Buffer

			Store(ObjectType(Arg2), Local7)
			if (LNotEqual(Local7, c00b)) {
				err(arg0, z040, 48, 0, 0, Local7, c00b)
			}
			if (LNotEqual(Arg2, Buffer(4) {4, 5, 6, 7})) {
				err(arg0, z040, 49, 0, 0, 0, 0)
			}
		}
		case (9) {

			// Buffer

			Name(b000, Buffer(4) {8, 9, 10, 11})
			Store(ObjectType(b000), Local7)
			if (LNotEqual(Local7, c00b)) {
				err(arg0, z040, 50, 0, 0, Local7, c00b)
			}
			if (LNotEqual(b000, Buffer(4) {8, 9, 10, 11})) {
				err(arg0, z040, 51, 0, 0, 0, 0)
			}
		}
		case (10) {

			// Buffer

			Store(ObjectType(b003), Local7)
			if (LNotEqual(Local7, c00b)) {
				err(arg0, z040, 52, 0, 0, Local7, c00b)
			}
			if (LNotEqual(b003, Buffer(4) {12, 13, 14, 15})) {
				err(arg0, z040, 53, 0, 0, 0, 0)
			}
		}
		case (11) {

			// Buffer Field

			Store(Buffer(4) {16, 17, 18, 19}, Local0)
			CreateBitField(Local0, 3, f001)
			Store(ObjectType(f001), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 54, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, Buffer(4) {16, 17, 18, 19})) {
				err(arg0, z040, 55, 0, 0, 0, 0)
			}
		}
		case (12) {

			// Buffer Field

			Store(Buffer(4) {20, 21, 22, 23}, Local0)
			CreateByteField(Local0, 3, f002)
			Store(ObjectType(f002), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 56, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, Buffer(4) {20, 21, 22, 23})) {
				err(arg0, z040, 57, 0, 0, 0, 0)
			}
		}
		case (13) {

			// Buffer Field

			Store(Buffer(4) {24, 25, 26, 27}, Local0)
			CreateDWordField(Local0, 0, f003)
			Store(ObjectType(f003), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 58, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, Buffer(4) {24, 25, 26, 27})) {
				err(arg0, z040, 59, 0, 0, 0, 0)
			}
		}
		case (14) {

			// Buffer Field

			Store(Buffer(4) {28, 29, 30, 31}, Local0)
			CreateField(Local0, 0, 32, f004)
			Store(ObjectType(f004), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 60, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, Buffer(4) {28, 29, 30, 31})) {
				err(arg0, z040, 61, 0, 0, 0, 0)
			}
		}
		case (15) {

			// Buffer Field

			Store(Buffer() {33, 34, 35, 36, 37, 38, 39, 40, 41}, Local0)
			CreateField(Local0, 0, 64, f005)
			Store(ObjectType(f005), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 62, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, Buffer() {33, 34, 35, 36, 37,
								38, 39, 40, 41})) {
				err(arg0, z040, 63, 0, 0, 0, 0)
			}
		}
		case (16) {

			// Buffer Field

			Store(Buffer() {42, 43, 44, 45, 46, 47, 48, 49, 50}, Local0)
			CreateField(Local0, 0, 65, f006)
			Store(ObjectType(f006), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 64, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, Buffer() {42, 43, 44, 45, 46, 47, 48, 49, 50})) {
				err(arg0, z040, 65, 0, 0, 0, 0)
			}

			CreateField(Local0, 0, 17, f111)
			Store(ObjectType(f111), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 66, 0, 0, Local7, c016)
			}
			CreateField(Local0, 0, 57, f112)
			Store(ObjectType(f112), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 67, 0, 0, Local7, c016)
			}
		}
		case (17) {

			// Buffer Field

			Store(Buffer() {42, 43, 44, 45, 46, 47, 48, 49, 50}, Local0)
			CreateQWordField(Local0, 0, f007)
			Store(ObjectType(f007), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 68, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, Buffer() {42, 43, 44, 45, 46, 47, 48, 49, 50})) {
				err(arg0, z040, 69, 0, 0, 0, 0)
			}
		}
		case (18) {

			// Buffer Field

			Store(Buffer() {51, 52, 53, 54}, Local0)
			CreateWordField(Local0, 0, f008)
			Store(ObjectType(f008), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 70, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, Buffer() {51, 52, 53, 54})) {
				err(arg0, z040, 71, 0, 0, 0, 0)
			}
		}
		case (19) {

			// Buffer Field

			Store("q", Local0)
			Store(Index(Local0, 0), Local1)
			Store(ObjectType(Local1), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 72, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, "q")) {
				err(arg0, z040, 73, 0, 0, 0, 0)
			}

			Store("qw", Local0)
			Store(Index(Local0, 0), Local1)
			Store(ObjectType(Local1), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 74, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, "qw")) {
				err(arg0, z040, 75, 0, 0, 0, 0)
			}

			Store("qwertyu", Local0)
			Store(Index(Local0, 0), Local1)
			Store(ObjectType(Local1), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 76, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, "qwertyu")) {
				err(arg0, z040, 77, 0, 0, 0, 0)
			}

			Store("qwertyuiop", Local0)
			Store(Index(Local0, 0), Local1)
			Store(ObjectType(Local1), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 78, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, "qwertyuiop")) {
				err(arg0, z040, 79, 0, 0, 0, 0)
			}
		}
		case (20) {

			// Buffer Field

			Store(Buffer() {42, 43, 44, 45}, Local0)
			Store(Index(Local0, 0), Local1)
			Store(ObjectType(Local1), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 80, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, Buffer() {42, 43, 44, 45})) {
				err(arg0, z040, 81, 0, 0, 0, 0)
			}

			Store(Buffer() {42, 43, 44, 45, 46, 47, 48, 49}, Local0)
			Store(Index(Local0, 0), Local1)
			Store(ObjectType(Local1), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 82, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, Buffer() {42, 43, 44, 45, 46, 47, 48, 49})) {
				err(arg0, z040, 83, 0, 0, 0, 0)
			}

			Store(Buffer() {42, 43, 44, 45, 46, 47, 48, 49, 50}, Local0)
			Store(Index(Local0, 0), Local1)
			Store(ObjectType(Local1), Local7)
			if (LNotEqual(Local7, c016)) {
				err(arg0, z040, 84, 0, 0, Local7, c016)
			}
			if (LNotEqual(Local0, Buffer() {42, 43, 44, 45, 46, 47, 48, 49, 50})) {
				err(arg0, z040, 85, 0, 0, 0, 0)
			}
		}
		case (21) {

			// Index with ...

			Store(Package() {
					Package() {
						0x98765432,
						Buffer() {0x12},
						Package() {0x12345678},
						"qwertyui"},
					Buffer() {0x12},
					"q",
					0x98765432}, LOcal0)

			// Package

			Store(Index(Local0, 0), Local1)
			Store(ObjectType(Local1), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 86, 0, 0, Local7, c00c)
			}

			// Buffer

			Store(Index(Local0, 1), Local1)
			Store(ObjectType(Local1), Local7)
			if (LNotEqual(Local7, c00b)) {
				err(arg0, z040, 87, 0, 0, Local7, c00b)
			}

			// String

			Store(Index(Local0, 2), Local1)
			Store(ObjectType(Local1), Local7)
			if (LNotEqual(Local7, c00a)) {
				err(arg0, z040, 88, 0, 0, Local7, c00a)
			}

			// Integer

			Store(Index(Local0, 3), Local1)
			Store(ObjectType(Local1), Local7)
			if (LNotEqual(Local7, c009)) {
				err(arg0, z040, 89, 0, 0, Local7, c009)
			}
		}
		case (22) {

			// Operation Region

			DataTableRegion (HDR0, "DSDT", "", "")
			Store(ObjectType(HDR0), Local7)
			if (LNotEqual(Local7, c012)) {
				err(arg0, z040, 90, 0, 0, Local7, c012)
			}
		}
		case (23) {

			// Debug Object

			Store(ObjectType(Debug), Local7)
			if (LNotEqual(Local7, c018)) {
				err(arg0, z040, 91, 0, 0, Local7, c018)
			}
		}
		case (24) {

			// Device

			Device(dv00) {}
			Store(ObjectType(dv00), Local7)
			if (LNotEqual(Local7, c00e)) {
				err(arg0, z040, 92, 0, 0, Local7, c00e)
			}
		}
		case (25) {

			// Event

			Event(evt0)
			Store(ObjectType(evt0), Local7)
			if (LNotEqual(Local7, c00f)) {
				err(arg0, z040, 93, 0, 0, Local7, c00f)
			}
		}
		case (26) {

			// Method

			Method(m0f2) { return (0x1234) }
			Store(ObjectType(m0f2), Local7)
			if (LNotEqual(Local7, c010)) {
				err(arg0, z040, 94, 0, 0, Local7, c010)
			}
		}
		case (27) {
/*
 *			// Function
 *
 *			Function(mof3) { return (0) }
 *			Store(ObjectType(m0f3), Local7)
 *			if (LNotEqual(Local7, c010)) {
 *				err(arg0, z040, 95, 0, 0, Local7, c010)
 *			}
 */
		}
		case (28) {

			// Mutex

			Mutex(mt00, 0)
			Store(ObjectType(mt00), Local7)
			if (LNotEqual(Local7, c011)) {
				err(arg0, z040, 96, 0, 0, Local7, c011)
			}
		}
		case (29) {

			// Operation Region

			Store(ObjectType(r000), Local7)
			if (LNotEqual(Local7, c012)) {
				err(arg0, z040, 97, 0, 0, Local7, c012)
			}
			Store(ObjectType(r001), Local7)
			if (LNotEqual(Local7, c012)) {
				err(arg0, z040, 98, 0, 0, Local7, c012)
			}
		}
		case (30) {

			// Package

			Name(p000, Package() {0x12345678})
			Name(p001, Package() {0x12345678, 0x9abcdef0})
			Name(p002, Package() {0x12345678, 0x9abcdef0, 0x9abcdef0})
			Name(p003, Package() {0x123456789abcdef0})
			Name(p004, Package() {0x123456789abcdef0, 0x123456789abcdef0})
			Name(p005, Package() {0x123456789abcdef0,
							0x123456789abcdef0, 0x123456789abcdef0})
			Name(p006, Package() {Buffer(1) {}})
			Name(p007, Package() {Buffer(32) {}})
			Name(p008, Package() {Buffer(64) {}})
			Name(p009, Package() {Buffer(125) {}})
			Name(p00a, Package() {0x12, Buffer() {0x12}})
			Name(p00b, Package() {0x12, Package() {0x12}})
			Name(p00c, Package() {Buffer() {0x12}})
			Name(p00d, Package() {Buffer() {0x12}, 0x12345678})
			Name(p00e, Package() {Buffer() {0x12}, Buffer() {0x12}})
			Name(p00f, Package() {Buffer() {0x12}, Package() {0x12}})
			Name(p010, Package() {Package() {0x12345678}})
			Name(p011, Package() {Package() {0x12345678}, 0x12345678})
			Name(p012, Package() {Package() {0x12345678}, Buffer() {0x12}})
			Name(p013, Package() {Package() {0x12345678}, Package() {0x12}})


			Store(ObjectType(p000), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 99, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p001), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 100, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p002), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 101, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p003), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 102, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p004), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 103, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p005), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 104, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p006), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 105, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p007), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 106, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p008), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 107, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p009), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 108, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p00a), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 109, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p00b), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 110, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p00c), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 111, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p00d), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 112, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p00e), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 113, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p00f), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 114, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p010), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 115, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p011), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 116, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p012), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 117, 0, 0, Local7, c00c)
			}
			Store(ObjectType(p013), Local7)
			if (LNotEqual(Local7, c00c)) {
				err(arg0, z040, 118, 0, 0, Local7, c00c)
			}
		}
		case (31) {

			// Power Resource

			PowerResource(pwr0, 1, 0) {Method(m000){return (0)}}
			Store(ObjectType(pwr0), Local7)
			if (LNotEqual(Local7, c013)) {
				err(arg0, z040, 119, 0, 0, Local7, c013)
			}
		}
		case (32) {

			// Processor

			Processor(pr00, 0, 0xFFFFFFFF, 0) {}
			Store(ObjectType(pr00), Local7)
			if (LNotEqual(Local7, c014)) {
				err(arg0, z040, 120, 0, 0, Local7, c014)
			}
		}
		case (33) {
			ThermalZone(tz00) {}
			Store(ObjectType(tz00), Local7)
			if (LNotEqual(Local7, c015)) {
				err(arg0, z040, 121, 0, 0, Local7, c015)
			}
		}
		case (34) {
/*
			// Reserved for DDB Handle

Store("==================================== zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz", Debug)

//			Store (LoadTable ("OEM1", "MYOEM", "TABLE1", "\\_SB.PCI0", "MYD",
//					 	Package () {0, "\\_SB.PCI0"}), Local0)

			Store (LoadTable("OEM1", "MYOEM", "TABLE1"), Local0)
			Store(ObjectType(Local0), Local7)
			if (LNotEqual(Local7, c017)) {
				err(arg0, z040, 122, 0, 0, Local7, c017)
			}

Store("==================================== uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu", Debug)
*/
		}
		Default {
			err(arg0, z040, 123, 0, 0, 0, 0)
		}
	}

	return (Local7)
}

Method(m0f0, 0, Serialized)
{
	Name(ts, "m0f0")

	Store("TEST: m0f0, ObjectType", Debug)

	Store(0, Local5)
	Store(35, Local4)

	While(Local4) {

		Store(0, Local2)

		switch (ToInteger (Local5)) {
			case (1) {
				Store(0x81223344, Local2)
			}
			case (2) {
				Store(0xfabefac489501248, Local2)
			}
			case (3) {
				Store("zxcvbnm0912345678ok", Local2)
			}
			case (8) {
				Store(Buffer(4) {4, 5, 6, 7}, Local2)
			}
		}

		m0f1(ts, Local5, Local2, 0, 0, 0, 0)

		Increment(Local5)
		Decrement(Local4)
	}
}

// Run-method
Method(OBT0)
{
	Store("TEST: OBT0, Type of object", Debug)

	m0f0()
}
