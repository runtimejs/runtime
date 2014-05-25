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
 * Bug 154:
 *
 * SUMMARY: Exception occurs on attempt to rewrite Device type object passed by ArgX to Method
 *
 * Check that exception doesnt occur
 */

	Method(mf43, 1)
	{
		Store(Concatenate("ObjectType(Arg0): 0x",
			Mid(ToHexString(ObjectType(Arg0)), 15, 1)), Debug)
		Store(0, Arg0)
		Store("Store(0, Arg0) done", Debug)
	}

	Method(mf44)
	{
		mf43(id1d)
		Store(ObjectType(id1d), Local0)
		if (LNotEqual(Local0, c009)) {
			err("", zFFF, 0x000, 0, 0, Local0, c009)
		}
		if (LNotEqual(id1d, 0xfedcba9876543210)) {
			err("", zFFF, 0x001, 0, 0, id1d, 0xfedcba9876543210)
		}

		mf43(ed02)
		Store(ObjectType(ed02), Local0)
		if (LNotEqual(Local0, c00f)) {
			err("", zFFF, 0x002, 0, 0, Local0, c00f)
		}

		mf43(dd0b)		
		Store(ObjectType(dd0b), Local0)
		if (LNotEqual(Local0, c00e)) {
			err("", zFFF, 0x003, 0, 0, Local0, c00e)
		}
	}
