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
 * Check implicit conversion being applied to ArgX Object
 */

Name(z121, 121)

Method(m617,, Serialized)
{
	Name(ts, "m617")

	// Integer to String implicit conversion Cases.

	// Integer to String conversion of the Integer second operand of
	// Logical operators when the first operand is evaluated as String.
	// LEqual LGreater LGreaterEqual LLess LLessEqual LNotEqual

	Method(m640, 2)
	{
		// LEqual

		Store(LEqual("FE7CB391D650A284", arg1), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual("fE7CB391D650A284", arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aus4, arg1), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(aus5, arg1), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aus4)), arg1), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(aus5)), arg1), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paus, 4)), arg1), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paus, 5)), arg1), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns String

		Store(LEqual(m601(2, 4), arg1), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(2, 5), arg1), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LEqual(Derefof(m602(2, 4, 1)), arg1), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(2, 5, 1)), arg1), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater("FE7CB391D650A284", arg1), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater("fE7CB391D650A284", arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater("FE7CB391D650A28 ", arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater("FE7CB391D650A284q", arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aus4, arg1), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(aus5, arg1), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aus4)), arg1), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(aus5)), arg1), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paus, 4)), arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paus, 5)), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns String

		Store(LGreater(m601(2, 4), arg1), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(2, 5), arg1), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LGreater(Derefof(m602(2, 4, 1)), arg1), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(2, 5, 1)), arg1), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual("FE7CB391D650A284", arg1), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual("fE7CB391D650A284", arg1), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual("FE7CB391D650A28 ", arg1), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual("FE7CB391D650A284q", arg1), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aus4, arg1), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(aus5, arg1), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aus4)), arg1), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(aus5)), arg1), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paus, 4)), arg1), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paus, 5)), arg1), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns String

		Store(LGreaterEqual(m601(2, 4), arg1), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(2, 5), arg1), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(2, 4, 1)), arg1), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(2, 5, 1)), arg1), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess("FE7CB391D650A284", arg1), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess("fE7CB391D650A284", arg1), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess("FE7CB391D650A28 ", arg1), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess("FE7CB391D650A284q", arg1), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aus4, arg1), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(aus5, arg1), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aus4)), arg1), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(aus5)), arg1), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paus, 4)), arg1), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paus, 5)), arg1), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns String

		Store(LLess(m601(2, 4), arg1), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(2, 5), arg1), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LLess(Derefof(m602(2, 4, 1)), arg1), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(2, 5, 1)), arg1), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual("FE7CB391D650A284", arg1), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual("fE7CB391D650A284", arg1), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual("FE7CB391D650A28 ", arg1), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual("FE7CB391D650A284q", arg1), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aus4, arg1), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(aus5, arg1), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aus4)), arg1), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(aus5)), arg1), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paus, 4)), arg1), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paus, 5)), arg1), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns String

		Store(LLessEqual(m601(2, 4), arg1), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(2, 5), arg1), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LLessEqual(Derefof(m602(2, 4, 1)), arg1), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(2, 5, 1)), arg1), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual("FE7CB391D650A284", arg1), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual("fE7CB391D650A284", arg1), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual("FE7CB391D650A28 ", arg1), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual("FE7CB391D650A284q", arg1), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aus4, arg1), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(aus5, arg1), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aus4)), arg1), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(aus5)), arg1), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paus, 4)), arg1), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paus, 5)), arg1), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns String

		Store(LNotEqual(m601(2, 4), arg1), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(2, 5), arg1), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LNotEqual(Derefof(m602(2, 4, 1)), arg1), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(2, 5, 1)), arg1), Local0)
			m600(arg0, 81, Local0, Ones)
		}
	}

	Method(m320, 2)
	{
		// LEqual

		Store(LEqual("C179B3FE", arg1), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual("c179B3FE", arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aus3, arg1), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(aus2, arg1), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aus3)), arg1), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(aus2)), arg1), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paus, 3)), arg1), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paus, 2)), arg1), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns String

		Store(LEqual(m601(2, 3), arg1), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(2, 2), arg1), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LEqual(Derefof(m602(2, 3, 1)), arg1), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(2, 2, 1)), arg1), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater("C179B3FE", arg1), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater("c179B3FE", arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater("C179B3F ", arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater("C179B3FEq", arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aus3, arg1), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(aus2, arg1), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aus3)), arg1), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(aus2)), arg1), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paus, 3)), arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paus, 2)), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns String

		Store(LGreater(m601(2, 3), arg1), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(2, 2), arg1), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LGreater(Derefof(m602(2, 3, 1)), arg1), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(2, 2, 1)), arg1), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual("C179B3FE", arg1), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual("c179B3FE", arg1), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual("C179B3F ", arg1), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual("C179B3FEq", arg1), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aus3, arg1), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(aus2, arg1), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aus3)), arg1), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(aus2)), arg1), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paus, 3)), arg1), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paus, 2)), arg1), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns String

		Store(LGreaterEqual(m601(2, 3), arg1), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(2, 2), arg1), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(2, 3, 1)), arg1), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(2, 2, 1)), arg1), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess("C179B3FE", arg1), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess("c179B3FE", arg1), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess("C179B3F ", arg1), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess("C179B3FEq", arg1), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aus3, arg1), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(aus2, arg1), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aus3)), arg1), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(aus2)), arg1), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paus, 3)), arg1), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paus, 2)), arg1), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns String

		Store(LLess(m601(2, 3), arg1), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(2, 2), arg1), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LLess(Derefof(m602(2, 3, 1)), arg1), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(2, 2, 1)), arg1), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual("C179B3FE", arg1), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual("c179B3FE", arg1), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual("C179B3F ", arg1), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual("C179B3FEq", arg1), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aus3, arg1), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(aus2, arg1), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aus3)), arg1), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(aus2)), arg1), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paus, 3)), arg1), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paus, 2)), arg1), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns String

		Store(LLessEqual(m601(2, 3), arg1), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(2, 2), arg1), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LLessEqual(Derefof(m602(2, 3, 1)), arg1), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(2, 2, 1)), arg1), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual("C179B3FE", arg1), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual("c179B3FE", arg1), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual("C179B3F ", arg1), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual("C179B3FEq", arg1), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aus3, arg1), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(aus2, arg1), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aus3)), arg1), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(aus2)), arg1), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paus, 3)), arg1), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paus, 2)), arg1), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns String

		Store(LNotEqual(m601(2, 3), arg1), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(2, 2), arg1), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LNotEqual(Derefof(m602(2, 3, 1)), arg1), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(2, 2, 1)), arg1), Local0)
			m600(arg0, 81, Local0, Ones)
		}
	}

	// Integer to String conversion of the Integer second operand of
	// Concatenate operator when the first operand is evaluated as String

	Method(m641, 2)
	{		
		Store(Concatenate("", arg1), Local0)
		m600(arg0, 0, Local0, bs10)

		Store(Concatenate("1234q", arg1), Local0)
		m600(arg0, 1, Local0, bs11)

		Store(Concatenate(aus0, arg1), Local0)
		m600(arg0, 2, Local0, bs10)

		Store(Concatenate(aus1, arg1), Local0)
		m600(arg0, 3, Local0, bs11)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aus0)), arg1), Local0)
			m600(arg0, 4, Local0, bs10)

			Store(Concatenate(Derefof(Refof(aus1)), arg1), Local0)
			m600(arg0, 5, Local0, bs11)
		}

		Store(Concatenate(Derefof(Index(paus, 0)), arg1), Local0)
		m600(arg0, 6, Local0, bs10)

		Store(Concatenate(Derefof(Index(paus, 1)), arg1), Local0)
		m600(arg0, 7, Local0, bs11)

		// Method returns String

		Store(Concatenate(m601(2, 0), arg1), Local0)
		m600(arg0, 8, Local0, bs10)

		Store(Concatenate(m601(2, 1), arg1), Local0)
		m600(arg0, 9, Local0, bs11)

		// Method returns Reference to String

		if (y500) {
			Store(Concatenate(Derefof(m602(2, 0, 1)), arg1), Local0)
			m600(arg0, 10, Local0, bs10)

			Store(Concatenate(Derefof(m602(2, 1, 1)), arg1), Local0)
			m600(arg0, 11, Local0, bs11)
		}

		Concatenate("", arg1, Local0)
		m600(arg0, 12, Local0, bs10)

		Concatenate("1234q", arg1, Local0)
		m600(arg0, 13, Local0, bs11)

		Concatenate(aus0, arg1, Local0)
		m600(arg0, 14, Local0, bs10)

		Concatenate(aus1, arg1, Local0)
		m600(arg0, 15, Local0, bs11)

		if (y078) {
			Concatenate(Derefof(Refof(aus0)), arg1, Local0)
			m600(arg0, 16, Local0, bs10)

			Concatenate(Derefof(Refof(aus1)), arg1, Local0)
			m600(arg0, 17, Local0, bs11)
		}

		Concatenate(Derefof(Index(paus, 0)), arg1, Local0)
		m600(arg0, 18, Local0, bs10)

		Concatenate(Derefof(Index(paus, 1)), arg1, Local0)
		m600(arg0, 19, Local0, bs11)

		// Method returns String

		Concatenate(m601(2, 0), arg1, Local0)
		m600(arg0, 20, Local0, bs10)

		Concatenate(m601(2, 1), arg1, Local0)
		m600(arg0, 21, Local0, bs11)

		// Method returns Reference to String

		if (y500) {
			Concatenate(Derefof(m602(2, 0, 1)), arg1, Local0)
			m600(arg0, 22, Local0, bs10)

			Concatenate(Derefof(m602(2, 1, 1)), arg1, Local0)
			m600(arg0, 23, Local0, bs11)
		}
	}

	Method(m321, 3)
	{		
		Store(Concatenate("", arg2), Local0)
		m600(arg0, 0, Local0, bs12)

		Store(Concatenate("1234q", arg2), Local0)
		m600(arg0, 1, Local0, bs13)

		Store(Concatenate(aus0, arg2), Local0)
		m600(arg0, 2, Local0, bs12)

		Store(Concatenate(aus1, arg2), Local0)
		m600(arg0, 3, Local0, bs13)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aus0)), arg2), Local0)
			m600(arg0, 4, Local0, bs12)

			Store(Concatenate(Derefof(Refof(aus1)), arg2), Local0)
			m600(arg0, 5, Local0, bs13)
		}

		Store(Concatenate(Derefof(Index(paus, 0)), arg2), Local0)
		m600(arg0, 6, Local0, bs12)

		Store(Concatenate(Derefof(Index(paus, 1)), arg2), Local0)
		m600(arg0, 7, Local0, bs13)

		// Method returns String

		Store(Concatenate(m601(2, 0), arg2), Local0)
		m600(arg0, 8, Local0, bs12)

		Store(Concatenate(m601(2, 1), arg2), Local0)
		m600(arg0, 9, Local0, bs13)

		// Method returns Reference to String

		if (y500) {
			Store(Concatenate(Derefof(m602(2, 0, 1)), arg2), Local0)
			m600(arg0, 10, Local0, bs12)

			Store(Concatenate(Derefof(m602(2, 1, 1)), arg2), Local0)
			m600(arg0, 11, Local0, bs13)
		}

		Store(Concatenate("", arg1), Local0)
		m600(arg0, 12, Local0, bs14)

		Store(Concatenate("1234q", arg1), Local0)
		m600(arg0, 13, Local0, bs15)

		Concatenate("", arg2, Local0)
		m600(arg0, 14, Local0, bs12)

		Concatenate("1234q", arg2, Local0)
		m600(arg0, 15, Local0, bs13)

		Concatenate(aus0, arg2, Local0)
		m600(arg0, 16, Local0, bs12)

		Concatenate(aus1, arg2, Local0)
		m600(arg0, 17, Local0, bs13)

		if (y078) {
			Concatenate(Derefof(Refof(aus0)), arg2, Local0)
			m600(arg0, 18, Local0, bs12)

			Concatenate(Derefof(Refof(aus1)), arg2, Local0)
			m600(arg0, 19, Local0, bs13)
		}

		Concatenate(Derefof(Index(paus, 0)), arg2, Local0)
		m600(arg0, 20, Local0, bs12)

		Concatenate(Derefof(Index(paus, 1)), arg2, Local0)
		m600(arg0, 21, Local0, bs13)

		// Method returns String

		Concatenate(m601(2, 0), arg2, Local0)
		m600(arg0, 22, Local0, bs12)

		Concatenate(m601(2, 1), arg2, Local0)
		m600(arg0, 23, Local0, bs13)

		// Method returns Reference to String

		if (y500) {
			Concatenate(Derefof(m602(2, 0, 1)), arg2, Local0)
			m600(arg0, 24, Local0, bs12)

			Concatenate(Derefof(m602(2, 1, 1)), arg2, Local0)
			m600(arg0, 25, Local0, bs13)
		}

		Concatenate("", arg1, Local0)
		m600(arg0, 26, Local0, bs14)

		Concatenate("1234q", arg1, Local0)
		m600(arg0, 27, Local0, bs15)
	}

//	Method(m642, 1)
	
//	Method(m322, 1)

//	Method(m643, 1)

//	Method(m323, 1)

	// Integer to Buffer implicit conversion Cases.

	// Integer to Buffer conversion of the Integer second operand of
	// Logical operators when the first operand is evaluated as Buffer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)

	Method(m644, 2)
	{		
		// LEqual

		Store(LEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, arg1), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aub4, arg1), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(aub3, arg1), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aub4)), arg1), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(aub3)), arg1), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paub, 4)), arg1), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paub, 3)), arg1), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns Buffer

		Store(LEqual(m601(3, 4), arg1), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(3, 3), arg1), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LEqual(Derefof(m602(3, 4, 1)), arg1), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(3, 3, 1)), arg1), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, arg1), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aub4, arg1), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(aub5, arg1), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aub4)), arg1), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(aub5)), arg1), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paub, 4)), arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paub, 5)), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Buffer

		Store(LGreater(m601(3, 4), arg1), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(3, 5), arg1), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreater(Derefof(m602(3, 4, 1)), arg1), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(3, 5, 1)), arg1), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, arg1), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, arg1), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, arg1), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, arg1), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aub4, arg1), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(aub5, arg1), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aub4)), arg1), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(aub5)), arg1), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paub, 4)), arg1), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paub, 5)), arg1), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns Buffer

		Store(LGreaterEqual(m601(3, 4), arg1), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(3, 5), arg1), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(3, 4, 1)), arg1), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(3, 5, 1)), arg1), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, arg1), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, arg1), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, arg1), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, arg1), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aub4, arg1), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(aub5, arg1), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aub4)), arg1), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(aub5)), arg1), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paub, 4)), arg1), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paub, 5)), arg1), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns Buffer

		Store(LLess(m601(3, 4), arg1), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(3, 5), arg1), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLess(Derefof(m602(3, 4, 1)), arg1), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(3, 5, 1)), arg1), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, arg1), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, arg1), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, arg1), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, arg1), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aub4, arg1), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(aub5, arg1), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aub4)), arg1), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(aub5)), arg1), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paub, 4)), arg1), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paub, 5)), arg1), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns Buffer

		Store(LLessEqual(m601(3, 4), arg1), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(3, 5), arg1), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLessEqual(Derefof(m602(3, 4, 1)), arg1), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(3, 5, 1)), arg1), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, arg1), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, arg1), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, arg1), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, arg1), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aub4, arg1), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(aub5, arg1), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aub4)), arg1), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(aub5)), arg1), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paub, 4)), arg1), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paub, 5)), arg1), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns Buffer

		Store(LNotEqual(m601(3, 4), arg1), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(3, 5), arg1), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LNotEqual(Derefof(m602(3, 4, 1)), arg1), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(3, 5, 1)), arg1), Local0)
			m600(arg0, 81, Local0, Ones)
		}
	}
	
	Method(m324, 2)
	{
		// LEqual

		Store(LEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, arg1), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aub3, arg1), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(aub2, arg1), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aub3)), arg1), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(aub2)), arg1), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paub, 3)), arg1), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paub, 2)), arg1), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns Buffer

		Store(LEqual(m601(3, 3), arg1), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(3, 2), arg1), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LEqual(Derefof(m602(3, 3, 1)), arg1), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(3, 2, 1)), arg1), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, arg1), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aub3, arg1), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(aub2, arg1), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aub3)), arg1), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(aub2)), arg1), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paub, 3)), arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paub, 2)), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Buffer

		Store(LGreater(m601(3, 3), arg1), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(3, 2), arg1), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreater(Derefof(m602(3, 3, 1)), arg1), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(3, 2, 1)), arg1), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, arg1), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, arg1), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, arg1), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, arg1), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aub3, arg1), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(aub2, arg1), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aub3)), arg1), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(aub2)), arg1), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paub, 3)), arg1), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paub, 2)), arg1), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns Buffer

		Store(LGreaterEqual(m601(3, 3), arg1), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(3, 2), arg1), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(3, 3, 1)), arg1), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(3, 2, 1)), arg1), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, arg1), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, arg1), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, arg1), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, arg1), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aub3, arg1), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(aub2, arg1), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aub3)), arg1), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(aub2)), arg1), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paub, 3)), arg1), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paub, 2)), arg1), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns Buffer

		Store(LLess(m601(3, 3), arg1), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(3, 2), arg1), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLess(Derefof(m602(3, 3, 1)), arg1), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(3, 2, 1)), arg1), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, arg1), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, arg1), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, arg1), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, arg1), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aub3, arg1), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(aub2, arg1), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aub3)), arg1), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(aub2)), arg1), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paub, 3)), arg1), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paub, 2)), arg1), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns Buffer

		Store(LLessEqual(m601(3, 3), arg1), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(3, 2), arg1), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLessEqual(Derefof(m602(3, 3, 1)), arg1), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(3, 2, 1)), arg1), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, arg1), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, arg1), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, arg1), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, arg1), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aub3, arg1), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(aub2, arg1), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aub3)), arg1), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(aub2)), arg1), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paub, 3)), arg1), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paub, 2)), arg1), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns Buffer

		Store(LNotEqual(m601(3, 3), arg1), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(3, 2), arg1), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LNotEqual(Derefof(m602(3, 3, 1)), arg1), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(3, 2, 1)), arg1), Local0)
			m600(arg0, 81, Local0, Ones)
		}
	}


	// Integer to Buffer conversion of the both Integer operands of
	// Concatenate operator

	Method(m645, 2)
	{		
		Store(Concatenate(arg1, arg1), Local0)
		m600(arg0, 0, Local0, bb20)

		Store(Concatenate(0x321, arg1), Local0)
		m600(arg0, 1, Local0, bb21)

		Store(Concatenate(arg1, 0x321), Local0)
		m600(arg0, 1, Local0, bb22)

		Concatenate(arg1, arg1, Local0)
		m600(arg0, 0, Local0, bb20)

		Concatenate(0x321, arg1, Local0)
		m600(arg0, 1, Local0, bb21)

		Concatenate(arg1, 0x321, Local0)
		m600(arg0, 1, Local0, bb22)
	}

	Method(m325, 2)
	{		
		Store(Concatenate(arg1, arg1), Local0)
		m600(arg0, 0, Local0, bb23)

		Store(Concatenate(0x321, arg1), Local0)
		m600(arg0, 1, Local0, bb24)

		Store(Concatenate(arg1, 0x321), Local0)
		m600(arg0, 1, Local0, bb25)

		Concatenate(arg1, arg1, Local0)
		m600(arg0, 0, Local0, bb23)

		Concatenate(0x321, arg1, Local0)
		m600(arg0, 1, Local0, bb24)

		Concatenate(arg1, 0x321, Local0)
		m600(arg0, 1, Local0, bb25)
	}

	// Integer to Buffer conversion of the Integer second operand of
	// Concatenate operator when the first operand is evaluated as Buffer

	Method(m646, 2)
	{		
		Store(Concatenate(Buffer(){0x5a}, arg1), Local0)
		m600(arg0, 0, Local0, bb10)

		Store(Concatenate(Buffer(){0x5a, 0x00}, arg1), Local0)
		m600(arg0, 1, Local0, bb11)

		Store(Concatenate(aub0, arg1), Local0)
		m600(arg0, 2, Local0, bb10)

		Store(Concatenate(aub1, arg1), Local0)
		m600(arg0, 3, Local0, bb11)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aub0)), arg1), Local0)
			m600(arg0, 4, Local0, bb10)

			Store(Concatenate(Derefof(Refof(aub1)), arg1), Local0)
			m600(arg0, 5, Local0, bb11)
		}

		Store(Concatenate(Derefof(Index(paub, 0)), arg1), Local0)
		m600(arg0, 6, Local0, bb10)

		Store(Concatenate(Derefof(Index(paub, 1)), arg1), Local0)
		m600(arg0, 7, Local0, bb11)

		// Method returns Buffer

		Store(Concatenate(m601(3, 0), arg1), Local0)
		m600(arg0, 8, Local0, bb10)

		Store(Concatenate(m601(3, 1), arg1), Local0)
		m600(arg0, 9, Local0, bb11)

		// Method returns Reference to Buffer

		if (y500) {
			Store(Concatenate(Derefof(m602(3, 0, 1)), arg1), Local0)
			m600(arg0, 10, Local0, bb10)

			Store(Concatenate(Derefof(m602(3, 1, 1)), arg1), Local0)
			m600(arg0, 11, Local0, bb11)
		}

		Concatenate(Buffer(){0x5a}, arg1, Local0)
		m600(arg0, 12, Local0, bb10)

		Concatenate(Buffer(){0x5a, 0x00}, arg1, Local0)
		m600(arg0, 13, Local0, bb11)

		Concatenate(aub0, arg1, Local0)
		m600(arg0, 14, Local0, bb10)

		Concatenate(aub1, arg1, Local0)
		m600(arg0, 15, Local0, bb11)

		if (y078) {
			Concatenate(Derefof(Refof(aub0)), arg1, Local0)
			m600(arg0, 16, Local0, bb10)

			Concatenate(Derefof(Refof(aub1)), arg1, Local0)
			m600(arg0, 17, Local0, bb11)
		}

		Concatenate(Derefof(Index(paub, 0)), arg1, Local0)
		m600(arg0, 18, Local0, bb10)

		Concatenate(Derefof(Index(paub, 1)), arg1, Local0)
		m600(arg0, 19, Local0, bb11)

		// Method returns Buffer

		Concatenate(m601(3, 0), arg1, Local0)
		m600(arg0, 20, Local0, bb10)

		Concatenate(m601(3, 1), arg1, Local0)
		m600(arg0, 21, Local0, bb11)

		// Method returns Reference to Buffer

		if (y500) {
			Concatenate(Derefof(m602(3, 0, 1)), arg1, Local0)
			m600(arg0, 22, Local0, bb10)

			Concatenate(Derefof(m602(3, 1, 1)), arg1, Local0)
			m600(arg0, 23, Local0, bb11)
		}
	}

	Method(m326, 3)
	{
		Store(Concatenate(Buffer(){0x5a}, arg2), Local0)
		m600(arg0, 0, Local0, bb12)

		Store(Concatenate(Buffer(){0x5a, 0x00}, arg2), Local0)
		m600(arg0, 1, Local0, bb13)

		Store(Concatenate(aub0, arg2), Local0)
		m600(arg0, 2, Local0, bb12)

		Store(Concatenate(aub1, arg2), Local0)
		m600(arg0, 3, Local0, bb13)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aub0)), arg2), Local0)
			m600(arg0, 4, Local0, bb12)

			Store(Concatenate(Derefof(Refof(aub1)), arg2), Local0)
			m600(arg0, 5, Local0, bb13)
		}

		Store(Concatenate(Derefof(Index(paub, 0)), arg2), Local0)
		m600(arg0, 6, Local0, bb12)

		Store(Concatenate(Derefof(Index(paub, 1)), arg2), Local0)
		m600(arg0, 7, Local0, bb13)

		// Method returns Buffer

		Store(Concatenate(m601(3, 0), arg2), Local0)
		m600(arg0, 8, Local0, bb12)

		Store(Concatenate(m601(3, 1), arg2), Local0)
		m600(arg0, 9, Local0, bb13)

		// Method returns Reference to Buffer

		if (y500) {
			Store(Concatenate(Derefof(m602(3, 0, 1)), arg2), Local0)
			m600(arg0, 10, Local0, bb12)

			Store(Concatenate(Derefof(m602(3, 1, 1)), arg2), Local0)
			m600(arg0, 11, Local0, bb13)
		}

		Store(Concatenate(Buffer(){0x5a}, arg1), Local0)
		m600(arg0, 12, Local0, bb14)

		Store(Concatenate(Buffer(){0x5a, 0x00}, arg1), Local0)
		m600(arg0, 13, Local0, bb15)

		Concatenate(Buffer(){0x5a}, arg2, Local0)
		m600(arg0, 14, Local0, bb12)

		Concatenate(Buffer(){0x5a, 0x00}, arg2, Local0)
		m600(arg0, 15, Local0, bb13)

		Concatenate(aub0, arg2, Local0)
		m600(arg0, 16, Local0, bb12)

		Concatenate(aub1, arg2, Local0)
		m600(arg0, 17, Local0, bb13)

		if (y078) {
			Concatenate(Derefof(Refof(aub0)), arg2, Local0)
			m600(arg0, 18, Local0, bb12)

			Concatenate(Derefof(Refof(aub1)), arg2, Local0)
			m600(arg0, 19, Local0, bb13)
		}

		Concatenate(Derefof(Index(paub, 0)), arg2, Local0)
		m600(arg0, 20, Local0, bb12)

		Concatenate(Derefof(Index(paub, 1)), arg2, Local0)
		m600(arg0, 21, Local0, bb13)

		// Method returns Buffer

		Concatenate(m601(3, 0), arg2, Local0)
		m600(arg0, 22, Local0, bb12)

		Concatenate(m601(3, 1), arg2, Local0)
		m600(arg0, 23, Local0, bb13)

		// Method returns Reference to Buffer

		if (y500) {
			Concatenate(Derefof(m602(3, 0, 1)), arg2, Local0)
			m600(arg0, 24, Local0, bb12)

			Concatenate(Derefof(m602(3, 1, 1)), arg2, Local0)
			m600(arg0, 25, Local0, bb13)
		}

		Concatenate(Buffer(){0x5a}, arg1, Local0)
		m600(arg0, 26, Local0, bb14)

		Concatenate(Buffer(){0x5a, 0x00}, arg1, Local0)
		m600(arg0, 27, Local0, bb15)
	}


	// Integer to Buffer conversion of the Integer Source operand of
	// ToString operator

	Method(m647, 3)
	{
		Store(ToString(arg1, Ones), Local0)
		m600(arg0, 0, Local0, bs18)

		Store(ToString(arg1, 3), Local0)
		m600(arg0, 1, Local0, bs19)

		Store(ToString(arg2, Ones), Local0)
		m600(arg0, 2, Local0, bs1a)

		Store(ToString(arg1, aui0), Local0)
		m600(arg0, 3, Local0, bs18)

		Store(ToString(arg1, aui7), Local0)
		m600(arg0, 4, Local0, bs19)

		Store(ToString(arg2, aui0), Local0)
		m600(arg0, 5, Local0, bs1a)

		if (y078) {
			Store(ToString(arg1, Derefof(Refof(aui0))), Local0)
			m600(arg0, 6, Local0, bs18)

			Store(ToString(arg1, Derefof(Refof(aui7))), Local0)
			m600(arg0, 7, Local0, bs19)

			Store(ToString(arg2, Derefof(Refof(aui0))), Local0)
			m600(arg0, 8, Local0, bs1a)
		}

		Store(ToString(arg1, Derefof(Index(paui, 0))), Local0)
		m600(arg0, 9, Local0, bs18)

		Store(ToString(arg1, Derefof(Index(paui, 7))), Local0)
		m600(arg0, 10, Local0, bs19)

		Store(ToString(arg2, Derefof(Index(paui, 0))), Local0)
		m600(arg0, 11, Local0, bs1a)

		// Method returns Length parameter

		Store(ToString(arg1, m601(1, 0)), Local0)
		m600(arg0, 12, Local0, bs18)

		Store(ToString(arg1, m601(1, 7)), Local0)
		m600(arg0, 13, Local0, bs19)

		Store(ToString(arg2, m601(1, 0)), Local0)
		m600(arg0, 14, Local0, bs1a)

		// Method returns Reference to Length parameter

		if (y500) {
			Store(ToString(arg1, Derefof(m601(1, 0))), Local0)
			m600(arg0, 15, Local0, bs18)

			Store(ToString(arg1, Derefof(m601(1, 7))), Local0)
			m600(arg0, 16, Local0, bs19)

			Store(ToString(arg2, Derefof(m601(1, 0))), Local0)
			m600(arg0, 17, Local0, bs1a)
		}

		ToString(arg1, Ones, Local0)
		m600(arg0, 18, Local0, bs18)

		ToString(arg1, 3, Local0)
		m600(arg0, 19, Local0, bs19)

		ToString(arg2, Ones, Local0)
		m600(arg0, 20, Local0, bs1a)

		ToString(arg1, aui0, Local0)
		m600(arg0, 21, Local0, bs18)

		ToString(arg1, aui7, Local0)
		m600(arg0, 22, Local0, bs19)

		ToString(arg2, aui0, Local0)
		m600(arg0, 23, Local0, bs1a)

		if (y078) {
			ToString(arg1, Derefof(Refof(aui0)), Local0)
			m600(arg0, 24, Local0, bs18)

			ToString(arg1, Derefof(Refof(aui7)), Local0)
			m600(arg0, 25, Local0, bs19)

			ToString(arg2, Derefof(Refof(aui0)), Local0)
			m600(arg0, 26, Local0, bs1a)
		}

		ToString(arg1, Derefof(Index(paui, 0)), Local0)
		m600(arg0, 27, Local0, bs18)

		ToString(arg1, Derefof(Index(paui, 7)), Local0)
		m600(arg0, 28, Local0, bs19)

		ToString(arg2, Derefof(Index(paui, 0)), Local0)
		m600(arg0, 29, Local0, bs1a)

		// Method returns Length parameter

		ToString(arg1, m601(1, 0), Local0)
		m600(arg0, 30, Local0, bs18)

		ToString(arg1, m601(1, 7), Local0)
		m600(arg0, 31, Local0, bs19)

		ToString(arg2, m601(1, 0), Local0)
		m600(arg0, 32, Local0, bs1a)

		// Method returns Reference to Length parameter

		if (y500) {
			ToString(arg1, Derefof(m601(1, 0)), Local0)
			m600(arg0, 33, Local0, bs18)

			ToString(arg1, Derefof(m601(1, 7)), Local0)
			m600(arg0, 34, Local0, bs19)

			ToString(arg2, Derefof(m601(1, 0)), Local0)
			m600(arg0, 35, Local0, bs1a)
		}
	}
	
	Method(m327, 3)
	{
		Store(ToString(arg1, Ones), Local0)
		m600(arg0, 0, Local0, bs16)

		Store(ToString(arg1, 3), Local0)
		m600(arg0, 1, Local0, bs17)

		Store(ToString(arg2, Ones), Local0)
		m600(arg0, 2, Local0, bs1a)

		Store(ToString(arg1, aui0), Local0)
		m600(arg0, 3, Local0, bs16)

		Store(ToString(arg1, aui7), Local0)
		m600(arg0, 4, Local0, bs17)

		Store(ToString(arg2, aui0), Local0)
		m600(arg0, 5, Local0, bs1a)

		if (y078) {
			Store(ToString(arg1, Derefof(Refof(aui0))), Local0)
			m600(arg0, 6, Local0, bs16)

			Store(ToString(arg1, Derefof(Refof(aui7))), Local0)
			m600(arg0, 7, Local0, bs17)

			Store(ToString(arg2, Derefof(Refof(aui0))), Local0)
			m600(arg0, 8, Local0, bs1a)
		}

		Store(ToString(arg1, Derefof(Index(paui, 0))), Local0)
		m600(arg0, 9, Local0, bs16)

		Store(ToString(arg1, Derefof(Index(paui, 7))), Local0)
		m600(arg0, 10, Local0, bs17)

		Store(ToString(arg2, Derefof(Index(paui, 0))), Local0)
		m600(arg0, 11, Local0, bs1a)

		// Method returns Length parameter

		Store(ToString(arg1, m601(1, 0)), Local0)
		m600(arg0, 12, Local0, bs16)

		Store(ToString(arg1, m601(1, 7)), Local0)
		m600(arg0, 13, Local0, bs17)

		Store(ToString(arg2, m601(1, 0)), Local0)
		m600(arg0, 14, Local0, bs1a)

		// Method returns Reference to Length parameter

		if (y500) {
			Store(ToString(arg1, Derefof(m601(1, 0))), Local0)
			m600(arg0, 15, Local0, bs16)

			Store(ToString(arg1, Derefof(m601(1, 7))), Local0)
			m600(arg0, 16, Local0, bs17)

			Store(ToString(arg2, Derefof(m601(1, 0))), Local0)
			m600(arg0, 17, Local0, bs1a)
		}

		ToString(arg1, Ones, Local0)
		m600(arg0, 18, Local0, bs16)

		ToString(arg1, 3, Local0)
		m600(arg0, 19, Local0, bs17)

		ToString(arg2, Ones, Local0)
		m600(arg0, 20, Local0, bs1a)

		ToString(arg1, aui0, Local0)
		m600(arg0, 21, Local0, bs16)

		ToString(arg1, aui7, Local0)
		m600(arg0, 22, Local0, bs17)

		ToString(arg2, aui0, Local0)
		m600(arg0, 23, Local0, bs1a)

		if (y078) {
			ToString(arg1, Derefof(Refof(aui0)), Local0)
			m600(arg0, 24, Local0, bs16)

			ToString(arg1, Derefof(Refof(aui7)), Local0)
			m600(arg0, 25, Local0, bs17)

			ToString(arg2, Derefof(Refof(aui0)), Local0)
			m600(arg0, 26, Local0, bs1a)
		}

		ToString(arg1, Derefof(Index(paui, 0)), Local0)
		m600(arg0, 27, Local0, bs16)

		ToString(arg1, Derefof(Index(paui, 7)), Local0)
		m600(arg0, 28, Local0, bs17)

		ToString(arg2, Derefof(Index(paui, 0)), Local0)
		m600(arg0, 29, Local0, bs1a)

		// Method returns Length parameter

		ToString(arg1, m601(1, 0), Local0)
		m600(arg0, 30, Local0, bs16)

		ToString(arg1, m601(1, 7), Local0)
		m600(arg0, 31, Local0, bs17)

		ToString(arg2, m601(1, 0), Local0)
		m600(arg0, 32, Local0, bs1a)

		// Method returns Reference to Length parameter

		if (y500) {
			ToString(arg1, Derefof(m601(1, 0)), Local0)
			m600(arg0, 33, Local0, bs16)

			ToString(arg1, Derefof(m601(1, 7)), Local0)
			m600(arg0, 34, Local0, bs17)

			ToString(arg2, Derefof(m601(1, 0)), Local0)
			m600(arg0, 35, Local0, bs1a)
		}
	}

	// Integer to Buffer conversion of the Integer Source operand of
	// Mid operator

	Method(m648, 3)
	{
		Store(Mid(arg1, 0, 9), Local0)
		m600(arg0, 0, Local0, bb1d)

		Store(Mid(arg2, 1, 8), Local0)
		m600(arg0, 1, Local0, bb30)

		Store(Mid(arg1, aui5, auib), Local0)
		m600(arg0, 2, Local0, bb1d)

		Store(Mid(arg2, aui6, auia), Local0)
		m600(arg0, 3, Local0, bb30)

		if (y078) {
			Store(Mid(arg1, Derefof(Refof(aui5)), Derefof(Refof(auib))), Local0)
			m600(arg0, 4, Local0, bb1d)

			Store(Mid(arg2, Derefof(Refof(aui6)), Derefof(Refof(auia))), Local0)
			m600(arg0, 5, Local0, bb30)
		}

		Store(Mid(arg1, Derefof(Index(paui, 5)), Derefof(Index(paui, 11))), Local0)
		m600(arg0, 6, Local0, bb1d)

		Store(Mid(arg2, Derefof(Index(paui, 6)), Derefof(Index(paui, 10))), Local0)
		m600(arg0, 7, Local0, bb30)

		// Method returns Index and Length parameters

		Store(Mid(arg1, m601(1, 5), m601(1, 11)), Local0)
		m600(arg0, 8, Local0, bb1d)

		Store(Mid(arg2, m601(1, 6), m601(1, 10)), Local0)
		m600(arg0, 9, Local0, bb30)

		// Method returns Reference to Index and Length parameters

		if (y500) {
			Store(Mid(arg1, Derefof(m601(1, 5)), Derefof(m601(1, 11))), Local0)
			m600(arg0, 10, Local0, bb1d)

			Store(Mid(arg2, Derefof(m601(1, 6)), Derefof(m601(1, 10))), Local0)
			m600(arg0, 11, Local0, bb30)
		}

		Mid(arg1, 0, 9, Local0)
		m600(arg0, 12, Local0, bb1d)

		Mid(arg2, 1, 8, Local0)
		m600(arg0, 13, Local0, bb30)

		Mid(arg1, aui5, auib, Local0)
		m600(arg0, 14, Local0, bb1d)

		Mid(arg2, aui6, auia, Local0)
		m600(arg0, 15, Local0, bb30)

		if (y078) {
			Mid(arg1, Derefof(Refof(aui5)), Derefof(Refof(auib)), Local0)
			m600(arg0, 16, Local0, bb1d)

			Mid(arg2, Derefof(Refof(aui6)), Derefof(Refof(auia)), Local0)
			m600(arg0, 17, Local0, bb30)
		}

		Mid(arg1, Derefof(Index(paui, 5)), Derefof(Index(paui, 11)), Local0)
		m600(arg0, 18, Local0, bb1d)

		Mid(arg2, Derefof(Index(paui, 6)), Derefof(Index(paui, 10)), Local0)
		m600(arg0, 19, Local0, bb30)

		// Method returns Index and Length parameters

		Mid(arg1, m601(1, 5), m601(1, 11), Local0)
		m600(arg0, 20, Local0, bb1d)

		Mid(arg2, m601(1, 6), m601(1, 10), Local0)
		m600(arg0, 21, Local0, bb30)

		// Method returns Reference to Index and Length parameters

		if (y500) {
			Mid(arg1, Derefof(m601(1, 5)), Derefof(m601(1, 11)), Local0)
			m600(arg0, 22, Local0, bb1d)

			Mid(arg2, Derefof(m601(1, 6)), Derefof(m601(1, 10)), Local0)
			m600(arg0, 23, Local0, bb30)
		}
	}

	Method(m328, 3)
	{
		Store(Mid(arg1, 0, 5), Local0)
		m600(arg0, 0, Local0, bb1c)

		Store(Mid(arg2, 1, 4), Local0)
		m600(arg0, 1, Local0, bb31)

		Store(Mid(arg1, aui5, aui9), Local0)
		m600(arg0, 2, Local0, bb1c)

		Store(Mid(arg2, aui6, aui8), Local0)
		m600(arg0, 3, Local0, bb31)

		if (y078) {
			Store(Mid(arg1, Derefof(Refof(aui5)), Derefof(Refof(aui9))), Local0)
			m600(arg0, 4, Local0, bb1c)

			Store(Mid(arg2, Derefof(Refof(aui6)), Derefof(Refof(aui8))), Local0)
			m600(arg0, 5, Local0, bb31)
		}

		Store(Mid(arg1, Derefof(Index(paui, 5)), Derefof(Index(paui, 9))), Local0)
		m600(arg0, 6, Local0, bb1c)

		Store(Mid(arg2, Derefof(Index(paui, 6)), Derefof(Index(paui, 8))), Local0)
		m600(arg0, 7, Local0, bb31)

		// Method returns Index and Length parameters

		Store(Mid(arg1, m601(1, 5), m601(1, 9)), Local0)
		m600(arg0, 8, Local0, bb1c)

		Store(Mid(arg2, m601(1, 6), m601(1, 8)), Local0)
		m600(arg0, 9, Local0, bb31)

		// Method returns Reference to Index and Length parameters

		if (y500) {
			Store(Mid(arg1, Derefof(m601(1, 5)), Derefof(m601(1, 9))), Local0)
			m600(arg0, 10, Local0, bb1c)

			Store(Mid(arg2, Derefof(m601(1, 6)), Derefof(m601(1, 8))), Local0)
			m600(arg0, 11, Local0, bb31)
		}

		Mid(arg1, 0, 5, Local0)
		m600(arg0, 12, Local0, bb1c)

		Mid(arg2, 1, 4, Local0)
		m600(arg0, 13, Local0, bb31)

		Mid(arg1, aui5, aui9, Local0)
		m600(arg0, 14, Local0, bb1c)

		Mid(arg2, aui6, aui8, Local0)
		m600(arg0, 15, Local0, bb31)

		if (y078) {
			Mid(arg1, Derefof(Refof(aui5)), Derefof(Refof(aui9)), Local0)
			m600(arg0, 16, Local0, bb1c)

			Mid(arg2, Derefof(Refof(aui6)), Derefof(Refof(aui8)), Local0)
			m600(arg0, 17, Local0, bb31)
		}

		Mid(arg1, Derefof(Index(paui, 5)), Derefof(Index(paui, 9)), Local0)
		m600(arg0, 18, Local0, bb1c)

		Mid(arg2, Derefof(Index(paui, 6)), Derefof(Index(paui, 8)), Local0)
		m600(arg0, 19, Local0, bb31)

		// Method returns Index and Length parameters

		Mid(arg1, m601(1, 5), m601(1, 9), Local0)
		m600(arg0, 20, Local0, bb1c)

		Mid(arg2, m601(1, 6), m601(1, 8), Local0)
		m600(arg0, 21, Local0, bb31)

		// Method returns Reference to Index and Length parameters

		if (y500) {
			Mid(arg1, Derefof(m601(1, 5)), Derefof(m601(1, 9)), Local0)
			m600(arg0, 22, Local0, bb1c)

			Mid(arg2, Derefof(m601(1, 6)), Derefof(m601(1, 8)), Local0)
			m600(arg0, 23, Local0, bb31)
		}
	}

//	Method(m649, 1)

//	Method(m329, 1)

//	Method(m64a, 1)

//	Method(m32a, 1)

	// String to Integer implicit conversion Cases.

	// String to Integer conversion of the String sole operand
	// of the 1-parameter Integer arithmetic operators
	// (Decrement, Increment, FindSetLeftBit, FindSetRightBit, Not)

	Method(m64b, 3)
	{
		// Decrement
		if (y501) {
			Store(Decrement(arg1), Local0)
			m600(arg0, 0, Local0, bi12)

			Store(Decrement(arg2), Local0)
			m600(arg0, 1, Local0, bi16)
		}

		// Increment
		if (y501) {
			Store(Increment(arg1), Local0)
			m600(arg0, 2, Local0, bi13)

			Store(Increment(arg2), Local0)
			m600(arg0, 3, Local0, bi17)
		}

		// FindSetLeftBit
		Store(FindSetLeftBit(arg1), Local0)
		m600(arg0, 4, Local0, 10)

		Store(FindSetLeftBit(arg2), Local0)
		m600(arg0, 5, Local0, 64)

		// FindSetRightBit

		Store(FindSetRightBit(arg1), Local0)
		m600(arg0, 6, Local0, 1)

		Store(FindSetRightBit(arg2), Local0)
		m600(arg0, 7, Local0, 3)

		// Not

		Store(Not(arg1), Local0)
		m600(arg0, 8, Local0, 0xfffffffffffffcde)

		Store(Not(arg2), Local0)
		m600(arg0, 9, Local0, 0x01834c6e29af5d7b)
	}

	Method(m32b, 3)
	{
		// Decrement
		if (y501) {
			Store(Decrement(arg1), Local0)
			m600(arg0, 0, Local0, bi12)

			Store(Decrement(arg2), Local0)
			m600(arg0, 1, Local0, bi14)
		}

		// Increment
		if (y501) {
			Store(Increment(arg1), Local0)
			m600(arg0, 2, Local0, bi13)

			Store(Increment(arg2), Local0)
			m600(arg0, 3, Local0, bi15)
		}

		// FindSetLeftBit

		Store(FindSetLeftBit(arg1), Local0)
		m600(arg0, 4, Local0, 10)

		Store(FindSetLeftBit(arg2), Local0)
		m600(arg0, 5, Local0, 32)

		// FindSetRightBit

		Store(FindSetRightBit(arg1), Local0)
		m600(arg0, 6, Local0, 1)

		Store(FindSetRightBit(arg2), Local0)
		m600(arg0, 7, Local0, 2)

		// Not

		Store(Not(arg1), Local0)
		m600(arg0, 8, Local0, 0xfffffcde)

		Store(Not(arg2), Local0)
		m600(arg0, 9, Local0, 0x3e864c01)
	}

	// String to Integer conversion of the String sole operand
	// of the LNot Logical Integer operator
	Method(m000, 5)
	{
		Store(LNot(arg4), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LNot(arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		if (F64) {
			Store(LNot(arg2), Local0)
			m600(arg0, 2, Local0, Zero)
		} else {
			Store(LNot(arg3), Local0)
			m600(arg0, 3, Local0, Zero)
		}
	}

	// String to Integer conversion of the String sole operand
	// of the FromBCD and ToBCD conversion operators

	Method(m64c, 5)
	{
		// FromBCD

		Store(FromBCD(arg1), Local0)
		m600(arg0, 2, Local0, 0x141)

		Store(FromBCD(arg3), Local0)
		m600(arg0, 3, Local0, 0xd76162ee9ec35)

		FromBCD(arg1, Local0)
		m600(arg0, 2, Local0, 0x141)

		FromBCD(arg3, Local0)
		m600(arg0, 3, Local0, 0xd76162ee9ec35)

		// ToBCD

		Store(ToBCD(arg1), Local0)
		m600(arg0, 4, Local0, 0x801)

/* Error of iASL on constant folding
		Store(ToBCD(arg4), Local0)
		m600(arg0, 5, Local0, 0x3789012345678901)
*/

		ToBCD(arg1, Local0)
		m600(arg0, 4, Local0, 0x801)

		ToBCD(arg4, Local0)
		m600(arg0, 5, Local0, 0x3789012345678901)
	}

	Method(m32c, 5)
	{
		// FromBCD

		Store(FromBCD(arg1), Local0)
		m600(arg0, 2, Local0, 0x141)

		Store(FromBCD(arg3), Local0)
		m600(arg0, 3, Local0, 0x55f2cc0)

		FromBCD(arg1, Local0)
		m600(arg0, 2, Local0, 0x141)

		FromBCD(arg3, Local0)
		m600(arg0, 3, Local0, 0x55f2cc0)

		// ToBCD

		Store(ToBCD(arg1), Local0)
		m600(arg0, 4, Local0, 0x801)

		Store(ToBCD(arg4), Local0)
		m600(arg0, 5, Local0, 0x90123456)

		ToBCD(arg1, Local0)
		m600(arg0, 4, Local0, 0x801)

		ToBCD(arg4, Local0)
		m600(arg0, 5, Local0, 0x90123456)
	}

	// String to Integer conversion of each String operand
	// of the 2-parameter Integer arithmetic operators
	// Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
	// ShiftLeft, ShiftRight, Subtract, Xor

	// Add, common 32-bit/64-bit test
	Method(m001, 2)
	{
		// Conversion of the first operand

		Store(Add(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Add(arg1, 1), Local0)
		m600(arg0, 1, Local0, 0x322)

		Store(Add(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Add(arg1, aui6), Local0)
		m600(arg0, 3, Local0, 0x322)

		if (y078) {
			Store(Add(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Add(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x322)
		}

		Store(Add(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Add(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x322)

		// Method returns Integer

		Store(Add(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Add(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Add(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x322)
		}

		Add(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Add(arg1, 1, Local0)
		m600(arg0, 13, Local0, 0x322)

		Add(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Add(arg1, aui6, Local0)
		m600(arg0, 15, Local0, 0x322)

		if (y078) {
			Add(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Add(arg1, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x322)
		}

		Add(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Add(arg1, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x322)

		// Method returns Integer

		Add(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Add(arg1, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Add(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Add(arg1, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x322)
		}

		// Conversion of the second operand

		Store(Add(0, arg1), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(Add(1, arg1), Local0)
		m600(arg0, 25, Local0, 0x322)

		Store(Add(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(Add(aui6, arg1), Local0)
		m600(arg0, 27, Local0, 0x322)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(Add(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 29, Local0, 0x322)
		}

		Store(Add(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(Add(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 31, Local0, 0x322)

		// Method returns Integer

		Store(Add(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(Add(m601(1, 6), arg1), Local0)
		m600(arg0, 33, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(Add(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0x322)
		}

		Add(0, arg1, Local0)
		m600(arg0, 36, Local0, 0x321)

		Add(1, arg1, Local0)
		m600(arg0, 37, Local0, 0x322)

		Add(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0x321)

		Add(aui6, arg1, Local0)
		m600(arg0, 39, Local0, 0x322)

		if (y078) {
			Add(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0x321)

			Add(Derefof(Refof(aui6)), arg1, Local0)
			m600(arg0, 41, Local0, 0x322)
		}

		Add(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0x321)

		Add(Derefof(Index(paui, 6)), arg1, Local0)
		m600(arg0, 43, Local0, 0x322)

		// Method returns Integer

		Add(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0x321)

		Add(m601(1, 6), arg1, Local0)
		m600(arg0, 45, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0x321)

			Add(Derefof(m602(1, 6, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0x322)
		}
	}

	// Add, 64-bit
	Method(m002, 3)
	{
		// Conversion of the first operand

		Store(Add(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Add(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a285)

		Store(Add(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Add(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Store(Add(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Add(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a285)
		}

		Store(Add(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Add(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Store(Add(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Add(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Add(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a285)
		}

		Add(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Add(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a285)

		Add(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Add(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Add(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Add(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a285)
		}

		Add(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Add(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Add(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Add(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Add(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a285)
		}

		// Conversion of the second operand

		Store(Add(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(Add(1, arg2), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a285)

		Store(Add(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(Add(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(Add(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a285)
		}

		Store(Add(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(Add(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Store(Add(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(Add(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(Add(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a285)
		}

		Add(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		Add(1, arg2, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a285)

		Add(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		Add(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Add(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			Add(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a285)
		}

		Add(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		Add(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Add(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		Add(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			Add(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a285)
		}

		// Conversion of the both operands

		Store(Add(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a5a5)

		Store(Add(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a5a5)

		Add(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a5a5)

		Add(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a5a5)
	}

	// Add, 32-bit
	Method(m003, 3)
	{
		// Conversion of the first operand

		Store(Add(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(Add(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xc179b3ff)

		Store(Add(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(Add(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xc179b3ff)

		if (y078) {
			Store(Add(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(Add(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xc179b3ff)
		}

		Store(Add(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(Add(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xc179b3ff)

		// Method returns Integer

		Store(Add(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(Add(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xc179b3ff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(Add(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xc179b3ff)
		}

		Add(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		Add(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xc179b3ff)

		Add(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		Add(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xc179b3ff)

		if (y078) {
			Add(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			Add(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xc179b3ff)
		}

		Add(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		Add(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xc179b3ff)

		// Method returns Integer

		Add(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		Add(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xc179b3ff)

		// Method returns Reference to Integer

		if (y500) {
			Add(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			Add(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xc179b3ff)
		}

		// Conversion of the second operand

		Store(Add(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xc179b3fe)

		Store(Add(1, arg2), Local0)
		m600(arg0, 25, Local0, 0xc179b3ff)

		Store(Add(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xc179b3fe)

		Store(Add(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0xc179b3ff)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xc179b3fe)

			Store(Add(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0xc179b3ff)
		}

		Store(Add(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xc179b3fe)

		Store(Add(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0xc179b3ff)

		// Method returns Integer

		Store(Add(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xc179b3fe)

		Store(Add(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0xc179b3ff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xc179b3fe)

			Store(Add(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xc179b3ff)
		}

		Add(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xc179b3fe)

		Add(1, arg2, Local0)
		m600(arg0, 37, Local0, 0xc179b3ff)

		Add(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xc179b3fe)

		Add(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0xc179b3ff)

		if (y078) {
			Add(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xc179b3fe)

			Add(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0xc179b3ff)
		}

		Add(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xc179b3fe)

		Add(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0xc179b3ff)

		// Method returns Integer

		Add(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xc179b3fe)

		Add(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0xc179b3ff)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xc179b3fe)

			Add(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xc179b3ff)
		}

		// Conversion of the both operands

		Store(Add(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xc179b71f)

		Store(Add(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xc179b71f)

		Add(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xc179b71f)

		Add(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xc179b71f)
	}

	// And, common 32-bit/64-bit test
	Method(m004, 2)
	{
		// Conversion of the first operand

		Store(And(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And(arg1, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x321)

		Store(And(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And(arg1, auij), Local0)
		m600(arg0, 3, Local0, 0x321)

		if (y078) {
			Store(And(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And(arg1, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x321)
		}

		Store(And(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And(arg1, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x321)

		// Method returns Integer

		Store(And(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And(arg1, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And(arg1, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x321)
		}

		And(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0)

		And(arg1, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x321)

		And(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And(arg1, auij, Local0)
		m600(arg0, 15, Local0, 0x321)

		if (y078) {
			And(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And(arg1, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x321)
		}

		And(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And(arg1, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x321)

		// Method returns Integer

		And(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And(arg1, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			And(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And(arg1, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x321)
		}

		// Conversion of the second operand

		Store(And(0, arg1), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffffffffffff, arg1), Local0)
		m600(arg0, 25, Local0, 0x321)

		Store(And(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auij, arg1), Local0)
		m600(arg0, 27, Local0, 0x321)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auij)), arg1), Local0)
			m600(arg0, 29, Local0, 0x321)
		}

		Store(And(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 19)), arg1), Local0)
		m600(arg0, 31, Local0, 0x321)

		// Method returns Integer

		Store(And(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 19), arg1), Local0)
		m600(arg0, 33, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 19, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0x321)
		}

		And(0, arg1, Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffffffffffff, arg1, Local0)
		m600(arg0, 37, Local0, 0x321)

		And(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0)

		And(auij, arg1, Local0)
		m600(arg0, 39, Local0, 0x321)

		if (y078) {
			And(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auij)), arg1, Local0)
			m600(arg0, 41, Local0, 0x321)
		}

		And(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 19)), arg1, Local0)
		m600(arg0, 43, Local0, 0x321)

		// Method returns Integer

		And(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 19), arg1, Local0)
		m600(arg0, 45, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 19, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0x321)
		}
	}

	// And, 64-bit
	Method(m005, 3)
	{
		// Conversion of the first operand

		Store(And(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And(arg2, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a284)

		Store(And(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And(arg2, auij), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(And(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And(arg2, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a284)
		}

		Store(And(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And(arg2, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(And(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And(arg2, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And(arg2, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a284)
		}

		And(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0)

		And(arg2, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		And(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And(arg2, auij, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a284)

		if (y078) {
			And(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And(arg2, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a284)
		}

		And(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And(arg2, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		And(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And(arg2, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And(arg2, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the second operand

		Store(And(0, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffffffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a284)

		Store(And(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auij, arg2), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auij)), arg2), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a284)
		}

		Store(And(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 19)), arg2), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(And(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 19), arg2), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 19, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a284)
		}

		And(0, arg2, Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffffffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a284)

		And(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0)

		And(auij, arg2, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a284)

		if (y078) {
			And(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auij)), arg2, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a284)
		}

		And(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 19)), arg2, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		And(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 19), arg2, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 19, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the both operands

		Store(And(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x200)

		Store(And(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x200)

		And(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x200)

		And(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x200)
	}

	// And, 32-bit
	Method(m006, 3)
	{
		// Conversion of the first operand

		Store(And(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And(arg2, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0xc179b3fe)

		Store(And(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And(arg2, auii), Local0)
		m600(arg0, 3, Local0, 0xc179b3fe)

		if (y078) {
			Store(And(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And(arg2, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0xc179b3fe)
		}

		Store(And(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And(arg2, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0xc179b3fe)

		// Method returns Integer

		Store(And(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And(arg2, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And(arg2, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0xc179b3fe)
		}

		And(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0)

		And(arg2, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0xc179b3fe)

		And(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And(arg2, auii, Local0)
		m600(arg0, 15, Local0, 0xc179b3fe)

		if (y078) {
			And(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And(arg2, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0xc179b3fe)
		}

		And(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And(arg2, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0xc179b3fe)

		// Method returns Integer

		And(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And(arg2, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			And(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And(arg2, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0xc179b3fe)
		}

		// Conversion of the second operand

		Store(And(0, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0xc179b3fe)

		Store(And(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auii, arg2), Local0)
		m600(arg0, 27, Local0, 0xc179b3fe)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auii)), arg2), Local0)
			m600(arg0, 29, Local0, 0xc179b3fe)
		}

		Store(And(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 18)), arg2), Local0)
		m600(arg0, 31, Local0, 0xc179b3fe)

		// Method returns Integer

		Store(And(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 18), arg2), Local0)
		m600(arg0, 33, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 18, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xc179b3fe)
		}

		And(0, arg2, Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0xc179b3fe)

		And(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0)

		And(auii, arg2, Local0)
		m600(arg0, 39, Local0, 0xc179b3fe)

		if (y078) {
			And(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auii)), arg2, Local0)
			m600(arg0, 41, Local0, 0xc179b3fe)
		}

		And(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 18)), arg2, Local0)
		m600(arg0, 43, Local0, 0xc179b3fe)

		// Method returns Integer

		And(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 18), arg2, Local0)
		m600(arg0, 45, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 18, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xc179b3fe)
		}

		// Conversion of the both operands

		Store(And(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x320)

		Store(And(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x320)

		And(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x320)

		And(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x320)
	}

	// Divide, common 32-bit/64-bit test
	Method(m007, 2)
	{
		// Conversion of the first operand

		Store(Divide(arg1, 1), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Divide(arg1, 0x321), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide(arg1, aui6), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Divide(arg1, aui1), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Divide(arg1, Derefof(Refof(aui1))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Divide(arg1, Derefof(Index(paui, 1))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide(arg1, m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Divide(arg1, m601(1, 1)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Divide(arg1, Derefof(m602(1, 1, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide(arg1, 1, Local1, Local0)
		m600(arg0, 12, Local0, 0x321)

		Divide(arg1, 0x321, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide(arg1, aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0x321)

		Divide(arg1, aui1, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide(arg1, Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0x321)

			Divide(arg1, Derefof(Refof(aui1)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide(arg1, Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0x321)

		Divide(arg1, Derefof(Index(paui, 1)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide(arg1, m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0x321)

		Divide(arg1, m601(1, 1), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(arg1, Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0x321)

			Divide(arg1, Derefof(m602(1, 1, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, arg1), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0x321, arg1), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, arg1), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(aui1, arg1), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), arg1), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 1), arg1), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, arg1, Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0x321, arg1, Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, arg1, Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(aui1, arg1, Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), arg1, Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(aui1)), arg1, Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), arg1, Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 1)), arg1, Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), arg1, Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 1), arg1, Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), arg1, Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 1, 1)), arg1, Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}
	}

	// Divide, 64-bit
	Method(m008, 3)
	{
		// Conversion of the first operand

		Store(Divide(arg2, 1), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Divide(arg2, 0xfe7cb391d650a284), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide(arg2, aui6), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Divide(arg2, aui4), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Divide(arg2, Derefof(Refof(aui4))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Divide(arg2, Derefof(Index(paui, 4))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide(arg2, m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Divide(arg2, m601(1, 4)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Divide(arg2, Derefof(m602(1, 4, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide(arg2, 1, Local1, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Divide(arg2, 0xfe7cb391d650a284, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide(arg2, aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Divide(arg2, aui4, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide(arg2, Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Divide(arg2, Derefof(Refof(aui4)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide(arg2, Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Divide(arg2, Derefof(Index(paui, 4)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide(arg2, m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Divide(arg2, m601(1, 4), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(arg2, Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Divide(arg2, Derefof(m602(1, 4, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0xfe7cb391d650a284, arg2), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(aui4, arg2), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(aui4)), arg2), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 4)), arg2), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 4), arg2), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 4, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, arg2, Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0xfe7cb391d650a284, arg2, Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, arg2, Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(aui4, arg2, Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), arg2, Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(aui4)), arg2, Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), arg2, Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 4)), arg2, Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), arg2, Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 4), arg2, Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), arg2, Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 4, 1)), arg2, Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}

		// Conversion of the both operands

		Store(Divide(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0)

		Store(Divide(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x0051558eb950f5a7)

		Divide(arg1, arg2, Local1, Local0)
		m600(arg0, 50, Local0, 0)

		Divide(arg2, arg1, Local1, Local0)
		m600(arg0, 51, Local0, 0x0051558eb950f5a7)
	}

	// Divide, 32-bit
	Method(m009, 3)
	{
		// Conversion of the first operand

		Store(Divide(arg2, 1), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(Divide(arg2, 0xc179b3fe), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide(arg2, aui6), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(Divide(arg2, aui3), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(Divide(arg2, Derefof(Refof(aui3))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(Divide(arg2, Derefof(Index(paui, 3))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide(arg2, m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(Divide(arg2, m601(1, 3)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(Divide(arg2, Derefof(m602(1, 3, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide(arg2, 1, Local1, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		Divide(arg2, 0xc179b3fe, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide(arg2, aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		Divide(arg2, aui3, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide(arg2, Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			Divide(arg2, Derefof(Refof(aui3)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide(arg2, Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		Divide(arg2, Derefof(Index(paui, 3)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide(arg2, m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		Divide(arg2, m601(1, 3), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(arg2, Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			Divide(arg2, Derefof(m602(1, 3, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0xc179b3fe, arg2), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(aui3, arg2), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(aui3)), arg2), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 3)), arg2), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 3), arg2), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 3, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, arg2, Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0xc179b3fe, arg2, Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, arg2, Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(aui3, arg2, Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), arg2, Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(aui3)), arg2, Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), arg2, Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 3)), arg2, Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), arg2, Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 3), arg2, Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), arg2, Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 3, 1)), arg2, Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}

		// Conversion of the both operands

		Store(Divide(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0)

		Store(Divide(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x003dd5b7)

		Divide(arg1, arg2, Local1, Local0)
		m600(arg0, 50, Local0, 0)

		Divide(arg2, arg1, Local1, Local0)
		m600(arg0, 51, Local0, 0x003dd5b7)
	}

	// Mod, common 32-bit/64-bit test
	Method(m00a, 2)
	{
		// Conversion of the first operand

		Store(Mod(arg1, 0x322), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Mod(arg1, 0x320), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod(arg1, auig), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Mod(arg1, auih), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Mod(arg1, Derefof(Refof(auig))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Mod(arg1, Derefof(Refof(auih))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod(arg1, Derefof(Index(paui, 16))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Mod(arg1, Derefof(Index(paui, 17))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod(arg1, m601(1, 16)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Mod(arg1, m601(1, 17)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(arg1, Derefof(m602(1, 16, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Mod(arg1, Derefof(m602(1, 17, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod(arg1, 0x322, Local0)
		m600(arg0, 12, Local0, 0x321)

		Mod(arg1, 0x320, Local0)
		m600(arg0, 13, Local0, 1)

		Mod(arg1, auig, Local0)
		m600(arg0, 14, Local0, 0x321)

		Mod(arg1, auih, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod(arg1, Derefof(Refof(auig)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Mod(arg1, Derefof(Refof(auih)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod(arg1, Derefof(Index(paui, 16)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Mod(arg1, Derefof(Index(paui, 17)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod(arg1, m601(1, 16), Local0)
		m600(arg0, 20, Local0, 0x321)

		Mod(arg1, m601(1, 17), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod(arg1, Derefof(m602(1, 16, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Mod(arg1, Derefof(m602(1, 17, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0x322, arg1), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0x320, arg1), Local0)
		m600(arg0, 25, Local0, 0x320)

		Store(Mod(auig, arg1), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auih, arg1), Local0)
		m600(arg0, 27, Local0, 0x320)

		if (y078) {
			Store(Mod(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 29, Local0, 0x320)
		}

		Store(Mod(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 31, Local0, 0x320)

		// Method returns Integer

		Store(Mod(m601(1, 16), arg1), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 17), arg1), Local0)
		m600(arg0, 33, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0x320)
		}

		Mod(0x322, arg1, Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0x320, arg1, Local0)
		m600(arg0, 37, Local0, 0x320)

		Mod(auig, arg1, Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auih, arg1, Local0)
		m600(arg0, 39, Local0, 0x320)

		if (y078) {
			Mod(Derefof(Refof(auig)), arg1, Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auih)), arg1, Local0)
			m600(arg0, 41, Local0, 0x320)
		}

		Mod(Derefof(Index(paui, 16)), arg1, Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 17)), arg1, Local0)
		m600(arg0, 43, Local0, 0x320)

		// Method returns Integer

		Mod(m601(1, 16), arg1, Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 17), arg1, Local0)
		m600(arg0, 45, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m602(1, 16, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m602(1, 17, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0x320)
		}
	}

	// Mod, 64-bit
	Method(m00b, 3)
	{
		// Conversion of the first operand

		Store(Mod(arg2, 0xfe7cb391d650a285), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Mod(arg2, 0xfe7cb391d650a283), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod(arg2, auid), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Mod(arg2, auif), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Mod(arg2, Derefof(Refof(auid))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Mod(arg2, Derefof(Refof(auif))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod(arg2, Derefof(Index(paui, 13))), Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		Store(Mod(arg2, Derefof(Index(paui, 15))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod(arg2, m601(1, 13)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Mod(arg2, m601(1, 15)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(arg2, Derefof(m602(1, 13, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Mod(arg2, Derefof(m602(1, 15, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod(arg2, 0xfe7cb391d650a285, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Mod(arg2, 0xfe7cb391d650a283, Local0)
		m600(arg0, 13, Local0, 1)

		Mod(arg2, auid, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Mod(arg2, auif, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod(arg2, Derefof(Refof(auid)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Mod(arg2, Derefof(Refof(auif)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod(arg2, Derefof(Index(paui, 13)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Mod(arg2, Derefof(Index(paui, 15)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod(arg2, m601(1, 13), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Mod(arg2, m601(1, 15), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod(arg2, Derefof(m602(1, 13, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Mod(arg2, Derefof(m602(1, 15, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0xfe7cb391d650a285, arg2), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0xfe7cb391d650a283, arg2), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a283)

		Store(Mod(auid, arg2), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auif, arg2), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Store(Mod(Derefof(Refof(auid)), arg2), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auif)), arg2), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a283)
		}

		Store(Mod(Derefof(Index(paui, 13)), arg2), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 15)), arg2), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Store(Mod(m601(1, 13), arg2), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 15), arg2), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m602(1, 13, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m602(1, 15, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a283)
		}

		Mod(0xfe7cb391d650a285, arg2, Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0xfe7cb391d650a283, arg2, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a283)

		Mod(auid, arg2, Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auif, arg2, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Mod(Derefof(Refof(auid)), arg2, Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auif)), arg2, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a283)
		}

		Mod(Derefof(Index(paui, 13)), arg2, Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 15)), arg2, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Mod(m601(1, 13), arg2, Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 15), arg2, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m602(1, 13, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m602(1, 15, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a283)
		}

		// Conversion of the both operands

		Store(Mod(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x321)

		Store(Mod(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x2fd)

		Mod(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x321)

		Mod(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x2fd)
	}

	// Mod, 32-bit
	Method(m00c, 3)
	{
		// Conversion of the first operand

		Store(Mod(arg2, 0xc179b3ff), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(Mod(arg2, 0xc179b3fd), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod(arg2, auic), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(Mod(arg2, auie), Local0)
		m600(arg0, 14, Local0, 1)

		if (y078) {
			Store(Mod(arg2, Derefof(Refof(auic))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(Mod(arg2, Derefof(Refof(auie))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod(arg2, Derefof(Index(paui, 12))), Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		Store(Mod(arg2, Derefof(Index(paui, 14))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod(arg2, m601(1, 12)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(Mod(arg2, m601(1, 14)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(arg2, Derefof(m602(1, 12, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(Mod(arg2, Derefof(m602(1, 14, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod(arg2, 0xc179b3ff, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		Mod(arg2, 0xc179b3fd, Local0)
		m600(arg0, 13, Local0, 1)

		Mod(arg2, auic, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		Mod(arg2, auie, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod(arg2, Derefof(Refof(auic)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			Mod(arg2, Derefof(Refof(auie)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod(arg2, Derefof(Index(paui, 12)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		Mod(arg2, Derefof(Index(paui, 14)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod(arg2, m601(1, 12), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		Mod(arg2, m601(1, 14), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod(arg2, Derefof(m602(1, 12, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			Mod(arg2, Derefof(m602(1, 14, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0xc179b3ff, arg2), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0xc179b3fd, arg2), Local0)
		m600(arg0, 25, Local0, 0xc179b3fd)

		Store(Mod(auic, arg2), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auie, arg2), Local0)
		m600(arg0, 27, Local0, 0xc179b3fd)

		if (y078) {
			Store(Mod(Derefof(Refof(auic)), arg2), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auie)), arg2), Local0)
			m600(arg0, 29, Local0, 0xc179b3fd)
		}

		Store(Mod(Derefof(Index(paui, 12)), arg2), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 14)), arg2), Local0)
		m600(arg0, 31, Local0, 0xc179b3fd)

		// Method returns Integer

		Store(Mod(m601(1, 12), arg2), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 14), arg2), Local0)
		m600(arg0, 33, Local0, 0xc179b3fd)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m602(1, 12, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m602(1, 14, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xc179b3fd)
		}

		Mod(0xc179b3ff, arg2, Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0xc179b3fd, arg2, Local0)
		m600(arg0, 37, Local0, 0xc179b3fd)

		Mod(auic, arg2, Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auie, arg2, Local0)
		m600(arg0, 39, Local0, 0xc179b3fd)

		if (y078) {
			Mod(Derefof(Refof(auic)), arg2, Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auie)), arg2, Local0)
			m600(arg0, 41, Local0, 0xc179b3fd)
		}

		Mod(Derefof(Index(paui, 12)), arg2, Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 14)), arg2, Local0)
		m600(arg0, 43, Local0, 0xc179b3fd)

		// Method returns Integer

		Mod(m601(1, 12), arg2, Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 14), arg2, Local0)
		m600(arg0, 45, Local0, 0xc179b3fd)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m602(1, 12, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m602(1, 14, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xc179b3fd)
		}

		// Conversion of the both operands

		Store(Mod(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x321)

		Store(Mod(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x267)

		Mod(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x321)

		Mod(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x267)
	}

	// Multiply, common 32-bit/64-bit test
	Method(m00d, 2)
	{
		// Conversion of the first operand

		Store(Multiply(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply(arg1, 1), Local0)
		m600(arg0, 1, Local0, 0x321)

		Store(Multiply(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply(arg1, aui6), Local0)
		m600(arg0, 3, Local0, 0x321)

		if (y078) {
			Store(Multiply(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x321)
		}

		Store(Multiply(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x321)

		// Method returns Integer

		Store(Multiply(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x321)
		}

		Multiply(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply(arg1, 1, Local0)
		m600(arg0, 13, Local0, 0x321)

		Multiply(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply(arg1, aui6, Local0)
		m600(arg0, 15, Local0, 0x321)

		if (y078) {
			Multiply(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply(arg1, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x321)
		}

		Multiply(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply(arg1, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x321)

		// Method returns Integer

		Multiply(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply(arg1, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply(arg1, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x321)
		}

		// Conversion of the second operand

		Store(Multiply(0, arg1), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, arg1), Local0)
		m600(arg0, 25, Local0, 0x321)

		Store(Multiply(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, arg1), Local0)
		m600(arg0, 27, Local0, 0x321)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 29, Local0, 0x321)
		}

		Store(Multiply(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 31, Local0, 0x321)

		// Method returns Integer

		Store(Multiply(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), arg1), Local0)
		m600(arg0, 33, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0x321)
		}

		Multiply(0, arg1, Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, arg1, Local0)
		m600(arg0, 37, Local0, 0x321)

		Multiply(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, arg1, Local0)
		m600(arg0, 39, Local0, 0x321)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), arg1, Local0)
			m600(arg0, 41, Local0, 0x321)
		}

		Multiply(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), arg1, Local0)
		m600(arg0, 43, Local0, 0x321)

		// Method returns Integer

		Multiply(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), arg1, Local0)
		m600(arg0, 45, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0x321)
		}
	}

	// Multiply, 64-bit
	Method(m00e, 3)
	{
		// Conversion of the first operand

		Store(Multiply(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a284)

		Store(Multiply(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(Multiply(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a284)
		}

		Store(Multiply(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(Multiply(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a284)
		}

		Multiply(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		Multiply(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Multiply(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a284)
		}

		Multiply(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Multiply(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the second operand

		Store(Multiply(0, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, arg2), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a284)

		Store(Multiply(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a284)
		}

		Store(Multiply(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(Multiply(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a284)
		}

		Multiply(0, arg2, Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, arg2, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a284)

		Multiply(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a284)
		}

		Multiply(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Multiply(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the both operands

		Store(Multiply(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x442ddb4f924c7f04)

		Store(Multiply(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x442ddb4f924c7f04)

		Multiply(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x442ddb4f924c7f04)

		Multiply(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x442ddb4f924c7f04)
	}

	// Multiply, 32-bit
	Method(m00f, 3)
	{
		// Conversion of the first operand

		Store(Multiply(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xc179b3fe)

		Store(Multiply(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xc179b3fe)

		if (y078) {
			Store(Multiply(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xc179b3fe)
		}

		Store(Multiply(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xc179b3fe)

		// Method returns Integer

		Store(Multiply(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xc179b3fe)
		}

		Multiply(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xc179b3fe)

		Multiply(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xc179b3fe)

		if (y078) {
			Multiply(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xc179b3fe)
		}

		Multiply(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xc179b3fe)

		// Method returns Integer

		Multiply(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xc179b3fe)
		}

		// Conversion of the second operand

		Store(Multiply(0, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, arg2), Local0)
		m600(arg0, 25, Local0, 0xc179b3fe)

		Store(Multiply(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0xc179b3fe)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0xc179b3fe)
		}

		Store(Multiply(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0xc179b3fe)

		// Method returns Integer

		Store(Multiply(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xc179b3fe)
		}

		Multiply(0, arg2, Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, arg2, Local0)
		m600(arg0, 37, Local0, 0xc179b3fe)

		Multiply(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0xc179b3fe)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0xc179b3fe)
		}

		Multiply(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0xc179b3fe)

		// Method returns Integer

		Multiply(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xc179b3fe)
		}

		// Conversion of the both operands

		Store(Multiply(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x5dcc2dbe)

		Store(Multiply(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x5dcc2dbe)

		Multiply(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x5dcc2dbe)

		Multiply(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x5dcc2dbe)
	}

	// NAnd, common 32-bit/64-bit test
	Method(m010, 2)
	{
		// Conversion of the first operand

		Store(NAnd(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0xffffffffffffffff)

		Store(NAnd(arg1, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfffffffffffffcde)

		Store(NAnd(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffffffffffff)

		Store(NAnd(arg1, auij), Local0)
		m600(arg0, 3, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(NAnd(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffffffffffff)

			Store(NAnd(arg1, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfffffffffffffcde)
		}

		Store(NAnd(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffffffffffff)

		Store(NAnd(arg1, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(NAnd(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffffffffffff)

		Store(NAnd(arg1, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffffffffffff)

			Store(NAnd(arg1, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfffffffffffffcde)
		}

		NAnd(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0xffffffffffffffff)

		NAnd(arg1, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfffffffffffffcde)

		NAnd(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffffffffffff)

		NAnd(arg1, auij, Local0)
		m600(arg0, 15, Local0, 0xfffffffffffffcde)

		if (y078) {
			NAnd(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffffffffffff)

			NAnd(arg1, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfffffffffffffcde)
		}

		NAnd(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffffffffffff)

		NAnd(arg1, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		NAnd(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffffffffffff)

		NAnd(arg1, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffffffffffff)

			NAnd(arg1, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfffffffffffffcde)
		}

		// Conversion of the second operand

		Store(NAnd(0, arg1), Local0)
		m600(arg0, 24, Local0, 0xffffffffffffffff)

		Store(NAnd(0xffffffffffffffff, arg1), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffcde)

		Store(NAnd(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0xffffffffffffffff)

		Store(NAnd(auij, arg1), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(Refof(auij)), arg1), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffcde)
		}

		Store(NAnd(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0xffffffffffffffff)

		Store(NAnd(Derefof(Index(paui, 19)), arg1), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(NAnd(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0xffffffffffffffff)

		Store(NAnd(m601(1, 19), arg1), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(m602(1, 19, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffcde)
		}

		NAnd(0, arg1, Local0)
		m600(arg0, 36, Local0, 0xffffffffffffffff)

		NAnd(0xffffffffffffffff, arg1, Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffcde)

		NAnd(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0xffffffffffffffff)

		NAnd(auij, arg1, Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffcde)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0xffffffffffffffff)

			NAnd(Derefof(Refof(auij)), arg1, Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffcde)
		}

		NAnd(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0xffffffffffffffff)

		NAnd(Derefof(Index(paui, 19)), arg1, Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		NAnd(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0xffffffffffffffff)

		NAnd(m601(1, 19), arg1, Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0xffffffffffffffff)

			NAnd(Derefof(m602(1, 19, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffcde)
		}
	}

	// NAnd, 64-bit
	Method(m011, 3)
	{
		// Conversion of the first operand

		Store(NAnd(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xffffffffffffffff)

		Store(NAnd(arg2, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x01834c6e29af5d7b)

		Store(NAnd(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffffffffffff)

		Store(NAnd(arg2, auij), Local0)
		m600(arg0, 3, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(NAnd(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffffffffffff)

			Store(NAnd(arg2, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x01834c6e29af5d7b)
		}

		Store(NAnd(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffffffffffff)

		Store(NAnd(arg2, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(NAnd(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffffffffffff)

		Store(NAnd(arg2, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffffffffffff)

			Store(NAnd(arg2, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xffffffffffffffff)

		NAnd(arg2, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x01834c6e29af5d7b)

		NAnd(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffffffffffff)

		NAnd(arg2, auij, Local0)
		m600(arg0, 15, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			NAnd(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffffffffffff)

			NAnd(arg2, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffffffffffff)

		NAnd(arg2, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		NAnd(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffffffffffff)

		NAnd(arg2, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffffffffffff)

			NAnd(arg2, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the second operand

		Store(NAnd(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xffffffffffffffff)

		Store(NAnd(0xffffffffffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7b)

		Store(NAnd(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xffffffffffffffff)

		Store(NAnd(auij, arg2), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(Refof(auij)), arg2), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7b)
		}

		Store(NAnd(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xffffffffffffffff)

		Store(NAnd(Derefof(Index(paui, 19)), arg2), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(NAnd(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xffffffffffffffff)

		Store(NAnd(m601(1, 19), arg2), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(m602(1, 19, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xffffffffffffffff)

		NAnd(0xffffffffffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7b)

		NAnd(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xffffffffffffffff)

		NAnd(auij, arg2, Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xffffffffffffffff)

			NAnd(Derefof(Refof(auij)), arg2, Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xffffffffffffffff)

		NAnd(Derefof(Index(paui, 19)), arg2, Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		NAnd(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xffffffffffffffff)

		NAnd(m601(1, 19), arg2, Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xffffffffffffffff)

			NAnd(Derefof(m602(1, 19, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the both operands

		Store(NAnd(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xfffffffffffffdff)

		Store(NAnd(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xfffffffffffffdff)

		NAnd(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xfffffffffffffdff)

		NAnd(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xfffffffffffffdff)
	}

	// NAnd, 32-bit
	Method(m012, 3)
	{
		// Conversion of the first operand

		Store(NAnd(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xffffffff)

		Store(NAnd(arg2, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0x3e864c01)

		Store(NAnd(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffff)

		Store(NAnd(arg2, auii), Local0)
		m600(arg0, 3, Local0, 0x3e864c01)

		if (y078) {
			Store(NAnd(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffff)

			Store(NAnd(arg2, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0x3e864c01)
		}

		Store(NAnd(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffff)

		Store(NAnd(arg2, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0x3e864c01)

		// Method returns Integer

		Store(NAnd(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffff)

		Store(NAnd(arg2, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffff)

			Store(NAnd(arg2, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0x3e864c01)
		}

		NAnd(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xffffffff)

		NAnd(arg2, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0x3e864c01)

		NAnd(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffff)

		NAnd(arg2, auii, Local0)
		m600(arg0, 15, Local0, 0x3e864c01)

		if (y078) {
			NAnd(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffff)

			NAnd(arg2, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0x3e864c01)
		}

		NAnd(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffff)

		NAnd(arg2, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0x3e864c01)

		// Method returns Integer

		NAnd(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffff)

		NAnd(arg2, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffff)

			NAnd(arg2, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0x3e864c01)
		}

		// Conversion of the second operand

		Store(NAnd(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xffffffff)

		Store(NAnd(0xffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0x3e864c01)

		Store(NAnd(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xffffffff)

		Store(NAnd(auii, arg2), Local0)
		m600(arg0, 27, Local0, 0x3e864c01)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xffffffff)

			Store(NAnd(Derefof(Refof(auii)), arg2), Local0)
			m600(arg0, 29, Local0, 0x3e864c01)
		}

		Store(NAnd(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xffffffff)

		Store(NAnd(Derefof(Index(paui, 18)), arg2), Local0)
		m600(arg0, 31, Local0, 0x3e864c01)

		// Method returns Integer

		Store(NAnd(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xffffffff)

		Store(NAnd(m601(1, 18), arg2), Local0)
		m600(arg0, 33, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xffffffff)

			Store(NAnd(Derefof(m602(1, 18, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x3e864c01)
		}

		NAnd(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xffffffff)

		NAnd(0xffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0x3e864c01)

		NAnd(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xffffffff)

		NAnd(auii, arg2, Local0)
		m600(arg0, 39, Local0, 0x3e864c01)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xffffffff)

			NAnd(Derefof(Refof(auii)), arg2, Local0)
			m600(arg0, 41, Local0, 0x3e864c01)
		}

		NAnd(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xffffffff)

		NAnd(Derefof(Index(paui, 18)), arg2, Local0)
		m600(arg0, 43, Local0, 0x3e864c01)

		// Method returns Integer

		NAnd(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xffffffff)

		NAnd(m601(1, 18), arg2, Local0)
		m600(arg0, 45, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xffffffff)

			NAnd(Derefof(m602(1, 18, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x3e864c01)
		}

		// Conversion of the both operands

		Store(NAnd(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xfffffcdf)

		Store(NAnd(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xfffffcdf)

		NAnd(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xfffffcdf)

		NAnd(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xfffffcdf)
	}

	// NOr, common 32-bit/64-bit test
	Method(m013, 2)
	{
		// Conversion of the first operand

		Store(NOr(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0xfffffffffffffcde)

		Store(NOr(arg1, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0xfffffffffffffcde)

		Store(NOr(arg1, auij), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfffffffffffffcde)

			Store(NOr(arg1, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfffffffffffffcde)

		Store(NOr(arg1, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfffffffffffffcde)

		Store(NOr(arg1, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfffffffffffffcde)

			Store(NOr(arg1, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0xfffffffffffffcde)

		NOr(arg1, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0xfffffffffffffcde)

		NOr(arg1, auij, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfffffffffffffcde)

			NOr(arg1, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfffffffffffffcde)

		NOr(arg1, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfffffffffffffcde)

		NOr(arg1, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfffffffffffffcde)

			NOr(arg1, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, arg1), Local0)
		m600(arg0, 24, Local0, 0xfffffffffffffcde)

		Store(NOr(0xffffffffffffffff, arg1), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0xfffffffffffffcde)

		Store(NOr(auij, arg1), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0xfffffffffffffcde)

			Store(NOr(Derefof(Refof(auij)), arg1), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0xfffffffffffffcde)

		Store(NOr(Derefof(Index(paui, 19)), arg1), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0xfffffffffffffcde)

		Store(NOr(m601(1, 19), arg1), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0xfffffffffffffcde)

			Store(NOr(Derefof(m602(1, 19, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, arg1, Local0)
		m600(arg0, 36, Local0, 0xfffffffffffffcde)

		NOr(0xffffffffffffffff, arg1, Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0xfffffffffffffcde)

		NOr(auij, arg1, Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0xfffffffffffffcde)

			NOr(Derefof(Refof(auij)), arg1, Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0xfffffffffffffcde)

		NOr(Derefof(Index(paui, 19)), arg1, Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0xfffffffffffffcde)

		NOr(m601(1, 19), arg1, Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0xfffffffffffffcde)

			NOr(Derefof(m602(1, 19, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0)
		}
	}

	// NOr, 64-bit
	Method(m014, 3)
	{
		// Conversion of the first operand

		Store(NOr(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0x01834c6e29af5d7b)

		Store(NOr(arg2, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0x01834c6e29af5d7b)

		Store(NOr(arg2, auij), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x01834c6e29af5d7b)

			Store(NOr(arg2, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x01834c6e29af5d7b)

		Store(NOr(arg2, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x01834c6e29af5d7b)

		Store(NOr(arg2, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x01834c6e29af5d7b)

			Store(NOr(arg2, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0x01834c6e29af5d7b)

		NOr(arg2, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0x01834c6e29af5d7b)

		NOr(arg2, auij, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x01834c6e29af5d7b)

			NOr(arg2, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x01834c6e29af5d7b)

		NOr(arg2, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x01834c6e29af5d7b)

		NOr(arg2, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x01834c6e29af5d7b)

			NOr(arg2, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, arg2), Local0)
		m600(arg0, 24, Local0, 0x01834c6e29af5d7b)

		Store(NOr(0xffffffffffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0x01834c6e29af5d7b)

		Store(NOr(auij, arg2), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0x01834c6e29af5d7b)

			Store(NOr(Derefof(Refof(auij)), arg2), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0x01834c6e29af5d7b)

		Store(NOr(Derefof(Index(paui, 19)), arg2), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0x01834c6e29af5d7b)

		Store(NOr(m601(1, 19), arg2), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0x01834c6e29af5d7b)

			Store(NOr(Derefof(m602(1, 19, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, arg2, Local0)
		m600(arg0, 36, Local0, 0x01834c6e29af5d7b)

		NOr(0xffffffffffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0x01834c6e29af5d7b)

		NOr(auij, arg2, Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0x01834c6e29af5d7b)

			NOr(Derefof(Refof(auij)), arg2, Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0x01834c6e29af5d7b)

		NOr(Derefof(Index(paui, 19)), arg2, Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0x01834c6e29af5d7b)

		NOr(m601(1, 19), arg2, Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0x01834c6e29af5d7b)

			NOr(Derefof(m602(1, 19, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0)
		}

		// Conversion of the both operands

		Store(NOr(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x01834c6e29af5c5a)

		Store(NOr(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x01834c6e29af5c5a)

		NOr(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x01834c6e29af5c5a)

		NOr(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x01834c6e29af5c5a)
	}

	// NOr, 32-bit
	Method(m015, 3)
	{
		// Conversion of the first operand

		Store(NOr(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0x3e864c01)

		Store(NOr(arg2, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0x3e864c01)

		Store(NOr(arg2, auii), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x3e864c01)

			Store(NOr(arg2, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x3e864c01)

		Store(NOr(arg2, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x3e864c01)

		Store(NOr(arg2, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x3e864c01)

			Store(NOr(arg2, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0x3e864c01)

		NOr(arg2, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0x3e864c01)

		NOr(arg2, auii, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x3e864c01)

			NOr(arg2, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x3e864c01)

		NOr(arg2, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x3e864c01)

		NOr(arg2, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x3e864c01)

			NOr(arg2, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, arg2), Local0)
		m600(arg0, 24, Local0, 0x3e864c01)

		Store(NOr(0xffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0x3e864c01)

		Store(NOr(auii, arg2), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0x3e864c01)

			Store(NOr(Derefof(Refof(auii)), arg2), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0x3e864c01)

		Store(NOr(Derefof(Index(paui, 18)), arg2), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0x3e864c01)

		Store(NOr(m601(1, 18), arg2), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0x3e864c01)

			Store(NOr(Derefof(m602(1, 18, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, arg2, Local0)
		m600(arg0, 36, Local0, 0x3e864c01)

		NOr(0xffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0x3e864c01)

		NOr(auii, arg2, Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0x3e864c01)

			NOr(Derefof(Refof(auii)), arg2, Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0x3e864c01)

		NOr(Derefof(Index(paui, 18)), arg2, Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0x3e864c01)

		NOr(m601(1, 18), arg2, Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0x3e864c01)

			NOr(Derefof(m602(1, 18, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0)
		}

		// Conversion of the both operands

		Store(NOr(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x3e864c00)

		Store(NOr(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x3e864c00)

		NOr(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x3e864c00)

		NOr(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x3e864c00)
	}

	// Or, common 32-bit/64-bit test
	Method(m016, 2)
	{
		// Conversion of the first operand

		Store(Or(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Or(arg1, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffffffffffff)

		Store(Or(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Or(arg1, auij), Local0)
		m600(arg0, 3, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Or(arg1, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xffffffffffffffff)
		}

		Store(Or(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Or(arg1, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Or(arg1, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Or(arg1, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffffffffffff)
		}

		Or(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Or(arg1, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffffffffffff)

		Or(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Or(arg1, auij, Local0)
		m600(arg0, 15, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Or(arg1, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xffffffffffffffff)
		}

		Or(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Or(arg1, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Or(arg1, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Or(arg1, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffffffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, arg1), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(Or(0xffffffffffffffff, arg1), Local0)
		m600(arg0, 25, Local0, 0xffffffffffffffff)

		Store(Or(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(Or(auij, arg1), Local0)
		m600(arg0, 27, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(Or(Derefof(Refof(auij)), arg1), Local0)
			m600(arg0, 29, Local0, 0xffffffffffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(Or(Derefof(Index(paui, 19)), arg1), Local0)
		m600(arg0, 31, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(Or(m601(1, 19), arg1), Local0)
		m600(arg0, 33, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(Or(Derefof(m602(1, 19, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0xffffffffffffffff)
		}

		Or(0, arg1, Local0)
		m600(arg0, 36, Local0, 0x321)

		Or(0xffffffffffffffff, arg1, Local0)
		m600(arg0, 37, Local0, 0xffffffffffffffff)

		Or(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0x321)

		Or(auij, arg1, Local0)
		m600(arg0, 39, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0x321)

			Or(Derefof(Refof(auij)), arg1, Local0)
			m600(arg0, 41, Local0, 0xffffffffffffffff)
		}

		Or(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0x321)

		Or(Derefof(Index(paui, 19)), arg1, Local0)
		m600(arg0, 43, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0x321)

		Or(m601(1, 19), arg1, Local0)
		m600(arg0, 45, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0x321)

			Or(Derefof(m602(1, 19, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0xffffffffffffffff)
		}
	}

	// Or, 64-bit
	Method(m017, 3)
	{
		// Conversion of the first operand

		Store(Or(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Or(arg2, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffffffffffff)

		Store(Or(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Or(arg2, auij), Local0)
		m600(arg0, 3, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Or(arg2, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xffffffffffffffff)
		}

		Store(Or(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Or(arg2, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Or(arg2, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Or(arg2, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffffffffffff)
		}

		Or(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Or(arg2, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffffffffffff)

		Or(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Or(arg2, auij, Local0)
		m600(arg0, 15, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Or(arg2, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xffffffffffffffff)
		}

		Or(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Or(arg2, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Or(arg2, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Or(arg2, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffffffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(Or(0xffffffffffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0xffffffffffffffff)

		Store(Or(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(Or(auij, arg2), Local0)
		m600(arg0, 27, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(Or(Derefof(Refof(auij)), arg2), Local0)
			m600(arg0, 29, Local0, 0xffffffffffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(Or(Derefof(Index(paui, 19)), arg2), Local0)
		m600(arg0, 31, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(Or(m601(1, 19), arg2), Local0)
		m600(arg0, 33, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(Or(Derefof(m602(1, 19, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xffffffffffffffff)
		}

		Or(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		Or(0xffffffffffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0xffffffffffffffff)

		Or(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		Or(auij, arg2, Local0)
		m600(arg0, 39, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			Or(Derefof(Refof(auij)), arg2, Local0)
			m600(arg0, 41, Local0, 0xffffffffffffffff)
		}

		Or(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		Or(Derefof(Index(paui, 19)), arg2, Local0)
		m600(arg0, 43, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		Or(m601(1, 19), arg2, Local0)
		m600(arg0, 45, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			Or(Derefof(m602(1, 19, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xffffffffffffffff)
		}

		// Conversion of the both operands

		Store(Or(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a3a5)

		Store(Or(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a3a5)

		Or(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a3a5)

		Or(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a3a5)
	}

	// Or, 32-bit
	Method(m018, 3)
	{
		// Conversion of the first operand

		Store(Or(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(Or(arg2, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffff)

		Store(Or(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(Or(arg2, auii), Local0)
		m600(arg0, 3, Local0, 0xffffffff)

		if (y078) {
			Store(Or(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(Or(arg2, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0xffffffff)
		}

		Store(Or(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(Or(arg2, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0xffffffff)

		// Method returns Integer

		Store(Or(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(Or(arg2, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(Or(arg2, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffff)
		}

		Or(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		Or(arg2, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffff)

		Or(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		Or(arg2, auii, Local0)
		m600(arg0, 15, Local0, 0xffffffff)

		if (y078) {
			Or(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			Or(arg2, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0xffffffff)
		}

		Or(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		Or(arg2, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0xffffffff)

		// Method returns Integer

		Or(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		Or(arg2, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			Or(arg2, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xc179b3fe)

		Store(Or(0xffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0xffffffff)

		Store(Or(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xc179b3fe)

		Store(Or(auii, arg2), Local0)
		m600(arg0, 27, Local0, 0xffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xc179b3fe)

			Store(Or(Derefof(Refof(auii)), arg2), Local0)
			m600(arg0, 29, Local0, 0xffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xc179b3fe)

		Store(Or(Derefof(Index(paui, 18)), arg2), Local0)
		m600(arg0, 31, Local0, 0xffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xc179b3fe)

		Store(Or(m601(1, 18), arg2), Local0)
		m600(arg0, 33, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xc179b3fe)

			Store(Or(Derefof(m602(1, 18, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xffffffff)
		}

		Or(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xc179b3fe)

		Or(0xffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0xffffffff)

		Or(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xc179b3fe)

		Or(auii, arg2, Local0)
		m600(arg0, 39, Local0, 0xffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xc179b3fe)

			Or(Derefof(Refof(auii)), arg2, Local0)
			m600(arg0, 41, Local0, 0xffffffff)
		}

		Or(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xc179b3fe)

		Or(Derefof(Index(paui, 18)), arg2, Local0)
		m600(arg0, 43, Local0, 0xffffffff)

		// Method returns Integer

		Or(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xc179b3fe)

		Or(m601(1, 18), arg2, Local0)
		m600(arg0, 45, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xc179b3fe)

			Or(Derefof(m602(1, 18, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xffffffff)
		}

		// Conversion of the both operands

		Store(Or(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xc179b3ff)

		Store(Or(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xc179b3ff)

		Or(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xc179b3ff)

		Or(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xc179b3ff)
	}

	// ShiftLeft, common 32-bit/64-bit test
	Method(m019, 3)
	{
		// Conversion of the first operand

		Store(ShiftLeft(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(ShiftLeft(arg1, 1), Local0)
		m600(arg0, 1, Local0, 0x642)

		Store(ShiftLeft(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(ShiftLeft(arg1, aui6), Local0)
		m600(arg0, 3, Local0, 0x642)

		if (y078) {
			Store(ShiftLeft(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(ShiftLeft(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x642)
		}

		Store(ShiftLeft(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(ShiftLeft(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x642)

		// Method returns Integer

		Store(ShiftLeft(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(ShiftLeft(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x642)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(ShiftLeft(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x642)
		}

		ShiftLeft(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		ShiftLeft(arg1, 1, Local0)
		m600(arg0, 13, Local0, 0x642)

		ShiftLeft(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		ShiftLeft(arg1, aui6, Local0)
		m600(arg0, 15, Local0, 0x642)

		if (y078) {
			ShiftLeft(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			ShiftLeft(arg1, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x642)
		}

		ShiftLeft(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		ShiftLeft(arg1, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x642)

		// Method returns Integer

		ShiftLeft(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		ShiftLeft(arg1, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x642)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			ShiftLeft(arg1, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x642)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, arg2), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, arg2, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, arg2, Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x800)
		}
	}

	// ShiftLeft, 64-bit
	Method(m01a, 4)
	{
		// Conversion of the first operand

		Store(ShiftLeft(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xfcf96723aca14508)

		Store(ShiftLeft(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xfcf96723aca14508)

		if (y078) {
			Store(ShiftLeft(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(ShiftLeft(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfcf96723aca14508)
		}

		Store(ShiftLeft(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfcf96723aca14508)

		// Method returns Integer

		Store(ShiftLeft(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfcf96723aca14508)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(ShiftLeft(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfcf96723aca14508)
		}

		ShiftLeft(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		ShiftLeft(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xfcf96723aca14508)

		ShiftLeft(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		ShiftLeft(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xfcf96723aca14508)

		if (y078) {
			ShiftLeft(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			ShiftLeft(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfcf96723aca14508)
		}

		ShiftLeft(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		ShiftLeft(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfcf96723aca14508)

		// Method returns Integer

		ShiftLeft(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		ShiftLeft(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfcf96723aca14508)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			ShiftLeft(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfcf96723aca14508)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, arg3), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, arg3), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, arg3), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, arg3), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), arg3), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), arg3), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), arg3), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), arg3), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), arg3), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), arg3), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), arg3), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), arg3), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, arg3, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, arg3, Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, arg3, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, arg3, Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), arg3, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), arg3, Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), arg3, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), arg3, Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), arg3, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), arg3, Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), arg3, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), arg3, Local0)
			m600(arg0, 47, Local0, 0x800)
		}

		// Conversion of the both operands

		Store(ShiftLeft(arg1, arg3), Local0)
		m600(arg0, 48, Local0, 0x190800)

		Store(ShiftLeft(arg2, arg3), Local0)
		m600(arg0, 49, Local0, 0xE59C8EB285142000)

		ShiftLeft(arg1, arg3, Local0)
		m600(arg0, 50, Local0, 0x190800)

		ShiftLeft(arg2, arg3, Local0)
		m600(arg0, 51, Local0, 0xE59C8EB285142000)
	}

	// ShiftLeft, 32-bit
	Method(m01b, 4)
	{
		// Conversion of the first operand

		Store(ShiftLeft(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(ShiftLeft(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0x82f367fc)

		Store(ShiftLeft(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(ShiftLeft(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0x82f367fc)

		if (y078) {
			Store(ShiftLeft(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(ShiftLeft(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x82f367fc)
		}

		Store(ShiftLeft(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(ShiftLeft(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x82f367fc)

		// Method returns Integer

		Store(ShiftLeft(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(ShiftLeft(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x82f367fc)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(ShiftLeft(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x82f367fc)
		}

		ShiftLeft(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		ShiftLeft(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0x82f367fc)

		ShiftLeft(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		ShiftLeft(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0x82f367fc)

		if (y078) {
			ShiftLeft(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			ShiftLeft(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x82f367fc)
		}

		ShiftLeft(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		ShiftLeft(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x82f367fc)

		// Method returns Integer

		ShiftLeft(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		ShiftLeft(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x82f367fc)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			ShiftLeft(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x82f367fc)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, arg3), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, arg3), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, arg3), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, arg3), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), arg3), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), arg3), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), arg3), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), arg3), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), arg3), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), arg3), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), arg3), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), arg3), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, arg3, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, arg3, Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, arg3, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, arg3, Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), arg3, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), arg3, Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), arg3, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), arg3, Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), arg3, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), arg3, Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), arg3, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), arg3, Local0)
			m600(arg0, 47, Local0, 0x800)
		}

		// Conversion of the both operands

		Store(ShiftLeft(arg1, arg3), Local0)
		m600(arg0, 48, Local0, 0x190800)

		Store(ShiftLeft(arg2, arg3), Local0)
		m600(arg0, 49, Local0, 0xcd9ff000)

		ShiftLeft(arg1, arg3, Local0)
		m600(arg0, 50, Local0, 0x190800)

		ShiftLeft(arg2, arg3, Local0)
		m600(arg0, 51, Local0, 0xcd9ff000)
	}

	// ShiftRight, common 32-bit/64-bit test
	Method(m01c, 3)
	{
		// Conversion of the first operand

		Store(ShiftRight(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(ShiftRight(arg1, 1), Local0)
		m600(arg0, 1, Local0, 0x190)

		Store(ShiftRight(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(ShiftRight(arg1, aui6), Local0)
		m600(arg0, 3, Local0, 0x190)

		if (y078) {
			Store(ShiftRight(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(ShiftRight(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x190)
		}

		Store(ShiftRight(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(ShiftRight(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x190)

		// Method returns Integer

		Store(ShiftRight(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(ShiftRight(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x190)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(ShiftRight(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x190)
		}

		ShiftRight(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		ShiftRight(arg1, 1, Local0)
		m600(arg0, 13, Local0, 0x190)

		ShiftRight(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		ShiftRight(arg1, aui6, Local0)
		m600(arg0, 15, Local0, 0x190)

		if (y078) {
			ShiftRight(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			ShiftRight(arg1, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x190)
		}

		ShiftRight(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		ShiftRight(arg1, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x190)

		// Method returns Integer

		ShiftRight(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		ShiftRight(arg1, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x190)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			ShiftRight(arg1, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x190)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xc179b3fe, arg2), Local0)
		m600(arg0, 25, Local0, 0x182f36)

		Store(ShiftRight(aui1, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(aui3, arg2), Local0)
		m600(arg0, 27, Local0, 0x182f36)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(aui3)), arg2), Local0)
			m600(arg0, 29, Local0, 0x182f36)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 3)), arg2), Local0)
		m600(arg0, 31, Local0, 0x182f36)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 3), arg2), Local0)
		m600(arg0, 33, Local0, 0x182f36)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 3, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x182f36)
		}

		ShiftRight(0x321, arg2, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xc179b3fe, arg2, Local0)
		m600(arg0, 37, Local0, 0x182f36)

		ShiftRight(aui1, arg2, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(aui3, arg2, Local0)
		m600(arg0, 39, Local0, 0x182f36)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), arg2, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(aui3)), arg2, Local0)
			m600(arg0, 41, Local0, 0x182f36)
		}

		ShiftRight(Derefof(Index(paui, 1)), arg2, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 3)), arg2, Local0)
		m600(arg0, 43, Local0, 0x182f36)

		// Method returns Integer

		ShiftRight(m601(1, 1), arg2, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 3), arg2, Local0)
		m600(arg0, 45, Local0, 0x182f36)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 3, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x182f36)
		}
	}

	// ShiftRight, 64-bit
	Method(m01d, 4)
	{
		// Conversion of the first operand

		Store(ShiftRight(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0x7f3e59c8eb285142)

		Store(ShiftRight(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0x7f3e59c8eb285142)

		if (y078) {
			Store(ShiftRight(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(ShiftRight(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x7f3e59c8eb285142)
		}

		Store(ShiftRight(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x7f3e59c8eb285142)

		// Method returns Integer

		Store(ShiftRight(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x7f3e59c8eb285142)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(ShiftRight(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x7f3e59c8eb285142)
		}

		ShiftRight(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		ShiftRight(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0x7f3e59c8eb285142)

		ShiftRight(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		ShiftRight(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0x7f3e59c8eb285142)

		if (y078) {
			ShiftRight(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			ShiftRight(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x7f3e59c8eb285142)
		}

		ShiftRight(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		ShiftRight(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x7f3e59c8eb285142)

		// Method returns Integer

		ShiftRight(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		ShiftRight(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x7f3e59c8eb285142)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			ShiftRight(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x7f3e59c8eb285142)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, arg3), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xfe7cb391d650a284, arg3), Local0)
		m600(arg0, 25, Local0, 0x1fcf96723aca14)

		Store(ShiftRight(aui1, arg3), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(aui4, arg3), Local0)
		m600(arg0, 27, Local0, 0x1fcf96723aca14)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), arg3), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(aui4)), arg3), Local0)
			m600(arg0, 29, Local0, 0x1fcf96723aca14)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), arg3), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 4)), arg3), Local0)
		m600(arg0, 31, Local0, 0x1fcf96723aca14)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), arg3), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 4), arg3), Local0)
		m600(arg0, 33, Local0, 0x1fcf96723aca14)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), arg3), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 4, 1)), arg3), Local0)
			m600(arg0, 35, Local0, 0x1fcf96723aca14)
		}

		ShiftRight(0x321, arg3, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xfe7cb391d650a284, arg3, Local0)
		m600(arg0, 37, Local0, 0x1fcf96723aca14)

		ShiftRight(aui1, arg3, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(aui4, arg3, Local0)
		m600(arg0, 39, Local0, 0x1fcf96723aca14)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), arg3, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(aui4)), arg3, Local0)
			m600(arg0, 41, Local0, 0x1fcf96723aca14)
		}

		ShiftRight(Derefof(Index(paui, 1)), arg3, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 4)), arg3, Local0)
		m600(arg0, 43, Local0, 0x1fcf96723aca14)

		// Method returns Integer

		ShiftRight(m601(1, 1), arg3, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 4), arg3, Local0)
		m600(arg0, 45, Local0, 0x1fcf96723aca14)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), arg3, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 4, 1)), arg3, Local0)
			m600(arg0, 47, Local0, 0x1fcf96723aca14)
		}

		// Conversion of the both operands

		Store(ShiftRight(arg1, arg3), Local0)
		m600(arg0, 48, Local0, 0)

		Store(ShiftRight(arg2, arg3), Local0)
		m600(arg0, 49, Local0, 0x1fcf96723aca14)

		ShiftRight(arg1, arg3, Local0)
		m600(arg0, 50, Local0, 0)

		ShiftRight(arg2, arg3, Local0)
		m600(arg0, 51, Local0, 0x1fcf96723aca14)
	}

	// ShiftRight, 32-bit
	Method(m01e, 4)
	{
		// Conversion of the first operand

		Store(ShiftRight(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(ShiftRight(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0x60bcd9ff)

		Store(ShiftRight(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(ShiftRight(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0x60bcd9ff)

		if (y078) {
			Store(ShiftRight(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(ShiftRight(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x60bcd9ff)
		}

		Store(ShiftRight(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(ShiftRight(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x60bcd9ff)

		// Method returns Integer

		Store(ShiftRight(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(ShiftRight(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x60bcd9ff)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(ShiftRight(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x60bcd9ff)
		}

		ShiftRight(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		ShiftRight(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0x60bcd9ff)

		ShiftRight(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		ShiftRight(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0x60bcd9ff)

		if (y078) {
			ShiftRight(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			ShiftRight(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x60bcd9ff)
		}

		ShiftRight(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		ShiftRight(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x60bcd9ff)

		// Method returns Integer

		ShiftRight(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		ShiftRight(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x60bcd9ff)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			ShiftRight(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x60bcd9ff)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, arg3), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xc179b3fe, arg3), Local0)
		m600(arg0, 25, Local0, 0x182f36)

		Store(ShiftRight(aui1, arg3), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(aui3, arg3), Local0)
		m600(arg0, 27, Local0, 0x182f36)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), arg3), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(aui3)), arg3), Local0)
			m600(arg0, 29, Local0, 0x182f36)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), arg3), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 3)), arg3), Local0)
		m600(arg0, 31, Local0, 0x182f36)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), arg3), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 3), arg3), Local0)
		m600(arg0, 33, Local0, 0x182f36)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), arg3), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 3, 1)), arg3), Local0)
			m600(arg0, 35, Local0, 0x182f36)
		}

		ShiftRight(0x321, arg3, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xc179b3fe, arg3, Local0)
		m600(arg0, 37, Local0, 0x182f36)

		ShiftRight(aui1, arg3, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(aui3, arg3, Local0)
		m600(arg0, 39, Local0, 0x182f36)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), arg3, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(aui3)), arg3, Local0)
			m600(arg0, 41, Local0, 0x182f36)
		}

		ShiftRight(Derefof(Index(paui, 1)), arg3, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 3)), arg3, Local0)
		m600(arg0, 43, Local0, 0x182f36)

		// Method returns Integer

		ShiftRight(m601(1, 1), arg3, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 3), arg3, Local0)
		m600(arg0, 45, Local0, 0x182f36)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), arg3, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 3, 1)), arg3, Local0)
			m600(arg0, 47, Local0, 0x182f36)
		}

		// Conversion of the both operands

		Store(ShiftRight(arg1, arg3), Local0)
		m600(arg0, 48, Local0, 0)

		Store(ShiftRight(arg2, arg3), Local0)
		m600(arg0, 49, Local0, 0x182f36)

		ShiftRight(arg1, arg3, Local0)
		m600(arg0, 50, Local0, 0)

		ShiftRight(arg2, arg3, Local0)
		m600(arg0, 51, Local0, 0x182f36)
	}

	// Subtract, common 32-bit/64-bit test
	Method(m01f, 2)
	{
		// Conversion of the first operand

		Store(Subtract(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Subtract(arg1, 1), Local0)
		m600(arg0, 1, Local0, 0x320)

		Store(Subtract(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Subtract(arg1, aui6), Local0)
		m600(arg0, 3, Local0, 0x320)

		if (y078) {
			Store(Subtract(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Subtract(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x320)
		}

		Store(Subtract(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Subtract(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x320)

		// Method returns Integer

		Store(Subtract(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Subtract(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Subtract(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x320)
		}

		Subtract(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Subtract(arg1, 1, Local0)
		m600(arg0, 13, Local0, 0x320)

		Subtract(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Subtract(arg1, aui6, Local0)
		m600(arg0, 15, Local0, 0x320)

		if (y078) {
			Subtract(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Subtract(arg1, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x320)
		}

		Subtract(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Subtract(arg1, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x320)

		// Method returns Integer

		Subtract(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Subtract(arg1, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Subtract(arg1, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x320)
		}

		// Conversion of the second operand

		Store(Subtract(0, arg1), Local0)
		m600(arg0, 24, Local0, 0xfffffffffffffcdf)

		Store(Subtract(1, arg1), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffce0)

		Store(Subtract(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0xfffffffffffffcdf)

		Store(Subtract(aui6, arg1), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffce0)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0xfffffffffffffcdf)

			Store(Subtract(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffce0)
		}

		Store(Subtract(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0xfffffffffffffcdf)

		Store(Subtract(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffce0)

		// Method returns Integer

		Store(Subtract(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0xfffffffffffffcdf)

		Store(Subtract(m601(1, 6), arg1), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffce0)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0xfffffffffffffcdf)

			Store(Subtract(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffce0)
		}

		Subtract(0, arg1, Local0)
		m600(arg0, 36, Local0, 0xfffffffffffffcdf)

		Subtract(1, arg1, Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffce0)

		Subtract(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0xfffffffffffffcdf)

		Subtract(aui6, arg1, Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffce0)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0xfffffffffffffcdf)

			Subtract(Derefof(Refof(aui6)), arg1, Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffce0)
		}

		Subtract(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0xfffffffffffffcdf)

		Subtract(Derefof(Index(paui, 6)), arg1, Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffce0)

		// Method returns Integer

		Subtract(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0xfffffffffffffcdf)

		Subtract(m601(1, 6), arg1, Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffce0)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0xfffffffffffffcdf)

			Subtract(Derefof(m602(1, 6, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffce0)
		}
	}

	// Subtract, 64-bit
	Method(m020, 3)
	{
		// Conversion of the first operand

		Store(Subtract(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Subtract(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a283)

		Store(Subtract(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Subtract(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Store(Subtract(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Subtract(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a283)
		}

		Store(Subtract(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Subtract(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Store(Subtract(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Subtract(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Subtract(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a283)
		}

		Subtract(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Subtract(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a283)

		Subtract(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Subtract(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Subtract(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Subtract(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a283)
		}

		Subtract(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Subtract(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Subtract(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Subtract(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Subtract(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a283)
		}

		// Conversion of the second operand

		Store(Subtract(0, arg2), Local0)
		m600(arg0, 24, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(1, arg2), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7d)

		Store(Subtract(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7d)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0x01834c6e29af5d7c)

			Store(Subtract(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7d)
		}

		Store(Subtract(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7d)

		// Method returns Integer

		Store(Subtract(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0x01834c6e29af5d7c)

			Store(Subtract(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7d)
		}

		Subtract(0, arg2, Local0)
		m600(arg0, 36, Local0, 0x01834c6e29af5d7c)

		Subtract(1, arg2, Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7d)

		Subtract(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0x01834c6e29af5d7c)

		Subtract(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7d)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0x01834c6e29af5d7c)

			Subtract(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7d)
		}

		Subtract(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0x01834c6e29af5d7c)

		Subtract(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7d)

		// Method returns Integer

		Subtract(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0x01834c6e29af5d7c)

		Subtract(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0x01834c6e29af5d7c)

			Subtract(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7d)
		}

		// Conversion of the both operands

		Store(Subtract(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x01834c6e29af609d)

		Store(Subtract(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d6509f63)

		Subtract(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x01834c6e29af609d)

		Subtract(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d6509f63)
	}

	// Subtract, 32-bit
	Method(m021, 3)
	{
		// Conversion of the first operand

		Store(Subtract(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(Subtract(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xc179b3fd)

		Store(Subtract(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(Subtract(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xc179b3fd)

		if (y078) {
			Store(Subtract(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(Subtract(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xc179b3fd)
		}

		Store(Subtract(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(Subtract(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xc179b3fd)

		// Method returns Integer

		Store(Subtract(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(Subtract(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xc179b3fd)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(Subtract(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xc179b3fd)
		}

		Subtract(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		Subtract(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xc179b3fd)

		Subtract(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		Subtract(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xc179b3fd)

		if (y078) {
			Subtract(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			Subtract(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xc179b3fd)
		}

		Subtract(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		Subtract(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xc179b3fd)

		// Method returns Integer

		Subtract(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		Subtract(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xc179b3fd)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			Subtract(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xc179b3fd)
		}

		// Conversion of the second operand

		Store(Subtract(0, arg2), Local0)
		m600(arg0, 24, Local0, 0x3e864c02)

		Store(Subtract(1, arg2), Local0)
		m600(arg0, 25, Local0, 0x3e864c03)

		Store(Subtract(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0x3e864c02)

		Store(Subtract(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0x3e864c03)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0x3e864c02)

			Store(Subtract(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0x3e864c03)
		}

		Store(Subtract(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0x3e864c02)

		Store(Subtract(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0x3e864c03)

		// Method returns Integer

		Store(Subtract(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0x3e864c02)

		Store(Subtract(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0x3e864c03)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0x3e864c02)

			Store(Subtract(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x3e864c03)
		}

		Subtract(0, arg2, Local0)
		m600(arg0, 36, Local0, 0x3e864c02)

		Subtract(1, arg2, Local0)
		m600(arg0, 37, Local0, 0x3e864c03)

		Subtract(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0x3e864c02)

		Subtract(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0x3e864c03)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0x3e864c02)

			Subtract(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0x3e864c03)
		}

		Subtract(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0x3e864c02)

		Subtract(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0x3e864c03)

		// Method returns Integer

		Subtract(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0x3e864c02)

		Subtract(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0x3e864c03)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0x3e864c02)

			Subtract(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x3e864c03)
		}

		// Conversion of the both operands

		Store(Subtract(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x3e864f23)

		Store(Subtract(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xc179b0dd)

		Subtract(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x3e864f23)

		Subtract(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xc179b0dd)
	}

	// XOr, common 32-bit/64-bit test
	Method(m022, 2)
	{
		// Conversion of the first operand

		Store(XOr(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(XOr(arg1, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfffffffffffffcde)

		Store(XOr(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(XOr(arg1, auij), Local0)
		m600(arg0, 3, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(XOr(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(XOr(arg1, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfffffffffffffcde)
		}

		Store(XOr(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(XOr(arg1, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(XOr(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(XOr(arg1, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(XOr(arg1, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfffffffffffffcde)
		}

		XOr(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		XOr(arg1, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfffffffffffffcde)

		XOr(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		XOr(arg1, auij, Local0)
		m600(arg0, 15, Local0, 0xfffffffffffffcde)

		if (y078) {
			XOr(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			XOr(arg1, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfffffffffffffcde)
		}

		XOr(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		XOr(arg1, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		XOr(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		XOr(arg1, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			XOr(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			XOr(arg1, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfffffffffffffcde)
		}

		// Conversion of the second operand

		Store(XOr(0, arg1), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(XOr(0xffffffffffffffff, arg1), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffcde)

		Store(XOr(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(XOr(auij, arg1), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(XOr(Derefof(Refof(auij)), arg1), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffcde)
		}

		Store(XOr(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(XOr(Derefof(Index(paui, 19)), arg1), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(XOr(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(XOr(m601(1, 19), arg1), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(XOr(Derefof(m602(1, 19, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffcde)
		}

		XOr(0, arg1, Local0)
		m600(arg0, 36, Local0, 0x321)

		XOr(0xffffffffffffffff, arg1, Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffcde)

		XOr(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0x321)

		XOr(auij, arg1, Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffcde)

		if (y078) {
			XOr(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0x321)

			XOr(Derefof(Refof(auij)), arg1, Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffcde)
		}

		XOr(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0x321)

		XOr(Derefof(Index(paui, 19)), arg1, Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		XOr(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0x321)

		XOr(m601(1, 19), arg1, Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0x321)

			XOr(Derefof(m602(1, 19, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffcde)
		}
	}

	// XOr, 64-bit
	Method(m023, 3)
	{
		// Conversion of the first operand

		Store(XOr(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(XOr(arg2, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x01834c6e29af5d7b)

		Store(XOr(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(XOr(arg2, auij), Local0)
		m600(arg0, 3, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(XOr(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(XOr(arg2, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x01834c6e29af5d7b)
		}

		Store(XOr(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(XOr(arg2, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(XOr(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(XOr(arg2, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(XOr(arg2, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x01834c6e29af5d7b)
		}

		XOr(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		XOr(arg2, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x01834c6e29af5d7b)

		XOr(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		XOr(arg2, auij, Local0)
		m600(arg0, 15, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			XOr(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			XOr(arg2, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x01834c6e29af5d7b)
		}

		XOr(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		XOr(arg2, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		XOr(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		XOr(arg2, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			XOr(arg2, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the second operand

		Store(XOr(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(XOr(0xffffffffffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7b)

		Store(XOr(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(XOr(auij, arg2), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(XOr(Derefof(Refof(auij)), arg2), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7b)
		}

		Store(XOr(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(XOr(Derefof(Index(paui, 19)), arg2), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(XOr(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(XOr(m601(1, 19), arg2), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(XOr(Derefof(m602(1, 19, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7b)
		}

		XOr(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		XOr(0xffffffffffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7b)

		XOr(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		XOr(auij, arg2, Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			XOr(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			XOr(Derefof(Refof(auij)), arg2, Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7b)
		}

		XOr(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		XOr(Derefof(Index(paui, 19)), arg2, Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		XOr(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		XOr(m601(1, 19), arg2, Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			XOr(Derefof(m602(1, 19, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the both operands

		Store(XOr(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a1a5)

		Store(XOr(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a1a5)

		XOr(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a1a5)

		XOr(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a1a5)
	}

	// XOr, 32-bit
	Method(m024, 3)
	{
		// Conversion of the first operand

		Store(XOr(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(XOr(arg2, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0x3e864c01)

		Store(XOr(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(XOr(arg2, auii), Local0)
		m600(arg0, 3, Local0, 0x3e864c01)

		if (y078) {
			Store(XOr(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(XOr(arg2, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0x3e864c01)
		}

		Store(XOr(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(XOr(arg2, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0x3e864c01)

		// Method returns Integer

		Store(XOr(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(XOr(arg2, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(XOr(arg2, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0x3e864c01)
		}

		XOr(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		XOr(arg2, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0x3e864c01)

		XOr(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		XOr(arg2, auii, Local0)
		m600(arg0, 15, Local0, 0x3e864c01)

		if (y078) {
			XOr(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			XOr(arg2, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0x3e864c01)
		}

		XOr(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		XOr(arg2, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0x3e864c01)

		// Method returns Integer

		XOr(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		XOr(arg2, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			XOr(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			XOr(arg2, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0x3e864c01)
		}

		// Conversion of the second operand

		Store(XOr(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xc179b3fe)

		Store(XOr(0xffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0x3e864c01)

		Store(XOr(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xc179b3fe)

		Store(XOr(auii, arg2), Local0)
		m600(arg0, 27, Local0, 0x3e864c01)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xc179b3fe)

			Store(XOr(Derefof(Refof(auii)), arg2), Local0)
			m600(arg0, 29, Local0, 0x3e864c01)
		}

		Store(XOr(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xc179b3fe)

		Store(XOr(Derefof(Index(paui, 18)), arg2), Local0)
		m600(arg0, 31, Local0, 0x3e864c01)

		// Method returns Integer

		Store(XOr(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xc179b3fe)

		Store(XOr(m601(1, 18), arg2), Local0)
		m600(arg0, 33, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xc179b3fe)

			Store(XOr(Derefof(m602(1, 18, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x3e864c01)
		}

		XOr(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xc179b3fe)

		XOr(0xffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0x3e864c01)

		XOr(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xc179b3fe)

		XOr(auii, arg2, Local0)
		m600(arg0, 39, Local0, 0x3e864c01)

		if (y078) {
			XOr(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xc179b3fe)

			XOr(Derefof(Refof(auii)), arg2, Local0)
			m600(arg0, 41, Local0, 0x3e864c01)
		}

		XOr(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xc179b3fe)

		XOr(Derefof(Index(paui, 18)), arg2, Local0)
		m600(arg0, 43, Local0, 0x3e864c01)

		// Method returns Integer

		XOr(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xc179b3fe)

		XOr(m601(1, 18), arg2, Local0)
		m600(arg0, 45, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xc179b3fe)

			XOr(Derefof(m602(1, 18, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x3e864c01)
		}

		// Conversion of the both operands

		Store(XOr(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xc179b0df)

		Store(XOr(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xc179b0df)

		XOr(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xc179b0df)

		XOr(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xc179b0df)
	}

	// Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
	// ShiftLeft, ShiftRight, Subtract, Xor

	Method(m64d, 1)
	{
		// Add
		Concatenate(arg0, "-m001", Local0)
		SRMT(Local0)
		m001(Local0, "0321")
		Concatenate(arg0, "-m002", Local0)
		SRMT(Local0)
		m002(Local0, "0321", "FE7CB391D650A284")

		// And
		Concatenate(arg0, "-m004", Local0)
		SRMT(Local0)
		m004(Local0, "0321")
		Concatenate(arg0, "-m005", Local0)
		SRMT(Local0)
		m005(Local0, "0321", "FE7CB391D650A284")

		// Divide
		Concatenate(arg0, "-m007", Local0)
		SRMT(Local0)
		m007(Local0, "0321")
		Concatenate(arg0, "-m008", Local0)
		SRMT(Local0)
		m008(Local0, "0321", "FE7CB391D650A284")

		// Mod
		Concatenate(arg0, "-m00a", Local0)
		SRMT(Local0)
		m00a(Local0, "0321")
		Concatenate(arg0, "-m00b", Local0)
		SRMT(Local0)
		m00b(Local0, "0321", "FE7CB391D650A284")

		// Multiply
		Concatenate(arg0, "-m00d", Local0)
		SRMT(Local0)
		m00d(Local0, "0321")
		Concatenate(arg0, "-m00e", Local0)
		SRMT(Local0)
		m00e(Local0, "0321", "FE7CB391D650A284")

		// NAnd
		Concatenate(arg0, "-m010", Local0)
		SRMT(Local0)
		m010(Local0, "0321")
		Concatenate(arg0, "-m011", Local0)
		SRMT(Local0)
		m011(Local0, "0321", "FE7CB391D650A284")

		// NOr
		Concatenate(arg0, "-m013", Local0)
		SRMT(Local0)
		m013(Local0, "0321")
		Concatenate(arg0, "-m014", Local0)
		SRMT(Local0)
		m014(Local0, "0321", "FE7CB391D650A284")

		// Or
		Concatenate(arg0, "-m016", Local0)
		SRMT(Local0)
		m016(Local0, "0321")
		Concatenate(arg0, "-m017", Local0)
		SRMT(Local0)
		m017(Local0, "0321", "FE7CB391D650A284")

		// ShiftLeft
		Concatenate(arg0, "-m019", Local0)
		SRMT(Local0)
		m019(Local0, "0321", "B")
		Concatenate(arg0, "-m01a", Local0)
		SRMT(Local0)
		m01a(Local0, "0321", "FE7CB391D650A284", "B")

		// ShiftRight
		Concatenate(arg0, "-m01c", Local0)
		SRMT(Local0)
		m01c(Local0, "0321", "B")
		Concatenate(arg0, "-m01d", Local0)
		SRMT(Local0)
		m01d(Local0, "0321", "FE7CB391D650A284", "B")

		// Subtract
		Concatenate(arg0, "-m01f", Local0)
		SRMT(Local0)
		m01f(Local0, "0321")
		Concatenate(arg0, "-m020", Local0)
		SRMT(Local0)
		m020(Local0, "0321", "FE7CB391D650A284")

		// XOr
		Concatenate(arg0, "-m022", Local0)
		SRMT(Local0)
		m022(Local0, "0321")
		Concatenate(arg0, "-m023", Local0)
		SRMT(Local0)
		m023(Local0, "0321", "FE7CB391D650A284")
	}

	Method(m32d, 1)
	{
		// Add
		Concatenate(arg0, "-m001", Local0)
		SRMT(Local0)
		m001(Local0, "0321")
		Concatenate(arg0, "-m003", Local0)
		SRMT(Local0)
		m003(Local0, "0321", "C179B3FE")

		// And
		Concatenate(arg0, "-m004", Local0)
		SRMT(Local0)
		m004(Local0, "0321")
		Concatenate(arg0, "-m006", Local0)
		SRMT(Local0)
		m006(Local0, "0321", "C179B3FE")

		// Divide
		Concatenate(arg0, "-m007", Local0)
		SRMT(Local0)
		m007(Local0, "0321")
		Concatenate(arg0, "-m009", Local0)
		SRMT(Local0)
		m009(Local0, "0321", "C179B3FE")

		// Mod
		Concatenate(arg0, "-m00a", Local0)
		SRMT(Local0)
		m00a(Local0, "0321")
		Concatenate(arg0, "-m00c", Local0)
		SRMT(Local0)
		m00c(Local0, "0321", "C179B3FE")

		// Multiply
		Concatenate(arg0, "-m00d", Local0)
		SRMT(Local0)
		m00d(Local0, "0321")
		Concatenate(arg0, "-m00f", Local0)
		SRMT(Local0)
		m00f(Local0, "0321", "C179B3FE")

		// NAnd
		Concatenate(arg0, "-m010", Local0)
		SRMT(Local0)
		if (y119) {
			m010(Local0, "0321")
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m012", Local0)
		SRMT(Local0)
		m012(Local0, "0321", "C179B3FE")

		// NOr
		Concatenate(arg0, "-m013", Local0)
		SRMT(Local0)
		if (y119) {
			m013(Local0, "0321")
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m015", Local0)
		SRMT(Local0)
		m015(Local0, "0321", "C179B3FE")

		// Or
		Concatenate(arg0, "-m016", Local0)
		SRMT(Local0)
		if (y119) {
			m016(Local0, "0321")
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m018", Local0)
		SRMT(Local0)
		m018(Local0, "0321", "C179B3FE")

		// ShiftLeft
		Concatenate(arg0, "-m019", Local0)
		SRMT(Local0)
		m019(Local0, "0321", "B")
		Concatenate(arg0, "-m01b", Local0)
		SRMT(Local0)
		m01b(Local0, "0321", "C179B3FE", "B")

		// ShiftRight
		Concatenate(arg0, "-m01c", Local0)
		SRMT(Local0)
		m01c(Local0, "0321", "B")
		Concatenate(arg0, "-m01e", Local0)
		SRMT(Local0)
		m01e(Local0, "0321", "C179B3FE", "B")

		// Subtract
		Concatenate(arg0, "-m01f", Local0)
		SRMT(Local0)
		if (y119) {
			m01f(Local0, "0321")
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m021", Local0)
		SRMT(Local0)
		m021(Local0, "0321", "C179B3FE")

		// XOr
		Concatenate(arg0, "-m022", Local0)
		SRMT(Local0)
		if (y119) {
			m022(Local0, "0321")
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m024", Local0)
		SRMT(Local0)
		m024(Local0, "0321", "C179B3FE")
	}


	// String to Integer conversion of each String operand
	// of the 2-parameter Logical Integer operators LAnd and LOr

	// LAnd, common 32-bit/64-bit test
	Method(m025, 2)
	{
		// Conversion of the first operand

		Store(LAnd(arg1, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd(arg1, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd(arg1, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd(arg1, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, arg1), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 23, Local0, Ones)
		}
	}

	// LAnd, 64-bit
	Method(m026, 3)
	{
		// Conversion of the first operand

		Store(LAnd(arg2, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd(arg2, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd(arg2, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd(arg2, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, arg2), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, arg2), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, arg2), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, arg2), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), arg2), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), arg2), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(LAnd(arg1, arg2), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(LAnd(arg2, arg1), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// LAnd, 32-bit
	Method(m027, 3)
	{
		// Conversion of the first operand

		Store(LAnd(arg2, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd(arg2, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd(arg2, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd(arg2, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, arg2), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, arg2), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, arg2), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, arg2), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), arg2), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), arg2), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(LAnd(arg1, arg2), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(LAnd(arg2, arg1), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// Lor, common 32-bit/64-bit test
	Method(m028, 2)
	{
		// Conversion of the first operand

		Store(Lor(arg1, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(Lor(arg1, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor(arg1, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(Lor(arg1, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(Lor(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(Lor(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(Lor(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(Lor(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, arg1), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(Lor(1, arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(Lor(aui6, arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(Lor(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(Lor(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(Lor(m601(1, 6), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(Lor(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 23, Local0, Ones)
		}
	}

	// Lor, 64-bit
	Method(m029, 3)
	{
		// Conversion of the first operand

		Store(Lor(arg1, 0), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(Lor(arg1, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor(arg1, aui5), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(Lor(arg1, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(Lor(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(Lor(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(Lor(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(Lor(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, arg1), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(Lor(1, arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, arg1), Local0)
		m600(arg0, 14, Local0, Ones)

		Store(Lor(aui6, arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 16, Local0, Ones)

			Store(Lor(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 18, Local0, Ones)

		Store(Lor(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), arg1), Local0)
		m600(arg0, 20, Local0, Ones)

		Store(Lor(m601(1, 6), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 22, Local0, Ones)

			Store(Lor(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(Lor(arg2, arg1), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(Lor(arg1, arg2), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// Lor, 32-bit
	Method(m02a, 3)
	{
		// Conversion of the first operand

		Store(Lor(arg1, 0), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(Lor(arg1, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor(arg1, aui5), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(Lor(arg1, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(Lor(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(Lor(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(Lor(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(Lor(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, arg1), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(Lor(1, arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, arg1), Local0)
		m600(arg0, 14, Local0, Ones)

		Store(Lor(aui6, arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 16, Local0, Ones)

			Store(Lor(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 18, Local0, Ones)

		Store(Lor(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), arg1), Local0)
		m600(arg0, 20, Local0, Ones)

		Store(Lor(m601(1, 6), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 22, Local0, Ones)

			Store(Lor(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(Lor(arg2, arg1), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(Lor(arg1, arg2), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	Method(m64e, 1)
	{
		// LAnd
		Concatenate(arg0, "-m025", Local0)
		SRMT(Local0)
		m025(Local0, "0321")
		Concatenate(arg0, "-m026", Local0)
		SRMT(Local0)
		m026(Local0, "0321", "FE7CB391D650A284")

		// LOr
		Concatenate(arg0, "-m028", Local0)
		SRMT(Local0)
		m028(Local0, "0")
		Concatenate(arg0, "-m029", Local0)
		SRMT(Local0)
		m029(Local0, "FE7CB391D650A284", "0")
	}

	Method(m32e, 1)
	{
		// LAnd
		Concatenate(arg0, "-m025", Local0)
		SRMT(Local0)
		m025(Local0, "0321")
		Concatenate(arg0, "-m027", Local0)
		SRMT(Local0)
		m027(Local0, "0321", "C179B3FE")

		// LOr
		Concatenate(arg0, "-m028", Local0)
		SRMT(Local0)
		m028(Local0, "0")
		Concatenate(arg0, "-m02a", Local0)
		SRMT(Local0)
		m02a(Local0, "C179B3FE", "0")
	}


	// String to Integer conversion of the String second operand of
	// Logical operators when the first operand is evaluated as Integer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)
		
	Method(m64f, 2)
	{
		// LEqual

		Store(LEqual(0xfe7cb391d650a284, arg1), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0xfe7cb391d650a285, arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0xfe7cb391d650a283, arg1), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(aui4, arg1), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auid, arg1), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auif, arg1), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aui4)), arg1), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auid)), arg1), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auif)), arg1), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 4)), arg1), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 13)), arg1), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 15)), arg1), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 4), arg1), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 13), arg1), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 15), arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 4, 1)), arg1), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m602(1, 13, 1)), arg1), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m602(1, 15, 1)), arg1), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0xfe7cb391d650a284, arg1), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0xfe7cb391d650a285, arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0xfe7cb391d650a283, arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(aui4, arg1), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auid, arg1), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auif, arg1), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(aui4)), arg1), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auid)), arg1), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auif)), arg1), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 4)), arg1), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 13)), arg1), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 15)), arg1), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 4), arg1), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 13), arg1), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 15), arg1), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 4, 1)), arg1), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m602(1, 13, 1)), arg1), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m602(1, 15, 1)), arg1), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0xfe7cb391d650a284, arg1), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0xfe7cb391d650a285, arg1), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0xfe7cb391d650a283, arg1), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(aui4, arg1), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auid, arg1), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auif, arg1), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aui4)), arg1), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auid)), arg1), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auif)), arg1), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 4)), arg1), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 13)), arg1), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 15)), arg1), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 4), arg1), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 13), arg1), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 15), arg1), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 4, 1)), arg1), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 13, 1)), arg1), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 15, 1)), arg1), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0xfe7cb391d650a284, arg1), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0xfe7cb391d650a285, arg1), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0xfe7cb391d650a283, arg1), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(aui4, arg1), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auid, arg1), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auif, arg1), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(aui4)), arg1), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auid)), arg1), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auif)), arg1), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 4)), arg1), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 13)), arg1), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 15)), arg1), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 4), arg1), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 13), arg1), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 15), arg1), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 4, 1)), arg1), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m602(1, 13, 1)), arg1), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m602(1, 15, 1)), arg1), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0xfe7cb391d650a284, arg1), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0xfe7cb391d650a285, arg1), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0xfe7cb391d650a283, arg1), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(aui4, arg1), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auid, arg1), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auif, arg1), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aui4)), arg1), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auid)), arg1), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auif)), arg1), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 4)), arg1), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 13)), arg1), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 15)), arg1), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 4), arg1), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 13), arg1), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 15), arg1), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 4, 1)), arg1), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m602(1, 13, 1)), arg1), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m602(1, 15, 1)), arg1), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0xfe7cb391d650a284, arg1), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0xfe7cb391d650a285, arg1), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0xfe7cb391d650a283, arg1), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(aui4, arg1), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auid, arg1), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auif, arg1), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aui4)), arg1), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auid)), arg1), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auif)), arg1), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 4)), arg1), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 13)), arg1), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 15)), arg1), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 4), arg1), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 13), arg1), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 15), arg1), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 4, 1)), arg1), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m602(1, 13, 1)), arg1), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m602(1, 15, 1)), arg1), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	Method(m32f, 2)
	{
		// LEqual

		Store(LEqual(0xc179b3fe, arg1), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0xc179b3ff, arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0xc179b3fd, arg1), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(aui3, arg1), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auic, arg1), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auie, arg1), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aui3)), arg1), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auic)), arg1), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auie)), arg1), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 3)), arg1), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 12)), arg1), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 14)), arg1), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 3), arg1), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 12), arg1), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 14), arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 3, 1)), arg1), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m602(1, 12, 1)), arg1), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m602(1, 14, 1)), arg1), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0xc179b3fe, arg1), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0xc179b3ff, arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0xc179b3fd, arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(aui3, arg1), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auic, arg1), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auie, arg1), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(aui3)), arg1), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auic)), arg1), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auie)), arg1), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 3)), arg1), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 12)), arg1), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 14)), arg1), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 3), arg1), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 12), arg1), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 14), arg1), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 3, 1)), arg1), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m602(1, 12, 1)), arg1), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m602(1, 14, 1)), arg1), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0xc179b3fe, arg1), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0xc179b3ff, arg1), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0xc179b3fd, arg1), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(aui3, arg1), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auic, arg1), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auie, arg1), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aui3)), arg1), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auic)), arg1), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auie)), arg1), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 3)), arg1), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 12)), arg1), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 14)), arg1), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 3), arg1), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 12), arg1), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 14), arg1), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 3, 1)), arg1), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 12, 1)), arg1), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 14, 1)), arg1), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0xc179b3fe, arg1), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0xc179b3ff, arg1), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0xc179b3fd, arg1), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(aui3, arg1), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auic, arg1), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auie, arg1), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(aui3)), arg1), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auic)), arg1), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auie)), arg1), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 3)), arg1), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 12)), arg1), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 14)), arg1), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 3), arg1), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 12), arg1), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 14), arg1), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 3, 1)), arg1), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m602(1, 12, 1)), arg1), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m602(1, 14, 1)), arg1), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0xc179b3fe, arg1), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0xc179b3ff, arg1), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0xc179b3fd, arg1), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(aui3, arg1), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auic, arg1), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auie, arg1), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aui3)), arg1), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auic)), arg1), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auie)), arg1), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 3)), arg1), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 12)), arg1), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 14)), arg1), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 3), arg1), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 12), arg1), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 14), arg1), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 3, 1)), arg1), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m602(1, 12, 1)), arg1), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m602(1, 14, 1)), arg1), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0xc179b3fe, arg1), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0xc179b3ff, arg1), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0xc179b3fd, arg1), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(aui3, arg1), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auic, arg1), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auie, arg1), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aui3)), arg1), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auic)), arg1), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auie)), arg1), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 3)), arg1), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 12)), arg1), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 14)), arg1), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 3), arg1), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 12), arg1), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 14), arg1), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 3, 1)), arg1), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m602(1, 12, 1)), arg1), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m602(1, 14, 1)), arg1), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	Method(m02b, 2)
	{
		// LEqual

		Store(LEqual(0x321, arg1), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0x322, arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0x320, arg1), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(aui1, arg1), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auig, arg1), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auih, arg1), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 1), arg1), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 16), arg1), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 17), arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0x321, arg1), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0x322, arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0x320, arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(aui1, arg1), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auig, arg1), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auih, arg1), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 1), arg1), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 16), arg1), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 17), arg1), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0x321, arg1), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0x322, arg1), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0x320, arg1), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(aui1, arg1), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auig, arg1), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auih, arg1), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 1), arg1), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 16), arg1), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 17), arg1), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0x321, arg1), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0x322, arg1), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0x320, arg1), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(aui1, arg1), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auig, arg1), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auih, arg1), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 1), arg1), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 16), arg1), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 17), arg1), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0x321, arg1), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0x322, arg1), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0x320, arg1), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(aui1, arg1), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auig, arg1), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auih, arg1), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 1), arg1), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 16), arg1), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 17), arg1), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0x321, arg1), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0x322, arg1), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0x320, arg1), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(aui1, arg1), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auig, arg1), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auih, arg1), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 1), arg1), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 16), arg1), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 17), arg1), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	// String to Integer intermediate conversion of the String second
	// operand of Concatenate operator in case the first one is Integer

	Method(m64g, 3)
	{		
		Store(Concatenate(0x321, arg1), Local0)
		m600(arg0, 0, Local0, bb26)

		Store(Concatenate(0x321, arg2), Local0)
		m600(arg0, 1, Local0, bb21)


		Store(Concatenate(aui1, arg1), Local0)
		m600(arg0, 2, Local0, bb26)

		Store(Concatenate(aui1, arg2), Local0)
		m600(arg0, 3, Local0, bb21)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 4, Local0, bb26)

			Store(Concatenate(Derefof(Refof(aui1)), arg2), Local0)
			m600(arg0, 5, Local0, bb21)
		}

		Store(Concatenate(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 6, Local0, bb26)

		Store(Concatenate(Derefof(Index(paui, 1)), arg2), Local0)
		m600(arg0, 7, Local0, bb21)

		// Method returns Integer

		Store(Concatenate(m601(1, 1), arg1), Local0)
		m600(arg0, 8, Local0, bb26)

		Store(Concatenate(m601(1, 1), arg2), Local0)
		m600(arg0, 9, Local0, bb21)

		// Method returns Reference to Integer

		if (y500) {
			Store(Concatenate(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 10, Local0, bb26)

			Store(Concatenate(Derefof(m602(1, 1, 1)), arg2), Local0)
			m600(arg0, 11, Local0, bb21)
		}

		Concatenate(0x321, arg1, Local0)
		m600(arg0, 12, Local0, bb26)

		Concatenate(0x321, arg2, Local0)
		m600(arg0, 13, Local0, bb21)


		Concatenate(aui1, arg1, Local0)
		m600(arg0, 14, Local0, bb26)

		Concatenate(aui1, arg2, Local0)
		m600(arg0, 15, Local0, bb21)

		if (y078) {
			Concatenate(Derefof(Refof(aui1)), arg1, Local0)
			m600(arg0, 16, Local0, bb26)

			Concatenate(Derefof(Refof(aui1)), arg2, Local0)
			m600(arg0, 17, Local0, bb21)
		}

		Concatenate(Derefof(Index(paui, 1)), arg1, Local0)
		m600(arg0, 18, Local0, bb26)

		Concatenate(Derefof(Index(paui, 1)), arg2, Local0)
		m600(arg0, 19, Local0, bb21)

		// Method returns Integer

		Concatenate(m601(1, 1), arg1, Local0)
		m600(arg0, 20, Local0, bb26)

		Concatenate(m601(1, 1), arg2, Local0)
		m600(arg0, 21, Local0, bb21)

		// Method returns Reference to Integer

		if (y500) {
			Concatenate(Derefof(m602(1, 1, 1)), arg1, Local0)
			m600(arg0, 22, Local0, bb26)

			Concatenate(Derefof(m602(1, 1, 1)), arg2, Local0)
			m600(arg0, 23, Local0, bb21)
		}
	}

	Method(m32g, 3)
	{		
		Store(Concatenate(0x321, arg1), Local0)
		m600(arg0, 0, Local0, bb27)

		Store(Concatenate(0x321, arg2), Local0)
		m600(arg0, 1, Local0, bb24)


		Store(Concatenate(aui1, arg1), Local0)
		m600(arg0, 2, Local0, bb27)

		Store(Concatenate(aui1, arg2), Local0)
		m600(arg0, 3, Local0, bb24)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 4, Local0, bb27)

			Store(Concatenate(Derefof(Refof(aui1)), arg2), Local0)
			m600(arg0, 5, Local0, bb24)
		}

		Store(Concatenate(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 6, Local0, bb27)

		Store(Concatenate(Derefof(Index(paui, 1)), arg2), Local0)
		m600(arg0, 7, Local0, bb24)

		// Method returns Integer

		Store(Concatenate(m601(1, 1), arg1), Local0)
		m600(arg0, 8, Local0, bb27)

		Store(Concatenate(m601(1, 1), arg2), Local0)
		m600(arg0, 9, Local0, bb24)

		// Method returns Reference to Integer

		if (y500) {
			Store(Concatenate(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 10, Local0, bb27)

			Store(Concatenate(Derefof(m602(1, 1, 1)), arg2), Local0)
			m600(arg0, 11, Local0, bb24)
		}

		Concatenate(0x321, arg1, Local0)
		m600(arg0, 12, Local0, bb27)

		Concatenate(0x321, arg2, Local0)
		m600(arg0, 13, Local0, bb24)


		Concatenate(aui1, arg1, Local0)
		m600(arg0, 14, Local0, bb27)

		Concatenate(aui1, arg2, Local0)
		m600(arg0, 15, Local0, bb24)

		if (y078) {
			Concatenate(Derefof(Refof(aui1)), arg1, Local0)
			m600(arg0, 16, Local0, bb27)

			Concatenate(Derefof(Refof(aui1)), arg2, Local0)
			m600(arg0, 17, Local0, bb24)
		}

		Concatenate(Derefof(Index(paui, 1)), arg1, Local0)
		m600(arg0, 18, Local0, bb27)

		Concatenate(Derefof(Index(paui, 1)), arg2, Local0)
		m600(arg0, 20, Local0, bb24)

		// Method returns Integer

		Concatenate(m601(1, 1), arg1, Local0)
		m600(arg0, 21, Local0, bb27)

		Concatenate(m601(1, 1), arg2, Local0)
		m600(arg0, 22, Local0, bb24)

		// Method returns Reference to Integer

		if (y500) {
			Concatenate(Derefof(m602(1, 1, 1)), arg1, Local0)
			m600(arg0, 23, Local0, bb27)

			Concatenate(Derefof(m602(1, 1, 1)), arg2, Local0)
			m600(arg0, 24, Local0, bb24)
		}
	}

	// String to Integer conversion of the String Length (second)
	// operand of the ToString operator

	// Common 32-bit/64-bit test
	Method(m02c, 3)
	{
		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			arg2), Local0)
		m600(arg0, 0, Local0, bs1b)

		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			arg1), Local0)
		m600(arg0, 1, Local0, bs1c)

		Store(ToString(aub6, arg2), Local0)
		m600(arg0, 2, Local0, bs1b)

		Store(ToString(aub6, arg1), Local0)
		m600(arg0, 3, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), arg2), Local0)
			m600(arg0, 4, Local0, bs1b)

			Store(ToString(Derefof(Refof(aub6)), arg1), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), arg2), Local0)
		m600(arg0, 6, Local0, bs1b)

		Store(ToString(Derefof(Index(paub, 6)), arg1), Local0)
		m600(arg0, 7, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), arg2), Local0)
		m600(arg0, 8, Local0, bs1b)

		Store(ToString(m601(3, 6), arg1), Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), arg2), Local0)
			m600(arg0, 10, Local0, bs1b)

			Store(ToString(Derefof(m602(3, 6, 1)), arg1), Local0)
			m600(arg0, 11, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			arg2, Local0)
		m600(arg0, 12, Local0, bs1b)

		ToString(Buffer() {"This is auxiliary Buffer"},
			arg1, Local0)
		m600(arg0, 13, Local0, bs1c)

		ToString(aub6, arg2, Local0)
		m600(arg0, 14, Local0, bs1b)

		ToString(aub6, arg1, Local0)
		m600(arg0, 15, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), arg2, Local0)
			m600(arg0, 16, Local0, bs1b)

			ToString(Derefof(Refof(aub6)), arg1, Local0)
			m600(arg0, 17, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), arg2, Local0)
		m600(arg0, 18, Local0, bs1b)

		ToString(Derefof(Index(paub, 6)), arg1, Local0)
		m600(arg0, 19, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), arg2, Local0)
		m600(arg0, 20, Local0, bs1b)

		ToString(m601(3, 6), arg1, Local0)
		m600(arg0, 21, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), arg2, Local0)
			m600(arg0, 22, Local0, bs1b)

			ToString(Derefof(m602(3, 6, 1)), arg1, Local0)
			m600(arg0, 23, Local0, bs1c)
		}
	}

	Method(m64h, 2)
	{
		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			arg1), Local0)
		m600(arg0, 0, Local0, bs1c)

		Store(ToString(aub6, arg1), Local0)
		m600(arg0, 1, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), arg1), Local0)
			m600(arg0, 2, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), arg1), Local0)
		m600(arg0, 3, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), arg1), Local0)
		m600(arg0, 4, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), arg1), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			arg1, Local0)
		m600(arg0, 6, Local0, bs1c)

		ToString(aub6, arg1, Local0)
		m600(arg0, 7, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), arg1, Local0)
			m600(arg0, 8, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), arg1, Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), arg1, Local0)
		m600(arg0, 10, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), arg1, Local0)
			m600(arg0, 11, Local0, bs1c)
		}
	}

	Method(m32h, 2)
	{
		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			arg1), Local0)
		m600(arg0, 0, Local0, bs1c)

		Store(ToString(aub6, arg1), Local0)
		m600(arg0, 1, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), arg1), Local0)
			m600(arg0, 2, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), arg1), Local0)
		m600(arg0, 3, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), arg1), Local0)
		m600(arg0, 4, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), arg1), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			arg1, Local0)
		m600(arg0, 6, Local0, bs1c)

		ToString(aub6, arg1, Local0)
		m600(arg0, 7, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), arg1, Local0)
			m600(arg0, 8, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), arg1, Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), arg1, Local0)
		m600(arg0, 10, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), arg1, Local0)
			m600(arg0, 11, Local0, bs1c)
		}
	}

	// String to Integer conversion of the String Index (second)
	// operand of the Index operator
	Method(m02d, 2)
	{
		Store(Index(aus6, arg1), Local0)
		m600(arg0, 0, Derefof(Local0), bi10)

		Store(Index(aub6, arg1), Local0)
		m600(arg0, 1, Derefof(Local0), bi10)

		Store(Index(aup0, arg1), Local0)
		m600(arg0, 2, Derefof(Local0), bi11)

		if (y078) {
			Store(Index(Derefof(Refof(aus6)), arg1), Local0)
			m600(arg0, 3, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aub6)), arg1), Local0)
			m600(arg0, 4, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aup0)), arg1), Local0)
			m600(arg0, 5, Derefof(Local0), bi11)
		}

		Store(Index(Derefof(Index(paus, 6)), arg1), Local0)
		m600(arg0, 6, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paub, 6)), arg1), Local0)
		m600(arg0, 7, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paup, 0)), arg1), Local0)
		m600(arg0, 8, Derefof(Local0), bi11)


		// Method returns Object

		if (y900) {
			Store(Index(m601(2, 6), arg1), Local0)
			m600(arg0, 9, Derefof(Local0), bi10)

			Store(Index(m601(3, 6), arg1), Local0)
			m600(arg0, 10, Derefof(Local0), bi10)

			Store(Index(m601(4, 0), arg1), Local0)
			m600(arg0, 11, Derefof(Local0), bi11)
		} else {

			CH03(arg0, z121, 0, 0, 0)

			Store(Index(m601(2, 6), arg1), Local3)
			CH04(arg0, 0, 85, z121, 9, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Store(Index(m601(3, 6), arg1), Local3)
			CH04(arg0, 0, 85, z121, 10, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Store(Index(m601(4, 0), arg1), Local3)
			CH04(arg0, 0, 85, z121, 11, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED
		}


		// Method returns Reference

		if (y500) {
			Store(Index(Derefof(m602(2, 6, 1)), arg1), Local0)
			m600(arg0, 12, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(3, 6, 1)), arg1), Local0)
			m600(arg0, 13, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(4, 0, 1)), arg1), Local0)
			m600(arg0, 14, Derefof(Local0), bi11)
		}

		Index(aus6, arg1, Local0)
		m600(arg0, 15, Derefof(Local0), bi10)

		Index(aub6, arg1, Local0)
		m600(arg0, 16, Derefof(Local0), bi10)

		Index(aup0, arg1, Local0)
		m600(arg0, 17, Derefof(Local0), bi11)

		if (y078) {
			Index(Derefof(Refof(aus6)), arg1, Local0)
			m600(arg0, 18, Derefof(Local0), bi10)

			Index(Derefof(Refof(aub6)), arg1, Local0)
			m600(arg0, 19, Derefof(Local0), bi10)

			Index(Derefof(Refof(aup0)), arg1, Local0)
			m600(arg0, 20, Derefof(Local0), bi11)
		}

		Index(Derefof(Index(paus, 6)), arg1, Local0)
		m600(arg0, 21, Derefof(Local0), bi10)

		Index(Derefof(Index(paub, 6)), arg1, Local0)
		m600(arg0, 22, Derefof(Local0), bi10)

		Index(Derefof(Index(paup, 0)), arg1, Local0)
		m600(arg0, 23, Derefof(Local0), bi11)


		// Method returns Object

		if (y900) {
			Index(m601(2, 6), arg1, Local0)
			m600(arg0, 24, Derefof(Local0), bi10)

			Index(m601(3, 6), arg1, Local0)
			m600(arg0, 25, Derefof(Local0), bi10)

			Index(m601(4, 0), arg1, Local0)
			m600(arg0, 26, Derefof(Local0), bi11)
		} else {
			CH03(arg0, z121, 0, 0, 0)

			Index(m601(2, 6), arg1, Local0)
			CH04(arg0, 0, 85, z121, 24, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Index(m601(3, 6), arg1, Local0)
			CH04(arg0, 0, 85, z121, 25, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Index(m601(4, 0), arg1, Local0)
			CH04(arg0, 0, 85, z121, 26, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED
		}

		// Method returns Reference

		if (y500) {
			Index(Derefof(m602(2, 6, 1)), arg1, Local0)
			m600(arg0, 27, Derefof(Local0), bi10)

			Index(Derefof(m602(3, 6, 1)), arg1, Local0)
			m600(arg0, 28, Derefof(Local0), bi10)

			Index(Derefof(m602(4, 0, 1)), arg1, Local0)
			m600(arg0, 29, Derefof(Local0), bi11)
		}

		if (y098) {
			Store(Index(aus6, arg1, Local1), Local0)
			m600(arg0, 30, Derefof(Local0), bi10)

			Store(Index(aub6, arg1, Local1), Local0)
			m600(arg0, 31, Derefof(Local0), bi10)

			Store(Index(aup0, arg1, Local1), Local0)
			m600(arg0, 32, Derefof(Local0), bi11)
		}

		if (y078) {
			Store(Index(Derefof(Refof(aus6)), arg1, Local1), Local0)
			m600(arg0, 33, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aub6)), arg1, Local1), Local0)
			m600(arg0, 34, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aup0)), arg1, Local1), Local0)
			m600(arg0, 35, Derefof(Local0), bi11)
		}

		if (y098) {
		Store(Index(Derefof(Index(paus, 6)), arg1, Local1), Local0)
		m600(arg0, 36, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paub, 6)), arg1, Local1), Local0)
		m600(arg0, 37, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paup, 0)), arg1, Local1), Local0)
		m600(arg0, 38, Derefof(Local0), bi11)
		}

		// Method returns Object

		if (LAnd(y900, y098)) {
			Store(Index(m601(2, 6), arg1, Local1), Local0)
			m600(arg0, 39, Derefof(Local0), bi10)

			Store(Index(m601(3, 6), arg1, Local1), Local0)
			m600(arg0, 40, Derefof(Local0), bi10)

			Store(Index(m601(4, 0), arg1, Local1), Local0)
			m600(arg0, 41, Derefof(Local0), bi11)
		}

		// Method returns Reference

		if (y500) {
			Store(Index(Derefof(m602(2, 6, 1)), arg1, Local1), Local0)
			m600(arg0, 42, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(3, 6, 1)), arg1, Local1), Local0)
			m600(arg0, 43, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(4, 0, 1)), arg1, Local1), Local0)
			m600(arg0, 44, Derefof(Local0), bi11)
		}
	}

	// String to Integer conversion of the String Arg (third)
	// operand of the Fatal operator
	// (it can only be checked an exception does not occur)
	Method(m02e, 4)
	{
		CH03(arg0, z121, 0, 0, 0)
		Fatal(0xff, 0xffffffff, arg1)
		if (F64) {
			Fatal(0xff, 0xffffffff, arg2)
		} else {
			Fatal(0xff, 0xffffffff, arg3)
		}
		CH03(arg0, z121, 1, 0, 0)
	}

	// String to Integer conversion of the String Index and Length
	// operands of the Mid operator

	// Common 32-bit/64-bit test
	Method(m02f, 2)
	{
		// String to Integer conversion of the String Index operand

		Store(Mid("This is auxiliary String", arg1, 10), Local0)
		m600(arg0, 0, Local0, bs1d)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, arg1, 10), Local0)
		m600(arg0, 1, Local0, bb32)

		Store(Mid(aus6, arg1, 10), Local0)
		m600(arg0, 2, Local0, bs1d)

		Store(Mid(aub6, arg1, 10), Local0)
		m600(arg0, 3, Local0, bb32)


		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), arg1, 10), Local0)
			m600(arg0, 4, Local0, bs1d)

			Store(Mid(Derefof(Refof(aub6)), arg1, 10), Local0)
			m600(arg0, 5, Local0, bb32)
		}

		Store(Mid(Derefof(Index(paus, 6)), arg1, 10), Local0)
		m600(arg0, 6, Local0, bs1d)

		Store(Mid(Derefof(Index(paub, 6)), arg1, 10), Local0)
		m600(arg0, 7, Local0, bb32)

		// Method returns Object

		Store(Mid(m601(2, 6), arg1, 10), Local0)
		m600(arg0, 8, Local0, bs1d)

		Store(Mid(m601(3, 6), arg1, 10), Local0)
		m600(arg0, 9, Local0, bb32)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), arg1, 10), Local0)
			m600(arg0, 10, Local0, bs1d)

			Store(Mid(Derefof(m602(3, 6, 1)), arg1, 10), Local0)
			m600(arg0, 11, Local0, bb32)
		}

		Mid("This is auxiliary String", arg1, 10, Local0)
		m600(arg0, 12, Local0, bs1d)

		Mid(Buffer(){"This is auxiliary Buffer"}, arg1, 10, Local0)
		m600(arg0, 13, Local0, bb32)

		Mid(aus6, arg1, 10, Local0)
		m600(arg0, 14, Local0, bs1d)

		Mid(aub6, arg1, 10, Local0)
		m600(arg0, 15, Local0, bb32)


		if (y078) {
			Mid(Derefof(Refof(aus6)), arg1, 10, Local0)
			m600(arg0, 16, Local0, bs1d)

			Mid(Derefof(Refof(aub6)), arg1, 10, Local0)
			m600(arg0, 17, Local0, bb32)
		}

		Mid(Derefof(Index(paus, 6)), arg1, 10, Local0)
		m600(arg0, 18, Local0, bs1d)

		Mid(Derefof(Index(paub, 6)), arg1, 10, Local0)
		m600(arg0, 19, Local0, bb32)

		// Method returns Object

		Mid(m601(2, 6), arg1, 10, Local0)
		m600(arg0, 20, Local0, bs1d)

		Mid(m601(3, 6), arg1, 10, Local0)
		m600(arg0, 21, Local0, bb32)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), arg1, 10, Local0)
			m600(arg0, 22, Local0, bs1d)

			Mid(Derefof(m602(3, 6, 1)), arg1, 10, Local0)
			m600(arg0, 23, Local0, bb32)
		}

		// String to Integer conversion of the String Length operand

		Store(Mid("This is auxiliary String", 0, arg1), Local0)
		m600(arg0, 24, Local0, bs1b)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, arg1), Local0)
		m600(arg0, 25, Local0, bb33)

		Store(Mid(aus6, 0, arg1), Local0)
		m600(arg0, 26, Local0, bs1b)

		Store(Mid(aub6, 0, arg1), Local0)
		m600(arg0, 27, Local0, bb33)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, arg1), Local0)
			m600(arg0, 28, Local0, bs1b)

			Store(Mid(Derefof(Refof(aub6)), 0, arg1), Local0)
			m600(arg0, 29, Local0, bb33)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, arg1), Local0)
		m600(arg0, 30, Local0, bs1b)

		Store(Mid(Derefof(Index(paub, 6)), 0, arg1), Local0)
		m600(arg0, 31, Local0, bb33)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, arg1), Local0)
		m600(arg0, 32, Local0, bs1b)

		Store(Mid(m601(3, 6), 0, arg1), Local0)
		m600(arg0, 33, Local0, bb33)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, arg1), Local0)
			m600(arg0, 34, Local0, bs1b)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, arg1), Local0)
			m600(arg0, 35, Local0, bb33)
		}

		Mid("This is auxiliary String", 0, arg1, Local0)
		m600(arg0, 36, Local0, bs1b)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, arg1, Local0)
		m600(arg0, 37, Local0, bb33)

		Mid(aus6, 0, arg1, Local0)
		m600(arg0, 37, Local0, bs1b)

		Mid(aub6, 0, arg1, Local0)
		m600(arg0, 39, Local0, bb33)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, arg1, Local0)
			m600(arg0, 40, Local0, bs1b)

			Mid(Derefof(Refof(aub6)), 0, arg1, Local0)
			m600(arg0, 41, Local0, bb33)
		}

		Mid(Derefof(Index(paus, 6)), 0, arg1, Local0)
		m600(arg0, 42, Local0, bs1b)

		Mid(Derefof(Index(paub, 6)), 0, arg1, Local0)
		m600(arg0, 43, Local0, bb33)

		// Method returns Object

		Mid(m601(2, 6), 0, arg1, Local0)
		m600(arg0, 44, Local0, bs1b)

		Mid(m601(3, 6), 0, arg1, Local0)
		m600(arg0, 45, Local0, bb33)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, arg1, Local0)
			m600(arg0, 46, Local0, bs1b)

			Mid(Derefof(m602(3, 6, 1)), 0, arg1, Local0)
			m600(arg0, 47, Local0, bb33)
		}
	}

	Method(m64i, 3)
	{
		// String to Integer conversion of the String Length operand

		Store(Mid("This is auxiliary String", 0, arg1), Local0)
		m600(arg0, 0, Local0, bs1e)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, arg1), Local0)
		m600(arg0, 1, Local0, bb34)

		Store(Mid(aus6, 0, arg1), Local0)
		m600(arg0, 2, Local0, bs1e)

		Store(Mid(aub6, 0, arg1), Local0)
		m600(arg0, 3, Local0, bb34)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, arg1), Local0)
			m600(arg0, 4, Local0, bs1e)

			Store(Mid(Derefof(Refof(aub6)), 0, arg1), Local0)
			m600(arg0, 5, Local0, bb34)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, arg1), Local0)
		m600(arg0, 6, Local0, bs1e)

		Store(Mid(Derefof(Index(paub, 6)), 0, arg1), Local0)
		m600(arg0, 7, Local0, bb34)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, arg1), Local0)
		m600(arg0, 8, Local0, bs1e)

		Store(Mid(m601(3, 6), 0, arg1), Local0)
		m600(arg0, 9, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, arg1), Local0)
			m600(arg0, 10, Local0, bs1e)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, arg1), Local0)
			m600(arg0, 11, Local0, bb34)
		}

		Mid("This is auxiliary String", 0, arg1, Local0)
		m600(arg0, 12, Local0, bs1e)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, arg1, Local0)
		m600(arg0, 13, Local0, bb34)

		Mid(aus6, 0, arg1, Local0)
		m600(arg0, 14, Local0, bs1e)

		Mid(aub6, 0, arg1, Local0)
		m600(arg0, 15, Local0, bb34)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, arg1, Local0)
			m600(arg0, 16, Local0, bs1e)

			Mid(Derefof(Refof(aub6)), 0, arg1, Local0)
			m600(arg0, 17, Local0, bb34)
		}

		Mid(Derefof(Index(paus, 6)), 0, arg1, Local0)
		m600(arg0, 18, Local0, bs1e)

		Mid(Derefof(Index(paub, 6)), 0, arg1, Local0)
		m600(arg0, 19, Local0, bb34)

		// Method returns Object

		Mid(m601(2, 6), 0, arg1, Local0)
		m600(arg0, 20, Local0, bs1e)

		Mid(m601(3, 6), 0, arg1, Local0)
		m600(arg0, 21, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, arg1, Local0)
			m600(arg0, 22, Local0, bs1e)

			Mid(Derefof(m602(3, 6, 1)), 0, arg1, Local0)
			m600(arg0, 23, Local0, bb34)
		}

		// String to Integer conversion of the both String operands

		Store(Mid("This is auxiliary String", arg2, arg1), Local0)
		m600(arg0, 24, Local0, bs1f)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, arg2, arg1), Local0)
		m600(arg0, 25, Local0, bb35)

		Store(Mid(aus6, arg2, arg1), Local0)
		m600(arg0, 26, Local0, bs1f)

		Store(Mid(aub6, arg2, arg1), Local0)
		m600(arg0, 27, Local0, bb35)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), arg2, arg1), Local0)
			m600(arg0, 28, Local0, bs1f)

			Store(Mid(Derefof(Refof(aub6)), arg2, arg1), Local0)
			m600(arg0, 29, Local0, bb35)
		}

		Store(Mid(Derefof(Index(paus, 6)), arg2, arg1), Local0)
		m600(arg0, 30, Local0, bs1f)

		Store(Mid(Derefof(Index(paub, 6)), arg2, arg1), Local0)
		m600(arg0, 31, Local0, bb35)

		// Method returns Object

		Store(Mid(m601(2, 6), arg2, arg1), Local0)
		m600(arg0, 32, Local0, bs1f)

		Store(Mid(m601(3, 6), arg2, arg1), Local0)
		m600(arg0, 33, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), arg2, arg1), Local0)
			m600(arg0, 34, Local0, bs1f)

			Store(Mid(Derefof(m602(3, 6, 1)), arg2, arg1), Local0)
			m600(arg0, 35, Local0, bb35)
		}

		Mid("This is auxiliary String", arg2, arg1, Local0)
		m600(arg0, 36, Local0, bs1f)

		Mid(Buffer(){"This is auxiliary Buffer"}, arg2, arg1, Local0)
		m600(arg0, 37, Local0, bb35)

		Mid(aus6, arg2, arg1, Local0)
		m600(arg0, 38, Local0, bs1f)

		Mid(aub6, arg2, arg1, Local0)
		m600(arg0, 39, Local0, bb35)


		if (y078) {
			Mid(Derefof(Refof(aus6)), arg2, arg1, Local0)
			m600(arg0, 40, Local0, bs1f)

			Mid(Derefof(Refof(aub6)), arg2, arg1, Local0)
			m600(arg0, 41, Local0, bb35)
		}

		Mid(Derefof(Index(paus, 6)), arg2, arg1, Local0)
		m600(arg0, 42, Local0, bs1f)

		Mid(Derefof(Index(paub, 6)), arg2, arg1, Local0)
		m600(arg0, 43, Local0, bb35)

		// Method returns Object

		Mid(m601(2, 6), arg2, arg1, Local0)
		m600(arg0, 44, Local0, bs1f)

		Mid(m601(3, 6), arg2, arg1, Local0)
		m600(arg0, 45, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), arg2, arg1, Local0)
			m600(arg0, 46, Local0, bs1f)

			Mid(Derefof(m602(3, 6, 1)), arg2, arg1, Local0)
			m600(arg0, 47, Local0, bb35)
		}
	}

	Method(m32i, 3)
	{
		// String to Integer conversion of the String Length operand

		Store(Mid("This is auxiliary String", 0, arg1), Local0)
		m600(arg0, 0, Local0, bs1e)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, arg1), Local0)
		m600(arg0, 1, Local0, bb34)

		Store(Mid(aus6, 0, arg1), Local0)
		m600(arg0, 2, Local0, bs1e)

		Store(Mid(aub6, 0, arg1), Local0)
		m600(arg0, 3, Local0, bb34)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, arg1), Local0)
			m600(arg0, 4, Local0, bs1e)

			Store(Mid(Derefof(Refof(aub6)), 0, arg1), Local0)
			m600(arg0, 5, Local0, bb34)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, arg1), Local0)
		m600(arg0, 6, Local0, bs1e)

		Store(Mid(Derefof(Index(paub, 6)), 0, arg1), Local0)
		m600(arg0, 7, Local0, bb34)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, arg1), Local0)
		m600(arg0, 8, Local0, bs1e)

		Store(Mid(m601(3, 6), 0, arg1), Local0)
		m600(arg0, 9, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, arg1), Local0)
			m600(arg0, 10, Local0, bs1e)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, arg1), Local0)
			m600(arg0, 11, Local0, bb34)
		}

		Mid("This is auxiliary String", 0, arg1, Local0)
		m600(arg0, 12, Local0, bs1e)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, arg1, Local0)
		m600(arg0, 13, Local0, bb34)

		Mid(aus6, 0, arg1, Local0)
		m600(arg0, 14, Local0, bs1e)

		Mid(aub6, 0, arg1, Local0)
		m600(arg0, 15, Local0, bb34)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, arg1, Local0)
			m600(arg0, 16, Local0, bs1e)

			Mid(Derefof(Refof(aub6)), 0, arg1, Local0)
			m600(arg0, 17, Local0, bb34)
		}

		Mid(Derefof(Index(paus, 6)), 0, arg1, Local0)
		m600(arg0, 18, Local0, bs1e)

		Mid(Derefof(Index(paub, 6)), 0, arg1, Local0)
		m600(arg0, 19, Local0, bb34)

		// Method returns Object

		Mid(m601(2, 6), 0, arg1, Local0)
		m600(arg0, 20, Local0, bs1e)

		Mid(m601(3, 6), 0, arg1, Local0)
		m600(arg0, 21, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, arg1, Local0)
			m600(arg0, 22, Local0, bs1e)

			Mid(Derefof(m602(3, 6, 1)), 0, arg1, Local0)
			m600(arg0, 23, Local0, bb34)
		}

		// String to Integer conversion of the both String operands

		Store(Mid("This is auxiliary String", arg2, arg1), Local0)
		m600(arg0, 24, Local0, bs1f)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, arg2, arg1), Local0)
		m600(arg0, 25, Local0, bb35)

		Store(Mid(aus6, arg2, arg1), Local0)
		m600(arg0, 26, Local0, bs1f)

		Store(Mid(aub6, arg2, arg1), Local0)
		m600(arg0, 27, Local0, bb35)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), arg2, arg1), Local0)
			m600(arg0, 28, Local0, bs1f)

			Store(Mid(Derefof(Refof(aub6)), arg2, arg1), Local0)
			m600(arg0, 29, Local0, bb35)
		}

		Store(Mid(Derefof(Index(paus, 6)), arg2, arg1), Local0)
		m600(arg0, 30, Local0, bs1f)

		Store(Mid(Derefof(Index(paub, 6)), arg2, arg1), Local0)
		m600(arg0, 31, Local0, bb35)

		// Method returns Object

		Store(Mid(m601(2, 6), arg2, arg1), Local0)
		m600(arg0, 32, Local0, bs1f)

		Store(Mid(m601(3, 6), arg2, arg1), Local0)
		m600(arg0, 33, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), arg2, arg1), Local0)
			m600(arg0, 34, Local0, bs1f)

			Store(Mid(Derefof(m602(3, 6, 1)), arg2, arg1), Local0)
			m600(arg0, 35, Local0, bb35)
		}

		Mid("This is auxiliary String", arg2, arg1, Local0)
		m600(arg0, 36, Local0, bs1f)

		Mid(Buffer(){"This is auxiliary Buffer"}, arg2, arg1, Local0)
		m600(arg0, 37, Local0, bb35)

		Mid(aus6, arg2, arg1, Local0)
		m600(arg0, 38, Local0, bs1f)

		Mid(aub6, arg2, arg1, Local0)
		m600(arg0, 39, Local0, bb35)


		if (y078) {
			Mid(Derefof(Refof(aus6)), arg2, arg1, Local0)
			m600(arg0, 40, Local0, bs1f)

			Mid(Derefof(Refof(aub6)), arg2, arg1, Local0)
			m600(arg0, 41, Local0, bb35)
		}

		Mid(Derefof(Index(paus, 6)), arg2, arg1, Local0)
		m600(arg0, 42, Local0, bs1f)

		Mid(Derefof(Index(paub, 6)), arg2, arg1, Local0)
		m600(arg0, 43, Local0, bb35)

		// Method returns Object

		Mid(m601(2, 6), arg2, arg1, Local0)
		m600(arg0, 44, Local0, bs1f)

		Mid(m601(3, 6), arg2, arg1, Local0)
		m600(arg0, 45, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), arg2, arg1, Local0)
			m600(arg0, 46, Local0, bs1f)

			Mid(Derefof(m602(3, 6, 1)), arg2, arg1, Local0)
			m600(arg0, 47, Local0, bb35)
		}
	}

	// String to Integer conversion of the String StartIndex
	// operand of the Match operator
	Method(m030, 2)
	{
		Store(Match(
			Package(){
				0xa50, 0xa51, 0xa52, 0xa53, 0xa54, 0xa55, 0xa56, 0xa57,
				0xa58, 0xa59, 0xa5a, 0xa5b, 0xa5c, 0xa5d, 0xa5e,},
			MEQ, 0xa5d, MTR, 0, arg1), Local0)
		m600(arg0, 0, Local0, 0xd)

		Store(Match(
			Package(){
				0xa50, 0xa51, 0xa52, 0xa53, 0xa54, 0xa55, 0xa56, 0xa57,
				0xa58, 0xa59, 0xa5a, 0xa5b, 0xa5c, 0xa5d, 0xa5e,},
			MEQ, 0xa5a, MTR, 0, arg1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(aup0, MEQ, 0xa5d, MTR, 0, arg1), Local0)
		m600(arg0, 2, Local0, 0xd)

		Store(Match(aup0, MEQ, 0xa5a, MTR, 0, arg1), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Match(Derefof(Refof(aup0)), MEQ, 0xa5d, MTR, 0, arg1), Local0)
			m600(arg0, 4, Local0, 0xd)

			Store(Match(Derefof(Refof(aup0)), MEQ, 0xa5a, MTR, 0, arg1), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Match(Derefof(Index(paup, 0)), MEQ, 0xa5d, MTR, 0, arg1), Local0)
		m600(arg0, 6, Local0, 0xd)

		Store(Match(Derefof(Index(paup, 0)), MEQ, 0xa5a, MTR, 0, arg1), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Object

		Store(Match(m601(4, 0), MEQ, 0xa5d, MTR, 0, arg1), Local0)
		m600(arg0, 8, Local0, 0xd)

		Store(Match(m601(4, 0), MEQ, 0xa5a, MTR, 0, arg1), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference

		if (y500) {
			Store(Match(Derefof(m602(4, 0, 1)), MEQ, 0xa5d, MTR, 0, arg1), Local0)
			m600(arg0, 10, Local0, 0xd)

			Store(Match(Derefof(m602(4, 0, 1)), MEQ, 0xa5a, MTR, 0, arg1), Local0)
			m600(arg0, 11, Local0, Ones)
		}
	}

//	Method(m64j, 1)

//	Method(m32j, 1)

	// String to Integer conversion of the String sole operand
	// of the Method execution control operators (Sleep, Stall)
	Method(m031, 3)
	{
		CH03(arg0, z121, 2, 0, 0)

		// Sleep

		Store(Timer, Local0)

		Sleep(arg1)
		CH03(arg0, z121, 3, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z121, 0, 0, 0, Local2, c08c)
		}

		// Stall

		Store(Timer, Local0)

		Stall(arg2)
		CH03(arg0, z121, 4, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, 990)) {
			err(arg0, z121, 1, 0, 0, Local2, 990)
		}
	}

	// String to Integer conversion of the String TimeoutValue
	// (second) operand of the Acquire operator ???
	Method(m032, 2, Serialized)
	{
		Mutex(MTX0, 0)

		Acquire(MTX0, 0)
		CH03(arg0, z121, 5, 0, 0)

		Store(Timer, Local0)

/* Compiler allows only Integer constant as TimeoutValue (Bug 1)
		Acquire(MTX0, arg1)
*/
		CH03(arg0, z121, 6, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z121, 0, 0, 0, Local2, c08c)
		}
	}

	// String to Integer conversion of the String TimeoutValue
	// (second) operand of the Wait operator
	Method(m033, 2, Serialized)
	{
		Event(EVT0)

		CH03(arg0, z121, 7, 0, 0)

		Store(Timer, Local0)

		Wait(EVT0, arg1)
		CH03(arg0, z121, 8, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z121, 0, 0, 0, Local2, c08c)
		}
	}

	// String to Integer conversion of the String value
	// of Predicate of the Method execution control statements
	// (If, ElseIf, While)
	Method(m034, 5, Serialized)
	{
		Name(ist0, 0)

		Method(m001, 1)
		{
			if (arg0) {
				Store(0, ist0)
			}
		}

		Method(m002, 1)
		{
			if (arg0) {
				Store(2, ist0)
			}
		}

		Method(m003, 1)
		{
			if (arg0) {
				Store(3, ist0)
			}
		}

		Method(m004, 1)
		{
			if (arg0) {
				Store(4, ist0)
			}
		}

		Method(m005, 2)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (arg1) {
				Store(0, ist0)
			}
		}

		Method(m006, 2)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (arg1) {
				Store(6, ist0)
			}
		}

		Method(m007, 2)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (arg1) {
				Store(7, ist0)
			}
		}

		Method(m008, 2)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (arg1) {
				Store(8, ist0)
			}
		}

		Method(m009, 1)
		{
			while (arg0) {
				Store(0, ist0)
				Break
			}
		}

		// If

		Store(1, ist0)
		m001(arg4)
		m600(arg0, 0, ist0, 1)

		m002(arg1)
		m600(arg0, 1, ist0, 2)

		m003(arg3)
		m600(arg0, 2, ist0, 3)

		m004(arg2)
		m600(arg0, 3, ist0, 4)

		// ElseIf

		Store(5, ist0)
		m005(0, arg4)
		m600(arg0, 4, ist0, 5)

		m006(0, arg1)
		m600(arg0, 5, ist0, 6)

		m007(0, arg3)
		m600(arg0, 6, ist0, 7)

		m008(0, arg2)
		m600(arg0, 7, ist0, 8)

		// While

		Store(9, ist0)
		m009(arg4)
		m600(arg0, 8, ist0, 9)
	}

//	Method(m64k, 1)

//	Method(m32k, 1)

	// String to Buffer implicit conversion Cases.

	// String to Buffer conversion of the String second operand of
	// Logical operators when the first operand is evaluated as Buffer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)

	Method(m035, 4)
	{		
		// LEqual

		Store(LEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, arg1), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aub7, arg1), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(aub3, arg1), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aub7)), arg1), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(aub3)), arg1), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paub, 7)), arg1), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paub, 3)), arg1), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns Buffer

		Store(LEqual(m601(3, 7), arg1), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(3, 3), arg1), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LEqual(Derefof(m602(3, 7, 1)), arg1), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(3, 3, 1)), arg1), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, arg1), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater(Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater(Buffer() {0x30, 0x33, 0x32, 0x31}, arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00, 0x01}, arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aub7, arg1), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(aub8, arg1), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aub7)), arg1), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(aub8)), arg1), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paub, 7)), arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paub, 8)), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Buffer

		Store(LGreater(m601(3, 7), arg1), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(3, 8), arg1), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreater(Derefof(m602(3, 7, 1)), arg1), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(3, 8, 1)), arg1), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, arg1), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, arg1), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0x30, 0x33, 0x32, 0x31}, arg1), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00, 0x01}, arg1), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aub7, arg1), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(aub8, arg1), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aub7)), arg1), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(aub8)), arg1), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paub, 7)), arg1), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paub, 8)), arg1), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns Buffer

		Store(LGreaterEqual(m601(3, 7), arg1), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(3, 8), arg1), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(3, 7, 1)), arg1), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(3, 8, 1)), arg1), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, arg1), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess(Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, arg1), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess(Buffer() {0x30, 0x33, 0x32, 0x31}, arg1), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00, 0x01}, arg1), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aub7, arg1), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(aub8, arg1), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aub7)), arg1), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(aub8)), arg1), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paub, 7)), arg1), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paub, 8)), arg1), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns Buffer

		Store(LLess(m601(3, 7), arg1), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(3, 8), arg1), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLess(Derefof(m602(3, 7, 1)), arg1), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(3, 8, 1)), arg1), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, arg1), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, arg1), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual(Buffer() {0x30, 0x33, 0x32, 0x31}, arg1), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00, 0x01}, arg1), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aub7, arg1), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(aub8, arg1), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aub7)), arg1), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(aub8)), arg1), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paub, 7)), arg1), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paub, 8)), arg1), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns Buffer

		Store(LLessEqual(m601(3, 7), arg1), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(3, 8), arg1), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLessEqual(Derefof(m602(3, 7, 1)), arg1), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(3, 8, 1)), arg1), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, arg1), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, arg1), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual(Buffer() {0x30, 0x33, 0x32, 0x31}, arg1), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00, 0x01}, arg1), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aub7, arg1), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(aub8, arg1), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aub7)), arg1), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(aub8)), arg1), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paub, 7)), arg1), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paub, 8)), arg1), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns Buffer

		Store(LNotEqual(m601(3, 7), arg1), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(3, 8), arg1), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LNotEqual(Derefof(m602(3, 7, 1)), arg1), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(3, 8, 1)), arg1), Local0)
			m600(arg0, 81, Local0, Ones)
		}

		// Boundary Cases

		Store(LEqual(Buffer() {0x00}, arg2), Local0)
		m600(arg0, 82, Local0, Ones)

		Store(LEqual(Buffer() {0x01}, arg2), Local0)
		m600(arg0, 83, Local0, Zero)

		Store(LGreater(Buffer() {0x00}, arg2), Local0)
		m600(arg0, 84, Local0, Zero)

		Store(LGreater(Buffer() {0x01}, arg2), Local0)
		m600(arg0, 85, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0x00}, arg2), Local0)
		m600(arg0, 86, Local0, Ones)

		Store(LGreater(Buffer() {0x01}, arg2), Local0)
		m600(arg0, 87, Local0, Ones)

		Store(LLess(Buffer() {0x00}, arg2), Local0)
		m600(arg0, 88, Local0, Zero)

		Store(LLess(Buffer() {0x01}, arg2), Local0)
		m600(arg0, 89, Local0, Zero)

		Store(LLessEqual(Buffer() {0x00}, arg2), Local0)
		m600(arg0, 90, Local0, Ones)

		Store(LLessEqual(Buffer() {0x01}, arg2), Local0)
		m600(arg0, 91, Local0, Zero)

		Store(LNotEqual(Buffer() {0x00}, arg2), Local0)
		m600(arg0, 92, Local0, Zero)

		Store(LNotEqual(Buffer() {0x01}, arg2), Local0)
		m600(arg0, 93, Local0, Ones)

		Store(LEqual(
				Buffer(){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
					0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
					0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
					0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
					0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
					0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
					0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
					0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
					0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x00,},
				arg3),
			Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LEqual(
				Buffer(){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
					0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
					0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
					0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
					0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
					0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
					0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
					0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
					0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x01,},
				arg3),
			Local0)
		m600(arg0, 95, Local0, Zero)

		Store(LGreater(
				Buffer(){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
					0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
					0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
					0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
					0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
					0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
					0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
					0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
					0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x00,},
				arg3),
			Local0)
		m600(arg0, 96, Local0, Zero)

		Store(LGreater(
				Buffer(){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
					0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
					0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
					0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
					0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
					0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
					0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
					0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
					0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x01,},
				arg3),
			Local0)
		m600(arg0, 97, Local0, Ones)

		Store(LGreaterEqual(
				Buffer(){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
					0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
					0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
					0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
					0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
					0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
					0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
					0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
					0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x00,},
				arg3),
			Local0)
		m600(arg0, 98, Local0, Ones)

		Store(LGreater(
				Buffer(){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
					0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
					0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
					0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
					0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
					0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
					0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
					0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
					0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x01,},
				arg3),
			Local0)
		m600(arg0, 99, Local0, Ones)

		Store(LLess(
				Buffer(){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
					0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
					0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
					0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
					0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
					0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
					0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
					0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
					0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x00,},
				arg3),
			Local0)
		m600(arg0, 100, Local0, Zero)

		Store(LLess(
				Buffer(){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
					0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
					0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
					0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
					0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
					0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
					0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
					0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
					0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x01,},
				arg3),
			Local0)
		m600(arg0, 101, Local0, Zero)

		Store(LLessEqual(
				Buffer(){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
					0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
					0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
					0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
					0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
					0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
					0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
					0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
					0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x00,},
				arg3),
			Local0)
		m600(arg0, 102, Local0, Ones)

		Store(LLessEqual(
				Buffer(){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
					0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
					0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
					0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
					0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
					0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
					0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
					0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
					0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x01,},
				arg3),
			Local0)
		m600(arg0, 103, Local0, Zero)

		Store(LNotEqual(
				Buffer(){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
					0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
					0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
					0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
					0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
					0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
					0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
					0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
					0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x00,},
				arg3),
			Local0)
		m600(arg0, 104, Local0, Zero)

		Store(LNotEqual(
				Buffer(){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
					0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
					0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
					0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
					0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
					0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
					0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
					0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
					0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x01,},
				arg3),
			Local0)
		m600(arg0, 105, Local0, Ones)
	}

	// String to Buffer conversion of the String second operand of
	// Concatenate operator when the first operand is evaluated as Buffer

	Method(m036, 4)
	{		
		Store(Concatenate(Buffer(){0x5a}, arg1), Local0)
		m600(arg0, 0, Local0, bb29)

		Store(Concatenate(Buffer(){0x5a, 0x00}, arg1), Local0)
		m600(arg0, 1, Local0, bb2a)

		Store(Concatenate(aub0, arg1), Local0)
		m600(arg0, 2, Local0, bb29)

		Store(Concatenate(aub1, arg1), Local0)
		m600(arg0, 3, Local0, bb2a)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aub0)), arg1), Local0)
			m600(arg0, 4, Local0, bb29)

			Store(Concatenate(Derefof(Refof(aub1)), arg1), Local0)
			m600(arg0, 5, Local0, bb2a)
		}

		Store(Concatenate(Derefof(Index(paub, 0)), arg1), Local0)
		m600(arg0, 6, Local0, bb29)

		Store(Concatenate(Derefof(Index(paub, 1)), arg1), Local0)
		m600(arg0, 7, Local0, bb2a)

		// Method returns Buffer

		Store(Concatenate(m601(3, 0), arg1), Local0)
		m600(arg0, 8, Local0, bb29)

		Store(Concatenate(m601(3, 1), arg1), Local0)
		m600(arg0, 9, Local0, bb2a)

		// Method returns Reference to Buffer

		if (y500) {
			Store(Concatenate(Derefof(m602(3, 0, 1)), arg1), Local0)
			m600(arg0, 10, Local0, bb29)

			Store(Concatenate(Derefof(m602(3, 1, 1)), arg1), Local0)
			m600(arg0, 11, Local0, bb2a)
		}

		Concatenate(Buffer(){0x5a}, arg1, Local0)
		m600(arg0, 12, Local0, bb29)

		Concatenate(Buffer(){0x5a, 0x00}, arg1, Local0)
		m600(arg0, 13, Local0, bb2a)

		Concatenate(aub0, arg1, Local0)
		m600(arg0, 14, Local0, bb29)

		Concatenate(aub1, arg1, Local0)
		m600(arg0, 15, Local0, bb2a)

		if (y078) {
			Concatenate(Derefof(Refof(aub0)), arg1, Local0)
			m600(arg0, 16, Local0, bb29)

			Concatenate(Derefof(Refof(aub1)), arg1, Local0)
			m600(arg0, 17, Local0, bb2a)
		}

		Concatenate(Derefof(Index(paub, 0)), arg1, Local0)
		m600(arg0, 18, Local0, bb29)

		Concatenate(Derefof(Index(paub, 1)), arg1, Local0)
		m600(arg0, 19, Local0, bb2a)

		// Method returns Buffer

		Concatenate(m601(3, 0), arg1, Local0)
		m600(arg0, 20, Local0, bb29)

		Concatenate(m601(3, 1), arg1, Local0)
		m600(arg0, 21, Local0, bb2a)

		// Method returns Reference to Buffer

		if (y500) {
			Concatenate(Derefof(m602(3, 0, 1)), arg1, Local0)
			m600(arg0, 22, Local0, bb29)

			Concatenate(Derefof(m602(3, 1, 1)), arg1, Local0)
			m600(arg0, 23, Local0, bb2a)
		}

		// Boundary Cases

		Store(Concatenate(Buffer(){0x5a}, arg2), Local0)
		m600(arg0, 24, Local0, bb2b)

		Store(Concatenate(Buffer(){0x5a, 0x00}, arg2), Local0)
		m600(arg0, 25, Local0, bb2c)

		Store(0, Local1)
		Store(Concatenate(Buffer(Local1){}, arg3), Local0)
		m600(arg0, 26, Local0, bb2d)
	}

	// String to Buffer conversion of the String Source operand of
	// ToString operator (has a visual effect in shortening of the
	// String taken the null character, that is impossible to show
	// with an immediate String constant).

	Method(m037, 4)
	{
		Store(ToString(arg1, Ones), Local0)
		m600(arg0, 0, Local0, bs20)

		Store(ToString(arg1, 3), Local0)
		m600(arg0, 1, Local0, bs21)

		Store(ToString(arg1, aui0), Local0)
		m600(arg0, 2, Local0, bs20)

		Store(ToString(arg1, aui7), Local0)
		m600(arg0, 3, Local0, bs21)

		if (y078) {
			Store(ToString(arg1, Derefof(Refof(aui0))), Local0)
			m600(arg0, 4, Local0, bs20)

			Store(ToString(arg1, Derefof(Refof(aui7))), Local0)
			m600(arg0, 5, Local0, bs21)
		}

		Store(ToString(arg1, Derefof(Index(paui, 0))), Local0)
		m600(arg0, 6, Local0, bs20)

		Store(ToString(arg1, Derefof(Index(paui, 7))), Local0)
		m600(arg0, 7, Local0, bs21)

		// Method returns Length parameter

		Store(ToString(arg1, m601(1, 0)), Local0)
		m600(arg0, 8, Local0, bs20)

		Store(ToString(arg1, m601(1, 7)), Local0)
		m600(arg0, 9, Local0, bs21)

		// Method returns Reference to Length parameter

		if (y500) {
			Store(ToString(arg1, Derefof(m601(1, 0))), Local0)
			m600(arg0, 10, Local0, bs20)

			Store(ToString(arg1, Derefof(m601(1, 7))), Local0)
			m600(arg0, 11, Local0, bs21)
		}

		ToString(arg1, Ones, Local0)
		m600(arg0, 12, Local0, bs20)

		ToString(arg1, 3, Local0)
		m600(arg0, 13, Local0, bs21)

		ToString(arg1, aui0, Local0)
		m600(arg0, 14, Local0, bs20)

		ToString(arg1, aui7, Local0)
		m600(arg0, 15, Local0, bs21)

		if (y078) {
			ToString(arg1, Derefof(Refof(aui0)), Local0)
			m600(arg0, 16, Local0, bs20)

			ToString(arg1, Derefof(Refof(aui7)), Local0)
			m600(arg0, 17, Local0, bs21)
		}

		ToString(arg1, Derefof(Index(paui, 0)), Local0)
		m600(arg0, 18, Local0, bs20)

		ToString(arg1, Derefof(Index(paui, 7)), Local0)
		m600(arg0, 19, Local0, bs21)

		// Method returns Length parameter

		ToString(arg1, m601(1, 0), Local0)
		m600(arg0, 20, Local0, bs20)

		ToString(arg1, m601(1, 7), Local0)
		m600(arg0, 21, Local0, bs21)

		// Method returns Reference to Length parameter

		if (y500) {
			ToString(arg1, Derefof(m601(1, 0)), Local0)
			m600(arg0, 22, Local0, bs20)

			ToString(arg1, Derefof(m601(1, 7)), Local0)
			m600(arg0, 23, Local0, bs21)
		}

		// Boundary Cases

		Store(ToString(arg2, Ones), Local0)
		m600(arg0, 24, Local0, bs22)

		Store(ToString(arg2, 3), Local0)
		m600(arg0, 25, Local0, bs22)

		Store(ToString(arg3, Ones), Local0)
		m600(arg0, 26, Local0, bs23)

		Store(ToString(arg3, 3), Local0)
		m600(arg0, 27, Local0, bs24)
	}
	
//	Method(m038, 1)

//	Method(m039, 1)

	// Buffer to Integer implicit conversion Cases.

	// Buffer to Integer conversion of the Buffer sole operand
	// of the 1-parameter Integer arithmetic operators
	// (Decrement, Increment, FindSetLeftBit, FindSetRightBit, Not)

	Method(m64l, 3)
	{
		// Decrement
		if (y501) {
			Store(Decrement(arg1), Local0)
			m600(arg0, 0, Local0, bi12)
		
			Store(Decrement(arg2), Local0)
			m600(arg0, 1, Local0, bi16)
		}

		// Increment
		if (y501) {
			Store(Increment(arg1), Local0)
			m600(arg0, 2, Local0, bi13)

			Store(Increment(arg2), Local0)
			m600(arg0, 3, Local0, bi17)
		}

		// FindSetLeftBit

		Store(FindSetLeftBit(arg1), Local0)
		m600(arg0, 4, Local0, 10)

		Store(FindSetLeftBit(arg2), Local0)
		m600(arg0, 5, Local0, 64)

		// FindSetRightBit

		Store(FindSetRightBit(arg1), Local0)
		m600(arg0, 6, Local0, 1)

		Store(FindSetRightBit(arg2), Local0)
		m600(arg0, 7, Local0, 3)

		// Not

		Store(Not(arg1), Local0)
		m600(arg0, 8, Local0, 0xfffffffffffffcde)

		Store(Not(arg2), Local0)
		m600(arg0, 9, Local0, 0x01834c6e29af5d7b)
	}

	Method(m32l, 3)
	{
		// Decrement
		if (y501) {
			Store(Decrement(arg1), Local0)
			m600(arg0, 0, Local0, bi12)

			Store(Decrement(arg2), Local0)
			m600(arg0, 1, Local0, bi18)
		}

		// Increment
		if (y501) {
			Store(Increment(arg1), Local0)
			m600(arg0, 2, Local0, bi13)

			Store(Increment(arg2), Local0)
			m600(arg0, 3, Local0, bi19)
		}

		// FindSetLeftBit

		Store(FindSetLeftBit(arg1), Local0)
		m600(arg0, 4, Local0, 10)

		Store(FindSetLeftBit(arg2), Local0)
		m600(arg0, 5, Local0, 32)

		// FindSetRightBit

		Store(FindSetRightBit(arg1), Local0)
		m600(arg0, 6, Local0, 1)

		Store(FindSetRightBit(arg2), Local0)
		m600(arg0, 7, Local0, 3)

		// Not

		Store(Not(arg1), Local0)
		m600(arg0, 8, Local0, 0xfffffcde)

		Store(Not(arg2), Local0)
		m600(arg0, 9, Local0, 0x29af5d7b)
	}

	// Buffer to Integer conversion of the Buffer sole operand
	// of the LNot Logical Integer operator
	Method(m03a, 4)
	{
		Store(LNot(arg3), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LNot(arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		if (F64) {
			Store(LNot(arg2), Local0)
			m600(arg0, 2, Local0, Zero)
		} else {
			Store(LNot(arg2), Local0)
			m600(arg0, 3, Local0, Zero)
		}
	}

	// Buffer to Integer conversion of the Buffer sole operand
	// of the FromBCD and ToBCD conversion operators

	Method(m64m, 4)
	{
		// FromBCD

		Store(FromBCD(arg1), Local0)
		m600(arg0, 2, Local0, 0x141)

		Store(FromBCD(arg2), Local0)
		m600(arg0, 3, Local0, 0xd76162ee9ec35)

		FromBCD(arg1, Local0)
		m600(arg0, 2, Local0, 0x141)

		FromBCD(arg2, Local0)
		m600(arg0, 3, Local0, 0xd76162ee9ec35)

		// ToBCD

		Store(ToBCD(arg1), Local0)
		m600(arg0, 4, Local0, 0x801)

// ??? No error of iASL on constant folding
		Store(ToBCD(arg3), Local0)
		m600(arg0, 5, Local0, 0x3789012345678901)

		ToBCD(arg1, Local0)
		m600(arg0, 4, Local0, 0x801)

		ToBCD(arg3, Local0)
		m600(arg0, 5, Local0, 0x3789012345678901)
	}

	Method(m32m, 4)
	{
		// FromBCD

		Store(FromBCD(arg1), Local0)
		m600(arg0, 2, Local0, 0x141)

		Store(FromBCD(arg2), Local0)
		m600(arg0, 3, Local0, 0x55f2cc0)

		FromBCD(arg1, Local0)
		m600(arg0, 2, Local0, 0x141)

		FromBCD(arg2, Local0)
		m600(arg0, 3, Local0, 0x55f2cc0)

		// ToBCD

		Store(ToBCD(arg1), Local0)
		m600(arg0, 4, Local0, 0x801)

		Store(ToBCD(arg3), Local0)
		m600(arg0, 5, Local0, 0x90123456)

		ToBCD(arg1, Local0)
		m600(arg0, 4, Local0, 0x801)

		ToBCD(arg3, Local0)
		m600(arg0, 5, Local0, 0x90123456)
	}

	// Buffer to Integer conversion of each Buffer operand
	// of the 2-parameter Integer arithmetic operators
	// Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
	// ShiftLeft, ShiftRight, Subtract, Xor

	// Add, common 32-bit/64-bit test
	Method(m03b, 2)
	{
		// Conversion of the first operand

		Store(Add(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Add(arg1, 1), Local0)
		m600(arg0, 1, Local0, 0x322)

		Store(Add(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Add(arg1, aui6), Local0)
		m600(arg0, 3, Local0, 0x322)

		if (y078) {
			Store(Add(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Add(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x322)
		}

		Store(Add(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Add(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x322)

		// Method returns Integer

		Store(Add(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Add(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Add(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x322)
		}

		Add(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Add(arg1, 1, Local0)
		m600(arg0, 13, Local0, 0x322)

		Add(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Add(arg1, aui6, Local0)
		m600(arg0, 15, Local0, 0x322)

		if (y078) {
			Add(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Add(arg1, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x322)
		}

		Add(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Add(arg1, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x322)

		// Method returns Integer

		Add(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Add(arg1, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Add(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Add(arg1, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x322)
		}

		// Conversion of the second operand

		Store(Add(0, arg1), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(Add(1, arg1), Local0)
		m600(arg0, 25, Local0, 0x322)

		Store(Add(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(Add(aui6, arg1), Local0)
		m600(arg0, 27, Local0, 0x322)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(Add(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 29, Local0, 0x322)
		}

		Store(Add(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(Add(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 31, Local0, 0x322)

		// Method returns Integer

		Store(Add(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(Add(m601(1, 6), arg1), Local0)
		m600(arg0, 33, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(Add(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0x322)
		}

		Add(0, arg1, Local0)
		m600(arg0, 36, Local0, 0x321)

		Add(1, arg1, Local0)
		m600(arg0, 37, Local0, 0x322)

		Add(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0x321)

		Add(aui6, arg1, Local0)
		m600(arg0, 39, Local0, 0x322)

		if (y078) {
			Add(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0x321)

			Add(Derefof(Refof(aui6)), arg1, Local0)
			m600(arg0, 41, Local0, 0x322)
		}

		Add(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0x321)

		Add(Derefof(Index(paui, 6)), arg1, Local0)
		m600(arg0, 43, Local0, 0x322)

		// Method returns Integer

		Add(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0x321)

		Add(m601(1, 6), arg1, Local0)
		m600(arg0, 45, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0x321)

			Add(Derefof(m602(1, 6, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0x322)
		}
	}

	// Add, 64-bit
	Method(m03c, 3)
	{
		// Conversion of the first operand

		Store(Add(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Add(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a285)

		Store(Add(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Add(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Store(Add(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Add(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a285)
		}

		Store(Add(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Add(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Store(Add(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Add(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Add(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a285)
		}

		Add(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Add(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a285)

		Add(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Add(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Add(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Add(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a285)
		}

		Add(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Add(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Add(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Add(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Add(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a285)
		}

		// Conversion of the second operand

		Store(Add(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(Add(1, arg2), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a285)

		Store(Add(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(Add(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(Add(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a285)
		}

		Store(Add(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(Add(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Store(Add(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(Add(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(Add(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a285)
		}

		Add(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		Add(1, arg2, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a285)

		Add(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		Add(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Add(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			Add(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a285)
		}

		Add(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		Add(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Add(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		Add(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			Add(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a285)
		}

		// Conversion of the both operands

		Store(Add(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a5a5)

		Store(Add(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a5a5)

		Add(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a5a5)

		Add(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a5a5)
	}

	// Add, 32-bit
	Method(m03d, 3)
	{
		// Conversion of the first operand

		Store(Add(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Add(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xd650a285)

		Store(Add(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Add(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xd650a285)

		if (y078) {
			Store(Add(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Add(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xd650a285)
		}

		Store(Add(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(Add(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xd650a285)

		// Method returns Integer

		Store(Add(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Add(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xd650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Add(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xd650a285)
		}

		Add(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Add(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xd650a285)

		Add(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Add(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xd650a285)

		if (y078) {
			Add(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Add(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xd650a285)
		}

		Add(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Add(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xd650a285)

		// Method returns Integer

		Add(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Add(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xd650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Add(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xd650a285)
		}

		// Conversion of the second operand

		Store(Add(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xd650a284)

		Store(Add(1, arg2), Local0)
		m600(arg0, 25, Local0, 0xd650a285)

		Store(Add(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xd650a284)

		Store(Add(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0xd650a285)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xd650a284)

			Store(Add(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0xd650a285)
		}

		Store(Add(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xd650a284)

		Store(Add(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0xd650a285)

		// Method returns Integer

		Store(Add(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xd650a284)

		Store(Add(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0xd650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xd650a284)

			Store(Add(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xd650a285)
		}

		Add(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xd650a284)

		Add(1, arg2, Local0)
		m600(arg0, 37, Local0, 0xd650a285)

		Add(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xd650a284)

		Add(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0xd650a285)

		if (y078) {
			Add(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xd650a284)

			Add(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0xd650a285)
		}

		Add(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xd650a284)

		Add(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0xd650a285)

		// Method returns Integer

		Add(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xd650a284)

		Add(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0xd650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xd650a284)

			Add(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xd650a285)
		}

		// Conversion of the both operands

		Store(Add(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xd650a5a5)

		Store(Add(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xd650a5a5)

		Add(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xd650a5a5)

		Add(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xd650a5a5)
	}

	// And, common 32-bit/64-bit test
	Method(m03e, 2)
	{
		// Conversion of the first operand

		Store(And(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And(arg1, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x321)

		Store(And(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And(arg1, auij), Local0)
		m600(arg0, 3, Local0, 0x321)

		if (y078) {
			Store(And(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And(arg1, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x321)
		}

		Store(And(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And(arg1, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x321)

		// Method returns Integer

		Store(And(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And(arg1, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And(arg1, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x321)
		}

		And(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0)

		And(arg1, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x321)

		And(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And(arg1, auij, Local0)
		m600(arg0, 15, Local0, 0x321)

		if (y078) {
			And(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And(arg1, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x321)
		}

		And(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And(arg1, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x321)

		// Method returns Integer

		And(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And(arg1, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			And(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And(arg1, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x321)
		}

		// Conversion of the second operand

		Store(And(0, arg1), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffffffffffff, arg1), Local0)
		m600(arg0, 25, Local0, 0x321)

		Store(And(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auij, arg1), Local0)
		m600(arg0, 27, Local0, 0x321)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auij)), arg1), Local0)
			m600(arg0, 29, Local0, 0x321)
		}

		Store(And(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 19)), arg1), Local0)
		m600(arg0, 31, Local0, 0x321)

		// Method returns Integer

		Store(And(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 19), arg1), Local0)
		m600(arg0, 33, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 19, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0x321)
		}

		And(0, arg1, Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffffffffffff, arg1, Local0)
		m600(arg0, 37, Local0, 0x321)

		And(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0)

		And(auij, arg1, Local0)
		m600(arg0, 39, Local0, 0x321)

		if (y078) {
			And(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auij)), arg1, Local0)
			m600(arg0, 41, Local0, 0x321)
		}

		And(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 19)), arg1, Local0)
		m600(arg0, 43, Local0, 0x321)

		// Method returns Integer

		And(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 19), arg1, Local0)
		m600(arg0, 45, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 19, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0x321)
		}
	}

	// And, 64-bit
	Method(m03f, 3)
	{
		// Conversion of the first operand

		Store(And(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And(arg2, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a284)

		Store(And(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And(arg2, auij), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(And(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And(arg2, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a284)
		}

		Store(And(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And(arg2, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(And(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And(arg2, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And(arg2, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a284)
		}

		And(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0)

		And(arg2, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		And(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And(arg2, auij, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a284)

		if (y078) {
			And(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And(arg2, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a284)
		}

		And(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And(arg2, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		And(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And(arg2, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And(arg2, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the second operand

		Store(And(0, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffffffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a284)

		Store(And(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auij, arg2), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auij)), arg2), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a284)
		}

		Store(And(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 19)), arg2), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(And(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 19), arg2), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 19, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a284)
		}

		And(0, arg2, Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffffffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a284)

		And(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0)

		And(auij, arg2, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a284)

		if (y078) {
			And(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auij)), arg2, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a284)
		}

		And(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 19)), arg2, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		And(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 19), arg2, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 19, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the both operands

		Store(And(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x200)

		Store(And(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x200)

		And(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x200)

		And(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x200)
	}

	// And, 32-bit
	Method(m040, 3)
	{
		// Conversion of the first operand

		Store(And(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And(arg2, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0xd650a284)

		Store(And(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And(arg2, auii), Local0)
		m600(arg0, 3, Local0, 0xd650a284)

		if (y078) {
			Store(And(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And(arg2, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0xd650a284)
		}

		Store(And(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And(arg2, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0xd650a284)

		// Method returns Integer

		Store(And(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And(arg2, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And(arg2, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0xd650a284)
		}

		And(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0)

		And(arg2, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0xd650a284)

		And(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And(arg2, auii, Local0)
		m600(arg0, 15, Local0, 0xd650a284)

		if (y078) {
			And(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And(arg2, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0xd650a284)
		}

		And(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And(arg2, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0xd650a284)

		// Method returns Integer

		And(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And(arg2, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And(arg2, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0xd650a284)
		}

		// Conversion of the second operand

		Store(And(0, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0xd650a284)

		Store(And(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auii, arg2), Local0)
		m600(arg0, 27, Local0, 0xd650a284)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auii)), arg2), Local0)
			m600(arg0, 29, Local0, 0xd650a284)
		}

		Store(And(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 18)), arg2), Local0)
		m600(arg0, 31, Local0, 0xd650a284)

		// Method returns Integer

		Store(And(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 18), arg2), Local0)
		m600(arg0, 33, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 18, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xd650a284)
		}

		And(0, arg2, Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0xd650a284)

		And(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0)

		And(auii, arg2, Local0)
		m600(arg0, 39, Local0, 0xd650a284)

		if (y078) {
			And(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auii)), arg2, Local0)
			m600(arg0, 41, Local0, 0xd650a284)
		}

		And(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 18)), arg2, Local0)
		m600(arg0, 43, Local0, 0xd650a284)

		// Method returns Integer

		And(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 18), arg2, Local0)
		m600(arg0, 45, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 18, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xd650a284)
		}

		// Conversion of the both operands

		Store(And(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x200)

		Store(And(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x200)

		And(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x200)

		And(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x200)
	}

	// Divide, common 32-bit/64-bit test
	Method(m041, 2)
	{
		// Conversion of the first operand

		Store(Divide(arg1, 1), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Divide(arg1, 0x321), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide(arg1, aui6), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Divide(arg1, aui1), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Divide(arg1, Derefof(Refof(aui1))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Divide(arg1, Derefof(Index(paui, 1))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide(arg1, m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Divide(arg1, m601(1, 1)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Divide(arg1, Derefof(m602(1, 1, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide(arg1, 1, Local1, Local0)
		m600(arg0, 12, Local0, 0x321)

		Divide(arg1, 0x321, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide(arg1, aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0x321)

		Divide(arg1, aui1, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide(arg1, Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0x321)

			Divide(arg1, Derefof(Refof(aui1)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide(arg1, Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0x321)

		Divide(arg1, Derefof(Index(paui, 1)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide(arg1, m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0x321)

		Divide(arg1, m601(1, 1), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(arg1, Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0x321)

			Divide(arg1, Derefof(m602(1, 1, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, arg1), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0x321, arg1), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, arg1), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(aui1, arg1), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), arg1), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 1), arg1), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, arg1, Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0x321, arg1, Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, arg1, Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(aui1, arg1, Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), arg1, Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(aui1)), arg1, Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), arg1, Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 1)), arg1, Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), arg1, Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 1), arg1, Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), arg1, Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 1, 1)), arg1, Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}
	}

	// Divide, 64-bit
	Method(m042, 3)
	{
		// Conversion of the first operand

		Store(Divide(arg2, 1), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Divide(arg2, 0xfe7cb391d650a284), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide(arg2, aui6), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Divide(arg2, aui4), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Divide(arg2, Derefof(Refof(aui4))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Divide(arg2, Derefof(Index(paui, 4))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide(arg2, m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Divide(arg2, m601(1, 4)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Divide(arg2, Derefof(m602(1, 4, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide(arg2, 1, Local1, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Divide(arg2, 0xfe7cb391d650a284, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide(arg2, aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Divide(arg2, aui4, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide(arg2, Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Divide(arg2, Derefof(Refof(aui4)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide(arg2, Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Divide(arg2, Derefof(Index(paui, 4)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide(arg2, m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Divide(arg2, m601(1, 4), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(arg2, Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Divide(arg2, Derefof(m602(1, 4, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0xfe7cb391d650a284, arg2), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(aui4, arg2), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(aui4)), arg2), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 4)), arg2), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 4), arg2), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 4, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, arg2, Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0xfe7cb391d650a284, arg2, Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, arg2, Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(aui4, arg2, Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), arg2, Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(aui4)), arg2, Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), arg2, Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 4)), arg2, Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), arg2, Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 4), arg2, Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), arg2, Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 4, 1)), arg2, Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}

		// Conversion of the both operands

		Store(Divide(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0)

		Store(Divide(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x0051558eb950f5a7)

		Divide(arg1, arg2, Local1, Local0)
		m600(arg0, 50, Local0, 0)

		Divide(arg2, arg1, Local1, Local0)
		m600(arg0, 51, Local0, 0x0051558eb950f5a7)
	}

	// Divide, 32-bit
	Method(m043, 3)
	{
		// Conversion of the first operand

		Store(Divide(arg2, 1), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Divide(arg2, 0xd650a284), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide(arg2, aui6), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Divide(arg2, auik), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Divide(arg2, Derefof(Refof(auik))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(Divide(arg2, Derefof(Index(paui, 20))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide(arg2, m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Divide(arg2, m601(1, 20)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Divide(arg2, Derefof(m602(1, 20, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide(arg2, 1, Local1, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Divide(arg2, 0xd650a284, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide(arg2, aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Divide(arg2, auik, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide(arg2, Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Divide(arg2, Derefof(Refof(auik)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide(arg2, Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Divide(arg2, Derefof(Index(paui, 20)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide(arg2, m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Divide(arg2, m601(1, 20), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(arg2, Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Divide(arg2, Derefof(m602(1, 20, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0xd650a284, arg2), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(auik, arg2), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(auik)), arg2), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 20)), arg2), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 20), arg2), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 20, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, arg2, Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0xd650a284, arg2, Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, arg2, Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(auik, arg2, Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), arg2, Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(auik)), arg2, Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), arg2, Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 20)), arg2, Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), arg2, Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 20), arg2, Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), arg2, Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 20, 1)), arg2, Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}

		// Conversion of the both operands

		Store(Divide(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0)

		Store(Divide(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x00447ec3)

		Divide(arg1, arg2, Local1, Local0)
		m600(arg0, 50, Local0, 0)

		Divide(arg2, arg1, Local1, Local0)
		m600(arg0, 51, Local0, 0x00447ec3)
	}

	// Mod, common 32-bit/64-bit test
	Method(m044, 2)
	{
		// Conversion of the first operand

		Store(Mod(arg1, 0x322), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Mod(arg1, 0x320), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod(arg1, auig), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Mod(arg1, auih), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Mod(arg1, Derefof(Refof(auig))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Mod(arg1, Derefof(Refof(auih))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod(arg1, Derefof(Index(paui, 16))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Mod(arg1, Derefof(Index(paui, 17))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod(arg1, m601(1, 16)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Mod(arg1, m601(1, 17)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(arg1, Derefof(m602(1, 16, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Mod(arg1, Derefof(m602(1, 17, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod(arg1, 0x322, Local0)
		m600(arg0, 12, Local0, 0x321)

		Mod(arg1, 0x320, Local0)
		m600(arg0, 13, Local0, 1)

		Mod(arg1, auig, Local0)
		m600(arg0, 14, Local0, 0x321)

		Mod(arg1, auih, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod(arg1, Derefof(Refof(auig)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Mod(arg1, Derefof(Refof(auih)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod(arg1, Derefof(Index(paui, 16)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Mod(arg1, Derefof(Index(paui, 17)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod(arg1, m601(1, 16), Local0)
		m600(arg0, 20, Local0, 0x321)

		Mod(arg1, m601(1, 17), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod(arg1, Derefof(m602(1, 16, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Mod(arg1, Derefof(m602(1, 17, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0x322, arg1), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0x320, arg1), Local0)
		m600(arg0, 25, Local0, 0x320)

		Store(Mod(auig, arg1), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auih, arg1), Local0)
		m600(arg0, 27, Local0, 0x320)

		if (y078) {
			Store(Mod(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 29, Local0, 0x320)
		}

		Store(Mod(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 31, Local0, 0x320)

		// Method returns Integer

		Store(Mod(m601(1, 16), arg1), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 17), arg1), Local0)
		m600(arg0, 33, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0x320)
		}

		Mod(0x322, arg1, Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0x320, arg1, Local0)
		m600(arg0, 37, Local0, 0x320)

		Mod(auig, arg1, Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auih, arg1, Local0)
		m600(arg0, 39, Local0, 0x320)

		if (y078) {
			Mod(Derefof(Refof(auig)), arg1, Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auih)), arg1, Local0)
			m600(arg0, 41, Local0, 0x320)
		}

		Mod(Derefof(Index(paui, 16)), arg1, Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 17)), arg1, Local0)
		m600(arg0, 43, Local0, 0x320)

		// Method returns Integer

		Mod(m601(1, 16), arg1, Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 17), arg1, Local0)
		m600(arg0, 45, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m602(1, 16, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m602(1, 17, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0x320)
		}
	}

	// Mod, 64-bit
	Method(m045, 3)
	{
		// Conversion of the first operand

		Store(Mod(arg2, 0xfe7cb391d650a285), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Mod(arg2, 0xfe7cb391d650a283), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod(arg2, auid), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Mod(arg2, auif), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Mod(arg2, Derefof(Refof(auid))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Mod(arg2, Derefof(Refof(auif))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod(arg2, Derefof(Index(paui, 13))), Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		Store(Mod(arg2, Derefof(Index(paui, 15))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod(arg2, m601(1, 13)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Mod(arg2, m601(1, 15)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(arg2, Derefof(m602(1, 13, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Mod(arg2, Derefof(m602(1, 15, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod(arg2, 0xfe7cb391d650a285, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Mod(arg2, 0xfe7cb391d650a283, Local0)
		m600(arg0, 13, Local0, 1)

		Mod(arg2, auid, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Mod(arg2, auif, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod(arg2, Derefof(Refof(auid)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Mod(arg2, Derefof(Refof(auif)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod(arg2, Derefof(Index(paui, 13)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Mod(arg2, Derefof(Index(paui, 15)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod(arg2, m601(1, 13), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Mod(arg2, m601(1, 15), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod(arg2, Derefof(m602(1, 13, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Mod(arg2, Derefof(m602(1, 15, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0xfe7cb391d650a285, arg2), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0xfe7cb391d650a283, arg2), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a283)

		Store(Mod(auid, arg2), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auif, arg2), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Store(Mod(Derefof(Refof(auid)), arg2), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auif)), arg2), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a283)
		}

		Store(Mod(Derefof(Index(paui, 13)), arg2), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 15)), arg2), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Store(Mod(m601(1, 13), arg2), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 15), arg2), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m602(1, 13, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m602(1, 15, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a283)
		}

		Mod(0xfe7cb391d650a285, arg2, Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0xfe7cb391d650a283, arg2, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a283)

		Mod(auid, arg2, Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auif, arg2, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Mod(Derefof(Refof(auid)), arg2, Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auif)), arg2, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a283)
		}

		Mod(Derefof(Index(paui, 13)), arg2, Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 15)), arg2, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Mod(m601(1, 13), arg2, Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 15), arg2, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m602(1, 13, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m602(1, 15, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a283)
		}

		// Conversion of the both operands

		Store(Mod(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x321)

		Store(Mod(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x2fd)

		Mod(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x321)

		Mod(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x2fd)
	}

	// Mod, 32-bit
	Method(m046, 3)
	{
		// Conversion of the first operand

		Store(Mod(arg2, 0xd650a285), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Mod(arg2, 0xd650a283), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod(arg2, auil), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Mod(arg2, auim), Local0)
		m600(arg0, 14, Local0, 1)

		if (y078) {
			Store(Mod(arg2, Derefof(Refof(auil))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Mod(arg2, Derefof(Refof(auim))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod(arg2, Derefof(Index(paui, 21))), Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Store(Mod(arg2, Derefof(Index(paui, 22))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod(arg2, m601(1, 21)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Mod(arg2, m601(1, 22)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(arg2, Derefof(m601(1, 21, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Mod(arg2, Derefof(m601(1, 22, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod(arg2, 0xd650a285, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Mod(arg2, 0xd650a283, Local0)
		m600(arg0, 13, Local0, 1)

		Mod(arg2, auil, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Mod(arg2, auim, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod(arg2, Derefof(Refof(auil)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Mod(arg2, Derefof(Refof(auim)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod(arg2, Derefof(Index(paui, 21)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Mod(arg2, Derefof(Index(paui, 22)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod(arg2, m601(1, 21), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Mod(arg2, m601(1, 22), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod(arg2, Derefof(m601(1, 21, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Mod(arg2, Derefof(m601(1, 22, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0xd650a285, arg2), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0xd650a283, arg2), Local0)
		m600(arg0, 25, Local0, 0xd650a283)

		Store(Mod(auil, arg2), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auim, arg2), Local0)
		m600(arg0, 27, Local0, 0xd650a283)

		if (y078) {
			Store(Mod(Derefof(Refof(auil)), arg2), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auim)), arg2), Local0)
			m600(arg0, 29, Local0, 0xd650a283)
		}

		Store(Mod(Derefof(Index(paui, 21)), arg2), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 22)), arg2), Local0)
		m600(arg0, 31, Local0, 0xd650a283)

		// Method returns Integer

		Store(Mod(m601(1, 21), arg2), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 22), arg2), Local0)
		m600(arg0, 33, Local0, 0xd650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m601(1, 21, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m601(1, 22, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xd650a283)
		}

		Mod(0xd650a285, arg2, Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0xd650a283, arg2, Local0)
		m600(arg0, 37, Local0, 0xd650a283)

		Mod(auil, arg2, Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auim, arg2, Local0)
		m600(arg0, 39, Local0, 0xd650a283)

		if (y078) {
			Mod(Derefof(Refof(auil)), arg2, Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auim)), arg2, Local0)
			m600(arg0, 41, Local0, 0xd650a283)
		}

		Mod(Derefof(Index(paui, 21)), arg2, Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 22)), arg2, Local0)
		m600(arg0, 43, Local0, 0xd650a283)

		// Method returns Integer

		Mod(m601(1, 21), arg2, Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 22), arg2, Local0)
		m600(arg0, 45, Local0, 0xd650a283)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m601(1, 21, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m601(1, 22, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xd650a283)
		}

		// Conversion of the both operands

		Store(Mod(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x321)

		Store(Mod(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x261)

		Mod(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x321)

		Mod(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x261)
	}

	// Multiply, common 32-bit/64-bit test
	Method(m047, 2)
	{
		// Conversion of the first operand

		Store(Multiply(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply(arg1, 1), Local0)
		m600(arg0, 1, Local0, 0x321)

		Store(Multiply(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply(arg1, aui6), Local0)
		m600(arg0, 3, Local0, 0x321)

		if (y078) {
			Store(Multiply(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x321)
		}

		Store(Multiply(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x321)

		// Method returns Integer

		Store(Multiply(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x321)
		}

		Multiply(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply(arg1, 1, Local0)
		m600(arg0, 13, Local0, 0x321)

		Multiply(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply(arg1, aui6, Local0)
		m600(arg0, 15, Local0, 0x321)

		if (y078) {
			Multiply(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply(arg1, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x321)
		}

		Multiply(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply(arg1, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x321)

		// Method returns Integer

		Multiply(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply(arg1, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply(arg1, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x321)
		}

		// Conversion of the second operand

		Store(Multiply(0, arg1), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, arg1), Local0)
		m600(arg0, 25, Local0, 0x321)

		Store(Multiply(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, arg1), Local0)
		m600(arg0, 27, Local0, 0x321)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 29, Local0, 0x321)
		}

		Store(Multiply(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 31, Local0, 0x321)

		// Method returns Integer

		Store(Multiply(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), arg1), Local0)
		m600(arg0, 33, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0x321)
		}

		Multiply(0, arg1, Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, arg1, Local0)
		m600(arg0, 37, Local0, 0x321)

		Multiply(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, arg1, Local0)
		m600(arg0, 39, Local0, 0x321)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), arg1, Local0)
			m600(arg0, 41, Local0, 0x321)
		}

		Multiply(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), arg1, Local0)
		m600(arg0, 43, Local0, 0x321)

		// Method returns Integer

		Multiply(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), arg1, Local0)
		m600(arg0, 45, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0x321)
		}
	}

	// Multiply, 64-bit
	Method(m048, 3)
	{
		// Conversion of the first operand

		Store(Multiply(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a284)

		Store(Multiply(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(Multiply(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a284)
		}

		Store(Multiply(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(Multiply(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a284)
		}

		Multiply(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		Multiply(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Multiply(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a284)
		}

		Multiply(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Multiply(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the second operand

		Store(Multiply(0, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, arg2), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a284)

		Store(Multiply(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a284)
		}

		Store(Multiply(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(Multiply(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a284)
		}

		Multiply(0, arg2, Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, arg2, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a284)

		Multiply(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a284)
		}

		Multiply(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Multiply(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the both operands

		Store(Multiply(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x442ddb4f924c7f04)

		Store(Multiply(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x442ddb4f924c7f04)

		Multiply(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x442ddb4f924c7f04)

		Multiply(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x442ddb4f924c7f04)
	}

	// Multiply, 32-bit
	Method(m049, 3)
	{
		// Conversion of the first operand

		Store(Multiply(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xd650a284)

		Store(Multiply(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xd650a284)

		if (y078) {
			Store(Multiply(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xd650a284)
		}

		Store(Multiply(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xd650a284)

		// Method returns Integer

		Store(Multiply(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xd650a284)
		}

		Multiply(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xd650a284)

		Multiply(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xd650a284)

		if (y078) {
			Multiply(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xd650a284)
		}

		Multiply(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xd650a284)

		// Method returns Integer

		Multiply(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xd650a284)
		}

		// Conversion of the second operand

		Store(Multiply(0, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, arg2), Local0)
		m600(arg0, 25, Local0, 0xd650a284)

		Store(Multiply(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0xd650a284)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0xd650a284)
		}

		Store(Multiply(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0xd650a284)

		// Method returns Integer

		Store(Multiply(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xd650a284)
		}

		Multiply(0, arg2, Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, arg2, Local0)
		m600(arg0, 37, Local0, 0xd650a284)

		Multiply(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0xd650a284)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0xd650a284)
		}

		Multiply(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0xd650a284)

		// Method returns Integer

		Multiply(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xd650a284)
		}

		// Conversion of the both operands

		Store(Multiply(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x924c7f04)

		Store(Multiply(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x924c7f04)

		Multiply(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x924c7f04)

		Multiply(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x924c7f04)
	}

	// NAnd, common 32-bit/64-bit test
	Method(m04a, 2)
	{
		// Conversion of the first operand

		Store(NAnd(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0xffffffffffffffff)

		Store(NAnd(arg1, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfffffffffffffcde)

		Store(NAnd(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffffffffffff)

		Store(NAnd(arg1, auij), Local0)
		m600(arg0, 3, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(NAnd(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffffffffffff)

			Store(NAnd(arg1, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfffffffffffffcde)
		}

		Store(NAnd(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffffffffffff)

		Store(NAnd(arg1, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(NAnd(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffffffffffff)

		Store(NAnd(arg1, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffffffffffff)

			Store(NAnd(arg1, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfffffffffffffcde)
		}

		NAnd(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0xffffffffffffffff)

		NAnd(arg1, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfffffffffffffcde)

		NAnd(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffffffffffff)

		NAnd(arg1, auij, Local0)
		m600(arg0, 15, Local0, 0xfffffffffffffcde)

		if (y078) {
			NAnd(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffffffffffff)

			NAnd(arg1, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfffffffffffffcde)
		}

		NAnd(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffffffffffff)

		NAnd(arg1, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		NAnd(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffffffffffff)

		NAnd(arg1, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffffffffffff)

			NAnd(arg1, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfffffffffffffcde)
		}

		// Conversion of the second operand

		Store(NAnd(0, arg1), Local0)
		m600(arg0, 24, Local0, 0xffffffffffffffff)

		Store(NAnd(0xffffffffffffffff, arg1), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffcde)

		Store(NAnd(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0xffffffffffffffff)

		Store(NAnd(auij, arg1), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(Refof(auij)), arg1), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffcde)
		}

		Store(NAnd(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0xffffffffffffffff)

		Store(NAnd(Derefof(Index(paui, 19)), arg1), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(NAnd(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0xffffffffffffffff)

		Store(NAnd(m601(1, 19), arg1), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(m602(1, 19, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffcde)
		}

		NAnd(0, arg1, Local0)
		m600(arg0, 36, Local0, 0xffffffffffffffff)

		NAnd(0xffffffffffffffff, arg1, Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffcde)

		NAnd(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0xffffffffffffffff)

		NAnd(auij, arg1, Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffcde)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0xffffffffffffffff)

			NAnd(Derefof(Refof(auij)), arg1, Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffcde)
		}

		NAnd(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0xffffffffffffffff)

		NAnd(Derefof(Index(paui, 19)), arg1, Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		NAnd(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0xffffffffffffffff)

		NAnd(m601(1, 19), arg1, Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0xffffffffffffffff)

			NAnd(Derefof(m602(1, 19, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffcde)
		}
	}

	// NAnd, 64-bit
	Method(m04b, 3)
	{
		// Conversion of the first operand

		Store(NAnd(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xffffffffffffffff)

		Store(NAnd(arg2, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x01834c6e29af5d7b)

		Store(NAnd(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffffffffffff)

		Store(NAnd(arg2, auij), Local0)
		m600(arg0, 3, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(NAnd(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffffffffffff)

			Store(NAnd(arg2, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x01834c6e29af5d7b)
		}

		Store(NAnd(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffffffffffff)

		Store(NAnd(arg2, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(NAnd(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffffffffffff)

		Store(NAnd(arg2, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffffffffffff)

			Store(NAnd(arg2, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xffffffffffffffff)

		NAnd(arg2, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x01834c6e29af5d7b)

		NAnd(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffffffffffff)

		NAnd(arg2, auij, Local0)
		m600(arg0, 15, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			NAnd(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffffffffffff)

			NAnd(arg2, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffffffffffff)

		NAnd(arg2, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		NAnd(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffffffffffff)

		NAnd(arg2, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffffffffffff)

			NAnd(arg2, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the second operand

		Store(NAnd(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xffffffffffffffff)

		Store(NAnd(0xffffffffffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7b)

		Store(NAnd(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xffffffffffffffff)

		Store(NAnd(auij, arg2), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(Refof(auij)), arg2), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7b)
		}

		Store(NAnd(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xffffffffffffffff)

		Store(NAnd(Derefof(Index(paui, 19)), arg2), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(NAnd(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xffffffffffffffff)

		Store(NAnd(m601(1, 19), arg2), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(m602(1, 19, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xffffffffffffffff)

		NAnd(0xffffffffffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7b)

		NAnd(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xffffffffffffffff)

		NAnd(auij, arg2, Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xffffffffffffffff)

			NAnd(Derefof(Refof(auij)), arg2, Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xffffffffffffffff)

		NAnd(Derefof(Index(paui, 19)), arg2, Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		NAnd(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xffffffffffffffff)

		NAnd(m601(1, 19), arg2, Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xffffffffffffffff)

			NAnd(Derefof(m602(1, 19, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the both operands

		Store(NAnd(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xfffffffffffffdff)

		Store(NAnd(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xfffffffffffffdff)

		NAnd(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xfffffffffffffdff)

		NAnd(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xfffffffffffffdff)
	}

	// NAnd, 32-bit
	Method(m04c, 3)
	{
		// Conversion of the first operand

		Store(NAnd(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xffffffff)

		Store(NAnd(arg2, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0x29af5d7b)

		Store(NAnd(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffff)

		Store(NAnd(arg2, auii), Local0)
		m600(arg0, 3, Local0, 0x29af5d7b)

		if (y078) {
			Store(NAnd(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffff)

			Store(NAnd(arg2, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0x29af5d7b)
		}

		Store(NAnd(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffff)

		Store(NAnd(arg2, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0x29af5d7b)

		// Method returns Integer

		Store(NAnd(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffff)

		Store(NAnd(arg2, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffff)

			Store(NAnd(arg2, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0x29af5d7b)
		}

		NAnd(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xffffffff)

		NAnd(arg2, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0x29af5d7b)

		NAnd(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffff)

		NAnd(arg2, auii, Local0)
		m600(arg0, 15, Local0, 0x29af5d7b)

		if (y078) {
			NAnd(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffff)

			NAnd(arg2, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0x29af5d7b)
		}

		NAnd(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffff)

		NAnd(arg2, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0x29af5d7b)

		// Method returns Integer

		NAnd(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffff)

		NAnd(arg2, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffff)

			NAnd(arg2, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0x29af5d7b)
		}

		// Conversion of the second operand

		Store(NAnd(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xffffffff)

		Store(NAnd(0xffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0x29af5d7b)

		Store(NAnd(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xffffffff)

		Store(NAnd(auii, arg2), Local0)
		m600(arg0, 27, Local0, 0x29af5d7b)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xffffffff)

			Store(NAnd(Derefof(Refof(auii)), arg2), Local0)
			m600(arg0, 29, Local0, 0x29af5d7b)
		}

		Store(NAnd(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xffffffff)

		Store(NAnd(Derefof(Index(paui, 18)), arg2), Local0)
		m600(arg0, 31, Local0, 0x29af5d7b)

		// Method returns Integer

		Store(NAnd(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xffffffff)

		Store(NAnd(m601(1, 18), arg2), Local0)
		m600(arg0, 33, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xffffffff)

			Store(NAnd(Derefof(m602(1, 18, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x29af5d7b)
		}

		NAnd(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xffffffff)

		NAnd(0xffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0x29af5d7b)

		NAnd(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xffffffff)

		NAnd(auii, arg2, Local0)
		m600(arg0, 39, Local0, 0x29af5d7b)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xffffffff)

			NAnd(Derefof(Refof(auii)), arg2, Local0)
			m600(arg0, 41, Local0, 0x29af5d7b)
		}

		NAnd(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xffffffff)

		NAnd(Derefof(Index(paui, 18)), arg2, Local0)
		m600(arg0, 43, Local0, 0x29af5d7b)

		// Method returns Integer

		NAnd(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xffffffff)

		NAnd(m601(1, 18), arg2, Local0)
		m600(arg0, 45, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xffffffff)

			NAnd(Derefof(m602(1, 18, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x29af5d7b)
		}

		// Conversion of the both operands

		Store(NAnd(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xfffffdff)

		Store(NAnd(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xfffffdff)

		NAnd(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xfffffdff)

		NAnd(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xfffffdff)
	}

	// NOr, common 32-bit/64-bit test
	Method(m04d, 2)
	{
		// Conversion of the first operand

		Store(NOr(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0xfffffffffffffcde)

		Store(NOr(arg1, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0xfffffffffffffcde)

		Store(NOr(arg1, auij), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfffffffffffffcde)

			Store(NOr(arg1, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfffffffffffffcde)

		Store(NOr(arg1, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfffffffffffffcde)

		Store(NOr(arg1, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfffffffffffffcde)

			Store(NOr(arg1, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0xfffffffffffffcde)

		NOr(arg1, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0xfffffffffffffcde)

		NOr(arg1, auij, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfffffffffffffcde)

			NOr(arg1, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfffffffffffffcde)

		NOr(arg1, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfffffffffffffcde)

		NOr(arg1, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfffffffffffffcde)

			NOr(arg1, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, arg1), Local0)
		m600(arg0, 24, Local0, 0xfffffffffffffcde)

		Store(NOr(0xffffffffffffffff, arg1), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0xfffffffffffffcde)

		Store(NOr(auij, arg1), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0xfffffffffffffcde)

			Store(NOr(Derefof(Refof(auij)), arg1), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0xfffffffffffffcde)

		Store(NOr(Derefof(Index(paui, 19)), arg1), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0xfffffffffffffcde)

		Store(NOr(m601(1, 19), arg1), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0xfffffffffffffcde)

			Store(NOr(Derefof(m602(1, 19, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, arg1, Local0)
		m600(arg0, 36, Local0, 0xfffffffffffffcde)

		NOr(0xffffffffffffffff, arg1, Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0xfffffffffffffcde)

		NOr(auij, arg1, Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0xfffffffffffffcde)

			NOr(Derefof(Refof(auij)), arg1, Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0xfffffffffffffcde)

		NOr(Derefof(Index(paui, 19)), arg1, Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0xfffffffffffffcde)

		NOr(m601(1, 19), arg1, Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0xfffffffffffffcde)

			NOr(Derefof(m602(1, 19, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0)
		}
	}

	// NOr, 64-bit
	Method(m04e, 3)
	{
		// Conversion of the first operand

		Store(NOr(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0x01834c6e29af5d7b)

		Store(NOr(arg2, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0x01834c6e29af5d7b)

		Store(NOr(arg2, auij), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x01834c6e29af5d7b)

			Store(NOr(arg2, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x01834c6e29af5d7b)

		Store(NOr(arg2, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x01834c6e29af5d7b)

		Store(NOr(arg2, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x01834c6e29af5d7b)

			Store(NOr(arg2, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0x01834c6e29af5d7b)

		NOr(arg2, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0x01834c6e29af5d7b)

		NOr(arg2, auij, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x01834c6e29af5d7b)

			NOr(arg2, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x01834c6e29af5d7b)

		NOr(arg2, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x01834c6e29af5d7b)

		NOr(arg2, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x01834c6e29af5d7b)

			NOr(arg2, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, arg2), Local0)
		m600(arg0, 24, Local0, 0x01834c6e29af5d7b)

		Store(NOr(0xffffffffffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0x01834c6e29af5d7b)

		Store(NOr(auij, arg2), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0x01834c6e29af5d7b)

			Store(NOr(Derefof(Refof(auij)), arg2), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0x01834c6e29af5d7b)

		Store(NOr(Derefof(Index(paui, 19)), arg2), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0x01834c6e29af5d7b)

		Store(NOr(m601(1, 19), arg2), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0x01834c6e29af5d7b)

			Store(NOr(Derefof(m602(1, 19, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, arg2, Local0)
		m600(arg0, 36, Local0, 0x01834c6e29af5d7b)

		NOr(0xffffffffffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0x01834c6e29af5d7b)

		NOr(auij, arg2, Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0x01834c6e29af5d7b)

			NOr(Derefof(Refof(auij)), arg2, Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0x01834c6e29af5d7b)

		NOr(Derefof(Index(paui, 19)), arg2, Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0x01834c6e29af5d7b)

		NOr(m601(1, 19), arg2, Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0x01834c6e29af5d7b)

			NOr(Derefof(m602(1, 19, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0)
		}

		// Conversion of the both operands

		Store(NOr(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x01834c6e29af5c5a)

		Store(NOr(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x01834c6e29af5c5a)

		NOr(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x01834c6e29af5c5a)

		NOr(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x01834c6e29af5c5a)
	}

	// NOr, 32-bit
	Method(m04f, 3)
	{
		// Conversion of the first operand

		Store(NOr(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0x29af5d7b)

		Store(NOr(arg2, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0x29af5d7b)

		Store(NOr(arg2, auii), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x29af5d7b)

			Store(NOr(arg2, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x29af5d7b)

		Store(NOr(arg2, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x29af5d7b)

		Store(NOr(arg2, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x29af5d7b)

			Store(NOr(arg2, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0x29af5d7b)

		NOr(arg2, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0x29af5d7b)

		NOr(arg2, auii, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x29af5d7b)

			NOr(arg2, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x29af5d7b)

		NOr(arg2, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x29af5d7b)

		NOr(arg2, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x29af5d7b)

			NOr(arg2, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, arg2), Local0)
		m600(arg0, 24, Local0, 0x29af5d7b)

		Store(NOr(0xffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0x29af5d7b)

		Store(NOr(auii, arg2), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0x29af5d7b)

			Store(NOr(Derefof(Refof(auii)), arg2), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0x29af5d7b)

		Store(NOr(Derefof(Index(paui, 18)), arg2), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0x29af5d7b)

		Store(NOr(m601(1, 18), arg2), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0x29af5d7b)

			Store(NOr(Derefof(m602(1, 18, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, arg2, Local0)
		m600(arg0, 36, Local0, 0x29af5d7b)

		NOr(0xffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0x29af5d7b)

		NOr(auii, arg2, Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0x29af5d7b)

			NOr(Derefof(Refof(auii)), arg2, Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0x29af5d7b)

		NOr(Derefof(Index(paui, 18)), arg2, Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0x29af5d7b)

		NOr(m601(1, 18), arg2, Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0x29af5d7b)

			NOr(Derefof(m602(1, 18, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0)
		}

		// Conversion of the both operands

		Store(NOr(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x29af5c5a)

		Store(NOr(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0x29af5c5a)

		NOr(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x29af5c5a)

		NOr(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0x29af5c5a)
	}

	// Or, common 32-bit/64-bit test
	Method(m050, 2)
	{
		// Conversion of the first operand

		Store(Or(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Or(arg1, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffffffffffff)

		Store(Or(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Or(arg1, auij), Local0)
		m600(arg0, 3, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Or(arg1, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xffffffffffffffff)
		}

		Store(Or(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Or(arg1, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Or(arg1, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Or(arg1, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffffffffffff)
		}

		Or(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Or(arg1, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffffffffffff)

		Or(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Or(arg1, auij, Local0)
		m600(arg0, 15, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Or(arg1, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xffffffffffffffff)
		}

		Or(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Or(arg1, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Or(arg1, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Or(arg1, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffffffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, arg1), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(Or(0xffffffffffffffff, arg1), Local0)
		m600(arg0, 25, Local0, 0xffffffffffffffff)

		Store(Or(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(Or(auij, arg1), Local0)
		m600(arg0, 27, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(Or(Derefof(Refof(auij)), arg1), Local0)
			m600(arg0, 29, Local0, 0xffffffffffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(Or(Derefof(Index(paui, 19)), arg1), Local0)
		m600(arg0, 31, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(Or(m601(1, 19), arg1), Local0)
		m600(arg0, 33, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(Or(Derefof(m602(1, 19, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0xffffffffffffffff)
		}

		Or(0, arg1, Local0)
		m600(arg0, 36, Local0, 0x321)

		Or(0xffffffffffffffff, arg1, Local0)
		m600(arg0, 37, Local0, 0xffffffffffffffff)

		Or(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0x321)

		Or(auij, arg1, Local0)
		m600(arg0, 39, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0x321)

			Or(Derefof(Refof(auij)), arg1, Local0)
			m600(arg0, 41, Local0, 0xffffffffffffffff)
		}

		Or(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0x321)

		Or(Derefof(Index(paui, 19)), arg1, Local0)
		m600(arg0, 43, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0x321)

		Or(m601(1, 19), arg1, Local0)
		m600(arg0, 45, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0x321)

			Or(Derefof(m602(1, 19, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0xffffffffffffffff)
		}
	}

	// Or, 64-bit
	Method(m051, 3)
	{
		// Conversion of the first operand

		Store(Or(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Or(arg2, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffffffffffff)

		Store(Or(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Or(arg2, auij), Local0)
		m600(arg0, 3, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Or(arg2, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xffffffffffffffff)
		}

		Store(Or(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Or(arg2, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Or(arg2, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Or(arg2, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffffffffffff)
		}

		Or(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Or(arg2, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffffffffffff)

		Or(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Or(arg2, auij, Local0)
		m600(arg0, 15, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Or(arg2, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xffffffffffffffff)
		}

		Or(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Or(arg2, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Or(arg2, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Or(arg2, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffffffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(Or(0xffffffffffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0xffffffffffffffff)

		Store(Or(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(Or(auij, arg2), Local0)
		m600(arg0, 27, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(Or(Derefof(Refof(auij)), arg2), Local0)
			m600(arg0, 29, Local0, 0xffffffffffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(Or(Derefof(Index(paui, 19)), arg2), Local0)
		m600(arg0, 31, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(Or(m601(1, 19), arg2), Local0)
		m600(arg0, 33, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(Or(Derefof(m602(1, 19, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xffffffffffffffff)
		}

		Or(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		Or(0xffffffffffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0xffffffffffffffff)

		Or(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		Or(auij, arg2, Local0)
		m600(arg0, 39, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			Or(Derefof(Refof(auij)), arg2, Local0)
			m600(arg0, 41, Local0, 0xffffffffffffffff)
		}

		Or(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		Or(Derefof(Index(paui, 19)), arg2, Local0)
		m600(arg0, 43, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		Or(m601(1, 19), arg2, Local0)
		m600(arg0, 45, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			Or(Derefof(m602(1, 19, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xffffffffffffffff)
		}

		// Conversion of the both operands

		Store(Or(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a3a5)

		Store(Or(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a3a5)

		Or(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a3a5)

		Or(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a3a5)
	}

	// Or, 32-bit
	Method(m052, 3)
	{
		// Conversion of the first operand

		Store(Or(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Or(arg2, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffff)

		Store(Or(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Or(arg2, auii), Local0)
		m600(arg0, 3, Local0, 0xffffffff)

		if (y078) {
			Store(Or(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Or(arg2, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0xffffffff)
		}

		Store(Or(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(Or(arg2, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0xffffffff)

		// Method returns Integer

		Store(Or(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Or(arg2, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Or(arg2, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffff)
		}

		Or(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Or(arg2, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffff)

		Or(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Or(arg2, auii, Local0)
		m600(arg0, 15, Local0, 0xffffffff)

		if (y078) {
			Or(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Or(arg2, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0xffffffff)
		}

		Or(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Or(arg2, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0xffffffff)

		// Method returns Integer

		Or(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Or(arg2, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Or(arg2, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xd650a284)

		Store(Or(0xffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0xffffffff)

		Store(Or(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xd650a284)

		Store(Or(auii, arg2), Local0)
		m600(arg0, 27, Local0, 0xffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xd650a284)

			Store(Or(Derefof(Refof(auii)), arg2), Local0)
			m600(arg0, 29, Local0, 0xffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xd650a284)

		Store(Or(Derefof(Index(paui, 18)), arg2), Local0)
		m600(arg0, 31, Local0, 0xffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xd650a284)

		Store(Or(m601(1, 18), arg2), Local0)
		m600(arg0, 33, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xd650a284)

			Store(Or(Derefof(m602(1, 18, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0xffffffff)
		}

		Or(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xd650a284)

		Or(0xffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0xffffffff)

		Or(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xd650a284)

		Or(auii, arg2, Local0)
		m600(arg0, 39, Local0, 0xffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xd650a284)

			Or(Derefof(Refof(auii)), arg2, Local0)
			m600(arg0, 41, Local0, 0xffffffff)
		}

		Or(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xd650a284)

		Or(Derefof(Index(paui, 18)), arg2, Local0)
		m600(arg0, 43, Local0, 0xffffffff)

		// Method returns Integer

		Or(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xd650a284)

		Or(m601(1, 18), arg2, Local0)
		m600(arg0, 45, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xd650a284)

			Or(Derefof(m602(1, 18, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0xffffffff)
		}

		// Conversion of the both operands

		Store(Or(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xd650a3a5)

		Store(Or(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xd650a3a5)

		Or(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xd650a3a5)

		Or(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xd650a3a5)
	}

	// ShiftLeft, common 32-bit/64-bit test
	Method(m053, 3)
	{
		// Conversion of the first operand

		Store(ShiftLeft(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(ShiftLeft(arg1, 1), Local0)
		m600(arg0, 1, Local0, 0x642)

		Store(ShiftLeft(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(ShiftLeft(arg1, aui6), Local0)
		m600(arg0, 3, Local0, 0x642)

		if (y078) {
			Store(ShiftLeft(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(ShiftLeft(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x642)
		}

		Store(ShiftLeft(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(ShiftLeft(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x642)

		// Method returns Integer

		Store(ShiftLeft(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(ShiftLeft(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x642)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(ShiftLeft(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x642)
		}

		ShiftLeft(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		ShiftLeft(arg1, 1, Local0)
		m600(arg0, 13, Local0, 0x642)

		ShiftLeft(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		ShiftLeft(arg1, aui6, Local0)
		m600(arg0, 15, Local0, 0x642)

		if (y078) {
			ShiftLeft(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			ShiftLeft(arg1, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x642)
		}

		ShiftLeft(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		ShiftLeft(arg1, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x642)

		// Method returns Integer

		ShiftLeft(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		ShiftLeft(arg1, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x642)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			ShiftLeft(arg1, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x642)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, arg2), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, arg2, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, arg2, Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x800)
		}
	}

	// ShiftLeft, 64-bit
	Method(m054, 4)
	{
		// Conversion of the first operand

		Store(ShiftLeft(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xfcf96723aca14508)

		Store(ShiftLeft(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xfcf96723aca14508)

		if (y078) {
			Store(ShiftLeft(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(ShiftLeft(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfcf96723aca14508)
		}

		Store(ShiftLeft(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfcf96723aca14508)

		// Method returns Integer

		Store(ShiftLeft(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfcf96723aca14508)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(ShiftLeft(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfcf96723aca14508)
		}

		ShiftLeft(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		ShiftLeft(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xfcf96723aca14508)

		ShiftLeft(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		ShiftLeft(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xfcf96723aca14508)

		if (y078) {
			ShiftLeft(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			ShiftLeft(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfcf96723aca14508)
		}

		ShiftLeft(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		ShiftLeft(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfcf96723aca14508)

		// Method returns Integer

		ShiftLeft(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		ShiftLeft(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfcf96723aca14508)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			ShiftLeft(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfcf96723aca14508)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, arg3), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, arg3), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, arg3), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, arg3), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), arg3), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), arg3), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), arg3), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), arg3), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), arg3), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), arg3), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), arg3), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), arg3), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, arg3, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, arg3, Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, arg3, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, arg3, Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), arg3, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), arg3, Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), arg3, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), arg3, Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), arg3, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), arg3, Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), arg3, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), arg3, Local0)
			m600(arg0, 47, Local0, 0x800)
		}

		// Conversion of the both operands

		Store(ShiftLeft(arg1, arg3), Local0)
		m600(arg0, 48, Local0, 0x190800)

		Store(ShiftLeft(arg2, arg3), Local0)
		m600(arg0, 49, Local0, 0xE59C8EB285142000)

		ShiftLeft(arg1, arg3, Local0)
		m600(arg0, 50, Local0, 0x190800)

		ShiftLeft(arg2, arg3, Local0)
		m600(arg0, 51, Local0, 0xE59C8EB285142000)
	}

	// ShiftLeft, 32-bit
	Method(m055, 4)
	{
		// Conversion of the first operand

		Store(ShiftLeft(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(ShiftLeft(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xaca14508)

		Store(ShiftLeft(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(ShiftLeft(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xaca14508)

		if (y078) {
			Store(ShiftLeft(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(ShiftLeft(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xaca14508)
		}

		Store(ShiftLeft(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(ShiftLeft(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xaca14508)

		// Method returns Integer

		Store(ShiftLeft(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(ShiftLeft(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xaca14508)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(ShiftLeft(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xaca14508)
		}

		ShiftLeft(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		ShiftLeft(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xaca14508)

		ShiftLeft(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		ShiftLeft(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xaca14508)

		if (y078) {
			ShiftLeft(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			ShiftLeft(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xaca14508)
		}

		ShiftLeft(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		ShiftLeft(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xaca14508)

		// Method returns Integer

		ShiftLeft(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		ShiftLeft(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xaca14508)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			ShiftLeft(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xaca14508)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, arg3), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, arg3), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, arg3), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, arg3), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), arg3), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), arg3), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), arg3), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), arg3), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), arg3), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), arg3), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), arg3), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), arg3), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, arg3, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, arg3, Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, arg3, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, arg3, Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), arg3, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), arg3, Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), arg3, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), arg3, Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), arg3, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), arg3, Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), arg3, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), arg3, Local0)
			m600(arg0, 47, Local0, 0x800)
		}

		// Conversion of the both operands

		Store(ShiftLeft(arg1, arg3), Local0)
		m600(arg0, 48, Local0, 0x190800)

		Store(ShiftLeft(arg2, arg3), Local0)
		m600(arg0, 49, Local0, 0x85142000)

		ShiftLeft(arg1, arg3, Local0)
		m600(arg0, 50, Local0, 0x190800)

		ShiftLeft(arg2, arg3, Local0)
		m600(arg0, 51, Local0, 0x85142000)
	}

	// ShiftRight, common 32-bit/64-bit test
	Method(m056, 3)
	{
		// Conversion of the first operand

		Store(ShiftRight(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(ShiftRight(arg1, 1), Local0)
		m600(arg0, 1, Local0, 0x190)

		Store(ShiftRight(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(ShiftRight(arg1, aui6), Local0)
		m600(arg0, 3, Local0, 0x190)

		if (y078) {
			Store(ShiftRight(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(ShiftRight(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x190)
		}

		Store(ShiftRight(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(ShiftRight(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x190)

		// Method returns Integer

		Store(ShiftRight(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(ShiftRight(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x190)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(ShiftRight(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x190)
		}

		ShiftRight(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		ShiftRight(arg1, 1, Local0)
		m600(arg0, 13, Local0, 0x190)

		ShiftRight(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		ShiftRight(arg1, aui6, Local0)
		m600(arg0, 15, Local0, 0x190)

		if (y078) {
			ShiftRight(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			ShiftRight(arg1, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x190)
		}

		ShiftRight(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		ShiftRight(arg1, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x190)

		// Method returns Integer

		ShiftRight(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		ShiftRight(arg1, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x190)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			ShiftRight(arg1, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x190)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, arg2), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xd650a284, arg2), Local0)
		m600(arg0, 25, Local0, 0x1aca14)

		Store(ShiftRight(aui1, arg2), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(auik, arg2), Local0)
		m600(arg0, 27, Local0, 0x1aca14)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), arg2), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(auik)), arg2), Local0)
			m600(arg0, 29, Local0, 0x1aca14)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), arg2), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 20)), arg2), Local0)
		m600(arg0, 31, Local0, 0x1aca14)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), arg2), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 20), arg2), Local0)
		m600(arg0, 33, Local0, 0x1aca14)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 20, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x1aca14)
		}

		ShiftRight(0x321, arg2, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xd650a284, arg2, Local0)
		m600(arg0, 37, Local0, 0x1aca14)

		ShiftRight(aui1, arg2, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(auik, arg2, Local0)
		m600(arg0, 39, Local0, 0x1aca14)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), arg2, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(auik)), arg2, Local0)
			m600(arg0, 41, Local0, 0x1aca14)
		}

		ShiftRight(Derefof(Index(paui, 1)), arg2, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 20)), arg2, Local0)
		m600(arg0, 43, Local0, 0x1aca14)

		// Method returns Integer

		ShiftRight(m601(1, 1), arg2, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 20), arg2, Local0)
		m600(arg0, 45, Local0, 0x1aca14)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 20, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x1aca14)
		}
	}

	// ShiftRight, 64-bit
	Method(m057, 4)
	{
		// Conversion of the first operand

		Store(ShiftRight(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0x7f3e59c8eb285142)

		Store(ShiftRight(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0x7f3e59c8eb285142)

		if (y078) {
			Store(ShiftRight(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(ShiftRight(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x7f3e59c8eb285142)
		}

		Store(ShiftRight(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x7f3e59c8eb285142)

		// Method returns Integer

		Store(ShiftRight(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x7f3e59c8eb285142)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(ShiftRight(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x7f3e59c8eb285142)
		}

		ShiftRight(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		ShiftRight(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0x7f3e59c8eb285142)

		ShiftRight(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		ShiftRight(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0x7f3e59c8eb285142)

		if (y078) {
			ShiftRight(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			ShiftRight(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x7f3e59c8eb285142)
		}

		ShiftRight(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		ShiftRight(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x7f3e59c8eb285142)

		// Method returns Integer

		ShiftRight(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		ShiftRight(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x7f3e59c8eb285142)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			ShiftRight(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x7f3e59c8eb285142)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, arg3), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xfe7cb391d650a284, arg3), Local0)
		m600(arg0, 25, Local0, 0x1fcf96723aca14)

		Store(ShiftRight(aui1, arg3), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(aui4, arg3), Local0)
		m600(arg0, 27, Local0, 0x1fcf96723aca14)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), arg3), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(aui4)), arg3), Local0)
			m600(arg0, 29, Local0, 0x1fcf96723aca14)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), arg3), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 4)), arg3), Local0)
		m600(arg0, 31, Local0, 0x1fcf96723aca14)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), arg3), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 4), arg3), Local0)
		m600(arg0, 33, Local0, 0x1fcf96723aca14)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), arg3), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 4, 1)), arg3), Local0)
			m600(arg0, 35, Local0, 0x1fcf96723aca14)
		}

		ShiftRight(0x321, arg3, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xfe7cb391d650a284, arg3, Local0)
		m600(arg0, 37, Local0, 0x1fcf96723aca14)

		ShiftRight(aui1, arg3, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(aui4, arg3, Local0)
		m600(arg0, 39, Local0, 0x1fcf96723aca14)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), arg3, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(aui4)), arg3, Local0)
			m600(arg0, 41, Local0, 0x1fcf96723aca14)
		}

		ShiftRight(Derefof(Index(paui, 1)), arg3, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 4)), arg3, Local0)
		m600(arg0, 43, Local0, 0x1fcf96723aca14)

		// Method returns Integer

		ShiftRight(m601(1, 1), arg3, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 4), arg3, Local0)
		m600(arg0, 45, Local0, 0x1fcf96723aca14)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), arg3, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 4, 1)), arg3, Local0)
			m600(arg0, 47, Local0, 0x1fcf96723aca14)
		}

		// Conversion of the both operands

		Store(ShiftRight(arg1, arg3), Local0)
		m600(arg0, 48, Local0, 0)

		Store(ShiftRight(arg2, arg3), Local0)
		m600(arg0, 49, Local0, 0x1fcf96723aca14)

		ShiftRight(arg1, arg3, Local0)
		m600(arg0, 50, Local0, 0)

		ShiftRight(arg2, arg3, Local0)
		m600(arg0, 51, Local0, 0x1fcf96723aca14)
	}

	// ShiftRight, 32-bit
	Method(m058, 4)
	{
		// Conversion of the first operand

		Store(ShiftRight(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(ShiftRight(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0x6b285142)

		Store(ShiftRight(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(ShiftRight(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0x6b285142)

		if (y078) {
			Store(ShiftRight(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(ShiftRight(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x6b285142)
		}

		Store(ShiftRight(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(ShiftRight(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x6b285142)

		// Method returns Integer

		Store(ShiftRight(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(ShiftRight(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x6b285142)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(ShiftRight(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x6b285142)
		}

		ShiftRight(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		ShiftRight(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0x6b285142)

		ShiftRight(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		ShiftRight(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0x6b285142)

		if (y078) {
			ShiftRight(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			ShiftRight(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x6b285142)
		}

		ShiftRight(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		ShiftRight(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x6b285142)

		// Method returns Integer

		ShiftRight(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		ShiftRight(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x6b285142)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			ShiftRight(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x6b285142)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, arg3), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xd650a284, arg3), Local0)
		m600(arg0, 25, Local0, 0x1aca14)

		Store(ShiftRight(aui1, arg3), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(auik, arg3), Local0)
		m600(arg0, 27, Local0, 0x1aca14)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), arg3), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(auik)), arg3), Local0)
			m600(arg0, 29, Local0, 0x1aca14)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), arg3), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 20)), arg3), Local0)
		m600(arg0, 31, Local0, 0x1aca14)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), arg3), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 20), arg3), Local0)
		m600(arg0, 33, Local0, 0x1aca14)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), arg3), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 20, 1)), arg3), Local0)
			m600(arg0, 35, Local0, 0x1aca14)
		}

		ShiftRight(0x321, arg3, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xd650a284, arg3, Local0)
		m600(arg0, 37, Local0, 0x1aca14)

		ShiftRight(aui1, arg3, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(auik, arg3, Local0)
		m600(arg0, 39, Local0, 0x1aca14)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), arg3, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(auik)), arg3, Local0)
			m600(arg0, 41, Local0, 0x1aca14)
		}

		ShiftRight(Derefof(Index(paui, 1)), arg3, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 20)), arg3, Local0)
		m600(arg0, 43, Local0, 0x1aca14)

		// Method returns Integer

		ShiftRight(m601(1, 1), arg3, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 20), arg3, Local0)
		m600(arg0, 45, Local0, 0x1aca14)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), arg3, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 20, 1)), arg3, Local0)
			m600(arg0, 47, Local0, 0x1aca14)
		}

		// Conversion of the both operands

		Store(ShiftRight(arg1, arg3), Local0)
		m600(arg0, 48, Local0, 0)

		Store(ShiftRight(arg2, arg3), Local0)
		m600(arg0, 49, Local0, 0x1aca14)

		ShiftRight(arg1, arg3, Local0)
		m600(arg0, 50, Local0, 0)

		ShiftRight(arg2, arg3, Local0)
		m600(arg0, 51, Local0, 0x1aca14)
	}

	// Subtract, common 32-bit/64-bit test
	Method(m059, 2)
	{
		// Conversion of the first operand

		Store(Subtract(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Subtract(arg1, 1), Local0)
		m600(arg0, 1, Local0, 0x320)

		Store(Subtract(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Subtract(arg1, aui6), Local0)
		m600(arg0, 3, Local0, 0x320)

		if (y078) {
			Store(Subtract(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Subtract(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x320)
		}

		Store(Subtract(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Subtract(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x320)

		// Method returns Integer

		Store(Subtract(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Subtract(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Subtract(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x320)
		}

		Subtract(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Subtract(arg1, 1, Local0)
		m600(arg0, 13, Local0, 0x320)

		Subtract(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Subtract(arg1, aui6, Local0)
		m600(arg0, 15, Local0, 0x320)

		if (y078) {
			Subtract(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Subtract(arg1, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x320)
		}

		Subtract(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Subtract(arg1, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x320)

		// Method returns Integer

		Subtract(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Subtract(arg1, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Subtract(arg1, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x320)
		}

		// Conversion of the second operand

		Store(Subtract(0, arg1), Local0)
		m600(arg0, 24, Local0, 0xfffffffffffffcdf)

		Store(Subtract(1, arg1), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffce0)

		Store(Subtract(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0xfffffffffffffcdf)

		Store(Subtract(aui6, arg1), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffce0)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0xfffffffffffffcdf)

			Store(Subtract(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffce0)
		}

		Store(Subtract(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0xfffffffffffffcdf)

		Store(Subtract(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffce0)

		// Method returns Integer

		Store(Subtract(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0xfffffffffffffcdf)

		Store(Subtract(m601(1, 6), arg1), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffce0)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0xfffffffffffffcdf)

			Store(Subtract(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffce0)
		}

		Subtract(0, arg1, Local0)
		m600(arg0, 36, Local0, 0xfffffffffffffcdf)

		Subtract(1, arg1, Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffce0)

		Subtract(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0xfffffffffffffcdf)

		Subtract(aui6, arg1, Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffce0)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0xfffffffffffffcdf)

			Subtract(Derefof(Refof(aui6)), arg1, Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffce0)
		}

		Subtract(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0xfffffffffffffcdf)

		Subtract(Derefof(Index(paui, 6)), arg1, Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffce0)

		// Method returns Integer

		Subtract(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0xfffffffffffffcdf)

		Subtract(m601(1, 6), arg1, Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffce0)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0xfffffffffffffcdf)

			Subtract(Derefof(m602(1, 6, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffce0)
		}
	}

	// Subtract, 64-bit
	Method(m05a, 3)
	{
		// Conversion of the first operand

		Store(Subtract(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Subtract(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a283)

		Store(Subtract(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Subtract(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Store(Subtract(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Subtract(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a283)
		}

		Store(Subtract(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Subtract(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Store(Subtract(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Subtract(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Subtract(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a283)
		}

		Subtract(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Subtract(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a283)

		Subtract(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Subtract(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Subtract(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Subtract(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a283)
		}

		Subtract(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Subtract(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Subtract(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Subtract(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Subtract(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a283)
		}

		// Conversion of the second operand

		Store(Subtract(0, arg2), Local0)
		m600(arg0, 24, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(1, arg2), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7d)

		Store(Subtract(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7d)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0x01834c6e29af5d7c)

			Store(Subtract(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7d)
		}

		Store(Subtract(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7d)

		// Method returns Integer

		Store(Subtract(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0x01834c6e29af5d7c)

			Store(Subtract(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7d)
		}

		Subtract(0, arg2, Local0)
		m600(arg0, 36, Local0, 0x01834c6e29af5d7c)

		Subtract(1, arg2, Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7d)

		Subtract(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0x01834c6e29af5d7c)

		Subtract(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7d)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0x01834c6e29af5d7c)

			Subtract(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7d)
		}

		Subtract(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0x01834c6e29af5d7c)

		Subtract(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7d)

		// Method returns Integer

		Subtract(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0x01834c6e29af5d7c)

		Subtract(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0x01834c6e29af5d7c)

			Subtract(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7d)
		}

		// Conversion of the both operands

		Store(Subtract(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x01834c6e29af609d)

		Store(Subtract(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d6509f63)

		Subtract(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x01834c6e29af609d)

		Subtract(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d6509f63)
	}

	// Subtract, 32-bit
	Method(m05b, 3)
	{
		// Conversion of the first operand

		Store(Subtract(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Subtract(arg2, 1), Local0)
		m600(arg0, 1, Local0, 0xd650a283)

		Store(Subtract(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Subtract(arg2, aui6), Local0)
		m600(arg0, 3, Local0, 0xd650a283)

		if (y078) {
			Store(Subtract(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Subtract(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xd650a283)
		}

		Store(Subtract(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(Subtract(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xd650a283)

		// Method returns Integer

		Store(Subtract(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Subtract(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xd650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Subtract(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xd650a283)
		}

		Subtract(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Subtract(arg2, 1, Local0)
		m600(arg0, 13, Local0, 0xd650a283)

		Subtract(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Subtract(arg2, aui6, Local0)
		m600(arg0, 15, Local0, 0xd650a283)

		if (y078) {
			Subtract(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Subtract(arg2, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xd650a283)
		}

		Subtract(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Subtract(arg2, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xd650a283)

		// Method returns Integer

		Subtract(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Subtract(arg2, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xd650a283)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Subtract(arg2, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xd650a283)
		}

		// Conversion of the second operand

		Store(Subtract(0, arg2), Local0)
		m600(arg0, 24, Local0, 0x29af5d7c)

		Store(Subtract(1, arg2), Local0)
		m600(arg0, 25, Local0, 0x29af5d7d)

		Store(Subtract(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0x29af5d7c)

		Store(Subtract(aui6, arg2), Local0)
		m600(arg0, 27, Local0, 0x29af5d7d)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0x29af5d7c)

			Store(Subtract(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 29, Local0, 0x29af5d7d)
		}

		Store(Subtract(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0x29af5d7c)

		Store(Subtract(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 31, Local0, 0x29af5d7d)

		// Method returns Integer

		Store(Subtract(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0x29af5d7c)

		Store(Subtract(m601(1, 6), arg2), Local0)
		m600(arg0, 33, Local0, 0x29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0x29af5d7c)

			Store(Subtract(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x29af5d7d)
		}

		Subtract(0, arg2, Local0)
		m600(arg0, 36, Local0, 0x29af5d7c)

		Subtract(1, arg2, Local0)
		m600(arg0, 37, Local0, 0x29af5d7d)

		Subtract(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0x29af5d7c)

		Subtract(aui6, arg2, Local0)
		m600(arg0, 39, Local0, 0x29af5d7d)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0x29af5d7c)

			Subtract(Derefof(Refof(aui6)), arg2, Local0)
			m600(arg0, 41, Local0, 0x29af5d7d)
		}

		Subtract(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0x29af5d7c)

		Subtract(Derefof(Index(paui, 6)), arg2, Local0)
		m600(arg0, 43, Local0, 0x29af5d7d)

		// Method returns Integer

		Subtract(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0x29af5d7c)

		Subtract(m601(1, 6), arg2, Local0)
		m600(arg0, 45, Local0, 0x29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0x29af5d7c)

			Subtract(Derefof(m602(1, 6, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x29af5d7d)
		}

		// Conversion of the both operands

		Store(Subtract(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0x29af609d)

		Store(Subtract(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xd6509f63)

		Subtract(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0x29af609d)

		Subtract(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xd6509f63)
	}

	// XOr, common 32-bit/64-bit test
	Method(m05c, 2)
	{
		// Conversion of the first operand

		Store(XOr(arg1, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(XOr(arg1, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfffffffffffffcde)

		Store(XOr(arg1, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(XOr(arg1, auij), Local0)
		m600(arg0, 3, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(XOr(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(XOr(arg1, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfffffffffffffcde)
		}

		Store(XOr(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(XOr(arg1, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(XOr(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(XOr(arg1, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(XOr(arg1, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfffffffffffffcde)
		}

		XOr(arg1, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		XOr(arg1, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfffffffffffffcde)

		XOr(arg1, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		XOr(arg1, auij, Local0)
		m600(arg0, 15, Local0, 0xfffffffffffffcde)

		if (y078) {
			XOr(arg1, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			XOr(arg1, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfffffffffffffcde)
		}

		XOr(arg1, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		XOr(arg1, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		XOr(arg1, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		XOr(arg1, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			XOr(arg1, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			XOr(arg1, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfffffffffffffcde)
		}

		// Conversion of the second operand

		Store(XOr(0, arg1), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(XOr(0xffffffffffffffff, arg1), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffcde)

		Store(XOr(aui5, arg1), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(XOr(auij, arg1), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(XOr(Derefof(Refof(auij)), arg1), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffcde)
		}

		Store(XOr(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(XOr(Derefof(Index(paui, 19)), arg1), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(XOr(m601(1, 5), arg1), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(XOr(m601(1, 19), arg1), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(XOr(Derefof(m602(1, 19, 1)), arg1), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffcde)
		}

		XOr(0, arg1, Local0)
		m600(arg0, 36, Local0, 0x321)

		XOr(0xffffffffffffffff, arg1, Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffcde)

		XOr(aui5, arg1, Local0)
		m600(arg0, 38, Local0, 0x321)

		XOr(auij, arg1, Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffcde)

		if (y078) {
			XOr(Derefof(Refof(aui5)), arg1, Local0)
			m600(arg0, 40, Local0, 0x321)

			XOr(Derefof(Refof(auij)), arg1, Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffcde)
		}

		XOr(Derefof(Index(paui, 5)), arg1, Local0)
		m600(arg0, 42, Local0, 0x321)

		XOr(Derefof(Index(paui, 19)), arg1, Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		XOr(m601(1, 5), arg1, Local0)
		m600(arg0, 44, Local0, 0x321)

		XOr(m601(1, 19), arg1, Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), arg1, Local0)
			m600(arg0, 46, Local0, 0x321)

			XOr(Derefof(m602(1, 19, 1)), arg1, Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffcde)
		}
	}

	// XOr, 64-bit
	Method(m05d, 3)
	{
		// Conversion of the first operand

		Store(XOr(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(XOr(arg2, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x01834c6e29af5d7b)

		Store(XOr(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(XOr(arg2, auij), Local0)
		m600(arg0, 3, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(XOr(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(XOr(arg2, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x01834c6e29af5d7b)
		}

		Store(XOr(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(XOr(arg2, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(XOr(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(XOr(arg2, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(XOr(arg2, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x01834c6e29af5d7b)
		}

		XOr(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		XOr(arg2, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x01834c6e29af5d7b)

		XOr(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		XOr(arg2, auij, Local0)
		m600(arg0, 15, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			XOr(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			XOr(arg2, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x01834c6e29af5d7b)
		}

		XOr(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		XOr(arg2, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		XOr(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		XOr(arg2, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			XOr(arg2, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the second operand

		Store(XOr(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(XOr(0xffffffffffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7b)

		Store(XOr(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(XOr(auij, arg2), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(XOr(Derefof(Refof(auij)), arg2), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7b)
		}

		Store(XOr(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(XOr(Derefof(Index(paui, 19)), arg2), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(XOr(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(XOr(m601(1, 19), arg2), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(XOr(Derefof(m602(1, 19, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7b)
		}

		XOr(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		XOr(0xffffffffffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7b)

		XOr(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		XOr(auij, arg2, Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			XOr(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			XOr(Derefof(Refof(auij)), arg2, Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7b)
		}

		XOr(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		XOr(Derefof(Index(paui, 19)), arg2, Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		XOr(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		XOr(m601(1, 19), arg2, Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			XOr(Derefof(m602(1, 19, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the both operands

		Store(XOr(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a1a5)

		Store(XOr(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a1a5)

		XOr(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a1a5)

		XOr(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a1a5)
	}

	// XOr, 32-bit
	Method(m05e, 3)
	{
		// Conversion of the first operand

		Store(XOr(arg2, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(XOr(arg2, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0x29af5d7b)

		Store(XOr(arg2, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(XOr(arg2, auii), Local0)
		m600(arg0, 3, Local0, 0x29af5d7b)

		if (y078) {
			Store(XOr(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(XOr(arg2, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0x29af5d7b)
		}

		Store(XOr(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(XOr(arg2, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0x29af5d7b)

		// Method returns Integer

		Store(XOr(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(XOr(arg2, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(XOr(arg2, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0x29af5d7b)
		}

		XOr(arg2, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		XOr(arg2, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0x29af5d7b)

		XOr(arg2, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		XOr(arg2, auii, Local0)
		m600(arg0, 15, Local0, 0x29af5d7b)

		if (y078) {
			XOr(arg2, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			XOr(arg2, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0x29af5d7b)
		}

		XOr(arg2, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		XOr(arg2, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0x29af5d7b)

		// Method returns Integer

		XOr(arg2, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		XOr(arg2, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(arg2, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			XOr(arg2, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0x29af5d7b)
		}

		// Conversion of the second operand

		Store(XOr(0, arg2), Local0)
		m600(arg0, 24, Local0, 0xd650a284)

		Store(XOr(0xffffffff, arg2), Local0)
		m600(arg0, 25, Local0, 0x29af5d7b)

		Store(XOr(aui5, arg2), Local0)
		m600(arg0, 26, Local0, 0xd650a284)

		Store(XOr(auii, arg2), Local0)
		m600(arg0, 27, Local0, 0x29af5d7b)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 28, Local0, 0xd650a284)

			Store(XOr(Derefof(Refof(auii)), arg2), Local0)
			m600(arg0, 29, Local0, 0x29af5d7b)
		}

		Store(XOr(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 30, Local0, 0xd650a284)

		Store(XOr(Derefof(Index(paui, 18)), arg2), Local0)
		m600(arg0, 31, Local0, 0x29af5d7b)

		// Method returns Integer

		Store(XOr(m601(1, 5), arg2), Local0)
		m600(arg0, 32, Local0, 0xd650a284)

		Store(XOr(m601(1, 18), arg2), Local0)
		m600(arg0, 33, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 34, Local0, 0xd650a284)

			Store(XOr(Derefof(m602(1, 18, 1)), arg2), Local0)
			m600(arg0, 35, Local0, 0x29af5d7b)
		}

		XOr(0, arg2, Local0)
		m600(arg0, 36, Local0, 0xd650a284)

		XOr(0xffffffff, arg2, Local0)
		m600(arg0, 37, Local0, 0x29af5d7b)

		XOr(aui5, arg2, Local0)
		m600(arg0, 38, Local0, 0xd650a284)

		XOr(auii, arg2, Local0)
		m600(arg0, 39, Local0, 0x29af5d7b)

		if (y078) {
			XOr(Derefof(Refof(aui5)), arg2, Local0)
			m600(arg0, 40, Local0, 0xd650a284)

			XOr(Derefof(Refof(auii)), arg2, Local0)
			m600(arg0, 41, Local0, 0x29af5d7b)
		}

		XOr(Derefof(Index(paui, 5)), arg2, Local0)
		m600(arg0, 42, Local0, 0xd650a284)

		XOr(Derefof(Index(paui, 18)), arg2, Local0)
		m600(arg0, 43, Local0, 0x29af5d7b)

		// Method returns Integer

		XOr(m601(1, 5), arg2, Local0)
		m600(arg0, 44, Local0, 0xd650a284)

		XOr(m601(1, 18), arg2, Local0)
		m600(arg0, 45, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), arg2, Local0)
			m600(arg0, 46, Local0, 0xd650a284)

			XOr(Derefof(m602(1, 18, 1)), arg2, Local0)
			m600(arg0, 47, Local0, 0x29af5d7b)
		}

		// Conversion of the both operands

		Store(XOr(arg1, arg2), Local0)
		m600(arg0, 48, Local0, 0xd650a1a5)

		Store(XOr(arg2, arg1), Local0)
		m600(arg0, 49, Local0, 0xd650a1a5)

		XOr(arg1, arg2, Local0)
		m600(arg0, 50, Local0, 0xd650a1a5)

		XOr(arg2, arg1, Local0)
		m600(arg0, 51, Local0, 0xd650a1a5)
	}

	// Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
	// ShiftLeft, ShiftRight, Subtract, Xor

	Method(m64n, 1)
	{
		// Add
		Concatenate(arg0, "-m03b", Local0)
		SRMT(Local0)
		m03b(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m03c", Local0)
		SRMT(Local0)
		m03c(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// And
		Concatenate(arg0, "-m03e", Local0)
		SRMT(Local0)
		m03e(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m03f", Local0)
		SRMT(Local0)
		m03f(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// Divide
		Concatenate(arg0, "-m041", Local0)
		SRMT(Local0)
		m041(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m042", Local0)
		SRMT(Local0)
		m042(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// Mod
		Concatenate(arg0, "-m044", Local0)
		SRMT(Local0)
		m044(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m045", Local0)
		SRMT(Local0)
		m045(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// Multiply
		Concatenate(arg0, "-m047", Local0)
		SRMT(Local0)
		m047(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m048", Local0)
		SRMT(Local0)
		m048(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// NAnd
		Concatenate(arg0, "-m04a", Local0)
		SRMT(Local0)
		m04a(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m04b", Local0)
		SRMT(Local0)
		m04b(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// NOr
		Concatenate(arg0, "-m04d", Local0)
		SRMT(Local0)
		m04d(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m04e", Local0)
		SRMT(Local0)
		m04e(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// Or
		Concatenate(arg0, "-m050", Local0)
		SRMT(Local0)
		m050(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m051", Local0)
		SRMT(Local0)
		m051(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// ShiftLeft
		Concatenate(arg0, "-m053", Local0)
		SRMT(Local0)
		m053(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(1){0xb})
		Concatenate(arg0, "-m054", Local0)
		SRMT(Local0)
		m054(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5},
			Buffer(1){0xb})

		// ShiftRight
		Concatenate(arg0, "-m056", Local0)
		SRMT(Local0)
		m056(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(1){0xb})
		Concatenate(arg0, "-m057", Local0)
		SRMT(Local0)
		m057(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5},
			Buffer(1){0xb})

		// Subtract
		Concatenate(arg0, "-m059", Local0)
		SRMT(Local0)
		m059(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m05a", Local0)
		SRMT(Local0)
		m05a(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// XOr
		Concatenate(arg0, "-m05c", Local0)
		SRMT(Local0)
		m05c(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m05d", Local0)
		SRMT(Local0)
		m05d(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
	}

	Method(m32n, 1)
	{
		// Add
		Concatenate(arg0, "-m03b", Local0)
		SRMT(Local0)
		m03b(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m03d", Local0)
		SRMT(Local0)
		m03d(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// And
		Concatenate(arg0, "-m03e", Local0)
		SRMT(Local0)
		m03e(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m040", Local0)
		SRMT(Local0)
		m040(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// Divide
		Concatenate(arg0, "-m041", Local0)
		SRMT(Local0)
		m041(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m043", Local0)
		SRMT(Local0)
		m043(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// Mod
		Concatenate(arg0, "-m044", Local0)
		SRMT(Local0)
		m044(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m046", Local0)
		SRMT(Local0)
		m046(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// Multiply
		Concatenate(arg0, "-m047", Local0)
		SRMT(Local0)
		m047(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m049", Local0)
		SRMT(Local0)
		m049(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// NAnd
		Concatenate(arg0, "-m04a", Local0)
		SRMT(Local0)
		if (y119) {
			m04a(Local0, Buffer(3){0x21, 0x03, 0x00})
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m04c", Local0)
		SRMT(Local0)
		m04c(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// NOr
		Concatenate(arg0, "-m04d", Local0)
		SRMT(Local0)
		if (y119) {
			m04d(Local0, Buffer(3){0x21, 0x03, 0x00})
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m04f", Local0)
		SRMT(Local0)
		m04f(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// Or
		Concatenate(arg0, "-m050", Local0)
		SRMT(Local0)
		if (y119) {
			m050(Local0, Buffer(3){0x21, 0x03, 0x00})
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m052", Local0)
		SRMT(Local0)
		m052(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// ShiftLeft
		Concatenate(arg0, "-m053", Local0)
		SRMT(Local0)
		m053(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(1){0xb})
		Concatenate(arg0, "-m055", Local0)
		SRMT(Local0)
		m055(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5},
			Buffer(1){0xb})

		// ShiftRight
		Concatenate(arg0, "-m056", Local0)
		SRMT(Local0)
		m056(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(1){0xb})
		Concatenate(arg0, "-m058", Local0)
		SRMT(Local0)
		m058(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5},
			Buffer(1){0xb})

		// Subtract
		Concatenate(arg0, "-m059", Local0)
		SRMT(Local0)
		if (y119) {
			m059(Local0, Buffer(3){0x21, 0x03, 0x00})
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m05b", Local0)
		SRMT(Local0)
		m05b(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// XOr
		Concatenate(arg0, "-m05c", Local0)
		SRMT(Local0)
		if (y119) {
			m05c(Local0, Buffer(3){0x21, 0x03, 0x00})
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m05e", Local0)
		SRMT(Local0)
		m05e(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
	}


	// Buffer to Integer conversion of each Buffer operand
	// of the 2-parameter Logical Integer operators LAnd and LOr

	// LAnd, common 32-bit/64-bit test
	Method(m05f, 2)
	{
		// Conversion of the first operand

		Store(LAnd(arg1, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd(arg1, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd(arg1, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd(arg1, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, arg1), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 23, Local0, Ones)
		}
	}

	// LAnd, 64-bit
	Method(m060, 3)
	{
		// Conversion of the first operand

		Store(LAnd(arg2, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd(arg2, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd(arg2, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd(arg2, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, arg2), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, arg2), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, arg2), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, arg2), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), arg2), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), arg2), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(LAnd(arg1, arg2), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(LAnd(arg2, arg1), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// LAnd, 32-bit
	Method(m061, 3)
	{
		// Conversion of the first operand

		Store(LAnd(arg2, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd(arg2, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd(arg2, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd(arg2, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd(arg2, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd(arg2, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd(arg2, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd(arg2, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd(arg2, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd(arg2, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(arg2, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd(arg2, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, arg2), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, arg2), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, arg2), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, arg2), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), arg2), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), arg2), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), arg2), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), arg2), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), arg2), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), arg2), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), arg2), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), arg2), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(LAnd(arg1, arg2), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(LAnd(arg2, arg1), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// Lor, common 32-bit/64-bit test
	Method(m062, 2)
	{
		// Conversion of the first operand

		Store(Lor(arg1, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(Lor(arg1, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor(arg1, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(Lor(arg1, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(Lor(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(Lor(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(Lor(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(Lor(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, arg1), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(Lor(1, arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(Lor(aui6, arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(Lor(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(Lor(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(Lor(m601(1, 6), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(Lor(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 23, Local0, Ones)
		}
	}

	// Lor, 64-bit
	Method(m063, 3)
	{
		// Conversion of the first operand

		Store(Lor(arg1, 0), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(Lor(arg1, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor(arg1, aui5), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(Lor(arg1, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(Lor(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(Lor(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(Lor(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(Lor(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, arg1), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(Lor(1, arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, arg1), Local0)
		m600(arg0, 14, Local0, Ones)

		Store(Lor(aui6, arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 16, Local0, Ones)

			Store(Lor(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 18, Local0, Ones)

		Store(Lor(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), arg1), Local0)
		m600(arg0, 20, Local0, Ones)

		Store(Lor(m601(1, 6), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 22, Local0, Ones)

			Store(Lor(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(Lor(arg2, arg1), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(Lor(arg1, arg2), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// Lor, 32-bit
	Method(m064, 3)
	{
		// Conversion of the first operand

		Store(Lor(arg1, 0), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(Lor(arg1, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor(arg1, aui5), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(Lor(arg1, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor(arg1, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(Lor(arg1, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor(arg1, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(Lor(arg1, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor(arg1, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(Lor(arg1, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(arg1, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(Lor(arg1, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, arg1), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(Lor(1, arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, arg1), Local0)
		m600(arg0, 14, Local0, Ones)

		Store(Lor(aui6, arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), arg1), Local0)
			m600(arg0, 16, Local0, Ones)

			Store(Lor(Derefof(Refof(aui6)), arg1), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), arg1), Local0)
		m600(arg0, 18, Local0, Ones)

		Store(Lor(Derefof(Index(paui, 6)), arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), arg1), Local0)
		m600(arg0, 20, Local0, Ones)

		Store(Lor(m601(1, 6), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), arg1), Local0)
			m600(arg0, 22, Local0, Ones)

			Store(Lor(Derefof(m602(1, 6, 1)), arg1), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(Lor(arg2, arg1), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(Lor(arg1, arg2), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	Method(m64o, 1)
	{
		// LAnd
		Concatenate(arg0, "-m05f", Local0)
		SRMT(Local0)
		m05f(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m060", Local0)
		SRMT(Local0)
		m060(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// LOr
		Concatenate(arg0, "-m062", Local0)
		SRMT(Local0)
		m062(Local0, Buffer(1){0x00})
		Concatenate(arg0, "-m063", Local0)
		SRMT(Local0)
		m063(Local0,
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5},
			Buffer(1){0x00})
	}

	Method(m32o, 1)
	{
		// LAnd
		Concatenate(arg0, "-m05f", Local0)
		SRMT(Local0)
		m05f(Local0, Buffer(3){0x21, 0x03, 0x00})
		Concatenate(arg0, "-m061", Local0)
		SRMT(Local0)
		m061(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

		// LOr
		Concatenate(arg0, "-m062", Local0)
		SRMT(Local0)
		m062(Local0, Buffer(1){0x00})
		Concatenate(arg0, "-m064", Local0)
		SRMT(Local0)
		m064(Local0,
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5},
			Buffer(1){0x00})
	}


	// Buffer to Integer conversion of the Buffer second operand of
	// Logical operators when the first operand is evaluated as Integer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)

	Method(m64p, 2)
	{
		// LEqual

		Store(LEqual(0xfe7cb391d650a284, arg1), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0xfe7cb391d650a285, arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0xfe7cb391d650a283, arg1), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(aui4, arg1), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auid, arg1), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auif, arg1), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aui4)), arg1), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auid)), arg1), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auif)), arg1), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 4)), arg1), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 13)), arg1), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 15)), arg1), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 4), arg1), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 13), arg1), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 15), arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 4, 1)), arg1), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m602(1, 13, 1)), arg1), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m602(1, 15, 1)), arg1), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0xfe7cb391d650a284, arg1), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0xfe7cb391d650a285, arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0xfe7cb391d650a283, arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(aui4, arg1), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auid, arg1), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auif, arg1), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(aui4)), arg1), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auid)), arg1), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auif)), arg1), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 4)), arg1), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 13)), arg1), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 15)), arg1), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 4), arg1), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 13), arg1), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 15), arg1), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 4, 1)), arg1), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m602(1, 13, 1)), arg1), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m602(1, 15, 1)), arg1), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0xfe7cb391d650a284, arg1), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0xfe7cb391d650a285, arg1), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0xfe7cb391d650a283, arg1), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(aui4, arg1), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auid, arg1), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auif, arg1), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aui4)), arg1), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auid)), arg1), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auif)), arg1), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 4)), arg1), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 13)), arg1), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 15)), arg1), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 4), arg1), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 13), arg1), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 15), arg1), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 4, 1)), arg1), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 13, 1)), arg1), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 15, 1)), arg1), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0xfe7cb391d650a284, arg1), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0xfe7cb391d650a285, arg1), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0xfe7cb391d650a283, arg1), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(aui4, arg1), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auid, arg1), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auif, arg1), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(aui4)), arg1), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auid)), arg1), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auif)), arg1), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 4)), arg1), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 13)), arg1), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 15)), arg1), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 4), arg1), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 13), arg1), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 15), arg1), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 4, 1)), arg1), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m602(1, 13, 1)), arg1), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m602(1, 15, 1)), arg1), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0xfe7cb391d650a284, arg1), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0xfe7cb391d650a285, arg1), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0xfe7cb391d650a283, arg1), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(aui4, arg1), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auid, arg1), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auif, arg1), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aui4)), arg1), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auid)), arg1), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auif)), arg1), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 4)), arg1), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 13)), arg1), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 15)), arg1), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 4), arg1), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 13), arg1), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 15), arg1), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 4, 1)), arg1), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m602(1, 13, 1)), arg1), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m602(1, 15, 1)), arg1), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0xfe7cb391d650a284, arg1), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0xfe7cb391d650a285, arg1), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0xfe7cb391d650a283, arg1), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(aui4, arg1), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auid, arg1), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auif, arg1), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aui4)), arg1), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auid)), arg1), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auif)), arg1), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 4)), arg1), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 13)), arg1), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 15)), arg1), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 4), arg1), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 13), arg1), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 15), arg1), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 4, 1)), arg1), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m602(1, 13, 1)), arg1), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m602(1, 15, 1)), arg1), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	Method(m32p, 2)
	{
		// LEqual

		Store(LEqual(0xd650a284, arg1), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0xd650a285, arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0xd650a283, arg1), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(auik, arg1), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auil, arg1), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auim, arg1), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(auik)), arg1), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auil)), arg1), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auim)), arg1), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 20)), arg1), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 21)), arg1), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 22)), arg1), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 20), arg1), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 21), arg1), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 22), arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 20, 1)), arg1), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m601(1, 21, 1)), arg1), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m601(1, 22, 1)), arg1), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0xd650a284, arg1), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0xd650a285, arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0xd650a283, arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(auik, arg1), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auil, arg1), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auim, arg1), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(auik)), arg1), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auil)), arg1), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auim)), arg1), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 20)), arg1), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 21)), arg1), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 22)), arg1), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 20), arg1), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 21), arg1), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 22), arg1), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 20, 1)), arg1), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m601(1, 21, 1)), arg1), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m601(1, 22, 1)), arg1), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0xd650a284, arg1), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0xd650a285, arg1), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0xd650a283, arg1), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(auik, arg1), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auil, arg1), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auim, arg1), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(auik)), arg1), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auil)), arg1), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auim)), arg1), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 20)), arg1), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 21)), arg1), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 22)), arg1), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 20), arg1), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 21), arg1), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 22), arg1), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 20, 1)), arg1), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m601(1, 21, 1)), arg1), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m601(1, 22, 1)), arg1), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0xd650a284, arg1), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0xd650a285, arg1), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0xd650a283, arg1), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(auik, arg1), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auil, arg1), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auim, arg1), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(auik)), arg1), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auil)), arg1), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auim)), arg1), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 20)), arg1), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 21)), arg1), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 22)), arg1), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 20), arg1), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 21), arg1), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 22), arg1), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 20, 1)), arg1), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m601(1, 21, 1)), arg1), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m601(1, 22, 1)), arg1), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0xd650a284, arg1), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0xd650a285, arg1), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0xd650a283, arg1), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(auik, arg1), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auil, arg1), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auim, arg1), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(auik)), arg1), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auil)), arg1), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auim)), arg1), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 20)), arg1), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 21)), arg1), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 22)), arg1), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 20), arg1), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 21), arg1), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 22), arg1), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 20, 1)), arg1), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m601(1, 21, 1)), arg1), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m601(1, 22, 1)), arg1), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0xd650a284, arg1), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0xd650a285, arg1), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0xd650a283, arg1), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(auik, arg1), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auil, arg1), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auim, arg1), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(auik)), arg1), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auil)), arg1), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auim)), arg1), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 20)), arg1), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 21)), arg1), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 22)), arg1), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 20), arg1), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 21), arg1), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 22), arg1), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 20, 1)), arg1), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m601(1, 21, 1)), arg1), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m601(1, 22, 1)), arg1), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	Method(m065, 2)
	{
		// LEqual

		Store(LEqual(0x321, arg1), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0x322, arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0x320, arg1), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(aui1, arg1), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auig, arg1), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auih, arg1), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 1), arg1), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 16), arg1), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 17), arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0x321, arg1), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0x322, arg1), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0x320, arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(aui1, arg1), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auig, arg1), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auih, arg1), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 1), arg1), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 16), arg1), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 17), arg1), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0x321, arg1), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0x322, arg1), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0x320, arg1), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(aui1, arg1), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auig, arg1), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auih, arg1), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 1), arg1), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 16), arg1), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 17), arg1), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0x321, arg1), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0x322, arg1), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0x320, arg1), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(aui1, arg1), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auig, arg1), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auih, arg1), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 1), arg1), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 16), arg1), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 17), arg1), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0x321, arg1), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0x322, arg1), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0x320, arg1), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(aui1, arg1), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auig, arg1), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auih, arg1), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 1), arg1), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 16), arg1), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 17), arg1), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0x321, arg1), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0x322, arg1), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0x320, arg1), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(aui1, arg1), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auig, arg1), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auih, arg1), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auig)), arg1), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auih)), arg1), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 16)), arg1), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 17)), arg1), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 1), arg1), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 16), arg1), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 17), arg1), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m602(1, 16, 1)), arg1), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m602(1, 17, 1)), arg1), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	// Buffer to Integer intermediate conversion of the Buffer second
	// operand of Concatenate operator in case the first one is Integer

	Method(m64q, 3)
	{		
		Store(Concatenate(0x321, arg1), Local0)
		m600(arg0, 0, Local0, bb26)

		Store(Concatenate(0x321, arg2), Local0)
		m600(arg0, 1, Local0, bb21)


		Store(Concatenate(aui1, arg1), Local0)
		m600(arg0, 2, Local0, bb26)

		Store(Concatenate(aui1, arg2), Local0)
		m600(arg0, 3, Local0, bb21)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 4, Local0, bb26)

			Store(Concatenate(Derefof(Refof(aui1)), arg2), Local0)
			m600(arg0, 5, Local0, bb21)
		}

		Store(Concatenate(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 6, Local0, bb26)

		Store(Concatenate(Derefof(Index(paui, 1)), arg2), Local0)
		m600(arg0, 7, Local0, bb21)

		// Method returns Integer

		Store(Concatenate(m601(1, 1), arg1), Local0)
		m600(arg0, 8, Local0, bb26)

		Store(Concatenate(m601(1, 1), arg2), Local0)
		m600(arg0, 9, Local0, bb21)

		// Method returns Reference to Integer

		if (y500) {
			Store(Concatenate(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 10, Local0, bb26)

			Store(Concatenate(Derefof(m602(1, 1, 1)), arg2), Local0)
			m600(arg0, 11, Local0, bb21)
		}

		Concatenate(0x321, arg1, Local0)
		m600(arg0, 12, Local0, bb26)

		Concatenate(0x321, arg2, Local0)
		m600(arg0, 13, Local0, bb21)


		Concatenate(aui1, arg1, Local0)
		m600(arg0, 14, Local0, bb26)

		Concatenate(aui1, arg2, Local0)
		m600(arg0, 15, Local0, bb21)

		if (y078) {
			Concatenate(Derefof(Refof(aui1)), arg1, Local0)
			m600(arg0, 16, Local0, bb26)

			Concatenate(Derefof(Refof(aui1)), arg2, Local0)
			m600(arg0, 17, Local0, bb21)
		}

		Concatenate(Derefof(Index(paui, 1)), arg1, Local0)
		m600(arg0, 18, Local0, bb26)

		Concatenate(Derefof(Index(paui, 1)), arg2, Local0)
		m600(arg0, 19, Local0, bb21)

		// Method returns Integer

		Concatenate(m601(1, 1), arg1, Local0)
		m600(arg0, 20, Local0, bb26)

		Concatenate(m601(1, 1), arg2, Local0)
		m600(arg0, 21, Local0, bb21)

		// Method returns Reference to Integer

		if (y500) {
			Concatenate(Derefof(m602(1, 1, 1)), arg1, Local0)
			m600(arg0, 22, Local0, bb26)

			Concatenate(Derefof(m602(1, 1, 1)), arg2, Local0)
			m600(arg0, 23, Local0, bb21)
		}
	}

	Method(m32q, 3)
	{		
		Store(Concatenate(0x321, arg1), Local0)
		m600(arg0, 0, Local0, bb27)

		Store(Concatenate(0x321, arg2), Local0)
		m600(arg0, 1, Local0, bb28)


		Store(Concatenate(aui1, arg1), Local0)
		m600(arg0, 2, Local0, bb27)

		Store(Concatenate(aui1, arg2), Local0)
		m600(arg0, 3, Local0, bb28)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aui1)), arg1), Local0)
			m600(arg0, 4, Local0, bb27)

			Store(Concatenate(Derefof(Refof(aui1)), arg2), Local0)
			m600(arg0, 5, Local0, bb28)
		}

		Store(Concatenate(Derefof(Index(paui, 1)), arg1), Local0)
		m600(arg0, 6, Local0, bb27)

		Store(Concatenate(Derefof(Index(paui, 1)), arg2), Local0)
		m600(arg0, 7, Local0, bb28)

		// Method returns Integer

		Store(Concatenate(m601(1, 1), arg1), Local0)
		m600(arg0, 8, Local0, bb27)

		Store(Concatenate(m601(1, 1), arg2), Local0)
		m600(arg0, 9, Local0, bb28)

		// Method returns Reference to Integer

		if (y500) {
			Store(Concatenate(Derefof(m602(1, 1, 1)), arg1), Local0)
			m600(arg0, 10, Local0, bb27)

			Store(Concatenate(Derefof(m602(1, 1, 1)), arg2), Local0)
			m600(arg0, 11, Local0, bb28)
		}

		Concatenate(0x321, arg1, Local0)
		m600(arg0, 12, Local0, bb27)

		Concatenate(0x321, arg2, Local0)
		m600(arg0, 13, Local0, bb28)


		Concatenate(aui1, arg1, Local0)
		m600(arg0, 14, Local0, bb27)

		Concatenate(aui1, arg2, Local0)
		m600(arg0, 15, Local0, bb28)

		if (y078) {
			Concatenate(Derefof(Refof(aui1)), arg1, Local0)
			m600(arg0, 16, Local0, bb27)

			Concatenate(Derefof(Refof(aui1)), arg2, Local0)
			m600(arg0, 17, Local0, bb28)
		}

		Concatenate(Derefof(Index(paui, 1)), arg1, Local0)
		m600(arg0, 18, Local0, bb27)

		Concatenate(Derefof(Index(paui, 1)), arg2, Local0)
		m600(arg0, 20, Local0, bb28)

		// Method returns Integer

		Concatenate(m601(1, 1), arg1, Local0)
		m600(arg0, 21, Local0, bb27)

		Concatenate(m601(1, 1), arg2, Local0)
		m600(arg0, 22, Local0, bb28)

		// Method returns Reference to Integer

		if (y500) {
			Concatenate(Derefof(m602(1, 1, 1)), arg1, Local0)
			m600(arg0, 23, Local0, bb27)

			Concatenate(Derefof(m602(1, 1, 1)), arg2, Local0)
			m600(arg0, 24, Local0, bb28)
		}
	}

	// Buffer to Integer conversion of the Buffer Length (second)
	// operand of the ToString operator

	// Common 32-bit/64-bit test
	Method(m066, 3)
	{
		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			arg2), Local0)
		m600(arg0, 0, Local0, bs1b)

		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			arg1), Local0)
		m600(arg0, 1, Local0, bs1c)

		Store(ToString(aub6, arg2), Local0)
		m600(arg0, 2, Local0, bs1b)

		Store(ToString(aub6, arg1), Local0)
		m600(arg0, 3, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), arg2), Local0)
			m600(arg0, 4, Local0, bs1b)

			Store(ToString(Derefof(Refof(aub6)), arg1), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), arg2), Local0)
		m600(arg0, 6, Local0, bs1b)

		Store(ToString(Derefof(Index(paub, 6)), arg1), Local0)
		m600(arg0, 7, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), arg2), Local0)
		m600(arg0, 8, Local0, bs1b)

		Store(ToString(m601(3, 6), arg1), Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), arg2), Local0)
			m600(arg0, 10, Local0, bs1b)

			Store(ToString(Derefof(m602(3, 6, 1)), arg1), Local0)
			m600(arg0, 11, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			arg2, Local0)
		m600(arg0, 12, Local0, bs1b)

		ToString(Buffer() {"This is auxiliary Buffer"},
			arg1, Local0)
		m600(arg0, 13, Local0, bs1c)

		ToString(aub6, arg2, Local0)
		m600(arg0, 14, Local0, bs1b)

		ToString(aub6, arg1, Local0)
		m600(arg0, 15, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), arg2, Local0)
			m600(arg0, 16, Local0, bs1b)

			ToString(Derefof(Refof(aub6)), arg1, Local0)
			m600(arg0, 17, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), arg2, Local0)
		m600(arg0, 18, Local0, bs1b)

		ToString(Derefof(Index(paub, 6)), arg1, Local0)
		m600(arg0, 19, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), arg2, Local0)
		m600(arg0, 20, Local0, bs1b)

		ToString(m601(3, 6), arg1, Local0)
		m600(arg0, 21, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), arg2, Local0)
			m600(arg0, 22, Local0, bs1b)

			ToString(Derefof(m602(3, 6, 1)), arg1, Local0)
			m600(arg0, 23, Local0, bs1c)
		}
	}

	Method(m64r, 2)
	{
		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			arg1), Local0)
		m600(arg0, 0, Local0, bs1c)

		Store(ToString(aub6, arg1), Local0)
		m600(arg0, 1, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), arg1), Local0)
			m600(arg0, 2, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), arg1), Local0)
		m600(arg0, 3, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), arg1), Local0)
		m600(arg0, 4, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), arg1), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			arg1, Local0)
		m600(arg0, 6, Local0, bs1c)

		ToString(aub6, arg1, Local0)
		m600(arg0, 7, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), arg1, Local0)
			m600(arg0, 8, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), arg1, Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), arg1, Local0)
		m600(arg0, 10, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), arg1, Local0)
			m600(arg0, 11, Local0, bs1c)
		}
	}

	Method(m32r, 2)
	{
		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			arg1), Local0)
		m600(arg0, 0, Local0, bs1c)

		Store(ToString(aub6, arg1), Local0)
		m600(arg0, 1, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), arg1), Local0)
			m600(arg0, 2, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), arg1), Local0)
		m600(arg0, 3, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), arg1), Local0)
		m600(arg0, 4, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), arg1), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			arg1, Local0)
		m600(arg0, 6, Local0, bs1c)

		ToString(aub6, arg1, Local0)
		m600(arg0, 7, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), arg1, Local0)
			m600(arg0, 8, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), arg1, Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), arg1, Local0)
		m600(arg0, 10, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), arg1, Local0)
			m600(arg0, 11, Local0, bs1c)
		}
	}

	// Buffer to Integer conversion of the Buffer Index (second)
	// operand of the Index operator
	Method(m067, 2)
	{
		Store(Index(aus6, arg1), Local0)
		m600(arg0, 0, Derefof(Local0), bi10)

		Store(Index(aub6, arg1), Local0)
		m600(arg0, 1, Derefof(Local0), bi10)

		Store(Index(aup0, arg1), Local0)
		m600(arg0, 2, Derefof(Local0), bi11)

		if (y078) {
			Store(Index(Derefof(Refof(aus6)), arg1), Local0)
			m600(arg0, 3, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aub6)), arg1), Local0)
			m600(arg0, 4, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aup0)), arg1), Local0)
			m600(arg0, 5, Derefof(Local0), bi11)
		}

		Store(Index(Derefof(Index(paus, 6)), arg1), Local0)
		m600(arg0, 6, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paub, 6)), arg1), Local0)
		m600(arg0, 7, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paup, 0)), arg1), Local0)
		m600(arg0, 8, Derefof(Local0), bi11)


		// Method returns Object

		if (y900) {
			Store(Index(m601(2, 6), arg1), Local0)
			m600(arg0, 9, Derefof(Local0), bi10)

			Store(Index(m601(3, 6), arg1), Local0)
			m600(arg0, 10, Derefof(Local0), bi10)

			Store(Index(m601(4, 0), arg1), Local0)
			m600(arg0, 11, Derefof(Local0), bi11)
		}

		// Method returns Reference

		if (y500) {
			Store(Index(Derefof(m602(2, 6, 1)), arg1), Local0)
			m600(arg0, 12, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(3, 6, 1)), arg1), Local0)
			m600(arg0, 13, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(4, 0, 1)), arg1), Local0)
			m600(arg0, 14, Derefof(Local0), bi11)
		}

		Index(aus6, arg1, Local0)
		m600(arg0, 15, Derefof(Local0), bi10)

		Index(aub6, arg1, Local0)
		m600(arg0, 16, Derefof(Local0), bi10)

		Index(aup0, arg1, Local0)
		m600(arg0, 17, Derefof(Local0), bi11)

		if (y078) {
			Index(Derefof(Refof(aus6)), arg1, Local0)
			m600(arg0, 18, Derefof(Local0), bi10)

			Index(Derefof(Refof(aub6)), arg1, Local0)
			m600(arg0, 19, Derefof(Local0), bi10)

			Index(Derefof(Refof(aup0)), arg1, Local0)
			m600(arg0, 20, Derefof(Local0), bi11)
		}

		Index(Derefof(Index(paus, 6)), arg1, Local0)
		m600(arg0, 21, Derefof(Local0), bi10)

		Index(Derefof(Index(paub, 6)), arg1, Local0)
		m600(arg0, 22, Derefof(Local0), bi10)

		Index(Derefof(Index(paup, 0)), arg1, Local0)
		m600(arg0, 23, Derefof(Local0), bi11)


		// Method returns Object

		if (y900) {
			Index(m601(2, 6), arg1, Local0)
			m600(arg0, 24, Derefof(Local0), bi10)

			Index(m601(3, 6), arg1, Local0)
			m600(arg0, 25, Derefof(Local0), bi10)

			Index(m601(4, 0), arg1, Local0)
			m600(arg0, 26, Derefof(Local0), bi11)
		}

		// Method returns Reference

		if (y500) {
			Index(Derefof(m602(2, 6, 1)), arg1, Local0)
			m600(arg0, 27, Derefof(Local0), bi10)

			Index(Derefof(m602(3, 6, 1)), arg1, Local0)
			m600(arg0, 28, Derefof(Local0), bi10)

			Index(Derefof(m602(4, 0, 1)), arg1, Local0)
			m600(arg0, 29, Derefof(Local0), bi11)
		}

		if (y098) {
			Store(Index(aus6, arg1, Local1), Local0)
			m600(arg0, 30, Derefof(Local0), bi10)

			Store(Index(aub6, arg1, Local1), Local0)
			m600(arg0, 31, Derefof(Local0), bi10)

			Store(Index(aup0, arg1, Local1), Local0)
			m600(arg0, 32, Derefof(Local0), bi11)
		}

		if (y078) {
			Store(Index(Derefof(Refof(aus6)), arg1, Local1), Local0)
			m600(arg0, 33, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aub6)), arg1, Local1), Local0)
			m600(arg0, 34, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aup0)), arg1, Local1), Local0)
			m600(arg0, 35, Derefof(Local0), bi11)
		}

		if (y098) {
		Store(Index(Derefof(Index(paus, 6)), arg1, Local1), Local0)
		m600(arg0, 36, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paub, 6)), arg1, Local1), Local0)
		m600(arg0, 37, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paup, 0)), arg1, Local1), Local0)
		m600(arg0, 38, Derefof(Local0), bi11)
		}

		// Method returns Object

		if (LAnd(y900, y098)) {
			Store(Index(m601(2, 6), arg1, Local1), Local0)
			m600(arg0, 39, Derefof(Local0), bi10)

			Store(Index(m601(3, 6), arg1, Local1), Local0)
			m600(arg0, 40, Derefof(Local0), bi10)

			Store(Index(m601(4, 0), arg1, Local1), Local0)
			m600(arg0, 41, Derefof(Local0), bi11)
		}

		// Method returns Reference

		if (y500) {
			Store(Index(Derefof(m602(2, 6, 1)), arg1, Local1), Local0)
			m600(arg0, 42, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(3, 6, 1)), arg1, Local1), Local0)
			m600(arg0, 43, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(4, 0, 1)), arg1, Local1), Local0)
			m600(arg0, 44, Derefof(Local0), bi11)
		}
	}

	// Buffer to Integer conversion of the String Arg (third)
	// operand of the Fatal operator
	// (it can only be checked an exception does not occur)
	Method(m068, 3)
	{
		CH03(arg0, z121, 9, 0, 0)
		Fatal(0xff, 0xffffffff, arg1)
		if (F64) {
			Fatal(0xff, 0xffffffff, arg2)
		} else {
			Fatal(0xff, 0xffffffff, arg2)
		}
		CH03(arg0, z121, 10, 0, 0)
	}

	// Buffer to Integer conversion of the Buffer Index and Length
	// operands of the Mid operator

	// Common 32-bit/64-bit test
	Method(m069, 2)
	{
		// String to Integer conversion of the String Index operand

		Store(Mid("This is auxiliary String", arg1, 10), Local0)
		m600(arg0, 0, Local0, bs1d)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, arg1, 10), Local0)
		m600(arg0, 1, Local0, bb32)

		Store(Mid(aus6, arg1, 10), Local0)
		m600(arg0, 2, Local0, bs1d)

		Store(Mid(aub6, arg1, 10), Local0)
		m600(arg0, 3, Local0, bb32)


		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), arg1, 10), Local0)
			m600(arg0, 4, Local0, bs1d)

			Store(Mid(Derefof(Refof(aub6)), arg1, 10), Local0)
			m600(arg0, 5, Local0, bb32)
		}

		Store(Mid(Derefof(Index(paus, 6)), arg1, 10), Local0)
		m600(arg0, 6, Local0, bs1d)

		Store(Mid(Derefof(Index(paub, 6)), arg1, 10), Local0)
		m600(arg0, 7, Local0, bb32)

		// Method returns Object

		Store(Mid(m601(2, 6), arg1, 10), Local0)
		m600(arg0, 8, Local0, bs1d)

		Store(Mid(m601(3, 6), arg1, 10), Local0)
		m600(arg0, 9, Local0, bb32)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), arg1, 10), Local0)
			m600(arg0, 10, Local0, bs1d)

			Store(Mid(Derefof(m602(3, 6, 1)), arg1, 10), Local0)
			m600(arg0, 11, Local0, bb32)
		}

		Mid("This is auxiliary String", arg1, 10, Local0)
		m600(arg0, 12, Local0, bs1d)

		Mid(Buffer(){"This is auxiliary Buffer"}, arg1, 10, Local0)
		m600(arg0, 13, Local0, bb32)

		Mid(aus6, arg1, 10, Local0)
		m600(arg0, 14, Local0, bs1d)

		Mid(aub6, arg1, 10, Local0)
		m600(arg0, 15, Local0, bb32)


		if (y078) {
			Mid(Derefof(Refof(aus6)), arg1, 10, Local0)
			m600(arg0, 16, Local0, bs1d)

			Mid(Derefof(Refof(aub6)), arg1, 10, Local0)
			m600(arg0, 17, Local0, bb32)
		}

		Mid(Derefof(Index(paus, 6)), arg1, 10, Local0)
		m600(arg0, 18, Local0, bs1d)

		Mid(Derefof(Index(paub, 6)), arg1, 10, Local0)
		m600(arg0, 19, Local0, bb32)

		// Method returns Object

		Mid(m601(2, 6), arg1, 10, Local0)
		m600(arg0, 20, Local0, bs1d)

		Mid(m601(3, 6), arg1, 10, Local0)
		m600(arg0, 21, Local0, bb32)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), arg1, 10, Local0)
			m600(arg0, 22, Local0, bs1d)

			Mid(Derefof(m602(3, 6, 1)), arg1, 10, Local0)
			m600(arg0, 23, Local0, bb32)
		}

		// String to Integer conversion of the String Length operand

		Store(Mid("This is auxiliary String", 0, arg1), Local0)
		m600(arg0, 24, Local0, bs1b)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, arg1), Local0)
		m600(arg0, 25, Local0, bb33)

		Store(Mid(aus6, 0, arg1), Local0)
		m600(arg0, 26, Local0, bs1b)

		Store(Mid(aub6, 0, arg1), Local0)
		m600(arg0, 27, Local0, bb33)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, arg1), Local0)
			m600(arg0, 28, Local0, bs1b)

			Store(Mid(Derefof(Refof(aub6)), 0, arg1), Local0)
			m600(arg0, 29, Local0, bb33)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, arg1), Local0)
		m600(arg0, 30, Local0, bs1b)

		Store(Mid(Derefof(Index(paub, 6)), 0, arg1), Local0)
		m600(arg0, 31, Local0, bb33)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, arg1), Local0)
		m600(arg0, 32, Local0, bs1b)

		Store(Mid(m601(3, 6), 0, arg1), Local0)
		m600(arg0, 33, Local0, bb33)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, arg1), Local0)
			m600(arg0, 34, Local0, bs1b)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, arg1), Local0)
			m600(arg0, 35, Local0, bb33)
		}

		Mid("This is auxiliary String", 0, arg1, Local0)
		m600(arg0, 36, Local0, bs1b)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, arg1, Local0)
		m600(arg0, 37, Local0, bb33)

		Mid(aus6, 0, arg1, Local0)
		m600(arg0, 37, Local0, bs1b)

		Mid(aub6, 0, arg1, Local0)
		m600(arg0, 39, Local0, bb33)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, arg1, Local0)
			m600(arg0, 40, Local0, bs1b)

			Mid(Derefof(Refof(aub6)), 0, arg1, Local0)
			m600(arg0, 41, Local0, bb33)
		}

		Mid(Derefof(Index(paus, 6)), 0, arg1, Local0)
		m600(arg0, 42, Local0, bs1b)

		Mid(Derefof(Index(paub, 6)), 0, arg1, Local0)
		m600(arg0, 43, Local0, bb33)

		// Method returns Object

		Mid(m601(2, 6), 0, arg1, Local0)
		m600(arg0, 44, Local0, bs1b)

		Mid(m601(3, 6), 0, arg1, Local0)
		m600(arg0, 45, Local0, bb33)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, arg1, Local0)
			m600(arg0, 46, Local0, bs1b)

			Mid(Derefof(m602(3, 6, 1)), 0, arg1, Local0)
			m600(arg0, 47, Local0, bb33)
		}
	}

	Method(m64s, 3)
	{
		// String to Integer conversion of the String Length operand

		Store(Mid("This is auxiliary String", 0, arg1), Local0)
		m600(arg0, 0, Local0, bs1e)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, arg1), Local0)
		m600(arg0, 1, Local0, bb34)

		Store(Mid(aus6, 0, arg1), Local0)
		m600(arg0, 2, Local0, bs1e)

		Store(Mid(aub6, 0, arg1), Local0)
		m600(arg0, 3, Local0, bb34)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, arg1), Local0)
			m600(arg0, 4, Local0, bs1e)

			Store(Mid(Derefof(Refof(aub6)), 0, arg1), Local0)
			m600(arg0, 5, Local0, bb34)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, arg1), Local0)
		m600(arg0, 6, Local0, bs1e)

		Store(Mid(Derefof(Index(paub, 6)), 0, arg1), Local0)
		m600(arg0, 7, Local0, bb34)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, arg1), Local0)
		m600(arg0, 8, Local0, bs1e)

		Store(Mid(m601(3, 6), 0, arg1), Local0)
		m600(arg0, 9, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, arg1), Local0)
			m600(arg0, 10, Local0, bs1e)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, arg1), Local0)
			m600(arg0, 11, Local0, bb34)
		}

		Mid("This is auxiliary String", 0, arg1, Local0)
		m600(arg0, 12, Local0, bs1e)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, arg1, Local0)
		m600(arg0, 13, Local0, bb34)

		Mid(aus6, 0, arg1, Local0)
		m600(arg0, 14, Local0, bs1e)

		Mid(aub6, 0, arg1, Local0)
		m600(arg0, 15, Local0, bb34)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, arg1, Local0)
			m600(arg0, 16, Local0, bs1e)

			Mid(Derefof(Refof(aub6)), 0, arg1, Local0)
			m600(arg0, 17, Local0, bb34)
		}

		Mid(Derefof(Index(paus, 6)), 0, arg1, Local0)
		m600(arg0, 18, Local0, bs1e)

		Mid(Derefof(Index(paub, 6)), 0, arg1, Local0)
		m600(arg0, 19, Local0, bb34)

		// Method returns Object

		Mid(m601(2, 6), 0, arg1, Local0)
		m600(arg0, 20, Local0, bs1e)

		Mid(m601(3, 6), 0, arg1, Local0)
		m600(arg0, 21, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, arg1, Local0)
			m600(arg0, 22, Local0, bs1e)

			Mid(Derefof(m602(3, 6, 1)), 0, arg1, Local0)
			m600(arg0, 23, Local0, bb34)
		}

		// String to Integer conversion of the both String operands

		Store(Mid("This is auxiliary String", arg2, arg1), Local0)
		m600(arg0, 24, Local0, bs1f)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, arg2, arg1), Local0)
		m600(arg0, 25, Local0, bb35)

		Store(Mid(aus6, arg2, arg1), Local0)
		m600(arg0, 26, Local0, bs1f)

		Store(Mid(aub6, arg2, arg1), Local0)
		m600(arg0, 27, Local0, bb35)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), arg2, arg1), Local0)
			m600(arg0, 28, Local0, bs1f)

			Store(Mid(Derefof(Refof(aub6)), arg2, arg1), Local0)
			m600(arg0, 29, Local0, bb35)
		}

		Store(Mid(Derefof(Index(paus, 6)), arg2, arg1), Local0)
		m600(arg0, 30, Local0, bs1f)

		Store(Mid(Derefof(Index(paub, 6)), arg2, arg1), Local0)
		m600(arg0, 31, Local0, bb35)

		// Method returns Object

		Store(Mid(m601(2, 6), arg2, arg1), Local0)
		m600(arg0, 32, Local0, bs1f)

		Store(Mid(m601(3, 6), arg2, arg1), Local0)
		m600(arg0, 33, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), arg2, arg1), Local0)
			m600(arg0, 34, Local0, bs1f)

			Store(Mid(Derefof(m602(3, 6, 1)), arg2, arg1), Local0)
			m600(arg0, 35, Local0, bb35)
		}

		Mid("This is auxiliary String", arg2, arg1, Local0)
		m600(arg0, 36, Local0, bs1f)

		Mid(Buffer(){"This is auxiliary Buffer"}, arg2, arg1, Local0)
		m600(arg0, 37, Local0, bb35)

		Mid(aus6, arg2, arg1, Local0)
		m600(arg0, 38, Local0, bs1f)

		Mid(aub6, arg2, arg1, Local0)
		m600(arg0, 39, Local0, bb35)


		if (y078) {
			Mid(Derefof(Refof(aus6)), arg2, arg1, Local0)
			m600(arg0, 40, Local0, bs1f)

			Mid(Derefof(Refof(aub6)), arg2, arg1, Local0)
			m600(arg0, 41, Local0, bb35)
		}

		Mid(Derefof(Index(paus, 6)), arg2, arg1, Local0)
		m600(arg0, 42, Local0, bs1f)

		Mid(Derefof(Index(paub, 6)), arg2, arg1, Local0)
		m600(arg0, 43, Local0, bb35)

		// Method returns Object

		Mid(m601(2, 6), arg2, arg1, Local0)
		m600(arg0, 44, Local0, bs1f)

		Mid(m601(3, 6), arg2, arg1, Local0)
		m600(arg0, 45, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), arg2, arg1, Local0)
			m600(arg0, 46, Local0, bs1f)

			Mid(Derefof(m602(3, 6, 1)), arg2, arg1, Local0)
			m600(arg0, 47, Local0, bb35)
		}
	}

	Method(m32s, 3)
	{
		// String to Integer conversion of the String Length operand

		Store(Mid("This is auxiliary String", 0, arg1), Local0)
		m600(arg0, 0, Local0, bs1e)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, arg1), Local0)
		m600(arg0, 1, Local0, bb34)

		Store(Mid(aus6, 0, arg1), Local0)
		m600(arg0, 2, Local0, bs1e)

		Store(Mid(aub6, 0, arg1), Local0)
		m600(arg0, 3, Local0, bb34)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, arg1), Local0)
			m600(arg0, 4, Local0, bs1e)

			Store(Mid(Derefof(Refof(aub6)), 0, arg1), Local0)
			m600(arg0, 5, Local0, bb34)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, arg1), Local0)
		m600(arg0, 6, Local0, bs1e)

		Store(Mid(Derefof(Index(paub, 6)), 0, arg1), Local0)
		m600(arg0, 7, Local0, bb34)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, arg1), Local0)
		m600(arg0, 8, Local0, bs1e)

		Store(Mid(m601(3, 6), 0, arg1), Local0)
		m600(arg0, 9, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, arg1), Local0)
			m600(arg0, 10, Local0, bs1e)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, arg1), Local0)
			m600(arg0, 11, Local0, bb34)
		}

		Mid("This is auxiliary String", 0, arg1, Local0)
		m600(arg0, 12, Local0, bs1e)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, arg1, Local0)
		m600(arg0, 13, Local0, bb34)

		Mid(aus6, 0, arg1, Local0)
		m600(arg0, 14, Local0, bs1e)

		Mid(aub6, 0, arg1, Local0)
		m600(arg0, 15, Local0, bb34)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, arg1, Local0)
			m600(arg0, 16, Local0, bs1e)

			Mid(Derefof(Refof(aub6)), 0, arg1, Local0)
			m600(arg0, 17, Local0, bb34)
		}

		Mid(Derefof(Index(paus, 6)), 0, arg1, Local0)
		m600(arg0, 18, Local0, bs1e)

		Mid(Derefof(Index(paub, 6)), 0, arg1, Local0)
		m600(arg0, 19, Local0, bb34)

		// Method returns Object

		Mid(m601(2, 6), 0, arg1, Local0)
		m600(arg0, 20, Local0, bs1e)

		Mid(m601(3, 6), 0, arg1, Local0)
		m600(arg0, 21, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, arg1, Local0)
			m600(arg0, 22, Local0, bs1e)

			Mid(Derefof(m602(3, 6, 1)), 0, arg1, Local0)
			m600(arg0, 23, Local0, bb34)
		}

		// String to Integer conversion of the both String operands

		Store(Mid("This is auxiliary String", arg2, arg1), Local0)
		m600(arg0, 24, Local0, bs1f)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, arg2, arg1), Local0)
		m600(arg0, 25, Local0, bb35)

		Store(Mid(aus6, arg2, arg1), Local0)
		m600(arg0, 26, Local0, bs1f)

		Store(Mid(aub6, arg2, arg1), Local0)
		m600(arg0, 27, Local0, bb35)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), arg2, arg1), Local0)
			m600(arg0, 28, Local0, bs1f)

			Store(Mid(Derefof(Refof(aub6)), arg2, arg1), Local0)
			m600(arg0, 29, Local0, bb35)
		}

		Store(Mid(Derefof(Index(paus, 6)), arg2, arg1), Local0)
		m600(arg0, 30, Local0, bs1f)

		Store(Mid(Derefof(Index(paub, 6)), arg2, arg1), Local0)
		m600(arg0, 31, Local0, bb35)

		// Method returns Object

		Store(Mid(m601(2, 6), arg2, arg1), Local0)
		m600(arg0, 32, Local0, bs1f)

		Store(Mid(m601(3, 6), arg2, arg1), Local0)
		m600(arg0, 33, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), arg2, arg1), Local0)
			m600(arg0, 34, Local0, bs1f)

			Store(Mid(Derefof(m602(3, 6, 1)), arg2, arg1), Local0)
			m600(arg0, 35, Local0, bb35)
		}

		Mid("This is auxiliary String", arg2, arg1, Local0)
		m600(arg0, 36, Local0, bs1f)

		Mid(Buffer(){"This is auxiliary Buffer"}, arg2, arg1, Local0)
		m600(arg0, 37, Local0, bb35)

		Mid(aus6, arg2, arg1, Local0)
		m600(arg0, 38, Local0, bs1f)

		Mid(aub6, arg2, arg1, Local0)
		m600(arg0, 39, Local0, bb35)


		if (y078) {
			Mid(Derefof(Refof(aus6)), arg2, arg1, Local0)
			m600(arg0, 40, Local0, bs1f)

			Mid(Derefof(Refof(aub6)), arg2, arg1, Local0)
			m600(arg0, 41, Local0, bb35)
		}

		Mid(Derefof(Index(paus, 6)), arg2, arg1, Local0)
		m600(arg0, 42, Local0, bs1f)

		Mid(Derefof(Index(paub, 6)), arg2, arg1, Local0)
		m600(arg0, 43, Local0, bb35)

		// Method returns Object

		Mid(m601(2, 6), arg2, arg1, Local0)
		m600(arg0, 44, Local0, bs1f)

		Mid(m601(3, 6), arg2, arg1, Local0)
		m600(arg0, 45, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), arg2, arg1, Local0)
			m600(arg0, 46, Local0, bs1f)

			Mid(Derefof(m602(3, 6, 1)), arg2, arg1, Local0)
			m600(arg0, 47, Local0, bb35)
		}
	}

	// Buffer to Integer conversion of the Buffer StartIndex
	// operand of the Match operator
	Method(m06a, 2)
	{
		Store(Match(
			Package(){
				0xa50, 0xa51, 0xa52, 0xa53, 0xa54, 0xa55, 0xa56, 0xa57,
				0xa58, 0xa59, 0xa5a, 0xa5b, 0xa5c, 0xa5d, 0xa5e,},
			MEQ, 0xa5d, MTR, 0, arg1), Local0)
		m600(arg0, 0, Local0, 0xd)

		Store(Match(
			Package(){
				0xa50, 0xa51, 0xa52, 0xa53, 0xa54, 0xa55, 0xa56, 0xa57,
				0xa58, 0xa59, 0xa5a, 0xa5b, 0xa5c, 0xa5d, 0xa5e,},
			MEQ, 0xa5a, MTR, 0, arg1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(aup0, MEQ, 0xa5d, MTR, 0, arg1), Local0)
		m600(arg0, 2, Local0, 0xd)

		Store(Match(aup0, MEQ, 0xa5a, MTR, 0, arg1), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Match(Derefof(Refof(aup0)), MEQ, 0xa5d, MTR, 0, arg1), Local0)
			m600(arg0, 4, Local0, 0xd)

			Store(Match(Derefof(Refof(aup0)), MEQ, 0xa5a, MTR, 0, arg1), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Match(Derefof(Index(paup, 0)), MEQ, 0xa5d, MTR, 0, arg1), Local0)
		m600(arg0, 6, Local0, 0xd)

		Store(Match(Derefof(Index(paup, 0)), MEQ, 0xa5a, MTR, 0, arg1), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Object

		Store(Match(m601(4, 0), MEQ, 0xa5d, MTR, 0, arg1), Local0)
		m600(arg0, 8, Local0, 0xd)

		Store(Match(m601(4, 0), MEQ, 0xa5a, MTR, 0, arg1), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference

		if (y500) {
			Store(Match(Derefof(m602(4, 0, 1)), MEQ, 0xa5d, MTR, 0, arg1), Local0)
			m600(arg0, 10, Local0, 0xd)

			Store(Match(Derefof(m602(4, 0, 1)), MEQ, 0xa5a, MTR, 0, arg1), Local0)
			m600(arg0, 11, Local0, Ones)
		}
	}

//	Method(m64t, 1)

//	Method(m32t, 1)

	// Buffer to Integer conversion of the Buffer sole operand
	// of the Method execution control operators (Sleep, Stall)
	Method(m06b, 3)
	{
		CH03(arg0, z121, 11, 0, 0)

		// Sleep

		Store(Timer, Local0)

		Sleep(arg1)
		CH03(arg0, z121, 12, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z121, 0, 0, 0, Local2, c08c)
		}

		// Stall

		Store(Timer, Local0)

		Stall(arg2)
		CH03(arg0, z121, 13, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, 990)) {
			err(arg0, z121, 1, 0, 0, Local2, 990)
		}
	}

	// Buffer to Integer conversion of the Buffer TimeoutValue
	// (second) operand of the Acquire operator

	Method(m06c, 2, Serialized)
	{
		Mutex(MTX0, 0)

		Acquire(MTX0, 0)
		CH03(arg0, z121, 14, 0, 0)

		Store(Timer, Local0)

/* Compiler allows only Integer constant as TimeoutValue (Bug 1)
		Acquire(MTX0, arg1)
*/
		CH03(arg0, z121, 15, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z121, 0, 0, 0, Local2, c08c)
		}
	}

	// Buffer to Integer conversion of the Buffer TimeoutValue
	// (second) operand of the Wait operator
	Method(m06d, 2, Serialized)
	{
		Event(EVT0)

		CH03(arg0, z121, 16, 0, 0)

		Store(Timer, Local0)

		Wait(EVT0, arg1)
		CH03(arg0, z121, 17, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z121, 0, 0, 0, Local2, c08c)
		}
	}

	// Buffer to Integer conversion of the Buffer value
	// of Predicate of the Method execution control statements
	// (If, ElseIf, While)
	Method(m06e, 4, Serialized)
	{
		Name(ist0, 0)

		Method(m001, 1)
		{
			if (arg0) {
				Store(0, ist0)
			}
		}

		Method(m002, 1)
		{
			if (arg0) {
				Store(2, ist0)
			}
		}

		Method(m003, 1)
		{
			if (arg0) {
				Store(3, ist0)
			}
		}

		Method(m004, 1)
		{
			if (arg0) {
				Store(4, ist0)
			}
		}

		Method(m005, 2)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (arg1) {
				Store(0, ist0)
			}
		}

		Method(m006, 2)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (arg1) {
				Store(6, ist0)
			}
		}

		Method(m007, 2)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (arg1) {
				Store(7, ist0)
			}
		}

		Method(m008, 2)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (arg1) {
				Store(8, ist0)
			}
		}

		Method(m009, 1)
		{
			while (arg0) {
				Store(0, ist0)
				Break
			}
		}

		// If

		Store(1, ist0)
		m001(arg3)
		m600(arg0, 0, ist0, 1)

		m002(arg1)
		m600(arg0, 1, ist0, 2)

		m003(arg2)
		m600(arg0, 2, ist0, 3)

		m004(arg2)
		m600(arg0, 3, ist0, 4)

		// ElseIf

		Store(5, ist0)
		m005(0, arg3)
		m600(arg0, 4, ist0, 5)

		m006(0, arg1)
		m600(arg0, 5, ist0, 6)

		m007(0, arg2)
		m600(arg0, 6, ist0, 7)

		m008(0, arg2)
		m600(arg0, 7, ist0, 8)

		// While

		Store(9, ist0)
		m009(arg3)
		m600(arg0, 8, ist0, 9)
	}

//	Method(m64u, 1)

//	Method(m32u, 1)

	// Buffer to String implicit conversion Cases.

	// Buffer to String conversion of the Buffer second operand of
	// Logical operators when the first operand is evaluated as String.
	// LEqual LGreater LGreaterEqual LLess LLessEqual LNotEqual
	Method(m06f, 3)
	{
		// LEqual

		Store(LEqual("21 03 00", arg1), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual("21 03 01", arg1), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aus9, arg1), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(ausa, arg1), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aus9)), arg1), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(ausa)), arg1), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paus, 9)), arg1), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paus, 10)), arg1), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns String

		Store(LEqual(m601(2, 9), arg1), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(2, 10), arg1), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LEqual(Derefof(m602(2, 9, 1)), arg1), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(2, 10, 1)), arg1), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater("21 03 00", arg1), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater("21 03 01", arg1), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater("21 03 0 ", arg1), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater("21 03 00q", arg1), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aus9, arg1), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(ausa, arg1), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aus9)), arg1), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(ausa)), arg1), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paus, 9)), arg1), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paus, 10)), arg1), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns String

		Store(LGreater(m601(2, 9), arg1), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(2, 10), arg1), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LGreater(Derefof(m602(2, 9, 1)), arg1), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(2, 10, 1)), arg1), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual("21 03 00", arg1), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual("21 03 01", arg1), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual("21 03 0 ", arg1), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual("21 03 00q", arg1), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aus9, arg1), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(ausa, arg1), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aus9)), arg1), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(ausa)), arg1), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paus, 9)), arg1), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paus, 10)), arg1), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns String

		Store(LGreaterEqual(m601(2, 9),
		 arg1), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(2, 10), arg1), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(2, 9, 1)), arg1), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(2, 10, 1)), arg1), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess("21 03 00", arg1), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess("21 03 01", arg1), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess("21 03 0 ", arg1), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess("21 03 00q", arg1), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aus9, arg1), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(ausa, arg1), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aus9)), arg1), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(ausa)), arg1), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paus, 9)), arg1), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paus, 10)), arg1), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns String

		Store(LLess(m601(2, 9), arg1), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(2, 10), arg1), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LLess(Derefof(m602(2, 9, 1)), arg1), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(2, 10, 1)), arg1), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual("21 03 00", arg1), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual("21 03 01", arg1), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual("21 03 0 ", arg1), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual("21 03 00q", arg1), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aus9, arg1), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(ausa, arg1), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aus9)), arg1), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(ausa)), arg1), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paus, 9)), arg1), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paus, 10)), arg1), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns String

		Store(LLessEqual(m601(2, 9), arg1), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(2, 10), arg1), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LLessEqual(Derefof(m602(2, 9, 1)), arg1), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(2, 10, 1)), arg1), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual("21 03 00", arg1), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual("21 03 01", arg1), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual("21 03 0 ", arg1), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual("21 03 00q", arg1), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aus9, arg1), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(ausa, arg1), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aus9)), arg1), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(ausa)), arg1), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paus, 9)), arg1), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paus, 10)), arg1), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns String

		Store(LNotEqual(m601(2, 9), arg1), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(2, 10), arg1), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LNotEqual(Derefof(m602(2, 9, 1)), arg1), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(2, 10, 1)), arg1), Local0)
			m600(arg0, 81, Local0, Ones)
		}

		// Boundary Cases

		Store(LEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
				arg2),
			Local0)
		m600(arg0, 82, Local0, Ones)

		Store(LEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
				arg2),
			Local0)
		m600(arg0, 83, Local0, Zero)

		Store(LGreater("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
				arg2),
			Local0)
		m600(arg0, 84, Local0, Zero)

		Store(LGreater("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
				arg2),
			Local0)
		m600(arg0, 85, Local0, Ones)

		Store(LGreaterEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
				arg2),
			Local0)
		m600(arg0, 86, Local0, Ones)

		Store(LGreaterEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
				arg2),
			Local0)
		m600(arg0, 87, Local0, Ones)

		Store(LLess("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
				arg2),
			Local0)
		m600(arg0, 88, Local0, Zero)

		Store(LLess("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
				arg2),
			Local0)
		m600(arg0, 89, Local0, Zero)

		Store(LLessEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
				arg2),
			Local0)
		m600(arg0, 90, Local0, Ones)

		Store(LLessEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
				arg2),
			Local0)
		m600(arg0, 91, Local0, Zero)


		Store(LNotEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
				arg2),
			Local0)
		m600(arg0, 92, Local0, Zero)

		Store(LNotEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
				arg2),
			Local0)
		m600(arg0, 93, Local0, Ones)
	}

	// Buffer to String conversion of the Buffer second operand of
	// Concatenate operator when the first operand is evaluated as String
	Method(m070, 3)
	{		
		Store(Concatenate("", arg1), Local0)
		m600(arg0, 0, Local0, bs25)

		Store(Concatenate("1234q", arg1), Local0)
		m600(arg0, 1, Local0, bs26)

		Store(Concatenate(aus0, arg1), Local0)
		m600(arg0, 2, Local0, bs25)

		Store(Concatenate(aus1, arg1), Local0)
		m600(arg0, 3, Local0, bs26)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aus0)), arg1), Local0)
			m600(arg0, 4, Local0, bs25)

			Store(Concatenate(Derefof(Refof(aus1)), arg1), Local0)
			m600(arg0, 5, Local0, bs26)
		}

		Store(Concatenate(Derefof(Index(paus, 0)), arg1), Local0)
		m600(arg0, 6, Local0, bs25)

		Store(Concatenate(Derefof(Index(paus, 1)), arg1), Local0)
		m600(arg0, 7, Local0, bs26)

		// Method returns String

		Store(Concatenate(m601(2, 0), arg1), Local0)
		m600(arg0, 8, Local0, bs25)

		Store(Concatenate(m601(2, 1), arg1), Local0)
		m600(arg0, 9, Local0, bs26)

		// Method returns Reference to String

		if (y500) {
			Store(Concatenate(Derefof(m602(2, 0, 1)), arg1), Local0)
			m600(arg0, 10, Local0, bs25)

			Store(Concatenate(Derefof(m602(2, 1, 1)), arg1), Local0)
			m600(arg0, 11, Local0, bs26)
		}

		Concatenate("", arg1, Local0)
		m600(arg0, 12, Local0, bs25)

		Concatenate("1234q", arg1, Local0)
		m600(arg0, 13, Local0, bs26)

		Concatenate(aus0, arg1, Local0)
		m600(arg0, 14, Local0, bs25)

		Concatenate(aus1, arg1, Local0)
		m600(arg0, 15, Local0, bs26)

		if (y078) {
			Concatenate(Derefof(Refof(aus0)), arg1, Local0)
			m600(arg0, 16, Local0, bs25)

			Concatenate(Derefof(Refof(aus1)), arg1, Local0)
			m600(arg0, 17, Local0, bs26)
		}

		Concatenate(Derefof(Index(paus, 0)), arg1, Local0)
		m600(arg0, 18, Local0, bs25)

		Concatenate(Derefof(Index(paus, 1)), arg1, Local0)
		m600(arg0, 19, Local0, bs26)

		// Method returns String

		Concatenate(m601(2, 0), arg1, Local0)
		m600(arg0, 20, Local0, bs25)

		Concatenate(m601(2, 1), arg1, Local0)
		m600(arg0, 21, Local0, bs26)

		// Method returns Reference to String

		if (y500) {
			Concatenate(Derefof(m602(2, 0, 1)), arg1, Local0)
			m600(arg0, 22, Local0, bs25)

			Concatenate(Derefof(m602(2, 1, 1)), arg1, Local0)
			m600(arg0, 23, Local0, bs26)
		}

		// Boundary Cases

		Store(Concatenate("",
				arg2),
			Local0)
		m600(arg0, 24, Local0, bs27)
	}

//	Method(m071, 1)

//	Method(m072, 1)

	/*
	 * Begin of the test body
	 */

	// Integer to String implicit conversion Cases.

	// Integer to String conversion of the Integer second operand of
	// Logical operators when the first operand is evaluated as String.
	// LEqual LGreater LGreaterEqual LLess LLessEqual LNotEqual
	if (F64) {
		Concatenate(ts, "-m640", Local0)
		SRMT(Local0)
		m640(Local0, 0xfe7cb391d650a284)
	} else {
		Concatenate(ts, "-m320", Local0)
		SRMT(Local0)
		m320(Local0, 0xc179b3fe)
	}

	// Integer to String conversion of the Integer second operand of
	// Concatenate operator when the first operand is evaluated as String
	if (F64) {
		Concatenate(ts, "-m641", Local0)
		SRMT(Local0)
		m641(Local0, 0xfe7cb391d650a284)
	} else {
		Concatenate(ts, "-m321", Local0)
		SRMT(Local0)
		m321(Local0, 0xfe7cb391d650a284, 0xc179b3fe)
	}

	// Integer to String conversion of the Integer value
	// of Expression of Case statement when Expression in
	// Switch is either static String data or explicitly
	// converted to String by ToDecimalString, ToHexString
	// or ToString
	//
	// Note: Expression of Case can be only static data

	// Integer to Buffer implicit conversion Cases.

	// Integer to Buffer conversion of the Integer second operand of
	// Logical operators when the first operand is evaluated as Buffer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)
	if (F64) {
		Concatenate(ts, "-m644", Local0)
		SRMT(Local0)
		m644(Local0, 0xfe7cb391d650a284)
	} else {
		Concatenate(ts, "-m324", Local0)
		SRMT(Local0)
		m324(Local0, 0xc179b3fe)
	}

	// Integer to Buffer conversion of the both Integer operands of
	// Concatenate operator
	if (F64) {
		Concatenate(ts, "-m645", Local0)
		SRMT(Local0)
		m645(Local0, 0xfe7cb391d650a284)
	} else {
		Concatenate(ts, "-m325", Local0)
		SRMT(Local0)
		m325(Local0, 0xc179b3fe)
	}

	// Integer to Buffer conversion of the Integer second operand of
	// Concatenate operator when the first operand is evaluated as Buffer
	if (F64) {
		Concatenate(ts, "-m646", Local0)
		SRMT(Local0)
		m646(Local0, 0xfe7cb391d650a284)
	} else {
		Concatenate(ts, "-m326", Local0)
		SRMT(Local0)
		m326(Local0, 0xfe7cb391d650a284, 0xc179b3fe)
	}

	// Integer to Buffer conversion of the Integer Source operand of
	// ToString operator
	if (F64) {
		Concatenate(ts, "-m647", Local0)
		SRMT(Local0)
		m647(Local0, 0x6e7c534136502214, 0x6e00534136002214)
	} else {
		Concatenate(ts, "-m327", Local0)
		SRMT(Local0)
		m327(Local0, 0x6179534e, 0x6e7c534136002214)
	}

	// Integer to Buffer conversion of the Integer Source operand of
	// Mid operator
	if (F64) {
		Concatenate(ts, "-m648", Local0)
		SRMT(Local0)
		m648(Local0, 0xfe7cb391d650a284, 0x6e7c534136002214)
	} else {
		Concatenate(ts, "-m328", Local0)
		SRMT(Local0)
		m328(Local0, 0xc179b3fe, 0x6e7c534136002214)
	}

	// Integer to Buffer conversion of the Integer value of
	// Expression of Case statement when Expression in Switch
	// is either static Buffer data or explicitly converted to
	// Buffer by ToBuffer
	//
	// Note: Expression of Case can be only static data


	// String to Integer implicit conversion Cases.

	// String to Integer conversion of the String sole operand
	// of the 1-parameter Integer arithmetic operators
	// (Decrement, Increment, FindSetLeftBit, FindSetRightBit, Not)
	if (F64) {
		Concatenate(ts, "-m64b", Local0)
		SRMT(Local0)
		m64b(Local0, "0321", "FE7CB391D650A284")
	} else {
		Concatenate(ts, "-m32b", Local0)
		SRMT(Local0)
		m32b(Local0, "0321", "C179B3FE")
	}

	// String to Integer conversion of the String sole operand
	// of the LNot Logical Integer operator
	Concatenate(ts, "-m000", Local0)
	SRMT(Local0)
	m000(Local0, "0321", "FE7CB391D650A284", "C179B3FE", "0")

	// String to Integer conversion of the String sole operand
	// of the FromBCD and ToBCD conversion operators
	if (F64) {
		Concatenate(ts, "-m64c", Local0)
		SRMT(Local0)
		m64c(Local0, "0321", "FE7CB391D650A284",
			"3789012345678901", "D76162EE9EC35")
	} else {
		Concatenate(ts, "-m32c", Local0)
		SRMT(Local0)
		m32c(Local0, "0321", "FE7CB391D650A284",
			"90123456", "55F2CC0")
	}

	// String to Integer conversion of each String operand
	// of the 2-parameter Integer arithmetic operators
	// Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
	// ShiftLeft, ShiftRight, Subtract, Xor
	if (F64) {
		m64d(Concatenate(ts, "-m64d"))
	} else {
		m32d(Concatenate(ts, "-m32d"))
	}

	// String to Integer conversion of each String operand
	// of the 2-parameter Logical Integer operators LAnd and LOr
	if (F64) {
		m64e(Concatenate(ts, "-m64e"))
	} else {
		m32e(Concatenate(ts, "-m32e"))
	}

	// String to Integer conversion of the String second operand of
	// Logical operators when the first operand is evaluated as Integer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)

	Concatenate(ts, "-m02b", Local0)
	SRMT(Local0)
	m02b(Local0, "0321")

	if (F64) {
		Concatenate(ts, "-m64f", Local0)
		SRMT(Local0)
		m64f(Local0, "FE7CB391D650A284")
	} else {
		Concatenate(ts, "-m32f", Local0)
		SRMT(Local0)
		m32f(Local0, "C179B3FE")
	}

	// String to Integer intermediate conversion of the String second
	// operand of Concatenate operator in case the first one is Integer
	if (F64) {
		Concatenate(ts, "-m64g", Local0)
		SRMT(Local0)
		m64g(Local0, "0321", "FE7CB391D650A284")
	} else {
		Concatenate(ts, "-m32g", Local0)
		SRMT(Local0)
		m32g(Local0, "0321", "C179B3FE")
	}

	// String to Integer conversion of the String Length (second)
	// operand of the ToString operator

	Concatenate(ts, "-m02c", Local0)
	SRMT(Local0)
	m02c(Local0, "0321", "B")

	if (F64) {
		Concatenate(ts, "-m64h", Local0)
		SRMT(Local0)
		m64h(Local0, "FE7CB391D650A284")
	} else {
		Concatenate(ts, "-m32h", Local0)
		SRMT(Local0)
		m32h(Local0, "C179B3FE")
	}

	// String to Integer conversion of the String Index (second)
	// operand of the Index operator
	Concatenate(ts, "-m02d", Local0)
	SRMT(Local0)
	m02d(Local0, "B")

	// String to Integer conversion of the String Arg (third)
	// operand of the Fatal operator
	// (it can only be checked an exception does not occur)
	Concatenate(ts, "-m02e", Local0)
	SRMT(Local0)
	m02e(Local0, "0321", "FE7CB391D650A284", "C179B3FE")

	// String to Integer conversion of the String Index and Length
	// operands of the Mid operator

	Concatenate(ts, "-m02f", Local0)
	SRMT(Local0)
	m02f(Local0, "B")

	if (F64) {
		Concatenate(ts, "-m64i", Local0)
		SRMT(Local0)
		m64i(Local0, "FE7CB391D650A284", "B")
	} else {
		Concatenate(ts, "-m32i", Local0)
		SRMT(Local0)
		m32i(Local0, "C179B3FE", "B")
	}

	// String to Integer conversion of the String StartIndex
	// operand of the Match operator
	Concatenate(ts, "-m030", Local0)
	SRMT(Local0)
	m030(Local0, "B")

	// String to Integer conversion of the String sole operand
	// of the Method execution control operators (Sleep, Stall)
	Concatenate(ts, "-m031", Local0)
	SRMT(Local0)
	m031(Local0, "0321", "63")

	// String to Integer conversion of the String TimeoutValue
	// (second) operand of the Acquire operator
/* Compiler allows only Integer constant as TimeoutValue (Bug 1)
	Concatenate(ts, "-m032", Local0)
	SRMT(Local0)
	m032(Local0, "0321")
*/

	// String to Integer conversion of the String TimeoutValue
	// (second) operand of the Wait operator
	Concatenate(ts, "-m033", Local0)
	SRMT(Local0)
	m033(Local0, "0321")

	// String to Integer conversion of the String value
	// of Predicate of the Method execution control statements
	// (If, ElseIf, While)
	Concatenate(ts, "-m034", Local0)
	SRMT(Local0)
	m034(Local0, "0321", "FE7CB391D650A284", "C179B3FE", "0")

	// String to Integer conversion of the String value
	// of Expression of Case statement when Expression in
	// Switch is evaluated as Integer
	//
	// Note: Expression of Case can be only static data


	// String to Buffer implicit conversion Cases.

	// String to Buffer conversion of the String second operand of
	// Logical operators when the first operand is evaluated as Buffer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)
	Concatenate(ts, "-m035", Local0)
	SRMT(Local0)
	m035(Local0, "0321", "",
		"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*")

	// String to Buffer conversion of the String second operand of
	// Concatenate operator when the first operand is evaluated as Buffer
	Concatenate(ts, "-m036", Local0)
	SRMT(Local0)
	m036(Local0, "0321", "",
		"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*")

	// String to Buffer conversion of the String Source operand of
	// ToString operator (has a visual effect in shortening of the
	// String taken the null character)
	Concatenate(ts, "-m037", Local0)
	SRMT(Local0)
	m037(Local0, "0321", "",
		"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*")


	// Buffer to Integer implicit conversion Cases.

	// Buffer to Integer conversion of the Buffer sole operand
	// of the 1-parameter Integer arithmetic operators
	// (Decrement, Increment, FindSetLeftBit, FindSetRightBit, Not)
	if (F64) {
		Concatenate(ts, "-m64l", Local0)
		SRMT(Local0)
		m64l(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
	} else {
		Concatenate(ts, "-m32l", Local0)
		SRMT(Local0)
		m32l(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
	}

	// Buffer to Integer conversion of the Buffer sole operand
	// of the LNot Logical Integer operator
	Concatenate(ts, "-m03a", Local0)
	SRMT(Local0)
	m03a(Local0, Buffer(3){0x21, 0x03, 0x00},
		Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5},
		Buffer(1){0x00})

	// Buffer to Integer conversion of the Buffer sole operand
	// of the FromBCD and ToBCD conversion operators
	if (F64) {
		Concatenate(ts, "-m64m", Local0)
		SRMT(Local0)
		m64m(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer() {0x01, 0x89, 0x67, 0x45, 0x23, 0x01, 0x89, 0x37},
			Buffer() {0x35, 0xec, 0xe9, 0x2e, 0x16, 0x76, 0x0d})
	} else {
		Concatenate(ts, "-m32m", Local0)
		SRMT(Local0)
		m32m(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer() {0x56, 0x34, 0x12, 0x90}, Buffer() {0xc0, 0x2c, 0x5f, 0x05})
	}

	// Buffer to Integer conversion of each Buffer operand
	// of the 2-parameter Integer arithmetic operators
	// Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
	// ShiftLeft, ShiftRight, Subtract, Xor
	if (F64) {
		m64n(Concatenate(ts, "-m64n"))
	} else {
		m32n(Concatenate(ts, "-m32n"))
	}

	// Buffer to Integer conversion of each Buffer operand
	// of the 2-parameter Logical Integer operators LAnd and LOr
	if (F64) {
		m64o(Concatenate(ts, "-m64o"))
	} else {
		m32o(Concatenate(ts, "-m32o"))
	}

	// Buffer to Integer conversion of the Buffer second operand of
	// Logical operators when the first operand is evaluated as Integer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)

	Concatenate(ts, "-m065", Local0)
	SRMT(Local0)
	m065(Local0, Buffer(3){0x21, 0x03, 0x00})

	if (F64) {
		Concatenate(ts, "-m64p", Local0)
		SRMT(Local0)
		m64p(Local0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
	} else {
		Concatenate(ts, "-m32p", Local0)
		SRMT(Local0)
		m32p(Local0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
	}

	// Buffer to Integer intermediate conversion of the Buffer second
	// operand of Concatenate operator in case the first one is Integer
	if (F64) {
		Concatenate(ts, "-m64q", Local0)
		SRMT(Local0)
		m64q(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
	} else {
		Concatenate(ts, "-m32q", Local0)
		SRMT(Local0)
		m32q(Local0, Buffer(3){0x21, 0x03, 0x00},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
	}

	// Buffer to Integer conversion of the Buffer Length (second)
	// operand of the ToString operator

	Concatenate(ts, "-m066", Local0)
	SRMT(Local0)
	m066(Local0, Buffer(3){0x21, 0x03, 0x00}, Buffer(1){0xb})

	if (F64) {
		Concatenate(ts, "-m64r", Local0)
		SRMT(Local0)
		m64r(Local0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
	} else {
		Concatenate(ts, "-m32r", Local0)
		SRMT(Local0)
		m32r(Local0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
	}

	// Buffer to Integer conversion of the Buffer Index (second)
	// operand of the Index operator
	Concatenate(ts, "-m067", Local0)
	SRMT(Local0)
	m067(Local0, Buffer(1){0xb})

	// Buffer to Integer conversion of the String Arg (third)
	// operand of the Fatal operator
	// (it can only be checked an exception does not occur)
	Concatenate(ts, "-m068", Local0)
	SRMT(Local0)
	m068(Local0, Buffer(3){0x21, 0x03, 0x00},
		Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})

	// Buffer to Integer conversion of the Buffer Index and Length
	// operands of the Mid operator

	Concatenate(ts, "-m069", Local0)
	SRMT(Local0)
	m069(Local0, Buffer(1){0xb})
	if (F64) {
		Concatenate(ts, "-m64s", Local0)
		SRMT(Local0)
		m64s(Local0,
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5},
			Buffer(1){0xb})
	} else {
		Concatenate(ts, "-m32s", Local0)
		SRMT(Local0)
		m32s(Local0,
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5},
			Buffer(1){0xb})
	}

	// Buffer to Integer conversion of the Buffer StartIndex
	// operand of the Match operator
	Concatenate(ts, "-m06a", Local0)
	SRMT(Local0)
	m06a(Local0, Buffer(1){0xb})

	// Buffer to Integer conversion of the Buffer sole operand
	// of the Method execution control operators (Sleep, Stall)
	Concatenate(ts, "-m06b", Local0)
	SRMT(Local0)
	m06b(Local0, Buffer(3){0x21, 0x03, 0x00}, Buffer(1){0x3f})

	// Buffer to Integer conversion of the Buffer TimeoutValue
	// (second) operand of the Acquire operator
/* Compiler allows only Integer constant as TimeoutValue (Bug 1)
	Concatenate(ts, "-m06c", Local0)
	SRMT(Local0)
	m06c(Local0, Buffer(3){0x21, 0x03, 0x00})
*/

	// Buffer to Integer conversion of the Buffer TimeoutValue
	// (second) operand of the Wait operator
	Concatenate(ts, "-m06d", Local0)
	SRMT(Local0)
	m06d(Local0, Buffer(3){0x21, 0x03, 0x00})

	// Buffer to Integer conversion of the Buffer value
	// of Predicate of the Method execution control statements
	// (If, ElseIf, While)
	Concatenate(ts, "-m06e", Local0)
	SRMT(Local0)
	m06e(Local0, Buffer(3){0x21, 0x03, 0x00},
		Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5},
		Buffer(1){0x00})

	// Buffer to Integer conversion of the Buffer value
	// of Expression of Case statement when Expression in
	// Switch is evaluated as Integer
	//
	// Note: Expression of Case can be only static data

	// Buffer to String implicit conversion Cases.

	// Buffer to String conversion of the Buffer second operand of
	// Logical operators when the first operand is evaluated as String.
	// LEqual LGreater LGreaterEqual LLess LLessEqual LNotEqual
	Concatenate(ts, "-m06f", Local0)
	SRMT(Local0)
	m06f(Local0, Buffer(3){0x21, 0x03, 0x00},
		Buffer(67){
			0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
			0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
			0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
			0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
			0x61,0x62,0x63,})

	// Buffer to String conversion of the Buffer second operand of
	// Concatenate operator when the first operand is evaluated as String
	Concatenate(ts, "-m070", Local0)
	SRMT(Local0)
	m070(Local0, Buffer(3){0x21, 0x03, 0x00},
		Buffer(67){
			0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
			0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
			0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
			0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
			0x61,0x62,0x63,})
}

// Run-method
Method(OPR5)
{
	Store("TEST: OPR5, Source Operand", Debug)

	m617()
}
