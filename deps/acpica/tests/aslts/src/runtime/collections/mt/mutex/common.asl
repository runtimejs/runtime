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
 * SEE:
 * ??????????? Multi-threading common definitions
 * see: see structure and the name of this file also later !!!!!!!!!!!!!!
 * ??????????????????????????????????????????????????????????????????????
 *
 *
 * NOTIONS and NOTATIONS:
 *
 * ID and Index of thread:
 *
 *   each thread is identified by its ID (delivered from the underlying system)
 *   and its calculated unique index between all the threads participating in
 *   the test.
 *
 * Control Thread - the thread with index equal to 0
 * Slave Threads  - all other threads with the non-zero index
 *
 * Number of threads (total) -
 *    the value passed to AcpiExec Threads command
 *    as a number of threads parameter.
 *
 * Number of threads actually in work -
 *    number of threads actually participating the relevent test.
 *    Note: this value includes the Control Thread too.
 */

Name(z147, 147)

/*
 * Common data of threads
 *
 * Usage:
 *
 *   command line: Threads 6 1 MAIN
 *     6 - number of threads, it can be greater or less than 6
 *
 *   redm      - set it to zero to reduce the run time
 *   vb00-vb06 - use them to suppress the output
 *
 *   FLG1      - the _TCI-based Initialization of multithreading interconnection
 *               (run command TCI_CMD_GET_ID_OF_THREADS to determine indexes of threads)
 */


/*
 * Flags
 */
Name(ctl0, 0) // the Control thread is ready
Name(redm, 1) // run tests in reduced mode
Name(gldi, 0) // global data initialized

/*
 * Simple switch of the verbal mode
 *
 * 0 - silent
 * otherwise - allow
 *
 * s-flags (defaults are given in comment (0/1))
 */
Name(vb00, 0) // (0) common messages
Name(vb02, 1) // (1) trace Control thread
Name(vb03, 0) // (0) trace Slave threads
Name(vb04, 1) // (1) report statistics
Name(vb05, 0) // (0) report warnings by slave-threads
Name(vb06, 1) // (1) report errors by slave-threads

/*
 * Multi-conditional switches of the verbal mode
 *
 * 0 - silent
 * 1 - allow only for Control Thread to report
 * 2 - allow only for Slave Threads to report
 * 3 - allow for all threads to report
 *
 * mc-flags
 */
Name(vb01, 1) // header of test


/* Sleep mode */

Name(sl00, 50) // Default milliseconds to sleep for Control thread
Name(sl01, 50) // Default milliseconds to sleep for Slave threads

/*
 * Default milliseconds to sleep for Control thread
 * before to check hang status of slave threads on
 * operations.
 */
Name(sl02, 500)
/* How many times maximum to repeat sl02 sleeping */
Name(sl03, 1)

Name(slm0, 0)   // Sleeping mode for slave threads

/* Milliseconds to sleep for non-zero slm0 */
Name(i100, 50)
Name(i101, 100)
Name(i102, 200)
Name(i103, 400)
Name(i104, 500)
Name(i105, 75)
Name(i106, 150)
Name(i107, 250)
Name(i108, 300)


/* Commands for slaves */
Name(c100, 0xf0) // Idle thread
Name(c101, 0xf1) // Exit the infinite loop
Name(c102, 0xf2) // Sleep for the specified number of Milliseconds
Name(c103, 0xf3) // Acquire/Sleep/Release
Name(c104, 0xf4) // <Acquire/Sleep>(0-15 levels)/Release(15-0 levels)
Name(c105, 0xf5) // Example 0
Name(c106, 0xf6) // Acquire specified set of mutexes
Name(c107, 0xf7) // Release specified set of mutexes
Name(c108, 0xf8) // Terminate thread
Name(c109, 0xf9) // Invoke Serialized method
Name(c10a, 0xfa) // Invoke non-Serialized method, use Mutex for exclusive access to critical section
Name(c10b, 0xfb) // Non-serialized method is grabbed simultaneously


/* Responds of slave threads (not intersect with 'Commands for slaves') */
Name(rs00, 0x97) // "I see zero do00"


