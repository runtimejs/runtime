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
 * Bug 243:
 *
 * SUMMARY: The normal work with mutexes is broken after the mutex Release order violation
 */

Method(m02f,, Serialized)
{
	Mutex(T500, 5)
	Mutex(T600, 6)
	Mutex(T700, 7)

	Method(m000)
	{
		Store("******** Test started", Debug)

		/* (1) */
		Store("Acquiring mutex of level 5:", Debug)
		Store(Acquire(T500, 0xffff), Local0)
		if (Local0) {
			Store("!!!!!!!! ERROR 0: Acquire T500 (Level 5, index 0)", Debug)
			err("", zFFF, 0x000, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquired T500 (Level 5, index 0)", Debug)
		}

		/* (2) */
		Store("Acquiring mutex of level 6:", Debug)
		Store(Acquire(T600, 0xffff), Local0)
		if (Local0) {
			Store("!!!!!!!! ERROR 1: Acquire T600 (Level 6, index 0)", Debug)
			err("", zFFF, 0x001, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquired T600 (Level 6, index 0)", Debug)
		}

		/* (3) */
		Store("Run Release of mutex of level 5 - exception AE_AML_MUTEX_ORDER is expected on it!", Debug)
		Store("Release T500 (Level 5, index 0)", Debug)
		Release(T500)
		/*
		 * If no exception there:
		 * ERROR: NO exception though expected! (it is the contents of bug 238)
		 */
		CH04("", 0, 64, 0, 0x002, 0, 0) // AE_AML_MUTEX_ORDER

		/* (4) */
		Store("Acquiring mutex of level 7:", Debug)
		Store(Acquire(T700, 0xffff), Local0)
		if (Local0) {
			Store("!!!!!!!! ERROR 3: Acquire T700 (Level 7, index 0)", Debug)
			err("", zFFF, 0x003, 0, 0, 0, 0)
		} else {
			Store("Ok: Acquired T700 (Level 7, index 0)", Debug)
			Store("Current level is equal to 7!", Debug)
		}
		CH03("", 0, 0x004, 0, 0)

		/* (5) */
		Store("Releasing the mutex of the current level: T700 (Level 7, index 0)", Debug)
		Release(T700)
		CH03("", 0, 0x005, 0, 0)

		/*
		 * (6)
		 *
		 * AE_AML_MUTEX_ORDER exception here which takes place
		 * is an essence of this bug 243.
		 */
		Store("Releasing mutex of level 6: T600 (Level 6, index 0)", Debug)
		Release(T600)
		CH03("", 0, 0x006, 0, 0)

		/* (7) */
		Store("Releasing mutex of level 5: T500 (Level 5, index 0)", Debug)
		Release(T500)
		CH03("", 0, 0x007, 0, 0)
	}

	Method(mm00)
	{
		m000()
	}

	mm00()
}

