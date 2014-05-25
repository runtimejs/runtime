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
 * Bug 0075:
 *
 * SUMMARY: Each scope of DefinitionBlock should be supplied with its set of _T_x objects
 *
 * Compiler should return an error...
 */

	Method(me0c, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (1) {
				Store(1, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (2) {
				Store(2, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (3) {
				Store(3, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (4) {
				Store(4, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (5) {
				Store(5, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (6) {
				Store(6, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (7) {
				Store(7, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (8) {
				Store(8, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (9) {
				Store(9, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (10) {
				Store(10, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (11) {
				Store(11, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (12) {
				Store(12, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (13) {
				Store(13, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (14) {
				Store(14, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (15) {
				Store(15, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (16) {
				Store(16, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (17) {
				Store(17, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (18) {
				Store(18, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (19) {
				Store(19, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (20) {
				Store(20, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (21) {
				Store(21, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (22) {
				Store(22, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (23) {
				Store(23, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (24) {
				Store(24, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (25) {
				Store(25, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (26) {
				Store(26, Local0)
			}
		}
		Switch (ToInteger (arg0)) {
			Case (27) {
				Store(27, Local0)
			}
		}

		return (Local0)
	}

	Method(me0d)
	{
		Store(1, Local7)

		While (LLessEqual(Local7, 27)) {
			Store(me0c(Local7), Local0)
			if (LNotEqual(Local0, Local7)) {
				Store("Error:", Debug)
				Store(Local7, Debug)
			}
			Increment(Local7)
		}
	
		return (0)
	}

	// //////////////////////

	Method(me0e, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (1) {
				Store(1, Local0)
			}
		}

		return (Local0)
	}

	Method(me0f, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (2) {
				Store(2, Local0)
			}
		}

		return (Local0)
	}

	Method(me10, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (3) {
				Store(3, Local0)
			}
		}

		return (Local0)
	}

	Method(me11, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (4) {
				Store(4, Local0)
			}
		}

		return (Local0)
	}

	Method(me12, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (5) {
				Store(5, Local0)
			}
		}

		return (Local0)
	}

	Method(me13, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (6) {
				Store(6, Local0)
			}
		}

		return (Local0)
	}

	Method(me14, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (7) {
				Store(7, Local0)
			}
		}

		return (Local0)
	}

	Method(me15, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (8) {
				Store(8, Local0)
			}
		}

		return (Local0)
	}

	Method(me16, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (9) {
				Store(9, Local0)
			}
		}

		return (Local0)
	}

	Method(me17, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (10) {
				Store(10, Local0)
			}
		}

		return (Local0)
	}

	Method(me18, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (11) {
				Store(11, Local0)
			}
		}

		return (Local0)
	}

	Method(me19, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (12) {
				Store(12, Local0)
			}
		}

		return (Local0)
	}

	Method(me1a, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (13) {
				Store(13, Local0)
			}
		}

		return (Local0)
	}

	Method(me1b, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (14) {
				Store(14, Local0)
			}
		}

		return (Local0)
	}

	Method(me1c, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (15) {
				Store(15, Local0)
			}
		}

		return (Local0)
	}

	Method(me1d, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (16) {
				Store(16, Local0)
			}
		}

		return (Local0)
	}

	Method(me1e, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (17) {
				Store(17, Local0)
			}
		}

		return (Local0)
	}

	Method(me1f, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (18) {
				Store(18, Local0)
			}
		}

		return (Local0)
	}

	Method(me20, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (19) {
				Store(19, Local0)
			}
		}

		return (Local0)
	}

	Method(me21, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (20) {
				Store(20, Local0)
			}
		}

		return (Local0)
	}

	Method(me22, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (21) {
				Store(21, Local0)
			}
		}

		return (Local0)
	}

	Method(me23, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (22) {
				Store(22, Local0)
			}
		}

		return (Local0)
	}

	Method(me24, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (23) {
				Store(23, Local0)
			}
		}

		return (Local0)
	}

	Method(me25, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (24) {
				Store(24, Local0)
			}
		}

		return (Local0)
	}

	Method(me26, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (25) {
				Store(25, Local0)
			}
		}

		return (Local0)
	}

	Method(me27, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (26) {
				Store(26, Local0)
			}
		}

		return (Local0)
	}

	Method(me28, 1, Serialized)
	{
		Store(0x100, Local0)

		Switch (ToInteger (arg0)) {
			Case (27) {
				Store(27, Local0)
			}
		}

		return (Local0)
	}
