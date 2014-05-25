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
 * Bug 126:
 *
 * SUMMARY: The Read access automatic dereference for RefOf reference doesn't work
 */

	Method(mf0f, 1)
	{
		Store("m000 started, apply DerefOf()", Debug)

		Store(DerefOf(arg0), Local0)

		Add(Local0, 1, Local7)

		if (LNotEqual(Local0, 7)) {
			err("", zFFF, 0x000, 0, 0, Local0, 7)
		}
		if (LNotEqual(Local7, 8)) {
			err("", zFFF, 0x000, 0, 0, Local7, 8)
		}

		Store("m000 finished", Debug)
	}

	Method(mf10, 1, Serialized)
	{
		Name(i001, 0)

		Store("m001 started, DONT apply DerefOf()", Debug)

		Add(arg0, 1, Local7)

		if (LNotEqual(arg0, 7)) {
			err("", zFFF, 0x000, 0, 0, arg0, 7)
		}
		if (LNotEqual(Local7, 8)) {
			err("", zFFF, 0x000, 0, 0, arg0, 8)
		}

		Store("m001 finished", Debug)
	}

	Method(mf11,, Serialized)
	{
		Name(i000, 7)
		mf0f(RefOf(i000))
	}

	Method(mf12,, Serialized)
	{
		Name(i000, 7)
		mf10(RefOf(i000))
	}
