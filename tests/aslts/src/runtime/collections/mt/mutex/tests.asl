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
 * The test strategies to be managed and controled by the
 * Control Thread and fulfilled by the Slave Threads (Slaves).
 */

Name(z152, 152)


/*
 * Acquire/Sleep/Release
 *
 * All slaves:
 * - Acquire the same mutex
 * - increment global counter
 * - set up another global to its Index
 * - sleep for the specified period
 * - check that the global contains just its Index
 * - Release mutex
 * Control thread:
 * - check after all threads complete that counter is correct
 *
 * arg0 - number of threads
 * arg1 - Level of mutex
 * arg2 - Index of mutex
 * arg3 - Number of mutexes of the same level
 */
Method(m801, 4, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(numW, 0) // number of threads in work

	/* Number of threads to be actually in work */
	Store(m213(arg0, 5, 4), numW)

	/* Set up per-thread set of mutexes */
	m334(numW, c300, arg1, 0, arg2, arg3)

	// c103 for all first num threads
	m210(bs00, arg0, c103, 0, numW, 1, c102) // cmd: Acquire/Sleep/Release
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)

	/* Check up the values of counters of all Mutexes */

	/* lpC0 - Index of mutex */

	Subtract(numW, 1, Local0) // exclude the Control thread
	Store(arg3, lpN0)
	Store(arg2, lpC0)
	While (lpN0) {
		m333(arg1, lpC0, Local0)
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * <Acquire/Sleep>(0-15 levels)/Release(15-0 levels)
 *
 * arg0 - number of threads
 * arg1 - Index of mutex
 * arg2 - Number of mutexes of the same level
 */
Method(m802, 3, Serialized)
{
	Name(numW, 0) // number of threads in work
	Name(lpN0, 0)
	Name(lpC0, 0)

	Name(lpN1, 0)
	Name(lpC1, 0)

	/* Number of threads to be actually in work */
	Store(m213(arg0, 5, 5), numW)

	/* Set up per-thread set of mutexes */
	m334(numW, c300, 0, 0, arg1, arg2)

	// c104 for all first num threads
	m210(bs00, arg0, c104, 0, numW, 1, c102) // cmd: <Acquire/Sleep>(0-15 levels)/Release(15-0 levels)
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)

	/* Check up the values of counters of all Mutexs */

	Subtract(numW, 1, Local0)
	Store(max0, lpN0)
	Store(0, lpC0)
	While (lpN0) {

		/* lpC0 - Level */

		Store(arg2, lpN1)
		Store(arg1, lpC1)
		While (lpN1) {

			/* lpC1 - Index of mutex */

			m333(lpC0, lpC1, Local0)

			Decrement(lpN1)
			Increment(lpC1)
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Example 0
 *
 * arg0 - number of threads
 * arg1 - Index of mutex
 * arg2 - Number of mutexes of the same level
 */
Method(m803, 1, Serialized)
{
	Name(numW, 0) // number of threads in work
	Name(lpN0, 0)
	Name(lpC0, 0)

	/* Number of threads to be actually in work */
	Store(m213(arg0, 6, 6), numW)

	// c105 for all first num threads
	m210(bs00, arg0, c105, 0, numW, 1, c102) // cmd: Example 0
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)
}

/*
 * Manage the test m804
 *
 * arg0 - number of threads
 * arg1 - 0        - thread_2 Releases than thread_1 Releases
 *        non-zero - thread_1 Releases than thread_2 Releases
 * Thread_1:
 * arg2 - Level of mutex (initial)
 * arg3 - Number of levels of mutexes
 * Thread_2:
 * arg4 - Level of mutex (initial)
 * arg5 - Number of levels of mutexes
 */
Method(m8ff, 6, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(thr, 0)


	/* ACQUIRING */


	/* === Thread 1 === */

	Store(1, thr)

	/* Set up per-thread set of mutexes */
	m334(arg0, c300, arg2, arg3, 0, 1)

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr, c106)  // cmd: Acquire specified set of mutexes
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m114(arg0)

	/* Wait for all Slave threads */
	m103(arg0)

	/* Check up the values of counters of all Mutexs */
	Store(arg3, lpN0)
	Store(arg2, lpC0)
	While (lpN0) {
		m333(lpC0, 0, 1)
		Decrement(lpN0)
		Increment(lpC0)
	}

	/* === Thread 2 === */

	Store(2, thr)

	/* Set up per-thread set of mutexes */
	m334(arg0, c300, arg4, arg5, 1, 1)

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr, c106)  // cmd: Acquire specified set of mutexes
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m114(arg0)

	/* Wait for all Slave threads */
	m103(arg0)

	/* Check up the values of counters of all Mutexs */
	Store(arg5, lpN0)
	Store(arg4, lpC0)
	While (lpN0) {
		m333(lpC0, 1, 1)
		Decrement(lpN0)
		Increment(lpC0)
	}


	/* RELEASING */


	if (LNot(arg1)) {

		/* === Thread 2 === */

		Store(2, thr)

		/* Set up per-thread set of mutexes */
		m334(arg0, c300, arg4, arg5, 1, 1)

		m200(bs00, arg0, c102) // cmd: Sleep
		m208(bs00, thr, c107)  // cmd: Release specified set of mutexes
		m114(arg0)

		/* Wait for all Slave threads */
		m103(arg0)
	}

	/* === Thread 1 === */

	Store(1, thr)

	/* Set up per-thread set of mutexes */
	m334(arg0, c300, arg2, arg3, 0, 1)

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr, c107)  // cmd: Release specified set of mutexes
	m114(arg0)

	/* Wait for all Slave threads */
	m103(arg0)

	if (arg1) {

		/* === Thread 2 === */

		Store(2, thr)

		/* Set up per-thread set of mutexes */
		m334(arg0, c300, arg4, arg5, 1, 1)

		m200(bs00, arg0, c102) // cmd: Sleep
		m208(bs00, thr, c107)  // cmd: Release specified set of mutexes
		m114(arg0)

		/* Wait for all Slave threads */
		m103(arg0)
	}
}

/*
 * arg0 - number of threads
 */
Method(m804, 1)
{
	/* I */
	m8ff(arg0, 0, 0, max0, 0, max0)

	/* Reset all counters (cnt0) and flags (fl00) corresponding to all Mutexes */
	m330()

	/* II */
	m8ff(arg0, 1, 0, max0, 0, max0)

	/* Reset all counters (cnt0) and flags (fl00) corresponding to all Mutexes */
	m330()

	/* III */
	m8ff(arg0, 1, 7, 1, 0, max0)
}

/*
 * arg0 - number of threads
 */
