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
 * Check implicit conversion being applied to Buffer Field Objects
 * in the current Scope of the Global ACPI namespace.
 */

Name(z089, 89)

Method(m614,, Serialized)
{
	Name(ts, "m614")
	Name(b640, Buffer(452){})
	Name(b641, Buffer(69){})

	// Buffer Field to Buffer implicit conversion Cases.

	// Buffer Field to Buffer conversion of the Buffer Field second operand
	// of Logical operators when the first operand is evaluated as Buffer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)

	Method(m644, 1)
	{		
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// LEqual

		Store(LEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, bf65), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aub4, bf65), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(aub3, bf65), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aub4)), bf65), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(aub3)), bf65), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paub, 4)), bf65), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paub, 3)), bf65), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns Buffer

		Store(LEqual(m601(3, 4), bf65), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(3, 3), bf65), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LEqual(Derefof(m602(3, 4, 1)), bf65), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(3, 3, 1)), bf65), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, bf65), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, bf65), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, bf65), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aub4, bf65), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(aub5, bf65), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aub4)), bf65), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(aub5)), bf65), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paub, 4)), bf65), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paub, 5)), bf65), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Buffer

		Store(LGreater(m601(3, 4), bf65), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(3, 5), bf65), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreater(Derefof(m602(3, 4, 1)), bf65), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(3, 5, 1)), bf65), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, bf65), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, bf65), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, bf65), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aub4, bf65), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(aub5, bf65), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aub4)), bf65), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(aub5)), bf65), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paub, 4)), bf65), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paub, 5)), bf65), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns Buffer

		Store(LGreaterEqual(m601(3, 4), bf65), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(3, 5), bf65), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(3, 4, 1)), bf65), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(3, 5, 1)), bf65), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, bf65), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, bf65), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, bf65), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aub4, bf65), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(aub5, bf65), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aub4)), bf65), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(aub5)), bf65), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paub, 4)), bf65), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paub, 5)), bf65), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns Buffer

		Store(LLess(m601(3, 4), bf65), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(3, 5), bf65), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLess(Derefof(m602(3, 4, 1)), bf65), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(3, 5, 1)), bf65), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, bf65), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, bf65), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, bf65), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aub4, bf65), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(aub5, bf65), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aub4)), bf65), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(aub5)), bf65), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paub, 4)), bf65), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paub, 5)), bf65), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns Buffer

		Store(LLessEqual(m601(3, 4), bf65), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(3, 5), bf65), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLessEqual(Derefof(m602(3, 4, 1)), bf65), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(3, 5, 1)), bf65), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF}, bf65), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFD}, bf65), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x01}, bf65), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aub4, bf65), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(aub5, bf65), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aub4)), bf65), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(aub5)), bf65), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paub, 4)), bf65), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paub, 5)), bf65), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns Buffer

		Store(LNotEqual(m601(3, 4), bf65), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(3, 5), bf65), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LNotEqual(Derefof(m602(3, 4, 1)), bf65), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(3, 5, 1)), bf65), Local0)
			m600(arg0, 81, Local0, Ones)
		}
	}
	
	Method(m324, 1)
	{
		CreateField(b640,  31, 32, bf62)

		Store(Buffer(4){0xFE, 0xB3, 0x79, 0xC1}, bf62)

		// LEqual

		Store(LEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, bf62), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, bf62), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(aub3, bf62), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(LEqual(aub2, bf62), Local0)
		m600(arg0, 3, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aub3)), bf62), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(LEqual(Derefof(Refof(aub2)), bf62), Local0)
			m600(arg0, 5, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paub, 3)), bf62), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(LEqual(Derefof(Index(paub, 2)), bf62), Local0)
		m600(arg0, 7, Local0, Zero)

		// Method returns Buffer

		Store(LEqual(m601(3, 3), bf62), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(LEqual(m601(3, 2), bf62), Local0)
		m600(arg0, 9, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LEqual(Derefof(m602(3, 3, 1)), bf62), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(LEqual(Derefof(m602(3, 2, 1)), bf62), Local0)
			m600(arg0, 11, Local0, Zero)
		}

		// LGreater

		Store(LGreater(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, bf62), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LGreater(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, bf62), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LGreater(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, bf62), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LGreater(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, bf62), Local0)
		m600(arg0, 15, Local0, Ones)

		Store(LGreater(aub3, bf62), Local0)
		m600(arg0, 16, Local0, Zero)

		Store(LGreater(aub2, bf62), Local0)
		m600(arg0, 17, Local0, Ones)

		if (y078) {
			Store(LGreater(Derefof(Refof(aub3)), bf62), Local0)
			m600(arg0, 18, Local0, Zero)

			Store(LGreater(Derefof(Refof(aub2)), bf62), Local0)
			m600(arg0, 19, Local0, Ones)
		}

		Store(LGreater(Derefof(Index(paub, 3)), bf62), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(Derefof(Index(paub, 2)), bf62), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Buffer

		Store(LGreater(m601(3, 3), bf62), Local0)
		m600(arg0, 22, Local0, Zero)

		Store(LGreater(m601(3, 2), bf62), Local0)
		m600(arg0, 23, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreater(Derefof(m602(3, 3, 1)), bf62), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(m602(3, 2, 1)), bf62), Local0)
			m600(arg0, 25, Local0, Ones)
		}

		// LGreaterEqual

		Store(LGreaterEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, bf62), Local0)
		m600(arg0, 26, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, bf62), Local0)
		m600(arg0, 27, Local0, Ones)

		Store(LGreaterEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, bf62), Local0)
		m600(arg0, 28, Local0, Zero)

		Store(LGreaterEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, bf62), Local0)
		m600(arg0, 29, Local0, Ones)

		Store(LGreaterEqual(aub3, bf62), Local0)
		m600(arg0, 30, Local0, Ones)

		Store(LGreaterEqual(aub2, bf62), Local0)
		m600(arg0, 31, Local0, Ones)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aub3)), bf62), Local0)
			m600(arg0, 32, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(aub2)), bf62), Local0)
			m600(arg0, 33, Local0, Ones)
		}

		Store(LGreaterEqual(Derefof(Index(paub, 3)), bf62), Local0)
		m600(arg0, 34, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paub, 2)), bf62), Local0)
		m600(arg0, 35, Local0, Ones)

		// Method returns Buffer

		Store(LGreaterEqual(m601(3, 3), bf62), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(m601(3, 2), bf62), Local0)
		m600(arg0, 37, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(3, 3, 1)), bf62), Local0)
			m600(arg0, 38, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(3, 2, 1)), bf62), Local0)
			m600(arg0, 39, Local0, Ones)
		}

		// LLess

		Store(LLess(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, bf62), Local0)
		m600(arg0, 40, Local0, Zero)

		Store(LLess(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, bf62), Local0)
		m600(arg0, 41, Local0, Zero)

		Store(LLess(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, bf62), Local0)
		m600(arg0, 42, Local0, Ones)

		Store(LLess(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, bf62), Local0)
		m600(arg0, 43, Local0, Zero)

		Store(LLess(aub3, bf62), Local0)
		m600(arg0, 44, Local0, Zero)

		Store(LLess(aub2, bf62), Local0)
		m600(arg0, 45, Local0, Zero)

		if (y078) {
			Store(LLess(Derefof(Refof(aub3)), bf62), Local0)
			m600(arg0, 46, Local0, Zero)

			Store(LLess(Derefof(Refof(aub2)), bf62), Local0)
			m600(arg0, 47, Local0, Zero)
		}

		Store(LLess(Derefof(Index(paub, 3)), bf62), Local0)
		m600(arg0, 48, Local0, Zero)

		Store(LLess(Derefof(Index(paub, 2)), bf62), Local0)
		m600(arg0, 49, Local0, Zero)

		// Method returns Buffer

		Store(LLess(m601(3, 3), bf62), Local0)
		m600(arg0, 50, Local0, Zero)

		Store(LLess(m601(3, 2), bf62), Local0)
		m600(arg0, 51, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLess(Derefof(m602(3, 3, 1)), bf62), Local0)
			m600(arg0, 52, Local0, Zero)

			Store(LLess(Derefof(m602(3, 2, 1)), bf62), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLessEqual

		Store(LLessEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, bf62), Local0)
		m600(arg0, 54, Local0, Ones)

		Store(LLessEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, bf62), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLessEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, bf62), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLessEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, bf62), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLessEqual(aub3, bf62), Local0)
		m600(arg0, 58, Local0, Ones)

		Store(LLessEqual(aub2, bf62), Local0)
		m600(arg0, 59, Local0, Zero)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aub3)), bf62), Local0)
			m600(arg0, 60, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(aub2)), bf62), Local0)
			m600(arg0, 61, Local0, Zero)
		}

		Store(LLessEqual(Derefof(Index(paub, 3)), bf62), Local0)
		m600(arg0, 62, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paub, 2)), bf62), Local0)
		m600(arg0, 63, Local0, Zero)

		// Method returns Buffer

		Store(LLessEqual(m601(3, 3), bf62), Local0)
		m600(arg0, 64, Local0, Ones)

		Store(LLessEqual(m601(3, 2), bf62), Local0)
		m600(arg0, 65, Local0, Zero)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LLessEqual(Derefof(m602(3, 3, 1)), bf62), Local0)
			m600(arg0, 66, Local0, Ones)

			Store(LLessEqual(Derefof(m602(3, 2, 1)), bf62), Local0)
			m600(arg0, 67, Local0, Zero)
		}

		// LNotEqual

		Store(LNotEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, bf62), Local0)
		m600(arg0, 68, Local0, Zero)

		Store(LNotEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC2}, bf62), Local0)
		m600(arg0, 69, Local0, Ones)

		Store(LNotEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC0}, bf62), Local0)
		m600(arg0, 70, Local0, Ones)

		Store(LNotEqual(Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01}, bf62), Local0)
		m600(arg0, 71, Local0, Ones)

		Store(LNotEqual(aub3, bf62), Local0)
		m600(arg0, 72, Local0, Zero)

		Store(LNotEqual(aub2, bf62), Local0)
		m600(arg0, 73, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aub3)), bf62), Local0)
			m600(arg0, 74, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(aub2)), bf62), Local0)
			m600(arg0, 75, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paub, 3)), bf62), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paub, 2)), bf62), Local0)
		m600(arg0, 77, Local0, Ones)

		// Method returns Buffer

		Store(LNotEqual(m601(3, 3), bf62), Local0)
		m600(arg0, 78, Local0, Zero)

		Store(LNotEqual(m601(3, 2), bf62), Local0)
		m600(arg0, 79, Local0, Ones)

		// Method returns Reference to Buffer

		if (y500) {
			Store(LNotEqual(Derefof(m602(3, 3, 1)), bf62), Local0)
			m600(arg0, 80, Local0, Zero)

			Store(LNotEqual(Derefof(m602(3, 2, 1)), bf62), Local0)
			m600(arg0, 81, Local0, Ones)
		}
	}


	// Buffer Field to Buffer conversion of the both Integer operands
	// of Concatenate operator

	Method(m645, 1)
	{		
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		Store(Concatenate(bf65, bf65), Local0)
		m600(arg0, 0, Local0, bb20)

		Store(Concatenate(0x321, bf65), Local0)
		m600(arg0, 1, Local0, bb21)

		Store(Concatenate(bf65, 0x321), Local0)
		m600(arg0, 1, Local0, bb22)

		Concatenate(bf65, bf65, Local0)
		m600(arg0, 0, Local0, bb20)

		Concatenate(0x321, bf65, Local0)
		m600(arg0, 1, Local0, bb21)

		Concatenate(bf65, 0x321, Local0)
		m600(arg0, 1, Local0, bb22)
	}

	Method(m325, 1)
	{		
		CreateField(b640,  31, 32, bf62)

		Store(Buffer(4){0xFE, 0xB3, 0x79, 0xC1}, bf62)

		Store(Concatenate(bf62, bf62), Local0)
		m600(arg0, 0, Local0, bb23)

		Store(Concatenate(0x321, bf62), Local0)
		m600(arg0, 1, Local0, bb24)

		Store(Concatenate(bf62, 0x321), Local0)
		m600(arg0, 1, Local0, bb25)

		Concatenate(bf62, bf62, Local0)
		m600(arg0, 0, Local0, bb23)

		Concatenate(0x321, bf62, Local0)
		m600(arg0, 1, Local0, bb24)

		Concatenate(bf62, 0x321, Local0)
		m600(arg0, 1, Local0, bb25)
	}

	// Buffer Field to Buffer conversion of the Buffer Field second operand
	// of Concatenate operator when the first operand is evaluated as Buffer

	Method(m646, 1)
	{		
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		Store(Concatenate(Buffer(){0x5a}, bf65), Local0)
		m600(arg0, 0, Local0, bb10)

		Store(Concatenate(Buffer(){0x5a, 0x00}, bf65), Local0)
		m600(arg0, 1, Local0, bb11)

		Store(Concatenate(aub0, bf65), Local0)
		m600(arg0, 2, Local0, bb10)

		Store(Concatenate(aub1, bf65), Local0)
		m600(arg0, 3, Local0, bb11)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aub0)), bf65), Local0)
			m600(arg0, 4, Local0, bb10)

			Store(Concatenate(Derefof(Refof(aub1)), bf65), Local0)
			m600(arg0, 5, Local0, bb11)
		}

		Store(Concatenate(Derefof(Index(paub, 0)), bf65), Local0)
		m600(arg0, 6, Local0, bb10)

		Store(Concatenate(Derefof(Index(paub, 1)), bf65), Local0)
		m600(arg0, 7, Local0, bb11)

		// Method returns Buffer

		Store(Concatenate(m601(3, 0), bf65), Local0)
		m600(arg0, 8, Local0, bb10)

		Store(Concatenate(m601(3, 1), bf65), Local0)
		m600(arg0, 9, Local0, bb11)

		// Method returns Reference to Buffer

		if (y500) {
			Store(Concatenate(Derefof(m602(3, 0, 1)), bf65), Local0)
			m600(arg0, 10, Local0, bb10)

			Store(Concatenate(Derefof(m602(3, 1, 1)), bf65), Local0)
			m600(arg0, 11, Local0, bb11)
		}

		Concatenate(Buffer(){0x5a}, bf65, Local0)
		m600(arg0, 12, Local0, bb10)

		Concatenate(Buffer(){0x5a, 0x00}, bf65, Local0)
		m600(arg0, 13, Local0, bb11)

		Concatenate(aub0, bf65, Local0)
		m600(arg0, 14, Local0, bb10)

		Concatenate(aub1, bf65, Local0)
		m600(arg0, 15, Local0, bb11)

		if (y078) {
			Concatenate(Derefof(Refof(aub0)), bf65, Local0)
			m600(arg0, 16, Local0, bb10)

			Concatenate(Derefof(Refof(aub1)), bf65, Local0)
			m600(arg0, 17, Local0, bb11)
		}

		Concatenate(Derefof(Index(paub, 0)), bf65, Local0)
		m600(arg0, 18, Local0, bb10)

		Concatenate(Derefof(Index(paub, 1)), bf65, Local0)
		m600(arg0, 19, Local0, bb11)

		// Method returns Buffer

		Concatenate(m601(3, 0), bf65, Local0)
		m600(arg0, 20, Local0, bb10)

		Concatenate(m601(3, 1), bf65, Local0)
		m600(arg0, 21, Local0, bb11)

		// Method returns Reference to Buffer

		if (y500) {
			Concatenate(Derefof(m602(3, 0, 1)), bf65, Local0)
			m600(arg0, 22, Local0, bb10)

			Concatenate(Derefof(m602(3, 1, 1)), bf65, Local0)
			m600(arg0, 23, Local0, bb11)
		}
	}

	Method(m326, 1)
	{
		CreateField(b640,  31, 32, bf62)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(4){0xFE, 0xB3, 0x79, 0xC1}, bf62)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		Store(Concatenate(Buffer(){0x5a}, bf62), Local0)
		m600(arg0, 0, Local0, bb12)

		Store(Concatenate(Buffer(){0x5a, 0x00}, bf62), Local0)
		m600(arg0, 1, Local0, bb13)

		Store(Concatenate(aub0, bf62), Local0)
		m600(arg0, 2, Local0, bb12)

		Store(Concatenate(aub1, bf62), Local0)
		m600(arg0, 3, Local0, bb13)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aub0)), bf62), Local0)
			m600(arg0, 4, Local0, bb12)

			Store(Concatenate(Derefof(Refof(aub1)), bf62), Local0)
			m600(arg0, 5, Local0, bb13)
		}

		Store(Concatenate(Derefof(Index(paub, 0)), bf62), Local0)
		m600(arg0, 6, Local0, bb12)

		Store(Concatenate(Derefof(Index(paub, 1)), bf62), Local0)
		m600(arg0, 7, Local0, bb13)

		// Method returns Buffer

		Store(Concatenate(m601(3, 0), bf62), Local0)
		m600(arg0, 8, Local0, bb12)

		Store(Concatenate(m601(3, 1), bf62), Local0)
		m600(arg0, 9, Local0, bb13)

		// Method returns Reference to Buffer

		if (y500) {
			Store(Concatenate(Derefof(m602(3, 0, 1)), bf62), Local0)
			m600(arg0, 10, Local0, bb12)

			Store(Concatenate(Derefof(m602(3, 1, 1)), bf62), Local0)
			m600(arg0, 11, Local0, bb13)
		}


		Store(Concatenate(Buffer(){0x5a}, bf65), Local0)
		m600(arg0, 12, Local0, bb10)

		Store(Concatenate(Buffer(){0x5a, 0x00}, bf65), Local0)
		m600(arg0, 13, Local0, bb11)


		Concatenate(Buffer(){0x5a}, bf62, Local0)
		m600(arg0, 14, Local0, bb12)

		Concatenate(Buffer(){0x5a, 0x00}, bf62, Local0)
		m600(arg0, 15, Local0, bb13)

		Concatenate(aub0, bf62, Local0)
		m600(arg0, 16, Local0, bb12)

		Concatenate(aub1, bf62, Local0)
		m600(arg0, 17, Local0, bb13)

		if (y078) {
			Concatenate(Derefof(Refof(aub0)), bf62, Local0)
			m600(arg0, 18, Local0, bb12)

			Concatenate(Derefof(Refof(aub1)), bf62, Local0)
			m600(arg0, 19, Local0, bb13)
		}

		Concatenate(Derefof(Index(paub, 0)), bf62, Local0)
		m600(arg0, 20, Local0, bb12)

		Concatenate(Derefof(Index(paub, 1)), bf62, Local0)
		m600(arg0, 21, Local0, bb13)

		// Method returns Buffer

		Concatenate(m601(3, 0), bf62, Local0)
		m600(arg0, 22, Local0, bb12)

		Concatenate(m601(3, 1), bf62, Local0)
		m600(arg0, 23, Local0, bb13)

		// Method returns Reference to Buffer

		if (y500) {
			Concatenate(Derefof(m602(3, 0, 1)), bf62, Local0)
			m600(arg0, 24, Local0, bb12)

			Concatenate(Derefof(m602(3, 1, 1)), bf62, Local0)
			m600(arg0, 25, Local0, bb13)
		}

		Concatenate(Buffer(){0x5a}, bf65, Local0)
		m600(arg0, 26, Local0, bb10)

		Concatenate(Buffer(){0x5a, 0x00}, bf65, Local0)
		m600(arg0, 27, Local0, bb11)

	}


	// Buffer Field to Buffer conversion of the Buffer Field Source operand
	// of ToString operator

	Method(m647, 1)
	{
		CreateField(b641, 228, 64, bf71)
		CreateField(b641, 292, 64, bf72)

		Store(0x6e7c534136502214, bf71)
		Store(0x6e00534136002214, bf72)

		Store(ToString(bf71, Ones), Local0)
		m600(arg0, 0, Local0, bs18)

		Store(ToString(bf71, 3), Local0)
		m600(arg0, 1, Local0, bs19)

		Store(ToString(bf72, Ones), Local0)
		m600(arg0, 2, Local0, bs1a)

		Store(ToString(bf71, aui0), Local0)
		m600(arg0, 3, Local0, bs18)

		Store(ToString(bf71, aui7), Local0)
		m600(arg0, 4, Local0, bs19)

		Store(ToString(bf72, aui0), Local0)
		m600(arg0, 5, Local0, bs1a)

		if (y078) {
			Store(ToString(bf71, Derefof(Refof(aui0))), Local0)
			m600(arg0, 6, Local0, bs18)

			Store(ToString(bf71, Derefof(Refof(aui7))), Local0)
			m600(arg0, 7, Local0, bs19)

			Store(ToString(bf72, Derefof(Refof(aui0))), Local0)
			m600(arg0, 8, Local0, bs1a)
		}

		Store(ToString(bf71, Derefof(Index(paui, 0))), Local0)
		m600(arg0, 9, Local0, bs18)

		Store(ToString(bf71, Derefof(Index(paui, 7))), Local0)
		m600(arg0, 10, Local0, bs19)

		Store(ToString(bf72, Derefof(Index(paui, 0))), Local0)
		m600(arg0, 11, Local0, bs1a)

		// Method returns Length parameter

		Store(ToString(bf71, m601(1, 0)), Local0)
		m600(arg0, 12, Local0, bs18)

		Store(ToString(bf71, m601(1, 7)), Local0)
		m600(arg0, 13, Local0, bs19)

		Store(ToString(bf72, m601(1, 0)), Local0)
		m600(arg0, 14, Local0, bs1a)

		// Method returns Reference to Length parameter

		if (y500) {
			Store(ToString(bf71, Derefof(m601(1, 0))), Local0)
			m600(arg0, 15, Local0, bs18)

			Store(ToString(bf71, Derefof(m601(1, 7))), Local0)
			m600(arg0, 16, Local0, bs19)

			Store(ToString(bf72, Derefof(m601(1, 0))), Local0)
			m600(arg0, 17, Local0, bs1a)
		}

		ToString(bf71, Ones, Local0)
		m600(arg0, 18, Local0, bs18)

		ToString(bf71, 3, Local0)
		m600(arg0, 19, Local0, bs19)

		ToString(bf72, Ones, Local0)
		m600(arg0, 20, Local0, bs1a)

		ToString(bf71, aui0, Local0)
		m600(arg0, 21, Local0, bs18)

		ToString(bf71, aui7, Local0)
		m600(arg0, 22, Local0, bs19)

		ToString(bf72, aui0, Local0)
		m600(arg0, 23, Local0, bs1a)

		if (y078) {
			ToString(bf71, Derefof(Refof(aui0)), Local0)
			m600(arg0, 24, Local0, bs18)

			ToString(bf71, Derefof(Refof(aui7)), Local0)
			m600(arg0, 25, Local0, bs19)

			ToString(bf72, Derefof(Refof(aui0)), Local0)
			m600(arg0, 26, Local0, bs1a)
		}

		ToString(bf71, Derefof(Index(paui, 0)), Local0)
		m600(arg0, 27, Local0, bs18)

		ToString(bf71, Derefof(Index(paui, 7)), Local0)
		m600(arg0, 28, Local0, bs19)

		ToString(bf72, Derefof(Index(paui, 0)), Local0)
		m600(arg0, 29, Local0, bs1a)

		// Method returns Length parameter

		ToString(bf71, m601(1, 0), Local0)
		m600(arg0, 30, Local0, bs18)

		ToString(bf71, m601(1, 7), Local0)
		m600(arg0, 31, Local0, bs19)

		ToString(bf72, m601(1, 0), Local0)
		m600(arg0, 32, Local0, bs1a)

		// Method returns Reference to Length parameter

		if (y500) {
			ToString(bf71, Derefof(m601(1, 0)), Local0)
			m600(arg0, 33, Local0, bs18)

			ToString(bf71, Derefof(m601(1, 7)), Local0)
			m600(arg0, 34, Local0, bs19)

			ToString(bf72, Derefof(m601(1, 0)), Local0)
			m600(arg0, 35, Local0, bs1a)
		}
	}
	
	Method(m327, 1)
	{
		CreateField(b641, 196, 32, bf70)
		CreateField(b641, 356, 64, bf73)

		Store(0x6179534e, bf70)
		Store(0x6e7c534136002214, bf73)

		Store(ToString(bf70, Ones), Local0)
		m600(arg0, 0, Local0, bs16)

		Store(ToString(bf70, 3), Local0)
		m600(arg0, 1, Local0, bs17)

		Store(ToString(bf73, Ones), Local0)
		m600(arg0, 2, Local0, bs1a)

		Store(ToString(bf70, aui0), Local0)
		m600(arg0, 3, Local0, bs16)

		Store(ToString(bf70, aui7), Local0)
		m600(arg0, 4, Local0, bs17)

		Store(ToString(bf73, aui0), Local0)
		m600(arg0, 5, Local0, bs1a)

		if (y078) {
			Store(ToString(bf70, Derefof(Refof(aui0))), Local0)
			m600(arg0, 6, Local0, bs16)

			Store(ToString(bf70, Derefof(Refof(aui7))), Local0)
			m600(arg0, 7, Local0, bs17)

			Store(ToString(bf73, Derefof(Refof(aui0))), Local0)
			m600(arg0, 8, Local0, bs1a)
		}

		Store(ToString(bf70, Derefof(Index(paui, 0))), Local0)
		m600(arg0, 9, Local0, bs16)

		Store(ToString(bf70, Derefof(Index(paui, 7))), Local0)
		m600(arg0, 10, Local0, bs17)

		Store(ToString(bf73, Derefof(Index(paui, 0))), Local0)
		m600(arg0, 11, Local0, bs1a)

		// Method returns Length parameter

		Store(ToString(bf70, m601(1, 0)), Local0)
		m600(arg0, 12, Local0, bs16)

		Store(ToString(bf70, m601(1, 7)), Local0)
		m600(arg0, 13, Local0, bs17)

		Store(ToString(bf73, m601(1, 0)), Local0)
		m600(arg0, 14, Local0, bs1a)

		// Method returns Reference to Length parameter

		if (y500) {
			Store(ToString(bf70, Derefof(m601(1, 0))), Local0)
			m600(arg0, 15, Local0, bs16)

			Store(ToString(bf70, Derefof(m601(1, 7))), Local0)
			m600(arg0, 16, Local0, bs17)

			Store(ToString(bf73, Derefof(m601(1, 0))), Local0)
			m600(arg0, 17, Local0, bs1a)
		}

		ToString(bf70, Ones, Local0)
		m600(arg0, 18, Local0, bs16)

		ToString(bf70, 3, Local0)
		m600(arg0, 19, Local0, bs17)

		ToString(bf73, Ones, Local0)
		m600(arg0, 20, Local0, bs1a)

		ToString(bf70, aui0, Local0)
		m600(arg0, 21, Local0, bs16)

		ToString(bf70, aui7, Local0)
		m600(arg0, 22, Local0, bs17)

		ToString(bf73, aui0, Local0)
		m600(arg0, 23, Local0, bs1a)

		if (y078) {
			ToString(bf70, Derefof(Refof(aui0)), Local0)
			m600(arg0, 24, Local0, bs16)

			ToString(bf70, Derefof(Refof(aui7)), Local0)
			m600(arg0, 25, Local0, bs17)

			ToString(bf73, Derefof(Refof(aui0)), Local0)
			m600(arg0, 26, Local0, bs1a)
		}

		ToString(bf70, Derefof(Index(paui, 0)), Local0)
		m600(arg0, 27, Local0, bs16)

		ToString(bf70, Derefof(Index(paui, 7)), Local0)
		m600(arg0, 28, Local0, bs17)

		ToString(bf73, Derefof(Index(paui, 0)), Local0)
		m600(arg0, 29, Local0, bs1a)

		// Method returns Length parameter

		ToString(bf70, m601(1, 0), Local0)
		m600(arg0, 30, Local0, bs16)

		ToString(bf70, m601(1, 7), Local0)
		m600(arg0, 31, Local0, bs17)

		ToString(bf73, m601(1, 0), Local0)
		m600(arg0, 32, Local0, bs1a)

		// Method returns Reference to Length parameter

		if (y500) {
			ToString(bf70, Derefof(m601(1, 0)), Local0)
			m600(arg0, 33, Local0, bs16)

			ToString(bf70, Derefof(m601(1, 7)), Local0)
			m600(arg0, 34, Local0, bs17)

			ToString(bf73, Derefof(m601(1, 0)), Local0)
			m600(arg0, 35, Local0, bs1a)
		}
	}

	// Buffer Field to Buffer conversion of the Buffer Field Source operand
	// of Mid operator

	Method(m648, 1)
	{
		CreateField(b640, 159, 64, bf65)
		CreateField(b630, 223, 65, bf66)
		CreateField(b641, 356, 64, bf73)

		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)
		Store(Buffer(9){0x21, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01}, bf66)
		Store(0x6e7c534136002214, bf73)

		Store(Mid(bf65, 0, 9), Local0)
		m600(arg0, 0, Local0, bb1d)

		Store(Mid(bf66, 0, 9), Local0)
		m600(arg0, 1, Local0, bb1f)

		Store(Mid(bf73, 1, 8), Local0)
		m600(arg0, 2, Local0, bb30)

		Store(Mid(bf65, aui5, auib), Local0)
		m600(arg0, 3, Local0, bb1d)

		Store(Mid(bf66, aui5, auib), Local0)
		m600(arg0, 4, Local0, bb1f)

		Store(Mid(bf73, aui6, auia), Local0)
		m600(arg0, 5, Local0, bb30)

		if (y078) {
			Store(Mid(bf65, Derefof(Refof(aui5)), Derefof(Refof(auib))), Local0)
			m600(arg0, 6, Local0, bb1d)

			Store(Mid(bf66, Derefof(Refof(aui5)), Derefof(Refof(auib))), Local0)
			m600(arg0, 7, Local0, bb1f)

			Store(Mid(bf73, Derefof(Refof(aui6)), Derefof(Refof(auia))), Local0)
			m600(arg0, 8, Local0, bb30)
		}

		Store(Mid(bf65, Derefof(Index(paui, 5)), Derefof(Index(paui, 11))), Local0)
		m600(arg0, 9, Local0, bb1d)

		Store(Mid(bf66, Derefof(Index(paui, 5)), Derefof(Index(paui, 11))), Local0)
		m600(arg0, 10, Local0, bb1f)

		Store(Mid(bf73, Derefof(Index(paui, 6)), Derefof(Index(paui, 10))), Local0)
		m600(arg0, 11, Local0, bb30)

		// Method returns Index and Length parameters

		Store(Mid(bf65, m601(1, 5), m601(1, 11)), Local0)
		m600(arg0, 12, Local0, bb1d)

		Store(Mid(bf66, m601(1, 5), m601(1, 11)), Local0)
		m600(arg0, 13, Local0, bb1f)

		Store(Mid(bf73, m601(1, 6), m601(1, 10)), Local0)
		m600(arg0, 14, Local0, bb30)

		// Method returns Reference to Index and Length parameters

		if (y500) {
			Store(Mid(bf65, Derefof(m601(1, 5)), Derefof(m601(1, 11))), Local0)
			m600(arg0, 15, Local0, bb1d)

			Store(Mid(bf66, Derefof(m601(1, 5)), Derefof(m601(1, 11))), Local0)
			m600(arg0, 16, Local0, bb1f)

			Store(Mid(bf73, Derefof(m601(1, 6)), Derefof(m601(1, 10))), Local0)
			m600(arg0, 17, Local0, bb30)
		}

		Mid(bf65, 0, 9, Local0)
		m600(arg0, 18, Local0, bb1d)

		Mid(bf66, 0, 9, Local0)
		m600(arg0, 19, Local0, bb1f)

		Mid(bf73, 1, 8, Local0)
		m600(arg0, 20, Local0, bb30)

		Mid(bf65, aui5, auib, Local0)
		m600(arg0, 21, Local0, bb1d)

		Mid(bf66, aui5, auib, Local0)
		m600(arg0, 22, Local0, bb1f)

		Mid(bf73, aui6, auia, Local0)
		m600(arg0, 23, Local0, bb30)

		if (y078) {
			Mid(bf65, Derefof(Refof(aui5)), Derefof(Refof(auib)), Local0)
			m600(arg0, 24, Local0, bb1d)

			Mid(bf66, Derefof(Refof(aui5)), Derefof(Refof(auib)), Local0)
			m600(arg0, 25, Local0, bb1f)

			Mid(bf73, Derefof(Refof(aui6)), Derefof(Refof(auia)), Local0)
			m600(arg0, 26, Local0, bb30)
		}

		Mid(bf65, Derefof(Index(paui, 5)), Derefof(Index(paui, 11)), Local0)
		m600(arg0, 27, Local0, bb1d)

		Mid(bf66, Derefof(Index(paui, 5)), Derefof(Index(paui, 11)), Local0)
		m600(arg0, 28, Local0, bb1f)

		Mid(bf73, Derefof(Index(paui, 6)), Derefof(Index(paui, 10)), Local0)
		m600(arg0, 29, Local0, bb30)

		// Method returns Index and Length parameters

		Mid(bf65, m601(1, 5), m601(1, 11), Local0)
		m600(arg0, 30, Local0, bb1d)

		Mid(bf66, m601(1, 5), m601(1, 11), Local0)
		m600(arg0, 31, Local0, bb1f)

		Mid(bf73, m601(1, 6), m601(1, 10), Local0)
		m600(arg0, 32, Local0, bb30)

		// Method returns Reference to Index and Length parameters

		if (y500) {
			Mid(bf65, Derefof(m601(1, 5)), Derefof(m601(1, 11)), Local0)
			m600(arg0, 33, Local0, bb1d)

			Mid(bf66, Derefof(m601(1, 5)), Derefof(m601(1, 11)), Local0)
			m600(arg0, 34, Local0, bb1f)

			Mid(bf73, Derefof(m601(1, 6)), Derefof(m601(1, 10)), Local0)
			m600(arg0, 35, Local0, bb30)
		}
	}
	
	Method(m328, 1)
	{
		CreateField(b640,  31, 32, bf62)
		CreateField(b630,  63, 33, bf63)
		CreateField(b641, 519, 32, bf77)

		Store(Buffer(4){0xFE, 0xB3, 0x79, 0xC1}, bf62)
		Store(Buffer(5){0xFE, 0xB3, 0x79, 0xC1, 0xa5}, bf63)
		Store(0x36002214, bf77)

		Store(Mid(bf62, 0, 5), Local0)
		m600(arg0, 0, Local0, bb1c)

		Store(Mid(bf63, 0, 5), Local0)
		m600(arg0, 1, Local0, bb1e)

		Store(Mid(bf77, 1, 4), Local0)
		m600(arg0, 2, Local0, bb31)

		Store(Mid(bf62, aui5, aui9), Local0)
		m600(arg0, 3, Local0, bb1c)

		Store(Mid(bf63, aui5, aui9), Local0)
		m600(arg0, 4, Local0, bb1e)

		Store(Mid(bf77, aui6, aui8), Local0)
		m600(arg0, 5, Local0, bb31)

		if (y078) {
			Store(Mid(bf62, Derefof(Refof(aui5)), Derefof(Refof(aui9))), Local0)
			m600(arg0, 6, Local0, bb1c)

			Store(Mid(bf63, Derefof(Refof(aui5)), Derefof(Refof(aui9))), Local0)
			m600(arg0, 7, Local0, bb1e)

			Store(Mid(bf77, Derefof(Refof(aui6)), Derefof(Refof(aui8))), Local0)
			m600(arg0, 8, Local0, bb31)
		}

		Store(Mid(bf62, Derefof(Index(paui, 5)), Derefof(Index(paui, 9))), Local0)
		m600(arg0, 9, Local0, bb1c)

		Store(Mid(bf63, Derefof(Index(paui, 5)), Derefof(Index(paui, 9))), Local0)
		m600(arg0, 10, Local0, bb1e)

		Store(Mid(bf77, Derefof(Index(paui, 6)), Derefof(Index(paui, 8))), Local0)
		m600(arg0, 11, Local0, bb31)

		// Method returns Index and Length parameters

		Store(Mid(bf62, m601(1, 5), m601(1, 9)), Local0)
		m600(arg0, 12, Local0, bb1c)

		Store(Mid(bf63, m601(1, 5), m601(1, 9)), Local0)
		m600(arg0, 13, Local0, bb1e)

		Store(Mid(bf77, m601(1, 6), m601(1, 8)), Local0)
		m600(arg0, 14, Local0, bb31)

		// Method returns Reference to Index and Length parameters

		if (y500) {
			Store(Mid(bf62, Derefof(m601(1, 5)), Derefof(m601(1, 9))), Local0)
			m600(arg0, 15, Local0, bb1c)

			Store(Mid(bf63, Derefof(m601(1, 5)), Derefof(m601(1, 9))), Local0)
			m600(arg0, 16, Local0, bb1e)

			Store(Mid(bf77, Derefof(m601(1, 6)), Derefof(m601(1, 8))), Local0)
			m600(arg0, 17, Local0, bb31)
		}

		Mid(bf62, 0, 5, Local0)
		m600(arg0, 18, Local0, bb1c)

		Mid(bf63, 0, 5, Local0)
		m600(arg0, 19, Local0, bb1e)

		Mid(bf77, 1, 4, Local0)
		m600(arg0, 20, Local0, bb31)

		Mid(bf62, aui5, aui9, Local0)
		m600(arg0, 21, Local0, bb1c)

		Mid(bf63, aui5, aui9, Local0)
		m600(arg0, 22, Local0, bb1e)

		Mid(bf77, aui6, aui8, Local0)
		m600(arg0, 23, Local0, bb31)

		if (y078) {
			Mid(bf62, Derefof(Refof(aui5)), Derefof(Refof(aui9)), Local0)
			m600(arg0, 24, Local0, bb1c)

			Mid(bf63, Derefof(Refof(aui5)), Derefof(Refof(aui9)), Local0)
			m600(arg0, 25, Local0, bb1e)

			Mid(bf77, Derefof(Refof(aui6)), Derefof(Refof(aui8)), Local0)
			m600(arg0, 26, Local0, bb31)
		}

		Mid(bf62, Derefof(Index(paui, 5)), Derefof(Index(paui, 9)), Local0)
		m600(arg0, 27, Local0, bb1c)

		Mid(bf63, Derefof(Index(paui, 5)), Derefof(Index(paui, 9)), Local0)
		m600(arg0, 28, Local0, bb1e)

		Mid(bf77, Derefof(Index(paui, 6)), Derefof(Index(paui, 8)), Local0)
		m600(arg0, 29, Local0, bb31)

		// Method returns Index and Length parameters

		Mid(bf62, m601(1, 5), m601(1, 9), Local0)
		m600(arg0, 30, Local0, bb1c)

		Mid(bf63, m601(1, 5), m601(1, 9), Local0)
		m600(arg0, 31, Local0, bb1e)

		Mid(bf77, m601(1, 6), m601(1, 8), Local0)
		m600(arg0, 32, Local0, bb31)

		// Method returns Reference to Index and Length parameters

		if (y500) {
			Mid(bf62, Derefof(m601(1, 5)), Derefof(m601(1, 9)), Local0)
			m600(arg0, 33, Local0, bb1c)

			Mid(bf63, Derefof(m601(1, 5)), Derefof(m601(1, 9)), Local0)
			m600(arg0, 34, Local0, bb1e)

			Mid(bf77, Derefof(m601(1, 6)), Derefof(m601(1, 8)), Local0)
			m600(arg0, 35, Local0, bb31)
		}
	}


	// Buffer Field to Integer implicit conversion Cases.

	// Buffer Field to Integer conversion of the Buffer Field sole operand
	// of the 1-parameter Integer arithmetic operators
	// (Decrement, Increment, FindSetLeftBit, FindSetRightBit, Not)

	Method(m64l, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)
		CreateField(b630, 3424, 31, bf91)
		CreateField(b630, 3455, 64, bf95)
		CreateField(b630, 3519, 31, bfa1)
		CreateField(b630, 3550, 64, bfa5)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)
		Store(Buffer(3){0x21, 0x03, 0x00}, bf91)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf95)
		Store(Buffer(3){0x21, 0x03, 0x00}, bfa1)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bfa5)

		// Decrement

		Store(Decrement(bf91), Local0)
		m600(arg0, 0, Local0, bi12)

		Store(Decrement(bf95), Local0)
		m600(arg0, 1, Local0, bi16)

		// Increment

		Store(Increment(bfa1), Local0)
		m600(arg0, 2, Local0, bi23)

		Store(Increment(bfa5), Local0)
		m600(arg0, 3, Local0, bi27)

		// FindSetLeftBit

		Store(FindSetLeftBit(bf61), Local0)
		m600(arg0, 0, Local0, 10)

		Store(FindSetLeftBit(bf65), Local0)
		m600(arg0, 1, Local0, 64)

		// FindSetRightBit

		Store(FindSetRightBit(bf61), Local0)
		m600(arg0, 2, Local0, 1)

		Store(FindSetRightBit(bf65), Local0)
		m600(arg0, 3, Local0, 3)

		// Not

		Store(Not(bf61), Local0)
		m600(arg0, 4, Local0, 0xfffffffffffffcde)

		Store(Not(bf65), Local0)
		m600(arg0, 5, Local0, 0x01834c6e29af5d7b)

		m600(arg0, 6, bf61, 0x321)
		m600(arg0, 7, bf65, 0xfe7cb391d650a284)
		m600(arg0, 8, bf91, 0x320)
		m600(arg0, 9, bfa1, 0x322)
		m600(arg0, 10, bf95, 0xfe7cb391d650a283)
		m600(arg0, 11, bfa5, 0xfe7cb391d650a285)
	}

	Method(m32l, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)
		CreateField(b630, 3424, 31, bf91)
		CreateField(b630, 3455, 64, bf95)
		CreateField(b630, 3519, 31, bfa1)
		CreateField(b630, 3550, 64, bfa5)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)
		Store(Buffer(3){0x21, 0x03, 0x00}, bf91)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf95)
		Store(Buffer(3){0x21, 0x03, 0x00}, bfa1)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bfa5)

		// Decrement

		Store(Decrement(bf91), Local0)
		m600(arg0, 0, Local0, bi12)

		Store(Decrement(bf95), Local0)
		m600(arg0, 1, Local0, bi18)

		// Increment

		Store(Increment(bfa1), Local0)
		m600(arg0, 2, Local0, bi23)

		Store(Increment(bfa5), Local0)
		m600(arg0, 3, Local0, bi29)

		// FindSetLeftBit

		Store(FindSetLeftBit(bf61), Local0)
		m600(arg0, 0, Local0, 10)

		Store(FindSetLeftBit(bf65), Local0)
		m600(arg0, 1, Local0, 32)

		// FindSetRightBit

		Store(FindSetRightBit(bf61), Local0)
		m600(arg0, 2, Local0, 1)

		Store(FindSetRightBit(bf65), Local0)
		m600(arg0, 3, Local0, 3)

		// Not

		Store(Not(bf61), Local0)
		m600(arg0, 4, Local0, 0xfffffcde)

		Store(Not(bf65), Local0)
		m600(arg0, 5, Local0, 0x29af5d7b)

		m600(arg0, 6, bf61, 0x321)
		m600(arg0, 7, bf65, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
		m600(arg0, 8, bf91, 0x320)
		m600(arg0, 9, bfa1, 0x322)
		m600(arg0, 10, bf95, Buffer(8){0x83, 0xA2, 0x50, 0xD6, 0x00, 0x00, 0x00, 0x00})
		m600(arg0, 11, bfa5, Buffer(8){0x85, 0xA2, 0x50, 0xD6, 0x00, 0x00, 0x00, 0x00})
	}

	// Buffer Field to Integer conversion of the Buffer Field sole operand
	// of the LNot Logical Integer operator
	Method(m03a, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)
		CreateField(b641, 486, 33, bf76)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)
		Store(0, bf76)

		Store(LNot(bf76), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LNot(bf61), Local0)
		m600(arg0, 1, Local0, Zero)

		if (F64) {
			Store(LNot(bf65), Local0)
			m600(arg0, 2, Local0, Zero)
		} else {
			Store(LNot(bf65), Local0)
			m600(arg0, 3, Local0, Zero)
		}
	}

	// Buffer Field to Integer conversion of the Buffer Field sole operand
	// of the FromBCD and ToBCD conversion operators

	Method(m64m, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b641, 0, 65, bf6c)
		CreateField(b641, 65, 65, bf6d)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer() {0x01, 0x89, 0x67, 0x45, 0x23, 0x01, 0x89, 0x37}, bf6c)
		Store(Buffer() {0x35, 0xec, 0xe9, 0x2e, 0x16, 0x76, 0x0d}, bf6d)

		// FromBCD

		Store(FromBCD(bf61), Local0)
		m600(arg0, 2, Local0, 0x141)

		Store(FromBCD(bf6c), Local0)
		m600(arg0, 3, Local0, 0xd76162ee9ec35)

		FromBCD(bf61, Local0)
		m600(arg0, 2, Local0, 0x141)

		FromBCD(bf6c, Local0)
		m600(arg0, 3, Local0, 0xd76162ee9ec35)

		// ToBCD

		Store(ToBCD(bf61), Local0)
		m600(arg0, 4, Local0, 0x801)

