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
 *  Uninitialized Data
 *
 * (verify exceptions caused by use of Uninitialized Data)
 */

Name(z092, 92)

// Expected exceptions:
//
// 49 - AE_AML_UNINITIALIZED_LOCAL
// 50 - AE_AML_UNINITIALIZED_ARG
// 51 - AE_AML_UNINITIALIZED_ELEMENT
Method(m4b0, 1, Serialized)
{
	Name(ts, "m4b0")

	Name(i000, 0)
	Event(e000)

	// Uninitialized Local
	Method(m000, 2)
	{
		if (arg1) {
			Store(0, Local0)
		}

		// CondRefOf
		
		CondRefOf(Local0, Local1)
		CH03(ts, z092, 1, 0, 0)

		// CopyObject

		CopyObject(Local0, Local1)
		CH06(arg0, 0, 49)

		// Decrement

		Decrement(Local0)
		CH06(arg0, 1, 49)

		// DerefOf

		Store (DerefOf(Local0), Local1)
		CH06(arg0, 2, 49)

		// FindSetLeftBit

		FindSetLeftBit(Local0, Local1)
		CH06(arg0, 4, 49)

		// FindSetRightBit

		FindSetRightBit(Local0, Local1)
		CH06(arg0, 6, 49)

		// FromBCD

		FromBCD(Local0, Local1)
		CH06(arg0, 8, 49)

		// Increment

		Increment(Local0)
		CH06(arg0, 9, 49)

		// LNot

		Store (LNot(Local0), Local1)
		CH06(arg0, 10, 49)

		// Not

		Not(Local0, Local1)
		CH06(arg0, 12, 49)

		// ObjectType

		Store (ObjectType(Local0), Local1)
		CH03(ts, z092, 2, 0, 0)

		// RefOf

		Store (RefOf(Local0), Local1)
		CH03(ts, z092, 3, 0, 0)

		// Release

		Release(Local0)
		CH06(arg0, 13, 49)

		// Reset

		Reset(Local0)
		CH06(arg0, 14, 49)

		// Signal

		Signal(Local0)
		CH06(arg0, 15, 49)

		// SizeOf

		Store (SizeOf(Local0), Local1)
		CH06(arg0, 16, 49)

		// Sleep

		Sleep(Local0)
		CH06(arg0, 17, 49)

		// Stall

		Stall(Local0)
		CH06(arg0, 18, 49)

		// Store

		Store(Local0, Local1)
		CH06(arg0, 19, 49)

		// ToBCD

		ToBCD(Local0, Local1)
		CH06(arg0, 21, 49)

		// ToBuffer

		ToBuffer(Local0, Local1)
		CH06(arg0, 23, 49)

		// ToDecimalString

		ToDecimalString(Local0, Local1)
		CH06(arg0, 25, 49)

		// ToHexString

		ToHexString(Local0, Local1)
		CH06(arg0, 27, 49)

		// ToInteger

		ToInteger(Local0, Local1)
		CH06(arg0, 29, 49)

		// Acquire

		Store(Acquire(Local0, 100), Local1)
		CH06(arg0, 30, 49)

		// Add

		Add(Local0, i000, Local1)
		CH06(arg0, 33, 49)

		Add(i000, Local0, Local1)
		CH06(arg0, 34, 49)

		// And

		And(Local0, i000, Local1)
		CH06(arg0, 37, 49)

		And(i000, Local0, Local1)
		CH06(arg0, 38, 49)

		// Concatenate

		Concatenate(Local0, i000, Local1)
		CH06(arg0, 41, 49)

		Concatenate(i000, Local0, Local1)
		CH06(arg0, 42, 49)

		// ConcatenateResTemplate

		ConcatenateResTemplate(Local0, ResourceTemplate(){}, Local1)
		CH06(arg0, 45, 49)

		ConcatenateResTemplate(ResourceTemplate(){}, Local0, Local1)
		CH06(arg0, 46, 49)

		// Divide

		Divide(Local0, i000, Local2)
		CH06(arg0, 49, 49)

		Divide(i000, Local0, Local2)
		CH06(arg0, 50, 49)

		Divide(Local0, i000, Local2, Local1)
		CH06(arg0, 51, 49)

		Divide(i000, Local0, Local2, Local1)
		CH06(arg0, 52, 49)

		// Fatal

		Fatal(0xff, 0xffffffff, Local0)
		CH06(arg0, 53, 49)

		// Index

		Index(Local0, 0, Local1)
		CH06(arg0, 56, 49)

		Index("0", Local0, Local1)
		CH06(arg0, 57, 49)

		// LEqual

		Store (LEqual(Local0, i000), Local1)
		CH06(arg0, 58, 49)

		Store (LEqual(i000, Local0), Local1)
		CH06(arg0, 59, 49)

		// LGreater

		Store (LGreater(Local0, i000), Local1)
		CH06(arg0, 60, 49)

		Store (LGreater(i000, Local0), Local1)
		CH06(arg0, 61, 49)

		// LGreaterEqual

		Store (LGreaterEqual(Local0, i000), Local1)
		CH06(arg0, 62, 0xff)

		Store (LGreaterEqual(i000, Local0), Local1)
		CH06(arg0, 63, 0xff)

		// LLess

		Store (LLess(Local0, i000), Local1)
		CH06(arg0, 64, 49)

		Store (LLess(i000, Local0), Local1)
		CH06(arg0, 65, 49)

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
		CH06(arg0, 70, 49)

		Store (LOr(i000, Local0), Local1)
		CH06(arg0, 71, 49)

		// Mod

		Mod(Local0, i000, Local1)
		CH06(arg0, 74, 49)

		Mod(i000, Local0, Local1)
		CH06(arg0, 75, 49)

		// Multiply

		Multiply(Local0, i000, Local1)
		CH06(arg0, 78, 49)

		Multiply(i000, Local0, Local1)
		CH06(arg0, 79, 49)

		// NAnd

		NAnd(Local0, i000, Local1)
		CH06(arg0, 82, 49)

		NAnd(i000, Local0, Local1)
		CH06(arg0, 83, 49)

		// NOr

		NOr(Local0, i000, Local1)
		CH06(arg0, 86, 49)

		NOr(i000, Local0, Local1)
		CH06(arg0, 87, 49)

		// Or

		Or(Local0, i000, Local1)
		CH06(arg0, 90, 49)

		Or(i000, Local0, Local1)
		CH06(arg0, 91, 49)

		// ShiftLeft

		ShiftLeft(Local0, i000, Local1)
		CH06(arg0, 94, 49)

		ShiftLeft(i000, Local0, Local1)
		CH06(arg0, 95, 49)

		// ShiftRight

		ShiftRight(Local0, i000, Local1)
		CH06(arg0, 98, 49)

		ShiftRight(i000, Local0, Local1)
		CH06(arg0, 99, 49)

		// Subtract

		Subtract(Local0, i000, Local1)
		CH06(arg0, 102, 49)

		Subtract(i000, Local0, Local1)
		CH06(arg0, 103, 49)

		// ToString

		ToString(Local0, 1, Local1)
		CH06(arg0, 106, 49)

		ToString(i000, Local0, Local1)
		CH06(arg0, 107, 49)

		// Wait

		Store(Wait(Local0, i000), Local1)
		CH06(arg0, 108, 49)

		Store(Wait(e000, Local0), Local1)
		CH06(arg0, 109, 49)

		// XOr

		XOr(Local0, i000, Local1)
		CH06(arg0, 112, 49)

		XOr(i000, Local0, Local1)
		CH06(arg0, 113, 49)

		// Mid

		Mid(Local0, 1, 1, Local1)
		CH06(arg0, 117, 49)

		Mid("123", Local0, 1, Local1)
		CH06(arg0, 118, 49)

		Mid("123", 1, Local0, Local1)
		CH06(arg0, 119, 49)

		// Match

		Store (Match(Local0, MTR, 0, MTR, 0, 0), Local1)
		CH06(arg0, 120, 49)

		Store (Match(Package(){1}, MTR, Local0, MTR, 0, 0), Local1)
		CH06(arg0, 121, 49)

		Store (Match(Package(){1}, MTR, 0, MTR, Local0, 0), Local1)
		CH06(arg0, 122, 49)

		Store (Match(Package(){1}, MTR, 0, MTR, 0, Local0), Local1)
		CH06(arg0, 123, 49)
	}

	// Uninitialized element of Package
	Method(m001, 1, Serialized)
	{
		Name(p000, Package(1){})

		// DeRefOf(Index(Package, Ind))

		Store (DeRefOf(Index(p000, 0)), Local1)
		CH04(ts, 1, 51, z092, 4, 0, 0)

		// CondRefOf
		
		CondRefOf(DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 1, 0xff)

		// CopyObject

		CopyObject(DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 2, 0xff)

		// Decrement

		Decrement(DeRefOf(Index(p000, 0)))
		CH06(arg0, 3, 0xff)

		// DerefOf

		Store (DerefOf(DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 4, 0xff)

		// FindSetLeftBit

		FindSetLeftBit(DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 6, 0xff)

		// FindSetRightBit

		FindSetRightBit(DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 8, 0xff)

		// FromBCD

		FromBCD(DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 10, 0xff)

		// Increment

		Increment(DeRefOf(Index(p000, 0)))
		CH06(arg0, 11, 0xff)

		// LNot

		Store (LNot(DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 12, 0xff)

		// Not

		Not(DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 14, 0xff)

		// ObjectType

		if (X104) {
			Store (ObjectType(DeRefOf(Index(p000, 0))), Local1)
			CH03(ts, z092, 5, 0, 0)
		}

		// RefOf

		Store (RefOf(DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 15, 0xff)

		// Release

		// Reset

		// Signal

		// SizeOf

		Store (SizeOf(DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 16, 0xff)

		// Sleep

		Sleep(DeRefOf(Index(p000, 0)))
		CH06(arg0, 17, 0xff)

		// Stall

		Stall(DeRefOf(Index(p000, 0)))
		CH06(arg0, 18, 0xff)

		// Store

		Store(DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 19, 0xff)

		// ToBCD

		ToBCD(DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 21, 0xff)

		// ToBuffer

		ToBuffer(DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 23, 0xff)

		// ToDecimalString

		ToDecimalString(DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 25, 0xff)

		// ToHexString

		ToHexString(DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 27, 0xff)

		// ToInteger

		ToInteger(DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 29, 0xff)

		// Acquire

		// Add

		Add(DeRefOf(Index(p000, 0)), i000, Local1)
		CH06(arg0, 33, 0xff)

		Add(i000, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 34, 0xff)

		// And

		And(DeRefOf(Index(p000, 0)), i000, Local1)
		CH06(arg0, 37, 0xff)

		And(i000, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 38, 0xff)

		// Concatenate

		Concatenate(DeRefOf(Index(p000, 0)), i000, Local1)
		CH06(arg0, 41, 0xff)

		Concatenate(i000, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 42, 0xff)

		// ConcatenateResTemplate

		ConcatenateResTemplate(DeRefOf(Index(p000, 0)), ResourceTemplate(){}, Local1)
		CH06(arg0, 45, 0xff)

		ConcatenateResTemplate(ResourceTemplate(){}, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 46, 0xff)

		// Divide

		Divide(DeRefOf(Index(p000, 0)), i000, Local2)
		CH06(arg0, 49, 0xff)

		Divide(i000, DeRefOf(Index(p000, 0)), Local2)
		CH06(arg0, 50, 0xff)

		Divide(DeRefOf(Index(p000, 0)), i000, Local2, Local1)
		CH06(arg0, 51, 0xff)

		Divide(i000, DeRefOf(Index(p000, 0)), Local2, Local1)
		CH06(arg0, 52, 0xff)

		// Fatal

		Fatal(0xff, 0xffffffff, DeRefOf(Index(p000, 0)))
		CH06(arg0, 53, 0xff)

		// Index

		Index(DeRefOf(Index(p000, 0)), 0, Local1)
		CH06(arg0, 56, 0xff)

		Index("0", DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 57, 0xff)

		// LEqual

		Store (LEqual(DeRefOf(Index(p000, 0)), i000), Local1)
		CH06(arg0, 58, 0xff)

		Store (LEqual(i000, DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 59, 0xff)

		// LGreater

		Store (LGreater(DeRefOf(Index(p000, 0)), i000), Local1)
		CH06(arg0, 60, 0xff)

		Store (LGreater(i000, DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 61, 0xff)

		// LGreaterEqual

		Store (LGreaterEqual(DeRefOf(Index(p000, 0)), i000), Local1)
		CH06(arg0, 62, 0xff)

		Store (LGreaterEqual(i000, DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 63, 0xff)

		// LLess

		Store (LLess(DeRefOf(Index(p000, 0)), i000), Local1)
		CH06(arg0, 64, 0xff)

		Store (LLess(i000, DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 65, 0xff)

		// LLessEqual

		Store (LLessEqual(DeRefOf(Index(p000, 0)), i000), Local1)
		CH06(arg0, 66, 0xff)

		Store (LLessEqual(i000, DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 67, 0xff)

		// LNotEqual

		Store (LNotEqual(DeRefOf(Index(p000, 0)), i000), Local1)
		CH06(arg0, 68, 0xff)

		Store (LNotEqual(i000, DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 69, 0xff)

		// LOr

		Store (LOr(DeRefOf(Index(p000, 0)), i000), Local1)
		CH06(arg0, 70, 0xff)

		Store (LOr(i000, DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 71, 0xff)

		// Mod

		Mod(DeRefOf(Index(p000, 0)), i000, Local1)
		CH06(arg0, 74, 0xff)

		Mod(i000, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 75, 0xff)

		// Multiply

		Multiply(DeRefOf(Index(p000, 0)), i000, Local1)
		CH06(arg0, 78, 0xff)

		Multiply(i000, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 79, 0xff)

		// NAnd

		NAnd(DeRefOf(Index(p000, 0)), i000, Local1)
		CH06(arg0, 82, 0xff)

		NAnd(i000, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 83, 0xff)

		// NOr

		NOr(DeRefOf(Index(p000, 0)), i000, Local1)
		CH06(arg0, 86, 0xff)

		NOr(i000, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 87, 0xff)

		// Or

		Or(DeRefOf(Index(p000, 0)), i000, Local1)
		CH06(arg0, 90, 0xff)

		Or(i000, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 91, 0xff)

		// ShiftLeft

		ShiftLeft(DeRefOf(Index(p000, 0)), i000, Local1)
		CH06(arg0, 94, 0xff)

		ShiftLeft(i000, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 95, 0xff)

		// ShiftRight

		ShiftRight(DeRefOf(Index(p000, 0)), i000, Local1)
		CH06(arg0, 98, 0xff)

		ShiftRight(i000, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 99, 0xff)

		// Subtract

		Subtract(DeRefOf(Index(p000, 0)), i000, Local1)
		CH06(arg0, 102, 0xff)

		Subtract(i000, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 103, 0xff)

		// ToString

		ToString(DeRefOf(Index(p000, 0)), 1, Local1)
		CH06(arg0, 106, 0xff)

		ToString(i000, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 107, 0xff)

		// Wait

		Store(Wait(e000, DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 109, 0xff)

		// XOr

		XOr(DeRefOf(Index(p000, 0)), i000, Local1)
		CH06(arg0, 112, 0xff)

		XOr(i000, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 113, 0xff)

		// Mid

		Mid(DeRefOf(Index(p000, 0)), 1, 1, Local1)
		CH06(arg0, 117, 0xff)

		Mid("123", DeRefOf(Index(p000, 0)), 1, Local1)
		CH06(arg0, 118, 0xff)

		Mid("123", 1, DeRefOf(Index(p000, 0)), Local1)
		CH06(arg0, 119, 0xff)

		// Match

		Store (Match(Package(){1}, MTR, DeRefOf(Index(p000, 0)), MTR, 0, 0), Local1)
		CH06(arg0, 121, 0xff)

		Store (Match(Package(){1}, MTR, 0, MTR, DeRefOf(Index(p000, 0)), 0), Local1)
		CH06(arg0, 122, 0xff)

		Store (Match(Package(){1}, MTR, 0, MTR, 0, DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 123, 0xff)

		// DeRefOf(Index(Package, Ind, Dest))
		// This should cause an exception
		// on storing to Dest (see m001)

		Return (0)
	}

/*
// Causes Remark on compilation
	// Uninitialized Arg
	Method(m002, 2)
	{
		if (arg1) {
			Store(0, arg2)
		}

		// CondRefOf
		
		CondRefOf(arg2)
		CH03(ts, z092, 6, 0, 0)

		CondRefOf(arg2, Local1)
		CH03(ts, z092, 7, 0, 0)

		// CopyObject

		CopyObject(arg2, Local1)
		CH06(arg0, 0, 50)

		// Decrement

		Decrement(arg2)
		CH06(arg0, 1, 50)

		// DerefOf

		DerefOf(arg2)
		CH06(arg0, 2, 50)

		// FindSetLeftBit

		FindSetLeftBit(arg2)
		CH06(arg0, 3, 50)

		FindSetLeftBit(arg2, Local1)
		CH06(arg0, 4, 50)

		// FindSetRightBit

		FindSetRightBit(arg2)
		CH06(arg0, 5, 50)

		FindSetRightBit(arg2, Local1)
		CH06(arg0, 6, 50)

		// FromBCD

		FromBCD(arg2)
		CH06(arg0, 7, 50)

		FromBCD(arg2, Local1)
		CH06(arg0, 8, 50)

		// Increment

		Increment(arg2)
		CH06(arg0, 9, 50)

		// LNot

		LNot(arg2)
		CH06(arg0, 10, 50)

		// Not

		Not(arg2)
		CH06(arg0, 11, 50)

		Not(arg2, Local1)
		CH06(arg0, 12, 50)

		// ObjectType

		ObjectType(arg2)
		CH03(ts, z092, 8, 0, 0)

		// RefOf

		RefOf(arg2)
		CH03(ts, z092, 9, 0, 0)

		// Release

		Release(arg2)
		CH06(arg0, 13, 50)

		// Reset

		Reset(arg2)
		CH06(arg0, 14, 50)

		// Signal

		Signal(arg2)
		CH06(arg0, 15, 50)

		// SizeOf

		SizeOf(arg2)
		CH06(arg0, 16, 50)

		// Sleep

		Sleep(arg2)
		CH06(arg0, 17, 50)

		// Stall

		Stall(arg2)
		CH06(arg0, 18, 50)

		// Store

		Store(arg2, Local1)
		CH06(arg0, 19, 50)

		// ToBCD

		ToBCD(arg2)
		CH06(arg0, 20, 50)

		ToBCD(arg2, Local1)
		CH06(arg0, 21, 50)

		// ToBuffer

		ToBuffer(arg2)
		CH06(arg0, 22, 50)

		ToBuffer(arg2, Local1)
		CH06(arg0, 23, 50)

		// ToDecimalString

		ToDecimalString(arg2)
		CH06(arg0, 24, 50)

		ToDecimalString(arg2, Local1)
		CH06(arg0, 25, 50)

		// ToHexString

		ToHexString(arg2)
		CH06(arg0, 26, 50)

		ToHexString(arg2, Local1)
		CH06(arg0, 27, 50)

		// ToInteger

		ToInteger(arg2)
		CH06(arg0, 28, 50)

		ToInteger(arg2, Local1)
		CH06(arg0, 29, 50)

		// Acquire

		Store(Acquire(arg2, 100), Local1)
		CH06(arg0, 30, 50)

		// Add

		Add(arg2, i000)
		CH06(arg0, 31, 50)

		Add(i000, arg2)
		CH06(arg0, 32, 50)

		Add(arg2, i000, Local1)
		CH06(arg0, 33, 50)

		Add(i000, arg2, Local1)
		CH06(arg0, 34, 50)

		// And

		And(arg2, i000)
		CH06(arg0, 35, 50)

		And(i000, arg2)
		CH06(arg0, 36, 50)

		And(arg2, i000, Local1)
		CH06(arg0, 37, 50)

		And(i000, arg2, Local1)
		CH06(arg0, 38, 50)

		// Concatenate

		Concatenate(arg2, i000)
		CH06(arg0, 39, 50)

		Concatenate(i000, arg2)
		CH06(arg0, 40, 50)

		Concatenate(arg2, i000, Local1)
		CH06(arg0, 41, 50)

		Concatenate(i000, arg2, Local1)
		CH06(arg0, 42, 50)

		// ConcatenateResTemplate

		ConcatenateResTemplate(arg2, ResourceTemplate(){})
		CH06(arg0, 43, 50)

		ConcatenateResTemplate(ResourceTemplate(){}, arg2)
		CH06(arg0, 44, 50)

		ConcatenateResTemplate(arg2, ResourceTemplate(){}, Local1)
		CH06(arg0, 45, 50)

		ConcatenateResTemplate(ResourceTemplate(){}, arg2, Local1)
		CH06(arg0, 46, 50)

		// Divide

		Divide(arg2, i000)
		CH06(arg0, 47, 50)

		Divide(i000, arg2)
		CH06(arg0, 48, 50)

		Divide(arg2, i000, Local2)
		CH06(arg0, 49, 50)

		Divide(i000, arg2, Local2)
		CH06(arg0, 50, 50)

		Divide(arg2, i000, Local2, Local1)
		CH06(arg0, 51, 50)

		Divide(i000, arg2, Local2, Local1)
		CH06(arg0, 52, 50)

		// Fatal

		Fatal(0xff, 0xffffffff, arg2)
		CH06(arg0, 53, 50)

		// Index

		Index(arg2, 0)
		CH06(arg0, 54, 50)

		Index("0", arg2)
		CH06(arg0, 55, 50)

		Index(arg2, 0, Local1)
		CH06(arg0, 56, 50)

		Index("0", arg2, Local1)
		CH06(arg0, 57, 50)

		// LEqual

		LEqual(arg2, i000)
		CH06(arg0, 58, 50)

		LEqual(i000, arg2)
		CH06(arg0, 59, 50)

		// LGreater

		LGreater(arg2, i000)
		CH06(arg0, 60, 50)

		LGreater(i000, arg2)
		CH06(arg0, 61, 50)

		// LGreaterEqual

		LGreaterEqual(arg2, i000)
		CH06(arg0, 62, 0xff)

		LGreaterEqual(i000, arg2)
		CH06(arg0, 63, 0xff)

		// LLess

		LLess(arg2, i000)
		CH06(arg0, 64, 50)

		LLess(i000, arg2)
		CH06(arg0, 65, 50)

		// LLessEqual

		LLessEqual(arg2, i000)
		CH06(arg0, 66, 0xff)

		LLessEqual(i000, arg2)
		CH06(arg0, 67, 0xff)

		// LNotEqual

		LNotEqual(arg2, i000)
		CH06(arg0, 68, 0xff)

		LNotEqual(i000, arg2)
		CH06(arg0, 69, 0xff)

		// LOr

		LOr(arg2, i000)
		CH06(arg0, 70, 50)

		LOr(i000, arg2)
		CH06(arg0, 71, 50)

		// Mod

		Mod(arg2, i000)
		CH06(arg0, 72, 50)

		Mod(i000, arg2)
		CH06(arg0, 73, 50)

		Mod(arg2, i000, Local1)
		CH06(arg0, 74, 50)

		Mod(i000, arg2, Local1)
		CH06(arg0, 75, 50)

		// Multiply

		Multiply(arg2, i000)
		CH06(arg0, 76, 50)

		Multiply(i000, arg2)
		CH06(arg0, 77, 50)

		Multiply(arg2, i000, Local1)
		CH06(arg0, 78, 50)

		Multiply(i000, arg2, Local1)
		CH06(arg0, 79, 50)

		// NAnd

		NAnd(arg2, i000)
		CH06(arg0, 80, 50)

		NAnd(i000, arg2)
		CH06(arg0, 81, 50)

		NAnd(arg2, i000, Local1)
		CH06(arg0, 82, 50)

		NAnd(i000, arg2, Local1)
		CH06(arg0, 83, 50)

		// NOr

		NOr(arg2, i000)
		CH06(arg0, 84, 50)

		NOr(i000, arg2)
		CH06(arg0, 85, 50)

		NOr(arg2, i000, Local1)
		CH06(arg0, 86, 50)

		NOr(i000, arg2, Local1)
		CH06(arg0, 87, 50)

		// Or

		Or(arg2, i000)
		CH06(arg0, 88, 50)

		Or(i000, arg2)
		CH06(arg0, 89, 50)

		Or(arg2, i000, Local1)
		CH06(arg0, 90, 50)

		Or(i000, arg2, Local1)
		CH06(arg0, 91, 50)

		// ShiftLeft

		ShiftLeft(arg2, i000)
		CH06(arg0, 92, 50)

		ShiftLeft(i000, arg2)
		CH06(arg0, 93, 50)

		ShiftLeft(arg2, i000, Local1)
		CH06(arg0, 94, 50)

		ShiftLeft(i000, arg2, Local1)
		CH06(arg0, 95, 50)

		// ShiftRight

		ShiftRight(arg2, i000)
		CH06(arg0, 96, 50)

		ShiftRight(i000, arg2)
		CH06(arg0, 97, 50)

		ShiftRight(arg2, i000, Local1)
		CH06(arg0, 98, 50)

		ShiftRight(i000, arg2, Local1)
		CH06(arg0, 99, 50)

		// Subtract

		Subtract(arg2, i000)
		CH06(arg0, 100, 50)

		Subtract(i000, arg2)
		CH06(arg0, 101, 50)

		Subtract(arg2, i000, Local1)
		CH06(arg0, 102, 50)

		Subtract(i000, arg2, Local1)
		CH06(arg0, 103, 50)

		// ToString

		ToString(arg2, 1)
		CH06(arg0, 104, 50)

		ToString(i000, arg2)
		CH06(arg0, 105, 50)

		ToString(arg2, 1, Local1)
		CH06(arg0, 106, 50)

		ToString(i000, arg2, Local1)
		CH06(arg0, 107, 50)

		// Wait

		Store(Wait(arg2, i000), Local1)
		CH06(arg0, 108, 50)

		Store(Wait(e000, arg2), Local1)
		CH06(arg0, 109, 50)

		// XOr

		XOr(arg2, i000)
		CH06(arg0, 110, 50)

		XOr(i000, arg2)
		CH06(arg0, 111, 50)

		XOr(arg2, i000, Local1)
		CH06(arg0, 112, 50)

		XOr(i000, arg2, Local1)
		CH06(arg0, 113, 50)

		// Mid

		Mid(arg2, 1, 1)
		CH06(arg0, 114, 50)

		Mid("123", arg2, 1)
		CH06(arg0, 115, 50)

		Mid("123", 1, arg2)
		CH06(arg0, 116, 50)

		Mid(arg2, 1, 1, Local1)
		CH06(arg0, 117, 50)

		Mid("123", arg2, 1, Local1)
		CH06(arg0, 118, 50)

		Mid("123", 1, arg2, Local1)
		CH06(arg0, 119, 50)

		// Match

		Match(arg2, MTR, 0, MTR, 0, 0)
		CH06(arg0, 120, 50)

		Match(Package(){1}, MTR, arg2, MTR, 0, 0)
		CH06(arg0, 121, 50)

		Match(Package(){1}, MTR, 0, MTR, arg2, 0)
		CH06(arg0, 122, 50)

		Match(Package(){1}, MTR, 0, MTR, 0, arg2)
		CH06(arg0, 123, 50)
	}
*/

	// Reference to Uninitialized Object
	Method(m003, 2)
	{
		Store(ObjectType(arg1), Local0)
		if (LNotEqual(Local0, 0)) {
			err(arg0, z092, 8, 0, 0, Local0, 0)
			return (1)
		}

		Store (DeRefOf(arg1), Local1)
		CH04(ts, 0, 62, z092, 10, 0, 0)

		// CondRefOf
		
		CondRefOf(DeRefOf(arg1), Local1)
		CH06(arg0, 1, 0xff)

		// CopyObject

		CopyObject(DeRefOf(arg1), Local1)
		CH06(arg0, 2, 0xff)

		// Decrement

		Decrement(DeRefOf(arg1))
		CH06(arg0, 3, 0xff)

		// DerefOf

		Store (DerefOf(DeRefOf(arg1)), Local1)
		CH06(arg0, 4, 0xff)

		// FindSetLeftBit

		FindSetLeftBit(DeRefOf(arg1), Local1)
		CH06(arg0, 6, 0xff)

		// FindSetRightBit

		FindSetRightBit(DeRefOf(arg1), Local1)
		CH06(arg0, 8, 0xff)

		// FromBCD

		FromBCD(DeRefOf(arg1), Local1)
		CH06(arg0, 10, 0xff)

		// Increment

		Increment(DeRefOf(arg1))
		CH06(arg0, 11, 0xff)

		// LNot

		Store (LNot(DeRefOf(arg1)), Local1)
		CH06(arg0, 12, 0xff)

		// Not

		Store (Not(DeRefOf(arg1)), Local1)
		CH06(arg0, 14, 0xff)

		// ObjectType

		if (X104) {
			Store (ObjectType(DeRefOf(arg1)), Local1)
			CH03(ts, z092, 11, 0, 0)
		}

		// RefOf

		Store (RefOf(DeRefOf(arg1)), Local1)
		CH06(arg0, 15, 0xff)

		// Release

		// Reset

		// Signal

		// SizeOf

		Store (SizeOf(DeRefOf(arg1)), Local1)
		CH06(arg0, 16, 0xff)

		// Sleep

		Sleep(DeRefOf(arg1))
		CH06(arg0, 17, 0xff)

		// Stall

		Stall(DeRefOf(arg1))
		CH06(arg0, 18, 0xff)

		// Store

		Store(DeRefOf(arg1), Local1)
		CH06(arg0, 19, 0xff)

		// ToBCD

		ToBCD(DeRefOf(arg1), Local1)
		CH06(arg0, 21, 0xff)

		// ToBuffer

		ToBuffer(DeRefOf(arg1), Local1)
		CH06(arg0, 23, 0xff)

		// ToDecimalString

		ToDecimalString(DeRefOf(arg1), Local1)
		CH06(arg0, 25, 0xff)

		// ToHexString

		ToHexString(DeRefOf(arg1), Local1)
		CH06(arg0, 27, 0xff)

		// ToInteger

		ToInteger(DeRefOf(arg1), Local1)
		CH06(arg0, 29, 0xff)

		// Acquire

		// Add

		Add(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 33, 0xff)

		Add(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 34, 0xff)

		// And

		And(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 37, 0xff)

		And(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 38, 0xff)

		// Concatenate

		Concatenate(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 41, 0xff)

		Concatenate(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 42, 0xff)

		// ConcatenateResTemplate

		ConcatenateResTemplate(DeRefOf(arg1), ResourceTemplate(){}, Local1)
		CH06(arg0, 45, 0xff)

		ConcatenateResTemplate(ResourceTemplate(){}, DeRefOf(arg1), Local1)
		CH06(arg0, 46, 0xff)

		// Divide

		Divide(DeRefOf(arg1), i000, Local2)
		CH06(arg0, 49, 0xff)

		Divide(i000, DeRefOf(arg1), Local2)
		CH06(arg0, 50, 0xff)

		Divide(DeRefOf(arg1), i000, Local2, Local1)
		CH06(arg0, 51, 0xff)

		Divide(i000, DeRefOf(arg1), Local2, Local1)
		CH06(arg0, 52, 0xff)

		// Fatal

		Fatal(0xff, 0xffffffff, DeRefOf(arg1))
		CH06(arg0, 53, 0xff)

		// Index

		Index(DeRefOf(arg1), 0, Local1)
		CH06(arg0, 56, 0xff)

		Index("0", DeRefOf(arg1), Local1)
		CH06(arg0, 57, 0xff)

		// LEqual

		Store (LEqual(DeRefOf(arg1), i000), Local1)
		CH06(arg0, 58, 0xff)

		Store (LEqual(i000, DeRefOf(arg1)), Local1)
		CH06(arg0, 59, 0xff)

		// LGreater

		Store (LGreater(DeRefOf(arg1), i000), Local1)
		CH06(arg0, 60, 0xff)

		Store (LGreater(i000, DeRefOf(arg1)), Local1)
		CH06(arg0, 61, 0xff)

		// LGreaterEqual

		Store (LGreaterEqual(DeRefOf(arg1), i000), Local1)
		CH06(arg0, 62, 0xff)

		Store (LGreaterEqual(i000, DeRefOf(arg1)), Local1)
		CH06(arg0, 63, 0xff)

		// LLess

		Store (LLess(DeRefOf(arg1), i000), Local1)
		CH06(arg0, 64, 0xff)

		Store (LLess(i000, DeRefOf(arg1)), Local1)
		CH06(arg0, 65, 0xff)

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
		CH06(arg0, 70, 0xff)

		Store (LOr(i000, DeRefOf(arg1)), Local1)
		CH06(arg0, 71, 0xff)

		// Mod

		Mod(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 74, 0xff)

		Mod(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 75, 0xff)

		// Multiply

		Multiply(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 78, 0xff)

		Multiply(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 79, 0xff)

		// NAnd

		NAnd(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 82, 0xff)

		NAnd(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 83, 0xff)

		// NOr

		NOr(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 86, 0xff)

		NOr(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 87, 0xff)

		// Or

		Or(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 90, 0xff)

		Or(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 91, 0xff)

		// ShiftLeft

		ShiftLeft(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 94, 0xff)

		ShiftLeft(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 95, 0xff)

		// ShiftRight

		ShiftRight(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 98, 0xff)

		ShiftRight(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 99, 0xff)

		// Subtract

		Subtract(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 102, 0xff)

		Subtract(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 103, 0xff)

		// ToString

		ToString(DeRefOf(arg1), 1, Local1)
		CH06(arg0, 106, 0xff)

		ToString(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 107, 0xff)

		// Wait

		Store(Wait(e000, DeRefOf(arg1)), Local1)
		CH06(arg0, 109, 0xff)

		// XOr

		XOr(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 112, 0xff)

		XOr(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 113, 0xff)

		// Mid

		Mid(DeRefOf(arg1), 1, 1, Local1)
		CH06(arg0, 117, 0xff)

		Mid("123", DeRefOf(arg1), 1, Local1)
		CH06(arg0, 118, 0xff)

		Mid("123", 1, DeRefOf(arg1), Local1)
		CH06(arg0, 119, 0xff)

		// Match

		Store (Match(DeRefOf(arg1), MTR, 0, MTR, 0, 0), Local1)
		CH06(arg0, 120, 0xff)

		Store (Match(Package(){1}, MTR, DeRefOf(arg1), MTR, 0, 0), Local1)
		CH06(arg0, 121, 0xff)

		Store (Match(Package(){1}, MTR, 0, MTR, DeRefOf(arg1), 0), Local1)
		CH06(arg0, 122, 0xff)

		Store (Match(Package(){1}, MTR, 0, MTR, 0, DeRefOf(arg1)), Local1)
		CH06(arg0, 123, 0xff)

		return (0)
	}

	// Uninitialized Local in Return
	Method(m004, 1)
	{
		if (arg0) {
			Store(0, Local0)
		}

		Return (Local0)

	}

	// Uninitialized element of Package in Return
	Method(m005,, Serialized)
	{
		Name(p000, Package(1){})

		Return (DeRefOf(Index(p000, 0)))

	}

/*
// Causes Remark on compilation
	// Uninitialized Arg in Return
	Method(m006, 1)
	{
		if (arg0) {
			Store(0, arg1)
		}

		Return (arg1)

	}
*/

	// Uninitialized Local in If
	Method(m007, 1)
	{
		if (arg0) {
			Store(0, Local0)
		}

		Store(0, Local1)

		if (Local0) {
			Store(1, Local1)
		}

		Return (Local1)

	}

	// Uninitialized element of Package in If
	Method(m008,, Serialized)
	{
		Name(p000, Package(1){})

		Store(0, Local1)

		if (DeRefOf(Index(p000, 0))) {
			Store(1, Local1)
		}

		Return (Local1)

	}

/*
// Causes Remark on compilation
	// Uninitialized Arg in If
	Method(m009, 1)
	{
		if (arg0) {
			Store(0, arg1)
		}

		Store(0, Local1)

		if (arg1) {
			Store(1, Local1)
		}

		Return (Local1)

	}
*/

	// Uninitialized Local in Elseif
	Method(m00a, 1)
	{
		if (arg0) {
			Store(0, Local0)
		}

		Store(0, Local1)

		if (arg0) {
			Store(1, Local1)
		} elseif (Local0) {
			Store(2, Local1)
		}

		Return (Local1)

	}

	// Uninitialized element of Package in Elseif
	Method(m00b, 1, Serialized)
	{
		Name(p000, Package(1){})

		Store(0, Local1)

		if (arg0) {
			Store(1, Local1)
		} elseif (DeRefOf(Index(p000, 0))) {
			Store(2, Local1)
		}

		Return (Local1)

	}

/*
// Causes Remark on compilation
	// Uninitialized Arg in If
	Method(m00c, 1)
	{
		if (arg0) {
			Store(0, arg1)
		}

		Store(0, Local1)

		if (arg0) {
			Store(1, Local1)
		} elseif (arg1) {
			Store(2, Local1)
		}

		Return (Local1)

	}
*/

	Name(i001, 0)

	Method(m00d, 1)
	{
		Store(1, i001)
	}


	// Uninitialized element of Package as parameter of a method
	Method(m00e, 1, Serialized)
	{
		Name(p000, Package(1){})

		Store(0, i001)
		m00d(Derefof(Index(p000, 0)))
		CH06(arg0, 0, 51)
		if (LNotEqual(i001, 0)) {
			err(arg0, z092, 1, 0, 0, i001, 0)
		}

		Store(0, i001)
		Store(Index(p000, 0), Local1)
		m00d(Derefof(Local1))
		CH06(arg0, 2, 51)
		if (LNotEqual(i001, 0)) {
			err(arg0, z092, 3, 0, 0, i001, 0)
		}

		Store(0, i001)
		m00d(Derefof(Index(p000, 0, Local2)))
		CH06(arg0, 4, 51)
		if (LNotEqual(i001, 0)) {
			err(arg0, z092, 5, 0, 0, i001, 0)
		}

		Store(0, i001)
		Index(p000, 0, Local3)
		m00d(Derefof(Local3))
		CH06(arg0, 6, 51)
		if (LNotEqual(i001, 0)) {
			err(arg0, z092, 7, 0, 0, i001, 0)
		}

		Store(0, i001)
		Store(Index(p000, 0, Local4), Local5)
		m00d(Derefof(Local5))
		CH06(arg0, 8, 51)
		if (LNotEqual(i001, 0)) {
			err(arg0, z092, 9, 0, 0, i001, 0)
		}
	}

	CH03(ts, z092, 12, 0, 0)

	// Uninitialized Local
	m000(Concatenate(ts, "-m000"), 0)

	// Uninitialized element of Package
	m001(Concatenate(ts, "-m001"))

/*
// Causes Remark on compilation
	// Uninitialized Arg
	m002(Concatenate(ts, "-m002"), 0)
*/

	// Reference to Uninitialized Local

	if (arg0) {
		Store(0, Local0)
	}

	m003(Concatenate(ts, "-m003-RefLocal"), RefOf(Local0))

	// Reference (Index) to Uninitialized element of Package

	if (y502) {
		Name(p000, Package(1){})

		if (y113) {
			m003(Concatenate(ts, "-m003-Index"), Index(p000, 0))
		}

		Store(Index(p000, 0), Local1)
		m003(Concatenate(ts, "-m003-Index2"), Local1)

		if (y113) {
			m003(Concatenate(ts, "-m003-Index3"), Index(p000, 0, Local2))
		}

		Index(p000, 0, Local3)
		m003(Concatenate(ts, "-m003-Index4"), Local3)

		Store(Index(p000, 0, Local4), Local5)
		m003(Concatenate(ts, "-m003-Index5"), Local5)
	}

	// Uninitialized Local in Return
	m004(0)
	CH06(ts, 0, 49)

	// Uninitialized element of Package in Return
	if (y502) {
		m005()
		CH06(ts, 1, 51)
	}

/*
// Causes Remark on compilation
	// Uninitialized Arg in Return
	m006(0)
	CH06(ts, 2, 50)
*/

	// Uninitialized Local in If
	m007(0)
	CH06(ts, 3, 49)

	// Uninitialized element of Package in If
	if (y502) {
		m008()
		CH06(ts, 4, 51)
	}

/*
// Causes Remark on compilation
	// Uninitialized Arg in If
	m009(0)
	CH06(ts, 5, 50)
*/

	// Uninitialized Local in Elseif
	m00a(0)
	CH06(ts, 6, 49)

	// Uninitialized element of Package in Elseif
	if (y502) {
		m00b(0)
		CH06(ts, 7, 51)
	}

/*
// Causes Remark on compilation
	// Uninitialized Arg in Elseif
	m00c(0)
	CH06(ts, 8, 50)
*/

	// Uninitialized Local as parameter of a method
	Store(0, i001)
	m00d(Local0)
	CH06(ts, 9, 49)
	if (LNotEqual(i001, 0)) {
		err(ts, z092, 10, 0, 0, i001, 0)
	}

	// Uninitialized element of Package as parameter of a method
	if (y502) {
		m00e(Concatenate(ts, "-m00e"))
	}

/*
// Causes Remark on compilation
	// Uninitialized Arg as parameter of a method
	Store(0, i001)
	m00d(Arg1)
	CH06(ts, 11, 50)
	if (LNotEqual(i001, 0)) {
		err(ts, z092, 12, i001, 0)
	}
*/
}