Method(m805, 1, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(thr, 0)

	Name(ee01, Buffer(arg0) {0, 63,   0}) // AE_AML_NOT_OWNER
	Name(ee02, Buffer(arg0) {0,  0,  63}) // AE_AML_NOT_OWNER


	/* 1. Thread_1 owns its set of all-level mutexes and falls into sleeping */

	Store(1, thr)

	/* Set up per-thread set of mutexes */
	m334(arg0, c300, 0, max0, 0, 1)

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr, c106)  // cmd: Acquire specified set of mutexes
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m114(arg0)

	/* Wait for all Slave threads */
	m103(arg0)

	/* Check up the values of counters of all Mutexs */
	Store(max0, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		m333(lpC0, 0, 1)
		Decrement(lpN0)
		Increment(lpC0)
	}


	/* 2,3. Thread_2 tries to Release all those mutexes owned by Thread_1 */

	Store(2, thr)

	/* Set up exception expectation on Release operation */
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m20f(arg0, ee02, 0)    // Init the exceptional conditions flags (AE_AML_NOT_OWNER)

	/* Set up per-thread set of mutexes */
	m334(arg0, c300, 0, max0, 0, 1)

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr, c107)  // cmd: Release specified set of mutexes
	m114(arg0)

	/* Wait for all Slave threads */
	m103(arg0)

	/* Reset exception expectation */
	m336(arg0, 1)


	/* 4. Thread_2 owns its set of all-level mutexes (not intersecting with Thread_1) */

	Store(2, thr)

	/* Set up per-thread set of mutexes */
	m334(arg0, c300, 0, max0, 1, 1)

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr, c106)  // cmd: Acquire specified set of mutexes
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m114(arg0)

	/* Wait for all Slave threads */
	m103(arg0)

	/* Check up the values of counters of all Mutexs */
	Store(max0, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		m333(lpC0, 0, 1)
		Decrement(lpN0)
		Increment(lpC0)
	}


	/* 5,6. Thread_2 tries again to Release mutexes owned by Thread_1 */

	Store(2, thr)

	/* Set up exception expectation on Release operation */
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m20f(arg0, ee02, 0)    // Init the exceptional conditions flags (AE_AML_NOT_OWNER)

	/* Set up per-thread set of mutexes */
	m334(arg0, c300, 0, max0, 0, 1)

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr, c107)  // cmd: Release specified set of mutexes
	m114(arg0)

	/* Wait for all Slave threads */
	m103(arg0)

	/* Reset exception expectation */
	m336(arg0, 1)


	/* 7,8. Thread_1 tries to Release mutexes owned by Thread_2 */

	Store(1, thr)

	/* Set up exception expectation on Release operation */
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m20f(arg0, ee01, 0)    // Init the exceptional conditions flags (AE_AML_NOT_OWNER)

	/* Set up per-thread set of mutexes */
	m334(arg0, c300, 0, max0, 1, 1)

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr, c107)  // cmd: Release specified set of mutexes
	m114(arg0)

	/* Wait for all Slave threads */
	m103(arg0)

	/* Reset exception expectation */
	m336(arg0, 1)


	/* 9. Thread_1 Releases its mutexes */

	Store(1, thr)

	/* Set up per-thread set of mutexes */
	m334(arg0, c300, 0, max0, 0, 1)

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr, c107)  // cmd: Release specified set of mutexes
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m114(arg0)

	/* Wait for all Slave threads */
	m103(arg0)


	/* 10. Thread_2 Releases its mutexes */

	Store(2, thr)

	/* Set up per-thread set of mutexes */
	m334(arg0, c300, 0, max0, 1, 1)

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr, c107)  // cmd: Release specified set of mutexes
	m114(arg0)

	/* Wait for all Slave threads */
	m103(arg0)
}

/*
 * arg0 - number of threads (total)
 */
