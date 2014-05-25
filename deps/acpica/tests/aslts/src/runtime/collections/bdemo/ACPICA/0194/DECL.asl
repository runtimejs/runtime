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
 * Bug 194:
 *
 * SUMMARY: Incorrect length of result of ToBuffer in case it is stored into a Named Buffer
 */
Method (bcmp, 2)
{
	Store(Sizeof(Arg0), Local0)
	Store(Sizeof(Arg1), Local1)

	if (LGreater(Local0, Local1))
	{
		Store(Local1, Local0)
	}
	while(Local0) {
		Decrement(Local0)
		Store(Local0, Debug)
		Store(DerefOf(Index(Arg0, Local0)), Local1)
		Store(DerefOf(Index(Arg1, Local0)), Local2)
		if (LNotEqual(Local1, Local2))
		{
			return (0)
		}
	}
	return (1)
}

Method(mfa7, 1, Serialized)
{
	Name(b000, Buffer(1){0x3c})
	Name(b001, Buffer(3){0x01, 0x02, 0x03})

	Name(bb00, Buffer(1){0x3c})
	Name(bb01, Buffer(3){0x01, 0x02, 0x03})

	if (arg0) {
		Store("ToBuffer(b001, b000)", Debug)
		ToBuffer(b001, b000)
		if (LNot(bcmp(b000, bb01))) {
			err("", zFFF, 0x000, 0, 0, b000, bb01)
		}
	} else {
		Store("ToBuffer(b000, b001)", Debug)
		ToBuffer(b000, b001)
		if (Lnot(bcmp(b001, bb00))) {
			err("", zFFF, 0x000, 0, 0, b001, bb00)
		}
	}
}

Method(mfa8)
{
	mfa7(0)
	mfa7(1)
}