/* Common use strategies provided by the Control thread */
Name(CM01, 1) // all slaves to exit the infinite loop
Name(CM02, 2) // all slaves to sleep for the specified period


/*
 * This buffer is to be filled by the control thread.
 * It is filed with the commands to be fulfilled by the
 * slave threads.
 *
 * The thread of i-th index takes the command from the
 * i-th element of Buffer.
 *
 * It is read-only for slave threads.
 */
Name(bs00, Buffer(){0})

/*
 * This buffer is zeroed by the control thread and then to be
 * filled by the slave threads with the commands they have been
 * fulfilled.
 */
Name(bs01, Buffer(){0})

/*
 * This buffer is zeroed by the control thread and then to be
 * filled by the slave threads when they see that do00 is zero.
 *
 * The control thread uses it to check that all the slave threads
 * saw zero do00 (are idle) before to start the next command.
 */
Name(bs02, Buffer(){0})

/*
 * This buffer is zeroed by the control thread and then to
 * be filled by the idle slave threads.
 */
Name(bs03, Buffer(){0})

/*
 * This buffer is zeroed by the control thread and then to be
 * set up by the slave threads when they complete.
 */
Name(bs04, Buffer(){0})


/*
 * p10X - statistics
 */

/*
 * These package are zeroed by the control thread,
 * the slave threads accumulate there:
 * - errors
 * - number of errors
 * - warnings
 * - number of warnings
 */
Name(p100, Package(){0}) // scale of errors
Name(p101, Package(){0}) // number of errors
Name(p102, Package(){0}) // scale of warnings
Name(p103, Package(){0}) // number of warnings

/* Command statistics */
Name(p104, Package(){0}) // number of Sleep
Name(p105, Package(){0}) // number of Acquire
Name(p106, Package(){0}) // number of Release


/*
 * To be filled by the control thread,
 * non-zero enables to fulfill the commands specified by bs00.
 */
Name(do00, 0)

/* Opcodes of errors reported by slave threads */
Name(er00, 0x00000001) // Acquire failed
Name(er01, 0x00000002) // Flag of mutex is already non-zero (set up by some thread(s))
Name(er02, 0x00000004) // Invalid flag of mutex (changed by other thread while this one owned that mutex)
Name(er03, 0x00000008) // Unexpected exception
Name(er04, 0x00000010) // Improper exception (no exception, or unexpected opcode, or more than one exception)
Name(er05, 0x00000020) // Invalid command
Name(er06, 0x00000040) // Invalid Index of current thread
Name(er07, 0x00000080) // Too big Index of current thread
Name(er08, 0x00000100) // Invalid counter of mutex owning
Name(er09, 0x00000200) // Acquire returned zero but FAIL expected
Name(er10, 0x00000400) // Serialized method doesnt provide exclusive call
Name(er11, 0x00000800) // Serialized method doesnt provide exclusive call
Name(er12, 0x00001000) // Non-serialized method thr-1 didn't get into method
Name(er13, 0x00002000) // Non-serialized method thr-N didn't get into method


/* Opcodes of warnings reported by slave threads */
Name(wn00, 0x00000001) // Acquire repeatedly the same mutex by thread which already owns it

/*
 * These packages are to be filled by the control thread.
 * They are filed with the arguments of commands specified
 * for the slave threads.
 *
 * The thread of i-th index takes the arguments from the
 * i-th elements of Packages.
 *
 * These are read-only for slave threads.
 *
 * For Acquire/Release:
 *
 * p200 - starting level of mutex
 * p201 - number of Levels of mutexes
 * p202 - starting index of mutex (on the specified level)
 * p203 - number of mutexes of the same level
 * p204 - exceptional conditions
 * p205 - opcode of TimeOutValue (see comment to ma00)
 */
Name(p200, Package(){0})
Name(p201, Package(){0})
Name(p202, Package(){0})
Name(p203, Package(){0})
Name(p204, Package(){0})
Name(p205, Package(){0})

/* Exceptions total number */
Name(ex10, 0)


