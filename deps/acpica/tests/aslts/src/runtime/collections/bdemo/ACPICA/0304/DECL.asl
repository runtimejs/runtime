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
 * Bug 304:
 *
 * SUMMARY: No exception AE_AML_METHOD_LIMIT for the number of method invocations exceeding 255
 */

Method(m1ed)
{
Method(m18a, 1, Serialized, 3)
{
	Name(rpt0, 0)
	Name(i000, 0)

	/*
	 * Total number of calls of the same Recursively Called method (RCM),
	 * the first call is counted there too.
	 */
	Name(n000, 3)

	Name(cnt0, 0) // how many methods are in progress simultaneously
	Name(max0, 0) // maximal number of methods being in progress simultaneously
	Name(cnt1, 0) // summary of total indexes

	Name(ix00, 0) // total index of current call
	Name(ind1, 0) // index of call to m100
	Name(ind2, 0) // index of call to m200
	Name(ind3, 0) // index of call to m300
	Name(ind4, 0) // index of call to m400

	Name(n100,  3) // number of calls to m100
	Name(n200,  6) // number of calls to m200
	Name(n300, 12) // number of calls to m300
	Name(n400, 24) // number of calls to m400

	Name(p100, Package(n100) {}) // Package to keep total indexs of call to m100
	Name(p200, Package(n200) {}) // Package to keep total indexs of call to m200
	Name(p300, Package(n300) {}) // Package to keep total indexs of call to m300
	Name(p400, Package(0x100) {}) // Package to keep total indexs of call to m400

	// Benchmarks of indexes
	Name(b1b0, Buffer(n100) {0,22,44})
	Name(b2b0, Buffer(n200) {1,11,21,  23,33,43})
	Name(b3b0, Buffer(n300) {2, 6,10,  12,16,20,  24,28,32,  34,38,42})
	Name(b4b0, Buffer(0x100) {3, 4, 5,   7, 8, 9,  13,14,15,  17,18,19,
					25,26,27,  29,30,31,  35,36,37,  39,40,41})

	/*
	 * Open method execution
	 *
	 * arg0 - ID of method (1,2,3...)
	 * arg1 - the message to be reported
	 */
	Method(m800, 2, Serialized)
	{
		if (rpt0) {
			Store(arg1, Debug)
		}
		Increment(cnt0)

		if (LGreater(cnt0, max0)) {
			Store(cnt0, max0)
		}

		Switch (ToInteger (arg0)) {
			Case (1) {
				Store(ix00, Index(p100, ind1))
				Increment(ind1)
			}
			Case (2) {
				Store(ix00, Index(p200, ind2))
				Increment(ind2)
			}
			Case (3) {
				Store(ix00, Index(p300, ind3))
				Increment(ind3)
			}
			Case (4) {
				Store(ix00, Index(p400, ind4))
				Increment(ind4)
			}
		}

		Increment(ix00) // total index
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
	 * arg0 - ID of method (1,2,3...)
	 * arg1 - number of elements to be compared
	 * arg2 - Package
	 * arg3 - Package with the benchmark values
	 */
	Method(m802, 4, Serialized) {
		Name(lpN0, 0)
		Name(lpC0, 0)

		Store(arg1, lpN0)
		Store(0, lpC0)

		While (lpN0) {

			Store(DeRefOf(Index(arg2, lpC0)), Local0)
			Store(DeRefOf(Index(arg3, lpC0)), Local1)
			if (LNotEqual(Local0, Local1)) {
				err("", zFFF, 0x000, 0, 0, Local0, Local1)
				Store(arg0, Debug)
				Store(lpC0, Debug)
			}
			Decrement(lpN0)
			Increment(lpC0)
		}

		Switch (ToInteger (arg0)) {
			Case (1) {
				if (LNotEqual(ind1, n100)) {
					err("", zFFF, 0x001, 0, 0, ind1, n100)
				}
			}
			Case (2) {
				if (LNotEqual(ind2, n200)) {
					err("", zFFF, 0x002, 0, 0, ind2, n200)
				}
			}
			Case (3) {
				if (LNotEqual(ind3, n300)) {
					err("", zFFF, 0x003, 0, 0, ind3, n300)
				}
			}
			Case (4) {
				if (LNotEqual(ind4, n400)) {
					err("", zFFF, 0x004, 0, 0, ind4, n400)
				}
			}
		}
	}

	/*
	 * Arguments of methods:
	 * arg0 - 0 - the first call, otherwise - recursive calls
	 */

	Name(c000, 3)
	Name(c100, 3)
	Name(c200, 3)
	Name(c300, 3)

	/*
	 * None internal objects (including Methods) or Switches in Serialized methods below
	 *
	 * Note: if Serialized method has internal objects (including Methods and Switches)
	 *       it could not be invoked recursively by the same thread.
	 */
	Method(m100, 0, Serialized, 0)
	{
		Store(3, c100)
		Store(ind1, Local1)
		Store(ix00, Local0)
		m800(1, "m100")
		Decrement(c000)
		if (LEqual(c000, 0)) {
			// m000()
		} else {
			m200()
		}
		m801(1)
		Add(cnt1, Local0, cnt1)
		Store(DerefOf(Index(p100, Local1)), Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x005, 0, 0, Local1, Local0)
		}
	}
	Method(m200, 0, Serialized, 0)
	{
		Store(3, c200)
		Store(ind2, Local1)
		Store(ix00, Local0)
		m800(2, "m200")
		Decrement(c100)
		if (LEqual(c100, 0)) {
			m100()
		} else {
			m300()
		}
		m801(2)
		Add(cnt1, Local0, cnt1)
		Store(DerefOf(Index(p200, Local1)), Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x006, 0, 0, Local1, Local0)
		}
	}
	Method(m300, 0, Serialized, 0)
	{
		if (i000) {
			Store(31, c300)
			// Store(32, c300) // AE_AML_METHOD_LIMIT occurs for this number (0x111 == 273)
		} else {
			Store(3, c300)
		}

		Store(ind3, Local1)
		Store(ix00, Local0)
		m800(3, "m300")
		Decrement(c200)
		if (LEqual(c200, 0)) {
			m200()
		} else {
			m400()
		}
		m801(3)
		Add(cnt1, Local0, cnt1)
		Store(DerefOf(Index(p300, Local1)), Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x007, 0, 0, Local1, Local0)
		}
	}
	Method(m400, 0, Serialized, 0)
	{
		Store(ind4, Local1)
		Store(ix00, Local0)
		m800(4, "m400")
		Decrement(c300)
		if (LEqual(c300, 0)) {
			m300()
		} else {
			m400()
		}
		m801(4)
		Add(cnt1, Local0, cnt1)
		Store(DerefOf(Index(p400, Local1)), Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x008, 0, 0, Local1, Local0)
		}
	}

	Store(arg0, i000)

	m100()

	Concatenate("Maximal number of methods being in progress simultaneously ", max0, Debug)

	// Check if exception takes place (AE_AML_METHOD_LIMIT)

	if (arg0) {
		CH04("", 0, 84, 0, 0x009, 0, 0) // AE_AML_METHOD_LIMIT
	} else {
		CH03("", 0, 0x00a, 0, 0)
	}
}

	CH03("", 0, 0x00b, 0, 0)
	SRMT("m18a-0")
	m18a(0)
	CH03("", 0, 0x00c, 0, 0)
	SRMT("m18a-1")
	m18a(1)
	CH03("", 0, 0x00d, 0, 0)
}