Method(m806, 1, Serialized)
{
	Name(numW, 0) // number of threads in work
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(nth0, Buffer(2) {})
	Name(ix00, Buffer(Multiply(min1, 2)) {0,0,   0,1,   1,1,   2,1,   3,1})

	/*
	 * arg0-arg5 - same as m33f
	 * arg6 - index of thread according to the test scenario
	 */
	Method(m000, 7, Serialized)
	{
		Name(nth1, 0) // actually in work

		Store(DerefOf(Index(arg0, 1)), nth1)
		if (LLess(arg6, nth1)) {
			m33f(arg0, arg1, arg2, arg3, arg4, arg5, 0)
		}
	}

	/* Number of threads to be actually in work */
	Store(m213(arg0, min1, 4), numW)

	/* Pack numbers of threads */
	Store(m20d(arg0, numW), nth0)

	/* Data */

	Name(b001, Buffer(Multiply(min1, 2)) {0,0,     0,0,   0,1,   0,1,   0,1})
	Name(b002, Buffer(Multiply(min1, 2)) {0,0,     1,1,   0,0,   1,1,   1,1})
	Name(b003, Buffer(Multiply(min1, 2)) {0,0,     2,1,   2,1,   0,0,   2,1})
	Name(b004, Buffer(Multiply(min1, 2)) {0,0,     3,1,   3,1,   3,1,   0,0})

	Name(cm01, Package(min1) {0,   c107, 0,    0,    0})
	Name(ee01, Buffer(min1)  {0,   63,   0,    0,    0}) // AE_AML_NOT_OWNER

	Name(cm02, Package(min1) {0,   0,    c107, 0,    0})
	Name(ee02, Buffer(min1)  {0,   0,    63,   0,    0}) // AE_AML_NOT_OWNER

	Name(cm03, Package(min1) {0,   0,    0,    c107, 0})
	Name(ee03, Buffer(min1)  {0,   0,    0,    63,   0}) // AE_AML_NOT_OWNER

	Name(cm04, Package(min1) {0,   0,    0,    0,    c107})
	Name(ee04, Buffer(min1)  {0,   0,    0,    0,    63}) // AE_AML_NOT_OWNER


	/* Acquire */

	Store(max0, lpN0)
	Store(0, lpC0)
	While (lpN0) {

		/* All threads Acquire their mutexes */

		m33f(nth0,  // numbers of threads           (buffer/Integer)
			c106, // Commands                     (buffer/Integer)
			0,    // Exceptional conditions flags (buffer/Integer)
			lpC0, // Levels of mutexes            (buffer/Integer)
			ix00, // Indexes of mutexes           (buffer/Integer)
			c106, // Expected completion statuses (buffer/Integer)
			0)    // Expected hang statuses       (buffer/Integer)

		/* 2. Threads thr-2, thr-3, thr-4 attempt to Release mutex of thr-1 */

		if (LGreater(numW, 1)) {
			m000(nth0, cm02, ee02, lpC0, b001, cm02, 2)
			m000(nth0, cm03, ee03, lpC0, b001, cm03, 3)
			m000(nth0, cm04, ee04, lpC0, b001, cm04, 4)
		}

		/* 3. Threads thr-1, thr-3, thr-4 attempt to Release mutex of thr-2 */

		if (LGreater(numW, 2)) {
			m000(nth0, cm01, ee01, lpC0, b002, cm01, 1)
			m000(nth0, cm03, ee03, lpC0, b002, cm03, 3)
			m000(nth0, cm04, ee04, lpC0, b002, cm04, 4)
		}

		/* 4. Threads thr-1, thr-2, thr-4 attempt to Release mutex of thr-3 */

		if (LGreater(numW, 3)) {
			m000(nth0, cm01, ee01, lpC0, b003, cm01, 1)
			m000(nth0, cm02, ee02, lpC0, b003, cm02, 2)
			m000(nth0, cm04, ee04, lpC0, b003, cm04, 4)
		}

		/* 5. Threads thr-1, thr-2, thr-3 attempt to Release mutex of thr-4 */

		if (LGreater(numW, 4)) {
			m000(nth0, cm01, ee01, lpC0, b004, cm01, 1)
			m000(nth0, cm02, ee02, lpC0, b004, cm02, 2)
			m000(nth0, cm03, ee03, lpC0, b004, cm03, 3)
		}


		/* All threads Release their mutexes */

		m33f(nth0,  // numbers of threads           (buffer/Integer)
			c107, // Commands                     (buffer/Integer)
			0,    // Exceptional conditions flags (buffer/Integer)
			lpC0, // Levels of mutexes            (buffer/Integer)
			ix00, // Indexes of mutexes           (buffer/Integer)
			c107, // Expected completion statuses (buffer/Integer)
			0)    // Expected hang statuses       (buffer/Integer)

		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * arg0 - number of threads
 */
Method(m807, 1, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(lpN1, 0)
	Name(lpC1, 0)
	Name(ix00, 0)
	Name(numW, 0) // number of threads in work

	/* Number of threads to be actually in work */
	Store(m213(arg0, min1, 3), numW)


	/* From 15 to 0 */

	Store(max0, lpN0)
	Store(max0, ix00)
	Decrement(ix00)
	Store(ix00, lpC0)


	While (lpN0) {
		if (LNotEqual(lpC0, 0)) {
			/*
			 * 3. Acquire mutexes from 0 to (N-1) levels:
			 *	- Set up per-thread set of mutexes
			 *	- Acquire specified set of mutexes
			 *	- Wait for all Slave threads
			 *	- Check up the values of counters of all Mutexs
			 */
			m337(arg0, numW, 0, lpC0, 1, 0)

			/*
			 * 4. Release mutexes from 0 to (N-1) levels:
			 *	- Set up per-thread set of mutexes
			 *	- Release specified set of mutexes
			 *	- Wait for all Slave threads
			 */
			m338(arg0, numW, 0, lpC0)

			/* Reset all counters (cnt0) and flags (fl00) corresponding to all Mutexes */
			m330()
		}

		/* 5. Acquire mutex of level N */
		m337(arg0, numW, lpC0, 1, 1, 0)

		if (LNotEqual(lpC0, 0)) {
			/*
			 * 6. Attempt to Acquire mutexes from 0 to (N-1) levels
			 * 7. Exception is expected
			 */
			m337(arg0, numW, 0, lpC0, 0, 64) // With exceptional conditions flags (AE_AML_MUTEX_ORDER)

			/* Reset exception expectation */
			m336(arg0, 1)
		}

		if (LNotEqual(lpC0, ix00)) {
			/*
			 * 8. Acquire mutexes from (N+1) to 15 levels
			 *	- Set up per-thread set of mutexes
			 *	- Acquire specified set of mutexes
			 *	- Wait for all Slave threads
			 *	- Check up the values of counters of all Mutexs
			 */
			Add(lpC0, 1, Local0)
			Subtract(ix00, lpC0, Local1)
			m337(arg0, numW, Local0, Local1, 1, 0)
		}

		/*
		 * 9. Release all mutexes (starting with lpC0 up to 15 level):
		 *	- Set up per-thread set of mutexes
		 *	- Release specified set of mutexes
		 *	- Wait for all Slave threads
		 */
		Subtract(max0, lpC0, Local1)
		m338(arg0, numW, lpC0, Local1)

		/* Reset all counters (cnt0) and flags (fl00) corresponding to all Mutexes */
		m330()

		if (LNotEqual(lpC0, 0)) {
			/*
			 * 10. Acquire mutexes from 0 to (N-1) levels:
			 *	- Set up per-thread set of mutexes
			 *	- Acquire specified set of mutexes
			 *	- Wait for all Slave threads
			 *	- Check up the values of counters of all Mutexs
			 */
			m337(arg0, numW, 0, lpC0, 1, 0)

			/*
			 * 11. Release mutexes (from 0 to (N-1) levels):
			 *	- Set up per-thread set of mutexes
			 *	- Release specified set of mutexes
			 *	- Wait for all Slave threads
			 */
			m338(arg0, numW, 0, lpC0)

			/* Reset all counters (cnt0) and flags (fl00) corresponding to all Mutexes */
			m330()
		}

		Decrement(lpN0)
		Decrement(lpC0)
	}
}

/*
 * arg0 - number of threads (total)
 */
Method(m808, 1, Serialized)
{
	Name(pr, 0)
	Name(L000, 0)
	Name(nth0, Buffer(2) {})

	/*
	 * Per-thread indexes of mutexes
	 *
	 * Ctl-thr,   thr-1, thr-2, thr-3, thr-4
	 */
	Name(b000, Buffer(Multiply(min1, 2)) {0,0,  0,1, 1,1, 2,1, 3,1})
	Name(b001, Buffer(Multiply(min1, 2)) {0,0,  1,1, 2,1, 3,1, 0,1})
	Name(b002, Buffer(Multiply(min1, 2)) {0,0,  2,1, 3,1, 0,1, 1,1})
	Name(b003, Buffer(Multiply(min1, 2)) {0,0,  3,1, 0,1, 1,1, 2,1})


	/* Pack numbers of threads */
	Store(m20d(arg0, min1), nth0)

	/* x-0-123 */

	/*
	 * Acquire all x-0-123 and check owning
	 *
	 * Threads thr-1, thr-2, thr-3, thr-4
	 * acquire respectively all x-0-123 mutexes
	 * and check owning of all those mutexes.
	 */
	m33f(nth0,  // numbers of threads           (buffer/Integer)
		c106, // Commands                     (buffer/Integer)
		0,    // Exceptional conditions flags (buffer/Integer)
		L000, // Levels of mutexes            (buffer/Integer)
		b000, // Indexes of mutexes           (buffer/Integer)
		c106, // Expected completion statuses (buffer/Integer)
		0)    // Expected hang statuses       (buffer/Integer)

	if (pr) {
		m20b(0, "Acquire all x-0-123")
	}

	/* At this point threads have Acquired: x-0-123 */

	m8fe(nth0, L000, b000, b001, pr)
	m8fe(nth0, L000, b001, b002, pr)
	m8fe(nth0, L000, b002, b003, pr)
	m8fe(nth0, L000, b003, b000, pr)

	/* At this point threads have Acquired: x-0-123 */

	/* Release mutexes on all threads */

	Name(cm00, Package(min1) {0, c107, c107, c107, c107})
	Name(cp00, Package(min1) {0, c107, c107, c107, c107})

	m33f(nth0,  // numbers of threads           (buffer/Integer)
		cm00, // Commands                     (buffer/Integer)
		0,    // Exceptional conditions flags (buffer/Integer)
		L000, // Levels of mutexes            (buffer/Integer)
		b000, // Indexes of mutexes           (buffer/Integer)
		cp00, // Expected completion statuses (buffer/Integer)
		0)    // Expected hang statuses       (buffer/Integer)
	if (pr) {
		m20b(0, "Release all")
	}
}

/*
 * Manage the test m808
 *
 * agr0 - numbers of threads (buffer/Integer)
 * arg1 - levels of mutexes  (buffer/Integer)
 * arg2 - indexes of mutexes (buffer/Integer) - start point
 * arg3 - indexes of mutexes (buffer/Integer) - target point
 * arg4 - printing flag
 */
Method(m8fe, 5, Serialized)
{
	/*
	 * Comments are for one particular transfer step from
	 * x-0-123 to x-1-230, other steps are identical.
	 */

	/* At this point threads have Acquired: x-0-123 */

	/* x-1-230 */

	/* Acquire x-x-230 and check that all -230- hang */

	Name(cm00, Package(min1) {0, 0, c106, c106, c106})

	m33f(arg0,  // numbers of threads           (buffer/Integer)
		cm00, // Commands                     (buffer/Integer)
		0,    // Exceptional conditions flags (buffer/Integer)
		arg1, // Levels of mutexes            (buffer/Integer)
		arg3, // Indexes of mutexes           (buffer/Integer)
		0,    // Expected completion statuses (buffer/Integer)
		cm00) // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Acquire x-x-230")
	}

	/* Release x-0-xxx, this frees mux for thr-4 */

	Name(cm01, Package(min1) {0, c107, 0,    0,    0})
	Name(cp01, Package(min1) {0, c107, 0,    0,    c106})
	Name(hg01, Package(min1) {0, 0,    c106, c106, 0})

	m33f(arg0,  // numbers of threads           (buffer/Integer)
		cm01, // Commands                     (buffer/Integer)
		0,    // Exceptional conditions flags (buffer/Integer)
		arg1, // Levels of mutexes            (buffer/Integer)
		arg2, // Indexes of mutexes           (buffer/Integer)
		cp01, // Expected completion statuses (buffer/Integer)
		hg01) // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Release x-0-xxx")
	}

	/* Acquire x-1-xxx and check that it hangs too */

	Name(cm02, Package(min1) {0, c106, 0,    0,    0})
	Name(hg02, Package(min1) {0, c106, c106, c106, 0})

	m33f(arg0,  // numbers of threads           (buffer/Integer)
		cm02, // Commands                     (buffer/Integer)
		0,    // Exceptional conditions flags (buffer/Integer)
		arg1, // Levels of mutexes            (buffer/Integer)
		arg3, // Indexes of mutexes           (buffer/Integer)
		0,    // Expected completion statuses (buffer/Integer)
		hg02) // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Acquire x-1-xxx")
	}

	/* Release x-x-xx3, this frees mux for thr-3 */

	Name(cm03, Package(min1) {0, 0,    0,    0,    c107})
	Name(cp03, Package(min1) {0, 0,    0,    c106, c107})
	Name(hg03, Package(min1) {0, c106, c106, 0,    0})

	m33f(arg0,  // numbers of threads           (buffer/Integer)
		cm03, // Commands                     (buffer/Integer)
		0,    // Exceptional conditions flags (buffer/Integer)
		arg1, // Levels of mutexes            (buffer/Integer)
		arg2, // Indexes of mutexes           (buffer/Integer)
		cp03, // Expected completion statuses (buffer/Integer)
		hg03) // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Release x-x-xx3")
	}

	/* Release x-x-x2x, this frees mux for thr-2 */

	Name(cm04, Package(min1) {0, 0,    0,    c107, 0})
	Name(cp04, Package(min1) {0, 0,    c106, c107, 0})
	Name(hg04, Package(min1) {0, c106, 0,    0,    0})

	m33f(arg0,  // numbers of threads           (buffer/Integer)
		cm04, // Commands                     (buffer/Integer)
		0,    // Exceptional conditions flags (buffer/Integer)
		arg1, // Levels of mutexes            (buffer/Integer)
		arg2, // Indexes of mutexes           (buffer/Integer)
		cp04, // Expected completion statuses (buffer/Integer)
		hg04) // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Release x-x-x2x")
	}

	/* Release x-x-1xx, this frees mux for thr-1 */

	Name(cm05, Package(min1) {0, 0,    c107, 0, 0})
	Name(cp05, Package(min1) {0, c106, c107, 0, 0})

	m33f(arg0,  // numbers of threads           (buffer/Integer)
		cm05, // Commands                     (buffer/Integer)
		0,    // Exceptional conditions flags (buffer/Integer)
		arg1, // Levels of mutexes            (buffer/Integer)
		arg2, // Indexes of mutexes           (buffer/Integer)
		cp05, // Expected completion statuses (buffer/Integer)
		0)    // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Release x-x-1xx")
	}

	/* At this point threads have Acquired: x-1-230 */
}

