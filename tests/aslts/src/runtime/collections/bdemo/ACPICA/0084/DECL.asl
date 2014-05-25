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
 * Bug 0084:
 *
 * SUMMARY: Failed to interpret AML code alternated with Method declarations
 */

Method(me35, 1)
{
	Method(m001)
	{
		return (0)
	}

	Store("Before m001 run", Debug)

	if (arg0) {
		Store("m001 started", Debug)
		m001()
		Store("m001 finished", Debug)
	}

	Store("After m001 run", Debug)

	Method(m002)
	{
		return (0)
	}

	Method(m003)
	{
		return (0)
	}

	Store("Before return from me35", Debug)

	return (0)
}

Method(me36)
{
	Store("Before me35(0) run", Debug)
	me35(0)
	Store("After me35(0) completion", Debug)

	Store("Before me35(1) run", Debug)
	me35(1)
	Store("After me35(1) completion", Debug)
}

Method(m803,, Serialized)
{
	Name(i000, 0xabcd0000)

	Method(m000)
	{
		if (LNotEqual(i000, 0xabcd0000)) {
			err("", zFFF, 0x000, 0, 0, i000, 0xabcd0000)
		}
		Store(0xabcd0001, i000)
		return (0xabcd0002)
	}

	m000()

	Method(m001)
	{
		if (LNotEqual(i000, 0xabcd0001)) {
			err("", zFFF, 0x001, 0, 0, i000, 0xabcd0001)
		}
		Store(0xabcd0003, i000)
		return (0xabcd0004)
	}

	m001()

	Method(m002)
	{
		if (LNotEqual(i000, 0xabcd0003)) {
			err("", zFFF, 0x002, 0, 0, i000, 0xabcd0003)
		}
		Store(0xabcd0005, i000)
		return (0xabcd0006)
	}

	m002()

	Method(m003)
	{
		if (LNotEqual(i000, 0xabcd0005)) {
			err("", zFFF, 0x003, 0, 0, i000, 0xabcd0005)
		}
		Store(0xabcd0007, i000)
		return (0xabcd0008)
	}

	m003()
}

Method(m804,, Serialized)
{
	Name(i000, 0xabcd0000)

	Method(m000)
	{
		Method(m000)
		{
			if (LNotEqual(i000, 0xabcd0000)) {
				err("", zFFF, 0x004, 0, 0, i000, 0xabcd0000)
			}
			Store(0xabcd0001, i000)
			return (0xabcd0002)
		}

		m000()

		Method(m001)
		{
			if (LNotEqual(i000, 0xabcd0001)) {
				err("", zFFF, 0x005, 0, 0, i000, 0xabcd0001)
			}
			Store(0xabcd0003, i000)
			return (0xabcd0004)
		}

		m001()

		Method(m002)
		{
			if (LNotEqual(i000, 0xabcd0003)) {
				err("", zFFF, 0x006, 0, 0, i000, 0xabcd0003)
			}
			Store(0xabcd0005, i000)
			return (0xabcd0006)
		}

		m002()

		Method(m003)
		{
			if (LNotEqual(i000, 0xabcd0005)) {
				err("", zFFF, 0x007, 0, 0, i000, 0xabcd0005)
			}
			Store(0xabcd0007, i000)
			return (0xabcd0008)
		}

		m003()
	}

	m000()

	Method(m001)
	{
		Method(m000)
		{
			if (LNotEqual(i000, 0xabcd0007)) {
				err("", zFFF, 0x008, 0, 0, i000, 0xabcd0007)
			}
			Store(0xabcd0008, i000)
			return (0xabcd0009)
		}

		m000()

		Method(m001)
		{
			if (LNotEqual(i000, 0xabcd0008)) {
				err("", zFFF, 0x009, 0, 0, i000, 0xabcd0008)
			}
			Store(0xabcd000a, i000)
			return (0xabcd000b)
		}

		m001()

		Method(m002)
		{
			if (LNotEqual(i000, 0xabcd000a)) {
				err("", zFFF, 0x00a, 0, 0, i000, 0xabcd000a)
			}
			Store(0xabcd000c, i000)
			return (0xabcd000d)
		}

		m002()

		Method(m003)
		{
			if (LNotEqual(i000, 0xabcd000c)) {
				err("", zFFF, 0x00b, 0, 0, i000, 0xabcd000c)
			}
			Store(0xabcd000e, i000)
			return (0xabcd000f)
		}

		m003()
	}

	m001()

	Method(m002)
	{
		Method(m000)
		{
			if (LNotEqual(i000, 0xabcd000e)) {
				err("", zFFF, 0x00c, 0, 0, i000, 0xabcd000e)
			}
			Store(0xabcd0010, i000)
			return (0xabcd0011)
		}

		m000()

		Method(m001)
		{
			if (LNotEqual(i000, 0xabcd0010)) {
				err("", zFFF, 0x00d, 0, 0, i000, 0xabcd0010)
			}
			Store(0xabcd0012, i000)
			return (0xabcd0013)
		}

		m001()

		Method(m002)
		{
			if (LNotEqual(i000, 0xabcd0012)) {
				err("", zFFF, 0x00e, 0, 0, i000, 0xabcd0012)
			}
			Store(0xabcd0014, i000)
			return (0xabcd0015)
		}

		m002()

		Method(m003)
		{
			if (LNotEqual(i000, 0xabcd0014)) {
				err("", zFFF, 0x00f, 0, 0, i000, 0xabcd0014)
			}
			Store(0xabcd0016, i000)
			return (0xabcd0017)
		}

		m003()
	}

	m002()

	if (LNotEqual(i000, 0xabcd0016)) {
		err("", zFFF, 0x010, 0, 0, i000, 0xabcd0016)
	}
}


