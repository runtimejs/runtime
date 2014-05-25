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
 * References
 *
 * (exceptions)
 */

Name(z109, 109)

/*
 * Check exceptions for unavailable types of Store
 */
Method(m1b3,, Serialized)
{
	Name(ts, "m1b3")

	Store(z109, c081) // absolute index of file initiating the checking

	Method(m000, 1)
	{
		if (arg0) {
			Store(0, Local7)
		}
		CH03(ts, z109, 0, 0, 0)
		Store(Local7, Local0)
		if (LNot(SLCK))
		{
		    CH04(ts, 0, 0xff, z109, 1, 0, 0)
		}
	}

	Method(m901) { return (0xabc0012) }

	m000(0)

	Store(i900, Local0)
	Store(ObjectType(Local0), Local7)
	if (LNotEqual(Local7, c009)) {
		err(ts, z109, 2, 0, 0, Local7, c009)
	}

	Store(s900, Local0)
	Store(ObjectType(Local0), Local7)
	if (LNotEqual(Local7, c00a)) {
		err(ts, z109, 3, 0, 0, Local7, c00a)
	}

	Store(b900, Local0)
	Store(ObjectType(Local0), Local7)
	if (LNotEqual(Local7, c00b)) {
		err(ts, z109, 4, 0, 0, Local7, c00b)
	}

	Store(p900, Local0)
	Store(ObjectType(Local0), Local7)
	if (LNotEqual(Local7, c00c)) {
		err(ts, z109, 5, 0, 0, Local7, c00c)
	}

	Store(f900, Local0)
	Store(ObjectType(Local0), Local7)
	if (LNotEqual(Local7, c009)) {
		err(ts, z109, 6, 0, 0, Local7, c009)
	}

	CH03(ts, z109, 7, 0, 0)
	Store(d900, Local0)
	if (LNot(SLCK)){
	    CH04(ts, 0, 0xff, z109, 8, 0, 0)
	}

	CH03(ts, z109, 9, 0, 0)
	Store(e900, Local0)
	if (LNot(SLCK)){
	    CH04(ts, 0, 0xff, z109, 10, 0, 0)
	}

	/*
	 * 21.12.2005.
	 * No exception now.
	 * Bug 114: could work improperly by the same reason as Bug 114.
	 * MS compiler allow this situation, iASL compiler just allows this
	 * for compatibility, iASL assume this is compiled to a method
	 * invacation.
	 */
	if (X114) {
		CH03(ts, z109, 11, 0, 0)
		Store(m901, Local0)
		//CH04(ts, 0, 0xff, z109, 12, 0, 0)
	}

	CH03(ts, z109, 13, 0, 0)
	Store(mx90, Local0)
	if (LNot(SLCK)){
	    CH04(ts, 0, 0xff, z109, 14, 0, 0)
	}

	CH03(ts, z109, 15, 0, 0)
	Store(r900, Local0)
	if (LNot(SLCK)){
	    CH04(ts, 0, 0xff, z109, 16, 0, 0)
	}

	CH03(ts, z109, 17, 0, 0)
	Store(pw90, Local0)
	if (LNot(SLCK)){
	    CH04(ts, 0, 0xff, z109, 18, 0, 0)
	}

	CH03(ts, z109, 19, 0, 0)
	Store(pr90, Local0)
	if (LNot(SLCK)){
	    CH04(ts, 0, 0xff, z109, 20, 0, 0)
	}

	CH03(ts, z109, 21, 0, 0)
	Store(tz90, Local0)
	if (LNot(SLCK))
	{
	    CH04(ts, 0, 0xff, z109, 22, 0, 0)
	}

	Store(bf90, Local0)
	Store(ObjectType(Local0), Local7)
	if (LNotEqual(Local7, c009)) {
		err(ts, z109, 23, 0, 0, Local7, c009)
	}
}
