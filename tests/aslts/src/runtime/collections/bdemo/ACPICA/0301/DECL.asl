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
 * Bug 301:
 *
 * SUMMARY: Recursive calls to methods with the internal declarations (and Swithces) causes AE_AML_INTERNAL and crash
 */

Method(m1ea)
{
Method(m19c,, Serialized)
{
	Name(rpt0, 0)

	/*
	 * Total number of calls of the same Recursively Called method (RCM),
	 * the first call is counted there too.
	 */
	Name(n000, 3)

	Name(cnt0, 0) // how many methods are in progress simultaneously
	Name(max0, 0) // maximal number of methods being in progress simultaneously

	/*
	 * Open method execution
	 *
	 * arg0 - ID of method (1,2,3...)
	 * arg1 - the message to be reported
	 */
	Method(m800, 2)
	{
		if (rpt0) {
			Store(arg1, Debug)
		}
		Increment(cnt0)

		if (LGreater(cnt0, max0)) {
			Store(cnt0, max0)
		}
	}

	/*
	 * Close method execution
	 *
	 * arg0 - ID of method (1,2,3...)
	 */
	Method(m801, 1)
	{
		Decrement(cnt0)
	}

	/*
	 * Arguments of methods:
	 * arg0 - 0 - the first call, otherwise - recursive calls
	 */

	Name(c000, 3)

	Method(m100,, Serialized)
	{
		Name(c100, 3)
		Method(m200,, Serialized)
		{
			Name(c200, 3)
			Method(m300,, Serialized)
			{
				Name(c300, 3)
				Method(m400)
				{
					m800(4, "m400")
					Decrement(c300)
					if (LEqual(c300, 0)) {
						m300()
					} else {
						m400()
					}
					m801(4)
				}
				m800(3, "m300")
				Decrement(c200)
				if (LEqual(c200, 0)) {
					m200()
				} else {
					m400()
				}
				m801(3)
			}
			m800(2, "m200")
			Decrement(c100)
			if (LEqual(c100, 0)) {
				m100()
			} else {
				m300()
			}
			m801(2)
		}
		m800(1, "m100")
		Decrement(c000)
		if (LEqual(c000, 0)) {
			// m000()
		} else {
			m200()
		}
		m801(1)
	}

	m100()
}

	CH03("", 0, 0x000, 0, 0)
	m19c()
	CH03("", 0, 0x001, 0, 0)
}