/*
 * arg0 - number of threads (total)
 */
Method(m809, 1)
{
	m80c(arg0, 1)
}

/*
 * arg0 - number of threads (total)
 * arg1 - variant (of parameters passed to m8fd):
 *        0:
 *           arg1 - indexes of mutexes (buffer/Integer)
 *           arg2 - levels of mutexes  (buffer/Integer) - start point
 *           arg3 - levels of mutexes  (buffer/Integer) - target point
 *        1:
 *           arg1 - levels of mutexes  (buffer/Integer)
 *           arg2 - indexes of mutexes (buffer/Integer) - start point
 *           arg3 - indexes of mutexes (buffer/Integer) - target point
 */
Method(m80c, 2, Serialized)
{

	Name(pr, 0)
	Name(ixll, 0)
	Name(nth0, Buffer(2) {})

	/*
	 * Per-thread indexes/levels (depending on arg1) of mutexes
	 *
	 * Ctl-thr,   thr-1, thr-2, thr-3, thr-4
	 */
	Name(b000, Buffer(Multiply(min1, 2)) {0,0,   0,1,  1,1,  2,1,  3,1})
	Name(b001, Buffer(Multiply(min1, 2)) {0,0,   1,1,  2,1,  3,1,  4,1})
	Name(b002, Buffer(Multiply(min1, 2)) {0,0,   2,1,  3,1,  4,1,  5,1})
	Name(b003, Buffer(Multiply(min1, 2)) {0,0,   3,1,  4,1,  5,1,  6,1})
	Name(b004, Buffer(Multiply(min1, 2)) {0,0,   4,1,  5,1,  6,1,  7,1})
	Name(b005, Buffer(Multiply(min1, 2)) {0,0,   5,1,  6,1,  7,1,  8,1})
	Name(b006, Buffer(Multiply(min1, 2)) {0,0,   6,1,  7,1,  8,1,  9,1})
	Name(b007, Buffer(Multiply(min1, 2)) {0,0,   7,1,  8,1,  9,1, 10,1})
	Name(b008, Buffer(Multiply(min1, 2)) {0,0,   8,1,  9,1, 10,1, 11,1})
	Name(b009, Buffer(Multiply(min1, 2)) {0,0,   9,1, 10,1, 11,1, 12,1})
	Name(b00a, Buffer(Multiply(min1, 2)) {0,0,  10,1, 11,1, 12,1, 13,1})
	Name(b00b, Buffer(Multiply(min1, 2)) {0,0,  11,1, 12,1, 13,1, 14,1})
	Name(b00c, Buffer(Multiply(min1, 2)) {0,0,  12,1, 13,1, 14,1, 15,1})

	if (arg1) {
		/* The same level of mutexes */
		Store(0, ixll)
	} else {
		/* The same index of mutexes */
		Store(0, ixll)
	}

	/* Pack numbers of threads */
	Store(m20d(arg0, min1), nth0)

	/* x-0123 */

	/*
	 * x-0-1-2-3
	 * Acquire all x-0123 and check owning
	 *
	 * Threads thr-1, thr-2, thr-3, thr-4
	 * acquire respectively all x-0123 mutexes
	 * and check owning of all those mutexes.
	 */
	if (arg1) {
		Store(ixll, Local6)
		Store(b000, Local7)
	} else {
		Store(b000, Local6)
		Store(ixll, Local7)
	}
	m33f(nth0,    // numbers of threads           (buffer/Integer)
		c106,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		c106,   // Expected completion statuses (buffer/Integer)
		0)      // Expected hang statuses       (buffer/Integer)

	if (pr) {
		m20b(0, "Acquire all x-0123")
	}


	m8fd(nth0, ixll, b000, b001, pr, arg1)
	m8fd(nth0, ixll, b001, b002, pr, arg1)
	m8fd(nth0, ixll, b002, b003, pr, arg1)
	m8fd(nth0, ixll, b003, b004, pr, arg1)
	m8fd(nth0, ixll, b004, b005, pr, arg1)
	m8fd(nth0, ixll, b005, b006, pr, arg1)
	m8fd(nth0, ixll, b006, b007, pr, arg1)
	m8fd(nth0, ixll, b007, b008, pr, arg1)
	m8fd(nth0, ixll, b008, b009, pr, arg1)
	m8fd(nth0, ixll, b009, b00a, pr, arg1)
	m8fd(nth0, ixll, b00a, b00b, pr, arg1)
	m8fd(nth0, ixll, b00b, b00c, pr, arg1)


	/* x-(12)-(13)-(14)-(15), Release=x-(12)(13)(14)(15), hang=x-xxxx, success=x-(12)(13)(14)(15) */

	if (arg1) {
		Store(ixll, Local6)
		Store(b00c, Local7)
	} else {
		Store(b00c, Local6)
		Store(ixll, Local7)
	}
	m33f(nth0,  // numbers of threads           (buffer/Integer)
		c107, // Commands                     (buffer/Integer)
		0,    // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		c107, // Expected completion statuses (buffer/Integer)
		0)    // Expected hang statuses       (buffer/Integer)

	if (pr) {
		m20b(0, "Release x-(12)(13)(14)(15)")
	}
}

/*
 * arg0 - numbers of threads (buffer/Integer)
 * arg1 - indexes/levels of mutexes (buffer/Integer)
 * arg2 - levels/indexes of mutexes (buffer/Integer) - start point
 * arg3 - levels/indexes of mutexes (buffer/Integer) - target point
 * arg4 - printing flag
 * arg5 - variant (see m80c)
 */
