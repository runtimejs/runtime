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
 * Bug 0107:
 *
 * SUMMARY: The ASL Compiler crashes when tries to convert data that can not be converted
 */

	Method(me6c)
	{
		Store(LLess(1, "1234q"), Local0)
		Store(Local0, Debug)

		if (LNotEqual(Local0, Ones)) {
			err("", zFFF, 0x000, 0, 0, Local0, Ones)
		}

	}
	Method(me6d)
	{
		Store(Add("1234q", 1), Local0)
		Store(Local0, Debug)

		if (LNotEqual(Local0, 0x1235)) {
			err("", zFFF, 0x001, 0, 0, Local0, 0x1235)
		}
	}
	Method(me6e)
	{
		Store(Not("1234q"), Local0)
		Store(Local0, Debug)

		if (LNotEqual(Local0, 0xffffffffffffedcb)) {
			err("", zFFF, 0x002, 0, 0, Local0, 0xffffffffffffedcb)
		}
	}

	Method(me6f)
	{
		me6c()
		me6d()
		me6e()
	}
