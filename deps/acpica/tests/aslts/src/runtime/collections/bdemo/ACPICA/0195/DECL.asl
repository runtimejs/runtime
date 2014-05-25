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
 * Bug 195 (local-bugzilla-353):
 *
 * SUMMARY: Increment and Decrement of String or Buffer changes the type of operand
 *
 * Increment and Decrement of either String or Buffer Object
 * unexpectedly change the type of operand (Addend and Minuend
 * respectively) to Integer. Operands should preserve the initial
 * types.
 *
 * By the way, the relevant "equivalent" operations
 * Add(Addend, 1, Addend) and Subtract(Minuend, 1, Minuend)
 * don't change the type of Addend and Minuend respectively.
 */

Method(mfaf,, Serialized)
{
	Name(s000, "0321")
	Name(s001, "0321")
	Name(b000, Buffer(3){0x21, 0x03, 0x00})
	Name(b001, Buffer(3){0x21, 0x03, 0x00})

	Decrement(s000)
	Subtract(s001, 1, s001)

	Store("======== :", Debug)
	Store(s000, Debug)
	Store(s001, Debug)
	Store("========.", Debug)

	Store(ObjectType(s000), Local0)
	Store(ObjectType(s001), Local1)

	if (LNotEqual(Local0, Local1)) {
		err("", zFFF, 0x000, 0, 0, Local0, Local1)
	} elseif (LNotEqual(s000, s001)) {
		err("", zFFF, 0x001, 0, 0, s000, s001)
	}

	if (LNotEqual(Local0, 2)) {
		err("", zFFF, 0x002, 0, 0, Local0, 2)
	}

	if (LNotEqual(Local1, 2)) {
		err("", zFFF, 0x003, 0, 0, Local1, 2)
	}

	Increment(b000)
	Add(b001, 1, b001)

	Store("======== :", Debug)
	Store(b000, Debug)
	Store(b001, Debug)
	Store("========.", Debug)

	Store(ObjectType(b000), Local0)
	Store(ObjectType(b001), Local1)

	if (LNotEqual(Local0, Local1)) {
		err("", zFFF, 0x004, 0, 0, Local0, Local1)
	} elseif (LNotEqual(b000, b001)) {
		err("", zFFF, 0x005, 0, 0, b000, b001)
	}

	if (LNotEqual(Local0, 3)) {
		err("", zFFF, 0x006, 0, 0, Local0, 3)
	}

	if (LNotEqual(Local1, 3)) {
		err("", zFFF, 0x007, 0, 0, Local1, 3)
	}
}