Method(m8fd, 6, Serialized)
{
	/* At this point threads have Acquired: x-0123 */

	/*
	 * Comments are given for one particular transfer step
	 * from x-0-123 to x-1-230, other steps are identical.
	 */

	/* x-01-12-23-34, Acquire=x-1234, hang=x-123x, success=x-xxx4 */

	Name(cm00, Package(min1) {0, c106, c106, c106, c106})
	Name(cp00, Package(min1) {0, 0,    0,    0,    c106})
	Name(hg00, Package(min1) {0, c106, c106, c106, 0})

	if (arg5) {
		Store(arg1, Local6)
		Store(arg3, Local7)
	} else {
		Store(arg3, Local6)
		Store(arg1, Local7)
	}
	m33f(arg0,    // numbers of threads           (buffer/Integer)
		cm00,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		cp00,   // Expected completion statuses (buffer/Integer)
		hg00)   // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Acquire x-1234")
	}

	/* x-01-12-23-3, Release=x-xxx4, hang=x-123x, success=x-xxx4 */

	Name(cm01, Package(min1) {0, 0,    0,    0,    c107})
	Name(cp01, Package(min1) {0, 0,    0,    0,    c107})
	Name(hg01, Package(min1) {0, c106, c106, c106, 0})

	if (arg5) {
		Store(arg1, Local6)
		Store(arg3, Local7)
	} else {
		Store(arg3, Local6)
		Store(arg1, Local7)
	}
	m33f(arg0,    // numbers of threads           (buffer/Integer)
		cm01,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		cp01,   // Expected completion statuses (buffer/Integer)
		hg01)   // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Release x-xxx4")
	}

	/* x-01-12-23-x, Release=x-xxx3, hang=x-12xx, success=x-xx33 */

	Name(cm02, Package(min1) {0, 0,    0,    0,    c107})
	Name(cp02, Package(min1) {0, 0,    0,    c106, c107})
	Name(hg02, Package(min1) {0, c106, c106, 0,    0})

	if (arg5) {
		Store(arg1, Local6)
		Store(arg2, Local7)
	} else {
		Store(arg2, Local6)
		Store(arg1, Local7)
	}
	m33f(arg0,    // numbers of threads           (buffer/Integer)
		cm02,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		cp02,   // Expected completion statuses (buffer/Integer)
		hg02)   // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Release x-xxx3")
	}

	/* x-01-12-23-4, Acquire=x-xxx4, hang=x-12xx, success=x-xxx4 */

	Name(cm03, Package(min1) {0, 0,    0,    0,    c106})
	Name(cp03, Package(min1) {0, 0,    0,    0,    c106})
	Name(hg03, Package(min1) {0, c106, c106, 0,    0})

	if (arg5) {
		Store(arg1, Local6)
		Store(arg3, Local7)
	} else {
		Store(arg3, Local6)
		Store(arg1, Local7)
	}
	m33f(arg0,    // numbers of threads           (buffer/Integer)
		cm03,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		cp03,   // Expected completion statuses (buffer/Integer)
		hg03)   // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Acquire x-xxx4")
	}

	/* x-01-12-2-4, Release=x-xx3x, hang=x-12xx, success=x-xx3x */

	Name(cm05, Package(min1) {0, 0,    0,    c107, 0})
	Name(cp05, Package(min1) {0, 0,    0,    c107, 0})
	Name(hg05, Package(min1) {0, c106, c106, 0,    0})

	if (arg5) {
		Store(arg1, Local6)
		Store(arg3, Local7)
	} else {
		Store(arg3, Local6)
		Store(arg1, Local7)
	}
	m33f(arg0,    // numbers of threads           (buffer/Integer)
		cm05,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		cp05,   // Expected completion statuses (buffer/Integer)
		hg05)   // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Release x-xx3x")
	}

	/* x-01-12-x-4, Release=x-xx2x, hang=x-1xxx, success=x-x22x */

	Name(cm06, Package(min1) {0, 0,    0,    c107, 0})
	Name(cp06, Package(min1) {0, 0,    c106, c107, 0})
	Name(hg06, Package(min1) {0, c106, 0,    0,    0})

	if (arg5) {
		Store(arg1, Local6)
		Store(arg2, Local7)
	} else {
		Store(arg2, Local6)
		Store(arg1, Local7)
	}
	m33f(arg0,    // numbers of threads           (buffer/Integer)
		cm06,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		cp06,   // Expected completion statuses (buffer/Integer)
		hg06)   // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Release x-xx2x")
	}

	/* x-01-12-3-4, Acquire=x-xx3x, hang=x-1xxx, success=x-xx3x */

	Name(cm07, Package(min1) {0, 0,    0,    c106, 0})
	Name(cp07, Package(min1) {0, 0,    0,    c106, 0})
	Name(hg07, Package(min1) {0, c106, 0,    0,    0})

	if (arg5) {
		Store(arg1, Local6)
		Store(arg3, Local7)
	} else {
		Store(arg3, Local6)
		Store(arg1, Local7)
	}
	m33f(arg0,    // numbers of threads           (buffer/Integer)
		cm07,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		cp07,   // Expected completion statuses (buffer/Integer)
		hg07)   // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Acquire x-xx3x")
	}

	/* x-01-1-3-4, Release=x-x2xx, hang=x-1xxx, success=x-x2xx */

	Name(cm08, Package(min1) {0, 0,    c107, 0,    0})
	Name(cp08, Package(min1) {0, 0,    c107, 0,    0})
	Name(hg08, Package(min1) {0, c106, 0,    0,    0})

	if (arg5) {
		Store(arg1, Local6)
		Store(arg3, Local7)
	} else {
		Store(arg3, Local6)
		Store(arg1, Local7)
	}
	m33f(arg0,    // numbers of threads           (buffer/Integer)
		cm08,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		cp08,   // Expected completion statuses (buffer/Integer)
		hg08)   // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Release x-x2xx")
	}

	/* x-01-x-3-4, Release=x-x1xx, hang=x-xxxx, success=x-11xx */

	Name(cm09, Package(min1) {0, 0,    c107, 0,    0})
	Name(cp09, Package(min1) {0, c106, c107, 0,    0})

	if (arg5) {
		Store(arg1, Local6)
		Store(arg2, Local7)
	} else {
		Store(arg2, Local6)
		Store(arg1, Local7)
	}
	m33f(arg0,    // numbers of threads           (buffer/Integer)
		cm09,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		cp09,   // Expected completion statuses (buffer/Integer)
		0)      // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Release x-x1xx")
	}

	/* x-01-2-3-4, Acquire=x-x2xx, hang=x-xxxx, success=x-x2xx */

	Name(cm0a, Package(min1) {0, 0,    c106, 0,    0})
	Name(cp0a, Package(min1) {0, 0,    c106, 0,    0})

	if (arg5) {
		Store(arg1, Local6)
		Store(arg3, Local7)
	} else {
		Store(arg3, Local6)
		Store(arg1, Local7)
	}
	m33f(arg0,    // numbers of threads           (buffer/Integer)
		cm0a,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		cp0a,   // Expected completion statuses (buffer/Integer)
		0)      // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Acquire x-x2xx")
	}

	/* x-0-2-3-4, Release=x-1xxx, hang=x-xxxx, success=x-1xxx */

	Name(cm0b, Package(min1) {0, c107, 0,    0,    0})
	Name(cp0b, Package(min1) {0, c107, 0,    0,    0})

	if (arg5) {
		Store(arg1, Local6)
		Store(arg3, Local7)
	} else {
		Store(arg3, Local6)
		Store(arg1, Local7)
	}
	m33f(arg0,    // numbers of threads           (buffer/Integer)
		cm0b,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		cp0b,   // Expected completion statuses (buffer/Integer)
		0)      // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Release x-1xxx")
	}

	/* x-x-2-3-4, Release=x-0xxx, hang=x-xxxx, success=x-0xxx */

	Name(cm0c, Package(min1) {0, c107, 0,    0,    0})
	Name(cp0c, Package(min1) {0, c107, 0,    0,    0})

	if (arg5) {
		Store(arg1, Local6)
		Store(arg2, Local7)
	} else {
		Store(arg2, Local6)
		Store(arg1, Local7)
	}
	m33f(arg0,    // numbers of threads           (buffer/Integer)
		cm0c,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		cp0c,   // Expected completion statuses (buffer/Integer)
		0)      // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Release x-0xxx")
	}

	/* x-1-2-3-4, Acquire=x-1xxx, hang=x-xxxx, success=x-1xxx */

	Name(cm0d, Package(min1) {0, c106, 0,    0,    0})
	Name(cp0d, Package(min1) {0, c106, 0,    0,    0})

	if (arg5) {
		Store(arg1, Local6)
		Store(arg3, Local7)
	} else {
		Store(arg3, Local6)
		Store(arg1, Local7)
	}
	m33f(arg0,    // numbers of threads           (buffer/Integer)
		cm0d,   // Commands                     (buffer/Integer)
		0,      // Exceptional conditions flags (buffer/Integer)
		Local6, // Levels of mutexes            (buffer/Integer)
		Local7, // Indexes of mutexes           (buffer/Integer)
		cp0d,   // Expected completion statuses (buffer/Integer)
		0)      // Expected hang statuses       (buffer/Integer)
	if (arg4) {
		m20b(0, "Acquire x-1xxx")
	}

	/* At this point threads have Acquired: x-1234 */
}

/*
 * arg0 - number of threads (total)
 */
Method(m810, 1)
{
	m80c(arg0, 0)
}

/*
 * arg0 - number of threads (total)
 */
