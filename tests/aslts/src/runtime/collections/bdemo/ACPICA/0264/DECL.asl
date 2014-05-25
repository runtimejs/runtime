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
 * Bug 264:
 *
 * SUMMARY: Crash on re-writing named element of Package
 */

/*
 * To be done:
 *
 * 1) Do then the bdemo-test for different type element of Package
 *    (not only Integer i000 as now).
 *
 * 2) See below: what should be there the result of Store operations?
 *
 * 3) After (2) do the relevant tests - writing/rewriting to such type elements of packages.
 */

Method(m025)
{
	Method(m000,, Serialized)
	{
		Name(i000, 0xabcd0000)
		Name(p000, Package() { i000 })

		CH03("", 0, 0x000, 0, 0)

		Store(0xabcd0001, DerefOf(Index(p000, 0)))

/*
Specify then what should be there the result of Store operation above?

		Store(DerefOf(Index(p000, 0)), Local0)
		if (LNotEqual(Local0, 0xabcd0000)) {
			err("", zFFF, 0x000, 0, 0, Local0, 0xabcd0000)
		}
*/

		CH03("", 0, 0x001, 0, 0)
	}

	Method(m001,, Serialized)
	{
		Name(i000, 0xabcd0000)
		Name(p000, Package() { i000 })

		CH03("", 0, 0x002, 0, 0)
		Store(0xabcd0001, DerefOf(Index(p000, 0, Local0)))
		CH03("", 0, 0x003, 0, 0)
	}

	Method(m002,, Serialized)
	{
		Name(i000, 0xabcd0000)
		Name(p000, Package() { i000 })

		CH03("", 0, 0x004, 0, 0)
		Index(p000, 0, Local0)
		Store(0xabcd0001, DerefOf(Local0))
		CH03("", 0, 0x005, 0, 0)
	}

	Method(m003,, Serialized)
	{
		Name(i000, 0xabcd0000)
		Name(p000, Package() { i000 })

		CH03("", 0, 0x006, 0, 0)
		Store(Index(p000, 0), Local0)
		Store(0xabcd0001, DerefOf(Local0))
		CH03("", 0, 0x007, 0, 0)
	}

	Method(m004,, Serialized)
	{
		Name(i000, 0xabcd0000)
		Name(p000, Package() { i000 })

		CH03("", 0, 0x008, 0, 0)
		Store(Index(p000, 0, Local0), Local1)
		Store(0xabcd0001, DerefOf(Local0))
		CH03("", 0, 0x009, 0, 0)
	}

	Method(m005,, Serialized)
	{
		Name(i000, 0xabcd0000)
		Name(p000, Package() { i000 })

		CH03("", 0, 0x00a, 0, 0)
		Store(Index(p000, 0, Local0), Local1)
		Store(0xabcd0001, DerefOf(Local1))
		CH03("", 0, 0x00b, 0, 0)
	}


	Method(m006) {
		m000()
		m001()
		m002()
		m003()
		m004()
		m005()
	}

	m006()
}

