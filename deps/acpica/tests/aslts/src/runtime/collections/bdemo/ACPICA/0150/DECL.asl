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
 * Bug 150:
 *
 * SUMMARY: No exception when Serialized Method is run after the higher level mutex acquiring
 *
 * EXAMPLES
 *
 * ROOT CAUSE
 *
 * SEE ALSO:
 */

/*
1. Acquire of the same mux several times without Releases
2. Acquire+Releases sequence of the same mux several times
3. Acquire mux level 7 then Release it and try Acquire mux level 6
4. Acquire mux level 7 then try Acquire mux level 6
5. Check all the specified features
*/

/*
 * The proper sequence of several enclosed Acquire operations.
 *
 * Acquire N level mutex then acquire (N+k) level mutex.
 */
Method(md8a,, Serialized)
{
	Mutex(mx00, 0)
	Mutex(mx01, 1)

	Store(0, Local0)
	Store(0, Local1)

	if (Acquire(mx00, 1)) {
		err("", zFFF, 0x000, 0, 0, 0, 0)
	} else {
		Store(1, Local0)
		if (Acquire(mx01, 1)) {
			err("", zFFF, 0x001, 0, 0, 0, 0)
		} else {
			Store(1, Local1)
		}
	}

	if (Local1) {
		Release(mx01)
	}
	if (Local0) {
		Release(mx00)
	}
}

/*
 * Improper sequence of several enclosed Acquire operations.
 *
 * Acquire N level mutex then acquire (N-k) level mutex.
 * Exception AE_AML_MUTEX_ORDER is expected in this case.
 */
Method(md8b,, Serialized)
{
	Mutex(mx00, 1)
	Mutex(mx01, 0)

	Store(0, Local0)
	Store(0, Local1)

	if (Acquire(mx00, 1)) {
		err("", zFFF, 0x002, 0, 0, 0, 0)
	} else {
		Store(1, Local0)
		CH03("", 0, 0x003, 0, 0)
		Acquire(mx01, 1)
		CH04("", 0, 64, 0, 0x004, 0, 0) // AE_AML_MUTEX_ORDER
	}
	if (Local0) {
		Release(mx00)
	}
}

/*
 * The proper sequence of several enclosed operations.
 *
 * Acquire N level mutex then call to Serialized Method
 * declared with (N+k) SyncLevel.
 */
Method(md8c,, Serialized)
{
	Mutex(mx00, 0)
	Method(mx01, 0, Serialized, 1)
	{
		Store("Run Method mx01", Debug)
	}

	Store(0, Local0)
	Store(0, Local1)

	if (Acquire(mx00, 1)) {
		err("", zFFF, 0x005, 0, 0, 0, 0)
	} else {
		Store(1, Local0)
		CH03("", 0, 0x006, 0, 0)
		mx01()
		CH03("", 0, 0x007, 0, 0)
	}

	if (Local0) {
		Release(mx00)
	}
}

/*
 * Improper sequence of several enclosed operations.
 *
 * Acquire N level mutex then call to Serialized Method declared with (N-k) SyncLevel.
 * Exception AE_AML_MUTEX_ORDER is expected in this case.
 */
Method(md8d,, Serialized)
{
	Mutex(mx00, 1)
	Method(mx01, 0, Serialized, 0)
	{
		Store("Run Method mx01", Debug)
	}

	Store(0, Local0)
	Store(0, Local1)

	if (Acquire(mx00, 1)) {
		err("", zFFF, 0x008, 0, 0, 0, 0)
	} else {
		Store(1, Local0)
		CH03("", 0, 0x009, 0, 0)
		mx01()
		CH04("", 0, 64, 0, 0x00a, 0, 0) // AE_AML_MUTEX_ORDER
	}

	if (Local0) {
		Release(mx00)
	}
}

Method(md8e)
{
	md8a()
	md8b()
	md8c()
	md8d()
}