Method(m811, 1, Serialized)
{
	Name(rpt, 4)
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(lpN1, 0)
	Name(lpC1, 0)
	Name(nth0, Buffer(2) {})
	Name(ix00, Buffer(Multiply(min1, 2)) {0,0,   0,1,   1,1,   2,1,   3,1})
	Name(numW, 0) // number of threads in work

	/* Number of threads to be actually in work */
	Store(m213(arg0, min1, 4), numW)

	/* Pack numbers of threads */
	Store(m20d(arg0, numW), nth0)


	/* Each thread Acquires successfully its mutex N times */

	Store(max0, lpN0)
	Store(0, lpC0)
	While (lpN0) {

		Store(rpt, lpN1)
		Store(0, lpC1)

		/* Repetition */
		While (lpN1) {
			m33f(nth0,  // numbers of threads           (buffer/Integer)
				c106, // Commands                     (buffer/Integer)
				0,    // Exceptional conditions flags (buffer/Integer)
				lpC0, // Levels of mutexes            (buffer/Integer)
				ix00, // Indexes of mutexes           (buffer/Integer)
				c106, // Expected completion statuses (buffer/Integer)
				0)    // Expected hang statuses       (buffer/Integer)
			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}


	/* Each thread Releases successfully its mutex N times */

	Store(max0, lpN0)
	Subtract(max0, 1, lpC0)
	While (lpN0) {

		Store(rpt, lpN1)
		Store(0, lpC1)

		/* Repetition */
		While (lpN1) {
			m33f(nth0,  // numbers of threads           (buffer/Integer)
				c107, // Commands                     (buffer/Integer)
				0,    // Exceptional conditions flags (buffer/Integer)
				lpC0, // Levels of mutexes            (buffer/Integer)
				ix00, // Indexes of mutexes           (buffer/Integer)
				c107, // Expected completion statuses (buffer/Integer)
				0)    // Expected hang statuses       (buffer/Integer)
			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Decrement(lpC0)
	}


	/*
	 * Each thread gets exception AE_AML_MUTEX_NOT_ACQUIRED (65)
	 * on additional Release.
	 */

	Store(max0, lpN0)
	Subtract(max0, 1, lpC0)
	While (lpN0) {
		m33f(nth0,  // numbers of threads           (buffer/Integer)
			c107, // Commands                     (buffer/Integer)
			65,   // Exceptional conditions flags (buffer/Integer)
			lpC0, // Levels of mutexes            (buffer/Integer)
			ix00, // Indexes of mutexes           (buffer/Integer)
			c107, // Expected completion statuses (buffer/Integer)
			0)    // Expected hang statuses       (buffer/Integer)
		Decrement(lpN0)
		Decrement(lpC0)
	}
}

/*
 * arg0 - number of threads (total)
 */
Method(m812, 1, Serialized)
{
	Name(rpt, 3)  // number of repetition
	Name(lpN0, 0) // level
	Name(lpC0, 0)
	Name(lpN1, 0) // index-thread
	Name(lpC1, 0)
	Name(indt, 0) // index of thread
	Name(lpN2, 0) // repetition
	Name(lpC2, 0)
	Name(lls0, 0)
	Name(num2, 0)
	Name(ixsz, 0)
	Name(numW, 0) // number of threads in work

	Store(Multiply(min1, 2), ixsz)

	Name(nth0, Buffer(2) {})

	// Buffers of indexes of mutexes
	Name(pixs, Package(min1) {
		0,
		Buffer(ixsz) {0,0,   0,1,   0,1,   0,1,   0,1},
		Buffer(ixsz) {0,0,   1,1,   1,1,   1,1,   1,1},
		Buffer(ixsz) {0,0,   2,1,   2,1,   2,1,   2,1},
		Buffer(ixsz) {0,0,   3,1,   3,1,   3,1,   3,1},
	})

	Name(bixs, Buffer(ixsz) {})

	Name(cm00, Buffer(min1) {})
	Name(cp00, Buffer(min1) {})
	Name(hg00, Buffer(min1) {})


	/*
	 * Determine num - number of threads actually in work
	 *
	 * Note: maximum for num is min1 here but it can be diminished
	 * to reduce the time of execution.
	 */
	Store(m213(arg0, min1, 3), numW)
	Subtract(numW, 1, num2) // except the control thread

	/* Pack numbers of threads */
	Store(m20d(arg0, numW), nth0)

	/*
	 * Determine lls0 - number of levels to be in work
	 *
	 * Note: maximum for lls0 is max0 here but it can be diminished
	 * to reduce the time of execution.
	 */
	if (redm) {
		Store(3, lls0)
	} else {
		Store(max0, lls0)
	}


	/* 9. Do 1-8 for all Levels of mutex one by one */
	Store(lls0, lpN0)
	Store(0, lpC0)
	While (lpN0) {

		/*
		 * 8. Do 1-7 for all threads one by one (so, for 0-3 Indexes of mutex as well)
		 */
		Store(num2, lpN1)
		Store(0, lpC1)
		While (lpN1) {

		Add(lpC1, 1, indt)

		Store(DerefOf(Index(pixs, indt)), bixs)


		/* 1. Thread thr-i Acquires successfully mutex M0 of (i-1)-th index for N times */


		// c106 for indt-th thread
		m210(cm00, numW, c106, indt, 1, 1, 0)

		/* Repetition */
		Store(rpt, lpN2)
		Store(0, lpC2)
		While (lpN2) {
			m33f(nth0,  // numbers of threads           (buffer/Integer)
				cm00, // Commands                     (buffer/Integer)
				0,    // Exceptional conditions flags (buffer/Integer)
				lpC0, // Levels of mutexes            (buffer/Integer)
				bixs, // Indexes of mutexes           (buffer/Integer)
				cm00, // Expected completion statuses (buffer/Integer)
				0)    // Expected hang statuses       (buffer/Integer)
			Decrement(lpN2)
			Increment(lpC2)
		}

		/* 2. Other threads Acquire M0 too and hang */

		/*
		 * c103 for all except indt-th thread
		 * (and except 0-th thread naturally,
		 * not mentioned more below)
		 */
		m200(cm00, numW, c103)
		m208(cm00, indt, 0)

		m33f(nth0, cm00, 0, lpC0, bixs, 0, cm00)

		/* 3. Thread thr-i Acquires successfully mutex M0 for N times again */

		// c106 for indt-th thread
		m210(cm00, numW, c106, indt, 1, 1, 0)

		// c103 for all except indt-th thread
		m200(hg00, numW, c103)
		m208(hg00, indt, 0)

		/* Repetition */
		Store(rpt, lpN2)
		Store(0, lpC2)
		While (lpN2) {
			m33f(nth0, cm00, 0, lpC0, bixs, cm00, hg00)
			Decrement(lpN2)
			Increment(lpC2)
		}

		/* 4. Thread thr-i Releases mutex M0 for 2*N times */

		// c107 for indt-th thread
		m210(cm00, numW, c107, indt, 1, 1, 0)

		// c103 for all except indt-th thread
		m200(hg00, numW, c103)
		m208(hg00, indt, 0)

		/* Repetition */
		Multiply(rpt, 2, lpN2)
		Decrement(lpN2)
		Store(0, lpC2)
		While (lpN2) {
			m33f(nth0, cm00, 0, lpC0, bixs, cm00, hg00)
			Decrement(lpN2)
			Increment(lpC2)
		}

		/*
		 * 5. One of other threads (thr-j) owns M0
		 * 6. Thread thr-j Release M0
		 * 7. Do 5-6 items for all 'other' threads
		 */

		// c107 for indt-th thread
		m210(cm00, numW, c107, indt, 1, 1, 0)

		// c103 for all except indt-th thread, and c107 for indt-th thread
		m200(cp00, numW, c103)
		m208(cp00, indt, c107)

		m33f(nth0, cm00, 0, lpC0, bixs, cp00, 0)

		Decrement(lpN1)
		Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * arg0 - number of threads (total)
 */
Method(m813, 1, Serialized)
{
	Name(rpt, 256) // number of repetition
	Name(lpN0, 0) // level
	Name(lpC0, 0)
	Name(lpN1, 0) // index-thread
	Name(lpC1, 0)
	Name(indt, 0) // index of thread
	Name(lpN2, 0) // repetition
	Name(lpC2, 0)
	Name(lls0, 0) // number of levels
	Name(num2, 0)
	Name(ixsz, 0)
	Name(numW, 0) // number of threads in work

	Store(Multiply(min1, 2), ixsz)

	Name(nth0, Buffer(2) {})

	// Buffer of per-thread indexes of mutexes
	Name(ix00, Buffer(ixsz) {0,0,   0,1,   1,1,   2,1,   3,1})

	Name(cm00, Buffer(min1) {})

	/*
	 * Determine num - number of threads actually in work
	 * See input control on arg0 (before m813)
	 *
	 * Note: maximum for num is min1 here but it can be diminished
	 * to reduce the time of execution.
	 */
	Store(m213(arg0, 3, 2), numW)
	Subtract(numW, 1, num2) // except the control thread

	/* Pack numbers of threads */
	Store(m20d(arg0, numW), nth0)

	/*
	 * Determine lls0 - number of levels to be in work
	 *
	 * Note: maximum for lls0 is max0 here but it can be diminished
	 * to reduce the time of execution.
	 */
	if (redm) {
		Store(1, lls0)
	} else {
		Store(max0, lls0)
	}


	/* For all Levels of mutex one by one */
	Store(lls0, lpN0)
	Store(0, lpC0)
	While (lpN0) {

		/* For different indexes-threads one by one */
		Store(num2, lpN1)
		Store(0, lpC1)
		While (lpN1) {

		Add(lpC1, 1, indt)


		/* Thread thr-i Acquires successfully mutex M0 of (i-1)-th index for N times */


		// c106 for indt-th thread
		m210(cm00, numW, c106, indt, 1, 1, 0)

		/* Repetition */
		Store(rpt, lpN2)
		Store(0, lpC2)
		While (lpN2) {
			m33f(nth0,  // numbers of threads           (buffer/Integer)
				cm00, // Commands                     (buffer/Integer)
				0,    // Exceptional conditions flags (buffer/Integer)
				lpC0, // Levels of mutexes            (buffer/Integer)
				ix00, // Indexes of mutexes           (buffer/Integer)
				cm00, // Expected completion statuses (buffer/Integer)
				0)    // Expected hang statuses       (buffer/Integer)
			Decrement(lpN2)
			Increment(lpC2)
		}

		/* Thread thr-i Releases mutex M0 for N times */

		// c107 for indt-th thread
		m210(cm00, numW, c107, indt, 1, 1, 0)

		/* Repetition */
		Store(rpt, lpN2)
		Store(0, lpC2)
		While (lpN2) {
			m33f(nth0, cm00, 0, lpC0, ix00, cm00, 0)
			Decrement(lpN2)
			Increment(lpC2)
		}


		Decrement(lpN1)
		Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * arg0 - number of threads (total)
 */
Method(m814, 1, Serialized)
{
	Name(lpN0, 0) // level
	Name(lpC0, 0)
	Name(lpN1, 0) // index
	Name(lpC1, 0)
	Name(thr1, 0)
	Name(thr2, 0)


	Store(1, thr1)
	Store(m115(arg0), thr2) // thread with the greatest index

	if (LGreaterEqual(thr2, arg0)) {
		Store("No alive threads for Test!", Debug)
		Store("Test mf14 skipped!", Debug)
		SKIP()
		return
	}

	if (LLessEqual(thr2, thr1)) {
		Store("Insufficient number of threads for Test!", Debug)
		Store("Test mf14 skipped!", Debug)
		SKIP()
		return
	}


	/* 1. Thread thr-N Acquires all the mutexes on all levels */

	/* Set up per-thread set of mutexes */
	m334(arg0, c300, 0, max0, 0, min0)

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr2, c106) // cmd: Acquire specified set of mutexes
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)

	/* Check up the values of counters of all Mutexs */
	Store(max0, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		Store(min0, lpN1)
		Store(0, lpC1)
		While (lpN1) {
			m333(lpC0, lpC1, 1)
			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}


	/*
	 * 2. Thread thr-1 tries to Acquire all the same mutexes
	 *    and gets FAIL (TimeOutValue is not 0xFFFF).
	 */

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr1, c106) // cmd: Acquire specified set of mutexes
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m214(arg0, arg0, TOV1) // TimeOutValue equal to 1 msec
	m20f(arg0, EX0D, 0)    // Init the exceptional conditions flags (FAIL)
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)


	/* 3. Thread thr-N terminates */

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr2, c108) // cmd: Terminate thread
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)


	/*
	 * 4. Thread thr-1 Acquire all those mutexes again
	 *    and gets success (TimeOutValue is 0xFFFF)
	 */

	/* Sleep, to ensure the thread thr-N terminates */
	m206(0, 200)

	/*
	 * Reset all counters (cnt0) and flags (fl00) corresponding
	 * to all Mutexes which were set up by thread thr-N.
	 */
	m330()

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr1, c106) // cmd: Acquire specified set of mutexes
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)


	/* 5. Thread thr-1 Releases all mutexes */

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr1, c107) // cmd: Release specified set of mutexes
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)
}

