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
 * Bug 151:
 *
 * SUMMARY: The zero-length resulting String of Mid operator passed to Concatenate operator causes crash
 *
 * Check absence of crash..
 */

	Method(mf3f, 1, Serialized)
	{
		Name(b000, Buffer(arg0){})
		Name(b001, Buffer(7){1,2,3,4,5,6,7})
		Name(b002, Buffer(7){8,9,10,11,12,13,14})

		Store("Buffer case", Debug)

		Store(b000, Debug)
		Store(Sizeof(b000), Debug)

		// 1.

		Store(Concatenate(b000, b001), Local1)
		Store("Ok: Concatenate(<Default empty buffer>, ...)", Debug)

		Concatenate(b000, b001, Local0)
		if (LNotEqual(Local0, Buffer(7){1,2,3,4,5,6,7})) {
			err("", zFFF, 0x000, 0, 0, Local0, Buffer(7){1,2,3,4,5,6,7})
		}

		// 2.

		Store(Mid(b002, 7, 1), Local0)
		Store(Local0, Debug)
		Store(Sizeof(Local0), Debug)

		Store("Try: Concatenate(<Mid empty buffer result object>, ...)", Debug)
		Store(Concatenate(Local0, b001), Local1)
		Store("Ok: Concatenate(<Mid empty buffer result object>, ...)", Debug)

		Concatenate(Local0, b001, Local0)
		if (LNotEqual(Local0, Buffer(7){1,2,3,4,5,6,7})) {
			err("", zFFF, 0x001, 0, 0, Local0, Buffer(7){1,2,3,4,5,6,7})
		}
	}

	Method(mf40,, Serialized)
	{
		Name(s000, "")
		Name(s001, "String1")
		Name(s002, "String2")

		Store("String case", Debug)

		Store(s000, Debug)
		Store(Sizeof(s000), Debug)

		// 3.

		Store(Concatenate(s000, s001), Local1)
		Store("Ok: Concatenate(<Default empty string>, ...)", Debug)

		Concatenate(s000, s001, Local0)
		if (LNotEqual(Local0, "String1")) {
			err("", zFFF, 0x002, 0, 0, Local0, "String1")
		}

		// 4.

		Store(Mid(s002, 7, 1), Local0)
		Store(Local0, Debug)
		Store(Sizeof(Local0), Debug)

		Store("Try: Concatenate(<Mid empty string result object>, ...)", Debug)
		Store(Concatenate(Local0, s001), Local1)
		Store("Ok: Concatenate(<Mid empty string result object>, ...)", Debug)

		Concatenate(Local0, s001, Local0)
		if (LNotEqual(Local0, "String1")) {
			err("", zFFF, 0x003, 0, 0, Local0, "String1")
		}
	}

	Method(mf41)
	{
		mf3f(0)
		mf40()
	}
