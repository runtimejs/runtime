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
 *  Field Unit
 *
 * (verify exceptions caused by the imprope use of Field Unit type objects)
 */

Name(z097, 97)

OperationRegion(rg01, SystemMemory, 0x100, 0x100)

Field(rg01, ByteAcc, NoLock, Preserve) {
	fu00, 31,
	fu01, 65}

Name(ii70, 0xabcd1234)
Name(bi00, Buffer() {0xa4,0xa5,0xa6,0xa7,0xb8,0xb9,0xba,0xbb,0xbc})

// Expected exceptions:
//
// 47 - AE_AML_OPERAND_TYPE
// See notes to m4b1 and m4b3
//
Method(m4b5,, Serialized)
{
	Name(ts, "m4b5")

	Field(rg01, ByteAcc, NoLock, Preserve) {
		Offset(12),
		fu02, 31,
		fu03, 65}

	// Local Named Object
	Method(m000, 1, Serialized)
	{
		Field(rg01, ByteAcc, NoLock, Preserve) {
			Offset(24),
			fu02, 31,
			fu03, 65}

		Store(ii70, fu02)
		Store(bi00, fu03)

		// Like Integer behaviour

		if (y083) {
			Store (DerefOf(fu02), Local1)
			CH06(arg0, 0, 47)
		}

		Store (Index(fu02, 0), Local1)
		CH06(arg0, 1, 47)

		// Like Buffer behaviour

		if (y083) {
			Store (DerefOf(fu03), Local1)
			CH06(arg0, 2, 47)
		}

		Store (Index(fu03, 0), Local1)
		if (y900) {
			CH03(ts, z097, 0, 0, 0)
		} else {
			CH04(ts, 0, 85, z094, 0x123, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
		}
	}

	// Global Named Object
	Method(m001, 1)
	{
		Store(ii70, fu00)
		Store(bi00, fu01)

		// Like Integer behaviour

		if (y083) {
			Store (DerefOf(fu00), Local1)
			CH06(arg0, 3, 47)
		}

		Store (Index(fu00, 0), Local1)
		CH06(arg0, 4, 47)

		// Like Buffer behaviour

		if (y083) {
			Store (DerefOf(fu01), Local1)
			CH06(arg0, 5, 47)
		}

		Store (Index(fu01, 0), Local1)
		if (y900) {
			CH03(ts, z097, 1, 0, 0)
		} else {
			CH04(ts, 0, 85, z094, 0x123, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
		}
	}

	// Reference to Object
	Method(m002, 3)
	{
		Store(arg0, Debug)
		Store(arg1, Debug)

		Store(ObjectType(arg1), Local0)
		if (LNotEqual(Local0, 5)) {
			err(arg0, z097, 6, 0, 0, Local0, 5)
			return (1)
		}

		Store (DerefOf(arg1), Local1)
		CH03(ts, z097, 2, 0, 0)

		Store (DerefOf(DerefOf(arg1)), Local1)
		CH06(arg0, 7, 47)

		Store (Index(DerefOf(arg1), 0), Local1)

		if (arg2) {
			// Like Buffer behaviour
			if (y900) {
				CH03(ts, z097, 3, 0, 0)
			} else {
				CH04(ts, 0, 85, z097, 0x123, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
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
		Field(rg01, ByteAcc, NoLock, Preserve) {
			Offset(24),
			fu02, 31,
			fu03, 65}

		Name(i000, 0) // Label to check m000 invocations

		Method(m000, 2)
		{
			Store(arg0, i000)
			if (LEqual(arg1, 0)) {
				Store(Refof(fu00), Local0)
			} elseif (LEqual(arg1, 1)) {
				Store(Refof(fu01), Local0)
			} elseif (LEqual(arg1, 2)) {
				Store(Refof(fu02), Local0)
			} elseif (LEqual(arg1, 3)) {
				Store(Refof(fu03), Local0)
			}
			Return (Local0)
		}

		Method(CH00, 2)
		{
			if (LNotEqual(i000, arg1)) {
				err(arg0, z097, 10, 0, 0, i000, arg1)
			}
		}

		Name(lpN0, 4)
		Name(lpC0, 0)

		Store(ii70, fu00)
		Store(bi00, fu01)
		Store(ii70, fu02)
		Store(bi00, fu03)

		While (lpN0) {
			Multiply(3, lpC0, Local0)

			Store(0, i000)

			Store (DerefOf(m000(1, lpC0)), Local1)
			CH03(ts, z097, Add(4, lpC0), 0, 0)
			CH00(arg0, 1)


			Store (DerefOf(DerefOf(m000(2, lpC0))), Local1)
			CH06(arg0, Add(11, Local0), 47)
			CH00(arg0, 2)

			Store (Index(DerefOf(m000(3, lpC0)), 0), Local1)
			if (Mod(lpC0, 2)) {
				// Like Buffer behaviour
				if (y900) {
					CH03(ts, z097, Add(8, lpC0), 0, 0)
				} else {
					CH04(ts, 0, 85, z097, 0x123, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
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

	CH03(ts, z097, 12, 0, 0)

	// Local Named Object
	m000(ts)

	// Global Named Object
	m001(ts)

	// Reference to Local Named Object

	Store(ii70, fu02)
	Store(bi00, fu03)

	m002(Concatenate(ts, "-m002-RefLocNameI"), RefOf(fu02), 0)

	Store(RefOf(fu02), Local0)
	m002(Concatenate(ts, "-m002-RefLocName2I"), Local0, 0)

	CondRefOf(fu02, Local0)
	m002(Concatenate(ts, "-m002-CondRefLocNameI"), Local0, 0)

	m002(Concatenate(ts, "-m002-RefLocNameB"), RefOf(fu03), 1)

	Store(RefOf(fu03), Local0)
	m002(Concatenate(ts, "-m002-RefLocName2B"), Local0, 1)

	CondRefOf(fu03, Local0)
	m002(Concatenate(ts, "-m002-CondRefLocNameB"), Local0, 1)

	Store(ii70, fu00)
	Store(bi00, fu01)

	m002(Concatenate(ts, "-m002-RefGlobNameI"), RefOf(fu00), 0)

	Store(RefOf(fu00), Local0)
	m002(Concatenate(ts, "-m002-RefGlobName2I"), Local0, 0)

	CondRefOf(fu00, Local0)
	m002(Concatenate(ts, "-m002-CondRefGlobNameI"), Local0, 0)

	m002(Concatenate(ts, "-m002-RefGlobNameB"), RefOf(fu01), 1)

	Store(RefOf(fu01), Local0)
	m002(Concatenate(ts, "-m002-RefGlobName2B"), Local0, 1)

	CondRefOf(fu01, Local0)
	m002(Concatenate(ts, "-m002-CondRefGlobNameB"), Local0, 1)

	// Reference to Object as Result of Method invocation
	m003(ts)
}