/*
 * arg0 - number of threads (total)
 */
Method(m815, 1, Serialized)
{
	Name(lpN0, 0) // level
	Name(lpC0, 0)
	Name(lpN1, 0) // index
	Name(lpC1, 0)
	Name(thr1, 0)
	Name(thr2, 0)


	Store(1, thr1)
	Store(m115(arg0), thr2) // thread with the greatest index

	if (LGreaterEqual(thr2, arg0)) {
		Store("No alive threads for Test!", Debug)
		Store("Test mf14 skipped!", Debug)
		SKIP()
		return
	}

	if (LLessEqual(thr2, thr1)) {
		Store("Insufficient number of threads for Test!", Debug)
		Store("Test mf15 skipped!", Debug)
		SKIP()
		return
	}


	/* 1. Thread thr-N Acquires all the mutexes on all levels */

	/* Set up per-thread set of mutexes */
	m334(arg0, c300, 0, max0, 0, min0)

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr2, c106) // cmd: Acquire specified set of mutexes
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)

	/* Check up the values of counters of all Mutexs */
	Store(max0, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		Store(min0, lpN1)
		Store(0, lpC1)
		While (lpN1) {
			m333(lpC0, lpC1, 1)
			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}


	/*
	 * 2. Thread thr-1 tries to Acquire all the same mutexes
	 *    and gets FAIL (TimeOutValue is not 0xFFFF).
	 */

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr1, c106) // cmd: Acquire specified set of mutexes
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m214(arg0, arg0, TOV1) // TimeOutValue equal to 1 msec
	m20f(arg0, EX0D, 0)    // Init the exceptional conditions flags (FAIL)
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)


	/*
	 * 3. Thread thr-1 tries to Acquire all the same mutexes
	 * and hang (TimeOutValue is 0xFFFF).
	 */

	/*
	 * Reset all counters (cnt0) and flags (fl00) corresponding
	 * to all Mutexes which were set up by thread thr-N.
	 */
	m330()

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr1, c106) // cmd: Acquire specified set of mutexes
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m114(arg0) // run

	/* Wait for all Slave threads */

	Name(cp00, Buffer(arg0) {})
	Name(hg00, Buffer(arg0) {})
	Name(id00, Buffer(arg0) {})

	CopyObject(bs00, cp00)
	Store(0, Index(cp00, thr1))
	Store(c106, Index(hg00, thr1))
	m110(arg0, cp00, hg00, id00)


	/*
	 * 4. Thread thr-N terminates
	 * 5. Thread thr-1 owns all those mutexes
	 */

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr2, c108) // cmd: Terminate thread
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m114(arg0) // run

	/* Wait for all Slave threads */

	Name(cp01, Buffer(arg0) {})
	Name(hg01, Buffer(arg0) {})
	Name(id01, Buffer(arg0) {})

	Store(c106, Index(bs00, thr1)) // thr-1 hangs on c106
	CopyObject(bs00, cp01)
	m110(arg0, cp01, hg01, id01)


	/* 6. Thread thr-1 Releases all mutexes */

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr1, c107) // cmd: Release specified set of mutexes
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)
}

/*
 * Serialized method to be executed by Slave thread
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(m8fc, 3, Serialized, 0)
{
	if (FLG2) {
		se00(arg2, er10, , "Error er10")
	}

	Store(arg1, FLG2)

	m201(arg2, vb03, "Execution of Serialized method started")
	m206(arg2, sl01) // Sleep

	/*
	 * NOTE: it is a recurcive second call to m101:
	 *
	 *       MAIN
	 *         mf00
	 *           mf16
	 *             m101
	 *               m8fc
	 *                 m101
	 *
	 * So, additional command c101 is needed for it to exit that second call to m101.
	 */
	m201(arg2, vb03, "Call recursively m101")
	m101(arg0, arg1, arg2, 1)

	m206(arg2, sl01) // Sleep

	m201(arg2, vb03, "Execution of Serialized method completed")

	if (LNotEqual(FLG2, arg1)) {
		se00(arg2, er11, , "Error er11")
	}

	Store(0, FLG2)
}

/*
 * Non-serialized method to be executed by Slave thread,
 * use mutex for exclusive access to critical section.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(m8fa, 3)
{
	Store(ma00(0, 0, 0xffff), Local0)
	if (Local0) {
		se00(arg2, er00, , "Error er00")
	}

	if (FLG2) {
		se00(arg2, er10, , "Error er10")
	}

	Store(arg1, FLG2)

	m201(arg2, vb03, "Execution of critical section started")
	m206(arg2, sl01) // Sleep

	/*
	 * NOTE: it is a recurcive second call to m101:
	 *
	 *       MAIN
	 *         mf00
	 *           mf16
	 *             m101
	 *               m8fc
	 *                 m101
	 *
	 * So, additional command c101 is needed for it to exit that second call to m101.
	 */
	m201(arg2, vb03, "Call recursively m101")
	m101(arg0, arg1, arg2, 1)

	m206(arg2, sl01) // Sleep

	m201(arg2, vb03, "Execution of critical section completed")

	if (LNotEqual(FLG2, arg1)) {
		se00(arg2, er11, , "Error er11")
	}

	Store(0, FLG2)

	if (LNot(Local0)) {
		ma10(0)
	}
}

