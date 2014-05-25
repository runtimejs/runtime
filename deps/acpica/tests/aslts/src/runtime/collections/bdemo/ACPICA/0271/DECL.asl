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
 * Bug 271:
 *
 * SUMMARY: CopyObject of Device works incorrectly
 */

Method(m021,, Serialized)
{
	Name(i000, 0xabcd0000)
	Name(i001, 0xabcd0001)
	Name(i002, 0xabcd0002)
	Device(d000) { Name(i002, 0xabcd0002) }

	Method(m123, 1)
	{
		CopyObject(d000, arg0)
		CopyObject(d000, Local0)
		CopyObject(d000, i001)
		Store("------------------------- Resulting devices:", Debug)
		Store(arg0, Debug)
		Store(Local0, Debug)
		Store(i001, Debug)
		Store("-------------------------.", Debug)
	}

	CH03("", 0, 0x000, 0, 0)

	m123(i000)

	Store(ObjectType(i001), Local0)
	if (LNotEqual(Local0, c00e)) {
		err("", zFFF, 0x001, 0, 0, Local0, c00e)
	}
	CH03("", 0, 0x002, 0, 0)

	CopyObject(i002, i001)

	Store(ObjectType(i001), Local0)
	if (LNotEqual(Local0, c009)) {
		err("", zFFF, 0x003, 0, 0, Local0, c009)
	}
	CH03("", 0, 0x004, 0, 0)
}

