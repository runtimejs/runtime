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
 * Bug 275:
 *
 * SUMMARY: pop result from bottom principle doesn't work
 */

Method(mc75,, Serialized)
{
	Name(i000, 0x11000000)
	Name(i001, 0x00220000)
	Name(p000, Package () {0xabcd0000, 0xabcd0001, 0xabcd0002})

	Method(m000)
	{
		Return (p000)
	}

	Method(m001, 1)
	{
		Return (0xabcd0003)
	}

	Method(m002, 2)
	{
		Index(arg0, 1, Local0)
		if (CH03("", 0, 0x001, arg0, 1)) {
			return
		}

		Store(DerefOf(Local0), Local1)
		if (CH03("", 0, 0x002, arg0, 1)) {
			return
		}

		if (LNotEqual(Local1, 0xabcd0001)) {
			err("", zFFF, 0x003, 0, 0, Local1, 0xabcd0001)
		}
		return
	}

	// ################################## How it should work

	// ================================== Example 0:
	m002(p000, 0xabcd0004)

	// ================================== Example 1:
	m002(m000(), 0xabcd0004)

	// ================================== Example 2:
	m002(p000, m001(Add(i000, i001)))

	// ################################## How it actually works:
	m002(m000(), m001(Add(i000, i001)))
}
