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
 *  String
 *
 * (verify exceptions caused by the imprope use of String type objects)
 */

Name(z094, 94)

Name(s100, "1")

// Expected exceptions:
//
// 47 - AE_AML_OPERAND_TYPE
//  5 - AE_NOT_FOUND (when DerefOf(String))
//
// Note: String can be used with DerefOf and Index
Method(m4b2, 1, Serialized)
{
	Name(ts, "m4b2")

	Name(s000, "2")

	// Local Named Object
	Method(m000, 1, Serialized)
	{
		Name(s000, "3")

		// DerefOf

		if (y083) {
			Store (DerefOf(s000), Local1)
			CH06(arg0, 0, 47)
		}

		// Index

		Index(s000, 0, Local1)
		CH03(ts, z094, 1, 0, 0)

		// ConcatenateResTemplate

		ConcatenateResTemplate(s000, ResourceTemplate(){}, Local1)
		CH06(arg0, 3, 47)

		ConcatenateResTemplate(ResourceTemplate(){}, s000, Local1)
		CH06(arg0, 4, 47)

	}

	// Global Named Object
	Method(m001, 1)
	{
		if (y083) {
			Store (DerefOf(s100), Local1)
			CH06(arg0, 5, 47)
		}

		// Index

		Index(s100, 0, Local1)
		CH03(ts, z094, 3, 0, 0)

		// ConcatenateResTemplate

		ConcatenateResTemplate(s100, ResourceTemplate(){}, Local1)
		CH06(arg0, 8, 47)

		ConcatenateResTemplate(ResourceTemplate(){}, s100, Local1)
		CH06(arg0, 9, 47)

	}

	// Argument
	Method(m002, 2)
	{
		// DerefOf

		Store (DerefOf(arg1), Local1)
		CH06(arg0, 10, 47)

		// Release

		Release(arg1)
		CH06(arg0, 11, 47)

		// Reset

		Reset(arg1)
		CH06(arg0, 12, 47)

		// Signal

		Signal(arg1)
		CH06(arg0, 13, 47)

		// Acquire

		Store(Acquire(arg1, 0), Local1)
		CH06(arg0, 14, 47)

		// ConcatenateResTemplate

		ConcatenateResTemplate(arg1, ResourceTemplate(){}, Local1)
		CH06(arg0, 17, 47)

		ConcatenateResTemplate(ResourceTemplate(){}, arg1, Local1)
		CH06(arg0, 18, 47)

		// Index

		Index(arg1, 0, Local1)
		CH03(ts, z094, 5, 0, 0)

		// Wait

		Store(Wait(arg1, 0), Local1)
		CH06(arg0, 19, 47)

		// Match

		Store (Match(arg1, MTR, 0, MTR, 0, 0), Local1)
		CH06(arg0, 20, 47)
	}

	// Local
	Method(m003, 1)
	{
		Store("3", Local0)

		// DerefOf

		Store (DerefOf(Local0), Local1)
		CH06(arg0, 21, 47)

		// Release

		Release(Local0)
		CH06(arg0, 22, 47)

		// Reset

		Reset(Local0)
		CH06(arg0, 23, 47)

		// Signal

		Signal(Local0)
		CH06(arg0, 24, 47)

		// Acquire

		Store(Acquire(Local0, 0), Local1)
		CH06(arg0, 25, 47)

		// ConcatenateResTemplate

		ConcatenateResTemplate(Local0, ResourceTemplate(){}, Local1)
		CH06(arg0, 28, 47)

		ConcatenateResTemplate(ResourceTemplate(){}, Local0, Local1)
		CH06(arg0, 29, 47)

		// Index

		Index(Local0, 0, Local1)
		CH03(ts, z094, 7, 0, 0)

		// Wait

		Store(Wait(Local0, 0), Local1)
		CH06(arg0, 30, 47)

		// Match

		Store (Match(Local0, MTR, 0, MTR, 0, 0), Local1)
		CH06(arg0, 31, 47)
	}

	// An element of Package
	Method(m004, 1, Serialized)
	{
		Name(p000, Package(){"3"})

		// DeRefOf(Index(Package, Ind))

		Store (DerefOf(DeRefOf(Index(p000, 0))), Local1)
		CH06(arg0, 32, 5)

		Store (Index(DeRefOf(Index(p000, 0)), 0), Local1)
		CH03(ts, z094, 8, 0, 0)

		Store (Match(DeRefOf(Index(p000, 0)), MTR, 0, MTR, 0, 0), Local1)
		CH06(arg0, 33, 47)

		// DeRefOf(Index(Package, Ind, Dest))

		Store (DerefOf(DeRefOf(Index(p000, 0, Local0))), Local1)
		CH06(arg0, 34, 5)

		Store (Index(DeRefOf(Index(p000, 0, Local0)), 0), Local1)
		CH03(ts, z094, 9, 0, 0)

		Store (Match(DeRefOf(Index(p000, 0, Local0)), MTR, 0, MTR, 0, 0), Local1)
		CH06(arg0, 35, 47)
	}

	// Reference to Object
	Method(m005, 2)
	{
		Store(arg0, Debug)
		Store(arg1, Debug)

		Store(ObjectType(arg1), Local0)
		if (LNotEqual(Local0, 2)) {
			err(arg0, z094, 36, 0, 0, Local0, 2)
			return (1)
		}

		Store (DerefOf(arg1), Local1)
		CH03(ts, z094, 10, 0, 0)

		Store (DerefOf(DerefOf(arg1)), Local1)
		CH06(arg0, 37, 5)

		Store (Index(DerefOf(arg1), 0), Local1)
		CH03(ts, z094, 11, 0, 0)

		Store (Match(DerefOf(arg1), MTR, 0, MTR, 0, 0), Local1)
		CH06(arg0, 38, 47)

		return (0)
	}

	// Result of Method invocation
	Method(m006, 1, Serialized)
	{
		Name(i000, 0) // Label to check m000 invocations

		Method(m000, 1)
		{
			Store(arg0, i000)
			Store("3", Local0)
			Return (Local0)
		}

		Method(CH00, 2)
		{
			if (LNotEqual(i000, arg1)) {
				err(arg0, z094, 39, 0, 0, i000, arg1)
			}
		}

		Store (DerefOf(m000(1)), Local1)
		CH06(arg0, 40, 5)
		CH00(arg0, 1)

		Release(m000(2))
		CH06(arg0, 41, 47)
		if (y600) {
			CH00(arg0, 2)
		}

		Reset(m000(3))
		CH06(arg0, 42, 47)
		if (y600) {
			CH00(arg0, 3)
		}

		Signal(m000(4))
		CH06(arg0, 43, 47)
		if (y600) {
			CH00(arg0, 4)
		}

		Store(Acquire(m000(5), 0), Local1)
		CH06(arg0, 44, 47)
		if (y600) {
			CH00(arg0, 5)
		}

		CH03(ts, z094, 12, 0, 0)
		Store (Index(m000(6), 0), Local1)
		if (y900) {
			CH03(ts, z094, 12, 0, 0)
			CH00(arg0, 6)
		} else {
			CH04(ts, 0, 85, z094, 0x123, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
		}

		Store(Wait(m000(7), 0), Local1)
		CH06(arg0, 45, 47)
		if (y600) {
			CH00(arg0, 7)
		}

		Store (Match(m000(8), MTR, 0, MTR, 0, 0), Local1)
		CH06(arg0, 46, 47)
		CH00(arg0, 8)
	}

	// Reference to Object as Result of Method invocation
	Method(m007, 1, Serialized)
	{
		Name(s000, "3")

		Name(i000, 0) // Label to check m000 invocations

		Method(m000, 2)
		{
			Store(arg0, i000)
			if (LEqual(arg1, 0)) {
				Store(Refof(s100), Local0)
			} elseif (LEqual(arg1, 1)) {
				Store(Refof(s000), Local0)
			}
			Return (Local0)
		}

		Method(CH00, 2)
		{
			if (LNotEqual(i000, arg1)) {
				err(arg0, z094, 47, 0, 0, i000, arg1)
			}
		}

		Name(lpN0, 2)
		Name(lpC0, 0)

		While (lpN0) {
			Multiply(3, lpC0, Local0)

			Store(0, i000)

			Store (DerefOf(m000(1, lpC0)), Local1)
			CH03(ts, z094, Add(13, lpC0), 0, 0)
			CH00(arg0, 1)

			Store (DerefOf(DerefOf(m000(2, lpC0))), Local1)
			CH06(arg0, Add(48, Local0), 47)
			CH00(arg0, 2)

			Store (Index(DerefOf(m000(3, lpC0)), 0), Local1)
			CH06(arg0, Add(49, Local0), 47)
			CH00(arg0, 3)

			Store (Match(DerefOf(m000(4, lpC0)), MTR, 0, MTR, 0, 0), Local1)
			CH06(arg0, Add(50, Local0), 47)
			CH00(arg0, 4)

			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	CH03(ts, z094, 15, 0, 0)

	// Local Named Object
	m000(ts)

	// Global Named Object
	m001(ts)

	// Argument
	m002(ts, "2")

	// Local
	m003(ts)

	// An element of Package
	m004(ts)


	// Reference to Local Named Object

	m005(Concatenate(ts, "-m005-RefLocName"), RefOf(s000))

	Store(RefOf(s000), Local0)
	m005(Concatenate(ts, "-m005-RefLocName2"), Local0)

	CondRefOf(s000, Local0)
	m005(Concatenate(ts, "-m005-CondRefLocName"), Local0)

	m005(Concatenate(ts, "-m005-RefGlobName"), RefOf(s100))

	Store(RefOf(s100), Local0)
	m005(Concatenate(ts, "-m005-RefGlobName2"), Local0)

	CondRefOf(s100, Local0)
	m005(Concatenate(ts, "-m005-CondRefGlobName"), Local0)


	// Reference to Local

	Store("2", Local0)

	m005(Concatenate(ts, "-m005-RefLocal"), RefOf(Local0))

	Store(RefOf(Local0), Local1)
	m005(Concatenate(ts, "-m005-RefLocal2"), Local1)

	CondRefOf(Local0, Local1)
	m005(Concatenate(ts, "-m005-CondRefLocal"), Local1)


	// Reference to Arg

	m005(Concatenate(ts, "-m005-RefArg"), RefOf(arg0))

	Store(RefOf(arg0), Local0)
	m005(Concatenate(ts, "-m005-RefArg2"), Local0)

	CondRefOf(arg0, Local0)
	m005(Concatenate(ts, "-m005-CondRefArg"), Local0)


	// Index to Package

	Name(p000, Package(){"2"})

	if (y113) {
		m005(Concatenate(ts, "-m005-Index"), Index(p000, 0))
	}

	Store(Index(p000, 0), Local0)
	m005(Concatenate(ts, "-m005-Index2"), Local0)

	if (y113) {
		m005(Concatenate(ts, "-m005-Index3"), Index(p000, 0, Local0))
	}

	Index(p000, 0, Local0)
	m005(Concatenate(ts, "-m005-Index4"), Local0)

	Store(Index(p000, 0, Local0), Local1)
	m005(Concatenate(ts, "-m005-Index5"), Local1)

	// Result of Method invocation
	m006(ts)

	// Reference to Object as Result of Method invocation
	if (y500) {
		m007(ts)
	}
}
