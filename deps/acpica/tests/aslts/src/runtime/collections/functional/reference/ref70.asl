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
 * References
 *
 * Verify exceptions for different operators dealing with references
 */

/*
SEE: FILE BUG: hangs without printing error
SEE: FILE BUG: CondRefOf doesnt cause exception but only under some conditions
*/

Name(z081, 81)

// Run operator and expect ANY exception(s)
Method(m1a7, 7, Serialized)
{
	Name(ts, "m1a7")

	Store(1, FLG3)
	Store(1, FLG4)

	// flag, run test till the first error
	if (c086) {
		// Get current indicator of errors
		if (GET2()) {
			return
		}
	}

	CH03(ts, z081, 0x200, arg6, arg6)
/*
	// FILE BUG: hangs without printing error
	Store(CH03(ts, z081, 0x200, arg6, arg6), Local0)
	if (Local0) {
		Concatenate("Operation: 0x", arg6, Local0)
		Store(Local0, Debug)
	}
*/

	Switch (ToInteger (Arg6)) {
		Case (7) {
			Store(Acquire(arg0, 100), Local7)
		}
		Default {
			m480(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
		}
	}

	CH04(c080, 0, 0xff, z081, 0x201, arg6, arg6)

/*
	// FILE BUG: hangs without printing error
	Store(CH04(c080, 0, 0xff, z081, 0x201, arg6, arg6), Local0)
	if (Local0) {
		Concatenate("Operation: 0x", arg6, Local0)
		Store(Local0, Debug)
	}
*/

	Store(0, FLG3)
	Store(0, FLG4)
}

/*
 * Switch
 *
 * This sub-test causes break of exc_ref due to the bug 248
 * (lose path after exception or hang).
 * So, it is blocked, and in order to show 'Test is blocked'
 * it is run also additionally separately.
 */
Method(m167, 1, Serialized)
{
	CH03("m167", z081, 0x206, 56, 56)
	Switch (ToInteger (arg0)) {
		Case (0) {
			Store(0, Local7)
		}
		Default {
			Store(1, Local7)
		}
	}
	CH04(c080, 0, 0xff, z081, 0x207, 56, 56)
}

// Check reaction on OPERAND-REFERENCE (exceptions are expected in most cases)
// arg0 - reference to the value of arbitrary type
// arg1 - absolute index of file initiating the checking
// arg2 - index of checking (inside the file)
Method(m1a8, 3, Serialized)
{
	Name(ts, "m1a8")

	// Return
	Method(m000, 1)
	{
		return (arg0)
	}

	// If
	Method(m001, 1)
	{
		CH03(ts, z081, 0x202, 54, 54)
		if (arg0) {
			Store(0, Local7)
		}
		CH04(c080, 0, 0xff, z081, 0x203, 54, 54)
	}

	// ElseIf
	Method(m002, 1)
	{
		CH03(ts, z081, 0x204, 55, 55)
		if (0) {
			Store(0, Local7)
		} elseif (arg0) {
			Store(1, Local7)
		}
		CH04(c080, 0, 0xff, z081, 0x205, 55, 55)
	}

	// While
	Method(m004, 1)
	{
		CH03(ts, z081, 0x208, 58, 58)
		While (arg0) {
			Store(0, Local7)
			Break
		}
		CH04(c080, 0, 0xff, z081, 0x209, 58, 58)
	}

	// Set parameters of current checking
	if (arg1) {
		SET0(arg1, 0, arg2)
	}

	// flag, run test till the first error
	if (c086) {
		// Get current indicator of errors
		if (GET2()) {
			return
		}
	}

	// Split into groups for debugging: some of them
	// were crashing the system.

	Name(rn00, 1) // CondRefOf
	Name(rn01, 0) // DerefOf
	if (y506) {
		// Crash
		Store(1, rn01)
	}
	Name(rn02, 1) // ObjectType
	Name(rn03, 1) // RefOf
	Name(rn04, 1) // SizeOf
	Name(rn05, 1) // CopyObject
	Name(rn06, 1) // Return
	Name(rn07, 1) // If,ElseIf,Switch,While
	Name(rn08, 1) // All other operators

	Name(b000, Buffer(10) {})
	Name(s000, "qwertyuiopasdfghjklz")
	Name(p000, Package() {1,2,3,4,5,6,7,8,9})

	Store(1, FLG4)

	if (rn00) {
		// CondRefOf

		CH03(ts, z081, 0x20a, 0, 0)
		m480(arg0, 0, 0, 0, 0, 0, 5)
		CH03(ts, z081, 0x20b, 0, 0)
	}

	if (rn01) {
		// DerefOf

		CH03(ts, z081, 0x20c, 0, 0)
		m480(arg0, 0, 0, 0, 0, 0, 8)
		CH03(ts, z081, 0x20d, 0, 0)
	}

	if (rn02) {
		// ObjectType

		CH03(ts, z081, 0x20e, 0, 0)
		m480(arg0, 0, 0, 0, 0, 0, 32)
		CH03(ts, z081, 0x20f, 0, 0)
	}

	if (rn03) {
		// RefOf

		CH03(ts, z081, 0x210, 0, 0)
		m480(arg0, 0, 0, 0, 0, 0, 34)
		CH03(ts, z081, 0x211, 0, 0)
	}

	if (rn04) {

		// SizeOf

		Store(0, Local0)
		Store(ObjectType(arg0), Local1)

		Switch (ToInteger (Local1)) {
			Case (1) {	// Integer
				Store(1, Local0)
			}
			Case (2) {	// String
				Store(1, Local0)
			}
			Case (3) {	// Buffer
				Store(1, Local0)
			}
			Case (4) {	// Package
				Store(1, Local0)
			}
		}

		if (y505) {

			// Buffer Field and Field Unit types should allow SizeOf()

			Switch (ToInteger (Local1)) {
				Case (5) {	// Field Unit
					Store(1, Local0)
				}
				Case (14) {	// Buffer Field
					Store(1, Local0)
				}
			}
		}

		if (Local0) {
			CH03(ts, z081, 0x212, 0, 0)
			m480(arg0, 0, 0, 0, 0, 0, 41)
			CH03(ts, z081, 0x213, 0, 0)
		} else {
			m1a7(arg0, 0, 0, 0, 0, 0, 41)
		}

	} /* if(rn04) */

	if (rn05) {

		// CopyObject

		CH03(ts, z081, 0x214, 0, 0)
		CopyObject(arg0, Local7)
		CH03(ts, z081, 0x215, 0, 0)
	}

	if (rn06) {

		// Return

		CH03(ts, z081, 0x216, 0, 0)
		m000(arg0)
		CH03(ts, z081, 0x217, 0, 0)
	}

	if (rn07) {

		// If

		m001(arg0)

		// ElseIf

		m002(arg0)

		// Switch

		if (y248) {
			m167(arg0)
		} else {
			Store("WARNING: test m1a8:m1a8 blocked due to the bug 248!", Debug)
		}

		// While

		m004(arg0)

	} /* if(rn07) */

	if (rn08) {

	// Acquire

	m1a7(arg0, 0, 0, 0, 0, 0, 0)

	// Add

	m1a7(arg0, 0, 0, 0, 0, 0, 1)
	m1a7(0, arg0, 0, 0, 0, 0, 1)

	// And

	m1a7(arg0, 0, 0, 0, 0, 0, 2)
	m1a7(0, arg0, 0, 0, 0, 0, 2)

	// Concatenate

	m1a7(arg0, 0, 0, 0, 0, 0, 3)
	m1a7(0, arg0, 0, 0, 0, 0, 3)

	// ConcatenateResTemplate

	m1a7(arg0, 0, 0, 0, 0, 0, 4)
	m1a7(0, arg0, 0, 0, 0, 0, 4)

	// Decrement

	m1a7(arg0, 0, 0, 0, 0, 0, 7)

	// Divide

	m1a7(arg0, 1, 0, 0, 0, 0, 9)
	m1a7(1, arg0, 0, 0, 0, 0, 9)

	// Fatal

	// FindSetLeftBit

	m1a7(arg0, 0, 0, 0, 0, 0, 11)

	// FindSetRightBit

	m1a7(arg0, 0, 0, 0, 0, 0, 12)

	// FromBCD

	m1a7(arg0, 0, 0, 0, 0, 0, 13)

	// Increment

	m1a7(arg0, 0, 0, 0, 0, 0, 14)

	// Index

	m1a7(arg0, 0, 0, 0, 0, 0, 15)
	m1a7(b000, arg0, 0, 0, 0, 0, 15)

	// LAnd

	m1a7(arg0, 0, 0, 0, 0, 0, 16)
	m1a7(0, arg0, 0, 0, 0, 0, 16)

	// LEqual

	m1a7(arg0, 0, 0, 0, 0, 0, 17)
	m1a7(0, arg0, 0, 0, 0, 0, 17)

	// LGreater

	m1a7(arg0, 0, 0, 0, 0, 0, 18)
	m1a7(0, arg0, 0, 0, 0, 0, 18)

	// LGreaterEqual

	m1a7(arg0, 0, 0, 0, 0, 0, 19)
	m1a7(0, arg0, 0, 0, 0, 0, 19)

	// LLess

	m1a7(arg0, 0, 0, 0, 0, 0, 20)
	m1a7(0, arg0, 0, 0, 0, 0, 20)

	// LLessEqual

	m1a7(arg0, 0, 0, 0, 0, 0, 21)
	m1a7(0, arg0, 0, 0, 0, 0, 21)

	// LNot

	m1a7(arg0, 0, 0, 0, 0, 0, 22)

	// LNotEqual

	m1a7(arg0, 0, 0, 0, 0, 0, 23)
	m1a7(0, arg0, 0, 0, 0, 0, 23)

	// LOr

	m1a7(arg0, 0, 0, 0, 0, 0, 24)
	m1a7(0, arg0, 0, 0, 0, 0, 24)

	// Match

	m1a7(arg0, 0,    1,    1,    1, 0, 25)
	m1a7(p000, 0, arg0,    1,    1, 0, 25)
	m1a7(p000, 0,    1, arg0,    1, 0, 25)
	m1a7(p000, 0,    1,    1, arg0, 0, 25)

	// Mid

	m1a7(arg0,    0,    5, 0, 0, 0, 26)
	m1a7(s000, arg0,    5, 0, 0, 0, 26)
	m1a7(s000,    0, arg0, 0, 0, 0, 26)

	// Mod

	m1a7(arg0, 1, 0, 0, 0, 0, 27)
	m1a7(1, arg0, 0, 0, 0, 0, 27)

	// Multiply

	m1a7(arg0, 1, 0, 0, 0, 0, 28)
	m1a7(1, arg0, 0, 0, 0, 0, 28)

	// NAnd

	m1a7(arg0, 1, 0, 0, 0, 0, 29)
	m1a7(1, arg0, 0, 0, 0, 0, 29)

	// NOr

	m1a7(arg0, 1, 0, 0, 0, 0, 30)
	m1a7(1, arg0, 0, 0, 0, 0, 30)

	// Not

	m1a7(arg0, 1, 0, 0, 0, 0, 31)

	// Or

	m1a7(arg0, 1, 0, 0, 0, 0, 33)
	m1a7(1, arg0, 0, 0, 0, 0, 33)

	// Release

	m1a7(arg0, 0, 0, 0, 0, 0, 35)

	// Reset

	m1a7(arg0, 0, 0, 0, 0, 0, 36)

	// ShiftLeft

	m1a7(arg0, 1, 0, 0, 0, 0, 38)
	m1a7(1, arg0, 0, 0, 0, 0, 38)

	// ShiftRight

	m1a7(arg0, 1, 0, 0, 0, 0, 39)
	m1a7(1, arg0, 0, 0, 0, 0, 39)

	// Signal

	m1a7(arg0, 0, 0, 0, 0, 0, 40)

	// Sleep

	m1a7(arg0, 0, 0, 0, 0, 0, 42)

	// Stall

	m1a7(arg0, 0, 0, 0, 0, 0, 43)

	// Store

	CH03(ts, z081, 0x218, 0, 0)
	Store(arg0, Local7)
	CH03(ts, z081, 0x219, 0, 0)

	// Subtract

	m1a7(arg0, 1, 0, 0, 0, 0, 45)
	m1a7(1, arg0, 0, 0, 0, 0, 45)

	// ToBCD

	m1a7(arg0, 0, 0, 0, 0, 0, 46)

	// ToBuffer

	m1a7(arg0, 0, 0, 0, 0, 0, 47)

	// ToDecimalString

	m1a7(arg0, 0, 0, 0, 0, 0, 48)

	// ToHexString

	m1a7(arg0, 0, 0, 0, 0, 0, 49)

	// ToInteger

	m1a7(arg0, 0, 0, 0, 0, 0, 50)

	// ToString

	m1a7(arg0,    1, 0, 0, 0, 0, 51)
	m1a7(b000, arg0, 0, 0, 0, 0, 51)

	// Wait

	m1a7(arg0,    1, 0, 0, 0, 0, 52)
	m1a7(b000, arg0, 0, 0, 0, 0, 52)

	// XOr

	m1a7(arg0,    1, 0, 0, 0, 0, 53)
	m1a7(b000, arg0, 0, 0, 0, 0, 53)

	} // if(rn08)

	Store(0, FLG4)

	RST0()

	return
}

// Simple test, only some particular ways of obtaining references
Method(m1a9,, Serialized)
{
	// FILE BUG: CondRefOf doesnt cause exception but only under some conditions,
	// namely for rn00 == 2.

	Name(rn00, 2) // Simplest modes, for debugging
	Name(rn01, 1) // Crash

	if (LEqual(rn00, 0)) {

		// Simplest mode, ONE-TWO operations of those below

		Store(RefOf(i900), Local0)
		m1a8(Local0, z081, 15)

		Store(CondRefOf(i900, Local0), Local1)
		if (m1a4(Local1, 34)) {
			m1a8(Local0, z081, 35)
		}

	} elseif (LEqual(rn00, 1)) {


		// Simplest mode, SOME of operations below

		Store(Index(s900, 0), Local0)
		m1a8(Local0, z081, 0)

		Store(Index(b900, 3), Local0)
		m1a8(Local0, z081, 1)

		Store(Index(p901, 0), Local0)
		m1a8(Local0, z081, 2)

		Store(Index(p91e, 0), Local0)
		m1a8(Local0, z081, 4)

		Store(Index(p901, 0, Local1), Local0)
		m1a8(Local1, z081, 10)

		Store(Index(p91e, 0, Local1), Local0)
		m1a8(Local1, z081, 14)

		Store(RefOf(i900), Local0)
		m1a8(Local0, z081, 15)

		Store(RefOf(f900), Local0)
		m1a8(Local0, z081, 18)

		Store(RefOf(bn90), Local0)
		m1a8(Local0, z081, 19)

		Store(RefOf(if90), Local0)
		m1a8(Local0, z081, 20)

		Store(RefOf(bf90), Local0)
		m1a8(Local0, z081, 21)

		Store(CondRefOf(i900, Local0), Local1)
		if (m1a4(Local1, 34)) {
			m1a8(Local0, z081, 35)
		}

	} else {

		// Index

		Store(Index(s900, 0), Local0)
		m1a8(Local0, z081, 0)

		Store(Index(b900, 3), Local0)
		m1a8(Local0, z081, 1)

		Store(Index(p901, 0), Local0)
		m1a8(Local0, z081, 2)

		if (rn01) {
			Store(Index(p916, 0), Local0)
			m1a8(Local0, z081, 3)
		}

		Store(Index(p91e, 0), Local0)
		m1a8(Local0, z081, 4)

		Store(Index(s900, 0, Local1), Local0)
		m1a8(Local0, z081, 5)
		m1a8(Local1, z081, 6)

		Store(Index(b900, 3, Local1), Local0)
		m1a8(Local0, z081, 7)
		m1a8(Local1, z081, 8)

		Store(Index(p901, 0, Local1), Local0)
		m1a8(Local0, z081, 9)
		m1a8(Local1, z081, 10)

		if (rn01) {
			Store(Index(p916, 0, Local1), Local0)
			m1a8(Local0, z081, 11)
			m1a8(Local1, z081, 12)
		}

		Store(Index(p91e, 0, Local1), Local0)
		m1a8(Local0, z081, 13)
		m1a8(Local1, z081, 14)

		// RefOf

		Store(RefOf(i900), Local0)
		m1a8(Local0, z081, 15)

		Store(RefOf(s900), Local0)
		m1a8(Local0, z081, 16)

		Store(RefOf(b900), Local0)
		m1a8(Local0, z081, 17)

		Store(RefOf(f900), Local0)
		m1a8(Local0, z081, 18)

		Store(RefOf(bn90), Local0)
		m1a8(Local0, z081, 19)

		Store(RefOf(if90), Local0)
		m1a8(Local0, z081, 20)

		Store(RefOf(bf90), Local0)
		m1a8(Local0, z081, 21)

		Store(RefOf(e900), Local0)
		m1a8(Local0, z081, 22)

		Store(RefOf(mx90), Local0)
		m1a8(Local0, z081, 23)

		Store(RefOf(d900), Local0)
		m1a8(Local0, z081, 24)

		Store(RefOf(tz90), Local0)
		m1a8(Local0, z081, 25)

		Store(RefOf(pr90), Local0)
		m1a8(Local0, z081, 26)

		Store(RefOf(r900), Local0)
		m1a8(Local0, z081, 27)

		Store(RefOf(pw90), Local0)
		m1a8(Local0, z081, 28)

		Store(RefOf(p900), Local0)
		m1a8(Local0, z081, 29)

		Store(RefOf(p901), Local0)
		m1a8(Local0, z081, 30)

		Store(RefOf(p916), Local0)
		m1a8(Local0, z081, 31)

		Store(RefOf(p91d), Local0)
		m1a8(Local0, z081, 32)

		Store(RefOf(p91e), Local0)
		m1a8(Local0, z081, 33)

		// CondRefOf

		Store(CondRefOf(i900, Local0), Local1)
		if (m1a4(Local1, 34)) {
			m1a8(Local0, z081, 35)
		}

		Store(CondRefOf(s900, Local0), Local1)
		if (m1a4(Local1, 36)) {
			m1a8(Local0, z081, 37)
		}

		Store(CondRefOf(b900, Local0), Local1)
		if (m1a4(Local1, 38)) {
			m1a8(Local0, z081, 39)
		}

		Store(CondRefOf(f900, Local0), Local1)
		if (m1a4(Local1, 40)) {
			m1a8(Local0, z081, 41)
		}

		Store(CondRefOf(bn90, Local0), Local1)
		if (m1a4(Local1, 42)) {
			m1a8(Local0, z081, 43)
		}

		Store(CondRefOf(if90, Local0), Local1)
		if (m1a4(Local1, 44)) {
			m1a8(Local0, z081, 45)
		}

		Store(CondRefOf(bf90, Local0), Local1)
		if (m1a4(Local1, 46)) {
			m1a8(Local0, z081, 47)
		}

		Store(CondRefOf(e900, Local0), Local1)
		if (m1a4(Local1, 48)) {
			m1a8(Local0, z081, 49)
		}

		Store(CondRefOf(mx90, Local0), Local1)
		if (m1a4(Local1, 50)) {
			m1a8(Local0, z081, 51)
		}

		Store(CondRefOf(d900, Local0), Local1)
		if (m1a4(Local1, 52)) {
			m1a8(Local0, z081, 53)
		}

		Store(CondRefOf(tz90, Local0), Local1)
		if (m1a4(Local1, 54)) {
			m1a8(Local0, z081, 55)
		}

		Store(CondRefOf(pr90, Local0), Local1)
		if (m1a4(Local1, 56)) {
			m1a8(Local0, z081, 57)
		}

		Store(CondRefOf(r900, Local0), Local1)
		if (m1a4(Local1, 58)) {
			m1a8(Local0, z081, 59)
		}

		Store(CondRefOf(pw90, Local0), Local1)
		if (m1a4(Local1, 60)) {
			m1a8(Local0, z081, 61)
		}

		Store(CondRefOf(p900, Local0), Local1)
		if (m1a4(Local1, 62)) {
			m1a8(Local0, z081, 63)
		}

		Store(CondRefOf(p901, Local0), Local1)
		if (m1a4(Local1, 64)) {
			m1a8(Local0, z081, 65)
		}

		Store(CondRefOf(p916, Local0), Local1)
		if (m1a4(Local1, 66)) {
			m1a8(Local0, z081, 67)
		}

		Store(CondRefOf(p91d, Local0), Local1)
		if (m1a4(Local1, 68)) {
			m1a8(Local0, z081, 69)
		}

		Store(CondRefOf(p91e, Local0), Local1)
		if (m1a4(Local1, 70)) {
			m1a8(Local0, z081, 71)
		}

	} // if(rn00)
}

Method(m106,, Serialized)
{
	Name(ts, "m106")

	Name(i000, 0xabcd0000)

	Method(m000, 1)
	{
		CH03(ts, z081, 72, 0, 0)

		Store(DerefOf(RefOf(DerefOf(RefOf(arg0)))), Debug)

		CH04(c080, 0, 0xff, z081, 73, 0, 0)
	}

	m000(i000)
}


// Run-method
Method(REF5,, Serialized)
{
	Name(p91e, Package() {0xabcd0000})

	Store("TEST: REF5, References, check exceptions", Debug)

	Store("REF5", c080)	// name of test
	Store(z081, c081)		// absolute index of file initiating the checking
	Store(1, c082)		// flag of test of exceptions
	Store(0, c083)		// run verification of references (write/read)
	Store(0, c084)		// run verification of references (reading)
	Store(0, c085)		// create the chain of references to LocalX, then dereference them
	Store(0, c086)		// flag, run test till the first error
	Store(1, c087)		// apply DeRefOf to ArgX-ObjectReference
	Store(1, c089)		// flag of Reference, object otherwise

	if (0) {

		// This mode of test run takes much time, moreover,
		// due to the bug 95 of ACPICA it fails to complete.
		// So, if run it then do it with the flag c086 set up
		// - run test till the first error.

		Store(1, c086) // flag, run test till the first error

		// For local data (methods of ref1.asl)

		// Reset current indicator of errors
		RST2()

		Store(z077, c081) // absolute index of file initiating the checking

		SRMT("m168")
		m168()
		SRMT("m169")
		m169()
		SRMT("m16a")
		m16a(0)
		SRMT("m16b")
		m16b()
		SRMT("m16c")
		m16c(0)
		SRMT("m16d")
		m16d()
		SRMT("m16e")
		m16e()

		// For global data (methods of ref4.asl)

		Store(z080, c081) // absolute index of file initiating the checking

		SRMT("m190")
		m190()
		SRMT("m191")
		m191(0)
		SRMT("m192")
		m192()
		SRMT("m193")
		m193(0)
		SRMT("m194")
		m194()

	} else {

		// Run simple test only for some particular ways of
		// obtaining references.

		Store(0, c086) // dont break testing on error appearance

		SRMT("m1a9")
		m1a9()
	}

	// Particular tests

	SRMT("m106")
	m106()
	SRMT("m167")
	if (y248) {
		/* This code here only to not forget to run m1a8:m167 */
		Store(Index(p91e, 0, Local1), Local0)
		m167(Local0)
	} else {
		BLCK()
	}
}