/*
 * p30X - Current state
 */
Name(p300, Package(){0}) // scale of errors
Name(p301, Package(){0}) // scale of warnings


/*
 * Non-zero means to check absence of exception
 * before and after each operation additionally
 * to the checking (if any) specified per-operation.
 */
Name(FLG0, 0)

/*
 * Handle exceptions
 *
 * Exceptional condition flag:
 *
 * EX0D      - FAIL expected
 * EX0E      - check for "no exception"
 * otherwise - opcode of exception expected
 */

/*
 * The _TCI-based Initialization of multithreading interconnection
 * (run command TCI_CMD_GET_ID_OF_THREADS to determine indexes of threads).
 *
 * Note: now when arguments (arg0, arg1, arg2) are determined
 *       by Threads command of AcpiExec and passed to test, it
 *       is unnecessary to do "The _TCI-based Initialization of
 *       multithreading interconnection" below. Used temporary.
 */
Name(FLG1, 0)

/*
 * Variables used by particular tests
 *
 * FLG2,
 * FLG3
 *   1) To show that Serialized method is grabbed exclusively
 *   2) To show that non-Serialized method is grabbed by two threads simultaneously
 */
Name(FLG2, 0)
Name(FLG3, 0)

/*
 * The Control Thread manages and controls the specified testing strategy
 * to be fulfilled by the Slave Threads.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread (0, can be used for control only)
 * arg2 - Index of current thread
 * arg3 - cammand - index of the test strategy to be
 *        managed and controled by the Control Thread
 *        and fulfilled by the Slave Threads (Slaves).
 *
 * Arguments of the command arg3:
 *
 * arg4
 * arg5
 * arg6
 */
Method(m100, 7)
{
	/* Prohibits activity of all the slave threads */

	Switch (arg3) {
		Case (1) {
			/* CM01: All slaves to exit the infinite loop */
			m10c(arg0)
		}
		Case (2) {
			/* CM02: All slaves to sleep for the specified period */
			m10d(arg0)
		}
	}
}

/*
 * Open testing - init interaction data
 *
 * arg0 - number of threads
 */