// ??? No error of iASL on constant folding
		Store(ToBCD(bf6d), Local0)
		m600(arg0, 5, Local0, 0x3789012345678901)

		ToBCD(bf61, Local0)
		m600(arg0, 4, Local0, 0x801)

		ToBCD(bf6d, Local0)
		m600(arg0, 5, Local0, 0x3789012345678901)
	}

	Method(m32m, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b641, 130, 33, bf6e)
		CreateField(b641, 163, 33, bf6f)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer() {0x56, 0x34, 0x12, 0x90}, bf6e)
		Store(Buffer() {0xc0, 0x2c, 0x5f, 0x05}, bf6f)

		// FromBCD

		Store(FromBCD(bf61), Local0)
		m600(arg0, 2, Local0, 0x141)

		Store(FromBCD(bf6e), Local0)
		m600(arg0, 3, Local0, 0x55f2cc0)

		FromBCD(bf61, Local0)
		m600(arg0, 2, Local0, 0x141)

		FromBCD(bf6e, Local0)
		m600(arg0, 3, Local0, 0x55f2cc0)

		// ToBCD

		Store(ToBCD(bf61), Local0)
		m600(arg0, 4, Local0, 0x801)

		Store(ToBCD(bf6f), Local0)
		m600(arg0, 5, Local0, 0x90123456)

		ToBCD(bf61, Local0)
		m600(arg0, 4, Local0, 0x801)

		ToBCD(bf6f, Local0)
		m600(arg0, 5, Local0, 0x90123456)
	}

	// Buffer Field to Integer conversion of each Buffer operand
	// of the 2-parameter Integer arithmetic operators
	// Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
	// ShiftLeft, ShiftRight, Subtract, Xor

	// Add, common 32-bit/64-bit test
	Method(m03b, 1)
	{
		CreateField(b640,   0, 31, bf61)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		// Conversion of the first operand

		Store(Add(bf61, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Add(bf61, 1), Local0)
		m600(arg0, 1, Local0, 0x322)

		Store(Add(bf61, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Add(bf61, aui6), Local0)
		m600(arg0, 3, Local0, 0x322)

		if (y078) {
			Store(Add(bf61, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Add(bf61, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x322)
		}

		Store(Add(bf61, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Add(bf61, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x322)

		// Method returns Integer

		Store(Add(bf61, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Add(bf61, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(bf61, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Add(bf61, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x322)
		}

		Add(bf61, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Add(bf61, 1, Local0)
		m600(arg0, 13, Local0, 0x322)

		Add(bf61, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Add(bf61, aui6, Local0)
		m600(arg0, 15, Local0, 0x322)

		if (y078) {
			Add(bf61, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Add(bf61, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x322)
		}

		Add(bf61, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Add(bf61, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x322)

		// Method returns Integer

		Add(bf61, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Add(bf61, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Add(bf61, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Add(bf61, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x322)
		}

		// Conversion of the second operand

		Store(Add(0, bf61), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(Add(1, bf61), Local0)
		m600(arg0, 25, Local0, 0x322)

		Store(Add(aui5, bf61), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(Add(aui6, bf61), Local0)
		m600(arg0, 27, Local0, 0x322)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), bf61), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(Add(Derefof(Refof(aui6)), bf61), Local0)
			m600(arg0, 29, Local0, 0x322)
		}

		Store(Add(Derefof(Index(paui, 5)), bf61), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(Add(Derefof(Index(paui, 6)), bf61), Local0)
		m600(arg0, 31, Local0, 0x322)

		// Method returns Integer

		Store(Add(m601(1, 5), bf61), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(Add(m601(1, 6), bf61), Local0)
		m600(arg0, 33, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), bf61), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(Add(Derefof(m602(1, 6, 1)), bf61), Local0)
			m600(arg0, 35, Local0, 0x322)
		}

		Add(0, bf61, Local0)
		m600(arg0, 36, Local0, 0x321)

		Add(1, bf61, Local0)
		m600(arg0, 37, Local0, 0x322)

		Add(aui5, bf61, Local0)
		m600(arg0, 38, Local0, 0x321)

		Add(aui6, bf61, Local0)
		m600(arg0, 39, Local0, 0x322)

		if (y078) {
			Add(Derefof(Refof(aui5)), bf61, Local0)
			m600(arg0, 40, Local0, 0x321)

			Add(Derefof(Refof(aui6)), bf61, Local0)
			m600(arg0, 41, Local0, 0x322)
		}

		Add(Derefof(Index(paui, 5)), bf61, Local0)
		m600(arg0, 42, Local0, 0x321)

		Add(Derefof(Index(paui, 6)), bf61, Local0)
		m600(arg0, 43, Local0, 0x322)

		// Method returns Integer

		Add(m601(1, 5), bf61, Local0)
		m600(arg0, 44, Local0, 0x321)

		Add(m601(1, 6), bf61, Local0)
		m600(arg0, 45, Local0, 0x322)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), bf61, Local0)
			m600(arg0, 46, Local0, 0x321)

			Add(Derefof(m602(1, 6, 1)), bf61, Local0)
			m600(arg0, 47, Local0, 0x322)
		}
	}

	// Add, 64-bit
	Method(m03c, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(Add(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Add(bf65, 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a285)

		Store(Add(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Add(bf65, aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Store(Add(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Add(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a285)
		}

		Store(Add(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Add(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Store(Add(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Add(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Add(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a285)
		}

		Add(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Add(bf65, 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a285)

		Add(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Add(bf65, aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Add(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Add(bf65, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a285)
		}

		Add(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Add(bf65, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Add(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Add(bf65, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Add(bf65, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a285)
		}

		// Conversion of the second operand

		Store(Add(0, bf65), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(Add(1, bf65), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a285)

		Store(Add(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(Add(aui6, bf65), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(Add(Derefof(Refof(aui6)), bf65), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a285)
		}

		Store(Add(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(Add(Derefof(Index(paui, 6)), bf65), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Store(Add(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(Add(m601(1, 6), bf65), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(Add(Derefof(m602(1, 6, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a285)
		}

		Add(0, bf65, Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		Add(1, bf65, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a285)

		Add(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		Add(aui6, bf65, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a285)

		if (y078) {
			Add(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			Add(Derefof(Refof(aui6)), bf65, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a285)
		}

		Add(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		Add(Derefof(Index(paui, 6)), bf65, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a285)

		// Method returns Integer

		Add(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		Add(m601(1, 6), bf65, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			Add(Derefof(m602(1, 6, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a285)
		}

		// Conversion of the both operands

		Store(Add(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a5a5)

		Store(Add(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a5a5)

		Add(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a5a5)

		Add(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a5a5)
	}

	// Add, 32-bit
	Method(m03d, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(Add(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Add(bf65, 1), Local0)
		m600(arg0, 1, Local0, 0xd650a285)

		Store(Add(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Add(bf65, aui6), Local0)
		m600(arg0, 3, Local0, 0xd650a285)

		if (y078) {
			Store(Add(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Add(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xd650a285)
		}

		Store(Add(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(Add(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xd650a285)

		// Method returns Integer

		Store(Add(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Add(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xd650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Add(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xd650a285)
		}

		Add(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Add(bf65, 1, Local0)
		m600(arg0, 13, Local0, 0xd650a285)

		Add(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Add(bf65, aui6, Local0)
		m600(arg0, 15, Local0, 0xd650a285)

		if (y078) {
			Add(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Add(bf65, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xd650a285)
		}

		Add(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Add(bf65, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xd650a285)

		// Method returns Integer

		Add(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Add(bf65, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xd650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Add(bf65, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xd650a285)
		}

		// Conversion of the second operand

		Store(Add(0, bf65), Local0)
		m600(arg0, 24, Local0, 0xd650a284)

		Store(Add(1, bf65), Local0)
		m600(arg0, 25, Local0, 0xd650a285)

		Store(Add(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0xd650a284)

		Store(Add(aui6, bf65), Local0)
		m600(arg0, 27, Local0, 0xd650a285)

		if (y078) {
			Store(Add(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0xd650a284)

			Store(Add(Derefof(Refof(aui6)), bf65), Local0)
			m600(arg0, 29, Local0, 0xd650a285)
		}

		Store(Add(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0xd650a284)

		Store(Add(Derefof(Index(paui, 6)), bf65), Local0)
		m600(arg0, 31, Local0, 0xd650a285)

		// Method returns Integer

		Store(Add(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0xd650a284)

		Store(Add(m601(1, 6), bf65), Local0)
		m600(arg0, 33, Local0, 0xd650a285)

		// Method returns Reference to Integer

		if (y500) {
			Store(Add(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0xd650a284)

			Store(Add(Derefof(m602(1, 6, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0xd650a285)
		}

		Add(0, bf65, Local0)
		m600(arg0, 36, Local0, 0xd650a284)

		Add(1, bf65, Local0)
		m600(arg0, 37, Local0, 0xd650a285)

		Add(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0xd650a284)

		Add(aui6, bf65, Local0)
		m600(arg0, 39, Local0, 0xd650a285)

		if (y078) {
			Add(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0xd650a284)

			Add(Derefof(Refof(aui6)), bf65, Local0)
			m600(arg0, 41, Local0, 0xd650a285)
		}

		Add(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0xd650a284)

		Add(Derefof(Index(paui, 6)), bf65, Local0)
		m600(arg0, 43, Local0, 0xd650a285)

		// Method returns Integer

		Add(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0xd650a284)

		Add(m601(1, 6), bf65, Local0)
		m600(arg0, 45, Local0, 0xd650a285)

		// Method returns Reference to Integer

		if (y500) {
			Add(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0xd650a284)

			Add(Derefof(m602(1, 6, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0xd650a285)
		}

		// Conversion of the both operands

		Store(Add(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0xd650a5a5)

		Store(Add(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0xd650a5a5)

		Add(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0xd650a5a5)

		Add(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0xd650a5a5)
	}

	// And, common 32-bit/64-bit test
	Method(m03e, 1)
	{
		CreateField(b640,   0, 31, bf61)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)

		// Conversion of the first operand

		Store(And(bf61, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And(bf61, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x321)

		Store(And(bf61, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And(bf61, auij), Local0)
		m600(arg0, 3, Local0, 0x321)

		if (y078) {
			Store(And(bf61, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And(bf61, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x321)
		}

		Store(And(bf61, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And(bf61, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x321)

		// Method returns Integer

		Store(And(bf61, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And(bf61, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(bf61, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And(bf61, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x321)
		}

		And(bf61, 0, Local0)
		m600(arg0, 12, Local0, 0)

		And(bf61, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x321)

		And(bf61, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And(bf61, auij, Local0)
		m600(arg0, 15, Local0, 0x321)

		if (y078) {
			And(bf61, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And(bf61, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x321)
		}

		And(bf61, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And(bf61, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x321)

		// Method returns Integer

		And(bf61, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And(bf61, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			And(bf61, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And(bf61, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x321)
		}

		// Conversion of the second operand

		Store(And(0, bf61), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffffffffffff, bf61), Local0)
		m600(arg0, 25, Local0, 0x321)

		Store(And(aui5, bf61), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auij, bf61), Local0)
		m600(arg0, 27, Local0, 0x321)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), bf61), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auij)), bf61), Local0)
			m600(arg0, 29, Local0, 0x321)
		}

		Store(And(Derefof(Index(paui, 5)), bf61), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 19)), bf61), Local0)
		m600(arg0, 31, Local0, 0x321)

		// Method returns Integer

		Store(And(m601(1, 5), bf61), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 19), bf61), Local0)
		m600(arg0, 33, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), bf61), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 19, 1)), bf61), Local0)
			m600(arg0, 35, Local0, 0x321)
		}

		And(0, bf61, Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffffffffffff, bf61, Local0)
		m600(arg0, 37, Local0, 0x321)

		And(aui5, bf61, Local0)
		m600(arg0, 38, Local0, 0)

		And(auij, bf61, Local0)
		m600(arg0, 39, Local0, 0x321)

		if (y078) {
			And(Derefof(Refof(aui5)), bf61, Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auij)), bf61, Local0)
			m600(arg0, 41, Local0, 0x321)
		}

		And(Derefof(Index(paui, 5)), bf61, Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 19)), bf61, Local0)
		m600(arg0, 43, Local0, 0x321)

		// Method returns Integer

		And(m601(1, 5), bf61, Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 19), bf61, Local0)
		m600(arg0, 45, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), bf61, Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 19, 1)), bf61, Local0)
			m600(arg0, 47, Local0, 0x321)
		}
	}

	// And, 64-bit
	Method(m03f, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(And(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And(bf65, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a284)

		Store(And(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And(bf65, auij), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(And(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And(bf65, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a284)
		}

		Store(And(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And(bf65, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(And(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And(bf65, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And(bf65, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a284)
		}

		And(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0)

		And(bf65, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		And(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And(bf65, auij, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a284)

		if (y078) {
			And(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And(bf65, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a284)
		}

		And(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And(bf65, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		And(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And(bf65, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And(bf65, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the second operand

		Store(And(0, bf65), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffffffffffff, bf65), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a284)

		Store(And(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auij, bf65), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auij)), bf65), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a284)
		}

		Store(And(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 19)), bf65), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(And(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 19), bf65), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 19, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a284)
		}

		And(0, bf65, Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffffffffffff, bf65, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a284)

		And(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0)

		And(auij, bf65, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a284)

		if (y078) {
			And(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auij)), bf65, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a284)
		}

		And(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 19)), bf65, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		And(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 19), bf65, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 19, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the both operands

		Store(And(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0x200)

		Store(And(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0x200)

		And(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0x200)

		And(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0x200)
	}

	// And, 32-bit
	Method(m040, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(And(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(And(bf65, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0xd650a284)

		Store(And(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(And(bf65, auii), Local0)
		m600(arg0, 3, Local0, 0xd650a284)

		if (y078) {
			Store(And(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(And(bf65, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0xd650a284)
		}

		Store(And(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(And(bf65, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0xd650a284)

		// Method returns Integer

		Store(And(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(And(bf65, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(And(bf65, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0xd650a284)
		}

		And(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0)

		And(bf65, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0xd650a284)

		And(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		And(bf65, auii, Local0)
		m600(arg0, 15, Local0, 0xd650a284)

		if (y078) {
			And(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			And(bf65, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0xd650a284)
		}

		And(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		And(bf65, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0xd650a284)

		// Method returns Integer

		And(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		And(bf65, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			And(bf65, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0xd650a284)
		}

		// Conversion of the second operand

		Store(And(0, bf65), Local0)
		m600(arg0, 24, Local0, 0)

		Store(And(0xffffffff, bf65), Local0)
		m600(arg0, 25, Local0, 0xd650a284)

		Store(And(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0)

		Store(And(auii, bf65), Local0)
		m600(arg0, 27, Local0, 0xd650a284)

		if (y078) {
			Store(And(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0)

			Store(And(Derefof(Refof(auii)), bf65), Local0)
			m600(arg0, 29, Local0, 0xd650a284)
		}

		Store(And(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0)

		Store(And(Derefof(Index(paui, 18)), bf65), Local0)
		m600(arg0, 31, Local0, 0xd650a284)

		// Method returns Integer

		Store(And(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0)

		Store(And(m601(1, 18), bf65), Local0)
		m600(arg0, 33, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(And(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0)

			Store(And(Derefof(m602(1, 18, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0xd650a284)
		}

		And(0, bf65, Local0)
		m600(arg0, 36, Local0, 0)

		And(0xffffffff, bf65, Local0)
		m600(arg0, 37, Local0, 0xd650a284)

		And(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0)

		And(auii, bf65, Local0)
		m600(arg0, 39, Local0, 0xd650a284)

		if (y078) {
			And(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0)

			And(Derefof(Refof(auii)), bf65, Local0)
			m600(arg0, 41, Local0, 0xd650a284)
		}

		And(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0)

		And(Derefof(Index(paui, 18)), bf65, Local0)
		m600(arg0, 43, Local0, 0xd650a284)

		// Method returns Integer

		And(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0)

		And(m601(1, 18), bf65, Local0)
		m600(arg0, 45, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			And(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0)

			And(Derefof(m602(1, 18, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0xd650a284)
		}

		// Conversion of the both operands

		Store(And(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0x200)

		Store(And(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0x200)

		And(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0x200)

		And(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0x200)
	}

	// Divide, common 32-bit/64-bit test
	Method(m041, 1)
	{
		CreateField(b640,   0, 31, bf61)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)

		// Conversion of the first operand

		Store(Divide(bf61, 1), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Divide(bf61, 0x321), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide(bf61, aui6), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Divide(bf61, aui1), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide(bf61, Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Divide(bf61, Derefof(Refof(aui1))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide(bf61, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Divide(bf61, Derefof(Index(paui, 1))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide(bf61, m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Divide(bf61, m601(1, 1)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(bf61, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Divide(bf61, Derefof(m602(1, 1, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide(bf61, 1, Local1, Local0)
		m600(arg0, 12, Local0, 0x321)

		Divide(bf61, 0x321, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide(bf61, aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0x321)

		Divide(bf61, aui1, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide(bf61, Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0x321)

			Divide(bf61, Derefof(Refof(aui1)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide(bf61, Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0x321)

		Divide(bf61, Derefof(Index(paui, 1)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide(bf61, m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0x321)

		Divide(bf61, m601(1, 1), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(bf61, Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0x321)

			Divide(bf61, Derefof(m602(1, 1, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, bf61), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0x321, bf61), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, bf61), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(aui1, bf61), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), bf61), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(aui1)), bf61), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), bf61), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 1)), bf61), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), bf61), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 1), bf61), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), bf61), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 1, 1)), bf61), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, bf61, Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0x321, bf61, Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, bf61, Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(aui1, bf61, Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), bf61, Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(aui1)), bf61, Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), bf61, Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 1)), bf61, Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), bf61, Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 1), bf61, Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), bf61, Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 1, 1)), bf61, Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}
	}

	// Divide, 64-bit
	Method(m042, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(Divide(bf65, 1), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Divide(bf65, 0xfe7cb391d650a284), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide(bf65, aui6), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Divide(bf65, aui4), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Divide(bf65, Derefof(Refof(aui4))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Divide(bf65, Derefof(Index(paui, 4))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide(bf65, m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Divide(bf65, m601(1, 4)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Divide(bf65, Derefof(m602(1, 4, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide(bf65, 1, Local1, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Divide(bf65, 0xfe7cb391d650a284, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide(bf65, aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Divide(bf65, aui4, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide(bf65, Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Divide(bf65, Derefof(Refof(aui4)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide(bf65, Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Divide(bf65, Derefof(Index(paui, 4)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide(bf65, m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Divide(bf65, m601(1, 4), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(bf65, Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Divide(bf65, Derefof(m602(1, 4, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, bf65), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0xfe7cb391d650a284, bf65), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, bf65), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(aui4, bf65), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), bf65), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(aui4)), bf65), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), bf65), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 4)), bf65), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), bf65), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 4), bf65), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 4, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, bf65, Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0xfe7cb391d650a284, bf65, Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, bf65, Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(aui4, bf65, Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), bf65, Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(aui4)), bf65, Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), bf65, Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 4)), bf65, Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), bf65, Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 4), bf65, Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), bf65, Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 4, 1)), bf65, Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}

		// Conversion of the both operands

		Store(Divide(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0)

		Store(Divide(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0x0051558eb950f5a7)

		Divide(bf61, bf65, Local1, Local0)
		m600(arg0, 50, Local0, 0)

		Divide(bf65, bf61, Local1, Local0)
		m600(arg0, 51, Local0, 0x0051558eb950f5a7)
	}

	// Divide, 32-bit
	Method(m043, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(Divide(bf65, 1), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Divide(bf65, 0xd650a284), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Divide(bf65, aui6), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Divide(bf65, auik), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Divide(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Divide(bf65, Derefof(Refof(auik))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Divide(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(Divide(bf65, Derefof(Index(paui, 20))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Divide(bf65, m601(1, 6)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Divide(bf65, m601(1, 20)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Divide(bf65, Derefof(m602(1, 20, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Divide(bf65, 1, Local1, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Divide(bf65, 0xd650a284, Local1, Local0)
		m600(arg0, 13, Local0, 1)

		Divide(bf65, aui6, Local1, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Divide(bf65, auik, Local1, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Divide(bf65, Derefof(Refof(aui6)), Local1, Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Divide(bf65, Derefof(Refof(auik)), Local1, Local0)
			m600(arg0, 17, Local0, 1)
		}

		Divide(bf65, Derefof(Index(paui, 6)), Local1, Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Divide(bf65, Derefof(Index(paui, 20)), Local1, Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Divide(bf65, m601(1, 6), Local1, Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Divide(bf65, m601(1, 20), Local1, Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(bf65, Derefof(m602(1, 6, 1)), Local1, Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Divide(bf65, Derefof(m602(1, 20, 1)), Local1, Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Divide(1, bf65), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Divide(0xd650a284, bf65), Local0)
		m600(arg0, 25, Local0, 1)

		Store(Divide(aui6, bf65), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Divide(auik, bf65), Local0)
		m600(arg0, 27, Local0, 1)

		if (y078) {
			Store(Divide(Derefof(Refof(aui6)), bf65), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Divide(Derefof(Refof(auik)), bf65), Local0)
			m600(arg0, 29, Local0, 1)
		}

		Store(Divide(Derefof(Index(paui, 6)), bf65), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Divide(Derefof(Index(paui, 20)), bf65), Local0)
		m600(arg0, 31, Local0, 1)

		// Method returns Integer

		Store(Divide(m601(1, 6), bf65), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Divide(m601(1, 20), bf65), Local0)
		m600(arg0, 33, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Divide(Derefof(m602(1, 6, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Divide(Derefof(m602(1, 20, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 1)
		}

		Divide(1, bf65, Local1, Local0)
		m600(arg0, 36, Local0, 0)

		Divide(0xd650a284, bf65, Local1, Local0)
		m600(arg0, 37, Local0, 1)

		Divide(aui6, bf65, Local1, Local0)
		m600(arg0, 38, Local0, 0)

		Divide(auik, bf65, Local1, Local0)
		m600(arg0, 39, Local0, 1)

		if (y078) {
			Divide(Derefof(Refof(aui6)), bf65, Local1, Local0)
			m600(arg0, 40, Local0, 0)

			Divide(Derefof(Refof(auik)), bf65, Local1, Local0)
			m600(arg0, 41, Local0, 1)
		}

		Divide(Derefof(Index(paui, 6)), bf65, Local1, Local0)
		m600(arg0, 42, Local0, 0)

		Divide(Derefof(Index(paui, 20)), bf65, Local1, Local0)
		m600(arg0, 43, Local0, 1)

		// Method returns Integer

		Divide(m601(1, 6), bf65, Local1, Local0)
		m600(arg0, 44, Local0, 0)

		Divide(m601(1, 20), bf65, Local1, Local0)
		m600(arg0, 45, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Divide(Derefof(m602(1, 6, 1)), bf65, Local1, Local0)
			m600(arg0, 46, Local0, 0)

			Divide(Derefof(m602(1, 20, 1)), bf65, Local1, Local0)
			m600(arg0, 47, Local0, 1)
		}

		// Conversion of the both operands

		Store(Divide(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0)

		Store(Divide(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0x00447ec3)

		Divide(bf61, bf65, Local1, Local0)
		m600(arg0, 50, Local0, 0)

		Divide(bf65, bf61, Local1, Local0)
		m600(arg0, 51, Local0, 0x00447ec3)
	}

	// Mod, common 32-bit/64-bit test
	Method(m044, 1)
	{
		CreateField(b640,   0, 31, bf61)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		// Conversion of the first operand

		Store(Mod(bf61, 0x322), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Mod(bf61, 0x320), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod(bf61, auig), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Mod(bf61, auih), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Mod(bf61, Derefof(Refof(auig))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Mod(bf61, Derefof(Refof(auih))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod(bf61, Derefof(Index(paui, 16))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Mod(bf61, Derefof(Index(paui, 17))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod(bf61, m601(1, 16)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Mod(bf61, m601(1, 17)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(bf61, Derefof(m602(1, 16, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Mod(bf61, Derefof(m602(1, 17, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod(bf61, 0x322, Local0)
		m600(arg0, 12, Local0, 0x321)

		Mod(bf61, 0x320, Local0)
		m600(arg0, 13, Local0, 1)

		Mod(bf61, auig, Local0)
		m600(arg0, 14, Local0, 0x321)

		Mod(bf61, auih, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod(bf61, Derefof(Refof(auig)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Mod(bf61, Derefof(Refof(auih)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod(bf61, Derefof(Index(paui, 16)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Mod(bf61, Derefof(Index(paui, 17)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod(bf61, m601(1, 16), Local0)
		m600(arg0, 20, Local0, 0x321)

		Mod(bf61, m601(1, 17), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod(bf61, Derefof(m602(1, 16, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Mod(bf61, Derefof(m602(1, 17, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0x322, bf61), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0x320, bf61), Local0)
		m600(arg0, 25, Local0, 0x320)

		Store(Mod(auig, bf61), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auih, bf61), Local0)
		m600(arg0, 27, Local0, 0x320)

		if (y078) {
			Store(Mod(Derefof(Refof(auig)), bf61), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auih)), bf61), Local0)
			m600(arg0, 29, Local0, 0x320)
		}

		Store(Mod(Derefof(Index(paui, 16)), bf61), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 17)), bf61), Local0)
		m600(arg0, 31, Local0, 0x320)

		// Method returns Integer

		Store(Mod(m601(1, 16), bf61), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 17), bf61), Local0)
		m600(arg0, 33, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m602(1, 16, 1)), bf61), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m602(1, 17, 1)), bf61), Local0)
			m600(arg0, 35, Local0, 0x320)
		}

		Mod(0x322, bf61, Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0x320, bf61, Local0)
		m600(arg0, 37, Local0, 0x320)

		Mod(auig, bf61, Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auih, bf61, Local0)
		m600(arg0, 39, Local0, 0x320)

		if (y078) {
			Mod(Derefof(Refof(auig)), bf61, Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auih)), bf61, Local0)
			m600(arg0, 41, Local0, 0x320)
		}

		Mod(Derefof(Index(paui, 16)), bf61, Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 17)), bf61, Local0)
		m600(arg0, 43, Local0, 0x320)

		// Method returns Integer

		Mod(m601(1, 16), bf61, Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 17), bf61, Local0)
		m600(arg0, 45, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m602(1, 16, 1)), bf61, Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m602(1, 17, 1)), bf61, Local0)
			m600(arg0, 47, Local0, 0x320)
		}
	}

	// Mod, 64-bit
	Method(m045, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(Mod(bf65, 0xfe7cb391d650a285), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Mod(bf65, 0xfe7cb391d650a283), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod(bf65, auid), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Mod(bf65, auif), Local0)
		m600(arg0, 3, Local0, 1)

		if (y078) {
			Store(Mod(bf65, Derefof(Refof(auid))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Mod(bf65, Derefof(Refof(auif))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod(bf65, Derefof(Index(paui, 13))), Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		Store(Mod(bf65, Derefof(Index(paui, 15))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod(bf65, m601(1, 13)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Mod(bf65, m601(1, 15)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(bf65, Derefof(m602(1, 13, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Mod(bf65, Derefof(m602(1, 15, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod(bf65, 0xfe7cb391d650a285, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Mod(bf65, 0xfe7cb391d650a283, Local0)
		m600(arg0, 13, Local0, 1)

		Mod(bf65, auid, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Mod(bf65, auif, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod(bf65, Derefof(Refof(auid)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Mod(bf65, Derefof(Refof(auif)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod(bf65, Derefof(Index(paui, 13)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Mod(bf65, Derefof(Index(paui, 15)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod(bf65, m601(1, 13), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Mod(bf65, m601(1, 15), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod(bf65, Derefof(m602(1, 13, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Mod(bf65, Derefof(m602(1, 15, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0xfe7cb391d650a285, bf65), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0xfe7cb391d650a283, bf65), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a283)

		Store(Mod(auid, bf65), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auif, bf65), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Store(Mod(Derefof(Refof(auid)), bf65), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auif)), bf65), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a283)
		}

		Store(Mod(Derefof(Index(paui, 13)), bf65), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 15)), bf65), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Store(Mod(m601(1, 13), bf65), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 15), bf65), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m602(1, 13, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m602(1, 15, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a283)
		}

		Mod(0xfe7cb391d650a285, bf65, Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0xfe7cb391d650a283, bf65, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a283)

		Mod(auid, bf65, Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auif, bf65, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Mod(Derefof(Refof(auid)), bf65, Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auif)), bf65, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a283)
		}

		Mod(Derefof(Index(paui, 13)), bf65, Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 15)), bf65, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Mod(m601(1, 13), bf65, Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 15), bf65, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m602(1, 13, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m602(1, 15, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a283)
		}

		// Conversion of the both operands

		Store(Mod(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0x321)

		Store(Mod(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0x2fd)

		Mod(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0x321)

		Mod(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0x2fd)
	}

	// Mod, 32-bit
	Method(m046, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(Mod(bf65, 0xd650a285), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Mod(bf65, 0xd650a283), Local0)
		m600(arg0, 1, Local0, 1)

		Store(Mod(bf65, auil), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Mod(bf65, auim), Local0)
		m600(arg0, 14, Local0, 1)

		if (y078) {
			Store(Mod(bf65, Derefof(Refof(auil))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Mod(bf65, Derefof(Refof(auim))), Local0)
			m600(arg0, 5, Local0, 1)
		}

		Store(Mod(bf65, Derefof(Index(paui, 21))), Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Store(Mod(bf65, Derefof(Index(paui, 22))), Local0)
		m600(arg0, 7, Local0, 1)

		// Method returns Integer

		Store(Mod(bf65, m601(1, 21)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Mod(bf65, m601(1, 22)), Local0)
		m600(arg0, 9, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(bf65, Derefof(m601(1, 21, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Mod(bf65, Derefof(m601(1, 22, 1))), Local0)
			m600(arg0, 11, Local0, 1)
		}

		Mod(bf65, 0xd650a285, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Mod(bf65, 0xd650a283, Local0)
		m600(arg0, 13, Local0, 1)

		Mod(bf65, auil, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Mod(bf65, auim, Local0)
		m600(arg0, 15, Local0, 1)

		if (y078) {
			Mod(bf65, Derefof(Refof(auil)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Mod(bf65, Derefof(Refof(auim)), Local0)
			m600(arg0, 17, Local0, 1)
		}

		Mod(bf65, Derefof(Index(paui, 21)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Mod(bf65, Derefof(Index(paui, 22)), Local0)
		m600(arg0, 19, Local0, 1)

		// Method returns Integer

		Mod(bf65, m601(1, 21), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Mod(bf65, m601(1, 22), Local0)
		m600(arg0, 21, Local0, 1)

		// Method returns Reference to Integer

		if (y500) {
			Mod(bf65, Derefof(m601(1, 21, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Mod(bf65, Derefof(m601(1, 22, 1)), Local0)
			m600(arg0, 23, Local0, 1)
		}

		// Conversion of the second operand

		Store(Mod(0xd650a285, bf65), Local0)
		m600(arg0, 24, Local0, 1)

		Store(Mod(0xd650a283, bf65), Local0)
		m600(arg0, 25, Local0, 0xd650a283)

		Store(Mod(auil, bf65), Local0)
		m600(arg0, 26, Local0, 1)

		Store(Mod(auim, bf65), Local0)
		m600(arg0, 27, Local0, 0xd650a283)

		if (y078) {
			Store(Mod(Derefof(Refof(auil)), bf65), Local0)
			m600(arg0, 28, Local0, 1)

			Store(Mod(Derefof(Refof(auim)), bf65), Local0)
			m600(arg0, 29, Local0, 0xd650a283)
		}

		Store(Mod(Derefof(Index(paui, 21)), bf65), Local0)
		m600(arg0, 30, Local0, 1)

		Store(Mod(Derefof(Index(paui, 22)), bf65), Local0)
		m600(arg0, 31, Local0, 0xd650a283)

		// Method returns Integer

		Store(Mod(m601(1, 21), bf65), Local0)
		m600(arg0, 32, Local0, 1)

		Store(Mod(m601(1, 22), bf65), Local0)
		m600(arg0, 33, Local0, 0xd650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Mod(Derefof(m601(1, 21, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 1)

			Store(Mod(Derefof(m601(1, 22, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0xd650a283)
		}

		Mod(0xd650a285, bf65, Local0)
		m600(arg0, 36, Local0, 1)

		Mod(0xd650a283, bf65, Local0)
		m600(arg0, 37, Local0, 0xd650a283)

		Mod(auil, bf65, Local0)
		m600(arg0, 38, Local0, 1)

		Mod(auim, bf65, Local0)
		m600(arg0, 39, Local0, 0xd650a283)

		if (y078) {
			Mod(Derefof(Refof(auil)), bf65, Local0)
			m600(arg0, 40, Local0, 1)

			Mod(Derefof(Refof(auim)), bf65, Local0)
			m600(arg0, 41, Local0, 0xd650a283)
		}

		Mod(Derefof(Index(paui, 21)), bf65, Local0)
		m600(arg0, 42, Local0, 1)

		Mod(Derefof(Index(paui, 22)), bf65, Local0)
		m600(arg0, 43, Local0, 0xd650a283)

		// Method returns Integer

		Mod(m601(1, 21), bf65, Local0)
		m600(arg0, 44, Local0, 1)

		Mod(m601(1, 22), bf65, Local0)
		m600(arg0, 45, Local0, 0xd650a283)

		// Method returns Reference to Integer

		if (y500) {
			Mod(Derefof(m601(1, 21, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 1)

			Mod(Derefof(m601(1, 22, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0xd650a283)
		}

		// Conversion of the both operands

		Store(Mod(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0x321)

		Store(Mod(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0x261)

		Mod(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0x321)

		Mod(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0x261)
	}

	// Multiply, common 32-bit/64-bit test
	Method(m047, 1)
	{
		CreateField(b640,   0, 31, bf61)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)

		// Conversion of the first operand

		Store(Multiply(bf61, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply(bf61, 1), Local0)
		m600(arg0, 1, Local0, 0x321)

		Store(Multiply(bf61, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply(bf61, aui6), Local0)
		m600(arg0, 3, Local0, 0x321)

		if (y078) {
			Store(Multiply(bf61, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply(bf61, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x321)
		}

		Store(Multiply(bf61, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply(bf61, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x321)

		// Method returns Integer

		Store(Multiply(bf61, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply(bf61, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(bf61, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply(bf61, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x321)
		}

		Multiply(bf61, 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply(bf61, 1, Local0)
		m600(arg0, 13, Local0, 0x321)

		Multiply(bf61, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply(bf61, aui6, Local0)
		m600(arg0, 15, Local0, 0x321)

		if (y078) {
			Multiply(bf61, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply(bf61, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x321)
		}

		Multiply(bf61, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply(bf61, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x321)

		// Method returns Integer

		Multiply(bf61, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply(bf61, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(bf61, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply(bf61, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x321)
		}

		// Conversion of the second operand

		Store(Multiply(0, bf61), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, bf61), Local0)
		m600(arg0, 25, Local0, 0x321)

		Store(Multiply(aui5, bf61), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, bf61), Local0)
		m600(arg0, 27, Local0, 0x321)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), bf61), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), bf61), Local0)
			m600(arg0, 29, Local0, 0x321)
		}

		Store(Multiply(Derefof(Index(paui, 5)), bf61), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), bf61), Local0)
		m600(arg0, 31, Local0, 0x321)

		// Method returns Integer

		Store(Multiply(m601(1, 5), bf61), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), bf61), Local0)
		m600(arg0, 33, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), bf61), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), bf61), Local0)
			m600(arg0, 35, Local0, 0x321)
		}

		Multiply(0, bf61, Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, bf61, Local0)
		m600(arg0, 37, Local0, 0x321)

		Multiply(aui5, bf61, Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, bf61, Local0)
		m600(arg0, 39, Local0, 0x321)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), bf61, Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), bf61, Local0)
			m600(arg0, 41, Local0, 0x321)
		}

		Multiply(Derefof(Index(paui, 5)), bf61, Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), bf61, Local0)
		m600(arg0, 43, Local0, 0x321)

		// Method returns Integer

		Multiply(m601(1, 5), bf61, Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), bf61, Local0)
		m600(arg0, 45, Local0, 0x321)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), bf61, Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), bf61, Local0)
			m600(arg0, 47, Local0, 0x321)
		}
	}

	// Multiply, 64-bit
	Method(m048, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(Multiply(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply(bf65, 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a284)

		Store(Multiply(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply(bf65, aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(Multiply(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a284)
		}

		Store(Multiply(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(Multiply(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a284)
		}

		Multiply(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply(bf65, 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a284)

		Multiply(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply(bf65, aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Multiply(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply(bf65, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a284)
		}

		Multiply(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply(bf65, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Multiply(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply(bf65, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply(bf65, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the second operand

		Store(Multiply(0, bf65), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, bf65), Local0)
		m600(arg0, 25, Local0, 0xfe7cb391d650a284)

		Store(Multiply(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, bf65), Local0)
		m600(arg0, 27, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), bf65), Local0)
			m600(arg0, 29, Local0, 0xfe7cb391d650a284)
		}

		Store(Multiply(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), bf65), Local0)
		m600(arg0, 31, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Store(Multiply(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), bf65), Local0)
		m600(arg0, 33, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0xfe7cb391d650a284)
		}

		Multiply(0, bf65, Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, bf65, Local0)
		m600(arg0, 37, Local0, 0xfe7cb391d650a284)

		Multiply(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, bf65, Local0)
		m600(arg0, 39, Local0, 0xfe7cb391d650a284)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), bf65, Local0)
			m600(arg0, 41, Local0, 0xfe7cb391d650a284)
		}

		Multiply(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), bf65, Local0)
		m600(arg0, 43, Local0, 0xfe7cb391d650a284)

		// Method returns Integer

		Multiply(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), bf65, Local0)
		m600(arg0, 45, Local0, 0xfe7cb391d650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0xfe7cb391d650a284)
		}

		// Conversion of the both operands

		Store(Multiply(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0x442ddb4f924c7f04)

		Store(Multiply(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0x442ddb4f924c7f04)

		Multiply(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0x442ddb4f924c7f04)

		Multiply(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0x442ddb4f924c7f04)
	}

	// Multiply, 32-bit
	Method(m049, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(Multiply(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0)

		Store(Multiply(bf65, 1), Local0)
		m600(arg0, 1, Local0, 0xd650a284)

		Store(Multiply(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0)

		Store(Multiply(bf65, aui6), Local0)
		m600(arg0, 3, Local0, 0xd650a284)

		if (y078) {
			Store(Multiply(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0)

			Store(Multiply(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xd650a284)
		}

		Store(Multiply(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0)

		Store(Multiply(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xd650a284)

		// Method returns Integer

		Store(Multiply(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0)

		Store(Multiply(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0)

			Store(Multiply(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xd650a284)
		}

		Multiply(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0)

		Multiply(bf65, 1, Local0)
		m600(arg0, 13, Local0, 0xd650a284)

		Multiply(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0)

		Multiply(bf65, aui6, Local0)
		m600(arg0, 15, Local0, 0xd650a284)

		if (y078) {
			Multiply(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0)

			Multiply(bf65, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xd650a284)
		}

		Multiply(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0)

		Multiply(bf65, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xd650a284)

		// Method returns Integer

		Multiply(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0)

		Multiply(bf65, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0)

			Multiply(bf65, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xd650a284)
		}

		// Conversion of the second operand

		Store(Multiply(0, bf65), Local0)
		m600(arg0, 24, Local0, 0)

		Store(Multiply(1, bf65), Local0)
		m600(arg0, 25, Local0, 0xd650a284)

		Store(Multiply(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0)

		Store(Multiply(aui6, bf65), Local0)
		m600(arg0, 27, Local0, 0xd650a284)

		if (y078) {
			Store(Multiply(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0)

			Store(Multiply(Derefof(Refof(aui6)), bf65), Local0)
			m600(arg0, 29, Local0, 0xd650a284)
		}

		Store(Multiply(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0)

		Store(Multiply(Derefof(Index(paui, 6)), bf65), Local0)
		m600(arg0, 31, Local0, 0xd650a284)

		// Method returns Integer

		Store(Multiply(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0)

		Store(Multiply(m601(1, 6), bf65), Local0)
		m600(arg0, 33, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Store(Multiply(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0)

			Store(Multiply(Derefof(m602(1, 6, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0xd650a284)
		}

		Multiply(0, bf65, Local0)
		m600(arg0, 36, Local0, 0)

		Multiply(1, bf65, Local0)
		m600(arg0, 37, Local0, 0xd650a284)

		Multiply(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0)

		Multiply(aui6, bf65, Local0)
		m600(arg0, 39, Local0, 0xd650a284)

		if (y078) {
			Multiply(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0)

			Multiply(Derefof(Refof(aui6)), bf65, Local0)
			m600(arg0, 41, Local0, 0xd650a284)
		}

		Multiply(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0)

		Multiply(Derefof(Index(paui, 6)), bf65, Local0)
		m600(arg0, 43, Local0, 0xd650a284)

		// Method returns Integer

		Multiply(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0)

		Multiply(m601(1, 6), bf65, Local0)
		m600(arg0, 45, Local0, 0xd650a284)

		// Method returns Reference to Integer

		if (y500) {
			Multiply(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0)

			Multiply(Derefof(m602(1, 6, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0xd650a284)
		}

		// Conversion of the both operands

		Store(Multiply(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0x924c7f04)

		Store(Multiply(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0x924c7f04)

		Multiply(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0x924c7f04)

		Multiply(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0x924c7f04)
	}

	// NAnd, common 32-bit/64-bit test
	Method(m04a, 1)
	{
		CreateField(b640,   0, 31, bf61)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)

		// Conversion of the first operand

		Store(NAnd(bf61, 0), Local0)
		m600(arg0, 0, Local0, 0xffffffffffffffff)

		Store(NAnd(bf61, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfffffffffffffcde)

		Store(NAnd(bf61, aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffffffffffff)

		Store(NAnd(bf61, auij), Local0)
		m600(arg0, 3, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(NAnd(bf61, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffffffffffff)

			Store(NAnd(bf61, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfffffffffffffcde)
		}

		Store(NAnd(bf61, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffffffffffff)

		Store(NAnd(bf61, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(NAnd(bf61, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffffffffffff)

		Store(NAnd(bf61, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(bf61, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffffffffffff)

			Store(NAnd(bf61, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfffffffffffffcde)
		}

		NAnd(bf61, 0, Local0)
		m600(arg0, 12, Local0, 0xffffffffffffffff)

		NAnd(bf61, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfffffffffffffcde)

		NAnd(bf61, aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffffffffffff)

		NAnd(bf61, auij, Local0)
		m600(arg0, 15, Local0, 0xfffffffffffffcde)

		if (y078) {
			NAnd(bf61, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffffffffffff)

			NAnd(bf61, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfffffffffffffcde)
		}

		NAnd(bf61, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffffffffffff)

		NAnd(bf61, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		NAnd(bf61, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffffffffffff)

		NAnd(bf61, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(bf61, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffffffffffff)

			NAnd(bf61, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfffffffffffffcde)
		}

		// Conversion of the second operand

		Store(NAnd(0, bf61), Local0)
		m600(arg0, 24, Local0, 0xffffffffffffffff)

		Store(NAnd(0xffffffffffffffff, bf61), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffcde)

		Store(NAnd(aui5, bf61), Local0)
		m600(arg0, 26, Local0, 0xffffffffffffffff)

		Store(NAnd(auij, bf61), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), bf61), Local0)
			m600(arg0, 28, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(Refof(auij)), bf61), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffcde)
		}

		Store(NAnd(Derefof(Index(paui, 5)), bf61), Local0)
		m600(arg0, 30, Local0, 0xffffffffffffffff)

		Store(NAnd(Derefof(Index(paui, 19)), bf61), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(NAnd(m601(1, 5), bf61), Local0)
		m600(arg0, 32, Local0, 0xffffffffffffffff)

		Store(NAnd(m601(1, 19), bf61), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), bf61), Local0)
			m600(arg0, 34, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(m602(1, 19, 1)), bf61), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffcde)
		}

		NAnd(0, bf61, Local0)
		m600(arg0, 36, Local0, 0xffffffffffffffff)

		NAnd(0xffffffffffffffff, bf61, Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffcde)

		NAnd(aui5, bf61, Local0)
		m600(arg0, 38, Local0, 0xffffffffffffffff)

		NAnd(auij, bf61, Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffcde)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), bf61, Local0)
			m600(arg0, 40, Local0, 0xffffffffffffffff)

			NAnd(Derefof(Refof(auij)), bf61, Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffcde)
		}

		NAnd(Derefof(Index(paui, 5)), bf61, Local0)
		m600(arg0, 42, Local0, 0xffffffffffffffff)

		NAnd(Derefof(Index(paui, 19)), bf61, Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		NAnd(m601(1, 5), bf61, Local0)
		m600(arg0, 44, Local0, 0xffffffffffffffff)

		NAnd(m601(1, 19), bf61, Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), bf61, Local0)
			m600(arg0, 46, Local0, 0xffffffffffffffff)

			NAnd(Derefof(m602(1, 19, 1)), bf61, Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffcde)
		}
	}

	// NAnd, 64-bit
	Method(m04b, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(NAnd(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xffffffffffffffff)

		Store(NAnd(bf65, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x01834c6e29af5d7b)

		Store(NAnd(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffffffffffff)

		Store(NAnd(bf65, auij), Local0)
		m600(arg0, 3, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(NAnd(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffffffffffff)

			Store(NAnd(bf65, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x01834c6e29af5d7b)
		}

		Store(NAnd(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffffffffffff)

		Store(NAnd(bf65, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(NAnd(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffffffffffff)

		Store(NAnd(bf65, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffffffffffff)

			Store(NAnd(bf65, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xffffffffffffffff)

		NAnd(bf65, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x01834c6e29af5d7b)

		NAnd(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffffffffffff)

		NAnd(bf65, auij, Local0)
		m600(arg0, 15, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			NAnd(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffffffffffff)

			NAnd(bf65, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffffffffffff)

		NAnd(bf65, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		NAnd(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffffffffffff)

		NAnd(bf65, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffffffffffff)

			NAnd(bf65, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the second operand

		Store(NAnd(0, bf65), Local0)
		m600(arg0, 24, Local0, 0xffffffffffffffff)

		Store(NAnd(0xffffffffffffffff, bf65), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7b)

		Store(NAnd(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0xffffffffffffffff)

		Store(NAnd(auij, bf65), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(Refof(auij)), bf65), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7b)
		}

		Store(NAnd(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0xffffffffffffffff)

		Store(NAnd(Derefof(Index(paui, 19)), bf65), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(NAnd(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0xffffffffffffffff)

		Store(NAnd(m601(1, 19), bf65), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0xffffffffffffffff)

			Store(NAnd(Derefof(m602(1, 19, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(0, bf65, Local0)
		m600(arg0, 36, Local0, 0xffffffffffffffff)

		NAnd(0xffffffffffffffff, bf65, Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7b)

		NAnd(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0xffffffffffffffff)

		NAnd(auij, bf65, Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0xffffffffffffffff)

			NAnd(Derefof(Refof(auij)), bf65, Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7b)
		}

		NAnd(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0xffffffffffffffff)

		NAnd(Derefof(Index(paui, 19)), bf65, Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		NAnd(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0xffffffffffffffff)

		NAnd(m601(1, 19), bf65, Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0xffffffffffffffff)

			NAnd(Derefof(m602(1, 19, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the both operands

		Store(NAnd(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0xfffffffffffffdff)

		Store(NAnd(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0xfffffffffffffdff)

		NAnd(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0xfffffffffffffdff)

		NAnd(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0xfffffffffffffdff)
	}

	// NAnd, 32-bit
	Method(m04c, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(NAnd(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xffffffff)

		Store(NAnd(bf65, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0x29af5d7b)

		Store(NAnd(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xffffffff)

		Store(NAnd(bf65, auii), Local0)
		m600(arg0, 3, Local0, 0x29af5d7b)

		if (y078) {
			Store(NAnd(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xffffffff)

			Store(NAnd(bf65, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0x29af5d7b)
		}

		Store(NAnd(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xffffffff)

		Store(NAnd(bf65, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0x29af5d7b)

		// Method returns Integer

		Store(NAnd(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xffffffff)

		Store(NAnd(bf65, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xffffffff)

			Store(NAnd(bf65, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0x29af5d7b)
		}

		NAnd(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xffffffff)

		NAnd(bf65, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0x29af5d7b)

		NAnd(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xffffffff)

		NAnd(bf65, auii, Local0)
		m600(arg0, 15, Local0, 0x29af5d7b)

		if (y078) {
			NAnd(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xffffffff)

			NAnd(bf65, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0x29af5d7b)
		}

		NAnd(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xffffffff)

		NAnd(bf65, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0x29af5d7b)

		// Method returns Integer

		NAnd(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xffffffff)

		NAnd(bf65, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xffffffff)

			NAnd(bf65, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0x29af5d7b)
		}

		// Conversion of the second operand

		Store(NAnd(0, bf65), Local0)
		m600(arg0, 24, Local0, 0xffffffff)

		Store(NAnd(0xffffffff, bf65), Local0)
		m600(arg0, 25, Local0, 0x29af5d7b)

		Store(NAnd(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0xffffffff)

		Store(NAnd(auii, bf65), Local0)
		m600(arg0, 27, Local0, 0x29af5d7b)

		if (y078) {
			Store(NAnd(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0xffffffff)

			Store(NAnd(Derefof(Refof(auii)), bf65), Local0)
			m600(arg0, 29, Local0, 0x29af5d7b)
		}

		Store(NAnd(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0xffffffff)

		Store(NAnd(Derefof(Index(paui, 18)), bf65), Local0)
		m600(arg0, 31, Local0, 0x29af5d7b)

		// Method returns Integer

		Store(NAnd(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0xffffffff)

		Store(NAnd(m601(1, 18), bf65), Local0)
		m600(arg0, 33, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(NAnd(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0xffffffff)

			Store(NAnd(Derefof(m602(1, 18, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0x29af5d7b)
		}

		NAnd(0, bf65, Local0)
		m600(arg0, 36, Local0, 0xffffffff)

		NAnd(0xffffffff, bf65, Local0)
		m600(arg0, 37, Local0, 0x29af5d7b)

		NAnd(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0xffffffff)

		NAnd(auii, bf65, Local0)
		m600(arg0, 39, Local0, 0x29af5d7b)

		if (y078) {
			NAnd(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0xffffffff)

			NAnd(Derefof(Refof(auii)), bf65, Local0)
			m600(arg0, 41, Local0, 0x29af5d7b)
		}

		NAnd(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0xffffffff)

		NAnd(Derefof(Index(paui, 18)), bf65, Local0)
		m600(arg0, 43, Local0, 0x29af5d7b)

		// Method returns Integer

		NAnd(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0xffffffff)

		NAnd(m601(1, 18), bf65, Local0)
		m600(arg0, 45, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			NAnd(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0xffffffff)

			NAnd(Derefof(m602(1, 18, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0x29af5d7b)
		}

		// Conversion of the both operands

		Store(NAnd(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0xfffffdff)

		Store(NAnd(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0xfffffdff)

		NAnd(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0xfffffdff)

		NAnd(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0xfffffdff)
	}

	// NOr, common 32-bit/64-bit test
	Method(m04d, 1)
	{
		CreateField(b640,   0, 31, bf61)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)

		// Conversion of the first operand

		Store(NOr(bf61, 0), Local0)
		m600(arg0, 0, Local0, 0xfffffffffffffcde)

		Store(NOr(bf61, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr(bf61, aui5), Local0)
		m600(arg0, 2, Local0, 0xfffffffffffffcde)

		Store(NOr(bf61, auij), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr(bf61, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfffffffffffffcde)

			Store(NOr(bf61, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr(bf61, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfffffffffffffcde)

		Store(NOr(bf61, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr(bf61, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfffffffffffffcde)

		Store(NOr(bf61, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(bf61, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfffffffffffffcde)

			Store(NOr(bf61, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr(bf61, 0, Local0)
		m600(arg0, 12, Local0, 0xfffffffffffffcde)

		NOr(bf61, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr(bf61, aui5, Local0)
		m600(arg0, 14, Local0, 0xfffffffffffffcde)

		NOr(bf61, auij, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr(bf61, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfffffffffffffcde)

			NOr(bf61, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr(bf61, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfffffffffffffcde)

		NOr(bf61, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr(bf61, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfffffffffffffcde)

		NOr(bf61, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(bf61, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfffffffffffffcde)

			NOr(bf61, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, bf61), Local0)
		m600(arg0, 24, Local0, 0xfffffffffffffcde)

		Store(NOr(0xffffffffffffffff, bf61), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, bf61), Local0)
		m600(arg0, 26, Local0, 0xfffffffffffffcde)

		Store(NOr(auij, bf61), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), bf61), Local0)
			m600(arg0, 28, Local0, 0xfffffffffffffcde)

			Store(NOr(Derefof(Refof(auij)), bf61), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), bf61), Local0)
		m600(arg0, 30, Local0, 0xfffffffffffffcde)

		Store(NOr(Derefof(Index(paui, 19)), bf61), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), bf61), Local0)
		m600(arg0, 32, Local0, 0xfffffffffffffcde)

		Store(NOr(m601(1, 19), bf61), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), bf61), Local0)
			m600(arg0, 34, Local0, 0xfffffffffffffcde)

			Store(NOr(Derefof(m602(1, 19, 1)), bf61), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, bf61, Local0)
		m600(arg0, 36, Local0, 0xfffffffffffffcde)

		NOr(0xffffffffffffffff, bf61, Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, bf61, Local0)
		m600(arg0, 38, Local0, 0xfffffffffffffcde)

		NOr(auij, bf61, Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), bf61, Local0)
			m600(arg0, 40, Local0, 0xfffffffffffffcde)

			NOr(Derefof(Refof(auij)), bf61, Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), bf61, Local0)
		m600(arg0, 42, Local0, 0xfffffffffffffcde)

		NOr(Derefof(Index(paui, 19)), bf61, Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), bf61, Local0)
		m600(arg0, 44, Local0, 0xfffffffffffffcde)

		NOr(m601(1, 19), bf61, Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), bf61, Local0)
			m600(arg0, 46, Local0, 0xfffffffffffffcde)

			NOr(Derefof(m602(1, 19, 1)), bf61, Local0)
			m600(arg0, 47, Local0, 0)
		}
	}

	// NOr, 64-bit
	Method(m04e, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(NOr(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0x01834c6e29af5d7b)

		Store(NOr(bf65, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0x01834c6e29af5d7b)

		Store(NOr(bf65, auij), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x01834c6e29af5d7b)

			Store(NOr(bf65, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x01834c6e29af5d7b)

		Store(NOr(bf65, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x01834c6e29af5d7b)

		Store(NOr(bf65, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x01834c6e29af5d7b)

			Store(NOr(bf65, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0x01834c6e29af5d7b)

		NOr(bf65, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0x01834c6e29af5d7b)

		NOr(bf65, auij, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x01834c6e29af5d7b)

			NOr(bf65, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x01834c6e29af5d7b)

		NOr(bf65, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x01834c6e29af5d7b)

		NOr(bf65, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x01834c6e29af5d7b)

			NOr(bf65, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, bf65), Local0)
		m600(arg0, 24, Local0, 0x01834c6e29af5d7b)

		Store(NOr(0xffffffffffffffff, bf65), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0x01834c6e29af5d7b)

		Store(NOr(auij, bf65), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0x01834c6e29af5d7b)

			Store(NOr(Derefof(Refof(auij)), bf65), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0x01834c6e29af5d7b)

		Store(NOr(Derefof(Index(paui, 19)), bf65), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0x01834c6e29af5d7b)

		Store(NOr(m601(1, 19), bf65), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0x01834c6e29af5d7b)

			Store(NOr(Derefof(m602(1, 19, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, bf65, Local0)
		m600(arg0, 36, Local0, 0x01834c6e29af5d7b)

		NOr(0xffffffffffffffff, bf65, Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0x01834c6e29af5d7b)

		NOr(auij, bf65, Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0x01834c6e29af5d7b)

			NOr(Derefof(Refof(auij)), bf65, Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0x01834c6e29af5d7b)

		NOr(Derefof(Index(paui, 19)), bf65, Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0x01834c6e29af5d7b)

		NOr(m601(1, 19), bf65, Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0x01834c6e29af5d7b)

			NOr(Derefof(m602(1, 19, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0)
		}

		// Conversion of the both operands

		Store(NOr(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0x01834c6e29af5c5a)

		Store(NOr(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0x01834c6e29af5c5a)

		NOr(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0x01834c6e29af5c5a)

		NOr(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0x01834c6e29af5c5a)
	}

	// NOr, 32-bit
	Method(m04f, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(NOr(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0x29af5d7b)

		Store(NOr(bf65, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0)

		Store(NOr(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0x29af5d7b)

		Store(NOr(bf65, auii), Local0)
		m600(arg0, 3, Local0, 0)

		if (y078) {
			Store(NOr(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x29af5d7b)

			Store(NOr(bf65, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0)
		}

		Store(NOr(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x29af5d7b)

		Store(NOr(bf65, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0)

		// Method returns Integer

		Store(NOr(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x29af5d7b)

		Store(NOr(bf65, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x29af5d7b)

			Store(NOr(bf65, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0)
		}

		NOr(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0x29af5d7b)

		NOr(bf65, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0)

		NOr(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0x29af5d7b)

		NOr(bf65, auii, Local0)
		m600(arg0, 15, Local0, 0)

		if (y078) {
			NOr(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x29af5d7b)

			NOr(bf65, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0)
		}

		NOr(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x29af5d7b)

		NOr(bf65, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0)

		// Method returns Integer

		NOr(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x29af5d7b)

		NOr(bf65, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x29af5d7b)

			NOr(bf65, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0)
		}

		// Conversion of the second operand

		Store(NOr(0, bf65), Local0)
		m600(arg0, 24, Local0, 0x29af5d7b)

		Store(NOr(0xffffffff, bf65), Local0)
		m600(arg0, 25, Local0, 0)

		Store(NOr(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0x29af5d7b)

		Store(NOr(auii, bf65), Local0)
		m600(arg0, 27, Local0, 0)

		if (y078) {
			Store(NOr(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0x29af5d7b)

			Store(NOr(Derefof(Refof(auii)), bf65), Local0)
			m600(arg0, 29, Local0, 0)
		}

		Store(NOr(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0x29af5d7b)

		Store(NOr(Derefof(Index(paui, 18)), bf65), Local0)
		m600(arg0, 31, Local0, 0)

		// Method returns Integer

		Store(NOr(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0x29af5d7b)

		Store(NOr(m601(1, 18), bf65), Local0)
		m600(arg0, 33, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			Store(NOr(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0x29af5d7b)

			Store(NOr(Derefof(m602(1, 18, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0)
		}

		NOr(0, bf65, Local0)
		m600(arg0, 36, Local0, 0x29af5d7b)

		NOr(0xffffffff, bf65, Local0)
		m600(arg0, 37, Local0, 0)

		NOr(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0x29af5d7b)

		NOr(auii, bf65, Local0)
		m600(arg0, 39, Local0, 0)

		if (y078) {
			NOr(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0x29af5d7b)

			NOr(Derefof(Refof(auii)), bf65, Local0)
			m600(arg0, 41, Local0, 0)
		}

		NOr(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0x29af5d7b)

		NOr(Derefof(Index(paui, 18)), bf65, Local0)
		m600(arg0, 43, Local0, 0)

		// Method returns Integer

		NOr(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0x29af5d7b)

		NOr(m601(1, 18), bf65, Local0)
		m600(arg0, 45, Local0, 0)

		// Method returns Reference to Integer

		if (y500) {
			NOr(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0x29af5d7b)

			NOr(Derefof(m602(1, 18, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0)
		}

		// Conversion of the both operands

		Store(NOr(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0x29af5c5a)

		Store(NOr(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0x29af5c5a)

		NOr(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0x29af5c5a)

		NOr(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0x29af5c5a)
	}

	// Or, common 32-bit/64-bit test
	Method(m050, 1)
	{
		CreateField(b640,   0, 31, bf61)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)

		// Conversion of the first operand

		Store(Or(bf61, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Or(bf61, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffffffffffff)

		Store(Or(bf61, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Or(bf61, auij), Local0)
		m600(arg0, 3, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(bf61, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Or(bf61, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xffffffffffffffff)
		}

		Store(Or(bf61, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Or(bf61, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(bf61, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Or(bf61, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(bf61, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Or(bf61, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffffffffffff)
		}

		Or(bf61, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Or(bf61, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffffffffffff)

		Or(bf61, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Or(bf61, auij, Local0)
		m600(arg0, 15, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(bf61, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Or(bf61, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xffffffffffffffff)
		}

		Or(bf61, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Or(bf61, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(bf61, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Or(bf61, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(bf61, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Or(bf61, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffffffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, bf61), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(Or(0xffffffffffffffff, bf61), Local0)
		m600(arg0, 25, Local0, 0xffffffffffffffff)

		Store(Or(aui5, bf61), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(Or(auij, bf61), Local0)
		m600(arg0, 27, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), bf61), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(Or(Derefof(Refof(auij)), bf61), Local0)
			m600(arg0, 29, Local0, 0xffffffffffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), bf61), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(Or(Derefof(Index(paui, 19)), bf61), Local0)
		m600(arg0, 31, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), bf61), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(Or(m601(1, 19), bf61), Local0)
		m600(arg0, 33, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), bf61), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(Or(Derefof(m602(1, 19, 1)), bf61), Local0)
			m600(arg0, 35, Local0, 0xffffffffffffffff)
		}

		Or(0, bf61, Local0)
		m600(arg0, 36, Local0, 0x321)

		Or(0xffffffffffffffff, bf61, Local0)
		m600(arg0, 37, Local0, 0xffffffffffffffff)

		Or(aui5, bf61, Local0)
		m600(arg0, 38, Local0, 0x321)

		Or(auij, bf61, Local0)
		m600(arg0, 39, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), bf61, Local0)
			m600(arg0, 40, Local0, 0x321)

			Or(Derefof(Refof(auij)), bf61, Local0)
			m600(arg0, 41, Local0, 0xffffffffffffffff)
		}

		Or(Derefof(Index(paui, 5)), bf61, Local0)
		m600(arg0, 42, Local0, 0x321)

		Or(Derefof(Index(paui, 19)), bf61, Local0)
		m600(arg0, 43, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(m601(1, 5), bf61, Local0)
		m600(arg0, 44, Local0, 0x321)

		Or(m601(1, 19), bf61, Local0)
		m600(arg0, 45, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), bf61, Local0)
			m600(arg0, 46, Local0, 0x321)

			Or(Derefof(m602(1, 19, 1)), bf61, Local0)
			m600(arg0, 47, Local0, 0xffffffffffffffff)
		}
	}

	// Or, 64-bit
	Method(m051, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(Or(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Or(bf65, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffffffffffff)

		Store(Or(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Or(bf65, auij), Local0)
		m600(arg0, 3, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Or(bf65, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xffffffffffffffff)
		}

		Store(Or(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Or(bf65, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Or(bf65, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Or(bf65, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffffffffffff)
		}

		Or(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Or(bf65, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffffffffffff)

		Or(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Or(bf65, auij, Local0)
		m600(arg0, 15, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Or(bf65, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xffffffffffffffff)
		}

		Or(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Or(bf65, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Or(bf65, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Or(bf65, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffffffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, bf65), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(Or(0xffffffffffffffff, bf65), Local0)
		m600(arg0, 25, Local0, 0xffffffffffffffff)

		Store(Or(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(Or(auij, bf65), Local0)
		m600(arg0, 27, Local0, 0xffffffffffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(Or(Derefof(Refof(auij)), bf65), Local0)
			m600(arg0, 29, Local0, 0xffffffffffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(Or(Derefof(Index(paui, 19)), bf65), Local0)
		m600(arg0, 31, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(Or(m601(1, 19), bf65), Local0)
		m600(arg0, 33, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(Or(Derefof(m602(1, 19, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0xffffffffffffffff)
		}

		Or(0, bf65, Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		Or(0xffffffffffffffff, bf65, Local0)
		m600(arg0, 37, Local0, 0xffffffffffffffff)

		Or(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		Or(auij, bf65, Local0)
		m600(arg0, 39, Local0, 0xffffffffffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			Or(Derefof(Refof(auij)), bf65, Local0)
			m600(arg0, 41, Local0, 0xffffffffffffffff)
		}

		Or(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		Or(Derefof(Index(paui, 19)), bf65, Local0)
		m600(arg0, 43, Local0, 0xffffffffffffffff)

		// Method returns Integer

		Or(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		Or(m601(1, 19), bf65, Local0)
		m600(arg0, 45, Local0, 0xffffffffffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			Or(Derefof(m602(1, 19, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0xffffffffffffffff)
		}

		// Conversion of the both operands

		Store(Or(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a3a5)

		Store(Or(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a3a5)

		Or(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a3a5)

		Or(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a3a5)
	}

	// Or, 32-bit
	Method(m052, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(Or(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Or(bf65, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0xffffffff)

		Store(Or(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Or(bf65, auii), Local0)
		m600(arg0, 3, Local0, 0xffffffff)

		if (y078) {
			Store(Or(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Or(bf65, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0xffffffff)
		}

		Store(Or(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(Or(bf65, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0xffffffff)

		// Method returns Integer

		Store(Or(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Or(bf65, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Or(bf65, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0xffffffff)
		}

		Or(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Or(bf65, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0xffffffff)

		Or(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Or(bf65, auii, Local0)
		m600(arg0, 15, Local0, 0xffffffff)

		if (y078) {
			Or(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Or(bf65, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0xffffffff)
		}

		Or(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Or(bf65, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0xffffffff)

		// Method returns Integer

		Or(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Or(bf65, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Or(bf65, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0xffffffff)
		}

		// Conversion of the second operand

		Store(Or(0, bf65), Local0)
		m600(arg0, 24, Local0, 0xd650a284)

		Store(Or(0xffffffff, bf65), Local0)
		m600(arg0, 25, Local0, 0xffffffff)

		Store(Or(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0xd650a284)

		Store(Or(auii, bf65), Local0)
		m600(arg0, 27, Local0, 0xffffffff)

		if (y078) {
			Store(Or(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0xd650a284)

			Store(Or(Derefof(Refof(auii)), bf65), Local0)
			m600(arg0, 29, Local0, 0xffffffff)
		}

		Store(Or(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0xd650a284)

		Store(Or(Derefof(Index(paui, 18)), bf65), Local0)
		m600(arg0, 31, Local0, 0xffffffff)

		// Method returns Integer

		Store(Or(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0xd650a284)

		Store(Or(m601(1, 18), bf65), Local0)
		m600(arg0, 33, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Store(Or(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0xd650a284)

			Store(Or(Derefof(m602(1, 18, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0xffffffff)
		}

		Or(0, bf65, Local0)
		m600(arg0, 36, Local0, 0xd650a284)

		Or(0xffffffff, bf65, Local0)
		m600(arg0, 37, Local0, 0xffffffff)

		Or(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0xd650a284)

		Or(auii, bf65, Local0)
		m600(arg0, 39, Local0, 0xffffffff)

		if (y078) {
			Or(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0xd650a284)

			Or(Derefof(Refof(auii)), bf65, Local0)
			m600(arg0, 41, Local0, 0xffffffff)
		}

		Or(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0xd650a284)

		Or(Derefof(Index(paui, 18)), bf65, Local0)
		m600(arg0, 43, Local0, 0xffffffff)

		// Method returns Integer

		Or(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0xd650a284)

		Or(m601(1, 18), bf65, Local0)
		m600(arg0, 45, Local0, 0xffffffff)

		// Method returns Reference to Integer

		if (y500) {
			Or(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0xd650a284)

			Or(Derefof(m602(1, 18, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0xffffffff)
		}

		// Conversion of the both operands

		Store(Or(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0xd650a3a5)

		Store(Or(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0xd650a3a5)

		Or(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0xd650a3a5)

		Or(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0xd650a3a5)
	}

	// ShiftLeft, common 32-bit/64-bit test
	Method(m053, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b641, 420, 33, bf74)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(0xb, bf74)

		// Conversion of the first operand

		Store(ShiftLeft(bf61, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(ShiftLeft(bf61, 1), Local0)
		m600(arg0, 1, Local0, 0x642)

		Store(ShiftLeft(bf61, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(ShiftLeft(bf61, aui6), Local0)
		m600(arg0, 3, Local0, 0x642)

		if (y078) {
			Store(ShiftLeft(bf61, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(ShiftLeft(bf61, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x642)
		}

		Store(ShiftLeft(bf61, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(ShiftLeft(bf61, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x642)

		// Method returns Integer

		Store(ShiftLeft(bf61, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(ShiftLeft(bf61, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x642)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(bf61, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(ShiftLeft(bf61, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x642)
		}

		ShiftLeft(bf61, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		ShiftLeft(bf61, 1, Local0)
		m600(arg0, 13, Local0, 0x642)

		ShiftLeft(bf61, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		ShiftLeft(bf61, aui6, Local0)
		m600(arg0, 15, Local0, 0x642)

		if (y078) {
			ShiftLeft(bf61, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			ShiftLeft(bf61, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x642)
		}

		ShiftLeft(bf61, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		ShiftLeft(bf61, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x642)

		// Method returns Integer

		ShiftLeft(bf61, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		ShiftLeft(bf61, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x642)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(bf61, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			ShiftLeft(bf61, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x642)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, bf74), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, bf74), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, bf74), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, bf74), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), bf74), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), bf74), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), bf74), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), bf74), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), bf74), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), bf74), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), bf74), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), bf74), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, bf74, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, bf74, Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, bf74, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, bf74, Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), bf74, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), bf74, Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), bf74, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), bf74, Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), bf74, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), bf74, Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), bf74, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), bf74, Local0)
			m600(arg0, 47, Local0, 0x800)
		}
	}

	// ShiftLeft, 64-bit
	Method(m054, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)
		CreateField(b641, 420, 33, bf74)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)
		Store(0xb, bf74)

		// Conversion of the first operand

		Store(ShiftLeft(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(bf65, 1), Local0)
		m600(arg0, 1, Local0, 0xfcf96723aca14508)

		Store(ShiftLeft(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(bf65, aui6), Local0)
		m600(arg0, 3, Local0, 0xfcf96723aca14508)

		if (y078) {
			Store(ShiftLeft(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(ShiftLeft(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfcf96723aca14508)
		}

		Store(ShiftLeft(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfcf96723aca14508)

		// Method returns Integer

		Store(ShiftLeft(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(ShiftLeft(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfcf96723aca14508)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(ShiftLeft(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfcf96723aca14508)
		}

		ShiftLeft(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		ShiftLeft(bf65, 1, Local0)
		m600(arg0, 13, Local0, 0xfcf96723aca14508)

		ShiftLeft(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		ShiftLeft(bf65, aui6, Local0)
		m600(arg0, 15, Local0, 0xfcf96723aca14508)

		if (y078) {
			ShiftLeft(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			ShiftLeft(bf65, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfcf96723aca14508)
		}

		ShiftLeft(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		ShiftLeft(bf65, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfcf96723aca14508)

		// Method returns Integer

		ShiftLeft(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		ShiftLeft(bf65, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfcf96723aca14508)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			ShiftLeft(bf65, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfcf96723aca14508)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, bf74), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, bf74), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, bf74), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, bf74), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), bf74), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), bf74), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), bf74), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), bf74), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), bf74), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), bf74), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), bf74), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), bf74), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, bf74, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, bf74, Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, bf74, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, bf74, Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), bf74, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), bf74, Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), bf74, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), bf74, Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), bf74, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), bf74, Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), bf74, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), bf74, Local0)
			m600(arg0, 47, Local0, 0x800)
		}

		// Conversion of the both operands

		Store(ShiftLeft(bf61, bf74), Local0)
		m600(arg0, 48, Local0, 0x190800)

		Store(ShiftLeft(bf65, bf74), Local0)
		m600(arg0, 49, Local0, 0xE59C8EB285142000)

		ShiftLeft(bf61, bf74, Local0)
		m600(arg0, 50, Local0, 0x190800)

		ShiftLeft(bf65, bf74, Local0)
		m600(arg0, 51, Local0, 0xE59C8EB285142000)
	}

	// ShiftLeft, 32-bit
	Method(m055, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)
		CreateField(b641, 420, 33, bf74)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)
		Store(0xb, bf74)

		// Conversion of the first operand

		Store(ShiftLeft(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(ShiftLeft(bf65, 1), Local0)
		m600(arg0, 1, Local0, 0xaca14508)

		Store(ShiftLeft(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(ShiftLeft(bf65, aui6), Local0)
		m600(arg0, 3, Local0, 0xaca14508)

		if (y078) {
			Store(ShiftLeft(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(ShiftLeft(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xaca14508)
		}

		Store(ShiftLeft(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(ShiftLeft(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xaca14508)

		// Method returns Integer

		Store(ShiftLeft(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(ShiftLeft(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xaca14508)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(ShiftLeft(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xaca14508)
		}

		ShiftLeft(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		ShiftLeft(bf65, 1, Local0)
		m600(arg0, 13, Local0, 0xaca14508)

		ShiftLeft(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		ShiftLeft(bf65, aui6, Local0)
		m600(arg0, 15, Local0, 0xaca14508)

		if (y078) {
			ShiftLeft(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			ShiftLeft(bf65, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xaca14508)
		}

		ShiftLeft(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		ShiftLeft(bf65, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xaca14508)

		// Method returns Integer

		ShiftLeft(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		ShiftLeft(bf65, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xaca14508)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			ShiftLeft(bf65, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xaca14508)
		}

		// Conversion of the second operand

		Store(ShiftLeft(0, bf74), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftLeft(1, bf74), Local0)
		m600(arg0, 25, Local0, 0x800)

		Store(ShiftLeft(aui5, bf74), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftLeft(aui6, bf74), Local0)
		m600(arg0, 27, Local0, 0x800)

		if (y078) {
			Store(ShiftLeft(Derefof(Refof(aui5)), bf74), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftLeft(Derefof(Refof(aui6)), bf74), Local0)
			m600(arg0, 29, Local0, 0x800)
		}

		Store(ShiftLeft(Derefof(Index(paui, 5)), bf74), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftLeft(Derefof(Index(paui, 6)), bf74), Local0)
		m600(arg0, 31, Local0, 0x800)

		// Method returns Integer

		Store(ShiftLeft(m601(1, 5), bf74), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftLeft(m601(1, 6), bf74), Local0)
		m600(arg0, 33, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftLeft(Derefof(m602(1, 5, 1)), bf74), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftLeft(Derefof(m602(1, 6, 1)), bf74), Local0)
			m600(arg0, 35, Local0, 0x800)
		}

		ShiftLeft(0, bf74, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftLeft(1, bf74, Local0)
		m600(arg0, 37, Local0, 0x800)

		ShiftLeft(aui5, bf74, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftLeft(aui6, bf74, Local0)
		m600(arg0, 39, Local0, 0x800)

		if (y078) {
			ShiftLeft(Derefof(Refof(aui5)), bf74, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftLeft(Derefof(Refof(aui6)), bf74, Local0)
			m600(arg0, 41, Local0, 0x800)
		}

		ShiftLeft(Derefof(Index(paui, 5)), bf74, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftLeft(Derefof(Index(paui, 6)), bf74, Local0)
		m600(arg0, 43, Local0, 0x800)

		// Method returns Integer

		ShiftLeft(m601(1, 5), bf74, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftLeft(m601(1, 6), bf74, Local0)
		m600(arg0, 45, Local0, 0x800)

		// Method returns Reference to Integer

		if (y500) {
			ShiftLeft(Derefof(m602(1, 5, 1)), bf74, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftLeft(Derefof(m602(1, 6, 1)), bf74, Local0)
			m600(arg0, 47, Local0, 0x800)
		}

		// Conversion of the both operands

		Store(ShiftLeft(bf61, bf74), Local0)
		m600(arg0, 48, Local0, 0x190800)

		Store(ShiftLeft(bf65, bf74), Local0)
		m600(arg0, 49, Local0, 0x85142000)

		ShiftLeft(bf61, bf74, Local0)
		m600(arg0, 50, Local0, 0x190800)

		ShiftLeft(bf65, bf74, Local0)
		m600(arg0, 51, Local0, 0x85142000)
	}

	// ShiftRight, common 32-bit/64-bit test
	Method(m056, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b641, 420, 33, bf74)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(0xb, bf74)

		// Conversion of the first operand

		Store(ShiftRight(bf61, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(ShiftRight(bf61, 1), Local0)
		m600(arg0, 1, Local0, 0x190)

		Store(ShiftRight(bf61, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(ShiftRight(bf61, aui6), Local0)
		m600(arg0, 3, Local0, 0x190)

		if (y078) {
			Store(ShiftRight(bf61, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(ShiftRight(bf61, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x190)
		}

		Store(ShiftRight(bf61, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(ShiftRight(bf61, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x190)

		// Method returns Integer

		Store(ShiftRight(bf61, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(ShiftRight(bf61, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x190)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(bf61, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(ShiftRight(bf61, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x190)
		}

		ShiftRight(bf61, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		ShiftRight(bf61, 1, Local0)
		m600(arg0, 13, Local0, 0x190)

		ShiftRight(bf61, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		ShiftRight(bf61, aui6, Local0)
		m600(arg0, 15, Local0, 0x190)

		if (y078) {
			ShiftRight(bf61, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			ShiftRight(bf61, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x190)
		}

		ShiftRight(bf61, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		ShiftRight(bf61, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x190)

		// Method returns Integer

		ShiftRight(bf61, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		ShiftRight(bf61, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x190)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(bf61, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			ShiftRight(bf61, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x190)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, bf74), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xd650a284, bf74), Local0)
		m600(arg0, 25, Local0, 0x1aca14)

		Store(ShiftRight(aui1, bf74), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(auik, bf74), Local0)
		m600(arg0, 27, Local0, 0x1aca14)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), bf74), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(auik)), bf74), Local0)
			m600(arg0, 29, Local0, 0x1aca14)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), bf74), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 20)), bf74), Local0)
		m600(arg0, 31, Local0, 0x1aca14)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), bf74), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 20), bf74), Local0)
		m600(arg0, 33, Local0, 0x1aca14)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), bf74), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 20, 1)), bf74), Local0)
			m600(arg0, 35, Local0, 0x1aca14)
		}

		ShiftRight(0x321, bf74, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xd650a284, bf74, Local0)
		m600(arg0, 37, Local0, 0x1aca14)

		ShiftRight(aui1, bf74, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(auik, bf74, Local0)
		m600(arg0, 39, Local0, 0x1aca14)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), bf74, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(auik)), bf74, Local0)
			m600(arg0, 41, Local0, 0x1aca14)
		}

		ShiftRight(Derefof(Index(paui, 1)), bf74, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 20)), bf74, Local0)
		m600(arg0, 43, Local0, 0x1aca14)

		// Method returns Integer

		ShiftRight(m601(1, 1), bf74, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 20), bf74, Local0)
		m600(arg0, 45, Local0, 0x1aca14)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), bf74, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 20, 1)), bf74, Local0)
			m600(arg0, 47, Local0, 0x1aca14)
		}
	}

	// ShiftRight, 64-bit
	Method(m057, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)
		CreateField(b641, 420, 33, bf74)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)
		Store(0xb, bf74)

		// Conversion of the first operand

		Store(ShiftRight(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(bf65, 1), Local0)
		m600(arg0, 1, Local0, 0x7f3e59c8eb285142)

		Store(ShiftRight(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(bf65, aui6), Local0)
		m600(arg0, 3, Local0, 0x7f3e59c8eb285142)

		if (y078) {
			Store(ShiftRight(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(ShiftRight(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x7f3e59c8eb285142)
		}

		Store(ShiftRight(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x7f3e59c8eb285142)

		// Method returns Integer

		Store(ShiftRight(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(ShiftRight(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x7f3e59c8eb285142)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(ShiftRight(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x7f3e59c8eb285142)
		}

		ShiftRight(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		ShiftRight(bf65, 1, Local0)
		m600(arg0, 13, Local0, 0x7f3e59c8eb285142)

		ShiftRight(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		ShiftRight(bf65, aui6, Local0)
		m600(arg0, 15, Local0, 0x7f3e59c8eb285142)

		if (y078) {
			ShiftRight(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			ShiftRight(bf65, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x7f3e59c8eb285142)
		}

		ShiftRight(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		ShiftRight(bf65, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x7f3e59c8eb285142)

		// Method returns Integer

		ShiftRight(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		ShiftRight(bf65, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x7f3e59c8eb285142)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			ShiftRight(bf65, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x7f3e59c8eb285142)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, bf74), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xfe7cb391d650a284, bf74), Local0)
		m600(arg0, 25, Local0, 0x1fcf96723aca14)

		Store(ShiftRight(aui1, bf74), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(aui4, bf74), Local0)
		m600(arg0, 27, Local0, 0x1fcf96723aca14)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), bf74), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(aui4)), bf74), Local0)
			m600(arg0, 29, Local0, 0x1fcf96723aca14)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), bf74), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 4)), bf74), Local0)
		m600(arg0, 31, Local0, 0x1fcf96723aca14)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), bf74), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 4), bf74), Local0)
		m600(arg0, 33, Local0, 0x1fcf96723aca14)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), bf74), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 4, 1)), bf74), Local0)
			m600(arg0, 35, Local0, 0x1fcf96723aca14)
		}

		ShiftRight(0x321, bf74, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xfe7cb391d650a284, bf74, Local0)
		m600(arg0, 37, Local0, 0x1fcf96723aca14)

		ShiftRight(aui1, bf74, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(aui4, bf74, Local0)
		m600(arg0, 39, Local0, 0x1fcf96723aca14)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), bf74, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(aui4)), bf74, Local0)
			m600(arg0, 41, Local0, 0x1fcf96723aca14)
		}

		ShiftRight(Derefof(Index(paui, 1)), bf74, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 4)), bf74, Local0)
		m600(arg0, 43, Local0, 0x1fcf96723aca14)

		// Method returns Integer

		ShiftRight(m601(1, 1), bf74, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 4), bf74, Local0)
		m600(arg0, 45, Local0, 0x1fcf96723aca14)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), bf74, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 4, 1)), bf74, Local0)
			m600(arg0, 47, Local0, 0x1fcf96723aca14)
		}

		// Conversion of the both operands

		Store(ShiftRight(bf61, bf74), Local0)
		m600(arg0, 48, Local0, 0)

		Store(ShiftRight(bf65, bf74), Local0)
		m600(arg0, 49, Local0, 0x1fcf96723aca14)

		ShiftRight(bf61, bf74, Local0)
		m600(arg0, 50, Local0, 0)

		ShiftRight(bf65, bf74, Local0)
		m600(arg0, 51, Local0, 0x1fcf96723aca14)
	}

	// ShiftRight, 32-bit
	Method(m058, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)
		CreateField(b641, 420, 33, bf74)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)
		Store(0xb, bf74)

		// Conversion of the first operand

		Store(ShiftRight(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(ShiftRight(bf65, 1), Local0)
		m600(arg0, 1, Local0, 0x6b285142)

		Store(ShiftRight(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(ShiftRight(bf65, aui6), Local0)
		m600(arg0, 3, Local0, 0x6b285142)

		if (y078) {
			Store(ShiftRight(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(ShiftRight(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x6b285142)
		}

		Store(ShiftRight(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(ShiftRight(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x6b285142)

		// Method returns Integer

		Store(ShiftRight(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(ShiftRight(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x6b285142)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(ShiftRight(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x6b285142)
		}

		ShiftRight(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		ShiftRight(bf65, 1, Local0)
		m600(arg0, 13, Local0, 0x6b285142)

		ShiftRight(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		ShiftRight(bf65, aui6, Local0)
		m600(arg0, 15, Local0, 0x6b285142)

		if (y078) {
			ShiftRight(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			ShiftRight(bf65, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x6b285142)
		}

		ShiftRight(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		ShiftRight(bf65, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x6b285142)

		// Method returns Integer

		ShiftRight(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		ShiftRight(bf65, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x6b285142)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			ShiftRight(bf65, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x6b285142)
		}

		// Conversion of the second operand

		Store(ShiftRight(0x321, bf74), Local0)
		m600(arg0, 24, Local0, 0)

		Store(ShiftRight(0xd650a284, bf74), Local0)
		m600(arg0, 25, Local0, 0x1aca14)

		Store(ShiftRight(aui1, bf74), Local0)
		m600(arg0, 26, Local0, 0)

		Store(ShiftRight(auik, bf74), Local0)
		m600(arg0, 27, Local0, 0x1aca14)

		if (y078) {
			Store(ShiftRight(Derefof(Refof(aui1)), bf74), Local0)
			m600(arg0, 28, Local0, 0)

			Store(ShiftRight(Derefof(Refof(auik)), bf74), Local0)
			m600(arg0, 29, Local0, 0x1aca14)
		}

		Store(ShiftRight(Derefof(Index(paui, 1)), bf74), Local0)
		m600(arg0, 30, Local0, 0)

		Store(ShiftRight(Derefof(Index(paui, 20)), bf74), Local0)
		m600(arg0, 31, Local0, 0x1aca14)

		// Method returns Integer

		Store(ShiftRight(m601(1, 1), bf74), Local0)
		m600(arg0, 32, Local0, 0)

		Store(ShiftRight(m601(1, 20), bf74), Local0)
		m600(arg0, 33, Local0, 0x1aca14)

		// Method returns Reference to Integer

		if (y500) {
			Store(ShiftRight(Derefof(m602(1, 1, 1)), bf74), Local0)
			m600(arg0, 34, Local0, 0)

			Store(ShiftRight(Derefof(m602(1, 20, 1)), bf74), Local0)
			m600(arg0, 35, Local0, 0x1aca14)
		}

		ShiftRight(0x321, bf74, Local0)
		m600(arg0, 36, Local0, 0)

		ShiftRight(0xd650a284, bf74, Local0)
		m600(arg0, 37, Local0, 0x1aca14)

		ShiftRight(aui1, bf74, Local0)
		m600(arg0, 38, Local0, 0)

		ShiftRight(auik, bf74, Local0)
		m600(arg0, 39, Local0, 0x1aca14)

		if (y078) {
			ShiftRight(Derefof(Refof(aui1)), bf74, Local0)
			m600(arg0, 40, Local0, 0)

			ShiftRight(Derefof(Refof(auik)), bf74, Local0)
			m600(arg0, 41, Local0, 0x1aca14)
		}

		ShiftRight(Derefof(Index(paui, 1)), bf74, Local0)
		m600(arg0, 42, Local0, 0)

		ShiftRight(Derefof(Index(paui, 20)), bf74, Local0)
		m600(arg0, 43, Local0, 0x1aca14)

		// Method returns Integer

		ShiftRight(m601(1, 1), bf74, Local0)
		m600(arg0, 44, Local0, 0)

		ShiftRight(m601(1, 20), bf74, Local0)
		m600(arg0, 45, Local0, 0x1aca14)

		// Method returns Reference to Integer

		if (y500) {
			ShiftRight(Derefof(m602(1, 1, 1)), bf74, Local0)
			m600(arg0, 46, Local0, 0)

			ShiftRight(Derefof(m602(1, 20, 1)), bf74, Local0)
			m600(arg0, 47, Local0, 0x1aca14)
		}

		// Conversion of the both operands

		Store(ShiftRight(bf61, bf74), Local0)
		m600(arg0, 48, Local0, 0)

		Store(ShiftRight(bf65, bf74), Local0)
		m600(arg0, 49, Local0, 0x1aca14)

		ShiftRight(bf61, bf74, Local0)
		m600(arg0, 50, Local0, 0)

		ShiftRight(bf65, bf74, Local0)
		m600(arg0, 51, Local0, 0x1aca14)
	}

	// Subtract, common 32-bit/64-bit test
	Method(m059, 1)
	{
		CreateField(b640,   0, 31, bf61)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)

		// Conversion of the first operand

		Store(Subtract(bf61, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(Subtract(bf61, 1), Local0)
		m600(arg0, 1, Local0, 0x320)

		Store(Subtract(bf61, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(Subtract(bf61, aui6), Local0)
		m600(arg0, 3, Local0, 0x320)

		if (y078) {
			Store(Subtract(bf61, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(Subtract(bf61, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0x320)
		}

		Store(Subtract(bf61, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(Subtract(bf61, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0x320)

		// Method returns Integer

		Store(Subtract(bf61, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(Subtract(bf61, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(bf61, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(Subtract(bf61, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0x320)
		}

		Subtract(bf61, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		Subtract(bf61, 1, Local0)
		m600(arg0, 13, Local0, 0x320)

		Subtract(bf61, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		Subtract(bf61, aui6, Local0)
		m600(arg0, 15, Local0, 0x320)

		if (y078) {
			Subtract(bf61, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			Subtract(bf61, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0x320)
		}

		Subtract(bf61, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		Subtract(bf61, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0x320)

		// Method returns Integer

		Subtract(bf61, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		Subtract(bf61, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0x320)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(bf61, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			Subtract(bf61, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0x320)
		}

		// Conversion of the second operand

		Store(Subtract(0, bf61), Local0)
		m600(arg0, 24, Local0, 0xfffffffffffffcdf)

		Store(Subtract(1, bf61), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffce0)

		Store(Subtract(aui5, bf61), Local0)
		m600(arg0, 26, Local0, 0xfffffffffffffcdf)

		Store(Subtract(aui6, bf61), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffce0)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), bf61), Local0)
			m600(arg0, 28, Local0, 0xfffffffffffffcdf)

			Store(Subtract(Derefof(Refof(aui6)), bf61), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffce0)
		}

		Store(Subtract(Derefof(Index(paui, 5)), bf61), Local0)
		m600(arg0, 30, Local0, 0xfffffffffffffcdf)

		Store(Subtract(Derefof(Index(paui, 6)), bf61), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffce0)

		// Method returns Integer

		Store(Subtract(m601(1, 5), bf61), Local0)
		m600(arg0, 32, Local0, 0xfffffffffffffcdf)

		Store(Subtract(m601(1, 6), bf61), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffce0)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), bf61), Local0)
			m600(arg0, 34, Local0, 0xfffffffffffffcdf)

			Store(Subtract(Derefof(m602(1, 6, 1)), bf61), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffce0)
		}

		Subtract(0, bf61, Local0)
		m600(arg0, 36, Local0, 0xfffffffffffffcdf)

		Subtract(1, bf61, Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffce0)

		Subtract(aui5, bf61, Local0)
		m600(arg0, 38, Local0, 0xfffffffffffffcdf)

		Subtract(aui6, bf61, Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffce0)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), bf61, Local0)
			m600(arg0, 40, Local0, 0xfffffffffffffcdf)

			Subtract(Derefof(Refof(aui6)), bf61, Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffce0)
		}

		Subtract(Derefof(Index(paui, 5)), bf61, Local0)
		m600(arg0, 42, Local0, 0xfffffffffffffcdf)

		Subtract(Derefof(Index(paui, 6)), bf61, Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffce0)

		// Method returns Integer

		Subtract(m601(1, 5), bf61, Local0)
		m600(arg0, 44, Local0, 0xfffffffffffffcdf)

		Subtract(m601(1, 6), bf61, Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffce0)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), bf61, Local0)
			m600(arg0, 46, Local0, 0xfffffffffffffcdf)

			Subtract(Derefof(m602(1, 6, 1)), bf61, Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffce0)
		}
	}

	// Subtract, 64-bit
	Method(m05a, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(Subtract(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(Subtract(bf65, 1), Local0)
		m600(arg0, 1, Local0, 0xfe7cb391d650a283)

		Store(Subtract(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(Subtract(bf65, aui6), Local0)
		m600(arg0, 3, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Store(Subtract(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(Subtract(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xfe7cb391d650a283)
		}

		Store(Subtract(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(Subtract(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Store(Subtract(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(Subtract(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(Subtract(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xfe7cb391d650a283)
		}

		Subtract(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		Subtract(bf65, 1, Local0)
		m600(arg0, 13, Local0, 0xfe7cb391d650a283)

		Subtract(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		Subtract(bf65, aui6, Local0)
		m600(arg0, 15, Local0, 0xfe7cb391d650a283)

		if (y078) {
			Subtract(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			Subtract(bf65, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xfe7cb391d650a283)
		}

		Subtract(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		Subtract(bf65, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xfe7cb391d650a283)

		// Method returns Integer

		Subtract(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		Subtract(bf65, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xfe7cb391d650a283)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			Subtract(bf65, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xfe7cb391d650a283)
		}

		// Conversion of the second operand

		Store(Subtract(0, bf65), Local0)
		m600(arg0, 24, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(1, bf65), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7d)

		Store(Subtract(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(aui6, bf65), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7d)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0x01834c6e29af5d7c)

			Store(Subtract(Derefof(Refof(aui6)), bf65), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7d)
		}

		Store(Subtract(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(Derefof(Index(paui, 6)), bf65), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7d)

		// Method returns Integer

		Store(Subtract(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0x01834c6e29af5d7c)

		Store(Subtract(m601(1, 6), bf65), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0x01834c6e29af5d7c)

			Store(Subtract(Derefof(m602(1, 6, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7d)
		}

		Subtract(0, bf65, Local0)
		m600(arg0, 36, Local0, 0x01834c6e29af5d7c)

		Subtract(1, bf65, Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7d)

		Subtract(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0x01834c6e29af5d7c)

		Subtract(aui6, bf65, Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7d)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0x01834c6e29af5d7c)

			Subtract(Derefof(Refof(aui6)), bf65, Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7d)
		}

		Subtract(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0x01834c6e29af5d7c)

		Subtract(Derefof(Index(paui, 6)), bf65, Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7d)

		// Method returns Integer

		Subtract(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0x01834c6e29af5d7c)

		Subtract(m601(1, 6), bf65, Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0x01834c6e29af5d7c)

			Subtract(Derefof(m602(1, 6, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7d)
		}

		// Conversion of the both operands

		Store(Subtract(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0x01834c6e29af609d)

		Store(Subtract(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d6509f63)

		Subtract(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0x01834c6e29af609d)

		Subtract(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d6509f63)
	}

	// Subtract, 32-bit
	Method(m05b, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(Subtract(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(Subtract(bf65, 1), Local0)
		m600(arg0, 1, Local0, 0xd650a283)

		Store(Subtract(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(Subtract(bf65, aui6), Local0)
		m600(arg0, 3, Local0, 0xd650a283)

		if (y078) {
			Store(Subtract(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(Subtract(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, 0xd650a283)
		}

		Store(Subtract(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(Subtract(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, 0xd650a283)

		// Method returns Integer

		Store(Subtract(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(Subtract(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, 0xd650a283)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(Subtract(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, 0xd650a283)
		}

		Subtract(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		Subtract(bf65, 1, Local0)
		m600(arg0, 13, Local0, 0xd650a283)

		Subtract(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		Subtract(bf65, aui6, Local0)
		m600(arg0, 15, Local0, 0xd650a283)

		if (y078) {
			Subtract(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			Subtract(bf65, Derefof(Refof(aui6)), Local0)
			m600(arg0, 17, Local0, 0xd650a283)
		}

		Subtract(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		Subtract(bf65, Derefof(Index(paui, 6)), Local0)
		m600(arg0, 19, Local0, 0xd650a283)

		// Method returns Integer

		Subtract(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		Subtract(bf65, m601(1, 6), Local0)
		m600(arg0, 21, Local0, 0xd650a283)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			Subtract(bf65, Derefof(m602(1, 6, 1)), Local0)
			m600(arg0, 23, Local0, 0xd650a283)
		}

		// Conversion of the second operand

		Store(Subtract(0, bf65), Local0)
		m600(arg0, 24, Local0, 0x29af5d7c)

		Store(Subtract(1, bf65), Local0)
		m600(arg0, 25, Local0, 0x29af5d7d)

		Store(Subtract(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0x29af5d7c)

		Store(Subtract(aui6, bf65), Local0)
		m600(arg0, 27, Local0, 0x29af5d7d)

		if (y078) {
			Store(Subtract(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0x29af5d7c)

			Store(Subtract(Derefof(Refof(aui6)), bf65), Local0)
			m600(arg0, 29, Local0, 0x29af5d7d)
		}

		Store(Subtract(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0x29af5d7c)

		Store(Subtract(Derefof(Index(paui, 6)), bf65), Local0)
		m600(arg0, 31, Local0, 0x29af5d7d)

		// Method returns Integer

		Store(Subtract(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0x29af5d7c)

		Store(Subtract(m601(1, 6), bf65), Local0)
		m600(arg0, 33, Local0, 0x29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Store(Subtract(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0x29af5d7c)

			Store(Subtract(Derefof(m602(1, 6, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0x29af5d7d)
		}

		Subtract(0, bf65, Local0)
		m600(arg0, 36, Local0, 0x29af5d7c)

		Subtract(1, bf65, Local0)
		m600(arg0, 37, Local0, 0x29af5d7d)

		Subtract(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0x29af5d7c)

		Subtract(aui6, bf65, Local0)
		m600(arg0, 39, Local0, 0x29af5d7d)

		if (y078) {
			Subtract(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0x29af5d7c)

			Subtract(Derefof(Refof(aui6)), bf65, Local0)
			m600(arg0, 41, Local0, 0x29af5d7d)
		}

		Subtract(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0x29af5d7c)

		Subtract(Derefof(Index(paui, 6)), bf65, Local0)
		m600(arg0, 43, Local0, 0x29af5d7d)

		// Method returns Integer

		Subtract(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0x29af5d7c)

		Subtract(m601(1, 6), bf65, Local0)
		m600(arg0, 45, Local0, 0x29af5d7d)

		// Method returns Reference to Integer

		if (y500) {
			Subtract(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0x29af5d7c)

			Subtract(Derefof(m602(1, 6, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0x29af5d7d)
		}

		// Conversion of the both operands

		Store(Subtract(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0x29af609d)

		Store(Subtract(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0xd6509f63)

		Subtract(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0x29af609d)

		Subtract(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0xd6509f63)
	}

	// XOr, common 32-bit/64-bit test
	Method(m05c, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(XOr(bf61, 0), Local0)
		m600(arg0, 0, Local0, 0x321)

		Store(XOr(bf61, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0xfffffffffffffcde)

		Store(XOr(bf61, aui5), Local0)
		m600(arg0, 2, Local0, 0x321)

		Store(XOr(bf61, auij), Local0)
		m600(arg0, 3, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(XOr(bf61, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0x321)

			Store(XOr(bf61, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0xfffffffffffffcde)
		}

		Store(XOr(bf61, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0x321)

		Store(XOr(bf61, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(XOr(bf61, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0x321)

		Store(XOr(bf61, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(bf61, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0x321)

			Store(XOr(bf61, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0xfffffffffffffcde)
		}

		XOr(bf61, 0, Local0)
		m600(arg0, 12, Local0, 0x321)

		XOr(bf61, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0xfffffffffffffcde)

		XOr(bf61, aui5, Local0)
		m600(arg0, 14, Local0, 0x321)

		XOr(bf61, auij, Local0)
		m600(arg0, 15, Local0, 0xfffffffffffffcde)

		if (y078) {
			XOr(bf61, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0x321)

			XOr(bf61, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0xfffffffffffffcde)
		}

		XOr(bf61, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0x321)

		XOr(bf61, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		XOr(bf61, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0x321)

		XOr(bf61, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			XOr(bf61, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0x321)

			XOr(bf61, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0xfffffffffffffcde)
		}

		// Conversion of the second operand

		Store(XOr(0, bf61), Local0)
		m600(arg0, 24, Local0, 0x321)

		Store(XOr(0xffffffffffffffff, bf61), Local0)
		m600(arg0, 25, Local0, 0xfffffffffffffcde)

		Store(XOr(aui5, bf61), Local0)
		m600(arg0, 26, Local0, 0x321)

		Store(XOr(auij, bf61), Local0)
		m600(arg0, 27, Local0, 0xfffffffffffffcde)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), bf61), Local0)
			m600(arg0, 28, Local0, 0x321)

			Store(XOr(Derefof(Refof(auij)), bf61), Local0)
			m600(arg0, 29, Local0, 0xfffffffffffffcde)
		}

		Store(XOr(Derefof(Index(paui, 5)), bf61), Local0)
		m600(arg0, 30, Local0, 0x321)

		Store(XOr(Derefof(Index(paui, 19)), bf61), Local0)
		m600(arg0, 31, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		Store(XOr(m601(1, 5), bf61), Local0)
		m600(arg0, 32, Local0, 0x321)

		Store(XOr(m601(1, 19), bf61), Local0)
		m600(arg0, 33, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), bf61), Local0)
			m600(arg0, 34, Local0, 0x321)

			Store(XOr(Derefof(m602(1, 19, 1)), bf61), Local0)
			m600(arg0, 35, Local0, 0xfffffffffffffcde)
		}

		XOr(0, bf61, Local0)
		m600(arg0, 36, Local0, 0x321)

		XOr(0xffffffffffffffff, bf61, Local0)
		m600(arg0, 37, Local0, 0xfffffffffffffcde)

		XOr(aui5, bf61, Local0)
		m600(arg0, 38, Local0, 0x321)

		XOr(auij, bf61, Local0)
		m600(arg0, 39, Local0, 0xfffffffffffffcde)

		if (y078) {
			XOr(Derefof(Refof(aui5)), bf61, Local0)
			m600(arg0, 40, Local0, 0x321)

			XOr(Derefof(Refof(auij)), bf61, Local0)
			m600(arg0, 41, Local0, 0xfffffffffffffcde)
		}

		XOr(Derefof(Index(paui, 5)), bf61, Local0)
		m600(arg0, 42, Local0, 0x321)

		XOr(Derefof(Index(paui, 19)), bf61, Local0)
		m600(arg0, 43, Local0, 0xfffffffffffffcde)

		// Method returns Integer

		XOr(m601(1, 5), bf61, Local0)
		m600(arg0, 44, Local0, 0x321)

		XOr(m601(1, 19), bf61, Local0)
		m600(arg0, 45, Local0, 0xfffffffffffffcde)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), bf61, Local0)
			m600(arg0, 46, Local0, 0x321)

			XOr(Derefof(m602(1, 19, 1)), bf61, Local0)
			m600(arg0, 47, Local0, 0xfffffffffffffcde)
		}
	}

	// XOr, 64-bit
	Method(m05d, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(XOr(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xfe7cb391d650a284)

		Store(XOr(bf65, 0xffffffffffffffff), Local0)
		m600(arg0, 1, Local0, 0x01834c6e29af5d7b)

		Store(XOr(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xfe7cb391d650a284)

		Store(XOr(bf65, auij), Local0)
		m600(arg0, 3, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(XOr(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xfe7cb391d650a284)

			Store(XOr(bf65, Derefof(Refof(auij))), Local0)
			m600(arg0, 5, Local0, 0x01834c6e29af5d7b)
		}

		Store(XOr(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xfe7cb391d650a284)

		Store(XOr(bf65, Derefof(Index(paui, 19))), Local0)
		m600(arg0, 7, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(XOr(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xfe7cb391d650a284)

		Store(XOr(bf65, m601(1, 19)), Local0)
		m600(arg0, 9, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xfe7cb391d650a284)

			Store(XOr(bf65, Derefof(m602(1, 19, 1))), Local0)
			m600(arg0, 11, Local0, 0x01834c6e29af5d7b)
		}

		XOr(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xfe7cb391d650a284)

		XOr(bf65, 0xffffffffffffffff, Local0)
		m600(arg0, 13, Local0, 0x01834c6e29af5d7b)

		XOr(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xfe7cb391d650a284)

		XOr(bf65, auij, Local0)
		m600(arg0, 15, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			XOr(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xfe7cb391d650a284)

			XOr(bf65, Derefof(Refof(auij)), Local0)
			m600(arg0, 17, Local0, 0x01834c6e29af5d7b)
		}

		XOr(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xfe7cb391d650a284)

		XOr(bf65, Derefof(Index(paui, 19)), Local0)
		m600(arg0, 19, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		XOr(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xfe7cb391d650a284)

		XOr(bf65, m601(1, 19), Local0)
		m600(arg0, 21, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xfe7cb391d650a284)

			XOr(bf65, Derefof(m602(1, 19, 1)), Local0)
			m600(arg0, 23, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the second operand

		Store(XOr(0, bf65), Local0)
		m600(arg0, 24, Local0, 0xfe7cb391d650a284)

		Store(XOr(0xffffffffffffffff, bf65), Local0)
		m600(arg0, 25, Local0, 0x01834c6e29af5d7b)

		Store(XOr(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0xfe7cb391d650a284)

		Store(XOr(auij, bf65), Local0)
		m600(arg0, 27, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0xfe7cb391d650a284)

			Store(XOr(Derefof(Refof(auij)), bf65), Local0)
			m600(arg0, 29, Local0, 0x01834c6e29af5d7b)
		}

		Store(XOr(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0xfe7cb391d650a284)

		Store(XOr(Derefof(Index(paui, 19)), bf65), Local0)
		m600(arg0, 31, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		Store(XOr(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0xfe7cb391d650a284)

		Store(XOr(m601(1, 19), bf65), Local0)
		m600(arg0, 33, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0xfe7cb391d650a284)

			Store(XOr(Derefof(m602(1, 19, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0x01834c6e29af5d7b)
		}

		XOr(0, bf65, Local0)
		m600(arg0, 36, Local0, 0xfe7cb391d650a284)

		XOr(0xffffffffffffffff, bf65, Local0)
		m600(arg0, 37, Local0, 0x01834c6e29af5d7b)

		XOr(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0xfe7cb391d650a284)

		XOr(auij, bf65, Local0)
		m600(arg0, 39, Local0, 0x01834c6e29af5d7b)

		if (y078) {
			XOr(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0xfe7cb391d650a284)

			XOr(Derefof(Refof(auij)), bf65, Local0)
			m600(arg0, 41, Local0, 0x01834c6e29af5d7b)
		}

		XOr(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0xfe7cb391d650a284)

		XOr(Derefof(Index(paui, 19)), bf65, Local0)
		m600(arg0, 43, Local0, 0x01834c6e29af5d7b)

		// Method returns Integer

		XOr(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0xfe7cb391d650a284)

		XOr(m601(1, 19), bf65, Local0)
		m600(arg0, 45, Local0, 0x01834c6e29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0xfe7cb391d650a284)

			XOr(Derefof(m602(1, 19, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0x01834c6e29af5d7b)
		}

		// Conversion of the both operands

		Store(XOr(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0xfe7cb391d650a1a5)

		Store(XOr(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0xfe7cb391d650a1a5)

		XOr(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0xfe7cb391d650a1a5)

		XOr(bf65, bf61, Local0)
		m600(arg0, 51, Local0, 0xfe7cb391d650a1a5)
	}

	// XOr, 32-bit
	Method(m05e, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(XOr(bf65, 0), Local0)
		m600(arg0, 0, Local0, 0xd650a284)

		Store(XOr(bf65, 0xffffffff), Local0)
		m600(arg0, 1, Local0, 0x29af5d7b)

		Store(XOr(bf65, aui5), Local0)
		m600(arg0, 2, Local0, 0xd650a284)

		Store(XOr(bf65, auii), Local0)
		m600(arg0, 3, Local0, 0x29af5d7b)

		if (y078) {
			Store(XOr(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, 0xd650a284)

			Store(XOr(bf65, Derefof(Refof(auii))), Local0)
			m600(arg0, 5, Local0, 0x29af5d7b)
		}

		Store(XOr(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, 0xd650a284)

		Store(XOr(bf65, Derefof(Index(paui, 18))), Local0)
		m600(arg0, 7, Local0, 0x29af5d7b)

		// Method returns Integer

		Store(XOr(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, 0xd650a284)

		Store(XOr(bf65, m601(1, 18)), Local0)
		m600(arg0, 9, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, 0xd650a284)

			Store(XOr(bf65, Derefof(m602(1, 18, 1))), Local0)
			m600(arg0, 11, Local0, 0x29af5d7b)
		}

		XOr(bf65, 0, Local0)
		m600(arg0, 12, Local0, 0xd650a284)

		XOr(bf65, 0xffffffff, Local0)
		m600(arg0, 13, Local0, 0x29af5d7b)

		XOr(bf65, aui5, Local0)
		m600(arg0, 14, Local0, 0xd650a284)

		XOr(bf65, auii, Local0)
		m600(arg0, 15, Local0, 0x29af5d7b)

		if (y078) {
			XOr(bf65, Derefof(Refof(aui5)), Local0)
			m600(arg0, 16, Local0, 0xd650a284)

			XOr(bf65, Derefof(Refof(auii)), Local0)
			m600(arg0, 17, Local0, 0x29af5d7b)
		}

		XOr(bf65, Derefof(Index(paui, 5)), Local0)
		m600(arg0, 18, Local0, 0xd650a284)

		XOr(bf65, Derefof(Index(paui, 18)), Local0)
		m600(arg0, 19, Local0, 0x29af5d7b)

		// Method returns Integer

		XOr(bf65, m601(1, 5), Local0)
		m600(arg0, 20, Local0, 0xd650a284)

		XOr(bf65, m601(1, 18), Local0)
		m600(arg0, 21, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(bf65, Derefof(m602(1, 5, 1)), Local0)
			m600(arg0, 22, Local0, 0xd650a284)

			XOr(bf65, Derefof(m602(1, 18, 1)), Local0)
			m600(arg0, 23, Local0, 0x29af5d7b)
		}

		// Conversion of the second operand

		Store(XOr(0, bf65), Local0)
		m600(arg0, 24, Local0, 0xd650a284)

		Store(XOr(0xffffffff, bf65), Local0)
		m600(arg0, 25, Local0, 0x29af5d7b)

		Store(XOr(aui5, bf65), Local0)
		m600(arg0, 26, Local0, 0xd650a284)

		Store(XOr(auii, bf65), Local0)
		m600(arg0, 27, Local0, 0x29af5d7b)

		if (y078) {
			Store(XOr(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 28, Local0, 0xd650a284)

			Store(XOr(Derefof(Refof(auii)), bf65), Local0)
			m600(arg0, 29, Local0, 0x29af5d7b)
		}

		Store(XOr(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 30, Local0, 0xd650a284)

		Store(XOr(Derefof(Index(paui, 18)), bf65), Local0)
		m600(arg0, 31, Local0, 0x29af5d7b)

		// Method returns Integer

		Store(XOr(m601(1, 5), bf65), Local0)
		m600(arg0, 32, Local0, 0xd650a284)

		Store(XOr(m601(1, 18), bf65), Local0)
		m600(arg0, 33, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			Store(XOr(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 34, Local0, 0xd650a284)

			Store(XOr(Derefof(m602(1, 18, 1)), bf65), Local0)
			m600(arg0, 35, Local0, 0x29af5d7b)
		}

		XOr(0, bf65, Local0)
		m600(arg0, 36, Local0, 0xd650a284)

		XOr(0xffffffff, bf65, Local0)
		m600(arg0, 37, Local0, 0x29af5d7b)

		XOr(aui5, bf65, Local0)
		m600(arg0, 38, Local0, 0xd650a284)

		XOr(auii, bf65, Local0)
		m600(arg0, 39, Local0, 0x29af5d7b)

		if (y078) {
			XOr(Derefof(Refof(aui5)), bf65, Local0)
			m600(arg0, 40, Local0, 0xd650a284)

			XOr(Derefof(Refof(auii)), bf65, Local0)
			m600(arg0, 41, Local0, 0x29af5d7b)
		}

		XOr(Derefof(Index(paui, 5)), bf65, Local0)
		m600(arg0, 42, Local0, 0xd650a284)

		XOr(Derefof(Index(paui, 18)), bf65, Local0)
		m600(arg0, 43, Local0, 0x29af5d7b)

		// Method returns Integer

		XOr(m601(1, 5), bf65, Local0)
		m600(arg0, 44, Local0, 0xd650a284)

		XOr(m601(1, 18), bf65, Local0)
		m600(arg0, 45, Local0, 0x29af5d7b)

		// Method returns Reference to Integer

		if (y500) {
			XOr(Derefof(m602(1, 5, 1)), bf65, Local0)
			m600(arg0, 46, Local0, 0xd650a284)

			XOr(Derefof(m602(1, 18, 1)), bf65, Local0)
			m600(arg0, 47, Local0, 0x29af5d7b)
		}

		// Conversion of the both operands

		Store(XOr(bf61, bf65), Local0)
		m600(arg0, 48, Local0, 0xd650a1a5)

		Store(XOr(bf65, bf61), Local0)
		m600(arg0, 49, Local0, 0xd650a1a5)

		XOr(bf61, bf65, Local0)
		m600(arg0, 50, Local0, 0xd650a1a5)

		XOr(bf65, bf61, Local0)
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


	// Buffer Field to Integer conversion of each Buffer operand
	// of the 2-parameter Logical Integer operators LAnd and LOr

	// LAnd, common 32-bit/64-bit test
	Method(m05f, 1)
	{
		CreateField(b640,   0, 31, bf61)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)

		// Conversion of the first operand

		Store(LAnd(bf61, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd(bf61, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd(bf61, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd(bf61, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd(bf61, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd(bf61, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd(bf61, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd(bf61, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd(bf61, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd(bf61, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(bf61, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd(bf61, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, bf61), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, bf61), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, bf61), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, bf61), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), bf61), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), bf61), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), bf61), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), bf61), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), bf61), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), bf61), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), bf61), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), bf61), Local0)
			m600(arg0, 23, Local0, Ones)
		}
	}

	// LAnd, 64-bit
	Method(m060, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(LAnd(bf65, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd(bf65, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd(bf65, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd(bf65, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, bf65), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, bf65), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, bf65), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, bf65), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), bf65), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), bf65), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), bf65), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), bf65), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), bf65), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(LAnd(bf61, bf65), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(LAnd(bf65, bf61), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// LAnd, 32-bit
	Method(m061, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// Conversion of the first operand

		Store(LAnd(bf65, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(LAnd(bf65, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(LAnd(bf65, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LAnd(bf65, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(LAnd(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(LAnd(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(LAnd(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(LAnd(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(LAnd(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(LAnd(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(LAnd(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(LAnd(0, bf65), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(LAnd(1, bf65), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(LAnd(aui5, bf65), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(LAnd(aui6, bf65), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(LAnd(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LAnd(Derefof(Refof(aui6)), bf65), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(LAnd(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LAnd(Derefof(Index(paui, 6)), bf65), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(LAnd(m601(1, 5), bf65), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LAnd(m601(1, 6), bf65), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LAnd(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(LAnd(Derefof(m602(1, 6, 1)), bf65), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(LAnd(bf61, bf65), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(LAnd(bf65, bf61), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// Lor, common 32-bit/64-bit test
	Method(m062, 1)
	{
		CreateField(b641, 486, 33, bf76)

		Store(0, bf76)

		// Conversion of the first operand

		Store(Lor(bf76, 0), Local0)
		m600(arg0, 0, Local0, Zero)

		Store(Lor(bf76, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor(bf76, aui5), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(Lor(bf76, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor(bf76, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Zero)

			Store(Lor(bf76, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor(bf76, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Zero)

		Store(Lor(bf76, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor(bf76, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Zero)

		Store(Lor(bf76, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(bf76, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Zero)

			Store(Lor(bf76, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, bf76), Local0)
		m600(arg0, 12, Local0, Zero)

		Store(Lor(1, bf76), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, bf76), Local0)
		m600(arg0, 14, Local0, Zero)

		Store(Lor(aui6, bf76), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), bf76), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(Lor(Derefof(Refof(aui6)), bf76), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), bf76), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(Lor(Derefof(Index(paui, 6)), bf76), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), bf76), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(Lor(m601(1, 6), bf76), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), bf76), Local0)
			m600(arg0, 22, Local0, Zero)

			Store(Lor(Derefof(m602(1, 6, 1)), bf76), Local0)
			m600(arg0, 23, Local0, Ones)
		}
	}

	// Lor, 64-bit
	Method(m063, 1)
	{
		CreateField(b640, 159, 64, bf65)
		CreateField(b641, 486, 33, bf76)

		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)
		Store(0, bf76)

		// Conversion of the first operand

		Store(Lor(bf65, 0), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(Lor(bf65, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor(bf65, aui5), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(Lor(bf65, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(Lor(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(Lor(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(Lor(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(Lor(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, bf65), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(Lor(1, bf65), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, bf65), Local0)
		m600(arg0, 14, Local0, Ones)

		Store(Lor(aui6, bf65), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 16, Local0, Ones)

			Store(Lor(Derefof(Refof(aui6)), bf65), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 18, Local0, Ones)

		Store(Lor(Derefof(Index(paui, 6)), bf65), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), bf65), Local0)
		m600(arg0, 20, Local0, Ones)

		Store(Lor(m601(1, 6), bf65), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 22, Local0, Ones)

			Store(Lor(Derefof(m602(1, 6, 1)), bf65), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(Lor(bf76, bf65), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(Lor(bf65, bf76), Local0)
		m600(arg0, 25, Local0, Ones)
	}

	// Lor, 32-bit
	Method(m064, 1)
	{
		CreateField(b640, 159, 64, bf65)
		CreateField(b641, 486, 33, bf76)

		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)
		Store(0, bf76)

		// Conversion of the first operand

		Store(Lor(bf65, 0), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(Lor(bf65, 1), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Lor(bf65, aui5), Local0)
		m600(arg0, 2, Local0, Ones)

		Store(Lor(bf65, aui6), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Lor(bf65, Derefof(Refof(aui5))), Local0)
			m600(arg0, 4, Local0, Ones)

			Store(Lor(bf65, Derefof(Refof(aui6))), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Lor(bf65, Derefof(Index(paui, 5))), Local0)
		m600(arg0, 6, Local0, Ones)

		Store(Lor(bf65, Derefof(Index(paui, 6))), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Integer

		Store(Lor(bf65, m601(1, 5)), Local0)
		m600(arg0, 8, Local0, Ones)

		Store(Lor(bf65, m601(1, 6)), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(bf65, Derefof(m602(1, 5, 1))), Local0)
			m600(arg0, 10, Local0, Ones)

			Store(Lor(bf65, Derefof(m602(1, 6, 1))), Local0)
			m600(arg0, 11, Local0, Ones)
		}

		// Conversion of the second operand

		Store(Lor(0, bf65), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(Lor(1, bf65), Local0)
		m600(arg0, 13, Local0, Ones)

		Store(Lor(aui5, bf65), Local0)
		m600(arg0, 14, Local0, Ones)

		Store(Lor(aui6, bf65), Local0)
		m600(arg0, 15, Local0, Ones)

		if (y078) {
			Store(Lor(Derefof(Refof(aui5)), bf65), Local0)
			m600(arg0, 16, Local0, Ones)

			Store(Lor(Derefof(Refof(aui6)), bf65), Local0)
			m600(arg0, 17, Local0, Ones)
		}

		Store(Lor(Derefof(Index(paui, 5)), bf65), Local0)
		m600(arg0, 18, Local0, Ones)

		Store(Lor(Derefof(Index(paui, 6)), bf65), Local0)
		m600(arg0, 19, Local0, Ones)

		// Method returns Integer

		Store(Lor(m601(1, 5), bf65), Local0)
		m600(arg0, 20, Local0, Ones)

		Store(Lor(m601(1, 6), bf65), Local0)
		m600(arg0, 21, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(Lor(Derefof(m602(1, 5, 1)), bf65), Local0)
			m600(arg0, 22, Local0, Ones)

			Store(Lor(Derefof(m602(1, 6, 1)), bf65), Local0)
			m600(arg0, 23, Local0, Ones)
		}

		// Conversion of the both operands

		Store(Lor(bf76, bf65), Local0)
		m600(arg0, 24, Local0, Ones)

		Store(Lor(bf65, bf76), Local0)
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


	// Buffer Field to Integer conversion of the Buffer Field second operand
	// of Logical operators when the first operand is evaluated as Integer
	// (LEqual, LGreater, LGreaterEqual, LLess, LLessEqual, LNotEqual)

	Method(m64p, 1)
	{
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// LEqual

		Store(LEqual(0xfe7cb391d650a284, bf65), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0xfe7cb391d650a285, bf65), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0xfe7cb391d650a283, bf65), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(aui4, bf65), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auid, bf65), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auif, bf65), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aui4)), bf65), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auid)), bf65), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auif)), bf65), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 4)), bf65), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 13)), bf65), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 15)), bf65), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 4), bf65), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 13), bf65), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 15), bf65), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 4, 1)), bf65), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m602(1, 13, 1)), bf65), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m602(1, 15, 1)), bf65), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0xfe7cb391d650a284, bf65), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0xfe7cb391d650a285, bf65), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0xfe7cb391d650a283, bf65), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(aui4, bf65), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auid, bf65), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auif, bf65), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(aui4)), bf65), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auid)), bf65), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auif)), bf65), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 4)), bf65), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 13)), bf65), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 15)), bf65), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 4), bf65), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 13), bf65), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 15), bf65), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 4, 1)), bf65), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m602(1, 13, 1)), bf65), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m602(1, 15, 1)), bf65), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0xfe7cb391d650a284, bf65), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0xfe7cb391d650a285, bf65), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0xfe7cb391d650a283, bf65), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(aui4, bf65), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auid, bf65), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auif, bf65), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aui4)), bf65), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auid)), bf65), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auif)), bf65), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 4)), bf65), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 13)), bf65), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 15)), bf65), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 4), bf65), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 13), bf65), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 15), bf65), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 4, 1)), bf65), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 13, 1)), bf65), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 15, 1)), bf65), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0xfe7cb391d650a284, bf65), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0xfe7cb391d650a285, bf65), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0xfe7cb391d650a283, bf65), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(aui4, bf65), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auid, bf65), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auif, bf65), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(aui4)), bf65), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auid)), bf65), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auif)), bf65), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 4)), bf65), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 13)), bf65), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 15)), bf65), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 4), bf65), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 13), bf65), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 15), bf65), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 4, 1)), bf65), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m602(1, 13, 1)), bf65), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m602(1, 15, 1)), bf65), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0xfe7cb391d650a284, bf65), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0xfe7cb391d650a285, bf65), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0xfe7cb391d650a283, bf65), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(aui4, bf65), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auid, bf65), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auif, bf65), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aui4)), bf65), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auid)), bf65), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auif)), bf65), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 4)), bf65), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 13)), bf65), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 15)), bf65), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 4), bf65), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 13), bf65), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 15), bf65), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 4, 1)), bf65), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m602(1, 13, 1)), bf65), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m602(1, 15, 1)), bf65), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0xfe7cb391d650a284, bf65), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0xfe7cb391d650a285, bf65), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0xfe7cb391d650a283, bf65), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(aui4, bf65), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auid, bf65), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auif, bf65), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aui4)), bf65), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auid)), bf65), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auif)), bf65), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 4)), bf65), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 13)), bf65), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 15)), bf65), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 4), bf65), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 13), bf65), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 15), bf65), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 4, 1)), bf65), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m602(1, 13, 1)), bf65), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m602(1, 15, 1)), bf65), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	Method(m32p, 1)
	{
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		// LEqual

		Store(LEqual(0xd650a284, bf65), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0xd650a285, bf65), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0xd650a283, bf65), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(auik, bf65), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auil, bf65), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auim, bf65), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(auik)), bf65), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auil)), bf65), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auim)), bf65), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 20)), bf65), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 21)), bf65), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 22)), bf65), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 20), bf65), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 21), bf65), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 22), bf65), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 20, 1)), bf65), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m601(1, 21, 1)), bf65), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m601(1, 22, 1)), bf65), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0xd650a284, bf65), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0xd650a285, bf65), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0xd650a283, bf65), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(auik, bf65), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auil, bf65), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auim, bf65), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(auik)), bf65), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auil)), bf65), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auim)), bf65), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 20)), bf65), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 21)), bf65), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 22)), bf65), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 20), bf65), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 21), bf65), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 22), bf65), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 20, 1)), bf65), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m601(1, 21, 1)), bf65), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m601(1, 22, 1)), bf65), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0xd650a284, bf65), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0xd650a285, bf65), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0xd650a283, bf65), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(auik, bf65), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auil, bf65), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auim, bf65), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(auik)), bf65), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auil)), bf65), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auim)), bf65), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 20)), bf65), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 21)), bf65), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 22)), bf65), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 20), bf65), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 21), bf65), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 22), bf65), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 20, 1)), bf65), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m601(1, 21, 1)), bf65), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m601(1, 22, 1)), bf65), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0xd650a284, bf65), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0xd650a285, bf65), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0xd650a283, bf65), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(auik, bf65), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auil, bf65), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auim, bf65), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(auik)), bf65), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auil)), bf65), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auim)), bf65), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 20)), bf65), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 21)), bf65), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 22)), bf65), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 20), bf65), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 21), bf65), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 22), bf65), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 20, 1)), bf65), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m601(1, 21, 1)), bf65), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m601(1, 22, 1)), bf65), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0xd650a284, bf65), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0xd650a285, bf65), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0xd650a283, bf65), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(auik, bf65), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auil, bf65), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auim, bf65), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(auik)), bf65), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auil)), bf65), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auim)), bf65), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 20)), bf65), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 21)), bf65), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 22)), bf65), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 20), bf65), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 21), bf65), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 22), bf65), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 20, 1)), bf65), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m601(1, 21, 1)), bf65), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m601(1, 22, 1)), bf65), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0xd650a284, bf65), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0xd650a285, bf65), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0xd650a283, bf65), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(auik, bf65), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auil, bf65), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auim, bf65), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(auik)), bf65), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auil)), bf65), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auim)), bf65), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 20)), bf65), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 21)), bf65), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 22)), bf65), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 20), bf65), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 21), bf65), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 22), bf65), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 20, 1)), bf65), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m601(1, 21, 1)), bf65), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m601(1, 22, 1)), bf65), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	Method(m065, 1)
	{
		CreateField(b640,   0, 31, bf61)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)

		// LEqual

		Store(LEqual(0x321, bf61), Local0)
		m600(arg0, 0, Local0, Ones)

		Store(LEqual(0x322, bf61), Local0)
		m600(arg0, 1, Local0, Zero)

		Store(LEqual(0x320, bf61), Local0)
		m600(arg0, 2, Local0, Zero)

		Store(LEqual(aui1, bf61), Local0)
		m600(arg0, 3, Local0, Ones)

		Store(LEqual(auig, bf61), Local0)
		m600(arg0, 4, Local0, Zero)

		Store(LEqual(auih, bf61), Local0)
		m600(arg0, 5, Local0, Zero)

		if (y078) {
			Store(LEqual(Derefof(Refof(aui1)), bf61), Local0)
			m600(arg0, 6, Local0, Ones)

			Store(LEqual(Derefof(Refof(auig)), bf61), Local0)
			m600(arg0, 7, Local0, Zero)

			Store(LEqual(Derefof(Refof(auih)), bf61), Local0)
			m600(arg0, 8, Local0, Zero)
		}

		Store(LEqual(Derefof(Index(paui, 1)), bf61), Local0)
		m600(arg0, 9, Local0, Ones)

		Store(LEqual(Derefof(Index(paui, 16)), bf61), Local0)
		m600(arg0, 10, Local0, Zero)

		Store(LEqual(Derefof(Index(paui, 17)), bf61), Local0)
		m600(arg0, 11, Local0, Zero)

		// Method returns Integer

		Store(LEqual(m601(1, 1), bf61), Local0)
		m600(arg0, 12, Local0, Ones)

		Store(LEqual(m601(1, 16), bf61), Local0)
		m600(arg0, 13, Local0, Zero)

		Store(LEqual(m601(1, 17), bf61), Local0)
		m600(arg0, 14, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LEqual(Derefof(m602(1, 1, 1)), bf61), Local0)
			m600(arg0, 15, Local0, Ones)

			Store(LEqual(Derefof(m602(1, 16, 1)), bf61), Local0)
			m600(arg0, 16, Local0, Zero)

			Store(LEqual(Derefof(m602(1, 17, 1)), bf61), Local0)
			m600(arg0, 17, Local0, Zero)
		}

		// LGreater

		Store(LGreater(0x321, bf61), Local0)
		m600(arg0, 18, Local0, Zero)

		Store(LGreater(0x322, bf61), Local0)
		m600(arg0, 19, Local0, Ones)

		Store(LGreater(0x320, bf61), Local0)
		m600(arg0, 20, Local0, Zero)

		Store(LGreater(aui1, bf61), Local0)
		m600(arg0, 21, Local0, Zero)

		Store(LGreater(auig, bf61), Local0)
		m600(arg0, 22, Local0, Ones)

		Store(LGreater(auih, bf61), Local0)
		m600(arg0, 23, Local0, Zero)

		if (y078) {
			Store(LGreater(Derefof(Refof(aui1)), bf61), Local0)
			m600(arg0, 24, Local0, Zero)

			Store(LGreater(Derefof(Refof(auig)), bf61), Local0)
			m600(arg0, 25, Local0, Ones)

			Store(LGreater(Derefof(Refof(auih)), bf61), Local0)
			m600(arg0, 26, Local0, Zero)
		}

		Store(LGreater(Derefof(Index(paui, 1)), bf61), Local0)
		m600(arg0, 27, Local0, Zero)

		Store(LGreater(Derefof(Index(paui, 16)), bf61), Local0)
		m600(arg0, 28, Local0, Ones)

		Store(LGreater(Derefof(Index(paui, 17)), bf61), Local0)
		m600(arg0, 29, Local0, Zero)

		// Method returns Integer

		Store(LGreater(m601(1, 1), bf61), Local0)
		m600(arg0, 30, Local0, Zero)

		Store(LGreater(m601(1, 16), bf61), Local0)
		m600(arg0, 31, Local0, Ones)

		Store(LGreater(m601(1, 17), bf61), Local0)
		m600(arg0, 32, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreater(Derefof(m602(1, 1, 1)), bf61), Local0)
			m600(arg0, 33, Local0, Zero)

			Store(LGreater(Derefof(m602(1, 16, 1)), bf61), Local0)
			m600(arg0, 34, Local0, Ones)

			Store(LGreater(Derefof(m602(1, 17, 1)), bf61), Local0)
			m600(arg0, 35, Local0, Zero)
		}

		// LGreaterEqual

		Store(LGreaterEqual(0x321, bf61), Local0)
		m600(arg0, 36, Local0, Ones)

		Store(LGreaterEqual(0x322, bf61), Local0)
		m600(arg0, 37, Local0, Ones)

		Store(LGreaterEqual(0x320, bf61), Local0)
		m600(arg0, 38, Local0, Zero)

		Store(LGreaterEqual(aui1, bf61), Local0)
		m600(arg0, 39, Local0, Ones)

		Store(LGreaterEqual(auig, bf61), Local0)
		m600(arg0, 40, Local0, Ones)

		Store(LGreaterEqual(auih, bf61), Local0)
		m600(arg0, 41, Local0, Zero)

		if (y078) {
			Store(LGreaterEqual(Derefof(Refof(aui1)), bf61), Local0)
			m600(arg0, 42, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auig)), bf61), Local0)
			m600(arg0, 43, Local0, Ones)

			Store(LGreaterEqual(Derefof(Refof(auih)), bf61), Local0)
			m600(arg0, 44, Local0, Zero)
		}

		Store(LGreaterEqual(Derefof(Index(paui, 1)), bf61), Local0)
		m600(arg0, 45, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 16)), bf61), Local0)
		m600(arg0, 46, Local0, Ones)

		Store(LGreaterEqual(Derefof(Index(paui, 17)), bf61), Local0)
		m600(arg0, 47, Local0, Zero)

		// Method returns Integer

		Store(LGreaterEqual(m601(1, 1), bf61), Local0)
		m600(arg0, 48, Local0, Ones)

		Store(LGreaterEqual(m601(1, 16), bf61), Local0)
		m600(arg0, 49, Local0, Ones)

		Store(LGreaterEqual(m601(1, 17), bf61), Local0)
		m600(arg0, 50, Local0, Zero)

		// Method returns Reference to Integer

		if (y500) {
			Store(LGreaterEqual(Derefof(m602(1, 1, 1)), bf61), Local0)
			m600(arg0, 51, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 16, 1)), bf61), Local0)
			m600(arg0, 52, Local0, Ones)

			Store(LGreaterEqual(Derefof(m602(1, 17, 1)), bf61), Local0)
			m600(arg0, 53, Local0, Zero)
		}

		// LLess

		Store(LLess(0x321, bf61), Local0)
		m600(arg0, 54, Local0, Zero)

		Store(LLess(0x322, bf61), Local0)
		m600(arg0, 55, Local0, Zero)

		Store(LLess(0x320, bf61), Local0)
		m600(arg0, 56, Local0, Ones)

		Store(LLess(aui1, bf61), Local0)
		m600(arg0, 57, Local0, Zero)

		Store(LLess(auig, bf61), Local0)
		m600(arg0, 58, Local0, Zero)

		Store(LLess(auih, bf61), Local0)
		m600(arg0, 59, Local0, Ones)

		if (y078) {
			Store(LLess(Derefof(Refof(aui1)), bf61), Local0)
			m600(arg0, 60, Local0, Zero)

			Store(LLess(Derefof(Refof(auig)), bf61), Local0)
			m600(arg0, 61, Local0, Zero)

			Store(LLess(Derefof(Refof(auih)), bf61), Local0)
			m600(arg0, 62, Local0, Ones)
		}

		Store(LLess(Derefof(Index(paui, 1)), bf61), Local0)
		m600(arg0, 63, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 16)), bf61), Local0)
		m600(arg0, 64, Local0, Zero)

		Store(LLess(Derefof(Index(paui, 17)), bf61), Local0)
		m600(arg0, 65, Local0, Ones)

		// Method returns Integer

		Store(LLess(m601(1, 1), bf61), Local0)
		m600(arg0, 66, Local0, Zero)

		Store(LLess(m601(1, 16), bf61), Local0)
		m600(arg0, 67, Local0, Zero)

		Store(LLess(m601(1, 17), bf61), Local0)
		m600(arg0, 68, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLess(Derefof(m602(1, 1, 1)), bf61), Local0)
			m600(arg0, 69, Local0, Zero)

			Store(LLess(Derefof(m602(1, 16, 1)), bf61), Local0)
			m600(arg0, 70, Local0, Zero)

			Store(LLess(Derefof(m602(1, 17, 1)), bf61), Local0)
			m600(arg0, 71, Local0, Ones)
		}

		// LLessEqual

		Store(LLessEqual(0x321, bf61), Local0)
		m600(arg0, 72, Local0, Ones)

		Store(LLessEqual(0x322, bf61), Local0)
		m600(arg0, 73, Local0, Zero)

		Store(LLessEqual(0x320, bf61), Local0)
		m600(arg0, 74, Local0, Ones)

		Store(LLessEqual(aui1, bf61), Local0)
		m600(arg0, 75, Local0, Ones)

		Store(LLessEqual(auig, bf61), Local0)
		m600(arg0, 76, Local0, Zero)

		Store(LLessEqual(auih, bf61), Local0)
		m600(arg0, 77, Local0, Ones)

		if (y078) {
			Store(LLessEqual(Derefof(Refof(aui1)), bf61), Local0)
			m600(arg0, 78, Local0, Ones)

			Store(LLessEqual(Derefof(Refof(auig)), bf61), Local0)
			m600(arg0, 79, Local0, Zero)

			Store(LLessEqual(Derefof(Refof(auih)), bf61), Local0)
			m600(arg0, 80, Local0, Ones)
		}

		Store(LLessEqual(Derefof(Index(paui, 1)), bf61), Local0)
		m600(arg0, 81, Local0, Ones)

		Store(LLessEqual(Derefof(Index(paui, 16)), bf61), Local0)
		m600(arg0, 82, Local0, Zero)

		Store(LLessEqual(Derefof(Index(paui, 17)), bf61), Local0)
		m600(arg0, 83, Local0, Ones)

		// Method returns Integer

		Store(LLessEqual(m601(1, 1), bf61), Local0)
		m600(arg0, 84, Local0, Ones)

		Store(LLessEqual(m601(1, 16), bf61), Local0)
		m600(arg0, 85, Local0, Zero)

		Store(LLessEqual(m601(1, 17), bf61), Local0)
		m600(arg0, 86, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LLessEqual(Derefof(m602(1, 1, 1)), bf61), Local0)
			m600(arg0, 87, Local0, Ones)

			Store(LLessEqual(Derefof(m602(1, 16, 1)), bf61), Local0)
			m600(arg0, 88, Local0, Zero)

			Store(LLessEqual(Derefof(m602(1, 17, 1)), bf61), Local0)
			m600(arg0, 89, Local0, Ones)
		}

		// LNotEqual

		Store(LNotEqual(0x321, bf61), Local0)
		m600(arg0, 90, Local0, Zero)

		Store(LNotEqual(0x322, bf61), Local0)
		m600(arg0, 91, Local0, Ones)

		Store(LNotEqual(0x320, bf61), Local0)
		m600(arg0, 92, Local0, Ones)

		Store(LNotEqual(aui1, bf61), Local0)
		m600(arg0, 93, Local0, Zero)

		Store(LNotEqual(auig, bf61), Local0)
		m600(arg0, 94, Local0, Ones)

		Store(LNotEqual(auih, bf61), Local0)
		m600(arg0, 95, Local0, Ones)

		if (y078) {
			Store(LNotEqual(Derefof(Refof(aui1)), bf61), Local0)
			m600(arg0, 96, Local0, Zero)

			Store(LNotEqual(Derefof(Refof(auig)), bf61), Local0)
			m600(arg0, 97, Local0, Ones)

			Store(LNotEqual(Derefof(Refof(auih)), bf61), Local0)
			m600(arg0, 98, Local0, Ones)
		}

		Store(LNotEqual(Derefof(Index(paui, 1)), bf61), Local0)
		m600(arg0, 99, Local0, Zero)

		Store(LNotEqual(Derefof(Index(paui, 16)), bf61), Local0)
		m600(arg0, 100, Local0, Ones)

		Store(LNotEqual(Derefof(Index(paui, 17)), bf61), Local0)
		m600(arg0, 101, Local0, Ones)

		// Method returns Integer

		Store(LNotEqual(m601(1, 1), bf61), Local0)
		m600(arg0, 102, Local0, Zero)

		Store(LNotEqual(m601(1, 16), bf61), Local0)
		m600(arg0, 103, Local0, Ones)

		Store(LNotEqual(m601(1, 17), bf61), Local0)
		m600(arg0, 104, Local0, Ones)

		// Method returns Reference to Integer

		if (y500) {
			Store(LNotEqual(Derefof(m602(1, 1, 1)), bf61), Local0)
			m600(arg0, 105, Local0, Zero)

			Store(LNotEqual(Derefof(m602(1, 16, 1)), bf61), Local0)
			m600(arg0, 106, Local0, Ones)

			Store(LNotEqual(Derefof(m602(1, 17, 1)), bf61), Local0)
			m600(arg0, 107, Local0, Ones)
		}
	}

	// Buffer Field to Integer intermediate conversion of the Buffer Field
	// second operand of Concatenate operator in case the first one is Integer

	Method(m64q, 1)
	{		
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		Store(Concatenate(0x321, bf61), Local0)
		m600(arg0, 0, Local0, bb26)

		Store(Concatenate(0x321, bf65), Local0)
		m600(arg0, 1, Local0, bb21)


		Store(Concatenate(aui1, bf61), Local0)
		m600(arg0, 2, Local0, bb26)

		Store(Concatenate(aui1, bf65), Local0)
		m600(arg0, 3, Local0, bb21)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aui1)), bf61), Local0)
			m600(arg0, 4, Local0, bb26)

			Store(Concatenate(Derefof(Refof(aui1)), bf65), Local0)
			m600(arg0, 5, Local0, bb21)
		}

		Store(Concatenate(Derefof(Index(paui, 1)), bf61), Local0)
		m600(arg0, 6, Local0, bb26)

		Store(Concatenate(Derefof(Index(paui, 1)), bf65), Local0)
		m600(arg0, 7, Local0, bb21)

		// Method returns Integer

		Store(Concatenate(m601(1, 1), bf61), Local0)
		m600(arg0, 8, Local0, bb26)

		Store(Concatenate(m601(1, 1), bf65), Local0)
		m600(arg0, 9, Local0, bb21)

		// Method returns Reference to Integer

		if (y500) {
			Store(Concatenate(Derefof(m602(1, 1, 1)), bf61), Local0)
			m600(arg0, 10, Local0, bb26)

			Store(Concatenate(Derefof(m602(1, 1, 1)), bf65), Local0)
			m600(arg0, 11, Local0, bb21)
		}

		Concatenate(0x321, bf61, Local0)
		m600(arg0, 12, Local0, bb26)

		Concatenate(0x321, bf65, Local0)
		m600(arg0, 13, Local0, bb21)


		Concatenate(aui1, bf61, Local0)
		m600(arg0, 14, Local0, bb26)

		Concatenate(aui1, bf65, Local0)
		m600(arg0, 15, Local0, bb21)

		if (y078) {
			Concatenate(Derefof(Refof(aui1)), bf61, Local0)
			m600(arg0, 16, Local0, bb26)

			Concatenate(Derefof(Refof(aui1)), bf65, Local0)
			m600(arg0, 17, Local0, bb21)
		}

		Concatenate(Derefof(Index(paui, 1)), bf61, Local0)
		m600(arg0, 18, Local0, bb26)

		Concatenate(Derefof(Index(paui, 1)), bf65, Local0)
		m600(arg0, 19, Local0, bb21)

		// Method returns Integer

		Concatenate(m601(1, 1), bf61, Local0)
		m600(arg0, 20, Local0, bb26)

		Concatenate(m601(1, 1), bf65, Local0)
		m600(arg0, 21, Local0, bb21)

		// Method returns Reference to Integer

		if (y500) {
			Concatenate(Derefof(m602(1, 1, 1)), bf61, Local0)
			m600(arg0, 22, Local0, bb26)

			Concatenate(Derefof(m602(1, 1, 1)), bf65, Local0)
			m600(arg0, 23, Local0, bb21)
		}
	}

	Method(m32q, 1)
	{		
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		Store(Concatenate(0x321, bf61), Local0)
		m600(arg0, 0, Local0, bb27)

		Store(Concatenate(0x321, bf65), Local0)
		m600(arg0, 1, Local0, bb28)


		Store(Concatenate(aui1, bf61), Local0)
		m600(arg0, 2, Local0, bb27)

		Store(Concatenate(aui1, bf65), Local0)
		m600(arg0, 3, Local0, bb28)

		if (y078) {
			Store(Concatenate(Derefof(Refof(aui1)), bf61), Local0)
			m600(arg0, 4, Local0, bb27)

			Store(Concatenate(Derefof(Refof(aui1)), bf65), Local0)
			m600(arg0, 5, Local0, bb28)
		}

		Store(Concatenate(Derefof(Index(paui, 1)), bf61), Local0)
		m600(arg0, 6, Local0, bb27)

		Store(Concatenate(Derefof(Index(paui, 1)), bf65), Local0)
		m600(arg0, 7, Local0, bb28)

		// Method returns Integer

		Store(Concatenate(m601(1, 1), bf61), Local0)
		m600(arg0, 8, Local0, bb27)

		Store(Concatenate(m601(1, 1), bf65), Local0)
		m600(arg0, 9, Local0, bb28)

		// Method returns Reference to Integer

		if (y500) {
			Store(Concatenate(Derefof(m602(1, 1, 1)), bf61), Local0)
			m600(arg0, 10, Local0, bb27)

			Store(Concatenate(Derefof(m602(1, 1, 1)), bf65), Local0)
			m600(arg0, 11, Local0, bb28)
		}

		Concatenate(0x321, bf61, Local0)
		m600(arg0, 12, Local0, bb27)

		Concatenate(0x321, bf65, Local0)
		m600(arg0, 13, Local0, bb28)


		Concatenate(aui1, bf61, Local0)
		m600(arg0, 14, Local0, bb27)

		Concatenate(aui1, bf65, Local0)
		m600(arg0, 15, Local0, bb28)

		if (y078) {
			Concatenate(Derefof(Refof(aui1)), bf61, Local0)
			m600(arg0, 16, Local0, bb27)

			Concatenate(Derefof(Refof(aui1)), bf65, Local0)
			m600(arg0, 17, Local0, bb28)
		}

		Concatenate(Derefof(Index(paui, 1)), bf61, Local0)
		m600(arg0, 18, Local0, bb27)

		Concatenate(Derefof(Index(paui, 1)), bf65, Local0)
		m600(arg0, 20, Local0, bb28)

		// Method returns Integer

		Concatenate(m601(1, 1), bf61, Local0)
		m600(arg0, 21, Local0, bb27)

		Concatenate(m601(1, 1), bf65, Local0)
		m600(arg0, 22, Local0, bb28)

		// Method returns Reference to Integer

		if (y500) {
			Concatenate(Derefof(m602(1, 1, 1)), bf61, Local0)
			m600(arg0, 23, Local0, bb27)

			Concatenate(Derefof(m602(1, 1, 1)), bf65, Local0)
			m600(arg0, 24, Local0, bb28)
		}
	}

	// Buffer Field to Integer conversion of the Buffer Field Length
	// (second) operand of the ToString operator

	// Common 32-bit/64-bit test
	Method(m066, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b641, 420, 33, bf74)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(0xb, bf74)

		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			bf74), Local0)
		m600(arg0, 0, Local0, bs1b)

		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			bf61), Local0)
		m600(arg0, 1, Local0, bs1c)

		Store(ToString(aub6, bf74), Local0)
		m600(arg0, 2, Local0, bs1b)

		Store(ToString(aub6, bf61), Local0)
		m600(arg0, 3, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), bf74), Local0)
			m600(arg0, 4, Local0, bs1b)

			Store(ToString(Derefof(Refof(aub6)), bf61), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), bf74), Local0)
		m600(arg0, 6, Local0, bs1b)

		Store(ToString(Derefof(Index(paub, 6)), bf61), Local0)
		m600(arg0, 7, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), bf74), Local0)
		m600(arg0, 8, Local0, bs1b)

		Store(ToString(m601(3, 6), bf61), Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), bf74), Local0)
			m600(arg0, 10, Local0, bs1b)

			Store(ToString(Derefof(m602(3, 6, 1)), bf61), Local0)
			m600(arg0, 11, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			bf74, Local0)
		m600(arg0, 12, Local0, bs1b)

		ToString(Buffer() {"This is auxiliary Buffer"},
			bf61, Local0)
		m600(arg0, 13, Local0, bs1c)

		ToString(aub6, bf74, Local0)
		m600(arg0, 14, Local0, bs1b)

		ToString(aub6, bf61, Local0)
		m600(arg0, 15, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), bf74, Local0)
			m600(arg0, 16, Local0, bs1b)

			ToString(Derefof(Refof(aub6)), bf61, Local0)
			m600(arg0, 17, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), bf74, Local0)
		m600(arg0, 18, Local0, bs1b)

		ToString(Derefof(Index(paub, 6)), bf61, Local0)
		m600(arg0, 19, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), bf74, Local0)
		m600(arg0, 20, Local0, bs1b)

		ToString(m601(3, 6), bf61, Local0)
		m600(arg0, 21, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), bf74, Local0)
			m600(arg0, 22, Local0, bs1b)

			ToString(Derefof(m602(3, 6, 1)), bf61, Local0)
			m600(arg0, 23, Local0, bs1c)
		}
	}

	Method(m64r, 1)
	{
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			bf65), Local0)
		m600(arg0, 0, Local0, bs1c)

		Store(ToString(aub6, bf65), Local0)
		m600(arg0, 1, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), bf65), Local0)
			m600(arg0, 2, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), bf65), Local0)
		m600(arg0, 3, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), bf65), Local0)
		m600(arg0, 4, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), bf65), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			bf65, Local0)
		m600(arg0, 6, Local0, bs1c)

		ToString(aub6, bf65, Local0)
		m600(arg0, 7, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), bf65, Local0)
			m600(arg0, 8, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), bf65, Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), bf65, Local0)
		m600(arg0, 10, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), bf65, Local0)
			m600(arg0, 11, Local0, bs1c)
		}
	}

	Method(m32r, 1)
	{
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		Store(ToString(Buffer() {"This is auxiliary Buffer"},
			bf65), Local0)
		m600(arg0, 0, Local0, bs1c)

		Store(ToString(aub6, bf65), Local0)
		m600(arg0, 1, Local0, bs1c)

		if (y078) {
			Store(ToString(Derefof(Refof(aub6)), bf65), Local0)
			m600(arg0, 2, Local0, bs1c)
		}

		Store(ToString(Derefof(Index(paub, 6)), bf65), Local0)
		m600(arg0, 3, Local0, bs1c)

		// Method returns Buffer

		Store(ToString(m601(3, 6), bf65), Local0)
		m600(arg0, 4, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			Store(ToString(Derefof(m602(3, 6, 1)), bf65), Local0)
			m600(arg0, 5, Local0, bs1c)
		}

		ToString(Buffer() {"This is auxiliary Buffer"},
			bf65, Local0)
		m600(arg0, 6, Local0, bs1c)

		ToString(aub6, bf65, Local0)
		m600(arg0, 7, Local0, bs1c)

		if (y078) {
			ToString(Derefof(Refof(aub6)), bf65, Local0)
			m600(arg0, 8, Local0, bs1c)
		}

		ToString(Derefof(Index(paub, 6)), bf65, Local0)
		m600(arg0, 9, Local0, bs1c)

		// Method returns Buffer

		ToString(m601(3, 6), bf65, Local0)
		m600(arg0, 10, Local0, bs1c)

		// Method returns Reference to Buffer

		if (y500) {
			ToString(Derefof(m602(3, 6, 1)), bf65, Local0)
			m600(arg0, 11, Local0, bs1c)
		}
	}

	// Buffer Field to Integer conversion of the Buffer Field Index
	// (second) operand of the Index operator
	Method(m067, 1)
	{
		CreateField(b641, 420, 33, bf74)

		Store(0xb, bf74)

		Store(Index(aus6, bf74), Local0)
		m600(arg0, 0, Derefof(Local0), bi10)

		Store(Index(aub6, bf74), Local0)
		m600(arg0, 1, Derefof(Local0), bi10)

		Store(Index(aup0, bf74), Local0)
		m600(arg0, 2, Derefof(Local0), bi11)

		if (y078) {
			Store(Index(Derefof(Refof(aus6)), bf74), Local0)
			m600(arg0, 3, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aub6)), bf74), Local0)
			m600(arg0, 4, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aup0)), bf74), Local0)
			m600(arg0, 5, Derefof(Local0), bi11)
		}

		Store(Index(Derefof(Index(paus, 6)), bf74), Local0)
		m600(arg0, 6, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paub, 6)), bf74), Local0)
		m600(arg0, 7, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paup, 0)), bf74), Local0)
		m600(arg0, 8, Derefof(Local0), bi11)


		// Method returns Object

		if (y900) {
			Store(Index(m601(2, 6), bf74), Local0)
			m600(arg0, 9, Derefof(Local0), bi10)

			Store(Index(m601(3, 6), bf74), Local0)
			m600(arg0, 10, Derefof(Local0), bi10)

			Store(Index(m601(4, 0), bf74), Local0)
			m600(arg0, 11, Derefof(Local0), bi11)
		} else {

			CH03(arg0, z089, 0, 0, 0)

			Store(Index(m601(2, 6), bf74), Local3)
			CH04(arg0, 0, 85, z089, 9, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Store(Index(m601(3, 6), bf74), Local3)
			CH04(arg0, 0, 85, z089, 10, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Store(Index(m601(4, 0), bf74), Local3)
			CH04(arg0, 0, 85, z089, 11, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED
		}

		// Method returns Reference

		if (y500) {
			Store(Index(Derefof(m602(2, 6, 1)), bf74), Local0)
			m600(arg0, 12, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(3, 6, 1)), bf74), Local0)
			m600(arg0, 13, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(4, 0, 1)), bf74), Local0)
			m600(arg0, 14, Derefof(Local0), bi11)
		}

		Index(aus6, bf74, Local0)
		m600(arg0, 15, Derefof(Local0), bi10)

		Index(aub6, bf74, Local0)
		m600(arg0, 16, Derefof(Local0), bi10)

		Index(aup0, bf74, Local0)
		m600(arg0, 17, Derefof(Local0), bi11)

		if (y078) {
			Index(Derefof(Refof(aus6)), bf74, Local0)
			m600(arg0, 18, Derefof(Local0), bi10)

			Index(Derefof(Refof(aub6)), bf74, Local0)
			m600(arg0, 19, Derefof(Local0), bi10)

			Index(Derefof(Refof(aup0)), bf74, Local0)
			m600(arg0, 20, Derefof(Local0), bi11)
		}

		Index(Derefof(Index(paus, 6)), bf74, Local0)
		m600(arg0, 21, Derefof(Local0), bi10)

		Index(Derefof(Index(paub, 6)), bf74, Local0)
		m600(arg0, 22, Derefof(Local0), bi10)

		Index(Derefof(Index(paup, 0)), bf74, Local0)
		m600(arg0, 23, Derefof(Local0), bi11)


		// Method returns Object

		if (y900) {
			Index(m601(2, 6), bf74, Local0)
			m600(arg0, 24, Derefof(Local0), bi10)

			Index(m601(3, 6), bf74, Local0)
			m600(arg0, 25, Derefof(Local0), bi10)

			Index(m601(4, 0), bf74, Local0)
			m600(arg0, 26, Derefof(Local0), bi11)
		} else {

			CH03(arg0, z088, 0, 0, 0)

			Index(m601(2, 6), bf74, Local0)
			CH04(arg0, 0, 85, z088, 24, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Index(m601(3, 6), bf74, Local0)
			CH04(arg0, 0, 85, z088, 25, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED

			Index(m601(4, 0), bf74, Local0)
			CH04(arg0, 0, 85, z088, 26, 0, 0)	// AE_INDEX_TO_NOT_ATTACHED
		}

		// Method returns Reference

		if (y500) {
			Index(Derefof(m602(2, 6, 1)), bf74, Local0)
			m600(arg0, 27, Derefof(Local0), bi10)

			Index(Derefof(m602(3, 6, 1)), bf74, Local0)
			m600(arg0, 28, Derefof(Local0), bi10)

			Index(Derefof(m602(4, 0, 1)), bf74, Local0)
			m600(arg0, 29, Derefof(Local0), bi11)
		}

		if (y098) {
			Store(Index(aus6, bf74, Local1), Local0)
			m600(arg0, 30, Derefof(Local0), bi10)

			Store(Index(aub6, bf74, Local1), Local0)
			m600(arg0, 31, Derefof(Local0), bi10)

			Store(Index(aup0, bf74, Local1), Local0)
			m600(arg0, 32, Derefof(Local0), bi11)
		}

		if (y078) {
			Store(Index(Derefof(Refof(aus6)), bf74, Local1), Local0)
			m600(arg0, 33, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aub6)), bf74, Local1), Local0)
			m600(arg0, 34, Derefof(Local0), bi10)

			Store(Index(Derefof(Refof(aup0)), bf74, Local1), Local0)
			m600(arg0, 35, Derefof(Local0), bi11)
		}

		if (y098) {
		Store(Index(Derefof(Index(paus, 6)), bf74, Local1), Local0)
		m600(arg0, 36, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paub, 6)), bf74, Local1), Local0)
		m600(arg0, 37, Derefof(Local0), bi10)

		Store(Index(Derefof(Index(paup, 0)), bf74, Local1), Local0)
		m600(arg0, 38, Derefof(Local0), bi11)
		}

		// Method returns Object

		if (LAnd(y900, y098)) {
			Store(Index(m601(2, 6), bf74, Local1), Local0)
			m600(arg0, 39, Derefof(Local0), bi10)

			Store(Index(m601(3, 6), bf74, Local1), Local0)
			m600(arg0, 40, Derefof(Local0), bi10)

			Store(Index(m601(4, 0), bf74, Local1), Local0)
			m600(arg0, 41, Derefof(Local0), bi11)
		}

		// Method returns Reference

		if (y500) {
			Store(Index(Derefof(m602(2, 6, 1)), bf74, Local1), Local0)
			m600(arg0, 42, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(3, 6, 1)), bf74, Local1), Local0)
			m600(arg0, 43, Derefof(Local0), bi10)

			Store(Index(Derefof(m602(4, 0, 1)), bf74, Local1), Local0)
			m600(arg0, 44, Derefof(Local0), bi11)
		}
	}

	// Buffer Field to Integer conversion of the Buffer Field Arg (third)
	// operand of the Fatal operator
	// (it can only be checked an exception does not occur)
	Method(m068, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)

		CH03(arg0, z089, 0, 0, 0)
		Fatal(0xff, 0xffffffff, bf61)
		if (F64) {
			Fatal(0xff, 0xffffffff, bf65)
		} else {
			Fatal(0xff, 0xffffffff, bf65)
		}
		CH03(arg0, z089, 1, 0, 0)
	}

	// Buffer Field to Integer conversion of the Buffer Field Index
	// and Length operands of the Mid operator

	// Common 32-bit/64-bit test
	Method(m069, 1)
	{
		CreateField(b641, 420, 33, bf74)

		Store(0xb, bf74)

		// Buffer Field to Integer conversion of the Buffer Field Index operand

		Store(Mid("This is auxiliary String", bf74, 10), Local0)
		m600(arg0, 0, Local0, bs1d)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, bf74, 10), Local0)
		m600(arg0, 1, Local0, bb32)

		Store(Mid(aus6, bf74, 10), Local0)
		m600(arg0, 2, Local0, bs1d)

		Store(Mid(aub6, bf74, 10), Local0)
		m600(arg0, 3, Local0, bb32)


		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), bf74, 10), Local0)
			m600(arg0, 4, Local0, bs1d)

			Store(Mid(Derefof(Refof(aub6)), bf74, 10), Local0)
			m600(arg0, 5, Local0, bb32)
		}

		Store(Mid(Derefof(Index(paus, 6)), bf74, 10), Local0)
		m600(arg0, 6, Local0, bs1d)

		Store(Mid(Derefof(Index(paub, 6)), bf74, 10), Local0)
		m600(arg0, 7, Local0, bb32)

		// Method returns Object

		Store(Mid(m601(2, 6), bf74, 10), Local0)
		m600(arg0, 8, Local0, bs1d)

		Store(Mid(m601(3, 6), bf74, 10), Local0)
		m600(arg0, 9, Local0, bb32)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), bf74, 10), Local0)
			m600(arg0, 10, Local0, bs1d)

			Store(Mid(Derefof(m602(3, 6, 1)), bf74, 10), Local0)
			m600(arg0, 11, Local0, bb32)
		}

		Mid("This is auxiliary String", bf74, 10, Local0)
		m600(arg0, 12, Local0, bs1d)

		Mid(Buffer(){"This is auxiliary Buffer"}, bf74, 10, Local0)
		m600(arg0, 13, Local0, bb32)

		Mid(aus6, bf74, 10, Local0)
		m600(arg0, 14, Local0, bs1d)

		Mid(aub6, bf74, 10, Local0)
		m600(arg0, 15, Local0, bb32)


		if (y078) {
			Mid(Derefof(Refof(aus6)), bf74, 10, Local0)
			m600(arg0, 16, Local0, bs1d)

			Mid(Derefof(Refof(aub6)), bf74, 10, Local0)
			m600(arg0, 17, Local0, bb32)
		}

		Mid(Derefof(Index(paus, 6)), bf74, 10, Local0)
		m600(arg0, 18, Local0, bs1d)

		Mid(Derefof(Index(paub, 6)), bf74, 10, Local0)
		m600(arg0, 19, Local0, bb32)

		// Method returns Object

		Mid(m601(2, 6), bf74, 10, Local0)
		m600(arg0, 20, Local0, bs1d)

		Mid(m601(3, 6), bf74, 10, Local0)
		m600(arg0, 21, Local0, bb32)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), bf74, 10, Local0)
			m600(arg0, 22, Local0, bs1d)

			Mid(Derefof(m602(3, 6, 1)), bf74, 10, Local0)
			m600(arg0, 23, Local0, bb32)
		}

		// Buffer Field to Integer conversion of the Buffer Field Length operand

		Store(Mid("This is auxiliary String", 0, bf74), Local0)
		m600(arg0, 24, Local0, bs1b)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, bf74), Local0)
		m600(arg0, 25, Local0, bb33)

		Store(Mid(aus6, 0, bf74), Local0)
		m600(arg0, 26, Local0, bs1b)

		Store(Mid(aub6, 0, bf74), Local0)
		m600(arg0, 27, Local0, bb33)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, bf74), Local0)
			m600(arg0, 28, Local0, bs1b)

			Store(Mid(Derefof(Refof(aub6)), 0, bf74), Local0)
			m600(arg0, 29, Local0, bb33)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, bf74), Local0)
		m600(arg0, 30, Local0, bs1b)

		Store(Mid(Derefof(Index(paub, 6)), 0, bf74), Local0)
		m600(arg0, 31, Local0, bb33)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, bf74), Local0)
		m600(arg0, 32, Local0, bs1b)

		Store(Mid(m601(3, 6), 0, bf74), Local0)
		m600(arg0, 33, Local0, bb33)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, bf74), Local0)
			m600(arg0, 34, Local0, bs1b)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, bf74), Local0)
			m600(arg0, 35, Local0, bb33)
		}

		Mid("This is auxiliary String", 0, bf74, Local0)
		m600(arg0, 36, Local0, bs1b)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, bf74, Local0)
		m600(arg0, 37, Local0, bb33)

		Mid(aus6, 0, bf74, Local0)
		m600(arg0, 37, Local0, bs1b)

		Mid(aub6, 0, bf74, Local0)
		m600(arg0, 39, Local0, bb33)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, bf74, Local0)
			m600(arg0, 40, Local0, bs1b)

			Mid(Derefof(Refof(aub6)), 0, bf74, Local0)
			m600(arg0, 41, Local0, bb33)
		}

		Mid(Derefof(Index(paus, 6)), 0, bf74, Local0)
		m600(arg0, 42, Local0, bs1b)

		Mid(Derefof(Index(paub, 6)), 0, bf74, Local0)
		m600(arg0, 43, Local0, bb33)

		// Method returns Object

		Mid(m601(2, 6), 0, bf74, Local0)
		m600(arg0, 44, Local0, bs1b)

		Mid(m601(3, 6), 0, bf74, Local0)
		m600(arg0, 45, Local0, bb33)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, bf74, Local0)
			m600(arg0, 46, Local0, bs1b)

			Mid(Derefof(m602(3, 6, 1)), 0, bf74, Local0)
			m600(arg0, 47, Local0, bb33)
		}
	}

	Method(m64s, 1)
	{
		CreateField(b640, 159, 64, bf65)
		CreateField(b641, 420, 33, bf74)

		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)
		Store(0xb, bf74)

		// Buffer Field to Integer conversion of the Buffer Field Length operand

		Store(Mid("This is auxiliary String", 0, bf65), Local0)
		m600(arg0, 0, Local0, bs1e)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, bf65), Local0)
		m600(arg0, 1, Local0, bb34)

		Store(Mid(aus6, 0, bf65), Local0)
		m600(arg0, 2, Local0, bs1e)

		Store(Mid(aub6, 0, bf65), Local0)
		m600(arg0, 3, Local0, bb34)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, bf65), Local0)
			m600(arg0, 4, Local0, bs1e)

			Store(Mid(Derefof(Refof(aub6)), 0, bf65), Local0)
			m600(arg0, 5, Local0, bb34)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, bf65), Local0)
		m600(arg0, 6, Local0, bs1e)

		Store(Mid(Derefof(Index(paub, 6)), 0, bf65), Local0)
		m600(arg0, 7, Local0, bb34)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, bf65), Local0)
		m600(arg0, 8, Local0, bs1e)

		Store(Mid(m601(3, 6), 0, bf65), Local0)
		m600(arg0, 9, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, bf65), Local0)
			m600(arg0, 10, Local0, bs1e)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, bf65), Local0)
			m600(arg0, 11, Local0, bb34)
		}

		Mid("This is auxiliary String", 0, bf65, Local0)
		m600(arg0, 12, Local0, bs1e)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, bf65, Local0)
		m600(arg0, 13, Local0, bb34)

		Mid(aus6, 0, bf65, Local0)
		m600(arg0, 14, Local0, bs1e)

		Mid(aub6, 0, bf65, Local0)
		m600(arg0, 15, Local0, bb34)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, bf65, Local0)
			m600(arg0, 16, Local0, bs1e)

			Mid(Derefof(Refof(aub6)), 0, bf65, Local0)
			m600(arg0, 17, Local0, bb34)
		}

		Mid(Derefof(Index(paus, 6)), 0, bf65, Local0)
		m600(arg0, 18, Local0, bs1e)

		Mid(Derefof(Index(paub, 6)), 0, bf65, Local0)
		m600(arg0, 19, Local0, bb34)

		// Method returns Object

		Mid(m601(2, 6), 0, bf65, Local0)
		m600(arg0, 20, Local0, bs1e)

		Mid(m601(3, 6), 0, bf65, Local0)
		m600(arg0, 21, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, bf65, Local0)
			m600(arg0, 22, Local0, bs1e)

			Mid(Derefof(m602(3, 6, 1)), 0, bf65, Local0)
			m600(arg0, 23, Local0, bb34)
		}

		// Buffer Field to Integer conversion of the both String operands

		Store(Mid("This is auxiliary String", bf74, bf65), Local0)
		m600(arg0, 24, Local0, bs1f)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, bf74, bf65), Local0)
		m600(arg0, 25, Local0, bb35)

		Store(Mid(aus6, bf74, bf65), Local0)
		m600(arg0, 26, Local0, bs1f)

		Store(Mid(aub6, bf74, bf65), Local0)
		m600(arg0, 27, Local0, bb35)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), bf74, bf65), Local0)
			m600(arg0, 28, Local0, bs1f)

			Store(Mid(Derefof(Refof(aub6)), bf74, bf65), Local0)
			m600(arg0, 29, Local0, bb35)
		}

		Store(Mid(Derefof(Index(paus, 6)), bf74, bf65), Local0)
		m600(arg0, 30, Local0, bs1f)

		Store(Mid(Derefof(Index(paub, 6)), bf74, bf65), Local0)
		m600(arg0, 31, Local0, bb35)

		// Method returns Object

		Store(Mid(m601(2, 6), bf74, bf65), Local0)
		m600(arg0, 32, Local0, bs1f)

		Store(Mid(m601(3, 6), bf74, bf65), Local0)
		m600(arg0, 33, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), bf74, bf65), Local0)
			m600(arg0, 34, Local0, bs1f)

			Store(Mid(Derefof(m602(3, 6, 1)), bf74, bf65), Local0)
			m600(arg0, 35, Local0, bb35)
		}

		Mid("This is auxiliary String", bf74, bf65, Local0)
		m600(arg0, 36, Local0, bs1f)

		Mid(Buffer(){"This is auxiliary Buffer"}, bf74, bf65, Local0)
		m600(arg0, 37, Local0, bb35)

		Mid(aus6, bf74, bf65, Local0)
		m600(arg0, 38, Local0, bs1f)

		Mid(aub6, bf74, bf65, Local0)
		m600(arg0, 39, Local0, bb35)


		if (y078) {
			Mid(Derefof(Refof(aus6)), bf74, bf65, Local0)
			m600(arg0, 40, Local0, bs1f)

			Mid(Derefof(Refof(aub6)), bf74, bf65, Local0)
			m600(arg0, 41, Local0, bb35)
		}

		Mid(Derefof(Index(paus, 6)), bf74, bf65, Local0)
		m600(arg0, 42, Local0, bs1f)

		Mid(Derefof(Index(paub, 6)), bf74, bf65, Local0)
		m600(arg0, 43, Local0, bb35)

		// Method returns Object

		Mid(m601(2, 6), bf74, bf65, Local0)
		m600(arg0, 44, Local0, bs1f)

		Mid(m601(3, 6), bf74, bf65, Local0)
		m600(arg0, 45, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), bf74, bf65, Local0)
			m600(arg0, 46, Local0, bs1f)

			Mid(Derefof(m602(3, 6, 1)), bf74, bf65, Local0)
			m600(arg0, 47, Local0, bb35)
		}
	}

	Method(m32s, 1)
	{
		CreateField(b640, 159, 64, bf65)
		CreateField(b641, 420, 33, bf74)

		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)
		Store(0xb, bf74)

		// Buffer Field to Integer conversion of the Buffer Field Length operand

		Store(Mid("This is auxiliary String", 0, bf65), Local0)
		m600(arg0, 0, Local0, bs1e)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, 0, bf65), Local0)
		m600(arg0, 1, Local0, bb34)

		Store(Mid(aus6, 0, bf65), Local0)
		m600(arg0, 2, Local0, bs1e)

		Store(Mid(aub6, 0, bf65), Local0)
		m600(arg0, 3, Local0, bb34)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), 0, bf65), Local0)
			m600(arg0, 4, Local0, bs1e)

			Store(Mid(Derefof(Refof(aub6)), 0, bf65), Local0)
			m600(arg0, 5, Local0, bb34)
		}

		Store(Mid(Derefof(Index(paus, 6)), 0, bf65), Local0)
		m600(arg0, 6, Local0, bs1e)

		Store(Mid(Derefof(Index(paub, 6)), 0, bf65), Local0)
		m600(arg0, 7, Local0, bb34)

		// Method returns Object

		Store(Mid(m601(2, 6), 0, bf65), Local0)
		m600(arg0, 8, Local0, bs1e)

		Store(Mid(m601(3, 6), 0, bf65), Local0)
		m600(arg0, 9, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), 0, bf65), Local0)
			m600(arg0, 10, Local0, bs1e)

			Store(Mid(Derefof(m602(3, 6, 1)), 0, bf65), Local0)
			m600(arg0, 11, Local0, bb34)
		}

		Mid("This is auxiliary String", 0, bf65, Local0)
		m600(arg0, 12, Local0, bs1e)

		Mid(Buffer(){"This is auxiliary Buffer"}, 0, bf65, Local0)
		m600(arg0, 13, Local0, bb34)

		Mid(aus6, 0, bf65, Local0)
		m600(arg0, 14, Local0, bs1e)

		Mid(aub6, 0, bf65, Local0)
		m600(arg0, 15, Local0, bb34)


		if (y078) {
			Mid(Derefof(Refof(aus6)), 0, bf65, Local0)
			m600(arg0, 16, Local0, bs1e)

			Mid(Derefof(Refof(aub6)), 0, bf65, Local0)
			m600(arg0, 17, Local0, bb34)
		}

		Mid(Derefof(Index(paus, 6)), 0, bf65, Local0)
		m600(arg0, 18, Local0, bs1e)

		Mid(Derefof(Index(paub, 6)), 0, bf65, Local0)
		m600(arg0, 19, Local0, bb34)

		// Method returns Object

		Mid(m601(2, 6), 0, bf65, Local0)
		m600(arg0, 20, Local0, bs1e)

		Mid(m601(3, 6), 0, bf65, Local0)
		m600(arg0, 21, Local0, bb34)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), 0, bf65, Local0)
			m600(arg0, 22, Local0, bs1e)

			Mid(Derefof(m602(3, 6, 1)), 0, bf65, Local0)
			m600(arg0, 23, Local0, bb34)
		}

		// Buffer Field to Integer conversion of the both String operands

		Store(Mid("This is auxiliary String", bf74, bf65), Local0)
		m600(arg0, 24, Local0, bs1f)

		Store(Mid(Buffer(){"This is auxiliary Buffer"}, bf74, bf65), Local0)
		m600(arg0, 25, Local0, bb35)

		Store(Mid(aus6, bf74, bf65), Local0)
		m600(arg0, 26, Local0, bs1f)

		Store(Mid(aub6, bf74, bf65), Local0)
		m600(arg0, 27, Local0, bb35)

		if (y078) {
			Store(Mid(Derefof(Refof(aus6)), bf74, bf65), Local0)
			m600(arg0, 28, Local0, bs1f)

			Store(Mid(Derefof(Refof(aub6)), bf74, bf65), Local0)
			m600(arg0, 29, Local0, bb35)
		}

		Store(Mid(Derefof(Index(paus, 6)), bf74, bf65), Local0)
		m600(arg0, 30, Local0, bs1f)

		Store(Mid(Derefof(Index(paub, 6)), bf74, bf65), Local0)
		m600(arg0, 31, Local0, bb35)

		// Method returns Object

		Store(Mid(m601(2, 6), bf74, bf65), Local0)
		m600(arg0, 32, Local0, bs1f)

		Store(Mid(m601(3, 6), bf74, bf65), Local0)
		m600(arg0, 33, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Store(Mid(Derefof(m602(2, 6, 1)), bf74, bf65), Local0)
			m600(arg0, 34, Local0, bs1f)

			Store(Mid(Derefof(m602(3, 6, 1)), bf74, bf65), Local0)
			m600(arg0, 35, Local0, bb35)
		}

		Mid("This is auxiliary String", bf74, bf65, Local0)
		m600(arg0, 36, Local0, bs1f)

		Mid(Buffer(){"This is auxiliary Buffer"}, bf74, bf65, Local0)
		m600(arg0, 37, Local0, bb35)

		Mid(aus6, bf74, bf65, Local0)
		m600(arg0, 38, Local0, bs1f)

		Mid(aub6, bf74, bf65, Local0)
		m600(arg0, 39, Local0, bb35)


		if (y078) {
			Mid(Derefof(Refof(aus6)), bf74, bf65, Local0)
			m600(arg0, 40, Local0, bs1f)

			Mid(Derefof(Refof(aub6)), bf74, bf65, Local0)
			m600(arg0, 41, Local0, bb35)
		}

		Mid(Derefof(Index(paus, 6)), bf74, bf65, Local0)
		m600(arg0, 42, Local0, bs1f)

		Mid(Derefof(Index(paub, 6)), bf74, bf65, Local0)
		m600(arg0, 43, Local0, bb35)

		// Method returns Object

		Mid(m601(2, 6), bf74, bf65, Local0)
		m600(arg0, 44, Local0, bs1f)

		Mid(m601(3, 6), bf74, bf65, Local0)
		m600(arg0, 45, Local0, bb35)

		// Method returns Reference

		if (y500) {
			Mid(Derefof(m602(2, 6, 1)), bf74, bf65, Local0)
			m600(arg0, 46, Local0, bs1f)

			Mid(Derefof(m602(3, 6, 1)), bf74, bf65, Local0)
			m600(arg0, 47, Local0, bb35)
		}
	}

	// Buffer Field to Integer conversion of the Buffer Field StartIndex
	// operand of the Match operator
	Method(m06a, 1)
	{
		CreateField(b641, 420, 33, bf74)

		Store(0xb, bf74)

		Store(Match(
			Package(){
				0xa50, 0xa51, 0xa52, 0xa53, 0xa54, 0xa55, 0xa56, 0xa57,
				0xa58, 0xa59, 0xa5a, 0xa5b, 0xa5c, 0xa5d, 0xa5e,},
			MEQ, 0xa5d, MTR, 0, bf74), Local0)
		m600(arg0, 0, Local0, 0xd)

		Store(Match(
			Package(){
				0xa50, 0xa51, 0xa52, 0xa53, 0xa54, 0xa55, 0xa56, 0xa57,
				0xa58, 0xa59, 0xa5a, 0xa5b, 0xa5c, 0xa5d, 0xa5e,},
			MEQ, 0xa5a, MTR, 0, bf74), Local0)
		m600(arg0, 1, Local0, Ones)

		Store(Match(aup0, MEQ, 0xa5d, MTR, 0, bf74), Local0)
		m600(arg0, 2, Local0, 0xd)

		Store(Match(aup0, MEQ, 0xa5a, MTR, 0, bf74), Local0)
		m600(arg0, 3, Local0, Ones)

		if (y078) {
			Store(Match(Derefof(Refof(aup0)), MEQ, 0xa5d, MTR, 0, bf74), Local0)
			m600(arg0, 4, Local0, 0xd)

			Store(Match(Derefof(Refof(aup0)), MEQ, 0xa5a, MTR, 0, bf74), Local0)
			m600(arg0, 5, Local0, Ones)
		}

		Store(Match(Derefof(Index(paup, 0)), MEQ, 0xa5d, MTR, 0, bf74), Local0)
		m600(arg0, 6, Local0, 0xd)

		Store(Match(Derefof(Index(paup, 0)), MEQ, 0xa5a, MTR, 0, bf74), Local0)
		m600(arg0, 7, Local0, Ones)

		// Method returns Object

		Store(Match(m601(4, 0), MEQ, 0xa5d, MTR, 0, bf74), Local0)
		m600(arg0, 8, Local0, 0xd)

		Store(Match(m601(4, 0), MEQ, 0xa5a, MTR, 0, bf74), Local0)
		m600(arg0, 9, Local0, Ones)

		// Method returns Reference

		if (y500) {
			Store(Match(Derefof(m602(4, 0, 1)), MEQ, 0xa5d, MTR, 0, bf74), Local0)
			m600(arg0, 10, Local0, 0xd)

			Store(Match(Derefof(m602(4, 0, 1)), MEQ, 0xa5a, MTR, 0, bf74), Local0)
			m600(arg0, 11, Local0, Ones)
		}
	}

	// Buffer Field to Integer conversion of the Buffer Field sole operand
	// of the Method execution control operators (Sleep, Stall)
	Method(m06b, 1)
	{
		CreateField(b640,   0, 31, bf61)
		CreateField(b641, 453, 33, bf75)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(0x3f, bf75)

		CH03(arg0, z089, 2, 0, 0)

		// Sleep

		Store(Timer, Local0)

		Sleep(bf61)
		CH03(arg0, z089, 3, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z089, 0, 0, 0, Local2, c08c)
		}

		// Stall

		Store(Timer, Local0)

		Stall(bf75)
		CH03(arg0, z089, 4, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, 990)) {
			err(arg0, z089, 1, 0, 0, Local2, 990)
		}
	}

	// Buffer Field to Integer conversion of the Buffer Field TimeoutValue
	// (second) operand of the Acquire operator

	Method(m06c, 1, Serialized)
	{
		CreateField(b640,   0, 31, bf61)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)

		Mutex(MTX0, 0)

		Acquire(MTX0, 0)
		CH03(arg0, z089, 5, 0, 0)

		Store(Timer, Local0)

