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
 *  Method
 *
 * (verify exceptions caused by the imprope use of Method type objects)
 */

Name(z100, 100)

Method(m4f0) {Return ("m4f0")}

// Expected exceptions:
//
// 47 - AE_AML_OPERAND_TYPE
//
Method(m4b8,, Serialized)
{
	Name(ts, "m4b8")

	Method(m4f1) {Return ("m4f1")}

	Event(e000)

	Name(i000, 0)

	// Local Named Object
	Method(m000, 1)
	{
		Method(m4f2) {Return ("m4f2")}

		if (y083) {
			Store (DerefOf(m4f2), Local1)
			CH06(arg0, 0, 47)
		}
	}

	// Global Named Object
	Method(m001, 1)
	{
		if (y083) {
			Store (DerefOf(m4f0), Local1)
			CH06(arg0, 1, 47)
		}
	}

	// Local
	Method(m002, 1, Serialized)
	{
		Method(m4f2) {Return ("m4f2")}

		Event(e000)

		CopyObject(Derefof(Refof(m4f2)), Local0)

		// CondRefOf
		
		CondRefOf(Local0, Local1)
		CH03(ts, z100, 1, 0, 0)

		// CopyObject

		CopyObject(Local0, Local1)
		CH03(ts, z100, 2, 0, 0)

		// Decrement

		Decrement(Local0)
		CH06(arg0, 1, 47)

		// DerefOf

		Store (DerefOf(Local0), Local1)
		CH06(arg0, 2, 47)

		// FindSetLeftBit

		FindSetLeftBit(Local0, Local1)
		CH06(arg0, 4, 47)

		// FindSetRightBit

		FindSetRightBit(Local0, Local1)
		CH06(arg0, 6, 47)

		// FromBCD

		FromBCD(Local0, Local1)
		CH06(arg0, 8, 47)

		// Increment

		Increment(Local0)
		CH06(arg0, 9, 47)

		// LNot

		Store (LNot(Local0), Local1)
		CH06(arg0, 10, 47)

		// Not

		Not(Local0, Local1)
		CH06(arg0, 12, 47)

		// ObjectType

		Store (ObjectType(Local0), Local1)
		CH03(ts, z100, 3, 0, 0)

		// RefOf

		Store (RefOf(Local0), Local1)
		CH03(ts, z100, 4, 0, 0)

		// Release

		Release(Local0)
		CH06(arg0, 13, 47)

		// Reset

		Reset(Local0)
		CH06(arg0, 14, 47)

		// Signal

		Signal(Local0)
		CH06(arg0, 15, 47)

		// SizeOf

		Store (SizeOf(Local0), Local1)
		CH06(arg0, 16, 47)

		// Sleep

		Sleep(Local0)
		CH06(arg0, 17, 47)

		// Stall

		Stall(Local0)
		CH06(arg0, 18, 47)

		// Store

		Store(Local0, Local1)
		CH06(arg0, 19, 47)

		// ToBCD

		ToBCD(Local0, Local1)
		CH06(arg0, 21, 47)

		// ToBuffer

		ToBuffer(Local0, Local1)
		CH06(arg0, 23, 47)

		// ToDecimalString

		ToDecimalString(Local0, Local1)
		CH06(arg0, 25, 47)

		// ToHexString

		ToHexString(Local0, Local1)
		CH06(arg0, 27, 47)

		// ToInteger

		ToInteger(Local0, Local1)
		CH06(arg0, 29, 47)

		// Acquire

		Store(Acquire(Local0, 100), Local1)
		CH06(arg0, 30, 47)

		// Add

		Add(Local0, i000, Local1)
		CH06(arg0, 33, 47)

		Add(i000, Local0, Local1)
		CH06(arg0, 34, 47)

		// And

		And(Local0, i000, Local1)
		CH06(arg0, 37, 47)

		And(i000, Local0, Local1)
		CH06(arg0, 38, 47)

		// Concatenate

		Concatenate(Local0, i000, Local1)
		CH06(arg0, 41, 47)

		Concatenate(i000, Local0, Local1)
		CH06(arg0, 42, 47)

		// ConcatenateResTemplate

		ConcatenateResTemplate(Local0, ResourceTemplate(){}, Local1)
		CH06(arg0, 45, 47)

		ConcatenateResTemplate(ResourceTemplate(){}, Local0, Local1)
		CH06(arg0, 46, 47)

		// Divide

		Divide(Local0, i000, Local2)
		CH06(arg0, 49, 47)

		Divide(i000, Local0, Local2)
		CH06(arg0, 50, 47)

		Divide(Local0, i000, Local2, Local1)
		CH06(arg0, 51, 47)

		Divide(i000, Local0, Local2, Local1)
		CH06(arg0, 52, 47)

		// Fatal

		Fatal(0xff, 0xffffffff, Local0)
		CH06(arg0, 53, 47)

		// Index

		Index(Local0, 0, Local1)
		CH06(arg0, 56, 47)

		Index("0", Local0, Local1)
		CH06(arg0, 57, 47)

		// LEqual

		Store (LEqual(Local0, i000), Local1)
		CH06(arg0, 58, 47)

		Store (LEqual(i000, Local0), Local1)
		CH06(arg0, 59, 47)

		// LGreater

		Store (LGreater(Local0, i000), Local1)
		CH06(arg0, 60, 47)

		Store (LGreater(i000, Local0), Local1)
		CH06(arg0, 61, 47)

		// LGreaterEqual

		Store (LGreaterEqual(Local0, i000), Local1)
		CH06(arg0, 62, 0xff)

		Store (LGreaterEqual(i000, Local0), Local1)
		CH06(arg0, 63, 0xff)

		// LLess

		Store (LLess(Local0, i000), Local1)
		CH06(arg0, 64, 47)

		Store (LLess(i000, Local0), Local1)
		CH06(arg0, 65, 47)

		// LLessEqual

		Store (LLessEqual(Local0, i000), Local1)
		CH06(arg0, 66, 0xff)

		Store (LLessEqual(i000, Local0), Local1)
		CH06(arg0, 67, 0xff)

		// LNotEqual

		Store (LNotEqual(Local0, i000), Local1)
		CH06(arg0, 68, 0xff)

		Store (LNotEqual(i000, Local0), Local1)
		CH06(arg0, 69, 0xff)

		// LOr

		Store (LOr(Local0, i000), Local1)
		CH06(arg0, 70, 47)

		Store (LOr(i000, Local0), Local1)
		CH06(arg0, 71, 47)

		// Mod

		Mod(Local0, i000, Local1)
		CH06(arg0, 74, 47)

		Mod(i000, Local0, Local1)
		CH06(arg0, 75, 47)

		// Multiply

		Multiply(Local0, i000, Local1)
		CH06(arg0, 78, 47)

		Multiply(i000, Local0, Local1)
		CH06(arg0, 79, 47)

		// NAnd

		NAnd(Local0, i000, Local1)
		CH06(arg0, 82, 47)

		NAnd(i000, Local0, Local1)
		CH06(arg0, 83, 47)

		// NOr

		NOr(Local0, i000, Local1)
		CH06(arg0, 86, 47)

		NOr(i000, Local0, Local1)
		CH06(arg0, 87, 47)

		// Or

		Or(Local0, i000, Local1)
		CH06(arg0, 90, 47)

		Or(i000, Local0, Local1)
		CH06(arg0, 91, 47)

		// ShiftLeft

		ShiftLeft(Local0, i000, Local1)
		CH06(arg0, 94, 47)

		ShiftLeft(i000, Local0, Local1)
		CH06(arg0, 95, 47)

		// ShiftRight

		ShiftRight(Local0, i000, Local1)
		CH06(arg0, 98, 47)

		ShiftRight(i000, Local0, Local1)
		CH06(arg0, 99, 47)

		// Subtract

		Subtract(Local0, i000, Local1)
		CH06(arg0, 102, 47)

		Subtract(i000, Local0, Local1)
		CH06(arg0, 103, 47)

		// ToString

		ToString(Local0, 1, Local1)
		CH06(arg0, 106, 47)

		ToString(i000, Local0, Local1)
		CH06(arg0, 107, 47)

		// Wait

		Store(Wait(Local0, i000), Local1)
		CH06(arg0, 108, 47)

		Store(Wait(e000, Local0), Local1)
		CH06(arg0, 109, 47)

		// XOr

		XOr(Local0, i000, Local1)
		CH06(arg0, 112, 47)

		XOr(i000, Local0, Local1)
		CH06(arg0, 113, 47)

		// Mid

		Mid(Local0, 1, 1, Local1)
		CH06(arg0, 117, 47)

		Mid("123", Local0, 1, Local1)
		CH06(arg0, 118, 47)

		Mid("123", 1, Local0, Local1)
		CH06(arg0, 119, 47)

		// Match

		Store (Match(Local0, MTR, 0, MTR, 0, 0), Local1)
		CH06(arg0, 120, 47)

		Store (Match(Package(){1}, MTR, Local0, MTR, 0, 0), Local1)
		CH06(arg0, 121, 47)

		Store (Match(Package(){1}, MTR, 0, MTR, Local0, 0), Local1)
		CH06(arg0, 122, 47)

		Store (Match(Package(){1}, MTR, 0, MTR, 0, Local0), Local1)
		CH06(arg0, 123, 47)
	}

	// Reference to Object
	Method(m003, 2)
	{
		Store(ObjectType(arg1), Local0)
		if (LNotEqual(Local0, 8)) {
			err(arg0, z100, 200, 0, 0, Local0, 8)
			return (1)
		}

		Store (DeRefOf(arg1), Local1)
		if(LNot(SLCK)){
			CH04(ts, 0, 47, z100, 5, 0, 0)
		}

		// CondRefOf
		
		CondRefOf(DeRefOf(arg1), Local1)
		CH06(arg0, 1, 47)

		// CopyObject

		CopyObject(DeRefOf(arg1), Local1)
		CH03(ts, z100, 2, 0, 0)

		// Decrement

		Decrement(DeRefOf(arg1))
		CH06(arg0, 3, 47)

		// DerefOf

		Store (DerefOf(DeRefOf(arg1)), Local1)
		CH06(arg0, 4, 47)

		// FindSetLeftBit

		FindSetLeftBit(DeRefOf(arg1), Local1)
		CH06(arg0, 6, 47)

		// FindSetRightBit

		FindSetRightBit(DeRefOf(arg1), Local1)
		CH06(arg0, 8, 47)

		// FromBCD

		FromBCD(DeRefOf(arg1), Local1)
		CH06(arg0, 10, 47)

		// Increment

		Increment(DeRefOf(arg1))
		CH06(arg0, 11, 47)

		// LNot

		Store (LNot(DeRefOf(arg1)), Local1)
		CH06(arg0, 12, 47)

		// Not

		Not(DeRefOf(arg1), Local1)
		CH06(arg0, 14, 47)

		// ObjectType

		Store (ObjectType(DeRefOf(arg1)), Local1)
		CH03(ts, z100, 6, 0, 0)

		// RefOf

		Store (RefOf(DeRefOf(arg1)), Local1)
		CH06(arg0, 15, 47)

		// Release

		// Reset

		// Signal

		// SizeOf

		Store (SizeOf(DeRefOf(arg1)), Local1)
		CH06(arg0, 16, 47)

		// Sleep

		Sleep(DeRefOf(arg1))
		CH06(arg0, 17, 47)

		// Stall

		Stall(DeRefOf(arg1))
		CH06(arg0, 18, 47)

		// Store

		Store(DeRefOf(arg1), Local1)
		CH06(arg0, 19, 47)

		// ToBCD

		ToBCD(DeRefOf(arg1), Local1)
		CH06(arg0, 21, 47)

		// ToBuffer

		ToBuffer(DeRefOf(arg1), Local1)
		CH06(arg0, 23, 47)

		// ToDecimalString

		ToDecimalString(DeRefOf(arg1), Local1)
		CH06(arg0, 25, 47)

		// ToHexString

		ToHexString(DeRefOf(arg1), Local1)
		CH06(arg0, 27, 47)

		// ToInteger

		ToInteger(DeRefOf(arg1), Local1)
		CH06(arg0, 29, 47)

		// Acquire

		// Add

		Add(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 33, 47)

		Add(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 34, 47)

		// And

		And(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 37, 47)

		And(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 38, 47)

		// Concatenate

		Concatenate(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 41, 47)

		Concatenate(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 42, 47)

		// ConcatenateResTemplate

		ConcatenateResTemplate(DeRefOf(arg1), ResourceTemplate(){}, Local1)
		CH06(arg0, 45, 47)

		ConcatenateResTemplate(ResourceTemplate(){}, DeRefOf(arg1), Local1)
		CH06(arg0, 46, 47)

		// Divide

		Divide(DeRefOf(arg1), i000, Local2)
		CH06(arg0, 49, 47)

		Divide(i000, DeRefOf(arg1), Local2)
		CH06(arg0, 50, 47)

		Divide(DeRefOf(arg1), i000, Local2, Local1)
		CH06(arg0, 51, 47)

		Divide(i000, DeRefOf(arg1), Local2, Local1)
		CH06(arg0, 52, 47)

		// Fatal

		Fatal(0xff, 0xffffffff, DeRefOf(arg1))
		CH06(arg0, 53, 47)

		// Index

		Index(DeRefOf(arg1), 0, Local1)
		CH06(arg0, 56, 47)

		Index("0", DeRefOf(arg1), Local1)
		CH06(arg0, 57, 47)

		// LEqual

		Store (LEqual(DeRefOf(arg1), i000), Local1)
		CH06(arg0, 58, 47)

		Store (LEqual(i000, DeRefOf(arg1)), Local1)
		CH06(arg0, 59, 47)

		// LGreater

		Store (LGreater(DeRefOf(arg1), i000), Local1)
		CH06(arg0, 60, 47)

		Store (LGreater(i000, DeRefOf(arg1)), Local1)
		CH06(arg0, 61, 47)

		// LGreaterEqual

		Store (LGreaterEqual(DeRefOf(arg1), i000), Local1)
		CH06(arg0, 62, 0xff)

		Store (LGreaterEqual(i000, DeRefOf(arg1)), Local1)
		CH06(arg0, 63, 0xff)

		// LLess

		Store (LLess(DeRefOf(arg1), i000), Local1)
		CH06(arg0, 64, 47)

		Store (LLess(i000, DeRefOf(arg1)), Local1)
		CH06(arg0, 65, 47)

		// LLessEqual

		Store (LLessEqual(DeRefOf(arg1), i000), Local1)
		CH06(arg0, 66, 0xff)

		Store (LLessEqual(i000, DeRefOf(arg1)), Local1)
		CH06(arg0, 67, 0xff)

		// LNotEqual

		Store (LNotEqual(DeRefOf(arg1), i000), Local1)
		CH06(arg0, 68, 0xff)

		Store (LNotEqual(i000, DeRefOf(arg1)), Local1)
		CH06(arg0, 69, 0xff)

		// LOr

		Store (LOr(DeRefOf(arg1), i000), Local1)
		CH06(arg0, 70, 47)

		Store (LOr(i000, DeRefOf(arg1)), Local1)
		CH06(arg0, 71, 47)

		// Mod

		Mod(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 74, 47)

		Mod(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 75, 47)

		// Multiply

		Multiply(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 78, 47)

		Multiply(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 79, 47)

		// NAnd

		NAnd(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 82, 47)

		NAnd(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 83, 47)

		// NOr

		NOr(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 86, 47)

		NOr(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 87, 47)

		// Or

		Or(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 90, 47)

		Or(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 91, 47)

		// ShiftLeft

		ShiftLeft(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 94, 47)

		ShiftLeft(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 95, 47)

		// ShiftRight

		ShiftRight(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 98, 47)

		ShiftRight(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 99, 47)

		// Subtract

		Subtract(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 102, 47)

		Subtract(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 103, 47)

		// ToString

		ToString(DeRefOf(arg1), 1, Local1)
		CH06(arg0, 106, 47)

		ToString(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 107, 47)

		// Wait

		Store(Wait(e000, DeRefOf(arg1)), Local1)
		CH06(arg0, 109, 47)

		// XOr

		XOr(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 112, 47)

		XOr(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 113, 47)

		// Mid

		Mid(DeRefOf(arg1), 1, 1, Local1)
		CH06(arg0, 117, 47)

		Mid("123", DeRefOf(arg1), 1, Local1)
		CH06(arg0, 118, 47)

		Mid("123", 1, DeRefOf(arg1), Local1)
		CH06(arg0, 119, 47)

		// Match

		Store (Match(DeRefOf(arg1), MTR, 0, MTR, 0, 0), Local1)
		CH06(arg0, 120, 47)

		Store (Match(Package(){1}, MTR, DeRefOf(arg1), MTR, 0, 0), Local1)
		CH06(arg0, 121, 47)

		Store (Match(Package(){1}, MTR, 0, MTR, DeRefOf(arg1), 0), Local1)
		CH06(arg0, 122, 47)

		Store (Match(Package(){1}, MTR, 0, MTR, 0, DeRefOf(arg1)), Local1)
		CH06(arg0, 123, 47)

		return (0)
	}

	// Result of Method invocation
	Method(m004, 1, Serialized)
	{
		Name(i000, 0) // Label to check m000 invocations

		Method(m000)
		{
			CopyObject(Derefof(Refof(m4f0)), Local0)
			Return (Local0)
		}

		// CondRefOf
		
		if (y601) {
			Store (CondRefOf(m000()), Local1)
			CH06(arg0, 0, 47)

			CondRefOf(m000(), Local1)
			CH06(arg0, 1, 47)
		}

		// CopyObject

		CopyObject(m000(), Local1)
		CH03(ts, z100, 7, 0, 0)

		// Decrement

		Decrement(m000())
		CH06(arg0, 2, 47)

		// DerefOf

		Store (DerefOf(m000()), Local1)
		CH06(arg0, 3, 47)

		// FindSetLeftBit

		FindSetLeftBit(m000(), Local1)
		CH06(arg0, 5, 47)

		// FindSetRightBit

		FindSetRightBit(m000(), Local1)
		CH06(arg0, 7, 47)

		// FromBCD

		FromBCD(m000(), Local1)
		CH06(arg0, 9, 47)

		// Increment

		Increment(m000())
		CH06(arg0, 10, 47)

		// LNot

		Store (LNot(m000()), Local1)
		CH06(arg0, 11, 47)

		// Not

		Not(m000(), Local1)
		CH06(arg0, 13, 47)

		// ObjectType
        /* Nov. 2012: Method invocation as arg to ObjectType is now illegal */
//
//		ObjectType(m000())
//		CH03(ts, z100, 8, 0, 0)

		// RefOf

		if (y601) {
			Store (RefOf(m000()), Local1)
			CH06(arg0, 14, 47)
		}

		// Release

		Release(m000())
		CH06(arg0, 13, 47)

		// Reset

		Reset(m000())
		CH06(arg0, 14, 47)

		// Signal

		Signal(m000())
		CH06(arg0, 15, 47)

		// SizeOf

		Store (SizeOf(m000()), Local1)
		CH06(arg0, 16, 47)

		// Sleep

		Sleep(m000())
		CH06(arg0, 17, 47)

		// Stall

		Stall(m000())
		CH06(arg0, 18, 47)

		// Store

		Store(m000(), Local1)
		CH06(arg0, 19, 47)

		// ToBCD

		ToBCD(m000(), Local1)
		CH06(arg0, 21, 47)

		// ToBuffer

		ToBuffer(m000(), Local1)
		CH06(arg0, 23, 47)

		// ToDecimalString

		ToDecimalString(m000(), Local1)
		CH06(arg0, 25, 47)

		// ToHexString

		ToHexString(m000(), Local1)
		CH06(arg0, 27, 47)

		// ToInteger

		ToInteger(m000(), Local1)
		CH06(arg0, 29, 47)

		// Acquire

		Store(Acquire(m000(), 100), Local1)
		CH06(arg0, 30, 47)

		// Add

		Add(m000(), i000, Local1)
		CH06(arg0, 33, 47)

		Add(i000, m000(), Local1)
		CH06(arg0, 34, 47)

		// And

		And(m000(), i000, Local1)
		CH06(arg0, 37, 47)

		And(i000, m000(), Local1)
		CH06(arg0, 38, 47)

		// Concatenate

		Concatenate(m000(), i000, Local1)
		CH06(arg0, 41, 47)

		Concatenate(i000, m000(), Local1)
		CH06(arg0, 42, 47)

		// ConcatenateResTemplate

		ConcatenateResTemplate(m000(), ResourceTemplate(){}, Local1)
		CH06(arg0, 45, 47)

		ConcatenateResTemplate(ResourceTemplate(){}, m000(), Local1)
		CH06(arg0, 46, 47)

		// Divide

		Divide(m000(), i000, Local2)
		CH06(arg0, 49, 47)

		Divide(i000, m000(), Local2)
		CH06(arg0, 50, 47)

		Divide(m000(), i000, Local2, Local1)
		CH06(arg0, 51, 47)

		Divide(i000, m000(), Local2, Local1)
		CH06(arg0, 52, 47)

		// Fatal

		Fatal(0xff, 0xffffffff, m000())
		CH06(arg0, 53, 47)

		// Index

		Index(m000(), 0, Local1)
		CH06(arg0, 56, 47)

		Index("0", m000(), Local1)
		CH06(arg0, 57, 47)

		// LEqual

		Store (LEqual(m000(), i000), Local1)
		CH06(arg0, 58, 47)

		Store (LEqual(i000, m000()), Local1)
		CH06(arg0, 59, 47)

		// LGreater

		Store (LGreater(m000(), i000), Local1)
		CH06(arg0, 60, 47)

		Store (LGreater(i000, m000()), Local1)
		CH06(arg0, 61, 47)

		// LGreaterEqual

		Store (LGreaterEqual(m000(), i000), Local1)
		CH06(arg0, 62, 0xff)

		Store (LGreaterEqual(i000, m000()), Local1)
		CH06(arg0, 63, 0xff)

		// LLess

		Store (LLess(m000(), i000), Local1)
		CH06(arg0, 64, 47)

		Store (LLess(i000, m000()), Local1)
		CH06(arg0, 65, 47)

		// LLessEqual

		Store (LLessEqual(m000(), i000), Local1)
		CH06(arg0, 66, 0xff)

		Store (LLessEqual(i000, m000()), Local1)
		CH06(arg0, 67, 0xff)

		// LNotEqual

		Store (LNotEqual(m000(), i000), Local1)
		CH06(arg0, 68, 0xff)

		Store (LNotEqual(i000, m000()), Local1)
		CH06(arg0, 69, 0xff)

		// LOr

		Store (LOr(m000(), i000), Local1)
		CH06(arg0, 70, 47)

		Store (LOr(i000, m000()), Local1)
		CH06(arg0, 71, 47)

		// Mod

		Mod(m000(), i000, Local1)
		CH06(arg0, 74, 47)

		Mod(i000, m000(), Local1)
		CH06(arg0, 75, 47)

		// Multiply

		Multiply(m000(), i000, Local1)
		CH06(arg0, 78, 47)

		Multiply(i000, m000(), Local1)
		CH06(arg0, 79, 47)

		// NAnd

		NAnd(m000(), i000, Local1)
		CH06(arg0, 82, 47)

		NAnd(i000, m000(), Local1)
		CH06(arg0, 83, 47)

		// NOr

		NOr(m000(), i000, Local1)
		CH06(arg0, 86, 47)

		NOr(i000, m000(), Local1)
		CH06(arg0, 87, 47)

		// Or

		Or(m000(), i000, Local1)
		CH06(arg0, 90, 47)

		Or(i000, m000(), Local1)
		CH06(arg0, 91, 47)

		// ShiftLeft

		ShiftLeft(m000(), i000, Local1)
		CH06(arg0, 94, 47)

		ShiftLeft(i000, m000(), Local1)
		CH06(arg0, 95, 47)

		// ShiftRight

		ShiftRight(m000(), i000, Local1)
		CH06(arg0, 98, 47)

		ShiftRight(i000, m000(), Local1)
		CH06(arg0, 99, 47)

		// Subtract

		Subtract(m000(), i000, Local1)
		CH06(arg0, 102, 47)

		Subtract(i000, m000(), Local1)
		CH06(arg0, 103, 47)

		// ToString

		ToString(m000(), 1, Local1)
		CH06(arg0, 106, 47)

		ToString(i000, m000(), Local1)
		CH06(arg0, 107, 47)

		// Wait

		Store(Wait(m000(), i000), Local1)
		CH06(arg0, 108, 47)

		Store(Wait(e000, m000()), Local1)
		CH06(arg0, 109, 47)

		// XOr

		XOr(m000(), i000, Local1)
		CH06(arg0, 112, 47)

		XOr(i000, m000(), Local1)
		CH06(arg0, 113, 47)

		// Mid

		Mid(m000(), 1, 1, Local1)
		CH06(arg0, 117, 47)

		Mid("123", m000(), 1, Local1)
		CH06(arg0, 118, 47)

		Mid("123", 1, m000(), Local1)
		CH06(arg0, 119, 47)

		// Match

		Store (Match(m000(), MTR, 0, MTR, 0, 0), Local1)
		CH06(arg0, 120, 47)

		Store (Match(Package(){1}, MTR, m000(), MTR, 0, 0), Local1)
		CH06(arg0, 121, 47)

		Store (Match(Package(){1}, MTR, 0, MTR, m000(), 0), Local1)
		CH06(arg0, 122, 47)

		Store (Match(Package(){1}, MTR, 0, MTR, 0, m000()), Local1)
		CH06(arg0, 123, 47)
	}

	// Reference to Object as Result of Method invocation
	Method(m005, 1, Serialized)
	{
		Method(m4f2) {Return ("m4f2")}

		Name(i000, 0) // Label to check m000 invocations

		Method(m000, 2)
		{
			Store(arg0, i000)
			if (LEqual(arg1, 0)) {
				Store(Refof(m4f0), Local0)
			} elseif (LEqual(arg1, 1)) {
				Store(Refof(m4f2), Local0)
			}
			Return (Local0)
		}

		Method(CH00, 2)
		{
			if (LNotEqual(i000, arg1)) {
				err(arg0, z100, 0, 0, 0, i000, arg1)
			}
		}

		Name(lpN0, 2)
		Name(lpC0, 0)

		While (lpN0) {
			Multiply(3, lpC0, Local0)

			Store(0, i000)

			Store (DerefOf(m000(1, lpC0)), Local1)
			if(LNot(SLCK)){
				CH04(ts, 0, 47, z100, Add(9, lpC0), 0, 0)
			}
			CH00(arg0, 1)

			Store (DerefOf(DerefOf(m000(2, lpC0))), Local1)
			if(LNot(SLCK)){
				CH06(arg0, Add(1, Local0), 47)
			}
			CH00(arg0, 2)

			Store (Index(DerefOf(m000(3, lpC0)), 0), Local1)
			CH06(arg0, Add(2, Local0), 47)
			CH00(arg0, 3)

			Store (Match(DerefOf(m000(4, lpC0)), MTR, 0, MTR, 0, 0), Local1)
			CH06(arg0, Add(3, Local0), 47)
			CH00(arg0, 4)

			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	SET0(z100, ts, 0)

	CH03(ts, z100, 11, 0, 0)

	// Local Named Object
	m000(ts)

	// Global Named Object
	m001(ts)

	// Local
	m002(Concatenate(ts, "-m002"))

	// Reference to Local Named Object

	m003(Concatenate(ts, "-m003-RefLocName"), RefOf(m4f1))

	Store(RefOf(m4f1), Local0)
	m003(Concatenate(ts, "-m003-RefLocName2"), Local0)

	CondRefOf(m4f1, Local0)
	m003(Concatenate(ts, "-m003-CondRefLocName"), Local0)

	m003(Concatenate(ts, "-m003-RefGlobName"), RefOf(m4f0))

	Store(RefOf(m4f0), Local0)
	m003(Concatenate(ts, "-m003-RefGlobName2"), Local0)

	CondRefOf(m4f0, Local0)
	m003(Concatenate(ts, "-m003-CondRefGlobName"), Local0)

	// Reference to Object as element of Package

	Name(pp00, Package(){m4f0})

	if (y113) {
		m003(Concatenate(ts, "-m003-Index"), Index(pp00, 0))
	}

	Store(Index(pp00, 0), Local1)
	m003(Concatenate(ts, "-m003-Index2"), Local1)

	if (y113) {
		m003(Concatenate(ts, "-m003-Index3"), Index(pp00, 0, Local2))
	}

	Index(pp00, 0, Local3)
	m003(Concatenate(ts, "-m003-Index4"), Local3)

	Store(Index(pp00, 0, Local4), Local5)
	m003(Concatenate(ts, "-m003-Index5"), Local5)

	// Result of Method invocation
	m004(Concatenate(ts, "-m004"))

	// Reference to Object as Result of Method invocation
	m005(Concatenate(ts, "-m005"))

	RST0()
}
