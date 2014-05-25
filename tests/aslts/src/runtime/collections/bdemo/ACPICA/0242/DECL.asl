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
 * Bug 242:
 *
 * SUMMARY: Releasing the mutex the first Acquired on the non-zero level makes Releasing the residuary mutexes of that level impossible
 */

Method(m031,, Serialized)
{
	Mutex(T000, 0)
	Mutex(T001, 0)
	Mutex(T002, 0)
	Mutex(T003, 0)

	Mutex(T100, 1)
	Mutex(T101, 1)
	Mutex(T102, 1)
	Mutex(T103, 1)


	/*
	 * Direct order for mutexes of level 0
	 *
	 * STATUS: works correctly - no exceptions
	 */
	Method(m000)
	{
		Store("******** Test 0, for mutexes of level 0", Debug)

		Store("Acquiring mutexes of level 0:", Debug)

		Store(Acquire(T000, 0xffff), Local0)
		if (Local0) {
			Store("ERROR: Acquire T000 (Level 0, index 0)", Debug)
			err("", zFFF, 0x000, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquire T000 (Level 0, index 0)", Debug)
		}

		Store(Acquire(T001, 0xffff), Local0)
		if (Local0) {
			Store("ERROR: Acquire T001 (Level 0, index 1)", Debug)
			err("", zFFF, 0x001, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquire T001 (Level 0, index 1)", Debug)
		}

		Store(Acquire(T002, 0xffff), Local0)
		if (Local0) {
			Store("ERROR: Acquire T002 (Level 0, index 2)", Debug)
			err("", zFFF, 0x002, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquire T002 (Level 0, index 2)", Debug)
		}

		Store(Acquire(T003, 0xffff), Local0)
		if (Local0) {
			Store("ERROR: Acquire T003 (Level 0, index 3)", Debug)
			err("", zFFF, 0x003, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquire T003 (Level 0, index 3)", Debug)
		}


		Store("Releasing mutexes of level 0:", Debug)

		Store("Release T000 (Level 0, index 0)", Debug)
		CH03("", 0, 0x004, 0, 0)
		Release(T000)
		CH03("", 0, 0x005, 0, 0)

		Store("Release T001 (Level 0, index 1)", Debug)
		CH03("", 0, 0x006, 0, 0)
		Release(T001)
		CH03("", 0, 0x007, 0, 0)

		Store("Release T002 (Level 0, index 2)", Debug)
		CH03("", 0, 0x008, 0, 0)
		Release(T002)
		CH03("", 0, 0x009, 0, 0)

		Store("Release T003 (Level 0, index 3)", Debug)
		CH03("", 0, 0x00a, 0, 0)
		Release(T003)
		CH03("", 0, 0x00b, 0, 0)
	}

	/*
	 * Direct order for mutexes of level 1
	 *
	 * STATUS: works incorrectly - has exceptions
	 */
	Method(m001)
	{
		Store("******** Test 1, for mutexes of level 1", Debug)

		Store("Acquiring mutexes of level 1:", Debug)

		Store(Acquire(T100, 0xffff), Local0)
		if (Local0) {
			Store("ERROR: Acquire T100 (Level 1, index 0)", Debug)
			err("", zFFF, 0x00c, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquire T100 (Level 1, index 0)", Debug)
		}

		Store(Acquire(T101, 0xffff), Local0)
		if (Local0) {
			Store("ERROR: Acquire T101 (Level 1, index 1)", Debug)
			err("", zFFF, 0x00d, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquire T101 (Level 1, index 1)", Debug)
		}

		Store(Acquire(T102, 0xffff), Local0)
		if (Local0) {
			Store("ERROR: Acquire T102 (Level 1, index 2)", Debug)
			err("", zFFF, 0x00e, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquire T102 (Level 1, index 2)", Debug)
		}

		Store(Acquire(T103, 0xffff), Local0)
		if (Local0) {
			Store("ERROR: Acquire T103 (Level 1, index 3)", Debug)
			err("", zFFF, 0x00f, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquire T103 (Level 1, index 3)", Debug)
		}


		Store("Releasing mutexes of Level 1:", Debug)

		Store("Release T100 (Level 1, index 0)", Debug)
		CH03("", 0, 0x010, 0, 0)
		Release(T100)
		CH03("", 0, 0x011, 0, 0)

		Store("Release T101 (Level 1, index 1)", Debug)
		CH03("", 0, 0x012, 0, 0)
		Release(T101)
		CH03("", 0, 0x013, 0, 0)

		Store("Release T102 (Level 1, index 2)", Debug)
		CH03("", 0, 0x014, 0, 0)
		Release(T102)
		CH03("", 0, 0x015, 0, 0)

		Store("Release T103 (Level 1, index 3)", Debug)
		CH03("", 0, 0x016, 0, 0)
		Release(T103)
		CH03("", 0, 0x017, 0, 0)
	}

	/*
	 * The test shows that no exception when the first
	 * Acquired mutex is Released in the last turn.
	 *
	 * STATUS: works correctly - no exception
	 */
	Method(m002)
	{
		Store("******** Test 2, for mutexes of level 1", Debug)

		Store("Acquiring mutexes of level 1:", Debug)

		Store(Acquire(T100, 0xffff), Local0)
		if (Local0) {
			Store("ERROR: Acquire T100 (Level 1, index 0)", Debug)
			err("", zFFF, 0x018, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquire T100 (Level 1, index 0)", Debug)
		}

		Store(Acquire(T101, 0xffff), Local0)
		if (Local0) {
			Store("ERROR: Acquire T101 (Level 1, index 1)", Debug)
			err("", zFFF, 0x019, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquire T101 (Level 1, index 1)", Debug)
		}

		Store(Acquire(T102, 0xffff), Local0)
		if (Local0) {
			Store("ERROR: Acquire T102 (Level 1, index 2)", Debug)
			err("", zFFF, 0x01a, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquire T102 (Level 1, index 2)", Debug)
		}

		Store(Acquire(T103, 0xffff), Local0)
		if (Local0) {
			Store("ERROR: Acquire T103 (Level 1, index 3)", Debug)
			err("", zFFF, 0x01b, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquire T103 (Level 1, index 3)", Debug)
		}


		Store("Releasing mutexes of Level 1:", Debug)

		Store("Release T101 (Level 1, index 1)", Debug)
		CH03("", 0, 0x01c, 0, 0)
		Release(T101)
		CH03("", 0, 0x01d, 0, 0)

		Store("Release T102 (Level 1, index 2)", Debug)
		CH03("", 0, 0x01e, 0, 0)
		Release(T102)
		CH03("", 0, 0x01f, 0, 0)

		Store("Release T103 (Level 1, index 3)", Debug)
		CH03("", 0, 0x020, 0, 0)
		Release(T103)
		CH03("", 0, 0x021, 0, 0)

		Store("Release T100 (Level 1, index 0)", Debug)
		CH03("", 0, 0x022, 0, 0)
		Release(T100)
		CH03("", 0, 0x023, 0, 0)
	}

	Method(mm00)
	{
		m000()
		m001()
		m002()
	}

	CH03("", 0, 0x024, 0, 0)
	mm00()
	CH03("", 0, 0x025, 0, 0)
}

