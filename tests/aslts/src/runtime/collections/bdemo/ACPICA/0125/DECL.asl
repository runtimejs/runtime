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
 * Bug 125:
 *
 * SUMMARY: The Mid operator in 64-bit mode returns non-empty result for improper Index
 */

	Method(mf08, 5)
	{
		Store(arg0, Debug)
		Store("source", Debug)
		Store(arg1, Debug)
		Store(arg2, Debug)
		Store(arg3, Debug)
		Store("expected", Debug)
		Store(arg4, Debug)

		Mid(arg1, arg2, arg3, Local0)

		if (LNotEqual(arg4, Local0)) {
			err("", zFFF, 0x000, 0, 0, arg4, Local0)
		}
	}

	Method(mf09)
	{
		Store(0, Local0)

		// Mid (Source, Index, Length, Result)
		// a) Index >= 0x100000000
		// b) Modulo(Index, 0x100000000) < Size.
		if (0x100000000) {
			mf08("Buffer: Index >= 0x100000000, Modulo(Index, 0x100000000) < Size:",
				bd07, 0x100001fff, 0x8000, Buffer(Local0){})

			mf08("String: Index >= 0x100000000, Modulo(Index, 0x100000000) < Size:",
				sd03, 0x100000005, 10, "")
		}

		// a) Index < Size
		// b) Index + Length >= 0x100000000
		// c) Modulo(Index + Length, 0x100000000) < Size.

		// Now causes exception AE_NO_MEMORY
		if (1) {
			mf08("Buffer: Index < Size, Index + Length >= 0x100000000:",
				bd07, 5000, 0xfffff000, Buffer(3193){})
		}

		// Now causes CRASH
		if (1) {
			mf08("String: Index < Size, Index + Length >= 0x100000000:",
				sd03, 8, 0xfffffffc, "89a")
		}
	}


