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
 * Bug 268:
 *
 * SUMMARY: The manner parameters are passed to method in ACPICA contradicts to MS
 */

Method(m023,, Serialized)
{
	Name(i000, 0xabcd0000)
	Method(mm00, 1)
	{
		Store("The view from inside method MM00:", Debug)
		Store("--------- i000 before re-writing i000:", Debug)
		Store(i000, Debug)
		Store("--------- Arg0 before re-writing i000:", Debug)
		Store(arg0, Debug)
		Store(0x11223344, i000)
		Store("--------- Arg0 after re-writing i000:", Debug)
		Store(arg0, Debug)
		Store("--------- i000 after re-writing i000:", Debug)
		Store(i000, Debug)

		if (LNotEqual(arg0, 0xabcd0000)) {
			err("", zFFF, 0x000, 0, 0, arg0, 0xabcd0000)
		}
	}

	Store("m000: test 0 (Integer passed to method)", Debug)

	Store("========= i000 from m000 before re-writing i000:", Debug)
	Store(i000, Debug)

	mm00(i000)

	Store("========= i000 from m000 after re-writing i000:", Debug)
	Store(i000, Debug)

	if (LNotEqual(i000, 0x11223344)) {
		err("", zFFF, 0x001, 0, 0, i000, 0x11223344)
	}
}
