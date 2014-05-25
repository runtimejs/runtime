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
 * Check mutex related interfaces in a real multi-threading mode
 */

Name(z148, 148)


/*
in progress
SEE:
??????????????????????????????????????????
1) See sleeping mode ... and m209

3) remove all mf0X - slaves only once go into
	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
and Ctl Thread do mf00()

4) do the same number of mutexes (indexes) for all mutex levels
   then uni0 will work in cm06/cm07... properly
5) actually properly split methods among files and files among directories
6) groups of methods - m340-m344 and m20d-m20e in the same group and name
6) some methods are not used?
7) m33f - does it have "Check up the values of counters of all Mutexes"?
8) allow tests to run for 3 and 2 threads (excluding some) without SKIPPED
*/


/*
 * Test mf01.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf01, 3, Serialized)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 0))) {
		if (LNot(arg2)) {
			Store("Test mf01 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf01", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/*
		 * These variables are to be actually used
		 * by the Control Thread only
		 */
		Name(lpN0, 0)
		Name(lpC0, 0)

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		/* Acquire/Sleep/Release for all 0-15 levels and GL */

		Store(max0, lpN0)
		Store(0, lpC0)
		While (lpN0) {

			/*
			 * Reset all counters (cnt0) and flags (fl00)
			 * corresponding to all Mutexes.
			 */
			m330()

			/*
			 * Acquire/Sleep/Release
			 *
			 * - Number of threads
			 * - Level of mutex
			 * - Index of mutex
			 * - Number of mutexes of the same level
			 */
			m801(arg0, lpC0, 0, min0)

			Decrement(lpN0)
			Increment(lpC0)
		}

		/* Close testing */
		m108("mf01", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf02.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf02, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 0))) {
		if (LNot(arg2)) {
			Store("Test mf02 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf02", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		/*
		 * <Acquire/Sleep>(0-15 levels) and GL/Release(15-0 levels) and GL
		 * - Number of threads
		 * - Index of mutex
		 * - Number of mutexes of the same level
		 */
		m802(arg0, 0, 2)

		/* Close testing */
		m108("mf02", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf03.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf03, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 0))) {
		if (LNot(arg2)) {
			Store("Test mf03 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf03", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		/*
		 * Example 0
		 * - Number of threads
		 */
		m803(arg0)

		/* Close testing */
		m108("mf03", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf04.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf04, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 3))) {
		if (LNot(arg2)) {
			Store("Test mf04 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf04", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf04)
		m804(arg0)

		/* Close testing */
		m108("mf04", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf05.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf05, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 3))) {
		if (LNot(arg2)) {
			Store("Test mf05 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf05", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf05)
		m805(arg0)

		/* Close testing */
		m108("mf05", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf06.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf06, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 3))) {
		if (LNot(arg2)) {
			Store("Test mf06 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf06", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf06)
		m806(arg0)

		/* Close testing */
		m108("mf06", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf07.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf07, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 0))) {
		if (LNot(arg2)) {
			Store("Test mf07 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf07", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf07)
		m807(arg0)

		/* Close testing */
		m108("mf07", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf08.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf08, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, min1))) {
		if (LNot(arg2)) {
			Store("Test mf08 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf08", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf08)
		m808(arg0)

		/* Close testing */
		m108("mf08", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf09.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf09, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, min1))) {
		if (LNot(arg2)) {
			Store("Test mf09 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf09", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf09)
		m809(arg0)

		/* Close testing */
		m108("mf09", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf10.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf10, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, min1))) {
		if (LNot(arg2)) {
			Store("Test mf10 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf10", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf10)
		m810(arg0)

		/* Close testing */
		m108("mf10", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf11.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf11, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 0))) {
		if (LNot(arg2)) {
			Store("Test mf11 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf11", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf11)
		m811(arg0)

		/* Close testing */
		m108("mf11", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf12.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf12, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 3))) {
		if (LNot(arg2)) {
			Store("Test mf12 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf12", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf12)
		m812(arg0)

		/* Close testing */
		m108("mf12", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf13.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf13, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 0))) {
		if (LNot(arg2)) {
			Store("Test mf13 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf13", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf13)
		m813(arg0)

		/* Close testing */
		m108("mf13", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf14.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf14, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 0))) {
		if (LNot(arg2)) {
			Store("Test mf14 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf14", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf14)
		m814(arg0)

		/* Close testing */
		m108("mf14", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}


/*
 * Test mf15.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf15, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 0))) {
		if (LNot(arg2)) {
			Store("Test mf15 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf15", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf15)
		m815(arg0)

		/* Close testing */
		m108("mf15", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf16.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf16, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 0))) {
		if (LNot(arg2)) {
			Store("Test mf16 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf16", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf16)
		m816(arg0)

		/* Close testing */
		m108("mf16", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf17.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf17, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 0))) {
		if (LNot(arg2)) {
			Store("Test mf17 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf17", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf17)
		m817(arg0)

		/* Close testing */
		m108("mf17", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}

/*
 * Test mf18.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf18, 3)
{
	/* Initialization of multithreading interconnection */

	if (LNot(m107(arg0, arg1, arg2, 0))) {
		if (LNot(arg2)) {
			Store("Test mf18 skipped!", Debug)
			SKIP()
		}
		return
	}

	/* Report start of test: depending on vb01 can be reported by each thread */
	m204("mf18", arg0, arg1, arg2)

	/*
	 * The Slave Threads loop forever executing strategies
	 * specified and controlled by the Control Thread.
	 */
	if (LEqual(arg2, 0)) { // Control Thread

		/* Open testing */
		m102(arg0)

		/* All slaves to sleep */
		m100(arg0, arg1, arg2, CM02, 0, 0, 0)

		// Test (see SPEC for mf18)
		m818(arg0)

		/* Close testing */
		m108("mf18", arg0, arg1, arg2)

	} else { // Slave Threads
		m101(arg0, arg1, arg2, 0)
	}
}


/*
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 */
Method(mf00, 3)
{
	if (LNot(arg2)) {

		/* Sleeping mode */

		Store(10, sl00) // default milliseconds to sleep for Control thread
		Store(10, sl01) // default milliseconds to sleep for Slave threads
		Store(0, slm0)  // sleeping mode for slave threads
	}

	if (LNot(y251)) {
		if (LNot(arg2)) {
			/*
			 * Initialization of multithreading interconnection:
			 * only to check that mt-technique itself works.
			 */
			if (LNot(m107(arg0, arg1, arg2, 0))) {
				Store("Mt-technique doesn't work!", Debug)
			} else {
				Store("Mt-technique works", Debug)
			}

			Store(0, vb04) // don't print statistics
			Store(1, ctl0) // Slave threads - go!

			SRMT("mt_mutex_tests")
		}
		return
	}


if (1) {

	/* Tests */

	if (LNot(arg2)) {
		SRMT("mf01")
	}
	mf01(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf02")
	}
	mf02(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf03")
	}
	mf03(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf04")
	}
	mf04(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf05")
	}
	mf05(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf06")
	}
	mf06(arg0, arg1, arg2)

if (1) {
	if (LNot(arg2)) {
		SRMT("mf07")
	}
	mf07(arg0, arg1, arg2)
} else {
	if (LNot(arg2)) {
		SRMT("mf07")
		BLCK()
	}
}

	if (LNot(arg2)) {
		SRMT("mf08")
	}
	mf08(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf09")
	}
	mf09(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf10")
	}
	mf10(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf11")
	}
	mf11(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf12")
	}
	mf12(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf13")
	}
	mf13(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf14")
	}
	mf14(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf15")
	}
	mf15(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf16")
	}
	mf16(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf17")
	}
	mf17(arg0, arg1, arg2)

	if (LNot(arg2)) {
		SRMT("mf18")
	}
	mf18(arg0, arg1, arg2)

} else {

	if (LNot(arg2)) {
		SRMT("mf01")
	}
	mf01(arg0, arg1, arg2)

}


	/* Report statistics */
	if (LEqual(arg2, 0)) { // Control Thread
		if (vb04) {
			m211(arg0)
		}
	}
}


