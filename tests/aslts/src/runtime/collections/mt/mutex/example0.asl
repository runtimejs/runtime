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
 * Example 0 (from some particular failed table)
 *
 * arg0 - ID of current thread
 * arg1 - Index of current thread
 * arg2 - Integer
 * arg3 - Integer
 * arg4 - Integer
 */
Method (C0A2, 5, Serialized)
{

	OperationRegion (C0A3, SystemIO, C0A1 (), 0x07)
	Field (C0A3, ByteAcc, NoLock, Preserve) {
		C0A4,   8,
		C0A5,   8,
		C0A6,   8,
		C0A7,   8,
		C0A8,   8,
		C0A9,   8,
		C0AA,   8
	}

	m310(arg0, arg1, GLLL, GLIX, 0, 0, 0) // Acquire

	Store (16, Local0)
	While (Local0) {
		Store(C0A4, Local1)
		m207(arg1, 100) // Stall
		Decrement (Local0)
	}

	Store (1, Local0)

	if (Local0) {

		Store (arg3, C0A7)
		Store (arg2, C0A8)
		If (LEqual (And (arg2, 0x01), 0x00))
		{
		    Store (arg4, C0A9)
		}

		Store (0xFF, C0A4)
		Store (0x48, C0A6)

		Store (11, Local0)
		While (Local0) {
			Store(C0A4, Local1)
			m207(arg1, 100) // Stall
			Decrement (Local0)
		}

		And (C0A4, 0x1C, Local1)
		Store (0xFF, C0A4)
		If (LAnd (LEqual (Local1, 0x00), And (arg2, 0x01)))
		{
		    Store (C0A9, Local2)
		}
	} else {
		Store (0x01, Local1)
	}

	m311(arg0, arg1, GLLL, GLIX, 0, 0) // Release

	Return (Local1)
}

Method (C0A1, 0, Serialized)
{
	Return (0x100)
}

/*
 * arg0 - ID of current thread
 * arg1 - Index of current thread
 */
Method (C0AB, 2)
{
	m310(arg0, arg1, GLLL, GLIX, 0, 0, 0) // Acquire

	Store (16, Local0)
	While (Local0) {
		m207(arg1, 50) // Stall
		Decrement (Local0)
	}

	m311(arg0, arg1, GLLL, GLIX, 0, 0) // Release
}
