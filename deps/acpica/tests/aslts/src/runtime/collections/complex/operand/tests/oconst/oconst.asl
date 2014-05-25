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
 * Check implicit conversion being applied to data images
 */

Name(z085, 85)

Method(m610,, Serialized)
{
	Name(ts, "m610")

	// Integer to String implicit conversion Cases.

	// Integer to String conversion of the Integer second operand of
	// Logical operators when the first operand is evaluated as String.
	// LEqual LGreater LGreaterEqual LLess LLessEqual LNotEqual

	Method(m640, 1)
	{
		// LEqual

		Store(LEqual("FE7CB391D650A284", 0xfe7cb391d650a284), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual("fE7CB391D650A284", 0xfe7cb391d650a284), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aus4, 0xfe7cb391d650a284), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(aus5, 0xfe7cb391d650a284), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aus4)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(aus5)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paus, 4)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paus, 5)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns String

		Store(LEqual(m601(2, 4), 0xfe7cb391d650a284), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(2, 5), 0xfe7cb391d650a284), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LEqual(Derefof(m602(2, 4, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(2, 5, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater("FE7CB391D650A284", 0xfe7cb391d650a284), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater("fE7CB391D650A284", 0xfe7cb391d650a284), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater("FE7CB391D650A28 ", 0xfe7cb391d650a284), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater("FE7CB391D650A284q", 0xfe7cb391d650a284), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aus4, 0xfe7cb391d650a284), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(aus5, 0xfe7cb391d650a284), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aus4)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(aus5)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paus, 4)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paus, 5)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns String

		Store(LGreater(m601(2, 4), 0xfe7cb391d650a284), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(2, 5), 0xfe7cb391d650a284), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LGreater(Derefof(m602(2, 4, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(2, 5, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual("FE7CB391D650A284", 0xfe7cb391d650a284), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual("fE7CB391D650A284", 0xfe7cb391d650a284), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual("FE7CB391D650A28 ", 0xfe7cb391d650a284), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual("FE7CB391D650A284q", 0xfe7cb391d650a284), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aus4, 0xfe7cb391d650a284), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(aus5, 0xfe7cb391d650a284), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aus4)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(aus5)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paus, 4)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paus, 5)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns String

		Store(LGreaterEqual(m601(2, 4), 0xfe7cb391d650a284), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(2, 5), 0xfe7cb391d650a284), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(2, 4, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(2, 5, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess("FE7CB391D650A284", 0xfe7cb391d650a284), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess("fE7CB391D650A284", 0xfe7cb391d650a284), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess("FE7CB391D650A28 ", 0xfe7cb391d650a284), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess("FE7CB391D650A284q", 0xfe7cb391d650a284), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aus4, 0xfe7cb391d650a284), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(aus5, 0xfe7cb391d650a284), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aus4)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(aus5)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paus, 4)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paus, 5)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns String

		Store(LLess(m601(2, 4), 0xfe7cb391d650a284), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(2, 5), 0xfe7cb391d650a284), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LLess(Derefof(m602(2, 4, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(2, 5, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual("FE7CB391D650A284", 0xfe7cb391d650a284), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual("fE7CB391D650A284", 0xfe7cb391d650a284), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual("FE7CB391D650A28 ", 0xfe7cb391d650a284), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual("FE7CB391D650A284q", 0xfe7cb391d650a284), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aus4, 0xfe7cb391d650a284), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(aus5, 0xfe7cb391d650a284), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aus4)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(aus5)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paus, 4)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paus, 5)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns String

		Store(LLessEqual(m601(2, 4), 0xfe7cb391d650a284), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(2, 5), 0xfe7cb391d650a284), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LLessEqual(Derefof(m602(2, 4, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(2, 5, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual("FE7CB391D650A284", 0xfe7cb391d650a284), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual("fE7CB391D650A284", 0xfe7cb391d650a284), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual("FE7CB391D650A28 ", 0xfe7cb391d650a284), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual("FE7CB391D650A284q", 0xfe7cb391d650a284), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aus4, 0xfe7cb391d650a284), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(aus5, 0xfe7cb391d650a284), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aus4)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(aus5)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paus, 4)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paus, 5)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns String

		Store(LNotEqual(m601(2, 4), 0xfe7cb391d650a284), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(2, 5), 0xfe7cb391d650a284), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LNotEqual(Derefof(m602(2, 4, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(2, 5, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 81, Local0, Ones)
		}
	}

	Method(m320, 1)
	{
		// LEqual

		Store(LEqual("C179B3FE", 0xc179b3fe), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual("c179B3FE", 0xc179b3fe), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aus3, 0xc179b3fe), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(aus2, 0xc179b3fe), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aus3)), 0xc179b3fe), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(aus2)), 0xc179b3fe), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paus, 3)), 0xc179b3fe), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paus, 2)), 0xc179b3fe), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns String

		Store(LEqual(m601(2, 3), 0xc179b3fe), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(2, 2), 0xc179b3fe), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LEqual(Derefof(m602(2, 3, 1)), 0xc179b3fe), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(2, 2, 1)), 0xc179b3fe), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater("C179B3FE", 0xc179b3fe), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater("c179B3FE", 0xc179b3fe), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater("C179B3F ", 0xc179b3fe), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater("C179B3FEq", 0xc179b3fe), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aus3, 0xc179b3fe), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(aus2, 0xc179b3fe), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aus3)), 0xc179b3fe), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(aus2)), 0xc179b3fe), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paus, 3)), 0xc179b3fe), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paus, 2)), 0xc179b3fe), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns String

		Store(LGreater(m601(2, 3), 0xc179b3fe), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(2, 2), 0xc179b3fe), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LGreater(Derefof(m602(2, 3, 1)), 0xc179b3fe), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(2, 2, 1)), 0xc179b3fe), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual("C179B3FE", 0xc179b3fe), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual("c179B3FE", 0xc179b3fe), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual("C179B3F ", 0xc179b3fe), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual("C179B3FEq", 0xc179b3fe), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aus3, 0xc179b3fe), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(aus2, 0xc179b3fe), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aus3)), 0xc179b3fe), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(aus2)), 0xc179b3fe), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paus, 3)), 0xc179b3fe), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paus, 2)), 0xc179b3fe), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns String

		Store(LGreaterEqual(m601(2, 3), 0xc179b3fe), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(2, 2), 0xc179b3fe), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(2, 3, 1)), 0xc179b3fe), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(2, 2, 1)), 0xc179b3fe), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess("C179B3FE", 0xc179b3fe), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess("c179B3FE", 0xc179b3fe), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess("C179B3F ", 0xc179b3fe), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess("C179B3FEq", 0xc179b3fe), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aus3, 0xc179b3fe), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(aus2, 0xc179b3fe), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aus3)), 0xc179b3fe), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(aus2)), 0xc179b3fe), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paus, 3)), 0xc179b3fe), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paus, 2)), 0xc179b3fe), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns String

		Store(LLess(m601(2, 3), 0xc179b3fe), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(2, 2), 0xc179b3fe), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LLess(Derefof(m602(2, 3, 1)), 0xc179b3fe), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(2, 2, 1)), 0xc179b3fe), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual("C179B3FE", 0xc179b3fe), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual("c179B3FE", 0xc179b3fe), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual("C179B3F ", 0xc179b3fe), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual("C179B3FEq", 0xc179b3fe), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aus3, 0xc179b3fe), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(aus2, 0xc179b3fe), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aus3)), 0xc179b3fe), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(aus2)), 0xc179b3fe), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paus, 3)), 0xc179b3fe), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paus, 2)), 0xc179b3fe), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns String

		Store(LLessEqual(m601(2, 3), 0xc179b3fe), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(2, 2), 0xc179b3fe), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LLessEqual(Derefof(m602(2, 3, 1)), 0xc179b3fe), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(2, 2, 1)), 0xc179b3fe), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual("C179B3FE", 0xc179b3fe), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual("c179B3FE", 0xc179b3fe), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual("C179B3F ", 0xc179b3fe), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual("C179B3FEq", 0xc179b3fe), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aus3, 0xc179b3fe), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(aus2, 0xc179b3fe), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aus3)), 0xc179b3fe), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(aus2)), 0xc179b3fe), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paus, 3)), 0xc179b3fe), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paus, 2)), 0xc179b3fe), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns String

		Store(LNotEqual(m601(2, 3), 0xc179b3fe), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(2, 2), 0xc179b3fe), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LNotEqual(Derefof(m602(2, 3, 1)), 0xc179b3fe), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(2, 2, 1)), 0xc179b3fe), Local0)
			m600(arg0, 81, Local0, Ones)
		}
	}

	// Integer to String conversion of the Integer second operand of
	// Concatenate operator when the first operand is evaluated as String

	Method(m641, 1)
	{		
		Store(Concatenate("", 0xfe7cb391d650a284), Local0)
		m600(arg0, 0, Local0, bs10)

		Store(Concatenate("1234q", 0xfe7cb391d650a284), Local0)
		m600(arg0, 1, Local0, bs11)

		Store(Concatenate(aus0, 0xfe7cb391d650a284), Local0)
		m600(arg0, 2, Local0, bs10)

		Store(Concatenate(aus1, 0xfe7cb391d650a284), Local0)
		m600(arg0, 3, Local0, bs11)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aus0)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 4, Local0, bs10)

			Store(Concatenate(Derefof(Refof(aus1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 5, Local0, bs11)
		}

		Store(Concatenate(Derefof(Index(paus, 0)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 6, Local0, bs10)

		Store(Concatenate(Derefof(Index(paus, 1)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 7, Local0, bs11)

		// Method returns String

		Store(Concatenate(m601(2, 0), 0xfe7cb391d650a284), Local0)
		m600(arg0, 8, Local0, bs10)

		Store(Concatenate(m601(2, 1), 0xfe7cb391d650a284), Local0)
		m600(arg0, 9, Local0, bs11)

		// Method returns Reference to String

		if (y500) {
			Store(Concatenate(Derefof(m602(2, 0, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 10, Local0, bs10)

			Store(Concatenate(Derefof(m602(2, 1, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 11, Local0, bs11)
		}

		Concatenate("", 0xfe7cb391d650a284, Local0)
		m600(arg0, 12, Local0, bs10)

		Concatenate("1234q", 0xfe7cb391d650a284, Local0)
		m600(arg0, 13, Local0, bs11)

		Concatenate(aus0, 0xfe7cb391d650a284, Local0)
		m600(arg0, 14, Local0, bs10)

		Concatenate(aus1, 0xfe7cb391d650a284, Local0)
		m600(arg0, 15, Local0, bs11)

		if (y078) {
			Concatenate(Derefof(Refof(aus0)), 0xfe7cb391d650a284, Local0)
			m600(arg0, 16, Local0, bs10)

			Concatenate(Derefof(Refof(aus1)), 0xfe7cb391d650a284, Local0)
			m600(arg0, 17, Local0, bs11)
		}

		Concatenate(Derefof(Index(paus, 0)), 0xfe7cb391d650a284, Local0)
		m600(arg0, 18, Local0, bs10)

		Concatenate(Derefof(Index(paus, 1)), 0xfe7cb391d650a284, Local0)
		m600(arg0, 19, Local0, bs11)

		// Method returns String

		Concatenate(m601(2, 0), 0xfe7cb391d650a284, Local0)
		m600(arg0, 20, Local0, bs10)

		Concatenate(m601(2, 1), 0xfe7cb391d650a284, Local0)
		m600(arg0, 21, Local0, bs11)

		// Method returns Reference to String

		if (y500) {
			Concatenate(Derefof(m602(2, 0, 1)), 0xfe7cb391d650a284, Local0)
			m600(arg0, 22, Local0, bs10)

			Concatenate(Derefof(m602(2, 1, 1)), 0xfe7cb391d650a284, Local0)
			m600(arg0, 23, Local0, bs11)
		}
	}

	Method(m321, 1)
	{		
		Store(Concatenate("", 0xc179b3fe), Local0)
		m600(arg0, 0, Local0, bs12)

		Store(Concatenate("1234q", 0xc179b3fe), Local0)
		m600(arg0, 1, Local0, bs13)

		Store(Concatenate(aus0, 0xc179b3fe), Local0)
		m600(arg0, 2, Local0, bs12)

		Store(Concatenate(aus1, 0xc179b3fe), Local0)
		m600(arg0, 3, Local0, bs13)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aus0)), 0xc179b3fe), Local0)
			m600(arg0, 4, Local0, bs12)

			Store(Concatenate(Derefof(Refof(aus1)), 0xc179b3fe), Local0)
			m600(arg0, 5, Local0, bs13)
		}

		Store(Concatenate(Derefof(Index(paus, 0)), 0xc179b3fe), Local0)
		m600(arg0, 6, Local0, bs12)

		Store(Concatenate(Derefof(Index(paus, 1)), 0xc179b3fe), Local0)
		m600(arg0, 7, Local0, bs13)

		// Method returns String

		Store(Concatenate(m601(2, 0), 0xc179b3fe), Local0)
		m600(arg0, 8, Local0, bs12)

		Store(Concatenate(m601(2, 1), 0xc179b3fe), Local0)
		m600(arg0, 9, Local0, bs13)

		// Method returns Reference to String

		if (y500) {
			Store(Concatenate(Derefof(m602(2, 0, 1)), 0xc179b3fe), Local0)
			m600(arg0, 10, Local0, bs12)

			Store(Concatenate(Derefof(m602(2, 1, 1)), 0xc179b3fe), Local0)
			m600(arg0, 11, Local0, bs13)
		}

		Store(Concatenate("", 0xfe7cb391d650a284), Local0)
		m600(arg0, 12, Local0, bs14)

		Store(Concatenate("1234q", 0xfe7cb391d650a284), Local0)
		m600(arg0, 13, Local0, bs15)

		Concatenate("", 0xc179b3fe, Local0)
		m600(arg0, 14, Local0, bs12)

		Concatenate("1234q", 0xc179b3fe, Local0)
		m600(arg0, 15, Local0, bs13)

		Concatenate(aus0, 0xc179b3fe, Local0)
		m600(arg0, 16, Local0, bs12)

		Concatenate(aus1, 0xc179b3fe, Local0)
		m600(arg0, 17, Local0, bs13)

		if (y078) {
			Concatenate(Derefof(Refof(aus0)), 0xc179b3fe, Local0)
			m600(arg0, 18, Local0, bs12)

			Concatenate(Derefof(Refof(aus1)), 0xc179b3fe, Local0)
			m600(arg0, 19, Local0, bs13)
		}

		Concatenate(Derefof(Index(paus, 0)), 0xc179b3fe, Local0)
		m600(arg0, 20, Local0, bs12)

		Concatenate(Derefof(Index(paus, 1)), 0xc179b3fe, Local0)
		m600(arg0, 21, Local0, bs13)

		// Method returns String

		Concatenate(m601(2, 0), 0xc179b3fe, Local0)
		m600(arg0, 22, Local0, bs12)

		Concatenate(m601(2, 1), 0xc179b3fe, Local0)
		m600(arg0, 23, Local0, bs13)

		// Method returns Reference to String

		if (y500) {
			Concatenate(Derefof(m602(2, 0, 1)), 0xc179b3fe, Local0)
			m600(arg0, 24, Local0, bs12)

			Concatenate(Derefof(m602(2, 1, 1)), 0xc179b3fe, Local0)
			m600(arg0, 25, Local0, bs13)
		}

		Concatenate("", 0xfe7cb391d650a284, Local0)
		m600(arg0, 26, Local0, bs14)

		Concatenate("1234q", 0xfe7cb391d650a284, Local0)
		m600(arg0, 27, Local0, bs15)
	}


	// Integer to String conversion of the Integer elements
	// of a search package of Match operator when some MatchObject
	// is evaluated as String

	Method(m642, 1)
	{
	
		Store(Match(Package(){0xfe7cb391d650a284},
			MEQ, "FE7CB391D650A284", MTR, 0, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Match(Package(){0xfe7cb391d650a284},
			MEQ, "fE7CB391D650A284", MTR, 0, 0), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(Package(){0xfe7cb391d650a284},
			MTR, 0, MEQ, "FE7CB391D650A284", 0), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Match(Package(){0xfe7cb391d650a284},
			MTR, 0, MEQ, "fE7CB391D650A284", 0), Local0)
		m600(arg0, 3, Local0, Ones)

	}
	
	Method(m322, 1)
	{
		Store(Match(Package(){0xc179b3fe},
			MEQ, "C179B3FE", MTR, 0, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Match(Package(){0xc179b3fe},
			MEQ, "c179B3FE", MTR, 0, 0), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(Package(){0xc179b3fe},
			MTR, 0, MEQ, "C179B3FE", 0), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Match(Package(){0xc179b3fe},
			MTR, 0, MEQ, "c179B3FE", 0), Local0)
		m600(arg0, 3, Local0, Ones)

	}

	// Integer to String conversion of the Integer value
	// of Expression of Case statement when Expression in
	// Switch is either static String data or explicitly
	// converted to String by ToDecimalString, ToHexString
	// or ToString

	Method(m643, 1, Serialized)
	{
		Name(i000, 0)

		Store(0, i000)
		Switch ("fE7CB391D650A284") {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 0, i000, 2)

		Store(0, i000)
		Switch ("FE7CB391D650A284") {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 1, i000, 1)

		Store(0, i000)
		Switch (ToHexString(aus5)) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 2, i000, 2)

		Store(0, i000)
		Switch (ToHexString(aus4)) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 3, i000, 1)

		if (y078) {
			Store(0, i000)
			Switch (ToHexString(Derefof(Refof(aus5)))) {
				Case (0xfe7cb391d650a284) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 4, i000, 2)

			Store(0, i000)
			Switch (ToHexString(Derefof(Refof(aus4)))) {
				Case (0xfe7cb391d650a284) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 5, i000, 1)
		}

		Store(0, i000)
		Switch (ToHexString(Derefof(Index(paus, 5)))) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 6, i000, 2)

		Store(0, i000)
		Switch (ToHexString(Derefof(Index(paus, 4)))) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 7, i000, 1)

		// Method returns String

		Store(0, i000)
		Switch (ToHexString(m601(2, 5))) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 8, i000, 2)

		Store(0, i000)
		Switch (ToHexString(m601(2, 4))) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 9, i000, 1)

		// Method returns Reference to String

		if (y500) {
			Store(0, i000)
			Switch (ToHexString(Derefof(m602(2, 5, 1)))) {
				Case (0xfe7cb391d650a284) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 10, i000, 2)

			Store(0, i000)
			Switch (ToHexString(Derefof(m602(2, 4, 1)))) {
				Case (0xfe7cb391d650a284) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 11, i000, 1)
		}
	}

	Method(m323, 1, Serialized)
	{
		Name(i000, 0)

		Store(0, i000)
		Switch ("c179B3FE") {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 0, i000, 2)

		Store(0, i000)
		Switch ("C179B3FE") {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 1, i000, 1)

		Store(0, i000)
		Switch (ToHexString(aus2)) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 2, i000, 2)

		Store(0, i000)
		Switch (ToHexString(aus3)) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 3, i000, 1)

		if (y078) {
			Store(0, i000)
			Switch (ToHexString(Derefof(Refof(aus2)))) {
				Case (0xc179b3fe) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 4, i000, 2)

			Store(0, i000)
			Switch (ToHexString(Derefof(Refof(aus3)))) {
				Case (0xc179b3fe) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 5, i000, 1)
		}

		Store(0, i000)
		Switch (ToHexString(Derefof(Index(paus, 2)))) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 6, i000, 2)

		Store(0, i000)
		Switch (ToHexString(Derefof(Index(paus, 3)))) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 7, i000, 1)

		// Method returns String

		Store(0, i000)
		Switch (ToHexString(m601(2, 2))) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 8, i000, 2)

		Store(0, i000)
		Switch (ToHexString(m601(2, 3))) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 9, i000, 1)

		// Method returns Reference to String

		if (y500) {
			Store(0, i000)
			Switch (ToHexString(Derefof(m602(2, 2, 1)))) {
				Case (0xc179b3fe) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 10, i000, 2)

			Store(0, i000)
			Switch (ToHexString(Derefof(m602(2, 3, 1)))) {
				Case (0xc179b3fe) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 11, i000, 1)
		}
	}

	// Integer to Buffer implicit conversion Cases.

	// Integer to Buffer conversion of the Integer second operand of
	// Logical operators when the first operand is evaluated as Buffer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)

	Method(m644, 1)
	{		
		// LEqual

		Store(LEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aub4, 0xfe7cb391d650a284), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(aub3, 0xfe7cb391d650a284), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aub4)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(aub3)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paub, 4)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paub, 3)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns Buffer

		Store(LEqual(m601(3, 4), 0xfe7cb391d650a284), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(3, 3), 0xfe7cb391d650a284), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LEqual(Derefof(m602(3, 4, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(3, 3, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aub4, 0xfe7cb391d650a284), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(aub5, 0xfe7cb391d650a284), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aub4)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(aub5)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paub, 4)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paub, 5)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Buffer

		Store(LGreater(m601(3, 4), 0xfe7cb391d650a284), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(3, 5), 0xfe7cb391d650a284), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreater(Derefof(m602(3, 4, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(3, 5, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aub4, 0xfe7cb391d650a284), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(aub5, 0xfe7cb391d650a284), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aub4)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(aub5)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paub, 4)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paub, 5)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns Buffer

		Store(LGreaterEqual(m601(3, 4), 0xfe7cb391d650a284), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(3, 5), 0xfe7cb391d650a284), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(3, 4, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(3, 5, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aub4, 0xfe7cb391d650a284), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(aub5, 0xfe7cb391d650a284), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aub4)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(aub5)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paub, 4)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paub, 5)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns Buffer

		Store(LLess(m601(3, 4), 0xfe7cb391d650a284), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(3, 5), 0xfe7cb391d650a284), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLess(Derefof(m602(3, 4, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(3, 5, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aub4, 0xfe7cb391d650a284), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(aub5, 0xfe7cb391d650a284), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aub4)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(aub5)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paub, 4)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paub, 5)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns Buffer

		Store(LLessEqual(m601(3, 4), 0xfe7cb391d650a284), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(3, 5), 0xfe7cb391d650a284), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLessEqual(Derefof(m602(3, 4, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(3, 5, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aub4, 0xfe7cb391d650a284), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(aub5, 0xfe7cb391d650a284), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aub4)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(aub5)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paub, 4)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paub, 5)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns Buffer

		Store(LNotEqual(m601(3, 4), 0xfe7cb391d650a284), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(3, 5), 0xfe7cb391d650a284), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LNotEqual(Derefof(m602(3, 4, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(3, 5, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 81, Local0, Ones)
		}
	}
	
	Method(m324, 1)
	{
		// LEqual

		Store(LEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, 0xc179b3fe), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, 0xc179b3fe), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aub3, 0xc179b3fe), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(aub2, 0xc179b3fe), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aub3)), 0xc179b3fe), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(aub2)), 0xc179b3fe), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paub, 3)), 0xc179b3fe), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paub, 2)), 0xc179b3fe), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns Buffer

		Store(LEqual(m601(3, 3), 0xc179b3fe), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(3, 2), 0xc179b3fe), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LEqual(Derefof(m602(3, 3, 1)), 0xc179b3fe), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(3, 2, 1)), 0xc179b3fe), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, 0xc179b3fe), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, 0xc179b3fe), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, 0xc179b3fe), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, 0xc179b3fe), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aub3, 0xc179b3fe), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(aub2, 0xc179b3fe), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aub3)), 0xc179b3fe), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(aub2)), 0xc179b3fe), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paub, 3)), 0xc179b3fe), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paub, 2)), 0xc179b3fe), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Buffer

		Store(LGreater(m601(3, 3), 0xc179b3fe), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(3, 2), 0xc179b3fe), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreater(Derefof(m602(3, 3, 1)), 0xc179b3fe), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(3, 2, 1)), 0xc179b3fe), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, 0xc179b3fe), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, 0xc179b3fe), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, 0xc179b3fe), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, 0xc179b3fe), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aub3, 0xc179b3fe), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(aub2, 0xc179b3fe), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aub3)), 0xc179b3fe), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(aub2)), 0xc179b3fe), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paub, 3)), 0xc179b3fe), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paub, 2)), 0xc179b3fe), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns Buffer

		Store(LGreaterEqual(m601(3, 3), 0xc179b3fe), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(3, 2), 0xc179b3fe), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(3, 3, 1)), 0xc179b3fe), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(3, 2, 1)), 0xc179b3fe), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, 0xc179b3fe), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, 0xc179b3fe), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, 0xc179b3fe), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, 0xc179b3fe), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aub3, 0xc179b3fe), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(aub2, 0xc179b3fe), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aub3)), 0xc179b3fe), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(aub2)), 0xc179b3fe), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paub, 3)), 0xc179b3fe), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paub, 2)), 0xc179b3fe), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns Buffer

		Store(LLess(m601(3, 3), 0xc179b3fe), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(3, 2), 0xc179b3fe), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLess(Derefof(m602(3, 3, 1)), 0xc179b3fe), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(3, 2, 1)), 0xc179b3fe), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, 0xc179b3fe), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, 0xc179b3fe), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, 0xc179b3fe), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, 0xc179b3fe), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aub3, 0xc179b3fe), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(aub2, 0xc179b3fe), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aub3)), 0xc179b3fe), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(aub2)), 0xc179b3fe), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paub, 3)), 0xc179b3fe), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paub, 2)), 0xc179b3fe), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns Buffer

		Store(LLessEqual(m601(3, 3), 0xc179b3fe), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(3, 2), 0xc179b3fe), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLessEqual(Derefof(m602(3, 3, 1)), 0xc179b3fe), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(3, 2, 1)), 0xc179b3fe), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, 0xc179b3fe), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, 0xc179b3fe), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, 0xc179b3fe), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, 0xc179b3fe), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aub3, 0xc179b3fe), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(aub2, 0xc179b3fe), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aub3)), 0xc179b3fe), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(aub2)), 0xc179b3fe), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paub, 3)), 0xc179b3fe), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paub, 2)), 0xc179b3fe), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns Buffer

		Store(LNotEqual(m601(3, 3), 0xc179b3fe), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(3, 2), 0xc179b3fe), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LNotEqual(Derefof(m602(3, 3, 1)), 0xc179b3fe), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(3, 2, 1)), 0xc179b3fe), Local0)
			m600(arg0, 81, Local0, Ones)
		}
	}


	// Integer to Buffer conversion of the both Integer operands of
	// Concatenate operator

	Method(m645, 1)
	{		
		Store(Concatenate(0xfe7cb391d650a284, 0xfe7cb391d650a284), Local0)
		m600(arg0, 0, Local0, bb20)

		Store(Concatenate(0x321, 0xfe7cb391d650a284), Local0)
		m600(arg0, 1, Local0, bb21)

		Store(Concatenate(0xfe7cb391d650a284, 0x321), Local0)
		m600(arg0, 1, Local0, bb22)

		Concatenate(0xfe7cb391d650a284, 0xfe7cb391d650a284, Local0)
		m600(arg0, 0, Local0, bb20)

		Concatenate(0x321, 0xfe7cb391d650a284, Local0)
		m600(arg0, 1, Local0, bb21)

		Concatenate(0xfe7cb391d650a284, 0x321, Local0)
		m600(arg0, 1, Local0, bb22)
	}

	Method(m325, 1)
	{		
		Store(Concatenate(0xc179b3fe, 0xc179b3fe), Local0)
		m600(arg0, 0, Local0, bb23)

		Store(Concatenate(0x321, 0xc179b3fe), Local0)
		m600(arg0, 1, Local0, bb24)

		Store(Concatenate(0xc179b3fe, 0x321), Local0)
		m600(arg0, 1, Local0, bb25)

		Concatenate(0xc179b3fe, 0xc179b3fe, Local0)
		m600(arg0, 0, Local0, bb23)

		Concatenate(0x321, 0xc179b3fe, Local0)
		m600(arg0, 1, Local0, bb24)

		Concatenate(0xc179b3fe, 0x321, Local0)
		m600(arg0, 1, Local0, bb25)
	}

	// Integer to Buffer conversion of the Integer second operand of
	// Concatenate operator when the first operand is evaluated as Buffer

	Method(m646, 1)
	{		
		Store(Concatenate(Buffer(){0x5a}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 0, Local0, bb10)

		Store(Concatenate(Buffer(){0x5a, 0x00}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 1, Local0, bb11)

		Store(Concatenate(aub0, 0xfe7cb391d650a284), Local0)
		m600(arg0, 2, Local0, bb10)

		Store(Concatenate(aub1, 0xfe7cb391d650a284), Local0)
		m600(arg0, 3, Local0, bb11)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aub0)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 4, Local0, bb10)

			Store(Concatenate(Derefof(Refof(aub1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 5, Local0, bb11)
		}

		Store(Concatenate(Derefof(Index(paub, 0)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 6, Local0, bb10)

		Store(Concatenate(Derefof(Index(paub, 1)), 0xfe7cb391d650a284), Local0)
		m600(arg0, 7, Local0, bb11)

		// Method returns Buffer

		Store(Concatenate(m601(3, 0), 0xfe7cb391d650a284), Local0)
		m600(arg0, 8, Local0, bb10)

		Store(Concatenate(m601(3, 1), 0xfe7cb391d650a284), Local0)
		m600(arg0, 9, Local0, bb11)

		// Method returns Reference to Buffer

		if (y500) {
			Store(Concatenate(Derefof(m602(3, 0, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 10, Local0, bb10)

			Store(Concatenate(Derefof(m602(3, 1, 1)), 0xfe7cb391d650a284), Local0)
			m600(arg0, 11, Local0, bb11)
		}

		Concatenate(Buffer(){0x5a}, 0xfe7cb391d650a284, Local0)
		m600(arg0, 12, Local0, bb10)

		Concatenate(Buffer(){0x5a, 0x00}, 0xfe7cb391d650a284, Local0)
		m600(arg0, 13, Local0, bb11)

		Concatenate(aub0, 0xfe7cb391d650a284, Local0)
		m600(arg0, 14, Local0, bb10)

		Concatenate(aub1, 0xfe7cb391d650a284, Local0)
		m600(arg0, 15, Local0, bb11)

		if (y078) {
			Concatenate(Derefof(Refof(aub0)), 0xfe7cb391d650a284, Local0)
			m600(arg0, 16, Local0, bb10)

			Concatenate(Derefof(Refof(aub1)), 0xfe7cb391d650a284, Local0)
			m600(arg0, 17, Local0, bb11)
		}

		Concatenate(Derefof(Index(paub, 0)), 0xfe7cb391d650a284, Local0)
		m600(arg0, 18, Local0, bb10)

		Concatenate(Derefof(Index(paub, 1)), 0xfe7cb391d650a284, Local0)
		m600(arg0, 19, Local0, bb11)

		// Method returns Buffer

		Concatenate(m601(3, 0), 0xfe7cb391d650a284, Local0)
		m600(arg0, 20, Local0, bb10)

		Concatenate(m601(3, 1), 0xfe7cb391d650a284, Local0)
		m600(arg0, 21, Local0, bb11)

		// Method returns Reference to Buffer

		if (y500) {
			Concatenate(Derefof(m602(3, 0, 1)), 0xfe7cb391d650a284, Local0)
			m600(arg0, 22, Local0, bb10)

			Concatenate(Derefof(m602(3, 1, 1)), 0xfe7cb391d650a284, Local0)
			m600(arg0, 23, Local0, bb11)
		}
	}

	Method(m326, 1)
	{
		
		Store(Concatenate(Buffer(){0x5a}, 0xc179b3fe), Local0)
		m600(arg0, 0, Local0, bb12)

		Store(Concatenate(Buffer(){0x5a, 0x00}, 0xc179b3fe), Local0)
		m600(arg0, 1, Local0, bb13)

		Store(Concatenate(aub0, 0xc179b3fe), Local0)
		m600(arg0, 2, Local0, bb12)

		Store(Concatenate(aub1, 0xc179b3fe), Local0)
		m600(arg0, 3, Local0, bb13)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aub0)), 0xc179b3fe), Local0)
			m600(arg0, 4, Local0, bb12)

			Store(Concatenate(Derefof(Refof(aub1)), 0xc179b3fe), Local0)
			m600(arg0, 5, Local0, bb13)
		}

		Store(Concatenate(Derefof(Index(paub, 0)), 0xc179b3fe), Local0)
		m600(arg0, 6, Local0, bb12)

		Store(Concatenate(Derefof(Index(paub, 1)), 0xc179b3fe), Local0)
		m600(arg0, 7, Local0, bb13)

		// Method returns Buffer

		Store(Concatenate(m601(3, 0), 0xc179b3fe), Local0)
		m600(arg0, 8, Local0, bb12)

		Store(Concatenate(m601(3, 1), 0xc179b3fe), Local0)
		m600(arg0, 9, Local0, bb13)

		// Method returns Reference to Buffer

		if (y500) {
			Store(Concatenate(Derefof(m602(3, 0, 1)), 0xc179b3fe), Local0)
			m600(arg0, 10, Local0, bb12)

			Store(Concatenate(Derefof(m602(3, 1, 1)), 0xc179b3fe), Local0)
			m600(arg0, 11, Local0, bb13)
		}

		Store(Concatenate(Buffer(){0x5a}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 12, Local0, bb14)

		Store(Concatenate(Buffer(){0x5a, 0x00}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 13, Local0, bb15)

		Concatenate(Buffer(){0x5a}, 0xc179b3fe, Local0)
		m600(arg0, 14, Local0, bb12)

		Concatenate(Buffer(){0x5a, 0x00}, 0xc179b3fe, Local0)
		m600(arg0, 15, Local0, bb13)

		Concatenate(aub0, 0xc179b3fe, Local0)
		m600(arg0, 16, Local0, bb12)

		Concatenate(aub1, 0xc179b3fe, Local0)
		m600(arg0, 17, Local0, bb13)

		if (y078) {
			Concatenate(Derefof(Refof(aub0)), 0xc179b3fe, Local0)
			m600(arg0, 18, Local0, bb12)

			Concatenate(Derefof(Refof(aub1)), 0xc179b3fe, Local0)
			m600(arg0, 19, Local0, bb13)
		}

		Concatenate(Derefof(Index(paub, 0)), 0xc179b3fe, Local0)
		m600(arg0, 20, Local0, bb12)

		Concatenate(Derefof(Index(paub, 1)), 0xc179b3fe, Local0)
		m600(arg0, 21, Local0, bb13)

		// Method returns Buffer

		Concatenate(m601(3, 0), 0xc179b3fe, Local0)
		m600(arg0, 22, Local0, bb12)

		Concatenate(m601(3, 1), 0xc179b3fe, Local0)
		m600(arg0, 23, Local0, bb13)

		// Method returns Reference to Buffer

		if (y500) {
			Concatenate(Derefof(m602(3, 0, 1)), 0xc179b3fe, Local0)
			m600(arg0, 24, Local0, bb12)

			Concatenate(Derefof(m602(3, 1, 1)), 0xc179b3fe, Local0)
			m600(arg0, 25, Local0, bb13)
		}

		Concatenate(Buffer(){0x5a}, 0xfe7cb391d650a284, Local0)
		m600(arg0, 26, Local0, bb14)

		Concatenate(Buffer(){0x5a, 0x00}, 0xfe7cb391d650a284, Local0)
		m600(arg0, 27, Local0, bb15)
	}


	// Integer to Buffer conversion of the Integer Source operand of
	// ToString operator

	Method(m647, 1)
	{
		Store(ToString(0x6e7c534136502214, Ones), Local0)
		m600(arg0, 0, Local0, bs18)

		Store(ToString(0x6e7c534136502214, 3), Local0)
		m600(arg0, 1, Local0, bs19)

		Store(ToString(0x6e00534136002214, Ones), Local0)
		m600(arg0, 2, Local0, bs1a)

		Store(ToString(0x6e7c534136502214, aui0), Local0)
		m600(arg0, 3, Local0, bs18)

		Store(ToString(0x6e7c534136502214, aui7), Local0)
		m600(arg0, 4, Local0, bs19)

		Store(ToString(0x6e00534136002214, aui0), Local0)
		m600(arg0, 5, Local0, bs1a)

		if (y078) {
			Store(ToString(0x6e7c534136502214, Derefof(Refof(aui0))), Local0)
			m600(arg0, 6, Local0, bs18)

			Store(ToString(0x6e7c534136502214, Derefof(Refof(aui7))), Local0)
			m600(arg0, 7, Local0, bs19)

			Store(ToString(0x6e00534136002214, Derefof(Refof(aui0))), Local0)
			m600(arg0, 8, Local0, bs1a)
		}

		Store(ToString(0x6e7c534136502214, Derefof(Index(paui, 0))), Local0)
		m600(arg0, 9, Local0, bs18)

		Store(ToString(0x6e7c534136502214, Derefof(Index(paui, 7))), Local0)
		m600(arg0, 10, Local0, bs19)

		Store(ToString(0x6e00534136002214, Derefof(Index(paui, 0))), Local0)
		m600(arg0, 11, Local0, bs1a)

		// Method returns Length parameter

		Store(ToString(0x6e7c534136502214, m601(1, 0)), Local0)
		m600(arg0, 12, Local0, bs18)

		Store(ToString(0x6e7c534136502214, m601(1, 7)), Local0)
		m600(arg0, 13, Local0, bs19)

		Store(ToString(0x6e00534136002214, m601(1, 0)), Local0)
		m600(arg0, 14, Local0, bs1a)

		// Method returns Reference to Length parameter

		if (y500) {
			Store(ToString(0x6e7c534136502214, Derefof(m601(1, 0))), Local0)
			m600(arg0, 15, Local0, bs18)

			Store(ToString(0x6e7c534136502214, Derefof(m601(1, 7))), Local0)
			m600(arg0, 16, Local0, bs19)

			Store(ToString(0x6e00534136002214, Derefof(m601(1, 0))), Local0)
			m600(arg0, 17, Local0, bs1a)
		}

		ToString(0x6e7c534136502214, Ones, Local0)
		m600(arg0, 18, Local0, bs18)

		ToString(0x6e7c534136502214, 3, Local0)
		m600(arg0, 19, Local0, bs19)

		ToString(0x6e00534136002214, Ones, Local0)
		m600(arg0, 20, Local0, bs1a)

		ToString(0x6e7c534136502214, aui0, Local0)
		m600(arg0, 21, Local0, bs18)

		ToString(0x6e7c534136502214, aui7, Local0)
		m600(arg0, 22, Local0, bs19)

		ToString(0x6e00534136002214, aui0, Local0)
		m600(arg0, 23, Local0, bs1a)

		if (y078) {
			ToString(0x6e7c534136502214, Derefof(Refof(aui0)), Local0)
			m600(arg0, 24, Local0, bs18)

			ToString(0x6e7c534136502214, Derefof(Refof(aui7)), Local0)
			m600(arg0, 25, Local0, bs19)

			ToString(0x6e00534136002214, Derefof(Refof(aui0)), Local0)
			m600(arg0, 26, Local0, bs1a)
		}

		ToString(0x6e7c534136502214, Derefof(Index(paui, 0)), Local0)
		m600(arg0, 27, Local0, bs18)

		ToString(0x6e7c534136502214, Derefof(Index(paui, 7)), Local0)
		m600(arg0, 28, Local0, bs19)

		ToString(0x6e00534136002214, Derefof(Index(paui, 0)), Local0)
		m600(arg0, 29, Local0, bs1a)

		// Method returns Length parameter

		ToString(0x6e7c534136502214, m601(1, 0), Local0)
		m600(arg0, 30, Local0, bs18)

		ToString(0x6e7c534136502214, m601(1, 7), Local0)
		m600(arg0, 31, Local0, bs19)

		ToString(0x6e00534136002214, m601(1, 0), Local0)
		m600(arg0, 32, Local0, bs1a)

		// Method returns Reference to Length parameter

		if (y500) {
			ToString(0x6e7c534136502214, Derefof(m601(1, 0)), Local0)
			m600(arg0, 33, Local0, bs18)

			ToString(0x6e7c534136502214, Derefof(m601(1, 7)), Local0)
			m600(arg0, 34, Local0, bs19)

			ToString(0x6e00534136002214, Derefof(m601(1, 0)), Local0)
			m600(arg0, 35, Local0, bs1a)
		}
	}
	
	Method(m327, 1)
	{
		Store(ToString(0x6179534e, Ones), Local0)
		m600(arg0, 0, Local0, bs16)

		Store(ToString(0x6179534e, 3), Local0)
		m600(arg0, 1, Local0, bs17)

		Store(ToString(0x6e7c534136002214, Ones), Local0)
		m600(arg0, 2, Local0, bs1a)

		Store(ToString(0x6179534e, aui0), Local0)
		m600(arg0, 3, Local0, bs16)

		Store(ToString(0x6179534e, aui7), Local0)
		m600(arg0, 4, Local0, bs17)

		Store(ToString(0x6e7c534136002214, aui0), Local0)
		m600(arg0, 5, Local0, bs1a)

		if (y078) {
			Store(ToString(0x6179534e, Derefof(Refof(aui0))), Local0)
			m600(arg0, 6, Local0, bs16)

			Store(ToString(0x6179534e, Derefof(Refof(aui7))), Local0)
			m600(arg0, 7, Local0, bs17)

			Store(ToString(0x6e7c534136002214, Derefof(Refof(aui0))), Local0)
			m600(arg0, 8, Local0, bs1a)
		}

		Store(ToString(0x6179534e, Derefof(Index(paui, 0))), Local0)
		m600(arg0, 9, Local0, bs16)

		Store(ToString(0x6179534e, Derefof(Index(paui, 7))), Local0)
		m600(arg0, 10, Local0, bs17)

		Store(ToString(0x6e7c534136002214, Derefof(Index(paui, 0))), Local0)
		m600(arg0, 11, Local0, bs1a)

		// Method returns Length parameter

		Store(ToString(0x6179534e, m601(1, 0)), Local0)
		m600(arg0, 12, Local0, bs16)

		Store(ToString(0x6179534e, m601(1, 7)), Local0)
		m600(arg0, 13, Local0, bs17)

		Store(ToString(0x6e7c534136002214, m601(1, 0)), Local0)
		m600(arg0, 14, Local0, bs1a)

		// Method returns Reference to Length parameter

		if (y500) {
			Store(ToString(0x6179534e, Derefof(m601(1, 0))), Local0)
			m600(arg0, 15, Local0, bs16)

			Store(ToString(0x6179534e, Derefof(m601(1, 7))), Local0)
			m600(arg0, 16, Local0, bs17)

			Store(ToString(0x6e7c534136002214, Derefof(m601(1, 0))), Local0)
			m600(arg0, 17, Local0, bs1a)
		}

		ToString(0x6179534e, Ones, Local0)
		m600(arg0, 18, Local0, bs16)

		ToString(0x6179534e, 3, Local0)
		m600(arg0, 19, Local0, bs17)

		ToString(0x6e7c534136002214, Ones, Local0)
		m600(arg0, 20, Local0, bs1a)

		ToString(0x6179534e, aui0, Local0)
		m600(arg0, 21, Local0, bs16)

		ToString(0x6179534e, aui7, Local0)
		m600(arg0, 22, Local0, bs17)

		ToString(0x6e7c534136002214, aui0, Local0)
		m600(arg0, 23, Local0, bs1a)

		if (y078) {
			ToString(0x6179534e, Derefof(Refof(aui0)), Local0)
			m600(arg0, 24, Local0, bs16)

			ToString(0x6179534e, Derefof(Refof(aui7)), Local0)
			m600(arg0, 25, Local0, bs17)

			ToString(0x6e7c534136002214, Derefof(Refof(aui0)), Local0)
			m600(arg0, 26, Local0, bs1a)
		}

		ToString(0x6179534e, Derefof(Index(paui, 0)), Local0)
		m600(arg0, 27, Local0, bs16)

		ToString(0x6179534e, Derefof(Index(paui, 7)), Local0)
		m600(arg0, 28, Local0, bs17)

		ToString(0x6e7c534136002214, Derefof(Index(paui, 0)), Local0)
		m600(arg0, 29, Local0, bs1a)

		// Method returns Length parameter

		ToString(0x6179534e, m601(1, 0), Local0)
		m600(arg0, 30, Local0, bs16)

		ToString(0x6179534e, m601(1, 7), Local0)
		m600(arg0, 31, Local0, bs17)

		ToString(0x6e7c534136002214, m601(1, 0), Local0)
		m600(arg0, 32, Local0, bs1a)

		// Method returns Reference to Length parameter

		if (y500) {
			ToString(0x6179534e, Derefof(m601(1, 0)), Local0)
			m600(arg0, 33, Local0, bs16)

			ToString(0x6179534e, Derefof(m601(1, 7)), Local0)
			m600(arg0, 34, Local0, bs17)

			ToString(0x6e7c534136002214, Derefof(m601(1, 0)), Local0)
			m600(arg0, 35, Local0, bs1a)
		}
	}

	// Integer to Buffer conversion of the Integer Source operand of
	// Mid operator

	Method(m648, 1)
	{
		Store(Mid(0xfe7cb391d650a284, 0, 9), Local0)
		m600(arg0, 0, Local0, bb1d)

		Store(Mid(0x6e7c534136002214, 1, 8), Local0)
		m600(arg0, 1, Local0, bb30)

		Store(Mid(0xfe7cb391d650a284, aui5, auib), Local0)
		m600(arg0, 2, Local0, bb1d)

		Store(Mid(0x6e7c534136002214, aui6, auia), Local0)
		m600(arg0, 3, Local0, bb30)

		if (y078) {
			Store(Mid(0xfe7cb391d650a284, Derefof(Refof(aui5)), Derefof(Refof(auib))), Local0)
			m600(arg0, 4, Local0, bb1d)

			Store(Mid(0x6e7c534136002214, Derefof(Refof(aui6)), Derefof(Refof(auia))), Local0)
			m600(arg0, 5, Local0, bb30)
		}

		Store(Mid(0xfe7cb391d650a284, Derefof(Index(paui, 5)), Derefof(Index(paui, 11))), Local0)
		m600(arg0, 6, Local0, bb1d)

		Store(Mid(0x6e7c534136002214, Derefof(Index(paui, 6)), Derefof(Index(paui, 10))), Local0)
		m600(arg0, 7, Local0, bb30)

		// Method returns Index and Length parameters

		Store(Mid(0xfe7cb391d650a284, m601(1, 5), m601(1, 11)), Local0)
		m600(arg0, 8, Local0, bb1d)

		Store(Mid(0x6e7c534136002214, m601(1, 6), m601(1, 10)), Local0)
		m600(arg0, 9, Local0, bb30)

		// Method returns Reference to Index and Length parameters

		if (y500) {
			Store(Mid(0xfe7cb391d650a284, Derefof(m601(1, 5)), Derefof(m601(1, 11))), Local0)
			m600(arg0, 10, Local0, bb1d)

			Store(Mid(0x6e7c534136002214, Derefof(m601(1, 6)), Derefof(m601(1, 10))), Local0)
			m600(arg0, 11, Local0, bb30)
		}

		Mid(0xfe7cb391d650a284, 0, 9, Local0)
		m600(arg0, 12, Local0, bb1d)

		Mid(0x6e7c534136002214, 1, 8, Local0)
		m600(arg0, 13, Local0, bb30)

		Mid(0xfe7cb391d650a284, aui5, auib, Local0)
		m600(arg0, 14, Local0, bb1d)

		Mid(0x6e7c534136002214, aui6, auia, Local0)
		m600(arg0, 15, Local0, bb30)

		if (y078) {
			Mid(0xfe7cb391d650a284, Derefof(Refof(aui5)), Derefof(Refof(auib)), Local0)
			m600(arg0, 16, Local0, bb1d)

			Mid(0x6e7c534136002214, Derefof(Refof(aui6)), Derefof(Refof(auia)), Local0)
			m600(arg0, 17, Local0, bb30)
		}

		Mid(0xfe7cb391d650a284, Derefof(Index(paui, 5)), Derefof(Index(paui, 11)), Local0)
		m600(arg0, 18, Local0, bb1d)

		Mid(0x6e7c534136002214, Derefof(Index(paui, 6)), Derefof(Index(paui, 10)), Local0)
		m600(arg0, 19, Local0, bb30)

		// Method returns Index and Length parameters

		Mid(0xfe7cb391d650a284, m601(1, 5), m601(1, 11), Local0)
		m600(arg0, 20, Local0, bb1d)

		Mid(0x6e7c534136002214, m601(1, 6), m601(1, 10), Local0)
		m600(arg0, 21, Local0, bb30)

		// Method returns Reference to Index and Length parameters

		if (y500) {
			Mid(0xfe7cb391d650a284, Derefof(m601(1, 5)), Derefof(m601(1, 11)), Local0)
			m600(arg0, 22, Local0, bb1d)

			Mid(0x6e7c534136002214, Derefof(m601(1, 6)), Derefof(m601(1, 10)), Local0)
			m600(arg0, 23, Local0, bb30)
		}
	}

	Method(m328, 1)
	{
		Store(Mid(0xc179b3fe, 0, 5), Local0)
		m600(arg0, 0, Local0, bb1c)

		Store(Mid(0x6e7c534136002214, 1, 4), Local0)
		m600(arg0, 1, Local0, bb31)

		Store(Mid(0xc179b3fe, aui5, aui9), Local0)
		m600(arg0, 2, Local0, bb1c)

		Store(Mid(0x6e7c534136002214, aui6, aui8), Local0)
		m600(arg0, 3, Local0, bb31)

		if (y078) {
			Store(Mid(0xc179b3fe, Derefof(Refof(aui5)), Derefof(Refof(aui9))), Local0)
			m600(arg0, 4, Local0, bb1c)

			Store(Mid(0x6e7c534136002214, Derefof(Refof(aui6)), Derefof(Refof(aui8))), Local0)
			m600(arg0, 5, Local0, bb31)
		}

		Store(Mid(0xc179b3fe, Derefof(Index(paui, 5)), Derefof(Index(paui, 9))), Local0)
		m600(arg0, 6, Local0, bb1c)

		Store(Mid(0x6e7c534136002214, Derefof(Index(paui, 6)), Derefof(Index(paui, 8))), Local0)
		m600(arg0, 7, Local0, bb31)

		// Method returns Index and Length parameters

		Store(Mid(0xc179b3fe, m601(1, 5), m601(1, 9)), Local0)
		m600(arg0, 8, Local0, bb1c)

		Store(Mid(0x6e7c534136002214, m601(1, 6), m601(1, 8)), Local0)
		m600(arg0, 9, Local0, bb31)

		// Method returns Reference to Index and Length parameters

		if (y500) {
			Store(Mid(0xc179b3fe, Derefof(m601(1, 5)), Derefof(m601(1, 9))), Local0)
			m600(arg0, 10, Local0, bb1c)

			Store(Mid(0x6e7c534136002214, Derefof(m601(1, 6)), Derefof(m601(1, 8))), Local0)
			m600(arg0, 11, Local0, bb31)
		}

		Mid(0xc179b3fe, 0, 5, Local0)
		m600(arg0, 12, Local0, bb1c)

		Mid(0x6e7c534136002214, 1, 4, Local0)
		m600(arg0, 13, Local0, bb31)

		Mid(0xc179b3fe, aui5, aui9, Local0)
		m600(arg0, 14, Local0, bb1c)

		Mid(0x6e7c534136002214, aui6, aui8, Local0)
		m600(arg0, 15, Local0, bb31)

		if (y078) {
			Mid(0xc179b3fe, Derefof(Refof(aui5)), Derefof(Refof(aui9)), Local0)
			m600(arg0, 16, Local0, bb1c)

			Mid(0x6e7c534136002214, Derefof(Refof(aui6)), Derefof(Refof(aui8)), Local0)
			m600(arg0, 17, Local0, bb31)
		}

		Mid(0xc179b3fe, Derefof(Index(paui, 5)), Derefof(Index(paui, 9)), Local0)
		m600(arg0, 18, Local0, bb1c)

		Mid(0x6e7c534136002214, Derefof(Index(paui, 6)), Derefof(Index(paui, 8)), Local0)
		m600(arg0, 19, Local0, bb31)

		// Method returns Index and Length parameters

		Mid(0xc179b3fe, m601(1, 5), m601(1, 9), Local0)
		m600(arg0, 20, Local0, bb1c)

		Mid(0x6e7c534136002214, m601(1, 6), m601(1, 8), Local0)
		m600(arg0, 21, Local0, bb31)

		// Method returns Reference to Index and Length parameters

		if (y500) {
			Mid(0xc179b3fe, Derefof(m601(1, 5)), Derefof(m601(1, 9)), Local0)
			m600(arg0, 22, Local0, bb1c)

			Mid(0x6e7c534136002214, Derefof(m601(1, 6)), Derefof(m601(1, 8)), Local0)
			m600(arg0, 23, Local0, bb31)
		}
	}

	// Integer to Buffer conversion of the Integer elements of
	// a search package of Match operator when some MatchObject
	// is evaluated as Buffer

	Method(m649, 1)
	{
		Store(Match(Package(){0xfe7cb391d650a284},
			MEQ, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, MTR, 0, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Match(Package(){0xfe7cb391d650a284},
			MEQ, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, MTR, 0, 0), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(Package(){0xfe7cb391d650a284},
			MTR, 0, MEQ, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, 0), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Match(Package(){0xfe7cb391d650a284},
			MTR, 0, MEQ, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, 0), Local0)
		m600(arg0, 3, Local0, Ones)
	}

	Method(m329, 1)
	{
		Store(Match(Package(){0xc179b3fe},
			MEQ, Buffer() {0xFE, 0xB3, 0x79, 0xC1}, MTR, 0, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Match(Package(){0xc179b3fe},
			MEQ, Buffer() {0xFE, 0xB3, 0x79, 0xC0}, MTR, 0, 0), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(Package(){0xc179b3fe},
			MTR, 0, MEQ, Buffer() {0xFE, 0xB3, 0x79, 0xC1}, 0), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Match(Package(){0xc179b3fe},
			MTR, 0, MEQ, Buffer() {0xFE, 0xB3, 0x79, 0xC0}, 0), Local0)
		m600(arg0, 3, Local0, Ones)
	}

	// Integer to Buffer conversion of the Integer value of
	// Expression of Case statement when Expression in Switch
	// is either static Buffer data or explicitly converted to
	// Buffer by ToBuffer

	Method(m64a, 1, Serialized)
	{
		Name(i000, 0)

		Store(0, i000)
		Switch (Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 0, i000, 2)

		Store(0, i000)
		Switch (Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 1, i000, 1)

		Store(0, i000)
		Switch (ToBuffer(aub5)) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 2, i000, 2)

		Store(0, i000)
		Switch (ToBuffer(aub4)) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 3, i000, 1)

		if (y078) {
			Store(0, i000)
			Switch (ToBuffer(Derefof(Refof(aub5)))) {
				Case (0xfe7cb391d650a284) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 4, i000, 2)

			Store(0, i000)
			Switch (ToBuffer(Derefof(Refof(aub4)))) {
				Case (0xfe7cb391d650a284) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 5, i000, 1)
		}

		Store(0, i000)
		Switch (ToBuffer(Derefof(Index(paub, 5)))) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 6, i000, 2)

		Store(0, i000)
		Switch (ToBuffer(Derefof(Index(paub, 4)))) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 7, i000, 1)

		// Method returns String

		Store(0, i000)
		Switch (ToBuffer(m601(3, 5))) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 8, i000, 2)

		Store(0, i000)
		Switch (ToBuffer(m601(3, 4))) {
			Case (0xfe7cb391d650a284) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 9, i000, 1)

		// Method returns Reference to String

		if (y500) {
			Store(0, i000)
			Switch (ToBuffer(Derefof(m602(3, 5, 1)))) {
				Case (0xfe7cb391d650a284) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 10, i000, 2)

			Store(0, i000)
			Switch (ToBuffer(Derefof(m602(3, 4, 1)))) {
				Case (0xfe7cb391d650a284) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 11, i000, 1)
		}
	}

	Method(m32a, 1, Serialized)
	{
		Name(i000, 0)

		Store(0, i000)
		Switch (Buffer() {0xFE, 0xB3, 0x79, 0xC2}) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 0, i000, 2)

		Store(0, i000)
		Switch (Buffer() {0xFE, 0xB3, 0x79, 0xC1}) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 1, i000, 1)

		Store(0, i000)
		Switch (ToBuffer(aub2)) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 2, i000, 2)

		Store(0, i000)
		Switch (ToBuffer(aub3)) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 3, i000, 1)

		if (y078) {
			Store(0, i000)
			Switch (ToBuffer(Derefof(Refof(aub2)))) {
				Case (0xc179b3fe) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 4, i000, 2)

			Store(0, i000)
			Switch (ToBuffer(Derefof(Refof(aub3)))) {
				Case (0xc179b3fe) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 5, i000, 1)
		}

		Store(0, i000)
		Switch (ToBuffer(Derefof(Index(paub, 2)))) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 6, i000, 2)

		Store(0, i000)
		Switch (ToBuffer(Derefof(Index(paub, 3)))) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 7, i000, 1)

		// Method returns String

		Store(0, i000)
		Switch (ToBuffer(m601(3, 2))) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 8, i000, 2)

		Store(0, i000)
		Switch (ToBuffer(m601(3, 3))) {
			Case (0xc179b3fe) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 9, i000, 1)

		// Method returns Reference to String

		if (y500) {
			Store(0, i000)
			Switch (ToBuffer(Derefof(m602(3, 2, 1)))) {
				Case (0xc179b3fe) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 10, i000, 2)

			Store(0, i000)
			Switch (ToBuffer(Derefof(m602(3, 3, 1)))) {
				Case (0xc179b3fe) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 11, i000, 1)
		}
	}

	// String to Integer implicit conversion Cases.

	// String to Integer conversion of the String sole operand
	// of the 1-parameter Integer arithmetic operators
	// (Decrement, Increment, FindSetLeftBit, FindSetRightBit, Not)

	Method(m64b, 1)
	{
		// Decrement

		// Increment

		// FindSetLeftBit

		Store(FindSetLeftBit("0321"), Local0)
		m600(arg0, 0, Local0, 10)

		Store(FindSetLeftBit("FE7CB391D650A284"), Local0)
		m600(arg0, 1, Local0, 64)

		// FindSetRightBit

		Store(FindSetRightBit("0321"), Local0)
		m600(arg0, 2, Local0, 1)

		Store(FindSetRightBit("FE7CB391D650A284"), Local0)
		m600(arg0, 3, Local0, 3)

		// Not

		Store(Not("0321"), Local0)
		m600(arg0, 4, Local0, 0xfffffffffffffcde)

		Store(Not("FE7CB391D650A284"), Local0)
		m600(arg0, 5, Local0, 0x01834c6e29af5d7b)
	}

	Method(m32b, 1)
	{
		// Decrement

		// Increment

		// FindSetLeftBit

		Store(FindSetLeftBit("0321"), Local0)
		m600(arg0, 0, Local0, 10)

		Store(FindSetLeftBit("C179B3FE"), Local0)
		m600(arg0, 1, Local0, 32)

		// FindSetRightBit

		Store(FindSetRightBit("0321"), Local0)
		m600(arg0, 2, Local0, 1)

		Store(FindSetRightBit("C179B3FE"), Local0)
		m600(arg0, 3, Local0, 2)

		// Not

		Store(Not("0321"), Local0)
		m600(arg0, 4, Local0, 0xfffffcde)

		Store(Not("C179B3FE"), Local0)
		m600(arg0, 5, Local0, 0x3e864c01)
	}

	// String to Integer conversion of the String sole operand
	// of the LNot Logical Integer operator
	Method(m000, 1)
	{
		Store(LNot("0"), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LNot("0321"), Local0)
		m600(arg0, 1, Local0, Zero)

		if (F64) {
			Store(LNot("FE7CB391D650A284"), Local0)
			m600(arg0, 2, Local0, Zero)
		} else {
			Store(LNot("C179B3FE"), Local0)
			m600(arg0, 3, Local0, Zero)
		}
	}

	// String to Integer conversion of the String sole operand
	// of the FromBCD and ToBCD conversion operators

	Method(m64c, 1)
	{
		// FromBCD

		Store(FromBCD("0321"), Local0)
		m600(arg0, 2, Local0, 0x141)

		Store(FromBCD("3789012345678901"), Local0)
		m600(arg0, 3, Local0, 0xd76162ee9ec35)

		FromBCD("0321", Local0)
		m600(arg0, 2, Local0, 0x141)

		FromBCD("3789012345678901", Local0)
		m600(arg0, 3, Local0, 0xd76162ee9ec35)

		// ToBCD

		Store(ToBCD("0321"), Local0)
		m600(arg0, 4, Local0, 0x801)

/* Error of iASL on constant folding
		Store(ToBCD("D76162EE9EC35"), Local0)
		m600(arg0, 5, Local0, 0x3789012345678901)
*/

		ToBCD("0321", Local0)
		m600(arg0, 4, Local0, 0x801)

		ToBCD("D76162EE9EC35", Local0)
		m600(arg0, 5, Local0, 0x3789012345678901)
	}

	Method(m32c, 1)
	{
		// FromBCD

		Store(FromBCD("0321"), Local0)
		m600(arg0, 2, Local0, 0x141)

		Store(FromBCD("90123456"), Local0)
		m600(arg0, 3, Local0, 0x55f2cc0)

		FromBCD("0321", Local0)
		m600(arg0, 2, Local0, 0x141)

		FromBCD("90123456", Local0)
		m600(arg0, 3, Local0, 0x55f2cc0)

		// ToBCD

		Store(ToBCD("0321"), Local0)
		m600(arg0, 4, Local0, 0x801)

		Store(ToBCD("55F2CC0"), Local0)
		m600(arg0, 5, Local0, 0x90123456)

		ToBCD("0321", Local0)
		m600(arg0, 4, Local0, 0x801)

		ToBCD("55F2CC0", Local0)
		m600(arg0, 5, Local0, 0x90123456)
	}

	// String to Integer conversion of each String operand
	// of the 2-parameter Integer arithmetic operators
	// Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
	// ShiftLeft, ShiftRight, Subtract, Xor

	// Add, common 32-bit/64-bit test
	Method(m001, 1)
	{
		// Conversion of the first operand

		Store(Add("0321", 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Add("0321", 1), Local0)
		m600(arg0, 1, Local0, 0x322)

		Store(Add("0321", aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Add("0321", aui6), Local0)
		m600(arg0, 3, Local0, 0x322)

		if (y078) {
			Store(Add("0321", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Add("0321", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x322)
		}

		Store(Add("0321", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Add("0321", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x322)

		// Method returns Integer

		Store(Add("0321", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Add("0321", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add("0321", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Add("0321", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x322)
		}

		Add("0321", 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Add("0321", 1, Local0)
		m600(arg0, 13, Local0, 0x322)

		Add("0321", aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Add("0321", aui6, Local0)
		m600(arg0, 15, Local0, 0x322)

		if (y078) {
			Add("0321", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Add("0321", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x322)
		}

		Add("0321", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Add("0321", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x322)

		// Method returns Integer

		Add("0321", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Add("0321", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Add("0321", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Add("0321", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x322)
		}

		// Conversion of the second operand

		Store(Add(0, "0321"), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(Add(1, "0321"), Local0)
		m600(arg0, 25, Local0, 0x322)

		Store(Add(aui5, "0321"), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(Add(aui6, "0321"), Local0)
		m600(arg0, 27, Local0, 0x322)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), "0321"), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(Add(Derefof(Refof(aui6)), "0321"), Local0)
			m600(arg0, 29, Local0, 0x322)
		}

		Store(Add(Derefof(Index(paui, 5)), "0321"), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(Add(Derefof(Index(paui, 6)), "0321"), Local0)
		m600(arg0, 31, Local0, 0x322)

		// Method returns Integer

		Store(Add(m601(1, 5), "0321"), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(Add(m601(1, 6), "0321"), Local0)
		m600(arg0, 33, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), "0321"), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(Add(Derefof(m602(1, 6, 1)), "0321"), Local0)
			m600(arg0, 35, Local0, 0x322)
		}

		Add(0, "0321", Local0)
		m600(arg0, 36, Local0, 0x321)

		Add(1, "0321", Local0)
		m600(arg0, 37, Local0, 0x322)

		Add(aui5, "0321", Local0)
		m600(arg0, 38, Local0, 0x321)

		Add(aui6, "0321", Local0)
		m600(arg0, 39, Local0, 0x322)

		if (y078) {
			Add(Derefof(Refof(aui5)), "0321", Local0)
			m600(arg0, 40, Local0, 0x321)

			Add(Derefof(Refof(aui6)), "0321", Local0)
			m600(arg0, 41, Local0, 0x322)
		}

		Add(Derefof(Index(paui, 5)), "0321", Local0)
		m600(arg0, 42, Local0, 0x321)

		Add(Derefof(Index(paui, 6)), "0321", Local0)
		m600(arg0, 43, Local0, 0x322)

		// Method returns Integer

		Add(m601(1, 5), "0321", Local0)
		m600(arg0, 44, Local0, 0x321)

		Add(m601(1, 6), "0321", Local0)
		m600(arg0, 45, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), "0321", Local0)
			m600(arg0, 46, Local0, 0x321)

			Add(Derefof(m602(1, 6, 1)), "0321", Local0)
			m600(arg0, 47, Local0, 0x322)
		}
	}

	// Add, 64-bit
	Method(m002, 1)
	{
		// Conversion of the first operand

		Store(Add("FE7CB391D650A284", 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Add("FE7CB391D650A284", 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a285)

		Store(Add("FE7CB391D650A284", aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Add("FE7CB391D650A284", aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Store(Add("FE7CB391D650A284", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Add("FE7CB391D650A284", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a285)
		}

		Store(Add("FE7CB391D650A284", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Add("FE7CB391D650A284", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Store(Add("FE7CB391D650A284", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Add("FE7CB391D650A284", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add("FE7CB391D650A284", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Add("FE7CB391D650A284", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a285)
		}

		Add("FE7CB391D650A284", 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Add("FE7CB391D650A284", 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a285)

		Add("FE7CB391D650A284", aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Add("FE7CB391D650A284", aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Add("FE7CB391D650A284", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Add("FE7CB391D650A284", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a285)
		}

		Add("FE7CB391D650A284", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Add("FE7CB391D650A284", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Add("FE7CB391D650A284", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Add("FE7CB391D650A284", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add("FE7CB391D650A284", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Add("FE7CB391D650A284", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a285)
		}

		// Conversion of the second operand

		Store(Add(0, "FE7CB391D650A284"), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(Add(1, "FE7CB391D650A284"), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a285)

		Store(Add(aui5, "FE7CB391D650A284"), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(Add(aui6, "FE7CB391D650A284"), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), "FE7CB391D650A284"), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(Add(Derefof(Refof(aui6)), "FE7CB391D650A284"), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a285)
		}

		Store(Add(Derefof(Index(paui, 5)), "FE7CB391D650A284"), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(Add(Derefof(Index(paui, 6)), "FE7CB391D650A284"), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Store(Add(m601(1, 5), "FE7CB391D650A284"), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(Add(m601(1, 6), "FE7CB391D650A284"), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(Add(Derefof(m602(1, 6, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a285)
		}

		Add(0, "FE7CB391D650A284", Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		Add(1, "FE7CB391D650A284", Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a285)

		Add(aui5, "FE7CB391D650A284", Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		Add(aui6, "FE7CB391D650A284", Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Add(Derefof(Refof(aui5)), "FE7CB391D650A284", Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			Add(Derefof(Refof(aui6)), "FE7CB391D650A284", Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a285)
		}

		Add(Derefof(Index(paui, 5)), "FE7CB391D650A284", Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		Add(Derefof(Index(paui, 6)), "FE7CB391D650A284", Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Add(m601(1, 5), "FE7CB391D650A284", Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		Add(m601(1, 6), "FE7CB391D650A284", Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			Add(Derefof(m602(1, 6, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a285)
		}

		// Conversion of the both operands

		Store(Add("0321", "FE7CB391D650A284"), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a5a5)

		Store(Add("FE7CB391D650A284", "0321"), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a5a5)

		Add("0321", "FE7CB391D650A284", Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a5a5)

		Add("FE7CB391D650A284", "0321", Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a5a5)
	}

	// Add, 32-bit
	Method(m003, 1)
	{
		// Conversion of the first operand

		Store(Add("C179B3FE", 0), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(Add("C179B3FE", 1), Local0)
		m600(arg0, 1, Local0, 0xc179b3ff)

		Store(Add("C179B3FE", aui5), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(Add("C179B3FE", aui6), Local0)
		m600(arg0, 3, Local0, 0xc179b3ff)

		if (y078) {
			Store(Add("C179B3FE", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(Add("C179B3FE", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xc179b3ff)
		}

		Store(Add("C179B3FE", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(Add("C179B3FE", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xc179b3ff)

		// Method returns Integer

		Store(Add("C179B3FE", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(Add("C179B3FE", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xc179b3ff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add("C179B3FE", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(Add("C179B3FE", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xc179b3ff)
		}

		Add("C179B3FE", 0, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		Add("C179B3FE", 1, Local0)
		m600(arg0, 13, Local0, 0xc179b3ff)

		Add("C179B3FE", aui5, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		Add("C179B3FE", aui6, Local0)
		m600(arg0, 15, Local0, 0xc179b3ff)

		if (y078) {
			Add("C179B3FE", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			Add("C179B3FE", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xc179b3ff)
		}

		Add("C179B3FE", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		Add("C179B3FE", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xc179b3ff)

		// Method returns Integer

		Add("C179B3FE", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		Add("C179B3FE", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xc179b3ff)

		// Method returns Reference to Integer

		if (y500) {
			Add("C179B3FE", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			Add("C179B3FE", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xc179b3ff)
		}

		// Conversion of the second operand

		Store(Add(0, "C179B3FE"), Local0)
		m600(arg0, 24, Local0, 0xc179b3fe)

		Store(Add(1, "C179B3FE"), Local0)
		m600(arg0, 25, Local0, 0xc179b3ff)

		Store(Add(aui5, "C179B3FE"), Local0)
		m600(arg0, 26, Local0, 0xc179b3fe)

		Store(Add(aui6, "C179B3FE"), Local0)
		m600(arg0, 27, Local0, 0xc179b3ff)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), "C179B3FE"), Local0)
			m600(arg0, 28, Local0, 0xc179b3fe)

			Store(Add(Derefof(Refof(aui6)), "C179B3FE"), Local0)
			m600(arg0, 29, Local0, 0xc179b3ff)
		}

		Store(Add(Derefof(Index(paui, 5)), "C179B3FE"), Local0)
		m600(arg0, 30, Local0, 0xc179b3fe)

		Store(Add(Derefof(Index(paui, 6)), "C179B3FE"), Local0)
		m600(arg0, 31, Local0, 0xc179b3ff)

		// Method returns Integer

		Store(Add(m601(1, 5), "C179B3FE"), Local0)
		m600(arg0, 32, Local0, 0xc179b3fe)

		Store(Add(m601(1, 6), "C179B3FE"), Local0)
		m600(arg0, 33, Local0, 0xc179b3ff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), "C179B3FE"), Local0)
			m600(arg0, 34, Local0, 0xc179b3fe)

			Store(Add(Derefof(m602(1, 6, 1)), "C179B3FE"), Local0)
			m600(arg0, 35, Local0, 0xc179b3ff)
		}

		Add(0, "C179B3FE", Local0)
		m600(arg0, 36, Local0, 0xc179b3fe)

		Add(1, "C179B3FE", Local0)
		m600(arg0, 37, Local0, 0xc179b3ff)

		Add(aui5, "C179B3FE", Local0)
		m600(arg0, 38, Local0, 0xc179b3fe)

		Add(aui6, "C179B3FE", Local0)
		m600(arg0, 39, Local0, 0xc179b3ff)

		if (y078) {
			Add(Derefof(Refof(aui5)), "C179B3FE", Local0)
			m600(arg0, 40, Local0, 0xc179b3fe)

			Add(Derefof(Refof(aui6)), "C179B3FE", Local0)
			m600(arg0, 41, Local0, 0xc179b3ff)
		}

		Add(Derefof(Index(paui, 5)), "C179B3FE", Local0)
		m600(arg0, 42, Local0, 0xc179b3fe)

		Add(Derefof(Index(paui, 6)), "C179B3FE", Local0)
		m600(arg0, 43, Local0, 0xc179b3ff)

		// Method returns Integer

		Add(m601(1, 5), "C179B3FE", Local0)
		m600(arg0, 44, Local0, 0xc179b3fe)

		Add(m601(1, 6), "C179B3FE", Local0)
		m600(arg0, 45, Local0, 0xc179b3ff)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), "C179B3FE", Local0)
			m600(arg0, 46, Local0, 0xc179b3fe)

			Add(Derefof(m602(1, 6, 1)), "C179B3FE", Local0)
			m600(arg0, 47, Local0, 0xc179b3ff)
		}

		// Conversion of the both operands

		Store(Add("0321", "C179B3FE"), Local0)
		m600(arg0, 48, Local0, 0xc179b71f)

		Store(Add("C179B3FE", "0321"), Local0)
		m600(arg0, 49, Local0, 0xc179b71f)

		Add("0321", "C179B3FE", Local0)
		m600(arg0, 50, Local0, 0xc179b71f)

		Add("C179B3FE", "0321", Local0)
		m600(arg0, 51, Local0, 0xc179b71f)
	}

	// And, common 32-bit/64-bit test
	Method(m004, 1)
	{
		// Conversion of the first operand

		Store(And("0321", 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And("0321", 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x321)

		Store(And("0321", aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And("0321", auij), Local0)
		m600(arg0, 3, Local0, 0x321)

		if (y078) {
			Store(And("0321", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And("0321", Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x321)
		}

		Store(And("0321", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And("0321", Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x321)

		// Method returns Integer

		Store(And("0321", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And("0321", m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(And("0321", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And("0321", Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x321)
		}

		And("0321", 0, Local0)
		m600(arg0, 12, Local0, 0)

		And("0321", 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x321)

		And("0321", aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And("0321", auij, Local0)
		m600(arg0, 15, Local0, 0x321)

		if (y078) {
			And("0321", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And("0321", Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x321)
		}

		And("0321", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And("0321", Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x321)

		// Method returns Integer

		And("0321", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And("0321", m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			And("0321", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And("0321", Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x321)
		}

		// Conversion of the second operand

		Store(And(0, "0321"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffffffffffff, "0321"), Local0)
		m600(arg0, 25, Local0, 0x321)

		Store(And(aui5, "0321"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auij, "0321"), Local0)
		m600(arg0, 27, Local0, 0x321)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), "0321"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auij)), "0321"), Local0)
			m600(arg0, 29, Local0, 0x321)
		}

		Store(And(Derefof(Index(paui, 5)), "0321"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 19)), "0321"), Local0)
		m600(arg0, 31, Local0, 0x321)

		// Method returns Integer

		Store(And(m601(1, 5), "0321"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 19), "0321"), Local0)
		m600(arg0, 33, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), "0321"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 19, 1)), "0321"), Local0)
			m600(arg0, 35, Local0, 0x321)
		}

		And(0, "0321", Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffffffffffff, "0321", Local0)
		m600(arg0, 37, Local0, 0x321)

		And(aui5, "0321", Local0)
		m600(arg0, 38, Local0, 0)

		And(auij, "0321", Local0)
		m600(arg0, 39, Local0, 0x321)

		if (y078) {
			And(Derefof(Refof(aui5)), "0321", Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auij)), "0321", Local0)
			m600(arg0, 41, Local0, 0x321)
		}

		And(Derefof(Index(paui, 5)), "0321", Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 19)), "0321", Local0)
		m600(arg0, 43, Local0, 0x321)

		// Method returns Integer

		And(m601(1, 5), "0321", Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 19), "0321", Local0)
		m600(arg0, 45, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), "0321", Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 19, 1)), "0321", Local0)
			m600(arg0, 47, Local0, 0x321)
		}
	}

	// And, 64-bit
	Method(m005, 1)
	{
		// Conversion of the first operand

		Store(And("FE7CB391D650A284", 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And("FE7CB391D650A284", 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a284)

		Store(And("FE7CB391D650A284", aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And("FE7CB391D650A284", auij), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(And("FE7CB391D650A284", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And("FE7CB391D650A284", Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a284)
		}

		Store(And("FE7CB391D650A284", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And("FE7CB391D650A284", Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(And("FE7CB391D650A284", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And("FE7CB391D650A284", m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And("FE7CB391D650A284", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And("FE7CB391D650A284", Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a284)
		}

		And("FE7CB391D650A284", 0, Local0)
		m600(arg0, 12, Local0, 0)

		And("FE7CB391D650A284", 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		And("FE7CB391D650A284", aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And("FE7CB391D650A284", auij, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a284)

		if (y078) {
			And("FE7CB391D650A284", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And("FE7CB391D650A284", Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a284)
		}

		And("FE7CB391D650A284", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And("FE7CB391D650A284", Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		And("FE7CB391D650A284", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And("FE7CB391D650A284", m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			And("FE7CB391D650A284", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And("FE7CB391D650A284", Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the second operand

		Store(And(0, "FE7CB391D650A284"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffffffffffff, "FE7CB391D650A284"), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a284)

		Store(And(aui5, "FE7CB391D650A284"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auij, "FE7CB391D650A284"), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), "FE7CB391D650A284"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auij)), "FE7CB391D650A284"), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a284)
		}

		Store(And(Derefof(Index(paui, 5)), "FE7CB391D650A284"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 19)), "FE7CB391D650A284"), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(And(m601(1, 5), "FE7CB391D650A284"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 19), "FE7CB391D650A284"), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 19, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a284)
		}

		And(0, "FE7CB391D650A284", Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffffffffffff, "FE7CB391D650A284", Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a284)

		And(aui5, "FE7CB391D650A284", Local0)
		m600(arg0, 38, Local0, 0)

		And(auij, "FE7CB391D650A284", Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a284)

		if (y078) {
			And(Derefof(Refof(aui5)), "FE7CB391D650A284", Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auij)), "FE7CB391D650A284", Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a284)
		}

		And(Derefof(Index(paui, 5)), "FE7CB391D650A284", Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 19)), "FE7CB391D650A284", Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		And(m601(1, 5), "FE7CB391D650A284", Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 19), "FE7CB391D650A284", Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 19, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the both operands

		Store(And("0321", "FE7CB391D650A284"), Local0)
		m600(arg0, 48, Local0, 0x200)

		Store(And("FE7CB391D650A284", "0321"), Local0)
		m600(arg0, 49, Local0, 0x200)

		And("0321", "FE7CB391D650A284", Local0)
		m600(arg0, 50, Local0, 0x200)

		And("FE7CB391D650A284", "0321", Local0)
		m600(arg0, 51, Local0, 0x200)
	}

	// And, 32-bit
	Method(m006, 1)
	{
		// Conversion of the first operand

		Store(And("C179B3FE", 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And("C179B3FE", 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0xc179b3fe)

		Store(And("C179B3FE", aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And("C179B3FE", auii), Local0)
		m600(arg0, 3, Local0, 0xc179b3fe)

		if (y078) {
			Store(And("C179B3FE", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And("C179B3FE", Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0xc179b3fe)
		}

		Store(And("C179B3FE", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And("C179B3FE", Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0xc179b3fe)

		// Method returns Integer

		Store(And("C179B3FE", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And("C179B3FE", m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			Store(And("C179B3FE", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And("C179B3FE", Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0xc179b3fe)
		}

		And("C179B3FE", 0, Local0)
		m600(arg0, 12, Local0, 0)

		And("C179B3FE", 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0xc179b3fe)

		And("C179B3FE", aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And("C179B3FE", auii, Local0)
		m600(arg0, 15, Local0, 0xc179b3fe)

		if (y078) {
			And("C179B3FE", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And("C179B3FE", Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0xc179b3fe)
		}

		And("C179B3FE", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And("C179B3FE", Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0xc179b3fe)

		// Method returns Integer

		And("C179B3FE", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And("C179B3FE", m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			And("C179B3FE", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And("C179B3FE", Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0xc179b3fe)
		}

		// Conversion of the second operand

		Store(And(0, "C179B3FE"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffff, "C179B3FE"), Local0)
		m600(arg0, 25, Local0, 0xc179b3fe)

		Store(And(aui5, "C179B3FE"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auii, "C179B3FE"), Local0)
		m600(arg0, 27, Local0, 0xc179b3fe)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), "C179B3FE"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auii)), "C179B3FE"), Local0)
			m600(arg0, 29, Local0, 0xc179b3fe)
		}

		Store(And(Derefof(Index(paui, 5)), "C179B3FE"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 18)), "C179B3FE"), Local0)
		m600(arg0, 31, Local0, 0xc179b3fe)

		// Method returns Integer

		Store(And(m601(1, 5), "C179B3FE"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 18), "C179B3FE"), Local0)
		m600(arg0, 33, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), "C179B3FE"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 18, 1)), "C179B3FE"), Local0)
			m600(arg0, 35, Local0, 0xc179b3fe)
		}

		And(0, "C179B3FE", Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffff, "C179B3FE", Local0)
		m600(arg0, 37, Local0, 0xc179b3fe)

		And(aui5, "C179B3FE", Local0)
		m600(arg0, 38, Local0, 0)

		And(auii, "C179B3FE", Local0)
		m600(arg0, 39, Local0, 0xc179b3fe)

		if (y078) {
			And(Derefof(Refof(aui5)), "C179B3FE", Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auii)), "C179B3FE", Local0)
			m600(arg0, 41, Local0, 0xc179b3fe)
		}

		And(Derefof(Index(paui, 5)), "C179B3FE", Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 18)), "C179B3FE", Local0)
		m600(arg0, 43, Local0, 0xc179b3fe)

		// Method returns Integer

		And(m601(1, 5), "C179B3FE", Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 18), "C179B3FE", Local0)
		m600(arg0, 45, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), "C179B3FE", Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 18, 1)), "C179B3FE", Local0)
			m600(arg0, 47, Local0, 0xc179b3fe)
		}

		// Conversion of the both operands

		Store(And("0321", "C179B3FE"), Local0)
		m600(arg0, 48, Local0, 0x320)

		Store(And("C179B3FE", "0321"), Local0)
		m600(arg0, 49, Local0, 0x320)

		And("0321", "C179B3FE", Local0)
		m600(arg0, 50, Local0, 0x320)

		And("C179B3FE", "0321", Local0)
		m600(arg0, 51, Local0, 0x320)
	}

	// Divide, common 32-bit/64-bit test
	Method(m007, 1)
	{
		// Conversion of the first operand

		Store(Divide("0321", 1), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Divide("0321", 0x321), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide("0321", aui6), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Divide("0321", aui1), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide("0321", Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Divide("0321", Derefof(Refof(aui1))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide("0321", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Divide("0321", Derefof(Index(paui, 1))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide("0321", m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Divide("0321", m601(1, 1)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide("0321", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Divide("0321", Derefof(m602(1, 1, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide("0321", 1, Local1, Local0)
		m600(arg0, 12, Local0, 0x321)

		Divide("0321", 0x321, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide("0321", aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0x321)

		Divide("0321", aui1, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide("0321", Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0x321)

			Divide("0321", Derefof(Refof(aui1)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide("0321", Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0x321)

		Divide("0321", Derefof(Index(paui, 1)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide("0321", m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0x321)

		Divide("0321", m601(1, 1), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide("0321", Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0x321)

			Divide("0321", Derefof(m602(1, 1, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, "0321"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0x321, "0321"), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, "0321"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(aui1, "0321"), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), "0321"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(aui1)), "0321"), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), "0321"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 1)), "0321"), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), "0321"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 1), "0321"), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), "0321"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 1, 1)), "0321"), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, "0321", Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0x321, "0321", Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, "0321", Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(aui1, "0321", Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), "0321", Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(aui1)), "0321", Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), "0321", Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 1)), "0321", Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), "0321", Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 1), "0321", Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), "0321", Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 1, 1)), "0321", Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}
	}

	// Divide, 64-bit
	Method(m008, 1)
	{
		// Conversion of the first operand

		Store(Divide("FE7CB391D650A284", 1), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Divide("FE7CB391D650A284", 0xfe7cb391d650a284), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide("FE7CB391D650A284", aui6), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Divide("FE7CB391D650A284", aui4), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide("FE7CB391D650A284", Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Divide("FE7CB391D650A284", Derefof(Refof(aui4))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide("FE7CB391D650A284", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Divide("FE7CB391D650A284", Derefof(Index(paui, 4))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide("FE7CB391D650A284", m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Divide("FE7CB391D650A284", m601(1, 4)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide("FE7CB391D650A284", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Divide("FE7CB391D650A284", Derefof(m602(1, 4, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide("FE7CB391D650A284", 1, Local1, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Divide("FE7CB391D650A284", 0xfe7cb391d650a284, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide("FE7CB391D650A284", aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Divide("FE7CB391D650A284", aui4, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide("FE7CB391D650A284", Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Divide("FE7CB391D650A284", Derefof(Refof(aui4)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide("FE7CB391D650A284", Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Divide("FE7CB391D650A284", Derefof(Index(paui, 4)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide("FE7CB391D650A284", m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Divide("FE7CB391D650A284", m601(1, 4), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide("FE7CB391D650A284", Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Divide("FE7CB391D650A284", Derefof(m602(1, 4, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, "FE7CB391D650A284"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0xfe7cb391d650a284, "FE7CB391D650A284"), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, "FE7CB391D650A284"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(aui4, "FE7CB391D650A284"), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), "FE7CB391D650A284"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(aui4)), "FE7CB391D650A284"), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), "FE7CB391D650A284"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 4)), "FE7CB391D650A284"), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), "FE7CB391D650A284"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 4), "FE7CB391D650A284"), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 4, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, "FE7CB391D650A284", Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0xfe7cb391d650a284, "FE7CB391D650A284", Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, "FE7CB391D650A284", Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(aui4, "FE7CB391D650A284", Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), "FE7CB391D650A284", Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(aui4)), "FE7CB391D650A284", Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), "FE7CB391D650A284", Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 4)), "FE7CB391D650A284", Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), "FE7CB391D650A284", Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 4), "FE7CB391D650A284", Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), "FE7CB391D650A284", Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 4, 1)), "FE7CB391D650A284", Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}

		// Conversion of the both operands

		Store(Divide("0321", "FE7CB391D650A284"), Local0)
		m600(arg0, 48, Local0, 0)

		Store(Divide("FE7CB391D650A284", "0321"), Local0)
		m600(arg0, 49, Local0, 0x0051558eb950f5a7)

		Divide("0321", "FE7CB391D650A284", Local1, Local0)
		m600(arg0, 50, Local0, 0)

		Divide("FE7CB391D650A284", "0321", Local1, Local0)
		m600(arg0, 51, Local0, 0x0051558eb950f5a7)
	}

	// Divide, 32-bit
	Method(m009, 1)
	{
		// Conversion of the first operand

		Store(Divide("C179B3FE", 1), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(Divide("C179B3FE", 0xc179b3fe), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide("C179B3FE", aui6), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(Divide("C179B3FE", aui3), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide("C179B3FE", Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(Divide("C179B3FE", Derefof(Refof(aui3))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide("C179B3FE", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(Divide("C179B3FE", Derefof(Index(paui, 3))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide("C179B3FE", m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(Divide("C179B3FE", m601(1, 3)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide("C179B3FE", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(Divide("C179B3FE", Derefof(m602(1, 3, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide("C179B3FE", 1, Local1, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		Divide("C179B3FE", 0xc179b3fe, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide("C179B3FE", aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		Divide("C179B3FE", aui3, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide("C179B3FE", Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			Divide("C179B3FE", Derefof(Refof(aui3)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide("C179B3FE", Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		Divide("C179B3FE", Derefof(Index(paui, 3)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide("C179B3FE", m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		Divide("C179B3FE", m601(1, 3), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide("C179B3FE", Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			Divide("C179B3FE", Derefof(m602(1, 3, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, "C179B3FE"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0xc179b3fe, "C179B3FE"), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, "C179B3FE"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(aui3, "C179B3FE"), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), "C179B3FE"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(aui3)), "C179B3FE"), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), "C179B3FE"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 3)), "C179B3FE"), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), "C179B3FE"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 3), "C179B3FE"), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), "C179B3FE"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 3, 1)), "C179B3FE"), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, "C179B3FE", Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0xc179b3fe, "C179B3FE", Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, "C179B3FE", Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(aui3, "C179B3FE", Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), "C179B3FE", Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(aui3)), "C179B3FE", Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), "C179B3FE", Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 3)), "C179B3FE", Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), "C179B3FE", Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 3), "C179B3FE", Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), "C179B3FE", Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 3, 1)), "C179B3FE", Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}

		// Conversion of the both operands

		Store(Divide("0321", "C179B3FE"), Local0)
		m600(arg0, 48, Local0, 0)

		Store(Divide("C179B3FE", "0321"), Local0)
		m600(arg0, 49, Local0, 0x003dd5b7)

		Divide("0321", "C179B3FE", Local1, Local0)
		m600(arg0, 50, Local0, 0)

		Divide("C179B3FE", "0321", Local1, Local0)
		m600(arg0, 51, Local0, 0x003dd5b7)
	}

	// Mod, common 32-bit/64-bit test
	Method(m00a, 1)
	{
		// Conversion of the first operand

		Store(Mod("0321", 0x322), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Mod("0321", 0x320), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod("0321", auig), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Mod("0321", auih), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Mod("0321", Derefof(Refof(auig))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Mod("0321", Derefof(Refof(auih))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod("0321", Derefof(Index(paui, 16))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Mod("0321", Derefof(Index(paui, 17))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod("0321", m601(1, 16)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Mod("0321", m601(1, 17)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod("0321", Derefof(m602(1, 16, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Mod("0321", Derefof(m602(1, 17, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod("0321", 0x322, Local0)
		m600(arg0, 12, Local0, 0x321)

		Mod("0321", 0x320, Local0)
		m600(arg0, 13, Local0, 1)

		Mod("0321", auig, Local0)
		m600(arg0, 14, Local0, 0x321)

		Mod("0321", auih, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod("0321", Derefof(Refof(auig)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Mod("0321", Derefof(Refof(auih)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod("0321", Derefof(Index(paui, 16)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Mod("0321", Derefof(Index(paui, 17)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod("0321", m601(1, 16), Local0)
		m600(arg0, 20, Local0, 0x321)

		Mod("0321", m601(1, 17), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod("0321", Derefof(m602(1, 16, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Mod("0321", Derefof(m602(1, 17, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0x322, "0321"), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0x320, "0321"), Local0)
		m600(arg0, 25, Local0, 0x320)

		Store(Mod(auig, "0321"), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auih, "0321"), Local0)
		m600(arg0, 27, Local0, 0x320)

		if (y078) {
			Store(Mod(Derefof(Refof(auig)), "0321"), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auih)), "0321"), Local0)
			m600(arg0, 29, Local0, 0x320)
		}

		Store(Mod(Derefof(Index(paui, 16)), "0321"), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 17)), "0321"), Local0)
		m600(arg0, 31, Local0, 0x320)

		// Method returns Integer

		Store(Mod(m601(1, 16), "0321"), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 17), "0321"), Local0)
		m600(arg0, 33, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m602(1, 16, 1)), "0321"), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m602(1, 17, 1)), "0321"), Local0)
			m600(arg0, 35, Local0, 0x320)
		}

		Mod(0x322, "0321", Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0x320, "0321", Local0)
		m600(arg0, 37, Local0, 0x320)

		Mod(auig, "0321", Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auih, "0321", Local0)
		m600(arg0, 39, Local0, 0x320)

		if (y078) {
			Mod(Derefof(Refof(auig)), "0321", Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auih)), "0321", Local0)
			m600(arg0, 41, Local0, 0x320)
		}

		Mod(Derefof(Index(paui, 16)), "0321", Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 17)), "0321", Local0)
		m600(arg0, 43, Local0, 0x320)

		// Method returns Integer

		Mod(m601(1, 16), "0321", Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 17), "0321", Local0)
		m600(arg0, 45, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m602(1, 16, 1)), "0321", Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m602(1, 17, 1)), "0321", Local0)
			m600(arg0, 47, Local0, 0x320)
		}
	}

	// Mod, 64-bit
	Method(m00b, 1)
	{
		// Conversion of the first operand

		Store(Mod("FE7CB391D650A284", 0xfe7cb391d650a285), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Mod("FE7CB391D650A284", 0xfe7cb391d650a283), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod("FE7CB391D650A284", auid), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Mod("FE7CB391D650A284", auif), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Mod("FE7CB391D650A284", Derefof(Refof(auid))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Mod("FE7CB391D650A284", Derefof(Refof(auif))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod("FE7CB391D650A284", Derefof(Index(paui, 13))), Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		Store(Mod("FE7CB391D650A284", Derefof(Index(paui, 15))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod("FE7CB391D650A284", m601(1, 13)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Mod("FE7CB391D650A284", m601(1, 15)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod("FE7CB391D650A284", Derefof(m602(1, 13, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Mod("FE7CB391D650A284", Derefof(m602(1, 15, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod("FE7CB391D650A284", 0xfe7cb391d650a285, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Mod("FE7CB391D650A284", 0xfe7cb391d650a283, Local0)
		m600(arg0, 13, Local0, 1)

		Mod("FE7CB391D650A284", auid, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Mod("FE7CB391D650A284", auif, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod("FE7CB391D650A284", Derefof(Refof(auid)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Mod("FE7CB391D650A284", Derefof(Refof(auif)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod("FE7CB391D650A284", Derefof(Index(paui, 13)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Mod("FE7CB391D650A284", Derefof(Index(paui, 15)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod("FE7CB391D650A284", m601(1, 13), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Mod("FE7CB391D650A284", m601(1, 15), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod("FE7CB391D650A284", Derefof(m602(1, 13, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Mod("FE7CB391D650A284", Derefof(m602(1, 15, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0xfe7cb391d650a285, "FE7CB391D650A284"), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0xfe7cb391d650a283, "FE7CB391D650A284"), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a283)

		Store(Mod(auid, "FE7CB391D650A284"), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auif, "FE7CB391D650A284"), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Store(Mod(Derefof(Refof(auid)), "FE7CB391D650A284"), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auif)), "FE7CB391D650A284"), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a283)
		}

		Store(Mod(Derefof(Index(paui, 13)), "FE7CB391D650A284"), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 15)), "FE7CB391D650A284"), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Store(Mod(m601(1, 13), "FE7CB391D650A284"), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 15), "FE7CB391D650A284"), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m602(1, 13, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m602(1, 15, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a283)
		}

		Mod(0xfe7cb391d650a285, "FE7CB391D650A284", Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0xfe7cb391d650a283, "FE7CB391D650A284", Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a283)

		Mod(auid, "FE7CB391D650A284", Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auif, "FE7CB391D650A284", Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Mod(Derefof(Refof(auid)), "FE7CB391D650A284", Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auif)), "FE7CB391D650A284", Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a283)
		}

		Mod(Derefof(Index(paui, 13)), "FE7CB391D650A284", Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 15)), "FE7CB391D650A284", Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Mod(m601(1, 13), "FE7CB391D650A284", Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 15), "FE7CB391D650A284", Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m602(1, 13, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m602(1, 15, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a283)
		}

		// Conversion of the both operands

		Store(Mod("0321", "FE7CB391D650A284"), Local0)
		m600(arg0, 48, Local0, 0x321)

		Store(Mod("FE7CB391D650A284", "0321"), Local0)
		m600(arg0, 49, Local0, 0x2fd)

		Mod("0321", "FE7CB391D650A284", Local0)
		m600(arg0, 50, Local0, 0x321)

		Mod("FE7CB391D650A284", "0321", Local0)
		m600(arg0, 51, Local0, 0x2fd)
	}

	// Mod, 32-bit
	Method(m00c, 1)
	{
		// Conversion of the first operand

		Store(Mod("C179B3FE", 0xc179b3ff), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(Mod("C179B3FE", 0xc179b3fd), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod("C179B3FE", auic), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(Mod("C179B3FE", auie), Local0)
		m600(arg0, 14, Local0, 1)

		if (y078) {
			Store(Mod("C179B3FE", Derefof(Refof(auic))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(Mod("C179B3FE", Derefof(Refof(auie))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod("C179B3FE", Derefof(Index(paui, 12))), Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		Store(Mod("C179B3FE", Derefof(Index(paui, 14))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod("C179B3FE", m601(1, 12)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(Mod("C179B3FE", m601(1, 14)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod("C179B3FE", Derefof(m602(1, 12, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(Mod("C179B3FE", Derefof(m602(1, 14, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod("C179B3FE", 0xc179b3ff, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		Mod("C179B3FE", 0xc179b3fd, Local0)
		m600(arg0, 13, Local0, 1)

		Mod("C179B3FE", auic, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		Mod("C179B3FE", auie, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod("C179B3FE", Derefof(Refof(auic)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			Mod("C179B3FE", Derefof(Refof(auie)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod("C179B3FE", Derefof(Index(paui, 12)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		Mod("C179B3FE", Derefof(Index(paui, 14)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod("C179B3FE", m601(1, 12), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		Mod("C179B3FE", m601(1, 14), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod("C179B3FE", Derefof(m602(1, 12, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			Mod("C179B3FE", Derefof(m602(1, 14, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0xc179b3ff, "C179B3FE"), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0xc179b3fd, "C179B3FE"), Local0)
		m600(arg0, 25, Local0, 0xc179b3fd)

		Store(Mod(auic, "C179B3FE"), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auie, "C179B3FE"), Local0)
		m600(arg0, 27, Local0, 0xc179b3fd)

		if (y078) {
			Store(Mod(Derefof(Refof(auic)), "C179B3FE"), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auie)), "C179B3FE"), Local0)
			m600(arg0, 29, Local0, 0xc179b3fd)
		}

		Store(Mod(Derefof(Index(paui, 12)), "C179B3FE"), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 14)), "C179B3FE"), Local0)
		m600(arg0, 31, Local0, 0xc179b3fd)

		// Method returns Integer

		Store(Mod(m601(1, 12), "C179B3FE"), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 14), "C179B3FE"), Local0)
		m600(arg0, 33, Local0, 0xc179b3fd)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m602(1, 12, 1)), "C179B3FE"), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m602(1, 14, 1)), "C179B3FE"), Local0)
			m600(arg0, 35, Local0, 0xc179b3fd)
		}

		Mod(0xc179b3ff, "C179B3FE", Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0xc179b3fd, "C179B3FE", Local0)
		m600(arg0, 37, Local0, 0xc179b3fd)

		Mod(auic, "C179B3FE", Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auie, "C179B3FE", Local0)
		m600(arg0, 39, Local0, 0xc179b3fd)

		if (y078) {
			Mod(Derefof(Refof(auic)), "C179B3FE", Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auie)), "C179B3FE", Local0)
			m600(arg0, 41, Local0, 0xc179b3fd)
		}

		Mod(Derefof(Index(paui, 12)), "C179B3FE", Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 14)), "C179B3FE", Local0)
		m600(arg0, 43, Local0, 0xc179b3fd)

		// Method returns Integer

		Mod(m601(1, 12), "C179B3FE", Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 14), "C179B3FE", Local0)
		m600(arg0, 45, Local0, 0xc179b3fd)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m602(1, 12, 1)), "C179B3FE", Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m602(1, 14, 1)), "C179B3FE", Local0)
			m600(arg0, 47, Local0, 0xc179b3fd)
		}

		// Conversion of the both operands

		Store(Mod("0321", "C179B3FE"), Local0)
		m600(arg0, 48, Local0, 0x321)

		Store(Mod("C179B3FE", "0321"), Local0)
		m600(arg0, 49, Local0, 0x267)

		Mod("0321", "C179B3FE", Local0)
		m600(arg0, 50, Local0, 0x321)

		Mod("C179B3FE", "0321", Local0)
		m600(arg0, 51, Local0, 0x267)
	}

	// Multiply, common 32-bit/64-bit test
	Method(m00d, 1)
	{
		// Conversion of the first operand

		Store(Multiply("0321", 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply("0321", 1), Local0)
		m600(arg0, 1, Local0, 0x321)

		Store(Multiply("0321", aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply("0321", aui6), Local0)
		m600(arg0, 3, Local0, 0x321)

		if (y078) {
			Store(Multiply("0321", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply("0321", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x321)
		}

		Store(Multiply("0321", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply("0321", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x321)

		// Method returns Integer

		Store(Multiply("0321", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply("0321", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply("0321", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply("0321", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x321)
		}

		Multiply("0321", 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply("0321", 1, Local0)
		m600(arg0, 13, Local0, 0x321)

		Multiply("0321", aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply("0321", aui6, Local0)
		m600(arg0, 15, Local0, 0x321)

		if (y078) {
			Multiply("0321", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply("0321", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x321)
		}

		Multiply("0321", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply("0321", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x321)

		// Method returns Integer

		Multiply("0321", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply("0321", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Multiply("0321", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply("0321", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x321)
		}

		// Conversion of the second operand

		Store(Multiply(0, "0321"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, "0321"), Local0)
		m600(arg0, 25, Local0, 0x321)

		Store(Multiply(aui5, "0321"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, "0321"), Local0)
		m600(arg0, 27, Local0, 0x321)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), "0321"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), "0321"), Local0)
			m600(arg0, 29, Local0, 0x321)
		}

		Store(Multiply(Derefof(Index(paui, 5)), "0321"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), "0321"), Local0)
		m600(arg0, 31, Local0, 0x321)

		// Method returns Integer

		Store(Multiply(m601(1, 5), "0321"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), "0321"), Local0)
		m600(arg0, 33, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), "0321"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), "0321"), Local0)
			m600(arg0, 35, Local0, 0x321)
		}

		Multiply(0, "0321", Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, "0321", Local0)
		m600(arg0, 37, Local0, 0x321)

		Multiply(aui5, "0321", Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, "0321", Local0)
		m600(arg0, 39, Local0, 0x321)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), "0321", Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), "0321", Local0)
			m600(arg0, 41, Local0, 0x321)
		}

		Multiply(Derefof(Index(paui, 5)), "0321", Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), "0321", Local0)
		m600(arg0, 43, Local0, 0x321)

		// Method returns Integer

		Multiply(m601(1, 5), "0321", Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), "0321", Local0)
		m600(arg0, 45, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), "0321", Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), "0321", Local0)
			m600(arg0, 47, Local0, 0x321)
		}
	}

	// Multiply, 64-bit
	Method(m00e, 1)
	{
		// Conversion of the first operand

		Store(Multiply("FE7CB391D650A284", 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply("FE7CB391D650A284", 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a284)

		Store(Multiply("FE7CB391D650A284", aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply("FE7CB391D650A284", aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(Multiply("FE7CB391D650A284", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply("FE7CB391D650A284", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a284)
		}

		Store(Multiply("FE7CB391D650A284", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply("FE7CB391D650A284", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(Multiply("FE7CB391D650A284", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply("FE7CB391D650A284", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply("FE7CB391D650A284", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply("FE7CB391D650A284", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a284)
		}

		Multiply("FE7CB391D650A284", 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply("FE7CB391D650A284", 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		Multiply("FE7CB391D650A284", aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply("FE7CB391D650A284", aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Multiply("FE7CB391D650A284", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply("FE7CB391D650A284", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a284)
		}

		Multiply("FE7CB391D650A284", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply("FE7CB391D650A284", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Multiply("FE7CB391D650A284", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply("FE7CB391D650A284", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply("FE7CB391D650A284", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply("FE7CB391D650A284", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the second operand

		Store(Multiply(0, "FE7CB391D650A284"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, "FE7CB391D650A284"), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a284)

		Store(Multiply(aui5, "FE7CB391D650A284"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, "FE7CB391D650A284"), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), "FE7CB391D650A284"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), "FE7CB391D650A284"), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a284)
		}

		Store(Multiply(Derefof(Index(paui, 5)), "FE7CB391D650A284"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), "FE7CB391D650A284"), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(Multiply(m601(1, 5), "FE7CB391D650A284"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), "FE7CB391D650A284"), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a284)
		}

		Multiply(0, "FE7CB391D650A284", Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, "FE7CB391D650A284", Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a284)

		Multiply(aui5, "FE7CB391D650A284", Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, "FE7CB391D650A284", Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), "FE7CB391D650A284", Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), "FE7CB391D650A284", Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a284)
		}

		Multiply(Derefof(Index(paui, 5)), "FE7CB391D650A284", Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), "FE7CB391D650A284", Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Multiply(m601(1, 5), "FE7CB391D650A284", Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), "FE7CB391D650A284", Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the both operands

		Store(Multiply("0321", "FE7CB391D650A284"), Local0)
		m600(arg0, 48, Local0, 0x442ddb4f924c7f04)

		Store(Multiply("FE7CB391D650A284", "0321"), Local0)
		m600(arg0, 49, Local0, 0x442ddb4f924c7f04)

		Multiply("0321", "FE7CB391D650A284", Local0)
		m600(arg0, 50, Local0, 0x442ddb4f924c7f04)

		Multiply("FE7CB391D650A284", "0321", Local0)
		m600(arg0, 51, Local0, 0x442ddb4f924c7f04)
	}

	// Multiply, 32-bit
	Method(m00f, 1)
	{
		// Conversion of the first operand

		Store(Multiply("C179B3FE", 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply("C179B3FE", 1), Local0)
		m600(arg0, 1, Local0, 0xc179b3fe)

		Store(Multiply("C179B3FE", aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply("C179B3FE", aui6), Local0)
		m600(arg0, 3, Local0, 0xc179b3fe)

		if (y078) {
			Store(Multiply("C179B3FE", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply("C179B3FE", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xc179b3fe)
		}

		Store(Multiply("C179B3FE", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply("C179B3FE", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xc179b3fe)

		// Method returns Integer

		Store(Multiply("C179B3FE", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply("C179B3FE", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply("C179B3FE", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply("C179B3FE", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xc179b3fe)
		}

		Multiply("C179B3FE", 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply("C179B3FE", 1, Local0)
		m600(arg0, 13, Local0, 0xc179b3fe)

		Multiply("C179B3FE", aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply("C179B3FE", aui6, Local0)
		m600(arg0, 15, Local0, 0xc179b3fe)

		if (y078) {
			Multiply("C179B3FE", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply("C179B3FE", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xc179b3fe)
		}

		Multiply("C179B3FE", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply("C179B3FE", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xc179b3fe)

		// Method returns Integer

		Multiply("C179B3FE", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply("C179B3FE", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			Multiply("C179B3FE", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply("C179B3FE", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xc179b3fe)
		}

		// Conversion of the second operand

		Store(Multiply(0, "C179B3FE"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, "C179B3FE"), Local0)
		m600(arg0, 25, Local0, 0xc179b3fe)

		Store(Multiply(aui5, "C179B3FE"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, "C179B3FE"), Local0)
		m600(arg0, 27, Local0, 0xc179b3fe)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), "C179B3FE"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), "C179B3FE"), Local0)
			m600(arg0, 29, Local0, 0xc179b3fe)
		}

		Store(Multiply(Derefof(Index(paui, 5)), "C179B3FE"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), "C179B3FE"), Local0)
		m600(arg0, 31, Local0, 0xc179b3fe)

		// Method returns Integer

		Store(Multiply(m601(1, 5), "C179B3FE"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), "C179B3FE"), Local0)
		m600(arg0, 33, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), "C179B3FE"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), "C179B3FE"), Local0)
			m600(arg0, 35, Local0, 0xc179b3fe)
		}

		Multiply(0, "C179B3FE", Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, "C179B3FE", Local0)
		m600(arg0, 37, Local0, 0xc179b3fe)

		Multiply(aui5, "C179B3FE", Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, "C179B3FE", Local0)
		m600(arg0, 39, Local0, 0xc179b3fe)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), "C179B3FE", Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), "C179B3FE", Local0)
			m600(arg0, 41, Local0, 0xc179b3fe)
		}

		Multiply(Derefof(Index(paui, 5)), "C179B3FE", Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), "C179B3FE", Local0)
		m600(arg0, 43, Local0, 0xc179b3fe)

		// Method returns Integer

		Multiply(m601(1, 5), "C179B3FE", Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), "C179B3FE", Local0)
		m600(arg0, 45, Local0, 0xc179b3fe)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), "C179B3FE", Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), "C179B3FE", Local0)
			m600(arg0, 47, Local0, 0xc179b3fe)
		}

		// Conversion of the both operands

		Store(Multiply("0321", "C179B3FE"), Local0)
		m600(arg0, 48, Local0, 0x5dcc2dbe)

		Store(Multiply("C179B3FE", "0321"), Local0)
		m600(arg0, 49, Local0, 0x5dcc2dbe)

		Multiply("0321", "C179B3FE", Local0)
		m600(arg0, 50, Local0, 0x5dcc2dbe)

		Multiply("C179B3FE", "0321", Local0)
		m600(arg0, 51, Local0, 0x5dcc2dbe)
	}

	// NAnd, common 32-bit/64-bit test
	Method(m010, 1)
	{
		// Conversion of the first operand

		Store(NAnd("0321", 0), Local0)
		m600(arg0, 0, Local0, 0xffffffffffffffff)

		Store(NAnd("0321", 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfffffffffffffcde)

		Store(NAnd("0321", aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffffffffffff)

		Store(NAnd("0321", auij), Local0)
		m600(arg0, 3, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(NAnd("0321", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffffffffffff)

			Store(NAnd("0321", Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfffffffffffffcde)
		}

		Store(NAnd("0321", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffffffffffff)

		Store(NAnd("0321", Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(NAnd("0321", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffffffffffff)

		Store(NAnd("0321", m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd("0321", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffffffffffff)

			Store(NAnd("0321", Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfffffffffffffcde)
		}

		NAnd("0321", 0, Local0)
		m600(arg0, 12, Local0, 0xffffffffffffffff)

		NAnd("0321", 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfffffffffffffcde)

		NAnd("0321", aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffffffffffff)

		NAnd("0321", auij, Local0)
		m600(arg0, 15, Local0, 0xfffffffffffffcde)

		if (y078) {
			NAnd("0321", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffffffffffff)

			NAnd("0321", Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfffffffffffffcde)
		}

		NAnd("0321", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffffffffffff)

		NAnd("0321", Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		NAnd("0321", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffffffffffff)

		NAnd("0321", m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			NAnd("0321", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffffffffffff)

			NAnd("0321", Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfffffffffffffcde)
		}

		// Conversion of the second operand

		Store(NAnd(0, "0321"), Local0)
		m600(arg0, 24, Local0, 0xffffffffffffffff)

		Store(NAnd(0xffffffffffffffff, "0321"), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffcde)

		Store(NAnd(aui5, "0321"), Local0)
		m600(arg0, 26, Local0, 0xffffffffffffffff)

		Store(NAnd(auij, "0321"), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), "0321"), Local0)
			m600(arg0, 28, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(Refof(auij)), "0321"), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffcde)
		}

		Store(NAnd(Derefof(Index(paui, 5)), "0321"), Local0)
		m600(arg0, 30, Local0, 0xffffffffffffffff)

		Store(NAnd(Derefof(Index(paui, 19)), "0321"), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(NAnd(m601(1, 5), "0321"), Local0)
		m600(arg0, 32, Local0, 0xffffffffffffffff)

		Store(NAnd(m601(1, 19), "0321"), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), "0321"), Local0)
			m600(arg0, 34, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(m602(1, 19, 1)), "0321"), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffcde)
		}

		NAnd(0, "0321", Local0)
		m600(arg0, 36, Local0, 0xffffffffffffffff)

		NAnd(0xffffffffffffffff, "0321", Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffcde)

		NAnd(aui5, "0321", Local0)
		m600(arg0, 38, Local0, 0xffffffffffffffff)

		NAnd(auij, "0321", Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffcde)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), "0321", Local0)
			m600(arg0, 40, Local0, 0xffffffffffffffff)

			NAnd(Derefof(Refof(auij)), "0321", Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffcde)
		}

		NAnd(Derefof(Index(paui, 5)), "0321", Local0)
		m600(arg0, 42, Local0, 0xffffffffffffffff)

		NAnd(Derefof(Index(paui, 19)), "0321", Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		NAnd(m601(1, 5), "0321", Local0)
		m600(arg0, 44, Local0, 0xffffffffffffffff)

		NAnd(m601(1, 19), "0321", Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), "0321", Local0)
			m600(arg0, 46, Local0, 0xffffffffffffffff)

			NAnd(Derefof(m602(1, 19, 1)), "0321", Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffcde)
		}
	}

	// NAnd, 64-bit
	Method(m011, 1)
	{
		// Conversion of the first operand

		Store(NAnd("FE7CB391D650A284", 0), Local0)
		m600(arg0, 0, Local0, 0xffffffffffffffff)

		Store(NAnd("FE7CB391D650A284", 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x01834c6e29af5d7b)

		Store(NAnd("FE7CB391D650A284", aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffffffffffff)

		Store(NAnd("FE7CB391D650A284", auij), Local0)
		m600(arg0, 3, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(NAnd("FE7CB391D650A284", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffffffffffff)

			Store(NAnd("FE7CB391D650A284", Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x01834c6e29af5d7b)
		}

		Store(NAnd("FE7CB391D650A284", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffffffffffff)

		Store(NAnd("FE7CB391D650A284", Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(NAnd("FE7CB391D650A284", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffffffffffff)

		Store(NAnd("FE7CB391D650A284", m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd("FE7CB391D650A284", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffffffffffff)

			Store(NAnd("FE7CB391D650A284", Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x01834c6e29af5d7b)
		}

		NAnd("FE7CB391D650A284", 0, Local0)
		m600(arg0, 12, Local0, 0xffffffffffffffff)

		NAnd("FE7CB391D650A284", 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x01834c6e29af5d7b)

		NAnd("FE7CB391D650A284", aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffffffffffff)

		NAnd("FE7CB391D650A284", auij, Local0)
		m600(arg0, 15, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			NAnd("FE7CB391D650A284", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffffffffffff)

			NAnd("FE7CB391D650A284", Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x01834c6e29af5d7b)
		}

		NAnd("FE7CB391D650A284", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffffffffffff)

		NAnd("FE7CB391D650A284", Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		NAnd("FE7CB391D650A284", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffffffffffff)

		NAnd("FE7CB391D650A284", m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd("FE7CB391D650A284", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffffffffffff)

			NAnd("FE7CB391D650A284", Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the second operand

		Store(NAnd(0, "FE7CB391D650A284"), Local0)
		m600(arg0, 24, Local0, 0xffffffffffffffff)

		Store(NAnd(0xffffffffffffffff, "FE7CB391D650A284"), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7b)

		Store(NAnd(aui5, "FE7CB391D650A284"), Local0)
		m600(arg0, 26, Local0, 0xffffffffffffffff)

		Store(NAnd(auij, "FE7CB391D650A284"), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), "FE7CB391D650A284"), Local0)
			m600(arg0, 28, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(Refof(auij)), "FE7CB391D650A284"), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7b)
		}

		Store(NAnd(Derefof(Index(paui, 5)), "FE7CB391D650A284"), Local0)
		m600(arg0, 30, Local0, 0xffffffffffffffff)

		Store(NAnd(Derefof(Index(paui, 19)), "FE7CB391D650A284"), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(NAnd(m601(1, 5), "FE7CB391D650A284"), Local0)
		m600(arg0, 32, Local0, 0xffffffffffffffff)

		Store(NAnd(m601(1, 19), "FE7CB391D650A284"), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 34, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(m602(1, 19, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(0, "FE7CB391D650A284", Local0)
		m600(arg0, 36, Local0, 0xffffffffffffffff)

		NAnd(0xffffffffffffffff, "FE7CB391D650A284", Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7b)

		NAnd(aui5, "FE7CB391D650A284", Local0)
		m600(arg0, 38, Local0, 0xffffffffffffffff)

		NAnd(auij, "FE7CB391D650A284", Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), "FE7CB391D650A284", Local0)
			m600(arg0, 40, Local0, 0xffffffffffffffff)

			NAnd(Derefof(Refof(auij)), "FE7CB391D650A284", Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(Derefof(Index(paui, 5)), "FE7CB391D650A284", Local0)
		m600(arg0, 42, Local0, 0xffffffffffffffff)

		NAnd(Derefof(Index(paui, 19)), "FE7CB391D650A284", Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		NAnd(m601(1, 5), "FE7CB391D650A284", Local0)
		m600(arg0, 44, Local0, 0xffffffffffffffff)

		NAnd(m601(1, 19), "FE7CB391D650A284", Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 46, Local0, 0xffffffffffffffff)

			NAnd(Derefof(m602(1, 19, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the both operands

		Store(NAnd("0321", "FE7CB391D650A284"), Local0)
		m600(arg0, 48, Local0, 0xfffffffffffffdff)

		Store(NAnd("FE7CB391D650A284", "0321"), Local0)
		m600(arg0, 49, Local0, 0xfffffffffffffdff)

		NAnd("0321", "FE7CB391D650A284", Local0)
		m600(arg0, 50, Local0, 0xfffffffffffffdff)

		NAnd("FE7CB391D650A284", "0321", Local0)
		m600(arg0, 51, Local0, 0xfffffffffffffdff)
	}

	// NAnd, 32-bit
	Method(m012, 1)
	{
		// Conversion of the first operand

		Store(NAnd("C179B3FE", 0), Local0)
		m600(arg0, 0, Local0, 0xffffffff)

		Store(NAnd("C179B3FE", 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0x3e864c01)

		Store(NAnd("C179B3FE", aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffff)

		Store(NAnd("C179B3FE", auii), Local0)
		m600(arg0, 3, Local0, 0x3e864c01)

		if (y078) {
			Store(NAnd("C179B3FE", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffff)

			Store(NAnd("C179B3FE", Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0x3e864c01)
		}

		Store(NAnd("C179B3FE", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffff)

		Store(NAnd("C179B3FE", Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0x3e864c01)

		// Method returns Integer

		Store(NAnd("C179B3FE", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffff)

		Store(NAnd("C179B3FE", m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd("C179B3FE", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffff)

			Store(NAnd("C179B3FE", Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0x3e864c01)
		}

		NAnd("C179B3FE", 0, Local0)
		m600(arg0, 12, Local0, 0xffffffff)

		NAnd("C179B3FE", 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0x3e864c01)

		NAnd("C179B3FE", aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffff)

		NAnd("C179B3FE", auii, Local0)
		m600(arg0, 15, Local0, 0x3e864c01)

		if (y078) {
			NAnd("C179B3FE", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffff)

			NAnd("C179B3FE", Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0x3e864c01)
		}

		NAnd("C179B3FE", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffff)

		NAnd("C179B3FE", Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0x3e864c01)

		// Method returns Integer

		NAnd("C179B3FE", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffff)

		NAnd("C179B3FE", m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			NAnd("C179B3FE", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffff)

			NAnd("C179B3FE", Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0x3e864c01)
		}

		// Conversion of the second operand

		Store(NAnd(0, "C179B3FE"), Local0)
		m600(arg0, 24, Local0, 0xffffffff)

		Store(NAnd(0xffffffff, "C179B3FE"), Local0)
		m600(arg0, 25, Local0, 0x3e864c01)

		Store(NAnd(aui5, "C179B3FE"), Local0)
		m600(arg0, 26, Local0, 0xffffffff)

		Store(NAnd(auii, "C179B3FE"), Local0)
		m600(arg0, 27, Local0, 0x3e864c01)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), "C179B3FE"), Local0)
			m600(arg0, 28, Local0, 0xffffffff)

			Store(NAnd(Derefof(Refof(auii)), "C179B3FE"), Local0)
			m600(arg0, 29, Local0, 0x3e864c01)
		}

		Store(NAnd(Derefof(Index(paui, 5)), "C179B3FE"), Local0)
		m600(arg0, 30, Local0, 0xffffffff)

		Store(NAnd(Derefof(Index(paui, 18)), "C179B3FE"), Local0)
		m600(arg0, 31, Local0, 0x3e864c01)

		// Method returns Integer

		Store(NAnd(m601(1, 5), "C179B3FE"), Local0)
		m600(arg0, 32, Local0, 0xffffffff)

		Store(NAnd(m601(1, 18), "C179B3FE"), Local0)
		m600(arg0, 33, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), "C179B3FE"), Local0)
			m600(arg0, 34, Local0, 0xffffffff)

			Store(NAnd(Derefof(m602(1, 18, 1)), "C179B3FE"), Local0)
			m600(arg0, 35, Local0, 0x3e864c01)
		}

		NAnd(0, "C179B3FE", Local0)
		m600(arg0, 36, Local0, 0xffffffff)

		NAnd(0xffffffff, "C179B3FE", Local0)
		m600(arg0, 37, Local0, 0x3e864c01)

		NAnd(aui5, "C179B3FE", Local0)
		m600(arg0, 38, Local0, 0xffffffff)

		NAnd(auii, "C179B3FE", Local0)
		m600(arg0, 39, Local0, 0x3e864c01)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), "C179B3FE", Local0)
			m600(arg0, 40, Local0, 0xffffffff)

			NAnd(Derefof(Refof(auii)), "C179B3FE", Local0)
			m600(arg0, 41, Local0, 0x3e864c01)
		}

		NAnd(Derefof(Index(paui, 5)), "C179B3FE", Local0)
		m600(arg0, 42, Local0, 0xffffffff)

		NAnd(Derefof(Index(paui, 18)), "C179B3FE", Local0)
		m600(arg0, 43, Local0, 0x3e864c01)

		// Method returns Integer

		NAnd(m601(1, 5), "C179B3FE", Local0)
		m600(arg0, 44, Local0, 0xffffffff)

		NAnd(m601(1, 18), "C179B3FE", Local0)
		m600(arg0, 45, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), "C179B3FE", Local0)
			m600(arg0, 46, Local0, 0xffffffff)

			NAnd(Derefof(m602(1, 18, 1)), "C179B3FE", Local0)
			m600(arg0, 47, Local0, 0x3e864c01)
		}

		// Conversion of the both operands

		Store(NAnd("0321", "C179B3FE"), Local0)
		m600(arg0, 48, Local0, 0xfffffcdf)

		Store(NAnd("C179B3FE", "0321"), Local0)
		m600(arg0, 49, Local0, 0xfffffcdf)

		NAnd("0321", "C179B3FE", Local0)
		m600(arg0, 50, Local0, 0xfffffcdf)

		NAnd("C179B3FE", "0321", Local0)
		m600(arg0, 51, Local0, 0xfffffcdf)
	}

	// NOr, common 32-bit/64-bit test
	Method(m013, 1)
	{
		// Conversion of the first operand

		Store(NOr("0321", 0), Local0)
		m600(arg0, 0, Local0, 0xfffffffffffffcde)

		Store(NOr("0321", 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr("0321", aui5), Local0)
		m600(arg0, 2, Local0, 0xfffffffffffffcde)

		Store(NOr("0321", auij), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr("0321", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfffffffffffffcde)

			Store(NOr("0321", Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr("0321", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfffffffffffffcde)

		Store(NOr("0321", Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr("0321", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfffffffffffffcde)

		Store(NOr("0321", m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr("0321", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfffffffffffffcde)

			Store(NOr("0321", Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr("0321", 0, Local0)
		m600(arg0, 12, Local0, 0xfffffffffffffcde)

		NOr("0321", 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr("0321", aui5, Local0)
		m600(arg0, 14, Local0, 0xfffffffffffffcde)

		NOr("0321", auij, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr("0321", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfffffffffffffcde)

			NOr("0321", Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr("0321", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfffffffffffffcde)

		NOr("0321", Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr("0321", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfffffffffffffcde)

		NOr("0321", m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr("0321", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfffffffffffffcde)

			NOr("0321", Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, "0321"), Local0)
		m600(arg0, 24, Local0, 0xfffffffffffffcde)

		Store(NOr(0xffffffffffffffff, "0321"), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, "0321"), Local0)
		m600(arg0, 26, Local0, 0xfffffffffffffcde)

		Store(NOr(auij, "0321"), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), "0321"), Local0)
			m600(arg0, 28, Local0, 0xfffffffffffffcde)

			Store(NOr(Derefof(Refof(auij)), "0321"), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), "0321"), Local0)
		m600(arg0, 30, Local0, 0xfffffffffffffcde)

		Store(NOr(Derefof(Index(paui, 19)), "0321"), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), "0321"), Local0)
		m600(arg0, 32, Local0, 0xfffffffffffffcde)

		Store(NOr(m601(1, 19), "0321"), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), "0321"), Local0)
			m600(arg0, 34, Local0, 0xfffffffffffffcde)

			Store(NOr(Derefof(m602(1, 19, 1)), "0321"), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, "0321", Local0)
		m600(arg0, 36, Local0, 0xfffffffffffffcde)

		NOr(0xffffffffffffffff, "0321", Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, "0321", Local0)
		m600(arg0, 38, Local0, 0xfffffffffffffcde)

		NOr(auij, "0321", Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), "0321", Local0)
			m600(arg0, 40, Local0, 0xfffffffffffffcde)

			NOr(Derefof(Refof(auij)), "0321", Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), "0321", Local0)
		m600(arg0, 42, Local0, 0xfffffffffffffcde)

		NOr(Derefof(Index(paui, 19)), "0321", Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), "0321", Local0)
		m600(arg0, 44, Local0, 0xfffffffffffffcde)

		NOr(m601(1, 19), "0321", Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), "0321", Local0)
			m600(arg0, 46, Local0, 0xfffffffffffffcde)

			NOr(Derefof(m602(1, 19, 1)), "0321", Local0)
			m600(arg0, 47, Local0, 0)
		}
	}

	// NOr, 64-bit
	Method(m014, 1)
	{
		// Conversion of the first operand

		Store(NOr("FE7CB391D650A284", 0), Local0)
		m600(arg0, 0, Local0, 0x01834c6e29af5d7b)

		Store(NOr("FE7CB391D650A284", 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr("FE7CB391D650A284", aui5), Local0)
		m600(arg0, 2, Local0, 0x01834c6e29af5d7b)

		Store(NOr("FE7CB391D650A284", auij), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr("FE7CB391D650A284", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x01834c6e29af5d7b)

			Store(NOr("FE7CB391D650A284", Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr("FE7CB391D650A284", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x01834c6e29af5d7b)

		Store(NOr("FE7CB391D650A284", Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr("FE7CB391D650A284", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x01834c6e29af5d7b)

		Store(NOr("FE7CB391D650A284", m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr("FE7CB391D650A284", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x01834c6e29af5d7b)

			Store(NOr("FE7CB391D650A284", Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr("FE7CB391D650A284", 0, Local0)
		m600(arg0, 12, Local0, 0x01834c6e29af5d7b)

		NOr("FE7CB391D650A284", 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr("FE7CB391D650A284", aui5, Local0)
		m600(arg0, 14, Local0, 0x01834c6e29af5d7b)

		NOr("FE7CB391D650A284", auij, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr("FE7CB391D650A284", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x01834c6e29af5d7b)

			NOr("FE7CB391D650A284", Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr("FE7CB391D650A284", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x01834c6e29af5d7b)

		NOr("FE7CB391D650A284", Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr("FE7CB391D650A284", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x01834c6e29af5d7b)

		NOr("FE7CB391D650A284", m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr("FE7CB391D650A284", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x01834c6e29af5d7b)

			NOr("FE7CB391D650A284", Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, "FE7CB391D650A284"), Local0)
		m600(arg0, 24, Local0, 0x01834c6e29af5d7b)

		Store(NOr(0xffffffffffffffff, "FE7CB391D650A284"), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, "FE7CB391D650A284"), Local0)
		m600(arg0, 26, Local0, 0x01834c6e29af5d7b)

		Store(NOr(auij, "FE7CB391D650A284"), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), "FE7CB391D650A284"), Local0)
			m600(arg0, 28, Local0, 0x01834c6e29af5d7b)

			Store(NOr(Derefof(Refof(auij)), "FE7CB391D650A284"), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), "FE7CB391D650A284"), Local0)
		m600(arg0, 30, Local0, 0x01834c6e29af5d7b)

		Store(NOr(Derefof(Index(paui, 19)), "FE7CB391D650A284"), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), "FE7CB391D650A284"), Local0)
		m600(arg0, 32, Local0, 0x01834c6e29af5d7b)

		Store(NOr(m601(1, 19), "FE7CB391D650A284"), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 34, Local0, 0x01834c6e29af5d7b)

			Store(NOr(Derefof(m602(1, 19, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, "FE7CB391D650A284", Local0)
		m600(arg0, 36, Local0, 0x01834c6e29af5d7b)

		NOr(0xffffffffffffffff, "FE7CB391D650A284", Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, "FE7CB391D650A284", Local0)
		m600(arg0, 38, Local0, 0x01834c6e29af5d7b)

		NOr(auij, "FE7CB391D650A284", Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), "FE7CB391D650A284", Local0)
			m600(arg0, 40, Local0, 0x01834c6e29af5d7b)

			NOr(Derefof(Refof(auij)), "FE7CB391D650A284", Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), "FE7CB391D650A284", Local0)
		m600(arg0, 42, Local0, 0x01834c6e29af5d7b)

		NOr(Derefof(Index(paui, 19)), "FE7CB391D650A284", Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), "FE7CB391D650A284", Local0)
		m600(arg0, 44, Local0, 0x01834c6e29af5d7b)

		NOr(m601(1, 19), "FE7CB391D650A284", Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 46, Local0, 0x01834c6e29af5d7b)

			NOr(Derefof(m602(1, 19, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 47, Local0, 0)
		}

		// Conversion of the both operands

		Store(NOr("0321", "FE7CB391D650A284"), Local0)
		m600(arg0, 48, Local0, 0x01834c6e29af5c5a)

		Store(NOr("FE7CB391D650A284", "0321"), Local0)
		m600(arg0, 49, Local0, 0x01834c6e29af5c5a)

		NOr("0321", "FE7CB391D650A284", Local0)
		m600(arg0, 50, Local0, 0x01834c6e29af5c5a)

		NOr("FE7CB391D650A284", "0321", Local0)
		m600(arg0, 51, Local0, 0x01834c6e29af5c5a)
	}

	// NOr, 32-bit
	Method(m015, 1)
	{
		// Conversion of the first operand

		Store(NOr("C179B3FE", 0), Local0)
		m600(arg0, 0, Local0, 0x3e864c01)

		Store(NOr("C179B3FE", 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr("C179B3FE", aui5), Local0)
		m600(arg0, 2, Local0, 0x3e864c01)

		Store(NOr("C179B3FE", auii), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr("C179B3FE", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x3e864c01)

			Store(NOr("C179B3FE", Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr("C179B3FE", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x3e864c01)

		Store(NOr("C179B3FE", Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr("C179B3FE", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x3e864c01)

		Store(NOr("C179B3FE", m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr("C179B3FE", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x3e864c01)

			Store(NOr("C179B3FE", Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr("C179B3FE", 0, Local0)
		m600(arg0, 12, Local0, 0x3e864c01)

		NOr("C179B3FE", 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr("C179B3FE", aui5, Local0)
		m600(arg0, 14, Local0, 0x3e864c01)

		NOr("C179B3FE", auii, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr("C179B3FE", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x3e864c01)

			NOr("C179B3FE", Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr("C179B3FE", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x3e864c01)

		NOr("C179B3FE", Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr("C179B3FE", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x3e864c01)

		NOr("C179B3FE", m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr("C179B3FE", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x3e864c01)

			NOr("C179B3FE", Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, "C179B3FE"), Local0)
		m600(arg0, 24, Local0, 0x3e864c01)

		Store(NOr(0xffffffff, "C179B3FE"), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, "C179B3FE"), Local0)
		m600(arg0, 26, Local0, 0x3e864c01)

		Store(NOr(auii, "C179B3FE"), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), "C179B3FE"), Local0)
			m600(arg0, 28, Local0, 0x3e864c01)

			Store(NOr(Derefof(Refof(auii)), "C179B3FE"), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), "C179B3FE"), Local0)
		m600(arg0, 30, Local0, 0x3e864c01)

		Store(NOr(Derefof(Index(paui, 18)), "C179B3FE"), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), "C179B3FE"), Local0)
		m600(arg0, 32, Local0, 0x3e864c01)

		Store(NOr(m601(1, 18), "C179B3FE"), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), "C179B3FE"), Local0)
			m600(arg0, 34, Local0, 0x3e864c01)

			Store(NOr(Derefof(m602(1, 18, 1)), "C179B3FE"), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, "C179B3FE", Local0)
		m600(arg0, 36, Local0, 0x3e864c01)

		NOr(0xffffffff, "C179B3FE", Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, "C179B3FE", Local0)
		m600(arg0, 38, Local0, 0x3e864c01)

		NOr(auii, "C179B3FE", Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), "C179B3FE", Local0)
			m600(arg0, 40, Local0, 0x3e864c01)

			NOr(Derefof(Refof(auii)), "C179B3FE", Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), "C179B3FE", Local0)
		m600(arg0, 42, Local0, 0x3e864c01)

		NOr(Derefof(Index(paui, 18)), "C179B3FE", Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), "C179B3FE", Local0)
		m600(arg0, 44, Local0, 0x3e864c01)

		NOr(m601(1, 18), "C179B3FE", Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), "C179B3FE", Local0)
			m600(arg0, 46, Local0, 0x3e864c01)

			NOr(Derefof(m602(1, 18, 1)), "C179B3FE", Local0)
			m600(arg0, 47, Local0, 0)
		}

		// Conversion of the both operands

		Store(NOr("0321", "C179B3FE"), Local0)
		m600(arg0, 48, Local0, 0x3e864c00)

		Store(NOr("C179B3FE", "0321"), Local0)
		m600(arg0, 49, Local0, 0x3e864c00)

		NOr("0321", "C179B3FE", Local0)
		m600(arg0, 50, Local0, 0x3e864c00)

		NOr("C179B3FE", "0321", Local0)
		m600(arg0, 51, Local0, 0x3e864c00)
	}

	// Or, common 32-bit/64-bit test
	Method(m016, 1)
	{
		// Conversion of the first operand

		Store(Or("0321", 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Or("0321", 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffffffffffff)

		Store(Or("0321", aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Or("0321", auij), Local0)
		m600(arg0, 3, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or("0321", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Or("0321", Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xffffffffffffffff)
		}

		Store(Or("0321", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Or("0321", Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or("0321", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Or("0321", m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or("0321", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Or("0321", Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffffffffffff)
		}

		Or("0321", 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Or("0321", 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffffffffffff)

		Or("0321", aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Or("0321", auij, Local0)
		m600(arg0, 15, Local0, 0xffffffffffffffff)

		if (y078) {
			Or("0321", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Or("0321", Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xffffffffffffffff)
		}

		Or("0321", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Or("0321", Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or("0321", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Or("0321", m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or("0321", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Or("0321", Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffffffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, "0321"), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(Or(0xffffffffffffffff, "0321"), Local0)
		m600(arg0, 25, Local0, 0xffffffffffffffff)

		Store(Or(aui5, "0321"), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(Or(auij, "0321"), Local0)
		m600(arg0, 27, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), "0321"), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(Or(Derefof(Refof(auij)), "0321"), Local0)
			m600(arg0, 29, Local0, 0xffffffffffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), "0321"), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(Or(Derefof(Index(paui, 19)), "0321"), Local0)
		m600(arg0, 31, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), "0321"), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(Or(m601(1, 19), "0321"), Local0)
		m600(arg0, 33, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), "0321"), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(Or(Derefof(m602(1, 19, 1)), "0321"), Local0)
			m600(arg0, 35, Local0, 0xffffffffffffffff)
		}

		Or(0, "0321", Local0)
		m600(arg0, 36, Local0, 0x321)

		Or(0xffffffffffffffff, "0321", Local0)
		m600(arg0, 37, Local0, 0xffffffffffffffff)

		Or(aui5, "0321", Local0)
		m600(arg0, 38, Local0, 0x321)

		Or(auij, "0321", Local0)
		m600(arg0, 39, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), "0321", Local0)
			m600(arg0, 40, Local0, 0x321)

			Or(Derefof(Refof(auij)), "0321", Local0)
			m600(arg0, 41, Local0, 0xffffffffffffffff)
		}

		Or(Derefof(Index(paui, 5)), "0321", Local0)
		m600(arg0, 42, Local0, 0x321)

		Or(Derefof(Index(paui, 19)), "0321", Local0)
		m600(arg0, 43, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(m601(1, 5), "0321", Local0)
		m600(arg0, 44, Local0, 0x321)

		Or(m601(1, 19), "0321", Local0)
		m600(arg0, 45, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), "0321", Local0)
			m600(arg0, 46, Local0, 0x321)

			Or(Derefof(m602(1, 19, 1)), "0321", Local0)
			m600(arg0, 47, Local0, 0xffffffffffffffff)
		}
	}

	// Or, 64-bit
	Method(m017, 1)
	{
		// Conversion of the first operand

		Store(Or("FE7CB391D650A284", 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Or("FE7CB391D650A284", 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffffffffffff)

		Store(Or("FE7CB391D650A284", aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Or("FE7CB391D650A284", auij), Local0)
		m600(arg0, 3, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or("FE7CB391D650A284", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Or("FE7CB391D650A284", Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xffffffffffffffff)
		}

		Store(Or("FE7CB391D650A284", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Or("FE7CB391D650A284", Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or("FE7CB391D650A284", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Or("FE7CB391D650A284", m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or("FE7CB391D650A284", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Or("FE7CB391D650A284", Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffffffffffff)
		}

		Or("FE7CB391D650A284", 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Or("FE7CB391D650A284", 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffffffffffff)

		Or("FE7CB391D650A284", aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Or("FE7CB391D650A284", auij, Local0)
		m600(arg0, 15, Local0, 0xffffffffffffffff)

		if (y078) {
			Or("FE7CB391D650A284", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Or("FE7CB391D650A284", Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xffffffffffffffff)
		}

		Or("FE7CB391D650A284", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Or("FE7CB391D650A284", Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or("FE7CB391D650A284", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Or("FE7CB391D650A284", m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or("FE7CB391D650A284", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Or("FE7CB391D650A284", Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffffffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, "FE7CB391D650A284"), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(Or(0xffffffffffffffff, "FE7CB391D650A284"), Local0)
		m600(arg0, 25, Local0, 0xffffffffffffffff)

		Store(Or(aui5, "FE7CB391D650A284"), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(Or(auij, "FE7CB391D650A284"), Local0)
		m600(arg0, 27, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), "FE7CB391D650A284"), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(Or(Derefof(Refof(auij)), "FE7CB391D650A284"), Local0)
			m600(arg0, 29, Local0, 0xffffffffffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), "FE7CB391D650A284"), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(Or(Derefof(Index(paui, 19)), "FE7CB391D650A284"), Local0)
		m600(arg0, 31, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), "FE7CB391D650A284"), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(Or(m601(1, 19), "FE7CB391D650A284"), Local0)
		m600(arg0, 33, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(Or(Derefof(m602(1, 19, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 35, Local0, 0xffffffffffffffff)
		}

		Or(0, "FE7CB391D650A284", Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		Or(0xffffffffffffffff, "FE7CB391D650A284", Local0)
		m600(arg0, 37, Local0, 0xffffffffffffffff)

		Or(aui5, "FE7CB391D650A284", Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		Or(auij, "FE7CB391D650A284", Local0)
		m600(arg0, 39, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), "FE7CB391D650A284", Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			Or(Derefof(Refof(auij)), "FE7CB391D650A284", Local0)
			m600(arg0, 41, Local0, 0xffffffffffffffff)
		}

		Or(Derefof(Index(paui, 5)), "FE7CB391D650A284", Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		Or(Derefof(Index(paui, 19)), "FE7CB391D650A284", Local0)
		m600(arg0, 43, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(m601(1, 5), "FE7CB391D650A284", Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		Or(m601(1, 19), "FE7CB391D650A284", Local0)
		m600(arg0, 45, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			Or(Derefof(m602(1, 19, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 47, Local0, 0xffffffffffffffff)
		}

		// Conversion of the both operands

		Store(Or("0321", "FE7CB391D650A284"), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a3a5)

		Store(Or("FE7CB391D650A284", "0321"), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a3a5)

		Or("0321", "FE7CB391D650A284", Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a3a5)

		Or("FE7CB391D650A284", "0321", Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a3a5)
	}

	// Or, 32-bit
	Method(m018, 1)
	{
		// Conversion of the first operand

		Store(Or("C179B3FE", 0), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(Or("C179B3FE", 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffff)

		Store(Or("C179B3FE", aui5), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(Or("C179B3FE", auii), Local0)
		m600(arg0, 3, Local0, 0xffffffff)

		if (y078) {
			Store(Or("C179B3FE", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(Or("C179B3FE", Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0xffffffff)
		}

		Store(Or("C179B3FE", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(Or("C179B3FE", Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0xffffffff)

		// Method returns Integer

		Store(Or("C179B3FE", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(Or("C179B3FE", m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or("C179B3FE", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(Or("C179B3FE", Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffff)
		}

		Or("C179B3FE", 0, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		Or("C179B3FE", 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffff)

		Or("C179B3FE", aui5, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		Or("C179B3FE", auii, Local0)
		m600(arg0, 15, Local0, 0xffffffff)

		if (y078) {
			Or("C179B3FE", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			Or("C179B3FE", Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0xffffffff)
		}

		Or("C179B3FE", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		Or("C179B3FE", Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0xffffffff)

		// Method returns Integer

		Or("C179B3FE", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		Or("C179B3FE", m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or("C179B3FE", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			Or("C179B3FE", Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, "C179B3FE"), Local0)
		m600(arg0, 24, Local0, 0xc179b3fe)

		Store(Or(0xffffffff, "C179B3FE"), Local0)
		m600(arg0, 25, Local0, 0xffffffff)

		Store(Or(aui5, "C179B3FE"), Local0)
		m600(arg0, 26, Local0, 0xc179b3fe)

		Store(Or(auii, "C179B3FE"), Local0)
		m600(arg0, 27, Local0, 0xffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), "C179B3FE"), Local0)
			m600(arg0, 28, Local0, 0xc179b3fe)

			Store(Or(Derefof(Refof(auii)), "C179B3FE"), Local0)
			m600(arg0, 29, Local0, 0xffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), "C179B3FE"), Local0)
		m600(arg0, 30, Local0, 0xc179b3fe)

		Store(Or(Derefof(Index(paui, 18)), "C179B3FE"), Local0)
		m600(arg0, 31, Local0, 0xffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), "C179B3FE"), Local0)
		m600(arg0, 32, Local0, 0xc179b3fe)

		Store(Or(m601(1, 18), "C179B3FE"), Local0)
		m600(arg0, 33, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), "C179B3FE"), Local0)
			m600(arg0, 34, Local0, 0xc179b3fe)

			Store(Or(Derefof(m602(1, 18, 1)), "C179B3FE"), Local0)
			m600(arg0, 35, Local0, 0xffffffff)
		}

		Or(0, "C179B3FE", Local0)
		m600(arg0, 36, Local0, 0xc179b3fe)

		Or(0xffffffff, "C179B3FE", Local0)
		m600(arg0, 37, Local0, 0xffffffff)

		Or(aui5, "C179B3FE", Local0)
		m600(arg0, 38, Local0, 0xc179b3fe)

		Or(auii, "C179B3FE", Local0)
		m600(arg0, 39, Local0, 0xffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), "C179B3FE", Local0)
			m600(arg0, 40, Local0, 0xc179b3fe)

			Or(Derefof(Refof(auii)), "C179B3FE", Local0)
			m600(arg0, 41, Local0, 0xffffffff)
		}

		Or(Derefof(Index(paui, 5)), "C179B3FE", Local0)
		m600(arg0, 42, Local0, 0xc179b3fe)

		Or(Derefof(Index(paui, 18)), "C179B3FE", Local0)
		m600(arg0, 43, Local0, 0xffffffff)

		// Method returns Integer

		Or(m601(1, 5), "C179B3FE", Local0)
		m600(arg0, 44, Local0, 0xc179b3fe)

		Or(m601(1, 18), "C179B3FE", Local0)
		m600(arg0, 45, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), "C179B3FE", Local0)
			m600(arg0, 46, Local0, 0xc179b3fe)

			Or(Derefof(m602(1, 18, 1)), "C179B3FE", Local0)
			m600(arg0, 47, Local0, 0xffffffff)
		}

		// Conversion of the both operands

		Store(Or("0321", "C179B3FE"), Local0)
		m600(arg0, 48, Local0, 0xc179b3ff)

		Store(Or("C179B3FE", "0321"), Local0)
		m600(arg0, 49, Local0, 0xc179b3ff)

		Or("0321", "C179B3FE", Local0)
		m600(arg0, 50, Local0, 0xc179b3ff)

		Or("C179B3FE", "0321", Local0)
		m600(arg0, 51, Local0, 0xc179b3ff)
	}

	// ShiftLeft, common 32-bit/64-bit test
	Method(m019, 1)
	{
		// Conversion of the first operand

		Store(ShiftLeft("0321", 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(ShiftLeft("0321", 1), Local0)
		m600(arg0, 1, Local0, 0x642)

		Store(ShiftLeft("0321", aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(ShiftLeft("0321", aui6), Local0)
		m600(arg0, 3, Local0, 0x642)

		if (y078) {
			Store(ShiftLeft("0321", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(ShiftLeft("0321", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x642)
		}

		Store(ShiftLeft("0321", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(ShiftLeft("0321", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x642)

		// Method returns Integer

		Store(ShiftLeft("0321", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(ShiftLeft("0321", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x642)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft("0321", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(ShiftLeft("0321", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x642)
		}

		ShiftLeft("0321", 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		ShiftLeft("0321", 1, Local0)
		m600(arg0, 13, Local0, 0x642)

		ShiftLeft("0321", aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		ShiftLeft("0321", aui6, Local0)
		m600(arg0, 15, Local0, 0x642)

		if (y078) {
			ShiftLeft("0321", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			ShiftLeft("0321", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x642)
		}

		ShiftLeft("0321", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		ShiftLeft("0321", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x642)

		// Method returns Integer

		ShiftLeft("0321", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		ShiftLeft("0321", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x642)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft("0321", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			ShiftLeft("0321", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x642)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, "B"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, "B"), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, "B"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, "B"), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), "B"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), "B"), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), "B"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), "B"), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), "B"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), "B"), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), "B"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), "B"), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, "B", Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, "B", Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, "B", Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, "B", Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), "B", Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), "B", Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), "B", Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), "B", Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), "B", Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), "B", Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), "B", Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), "B", Local0)
			m600(arg0, 47, Local0, 0x800)
		}
	}

	// ShiftLeft, 64-bit
	Method(m01a, 1)
	{
		// Conversion of the first operand

		Store(ShiftLeft("FE7CB391D650A284", 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft("FE7CB391D650A284", 1), Local0)
		m600(arg0, 1, Local0, 0xfcf96723aca14508)

		Store(ShiftLeft("FE7CB391D650A284", aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft("FE7CB391D650A284", aui6), Local0)
		m600(arg0, 3, Local0, 0xfcf96723aca14508)

		if (y078) {
			Store(ShiftLeft("FE7CB391D650A284", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(ShiftLeft("FE7CB391D650A284", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfcf96723aca14508)
		}

		Store(ShiftLeft("FE7CB391D650A284", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft("FE7CB391D650A284", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfcf96723aca14508)

		// Method returns Integer

		Store(ShiftLeft("FE7CB391D650A284", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft("FE7CB391D650A284", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfcf96723aca14508)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft("FE7CB391D650A284", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(ShiftLeft("FE7CB391D650A284", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfcf96723aca14508)
		}

		ShiftLeft("FE7CB391D650A284", 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		ShiftLeft("FE7CB391D650A284", 1, Local0)
		m600(arg0, 13, Local0, 0xfcf96723aca14508)

		ShiftLeft("FE7CB391D650A284", aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		ShiftLeft("FE7CB391D650A284", aui6, Local0)
		m600(arg0, 15, Local0, 0xfcf96723aca14508)

		if (y078) {
			ShiftLeft("FE7CB391D650A284", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			ShiftLeft("FE7CB391D650A284", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfcf96723aca14508)
		}

		ShiftLeft("FE7CB391D650A284", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		ShiftLeft("FE7CB391D650A284", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfcf96723aca14508)

		// Method returns Integer

		ShiftLeft("FE7CB391D650A284", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		ShiftLeft("FE7CB391D650A284", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfcf96723aca14508)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft("FE7CB391D650A284", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			ShiftLeft("FE7CB391D650A284", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfcf96723aca14508)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, "B"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, "B"), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, "B"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, "B"), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), "B"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), "B"), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), "B"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), "B"), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), "B"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), "B"), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), "B"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), "B"), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, "B", Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, "B", Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, "B", Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, "B", Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), "B", Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), "B", Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), "B", Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), "B", Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), "B", Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), "B", Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), "B", Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), "B", Local0)
			m600(arg0, 47, Local0, 0x800)
		}

		// Conversion of the both operands

		Store(ShiftLeft("0321", "B"), Local0)
		m600(arg0, 48, Local0, 0x190800)

		Store(ShiftLeft("FE7CB391D650A284", "B"), Local0)
		m600(arg0, 49, Local0, 0xE59C8EB285142000)

		ShiftLeft("0321", "B", Local0)
		m600(arg0, 50, Local0, 0x190800)

		ShiftLeft("FE7CB391D650A284", "B", Local0)
		m600(arg0, 51, Local0, 0xE59C8EB285142000)
	}

	// ShiftLeft, 32-bit
	Method(m01b, 1)
	{
		// Conversion of the first operand

		Store(ShiftLeft("C179B3FE", 0), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(ShiftLeft("C179B3FE", 1), Local0)
		m600(arg0, 1, Local0, 0x82f367fc)

		Store(ShiftLeft("C179B3FE", aui5), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(ShiftLeft("C179B3FE", aui6), Local0)
		m600(arg0, 3, Local0, 0x82f367fc)

		if (y078) {
			Store(ShiftLeft("C179B3FE", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(ShiftLeft("C179B3FE", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x82f367fc)
		}

		Store(ShiftLeft("C179B3FE", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(ShiftLeft("C179B3FE", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x82f367fc)

		// Method returns Integer

		Store(ShiftLeft("C179B3FE", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(ShiftLeft("C179B3FE", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x82f367fc)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft("C179B3FE", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(ShiftLeft("C179B3FE", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x82f367fc)
		}

		ShiftLeft("C179B3FE", 0, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		ShiftLeft("C179B3FE", 1, Local0)
		m600(arg0, 13, Local0, 0x82f367fc)

		ShiftLeft("C179B3FE", aui5, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		ShiftLeft("C179B3FE", aui6, Local0)
		m600(arg0, 15, Local0, 0x82f367fc)

		if (y078) {
			ShiftLeft("C179B3FE", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			ShiftLeft("C179B3FE", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x82f367fc)
		}

		ShiftLeft("C179B3FE", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		ShiftLeft("C179B3FE", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x82f367fc)

		// Method returns Integer

		ShiftLeft("C179B3FE", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		ShiftLeft("C179B3FE", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x82f367fc)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft("C179B3FE", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			ShiftLeft("C179B3FE", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x82f367fc)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, "B"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, "B"), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, "B"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, "B"), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), "B"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), "B"), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), "B"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), "B"), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), "B"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), "B"), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), "B"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), "B"), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, "B", Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, "B", Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, "B", Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, "B", Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), "B", Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), "B", Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), "B", Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), "B", Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), "B", Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), "B", Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), "B", Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), "B", Local0)
			m600(arg0, 47, Local0, 0x800)
		}

		// Conversion of the both operands

		Store(ShiftLeft("0321", "B"), Local0)
		m600(arg0, 48, Local0, 0x190800)

		Store(ShiftLeft("C179B3FE", "B"), Local0)
		m600(arg0, 49, Local0, 0xcd9ff000)

		ShiftLeft("0321", "B", Local0)
		m600(arg0, 50, Local0, 0x190800)

		ShiftLeft("C179B3FE", "B", Local0)
		m600(arg0, 51, Local0, 0xcd9ff000)
	}

	// ShiftRight, common 32-bit/64-bit test
	Method(m01c, 1)
	{
		// Conversion of the first operand

		Store(ShiftRight("0321", 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(ShiftRight("0321", 1), Local0)
		m600(arg0, 1, Local0, 0x190)

		Store(ShiftRight("0321", aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(ShiftRight("0321", aui6), Local0)
		m600(arg0, 3, Local0, 0x190)

		if (y078) {
			Store(ShiftRight("0321", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(ShiftRight("0321", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x190)
		}

		Store(ShiftRight("0321", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(ShiftRight("0321", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x190)

		// Method returns Integer

		Store(ShiftRight("0321", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(ShiftRight("0321", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x190)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight("0321", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(ShiftRight("0321", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x190)
		}

		ShiftRight("0321", 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		ShiftRight("0321", 1, Local0)
		m600(arg0, 13, Local0, 0x190)

		ShiftRight("0321", aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		ShiftRight("0321", aui6, Local0)
		m600(arg0, 15, Local0, 0x190)

		if (y078) {
			ShiftRight("0321", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			ShiftRight("0321", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x190)
		}

		ShiftRight("0321", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		ShiftRight("0321", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x190)

		// Method returns Integer

		ShiftRight("0321", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		ShiftRight("0321", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x190)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight("0321", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			ShiftRight("0321", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x190)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, "B"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xc179b3fe, "B"), Local0)
		m600(arg0, 25, Local0, 0x182f36)

		Store(ShiftRight(aui1, "B"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(aui3, "B"), Local0)
		m600(arg0, 27, Local0, 0x182f36)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), "B"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(aui3)), "B"), Local0)
			m600(arg0, 29, Local0, 0x182f36)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), "B"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 3)), "B"), Local0)
		m600(arg0, 31, Local0, 0x182f36)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), "B"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 3), "B"), Local0)
		m600(arg0, 33, Local0, 0x182f36)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), "B"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 3, 1)), "B"), Local0)
			m600(arg0, 35, Local0, 0x182f36)
		}

		ShiftRight(0x321, "B", Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xc179b3fe, "B", Local0)
		m600(arg0, 37, Local0, 0x182f36)

		ShiftRight(aui1, "B", Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(aui3, "B", Local0)
		m600(arg0, 39, Local0, 0x182f36)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), "B", Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(aui3)), "B", Local0)
			m600(arg0, 41, Local0, 0x182f36)
		}

		ShiftRight(Derefof(Index(paui, 1)), "B", Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 3)), "B", Local0)
		m600(arg0, 43, Local0, 0x182f36)

		// Method returns Integer

		ShiftRight(m601(1, 1), "B", Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 3), "B", Local0)
		m600(arg0, 45, Local0, 0x182f36)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), "B", Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 3, 1)), "B", Local0)
			m600(arg0, 47, Local0, 0x182f36)
		}
	}

	// ShiftRight, 64-bit
	Method(m01d, 1)
	{
		// Conversion of the first operand

		Store(ShiftRight("FE7CB391D650A284", 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight("FE7CB391D650A284", 1), Local0)
		m600(arg0, 1, Local0, 0x7f3e59c8eb285142)

		Store(ShiftRight("FE7CB391D650A284", aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight("FE7CB391D650A284", aui6), Local0)
		m600(arg0, 3, Local0, 0x7f3e59c8eb285142)

		if (y078) {
			Store(ShiftRight("FE7CB391D650A284", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(ShiftRight("FE7CB391D650A284", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x7f3e59c8eb285142)
		}

		Store(ShiftRight("FE7CB391D650A284", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight("FE7CB391D650A284", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x7f3e59c8eb285142)

		// Method returns Integer

		Store(ShiftRight("FE7CB391D650A284", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight("FE7CB391D650A284", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x7f3e59c8eb285142)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight("FE7CB391D650A284", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(ShiftRight("FE7CB391D650A284", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x7f3e59c8eb285142)
		}

		ShiftRight("FE7CB391D650A284", 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		ShiftRight("FE7CB391D650A284", 1, Local0)
		m600(arg0, 13, Local0, 0x7f3e59c8eb285142)

		ShiftRight("FE7CB391D650A284", aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		ShiftRight("FE7CB391D650A284", aui6, Local0)
		m600(arg0, 15, Local0, 0x7f3e59c8eb285142)

		if (y078) {
			ShiftRight("FE7CB391D650A284", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			ShiftRight("FE7CB391D650A284", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x7f3e59c8eb285142)
		}

		ShiftRight("FE7CB391D650A284", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		ShiftRight("FE7CB391D650A284", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x7f3e59c8eb285142)

		// Method returns Integer

		ShiftRight("FE7CB391D650A284", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		ShiftRight("FE7CB391D650A284", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x7f3e59c8eb285142)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight("FE7CB391D650A284", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			ShiftRight("FE7CB391D650A284", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x7f3e59c8eb285142)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, "B"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xfe7cb391d650a284, "B"), Local0)
		m600(arg0, 25, Local0, 0x1fcf96723aca14)

		Store(ShiftRight(aui1, "B"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(aui4, "B"), Local0)
		m600(arg0, 27, Local0, 0x1fcf96723aca14)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), "B"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(aui4)), "B"), Local0)
			m600(arg0, 29, Local0, 0x1fcf96723aca14)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), "B"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 4)), "B"), Local0)
		m600(arg0, 31, Local0, 0x1fcf96723aca14)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), "B"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 4), "B"), Local0)
		m600(arg0, 33, Local0, 0x1fcf96723aca14)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), "B"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 4, 1)), "B"), Local0)
			m600(arg0, 35, Local0, 0x1fcf96723aca14)
		}

		ShiftRight(0x321, "B", Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xfe7cb391d650a284, "B", Local0)
		m600(arg0, 37, Local0, 0x1fcf96723aca14)

		ShiftRight(aui1, "B", Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(aui4, "B", Local0)
		m600(arg0, 39, Local0, 0x1fcf96723aca14)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), "B", Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(aui4)), "B", Local0)
			m600(arg0, 41, Local0, 0x1fcf96723aca14)
		}

		ShiftRight(Derefof(Index(paui, 1)), "B", Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 4)), "B", Local0)
		m600(arg0, 43, Local0, 0x1fcf96723aca14)

		// Method returns Integer

		ShiftRight(m601(1, 1), "B", Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 4), "B", Local0)
		m600(arg0, 45, Local0, 0x1fcf96723aca14)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), "B", Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 4, 1)), "B", Local0)
			m600(arg0, 47, Local0, 0x1fcf96723aca14)
		}

		// Conversion of the both operands

		Store(ShiftRight("0321", "B"), Local0)
		m600(arg0, 48, Local0, 0)

		Store(ShiftRight("FE7CB391D650A284", "B"), Local0)
		m600(arg0, 49, Local0, 0x1fcf96723aca14)

		ShiftRight("0321", "B", Local0)
		m600(arg0, 50, Local0, 0)

		ShiftRight("FE7CB391D650A284", "B", Local0)
		m600(arg0, 51, Local0, 0x1fcf96723aca14)
	}

	// ShiftRight, 32-bit
	Method(m01e, 1)
	{
		// Conversion of the first operand

		Store(ShiftRight("C179B3FE", 0), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(ShiftRight("C179B3FE", 1), Local0)
		m600(arg0, 1, Local0, 0x60bcd9ff)

		Store(ShiftRight("C179B3FE", aui5), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(ShiftRight("C179B3FE", aui6), Local0)
		m600(arg0, 3, Local0, 0x60bcd9ff)

		if (y078) {
			Store(ShiftRight("C179B3FE", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(ShiftRight("C179B3FE", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x60bcd9ff)
		}

		Store(ShiftRight("C179B3FE", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(ShiftRight("C179B3FE", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x60bcd9ff)

		// Method returns Integer

		Store(ShiftRight("C179B3FE", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(ShiftRight("C179B3FE", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x60bcd9ff)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight("C179B3FE", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(ShiftRight("C179B3FE", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x60bcd9ff)
		}

		ShiftRight("C179B3FE", 0, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		ShiftRight("C179B3FE", 1, Local0)
		m600(arg0, 13, Local0, 0x60bcd9ff)

		ShiftRight("C179B3FE", aui5, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		ShiftRight("C179B3FE", aui6, Local0)
		m600(arg0, 15, Local0, 0x60bcd9ff)

		if (y078) {
			ShiftRight("C179B3FE", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			ShiftRight("C179B3FE", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x60bcd9ff)
		}

		ShiftRight("C179B3FE", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		ShiftRight("C179B3FE", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x60bcd9ff)

		// Method returns Integer

		ShiftRight("C179B3FE", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		ShiftRight("C179B3FE", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x60bcd9ff)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight("C179B3FE", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			ShiftRight("C179B3FE", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x60bcd9ff)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, "B"), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xc179b3fe, "B"), Local0)
		m600(arg0, 25, Local0, 0x182f36)

		Store(ShiftRight(aui1, "B"), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(aui3, "B"), Local0)
		m600(arg0, 27, Local0, 0x182f36)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), "B"), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(aui3)), "B"), Local0)
			m600(arg0, 29, Local0, 0x182f36)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), "B"), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 3)), "B"), Local0)
		m600(arg0, 31, Local0, 0x182f36)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), "B"), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 3), "B"), Local0)
		m600(arg0, 33, Local0, 0x182f36)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), "B"), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 3, 1)), "B"), Local0)
			m600(arg0, 35, Local0, 0x182f36)
		}

		ShiftRight(0x321, "B", Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xc179b3fe, "B", Local0)
		m600(arg0, 37, Local0, 0x182f36)

		ShiftRight(aui1, "B", Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(aui3, "B", Local0)
		m600(arg0, 39, Local0, 0x182f36)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), "B", Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(aui3)), "B", Local0)
			m600(arg0, 41, Local0, 0x182f36)
		}

		ShiftRight(Derefof(Index(paui, 1)), "B", Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 3)), "B", Local0)
		m600(arg0, 43, Local0, 0x182f36)

		// Method returns Integer

		ShiftRight(m601(1, 1), "B", Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 3), "B", Local0)
		m600(arg0, 45, Local0, 0x182f36)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), "B", Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 3, 1)), "B", Local0)
			m600(arg0, 47, Local0, 0x182f36)
		}

		// Conversion of the both operands

		Store(ShiftRight("0321", "B"), Local0)
		m600(arg0, 48, Local0, 0)

		Store(ShiftRight("C179B3FE", "B"), Local0)
		m600(arg0, 49, Local0, 0x182f36)

		ShiftRight("0321", "B", Local0)
		m600(arg0, 50, Local0, 0)

		ShiftRight("C179B3FE", "B", Local0)
		m600(arg0, 51, Local0, 0x182f36)
	}

	// Subtract, common 32-bit/64-bit test
	Method(m01f, 1)
	{
		// Conversion of the first operand

		Store(Subtract("0321", 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Subtract("0321", 1), Local0)
		m600(arg0, 1, Local0, 0x320)

		Store(Subtract("0321", aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Subtract("0321", aui6), Local0)
		m600(arg0, 3, Local0, 0x320)

		if (y078) {
			Store(Subtract("0321", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Subtract("0321", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x320)
		}

		Store(Subtract("0321", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Subtract("0321", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x320)

		// Method returns Integer

		Store(Subtract("0321", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Subtract("0321", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract("0321", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Subtract("0321", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x320)
		}

		Subtract("0321", 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Subtract("0321", 1, Local0)
		m600(arg0, 13, Local0, 0x320)

		Subtract("0321", aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Subtract("0321", aui6, Local0)
		m600(arg0, 15, Local0, 0x320)

		if (y078) {
			Subtract("0321", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Subtract("0321", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x320)
		}

		Subtract("0321", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Subtract("0321", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x320)

		// Method returns Integer

		Subtract("0321", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Subtract("0321", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Subtract("0321", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Subtract("0321", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x320)
		}

		// Conversion of the second operand

		Store(Subtract(0, "0321"), Local0)
		m600(arg0, 24, Local0, 0xfffffffffffffcdf)

		Store(Subtract(1, "0321"), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffce0)

		Store(Subtract(aui5, "0321"), Local0)
		m600(arg0, 26, Local0, 0xfffffffffffffcdf)

		Store(Subtract(aui6, "0321"), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffce0)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), "0321"), Local0)
			m600(arg0, 28, Local0, 0xfffffffffffffcdf)

			Store(Subtract(Derefof(Refof(aui6)), "0321"), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffce0)
		}

		Store(Subtract(Derefof(Index(paui, 5)), "0321"), Local0)
		m600(arg0, 30, Local0, 0xfffffffffffffcdf)

		Store(Subtract(Derefof(Index(paui, 6)), "0321"), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffce0)

		// Method returns Integer

		Store(Subtract(m601(1, 5), "0321"), Local0)
		m600(arg0, 32, Local0, 0xfffffffffffffcdf)

		Store(Subtract(m601(1, 6), "0321"), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffce0)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), "0321"), Local0)
			m600(arg0, 34, Local0, 0xfffffffffffffcdf)

			Store(Subtract(Derefof(m602(1, 6, 1)), "0321"), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffce0)
		}

		Subtract(0, "0321", Local0)
		m600(arg0, 36, Local0, 0xfffffffffffffcdf)

		Subtract(1, "0321", Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffce0)

		Subtract(aui5, "0321", Local0)
		m600(arg0, 38, Local0, 0xfffffffffffffcdf)

		Subtract(aui6, "0321", Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffce0)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), "0321", Local0)
			m600(arg0, 40, Local0, 0xfffffffffffffcdf)

			Subtract(Derefof(Refof(aui6)), "0321", Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffce0)
		}

		Subtract(Derefof(Index(paui, 5)), "0321", Local0)
		m600(arg0, 42, Local0, 0xfffffffffffffcdf)

		Subtract(Derefof(Index(paui, 6)), "0321", Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffce0)

		// Method returns Integer

		Subtract(m601(1, 5), "0321", Local0)
		m600(arg0, 44, Local0, 0xfffffffffffffcdf)

		Subtract(m601(1, 6), "0321", Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffce0)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), "0321", Local0)
			m600(arg0, 46, Local0, 0xfffffffffffffcdf)

			Subtract(Derefof(m602(1, 6, 1)), "0321", Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffce0)
		}
	}

	// Subtract, 64-bit
	Method(m020, 1)
	{
		// Conversion of the first operand

		Store(Subtract("FE7CB391D650A284", 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Subtract("FE7CB391D650A284", 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a283)

		Store(Subtract("FE7CB391D650A284", aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Subtract("FE7CB391D650A284", aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Store(Subtract("FE7CB391D650A284", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Subtract("FE7CB391D650A284", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a283)
		}

		Store(Subtract("FE7CB391D650A284", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Subtract("FE7CB391D650A284", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Store(Subtract("FE7CB391D650A284", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Subtract("FE7CB391D650A284", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract("FE7CB391D650A284", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Subtract("FE7CB391D650A284", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a283)
		}

		Subtract("FE7CB391D650A284", 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Subtract("FE7CB391D650A284", 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a283)

		Subtract("FE7CB391D650A284", aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Subtract("FE7CB391D650A284", aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Subtract("FE7CB391D650A284", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Subtract("FE7CB391D650A284", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a283)
		}

		Subtract("FE7CB391D650A284", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Subtract("FE7CB391D650A284", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Subtract("FE7CB391D650A284", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Subtract("FE7CB391D650A284", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Subtract("FE7CB391D650A284", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Subtract("FE7CB391D650A284", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a283)
		}

		// Conversion of the second operand

		Store(Subtract(0, "FE7CB391D650A284"), Local0)
		m600(arg0, 24, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(1, "FE7CB391D650A284"), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7d)

		Store(Subtract(aui5, "FE7CB391D650A284"), Local0)
		m600(arg0, 26, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(aui6, "FE7CB391D650A284"), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7d)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), "FE7CB391D650A284"), Local0)
			m600(arg0, 28, Local0, 0x01834c6e29af5d7c)

			Store(Subtract(Derefof(Refof(aui6)), "FE7CB391D650A284"), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7d)
		}

		Store(Subtract(Derefof(Index(paui, 5)), "FE7CB391D650A284"), Local0)
		m600(arg0, 30, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(Derefof(Index(paui, 6)), "FE7CB391D650A284"), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7d)

		// Method returns Integer

		Store(Subtract(m601(1, 5), "FE7CB391D650A284"), Local0)
		m600(arg0, 32, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(m601(1, 6), "FE7CB391D650A284"), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 34, Local0, 0x01834c6e29af5d7c)

			Store(Subtract(Derefof(m602(1, 6, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7d)
		}

		Subtract(0, "FE7CB391D650A284", Local0)
		m600(arg0, 36, Local0, 0x01834c6e29af5d7c)

		Subtract(1, "FE7CB391D650A284", Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7d)

		Subtract(aui5, "FE7CB391D650A284", Local0)
		m600(arg0, 38, Local0, 0x01834c6e29af5d7c)

		Subtract(aui6, "FE7CB391D650A284", Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7d)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), "FE7CB391D650A284", Local0)
			m600(arg0, 40, Local0, 0x01834c6e29af5d7c)

			Subtract(Derefof(Refof(aui6)), "FE7CB391D650A284", Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7d)
		}

		Subtract(Derefof(Index(paui, 5)), "FE7CB391D650A284", Local0)
		m600(arg0, 42, Local0, 0x01834c6e29af5d7c)

		Subtract(Derefof(Index(paui, 6)), "FE7CB391D650A284", Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7d)

		// Method returns Integer

		Subtract(m601(1, 5), "FE7CB391D650A284", Local0)
		m600(arg0, 44, Local0, 0x01834c6e29af5d7c)

		Subtract(m601(1, 6), "FE7CB391D650A284", Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 46, Local0, 0x01834c6e29af5d7c)

			Subtract(Derefof(m602(1, 6, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7d)
		}

		// Conversion of the both operands

		Store(Subtract("0321", "FE7CB391D650A284"), Local0)
		m600(arg0, 48, Local0, 0x01834c6e29af609d)

		Store(Subtract("FE7CB391D650A284", "0321"), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d6509f63)

		Subtract("0321", "FE7CB391D650A284", Local0)
		m600(arg0, 50, Local0, 0x01834c6e29af609d)

		Subtract("FE7CB391D650A284", "0321", Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d6509f63)
	}

	// Subtract, 32-bit
	Method(m021, 1)
	{
		// Conversion of the first operand

		Store(Subtract("C179B3FE", 0), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(Subtract("C179B3FE", 1), Local0)
		m600(arg0, 1, Local0, 0xc179b3fd)

		Store(Subtract("C179B3FE", aui5), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(Subtract("C179B3FE", aui6), Local0)
		m600(arg0, 3, Local0, 0xc179b3fd)

		if (y078) {
			Store(Subtract("C179B3FE", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(Subtract("C179B3FE", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xc179b3fd)
		}

		Store(Subtract("C179B3FE", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(Subtract("C179B3FE", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xc179b3fd)

		// Method returns Integer

		Store(Subtract("C179B3FE", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(Subtract("C179B3FE", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xc179b3fd)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract("C179B3FE", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(Subtract("C179B3FE", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xc179b3fd)
		}

		Subtract("C179B3FE", 0, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		Subtract("C179B3FE", 1, Local0)
		m600(arg0, 13, Local0, 0xc179b3fd)

		Subtract("C179B3FE", aui5, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		Subtract("C179B3FE", aui6, Local0)
		m600(arg0, 15, Local0, 0xc179b3fd)

		if (y078) {
			Subtract("C179B3FE", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			Subtract("C179B3FE", Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xc179b3fd)
		}

		Subtract("C179B3FE", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		Subtract("C179B3FE", Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xc179b3fd)

		// Method returns Integer

		Subtract("C179B3FE", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		Subtract("C179B3FE", m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xc179b3fd)

		// Method returns Reference to Integer

		if (y500) {
			Subtract("C179B3FE", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			Subtract("C179B3FE", Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xc179b3fd)
		}

		// Conversion of the second operand

		Store(Subtract(0, "C179B3FE"), Local0)
		m600(arg0, 24, Local0, 0x3e864c02)

		Store(Subtract(1, "C179B3FE"), Local0)
		m600(arg0, 25, Local0, 0x3e864c03)

		Store(Subtract(aui5, "C179B3FE"), Local0)
		m600(arg0, 26, Local0, 0x3e864c02)

		Store(Subtract(aui6, "C179B3FE"), Local0)
		m600(arg0, 27, Local0, 0x3e864c03)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), "C179B3FE"), Local0)
			m600(arg0, 28, Local0, 0x3e864c02)

			Store(Subtract(Derefof(Refof(aui6)), "C179B3FE"), Local0)
			m600(arg0, 29, Local0, 0x3e864c03)
		}

		Store(Subtract(Derefof(Index(paui, 5)), "C179B3FE"), Local0)
		m600(arg0, 30, Local0, 0x3e864c02)

		Store(Subtract(Derefof(Index(paui, 6)), "C179B3FE"), Local0)
		m600(arg0, 31, Local0, 0x3e864c03)

		// Method returns Integer

		Store(Subtract(m601(1, 5), "C179B3FE"), Local0)
		m600(arg0, 32, Local0, 0x3e864c02)

		Store(Subtract(m601(1, 6), "C179B3FE"), Local0)
		m600(arg0, 33, Local0, 0x3e864c03)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), "C179B3FE"), Local0)
			m600(arg0, 34, Local0, 0x3e864c02)

			Store(Subtract(Derefof(m602(1, 6, 1)), "C179B3FE"), Local0)
			m600(arg0, 35, Local0, 0x3e864c03)
		}

		Subtract(0, "C179B3FE", Local0)
		m600(arg0, 36, Local0, 0x3e864c02)

		Subtract(1, "C179B3FE", Local0)
		m600(arg0, 37, Local0, 0x3e864c03)

		Subtract(aui5, "C179B3FE", Local0)
		m600(arg0, 38, Local0, 0x3e864c02)

		Subtract(aui6, "C179B3FE", Local0)
		m600(arg0, 39, Local0, 0x3e864c03)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), "C179B3FE", Local0)
			m600(arg0, 40, Local0, 0x3e864c02)

			Subtract(Derefof(Refof(aui6)), "C179B3FE", Local0)
			m600(arg0, 41, Local0, 0x3e864c03)
		}

		Subtract(Derefof(Index(paui, 5)), "C179B3FE", Local0)
		m600(arg0, 42, Local0, 0x3e864c02)

		Subtract(Derefof(Index(paui, 6)), "C179B3FE", Local0)
		m600(arg0, 43, Local0, 0x3e864c03)

		// Method returns Integer

		Subtract(m601(1, 5), "C179B3FE", Local0)
		m600(arg0, 44, Local0, 0x3e864c02)

		Subtract(m601(1, 6), "C179B3FE", Local0)
		m600(arg0, 45, Local0, 0x3e864c03)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), "C179B3FE", Local0)
			m600(arg0, 46, Local0, 0x3e864c02)

			Subtract(Derefof(m602(1, 6, 1)), "C179B3FE", Local0)
			m600(arg0, 47, Local0, 0x3e864c03)
		}

		// Conversion of the both operands

		Store(Subtract("0321", "C179B3FE"), Local0)
		m600(arg0, 48, Local0, 0x3e864f23)

		Store(Subtract("C179B3FE", "0321"), Local0)
		m600(arg0, 49, Local0, 0xc179b0dd)

		Subtract("0321", "C179B3FE", Local0)
		m600(arg0, 50, Local0, 0x3e864f23)

		Subtract("C179B3FE", "0321", Local0)
		m600(arg0, 51, Local0, 0xc179b0dd)
	}

	// XOr, common 32-bit/64-bit test
	Method(m022, 1)
	{
		// Conversion of the first operand

		Store(XOr("0321", 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(XOr("0321", 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfffffffffffffcde)

		Store(XOr("0321", aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(XOr("0321", auij), Local0)
		m600(arg0, 3, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(XOr("0321", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(XOr("0321", Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfffffffffffffcde)
		}

		Store(XOr("0321", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(XOr("0321", Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(XOr("0321", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(XOr("0321", m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr("0321", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(XOr("0321", Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfffffffffffffcde)
		}

		XOr("0321", 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		XOr("0321", 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfffffffffffffcde)

		XOr("0321", aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		XOr("0321", auij, Local0)
		m600(arg0, 15, Local0, 0xfffffffffffffcde)

		if (y078) {
			XOr("0321", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			XOr("0321", Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfffffffffffffcde)
		}

		XOr("0321", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		XOr("0321", Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		XOr("0321", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		XOr("0321", m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			XOr("0321", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			XOr("0321", Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfffffffffffffcde)
		}

		// Conversion of the second operand

		Store(XOr(0, "0321"), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(XOr(0xffffffffffffffff, "0321"), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffcde)

		Store(XOr(aui5, "0321"), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(XOr(auij, "0321"), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), "0321"), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(XOr(Derefof(Refof(auij)), "0321"), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffcde)
		}

		Store(XOr(Derefof(Index(paui, 5)), "0321"), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(XOr(Derefof(Index(paui, 19)), "0321"), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(XOr(m601(1, 5), "0321"), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(XOr(m601(1, 19), "0321"), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), "0321"), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(XOr(Derefof(m602(1, 19, 1)), "0321"), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffcde)
		}

		XOr(0, "0321", Local0)
		m600(arg0, 36, Local0, 0x321)

		XOr(0xffffffffffffffff, "0321", Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffcde)

		XOr(aui5, "0321", Local0)
		m600(arg0, 38, Local0, 0x321)

		XOr(auij, "0321", Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffcde)

		if (y078) {
			XOr(Derefof(Refof(aui5)), "0321", Local0)
			m600(arg0, 40, Local0, 0x321)

			XOr(Derefof(Refof(auij)), "0321", Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffcde)
		}

		XOr(Derefof(Index(paui, 5)), "0321", Local0)
		m600(arg0, 42, Local0, 0x321)

		XOr(Derefof(Index(paui, 19)), "0321", Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		XOr(m601(1, 5), "0321", Local0)
		m600(arg0, 44, Local0, 0x321)

		XOr(m601(1, 19), "0321", Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), "0321", Local0)
			m600(arg0, 46, Local0, 0x321)

			XOr(Derefof(m602(1, 19, 1)), "0321", Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffcde)
		}
	}

	// XOr, 64-bit
	Method(m023, 1)
	{
		// Conversion of the first operand

		Store(XOr("FE7CB391D650A284", 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(XOr("FE7CB391D650A284", 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x01834c6e29af5d7b)

		Store(XOr("FE7CB391D650A284", aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(XOr("FE7CB391D650A284", auij), Local0)
		m600(arg0, 3, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(XOr("FE7CB391D650A284", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(XOr("FE7CB391D650A284", Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x01834c6e29af5d7b)
		}

		Store(XOr("FE7CB391D650A284", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(XOr("FE7CB391D650A284", Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(XOr("FE7CB391D650A284", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(XOr("FE7CB391D650A284", m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr("FE7CB391D650A284", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(XOr("FE7CB391D650A284", Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x01834c6e29af5d7b)
		}

		XOr("FE7CB391D650A284", 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		XOr("FE7CB391D650A284", 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x01834c6e29af5d7b)

		XOr("FE7CB391D650A284", aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		XOr("FE7CB391D650A284", auij, Local0)
		m600(arg0, 15, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			XOr("FE7CB391D650A284", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			XOr("FE7CB391D650A284", Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x01834c6e29af5d7b)
		}

		XOr("FE7CB391D650A284", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		XOr("FE7CB391D650A284", Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		XOr("FE7CB391D650A284", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		XOr("FE7CB391D650A284", m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr("FE7CB391D650A284", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			XOr("FE7CB391D650A284", Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the second operand

		Store(XOr(0, "FE7CB391D650A284"), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(XOr(0xffffffffffffffff, "FE7CB391D650A284"), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7b)

		Store(XOr(aui5, "FE7CB391D650A284"), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(XOr(auij, "FE7CB391D650A284"), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), "FE7CB391D650A284"), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(XOr(Derefof(Refof(auij)), "FE7CB391D650A284"), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7b)
		}

		Store(XOr(Derefof(Index(paui, 5)), "FE7CB391D650A284"), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(XOr(Derefof(Index(paui, 19)), "FE7CB391D650A284"), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(XOr(m601(1, 5), "FE7CB391D650A284"), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(XOr(m601(1, 19), "FE7CB391D650A284"), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(XOr(Derefof(m602(1, 19, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7b)
		}

		XOr(0, "FE7CB391D650A284", Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		XOr(0xffffffffffffffff, "FE7CB391D650A284", Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7b)

		XOr(aui5, "FE7CB391D650A284", Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		XOr(auij, "FE7CB391D650A284", Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			XOr(Derefof(Refof(aui5)), "FE7CB391D650A284", Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			XOr(Derefof(Refof(auij)), "FE7CB391D650A284", Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7b)
		}

		XOr(Derefof(Index(paui, 5)), "FE7CB391D650A284", Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		XOr(Derefof(Index(paui, 19)), "FE7CB391D650A284", Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		XOr(m601(1, 5), "FE7CB391D650A284", Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		XOr(m601(1, 19), "FE7CB391D650A284", Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			XOr(Derefof(m602(1, 19, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the both operands

		Store(XOr("0321", "FE7CB391D650A284"), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a1a5)

		Store(XOr("FE7CB391D650A284", "0321"), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a1a5)

		XOr("0321", "FE7CB391D650A284", Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a1a5)

		XOr("FE7CB391D650A284", "0321", Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a1a5)
	}

	// XOr, 32-bit
	Method(m024, 1)
	{
		// Conversion of the first operand

		Store(XOr("C179B3FE", 0), Local0)
		m600(arg0, 0, Local0, 0xc179b3fe)

		Store(XOr("C179B3FE", 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0x3e864c01)

		Store(XOr("C179B3FE", aui5), Local0)
		m600(arg0, 2, Local0, 0xc179b3fe)

		Store(XOr("C179B3FE", auii), Local0)
		m600(arg0, 3, Local0, 0x3e864c01)

		if (y078) {
			Store(XOr("C179B3FE", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xc179b3fe)

			Store(XOr("C179B3FE", Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0x3e864c01)
		}

		Store(XOr("C179B3FE", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xc179b3fe)

		Store(XOr("C179B3FE", Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0x3e864c01)

		// Method returns Integer

		Store(XOr("C179B3FE", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xc179b3fe)

		Store(XOr("C179B3FE", m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr("C179B3FE", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xc179b3fe)

			Store(XOr("C179B3FE", Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0x3e864c01)
		}

		XOr("C179B3FE", 0, Local0)
		m600(arg0, 12, Local0, 0xc179b3fe)

		XOr("C179B3FE", 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0x3e864c01)

		XOr("C179B3FE", aui5, Local0)
		m600(arg0, 14, Local0, 0xc179b3fe)

		XOr("C179B3FE", auii, Local0)
		m600(arg0, 15, Local0, 0x3e864c01)

		if (y078) {
			XOr("C179B3FE", Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xc179b3fe)

			XOr("C179B3FE", Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0x3e864c01)
		}

		XOr("C179B3FE", Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xc179b3fe)

		XOr("C179B3FE", Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0x3e864c01)

		// Method returns Integer

		XOr("C179B3FE", m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xc179b3fe)

		XOr("C179B3FE", m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			XOr("C179B3FE", Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xc179b3fe)

			XOr("C179B3FE", Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0x3e864c01)
		}

		// Conversion of the second operand

		Store(XOr(0, "C179B3FE"), Local0)
		m600(arg0, 24, Local0, 0xc179b3fe)

		Store(XOr(0xffffffff, "C179B3FE"), Local0)
		m600(arg0, 25, Local0, 0x3e864c01)

		Store(XOr(aui5, "C179B3FE"), Local0)
		m600(arg0, 26, Local0, 0xc179b3fe)

		Store(XOr(auii, "C179B3FE"), Local0)
		m600(arg0, 27, Local0, 0x3e864c01)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), "C179B3FE"), Local0)
			m600(arg0, 28, Local0, 0xc179b3fe)

			Store(XOr(Derefof(Refof(auii)), "C179B3FE"), Local0)
			m600(arg0, 29, Local0, 0x3e864c01)
		}

		Store(XOr(Derefof(Index(paui, 5)), "C179B3FE"), Local0)
		m600(arg0, 30, Local0, 0xc179b3fe)

		Store(XOr(Derefof(Index(paui, 18)), "C179B3FE"), Local0)
		m600(arg0, 31, Local0, 0x3e864c01)

		// Method returns Integer

		Store(XOr(m601(1, 5), "C179B3FE"), Local0)
		m600(arg0, 32, Local0, 0xc179b3fe)

		Store(XOr(m601(1, 18), "C179B3FE"), Local0)
		m600(arg0, 33, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), "C179B3FE"), Local0)
			m600(arg0, 34, Local0, 0xc179b3fe)

			Store(XOr(Derefof(m602(1, 18, 1)), "C179B3FE"), Local0)
			m600(arg0, 35, Local0, 0x3e864c01)
		}

		XOr(0, "C179B3FE", Local0)
		m600(arg0, 36, Local0, 0xc179b3fe)

		XOr(0xffffffff, "C179B3FE", Local0)
		m600(arg0, 37, Local0, 0x3e864c01)

		XOr(aui5, "C179B3FE", Local0)
		m600(arg0, 38, Local0, 0xc179b3fe)

		XOr(auii, "C179B3FE", Local0)
		m600(arg0, 39, Local0, 0x3e864c01)

		if (y078) {
			XOr(Derefof(Refof(aui5)), "C179B3FE", Local0)
			m600(arg0, 40, Local0, 0xc179b3fe)

			XOr(Derefof(Refof(auii)), "C179B3FE", Local0)
			m600(arg0, 41, Local0, 0x3e864c01)
		}

		XOr(Derefof(Index(paui, 5)), "C179B3FE", Local0)
		m600(arg0, 42, Local0, 0xc179b3fe)

		XOr(Derefof(Index(paui, 18)), "C179B3FE", Local0)
		m600(arg0, 43, Local0, 0x3e864c01)

		// Method returns Integer

		XOr(m601(1, 5), "C179B3FE", Local0)
		m600(arg0, 44, Local0, 0xc179b3fe)

		XOr(m601(1, 18), "C179B3FE", Local0)
		m600(arg0, 45, Local0, 0x3e864c01)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), "C179B3FE", Local0)
			m600(arg0, 46, Local0, 0xc179b3fe)

			XOr(Derefof(m602(1, 18, 1)), "C179B3FE", Local0)
			m600(arg0, 47, Local0, 0x3e864c01)
		}

		// Conversion of the both operands

		Store(XOr("0321", "C179B3FE"), Local0)
		m600(arg0, 48, Local0, 0xc179b0df)

		Store(XOr("C179B3FE", "0321"), Local0)
		m600(arg0, 49, Local0, 0xc179b0df)

		XOr("0321", "C179B3FE", Local0)
		m600(arg0, 50, Local0, 0xc179b0df)

		XOr("C179B3FE", "0321", Local0)
		m600(arg0, 51, Local0, 0xc179b0df)
	}

	// Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
	// ShiftLeft, ShiftRight, Subtract, Xor

	Method(m64d, 1)
	{
		// Add
		Concatenate(arg0, "-m001", Local0)
		SRMT(Local0)
		m001(Local0)
		Concatenate(arg0, "-m002", Local0)
		SRMT(Local0)
		m002(Local0)

		// And
		Concatenate(arg0, "-m004", Local0)
		SRMT(Local0)
		m004(Local0)
		Concatenate(arg0, "-m005", Local0)
		SRMT(Local0)
		m005(Local0)

		// Divide
		Concatenate(arg0, "-m007", Local0)
		SRMT(Local0)
		m007(Local0)
		Concatenate(arg0, "-m008", Local0)
		SRMT(Local0)
		m008(Local0)

		// Mod
		Concatenate(arg0, "-m00a", Local0)
		SRMT(Local0)
		m00a(Local0)
		Concatenate(arg0, "-m00b", Local0)
		SRMT(Local0)
		m00b(Local0)

		// Multiply
		Concatenate(arg0, "-m00d", Local0)
		SRMT(Local0)
		m00d(Local0)
		Concatenate(arg0, "-m00e", Local0)
		SRMT(Local0)
		m00e(Local0)

		// NAnd
		Concatenate(arg0, "-m010", Local0)
		SRMT(Local0)
		m010(Local0)
		Concatenate(arg0, "-m011", Local0)
		SRMT(Local0)
		m011(Local0)

		// NOr
		Concatenate(arg0, "-m013", Local0)
		SRMT(Local0)
		m013(Local0)
		Concatenate(arg0, "-m014", Local0)
		SRMT(Local0)
		m014(Local0)

		// Or
		Concatenate(arg0, "-m016", Local0)
		SRMT(Local0)
		m016(Local0)
		Concatenate(arg0, "-m017", Local0)
		SRMT(Local0)
		m017(Local0)

		// ShiftLeft
		Concatenate(arg0, "-m019", Local0)
		SRMT(Local0)
		m019(Local0)
		Concatenate(arg0, "-m01a", Local0)
		SRMT(Local0)
		m01a(Local0)

		// ShiftRight
		Concatenate(arg0, "-m01c", Local0)
		SRMT(Local0)
		m01c(Local0)
		Concatenate(arg0, "-m01d", Local0)
		SRMT(Local0)
		m01d(Local0)

		// Subtract
		Concatenate(arg0, "-m01f", Local0)
		SRMT(Local0)
		m01f(Local0)
		Concatenate(arg0, "-m020", Local0)
		SRMT(Local0)
		m020(Local0)

		// XOr
		Concatenate(arg0, "-m022", Local0)
		SRMT(Local0)
		m022(Local0)
		Concatenate(arg0, "-m023", Local0)
		SRMT(Local0)
		m023(Local0)
	}

	Method(m32d, 1)
	{
		// Add
		Concatenate(arg0, "-m001", Local0)
		SRMT(Local0)
		m001(Local0)
		Concatenate(arg0, "-m003", Local0)
		SRMT(Local0)
		m003(Local0)

		// And
		Concatenate(arg0, "-m004", Local0)
		SRMT(Local0)
		m004(Local0)
		Concatenate(arg0, "-m006", Local0)
		SRMT(Local0)
		m006(Local0)

		// Divide
		Concatenate(arg0, "-m007", Local0)
		SRMT(Local0)
		m007(Local0)
		Concatenate(arg0, "-m009", Local0)
		SRMT(Local0)
		m009(Local0)

		// Mod
		Concatenate(arg0, "-m00a", Local0)
		SRMT(Local0)
		m00a(Local0)
		Concatenate(arg0, "-m00c", Local0)
		SRMT(Local0)
		m00c(Local0)

		// Multiply
		Concatenate(arg0, "-m00d", Local0)
		SRMT(Local0)
		m00d(Local0)
		Concatenate(arg0, "-m00f", Local0)
		SRMT(Local0)
		m00f(Local0)

		// NAnd
		Concatenate(arg0, "-m010", Local0)
		SRMT(Local0)
		if (y119) {
			m010(Local0)
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m012", Local0)
		SRMT(Local0)
		m012(Local0)

		// NOr
		Concatenate(arg0, "-m013", Local0)
		SRMT(Local0)
		if (y119) {
			m013(Local0)
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m015", Local0)
		SRMT(Local0)
		m015(Local0)

		// Or
		Concatenate(arg0, "-m016", Local0)
		SRMT(Local0)
		if (y119) {
			m016(Local0)
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m018", Local0)
		SRMT(Local0)
		m018(Local0)

		// ShiftLeft
		Concatenate(arg0, "-m019", Local0)
		SRMT(Local0)
		m019(Local0)
		Concatenate(arg0, "-m01b", Local0)
		SRMT(Local0)
		m01b(Local0)

		// ShiftRight
		Concatenate(arg0, "-m01c", Local0)
		SRMT(Local0)
		m01c(Local0)
		Concatenate(arg0, "-m01e", Local0)
		SRMT(Local0)
		m01e(Local0)

		// Subtract
		Concatenate(arg0, "-m01f", Local0)
		SRMT(Local0)
		if (y119) {
			m01f(Local0)
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m021", Local0)
		SRMT(Local0)
		m021(Local0)

		// XOr
		Concatenate(arg0, "-m022", Local0)
		SRMT(Local0)
		if (y119) {
			m022(Local0)
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m024", Local0)
		SRMT(Local0)
		m024(Local0)
	}


	// String to Integer conversion of each String operand
	// of the 2-parameter Logical Integer operators LAnd and LOr

	// LAnd, common 32-bit/64-bit test
	Method(m025, 1)
	{
		// Conversion of the first operand

		Store(LAnd("0321", 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd("0321", 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd("0321", aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd("0321", aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd("0321", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd("0321", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd("0321", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd("0321", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd("0321", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd("0321", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd("0321", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd("0321", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, "0321"), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, "0321"), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, "0321"), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, "0321"), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), "0321"), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), "0321"), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), "0321"), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), "0321"), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), "0321"), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), "0321"), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), "0321"), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), "0321"), Local0)
			m600(arg0, 23, Local0, Ones)
		}
	}

	// LAnd, 64-bit
	Method(m026, 1)
	{
		// Conversion of the first operand

		Store(LAnd("FE7CB391D650A284", 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd("FE7CB391D650A284", 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd("FE7CB391D650A284", aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd("FE7CB391D650A284", aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd("FE7CB391D650A284", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd("FE7CB391D650A284", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd("FE7CB391D650A284", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd("FE7CB391D650A284", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd("FE7CB391D650A284", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd("FE7CB391D650A284", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd("FE7CB391D650A284", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd("FE7CB391D650A284", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, "FE7CB391D650A284"), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, "FE7CB391D650A284"), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, "FE7CB391D650A284"), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, "FE7CB391D650A284"), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), "FE7CB391D650A284"), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), "FE7CB391D650A284"), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), "FE7CB391D650A284"), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), "FE7CB391D650A284"), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), "FE7CB391D650A284"), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), "FE7CB391D650A284"), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(LAnd("0321", "FE7CB391D650A284"), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(LAnd("FE7CB391D650A284", "0321"), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// LAnd, 32-bit
	Method(m027, 1)
	{
		// Conversion of the first operand

		Store(LAnd("C179B3FE", 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd("C179B3FE", 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd("C179B3FE", aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd("C179B3FE", aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd("C179B3FE", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd("C179B3FE", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd("C179B3FE", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd("C179B3FE", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd("C179B3FE", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd("C179B3FE", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd("C179B3FE", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd("C179B3FE", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, "C179B3FE"), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, "C179B3FE"), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, "C179B3FE"), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, "C179B3FE"), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), "C179B3FE"), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), "C179B3FE"), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), "C179B3FE"), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), "C179B3FE"), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), "C179B3FE"), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), "C179B3FE"), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), "C179B3FE"), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), "C179B3FE"), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(LAnd("0321", "C179B3FE"), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(LAnd("C179B3FE", "0321"), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// Lor, common 32-bit/64-bit test
	Method(m028, 1)
	{
		// Conversion of the first operand

		Store(Lor("0", 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(Lor("0", 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor("0", aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(Lor("0", aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor("0", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(Lor("0", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor("0", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(Lor("0", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor("0", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(Lor("0", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor("0", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(Lor("0", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, "0"), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(Lor(1, "0"), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, "0"), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(Lor(aui6, "0"), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), "0"), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(Lor(Derefof(Refof(aui6)), "0"), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), "0"), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(Lor(Derefof(Index(paui, 6)), "0"), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), "0"), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(Lor(m601(1, 6), "0"), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), "0"), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(Lor(Derefof(m602(1, 6, 1)), "0"), Local0)
			m600(arg0, 23, Local0, Ones)
		}
	}

	// Lor, 64-bit
	Method(m029, 1)
	{
		// Conversion of the first operand

		Store(Lor("FE7CB391D650A284", 0), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(Lor("FE7CB391D650A284", 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor("FE7CB391D650A284", aui5), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(Lor("FE7CB391D650A284", aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor("FE7CB391D650A284", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(Lor("FE7CB391D650A284", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor("FE7CB391D650A284", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(Lor("FE7CB391D650A284", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor("FE7CB391D650A284", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(Lor("FE7CB391D650A284", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor("FE7CB391D650A284", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(Lor("FE7CB391D650A284", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, "FE7CB391D650A284"), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(Lor(1, "FE7CB391D650A284"), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, "FE7CB391D650A284"), Local0)
		m600(arg0, 14, Local0, Ones)

		Store(Lor(aui6, "FE7CB391D650A284"), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), "FE7CB391D650A284"), Local0)
			m600(arg0, 16, Local0, Ones)

			Store(Lor(Derefof(Refof(aui6)), "FE7CB391D650A284"), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), "FE7CB391D650A284"), Local0)
		m600(arg0, 18, Local0, Ones)

		Store(Lor(Derefof(Index(paui, 6)), "FE7CB391D650A284"), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), "FE7CB391D650A284"), Local0)
		m600(arg0, 20, Local0, Ones)

		Store(Lor(m601(1, 6), "FE7CB391D650A284"), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 22, Local0, Ones)

			Store(Lor(Derefof(m602(1, 6, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(Lor("0", "FE7CB391D650A284"), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(Lor("FE7CB391D650A284", "0"), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// Lor, 32-bit
	Method(m02a, 1)
	{
		// Conversion of the first operand

		Store(Lor("C179B3FE", 0), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(Lor("C179B3FE", 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor("C179B3FE", aui5), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(Lor("C179B3FE", aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor("C179B3FE", Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(Lor("C179B3FE", Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor("C179B3FE", Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(Lor("C179B3FE", Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor("C179B3FE", m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(Lor("C179B3FE", m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor("C179B3FE", Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(Lor("C179B3FE", Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, "C179B3FE"), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(Lor(1, "C179B3FE"), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, "C179B3FE"), Local0)
		m600(arg0, 14, Local0, Ones)

		Store(Lor(aui6, "C179B3FE"), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), "C179B3FE"), Local0)
			m600(arg0, 16, Local0, Ones)

			Store(Lor(Derefof(Refof(aui6)), "C179B3FE"), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), "C179B3FE"), Local0)
		m600(arg0, 18, Local0, Ones)

		Store(Lor(Derefof(Index(paui, 6)), "C179B3FE"), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), "C179B3FE"), Local0)
		m600(arg0, 20, Local0, Ones)

		Store(Lor(m601(1, 6), "C179B3FE"), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), "C179B3FE"), Local0)
			m600(arg0, 22, Local0, Ones)

			Store(Lor(Derefof(m602(1, 6, 1)), "C179B3FE"), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(Lor("0", "C179B3FE"), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(Lor("C179B3FE", "0"), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	Method(m64e, 1)
	{
		// LAnd
		Concatenate(arg0, "-m025", Local0)
		SRMT(Local0)
		m025(Local0)
		Concatenate(arg0, "-m026", Local0)
		SRMT(Local0)
		m026(Local0)

		// LOr
		Concatenate(arg0, "-m028", Local0)
		SRMT(Local0)
		m028(Local0)
		Concatenate(arg0, "-m029", Local0)
		SRMT(Local0)
		m029(Local0)
	}

	Method(m32e, 1)
	{
		// LAnd
		Concatenate(arg0, "-m025", Local0)
		SRMT(Local0)
		m025(Local0)
		Concatenate(arg0, "-m027", Local0)
		SRMT(Local0)
		m027(Local0)

		// LOr
		Concatenate(arg0, "-m028", Local0)
		SRMT(Local0)
		m028(Local0)
		Concatenate(arg0, "-m02a", Local0)
		SRMT(Local0)
		m02a(Local0)
	}


	// String to Integer conversion of the String second operand of
	// Logical operators when the first operand is evaluated as Integer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)
		
	Method(m64f, 1)
	{
		// LEqual

		Store(LEqual(0xfe7cb391d650a284, "FE7CB391D650A284"), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0xfe7cb391d650a285, "FE7CB391D650A284"), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0xfe7cb391d650a283, "FE7CB391D650A284"), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(aui4, "FE7CB391D650A284"), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auid, "FE7CB391D650A284"), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auif, "FE7CB391D650A284"), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aui4)), "FE7CB391D650A284"), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auid)), "FE7CB391D650A284"), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auif)), "FE7CB391D650A284"), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 4)), "FE7CB391D650A284"), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 13)), "FE7CB391D650A284"), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 15)), "FE7CB391D650A284"), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 4), "FE7CB391D650A284"), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 13), "FE7CB391D650A284"), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 15), "FE7CB391D650A284"), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 4, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m602(1, 13, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m602(1, 15, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0xfe7cb391d650a284, "FE7CB391D650A284"), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0xfe7cb391d650a285, "FE7CB391D650A284"), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0xfe7cb391d650a283, "FE7CB391D650A284"), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(aui4, "FE7CB391D650A284"), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auid, "FE7CB391D650A284"), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auif, "FE7CB391D650A284"), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(aui4)), "FE7CB391D650A284"), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auid)), "FE7CB391D650A284"), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auif)), "FE7CB391D650A284"), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 4)), "FE7CB391D650A284"), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 13)), "FE7CB391D650A284"), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 15)), "FE7CB391D650A284"), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 4), "FE7CB391D650A284"), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 13), "FE7CB391D650A284"), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 15), "FE7CB391D650A284"), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 4, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m602(1, 13, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m602(1, 15, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0xfe7cb391d650a284, "FE7CB391D650A284"), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0xfe7cb391d650a285, "FE7CB391D650A284"), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0xfe7cb391d650a283, "FE7CB391D650A284"), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(aui4, "FE7CB391D650A284"), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auid, "FE7CB391D650A284"), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auif, "FE7CB391D650A284"), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aui4)), "FE7CB391D650A284"), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auid)), "FE7CB391D650A284"), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auif)), "FE7CB391D650A284"), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 4)), "FE7CB391D650A284"), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 13)), "FE7CB391D650A284"), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 15)), "FE7CB391D650A284"), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 4), "FE7CB391D650A284"), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 13), "FE7CB391D650A284"), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 15), "FE7CB391D650A284"), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 4, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 13, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 15, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0xfe7cb391d650a284, "FE7CB391D650A284"), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0xfe7cb391d650a285, "FE7CB391D650A284"), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0xfe7cb391d650a283, "FE7CB391D650A284"), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(aui4, "FE7CB391D650A284"), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auid, "FE7CB391D650A284"), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auif, "FE7CB391D650A284"), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(aui4)), "FE7CB391D650A284"), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auid)), "FE7CB391D650A284"), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auif)), "FE7CB391D650A284"), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 4)), "FE7CB391D650A284"), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 13)), "FE7CB391D650A284"), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 15)), "FE7CB391D650A284"), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 4), "FE7CB391D650A284"), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 13), "FE7CB391D650A284"), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 15), "FE7CB391D650A284"), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 4, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m602(1, 13, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m602(1, 15, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0xfe7cb391d650a284, "FE7CB391D650A284"), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0xfe7cb391d650a285, "FE7CB391D650A284"), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0xfe7cb391d650a283, "FE7CB391D650A284"), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(aui4, "FE7CB391D650A284"), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auid, "FE7CB391D650A284"), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auif, "FE7CB391D650A284"), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aui4)), "FE7CB391D650A284"), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auid)), "FE7CB391D650A284"), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auif)), "FE7CB391D650A284"), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 4)), "FE7CB391D650A284"), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 13)), "FE7CB391D650A284"), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 15)), "FE7CB391D650A284"), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 4), "FE7CB391D650A284"), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 13), "FE7CB391D650A284"), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 15), "FE7CB391D650A284"), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 4, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m602(1, 13, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m602(1, 15, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0xfe7cb391d650a284, "FE7CB391D650A284"), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0xfe7cb391d650a285, "FE7CB391D650A284"), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0xfe7cb391d650a283, "FE7CB391D650A284"), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(aui4, "FE7CB391D650A284"), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auid, "FE7CB391D650A284"), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auif, "FE7CB391D650A284"), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aui4)), "FE7CB391D650A284"), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auid)), "FE7CB391D650A284"), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auif)), "FE7CB391D650A284"), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 4)), "FE7CB391D650A284"), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 13)), "FE7CB391D650A284"), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 15)), "FE7CB391D650A284"), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 4), "FE7CB391D650A284"), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 13), "FE7CB391D650A284"), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 15), "FE7CB391D650A284"), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 4, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m602(1, 13, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m602(1, 15, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	Method(m32f, 1)
	{
		// LEqual

		Store(LEqual(0xc179b3fe, "C179B3FE"), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0xc179b3ff, "C179B3FE"), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0xc179b3fd, "C179B3FE"), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(aui3, "C179B3FE"), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auic, "C179B3FE"), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auie, "C179B3FE"), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aui3)), "C179B3FE"), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auic)), "C179B3FE"), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auie)), "C179B3FE"), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 3)), "C179B3FE"), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 12)), "C179B3FE"), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 14)), "C179B3FE"), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 3), "C179B3FE"), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 12), "C179B3FE"), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 14), "C179B3FE"), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 3, 1)), "C179B3FE"), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m602(1, 12, 1)), "C179B3FE"), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m602(1, 14, 1)), "C179B3FE"), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0xc179b3fe, "C179B3FE"), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0xc179b3ff, "C179B3FE"), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0xc179b3fd, "C179B3FE"), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(aui3, "C179B3FE"), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auic, "C179B3FE"), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auie, "C179B3FE"), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(aui3)), "C179B3FE"), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auic)), "C179B3FE"), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auie)), "C179B3FE"), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 3)), "C179B3FE"), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 12)), "C179B3FE"), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 14)), "C179B3FE"), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 3), "C179B3FE"), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 12), "C179B3FE"), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 14), "C179B3FE"), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 3, 1)), "C179B3FE"), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m602(1, 12, 1)), "C179B3FE"), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m602(1, 14, 1)), "C179B3FE"), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0xc179b3fe, "C179B3FE"), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0xc179b3ff, "C179B3FE"), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0xc179b3fd, "C179B3FE"), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(aui3, "C179B3FE"), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auic, "C179B3FE"), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auie, "C179B3FE"), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aui3)), "C179B3FE"), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auic)), "C179B3FE"), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auie)), "C179B3FE"), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 3)), "C179B3FE"), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 12)), "C179B3FE"), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 14)), "C179B3FE"), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 3), "C179B3FE"), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 12), "C179B3FE"), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 14), "C179B3FE"), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 3, 1)), "C179B3FE"), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 12, 1)), "C179B3FE"), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 14, 1)), "C179B3FE"), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0xc179b3fe, "C179B3FE"), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0xc179b3ff, "C179B3FE"), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0xc179b3fd, "C179B3FE"), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(aui3, "C179B3FE"), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auic, "C179B3FE"), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auie, "C179B3FE"), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(aui3)), "C179B3FE"), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auic)), "C179B3FE"), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auie)), "C179B3FE"), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 3)), "C179B3FE"), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 12)), "C179B3FE"), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 14)), "C179B3FE"), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 3), "C179B3FE"), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 12), "C179B3FE"), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 14), "C179B3FE"), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 3, 1)), "C179B3FE"), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m602(1, 12, 1)), "C179B3FE"), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m602(1, 14, 1)), "C179B3FE"), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0xc179b3fe, "C179B3FE"), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0xc179b3ff, "C179B3FE"), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0xc179b3fd, "C179B3FE"), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(aui3, "C179B3FE"), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auic, "C179B3FE"), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auie, "C179B3FE"), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aui3)), "C179B3FE"), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auic)), "C179B3FE"), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auie)), "C179B3FE"), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 3)), "C179B3FE"), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 12)), "C179B3FE"), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 14)), "C179B3FE"), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 3), "C179B3FE"), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 12), "C179B3FE"), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 14), "C179B3FE"), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 3, 1)), "C179B3FE"), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m602(1, 12, 1)), "C179B3FE"), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m602(1, 14, 1)), "C179B3FE"), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0xc179b3fe, "C179B3FE"), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0xc179b3ff, "C179B3FE"), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0xc179b3fd, "C179B3FE"), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(aui3, "C179B3FE"), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auic, "C179B3FE"), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auie, "C179B3FE"), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aui3)), "C179B3FE"), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auic)), "C179B3FE"), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auie)), "C179B3FE"), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 3)), "C179B3FE"), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 12)), "C179B3FE"), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 14)), "C179B3FE"), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 3), "C179B3FE"), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 12), "C179B3FE"), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 14), "C179B3FE"), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 3, 1)), "C179B3FE"), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m602(1, 12, 1)), "C179B3FE"), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m602(1, 14, 1)), "C179B3FE"), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	Method(m02b, 1)
	{
		// LEqual

		Store(LEqual(0x321, "0321"), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0x322, "0321"), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0x320, "0321"), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(aui1, "0321"), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auig, "0321"), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auih, "0321"), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aui1)), "0321"), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auig)), "0321"), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auih)), "0321"), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 1)), "0321"), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 16)), "0321"), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 17)), "0321"), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 1), "0321"), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 16), "0321"), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 17), "0321"), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 1, 1)), "0321"), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m602(1, 16, 1)), "0321"), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m602(1, 17, 1)), "0321"), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0x321, "0321"), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0x322, "0321"), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0x320, "0321"), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(aui1, "0321"), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auig, "0321"), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auih, "0321"), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(aui1)), "0321"), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auig)), "0321"), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auih)), "0321"), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 1)), "0321"), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 16)), "0321"), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 17)), "0321"), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 1), "0321"), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 16), "0321"), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 17), "0321"), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 1, 1)), "0321"), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m602(1, 16, 1)), "0321"), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m602(1, 17, 1)), "0321"), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0x321, "0321"), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0x322, "0321"), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0x320, "0321"), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(aui1, "0321"), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auig, "0321"), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auih, "0321"), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aui1)), "0321"), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auig)), "0321"), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auih)), "0321"), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 1)), "0321"), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 16)), "0321"), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 17)), "0321"), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 1), "0321"), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 16), "0321"), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 17), "0321"), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 1, 1)), "0321"), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 16, 1)), "0321"), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 17, 1)), "0321"), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0x321, "0321"), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0x322, "0321"), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0x320, "0321"), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(aui1, "0321"), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auig, "0321"), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auih, "0321"), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(aui1)), "0321"), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auig)), "0321"), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auih)), "0321"), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 1)), "0321"), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 16)), "0321"), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 17)), "0321"), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 1), "0321"), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 16), "0321"), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 17), "0321"), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 1, 1)), "0321"), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m602(1, 16, 1)), "0321"), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m602(1, 17, 1)), "0321"), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0x321, "0321"), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0x322, "0321"), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0x320, "0321"), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(aui1, "0321"), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auig, "0321"), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auih, "0321"), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aui1)), "0321"), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auig)), "0321"), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auih)), "0321"), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 1)), "0321"), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 16)), "0321"), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 17)), "0321"), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 1), "0321"), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 16), "0321"), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 17), "0321"), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 1, 1)), "0321"), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m602(1, 16, 1)), "0321"), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m602(1, 17, 1)), "0321"), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0x321, "0321"), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0x322, "0321"), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0x320, "0321"), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(aui1, "0321"), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auig, "0321"), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auih, "0321"), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aui1)), "0321"), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auig)), "0321"), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auih)), "0321"), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 1)), "0321"), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 16)), "0321"), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 17)), "0321"), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 1), "0321"), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 16), "0321"), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 17), "0321"), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 1, 1)), "0321"), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m602(1, 16, 1)), "0321"), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m602(1, 17, 1)), "0321"), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	// String to Integer intermediate conversion of the String second
	// operand of Concatenate operator in case the first one is Integer

	Method(m64g, 1)
	{		
		Store(Concatenate(0x321, "0321"), Local0)
		m600(arg0, 0, Local0, bb26)

		Store(Concatenate(0x321, "FE7CB391D650A284"), Local0)
		m600(arg0, 1, Local0, bb21)


		Store(Concatenate(aui1, "0321"), Local0)
		m600(arg0, 2, Local0, bb26)

		Store(Concatenate(aui1, "FE7CB391D650A284"), Local0)
		m600(arg0, 3, Local0, bb21)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aui1)), "0321"), Local0)
			m600(arg0, 4, Local0, bb26)

			Store(Concatenate(Derefof(Refof(aui1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 5, Local0, bb21)
		}

		Store(Concatenate(Derefof(Index(paui, 1)), "0321"), Local0)
		m600(arg0, 6, Local0, bb26)

		Store(Concatenate(Derefof(Index(paui, 1)), "FE7CB391D650A284"), Local0)
		m600(arg0, 7, Local0, bb21)

		// Method returns Integer

		Store(Concatenate(m601(1, 1), "0321"), Local0)
		m600(arg0, 8, Local0, bb26)

		Store(Concatenate(m601(1, 1), "FE7CB391D650A284"), Local0)
		m600(arg0, 9, Local0, bb21)

		// Method returns Reference to Integer

		if (y500) {
			Store(Concatenate(Derefof(m602(1, 1, 1)), "0321"), Local0)
			m600(arg0, 10, Local0, bb26)

			Store(Concatenate(Derefof(m602(1, 1, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 11, Local0, bb21)
		}

		Concatenate(0x321, "0321", Local0)
		m600(arg0, 12, Local0, bb26)

		Concatenate(0x321, "FE7CB391D650A284", Local0)
		m600(arg0, 13, Local0, bb21)


		Concatenate(aui1, "0321", Local0)
		m600(arg0, 14, Local0, bb26)

		Concatenate(aui1, "FE7CB391D650A284", Local0)
		m600(arg0, 15, Local0, bb21)

		if (y078) {
			Concatenate(Derefof(Refof(aui1)), "0321", Local0)
			m600(arg0, 16, Local0, bb26)

			Concatenate(Derefof(Refof(aui1)), "FE7CB391D650A284", Local0)
			m600(arg0, 17, Local0, bb21)
		}

		Concatenate(Derefof(Index(paui, 1)), "0321", Local0)
		m600(arg0, 18, Local0, bb26)

		Concatenate(Derefof(Index(paui, 1)), "FE7CB391D650A284", Local0)
		m600(arg0, 19, Local0, bb21)

		// Method returns Integer

		Concatenate(m601(1, 1), "0321", Local0)
		m600(arg0, 20, Local0, bb26)

		Concatenate(m601(1, 1), "FE7CB391D650A284", Local0)
		m600(arg0, 21, Local0, bb21)

		// Method returns Reference to Integer

		if (y500) {
			Concatenate(Derefof(m602(1, 1, 1)), "0321", Local0)
			m600(arg0, 22, Local0, bb26)

			Concatenate(Derefof(m602(1, 1, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 23, Local0, bb21)
		}
	}

	Method(m32g, 1)
	{		
		Store(Concatenate(0x321, "0321"), Local0)
		m600(arg0, 0, Local0, bb27)

		Store(Concatenate(0x321, "C179B3FE"), Local0)
		m600(arg0, 1, Local0, bb24)


		Store(Concatenate(aui1, "0321"), Local0)
		m600(arg0, 2, Local0, bb27)

		Store(Concatenate(aui1, "C179B3FE"), Local0)
		m600(arg0, 3, Local0, bb24)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aui1)), "0321"), Local0)
			m600(arg0, 4, Local0, bb27)

			Store(Concatenate(Derefof(Refof(aui1)), "C179B3FE"), Local0)
			m600(arg0, 5, Local0, bb24)
		}

		Store(Concatenate(Derefof(Index(paui, 1)), "0321"), Local0)
		m600(arg0, 6, Local0, bb27)

		Store(Concatenate(Derefof(Index(paui, 1)), "C179B3FE"), Local0)
		m600(arg0, 7, Local0, bb24)

		// Method returns Integer

		Store(Concatenate(m601(1, 1), "0321"), Local0)
		m600(arg0, 8, Local0, bb27)

		Store(Concatenate(m601(1, 1), "C179B3FE"), Local0)
		m600(arg0, 9, Local0, bb24)

		// Method returns Reference to Integer

		if (y500) {
			Store(Concatenate(Derefof(m602(1, 1, 1)), "0321"), Local0)
			m600(arg0, 10, Local0, bb27)

			Store(Concatenate(Derefof(m602(1, 1, 1)), "C179B3FE"), Local0)
			m600(arg0, 11, Local0, bb24)
		}

		Concatenate(0x321, "0321", Local0)
		m600(arg0, 12, Local0, bb27)

		Concatenate(0x321, "C179B3FE", Local0)
		m600(arg0, 13, Local0, bb24)


		Concatenate(aui1, "0321", Local0)
		m600(arg0, 14, Local0, bb27)

		Concatenate(aui1, "C179B3FE", Local0)
		m600(arg0, 15, Local0, bb24)

		if (y078) {
			Concatenate(Derefof(Refof(aui1)), "0321", Local0)
			m600(arg0, 16, Local0, bb27)

			Concatenate(Derefof(Refof(aui1)), "C179B3FE", Local0)
			m600(arg0, 17, Local0, bb24)
		}

		Concatenate(Derefof(Index(paui, 1)), "0321", Local0)
		m600(arg0, 18, Local0, bb27)

		Concatenate(Derefof(Index(paui, 1)), "C179B3FE", Local0)
		m600(arg0, 20, Local0, bb24)

		// Method returns Integer

		Concatenate(m601(1, 1), "0321", Local0)
		m600(arg0, 21, Local0, bb27)

		Concatenate(m601(1, 1), "C179B3FE", Local0)
		m600(arg0, 22, Local0, bb24)

		// Method returns Reference to Integer

		if (y500) {
			Concatenate(Derefof(m602(1, 1, 1)), "0321", Local0)
			m600(arg0, 23, Local0, bb27)

			Concatenate(Derefof(m602(1, 1, 1)), "C179B3FE", Local0)
			m600(arg0, 24, Local0, bb24)
		}
	}

	// String to Integer conversion of the String Length (second)
	// operand of the ToString operator

	// Common 32-bit/64-bit test
	Method(m02c, 1)
	{
		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			"B"), Local0)
		m600(arg0, 0, Local0, bs1b)

		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			"0321"), Local0)
		m600(arg0, 1, Local0, bs1c)

		Store(ToString(aub6, "B"), Local0)
		m600(arg0, 2, Local0, bs1b)

		Store(ToString(aub6, "0321"), Local0)
		m600(arg0, 3, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), "B"), Local0)
			m600(arg0, 4, Local0, bs1b)

			Store(ToString(Derefof(Refof(aub6)), "0321"), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), "B"), Local0)
		m600(arg0, 6, Local0, bs1b)

		Store(ToString(Derefof(Index(paub, 6)), "0321"), Local0)
		m600(arg0, 7, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), "B"), Local0)
		m600(arg0, 8, Local0, bs1b)

		Store(ToString(m601(3, 6), "0321"), Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), "B"), Local0)
			m600(arg0, 10, Local0, bs1b)

			Store(ToString(Derefof(m602(3, 6, 1)), "0321"), Local0)
			m600(arg0, 11, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			"B", Local0)
		m600(arg0, 12, Local0, bs1b)

		ToString(Buffer() {"This is auxiliary Buffer"},
			"0321", Local0)
		m600(arg0, 13, Local0, bs1c)

		ToString(aub6, "B", Local0)
		m600(arg0, 14, Local0, bs1b)

		ToString(aub6, "0321", Local0)
		m600(arg0, 15, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), "B", Local0)
			m600(arg0, 16, Local0, bs1b)

			ToString(Derefof(Refof(aub6)), "0321", Local0)
			m600(arg0, 17, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), "B", Local0)
		m600(arg0, 18, Local0, bs1b)

		ToString(Derefof(Index(paub, 6)), "0321", Local0)
		m600(arg0, 19, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), "B", Local0)
		m600(arg0, 20, Local0, bs1b)

		ToString(m601(3, 6), "0321", Local0)
		m600(arg0, 21, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), "B", Local0)
			m600(arg0, 22, Local0, bs1b)

			ToString(Derefof(m602(3, 6, 1)), "0321", Local0)
			m600(arg0, 23, Local0, bs1c)
		}
	}

	Method(m64h, 1)
	{
		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			"FE7CB391D650A284"), Local0)
		m600(arg0, 0, Local0, bs1c)

		Store(ToString(aub6, "FE7CB391D650A284"), Local0)
		m600(arg0, 1, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), "FE7CB391D650A284"), Local0)
			m600(arg0, 2, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), "FE7CB391D650A284"), Local0)
		m600(arg0, 3, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), "FE7CB391D650A284"), Local0)
		m600(arg0, 4, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), "FE7CB391D650A284"), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			"FE7CB391D650A284", Local0)
		m600(arg0, 6, Local0, bs1c)

		ToString(aub6, "FE7CB391D650A284", Local0)
		m600(arg0, 7, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), "FE7CB391D650A284", Local0)
			m600(arg0, 8, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), "FE7CB391D650A284", Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), "FE7CB391D650A284", Local0)
		m600(arg0, 10, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), "FE7CB391D650A284", Local0)
			m600(arg0, 11, Local0, bs1c)
		}
	}

	Method(m32h, 1)
	{
		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			"C179B3FE"), Local0)
		m600(arg0, 0, Local0, bs1c)

		Store(ToString(aub6, "C179B3FE"), Local0)
		m600(arg0, 1, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), "C179B3FE"), Local0)
			m600(arg0, 2, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), "C179B3FE"), Local0)
		m600(arg0, 3, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), "C179B3FE"), Local0)
		m600(arg0, 4, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), "C179B3FE"), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			"C179B3FE", Local0)
		m600(arg0, 6, Local0, bs1c)

		ToString(aub6, "C179B3FE", Local0)
		m600(arg0, 7, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), "C179B3FE", Local0)
			m600(arg0, 8, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), "C179B3FE", Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), "C179B3FE", Local0)
		m600(arg0, 10, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), "C179B3FE", Local0)
			m600(arg0, 11, Local0, bs1c)
		}
	}

	// String to Integer conversion of the String Index (second)
	// operand of the Index operator
	Method(m02d, 1)
	{
		Store(Index(aus6, "B"), Local0)
		m600(arg0, 0, Derefof(Local0), bi10)

		Store(Index(aub6, "B"), Local0)
		m600(arg0, 1, Derefof(Local0), bi10)

		Store(Index(aup0, "B"), Local0)
		m600(arg0, 2, Derefof(Local0), bi11)

		if (y078) {
			Store(Index(Derefof(Refof(aus6)), "B"), Local0)
			m600(arg0, 3, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aub6)), "B"), Local0)
			m600(arg0, 4, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aup0)), "B"), Local0)
			m600(arg0, 5, Derefof(Local0), bi11)
		}

		Store(Index(Derefof(Index(paus, 6)), "B"), Local0)
		m600(arg0, 6, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paub, 6)), "B"), Local0)
		m600(arg0, 7, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paup, 0)), "B"), Local0)
		m600(arg0, 8, Derefof(Local0), bi11)


		// Method returns Object

		if (y900) {
			Store(Index(m601(2, 6), "B"), Local0)
			m600(arg0, 9, Derefof(Local0), bi10)

			Store(Index(m601(3, 6), "B"), Local0)
			m600(arg0, 10, Derefof(Local0), bi10)

			Store(Index(m601(4, 0), "B"), Local0)
			m600(arg0, 11, Derefof(Local0), bi11)
		} else {

			CH03(arg0, z085, 0, 0, 0)

			Store(Index(m601(2, 6), "B"), Local3)
			CH04(arg0, 0, 85, z085, 9, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Store(Index(m601(3, 6), "B"), Local3)
			CH04(arg0, 0, 85, z085, 10, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Store(Index(m601(4, 0), "B"), Local3)
			CH04(arg0, 0, 85, z085, 11, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED
		}


		// Method returns Reference

		if (y500) {
			Store(Index(Derefof(m602(2, 6, 1)), "B"), Local0)
			m600(arg0, 12, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(3, 6, 1)), "B"), Local0)
			m600(arg0, 13, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(4, 0, 1)), "B"), Local0)
			m600(arg0, 14, Derefof(Local0), bi11)
		}

		Index(aus6, "B", Local0)
		m600(arg0, 15, Derefof(Local0), bi10)

		Index(aub6, "B", Local0)
		m600(arg0, 16, Derefof(Local0), bi10)

		Index(aup0, "B", Local0)
		m600(arg0, 17, Derefof(Local0), bi11)

		if (y078) {
			Index(Derefof(Refof(aus6)), "B", Local0)
			m600(arg0, 18, Derefof(Local0), bi10)

			Index(Derefof(Refof(aub6)), "B", Local0)
			m600(arg0, 19, Derefof(Local0), bi10)

			Index(Derefof(Refof(aup0)), "B", Local0)
			m600(arg0, 20, Derefof(Local0), bi11)
		}

		Index(Derefof(Index(paus, 6)), "B", Local0)
		m600(arg0, 21, Derefof(Local0), bi10)

		Index(Derefof(Index(paub, 6)), "B", Local0)
		m600(arg0, 22, Derefof(Local0), bi10)

		Index(Derefof(Index(paup, 0)), "B", Local0)
		m600(arg0, 23, Derefof(Local0), bi11)


		// Method returns Object

		if (y900) {
			Index(m601(2, 6), "B", Local0)
			m600(arg0, 24, Derefof(Local0), bi10)

			Index(m601(3, 6), "B", Local0)
			m600(arg0, 25, Derefof(Local0), bi10)

			Index(m601(4, 0), "B", Local0)
			m600(arg0, 26, Derefof(Local0), bi11)
		} else {

			CH03(arg0, z085, 0, 0, 0)

			Index(m601(2, 6), "B", Local0)
			CH04(arg0, 0, 85, z085, 24, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Index(m601(3, 6), "B", Local0)
			CH04(arg0, 0, 85, z085, 25, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Index(m601(4, 0), "B", Local0)
			CH04(arg0, 0, 85, z085, 26, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED
		}


		// Method returns Reference

		if (y500) {
			Index(Derefof(m602(2, 6, 1)), "B", Local0)
			m600(arg0, 27, Derefof(Local0), bi10)

			Index(Derefof(m602(3, 6, 1)), "B", Local0)
			m600(arg0, 28, Derefof(Local0), bi10)

			Index(Derefof(m602(4, 0, 1)), "B", Local0)
			m600(arg0, 29, Derefof(Local0), bi11)
		}

		if (y098) {
			Store(Index(aus6, "B", Local1), Local0)
			m600(arg0, 30, Derefof(Local0), bi10)

			Store(Index(aub6, "B", Local1), Local0)
			m600(arg0, 31, Derefof(Local0), bi10)

			Store(Index(aup0, "B", Local1), Local0)
			m600(arg0, 32, Derefof(Local0), bi11)
		}

		if (y078) {
			Store(Index(Derefof(Refof(aus6)), "B", Local1), Local0)
			m600(arg0, 33, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aub6)), "B", Local1), Local0)
			m600(arg0, 34, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aup0)), "B", Local1), Local0)
			m600(arg0, 35, Derefof(Local0), bi11)
		}

		if (y098) {
		Store(Index(Derefof(Index(paus, 6)), "B", Local1), Local0)
		m600(arg0, 36, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paub, 6)), "B", Local1), Local0)
		m600(arg0, 37, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paup, 0)), "B", Local1), Local0)
		m600(arg0, 38, Derefof(Local0), bi11)
		}

		// Method returns Object

		if (LAnd(y900, y098)) {
			Store(Index(m601(2, 6), "B", Local1), Local0)
			m600(arg0, 39, Derefof(Local0), bi10)

			Store(Index(m601(3, 6), "B", Local1), Local0)
			m600(arg0, 40, Derefof(Local0), bi10)

			Store(Index(m601(4, 0), "B", Local1), Local0)
			m600(arg0, 41, Derefof(Local0), bi11)
		}

		// Method returns Reference

		if (y500) {
			Store(Index(Derefof(m602(2, 6, 1)), "B", Local1), Local0)
			m600(arg0, 42, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(3, 6, 1)), "B", Local1), Local0)
			m600(arg0, 43, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(4, 0, 1)), "B", Local1), Local0)
			m600(arg0, 44, Derefof(Local0), bi11)
		}
	}

	// String to Integer conversion of the String Arg (third)
	// operand of the Fatal operator
	// (it can only be checked an exception does not occur)
	Method(m02e, 1)
	{
		CH03(arg0, z085, 0, 0, 0)
		Fatal(0xff, 0xffffffff, "0321")
		if (F64) {
			Fatal(0xff, 0xffffffff, "FE7CB391D650A284")
		} else {
			Fatal(0xff, 0xffffffff, "C179B3FE")
		}
		CH03(arg0, z085, 1, 0, 0)
	}

	// String to Integer conversion of the String Index and Length
	// operands of the Mid operator

	// Common 32-bit/64-bit test
	Method(m02f, 1)
	{
		// String to Integer conversion of the String Index operand

		Store(Mid("This is auxiliary String", "B", 10), Local0)
		m600(arg0, 0, Local0, bs1d)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, "B", 10), Local0)
		m600(arg0, 1, Local0, bb32)

		Store(Mid(aus6, "B", 10), Local0)
		m600(arg0, 2, Local0, bs1d)

		Store(Mid(aub6, "B", 10), Local0)
		m600(arg0, 3, Local0, bb32)


		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), "B", 10), Local0)
			m600(arg0, 4, Local0, bs1d)

			Store(Mid(Derefof(Refof(aub6)), "B", 10), Local0)
			m600(arg0, 5, Local0, bb32)
		}

		Store(Mid(Derefof(Index(paus, 6)), "B", 10), Local0)
		m600(arg0, 6, Local0, bs1d)

		Store(Mid(Derefof(Index(paub, 6)), "B", 10), Local0)
		m600(arg0, 7, Local0, bb32)

		// Method returns Object

		Store(Mid(m601(2, 6), "B", 10), Local0)
		m600(arg0, 8, Local0, bs1d)

		Store(Mid(m601(3, 6), "B", 10), Local0)
		m600(arg0, 9, Local0, bb32)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), "B", 10), Local0)
			m600(arg0, 10, Local0, bs1d)

			Store(Mid(Derefof(m602(3, 6, 1)), "B", 10), Local0)
			m600(arg0, 11, Local0, bb32)
		}

		Mid("This is auxiliary String", "B", 10, Local0)
		m600(arg0, 12, Local0, bs1d)

		Mid(Buffer(){"This is auxiliary Buffer"}, "B", 10, Local0)
		m600(arg0, 13, Local0, bb32)

		Mid(aus6, "B", 10, Local0)
		m600(arg0, 14, Local0, bs1d)

		Mid(aub6, "B", 10, Local0)
		m600(arg0, 15, Local0, bb32)


		if (y078) {
			Mid(Derefof(Refof(aus6)), "B", 10, Local0)
			m600(arg0, 16, Local0, bs1d)

			Mid(Derefof(Refof(aub6)), "B", 10, Local0)
			m600(arg0, 17, Local0, bb32)
		}

		Mid(Derefof(Index(paus, 6)), "B", 10, Local0)
		m600(arg0, 18, Local0, bs1d)

		Mid(Derefof(Index(paub, 6)), "B", 10, Local0)
		m600(arg0, 19, Local0, bb32)

		// Method returns Object

		Mid(m601(2, 6), "B", 10, Local0)
		m600(arg0, 20, Local0, bs1d)

		Mid(m601(3, 6), "B", 10, Local0)
		m600(arg0, 21, Local0, bb32)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), "B", 10, Local0)
			m600(arg0, 22, Local0, bs1d)

			Mid(Derefof(m602(3, 6, 1)), "B", 10, Local0)
			m600(arg0, 23, Local0, bb32)
		}

		// String to Integer conversion of the String Length operand

		Store(Mid("This is auxiliary String", 0, "B"), Local0)
		m600(arg0, 24, Local0, bs1b)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, "B"), Local0)
		m600(arg0, 25, Local0, bb33)

		Store(Mid(aus6, 0, "B"), Local0)
		m600(arg0, 26, Local0, bs1b)

		Store(Mid(aub6, 0, "B"), Local0)
		m600(arg0, 27, Local0, bb33)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, "B"), Local0)
			m600(arg0, 28, Local0, bs1b)

			Store(Mid(Derefof(Refof(aub6)), 0, "B"), Local0)
			m600(arg0, 29, Local0, bb33)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, "B"), Local0)
		m600(arg0, 30, Local0, bs1b)

		Store(Mid(Derefof(Index(paub, 6)), 0, "B"), Local0)
		m600(arg0, 31, Local0, bb33)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, "B"), Local0)
		m600(arg0, 32, Local0, bs1b)

		Store(Mid(m601(3, 6), 0, "B"), Local0)
		m600(arg0, 33, Local0, bb33)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, "B"), Local0)
			m600(arg0, 34, Local0, bs1b)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, "B"), Local0)
			m600(arg0, 35, Local0, bb33)
		}

		Mid("This is auxiliary String", 0, "B", Local0)
		m600(arg0, 36, Local0, bs1b)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, "B", Local0)
		m600(arg0, 37, Local0, bb33)

		Mid(aus6, 0, "B", Local0)
		m600(arg0, 37, Local0, bs1b)

		Mid(aub6, 0, "B", Local0)
		m600(arg0, 39, Local0, bb33)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, "B", Local0)
			m600(arg0, 40, Local0, bs1b)

			Mid(Derefof(Refof(aub6)), 0, "B", Local0)
			m600(arg0, 41, Local0, bb33)
		}

		Mid(Derefof(Index(paus, 6)), 0, "B", Local0)
		m600(arg0, 42, Local0, bs1b)

		Mid(Derefof(Index(paub, 6)), 0, "B", Local0)
		m600(arg0, 43, Local0, bb33)

		// Method returns Object

		Mid(m601(2, 6), 0, "B", Local0)
		m600(arg0, 44, Local0, bs1b)

		Mid(m601(3, 6), 0, "B", Local0)
		m600(arg0, 45, Local0, bb33)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, "B", Local0)
			m600(arg0, 46, Local0, bs1b)

			Mid(Derefof(m602(3, 6, 1)), 0, "B", Local0)
			m600(arg0, 47, Local0, bb33)
		}
	}

	Method(m64i, 1)
	{
		// String to Integer conversion of the String Length operand

		Store(Mid("This is auxiliary String", 0, "FE7CB391D650A284"), Local0)
		m600(arg0, 0, Local0, bs1e)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, "FE7CB391D650A284"), Local0)
		m600(arg0, 1, Local0, bb34)

		Store(Mid(aus6, 0, "FE7CB391D650A284"), Local0)
		m600(arg0, 2, Local0, bs1e)

		Store(Mid(aub6, 0, "FE7CB391D650A284"), Local0)
		m600(arg0, 3, Local0, bb34)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, "FE7CB391D650A284"), Local0)
			m600(arg0, 4, Local0, bs1e)

			Store(Mid(Derefof(Refof(aub6)), 0, "FE7CB391D650A284"), Local0)
			m600(arg0, 5, Local0, bb34)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, "FE7CB391D650A284"), Local0)
		m600(arg0, 6, Local0, bs1e)

		Store(Mid(Derefof(Index(paub, 6)), 0, "FE7CB391D650A284"), Local0)
		m600(arg0, 7, Local0, bb34)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, "FE7CB391D650A284"), Local0)
		m600(arg0, 8, Local0, bs1e)

		Store(Mid(m601(3, 6), 0, "FE7CB391D650A284"), Local0)
		m600(arg0, 9, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, "FE7CB391D650A284"), Local0)
			m600(arg0, 10, Local0, bs1e)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, "FE7CB391D650A284"), Local0)
			m600(arg0, 11, Local0, bb34)
		}

		Mid("This is auxiliary String", 0, "FE7CB391D650A284", Local0)
		m600(arg0, 12, Local0, bs1e)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, "FE7CB391D650A284", Local0)
		m600(arg0, 13, Local0, bb34)

		Mid(aus6, 0, "FE7CB391D650A284", Local0)
		m600(arg0, 14, Local0, bs1e)

		Mid(aub6, 0, "FE7CB391D650A284", Local0)
		m600(arg0, 15, Local0, bb34)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, "FE7CB391D650A284", Local0)
			m600(arg0, 16, Local0, bs1e)

			Mid(Derefof(Refof(aub6)), 0, "FE7CB391D650A284", Local0)
			m600(arg0, 17, Local0, bb34)
		}

		Mid(Derefof(Index(paus, 6)), 0, "FE7CB391D650A284", Local0)
		m600(arg0, 18, Local0, bs1e)

		Mid(Derefof(Index(paub, 6)), 0, "FE7CB391D650A284", Local0)
		m600(arg0, 19, Local0, bb34)

		// Method returns Object

		Mid(m601(2, 6), 0, "FE7CB391D650A284", Local0)
		m600(arg0, 20, Local0, bs1e)

		Mid(m601(3, 6), 0, "FE7CB391D650A284", Local0)
		m600(arg0, 21, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, "FE7CB391D650A284", Local0)
			m600(arg0, 22, Local0, bs1e)

			Mid(Derefof(m602(3, 6, 1)), 0, "FE7CB391D650A284", Local0)
			m600(arg0, 23, Local0, bb34)
		}

		// String to Integer conversion of the both String operands

		Store(Mid("This is auxiliary String", "B", "FE7CB391D650A284"), Local0)
		m600(arg0, 24, Local0, bs1f)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, "B", "FE7CB391D650A284"), Local0)
		m600(arg0, 25, Local0, bb35)

		Store(Mid(aus6, "B", "FE7CB391D650A284"), Local0)
		m600(arg0, 26, Local0, bs1f)

		Store(Mid(aub6, "B", "FE7CB391D650A284"), Local0)
		m600(arg0, 27, Local0, bb35)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), "B", "FE7CB391D650A284"), Local0)
			m600(arg0, 28, Local0, bs1f)

			Store(Mid(Derefof(Refof(aub6)), "B", "FE7CB391D650A284"), Local0)
			m600(arg0, 29, Local0, bb35)
		}

		Store(Mid(Derefof(Index(paus, 6)), "B", "FE7CB391D650A284"), Local0)
		m600(arg0, 30, Local0, bs1f)

		Store(Mid(Derefof(Index(paub, 6)), "B", "FE7CB391D650A284"), Local0)
		m600(arg0, 31, Local0, bb35)

		// Method returns Object

		Store(Mid(m601(2, 6), "B", "FE7CB391D650A284"), Local0)
		m600(arg0, 32, Local0, bs1f)

		Store(Mid(m601(3, 6), "B", "FE7CB391D650A284"), Local0)
		m600(arg0, 33, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), "B", "FE7CB391D650A284"), Local0)
			m600(arg0, 34, Local0, bs1f)

			Store(Mid(Derefof(m602(3, 6, 1)), "B", "FE7CB391D650A284"), Local0)
			m600(arg0, 35, Local0, bb35)
		}

		Mid("This is auxiliary String", "B", "FE7CB391D650A284", Local0)
		m600(arg0, 36, Local0, bs1f)

		Mid(Buffer(){"This is auxiliary Buffer"}, "B", "FE7CB391D650A284", Local0)
		m600(arg0, 37, Local0, bb35)

		Mid(aus6, "B", "FE7CB391D650A284", Local0)
		m600(arg0, 38, Local0, bs1f)

		Mid(aub6, "B", "FE7CB391D650A284", Local0)
		m600(arg0, 39, Local0, bb35)


		if (y078) {
			Mid(Derefof(Refof(aus6)), "B", "FE7CB391D650A284", Local0)
			m600(arg0, 40, Local0, bs1f)

			Mid(Derefof(Refof(aub6)), "B", "FE7CB391D650A284", Local0)
			m600(arg0, 41, Local0, bb35)
		}

		Mid(Derefof(Index(paus, 6)), "B", "FE7CB391D650A284", Local0)
		m600(arg0, 42, Local0, bs1f)

		Mid(Derefof(Index(paub, 6)), "B", "FE7CB391D650A284", Local0)
		m600(arg0, 43, Local0, bb35)

		// Method returns Object

		Mid(m601(2, 6), "B", "FE7CB391D650A284", Local0)
		m600(arg0, 44, Local0, bs1f)

		Mid(m601(3, 6), "B", "FE7CB391D650A284", Local0)
		m600(arg0, 45, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), "B", "FE7CB391D650A284", Local0)
			m600(arg0, 46, Local0, bs1f)

			Mid(Derefof(m602(3, 6, 1)), "B", "FE7CB391D650A284", Local0)
			m600(arg0, 47, Local0, bb35)
		}
	}

	Method(m32i, 1)
	{
		// String to Integer conversion of the String Length operand

		Store(Mid("This is auxiliary String", 0, "C179B3FE"), Local0)
		m600(arg0, 0, Local0, bs1e)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, "C179B3FE"), Local0)
		m600(arg0, 1, Local0, bb34)

		Store(Mid(aus6, 0, "C179B3FE"), Local0)
		m600(arg0, 2, Local0, bs1e)

		Store(Mid(aub6, 0, "C179B3FE"), Local0)
		m600(arg0, 3, Local0, bb34)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, "C179B3FE"), Local0)
			m600(arg0, 4, Local0, bs1e)

			Store(Mid(Derefof(Refof(aub6)), 0, "C179B3FE"), Local0)
			m600(arg0, 5, Local0, bb34)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, "C179B3FE"), Local0)
		m600(arg0, 6, Local0, bs1e)

		Store(Mid(Derefof(Index(paub, 6)), 0, "C179B3FE"), Local0)
		m600(arg0, 7, Local0, bb34)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, "C179B3FE"), Local0)
		m600(arg0, 8, Local0, bs1e)

		Store(Mid(m601(3, 6), 0, "C179B3FE"), Local0)
		m600(arg0, 9, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, "C179B3FE"), Local0)
			m600(arg0, 10, Local0, bs1e)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, "C179B3FE"), Local0)
			m600(arg0, 11, Local0, bb34)
		}

		Mid("This is auxiliary String", 0, "C179B3FE", Local0)
		m600(arg0, 12, Local0, bs1e)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, "C179B3FE", Local0)
		m600(arg0, 13, Local0, bb34)

		Mid(aus6, 0, "C179B3FE", Local0)
		m600(arg0, 14, Local0, bs1e)

		Mid(aub6, 0, "C179B3FE", Local0)
		m600(arg0, 15, Local0, bb34)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, "C179B3FE", Local0)
			m600(arg0, 16, Local0, bs1e)

			Mid(Derefof(Refof(aub6)), 0, "C179B3FE", Local0)
			m600(arg0, 17, Local0, bb34)
		}

		Mid(Derefof(Index(paus, 6)), 0, "C179B3FE", Local0)
		m600(arg0, 18, Local0, bs1e)

		Mid(Derefof(Index(paub, 6)), 0, "C179B3FE", Local0)
		m600(arg0, 19, Local0, bb34)

		// Method returns Object

		Mid(m601(2, 6), 0, "C179B3FE", Local0)
		m600(arg0, 20, Local0, bs1e)

		Mid(m601(3, 6), 0, "C179B3FE", Local0)
		m600(arg0, 21, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, "C179B3FE", Local0)
			m600(arg0, 22, Local0, bs1e)

			Mid(Derefof(m602(3, 6, 1)), 0, "C179B3FE", Local0)
			m600(arg0, 23, Local0, bb34)
		}

		// String to Integer conversion of the both String operands

		Store(Mid("This is auxiliary String", "B", "C179B3FE"), Local0)
		m600(arg0, 24, Local0, bs1f)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, "B", "C179B3FE"), Local0)
		m600(arg0, 25, Local0, bb35)

		Store(Mid(aus6, "B", "C179B3FE"), Local0)
		m600(arg0, 26, Local0, bs1f)

		Store(Mid(aub6, "B", "C179B3FE"), Local0)
		m600(arg0, 27, Local0, bb35)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), "B", "C179B3FE"), Local0)
			m600(arg0, 28, Local0, bs1f)

			Store(Mid(Derefof(Refof(aub6)), "B", "C179B3FE"), Local0)
			m600(arg0, 29, Local0, bb35)
		}

		Store(Mid(Derefof(Index(paus, 6)), "B", "C179B3FE"), Local0)
		m600(arg0, 30, Local0, bs1f)

		Store(Mid(Derefof(Index(paub, 6)), "B", "C179B3FE"), Local0)
		m600(arg0, 31, Local0, bb35)

		// Method returns Object

		Store(Mid(m601(2, 6), "B", "C179B3FE"), Local0)
		m600(arg0, 32, Local0, bs1f)

		Store(Mid(m601(3, 6), "B", "C179B3FE"), Local0)
		m600(arg0, 33, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), "B", "C179B3FE"), Local0)
			m600(arg0, 34, Local0, bs1f)

			Store(Mid(Derefof(m602(3, 6, 1)), "B", "C179B3FE"), Local0)
			m600(arg0, 35, Local0, bb35)
		}

		Mid("This is auxiliary String", "B", "C179B3FE", Local0)
		m600(arg0, 36, Local0, bs1f)

		Mid(Buffer(){"This is auxiliary Buffer"}, "B", "C179B3FE", Local0)
		m600(arg0, 37, Local0, bb35)

		Mid(aus6, "B", "C179B3FE", Local0)
		m600(arg0, 38, Local0, bs1f)

		Mid(aub6, "B", "C179B3FE", Local0)
		m600(arg0, 39, Local0, bb35)


		if (y078) {
			Mid(Derefof(Refof(aus6)), "B", "C179B3FE", Local0)
			m600(arg0, 40, Local0, bs1f)

			Mid(Derefof(Refof(aub6)), "B", "C179B3FE", Local0)
			m600(arg0, 41, Local0, bb35)
		}

		Mid(Derefof(Index(paus, 6)), "B", "C179B3FE", Local0)
		m600(arg0, 42, Local0, bs1f)

		Mid(Derefof(Index(paub, 6)), "B", "C179B3FE", Local0)
		m600(arg0, 43, Local0, bb35)

		// Method returns Object

		Mid(m601(2, 6), "B", "C179B3FE", Local0)
		m600(arg0, 44, Local0, bs1f)

		Mid(m601(3, 6), "B", "C179B3FE", Local0)
		m600(arg0, 45, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), "B", "C179B3FE", Local0)
			m600(arg0, 46, Local0, bs1f)

			Mid(Derefof(m602(3, 6, 1)), "B", "C179B3FE", Local0)
			m600(arg0, 47, Local0, bb35)
		}
	}

	// String to Integer conversion of the String StartIndex
	// operand of the Match operator
	Method(m030, 1)
	{
		Store(Match(
			Package(){
				0xa50, 0xa51, 0xa52, 0xa53, 0xa54, 0xa55, 0xa56, 0xa57,
				0xa58, 0xa59, 0xa5a, 0xa5b, 0xa5c, 0xa5d, 0xa5e,},
			MEQ, 0xa5d, MTR, 0, "B"), Local0)
		m600(arg0, 0, Local0, 0xd)

		Store(Match(
			Package(){
				0xa50, 0xa51, 0xa52, 0xa53, 0xa54, 0xa55, 0xa56, 0xa57,
				0xa58, 0xa59, 0xa5a, 0xa5b, 0xa5c, 0xa5d, 0xa5e,},
			MEQ, 0xa5a, MTR, 0, "B"), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(aup0, MEQ, 0xa5d, MTR, 0, "B"), Local0)
		m600(arg0, 2, Local0, 0xd)

		Store(Match(aup0, MEQ, 0xa5a, MTR, 0, "B"), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Match(Derefof(Refof(aup0)), MEQ, 0xa5d, MTR, 0, "B"), Local0)
			m600(arg0, 4, Local0, 0xd)

			Store(Match(Derefof(Refof(aup0)), MEQ, 0xa5a, MTR, 0, "B"), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Match(Derefof(Index(paup, 0)), MEQ, 0xa5d, MTR, 0, "B"), Local0)
		m600(arg0, 6, Local0, 0xd)

		Store(Match(Derefof(Index(paup, 0)), MEQ, 0xa5a, MTR, 0, "B"), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Object

		Store(Match(m601(4, 0), MEQ, 0xa5d, MTR, 0, "B"), Local0)
		m600(arg0, 8, Local0, 0xd)

		Store(Match(m601(4, 0), MEQ, 0xa5a, MTR, 0, "B"), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference

		if (y500) {
			Store(Match(Derefof(m602(4, 0, 1)), MEQ, 0xa5d, MTR, 0, "B"), Local0)
			m600(arg0, 10, Local0, 0xd)

			Store(Match(Derefof(m602(4, 0, 1)), MEQ, 0xa5a, MTR, 0, "B"), Local0)
			m600(arg0, 11, Local0, Ones)
		}
	}

	// String to Integer conversion of the String elements
	// of a search package of Match operator when some
	// MatchObject is evaluated as Integer

	Method(m64j, 1)
	{
		Store(Match(Package(){"FE7CB391D650A284"},
			MEQ, 0xfe7cb391d650a284, MTR, 0, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Match(Package(){"FE7CB391D650A284"},
			MEQ, 0xfe7cb391d650a285, MTR, 0, 0), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(Package(){"FE7CB391D650A284"},
			MTR, 0, MEQ, 0xfe7cb391d650a284, 0), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Match(Package(){"FE7CB391D650A284"},
			MTR, 0, MEQ, 0xfe7cb391d650a285, 0), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(Match(Package(){"fE7CB391D650A284"},
			MEQ, 0xfe7cb391d650a284, MTR, 0, 0), Local0)
		m600(arg0, 4, Local0, 0)

		Store(Match(Package(){"fE7CB391D650A284"},
			MEQ, 0xfe7cb391d650a285, MTR, 0, 0), Local0)
		m600(arg0, 5, Local0, Ones)

		Store(Match(Package(){"fE7CB391D650A284"},
			MTR, 0, MEQ, 0xfe7cb391d650a284, 0), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Match(Package(){"fE7CB391D650A284"},
			MTR, 0, MEQ, 0xfe7cb391d650a285, 0), Local0)
		m600(arg0, 7, Local0, Ones)
	}

	Method(m32j, 1)
	{
		Store(Match(Package(){"C179B3FE"},
			MEQ, 0xc179b3fe, MTR, 0, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Match(Package(){"C179B3FE"},
			MEQ, 0xc179b3ff, MTR, 0, 0), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(Package(){"C179B3FE"},
			MTR, 0, MEQ, 0xc179b3fe, 0), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Match(Package(){"C179B3FE"},
			MTR, 0, MEQ, 0xc179b3ff, 0), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(Match(Package(){"c179B3FE"},
			MEQ, 0xc179b3fe, MTR, 0, 0), Local0)
		m600(arg0, 4, Local0, 0)

		Store(Match(Package(){"c179B3FE"},
			MEQ, 0xc179b3ff, MTR, 0, 0), Local0)
		m600(arg0, 5, Local0, Ones)

		Store(Match(Package(){"c179B3FE"},
			MTR, 0, MEQ, 0xc179b3fe, 0), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Match(Package(){"c179B3FE"},
			MTR, 0, MEQ, 0xc179b3ff, 0), Local0)
		m600(arg0, 7, Local0, Ones)
	}

	// String to Integer conversion of the String sole operand
	// of the Method execution control operators (Sleep, Stall)
	Method(m031, 1)
	{
		CH03(arg0, z085, 2, 0, 0)

		// Sleep

		Store(Timer, Local0)

		Sleep("0321")
		CH03(arg0, z085, 3, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z085, 0, 0, 0, Local2, c08c)
		}

		// Stall

		Store(Timer, Local0)

		Stall("63")
		CH03(arg0, z085, 4, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, 990)) {
			err(arg0, z085, 1, 0, 0, Local2, 990)
		}
	}

	// String to Integer conversion of the String TimeoutValue
	// (second) operand of the Acquire operator ???
	Method(m032, 1, Serialized)
	{
		Mutex(MTX0, 0)

		Acquire(MTX0, 0)
		CH03(arg0, z085, 5, 0, 0)

		Store(Timer, Local0)

/* Compiler allows only Integer constant as TimeoutValue (Bug 1)
		Acquire(MTX0, "0321")
*/
		CH03(arg0, z085, 6, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z085, 0, 0, 0, Local2, c08c)
		}
	}

	// String to Integer conversion of the String TimeoutValue
	// (second) operand of the Wait operator
	Method(m033, 1, Serialized)
	{
		Event(EVT0)

		CH03(arg0, z085, 7, 0, 0)

		Store(Timer, Local0)

		Wait(EVT0, "0321")
		CH03(arg0, z085, 8, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z085, 0, 0, 0, Local2, c08c)
		}
	}

	// String to Integer conversion of the String value
	// of Predicate of the Method execution control statements
	// (If, ElseIf, While)
	Method(m034, 1, Serialized)
	{
		Name(ist0, 0)

		Method(m001)
		{
			if ("0") {
				Store(0, ist0)
			}
		}

		Method(m002)
		{
			if ("0321") {
				Store(2, ist0)
			}
		}

		Method(m003)
		{
			if ("C179B3FE") {
				Store(3, ist0)
			}
		}

		Method(m004)
		{
			if ("FE7CB391D650A284") {
				Store(4, ist0)
			}
		}

		Method(m005, 1)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif ("0") {
				Store(0, ist0)
			}
		}

		Method(m006, 1)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif ("0321") {
				Store(6, ist0)
			}
		}

		Method(m007, 1)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif ("C179B3FE") {
				Store(7, ist0)
			}
		}

		Method(m008, 1)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif ("FE7CB391D650A284") {
				Store(8, ist0)
			}
		}

		Method(m009)
		{
			while ("0") {
				Store(0, ist0)
			}
		}

		// If

		Store(1, ist0)
		m001()
		m600(arg0, 0, ist0, 1)

		m002()
		m600(arg0, 1, ist0, 2)

		m003()
		m600(arg0, 2, ist0, 3)

		m004()
		m600(arg0, 3, ist0, 4)

		// ElseIf

		Store(5, ist0)
		m005(0)
		m600(arg0, 4, ist0, 5)

		m006(0)
		m600(arg0, 5, ist0, 6)

		m007(0)
		m600(arg0, 6, ist0, 7)

		m008(0)
		m600(arg0, 7, ist0, 8)

		// While

		Store(9, ist0)
		m009()
		m600(arg0, 8, ist0, 9)
	}

	// String to Integer conversion of the String value
	// of Expression of Case statement when Expression in
	// Switch is evaluated as Integer

	Method(m64k, 1, Serialized)
	{
		Name(i000, 0)

		Store(0, i000)
		Switch (0xfe7cb391d650a285) {
			Case ("fE7CB391D650A284") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 0, i000, 2)

		Store(0, i000)
		Switch (0xfe7cb391d650a284) {
			Case ("fE7CB391D650A284") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 1, i000, 1)

		Store(0, i000)
		Switch (auid) {
			Case ("fE7CB391D650A284") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 2, i000, 2)

		Store(0, i000)
		Switch (aui4) {
			Case ("fE7CB391D650A284") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 3, i000, 1)

		if (y078) {
			Store(0, i000)
			Switch (Derefof(Refof(auid))) {
				Case ("fE7CB391D650A284") {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 4, i000, 2)

			Store(0, i000)
			Switch (Derefof(Refof(aui4))) {
				Case ("fE7CB391D650A284") {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 5, i000, 1)
		}

		Store(0, i000)
		Switch (Derefof(Index(paui, 13))) {
			Case ("fE7CB391D650A284") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 6, i000, 2)

		Store(0, i000)
		Switch (Derefof(Index(paui, 4))) {
			Case ("fE7CB391D650A284") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 7, i000, 1)

		// Method returns Integer

		Store(0, i000)
		Switch (m601(1, 13)) {
			Case ("fE7CB391D650A284") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 8, i000, 2)

		Store(0, i000)
		Switch (m601(1, 4)) {
			Case ("fE7CB391D650A284") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 9, i000, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(0, i000)
			Switch (Derefof(m602(1, 13, 1))) {
				Case ("fE7CB391D650A284") {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 10, i000, 2)

			Store(0, i000)
			Switch (Derefof(m602(1, 4, 1))) {
				Case ("fE7CB391D650A284") {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 11, i000, 1)
		}
	}

	Method(m32k, 1, Serialized)
	{
		Name(i000, 0)

		Store(0, i000)
		Switch (0xc179b3ff) {
			Case ("c179B3FE") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 0, i000, 2)

		Store(0, i000)
		Switch (0xc179b3fe) {
			Case ("c179B3FE") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 1, i000, 1)

		Store(0, i000)
		Switch (auic) {
			Case ("c179B3FE") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 2, i000, 2)

		Store(0, i000)
		Switch (aui3) {
			Case ("c179B3FE") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 3, i000, 1)

		if (y078) {
			Store(0, i000)
			Switch (Derefof(Refof(auic))) {
				Case ("c179B3FE") {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 4, i000, 2)

			Store(0, i000)
			Switch (Derefof(Refof(aui3))) {
				Case ("c179B3FE") {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 5, i000, 1)
		}

		Store(0, i000)
		Switch (Derefof(Index(paui, 12))) {
			Case ("c179B3FE") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 6, i000, 2)

		Store(0, i000)
		Switch (Derefof(Index(paui, 3))) {
			Case ("c179B3FE") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 7, i000, 1)

		// Method returns Integer

		Store(0, i000)
		Switch (m601(1, 12)) {
			Case ("c179B3FE") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 8, i000, 2)

		Store(0, i000)
		Switch (m601(1, 3)) {
			Case ("c179B3FE") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 9, i000, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(0, i000)
			Switch (Derefof(m602(1, 12, 1))) {
				Case ("c179B3FE") {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 10, i000, 2)

			Store(0, i000)
			Switch (Derefof(m602(1, 3, 1))) {
				Case ("c179B3FE") {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 11, i000, 1)
		}
	}

	// String to Buffer implicit conversion Cases.

	// String to Buffer conversion of the String second operand of
	// Logical operators when the first operand is evaluated as Buffer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)

	Method(m035, 1)
	{		
		// LEqual

		Store(LEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, "0321"), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, "0321"), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aub7, "0321"), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(aub3, "0321"), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aub7)), "0321"), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(aub3)), "0321"), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paub, 7)), "0321"), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paub, 3)), "0321"), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns Buffer

		Store(LEqual(m601(3, 7), "0321"), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(3, 3), "0321"), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LEqual(Derefof(m602(3, 7, 1)), "0321"), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(3, 3, 1)), "0321"), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, "0321"), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater(Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, "0321"), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater(Buffer() {0x30, 0x33, 0x32, 0x31}, "0321"), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00, 0x01}, "0321"), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aub7, "0321"), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(aub8, "0321"), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aub7)), "0321"), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(aub8)), "0321"), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paub, 7)), "0321"), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paub, 8)), "0321"), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Buffer

		Store(LGreater(m601(3, 7), "0321"), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(3, 8), "0321"), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreater(Derefof(m602(3, 7, 1)), "0321"), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(3, 8, 1)), "0321"), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, "0321"), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, "0321"), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0x30, 0x33, 0x32, 0x31}, "0321"), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00, 0x01}, "0321"), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aub7, "0321"), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(aub8, "0321"), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aub7)), "0321"), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(aub8)), "0321"), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paub, 7)), "0321"), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paub, 8)), "0321"), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns Buffer

		Store(LGreaterEqual(m601(3, 7), "0321"), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(3, 8), "0321"), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(3, 7, 1)), "0321"), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(3, 8, 1)), "0321"), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, "0321"), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess(Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, "0321"), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess(Buffer() {0x30, 0x33, 0x32, 0x31}, "0321"), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00, 0x01}, "0321"), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aub7, "0321"), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(aub8, "0321"), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aub7)), "0321"), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(aub8)), "0321"), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paub, 7)), "0321"), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paub, 8)), "0321"), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns Buffer

		Store(LLess(m601(3, 7), "0321"), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(3, 8), "0321"), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLess(Derefof(m602(3, 7, 1)), "0321"), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(3, 8, 1)), "0321"), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, "0321"), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, "0321"), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual(Buffer() {0x30, 0x33, 0x32, 0x31}, "0321"), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00, 0x01}, "0321"), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aub7, "0321"), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(aub8, "0321"), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aub7)), "0321"), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(aub8)), "0321"), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paub, 7)), "0321"), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paub, 8)), "0321"), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns Buffer

		Store(LLessEqual(m601(3, 7), "0321"), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(3, 8), "0321"), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLessEqual(Derefof(m602(3, 7, 1)), "0321"), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(3, 8, 1)), "0321"), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, "0321"), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, "0321"), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual(Buffer() {0x30, 0x33, 0x32, 0x31}, "0321"), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual(Buffer() {0x30, 0x33, 0x32, 0x31, 0x00, 0x01}, "0321"), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aub7, "0321"), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(aub8, "0321"), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aub7)), "0321"), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(aub8)), "0321"), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paub, 7)), "0321"), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paub, 8)), "0321"), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns Buffer

		Store(LNotEqual(m601(3, 7), "0321"), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(3, 8), "0321"), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LNotEqual(Derefof(m602(3, 7, 1)), "0321"), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(3, 8, 1)), "0321"), Local0)
			m600(arg0, 81, Local0, Ones)
		}

		// Boundary Cases

		Store(LEqual(Buffer() {0x00}, ""), Local0)
		m600(arg0, 82, Local0, Ones)

		Store(LEqual(Buffer() {0x01}, ""), Local0)
		m600(arg0, 83, Local0, Zero)

		Store(LGreater(Buffer() {0x00}, ""), Local0)
		m600(arg0, 84, Local0, Zero)

		Store(LGreater(Buffer() {0x01}, ""), Local0)
		m600(arg0, 85, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0x00}, ""), Local0)
		m600(arg0, 86, Local0, Ones)

		Store(LGreater(Buffer() {0x01}, ""), Local0)
		m600(arg0, 87, Local0, Ones)

		Store(LLess(Buffer() {0x00}, ""), Local0)
		m600(arg0, 88, Local0, Zero)

		Store(LLess(Buffer() {0x01}, ""), Local0)
		m600(arg0, 89, Local0, Zero)

		Store(LLessEqual(Buffer() {0x00}, ""), Local0)
		m600(arg0, 90, Local0, Ones)

		Store(LLessEqual(Buffer() {0x01}, ""), Local0)
		m600(arg0, 91, Local0, Zero)

		Store(LNotEqual(Buffer() {0x00}, ""), Local0)
		m600(arg0, 92, Local0, Zero)

		Store(LNotEqual(Buffer() {0x01}, ""), Local0)
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
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"),
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
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"),
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
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"),
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
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"),
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
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"),
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
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"),
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
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"),
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
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"),
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
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"),
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
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"),
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
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"),
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
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"),
			Local0)
		m600(arg0, 105, Local0, Ones)
	}

	// String to Buffer conversion of the String second operand of
	// Concatenate operator when the first operand is evaluated as Buffer

	Method(m036, 1)
	{		
		Store(Concatenate(Buffer(){0x5a}, "0321"), Local0)
		m600(arg0, 0, Local0, bb29)

		Store(Concatenate(Buffer(){0x5a, 0x00}, "0321"), Local0)
		m600(arg0, 1, Local0, bb2a)

		Store(Concatenate(aub0, "0321"), Local0)
		m600(arg0, 2, Local0, bb29)

		Store(Concatenate(aub1, "0321"), Local0)
		m600(arg0, 3, Local0, bb2a)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aub0)), "0321"), Local0)
			m600(arg0, 4, Local0, bb29)

			Store(Concatenate(Derefof(Refof(aub1)), "0321"), Local0)
			m600(arg0, 5, Local0, bb2a)
		}

		Store(Concatenate(Derefof(Index(paub, 0)), "0321"), Local0)
		m600(arg0, 6, Local0, bb29)

		Store(Concatenate(Derefof(Index(paub, 1)), "0321"), Local0)
		m600(arg0, 7, Local0, bb2a)

		// Method returns Buffer

		Store(Concatenate(m601(3, 0), "0321"), Local0)
		m600(arg0, 8, Local0, bb29)

		Store(Concatenate(m601(3, 1), "0321"), Local0)
		m600(arg0, 9, Local0, bb2a)

		// Method returns Reference to Buffer

		if (y500) {
			Store(Concatenate(Derefof(m602(3, 0, 1)), "0321"), Local0)
			m600(arg0, 10, Local0, bb29)

			Store(Concatenate(Derefof(m602(3, 1, 1)), "0321"), Local0)
			m600(arg0, 11, Local0, bb2a)
		}

		Concatenate(Buffer(){0x5a}, "0321", Local0)
		m600(arg0, 12, Local0, bb29)

		Concatenate(Buffer(){0x5a, 0x00}, "0321", Local0)
		m600(arg0, 13, Local0, bb2a)

		Concatenate(aub0, "0321", Local0)
		m600(arg0, 14, Local0, bb29)

		Concatenate(aub1, "0321", Local0)
		m600(arg0, 15, Local0, bb2a)

		if (y078) {
			Concatenate(Derefof(Refof(aub0)), "0321", Local0)
			m600(arg0, 16, Local0, bb29)

			Concatenate(Derefof(Refof(aub1)), "0321", Local0)
			m600(arg0, 17, Local0, bb2a)
		}

		Concatenate(Derefof(Index(paub, 0)), "0321", Local0)
		m600(arg0, 18, Local0, bb29)

		Concatenate(Derefof(Index(paub, 1)), "0321", Local0)
		m600(arg0, 19, Local0, bb2a)

		// Method returns Buffer

		Concatenate(m601(3, 0), "0321", Local0)
		m600(arg0, 20, Local0, bb29)

		Concatenate(m601(3, 1), "0321", Local0)
		m600(arg0, 21, Local0, bb2a)

		// Method returns Reference to Buffer

		if (y500) {
			Concatenate(Derefof(m602(3, 0, 1)), "0321", Local0)
			m600(arg0, 22, Local0, bb29)

			Concatenate(Derefof(m602(3, 1, 1)), "0321", Local0)
			m600(arg0, 23, Local0, bb2a)
		}

		// Boundary Cases

		Store(Concatenate(Buffer(){0x5a}, ""), Local0)
		m600(arg0, 24, Local0, bb2b)

		Store(Concatenate(Buffer(){0x5a, 0x00}, ""), Local0)
		m600(arg0, 25, Local0, bb2c)

		Store(Concatenate(Buffer(0){},
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"),
			Local0)
		m600(arg0, 26, Local0, bb2d)
	}

	// String to Buffer conversion of the String Source operand of
	// ToString operator (has a visual effect in shortening of the
	// String taken the null character, that is impossible to show
	// with an immediate String constant).

	Method(m037, 1)
	{
		Store(ToString("0321", Ones), Local0)
		m600(arg0, 0, Local0, bs20)

		Store(ToString("0321", 3), Local0)
		m600(arg0, 1, Local0, bs21)

		Store(ToString("0321", aui0), Local0)
		m600(arg0, 2, Local0, bs20)

		Store(ToString("0321", aui7), Local0)
		m600(arg0, 3, Local0, bs21)

		if (y078) {
			Store(ToString("0321", Derefof(Refof(aui0))), Local0)
			m600(arg0, 4, Local0, bs20)

			Store(ToString("0321", Derefof(Refof(aui7))), Local0)
			m600(arg0, 5, Local0, bs21)
		}

		Store(ToString("0321", Derefof(Index(paui, 0))), Local0)
		m600(arg0, 6, Local0, bs20)

		Store(ToString("0321", Derefof(Index(paui, 7))), Local0)
		m600(arg0, 7, Local0, bs21)

		// Method returns Length parameter

		Store(ToString("0321", m601(1, 0)), Local0)
		m600(arg0, 8, Local0, bs20)

		Store(ToString("0321", m601(1, 7)), Local0)
		m600(arg0, 9, Local0, bs21)

		// Method returns Reference to Length parameter

		if (y500) {
			Store(ToString("0321", Derefof(m601(1, 0))), Local0)
			m600(arg0, 10, Local0, bs20)

			Store(ToString("0321", Derefof(m601(1, 7))), Local0)
			m600(arg0, 11, Local0, bs21)
		}

		ToString("0321", Ones, Local0)
		m600(arg0, 12, Local0, bs20)

		ToString("0321", 3, Local0)
		m600(arg0, 13, Local0, bs21)

		ToString("0321", aui0, Local0)
		m600(arg0, 14, Local0, bs20)

		ToString("0321", aui7, Local0)
		m600(arg0, 15, Local0, bs21)

		if (y078) {
			ToString("0321", Derefof(Refof(aui0)), Local0)
			m600(arg0, 16, Local0, bs20)

			ToString("0321", Derefof(Refof(aui7)), Local0)
			m600(arg0, 17, Local0, bs21)
		}

		ToString("0321", Derefof(Index(paui, 0)), Local0)
		m600(arg0, 18, Local0, bs20)

		ToString("0321", Derefof(Index(paui, 7)), Local0)
		m600(arg0, 19, Local0, bs21)

		// Method returns Length parameter

		ToString("0321", m601(1, 0), Local0)
		m600(arg0, 20, Local0, bs20)

		ToString("0321", m601(1, 7), Local0)
		m600(arg0, 21, Local0, bs21)

		// Method returns Reference to Length parameter

		if (y500) {
			ToString("0321", Derefof(m601(1, 0)), Local0)
			m600(arg0, 22, Local0, bs20)

			ToString("0321", Derefof(m601(1, 7)), Local0)
			m600(arg0, 23, Local0, bs21)
		}

		// Boundary Cases

		Store(ToString("", Ones), Local0)
		m600(arg0, 24, Local0, bs22)

		Store(ToString("", 3), Local0)
		m600(arg0, 25, Local0, bs22)

		Store(ToString(
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
				Ones), Local0)
		m600(arg0, 26, Local0, bs23)

		Store(ToString(
				"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
				3), Local0)
		m600(arg0, 27, Local0, bs24)
	}
	
	// String to Buffer conversion of the String elements of
	// a search package of Match operator when some MatchObject
	// is evaluated as Buffer

	Method(m038, 1)
	{
		Store(Match(Package(){"0321"},
			MEQ, Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, MTR, 0, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Match(Package(){"0321"},
			MEQ, Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, MTR, 0, 0), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(Package(){"0321"},
			MTR, 0, MEQ, Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}, 0), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Match(Package(){"0321"},
			MTR, 0, MEQ, Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}, 0), Local0)
		m600(arg0, 3, Local0, Ones)

		// Boundary Cases

		Store(Match(Package(){""},
			MEQ, Buffer() {0x00}, MTR, 0, 0), Local0)
		m600(arg0, 4, Local0, 0)

		Store(Match(Package(){""},
			MEQ, Buffer() {0x01}, MTR, 0, 0), Local0)
		m600(arg0, 5, Local0, Ones)

		Store(Match(Package(){""},
			MTR, 0, MEQ, Buffer() {0x00}, 0), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Match(Package(){""},
			MTR, 0, MEQ, Buffer() {0x01}, 0), Local0)
		m600(arg0, 7, Local0, Ones)

		Store(Match(Package(){"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"},
			MEQ,
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
			MTR, 0, 0), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Match(Package(){"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"},
			MEQ,
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
			MTR, 0, 0), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(Match(Package(){"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"},
			MTR, 0, MEQ,
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
			0), Local0)
		m600(arg0, 10, Local0, 0)

		Store(Match(Package(){"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*"},
			MTR, 0, MEQ,
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
			0), Local0)
		m600(arg0, 11, Local0, Ones)
	}

	// String to Buffer conversion of the String value of
	// Expression of Case statement when Expression in Switch
	// is either static Buffer data or explicitly converted to
	// Buffer by ToBuffer

	Method(m039, 1, Serialized)
	{
		Name(i000, 0)

		Store(0, i000)
		Switch (Buffer() {0x30, 0x33, 0x32, 0x31, 0x01}) {
			Case ("0321") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 0, i000, 2)

		Store(0, i000)
		Switch (Buffer() {0x30, 0x33, 0x32, 0x31, 0x00}) {
			Case ("0321") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 1, i000, 1)

		Store(0, i000)
		Switch (ToBuffer(aub8)) {
			Case ("0321") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 2, i000, 2)

		Store(0, i000)
		Switch (ToBuffer(aub7)) {
			Case ("0321") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 3, i000, 1)

		if (y078) {
			Store(0, i000)
			Switch (ToBuffer(Derefof(Refof(aub8)))) {
				Case ("0321") {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 4, i000, 2)

			Store(0, i000)
			Switch (ToBuffer(Derefof(Refof(aub7)))) {
				Case ("0321") {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 5, i000, 1)
		}

		Store(0, i000)
		Switch (ToBuffer(Derefof(Index(paub, 8)))) {
			Case ("0321") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 6, i000, 2)

		Store(0, i000)
		Switch (ToBuffer(Derefof(Index(paub, 7)))) {
			Case ("0321") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 7, i000, 1)

		// Method returns String

		Store(0, i000)
		Switch (ToBuffer(m601(3, 8))) {
			Case ("0321") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 8, i000, 2)

		Store(0, i000)
		Switch (ToBuffer(m601(3, 7))) {
			Case ("0321") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 9, i000, 1)

		// Method returns Reference to String

		if (y500) {
			Store(0, i000)
			Switch (ToBuffer(Derefof(m602(3, 8, 1)))) {
				Case ("0321") {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 10, i000, 2)

			Store(0, i000)
			Switch (ToBuffer(Derefof(m602(3, 7, 1)))) {
				Case ("0321") {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 11, i000, 1)
		}

		// Boundary Cases

		Store(0, i000)
		Switch (Buffer() {0x01}) {
			Case ("") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 12, i000, 2)

		Store(0, i000)
		Switch (Buffer() {0x00}) {
			Case ("") {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 13, i000, 1)

		Store(0, i000)
		Switch (
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
				0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x01,}
				) {
			Case ("!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*") {
				Store(1, i000)
			}
			Default {Store(2, i000)}
		}
		m600(arg0, 14, i000, 2)

		Store(0, i000)
		Switch (
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
				0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x00,}
				) {
			Case ("!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*") {
				Store(1, i000)
			}
			Default {Store(2, i000)}
		}
		m600(arg0, 15, i000, 1)
	}

	// Buffer to Integer implicit conversion Cases.

	// Buffer to Integer conversion of the Buffer sole operand
	// of the 1-parameter Integer arithmetic operators
	// (Decrement, Increment, FindSetLeftBit, FindSetRightBit, Not)

	Method(m64l, 1)
	{
		// Decrement

		// Increment

		// FindSetLeftBit

		Store(FindSetLeftBit(Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 0, Local0, 10)

		Store(FindSetLeftBit(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 1, Local0, 64)

		// FindSetRightBit

		Store(FindSetRightBit(Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 2, Local0, 1)

		Store(FindSetRightBit(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 3, Local0, 3)

		// Not

		Store(Not(Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 4, Local0, 0xfffffffffffffcde)

		Store(Not(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 5, Local0, 0x01834c6e29af5d7b)
	}

	Method(m32l, 1)
	{
		// Decrement

		// Increment

		// FindSetLeftBit

		Store(FindSetLeftBit(Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 0, Local0, 10)

		Store(FindSetLeftBit(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 1, Local0, 32)

		// FindSetRightBit

		Store(FindSetRightBit(Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 2, Local0, 1)

		Store(FindSetRightBit(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 3, Local0, 3)

		// Not

		Store(Not(Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 4, Local0, 0xfffffcde)

		Store(Not(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 5, Local0, 0x29af5d7b)
	}

	// Buffer to Integer conversion of the Buffer sole operand
	// of the LNot Logical Integer operator
	Method(m03a, 1)
	{
		Store(LNot(Buffer(1){0x00}), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LNot(Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 1, Local0, Zero)

		if (F64) {
			Store(LNot(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 2, Local0, Zero)
		} else {
			Store(LNot(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 3, Local0, Zero)
		}
	}

	// Buffer to Integer conversion of the Buffer sole operand
	// of the FromBCD and ToBCD conversion operators

	Method(m64m, 1)
	{
		// FromBCD

		Store(FromBCD(Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 2, Local0, 0x141)

		Store(FromBCD(Buffer() {0x01, 0x89, 0x67, 0x45, 0x23, 0x01, 0x89, 0x37}), Local0)
		m600(arg0, 3, Local0, 0xd76162ee9ec35)

		FromBCD(Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 2, Local0, 0x141)

		FromBCD(Buffer() {0x01, 0x89, 0x67, 0x45, 0x23, 0x01, 0x89, 0x37}, Local0)
		m600(arg0, 3, Local0, 0xd76162ee9ec35)

		// ToBCD

		Store(ToBCD(Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 4, Local0, 0x801)

// ??? No error of iASL on constant folding
		Store(ToBCD(Buffer() {0x35, 0xec, 0xe9, 0x2e, 0x16, 0x76, 0x0d}), Local0)
		m600(arg0, 5, Local0, 0x3789012345678901)

		ToBCD(Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 4, Local0, 0x801)

		ToBCD(Buffer() {0x35, 0xec, 0xe9, 0x2e, 0x16, 0x76, 0x0d}, Local0)
		m600(arg0, 5, Local0, 0x3789012345678901)
	}

	Method(m32m, 1)
	{
		// FromBCD

		Store(FromBCD(Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 2, Local0, 0x141)

		Store(FromBCD(Buffer() {0x56, 0x34, 0x12, 0x90}), Local0)
		m600(arg0, 3, Local0, 0x55f2cc0)

		FromBCD(Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 2, Local0, 0x141)

		FromBCD(Buffer() {0x56, 0x34, 0x12, 0x90}, Local0)
		m600(arg0, 3, Local0, 0x55f2cc0)

		// ToBCD

		Store(ToBCD(Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 4, Local0, 0x801)

		Store(ToBCD(Buffer() {0xc0, 0x2c, 0x5f, 0x05}), Local0)
		m600(arg0, 5, Local0, 0x90123456)

		ToBCD(Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 4, Local0, 0x801)

		ToBCD(Buffer() {0xc0, 0x2c, 0x5f, 0x05}, Local0)
		m600(arg0, 5, Local0, 0x90123456)
	}

	// Buffer to Integer conversion of each Buffer operand
	// of the 2-parameter Integer arithmetic operators
	// Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
	// ShiftLeft, ShiftRight, Subtract, Xor

	// Add, common 32-bit/64-bit test
	Method(m03b, 1)
	{
		// Conversion of the first operand

		Store(Add(Buffer(3){0x21, 0x03, 0x00}, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Add(Buffer(3){0x21, 0x03, 0x00}, 1), Local0)
		m600(arg0, 1, Local0, 0x322)

		Store(Add(Buffer(3){0x21, 0x03, 0x00}, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Add(Buffer(3){0x21, 0x03, 0x00}, aui6), Local0)
		m600(arg0, 3, Local0, 0x322)

		if (y078) {
			Store(Add(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Add(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x322)
		}

		Store(Add(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Add(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x322)

		// Method returns Integer

		Store(Add(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Add(Buffer(3){0x21, 0x03, 0x00}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Add(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x322)
		}

		Add(Buffer(3){0x21, 0x03, 0x00}, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Add(Buffer(3){0x21, 0x03, 0x00}, 1, Local0)
		m600(arg0, 13, Local0, 0x322)

		Add(Buffer(3){0x21, 0x03, 0x00}, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Add(Buffer(3){0x21, 0x03, 0x00}, aui6, Local0)
		m600(arg0, 15, Local0, 0x322)

		if (y078) {
			Add(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Add(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x322)
		}

		Add(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Add(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x322)

		// Method returns Integer

		Add(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Add(Buffer(3){0x21, 0x03, 0x00}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Add(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Add(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x322)
		}

		// Conversion of the second operand

		Store(Add(0, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(Add(1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 25, Local0, 0x322)

		Store(Add(aui5, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(Add(aui6, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 27, Local0, 0x322)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(Add(Derefof(Refof(aui6)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 29, Local0, 0x322)
		}

		Store(Add(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(Add(Derefof(Index(paui, 6)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 31, Local0, 0x322)

		// Method returns Integer

		Store(Add(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(Add(m601(1, 6), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 33, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(Add(Derefof(m602(1, 6, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 35, Local0, 0x322)
		}

		Add(0, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 36, Local0, 0x321)

		Add(1, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 37, Local0, 0x322)

		Add(aui5, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 38, Local0, 0x321)

		Add(aui6, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 39, Local0, 0x322)

		if (y078) {
			Add(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 40, Local0, 0x321)

			Add(Derefof(Refof(aui6)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 41, Local0, 0x322)
		}

		Add(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 42, Local0, 0x321)

		Add(Derefof(Index(paui, 6)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 43, Local0, 0x322)

		// Method returns Integer

		Add(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 44, Local0, 0x321)

		Add(m601(1, 6), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 45, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 46, Local0, 0x321)

			Add(Derefof(m602(1, 6, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 47, Local0, 0x322)
		}
	}

	// Add, 64-bit
	Method(m03c, 1)
	{
		// Conversion of the first operand

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a285)

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a285)
		}

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a285)
		}

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a285)

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a285)
		}

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a285)
		}

		// Conversion of the second operand

		Store(Add(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(Add(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a285)

		Store(Add(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(Add(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(Add(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a285)
		}

		Store(Add(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(Add(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Store(Add(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(Add(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(Add(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a285)
		}

		Add(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		Add(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a285)

		Add(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		Add(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Add(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			Add(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a285)
		}

		Add(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		Add(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Add(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		Add(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			Add(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a285)
		}

		// Conversion of the both operands

		Store(Add(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a5a5)

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a5a5)

		Add(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a5a5)

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a5a5)
	}

	// Add, 32-bit
	Method(m03d, 1)
	{
		// Conversion of the first operand

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, 0xd650a285)

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, 0xd650a285)

		if (y078) {
			Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xd650a285)
		}

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xd650a285)

		// Method returns Integer

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xd650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xd650a285)
		}

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1, Local0)
		m600(arg0, 13, Local0, 0xd650a285)

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6, Local0)
		m600(arg0, 15, Local0, 0xd650a285)

		if (y078) {
			Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xd650a285)
		}

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xd650a285)

		// Method returns Integer

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xd650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xd650a285)
		}

		// Conversion of the second operand

		Store(Add(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0xd650a284)

		Store(Add(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0xd650a285)

		Store(Add(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0xd650a284)

		Store(Add(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0xd650a285)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0xd650a284)

			Store(Add(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0xd650a285)
		}

		Store(Add(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0xd650a284)

		Store(Add(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0xd650a285)

		// Method returns Integer

		Store(Add(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0xd650a284)

		Store(Add(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0xd650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0xd650a284)

			Store(Add(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0xd650a285)
		}

		Add(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0xd650a284)

		Add(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0xd650a285)

		Add(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0xd650a284)

		Add(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0xd650a285)

		if (y078) {
			Add(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0xd650a284)

			Add(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0xd650a285)
		}

		Add(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0xd650a284)

		Add(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0xd650a285)

		// Method returns Integer

		Add(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0xd650a284)

		Add(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0xd650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0xd650a284)

			Add(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0xd650a285)
		}

		// Conversion of the both operands

		Store(Add(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0xd650a5a5)

		Store(Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0xd650a5a5)

		Add(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0xd650a5a5)

		Add(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0xd650a5a5)
	}

	// And, common 32-bit/64-bit test
	Method(m03e, 1)
	{
		// Conversion of the first operand

		Store(And(Buffer(3){0x21, 0x03, 0x00}, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And(Buffer(3){0x21, 0x03, 0x00}, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x321)

		Store(And(Buffer(3){0x21, 0x03, 0x00}, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And(Buffer(3){0x21, 0x03, 0x00}, auij), Local0)
		m600(arg0, 3, Local0, 0x321)

		if (y078) {
			Store(And(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x321)
		}

		Store(And(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x321)

		// Method returns Integer

		Store(And(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And(Buffer(3){0x21, 0x03, 0x00}, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x321)
		}

		And(Buffer(3){0x21, 0x03, 0x00}, 0, Local0)
		m600(arg0, 12, Local0, 0)

		And(Buffer(3){0x21, 0x03, 0x00}, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x321)

		And(Buffer(3){0x21, 0x03, 0x00}, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And(Buffer(3){0x21, 0x03, 0x00}, auij, Local0)
		m600(arg0, 15, Local0, 0x321)

		if (y078) {
			And(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x321)
		}

		And(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x321)

		// Method returns Integer

		And(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And(Buffer(3){0x21, 0x03, 0x00}, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			And(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x321)
		}

		// Conversion of the second operand

		Store(And(0, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffffffffffff, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 25, Local0, 0x321)

		Store(And(aui5, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auij, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 27, Local0, 0x321)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auij)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 29, Local0, 0x321)
		}

		Store(And(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 19)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 31, Local0, 0x321)

		// Method returns Integer

		Store(And(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 19), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 33, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 19, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 35, Local0, 0x321)
		}

		And(0, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffffffffffff, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 37, Local0, 0x321)

		And(aui5, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 38, Local0, 0)

		And(auij, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 39, Local0, 0x321)

		if (y078) {
			And(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auij)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 41, Local0, 0x321)
		}

		And(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 19)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 43, Local0, 0x321)

		// Method returns Integer

		And(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 19), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 45, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 19, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 47, Local0, 0x321)
		}
	}

	// And, 64-bit
	Method(m03f, 1)
	{
		// Conversion of the first operand

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a284)

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auij), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a284)
		}

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a284)
		}

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0)

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auij, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a284)

		if (y078) {
			And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a284)
		}

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the second operand

		Store(And(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffffffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a284)

		Store(And(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auij, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auij)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a284)
		}

		Store(And(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 19)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(And(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 19), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 19, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a284)
		}

		And(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffffffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a284)

		And(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0)

		And(auij, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a284)

		if (y078) {
			And(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auij)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a284)
		}

		And(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 19)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		And(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 19), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 19, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the both operands

		Store(And(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0x200)

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0x200)

		And(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0x200)

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0x200)
	}

	// And, 32-bit
	Method(m040, 1)
	{
		// Conversion of the first operand

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0xd650a284)

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auii), Local0)
		m600(arg0, 3, Local0, 0xd650a284)

		if (y078) {
			Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0xd650a284)
		}

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0xd650a284)

		// Method returns Integer

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0xd650a284)
		}

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0)

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0xd650a284)

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auii, Local0)
		m600(arg0, 15, Local0, 0xd650a284)

		if (y078) {
			And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0xd650a284)
		}

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0xd650a284)

		// Method returns Integer

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0xd650a284)
		}

		// Conversion of the second operand

		Store(And(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0xd650a284)

		Store(And(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auii, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0xd650a284)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auii)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0xd650a284)
		}

		Store(And(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 18)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0xd650a284)

		// Method returns Integer

		Store(And(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 18), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 18, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0xd650a284)
		}

		And(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0xd650a284)

		And(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0)

		And(auii, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0xd650a284)

		if (y078) {
			And(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auii)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0xd650a284)
		}

		And(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 18)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0xd650a284)

		// Method returns Integer

		And(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 18), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 18, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0xd650a284)
		}

		// Conversion of the both operands

		Store(And(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0x200)

		Store(And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0x200)

		And(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0x200)

		And(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0x200)
	}

	// Divide, common 32-bit/64-bit test
	Method(m041, 1)
	{
		// Conversion of the first operand

		Store(Divide(Buffer(3){0x21, 0x03, 0x00}, 1), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Divide(Buffer(3){0x21, 0x03, 0x00}, 0x321), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide(Buffer(3){0x21, 0x03, 0x00}, aui6), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Divide(Buffer(3){0x21, 0x03, 0x00}, aui1), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Divide(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui1))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Divide(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 1))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide(Buffer(3){0x21, 0x03, 0x00}, m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Divide(Buffer(3){0x21, 0x03, 0x00}, m601(1, 1)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Divide(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 1, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide(Buffer(3){0x21, 0x03, 0x00}, 1, Local1, Local0)
		m600(arg0, 12, Local0, 0x321)

		Divide(Buffer(3){0x21, 0x03, 0x00}, 0x321, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide(Buffer(3){0x21, 0x03, 0x00}, aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0x321)

		Divide(Buffer(3){0x21, 0x03, 0x00}, aui1, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0x321)

			Divide(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui1)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0x321)

		Divide(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 1)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide(Buffer(3){0x21, 0x03, 0x00}, m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0x321)

		Divide(Buffer(3){0x21, 0x03, 0x00}, m601(1, 1), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0x321)

			Divide(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 1, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0x321, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(aui1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(aui1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 1), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 1, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0x321, Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(aui1, Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(aui1)), Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 1)), Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 1), Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 1, 1)), Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}
	}

	// Divide, 64-bit
	Method(m042, 1)
	{
		// Conversion of the first operand

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xfe7cb391d650a284), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui4), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui4))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 4))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 4)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 4, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1, Local1, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xfe7cb391d650a284, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui4, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui4)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 4)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 4), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 4, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0xfe7cb391d650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(aui4, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(aui4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 4), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 4, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0xfe7cb391d650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(aui4, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(aui4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 4), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 4, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}

		// Conversion of the both operands

		Store(Divide(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0)

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0x0051558eb950f5a7)

		Divide(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 50, Local0, 0)

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
		m600(arg0, 51, Local0, 0x0051558eb950f5a7)
	}

	// Divide, 32-bit
	Method(m043, 1)
	{
		// Conversion of the first operand

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xd650a284), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auik), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auik))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 20))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 20)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 20, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1, Local1, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xd650a284, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auik, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auik)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 20)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 20), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 20, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0xd650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(auik, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(auik)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 20)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 20), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 20, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0xd650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(auik, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(auik)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 20)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 20), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 20, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}

		// Conversion of the both operands

		Store(Divide(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0)

		Store(Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0x00447ec3)

		Divide(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local1, Local0)
		m600(arg0, 50, Local0, 0)

		Divide(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local1, Local0)
		m600(arg0, 51, Local0, 0x00447ec3)
	}

	// Mod, common 32-bit/64-bit test
	Method(m044, 1)
	{
		// Conversion of the first operand

		Store(Mod(Buffer(3){0x21, 0x03, 0x00}, 0x322), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Mod(Buffer(3){0x21, 0x03, 0x00}, 0x320), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod(Buffer(3){0x21, 0x03, 0x00}, auig), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Mod(Buffer(3){0x21, 0x03, 0x00}, auih), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Mod(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auig))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Mod(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auih))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 16))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Mod(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 17))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod(Buffer(3){0x21, 0x03, 0x00}, m601(1, 16)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Mod(Buffer(3){0x21, 0x03, 0x00}, m601(1, 17)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 16, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Mod(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 17, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod(Buffer(3){0x21, 0x03, 0x00}, 0x322, Local0)
		m600(arg0, 12, Local0, 0x321)

		Mod(Buffer(3){0x21, 0x03, 0x00}, 0x320, Local0)
		m600(arg0, 13, Local0, 1)

		Mod(Buffer(3){0x21, 0x03, 0x00}, auig, Local0)
		m600(arg0, 14, Local0, 0x321)

		Mod(Buffer(3){0x21, 0x03, 0x00}, auih, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auig)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Mod(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auih)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 16)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Mod(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 17)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod(Buffer(3){0x21, 0x03, 0x00}, m601(1, 16), Local0)
		m600(arg0, 20, Local0, 0x321)

		Mod(Buffer(3){0x21, 0x03, 0x00}, m601(1, 17), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 16, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Mod(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 17, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0x322, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0x320, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 25, Local0, 0x320)

		Store(Mod(auig, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auih, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 27, Local0, 0x320)

		if (y078) {
			Store(Mod(Derefof(Refof(auig)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auih)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 29, Local0, 0x320)
		}

		Store(Mod(Derefof(Index(paui, 16)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 17)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 31, Local0, 0x320)

		// Method returns Integer

		Store(Mod(m601(1, 16), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 17), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 33, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m602(1, 16, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m602(1, 17, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 35, Local0, 0x320)
		}

		Mod(0x322, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0x320, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 37, Local0, 0x320)

		Mod(auig, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auih, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 39, Local0, 0x320)

		if (y078) {
			Mod(Derefof(Refof(auig)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auih)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 41, Local0, 0x320)
		}

		Mod(Derefof(Index(paui, 16)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 17)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 43, Local0, 0x320)

		// Method returns Integer

		Mod(m601(1, 16), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 17), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 45, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m602(1, 16, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m602(1, 17, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 47, Local0, 0x320)
		}
	}

	// Mod, 64-bit
	Method(m045, 1)
	{
		// Conversion of the first operand

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xfe7cb391d650a285), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xfe7cb391d650a283), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auid), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auif), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auid))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auif))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 13))), Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 15))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 13)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 15)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 13, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 15, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xfe7cb391d650a285, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xfe7cb391d650a283, Local0)
		m600(arg0, 13, Local0, 1)

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auid, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auif, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auid)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auif)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 13)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 15)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 13), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 15), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 13, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 15, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0xfe7cb391d650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0xfe7cb391d650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a283)

		Store(Mod(auid, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auif, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Store(Mod(Derefof(Refof(auid)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auif)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a283)
		}

		Store(Mod(Derefof(Index(paui, 13)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 15)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Store(Mod(m601(1, 13), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 15), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m602(1, 13, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m602(1, 15, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a283)
		}

		Mod(0xfe7cb391d650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0xfe7cb391d650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a283)

		Mod(auid, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auif, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Mod(Derefof(Refof(auid)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auif)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a283)
		}

		Mod(Derefof(Index(paui, 13)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 15)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Mod(m601(1, 13), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 15), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m602(1, 13, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m602(1, 15, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a283)
		}

		// Conversion of the both operands

		Store(Mod(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0x321)

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0x2fd)

		Mod(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0x321)

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0x2fd)
	}

	// Mod, 32-bit
	Method(m046, 1)
	{
		// Conversion of the first operand

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xd650a285), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xd650a283), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auil), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auim), Local0)
		m600(arg0, 14, Local0, 1)

		if (y078) {
			Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auil))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auim))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 21))), Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 22))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 21)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 22)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m601(1, 21, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m601(1, 22, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xd650a285, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xd650a283, Local0)
		m600(arg0, 13, Local0, 1)

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auil, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auim, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auil)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auim)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 21)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 22)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 21), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 22), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m601(1, 21, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m601(1, 22, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0xd650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0xd650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0xd650a283)

		Store(Mod(auil, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auim, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0xd650a283)

		if (y078) {
			Store(Mod(Derefof(Refof(auil)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auim)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0xd650a283)
		}

		Store(Mod(Derefof(Index(paui, 21)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 22)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0xd650a283)

		// Method returns Integer

		Store(Mod(m601(1, 21), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 22), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0xd650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m601(1, 21, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m601(1, 22, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0xd650a283)
		}

		Mod(0xd650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0xd650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0xd650a283)

		Mod(auil, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auim, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0xd650a283)

		if (y078) {
			Mod(Derefof(Refof(auil)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auim)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0xd650a283)
		}

		Mod(Derefof(Index(paui, 21)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 22)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0xd650a283)

		// Method returns Integer

		Mod(m601(1, 21), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 22), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0xd650a283)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m601(1, 21, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m601(1, 22, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0xd650a283)
		}

		// Conversion of the both operands

		Store(Mod(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0x321)

		Store(Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0x261)

		Mod(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0x321)

		Mod(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0x261)
	}

	// Multiply, common 32-bit/64-bit test
	Method(m047, 1)
	{
		// Conversion of the first operand

		Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, 1), Local0)
		m600(arg0, 1, Local0, 0x321)

		Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, aui6), Local0)
		m600(arg0, 3, Local0, 0x321)

		if (y078) {
			Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x321)
		}

		Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x321)

		// Method returns Integer

		Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x321)
		}

		Multiply(Buffer(3){0x21, 0x03, 0x00}, 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply(Buffer(3){0x21, 0x03, 0x00}, 1, Local0)
		m600(arg0, 13, Local0, 0x321)

		Multiply(Buffer(3){0x21, 0x03, 0x00}, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply(Buffer(3){0x21, 0x03, 0x00}, aui6, Local0)
		m600(arg0, 15, Local0, 0x321)

		if (y078) {
			Multiply(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x321)
		}

		Multiply(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x321)

		// Method returns Integer

		Multiply(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply(Buffer(3){0x21, 0x03, 0x00}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x321)
		}

		// Conversion of the second operand

		Store(Multiply(0, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 25, Local0, 0x321)

		Store(Multiply(aui5, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 27, Local0, 0x321)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 29, Local0, 0x321)
		}

		Store(Multiply(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 31, Local0, 0x321)

		// Method returns Integer

		Store(Multiply(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 33, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 35, Local0, 0x321)
		}

		Multiply(0, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 37, Local0, 0x321)

		Multiply(aui5, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 39, Local0, 0x321)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 41, Local0, 0x321)
		}

		Multiply(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 43, Local0, 0x321)

		// Method returns Integer

		Multiply(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 45, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 47, Local0, 0x321)
		}
	}

	// Multiply, 64-bit
	Method(m048, 1)
	{
		// Conversion of the first operand

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a284)

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a284)
		}

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a284)
		}

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a284)
		}

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the second operand

		Store(Multiply(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a284)

		Store(Multiply(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a284)
		}

		Store(Multiply(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(Multiply(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a284)
		}

		Multiply(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a284)

		Multiply(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a284)
		}

		Multiply(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Multiply(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the both operands

		Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0x442ddb4f924c7f04)

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0x442ddb4f924c7f04)

		Multiply(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0x442ddb4f924c7f04)

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0x442ddb4f924c7f04)
	}

	// Multiply, 32-bit
	Method(m049, 1)
	{
		// Conversion of the first operand

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, 0xd650a284)

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, 0xd650a284)

		if (y078) {
			Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xd650a284)
		}

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xd650a284)

		// Method returns Integer

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xd650a284)
		}

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1, Local0)
		m600(arg0, 13, Local0, 0xd650a284)

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6, Local0)
		m600(arg0, 15, Local0, 0xd650a284)

		if (y078) {
			Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xd650a284)
		}

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xd650a284)

		// Method returns Integer

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xd650a284)
		}

		// Conversion of the second operand

		Store(Multiply(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0xd650a284)

		Store(Multiply(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0xd650a284)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0xd650a284)
		}

		Store(Multiply(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0xd650a284)

		// Method returns Integer

		Store(Multiply(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0xd650a284)
		}

		Multiply(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0xd650a284)

		Multiply(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0xd650a284)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0xd650a284)
		}

		Multiply(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0xd650a284)

		// Method returns Integer

		Multiply(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0xd650a284)
		}

		// Conversion of the both operands

		Store(Multiply(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0x924c7f04)

		Store(Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0x924c7f04)

		Multiply(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0x924c7f04)

		Multiply(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0x924c7f04)
	}

	// NAnd, common 32-bit/64-bit test
	Method(m04a, 1)
	{
		// Conversion of the first operand

		Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, 0), Local0)
		m600(arg0, 0, Local0, 0xffffffffffffffff)

		Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfffffffffffffcde)

		Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffffffffffff)

		Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, auij), Local0)
		m600(arg0, 3, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffffffffffff)

			Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfffffffffffffcde)
		}

		Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffffffffffff)

		Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffffffffffff)

		Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffffffffffff)

			Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfffffffffffffcde)
		}

		NAnd(Buffer(3){0x21, 0x03, 0x00}, 0, Local0)
		m600(arg0, 12, Local0, 0xffffffffffffffff)

		NAnd(Buffer(3){0x21, 0x03, 0x00}, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfffffffffffffcde)

		NAnd(Buffer(3){0x21, 0x03, 0x00}, aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffffffffffff)

		NAnd(Buffer(3){0x21, 0x03, 0x00}, auij, Local0)
		m600(arg0, 15, Local0, 0xfffffffffffffcde)

		if (y078) {
			NAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffffffffffff)

			NAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfffffffffffffcde)
		}

		NAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffffffffffff)

		NAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		NAnd(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffffffffffff)

		NAnd(Buffer(3){0x21, 0x03, 0x00}, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffffffffffff)

			NAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfffffffffffffcde)
		}

		// Conversion of the second operand

		Store(NAnd(0, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 24, Local0, 0xffffffffffffffff)

		Store(NAnd(0xffffffffffffffff, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffcde)

		Store(NAnd(aui5, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 26, Local0, 0xffffffffffffffff)

		Store(NAnd(auij, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 28, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(Refof(auij)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffcde)
		}

		Store(NAnd(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 30, Local0, 0xffffffffffffffff)

		Store(NAnd(Derefof(Index(paui, 19)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(NAnd(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 32, Local0, 0xffffffffffffffff)

		Store(NAnd(m601(1, 19), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 34, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(m602(1, 19, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffcde)
		}

		NAnd(0, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 36, Local0, 0xffffffffffffffff)

		NAnd(0xffffffffffffffff, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffcde)

		NAnd(aui5, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 38, Local0, 0xffffffffffffffff)

		NAnd(auij, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffcde)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 40, Local0, 0xffffffffffffffff)

			NAnd(Derefof(Refof(auij)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffcde)
		}

		NAnd(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 42, Local0, 0xffffffffffffffff)

		NAnd(Derefof(Index(paui, 19)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		NAnd(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 44, Local0, 0xffffffffffffffff)

		NAnd(m601(1, 19), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 46, Local0, 0xffffffffffffffff)

			NAnd(Derefof(m602(1, 19, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffcde)
		}
	}

	// NAnd, 64-bit
	Method(m04b, 1)
	{
		// Conversion of the first operand

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xffffffffffffffff)

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x01834c6e29af5d7b)

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffffffffffff)

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auij), Local0)
		m600(arg0, 3, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffffffffffff)

			Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x01834c6e29af5d7b)
		}

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffffffffffff)

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffffffffffff)

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffffffffffff)

			Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xffffffffffffffff)

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x01834c6e29af5d7b)

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffffffffffff)

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auij, Local0)
		m600(arg0, 15, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffffffffffff)

			NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffffffffffff)

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffffffffffff)

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffffffffffff)

			NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the second operand

		Store(NAnd(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0xffffffffffffffff)

		Store(NAnd(0xffffffffffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7b)

		Store(NAnd(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0xffffffffffffffff)

		Store(NAnd(auij, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(Refof(auij)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7b)
		}

		Store(NAnd(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0xffffffffffffffff)

		Store(NAnd(Derefof(Index(paui, 19)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(NAnd(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0xffffffffffffffff)

		Store(NAnd(m601(1, 19), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(m602(1, 19, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0xffffffffffffffff)

		NAnd(0xffffffffffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7b)

		NAnd(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0xffffffffffffffff)

		NAnd(auij, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0xffffffffffffffff)

			NAnd(Derefof(Refof(auij)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0xffffffffffffffff)

		NAnd(Derefof(Index(paui, 19)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		NAnd(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0xffffffffffffffff)

		NAnd(m601(1, 19), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0xffffffffffffffff)

			NAnd(Derefof(m602(1, 19, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the both operands

		Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0xfffffffffffffdff)

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0xfffffffffffffdff)

		NAnd(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0xfffffffffffffdff)

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0xfffffffffffffdff)
	}

	// NAnd, 32-bit
	Method(m04c, 1)
	{
		// Conversion of the first operand

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xffffffff)

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0x29af5d7b)

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffff)

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auii), Local0)
		m600(arg0, 3, Local0, 0x29af5d7b)

		if (y078) {
			Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffff)

			Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0x29af5d7b)
		}

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffff)

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0x29af5d7b)

		// Method returns Integer

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffff)

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffff)

			Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0x29af5d7b)
		}

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xffffffff)

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0x29af5d7b)

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffff)

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auii, Local0)
		m600(arg0, 15, Local0, 0x29af5d7b)

		if (y078) {
			NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffff)

			NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0x29af5d7b)
		}

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffff)

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0x29af5d7b)

		// Method returns Integer

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffff)

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffff)

			NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0x29af5d7b)
		}

		// Conversion of the second operand

		Store(NAnd(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0xffffffff)

		Store(NAnd(0xffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0x29af5d7b)

		Store(NAnd(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0xffffffff)

		Store(NAnd(auii, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0x29af5d7b)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0xffffffff)

			Store(NAnd(Derefof(Refof(auii)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0x29af5d7b)
		}

		Store(NAnd(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0xffffffff)

		Store(NAnd(Derefof(Index(paui, 18)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0x29af5d7b)

		// Method returns Integer

		Store(NAnd(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0xffffffff)

		Store(NAnd(m601(1, 18), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0xffffffff)

			Store(NAnd(Derefof(m602(1, 18, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0x29af5d7b)
		}

		NAnd(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0xffffffff)

		NAnd(0xffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0x29af5d7b)

		NAnd(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0xffffffff)

		NAnd(auii, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0x29af5d7b)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0xffffffff)

			NAnd(Derefof(Refof(auii)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0x29af5d7b)
		}

		NAnd(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0xffffffff)

		NAnd(Derefof(Index(paui, 18)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0x29af5d7b)

		// Method returns Integer

		NAnd(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0xffffffff)

		NAnd(m601(1, 18), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0xffffffff)

			NAnd(Derefof(m602(1, 18, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0x29af5d7b)
		}

		// Conversion of the both operands

		Store(NAnd(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0xfffffdff)

		Store(NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0xfffffdff)

		NAnd(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0xfffffdff)

		NAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0xfffffdff)
	}

	// NOr, common 32-bit/64-bit test
	Method(m04d, 1)
	{
		// Conversion of the first operand

		Store(NOr(Buffer(3){0x21, 0x03, 0x00}, 0), Local0)
		m600(arg0, 0, Local0, 0xfffffffffffffcde)

		Store(NOr(Buffer(3){0x21, 0x03, 0x00}, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr(Buffer(3){0x21, 0x03, 0x00}, aui5), Local0)
		m600(arg0, 2, Local0, 0xfffffffffffffcde)

		Store(NOr(Buffer(3){0x21, 0x03, 0x00}, auij), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfffffffffffffcde)

			Store(NOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfffffffffffffcde)

		Store(NOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfffffffffffffcde)

		Store(NOr(Buffer(3){0x21, 0x03, 0x00}, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfffffffffffffcde)

			Store(NOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr(Buffer(3){0x21, 0x03, 0x00}, 0, Local0)
		m600(arg0, 12, Local0, 0xfffffffffffffcde)

		NOr(Buffer(3){0x21, 0x03, 0x00}, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr(Buffer(3){0x21, 0x03, 0x00}, aui5, Local0)
		m600(arg0, 14, Local0, 0xfffffffffffffcde)

		NOr(Buffer(3){0x21, 0x03, 0x00}, auij, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfffffffffffffcde)

			NOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfffffffffffffcde)

		NOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfffffffffffffcde)

		NOr(Buffer(3){0x21, 0x03, 0x00}, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfffffffffffffcde)

			NOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 24, Local0, 0xfffffffffffffcde)

		Store(NOr(0xffffffffffffffff, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 26, Local0, 0xfffffffffffffcde)

		Store(NOr(auij, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 28, Local0, 0xfffffffffffffcde)

			Store(NOr(Derefof(Refof(auij)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 30, Local0, 0xfffffffffffffcde)

		Store(NOr(Derefof(Index(paui, 19)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 32, Local0, 0xfffffffffffffcde)

		Store(NOr(m601(1, 19), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 34, Local0, 0xfffffffffffffcde)

			Store(NOr(Derefof(m602(1, 19, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 36, Local0, 0xfffffffffffffcde)

		NOr(0xffffffffffffffff, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 38, Local0, 0xfffffffffffffcde)

		NOr(auij, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 40, Local0, 0xfffffffffffffcde)

			NOr(Derefof(Refof(auij)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 42, Local0, 0xfffffffffffffcde)

		NOr(Derefof(Index(paui, 19)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 44, Local0, 0xfffffffffffffcde)

		NOr(m601(1, 19), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 46, Local0, 0xfffffffffffffcde)

			NOr(Derefof(m602(1, 19, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 47, Local0, 0)
		}
	}

	// NOr, 64-bit
	Method(m04e, 1)
	{
		// Conversion of the first operand

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0x01834c6e29af5d7b)

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0x01834c6e29af5d7b)

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auij), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x01834c6e29af5d7b)

			Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x01834c6e29af5d7b)

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x01834c6e29af5d7b)

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x01834c6e29af5d7b)

			Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0x01834c6e29af5d7b)

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0x01834c6e29af5d7b)

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auij, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x01834c6e29af5d7b)

			NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x01834c6e29af5d7b)

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x01834c6e29af5d7b)

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x01834c6e29af5d7b)

			NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0x01834c6e29af5d7b)

		Store(NOr(0xffffffffffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0x01834c6e29af5d7b)

		Store(NOr(auij, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0x01834c6e29af5d7b)

			Store(NOr(Derefof(Refof(auij)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0x01834c6e29af5d7b)

		Store(NOr(Derefof(Index(paui, 19)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0x01834c6e29af5d7b)

		Store(NOr(m601(1, 19), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0x01834c6e29af5d7b)

			Store(NOr(Derefof(m602(1, 19, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0x01834c6e29af5d7b)

		NOr(0xffffffffffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0x01834c6e29af5d7b)

		NOr(auij, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0x01834c6e29af5d7b)

			NOr(Derefof(Refof(auij)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0x01834c6e29af5d7b)

		NOr(Derefof(Index(paui, 19)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0x01834c6e29af5d7b)

		NOr(m601(1, 19), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0x01834c6e29af5d7b)

			NOr(Derefof(m602(1, 19, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0)
		}

		// Conversion of the both operands

		Store(NOr(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0x01834c6e29af5c5a)

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0x01834c6e29af5c5a)

		NOr(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0x01834c6e29af5c5a)

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0x01834c6e29af5c5a)
	}

	// NOr, 32-bit
	Method(m04f, 1)
	{
		// Conversion of the first operand

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0x29af5d7b)

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0x29af5d7b)

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auii), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x29af5d7b)

			Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x29af5d7b)

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x29af5d7b)

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x29af5d7b)

			Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0x29af5d7b)

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0x29af5d7b)

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auii, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x29af5d7b)

			NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x29af5d7b)

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x29af5d7b)

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x29af5d7b)

			NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0x29af5d7b)

		Store(NOr(0xffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0x29af5d7b)

		Store(NOr(auii, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0x29af5d7b)

			Store(NOr(Derefof(Refof(auii)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0x29af5d7b)

		Store(NOr(Derefof(Index(paui, 18)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0x29af5d7b)

		Store(NOr(m601(1, 18), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0x29af5d7b)

			Store(NOr(Derefof(m602(1, 18, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0x29af5d7b)

		NOr(0xffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0x29af5d7b)

		NOr(auii, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0x29af5d7b)

			NOr(Derefof(Refof(auii)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0x29af5d7b)

		NOr(Derefof(Index(paui, 18)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0x29af5d7b)

		NOr(m601(1, 18), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0x29af5d7b)

			NOr(Derefof(m602(1, 18, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0)
		}

		// Conversion of the both operands

		Store(NOr(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0x29af5c5a)

		Store(NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0x29af5c5a)

		NOr(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0x29af5c5a)

		NOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0x29af5c5a)
	}

	// Or, common 32-bit/64-bit test
	Method(m050, 1)
	{
		// Conversion of the first operand

		Store(Or(Buffer(3){0x21, 0x03, 0x00}, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Or(Buffer(3){0x21, 0x03, 0x00}, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffffffffffff)

		Store(Or(Buffer(3){0x21, 0x03, 0x00}, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Or(Buffer(3){0x21, 0x03, 0x00}, auij), Local0)
		m600(arg0, 3, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Or(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xffffffffffffffff)
		}

		Store(Or(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Or(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Or(Buffer(3){0x21, 0x03, 0x00}, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Or(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffffffffffff)
		}

		Or(Buffer(3){0x21, 0x03, 0x00}, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Or(Buffer(3){0x21, 0x03, 0x00}, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffffffffffff)

		Or(Buffer(3){0x21, 0x03, 0x00}, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Or(Buffer(3){0x21, 0x03, 0x00}, auij, Local0)
		m600(arg0, 15, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Or(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xffffffffffffffff)
		}

		Or(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Or(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Or(Buffer(3){0x21, 0x03, 0x00}, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Or(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffffffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(Or(0xffffffffffffffff, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 25, Local0, 0xffffffffffffffff)

		Store(Or(aui5, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(Or(auij, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 27, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(Or(Derefof(Refof(auij)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 29, Local0, 0xffffffffffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(Or(Derefof(Index(paui, 19)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 31, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(Or(m601(1, 19), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 33, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(Or(Derefof(m602(1, 19, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 35, Local0, 0xffffffffffffffff)
		}

		Or(0, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 36, Local0, 0x321)

		Or(0xffffffffffffffff, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 37, Local0, 0xffffffffffffffff)

		Or(aui5, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 38, Local0, 0x321)

		Or(auij, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 39, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 40, Local0, 0x321)

			Or(Derefof(Refof(auij)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 41, Local0, 0xffffffffffffffff)
		}

		Or(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 42, Local0, 0x321)

		Or(Derefof(Index(paui, 19)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 43, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 44, Local0, 0x321)

		Or(m601(1, 19), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 45, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 46, Local0, 0x321)

			Or(Derefof(m602(1, 19, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 47, Local0, 0xffffffffffffffff)
		}
	}

	// Or, 64-bit
	Method(m051, 1)
	{
		// Conversion of the first operand

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffffffffffff)

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auij), Local0)
		m600(arg0, 3, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xffffffffffffffff)
		}

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffffffffffff)
		}

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffffffffffff)

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auij, Local0)
		m600(arg0, 15, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xffffffffffffffff)
		}

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffffffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(Or(0xffffffffffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0xffffffffffffffff)

		Store(Or(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(Or(auij, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(Or(Derefof(Refof(auij)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0xffffffffffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(Or(Derefof(Index(paui, 19)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(Or(m601(1, 19), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(Or(Derefof(m602(1, 19, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0xffffffffffffffff)
		}

		Or(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		Or(0xffffffffffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0xffffffffffffffff)

		Or(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		Or(auij, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			Or(Derefof(Refof(auij)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0xffffffffffffffff)
		}

		Or(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		Or(Derefof(Index(paui, 19)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		Or(m601(1, 19), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			Or(Derefof(m602(1, 19, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0xffffffffffffffff)
		}

		// Conversion of the both operands

		Store(Or(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a3a5)

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a3a5)

		Or(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a3a5)

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a3a5)
	}

	// Or, 32-bit
	Method(m052, 1)
	{
		// Conversion of the first operand

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffff)

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auii), Local0)
		m600(arg0, 3, Local0, 0xffffffff)

		if (y078) {
			Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0xffffffff)
		}

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0xffffffff)

		// Method returns Integer

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffff)
		}

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffff)

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auii, Local0)
		m600(arg0, 15, Local0, 0xffffffff)

		if (y078) {
			Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0xffffffff)
		}

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0xffffffff)

		// Method returns Integer

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0xd650a284)

		Store(Or(0xffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0xffffffff)

		Store(Or(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0xd650a284)

		Store(Or(auii, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0xffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0xd650a284)

			Store(Or(Derefof(Refof(auii)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0xffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0xd650a284)

		Store(Or(Derefof(Index(paui, 18)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0xffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0xd650a284)

		Store(Or(m601(1, 18), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0xd650a284)

			Store(Or(Derefof(m602(1, 18, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0xffffffff)
		}

		Or(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0xd650a284)

		Or(0xffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0xffffffff)

		Or(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0xd650a284)

		Or(auii, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0xffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0xd650a284)

			Or(Derefof(Refof(auii)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0xffffffff)
		}

		Or(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0xd650a284)

		Or(Derefof(Index(paui, 18)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0xffffffff)

		// Method returns Integer

		Or(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0xd650a284)

		Or(m601(1, 18), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0xd650a284)

			Or(Derefof(m602(1, 18, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0xffffffff)
		}

		// Conversion of the both operands

		Store(Or(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0xd650a3a5)

		Store(Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0xd650a3a5)

		Or(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0xd650a3a5)

		Or(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0xd650a3a5)
	}

	// ShiftLeft, common 32-bit/64-bit test
	Method(m053, 1)
	{
		// Conversion of the first operand

		Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, 1), Local0)
		m600(arg0, 1, Local0, 0x642)

		Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, aui6), Local0)
		m600(arg0, 3, Local0, 0x642)

		if (y078) {
			Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x642)
		}

		Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x642)

		// Method returns Integer

		Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x642)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x642)
		}

		ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, 1, Local0)
		m600(arg0, 13, Local0, 0x642)

		ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, aui6, Local0)
		m600(arg0, 15, Local0, 0x642)

		if (y078) {
			ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x642)
		}

		ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x642)

		// Method returns Integer

		ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x642)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x642)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, Buffer(1){0xb}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, Buffer(1){0xb}), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, Buffer(1){0xb}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, Buffer(1){0xb}), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), Buffer(1){0xb}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), Buffer(1){0xb}), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), Buffer(1){0xb}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), Buffer(1){0xb}), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), Buffer(1){0xb}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), Buffer(1){0xb}), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, Buffer(1){0xb}, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, Buffer(1){0xb}, Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, Buffer(1){0xb}, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, Buffer(1){0xb}, Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), Buffer(1){0xb}, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), Buffer(1){0xb}, Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), Buffer(1){0xb}, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), Buffer(1){0xb}, Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), Buffer(1){0xb}, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), Buffer(1){0xb}, Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 47, Local0, 0x800)
		}
	}

	// ShiftLeft, 64-bit
	Method(m054, 1)
	{
		// Conversion of the first operand

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, 0xfcf96723aca14508)

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, 0xfcf96723aca14508)

		if (y078) {
			Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfcf96723aca14508)
		}

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfcf96723aca14508)

		// Method returns Integer

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfcf96723aca14508)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfcf96723aca14508)
		}

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1, Local0)
		m600(arg0, 13, Local0, 0xfcf96723aca14508)

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6, Local0)
		m600(arg0, 15, Local0, 0xfcf96723aca14508)

		if (y078) {
			ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfcf96723aca14508)
		}

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfcf96723aca14508)

		// Method returns Integer

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfcf96723aca14508)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfcf96723aca14508)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, Buffer(1){0xb}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, Buffer(1){0xb}), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, Buffer(1){0xb}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, Buffer(1){0xb}), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), Buffer(1){0xb}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), Buffer(1){0xb}), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), Buffer(1){0xb}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), Buffer(1){0xb}), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), Buffer(1){0xb}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), Buffer(1){0xb}), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, Buffer(1){0xb}, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, Buffer(1){0xb}, Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, Buffer(1){0xb}, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, Buffer(1){0xb}, Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), Buffer(1){0xb}, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), Buffer(1){0xb}, Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), Buffer(1){0xb}, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), Buffer(1){0xb}, Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), Buffer(1){0xb}, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), Buffer(1){0xb}, Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 47, Local0, 0x800)
		}

		// Conversion of the both operands

		Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Buffer(1){0xb}), Local0)
		m600(arg0, 48, Local0, 0x190800)

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(1){0xb}), Local0)
		m600(arg0, 49, Local0, 0xE59C8EB285142000)

		ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Buffer(1){0xb}, Local0)
		m600(arg0, 50, Local0, 0x190800)

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(1){0xb}, Local0)
		m600(arg0, 51, Local0, 0xE59C8EB285142000)
	}

	// ShiftLeft, 32-bit
	Method(m055, 1)
	{
		// Conversion of the first operand

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, 0xaca14508)

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, 0xaca14508)

		if (y078) {
			Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xaca14508)
		}

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xaca14508)

		// Method returns Integer

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xaca14508)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xaca14508)
		}

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1, Local0)
		m600(arg0, 13, Local0, 0xaca14508)

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6, Local0)
		m600(arg0, 15, Local0, 0xaca14508)

		if (y078) {
			ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xaca14508)
		}

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xaca14508)

		// Method returns Integer

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xaca14508)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xaca14508)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, Buffer(1){0xb}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, Buffer(1){0xb}), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, Buffer(1){0xb}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, Buffer(1){0xb}), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), Buffer(1){0xb}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), Buffer(1){0xb}), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), Buffer(1){0xb}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), Buffer(1){0xb}), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), Buffer(1){0xb}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), Buffer(1){0xb}), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, Buffer(1){0xb}, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, Buffer(1){0xb}, Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, Buffer(1){0xb}, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, Buffer(1){0xb}, Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), Buffer(1){0xb}, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), Buffer(1){0xb}, Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), Buffer(1){0xb}, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), Buffer(1){0xb}, Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), Buffer(1){0xb}, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), Buffer(1){0xb}, Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 47, Local0, 0x800)
		}

		// Conversion of the both operands

		Store(ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Buffer(1){0xb}), Local0)
		m600(arg0, 48, Local0, 0x190800)

		Store(ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(1){0xb}), Local0)
		m600(arg0, 49, Local0, 0x85142000)

		ShiftLeft(Buffer(3){0x21, 0x03, 0x00}, Buffer(1){0xb}, Local0)
		m600(arg0, 50, Local0, 0x190800)

		ShiftLeft(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(1){0xb}, Local0)
		m600(arg0, 51, Local0, 0x85142000)
	}

	// ShiftRight, common 32-bit/64-bit test
	Method(m056, 1)
	{
		// Conversion of the first operand

		Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, 1), Local0)
		m600(arg0, 1, Local0, 0x190)

		Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, aui6), Local0)
		m600(arg0, 3, Local0, 0x190)

		if (y078) {
			Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x190)
		}

		Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x190)

		// Method returns Integer

		Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x190)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x190)
		}

		ShiftRight(Buffer(3){0x21, 0x03, 0x00}, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		ShiftRight(Buffer(3){0x21, 0x03, 0x00}, 1, Local0)
		m600(arg0, 13, Local0, 0x190)

		ShiftRight(Buffer(3){0x21, 0x03, 0x00}, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		ShiftRight(Buffer(3){0x21, 0x03, 0x00}, aui6, Local0)
		m600(arg0, 15, Local0, 0x190)

		if (y078) {
			ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x190)
		}

		ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x190)

		// Method returns Integer

		ShiftRight(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		ShiftRight(Buffer(3){0x21, 0x03, 0x00}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x190)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x190)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, Buffer(1){0xb}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xd650a284, Buffer(1){0xb}), Local0)
		m600(arg0, 25, Local0, 0x1aca14)

		Store(ShiftRight(aui1, Buffer(1){0xb}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(auik, Buffer(1){0xb}), Local0)
		m600(arg0, 27, Local0, 0x1aca14)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), Buffer(1){0xb}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(auik)), Buffer(1){0xb}), Local0)
			m600(arg0, 29, Local0, 0x1aca14)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), Buffer(1){0xb}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 20)), Buffer(1){0xb}), Local0)
		m600(arg0, 31, Local0, 0x1aca14)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), Buffer(1){0xb}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 20), Buffer(1){0xb}), Local0)
		m600(arg0, 33, Local0, 0x1aca14)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 20, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 35, Local0, 0x1aca14)
		}

		ShiftRight(0x321, Buffer(1){0xb}, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xd650a284, Buffer(1){0xb}, Local0)
		m600(arg0, 37, Local0, 0x1aca14)

		ShiftRight(aui1, Buffer(1){0xb}, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(auik, Buffer(1){0xb}, Local0)
		m600(arg0, 39, Local0, 0x1aca14)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), Buffer(1){0xb}, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(auik)), Buffer(1){0xb}, Local0)
			m600(arg0, 41, Local0, 0x1aca14)
		}

		ShiftRight(Derefof(Index(paui, 1)), Buffer(1){0xb}, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 20)), Buffer(1){0xb}, Local0)
		m600(arg0, 43, Local0, 0x1aca14)

		// Method returns Integer

		ShiftRight(m601(1, 1), Buffer(1){0xb}, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 20), Buffer(1){0xb}, Local0)
		m600(arg0, 45, Local0, 0x1aca14)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 20, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 47, Local0, 0x1aca14)
		}
	}

	// ShiftRight, 64-bit
	Method(m057, 1)
	{
		// Conversion of the first operand

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, 0x7f3e59c8eb285142)

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, 0x7f3e59c8eb285142)

		if (y078) {
			Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x7f3e59c8eb285142)
		}

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x7f3e59c8eb285142)

		// Method returns Integer

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x7f3e59c8eb285142)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x7f3e59c8eb285142)
		}

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1, Local0)
		m600(arg0, 13, Local0, 0x7f3e59c8eb285142)

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6, Local0)
		m600(arg0, 15, Local0, 0x7f3e59c8eb285142)

		if (y078) {
			ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x7f3e59c8eb285142)
		}

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x7f3e59c8eb285142)

		// Method returns Integer

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x7f3e59c8eb285142)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x7f3e59c8eb285142)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, Buffer(1){0xb}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xfe7cb391d650a284, Buffer(1){0xb}), Local0)
		m600(arg0, 25, Local0, 0x1fcf96723aca14)

		Store(ShiftRight(aui1, Buffer(1){0xb}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(aui4, Buffer(1){0xb}), Local0)
		m600(arg0, 27, Local0, 0x1fcf96723aca14)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), Buffer(1){0xb}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(aui4)), Buffer(1){0xb}), Local0)
			m600(arg0, 29, Local0, 0x1fcf96723aca14)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), Buffer(1){0xb}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 4)), Buffer(1){0xb}), Local0)
		m600(arg0, 31, Local0, 0x1fcf96723aca14)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), Buffer(1){0xb}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 4), Buffer(1){0xb}), Local0)
		m600(arg0, 33, Local0, 0x1fcf96723aca14)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 4, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 35, Local0, 0x1fcf96723aca14)
		}

		ShiftRight(0x321, Buffer(1){0xb}, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xfe7cb391d650a284, Buffer(1){0xb}, Local0)
		m600(arg0, 37, Local0, 0x1fcf96723aca14)

		ShiftRight(aui1, Buffer(1){0xb}, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(aui4, Buffer(1){0xb}, Local0)
		m600(arg0, 39, Local0, 0x1fcf96723aca14)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), Buffer(1){0xb}, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(aui4)), Buffer(1){0xb}, Local0)
			m600(arg0, 41, Local0, 0x1fcf96723aca14)
		}

		ShiftRight(Derefof(Index(paui, 1)), Buffer(1){0xb}, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 4)), Buffer(1){0xb}, Local0)
		m600(arg0, 43, Local0, 0x1fcf96723aca14)

		// Method returns Integer

		ShiftRight(m601(1, 1), Buffer(1){0xb}, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 4), Buffer(1){0xb}, Local0)
		m600(arg0, 45, Local0, 0x1fcf96723aca14)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 4, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 47, Local0, 0x1fcf96723aca14)
		}

		// Conversion of the both operands

		Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Buffer(1){0xb}), Local0)
		m600(arg0, 48, Local0, 0)

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(1){0xb}), Local0)
		m600(arg0, 49, Local0, 0x1fcf96723aca14)

		ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Buffer(1){0xb}, Local0)
		m600(arg0, 50, Local0, 0)

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(1){0xb}, Local0)
		m600(arg0, 51, Local0, 0x1fcf96723aca14)
	}

	// ShiftRight, 32-bit
	Method(m058, 1)
	{
		// Conversion of the first operand

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, 0x6b285142)

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, 0x6b285142)

		if (y078) {
			Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x6b285142)
		}

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x6b285142)

		// Method returns Integer

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x6b285142)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x6b285142)
		}

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1, Local0)
		m600(arg0, 13, Local0, 0x6b285142)

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6, Local0)
		m600(arg0, 15, Local0, 0x6b285142)

		if (y078) {
			ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x6b285142)
		}

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x6b285142)

		// Method returns Integer

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x6b285142)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x6b285142)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, Buffer(1){0xb}), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xd650a284, Buffer(1){0xb}), Local0)
		m600(arg0, 25, Local0, 0x1aca14)

		Store(ShiftRight(aui1, Buffer(1){0xb}), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(auik, Buffer(1){0xb}), Local0)
		m600(arg0, 27, Local0, 0x1aca14)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), Buffer(1){0xb}), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(auik)), Buffer(1){0xb}), Local0)
			m600(arg0, 29, Local0, 0x1aca14)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), Buffer(1){0xb}), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 20)), Buffer(1){0xb}), Local0)
		m600(arg0, 31, Local0, 0x1aca14)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), Buffer(1){0xb}), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 20), Buffer(1){0xb}), Local0)
		m600(arg0, 33, Local0, 0x1aca14)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 20, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 35, Local0, 0x1aca14)
		}

		ShiftRight(0x321, Buffer(1){0xb}, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xd650a284, Buffer(1){0xb}, Local0)
		m600(arg0, 37, Local0, 0x1aca14)

		ShiftRight(aui1, Buffer(1){0xb}, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(auik, Buffer(1){0xb}, Local0)
		m600(arg0, 39, Local0, 0x1aca14)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), Buffer(1){0xb}, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(auik)), Buffer(1){0xb}, Local0)
			m600(arg0, 41, Local0, 0x1aca14)
		}

		ShiftRight(Derefof(Index(paui, 1)), Buffer(1){0xb}, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 20)), Buffer(1){0xb}, Local0)
		m600(arg0, 43, Local0, 0x1aca14)

		// Method returns Integer

		ShiftRight(m601(1, 1), Buffer(1){0xb}, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 20), Buffer(1){0xb}, Local0)
		m600(arg0, 45, Local0, 0x1aca14)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 20, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 47, Local0, 0x1aca14)
		}

		// Conversion of the both operands

		Store(ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Buffer(1){0xb}), Local0)
		m600(arg0, 48, Local0, 0)

		Store(ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(1){0xb}), Local0)
		m600(arg0, 49, Local0, 0x1aca14)

		ShiftRight(Buffer(3){0x21, 0x03, 0x00}, Buffer(1){0xb}, Local0)
		m600(arg0, 50, Local0, 0)

		ShiftRight(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(1){0xb}, Local0)
		m600(arg0, 51, Local0, 0x1aca14)
	}

	// Subtract, common 32-bit/64-bit test
	Method(m059, 1)
	{
		// Conversion of the first operand

		Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, 1), Local0)
		m600(arg0, 1, Local0, 0x320)

		Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, aui6), Local0)
		m600(arg0, 3, Local0, 0x320)

		if (y078) {
			Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x320)
		}

		Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x320)

		// Method returns Integer

		Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x320)
		}

		Subtract(Buffer(3){0x21, 0x03, 0x00}, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Subtract(Buffer(3){0x21, 0x03, 0x00}, 1, Local0)
		m600(arg0, 13, Local0, 0x320)

		Subtract(Buffer(3){0x21, 0x03, 0x00}, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Subtract(Buffer(3){0x21, 0x03, 0x00}, aui6, Local0)
		m600(arg0, 15, Local0, 0x320)

		if (y078) {
			Subtract(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Subtract(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x320)
		}

		Subtract(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Subtract(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x320)

		// Method returns Integer

		Subtract(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Subtract(Buffer(3){0x21, 0x03, 0x00}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Subtract(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x320)
		}

		// Conversion of the second operand

		Store(Subtract(0, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 24, Local0, 0xfffffffffffffcdf)

		Store(Subtract(1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffce0)

		Store(Subtract(aui5, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 26, Local0, 0xfffffffffffffcdf)

		Store(Subtract(aui6, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffce0)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 28, Local0, 0xfffffffffffffcdf)

			Store(Subtract(Derefof(Refof(aui6)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffce0)
		}

		Store(Subtract(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 30, Local0, 0xfffffffffffffcdf)

		Store(Subtract(Derefof(Index(paui, 6)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffce0)

		// Method returns Integer

		Store(Subtract(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 32, Local0, 0xfffffffffffffcdf)

		Store(Subtract(m601(1, 6), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffce0)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 34, Local0, 0xfffffffffffffcdf)

			Store(Subtract(Derefof(m602(1, 6, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffce0)
		}

		Subtract(0, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 36, Local0, 0xfffffffffffffcdf)

		Subtract(1, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffce0)

		Subtract(aui5, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 38, Local0, 0xfffffffffffffcdf)

		Subtract(aui6, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffce0)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 40, Local0, 0xfffffffffffffcdf)

			Subtract(Derefof(Refof(aui6)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffce0)
		}

		Subtract(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 42, Local0, 0xfffffffffffffcdf)

		Subtract(Derefof(Index(paui, 6)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffce0)

		// Method returns Integer

		Subtract(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 44, Local0, 0xfffffffffffffcdf)

		Subtract(m601(1, 6), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffce0)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 46, Local0, 0xfffffffffffffcdf)

			Subtract(Derefof(m602(1, 6, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffce0)
		}
	}

	// Subtract, 64-bit
	Method(m05a, 1)
	{
		// Conversion of the first operand

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a283)

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a283)
		}

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a283)
		}

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a283)

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a283)
		}

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a283)
		}

		// Conversion of the second operand

		Store(Subtract(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7d)

		Store(Subtract(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7d)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0x01834c6e29af5d7c)

			Store(Subtract(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7d)
		}

		Store(Subtract(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7d)

		// Method returns Integer

		Store(Subtract(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0x01834c6e29af5d7c)

			Store(Subtract(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7d)
		}

		Subtract(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0x01834c6e29af5d7c)

		Subtract(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7d)

		Subtract(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0x01834c6e29af5d7c)

		Subtract(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7d)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0x01834c6e29af5d7c)

			Subtract(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7d)
		}

		Subtract(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0x01834c6e29af5d7c)

		Subtract(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7d)

		// Method returns Integer

		Subtract(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0x01834c6e29af5d7c)

		Subtract(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0x01834c6e29af5d7c)

			Subtract(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7d)
		}

		// Conversion of the both operands

		Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0x01834c6e29af609d)

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d6509f63)

		Subtract(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0x01834c6e29af609d)

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d6509f63)
	}

	// Subtract, 32-bit
	Method(m05b, 1)
	{
		// Conversion of the first operand

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, 0xd650a283)

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, 0xd650a283)

		if (y078) {
			Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xd650a283)
		}

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xd650a283)

		// Method returns Integer

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xd650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xd650a283)
		}

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1, Local0)
		m600(arg0, 13, Local0, 0xd650a283)

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6, Local0)
		m600(arg0, 15, Local0, 0xd650a283)

		if (y078) {
			Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xd650a283)
		}

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xd650a283)

		// Method returns Integer

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xd650a283)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xd650a283)
		}

		// Conversion of the second operand

		Store(Subtract(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0x29af5d7c)

		Store(Subtract(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0x29af5d7d)

		Store(Subtract(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0x29af5d7c)

		Store(Subtract(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0x29af5d7d)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0x29af5d7c)

			Store(Subtract(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0x29af5d7d)
		}

		Store(Subtract(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0x29af5d7c)

		Store(Subtract(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0x29af5d7d)

		// Method returns Integer

		Store(Subtract(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0x29af5d7c)

		Store(Subtract(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0x29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0x29af5d7c)

			Store(Subtract(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0x29af5d7d)
		}

		Subtract(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0x29af5d7c)

		Subtract(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0x29af5d7d)

		Subtract(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0x29af5d7c)

		Subtract(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0x29af5d7d)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0x29af5d7c)

			Subtract(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0x29af5d7d)
		}

		Subtract(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0x29af5d7c)

		Subtract(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0x29af5d7d)

		// Method returns Integer

		Subtract(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0x29af5d7c)

		Subtract(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0x29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0x29af5d7c)

			Subtract(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0x29af5d7d)
		}

		// Conversion of the both operands

		Store(Subtract(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0x29af609d)

		Store(Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0xd6509f63)

		Subtract(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0x29af609d)

		Subtract(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0xd6509f63)
	}

	// XOr, common 32-bit/64-bit test
	Method(m05c, 1)
	{
		// Conversion of the first operand

		Store(XOr(Buffer(3){0x21, 0x03, 0x00}, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(XOr(Buffer(3){0x21, 0x03, 0x00}, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfffffffffffffcde)

		Store(XOr(Buffer(3){0x21, 0x03, 0x00}, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(XOr(Buffer(3){0x21, 0x03, 0x00}, auij), Local0)
		m600(arg0, 3, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(XOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(XOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfffffffffffffcde)
		}

		Store(XOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(XOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(XOr(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(XOr(Buffer(3){0x21, 0x03, 0x00}, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(XOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfffffffffffffcde)
		}

		XOr(Buffer(3){0x21, 0x03, 0x00}, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		XOr(Buffer(3){0x21, 0x03, 0x00}, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfffffffffffffcde)

		XOr(Buffer(3){0x21, 0x03, 0x00}, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		XOr(Buffer(3){0x21, 0x03, 0x00}, auij, Local0)
		m600(arg0, 15, Local0, 0xfffffffffffffcde)

		if (y078) {
			XOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			XOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfffffffffffffcde)
		}

		XOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		XOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		XOr(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		XOr(Buffer(3){0x21, 0x03, 0x00}, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			XOr(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfffffffffffffcde)
		}

		// Conversion of the second operand

		Store(XOr(0, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(XOr(0xffffffffffffffff, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffcde)

		Store(XOr(aui5, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(XOr(auij, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(XOr(Derefof(Refof(auij)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffcde)
		}

		Store(XOr(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(XOr(Derefof(Index(paui, 19)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(XOr(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(XOr(m601(1, 19), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(XOr(Derefof(m602(1, 19, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffcde)
		}

		XOr(0, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 36, Local0, 0x321)

		XOr(0xffffffffffffffff, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffcde)

		XOr(aui5, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 38, Local0, 0x321)

		XOr(auij, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffcde)

		if (y078) {
			XOr(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 40, Local0, 0x321)

			XOr(Derefof(Refof(auij)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffcde)
		}

		XOr(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 42, Local0, 0x321)

		XOr(Derefof(Index(paui, 19)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		XOr(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 44, Local0, 0x321)

		XOr(m601(1, 19), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 46, Local0, 0x321)

			XOr(Derefof(m602(1, 19, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffcde)
		}
	}

	// XOr, 64-bit
	Method(m05d, 1)
	{
		// Conversion of the first operand

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x01834c6e29af5d7b)

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auij), Local0)
		m600(arg0, 3, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x01834c6e29af5d7b)
		}

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x01834c6e29af5d7b)
		}

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x01834c6e29af5d7b)

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auij, Local0)
		m600(arg0, 15, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x01834c6e29af5d7b)
		}

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the second operand

		Store(XOr(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(XOr(0xffffffffffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7b)

		Store(XOr(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(XOr(auij, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(XOr(Derefof(Refof(auij)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7b)
		}

		Store(XOr(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(XOr(Derefof(Index(paui, 19)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(XOr(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(XOr(m601(1, 19), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(XOr(Derefof(m602(1, 19, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7b)
		}

		XOr(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		XOr(0xffffffffffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7b)

		XOr(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		XOr(auij, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			XOr(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			XOr(Derefof(Refof(auij)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7b)
		}

		XOr(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		XOr(Derefof(Index(paui, 19)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		XOr(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		XOr(m601(1, 19), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			XOr(Derefof(m602(1, 19, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the both operands

		Store(XOr(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a1a5)

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a1a5)

		XOr(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a1a5)

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a1a5)
	}

	// XOr, 32-bit
	Method(m05e, 1)
	{
		// Conversion of the first operand

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0x29af5d7b)

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auii), Local0)
		m600(arg0, 3, Local0, 0x29af5d7b)

		if (y078) {
			Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0x29af5d7b)
		}

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0x29af5d7b)

		// Method returns Integer

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0x29af5d7b)
		}

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0x29af5d7b)

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, auii, Local0)
		m600(arg0, 15, Local0, 0x29af5d7b)

		if (y078) {
			XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0x29af5d7b)
		}

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0x29af5d7b)

		// Method returns Integer

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0x29af5d7b)
		}

		// Conversion of the second operand

		Store(XOr(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, 0xd650a284)

		Store(XOr(0xffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, 0x29af5d7b)

		Store(XOr(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, 0xd650a284)

		Store(XOr(auii, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, 0x29af5d7b)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, 0xd650a284)

			Store(XOr(Derefof(Refof(auii)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, 0x29af5d7b)
		}

		Store(XOr(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, 0xd650a284)

		Store(XOr(Derefof(Index(paui, 18)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, 0x29af5d7b)

		// Method returns Integer

		Store(XOr(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, 0xd650a284)

		Store(XOr(m601(1, 18), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, 0xd650a284)

			Store(XOr(Derefof(m602(1, 18, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, 0x29af5d7b)
		}

		XOr(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, 0xd650a284)

		XOr(0xffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, 0x29af5d7b)

		XOr(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, 0xd650a284)

		XOr(auii, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, 0x29af5d7b)

		if (y078) {
			XOr(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, 0xd650a284)

			XOr(Derefof(Refof(auii)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, 0x29af5d7b)
		}

		XOr(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, 0xd650a284)

		XOr(Derefof(Index(paui, 18)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, 0x29af5d7b)

		// Method returns Integer

		XOr(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, 0xd650a284)

		XOr(m601(1, 18), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, 0xd650a284)

			XOr(Derefof(m602(1, 18, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, 0x29af5d7b)
		}

		// Conversion of the both operands

		Store(XOr(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, 0xd650a1a5)

		Store(XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, 0xd650a1a5)

		XOr(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 50, Local0, 0xd650a1a5)

		XOr(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 51, Local0, 0xd650a1a5)
	}

	// Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
	// ShiftLeft, ShiftRight, Subtract, Xor

	Method(m64n, 1)
	{
		// Add
		Concatenate(arg0, "-m03b", Local0)
		SRMT(Local0)
		m03b(Local0)
		Concatenate(arg0, "-m03c", Local0)
		SRMT(Local0)
		m03c(Local0)

		// And
		Concatenate(arg0, "-m03e", Local0)
		SRMT(Local0)
		m03e(Local0)
		Concatenate(arg0, "-m03f", Local0)
		SRMT(Local0)
		m03f(Local0)

		// Divide
		Concatenate(arg0, "-m041", Local0)
		SRMT(Local0)
		m041(Local0)
		Concatenate(arg0, "-m042", Local0)
		SRMT(Local0)
		m042(Local0)

		// Mod
		Concatenate(arg0, "-m044", Local0)
		SRMT(Local0)
		m044(Local0)
		Concatenate(arg0, "-m045", Local0)
		SRMT(Local0)
		m045(Local0)

		// Multiply
		Concatenate(arg0, "-m047", Local0)
		SRMT(Local0)
		m047(Local0)
		Concatenate(arg0, "-m048", Local0)
		SRMT(Local0)
		m048(Local0)

		// NAnd
		Concatenate(arg0, "-m04a", Local0)
		SRMT(Local0)
		m04a(Local0)
		Concatenate(arg0, "-m04b", Local0)
		SRMT(Local0)
		m04b(Local0)

		// NOr
		Concatenate(arg0, "-m04d", Local0)
		SRMT(Local0)
		m04d(Local0)
		Concatenate(arg0, "-m04e", Local0)
		SRMT(Local0)
		m04e(Local0)

		// Or
		Concatenate(arg0, "-m050", Local0)
		SRMT(Local0)
		m050(Local0)
		Concatenate(arg0, "-m051", Local0)
		SRMT(Local0)
		m051(Local0)

		// ShiftLeft
		Concatenate(arg0, "-m053", Local0)
		SRMT(Local0)
		m053(Local0)
		Concatenate(arg0, "-m054", Local0)
		SRMT(Local0)
		m054(Local0)

		// ShiftRight
		Concatenate(arg0, "-m056", Local0)
		SRMT(Local0)
		m056(Local0)
		Concatenate(arg0, "-m057", Local0)
		SRMT(Local0)
		m057(Local0)

		// Subtract
		Concatenate(arg0, "-m059", Local0)
		SRMT(Local0)
		m059(Local0)
		Concatenate(arg0, "-m05a", Local0)
		SRMT(Local0)
		m05a(Local0)

		// XOr
		Concatenate(arg0, "-m05c", Local0)
		SRMT(Local0)
		m05c(Local0)
		Concatenate(arg0, "-m05d", Local0)
		SRMT(Local0)
		m05d(Local0)
	}

	Method(m32n, 1)
	{
		// Add
		Concatenate(arg0, "-m03b", Local0)
		SRMT(Local0)
		m03b(Local0)
		Concatenate(arg0, "-m03d", Local0)
		SRMT(Local0)
		m03d(Local0)

		// And
		Concatenate(arg0, "-m03e", Local0)
		SRMT(Local0)
		m03e(Local0)
		Concatenate(arg0, "-m040", Local0)
		SRMT(Local0)
		m040(Local0)

		// Divide
		Concatenate(arg0, "-m041", Local0)
		SRMT(Local0)
		m041(Local0)
		Concatenate(arg0, "-m043", Local0)
		SRMT(Local0)
		m043(Local0)

		// Mod
		Concatenate(arg0, "-m044", Local0)
		SRMT(Local0)
		m044(Local0)
		Concatenate(arg0, "-m046", Local0)
		SRMT(Local0)
		m046(Local0)

		// Multiply
		Concatenate(arg0, "-m047", Local0)
		SRMT(Local0)
		m047(Local0)
		Concatenate(arg0, "-m049", Local0)
		SRMT(Local0)
		m049(Local0)

		// NAnd
		Concatenate(arg0, "-m04a", Local0)
		SRMT(Local0)
		if (y119) {
			m04a(Local0)
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m04c", Local0)
		SRMT(Local0)
		m04c(Local0)

		// NOr
		Concatenate(arg0, "-m04d", Local0)
		SRMT(Local0)
		if (y119) {
			m04d(Local0)
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m04f", Local0)
		SRMT(Local0)
		m04f(Local0)

		// Or
		Concatenate(arg0, "-m050", Local0)
		SRMT(Local0)
		if (y119) {
			m050(Local0)
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m052", Local0)
		SRMT(Local0)
		m052(Local0)

		// ShiftLeft
		Concatenate(arg0, "-m053", Local0)
		SRMT(Local0)
		m053(Local0)
		Concatenate(arg0, "-m055", Local0)
		SRMT(Local0)
		m055(Local0)

		// ShiftRight
		Concatenate(arg0, "-m056", Local0)
		SRMT(Local0)
		m056(Local0)
		Concatenate(arg0, "-m058", Local0)
		SRMT(Local0)
		m058(Local0)

		// Subtract
		Concatenate(arg0, "-m059", Local0)
		SRMT(Local0)
		if (y119) {
			m059(Local0)
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m05b", Local0)
		SRMT(Local0)
		m05b(Local0)

		// XOr
		Concatenate(arg0, "-m05c", Local0)
		SRMT(Local0)
		if (y119) {
			m05c(Local0)
		} else {
			BLCK()
		}
		Concatenate(arg0, "-m05e", Local0)
		SRMT(Local0)
		m05e(Local0)
	}

	// Buffer to Integer conversion of each Buffer operand
	// of the 2-parameter Logical Integer operators LAnd and LOr

	// LAnd, common 32-bit/64-bit test
	Method(m05f, 1)
	{
		// Conversion of the first operand

		Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 23, Local0, Ones)
		}
	}

	// LAnd, 64-bit
	Method(m060, 1)
	{
		// Conversion of the first operand

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// LAnd, 32-bit
	Method(m061, 1)
	{
		// Conversion of the first operand

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(LAnd(Buffer(3){0x21, 0x03, 0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(LAnd(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// Lor, common 32-bit/64-bit test
	Method(m062, 1)
	{
		// Conversion of the first operand

		Store(Lor(Buffer(1){0x00}, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(Lor(Buffer(1){0x00}, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor(Buffer(1){0x00}, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(Lor(Buffer(1){0x00}, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor(Buffer(1){0x00}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(Lor(Buffer(1){0x00}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor(Buffer(1){0x00}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(Lor(Buffer(1){0x00}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor(Buffer(1){0x00}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(Lor(Buffer(1){0x00}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Buffer(1){0x00}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(Lor(Buffer(1){0x00}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, Buffer(1){0x00}), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(Lor(1, Buffer(1){0x00}), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, Buffer(1){0x00}), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(Lor(aui6, Buffer(1){0x00}), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), Buffer(1){0x00}), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(Lor(Derefof(Refof(aui6)), Buffer(1){0x00}), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), Buffer(1){0x00}), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(Lor(Derefof(Index(paui, 6)), Buffer(1){0x00}), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), Buffer(1){0x00}), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(Lor(m601(1, 6), Buffer(1){0x00}), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), Buffer(1){0x00}), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(Lor(Derefof(m602(1, 6, 1)), Buffer(1){0x00}), Local0)
			m600(arg0, 23, Local0, Ones)
		}
	}

	// Lor, 64-bit
	Method(m063, 1)
	{
		// Conversion of the first operand

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(Lor(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 14, Local0, Ones)

		Store(Lor(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 16, Local0, Ones)

			Store(Lor(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 18, Local0, Ones)

		Store(Lor(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 20, Local0, Ones)

		Store(Lor(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 22, Local0, Ones)

			Store(Lor(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(Lor(Buffer(1){0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(1){0x00}), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// Lor, 32-bit
	Method(m064, 1)
	{
		// Conversion of the first operand

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 0), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui5), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(Lor(1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 14, Local0, Ones)

		Store(Lor(aui6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 16, Local0, Ones)

			Store(Lor(Derefof(Refof(aui6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 18, Local0, Ones)

		Store(Lor(Derefof(Index(paui, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 20, Local0, Ones)

		Store(Lor(m601(1, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 22, Local0, Ones)

			Store(Lor(Derefof(m602(1, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(Lor(Buffer(1){0x00}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(Lor(Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Buffer(1){0x00}), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	Method(m64o, 1)
	{
		// LAnd
		Concatenate(arg0, "-m05f", Local0)
		SRMT(Local0)
		m05f(Local0)
		Concatenate(arg0, "-m060", Local0)
		SRMT(Local0)
		m060(Local0)

		// LOr
		Concatenate(arg0, "-m062", Local0)
		SRMT(Local0)
		m062(Local0)
		Concatenate(arg0, "-m063", Local0)
		SRMT(Local0)
		m063(Local0)
	}

	Method(m32o, 1)
	{
		// LAnd
		Concatenate(arg0, "-m05f", Local0)
		SRMT(Local0)
		m05f(Local0)
		Concatenate(arg0, "-m061", Local0)
		SRMT(Local0)
		m061(Local0)

		// LOr
		Concatenate(arg0, "-m062", Local0)
		SRMT(Local0)
		m062(Local0)
		Concatenate(arg0, "-m064", Local0)
		SRMT(Local0)
		m064(Local0)
	}


	// Buffer to Integer conversion of the Buffer second operand of
	// Logical operators when the first operand is evaluated as Integer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)

	Method(m64p, 1)
	{
		// LEqual

		Store(LEqual(0xfe7cb391d650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0xfe7cb391d650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0xfe7cb391d650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(aui4, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auid, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auif, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aui4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auid)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auif)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 13)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 15)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 4), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 13), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 15), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 4, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m602(1, 13, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m602(1, 15, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0xfe7cb391d650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0xfe7cb391d650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0xfe7cb391d650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(aui4, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auid, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auif, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(aui4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auid)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auif)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 13)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 15)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 4), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 13), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 15), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 4, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m602(1, 13, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m602(1, 15, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0xfe7cb391d650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0xfe7cb391d650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0xfe7cb391d650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(aui4, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auid, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auif, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aui4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auid)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auif)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 13)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 15)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 4), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 13), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 15), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 4, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 13, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 15, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0xfe7cb391d650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0xfe7cb391d650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0xfe7cb391d650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(aui4, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auid, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auif, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(aui4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auid)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auif)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 13)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 15)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 4), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 13), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 15), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 4, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m602(1, 13, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m602(1, 15, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0xfe7cb391d650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0xfe7cb391d650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0xfe7cb391d650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(aui4, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auid, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auif, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aui4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auid)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auif)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 13)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 15)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 4), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 13), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 15), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 4, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m602(1, 13, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m602(1, 15, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0xfe7cb391d650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0xfe7cb391d650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0xfe7cb391d650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(aui4, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auid, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auif, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aui4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auid)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auif)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 4)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 13)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 15)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 4), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 13), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 15), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 4, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m602(1, 13, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m602(1, 15, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	Method(m32p, 1)
	{
		// LEqual

		Store(LEqual(0xd650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0xd650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0xd650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(auik, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auil, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auim, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(auik)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auil)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auim)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 20)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 21)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 22)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 20), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 21), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 22), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 20, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m601(1, 21, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m601(1, 22, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0xd650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0xd650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0xd650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(auik, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auil, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auim, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(auik)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auil)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auim)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 20)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 21)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 22)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 20), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 21), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 22), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 20, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m601(1, 21, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m601(1, 22, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0xd650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0xd650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0xd650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(auik, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auil, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auim, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(auik)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auil)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auim)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 20)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 21)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 22)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 20), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 21), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 22), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 20, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m601(1, 21, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m601(1, 22, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0xd650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0xd650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0xd650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(auik, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auil, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auim, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(auik)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auil)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auim)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 20)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 21)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 22)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 20), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 21), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 22), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 20, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m601(1, 21, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m601(1, 22, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0xd650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0xd650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0xd650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(auik, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auil, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auim, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(auik)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auil)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auim)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 20)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 21)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 22)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 20), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 21), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 22), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 20, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m601(1, 21, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m601(1, 22, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0xd650a284, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0xd650a285, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0xd650a283, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(auik, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auil, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auim, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(auik)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auil)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auim)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 20)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 21)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 22)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 20), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 21), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 22), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 20, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m601(1, 21, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m601(1, 22, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	Method(m065, 1)
	{
		// LEqual

		Store(LEqual(0x321, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0x322, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0x320, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(aui1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auig, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auih, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aui1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auig)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auih)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 16)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 17)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 1), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 16), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 17), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 1, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m602(1, 16, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m602(1, 17, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0x321, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0x322, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0x320, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(aui1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auig, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auih, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(aui1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auig)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auih)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 16)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 17)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 1), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 16), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 17), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 1, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m602(1, 16, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m602(1, 17, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0x321, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0x322, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0x320, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(aui1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auig, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auih, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aui1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auig)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auih)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 16)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 17)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 1), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 16), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 17), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 1, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 16, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 17, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0x321, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0x322, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0x320, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(aui1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auig, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auih, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(aui1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auig)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auih)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 16)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 17)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 1), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 16), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 17), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 1, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m602(1, 16, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m602(1, 17, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0x321, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0x322, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0x320, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(aui1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auig, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auih, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aui1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auig)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auih)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 16)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 17)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 1), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 16), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 17), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 1, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m602(1, 16, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m602(1, 17, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0x321, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0x322, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0x320, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(aui1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auig, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auih, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aui1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auig)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auih)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 16)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 17)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 1), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 16), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 17), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 1, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m602(1, 16, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m602(1, 17, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	// Buffer to Integer intermediate conversion of the Buffer second
	// operand of Concatenate operator in case the first one is Integer

	Method(m64q, 1)
	{		
		Store(Concatenate(0x321, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 0, Local0, bb26)

		Store(Concatenate(0x321, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 1, Local0, bb21)


		Store(Concatenate(aui1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 2, Local0, bb26)

		Store(Concatenate(aui1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 3, Local0, bb21)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aui1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 4, Local0, bb26)

			Store(Concatenate(Derefof(Refof(aui1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 5, Local0, bb21)
		}

		Store(Concatenate(Derefof(Index(paui, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 6, Local0, bb26)

		Store(Concatenate(Derefof(Index(paui, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 7, Local0, bb21)

		// Method returns Integer

		Store(Concatenate(m601(1, 1), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 8, Local0, bb26)

		Store(Concatenate(m601(1, 1), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 9, Local0, bb21)

		// Method returns Reference to Integer

		if (y500) {
			Store(Concatenate(Derefof(m602(1, 1, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 10, Local0, bb26)

			Store(Concatenate(Derefof(m602(1, 1, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 11, Local0, bb21)
		}

		Concatenate(0x321, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 12, Local0, bb26)

		Concatenate(0x321, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 13, Local0, bb21)


		Concatenate(aui1, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 14, Local0, bb26)

		Concatenate(aui1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 15, Local0, bb21)

		if (y078) {
			Concatenate(Derefof(Refof(aui1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 16, Local0, bb26)

			Concatenate(Derefof(Refof(aui1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 17, Local0, bb21)
		}

		Concatenate(Derefof(Index(paui, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 18, Local0, bb26)

		Concatenate(Derefof(Index(paui, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 19, Local0, bb21)

		// Method returns Integer

		Concatenate(m601(1, 1), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 20, Local0, bb26)

		Concatenate(m601(1, 1), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 21, Local0, bb21)

		// Method returns Reference to Integer

		if (y500) {
			Concatenate(Derefof(m602(1, 1, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 22, Local0, bb26)

			Concatenate(Derefof(m602(1, 1, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 23, Local0, bb21)
		}
	}

	Method(m32q, 1)
	{		
		Store(Concatenate(0x321, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 0, Local0, bb27)

		Store(Concatenate(0x321, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 1, Local0, bb28)


		Store(Concatenate(aui1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 2, Local0, bb27)

		Store(Concatenate(aui1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 3, Local0, bb28)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aui1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 4, Local0, bb27)

			Store(Concatenate(Derefof(Refof(aui1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 5, Local0, bb28)
		}

		Store(Concatenate(Derefof(Index(paui, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 6, Local0, bb27)

		Store(Concatenate(Derefof(Index(paui, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 7, Local0, bb28)

		// Method returns Integer

		Store(Concatenate(m601(1, 1), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 8, Local0, bb27)

		Store(Concatenate(m601(1, 1), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 9, Local0, bb28)

		// Method returns Reference to Integer

		if (y500) {
			Store(Concatenate(Derefof(m602(1, 1, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 10, Local0, bb27)

			Store(Concatenate(Derefof(m602(1, 1, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 11, Local0, bb28)
		}

		Concatenate(0x321, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 12, Local0, bb27)

		Concatenate(0x321, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 13, Local0, bb28)


		Concatenate(aui1, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 14, Local0, bb27)

		Concatenate(aui1, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 15, Local0, bb28)

		if (y078) {
			Concatenate(Derefof(Refof(aui1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 16, Local0, bb27)

			Concatenate(Derefof(Refof(aui1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 17, Local0, bb28)
		}

		Concatenate(Derefof(Index(paui, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 18, Local0, bb27)

		Concatenate(Derefof(Index(paui, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 20, Local0, bb28)

		// Method returns Integer

		Concatenate(m601(1, 1), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 21, Local0, bb27)

		Concatenate(m601(1, 1), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 22, Local0, bb28)

		// Method returns Reference to Integer

		if (y500) {
			Concatenate(Derefof(m602(1, 1, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 23, Local0, bb27)

			Concatenate(Derefof(m602(1, 1, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 24, Local0, bb28)
		}
	}

	// Buffer to Integer conversion of the Buffer Length (second)
	// operand of the ToString operator

	// Common 32-bit/64-bit test
	Method(m066, 1)
	{
		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			Buffer(1){0xb}), Local0)
		m600(arg0, 0, Local0, bs1b)

		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 1, Local0, bs1c)

		Store(ToString(aub6, Buffer(1){0xb}), Local0)
		m600(arg0, 2, Local0, bs1b)

		Store(ToString(aub6, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 3, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), Buffer(1){0xb}), Local0)
			m600(arg0, 4, Local0, bs1b)

			Store(ToString(Derefof(Refof(aub6)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), Buffer(1){0xb}), Local0)
		m600(arg0, 6, Local0, bs1b)

		Store(ToString(Derefof(Index(paub, 6)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 7, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), Buffer(1){0xb}), Local0)
		m600(arg0, 8, Local0, bs1b)

		Store(ToString(m601(3, 6), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 10, Local0, bs1b)

			Store(ToString(Derefof(m602(3, 6, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 11, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			Buffer(1){0xb}, Local0)
		m600(arg0, 12, Local0, bs1b)

		ToString(Buffer() {"This is auxiliary Buffer"},
			Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 13, Local0, bs1c)

		ToString(aub6, Buffer(1){0xb}, Local0)
		m600(arg0, 14, Local0, bs1b)

		ToString(aub6, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 15, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), Buffer(1){0xb}, Local0)
			m600(arg0, 16, Local0, bs1b)

			ToString(Derefof(Refof(aub6)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 17, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), Buffer(1){0xb}, Local0)
		m600(arg0, 18, Local0, bs1b)

		ToString(Derefof(Index(paub, 6)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 19, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), Buffer(1){0xb}, Local0)
		m600(arg0, 20, Local0, bs1b)

		ToString(m601(3, 6), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 21, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 22, Local0, bs1b)

			ToString(Derefof(m602(3, 6, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 23, Local0, bs1c)
		}
	}

	Method(m64r, 1)
	{
		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 0, Local0, bs1c)

		Store(ToString(aub6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 1, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 2, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 3, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 4, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 6, Local0, bs1c)

		ToString(aub6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 7, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 8, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 10, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 11, Local0, bs1c)
		}
	}

	Method(m32r, 1)
	{
		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 0, Local0, bs1c)

		Store(ToString(aub6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 1, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 2, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 3, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 4, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 6, Local0, bs1c)

		ToString(aub6, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 7, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 8, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 10, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 11, Local0, bs1c)
		}
	}

	// Buffer to Integer conversion of the Buffer Index (second)
	// operand of the Index operator
	Method(m067, 1)
	{
		Store(Index(aus6, Buffer(1){0xb}), Local0)
		m600(arg0, 0, Derefof(Local0), bi10)

		Store(Index(aub6, Buffer(1){0xb}), Local0)
		m600(arg0, 1, Derefof(Local0), bi10)

		Store(Index(aup0, Buffer(1){0xb}), Local0)
		m600(arg0, 2, Derefof(Local0), bi11)

		if (y078) {
			Store(Index(Derefof(Refof(aus6)), Buffer(1){0xb}), Local0)
			m600(arg0, 3, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aub6)), Buffer(1){0xb}), Local0)
			m600(arg0, 4, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aup0)), Buffer(1){0xb}), Local0)
			m600(arg0, 5, Derefof(Local0), bi11)
		}

		Store(Index(Derefof(Index(paus, 6)), Buffer(1){0xb}), Local0)
		m600(arg0, 6, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paub, 6)), Buffer(1){0xb}), Local0)
		m600(arg0, 7, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paup, 0)), Buffer(1){0xb}), Local0)
		m600(arg0, 8, Derefof(Local0), bi11)


		// Method returns Object

		if (y900) {
			Store(Index(m601(2, 6), Buffer(1){0xb}), Local0)
			m600(arg0, 9, Derefof(Local0), bi10)

			Store(Index(m601(3, 6), Buffer(1){0xb}), Local0)
			m600(arg0, 10, Derefof(Local0), bi10)

			Store(Index(m601(4, 0), Buffer(1){0xb}), Local0)
			m600(arg0, 11, Derefof(Local0), bi11)
		} else {

			CH03(arg0, z085, 0, 0, 0)

			Store(Index(m601(2, 6), Buffer(1){0xb}), Local3)
			CH04(arg0, 0, 85, z085, 9, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Store(Index(m601(3, 6), Buffer(1){0xb}), Local3)
			CH04(arg0, 0, 85, z085, 10, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Store(Index(m601(4, 0), Buffer(1){0xb}), Local3)
			CH04(arg0, 0, 85, z085, 11, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED
		}

		// Method returns Reference

		if (y500) {
			Store(Index(Derefof(m602(2, 6, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 12, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(3, 6, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 13, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(4, 0, 1)), Buffer(1){0xb}), Local0)
			m600(arg0, 14, Derefof(Local0), bi11)
		}

		Index(aus6, Buffer(1){0xb}, Local0)
		m600(arg0, 15, Derefof(Local0), bi10)

		Index(aub6, Buffer(1){0xb}, Local0)
		m600(arg0, 16, Derefof(Local0), bi10)

		Index(aup0, Buffer(1){0xb}, Local0)
		m600(arg0, 17, Derefof(Local0), bi11)

		if (y078) {
			Index(Derefof(Refof(aus6)), Buffer(1){0xb}, Local0)
			m600(arg0, 18, Derefof(Local0), bi10)

			Index(Derefof(Refof(aub6)), Buffer(1){0xb}, Local0)
			m600(arg0, 19, Derefof(Local0), bi10)

			Index(Derefof(Refof(aup0)), Buffer(1){0xb}, Local0)
			m600(arg0, 20, Derefof(Local0), bi11)
		}

		Index(Derefof(Index(paus, 6)), Buffer(1){0xb}, Local0)
		m600(arg0, 21, Derefof(Local0), bi10)

		Index(Derefof(Index(paub, 6)), Buffer(1){0xb}, Local0)
		m600(arg0, 22, Derefof(Local0), bi10)

		Index(Derefof(Index(paup, 0)), Buffer(1){0xb}, Local0)
		m600(arg0, 23, Derefof(Local0), bi11)


		// Method returns Object

		if (y900) {
			Index(m601(2, 6), Buffer(1){0xb}, Local0)
			m600(arg0, 24, Derefof(Local0), bi10)

			Index(m601(3, 6), Buffer(1){0xb}, Local0)
			m600(arg0, 25, Derefof(Local0), bi10)

			Index(m601(4, 0), Buffer(1){0xb}, Local0)
			m600(arg0, 26, Derefof(Local0), bi11)
		} else {

			CH03(arg0, z085, 0, 0, 0)

			Index(m601(2, 6), Buffer(1){0xb}, Local0)
			CH04(arg0, 0, 85, z085, 24, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Index(m601(3, 6), Buffer(1){0xb}, Local0)
			CH04(arg0, 0, 85, z085, 25, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Index(m601(4, 0), Buffer(1){0xb}, Local0)
			CH04(arg0, 0, 85, z085, 26, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED
		}

		// Method returns Reference

		if (y500) {
			Index(Derefof(m602(2, 6, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 27, Derefof(Local0), bi10)

			Index(Derefof(m602(3, 6, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 28, Derefof(Local0), bi10)

			Index(Derefof(m602(4, 0, 1)), Buffer(1){0xb}, Local0)
			m600(arg0, 29, Derefof(Local0), bi11)
		}

		if (y098) {
			Store(Index(aus6, Buffer(1){0xb}, Local1), Local0)
			m600(arg0, 30, Derefof(Local0), bi10)

			Store(Index(aub6, Buffer(1){0xb}, Local1), Local0)
			m600(arg0, 31, Derefof(Local0), bi10)

			Store(Index(aup0, Buffer(1){0xb}, Local1), Local0)
			m600(arg0, 32, Derefof(Local0), bi11)
		}

		if (y078) {
			Store(Index(Derefof(Refof(aus6)), Buffer(1){0xb}, Local1), Local0)
			m600(arg0, 33, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aub6)), Buffer(1){0xb}, Local1), Local0)
			m600(arg0, 34, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aup0)), Buffer(1){0xb}, Local1), Local0)
			m600(arg0, 35, Derefof(Local0), bi11)
		}

		if (y098) {
		Store(Index(Derefof(Index(paus, 6)), Buffer(1){0xb}, Local1), Local0)
		m600(arg0, 36, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paub, 6)), Buffer(1){0xb}, Local1), Local0)
		m600(arg0, 37, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paup, 0)), Buffer(1){0xb}, Local1), Local0)
		m600(arg0, 38, Derefof(Local0), bi11)
		}

		// Method returns Object

		if (LAnd(y900, y098)) {
			Store(Index(m601(2, 6), Buffer(1){0xb}, Local1), Local0)
			m600(arg0, 39, Derefof(Local0), bi10)

			Store(Index(m601(3, 6), Buffer(1){0xb}, Local1), Local0)
			m600(arg0, 40, Derefof(Local0), bi10)

			Store(Index(m601(4, 0), Buffer(1){0xb}, Local1), Local0)
			m600(arg0, 41, Derefof(Local0), bi11)
		}

		// Method returns Reference

		if (y500) {
			Store(Index(Derefof(m602(2, 6, 1)), Buffer(1){0xb}, Local1), Local0)
			m600(arg0, 42, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(3, 6, 1)), Buffer(1){0xb}, Local1), Local0)
			m600(arg0, 43, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(4, 0, 1)), Buffer(1){0xb}, Local1), Local0)
			m600(arg0, 44, Derefof(Local0), bi11)
		}
	}

	// Buffer to Integer conversion of the String Arg (third)
	// operand of the Fatal operator
	// (it can only be checked an exception does not occur)
	Method(m068, 1)
	{
		CH03(arg0, z085, 9, 0, 0)
		Fatal(0xff, 0xffffffff, Buffer(3){0x21, 0x03, 0x00})
		if (F64) {
			Fatal(0xff, 0xffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
		} else {
			Fatal(0xff, 0xffffffff, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
		}
		CH03(arg0, z085, 10, 0, 0)
	}

	// Buffer to Integer conversion of the Buffer Index and Length
	// operands of the Mid operator

	// Common 32-bit/64-bit test
	Method(m069, 1)
	{
		// String to Integer conversion of the String Index operand

		Store(Mid("This is auxiliary String", Buffer(1){0xb}, 10), Local0)
		m600(arg0, 0, Local0, bs1d)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, Buffer(1){0xb}, 10), Local0)
		m600(arg0, 1, Local0, bb32)

		Store(Mid(aus6, Buffer(1){0xb}, 10), Local0)
		m600(arg0, 2, Local0, bs1d)

		Store(Mid(aub6, Buffer(1){0xb}, 10), Local0)
		m600(arg0, 3, Local0, bb32)


		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), Buffer(1){0xb}, 10), Local0)
			m600(arg0, 4, Local0, bs1d)

			Store(Mid(Derefof(Refof(aub6)), Buffer(1){0xb}, 10), Local0)
			m600(arg0, 5, Local0, bb32)
		}

		Store(Mid(Derefof(Index(paus, 6)), Buffer(1){0xb}, 10), Local0)
		m600(arg0, 6, Local0, bs1d)

		Store(Mid(Derefof(Index(paub, 6)), Buffer(1){0xb}, 10), Local0)
		m600(arg0, 7, Local0, bb32)

		// Method returns Object

		Store(Mid(m601(2, 6), Buffer(1){0xb}, 10), Local0)
		m600(arg0, 8, Local0, bs1d)

		Store(Mid(m601(3, 6), Buffer(1){0xb}, 10), Local0)
		m600(arg0, 9, Local0, bb32)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), Buffer(1){0xb}, 10), Local0)
			m600(arg0, 10, Local0, bs1d)

			Store(Mid(Derefof(m602(3, 6, 1)), Buffer(1){0xb}, 10), Local0)
			m600(arg0, 11, Local0, bb32)
		}

		Mid("This is auxiliary String", Buffer(1){0xb}, 10, Local0)
		m600(arg0, 12, Local0, bs1d)

		Mid(Buffer(){"This is auxiliary Buffer"}, Buffer(1){0xb}, 10, Local0)
		m600(arg0, 13, Local0, bb32)

		Mid(aus6, Buffer(1){0xb}, 10, Local0)
		m600(arg0, 14, Local0, bs1d)

		Mid(aub6, Buffer(1){0xb}, 10, Local0)
		m600(arg0, 15, Local0, bb32)


		if (y078) {
			Mid(Derefof(Refof(aus6)), Buffer(1){0xb}, 10, Local0)
			m600(arg0, 16, Local0, bs1d)

			Mid(Derefof(Refof(aub6)), Buffer(1){0xb}, 10, Local0)
			m600(arg0, 17, Local0, bb32)
		}

		Mid(Derefof(Index(paus, 6)), Buffer(1){0xb}, 10, Local0)
		m600(arg0, 18, Local0, bs1d)

		Mid(Derefof(Index(paub, 6)), Buffer(1){0xb}, 10, Local0)
		m600(arg0, 19, Local0, bb32)

		// Method returns Object

		Mid(m601(2, 6), Buffer(1){0xb}, 10, Local0)
		m600(arg0, 20, Local0, bs1d)

		Mid(m601(3, 6), Buffer(1){0xb}, 10, Local0)
		m600(arg0, 21, Local0, bb32)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), Buffer(1){0xb}, 10, Local0)
			m600(arg0, 22, Local0, bs1d)

			Mid(Derefof(m602(3, 6, 1)), Buffer(1){0xb}, 10, Local0)
			m600(arg0, 23, Local0, bb32)
		}

		// String to Integer conversion of the String Length operand

		Store(Mid("This is auxiliary String", 0, Buffer(1){0xb}), Local0)
		m600(arg0, 24, Local0, bs1b)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, Buffer(1){0xb}), Local0)
		m600(arg0, 25, Local0, bb33)

		Store(Mid(aus6, 0, Buffer(1){0xb}), Local0)
		m600(arg0, 26, Local0, bs1b)

		Store(Mid(aub6, 0, Buffer(1){0xb}), Local0)
		m600(arg0, 27, Local0, bb33)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, Buffer(1){0xb}), Local0)
			m600(arg0, 28, Local0, bs1b)

			Store(Mid(Derefof(Refof(aub6)), 0, Buffer(1){0xb}), Local0)
			m600(arg0, 29, Local0, bb33)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, Buffer(1){0xb}), Local0)
		m600(arg0, 30, Local0, bs1b)

		Store(Mid(Derefof(Index(paub, 6)), 0, Buffer(1){0xb}), Local0)
		m600(arg0, 31, Local0, bb33)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, Buffer(1){0xb}), Local0)
		m600(arg0, 32, Local0, bs1b)

		Store(Mid(m601(3, 6), 0, Buffer(1){0xb}), Local0)
		m600(arg0, 33, Local0, bb33)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, Buffer(1){0xb}), Local0)
			m600(arg0, 34, Local0, bs1b)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, Buffer(1){0xb}), Local0)
			m600(arg0, 35, Local0, bb33)
		}

		Mid("This is auxiliary String", 0, Buffer(1){0xb}, Local0)
		m600(arg0, 36, Local0, bs1b)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, Buffer(1){0xb}, Local0)
		m600(arg0, 37, Local0, bb33)

		Mid(aus6, 0, Buffer(1){0xb}, Local0)
		m600(arg0, 37, Local0, bs1b)

		Mid(aub6, 0, Buffer(1){0xb}, Local0)
		m600(arg0, 39, Local0, bb33)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, Buffer(1){0xb}, Local0)
			m600(arg0, 40, Local0, bs1b)

			Mid(Derefof(Refof(aub6)), 0, Buffer(1){0xb}, Local0)
			m600(arg0, 41, Local0, bb33)
		}

		Mid(Derefof(Index(paus, 6)), 0, Buffer(1){0xb}, Local0)
		m600(arg0, 42, Local0, bs1b)

		Mid(Derefof(Index(paub, 6)), 0, Buffer(1){0xb}, Local0)
		m600(arg0, 43, Local0, bb33)

		// Method returns Object

		Mid(m601(2, 6), 0, Buffer(1){0xb}, Local0)
		m600(arg0, 44, Local0, bs1b)

		Mid(m601(3, 6), 0, Buffer(1){0xb}, Local0)
		m600(arg0, 45, Local0, bb33)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, Buffer(1){0xb}, Local0)
			m600(arg0, 46, Local0, bs1b)

			Mid(Derefof(m602(3, 6, 1)), 0, Buffer(1){0xb}, Local0)
			m600(arg0, 47, Local0, bb33)
		}
	}

	Method(m64s, 1)
	{
		// String to Integer conversion of the String Length operand

		Store(Mid("This is auxiliary String", 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 0, Local0, bs1e)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 1, Local0, bb34)

		Store(Mid(aus6, 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 2, Local0, bs1e)

		Store(Mid(aub6, 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 3, Local0, bb34)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 4, Local0, bs1e)

			Store(Mid(Derefof(Refof(aub6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 5, Local0, bb34)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 6, Local0, bs1e)

		Store(Mid(Derefof(Index(paub, 6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 7, Local0, bb34)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 8, Local0, bs1e)

		Store(Mid(m601(3, 6), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 9, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 10, Local0, bs1e)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 11, Local0, bb34)
		}

		Mid("This is auxiliary String", 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 12, Local0, bs1e)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 13, Local0, bb34)

		Mid(aus6, 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 14, Local0, bs1e)

		Mid(aub6, 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 15, Local0, bb34)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 16, Local0, bs1e)

			Mid(Derefof(Refof(aub6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 17, Local0, bb34)
		}

		Mid(Derefof(Index(paus, 6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 18, Local0, bs1e)

		Mid(Derefof(Index(paub, 6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 19, Local0, bb34)

		// Method returns Object

		Mid(m601(2, 6), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 20, Local0, bs1e)

		Mid(m601(3, 6), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 21, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 22, Local0, bs1e)

			Mid(Derefof(m602(3, 6, 1)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 23, Local0, bb34)
		}

		// String to Integer conversion of the both String operands

		Store(Mid("This is auxiliary String", Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, bs1f)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, bb35)

		Store(Mid(aus6, Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, bs1f)

		Store(Mid(aub6, Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, bb35)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, bs1f)

			Store(Mid(Derefof(Refof(aub6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, bb35)
		}

		Store(Mid(Derefof(Index(paus, 6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, bs1f)

		Store(Mid(Derefof(Index(paub, 6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, bb35)

		// Method returns Object

		Store(Mid(m601(2, 6), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, bs1f)

		Store(Mid(m601(3, 6), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, bs1f)

			Store(Mid(Derefof(m602(3, 6, 1)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, bb35)
		}

		Mid("This is auxiliary String", Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, bs1f)

		Mid(Buffer(){"This is auxiliary Buffer"}, Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, bb35)

		Mid(aus6, Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, bs1f)

		Mid(aub6, Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, bb35)


		if (y078) {
			Mid(Derefof(Refof(aus6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, bs1f)

			Mid(Derefof(Refof(aub6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, bb35)
		}

		Mid(Derefof(Index(paus, 6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, bs1f)

		Mid(Derefof(Index(paub, 6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, bb35)

		// Method returns Object

		Mid(m601(2, 6), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, bs1f)

		Mid(m601(3, 6), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, bs1f)

			Mid(Derefof(m602(3, 6, 1)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, bb35)
		}
	}

	Method(m32s, 1)
	{
		// String to Integer conversion of the String Length operand

		Store(Mid("This is auxiliary String", 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 0, Local0, bs1e)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 1, Local0, bb34)

		Store(Mid(aus6, 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 2, Local0, bs1e)

		Store(Mid(aub6, 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 3, Local0, bb34)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 4, Local0, bs1e)

			Store(Mid(Derefof(Refof(aub6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 5, Local0, bb34)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 6, Local0, bs1e)

		Store(Mid(Derefof(Index(paub, 6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 7, Local0, bb34)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 8, Local0, bs1e)

		Store(Mid(m601(3, 6), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 9, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 10, Local0, bs1e)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 11, Local0, bb34)
		}

		Mid("This is auxiliary String", 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 12, Local0, bs1e)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 13, Local0, bb34)

		Mid(aus6, 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 14, Local0, bs1e)

		Mid(aub6, 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 15, Local0, bb34)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 16, Local0, bs1e)

			Mid(Derefof(Refof(aub6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 17, Local0, bb34)
		}

		Mid(Derefof(Index(paus, 6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 18, Local0, bs1e)

		Mid(Derefof(Index(paub, 6)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 19, Local0, bb34)

		// Method returns Object

		Mid(m601(2, 6), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 20, Local0, bs1e)

		Mid(m601(3, 6), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 21, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 22, Local0, bs1e)

			Mid(Derefof(m602(3, 6, 1)), 0, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 23, Local0, bb34)
		}

		// String to Integer conversion of the both String operands

		Store(Mid("This is auxiliary String", Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 24, Local0, bs1f)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 25, Local0, bb35)

		Store(Mid(aus6, Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 26, Local0, bs1f)

		Store(Mid(aub6, Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 27, Local0, bb35)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 28, Local0, bs1f)

			Store(Mid(Derefof(Refof(aub6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 29, Local0, bb35)
		}

		Store(Mid(Derefof(Index(paus, 6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 30, Local0, bs1f)

		Store(Mid(Derefof(Index(paub, 6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 31, Local0, bb35)

		// Method returns Object

		Store(Mid(m601(2, 6), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 32, Local0, bs1f)

		Store(Mid(m601(3, 6), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
		m600(arg0, 33, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 34, Local0, bs1f)

			Store(Mid(Derefof(m602(3, 6, 1)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}), Local0)
			m600(arg0, 35, Local0, bb35)
		}

		Mid("This is auxiliary String", Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 36, Local0, bs1f)

		Mid(Buffer(){"This is auxiliary Buffer"}, Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 37, Local0, bb35)

		Mid(aus6, Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 38, Local0, bs1f)

		Mid(aub6, Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 39, Local0, bb35)


		if (y078) {
			Mid(Derefof(Refof(aus6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 40, Local0, bs1f)

			Mid(Derefof(Refof(aub6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 41, Local0, bb35)
		}

		Mid(Derefof(Index(paus, 6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 42, Local0, bs1f)

		Mid(Derefof(Index(paub, 6)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 43, Local0, bb35)

		// Method returns Object

		Mid(m601(2, 6), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 44, Local0, bs1f)

		Mid(m601(3, 6), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
		m600(arg0, 45, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 46, Local0, bs1f)

			Mid(Derefof(m602(3, 6, 1)), Buffer(1){0xb}, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}, Local0)
			m600(arg0, 47, Local0, bb35)
		}
	}

	// Buffer to Integer conversion of the Buffer StartIndex
	// operand of the Match operator
	Method(m06a, 1)
	{
		Store(Match(
			Package(){
				0xa50, 0xa51, 0xa52, 0xa53, 0xa54, 0xa55, 0xa56, 0xa57,
				0xa58, 0xa59, 0xa5a, 0xa5b, 0xa5c, 0xa5d, 0xa5e,},
			MEQ, 0xa5d, MTR, 0, Buffer(1){0xb}), Local0)
		m600(arg0, 0, Local0, 0xd)

		Store(Match(
			Package(){
				0xa50, 0xa51, 0xa52, 0xa53, 0xa54, 0xa55, 0xa56, 0xa57,
				0xa58, 0xa59, 0xa5a, 0xa5b, 0xa5c, 0xa5d, 0xa5e,},
			MEQ, 0xa5a, MTR, 0, Buffer(1){0xb}), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(aup0, MEQ, 0xa5d, MTR, 0, Buffer(1){0xb}), Local0)
		m600(arg0, 2, Local0, 0xd)

		Store(Match(aup0, MEQ, 0xa5a, MTR, 0, Buffer(1){0xb}), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Match(Derefof(Refof(aup0)), MEQ, 0xa5d, MTR, 0, Buffer(1){0xb}), Local0)
			m600(arg0, 4, Local0, 0xd)

			Store(Match(Derefof(Refof(aup0)), MEQ, 0xa5a, MTR, 0, Buffer(1){0xb}), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Match(Derefof(Index(paup, 0)), MEQ, 0xa5d, MTR, 0, Buffer(1){0xb}), Local0)
		m600(arg0, 6, Local0, 0xd)

		Store(Match(Derefof(Index(paup, 0)), MEQ, 0xa5a, MTR, 0, Buffer(1){0xb}), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Object

		Store(Match(m601(4, 0), MEQ, 0xa5d, MTR, 0, Buffer(1){0xb}), Local0)
		m600(arg0, 8, Local0, 0xd)

		Store(Match(m601(4, 0), MEQ, 0xa5a, MTR, 0, Buffer(1){0xb}), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference

		if (y500) {
			Store(Match(Derefof(m602(4, 0, 1)), MEQ, 0xa5d, MTR, 0, Buffer(1){0xb}), Local0)
			m600(arg0, 10, Local0, 0xd)

			Store(Match(Derefof(m602(4, 0, 1)), MEQ, 0xa5a, MTR, 0, Buffer(1){0xb}), Local0)
			m600(arg0, 11, Local0, Ones)
		}
	}

	// Buffer to Integer conversion of the Buffer elements
	// of a search package of Match operator when some
	// MatchObject is evaluated as Integer

	Method(m64t, 1)
	{
		Store(Match(Package(){Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}},
			MEQ, 0xfe7cb391d650a284, MTR, 0, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Match(Package(){Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}},
			MEQ, 0xfe7cb391d650a285, MTR, 0, 0), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(Package(){Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}},
			MTR, 0, MEQ, 0xfe7cb391d650a284, 0), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Match(Package(){Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}},
			MTR, 0, MEQ, 0xfe7cb391d650a285, 0), Local0)
		m600(arg0, 3, Local0, Ones)
	}

	Method(m32t, 1)
	{
		Store(Match(Package(){Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}},
			MEQ, 0xd650a284, MTR, 0, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Match(Package(){Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}},
			MEQ, 0xd650a285, MTR, 0, 0), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(Package(){Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}},
			MTR, 0, MEQ, 0xd650a284, 0), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Match(Package(){Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}},
			MTR, 0, MEQ, 0xd650a285, 0), Local0)
		m600(arg0, 3, Local0, Ones)
	}

	// Buffer to Integer conversion of the Buffer sole operand
	// of the Method execution control operators (Sleep, Stall)
	Method(m06b, 1)
	{
		CH03(arg0, z085, 11, 0, 0)

		// Sleep

		Store(Timer, Local0)

		Sleep(Buffer(3){0x21, 0x03, 0x00})
		CH03(arg0, z085, 12, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z085, 0, 0, 0, Local2, c08c)
		}

		// Stall

		Store(Timer, Local0)

		Stall(Buffer(1){0x3f})
		CH03(arg0, z085, 13, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, 990)) {
			err(arg0, z085, 1, 0, 0, Local2, 990)
		}
	}

	// Buffer to Integer conversion of the Buffer TimeoutValue
	// (second) operand of the Acquire operator

	Method(m06c, 1, Serialized)
	{
		Mutex(MTX0, 0)

		Acquire(MTX0, 0)
		CH03(arg0, z085, 14, 0, 0)

		Store(Timer, Local0)

/* Compiler allows only Integer constant as TimeoutValue (Bug 1)
		Acquire(MTX0, Buffer(3){0x21, 0x03, 0x00})
*/
		CH03(arg0, z085, 15, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z085, 0, 0, 0, Local2, c08c)
		}
	}

	// Buffer to Integer conversion of the Buffer TimeoutValue
	// (second) operand of the Wait operator
	Method(m06d, 1, Serialized)
	{
		Event(EVT0)

		CH03(arg0, z085, 16, 0, 0)

		Store(Timer, Local0)

		Wait(EVT0, Buffer(3){0x21, 0x03, 0x00})
		CH03(arg0, z085, 17, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z085, 0, 0, 0, Local2, c08c)
		}
	}

	// Buffer to Integer conversion of the Buffer value
	// of Predicate of the Method execution control statements
	// (If, ElseIf, While)
	Method(m06e, 1, Serialized)
	{
		Name(ist0, 0)

		Method(m001)
		{
			if (Buffer(1){0x00}) {
				Store(0, ist0)
			}
		}

		Method(m002)
		{
			if (Buffer(3){0x21, 0x03, 0x00}) {
				Store(2, ist0)
			}
		}

		Method(m003)
		{
			if (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {
				Store(3, ist0)
			}
		}

		Method(m004)
		{
			if (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {
				Store(4, ist0)
			}
		}

		Method(m005, 1)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (Buffer(1){0x00}) {
				Store(0, ist0)
			}
		}

		Method(m006, 1)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (Buffer(3){0x21, 0x03, 0x00}) {
				Store(6, ist0)
			}
		}

		Method(m007, 1)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {
				Store(7, ist0)
			}
		}

		Method(m008, 1)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {
				Store(8, ist0)
			}
		}

		Method(m009,, Serialized)
		{
			Name(buf0, Buffer(1){0x00})
			while (buf0) {
				Store(0, ist0)
			}
		}

		// If

		Store(1, ist0)
		m001()
		m600(arg0, 0, ist0, 1)

		m002()
		m600(arg0, 1, ist0, 2)

		m003()
		m600(arg0, 2, ist0, 3)

		m004()
		m600(arg0, 3, ist0, 4)

		// ElseIf

		Store(5, ist0)
		m005(0)
		m600(arg0, 4, ist0, 5)

		m006(0)
		m600(arg0, 5, ist0, 6)

		m007(0)
		m600(arg0, 6, ist0, 7)

		m008(0)
		m600(arg0, 7, ist0, 8)

		// While

		Store(9, ist0)
		m009()
		m600(arg0, 8, ist0, 9)
	}

	// Buffer to Integer conversion of the Buffer value
	// of Expression of Case statement when Expression in
	// Switch is evaluated as Integer

	Method(m64u, 1)
	{
		Name(i000, 0)

		Store(0, i000)
		Switch (0xfe7cb391d650a285) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 0, i000, 2)

		Store(0, i000)
		Switch (0xfe7cb391d650a284) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 1, i000, 1)

		Store(0, i000)
		Switch (auid) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 2, i000, 2)

		Store(0, i000)
		Switch (aui4) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 3, i000, 1)

		if (y078) {
			Store(0, i000)
			Switch (Derefof(Refof(auid))) {
				Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 4, i000, 2)

			Store(0, i000)
			Switch (Derefof(Refof(aui4))) {
				Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 5, i000, 1)
		}

		Store(0, i000)
		Switch (Derefof(Index(paui, 13))) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 6, i000, 2)

		Store(0, i000)
		Switch (Derefof(Index(paui, 4))) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 7, i000, 1)

		// Method returns Integer

		Store(0, i000)
		Switch (m601(1, 13)) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 8, i000, 2)

		Store(0, i000)
		Switch (m601(1, 4)) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 9, i000, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(0, i000)
			Switch (Derefof(m602(1, 13, 1))) {
				Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 10, i000, 2)

			Store(0, i000)
			Switch (Derefof(m602(1, 4, 1))) {
				Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 11, i000, 1)
		}
	}

	Method(m32u, 1, Serialized)
	{
		Name(i000, 0)

		Store(0, i000)
		Switch (0xd650a285) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 0, i000, 2)

		Store(0, i000)
		Switch (0xd650a284) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 1, i000, 1)

		Store(0, i000)
		Switch (auil) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 2, i000, 2)

		Store(0, i000)
		Switch (auik) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 3, i000, 1)

		if (y078) {
			Store(0, i000)
			Switch (Derefof(Refof(auil))) {
				Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 4, i000, 2)

			Store(0, i000)
			Switch (Derefof(Refof(auik))) {
				Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 5, i000, 1)
		}

		Store(0, i000)
		Switch (Derefof(Index(paui, 21))) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 6, i000, 2)

		Store(0, i000)
		Switch (Derefof(Index(paui, 20))) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 7, i000, 1)

		// Method returns Integer

		Store(0, i000)
		Switch (m601(1, 21)) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 8, i000, 2)

		Store(0, i000)
		Switch (m601(1, 20)) {
			Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 9, i000, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(0, i000)
			Switch (Derefof(m601(1, 21, 1))) {
				Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 10, i000, 2)

			Store(0, i000)
			Switch (Derefof(m602(1, 20, 1))) {
				Case (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5}) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 11, i000, 1)
		}
	}

	// Buffer to String implicit conversion Cases.

	// Buffer to String conversion of the Buffer second operand of
	// Logical operators when the first operand is evaluated as String.
	// LEqual LGreater LGreaterEqual LLess LLessEqual LNotEqual
	Method(m06f, 1)
	{
		// LEqual

		Store(LEqual("21 03 00", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual("21 03 01", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aus9, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(ausa, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aus9)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(ausa)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paus, 9)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paus, 10)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns String

		Store(LEqual(m601(2, 9), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(2, 10), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LEqual(Derefof(m602(2, 9, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(2, 10, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater("21 03 00", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater("21 03 01", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater("21 03 0 ", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater("21 03 00q", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aus9, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(ausa, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aus9)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(ausa)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paus, 9)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paus, 10)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns String

		Store(LGreater(m601(2, 9), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(2, 10), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LGreater(Derefof(m602(2, 9, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(2, 10, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual("21 03 00", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual("21 03 01", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual("21 03 0 ", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual("21 03 00q", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aus9, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(ausa, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aus9)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(ausa)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paus, 9)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paus, 10)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns String

		Store(LGreaterEqual(m601(2, 9),
		 Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(2, 10), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(2, 9, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(2, 10, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess("21 03 00", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess("21 03 01", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess("21 03 0 ", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess("21 03 00q", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aus9, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(ausa, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aus9)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(ausa)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paus, 9)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paus, 10)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns String

		Store(LLess(m601(2, 9), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(2, 10), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LLess(Derefof(m602(2, 9, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(2, 10, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual("21 03 00", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual("21 03 01", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual("21 03 0 ", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual("21 03 00q", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aus9, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(ausa, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aus9)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(ausa)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paus, 9)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paus, 10)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns String

		Store(LLessEqual(m601(2, 9), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(2, 10), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to String

		if (y500) {
			Store(LLessEqual(Derefof(m602(2, 9, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(2, 10, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual("21 03 00", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual("21 03 01", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual("21 03 0 ", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual("21 03 00q", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aus9, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(ausa, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aus9)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(ausa)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paus, 9)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paus, 10)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns String

		Store(LNotEqual(m601(2, 9), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(2, 10), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to String

		if (y500) {
			Store(LNotEqual(Derefof(m602(2, 9, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(2, 10, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 81, Local0, Ones)
		}

		// Boundary Cases

		Store(LEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}),
			Local0)
		m600(arg0, 82, Local0, Ones)

		Store(LEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}),
			Local0)
		m600(arg0, 83, Local0, Zero)

		Store(LGreater("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}),
			Local0)
		m600(arg0, 84, Local0, Zero)

		Store(LGreater("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}),
			Local0)
		m600(arg0, 85, Local0, Ones)

		Store(LGreaterEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}),
			Local0)
		m600(arg0, 86, Local0, Ones)

		Store(LGreaterEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}),
			Local0)
		m600(arg0, 87, Local0, Ones)

		Store(LLess("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}),
			Local0)
		m600(arg0, 88, Local0, Zero)

		Store(LLess("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}),
			Local0)
		m600(arg0, 89, Local0, Zero)

		Store(LLessEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}),
			Local0)
		m600(arg0, 90, Local0, Ones)

		Store(LLessEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}),
			Local0)
		m600(arg0, 91, Local0, Zero)


		Store(LNotEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}),
			Local0)
		m600(arg0, 92, Local0, Zero)

		Store(LNotEqual("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}),
			Local0)
		m600(arg0, 93, Local0, Ones)
	}

	// Buffer to String conversion of the Buffer second operand of
	// Concatenate operator when the first operand is evaluated as String
	Method(m070, 1)
	{		
		Store(Concatenate("", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 0, Local0, bs25)

		Store(Concatenate("1234q", Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 1, Local0, bs26)

		Store(Concatenate(aus0, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 2, Local0, bs25)

		Store(Concatenate(aus1, Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 3, Local0, bs26)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aus0)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 4, Local0, bs25)

			Store(Concatenate(Derefof(Refof(aus1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 5, Local0, bs26)
		}

		Store(Concatenate(Derefof(Index(paus, 0)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 6, Local0, bs25)

		Store(Concatenate(Derefof(Index(paus, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 7, Local0, bs26)

		// Method returns String

		Store(Concatenate(m601(2, 0), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 8, Local0, bs25)

		Store(Concatenate(m601(2, 1), Buffer(3){0x21, 0x03, 0x00}), Local0)
		m600(arg0, 9, Local0, bs26)

		// Method returns Reference to String

		if (y500) {
			Store(Concatenate(Derefof(m602(2, 0, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 10, Local0, bs25)

			Store(Concatenate(Derefof(m602(2, 1, 1)), Buffer(3){0x21, 0x03, 0x00}), Local0)
			m600(arg0, 11, Local0, bs26)
		}

		Concatenate("", Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 12, Local0, bs25)

		Concatenate("1234q", Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 13, Local0, bs26)

		Concatenate(aus0, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 14, Local0, bs25)

		Concatenate(aus1, Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 15, Local0, bs26)

		if (y078) {
			Concatenate(Derefof(Refof(aus0)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 16, Local0, bs25)

			Concatenate(Derefof(Refof(aus1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 17, Local0, bs26)
		}

		Concatenate(Derefof(Index(paus, 0)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 18, Local0, bs25)

		Concatenate(Derefof(Index(paus, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 19, Local0, bs26)

		// Method returns String

		Concatenate(m601(2, 0), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 20, Local0, bs25)

		Concatenate(m601(2, 1), Buffer(3){0x21, 0x03, 0x00}, Local0)
		m600(arg0, 21, Local0, bs26)

		// Method returns Reference to String

		if (y500) {
			Concatenate(Derefof(m602(2, 0, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 22, Local0, bs25)

			Concatenate(Derefof(m602(2, 1, 1)), Buffer(3){0x21, 0x03, 0x00}, Local0)
			m600(arg0, 23, Local0, bs26)
		}

		// Boundary Cases

		Store(Concatenate("",
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}),
			Local0)
		m600(arg0, 24, Local0, bs27)
	}

	// Buffer to String conversion of the Buffer elements
	// of a search package of Match operator when some MatchObject
	// is evaluated as String
	Method(m071, 1)
	{
	
		Store(Match(Package(){Buffer(3){0x21, 0x03, 0x00}},
			MEQ, "21 03 00", MTR, 0, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Match(Package(){Buffer(3){0x21, 0x03, 0x00}},
			MEQ, "21 03 01", MTR, 0, 0), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(Package(){Buffer(3){0x21, 0x03, 0x00}},
			MTR, 0, MEQ, "21 03 00", 0), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Match(Package(){Buffer(3){0x21, 0x03, 0x00}},
			MTR, 0, MEQ, "21 03 01", 0), Local0)
		m600(arg0, 3, Local0, Ones)

		// Boundary Cases

		Store(Match(Package(){
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}},
			MEQ,
			"21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
			MTR, 0, 0), Local0)
		m600(arg0, 4, Local0, 0)

		Store(Match(Package(){
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}},
			MEQ,
			"21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
			MTR, 0, 0), Local0)
		m600(arg0, 5, Local0, Ones)

		Store(Match(Package(){
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}},
			MTR, 0, MEQ,
			"21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
			0), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Match(Package(){
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}},
			MTR, 0, MEQ,
			"21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
			0), Local0)
		m600(arg0, 7, Local0, Ones)
	}

	// Buffer to String conversion of the Buffer value
	// of Expression of Case statement when Expression in
	// Switch is either static String data or explicitly
	// converted to String by ToDecimalString, ToHexString
	// or ToString
	Method(m072, 1)
	{
		Name(i000, 0)

		Store(0, i000)
		Switch ("21 03 01") {
			Case (Buffer(3){0x21, 0x03, 0x00}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 0, i000, 2)

		Store(0, i000)
		Switch ("21 03 00") {
			Case (Buffer(3){0x21, 0x03, 0x00}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 1, i000, 1)

		Store(0, i000)
		Switch (ToHexString(ausa)) {
			Case (Buffer(3){0x21, 0x03, 0x00}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 2, i000, 2)

		Store(0, i000)
		Switch (ToHexString(aus9)) {
			Case (Buffer(3){0x21, 0x03, 0x00}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 3, i000, 1)

		if (y078) {
			Store(0, i000)
			Switch (ToHexString(Derefof(Refof(ausa)))) {
				Case (Buffer(3){0x21, 0x03, 0x00}) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 4, i000, 2)

			Store(0, i000)
			Switch (ToHexString(Derefof(Refof(aus9)))) {
				Case (Buffer(3){0x21, 0x03, 0x00}) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 5, i000, 1)
		}

		Store(0, i000)
		Switch (ToHexString(Derefof(Index(paus, 10)))) {
			Case (Buffer(3){0x21, 0x03, 0x00}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 6, i000, 2)

		Store(0, i000)
		Switch (ToHexString(Derefof(Index(paus, 9)))) {
			Case (Buffer(3){0x21, 0x03, 0x00}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 7, i000, 1)

		// Method returns String

		Store(0, i000)
		Switch (ToHexString(m601(2, 10))) {
			Case (Buffer(3){0x21, 0x03, 0x00}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 8, i000, 2)

		Store(0, i000)
		Switch (ToHexString(m601(2, 9))) {
			Case (Buffer(3){0x21, 0x03, 0x00}) {Store(1, i000)}
			Default {Store(2, i000)}
		}
		m600(arg0, 9, i000, 1)

		// Method returns Reference to String

		if (y500) {
			Store(0, i000)
			Switch (ToHexString(Derefof(m602(2, 10, 1)))) {
				Case (Buffer(3){0x21, 0x03, 0x00}) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 10, i000, 2)

			Store(0, i000)
			Switch (ToHexString(Derefof(m602(2, 9, 1)))) {
				Case (Buffer(3){0x21, 0x03, 0x00}) {Store(1, i000)}
				Default {Store(2, i000)}
			}
			m600(arg0, 11, i000, 1)
		}

		// Boundary Cases

		Store(0, i000)
		Switch ("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64") {
			Case (
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}
					) {
				Store(1, i000)
			}
			Default {Store(2, i000)}
		}
		m600(arg0, 0, i000, 2)

		Store(0, i000)
		Switch ("21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63") {
			Case (
				Buffer(67){
					0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
					0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
					0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
					0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
					0x61,0x62,0x63,}
					) {
				Store(1, i000)
			}
			Default {Store(2, i000)}
		}
		m600(arg0, 1, i000, 1)
	}

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
		m640(Local0)
	} else {
		Concatenate(ts, "-m320", Local0)
		SRMT(Local0)
		m320(Local0)
	}

	// Integer to String conversion of the Integer second operand of
	// Concatenate operator when the first operand is evaluated as String
	if (F64) {
		Concatenate(ts, "-m641", Local0)
		SRMT(Local0)
		m641(Local0)
	} else {
		Concatenate(ts, "-m321", Local0)
		SRMT(Local0)
		m321(Local0)
	}

	// Integer to String conversion of the Integer elements
	// of a search package of Match operator when some MatchObject
	// is evaluated as String
	if (F64) {
		Concatenate(ts, "-m642", Local0)
		SRMT(Local0)
		m642(Local0)
	} else {
		Concatenate(ts, "-m322", Local0)
		SRMT(Local0)
		m322(Local0)
	}

	// Integer to String conversion of the Integer value
	// of Expression of Case statement when Expression in
	// Switch is either static String data or explicitly
	// converted to String by ToDecimalString, ToHexString
	// or ToString
	if (F64) {
		Concatenate(ts, "-m643", Local0)
		SRMT(Local0)
		m643(Local0)
	} else {
		Concatenate(ts, "-m323", Local0)
		SRMT(Local0)
		m323(Local0)
	}

	// Integer to Buffer implicit conversion Cases.

	// Integer to Buffer conversion of the Integer second operand of
	// Logical operators when the first operand is evaluated as Buffer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)
	if (F64) {
		Concatenate(ts, "-m644", Local0)
		SRMT(Local0)
		m644(Local0)
	} else {
		Concatenate(ts, "-m324", Local0)
		SRMT(Local0)
		m324(Local0)
	}

	// Integer to Buffer conversion of the both Integer operands of
	// Concatenate operator
	if (F64) {
		Concatenate(ts, "-m645", Local0)
		SRMT(Local0)
		m645(Local0)
	} else {
		Concatenate(ts, "-m325", Local0)
		SRMT(Local0)
		m325(Local0)
	}

	// Integer to Buffer conversion of the Integer second operand of
	// Concatenate operator when the first operand is evaluated as Buffer
	if (F64) {
		Concatenate(ts, "-m646", Local0)
		SRMT(Local0)
		m646(Local0)
	} else {
		Concatenate(ts, "-m326", Local0)
		SRMT(Local0)
		m326(Local0)
	}

	// Integer to Buffer conversion of the Integer Source operand of
	// ToString operator
	if (F64) {
		Concatenate(ts, "-m647", Local0)
		SRMT(Local0)
		m647(Local0)
	} else {
		Concatenate(ts, "-m327", Local0)
		SRMT(Local0)
		m327(Local0)
	}

	// Integer to Buffer conversion of the Integer Source operand of
	// Mid operator
	if (F64) {
		Concatenate(ts, "-m648", Local0)
		SRMT(Local0)
		m648(Local0)
	} else {
		Concatenate(ts, "-m328", Local0)
		SRMT(Local0)
		m328(Local0)
	}

	// Integer to Buffer conversion of the Integer elements of
	// a search package of Match operator when some MatchObject
	// is evaluated as Buffer
	if (F64) {
		Concatenate(ts, "-m649", Local0)
		SRMT(Local0)
		m649(Local0)
	} else {
		Concatenate(ts, "-m329", Local0)
		SRMT(Local0)
		m329(Local0)
	}

	// Integer to Buffer conversion of the Integer value of
	// Expression of Case statement when Expression in Switch
	// is either static Buffer data or explicitly converted to
	// Buffer by ToBuffer
	if (F64) {
		Concatenate(ts, "-m64a", Local0)
		SRMT(Local0)
		m64a(Local0)
	} else {
		Concatenate(ts, "-m32a", Local0)
		SRMT(Local0)
		m32a(Local0)
	}


	// String to Integer implicit conversion Cases.

	// String to Integer conversion of the String sole operand
	// of the 1-parameter Integer arithmetic operators
	// (Decrement, Increment, FindSetLeftBit, FindSetRightBit, Not)
	if (F64) {
		Concatenate(ts, "-m64b", Local0)
		SRMT(Local0)
		m64b(Local0)
	} else {
		Concatenate(ts, "-m32b", Local0)
		SRMT(Local0)
		m32b(Local0)
	}

	// String to Integer conversion of the String sole operand
	// of the LNot Logical Integer operator
	Concatenate(ts, "-m000", Local0)
	SRMT(Local0)
	m000(Local0)

	// String to Integer conversion of the String sole operand
	// of the FromBCD and ToBCD conversion operators
	if (F64) {
		Concatenate(ts, "-m64c", Local0)
		SRMT(Local0)
		m64c(Local0)
	} else {
		Concatenate(ts, "-m32c", Local0)
		SRMT(Local0)
		m32c(Local0)
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
	m02b(Local0)

	if (F64) {
		Concatenate(ts, "-m64f", Local0)
		SRMT(Local0)
		m64f(Local0)
	} else {
		Concatenate(ts, "-m32f", Local0)
		SRMT(Local0)
		m32f(Local0)
	}

	// String to Integer intermediate conversion of the String second
	// operand of Concatenate operator in case the first one is Integer
	if (F64) {
		Concatenate(ts, "-m64g", Local0)
		SRMT(Local0)
		m64g(Local0)
	} else {
		Concatenate(ts, "-m32g", Local0)
		SRMT(Local0)
		m32g(Local0)
	}

	// String to Integer conversion of the String Length (second)
	// operand of the ToString operator

	Concatenate(ts, "-m02c", Local0)
	SRMT(Local0)
	m02c(Local0)

	if (F64) {
		Concatenate(ts, "-m64h", Local0)
		SRMT(Local0)
		m64h(Local0)
	} else {
		Concatenate(ts, "-m32h", Local0)
		SRMT(Local0)
		m32h(Local0)
	}

	// String to Integer conversion of the String Index (second)
	// operand of the Index operator
	Concatenate(ts, "-m02d", Local0)
	SRMT(Local0)
	m02d(Local0)

	// String to Integer conversion of the String Arg (third)
	// operand of the Fatal operator
	// (it can only be checked an exception does not occur)
	Concatenate(ts, "-m02e", Local0)
	SRMT(Local0)
	m02e(Local0)

	// String to Integer conversion of the String Index and Length
	// operands of the Mid operator

	Concatenate(ts, "-m02f", Local0)
	SRMT(Local0)
	m02f(Local0)

	if (F64) {
		Concatenate(ts, "-m64i", Local0)
		SRMT(Local0)
		m64i(Local0)
	} else {
		Concatenate(ts, "-m32i", Local0)
		SRMT(Local0)
		m32i(Local0)
	}

	// String to Integer conversion of the String StartIndex
	// operand of the Match operator
	Concatenate(ts, "-m030", Local0)
	SRMT(Local0)
	m030(Local0)

	// String to Integer conversion of the String elements
	// of a search package of Match operator when some
	// MatchObject is evaluated as Integer
	if (F64) {
		Concatenate(ts, "-m64j", Local0)
		SRMT(Local0)
		m64j(Local0)
	} else {
		Concatenate(ts, "-m32j", Local0)
		SRMT(Local0)
		m32j(Local0)
	}

	// String to Integer conversion of the String sole operand
	// of the Method execution control operators (Sleep, Stall)
	Concatenate(ts, "-m031", Local0)
	SRMT(Local0)
	m031(Local0)

	// String to Integer conversion of the String TimeoutValue
	// (second) operand of the Acquire operator
/* Compiler allows only Integer constant as TimeoutValue (Bug 1)
	Concatenate(ts, "-m032", Local0)
	SRMT(Local0)
	m032(Local0)
*/

	// String to Integer conversion of the String TimeoutValue
	// (second) operand of the Wait operator
	Concatenate(ts, "-m033", Local0)
	SRMT(Local0)
	m033(Local0)

	// String to Integer conversion of the String value
	// of Predicate of the Method execution control statements
	// (If, ElseIf, While)
	Concatenate(ts, "-m034", Local0)
	SRMT(Local0)
	if (y111) {
		m034(Local0)
	} else {
		BLCK()
	}

	// String to Integer conversion of the String value
	// of Expression of Case statement when Expression in
	// Switch is evaluated as Integer
	if (F64) {
		Concatenate(ts, "-m64k", Local0)
		SRMT(Local0)
		m64k(Local0)
	} else {
		Concatenate(ts, "-m32k", Local0)
		SRMT(Local0)
		m32k(Local0)
	}


	// String to Buffer implicit conversion Cases.

	// String to Buffer conversion of the String second operand of
	// Logical operators when the first operand is evaluated as Buffer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)
	Concatenate(ts, "-m035", Local0)
	SRMT(Local0)
	m035(Local0)

	// String to Buffer conversion of the String second operand of
	// Concatenate operator when the first operand is evaluated as Buffer
	Concatenate(ts, "-m036", Local0)
	SRMT(Local0)
	m036(Local0)

	// String to Buffer conversion of the String Source operand of
	// ToString operator (has a visual effect in shortening of the
	// String taken the null character)
	Concatenate(ts, "-m037", Local0)
	SRMT(Local0)
	m037(Local0)

	// String to Buffer conversion of the String elements of
	// a search package of Match operator when some MatchObject
	// is evaluated as Buffer
	Concatenate(ts, "-m038", Local0)
	SRMT(Local0)
	m038(Local0)

	// String to Buffer conversion of the String value of
	// Expression of Case statement when Expression in Switch
	// is either static Buffer data or explicitly converted to
	// Buffer by ToBuffer
	Concatenate(ts, "-m039", Local0)
	SRMT(Local0)
	m039(Local0)


	// Buffer to Integer implicit conversion Cases.

	// Buffer to Integer conversion of the Buffer sole operand
	// of the 1-parameter Integer arithmetic operators
	// (Decrement, Increment, FindSetLeftBit, FindSetRightBit, Not)
	if (F64) {
		Concatenate(ts, "-m64l", Local0)
		SRMT(Local0)
		m64l(Local0)
	} else {
		Concatenate(ts, "-m32l", Local0)
		SRMT(Local0)
		m32l(Local0)
	}

	// Buffer to Integer conversion of the Buffer sole operand
	// of the LNot Logical Integer operator
	Concatenate(ts, "-m03a", Local0)
	SRMT(Local0)
	m03a(Local0)

	// Buffer to Integer conversion of the Buffer sole operand
	// of the FromBCD and ToBCD conversion operators
	if (F64) {
		Concatenate(ts, "-m64m", Local0)
		SRMT(Local0)
		m64m(Local0)
	} else {
		Concatenate(ts, "-m32m", Local0)
		SRMT(Local0)
		m32m(Local0)
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
	m065(Local0)

	if (F64) {
		Concatenate(ts, "-m64p", Local0)
		SRMT(Local0)
		m64p(Local0)
	} else {
		Concatenate(ts, "-m32p", Local0)
		SRMT(Local0)
		m32p(Local0)
	}

	// Buffer to Integer intermediate conversion of the Buffer second
	// operand of Concatenate operator in case the first one is Integer
	if (F64) {
		Concatenate(ts, "-m64q", Local0)
		SRMT(Local0)
		m64q(Local0)
	} else {
		Concatenate(ts, "-m32q", Local0)
		SRMT(Local0)
		m32q(Local0)
	}

	// Buffer to Integer conversion of the Buffer Length (second)
	// operand of the ToString operator

	Concatenate(ts, "-m066", Local0)
	SRMT(Local0)
	m066(Local0)

	if (F64) {
		Concatenate(ts, "-m64r", Local0)
		SRMT(Local0)
		m64r(Local0)
	} else {
		Concatenate(ts, "-m32r", Local0)
		SRMT(Local0)
		m32r(Local0)
	}

	// Buffer to Integer conversion of the Buffer Index (second)
	// operand of the Index operator
	Concatenate(ts, "-m067", Local0)
	SRMT(Local0)
	m067(Local0)

	// Buffer to Integer conversion of the String Arg (third)
	// operand of the Fatal operator
	// (it can only be checked an exception does not occur)
	Concatenate(ts, "-m068", Local0)
	SRMT(Local0)
	m068(Local0)

	// Buffer to Integer conversion of the Buffer Index and Length
	// operands of the Mid operator

	Concatenate(ts, "-m069", Local0)
	SRMT(Local0)
	m069(Local0)

	if (F64) {
		Concatenate(ts, "-m64s", Local0)
		SRMT(Local0)
		m64s(Local0)
	} else {
		Concatenate(ts, "-m32s", Local0)
		SRMT(Local0)
		m32s(Local0)
	}

	// Buffer to Integer conversion of the Buffer StartIndex
	// operand of the Match operator
	Concatenate(ts, "-m06a", Local0)
	SRMT(Local0)
	m06a(Local0)

	// Buffer to Integer conversion of the Buffer elements
	// of a search package of Match operator when some
	// MatchObject is evaluated as Integer
	if (F64) {
		Concatenate(ts, "-m64t", Local0)
		SRMT(Local0)
		m64t(Local0)
	} else {
		Concatenate(ts, "-m32t", Local0)
		SRMT(Local0)
		m32t(Local0)
	}

	// Buffer to Integer conversion of the Buffer sole operand
	// of the Method execution control operators (Sleep, Stall)
	Concatenate(ts, "-m06b", Local0)
	SRMT(Local0)
	m06b(Local0)

	// Buffer to Integer conversion of the Buffer TimeoutValue
	// (second) operand of the Acquire operator
/* Compiler allows only Integer constant as TimeoutValue (Bug 1)
	Concatenate(ts, "-m06c", Local0)
	SRMT(Local0)
	m06c(Local0)
*/

	// Buffer to Integer conversion of the Buffer TimeoutValue
	// (second) operand of the Wait operator
	Concatenate(ts, "-m06d", Local0)
	SRMT(Local0)
	m06d(Local0)

	// Buffer to Integer conversion of the Buffer value
	// of Predicate of the Method execution control statements
	// (If, ElseIf, While)
	Concatenate(ts, "-m06e", Local0)
	SRMT(Local0)
	if (y111) {
		m06e(Local0)
	} else {
		BLCK()
	}

	// Buffer to Integer conversion of the Buffer value
	// of Expression of Case statement when Expression in
	// Switch is evaluated as Integer
	if (F64) {
		Concatenate(ts, "-m64u", Local0)
		SRMT(Local0)
		m64u(Local0)
	} else {
		Concatenate(ts, "-m32u", Local0)
		SRMT(Local0)
		m32u(Local0)
	}

	// Buffer to String implicit conversion Cases.

	// Buffer to String conversion of the Buffer second operand of
	// Logical operators when the first operand is evaluated as String.
	// LEqual LGreater LGreaterEqual LLess LLessEqual LNotEqual
	Concatenate(ts, "-m06f", Local0)
	SRMT(Local0)
	m06f(Local0)

	// Buffer to String conversion of the Buffer second operand of
	// Concatenate operator when the first operand is evaluated as String
	Concatenate(ts, "-m070", Local0)
	SRMT(Local0)
	m070(Local0)

	// Buffer to String conversion of the Buffer elements
	// of a search package of Match operator when some MatchObject
	// is evaluated as String
	Concatenate(ts, "-m071", Local0)
	SRMT(Local0)
	m071(Local0)

	// Buffer to String conversion of the Buffer value
	// of Expression of Case statement when Expression in
	// Switch is either static String data or explicitly
	// converted to String by ToDecimalString, ToHexString
	// or ToString
	Concatenate(ts, "-m072", Local0)
	SRMT(Local0)
	m072(Local0)

	// There are no Buffer field and Field unit constant
	// images therefore there are no test objects to test
	// Data of these types in this test.
}

/*
 * Cases when there are more than one operand for implicit conversion
 * - when the  first operand of Concatenate operator is Integer,
 *   there are additional conversions besides this Integer to Buffer:
 *    = String to Integer conversion if second operand is String
 *    = Buffer to Integer conversion if second operand is Buffer
 *    = Integer to Buffer conversion of the converted second operand
 */
Method(m620,, Serialized)
{
	Name(ts, "m620")

	// Buffer to Integer conversion if second operand is Buffer
	Method(m645, 1)
	{		
		Store(Concatenate(0xfe7cb391d650a284, Buffer(){0x5a}), Local0)
		m600(arg0, 0, Local0, bb16)

		Store(Concatenate(0xfe7cb391d650a284, Buffer(){0x5a, 0x00}), Local0)
		m600(arg0, 1, Local0, bb17)

		Store(Concatenate(0xfe7cb391d650a284, aub0), Local0)
		m600(arg0, 2, Local0, bb16)

		Store(Concatenate(0xfe7cb391d650a284, aub1), Local0)
		m600(arg0, 3, Local0, bb17)

		if (y078) {
			Store(Concatenate(0xfe7cb391d650a284, Derefof(Refof(aub0))), Local0)
			m600(arg0, 4, Local0, bb16)

			Store(Concatenate(0xfe7cb391d650a284, Derefof(Refof(aub1))), Local0)
			m600(arg0, 5, Local0, bb17)
		}

		Store(Concatenate(0xfe7cb391d650a284, Derefof(Index(paub, 0))), Local0)
		m600(arg0, 6, Local0, bb16)

		Store(Concatenate(0xfe7cb391d650a284, Derefof(Index(paub, 1))), Local0)
		m600(arg0, 7, Local0, bb17)

		// Method returns Buffer

		Store(Concatenate(0xfe7cb391d650a284, m601(3, 0)), Local0)
		m600(arg0, 8, Local0, bb16)

		Store(Concatenate(0xfe7cb391d650a284, m601(3, 1)), Local0)
		m600(arg0, 9, Local0, bb17)

		// Method returns Reference to Buffer

		if (y500) {
			Store(Concatenate(0xfe7cb391d650a284, Derefof(m602(3, 0, 1))), Local0)
			m600(arg0, 10, Local0, bb16)

			Store(Concatenate(0xfe7cb391d650a284, Derefof(m602(3, 1, 1))), Local0)
			m600(arg0, 11, Local0, bb17)
		}

		Concatenate(0xfe7cb391d650a284, Buffer(){0x5a}, Local0)
		m600(arg0, 12, Local0, bb16)

		Concatenate(0xfe7cb391d650a284, Buffer(){0x5a, 0x00}, Local0)
		m600(arg0, 13, Local0, bb17)

		Concatenate(0xfe7cb391d650a284, aub0, Local0)
		m600(arg0, 14, Local0, bb16)

		Concatenate(0xfe7cb391d650a284, aub1, Local0)
		m600(arg0, 15, Local0, bb17)

		if (y078) {
			Concatenate(0xfe7cb391d650a284, Derefof(Refof(aub0)), Local0)
			m600(arg0, 16, Local0, bb16)

			Concatenate(0xfe7cb391d650a284, Derefof(Refof(aub1)), Local0)
			m600(arg0, 17, Local0, bb17)
		}

		Concatenate(0xfe7cb391d650a284, Derefof(Index(paub, 0)), Local0)
		m600(arg0, 18, Local0, bb16)

		Concatenate(0xfe7cb391d650a284, Derefof(Index(paub, 1)), Local0)
		m600(arg0, 19, Local0, bb17)

		// Method returns Buffer

		Concatenate(0xfe7cb391d650a284, m601(3, 0), Local0)
		m600(arg0, 20, Local0, bb16)

		Concatenate(0xfe7cb391d650a284, m601(3, 1), Local0)
		m600(arg0, 21, Local0, bb17)

		// Method returns Reference to Buffer

		if (y500) {
			Concatenate(0xfe7cb391d650a284, Derefof(m602(3, 0, 1)), Local0)
			m600(arg0, 22, Local0, bb16)

			Concatenate(0xfe7cb391d650a284, Derefof(m602(3, 1, 1)), Local0)
			m600(arg0, 23, Local0, bb17)
		}
	}
	
	Method(m325, 1)
	{
		Store(Concatenate(0xc179b3fe, Buffer(){0x5a}), Local0)
		m600(arg0, 0, Local0, bb18)

		Store(Concatenate(0xc179b3fe, Buffer(){0x5a, 0x00}), Local0)
		m600(arg0, 1, Local0, bb19)

		Store(Concatenate(0xc179b3fe, aub0), Local0)
		m600(arg0, 2, Local0, bb18)

		Store(Concatenate(0xc179b3fe,aub1 ), Local0)
		m600(arg0, 3, Local0, bb19)

		if (y078) {
			Store(Concatenate(0xc179b3fe, Derefof(Refof(aub0))), Local0)
			m600(arg0, 4, Local0, bb18)

			Store(Concatenate(0xc179b3fe, Derefof(Refof(aub1))), Local0)
			m600(arg0, 5, Local0, bb19)
		}

		Store(Concatenate(0xc179b3fe, Derefof(Index(paub, 0))), Local0)
		m600(arg0, 6, Local0, bb18)

		Store(Concatenate(0xc179b3fe, Derefof(Index(paub, 1))), Local0)
		m600(arg0, 7, Local0, bb19)

		// Method returns Buffer

		Store(Concatenate(0xc179b3fe, m601(3, 0)), Local0)
		m600(arg0, 8, Local0, bb18)

		Store(Concatenate(0xc179b3fe, m601(3, 1)), Local0)
		m600(arg0, 9, Local0, bb19)

		// Method returns Reference to Buffer

		if (y500) {
			Store(Concatenate(0xc179b3fe, Derefof(m602(3, 0, 1))), Local0)
			m600(arg0, 10, Local0, bb18)

			Store(Concatenate(0xc179b3fe, Derefof(m602(3, 1, 1))), Local0)
			m600(arg0, 11, Local0, bb19)
		}

		Store(Concatenate(0xfe7cb391d650a284, Buffer(){0x5a}), Local0)
		m600(arg0, 12, Local0, bb1a)

		Store(Concatenate(0xfe7cb391d650a284, Buffer(){0x5a, 0x00}), Local0)
		m600(arg0, 13, Local0, bb1b)

		Concatenate(0xc179b3fe, Buffer(){0x5a}, Local0)
		m600(arg0, 14, Local0, bb18)

		Concatenate(0xc179b3fe, Buffer(){0x5a, 0x00}, Local0)
		m600(arg0, 15, Local0, bb19)

		Concatenate(0xc179b3fe, aub0, Local0)
		m600(arg0, 16, Local0, bb18)

		Concatenate(0xc179b3fe, aub1, Local0)
		m600(arg0, 17, Local0, bb19)

		if (y078) {
			Concatenate(0xc179b3fe, Derefof(Refof(aub0)), Local0)
			m600(arg0, 18, Local0, bb18)

			Concatenate(0xc179b3fe, Derefof(Refof(aub1)), Local0)
			m600(arg0, 19, Local0, bb19)
		}

		Concatenate(0xc179b3fe, Derefof(Index(paub, 0)), Local0)
		m600(arg0, 20, Local0, bb18)

		Concatenate(0xc179b3fe, Derefof(Index(paub, 1)), Local0)
		m600(arg0, 21, Local0, bb19)

		// Method returns Buffer

		Concatenate(0xc179b3fe, m601(3, 0), Local0)
		m600(arg0, 22, Local0, bb18)

		Concatenate(0xc179b3fe, m601(3, 1), Local0)
		m600(arg0, 23, Local0, bb19)

		// Method returns Reference to Buffer

		if (y500) {
			Concatenate(0xc179b3fe, Derefof(m602(3, 0, 1)), Local0)
			m600(arg0, 24, Local0, bb18)

			Concatenate(0xc179b3fe, Derefof(m602(3, 1, 1)), Local0)
			m600(arg0, 25, Local0, bb19)
		}

		Concatenate(0xfe7cb391d650a284, Buffer(){0x5a}, Local0)
		m600(arg0, 26, Local0, bb1a)

		Concatenate(0xfe7cb391d650a284, Buffer(){0x5a, 0x00}, Local0)
		m600(arg0, 27, Local0, bb1b)
	}

	if (F64) {
		Concatenate(ts, "-m645", Local0)
		SRMT(Local0)
		m645(Local0)
	} else {
		Concatenate(ts, "-m325", Local0)
		SRMT(Local0)
		m325(Local0)
	}
}

// Run-method
Method(OPR0)
{
	Store("TEST: OPR0, Source Operand", Debug)

	m610()

	m620()
}

