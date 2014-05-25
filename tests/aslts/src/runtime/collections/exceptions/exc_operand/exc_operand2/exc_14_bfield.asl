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
 *  Buffer Field
 *
 * (verify exceptions caused by the imprope use of Buffer Field type objects)
 */

Name(z106, 106)

Name(b700, Buffer(20) {})
CreateField(b700, 11, 31, bf20)
CreateField(b700, 58, 65, bf21)

Name(ii71, 0xabcd1234)
Name(bi01, Buffer() {0xa4,0xa5,0xa6,0xa7,0xb8,0xb9,0xba,0xbb,0xbc})

// Expected exceptions:
//
// 47 - AE_AML_OPERAND_TYPE
// See notes to m4b1 and m4b3
//
Method(m4be,, Serialized)
{
	Name(ts, "m4be")

	Name(bbf1, Buffer(20) {})
	CreateField(bbf1, 11, 31, bf02)
	CreateField(bbf1, 58, 65, bf03)

	// Local Named Object
	Method(m000, 1, Serialized)
	{
		Name(bbf1, Buffer(20) {})
		CreateField(bbf1, 11, 31, bf02)
		CreateField(bbf1, 58, 65, bf03)

		Store(ii71, bf02)
		Store(bi01, bf03)

		// Like Integer behaviour

		if (y083) {
			Store (DerefOf(bf02), Local1)
			CH06(arg0, 0, 47)
		}

		Store (Index(bf02, 0), Local1)
		CH06(arg0, 1, 47)

		// Like Buffer behaviour

		if (y083) {
			Store (DerefOf(bf03), Local1)
			CH06(arg0, 2, 47)
		}

		Store (Index(bf03, 0), Local1)
		if (y900) {
			CH03(ts, z106, 0, 0, 0)
		} else {
			CH04(ts, 0, 85, z106, 0x123, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
		}
	}

	// Global Named Object
	Method(m001, 1)
	{
		Store(ii71, bf20)
		Store(bi01, bf21)

		// Like Integer behaviour

		if (y083) {
			Store (DerefOf(bf20), Local1)
			CH06(arg0, 3, 47)
		}

		Store (Index(bf20, 0), Local1)
		CH06(arg0, 4, 47)

		// Like Buffer behaviour

		if (y083) {
			Store (DerefOf(bf21), Local1)
			CH06(arg0, 5, 47)
		}

		Store (Index(bf21, 0), Local1)
		if (y900) {
			CH03(ts, z106, 1, 0, 0)
		} else {
			CH04(ts, 0, 85, z106, 0x123, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
		}

	}

	// Reference to Object
	Method(m002, 3)
	{
		Store(arg0, Debug)
		Store(arg1, Debug)

		Store(ObjectType(arg1), Local0)
		if (LNotEqual(Local0, 14)) {
			err(arg0, z106, 6, 0, 0, Local0, 14)
			return (1)
		}

		Store (DerefOf(arg1), Local1)
		CH03(ts, z106, 2, 0, 0)

		Store (DerefOf(DerefOf(arg1)), Local1)
		CH06(arg0, 7, 47)

		Store (Index(DerefOf(arg1), 0), Local1)

		if (arg2) {
			// Like Buffer behaviour
			if (y900) {
				CH03(ts, z106, 3, 0, 0)
			} else {
				CH04(ts, 0, 85, z106, 0x123, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
			}
		} else {
			// Like Integer behaviour
			CH06(arg0, 8, 47)
		}

		Store (Match(DerefOf(arg1), MTR, 0, MTR, 0, 0), Local1)
		CH06(arg0, 9, 47)

		return (0)
	}

	// Reference to Object as Result of Method invocation
	Method(m003, 1, Serialized)
	{
		Name(bbf1, Buffer(20) {})
		CreateField(bbf1, 11, 31, bf02)
		CreateField(bbf1, 58, 65, bf03)

		Name(i000, 0) // Label to check m000 invocations

		Method(m000, 2)
		{
			Store(arg0, i000)
			if (LEqual(arg1, 0)) {
				Store(Refof(bf20), Local0)
			} elseif (LEqual(arg1, 1)) {
				Store(Refof(bf21), Local0)
			} elseif (LEqual(arg1, 2)) {
				Store(Refof(bf02), Local0)
			} elseif (LEqual(arg1, 3)) {
				Store(Refof(bf03), Local0)
			}
			Return (Local0)
		}

		Method(CH00, 2)
		{
			if (LNotEqual(i000, arg1)) {
				err(arg0, z106, 10, 0, 0, i000, arg1)
			}
		}

		Name(lpN0, 4)
		Name(lpC0, 0)

		Store(ii71, bf20)
		Store(bi01, bf21)
		Store(ii71, bf02)
		Store(bi01, bf03)

		While (lpN0) {
			Multiply(3, lpC0, Local0)

			Store(0, i000)

			Store (DerefOf(m000(1, lpC0)), Local1)
			CH03(ts, z106, Add(4, lpC0), 0, 0)
			CH00(arg0, 1)


			Store (DerefOf(DerefOf(m000(2, lpC0))), Local1)
			CH06(arg0, Add(11, Local0), 47)
			CH00(arg0, 2)

			Store (Index(DerefOf(m000(3, lpC0)), 0), Local1)
			if (Mod(lpC0, 2)) {
				// Like Buffer behaviour
				if (y900) {
					CH03(ts, z106, Add(8, lpC0), 0, 0)
				} else {
					CH04(ts, 0, 85, z106, 0x123, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
				}
			} else {
				// Like Integer behaviour
				CH06(arg0, Add(12, Local0), 47)
			}
			CH00(arg0, 3)

			Store (Match(DerefOf(m000(4, lpC0)), MTR, 0, MTR, 0, 0), Local1)
			CH06(arg0, Add(13, Local0), 47)
			CH00(arg0, 4)

			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	CH03(ts, z106, 12, 0, 0)

	// Local Named Object
	m000(ts)

	// Global Named Object
	m001(ts)

	// Reference to Local Named Object

	Store(ii71, bf02)
	Store(bi01, bf03)

	m002(Concatenate(ts, "-m002-RefLocNameI"), RefOf(bf02), 0)

	Store(RefOf(bf02), Local0)
	m002(Concatenate(ts, "-m002-RefLocName2I"), Local0, 0)

	CondRefOf(bf02, Local0)
	m002(Concatenate(ts, "-m002-CondRefLocNameI"), Local0, 0)

	m002(Concatenate(ts, "-m002-RefLocNameB"), RefOf(bf03), 1)

	Store(RefOf(bf03), Local0)
	m002(Concatenate(ts, "-m002-RefLocName2B"), Local0, 1)

	CondRefOf(bf03, Local0)
	m002(Concatenate(ts, "-m002-CondRefLocNameB"), Local0, 1)

	Store(ii71, bf20)
	Store(bi01, bf21)

	m002(Concatenate(ts, "-m002-RefGlobNameI"), RefOf(bf20), 0)

	Store(RefOf(bf20), Local0)
	m002(Concatenate(ts, "-m002-RefGlobName2I"), Local0, 0)

	CondRefOf(bf20, Local0)
	m002(Concatenate(ts, "-m002-CondRefGlobNameI"), Local0, 0)

	m002(Concatenate(ts, "-m002-RefGlobNameB"), RefOf(bf21), 1)

	Store(RefOf(bf21), Local0)
	m002(Concatenate(ts, "-m002-RefGlobName2B"), Local0, 1)

	CondRefOf(bf21, Local0)
	m002(Concatenate(ts, "-m002-CondRefGlobNameB"), Local0, 1)

	// Reference to Object as Result of Method invocation
	m003(ts)
}