/*
 * Non-serialized method to be executed by Slave thread
 *
 * non-serialized method is grabbed simultaneously by several threads
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(m8f9, 3)
{
	/*
	 * Index of one of two threads participating in test is 1
	 */
	if (LEqual(arg2, 1)) {
		if (FLG2) {
			se00(arg2, er12, , "Error er12")
		} else {
			Store(arg2, FLG2)
		}
	} else {
		if (FLG3) {
			se00(arg2, er12, , "Error er12")
		} else {
			Store(arg2, FLG3)
		}
	}


	m201(arg2, vb03, "Execution of non-serialized method started")
	m206(arg2, sl01) // Sleep

	/*
	 * NOTE: it is a recurcive second call to m101:
	 *
	 *       MAIN
	 *         mf00
	 *           mf16
	 *             m101
	 *               m8fc
	 *                 m101
	 *
	 * So, additional command c101 is needed for it to exit that second call to m101.
	 */
	m201(arg2, vb03, "Call recursively m101")
	m101(arg0, arg1, arg2, 1)

	m206(arg2, sl01) // Sleep

	m201(arg2, vb03, "Execution of non-serialized method completed")

	if (LNot(FLG2)) {
		se00(arg2, er12, , "Error er12")
	}
	if (LNot(FLG3)) {
		se00(arg2, er13, , "Error er13")
	}
}

/*
 * arg0 - number of threads (total)
 * arg1 - main command for slave thread
 */
Method(m8fb, 2, Serialized)
{
	Name(lpN0, 0) // level
	Name(lpC0, 0)
	Name(lpN1, 0) // index
	Name(lpC1, 0)
	Name(thr1, 0)
	Name(thr2, 0)


	Store(1, thr1)
	Store(m115(arg0), thr2) // thread with the greatest index

	if (LGreaterEqual(thr2, arg0)) {
		Store("No alive threads for Test!", Debug)
		Store("Test mf14 skipped!", Debug)
		SKIP()
		return
	}

	if (LLessEqual(thr2, thr1)) {
		Store("Insufficient number of threads for Test!", Debug)
		Store("Test mf15 skipped!", Debug)
		SKIP()
		return
	}


	/*
	 * 1. Thread thr-1 invokes method MXXX (by c109/c10a) which allows
	 *    exclusive access to the critical section.
	 *    Then it calls recursively m101 (infinite loop of slave threads)
	 *    so becomes identical to other threads for managing it.
	 */

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr1, arg1) // cmd: c109/c10a
	m20f(arg0, 0, 0)       // Init (Reset) the exceptional conditions flags (SUCCESS)
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)


	/*
	 * 2. Thread thr-2 invokes the same method MXXX (by c109/c10a) and hangs
	 *    because method MXXX provides exclusive access and is already grabbed by thr-1.
	 */

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr2, arg1) // cmd: c109/c10a
	m20f(arg0, 0, 0)       // Init (Reset) the exceptional conditions flags (SUCCESS)
	m114(arg0) // run

	/* Wait for all Slave threads */

	Name(cp00, Buffer(arg0) {})
	Name(hg00, Buffer(arg0) {})
	Name(id00, Buffer(arg0) {})

	CopyObject(bs00, cp00)
	Store(0, Index(cp00, thr2))
	Store(arg1, Index(hg00, thr2))
	m110(arg0, cp00, hg00, id00)


	/*
	 * 3. Sleep for all
	 */

	m200(bs00, arg0, c102) // cmd: Sleep
	m114(arg0) // run

	/* Wait for all Slave threads */

	Name(cp01, Buffer(arg0) {})
	Name(hg01, Buffer(arg0) {})
	Name(id01, Buffer(arg0) {})

	CopyObject(bs00, cp01)
	Store(0, Index(cp01, thr2))
	Store(arg1, Index(hg01, thr2))
	m110(arg0, cp01, hg01, id01)


	/*
	 * 4. Thread thr-1 is directed to exit recursive (second) call to m101
	 *    (infinite loop of slave threads).
	 */

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr1, c101) // cmd: Exit the infinite loop
	m114(arg0) // run

	/* Wait for all Slave threads */

	Name(cp02, Buffer(arg0) {})
	Name(hg02, Buffer(arg0) {})
	Name(id02, Buffer(arg0) {})

	CopyObject(bs00, cp02)
	Store(0, Index(cp02, thr2))
	Store(arg1, Index(hg02, thr2))
	m110(arg0, cp02, hg02, id02)


	/*
	 * 5. Thread thr-2 is directed to exit recursive (second) call to m101
	 *    (infinite loop of slave threads).
	 */

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr2, c101) // cmd: Exit the infinite loop
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)
}

/*
 * Use Serialized method for exclusive access to critical section
 *
 * arg0 - number of threads (total)
 */
Method(m816, 1)
{
	m8fb(arg0, c109)
}

/*
 * Use Mutex for exclusive access to critical section, invoke non-Serialized method
 *
 * arg0 - number of threads (total)
 */
Method(m817, 1)
{
	m8fb(arg0, c10a)
}

/*
 * Non-serialized method is grabbed simultaneously
 *
 * arg0 - number of threads (total)
 */
Method(m818, 1, Serialized)
{
	Name(lpN0, 0) // level
	Name(lpC0, 0)
	Name(lpN1, 0) // index
	Name(lpC1, 0)
	Name(thr1, 0)
	Name(thr2, 0)


	Store(0, FLG2)
	Store(0, FLG3)

	Store(1, thr1)
	Store(m115(arg0), thr2) // thread with the greatest index

	if (LGreaterEqual(thr2, arg0)) {
		Store("No alive threads for Test!", Debug)
		Store("Test mf14 skipped!", Debug)
		SKIP()
		return
	}

	if (LLessEqual(thr2, thr1)) {
		Store("Insufficient number of threads for Test!", Debug)
		Store("Test mf15 skipped!", Debug)
		SKIP()
		return
	}


	/*
	 * 1. Thread thr-1 invokes non-Serialized method MXXX.
	 *    Then it calls recursively m101 (infinite loop of slave threads)
	 *    so becomes identical to other threads for managing it.
	 */

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr1, c10b) // cmd: Invoke non-Serialized method
	m20f(arg0, 0, 0)       // Init (Reset) the exceptional conditions flags (SUCCESS)
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)


	/*
	 * 2. Sleep for all
	 */

	m200(bs00, arg0, c102) // cmd: Sleep
	m20f(arg0, 0, 0)       // Init (Reset) the exceptional conditions flags (SUCCESS)
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)


	/*
	 * 3. Thread thr-N invokes non-Serialized method MXXX.
	 *    Then it calls recursively m101 (infinite loop of slave threads)
	 *    so becomes identical to other threads for managing it.
	 */

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr2, c10b) // cmd: Invoke non-Serialized method
	m20f(arg0, 0, 0)       // Init (Reset) the exceptional conditions flags (SUCCESS)
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)


	/*
	 * 4. Sleep for all
	 */

	m200(bs00, arg0, c102) // cmd: Sleep
	m20f(arg0, 0, 0)       // Init (Reset) the exceptional conditions flags (SUCCESS)
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)


	/*
	 * 5. Both threads thr-1 and thr-N are directed to exit recursive (second) calls to m101
	 *    (infinite loops of slave threads).
	 */

	m200(bs00, arg0, c102) // cmd: Sleep
	m208(bs00, thr1, c101) // cmd: Exit the infinite loop
	m208(bs00, thr2, c101) // cmd: Exit the infinite loop
	m20f(arg0, 0, 0)       // Init (Reset) the exceptional conditions flags (SUCCESS)
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)

	if (LNotequal(FLG2, thr1)) {
		err(arg0, z152, 0x000, 0, 0, FLG2, thr1)
	}
	if (LNotequal(FLG3, thr2)) {
		err(arg0, z152, 0x001, 0, 0, FLG3, thr2)
	}
}

