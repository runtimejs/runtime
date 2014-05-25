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

Name(z042, 42)

Mutex(MT04, 0)

// Verifying 1-parameter, 1-result operator
Method(m302, 6, Serialized)
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
				ToInteger(Local0, Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z042, 0, 0, 0, Local5, arg2)
					return (1)
				}
			}
			case (1) {
				ToBuffer(Local0, Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z042, 1, 0, 0, Local5, arg2)
					return (1)
				}
			}
			case (2) {
				ToString(Local0, , Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z042, 2, 0, 0, Local5, arg2)
					return (1)
				}
			}
			case (3) {
				ToDecimalString(Local0, Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z042, 3, 0, 0, Local5, arg2)
					return (1)
				}
			}
			case (4) {
				ToHexString(Local0, Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z042, 4, 0, 0, Local5, arg2)
					return (1)
				}
			}
			case (5) {
				ToBCD(Local0, Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z042, 5, 0, 0, Local5, arg2)
					return (1)
				}
			}
			case (6) {
				FromBCD(Local0, Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z042, 6, 0, 0, Local5, arg2)
					return (1)
				}
			}
			case (7) {	// ToUUID macro
				Store(Local0, Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z042, 7, 0, 0, Local5, arg2)
					return (1)
				}
			}
			case (8) {	// Unicode macro
				Store(Local0, Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z042, 8, 0, 0, Local5, arg2)
					return (1)
				}
			}
			case (9) {	// EISAID macro
				Store(Local0, Local2)
				if (LNotEqual(Local2, Local1)) {
					err(arg0, z042, 9, 0, 0, Local5, arg2)
					return (1)
				}
			}
		}
		Increment(Local5)
		Decrement(Local3)
	}
	return (0)
}

