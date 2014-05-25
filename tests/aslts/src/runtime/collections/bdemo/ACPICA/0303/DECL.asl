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
 * Bug 303:
 *
 * SUMMARY: Name operation performed from inside the If operation doesn't work for the full-path ObjectName
 */

Method(m1ec)
{
	// The usual case, it works
	Method(m000)
	{
		Method(m100, 1, Serialized, 3)
		{
			Name(\i4z0, 0xabcd0000)

			if (LNotEqual(i4z0, 0xabcd0000)) {
				err("", zFFF, 0x000, 0, 0, i4z0, 0xabcd0000)
			}
			if (LNotEqual(\i4z0, 0xabcd0000)) {
				err("", zFFF, 0x001, 0, 0, \i4z0, 0xabcd0000)
			}
			m101()
		}

		Method(m101)
		{
			if (LNotEqual(i4z0, 0xabcd0000)) {
				err("", zFFF, 0x002, 0, 0, i4z0, 0xabcd0000)
			}
			if (LNotEqual(\i4z0, 0xabcd0000)) {
				err("", zFFF, 0x003, 0, 0, \i4z0, 0xabcd0000)
			}
		}

		Store("---------------- The case 1 started:",debug)
		m100(0)
		Store("---------------- Completed.",debug)
	}

	// The case where Name(\i4z1, 0xabcd0000) is performed from If, it doesn't work.
	Method(m001)
	{
		Method(m100, 1, Serialized)
		{
			if (LNot(arg0)) {
				Name(\i4z1, 0xabcd0000)
			}

			if (LNotEqual(i4z1, 0xabcd0000)) {
				err("", zFFF, 0x004, 0, 0, i4z1, 0xabcd0000)
			}
			if (LNotEqual(\i4z1, 0xabcd0000)) {
				err("", zFFF, 0x005, 0, 0, \i4z1, 0xabcd0000)
			}
			m101()
		}

		Method(m101)
		{
			if (LNotEqual(i4z1, 0xabcd0000)) {
				err("", zFFF, 0x006, 0, 0, i4z1, 0xabcd0000)
			}
			if (LNotEqual(\i4z1, 0xabcd0000)) {
				err("", zFFF, 0x007, 0, 0, \i4z1, 0xabcd0000)
			}
		}

		Store("---------------- The case 2 started:",debug)
		m100(0)
		Store("---------------- Completed",debug)
	}

	CH03("", 0, 0x008, 0, 0)
	SRMT("m1ec-m000")
	m000()
	CH03("", 0, 0x009, 0, 0)
	SRMT("m1ec-m001")
	m001()
	CH03("", 0, 0x00a, 0, 0)
}


