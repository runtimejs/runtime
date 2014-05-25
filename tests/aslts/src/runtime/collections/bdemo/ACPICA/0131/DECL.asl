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
 * Bug 131:
 *
 * SUMMARY: Store to the Index reference immediately returned by Method doesn't work
 */

Method(m126,, Serialized)
{
	Name(p000, Package() {1,2,3,4,5,6,7,8})

	Method(m002)
	{
		Store("m002 started", Debug)
		return (Index(p000, 1))
	}

	Method(m003)
	{
		Store("m003 started", Debug)
		Store(Index(p000, 1), Local0)
		return (Local0)
	}

	Method(m004, 1)
	{
		Store("m004 started", Debug)
		Store(Index(p000, arg0), Local0)
		return (Local0)
	}

	Method(m005)
	{
		Store(0xabcd0001, Index(p000, 0))
		Store(DerefOf(Index(p000, 0)), Local0)
		if (LNotEqual(Local0, 0xabcd0001)) {
			err("", zFFF, 0x000, 0, 0, Local0, 0xabcd0001)
		}

		Store(0xabcd0004, m002())
		Store(DerefOf(Index(p000, 1)), Local0)
		if (LNotEqual(Local0, 0xabcd0004)) {
			err("", zFFF, 0x000, 0, 0, Local0, 0xabcd0004)
		}

		Store(0xabcd0005, m003())
		Store(DerefOf(Index(p000, 1)), Local0)
		if (LNotEqual(Local0, 0xabcd0005)) {
			err("", zFFF, 0x000, 0, 0, Local0, 0xabcd0005)
		}

		Store(0xabcd0006, m004(1))
		Store(DerefOf(Index(p000, 1)), Local0)
		if (LNotEqual(Local0, 0xabcd0006)) {
			err("", zFFF, 0x000, 0, 0, Local0, 0xabcd0006)
		}
	}

	m005()
}

