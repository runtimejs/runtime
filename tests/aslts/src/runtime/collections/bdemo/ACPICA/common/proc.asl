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
 * Common use Methods
 */

/*
 * Verification of Package
 *
 * arg0 - Package
 * arg1 - size of Package
 * arg2 - size of pre-initialized area
 * arg3 - index of area to be written
 * arg4 - size of area to be written
 * arg5 - maximal number of pre-initialized elements to be verified
 * arg6 - maximal number of written elements to be verified
 */
Method(md6a, 7, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)


	// Writing

	if (arg4) {
		Store(arg4, lpN0)
		Store(arg3, lpC0)

		While (lpN0) {
			TRC0(arg0, lpC0, lpC0)
			Store(lpC0, Index(arg0, lpC0))
			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	// Verifying pre-initialized area

	if (LAnd(arg2, arg5)) {
		if (LLess(arg2, arg5)) {
			Store(arg2, arg5)
		}
		Store(arg5, lpN0)
		Store(0, lpC0)

		While (lpN0) {
			Store(DerefOf(Index(arg0, lpC0)), Local0)
			TRC1(arg0, lpC0, Local0)
			if (LNotEqual(Local0, lpC0)) {
				err("", zFFF, 0x000, 0, 0, Local0, lpC0)
			}
			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	if (arg2) {
		// First pre-initialized element
		Store(DerefOf(Index(arg0, 0)), Local0)
		TRC1(arg0, 0, Local0)
		if (LNotEqual(Local0, 0)) {
			err("", zFFF, 0x001, 0, 0, Local0, 0)
		}

		// Last pre-initialized element
		Subtract(arg2, 1, Local0)
		Store(DerefOf(Index(arg0, Local0)), Local1)
		TRC1(arg0, Local0, Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x002, 0, 0, Local1, Local0)
		}

		// Middle pre-initialized element
		Divide(arg2, 2, Local1, Local0)
		Store(DerefOf(Index(arg0, Local0)), Local1)
		TRC1(arg0, Local0, Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x003, 0, 0, Local1, Local0)
		}
	}

	// Verifying written area

	if (LAnd(arg4, arg6)) {
		if (LLess(arg4, arg6)) {
			Store(arg4, arg6)
		}
		Store(arg6, lpN0)
		Store(arg3, lpC0)

		While (lpN0) {
			Store(DerefOf(Index(arg0, lpC0)), Local0)
			TRC1(arg0, lpC0, Local0)
			if (LNotEqual(Local0, lpC0)) {
				err("", zFFF, 0x004, 0, 0, Local0, lpC0)
			}
			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	if (arg4) {
		// First written element
		Store(DerefOf(Index(arg0, arg3)), Local0)
		TRC1(arg0, arg3, Local0)
		if (LNotEqual(Local0, arg3)) {
			err("", zFFF, 0x005, 0, 0, Local0, arg3)
		}

		// Last written element
		Add(arg3, arg4, Local0)
		Decrement(Local0)
		Store(DerefOf(Index(arg0, Local0)), Local1)
		TRC1(arg0, Local0, Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x006, 0, 0, Local1, Local0)
		}

		// Middle written element
		Divide(arg4, 2, Local0, Local1)
		Add(arg3, Local1, Local0)
		Store(DerefOf(Index(arg0, Local0)), Local1)
		TRC1(arg0, Local0, Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x007, 0, 0, Local1, Local0)
		}
	}

	// Check exception on access to the uninitialized element

	if (LLess(arg2, arg1)) {
		if (arg4) {
			if (LGreater(arg3, arg2)) {

				// Just after pre-initialized area

				TRC1(arg0, arg2, 0xf0f0f0f0)
				Store(Index(arg0, arg2), Local0)
				CH03("", 0, 0x100, 0, 0)
				Store(DerefOf(Local0), Local1)
				CH04("", 1, 51, 0, 0x101, 0, 0) // AE_AML_UNINITIALIZED_ELEMENT

				// Just before written area

				Subtract(arg3, 1, Local1)
				TRC1(arg0, Local1, 0xf0f0f0f0)
				Store(Index(arg0, Local1), Local0)
				CH03("", 0, 0x102, 0, 0)
				Store(DerefOf(Local0), Local1)
				CH04("", 1, 51, 0, 0x103, 0, 0) // AE_AML_UNINITIALIZED_ELEMENT
			}

			// Just after pre-initialized and written areas

			Add(arg3, arg4, Local7)
			if (LGreater(arg2, Local7)) {
				Store(arg2, Local7)
			}

			if (LLess(Local7, arg1)) {
				TRC1(arg0, Local7, 0xf0f0f0f0)
				Store(Index(arg0, Local7), Local0)
				CH03("", 0, 0x104, 0, 0)
				Store(DerefOf(Local0), Local1)
				CH04("", 1, 51, 0, 0x105, 0, 0) // AE_AML_UNINITIALIZED_ELEMENT

				// Last element of Package

				Subtract(arg1, 1, Local1)
				TRC1(arg0, Local1, 0xf0f0f0f0)
				Store(Index(arg0, Local1), Local0)
				CH03("", 0, 0x106, 0, 0)
				Store(DerefOf(Local0), Local1)
				CH04("", 1, 51, 0, 0x107, 0, 0) // AE_AML_UNINITIALIZED_ELEMENT
			}
		} else {
			// Just after pre-initialized area

			TRC1(arg0, arg2, 0xf0f0f0f0)
			Store(Index(arg0, arg2), Local0)
			CH03("", 0, 0x108, 0, 0)
			Store(DerefOf(Local0), Local1)
			CH04("", 1, 51, 0, 0x109, 0, 0) // AE_AML_UNINITIALIZED_ELEMENT

			// Last element of Package

			Subtract(arg1, 1, Local1)
			TRC1(arg0, Local1, 0xf0f0f0f0)
			Store(Index(arg0, Local1), Local0)
			CH03("", 0, 0x10a, 0, 0)
			Store(DerefOf(Local0), Local1)
			CH04("", 1, 51, 0, 0x10b, 0, 0) // AE_AML_UNINITIALIZED_ELEMENT
		}
	}

	// Check exception on out of Package access

	TRC1(arg0, arg1, 0xf0f0f0f0)
	CH03("", 0, 0x10c, 0, 0)
	Index(arg0, arg1, Local0)
	CH04("", 0, 55, 0, 0x10d, 0, 0) // AE_AML_PACKAGE_LIMIT

	Add(arg1, 1, Local7)
	if (LGreaterEqual(Local7, arg1)) {
		TRC1(arg0, Local7, 0xf0f0f0f0)
		CH03("", 0, 0x10e, 0, 0)
		Index(arg0, Local7, Local0)
		CH04("", 0, 55, 0, 0x10f, 0, 0) // AE_AML_PACKAGE_LIMIT
	}

	if (LGreaterEqual(0xffffffffffffffff, arg1)) {
		TRC1(arg0, 0xffffffffffffffff, 0xf0f0f0f0)
		CH03("", 0, 0x110, 0, 0)
		Index(arg0, 0xffffffffffffffff, Local0)
		CH04("", 0, 55, 0, 0x111, 0, 0) // AE_AML_PACKAGE_LIMIT
	}

	// Check near the maximal bound of a simple Package
	// (not VarPackage) - 254, 255, 256, 257 elements:

	md6b(arg0, arg1,  arg2, arg3, arg4, 254)
	md6b(arg0, arg1,  arg2, arg3, arg4, 255)
	md6b(arg0, arg1,  arg2, arg3, arg4, 256)
	md6b(arg0, arg1,  arg2, arg3, arg4, 257)

	TRC2("The test run up to the end")
}

/*
 * Verification of Package
 *
 * arg0 - Package
 * arg1 - size of Package
 * arg2 - size of pre-initialized area
 * arg3 - index of area to be written
 * arg4 - size of area to be written
 * arg5 - index of element of Package to be verified
 */
Method(md6b, 6)
{
	Store(0, Local7)

	if (LLess(arg5, arg2)) {
		Store(1, Local7)
	} elseif (LGreaterEqual(arg5, arg3)) {
		Add(arg3, arg4, Local0)
		if (LLess(arg5, Local0)) {
			Store(1, Local7)
		}
	}

	if (Local7) {

		// Was initialized

		CH03("", 0, 0x112, 0, 0)
		Store(DerefOf(Index(arg0, arg5)), Local0)
		TRC1(arg0, arg5, Local0)
		if (LNotEqual(Local0, arg5)) {
			err("", zFFF, 0x008, 0, 0, Local0, arg5)
		}
		CH03("", 0, 0x113, 0, 0)

	} elseif (LLess(arg5, arg1)) {

		// Check exception on access to the uninitialized element

		TRC1(arg0, arg5, 0xf0f0f0f0)
		Store(Index(arg0, arg5), Local0)
		CH03("", 0, 0x114, 0, 0)
		Store(DerefOf(Local0), Local1)
		CH04("", 1, 51, 0, 0x115, 0, 0) // AE_AML_UNINITIALIZED_ELEMENT

	} else {

		// Check exception on out of Package access

		TRC1(arg0, arg5, 0xf0f0f0f0)
		CH03("", 0, 0x116, 0, 0)
		Index(arg0, arg5, Local0)
		CH04("", 0, 55, 0, 0x117, 0, 0) // AE_AML_PACKAGE_LIMIT

	}
}

/*
 * Check, register errors and reset the global level
 * execution exception AE_AML_DIVIDE_BY_ZERO caused in
 * demo-test of bug 162.
 */
Method(md7d)
{
	Store(0, id01)
	Store(ERRS, Local0)

	/*
	 * Slacken expectations:
	 *
	 * - check opcode of the FIRST exception
	 * - number of exceptions NOT GREATER than two
	 */

	/* Check opcode of the first exception */
	CH04("", 1, 56, 0, 0x118, 0, 0) // AE_AML_DIVIDE_BY_ZERO

	/* Number of exceptions not greater than two */
	if (LGreater(EXC1, 2)) {
		Store(1, id01)
	}

	/* Reset the number of exceptions */
	Store(0, EXC1)

	if (LNotEqual(ERRS, Local0)) {
		Store(1, id01)
	}

	CH03("", 0, 0x119, 0, 0)
	return (1)
}

/*
 * Check result
 * arg0 - result
 * arg1 - expected type of result
 * arg2 - expected result
 * arg3 - index of checking
 * arg4 - index of checking
 * arg5 - tag, to check the value of object
 */
Method(mf88, 6)
{
	Store(ObjectType(arg0), Local0)

	if (LNotEqual(Local0, arg1)) {
		err("", zFFF, arg3, 0, 0, Local0, arg1)
	}
	if (arg5) {
		if (LNotEqual(arg0, arg2)) {
			err("", zFFF, arg4, 0, 0, arg0, arg2)
		}
	}
}

Method(m02a)
{
	Store("Check the error manually and remove call to m02a() when the bug is fixed.", Debug)

	err("", zFFF, 0x800, 0, 0, 0, 0)
}
