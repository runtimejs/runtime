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

Name(z156, 156)

/*
 * Check access to elements Package/Buffer/String and Buffer Field
 * where the parent is an element of some complex object (Device).
 */

Method(m200,, Serialized)
{
	Name(ts, "m200")
	Device(d000)
	{
		Name(p000, Package() {0xabcd0000, 0xabcd0001, 0xabcd0002})
	}

	Method(m001, 2)
	{
		Store(0x11112222, Index(arg0, 0))
	}

	m001(d000.p000, RefOf(d000.p000))

	Store(DerefOf(Index(d000.p000, 0)), Local0)

	if (LNotEqual(Local0, 0x11112222)) {
		err(ts, z156, 0x000, 0, 0, Local0, 0x11112222)
	}

	CH03(ts, z156, 0x001, 0, 0)
}

Method(m201,, Serialized)
{
	Name(ts, "m201")
	Device(d000)
	{
		Name(b000, Buffer() {0x10, 0x11, 0x12})
	}
	Method(m001, 2)
	{
		Store(0x67, Index(arg0, 0))
	}

	m001(d000.b000, RefOf(d000.b000))

	Store(DerefOf(Index(d000.b000, 0)), Local0)

	if (LNotEqual(Local0, 0x67)) {
		err(ts, z156, 0x002, 0, 0, Local0, 0x67)
	}

	CH03(ts, z156, 0x003, 0, 0)
}

Method(m202,, Serialized)
{
	Name(ts, "m202")
	Device(d000)
	{
		Name(s000, "qqqqqqqqqqqqqq")
	}
	Method(m001, 2)
	{
		Store(0x38, Index(arg0, 0))
	}

	m001(d000.s000, RefOf(d000.s000))

	Store(DerefOf(Index(d000.s000, 0)), Local0)

	if (LNotEqual(Local0, 0x38)) {
		err(ts, z156, 0x004, 0, 0, Local0, 0x38)
	}

	CH03(ts, z156, 0x005, 0, 0)
}

/*
 * Element of Package instead of i000 (in m002)
 */
Method(m204,, Serialized)
{
	Name(ts, "m204")
	Name(i001, 0)
	Device(d000)
	{
		Name(pp00, Package() {0x11111111, 0x00100000, 0x22223333})
	}

	Method(m001)
	{
		if (LLess(i001, 100)) {

			Store(DerefOf(Index(^d000.pp00, 1)), Local0)
			Increment(Local0)
			Store(Local0, Index(^d000.pp00, 1))
			Increment(i001)
			Add(DerefOf(Index(^d000.pp00, 1)), m001(), Local0)
			Return (Local0)
		}
		Return (0)
	}
	Store(Add(DerefOf(Index(d000.pp00, 1)), m001()), Local0)

	if (LNotEqual(Local0, 0x065013BA)) {
		err(ts, z156, 0x00a, 0, 0, Local0, 0x065013BA)
	}

	Store(DerefOf(Index(d000.pp00, 1)), Local0)

	if (LNotEqual(Local0, 0x00100064)) {
		err(ts, z156, 0x00b, 0, 0, Local0, 0x00100064)
	}

	CH03(ts, z156, 0x00c, 0, 0)
}

Method(n002)
{
if (1) {
	SRMT("m200")
	m200()
	SRMT("m201")
	m201()
	SRMT("m202")
	m202()
	SRMT("m204")
	m204()
} else {
	SRMT("m200")
	m200()
}
}