/* Compiler allows only Integer constant as TimeoutValue (Bug 1)
		Acquire(MTX0, bf61)
*/
		CH03(arg0, z089, 6, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z089, 0, 0, 0, Local2, c08c)
		}
	}

	// Buffer Field to Integer conversion of the Buffer Field TimeoutValue
	// (second) operand of the Wait operator
	Method(m06d, 1, Serialized)
	{
		CreateField(b640,   0, 31, bf61)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)

		Event(EVT0)

		CH03(arg0, z089, 7, 0, 0)

		Store(Timer, Local0)

		Wait(EVT0, bf61)
		CH03(arg0, z089, 8, 0, 0)

		Store(Timer, Local1)
		Subtract(Local1, Local0, Local2)
		if (LLess(Local2, c08c)) {
			err(arg0, z089, 0, 0, 0, Local2, c08c)
		}
	}

	// Buffer Field to Integer conversion of the Buffer Field value
	// of Predicate of the Method execution control statements
	// (If, ElseIf, While)
	Method(m06e, 1, Serialized)
	{
		Name(ist0, 0)
		CreateField(b640,   0, 31, bf61)
		CreateField(b640, 159, 64, bf65)
		CreateField(b641, 486, 33, bf76)

		Store(Buffer(3){0x21, 0x03, 0x00}, bf61)
		Store(Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf65)
		Store(0, bf76)


		Method(m001)
		{
			if (bf76) {
				Store(0, ist0)
			}
		}

		Method(m002)
		{
			if (bf61) {
				Store(2, ist0)
			}
		}

		Method(m003)
		{
			if (bf65) {
				Store(3, ist0)
			}
		}

		Method(m004)
		{
			if (bf65) {
				Store(4, ist0)
			}
		}

		Method(m005, 1)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (bf76) {
				Store(0, ist0)
			}
		}

		Method(m006, 1)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (bf61) {
				Store(6, ist0)
			}
		}

		Method(m007, 1)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (bf65) {
				Store(7, ist0)
			}
		}

		Method(m008, 1)
		{
			if (arg0) {
				Store(0xff, ist0)
			} elseif (bf65) {
				Store(8, ist0)
			}
		}

		Method(m009)
		{
			while (bf76) {
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

	/*
	 * Begin of the test body
	 */
	
	// Buffer Field to Buffer implicit conversion Cases.

	// Buffer Field to Buffer conversion of the Buffer Field second operand
	// of Logical operators when the first operand is evaluated as Buffer
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

	// Buffer Field to Buffer conversion of the both Integer operands
	// of Concatenate operator
	if (F64) {
		Concatenate(ts, "-m645", Local0)
		SRMT(Local0)
		m645(Local0)
	} else {
		Concatenate(ts, "-m325", Local0)
		SRMT(Local0)
		m325(Local0)
	}

	// Buffer Field to Buffer conversion of the Buffer Field second operand
	// of Concatenate operator when the first operand is evaluated as Buffer
	if (F64) {
		Concatenate(ts, "-m646", Local0)
		SRMT(Local0)
		m646(Local0)
	} else {
		Concatenate(ts, "-m326", Local0)
		SRMT(Local0)
		m326(Local0)
	}

	// Buffer Field to Buffer conversion of the Buffer Field Source operand
	// of ToString operator
	if (F64) {
		Concatenate(ts, "-m647", Local0)
		SRMT(Local0)
		m647(Local0)
	} else {
		Concatenate(ts, "-m327", Local0)
		SRMT(Local0)
		m327(Local0)
	}

	// Buffer Field to Buffer conversion of the Buffer Field Source operand
	// of Mid operator
	if (F64) {
		Concatenate(ts, "-m648", Local0)
		SRMT(Local0)
		m648(Local0)
	} else {
		Concatenate(ts, "-m328", Local0)
		SRMT(Local0)
		m328(Local0)
	}


	// Buffer Field to Integer implicit conversion Cases.

	// Buffer Field to Integer conversion of the Buffer Field sole operand
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

	// Buffer Field to Integer conversion of the Buffer Field sole operand
	// of the LNot Logical Integer operator
	Concatenate(ts, "-m03a", Local0)
	SRMT(Local0)
	m03a(Local0)

	// Buffer Field to Integer conversion of the Buffer Field sole operand
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

	// Buffer Field to Integer conversion of each Buffer operand
	// of the 2-parameter Integer arithmetic operators
	// Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
	// ShiftLeft, ShiftRight, Subtract, Xor
	if (F64) {
		m64n(Concatenate(ts, "-m64n"))
	} else {
		m32n(Concatenate(ts, "-m32n"))
	}

	// Buffer Field to Integer conversion of each Buffer operand
	// of the 2-parameter Logical Integer operators LAnd and LOr
	if (F64) {
		m64o(Concatenate(ts, "-m64o"))
	} else {
		m32o(Concatenate(ts, "-m32o"))
	}

	// Buffer Field to Integer conversion of the Buffer Field second operand
	// of Logical operators when the first operand is evaluated as Integer
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

	// Buffer Field to Integer intermediate conversion of the Buffer Field
	// second operand of Concatenate operator in case the first one is Integer
	if (F64) {
		Concatenate(ts, "-m64q", Local0)
		SRMT(Local0)
		m64q(Local0)
	} else {
		Concatenate(ts, "-m32q", Local0)
		SRMT(Local0)
		m32q(Local0)
	}

	// Buffer Field to Integer conversion of the Buffer Field Length
	// (second) operand of the ToString operator

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

	// Buffer Field to Integer conversion of the Buffer Field Index
	// (second) operand of the Index operator
	Concatenate(ts, "-m067", Local0)
	SRMT(Local0)
	m067(Local0)

	// Buffer Field to Integer conversion of the Buffer Field Arg (third)
	// operand of the Fatal operator
	// (it can only be checked an exception does not occur)
	Concatenate(ts, "-m068", Local0)
	SRMT(Local0)
	m068(Local0)

	// Buffer Field to Integer conversion of the Buffer Field Index
	// and Length operands of the Mid operator

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

	// Buffer Field to Integer conversion of the Buffer Field StartIndex
	// operand of the Match operator
	Concatenate(ts, "-m06a", Local0)
	SRMT(Local0)
	m06a(Local0)

	// Buffer Field to Integer conversion of the Buffer Field sole operand
	// of the Method execution control operators (Sleep, Stall)
	Concatenate(ts, "-m06b", Local0)
	SRMT(Local0)
	m06b(Local0)

	// Buffer Field to Integer conversion of the Buffer Field TimeoutValue
	// (second) operand of the Wait operator
	Concatenate(ts, "-m06d", Local0)
	SRMT(Local0)
	m06d(Local0)

	// Buffer Field to Integer conversion of the Buffer Field value
	// of Predicate of the Method execution control statements
	// (If, ElseIf, While)
	Concatenate(ts, "-m06e", Local0)
	SRMT(Local0)
	m06e(Local0)
}

// Run-method
Method(OPR2)
{
	Store("TEST: OPR2, Source Operand", Debug)

	m613()
	m614()
}
