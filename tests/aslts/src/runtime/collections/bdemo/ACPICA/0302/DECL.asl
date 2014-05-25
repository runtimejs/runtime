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
 * Bug 302:
 *
 * SUMMARY: Scope operation doesn't work for the root node Location
 */

Method(m1eb)
{
	Method(m100)
	{
		Method(m200,, Serialized)
		{
			Store("---------------- Before <Scope(\\_SB)>",debug)
			Scope(\_SB) { Name(i2z7, 0xabcd0007) }
			Store("---------------- After Scope(\\_SB)",debug)
			m201()
			Store("---------------- Completed.",debug)
		}

		Method(m201)
		{
			if (LNotEqual(\_SB.i2z7, 0xabcd0007)) {
				err("", zFFF, 0x000, 0, 0, \_SB.i2z7, 0xabcd0007)
			}
		}

		m200()
	}

	Method(m101)
	{
		Method(m202,, Serialized)
		{
			Store("---------------- Before <Scope(\\)>",debug)
			Scope(\) { Name(i2z4, 0xabcd0004) }
			Store("---------------- After Scope(\\)",debug)
			m203()
			Store("---------------- Completed.",debug)
		}

		Method(m203)
		{
			if (LNotEqual(\i2z4, 0xabcd0004)) {
				err("", zFFF, 0x001, 0, 0, \i2z4, 0xabcd0004)
			}
		}

		m202()
	}


	CH03("", 0, 0x002, 0, 0)

	SRMT("m1eb-m100")
	m100()

	SRMT("m1eb-m101")
	if (y302) {
		m101()
	} else {
		BLCK()
	}

	CH03("", 0, 0x003, 0, 0)
}


