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
 * Bug 0023:
 *
 * SUMMARY: FromBCD/ToBCD works incorrectly in 64-bit mode starting with the large enough values
 */

Method(mdb8)
{
	// Ok, FromBCD(0x9999999999)

	Store(0x9999999999, Local0)
	Store(9999999999, Local1)

	CH03("", 0, 0x000, 0, 0)
	FromBCD(Local0, Local2)
	if (LNotEqual(Local2, Local1)) {
		err("", zFFF, 0x001, 0, 0, Local2, Local1)
	}

	// Bug, FromBCD(0x10000000000)

	Store(0x10000000000, Local0)
	Store(10000000000, Local1)

	CH03("", 0, 0x003, 0, 0)
	FromBCD(Local0, Local2)
	if (LNotEqual(Local2, Local1)) {
		err("", zFFF, 0x004, 0, 0, Local2, Local1)
	}

	// Ok, ToBCD(10000000000)

	Store(10000000000, Local0)
	Store(0x10000000000, Local1)

	CH03("", 0, 0x006, 0, 0)
	ToBCD(Local0, Local2)
	if (LNotEqual(Local2, Local1)) {
		err("", zFFF, 0x007, 0, 0, Local2, Local1)
	}

	CH03("", 0, 0x000, 0, 0)
}