Method(ST00,, Serialized)
{
	Name(ts, "ST00")

	Store("TEST: ST00, Store object", Debug)

	// Store

	Store(Store(0xabcdef12, Local0), Local1)
	if (LNotEqual(Local1, 0xabcdef12)) {
		err(ts, z042, 10, 0, 0, 0, 0)
	}

	// Integer arithmetic

	// Add

	Store(Add(0x12345678, 0x11111111, Local0), Local1)
	if (LNotEqual(Local1, 0x23456789)) {
		err(ts, z042, 11, 0, 0, 0, 0)
	}
	Store(Add(0x23456781, 0x11111111), Local0)
	if (LNotEqual(Local0, 0x34567892)) {
		err(ts, z042, 12, 0, 0, 0, 0)
	}

	Store(Add(0x12345678, 0xf0000000, Local0), Local1)
	m4c0(ts, Local1, 0x0000000102345678, 0x02345678)

	// Subtract

	Store(Subtract(0x87654321, 0x11111111, Local0), Local1)
	if (LNotEqual(Local1, 0x76543210)) {
		err(ts, z042, 13, 0, 0, 0, 0)
	}
	Store(Subtract(0x72387654, 0x22221111), Local0)
	if (LNotEqual(Local0, 0x50166543)) {
		err(ts, z042, 14, 0, 0, 0, 0)
	}

	// Multiply

	Store(Multiply(0x12345, 0x7abc, Local0), Local1)
	if (LNotEqual(Local1, 0x8BA4C8AC)) {
		err(ts, z042, 15, 0, 0, 0, 0)
	}
	Store(Multiply(0x145ab, 0x3247), Local0)
	if (LNotEqual(Local0, 0x3FF5B86D)) {
		err(ts, z042, 16, 0, 0, 0, 0)
	}

	// Divide

	Store(Divide(0x12345678, 0x1000, Local0, Local1), Local2)
	if (LNotEqual(Local2, 0x12345)) {
		err(ts, z042, 17, 0, 0, 0, 0)
	}
	Store(Divide(0x7abc56e8, 0x1000, Local0), Local1)
	if (LNotEqual(Local1, 0x7ABC5)) {
		err(ts, z042, 18, 0, 0, 0, 0)
	}

	Store(Divide(0x55667788, 0x1000), Local0)
	if (LNotEqual(Local0, 0x55667)) {
		err(ts, z042, 19, 0, 0, 0, 0)
	}

	// Increment

	Store(0x12345678, Local0)
	Store(Increment(Local0), Local1)
	if (LNotEqual(Local1, 0x12345679)) {
		err(ts, z042, 20, 0, 0, 0, 0)
	}

	// Decrement

	Store(0x67812345, Local0)
	Store(Decrement(Local0), Local1)
	if (LNotEqual(Local1, 0x67812344)) {
		err(ts, z042, 21, 0, 0, 0, 0)
	}

	// And

	Store(And(0x87654321, 0xaaaaaaaa, Local0), Local1)
	if (LNotEqual(Local1, 0x82200220)) {
		err(ts, z042, 22, 0, 0, 0, 0)
	}
	Store(And(0x88aabbcc, 0xaaaaaaaa), Local0)
	if (LNotEqual(Local0, 0x88AAAA88)) {
		err(ts, z042, 23, 0, 0, 0, 0)
	}

	// FindSetLeftBit

	Store(FindSetLeftBit(0x0000f001, Local0), Local1)
	if (LNotEqual(Local1, 16)) {
		err(ts, z042, 24, 0, 0, 0, 0)
	}
	Store(FindSetLeftBit(0x09007001), Local0)
	if (LNotEqual(Local0, 28)) {
		err(ts, z042, 25, 0, 0, 0, 0)
	}

	// FindSetRightBit

	Store(FindSetRightBit(0x01080040, Local0), Local1)
	if (LNotEqual(Local1, 7)) {
		err(ts, z042, 26, 0, 0, 0, 0)
	}
	Store(FindSetRightBit(0x09800000), Local0)
	if (LNotEqual(Local0, 24)) {
		err(ts, z042, 27, 0, 0, 0, 0)
	}

	// Mod

	Store(Mod(0x1afb3c4d, 0x400000), Local0)
	if (LNotEqual(Local0, 0x3b3c4d)) {
		err(ts, z042, 28, 0, 0, 0, 0)
	}

	// ShiftLeft

	Store(ShiftLeft(0x12345678, 9, Local0), Local1)
	m4c0(ts, Local1, 0x0000002468ACF000, 0x68ACF000)

	Store(ShiftLeft(0x45678abf, 11), Local0)
	m4c0(ts, Local0, 0x0000022B3C55F800, 0x3C55F800)

	// ShiftRight

	Store(ShiftRight(0x87654321, 25, Local0), Local1)
	if (LNotEqual(Local1, 0x00000043)) {
		err(ts, z042, 29, 0, 0, 0, 0)
	}
	Store(ShiftRight(0x7654a0cb, 21), Local0)
	if (LNotEqual(Local0, 0x000003b2)) {
		err(ts, z042, 30, 0, 0, 0, 0)
	}

	// Nand

	Store(Nand(0xa33553ac, 0x9a9636ca, Local0), Local1)
	m4c0(ts, Local1, 0xFFFFFFFF7DEBED77, 0x7DEBED77)

	Store(Nand(0xa33553ac, 0x565c36c9), Local0)
	m4c0(ts, Local0, 0xFFFFFFFFFDEBED77, 0xFDEBED77)

	// Nor

	Store(Nor(0x9a335a3c, 0x39a96c6a, Local0), Local1)
	m4c0(ts, Local1, 0xFFFFFFFF44448181, 0x44448181)

	Store(Nor(0x9a353a3c, 0x39a69c6a), Local0)
	m4c0(ts, Local0, 0xFFFFFFFF44484181, 0x44484181)

	// Not

	Store(Not(0x8a345678, Local0), Local1)
	m4c0(ts, Local1, 0xFFFFFFFF75CBA987, 0x75CBA987)

	Store(Not(0x8af45678), Local0)
	m4c0(ts, Local0, 0xFFFFFFFF750BA987, 0x750BA987)

	// Or

	Store(Or(0x9a3533ac, 0x39a696ca, Local0), Local1)
	if (LNotEqual(Local1, 0xBBB7B7EE)) {
		err(ts, z042, 31, 0, 0, 0, 0)
	}
	Store(Or(0xca3533a9, 0xa9a696c3), Local0)
	if (LNotEqual(Local0, 0xEBB7B7EB)) {
		err(ts, z042, 32, 0, 0, 0, 0)
	}

	// Xor

	Store(Xor(0x9a365ac3, 0x39a96ca6, Local0), Local1)
	if (LNotEqual(Local1,  0xA39F3665)) {
		err(ts, z042, 33, 0, 0, 0, 0)
	}
	Store(Xor(0xa9365ac3, 0x93a96ca6), Local0)
	if (LNotEqual(Local0,  0x3A9F3665)) {
		err(ts, z042, 34, 0, 0, 0, 0)
	}

	// Logical operators

	// LAnd          (provided by LAN0)
	// LEqual        (provided by LEQ0)
	// LGreater      (provided by LGR0)
	// LGreaterEqual (provided by LGE0)
	// LLess         (provided by LL00)
	// LLessEqual    (provided by LLE0)
	// LNot          (provided by LN00)
	// LNotEqual     (provided by LNE0)
	// LOr           (provided by LOR0)

	// Synchronization

	// Acquire

	Store(Acquire(MT04, 0x0005), Local0)
	if (LNotEqual(Local0, Zero)) {
		err(ts, z042, 35, 0, 0, 0, 0)
	}

	// Release (None)

	// ToInteger

	Store(ToInteger("0x89abcdef", Local0), Local1)
	if (LNotEqual(Local1, 0x89abcdef)) {
		err(ts, z042, 36, 0, 0, 0, 0)
	}
	Store(ToInteger("0x89abcdef"), Local0)
	if (LNotEqual(Local0, 0x89abcdef)) {
		err(ts, z042, 37, 0, 0, 0, 0)
	}

	// ToString

	Store(Buffer(1){0x01}, Local2)

	Store(ToString(Local2, Ones, Local0), Local1)
	if (LNotEqual(Local1, "\x01")) {
		err(ts, z042, 38, 0, 0, 0, 0)
	}
	Store(ToString(Local2, Ones), Local0)
	if (LNotEqual(Local0,  "\x01")) {
		err(ts, z042, 39, 0, 0, 0, 0)
	}

	Store(ToString(Local2, 1, Local0), Local1)
	if (LNotEqual(Local1, "\x01")) {
		err(ts, z042, 40, 0, 0, 0, 0)
	}
	Store(ToString(Local2, 1), Local0)
	if (LNotEqual(Local0,  "\x01")) {
		err(ts, z042, 41, 0, 0, 0, 0)
	}

	// ToBuffer

	Store("\x01", Local2)

	Store(ToBuffer(Local2, Local0), Local1)
	if (LNotEqual(Local1, Buffer(2){0x01, 0x00})) {
		err(ts, z042, 42, 0, 0, 0, 0)
	}
	Store(ToBuffer(Local2), Local0)
	if (LNotEqual(Local0, Buffer(2){0x01, 0x00})) {
		err(ts, z042, 43, 0, 0, 0, 0)
	}

	// ToDecimalString

	Store(12, Local2)

	Store(ToDecimalString(Local2, Local0), Local1)
	if (LNotEqual(Local1, "12")) {
		err(ts, z042, 44, 0, 0, 0, 0)
	}
	Store(ToDecimalString(Local2), Local0)
	if (LNotEqual(Local0, "12")) {
		err(ts, z042, 45, 0, 0, 0, 0)
	}

	// ToHexString

	Store(Buffer(1){0xef}, Local2)

	Store(ToHexString(Local2, Local0), Local1)
	if (LNotEqual(Local1, "EF")) {
		err(ts, z042, 46, 0, 0, 0, 0)
	}
	Store(ToHexString(Local2), Local0)
	if (LNotEqual(Local0, "EF")) {
		err(ts, z042, 47, 0, 0, 0, 0)
	}

	// ToBCD

	Store(10, Local2)

	Store(ToBCD(Local2, Local0), Local1)
	if (LNotEqual(Local1, 0x10)) {
		err(ts, z042, 48, 0, 0, 0, 0)
	}
	Store(ToBCD(Local2), Local0)
	if (LNotEqual(Local0, 0x10)) {
		err(ts, z042, 49, 0, 0, 0, 0)
	}

	// FromBCD

	Store(0x10, Local2)

	Store(FromBCD(Local2, Local0), Local1)
	if (LNotEqual(Local1, 10)) {
		err(ts, z042, 50, 0, 0, 0, 0)
	}
	Store(FromBCD(Local2), Local0)
	if (LNotEqual(Local0, 10)) {
		err(ts, z042, 51, 0, 0, 0, 0)
	}

	// Mid

	Store("0123", Local2)

	Store(Mid(Local2, 1, 2, Local0), Local1)
	if (LNotEqual(Local1, "12")) {
		err(ts, z042, 52, 0, 0, 0, 0)
	}
	Store(Mid(Local2, 1, 2), Local0)
	if (LNotEqual(Local0, "12")) {
		err(ts, z042, 53, 0, 0, 0, 0)
	}

	Store(Buffer(){0, 1, 2, 3}, Local2)

	Store(Mid(Local2, 1, 2, Local0), Local1)
	if (LNotEqual(Local1, Buffer(){1, 2})) {
		err(ts, z042, 54, 0, 0, 0, 0)
	}
	Store(Mid(Local2, 1, 2), Local0)
	if (LNotEqual(Local0, Buffer(){1, 2})) {
		err(ts, z042, 55, 0, 0, 0, 0)
	}

	// Match

	Store(Package(){1}, Local2)

	Store(Match(Local2, MTR, 0, MTR, 0, 0), Local0)
	if (LNotEqual(Local0, 0)) {
		err(ts, z042, 56, 0, 0, 0, 0)
	}

	// ConcatenateResTemplate

	Store(ResourceTemplate(){}, Local2)
	Store(ResourceTemplate(){}, Local3)

	Store(ConcatenateResTemplate(Local2, Local3, Local0), Local1)
	/*
	 * 20.12.2005: 0 instead of 0x87
	 */
	if (LNotEqual(Local1, Buffer(){0x79, 0})) {
		err(ts, z042, 57, 0, 0, 0, 0)
	}
	/*
	 * 20.12.2005: 0 instead of 0x87
	 */
	Store(ConcatenateResTemplate(Local2, Local3), Local0)
	if (LNotEqual(Local0, Buffer(){0x79, 0})) {
		err(ts, z042, 58, 0, 0, 0, 0)
	}
}

Method(m30d,, Serialized)
{
	Name(str0, "mnbvcxzlkjhgf")
	Name(str1, "mnbvcxzlkjAgf")

	Store("A", Index(str0, 10))

	if (LNotEqual(str0, str1)) {
		err("m30d", z042, 59, 0, 0, str0, str1)
	}
}

// Run-method
Method(DCM0)
{
	ST00()
	m30d()
}
