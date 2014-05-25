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
 * Bug 144:
 *
 * SUMMARY: The ASL Compiler doesn't support multiple type list for particular ParameterType of Method
 */

	Method(mf34, 1, Serialized, 0, IntObj, IntObj)
	{
		Return (Arg0)
	}

	Method(mf35, 1, Serialized, 0, IntObj, {IntObj})
	{
		Return (Arg0)
	}

	Method(mf36, 1, Serialized, 0, IntObj, {{IntObj}})
	{
		Return (Arg0)
	}

	Method(mf37, 1, Serialized, 0, IntObj, {{IntObj, StrObj, BuffObj}})
	{
		Return (Arg0)
	}

	Method(mf38) {
		Store(mf34(0), Local0)
		if (LNotEqual(Local0, 0)) {
			err("", zFFF, 0x000, 0, 0, Local0, 0)
		}

		Store(mf35(1), Local0)
		if (LNotEqual(Local0, 1)) {
			err("", zFFF, 0x000, 0, 0, Local0, 1)
		}

		Store(mf36(2), Local0)
		if (LNotEqual(Local0, 2)) {
			err("", zFFF, 0x000, 0, 0, Local0, 2)
		}

		Store(mf37("3"), Local0)
		if (LNotEqual(Local0, "3")) {
			err("", zFFF, 0x000, 0, 0, Local0, "3")
		}
	}