Method(m102, 1, Serialized)
{
	Name(b000, Buffer(arg0){})
	Name(p000, Package(arg0){})
	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(0, do00)
	CopyObject(b000, bs00)
	CopyObject(b000, bs01)
	CopyObject(b000, bs02)
	CopyObject(b000, bs03)

	CopyObject(p000, p200)
	CopyObject(p000, p201)
	CopyObject(p000, p202)
	CopyObject(p000, p203)
	CopyObject(p000, p204)
	CopyObject(p000, p205)

	CopyObject(p000, p300)
	CopyObject(p000, p301)

	Store(arg0, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		Store(0, Index(p300, lpC0))
		Store(0, Index(p301, lpC0))
		Decrement(lpN0)
		Increment(lpC0)
	}


	/*
	 * Initialization to be done once
	 */
	if (LNot(gldi)) {

		/* Statistics */

		CopyObject(p000, p100)
		CopyObject(p000, p101)
		CopyObject(p000, p102)
		CopyObject(p000, p103)
		CopyObject(p000, p104)
		CopyObject(p000, p105)
		CopyObject(p000, p106)

		CopyObject(b000, bs04)

		Store(arg0, lpN0)
		Store(0, lpC0)
		While (lpN0) {
			Store(0, Index(p100, lpC0))
			Store(0, Index(p101, lpC0))
			Store(0, Index(p102, lpC0))
			Store(0, Index(p103, lpC0))
			Store(0, Index(p104, lpC0))
			Store(0, Index(p105, lpC0))
			Store(0, Index(p106, lpC0))

			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	/* Init fl01 */
	m339()

	/*
	 * Reset all counters (cnt0) and flags (fl00)
	 * corresponding to all Mutexes.
	 */
	m330()

	/* Report that the Control thread is ready */
	Store(1, ctl0)

	Store(1, gldi)
}

/*
 * Control thread waits for all the slave threads to
 * fulfill the specified for them buffer of commands.
 *
 * arg0 - number of threads
 */
Method(m103, 1, Serialized)
{
	/* Wait for all Slave threads and check their statuses */

	Name(b000, Buffer(arg0){})
	Name(b001, Buffer(arg0){})
	Name(b002, Buffer(arg0){})

	CopyObject(bs00, b000)
	m110(arg0, b000, b001, b002)
}

/*
 * The _TCI-based initialization of multithreading interconnection
 *
 * In result each thread knows its ID and calculated its index
 * between all threads participating in the test.
 *
 * arg0 - number of threads
 *
 * Return:
 *   success   - II-Package
 *   otherwise - 0
 */
Method(m104, 1)
{
	/*
	 * Local0 - array of thread IDs
	 * Local1 - auxiliary
	 * Local2 - auxiliary
	 * Local7 - II-Package
	 */

	if (vb00) {
		Store("Checking for the Test Command Interface with the ACPICA (_TCI) support", Debug)
	}

	if (LNot(m3a5())) {
		Store("The Test Command Interface with the ACPICA (_TCI) is not supported", Debug)
		return (0)
	}

	if (vb00) {
		Store("Getting array of thread IDs", Debug)
	}

	Store(m163(arg0), Local0)
	Store(ObjectType(Local0), Local1)
	if (LNotEqual(Local1, c00c)) {
		Store("Failed to get array of thread indexes", Debug)
		return (0)
	}

	if (vb00) {
		Store("Calculating index of thread", Debug)
	}

	Store(m105(Local0, arg0), Local7)
	Store(ObjectType(Local7), Local2)
	if (LNotEqual(Local2, c00c)) {
		Store("Invalid contents of Package of threads", Debug)
		return (0)
	}

	return (Local7)
}

/*
 * Calculate and return II-Package with Index of current thread between
 * all threads participating in the test and ID of that thread.
 *
 * arg0 - the Package of thread IDs returned by m163 which
 *        executes the command TCI_CMD_GET_ID_OF_THREADS.
 * arg1 - number of threads
 *
 * Return:
 * II-Package in success:
 *	0-th element - ID of that current thread
 *	1-th element - Index of current thread between all threads participating in test
 * Integer otherwise:
 *    0
 */
Method(m105, 2)
{
	/*
	 * Local0 - auxiliary
	 * Local1 - auxiliary
	 * Local2 - lpN0
	 * Local3 - lpC0
	 * Local4 - TCI_PACKAGE_THR_NUM
	 * Local5 - TCI_PACKAGE_THR_NUM_REAL
	 * Local6 - TCI_PACKAGE_THR_ID (ID of thread)
	 * Local7 - Index of thread
	 */

	Store(ff32, Local7)

	// Store(arg0, Debug)

	Store(DerefOf(Index(arg0, c22c)), Local4) // TCI_PACKAGE_THR_NUM
	if (LNot(Local4)) {
		Store("TCI_PACKAGE_THR_NUM is zero", Debug)
		return (0)
	}

	Store(DerefOf(Index(arg0, c22d)), Local5) // TCI_PACKAGE_THR_NUM_REAL
	if (LNot(Local5)) {
		Store("TCI_PACKAGE_THR_NUM_REAL is zero", Debug)
		return (0)
	}

	Store(DerefOf(Index(arg0, c22e)), Local6) // TCI_PACKAGE_THR_ID
	if (LNot(Local6)) {
		Store("TCI_PACKAGE_THR_ID is zero", Debug)
		return (0)
	}

	if (LNotEqual(Local4, Local5)) {
		Store("TCI_PACKAGE_THR_NUM != TCI_PACKAGE_THR_NUM_REAL", Debug)
		Store(Local4, Debug)
		Store(Local5, Debug)
		return (0)
	}

	if (LNotEqual(Local4, arg1)) {
		Store("TCI_PACKAGE_THR_NUM != Number of threads", Debug)
		Store(Local4, Debug)
		Store(arg1, Debug)
		return (0)
	}

	// Calculate index of thread

	Store(arg1, Local2)
	Store(0, Local3)
	Store(c22f, Local0)

	While (Local2) {
		Store(DeRefOf(Index(arg0, Local0)), Local1)

		if (LNot(Local1)) {
			Store("thread ID is zero", Debug)
			return (0)
		} elseif (LEqual(Local1, Local6)) {
			if (LNotEqual(Local7, ff32)) {
				Store("thread ID encountered twice", Debug)
				return (0)
			}
			Store(Local3, Local7)
		}

		Increment(Local0)
		Decrement(Local2)
		Increment(Local3)
	}

	/* Return Package: Index of current thread, ID of current thread */

	Store(Package(2) {}, Local0)
	Store(Local6, Index(Local0, 0))
	Store(Local7, Index(Local0, 1))

	return (Local0)
}

/*
 * Report errors detected by the slave threads
 *
 * arg0 - name of test
 * arg1 - number of threads
 */
Method(m106, 2, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(arg1, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		Store(DerefOf(Index(p300, lpC0)), Local0)
		if (Local0) {
			/*
			 * Reports:
			 * lpC0   - Index of thread
			 * Local0 - the scale of its errors
			 */
			err(arg0, z147, 0x000, 0, 0, lpC0, Local0)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Initialization of multithreading interconnection
 *
 * Note: now when arguments (arg0, arg1, arg2) are determined
 *       by Threads command of AcpiExec and passed to test, it
 *       is unnecessary to do "The _TCI-based Initialization of
 *       multithreading interconnection" below. Used temporary.
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 * arg3 - minimal number of threads needed for test
 */
Method(m107, 4)
{
	/* Set the multi-threading mode flag */
	SET3(1)

	/*
	 * Local0 - auxiliary
	 * Local1 - auxiliary
	 * Local6 - ID of thread
	 * Local7 - Index of thread
	 */

	/* The _TCI-based Initialization of multithreading interconnection */

	if (FLG1) {
		Store(m104(arg0), Local0)
		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c00c)) {
			err("m107", z147, 0x001, 0, 0, Local1, c00c)
			return (0)
		}

		/* Get ID and Index of current thread */
		Store(DeRefOf(Index(Local0, 0)), Local6)
		Store(DeRefOf(Index(Local0, 1)), Local7)

		if (LNotEqual(Local6, arg1)) {
			err("m107", z147, 0x002, 0, 0, Local6, arg1)
			return (0)
		}

		if (LNotEqual(Local7, arg2)) {
			err("m107", z147, 0x003, 0, 0, Local7, arg2)
			return (0)
		}
	}

	if (LOr(LLess(arg0, 2), LLess(arg0, arg3))) {
		Store("Insufficient number of threads for Test!", Debug)
		return (0)
	}

	return (1)
}

/*
 * Close testing
 *
 * arg0 - name of test
 * arg1 - number of threads
 * arg2 - ID of current thread
 * arg3 - Index of current thread
 */
Method(m108, 4)
{
	/* all slaves to exit the infinite loop */

	m100(arg1, arg2, arg3, CM01, 0, 0, 0)

	/* Report errors detected by the slave threads */

	m106(arg0, arg1)
}

/*
 * CM01: all slaves to exit the infinite loop
 *
 * arg0 - number of threads
 */
Method(m10c, 1, Serialized)
{
	/* All slaves to exit the infinite loop */

	m200(bs00, arg0, c101) // cmd: Exit the infinite loop
	m114(arg0)

	/* Wait for all Slave threads */

	Name(b000, Buffer(arg0){})
	Name(b001, Buffer(arg0){})
	Name(b002, Buffer(arg0){})

	CopyObject(bs00, b000)
	m110(arg0, b000, b001, b002)
}

/*
 * CM02: all slaves to sleep for the specified period
 *
 * arg0 - number of threads
 */
Method(m10d, 1)
{
	/* All slaves to sleep for the specified period */

	m200(bs00, arg0, c102) // cmd: Sleep for the specified number of Milliseconds
	m114(arg0)

	/* Wait for all Slave threads */
	m103(arg0)
}

/*
 * Control thread checks that the specified set of slave threads
 * hang on the specified operations or completed the operations.
 *
 * arg0 - number of threads
 * arg1 - buffer of arg0 length
 *        1 - check completion of operation
 *        2 - check hang
 *
 * Return:
 *   These mean unexpected behaviour:
 *     0x01 - some threads has not completed operation
 *     0x02 - some threads are not hang on operation
 *   These report the contents of buffer:
 *     0x10 - has checkings of completed operation
 *     0x20 - has checkings of hang on operation
 */
Method(m10e, 2, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(rval, 0)

	Store(arg0, lpN0)
	Store(0, lpC0)
	While (lpN0) {

		/* For not a Control thread only */
		if (LNotEqual(lpC0, 0)) {
			Store(DerefOf(Index(arg1, lpC0)), Local0)
			Store(DerefOf(Index(bs01, lpC0)), Local1)

			if (LEqual(Local0, 1)) {
				/* check completion of operation */
				Or(rval, 0x10, rval)
				if (LNot(Local1)) {
					Or(rval, 0x01, rval)
				}
			} elseif (LEqual(Local0, 2)) {
				/* check hang */
				Or(rval, 0x20, rval)
				if (Local1) {
					Or(rval, 0x02, rval)
				}
			}
		}

		Decrement(lpN0)
		Increment(lpC0)
	}

	return (rval)
}

/*
 * Run and analize result of m10e()
 *
 * arg0,
 * arg1 - see m10e
 */
Method(m10f, 2, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(rval, 0)

	Store(sl03, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		Sleep(sl02)
		Store(m10e(arg0, arg1), rval)

		if (LNot(And(rval, 0x20))) {
			/* doesn't have checkings of hang */
			if (LNot(And(rval, 0x01))) {
				/* all examined have completed */
				break
			}
		}
		Decrement(lpN0)
		Increment(lpC0)
	}

	return (rval)
}

/*
 * Control thread waits for all the slave threads to
 * fulfill the specified for them buffer of commands.
 *
 * arg0 - number of threads (total)
 * arg1 - the per-thread expectations of completion status mapping buffer
 * arg2 - the per-thread expectations of hang       status mapping buffer
 * arg3 - the per-thread expectations of idle       status mapping buffer
 */
Method(m110, 4, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(find, 0)
	Name(sl80, 0)
	Name(sl81, 0)
	Name(cmd0, 0)
	Name(hng0, 0)
	Name(idl0, 0)
	Name(quit, 0)

	/*
	 * Check that all the slave threads saw my
	 * non-zero do00 and fulfilled the proper command.
	 */
	While (1) {
		Store(0, find)
		Store(arg0, lpN0)
		Store(0, lpC0)
		While (lpN0) {

			/* For not a Control thread only */
			if (LNotEqual(lpC0, 0)) {

				Store(DerefOf(Index(arg1, lpC0)), cmd0)
				Store(DerefOf(Index(arg2, lpC0)), hng0)
				Store(DerefOf(Index(arg3, lpC0)), idl0)

				Store(DerefOf(Index(bs00, lpC0)), Local0)
				Store(DerefOf(Index(bs01, lpC0)), Local1)
				Store(DerefOf(Index(bs03, lpC0)), Local2)
				Store(DerefOf(Index(bs04, lpC0)), Local3) // terminated threads

				if (Local3) {

					/* Thread already completed by c108 */

				} elseif (cmd0) {

					if (LNotEqual(Local0, cmd0)) {
						err("m110", z147, 0x004, 0, 0, Local0, cmd0)
						Store(lpC0, Debug)
					}
					if (LNot(Local1)) {
						/* Not completed yet */
						Store(1, find)
						break
					} elseif (LNotEqual(Local1, Local0)) {
						/* Has executed unexpected command */
						err("m110", z147, 0x005, 0, 0, Local1, Local0)
						Store(lpC0, Debug)
					}
				} elseif (hng0) {
					Store(1, sl81)
					if (LLess(sl80, sl03)) {
						/*
						 * Delay here is some pure attempt to be objective -
						 * it can look like hang now but go just after this
						 * checking.
						 */
						Increment(sl80)
						Sleep(sl02)
					}
					Store(DerefOf(Index(bs01, lpC0)), Local4)
					if (Local4) {
						/* Doesn't hang */
						if (LNotEqual(Local4, Local0)) {
							/* Has executed unexpected command */
							err("m110", z147, 0x006, 0, 0, Local1, Local0)
							Store(lpC0, Debug)
						}
						err("m110", z147, 0x007, 0, 0, Local0, Local4)
						Store(lpC0, Debug)
					}
				} elseif (idl0) {
					if (LNotEqual(Local0, c100)) {
						err("m110", z147, 0x008, 0, 0, Local0, cmd0)
						Store(lpC0, Debug)
					}
					if (LNot(Local2)) {
						/* Not completed yet */
						Store(1, find)
						break
					} elseif (LNotEqual(Local2, c100)) {
						/* Has executed unexpected command */
						err("m110", z147, 0x009, 0, 0, Local0, cmd0)
						Store(lpC0, Debug)
					}
				} else {
					err("m110", z147, 0x00a, 0, 0, lpC0, Local0)
					Store(lpC0, Debug)
				}
			}

			Decrement(lpN0)
			Increment(lpC0)
		}

		Store(0, quit)

		if (LNot(find)) {

			Store(1, quit)

			/*
			 * All threads except those being checked for hang status
			 * have completed their commands.
			 */
			if (sl81) {
				/* Has threads to check hang status */
				if (LLess(sl80, sl03)) {
					/* Not completed yet the specified delay */
					Store(0, quit)
				}
			}
		}

		if (quit) {
			break
		}

		/*
		 * Don't report about Control thread sleeping -
		 * don't use m206(0, sl00).
		 */
		Sleep(sl00)
	}

	/*
	 * Set do00 to zero and check that all the slave threads
	 * saw my zero do00 (if only it is not the EXIT command).
	 */

	m200(bs02, arg0, 0)
	Store(0, do00)
	While (1) {
		Store(0, find)
		Store(arg0, lpN0)
		Store(0, lpC0)
		While (lpN0) {

			/* For not a Control thread only */
			if (LNotEqual(lpC0, 0)) {

				/*
				 * Reset the specified command for each thread
				 * which in fact doesn't hang.
				 */
				Store(DerefOf(Index(bs02, lpC0)), Local0)
				if (Local0) {
					/* Alive, doesn't hang, so reset its command */
					Store(c100, Index(bs00, lpC0))
					Store(0, Index(bs01, lpC0))
				}

				/*
				 * For all threads except those being checked for
				 * hang status and completed already.
				 */
				Store(DerefOf(Index(arg2, lpC0)), hng0)
				Store(DerefOf(Index(bs04, lpC0)), Local0)

				if (LAnd(LNot(hng0), LNot(Local0))) {
					Store(DerefOf(Index(bs02, lpC0)), Local0)
					if (LNot(Local0)) {
						Store(1, find)
						break
					}
				}
			}

			Decrement(lpN0)
			Increment(lpC0)
		}

		/*
		 * All threads except those being checked for hang status
		 * have zeroed do00.
		 */
		if (LNot(find)) {
			break
		}

		/*
		 * Don't report about Control thread sleeping -
		 * don't use m206(0, sl00).
		 */
		Sleep(sl00)
	}

	/* All the slave threads are ready for any next command */
}

/*
 * Check absence of exception
 *
 * arg0 - ID of current thread
 * arg1 - Index of current thread
 * arg2 - exceptional condition flag
 * arg3 - the name of operation
 *
 * Return opcode of exception to be generated or zero
 */
Method(m111, 4)
{
	if (LOr(FLG0, arg2)) {
		Store(CH08("m111", arg0, z147, 0x00c, 0, 0), Local0)
		if (Local0) {
			se00(arg1, er03, "Error er03")
		}
	}

	/* Analize opcode of exception to be generated */

	Switch (arg2) {
		Case (0) {
			Store(0, Local0)
		}
		Case (0xfe) { // EX0E - check "no exception"
			Store(0, Local0)
		}
		Case (0xfd) { // EX0D - FAIL expected
			Store(arg2, Local0)
			Concatenate(arg3, ", generating FAIL condition ", Local1)
			m201(arg1, vb03, Local1)
		}
		Default {
			Store(arg2, Local0)
			Concatenate(arg3, ", generating exceptional condition ", Local1)
			Concatenate(Local1, Local0, Local1)
			m201(arg1, vb03, Local1)
		}
	}

	return (Local0)
}

/*
 * Check exception
 *
 * arg0 - ID of current thread
 * arg1 - Index of current thread
 * arg2 - exceptional condition flag
 * arg3 - return code of operation
 */
Method(m112, 4)
{
	Store(0, Local2)

	if (LEqual(arg2, EX0E)) {

		/* check "no exception" */

		Store(CH08("m112", arg0, z147, 0x00d, 0, 0), Local0)
		if (Local0) {
			se00(arg1, er03, "Error er03")
		}

	} elseif (LEqual(arg2, EX0D)) {

		/* FAIL of operation expected */

		if (LNot(arg3)) {
			err("m112", z147, 0x00e, 0, 0, arg3, 1)
		}

	} elseif (arg2) {

		/* check presence of particular exception */

		Store(CH09(0, arg0, arg2, z147, 0x00f, RefOf(Local2)), Local0)
		if (Local0) {
			se00(arg1, er04, "Error er04")
		}
	}

	if (FLG0) {
		Store(CH08("m112", arg0, z147, 0x010, 0, 0), Local0)
		if (Local0) {
			se00(arg1, er03, "Error er03")
		}
	}
}

/*
 * Control thread initiates execution of commands by the slave threads
 *
 * arg0 - number of threads (total)
 */
Method(m114, 1)
{
	m200(bs01, arg0, 0)
	m200(bs03, arg0, 0)
	Store(1, do00)
}

/*
 * Return index of the greatest alive non-terminated yet thread
 *
 * arg0 - number of threads
 */
Method(m115, 1, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	/* Means 'not found' */
	Store(arg0, Local7)

	/* Inverse order, excluding a Control thread */
	Subtract(arg0, 1, lpN0)
	Subtract(arg0, 1, lpC0)

	While (lpN0) {

		Store(DerefOf(Index(bs04, lpC0)), Local0)
		if (LNot(Local0)) {
			Store(lpC0, Local7)
			break
		}

		Decrement(lpN0)
		Decrement(lpC0)
	}

	return (Local7)
}

/*
 * Add error-bit relative to arg0-th thread
 *
 * arg0 - Index of thread
 * arg1 - error-bit
 * arg2 - message
 */
Method(se00, 3)
{
	Store(DerefOf(Index(p300, arg0)), Local0)
	Or(arg1, Local0, Local1)
	Store(Local1, Index(p300, arg0))

	if (vb04) {

		/* Add scale of Errors */

		Store(DerefOf(Index(p100, arg0)), Local0)
		Or(arg1, Local0, Local1)
		Store(Local1, Index(p100, arg0))

		/* Increment statistics of Errors (number) */
		m212(RefOf(p101), arg0)
	}

	if (vb06) {
		Concatenate("ERROR: ", arg2, Local0)
		m201(arg0, 1, Local0)
	}
}

/*
 * Add warning-bit relative to arg0-th thread
 *
 * arg0 - Index of thread
 * arg1 - warning-bit
 * arg2 - message
 */
Method(wrn0, 3)
{
	Store(DerefOf(Index(p301, arg0)), Local0)
	Or(arg1, Local0, Local1)
	Store(Local1, Index(p301, arg0))

	if (vb04) {

		/* Add scale of Warnings */

		Store(DerefOf(Index(p102, arg0)), Local0)
		Or(arg1, Local0, Local1)
		Store(Local1, Index(p102, arg0))

		/* Increment statistics of Warnings (number) */
		m212(RefOf(p103), arg0)
	}

	if (vb05) {
		Concatenate("WARNING: ", arg2, Local0)
		m201(arg0, 1, Local0)
	}
}


