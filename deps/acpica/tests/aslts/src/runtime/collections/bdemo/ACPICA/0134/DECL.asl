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
 * Bug 134:
 *
 * SUMMARY: Writing RefOf reference from inside Method breaks effectively local Arg
 */

	Method(mf23, 7)
	{
		Store("LocalX case of Method started:", Debug)

		Store(RefOf(id14), Local0)
		Store(Local0, Local1)
		Store(Local1, Local2)
		Store(Local2, Local3)
		Store(Local3, Local4)
		Store(Local4, Local5)
		Store(Local5, Local6)


		Store(DerefOf(Local0), Local6)
		Store(Local6, Debug)

		if (LNotEqual(Local6, 0x11)) {
			err("", zFFF, 0x000, 0, 0, Local6, 0x11)
		}

		Store("LocalX case of Method finished", Debug)
	}

	Method(mf24, 7)
	{
		Store("ArgX case (1) of Method started:", Debug)

		Store(RefOf(id14), arg0)
		Store(arg0, arg1)
		Store(arg1, arg2)
		Store(arg2, arg3)
		Store(arg3, arg4)
		Store(arg4, arg5)
		Store(arg5, arg6)


		Store(DerefOf(arg0), arg6)
		Store(arg6, Debug)

		if (LNotEqual(arg6, 0x11)) {
			err("", zFFF, 0x000, 0, 0, arg6, 0x11)
		}

		Store("ArgX case (1) of Method finished", Debug)
	}

	Method(mf25, 7)
	{
		Store("ArgX case (2) of Method started:", Debug)

		Store(RefOf(id14), Local0)
		Store(Local0, arg1)
		Store(Local0, arg2)
		Store(Local0, arg3)
		Store(Local0, arg4)
		Store(Local0, arg5)
		Store(Local0, arg6)


		Store(DerefOf(arg0), arg6)
		Store(arg6, Debug)

		if (LNotEqual(arg6, 0x11)) {
			err("", zFFF, 0x000, 0, 0, arg6, 0x11)
		}

		Store("ArgX case (2) of Method finished", Debug)
	}

	Method(mf26)
	{
		SRMT("mf23")
		mf23(id14,id15,id16,id17,id18,id19,id1a)

		SRMT("mf24")
		if (y134) {
			mf24(id14,id15,id16,id17,id18,id19,id1a)
		} else {
			BLCK()
		}

		SRMT("mf25")
		if (y134) {
			mf25(id14,id15,id16,id17,id18,id19,id1a)
		} else {
			BLCK()
		}
	}


