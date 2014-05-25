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
 * Access to mutexes routines
 */

Name(z149, 149)

/*
 * Opcodes of initialization of set of mutexes
 *
 * c300 - usual
 * c301 - one mutex of Index equal to ((Index of current thread) - 1)
 */
Name(c300, 0)
Name(c301, 1)

/*
 * Flags corresponding to Mutexes
 */
Name(fl00, Package(max0) {
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	})

/*
 * Counters (current) corresponding to Mutexes
 * (how many times the relevant mutex has been
 * successfully Acquired (may be repeatedly)
 * (by the same thread))
 *
 * - incremented on Acquire
 * - decremented on Release
 */
Name(fl01, Package(max0) {
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	})

/*
 * Counters corresponding to Mutexes
 *
 * how many times the mutex has successfully Acquired
 * by different threads.
 *
 * - incremented on Acquire
 * - reset to zero by the Control thread
 */
Name(cnt0, Package(max0) {
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	Package(max1) {},
	})

/*
 * Acquire mutex
 *
 * arg0 - ID of current thread
 * arg1 - Index of thread
 * arg2 - Level of mutex
 * arg3 - Index of mutex
 * arg4 - opcode of exception to be generated or zero
 * arg5 - opcode of TimeOutValue (see comment to ma00)
 * arg6 - if fall into sleep
 */
Method(m310, 7)
{
	Store(m21e("Acquire mutex, ", arg2, arg3), Local0)
	m201(arg1, vb03, Local0)

	/* Increment statistics of Acquire */
	if (vb04) {
		m212(RefOf(p105), arg1)
	}

	if (LEqual(arg4, EX0D)) { // FAIL expected
		Store(0, Local6)
	} else {
		Store(arg4, Local6)
	}

	Store(1, Local7) // Init with FAIL

	Switch (arg2) {
		Case (0) {
			Store(ma00(arg3, Local6, arg5), Local7)
		}
		Case (1) {
			Store(ma01(arg3, Local6, arg5), Local7)
		}
		Case (2) {
			Store(ma02(arg3, Local6, arg5), Local7)
		}
		Case (3) {
			Store(ma03(arg3, Local6, arg5), Local7)
		}
		Case (4) {
			Store(ma04(arg3, Local6, arg5), Local7)
		}
		Case (5) {
			Store(ma05(arg3, Local6, arg5), Local7)
		}
		Case (6) {
			Store(ma06(arg3, Local6, arg5), Local7)
		}
		Case (7) {
			Store(ma07(arg3, Local6, arg5), Local7)
		}
		Case (8) {
			Store(ma08(arg3, Local6, arg5), Local7)
		}
		Case (9) {
			Store(ma09(arg3, Local6, arg5), Local7)
		}
		Case (10) {
			Store(ma0a(arg3, Local6, arg5), Local7)
		}
		Case (11) {
			Store(ma0b(arg3, Local6, arg5), Local7)
		}
		Case (12) {
			Store(ma0c(arg3, Local6, arg5), Local7)
		}
		Case (13) {
			Store(ma0d(arg3, Local6, arg5), Local7)
		}
		Case (14) {
			Store(ma0e(arg3, Local6, arg5), Local7)
		}
		Case (15) {
			Store(ma0f(arg3, Local6, arg5), Local7)
		}
	}

	if (LEqual(arg4, EX0D)) {

		/* FAIL expected */

		if (Local7) {
			m201(arg1, vb03, "Acquire returned non-zero, it was expected")
		} else {
			m201(arg1, vb03, "Error 9: Acquire returned zero but FAIL expected!")
			se00(arg1, er09, "Error er09")
		}

		return (Local7)
	} elseif (arg4) {
		return (1)
	} elseif (Local7) {
		m201(arg1, vb03, "Error 0: Acquire returned non-zero!")
		se00(arg1, er00, "Error er00")
		return (1)
	} else {
		/*
		 * Increment counter (cnt0) and set up flag (fl00)
		 * corresponding to mutex. Report error in case the
		 * flag is non-zero.
		 */

		Store(m21e("Incrementing count of mutex, ", arg2, arg3), Local7)
		Concatenate(Local7, " and set up its flag", Local1)
		m201(arg1, vb03, Local1)
		m331(arg1, arg2, arg3)

		if (arg6) {
			m201(arg1, vb03, "Fall into sleep")
			if (slm0) {
				Divide(arg1, 5, Local1)
				Store(100, Local2)
				Switch (Local1) {
					Case (0) {
						Store(i100, Local2)
					}
					Case (1) {
						Store(i101, Local2)
					}
					Case (2) {
						Store(i102, Local2)
					}
					Case (3) {
						Store(i103, Local2)
					}
					Case (4) {
						Store(i104, Local2)
					}
					Case (5) {
						Store(i105, Local2)
					}
					Case (6) {
						Store(i106, Local2)
					}
					Case (7) {
						Store(i107, Local2)
					}
					Case (8) {
						Store(i108, Local2)
					}
				}
				m206(arg1, Local2)
			} else {
				m206(arg1, sl01)
			}
		}
	}

	return (0)
}

/*
 * Release mutex
 *
 * arg0 - ID of current thread
 * arg1 - Index of thread
 * arg2 - Level of mutex
 * arg3 - Index of mutex
 * arg4 - opcode of exception to be generated or zero
 * arg5 - if fall into sleep
 */
Method(m311, 6)
{
	Store(m21e("Release mutex, ", arg2, arg3), Local0)
	m201(arg1, vb03, Local0)

	/* Increment statistics of Release */
	if (vb04) {
		m212(RefOf(p106), arg1)
	}

	/*
	 * Check up and reset flag (fl00) corresponding to this Mutex
	 * (check that it was not changed by other threads while this
	 * one was sleeping).
	 */
	if (LNot(arg4)) {
		m332(arg1, arg2, arg3)
	}

	Switch (arg2) {
		Case (0) {
			ma10(arg3)
		}
		Case (1) {
			ma11(arg3)
		}
		Case (2) {
			ma12(arg3)
		}
		Case (3) {
			ma13(arg3)
		}
		Case (4) {
			ma14(arg3)
		}
		Case (5) {
			ma15(arg3)
		}
		Case (6) {
			ma16(arg3)
		}
		Case (7) {
			ma17(arg3)
		}
		Case (8) {
			ma18(arg3)
		}
		Case (9) {
			ma19(arg3)
		}
		Case (10) {
			ma1a(arg3)
		}
		Case (11) {
			ma1b(arg3)
		}
		Case (12) {
			ma1c(arg3)
		}
		Case (13) {
			ma1d(arg3)
		}
		Case (14) {
			ma1e(arg3)
		}
		Case (15) {
			ma1f(arg3)
		}
	}

	if (arg5) {
		m206(arg1, sl01)
	}
}

/*
 * Reset all counters (cnt0) and flags (fl00)
 * corresponding to all Mutexes.
 */
Method(m330,, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(lpN1, 0)
	Name(lpC1, 0)

	Store(max0, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		Store(max1, lpN1)
		Store(0, lpC1)
		While (lpN1) {
			Store(0, Index(DerefOf(Index(cnt0, lpC0)), lpC1))
			Store(0, Index(DerefOf(Index(fl00, lpC0)), lpC1))
			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * For Acquire
 *
 * Increment counter (cnt0) and set up flag (fl00)
 * corresponding to the mutex of arg1-Level and
 * arg2-Index. Report error in case the flag is non-zero.
 *
 * arg0 - Index of thread
 * arg1 - Level of mutex
 * arg2 - Index of mutex
 */
Method(m331, 3)
{
	/* Local1 - the value of flag (index of thread owning the mutex) */

	Store(DerefOf(Index(fl00, arg1)), Local0)
	Store(DerefOf(Index(Local0, arg2)), Local1)

	if (Local1) {
		if (LEqual(Local1, arg0)) {
			Store(m21e("Mutex ", arg1, arg2), Local7)
			Concatenate(Local7, " is already owned by thr ", Local7)
			Concatenate(Local7, arg0, Local7)
			wrn0(arg0, wn00, Local7)
		} else {
			se00(arg0, er01, "Error er01")
		}
	}

	/* Set up flag */

	Store(arg0, Index(DerefOf(Index(fl00, arg1)), arg2))

	/* Increment counter cnt0 (owning by all threads) */

	Store(DerefOf(Index(cnt0, arg1)), Local0)
	Store(DerefOf(Index(Local0, arg2)), Local1)
	Increment(Local1)
	Store(Local1, Index(DerefOf(Index(cnt0, arg1)), arg2))

	/* Increment counter fl01 (owning by one thread) */

	Store(DerefOf(Index(fl01, arg1)), Local0)
	Store(DerefOf(Index(Local0, arg2)), Local1)
	Increment(Local1)
	Store(Local1, Index(DerefOf(Index(fl01, arg1)), arg2))
}

/*
 * For Release
 *
 * Check up and reset flag (fl00) corresponding to this Mutex
 * (check that it was not changed by other threads while this
 * one was sleeping).
 *
 * arg0 - Index of thread
 * arg1 - Level of mutex
 * arg2 - Index of mutex
 */
Method(m332, 3)
{
	/* Local1 - the value of flag (index of thread owning the mutex) */

	Store(DerefOf(Index(fl00, arg1)), Local0)
	Store(DerefOf(Index(Local0, arg2)), Local1)

	if (LNotEqual(Local1, arg0)) {
		se00(arg0, er02, "Error er02")
	} else {
		/* Reset flag */

		/* Local1 - counter of owning the mutex by the same thread */

		Store(DerefOf(Index(fl01, arg1)), Local0)
		Store(DerefOf(Index(Local0, arg2)), Local1)

		if (LEqual(Local1, 0)) {
			se00(arg0, er08, "Error er08")
		} else {
			Decrement(Local1)
			if (LEqual(Local1, 0)) {
				/*
				 * May be greater than one when owning mutex by the
				 * same thread several times (allowed for ACPI mutex).
				 */
				Store(0, Index(DerefOf(Index(fl00, arg1)), arg2))
			}
			Store(Local1, Index(DerefOf(Index(fl01, arg1)), arg2))
		}
	}
}

/*
 * Check up the value of counter corresponding to this Mutex
 *
 * arg0 - Level of mutex
 * arg1 - Index of mutex
 * arg2 - expected value of counter
 */
Method(m333, 3)
{
	Store(DerefOf(Index(cnt0, arg0)), Local0)
	Store(DerefOf(Index(Local0, arg1)), Local1)
	if (LNotEqual(Local1, arg2)) {
		err("m333", z149, 0x000, 0, 0, Local1, arg2)
		Store(arg0, Debug)
		Store(arg1, Debug)
	}
}

/*
 * Specify the per-thread set of mutexes to deal with in operation
 *
 * arg0 - number of threads (threads actually in work)
 * arg1 - opcode of initialization
 * arg2 - Level of mutex (initial)
 * arg3 - Number of levels of mutexes
 * arg4 - Index of mutex (inside the level)
 * arg5 - Number of mutexes of the same level
 */
Method(m334, 6)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(arg0, lpN0)
	Store(0, lpC0)

	While (lpN0) {

		/* For not a Control thread only */
		if (LNotEqual(lpC0, 0)) {

		Switch (arg1) {
		Case (1) { // c301
			/*
			 * One mutex of Index equal to
			 * ((Index of current thread) - 1)
			 */
			Store(arg2, Index(p200, lpC0))
			Store(arg3, Index(p201, lpC0))

			Subtract(lpC0, 1, Local0)
			Store(Local0, Index(p202, lpC0))
			Store(1, Index(p203, lpC0))
		}
		Default { // c300
			Store(arg2, Index(p200, lpC0))
			Store(arg3, Index(p201, lpC0))
			Store(arg4, Index(p202, lpC0))
			Store(arg5, Index(p203, lpC0))
		}
		} /* Switch() */
		} /* if() */

		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Control thread initiates slaves to Acquire
 * specified set of mutexes - on each specified
 * level - one mutex of Index which is equal to
 * ((Index of thread) - 1).
 *
 * When all slaves complete that operation checks up
 * the state of execution of operation provided by
 * slaves.
 *
 * arg0 - number of threads (total)
 * arg1 - number of threads (threads actually in work)
 *
 * ====== as for m334:
 * arg2 - Level of mutex (initial)
 * arg3 - Number of levels of mutexes
 *
 * arg4 - expected value of counter
 * arg5 - exceptional conditions flags (buffer/Integer)
 */
Method(m337, 6, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	/* Acquire specified set of mutexes */

	/* Set up per-thread set of mutexes */
	m334(arg1, c301, arg2, arg3, 0, 0)

	/* Init the exceptional conditions flags */
	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
	m20f(arg1, arg5, 0)

	// c106 for all first arg1 threads
	m210(bs00, arg0, c106, 0, arg1, 1, c102) // cmd: Acquire specified set of mutexes
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)

	/* Check up the values of counters of all Mutexs */
	Store(arg3, lpN0)
	Store(arg2, lpC0)
	While (lpN0) {
		m333(lpC0, 0, arg4)
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Control thread initiates slaves to Release
 * specified set of mutexes - on each specified
 * level - one mutex of Index which is equal to
 * ((Index of thread) - 1).
 *
 * Control thread initiates slaves to Release
 * specified set of mutexes.
 *
 * arg0 - number of threads (total)
 * arg1 - number of threads (threads actually in work)
 *
 * ====== as for m334:
 * arg2 - Level of mutex (initial)
 * arg3 - Number of levels of mutexes
 */
Method(m338, 4)
{
	/* Set up per-thread set of mutexes */
	m334(arg1, c301, arg2, arg3, 0, 0)

	// c107 for all first arg1 threads
	m210(bs00, arg0, c107, 0, arg1, 1, c102) // cmd: Release specified set of mutexes
	m114(arg0) // run

	/* Wait for all Slave threads */
	m103(arg0)
}

/*
 * Control thread checks that the specified set of slave threads
 * hang on the specified operations or completed the operations.
 *
 * See m10e for args:
 * arg0 - number of threads
 * arg1 - buffer
 */
Method(m33d, 2)
{
	Store(m10f(arg0, arg1), Local0)
	if (And(Local0, 0x01)) {
		err("m33d", z149, 0x001, 0, 0, Local0, 0)
	}
	if (And(Local0, 0x02)) {
		err("m33d", z149, 0x002, 0, 0, Local0, 0)
	}
}

/*
 * Run command for the specified set of slaves
 *
 * arg0 - number of threads
 * arg1 - specificator of elements (see m20a)
 * arg2 - command
 */
Method(m33e, 3)
{
	m20a(bs00, arg0, arg2, arg1) // cmd
	m114(arg0)

	/* Wait for Slave threads */
	m103(arg0)
}

/*
 * Control thread initiates commands for slaves to be fulfilled.
 * After commands execution checks the statuses of all threads.
 *
 * It should be one of the following:
 *   - thread completed the specified command
 *   - thread hangs (on the specified command)
 *   - all other idle threads completed the 'idle-command'
 *     (for all those threads not enumerated in either 'Expected
 *     completion statuses' or 'Expected hang statuses' lists).
 *
 * Note: because of the restricted number of ACPI arguments available,
 *       the input data are combined.
 *
 * arg0 - numbers of threads (buffer/Integer).
 *        Integer:
 *          number of threads both total and 'actually in work'
 *        Buffer (elements of buffer):
 *          0-th element - number of threads (total)
 *          1-th element - number of threads (threads actually in work, not extra idle ones)
 *
 * arg1 - Commands (buffer/Integer).
 *
 *        buffer/Integer, per-thread commands to be fulfilled
 *        Integer:
 *          0        - undefined
 *          non-zero - the same command for all slave threads
 *        Buffer (elements of buffer):
 *          0        - undefined
 *          non-zero - command for the relevant slave thread
 *
 * arg2 - Exceptional conditions flags (buffer/Integer)
 *
 *        buffer/Integer, per-thread flags of exceptional conditions
 *        Integer:
 *          - non-zero means that we generate the same
 *            exceptional condition for all slave threads
 *        Buffer (elements of buffer):
 *          0        - exception is not expected
 *          non-zero - means that we generate exceptional condition
 *                     for the relevant thread
 *
 *        The particular value (X0) of the exceptional condition flag
 *        corresponding to the particular thread means the following:
 *
 *        0: do nothing
 *        non-zero:
 *
 *          1) before to run operation:
 *
 *             check absence of any exception occured on this thread
 *
 *          2) after the operation is completed depending on X0:
 *
 *             EX0E (particular undefined opcode of exception):
 *
 *               check that no any exception occured on this thread
 *
 *             otherwise:
 *
 *               check that exception with opcode equal to X0
 *               has occured on this thread
 *
 * arg3 - Levels of mutexes (buffer/Integer).
 *
 *        buffer/Integer, per-thread levels of mutexes
 *        Integer:
 *          - the same level of mutex for all slave threads
 *            (number of levels is 1)
 *        Buffer (elements of buffer):
 *        Pairs:
 *          - start level of mutex for the relevant thread
 *          - number of levels
 *
 * arg4 - Indexes of mutexes (buffer/Integer).
 *
 *        buffer/Integer, per-thread indexes of mutexes
 *        Integer:
 *          - the same index of mutex for all slave threads
 *            (number of mutexes of the same level is 1)
 *        Buffer (elements of buffer):
 *        Pairs:
 *          - start index of mutex for the relevant thread
 *          - number of mutexes of the same level
 *
 * arg5 - Expected completion statuses (the same semantics as Commands) (buffer/Integer).
 *
 *        buffer/Integer, per-thread commands to check for completion
 *        Integer:
 *          0        - do nothing
 *          non-zero - the same command for all slave threads
 *        Buffer (elements of buffer):
 *          0        - do nothing
 *          non-zero - command for the relevant slave thread
 *
 * arg6 - Expected hang statuses (the same semantics as Commands) (buffer/Integer).
 *
 *        buffer/Integer, per-thread commands to check for hang
 *        Integer:
 *          0        - do nothing
 *          non-zero - the same command for all slave threads
 *        Buffer (elements of buffer):
 *          0        - do nothing
 *          non-zero - command for the relevant slave thread
 *
 *        Note: non-zero 0-th element of the buffer means the
 *              number of hanging threads expected to wake up
 *              after some command of arg1 will be executed.
 */
Method(m33f, 7, Serialized)
{
	Name(nth0, 0) // total
	Name(nth1, 0) // actually in work
	Name(has1, 0) // has non-zero exception expectations

	/* Check params */
	Store(m344(arg5, arg6), Local0)
	if (Local0) {
		err("m33f: incorrect parameters", z149, 0x003, 0, 0, arg5, arg6)
		Store(Local0, Debug)
		return
	}

	/* Parse number of threads */

	if (LEqual(ObjectType(arg0), c009)) {
		Store(arg0, nth0)
		Store(arg0, nth1)
	} else {
		Store(DerefOf(Index(arg0, 0)), nth0)
		Store(DerefOf(Index(arg0, 1)), nth1)
	}

	/* 1) Command execution */

	/*
	 * Prepare buffers of per-thread commands and arguments
	 *
	 * Resulting data: bs00, p200, p201, p202, p203, p204
	 *
	 * Note: not specified elements of buffers are not touched.
	 */
	Store(m340(nth1, arg1, arg2, arg3, arg4), has1)

	/* Allow slaves to execute their commands */

	m114(nth0)

	/* 2) Check status of execution of commands */

	/* Calculate the per-thread expectations of completion statuses */

	Store(m342(nth0, nth1, arg5), Local0)

	/* Calculate the per-thread expectations of hang statuses */

	Store(m342(nth0, nth1, arg6), Local1)

	/* Calculate the idle-threads mapping buffer */

	Store(m343(nth0, nth1, Local0, Local1), Local2)

	/*
	 * So, each thread is represented in one and only one of sets:
	 *
	 * Local0 - expectations of completion
	 * Local1 - expectations of hang
	 * Local2 - idle
	 */

	/* Wait for all Slave threads and check their statuses */

	m110(nth0, Local0, Local1, Local2)

	/* Reset exception expectation */
	m336(nth0, has1)
}

/*
 * Prepare buffers of per-thread commands and arguments
 *
 * Resulting data: bs00, p200, p201, p202, p203
 *
 * Note: don't touch not specified elements of buffer.
 *
 * arg0 - number of threads (threads actually in work)
 * arg1 - Commands (see m33f)
 * arg2 - Exceptional conditions flags (see m33f)
 * arg3 - Levels of mutexes (see m33f)
 * arg4 - Indexes of mutexes (see m33f)
 */
Method(m340, 5, Serialized)
{
	Name(has0, 0)
	Name(has1, 0) // has non-zero exception expectations
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(slct, 0)
	Name(cmd0, 0)

	Name(b000, Buffer(arg0){})
	Name(b200, Buffer(arg0){})
	Name(b201, Buffer(arg0){})
	Name(b202, Buffer(arg0){})
	Name(b203, Buffer(arg0){})

	Store(ObjectType(arg1), Local0)
	if (LEqual(Local0, c009)) {
		/* Integer */
		Store(arg1, cmd0)
		if (LNot(cmd0)) {
			return
		}
	} else {
		/* Buffer/Package */
		Store(1, slct)
	}

	Store(arg0, lpN0)
	Store(0, lpC0)
	While (lpN0) {

		/* For not a Control thread only */
		if (LNotEqual(lpC0, 0)) {

			if (slct) {
				Store(DerefOf(Index(arg1, lpC0)), cmd0)
			}
			if (cmd0) {

				Store(1, has0)

				Store(cmd0, Index(b000, lpC0))

				/* Prepare arguments of command */
				Store(m341(cmd0, lpC0, arg3, arg4), Local0)
				if (LEqual(ObjectType(Local0), c00c)) {
					Store(DerefOf(Index(Local0, 0)), Local1)
					Store(Local1, Index(b200, lpC0))
					Store(DerefOf(Index(Local0, 1)), Local1)
					Store(Local1, Index(b201, lpC0))
					Store(DerefOf(Index(Local0, 2)), Local1)
					Store(Local1, Index(b202, lpC0))
					Store(DerefOf(Index(Local0, 3)), Local1)
					Store(Local1, Index(b203, lpC0))
				}
			}
		}
		Decrement(lpN0)
		Increment(lpC0)
	}

	/* Prepare the exceptional conditions flags buffer */

	Store(m20e(arg0, arg2), Local1)


	/*
	 * Prepare all the commands and arguments and then re-write
	 * them into the target buffers looks there useful for debugging.
	 */
	if (has0) {
		Store(arg0, lpN0)
		Store(0, lpC0)
		While (lpN0) {
			Store(DerefOf(Index(b000, lpC0)), cmd0)
			if (cmd0) {
				Store(cmd0, Index(bs00, lpC0))

				Store(DerefOf(Index(b200, lpC0)), Local0)
				Store(Local0, Index(p200, lpC0))
				Store(DerefOf(Index(b201, lpC0)), Local0)
				Store(Local0, Index(p201, lpC0))
				Store(DerefOf(Index(b202, lpC0)), Local0)
				Store(Local0, Index(p202, lpC0))
				Store(DerefOf(Index(b203, lpC0)), Local0)
				Store(Local0, Index(p203, lpC0))
				Store(DerefOf(Index(Local1, lpC0)), Local0)
				if (Local0) {
					Store(1, has1)
				}
				Store(Local0, Index(p204, lpC0))
				Store(TOVF, Index(p205, lpC0))
			}
			Decrement(lpN0)
			Increment(lpC0)
		}
	}
	return (has1)
}

/*
 * Prepare arguments of command
 *
 * arg0 - command
 * arg1 - index of thread
 * arg2 - Levels of mutexes (see m33f)
 * arg3 - Indexes of mutexes (see m33f)
 *
 * Return (no free ArgX to pass references to target Packages there,
 *         so using Return):
 *   - Package with elements to be filled
 *     into p200, p201, p202, p203.
 *   - Integer if no arguments.
 */
Method(m341, 4)
{
	Name(has0, 0)
	Name(p000, Package(4){0,0,0,0})

	Name(i000, 0)
	Name(i001, 0)
	Name(i002, 0)
	Name(i003, 0)

	Switch (arg0) {
	Case (Package(3) {0xf6, 0xf7, 0xf3}) {

		// 0xf6, c106 - Acquire specified set of mutexes
		// 0xf7, c107 - Release specified set of mutexes
		// 0xf3, c103 - Acquire/Sleep/Release

		/*
		 * To calculate:
		 *
		 * i000 - starting level of mutex
		 * i001 - number of levels
		 * i002 - starting index of mutex (of the same level)
		 * i003 - number of mutexes (of the same level)
		 */

		/* Levels */

		Store(ObjectType(arg2), Local0)
		if (LEqual(Local0, c009)) {
			/* Integer */
			Store(arg2, i000)
			Store(1, i001)
		} else {
			/* Buffer/Package */
			Multiply(arg1, 2, Local0)
			Store(DerefOf(Index(arg2, Local0)), i000)
			Increment(Local0)
			Store(DerefOf(Index(arg2, Local0)), i001)
		}

		/* Indexes */

		Store(ObjectType(arg3), Local0)
		if (LEqual(Local0, c009)) {
			/* Integer */
			Store(arg3, i002)
			Store(1, i003)
		} else {
			/* Buffer/Package */
			Multiply(arg1, 2, Local0)
			Store(DerefOf(Index(arg3, Local0)), i002)
			Increment(Local0)
			Store(DerefOf(Index(arg3, Local0)), i003)
		}

		Store(1, has0)
	}
	Default {
		err("m341: unexpected command:", z149, 0x004, 0, 0, 0, arg0)
	}
	}

	if (has0) {
		Store(i000, Index(p000, 0))
		Store(i001, Index(p000, 1))
		Store(i002, Index(p000, 2))
		Store(i003, Index(p000, 3))

		return (p000)
	}

	return (0)
}

/*
 * Prepare the per-thread status expectations mapping buffer
 *
 * arg0 - number of threads (total)
 * arg1 - number of threads (threads actually in work)
 * arg2 - Expected completion/hang statuses (see m33f)
 *
 * Return:
 *
 * Buffer (elements of buffer):
 *   0        - nothing to do for the relevant thread
 *   non-zero - element of buffer means the last command
 *              specified for the relevant thread.
 */
Method(m342, 3, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(slct, 0)
	Name(cmd0, 0)

	Name(b000, Buffer(arg0){})

	Store(ObjectType(arg2), Local0)
	if (LEqual(Local0, c009)) {
		/* Integer */
		Store(arg2, cmd0)
		if (LNot(cmd0)) {
			return (b000)
		}
	} else {
		/* Buffer/Package */
		Store(1, slct)
	}

	Store(arg1, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		if (slct) {
			Store(DerefOf(Index(arg2, lpC0)), cmd0)
		}
		if (cmd0) {
			Store(cmd0, Index(b000, lpC0))
		}
		Decrement(lpN0)
		Increment(lpC0)
	}

	return (b000)
}

/*
 * Prepare the idle-threads mapping buffer
 *
 * arg0 - number of threads (total)
 * arg1 - number of threads (threads actually in work, not extra idle ones)
 * arg2 - Buffer, expected completion statuses (see m33f)
 * arg3 - Buffer, Expected hang statuses (see m33f)
 *
 * Return:
 *
 * Buffer (elements of buffer):
 *   0        - the relevant thread is non-idle
 *   non-zero - the relevant thread is idle
 */
Method(m343, 4, Serialized)
{
	Name(err0, 0)
	Name(idle, 0)
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(b000, Buffer(arg0){})

	Store(arg0, lpN0)
	Store(0, lpC0)
	While (lpN0) {

		Store(0, idle)

		if (LGreaterEqual(lpC0, arg1)) {
			Store(1, idle)
		} else {
			Store(DerefOf(Index(arg2, lpC0)), Local0)
			Store(DerefOf(Index(arg3, lpC0)), Local1)

			if (LAnd(Local0, Local1)) {
				/* Expects both completion and hang simultaneously */
				Store(1, err0)
			} elseif (LAnd(LNot(Local0), LNot(Local1))) {
				Store(1, idle)
			}
		}

		Store(idle, Index(b000, lpC0))

		Decrement(lpN0)
		Increment(lpC0)
	}

	if (err0) {
		err("m333", z149, 0x005, 0, 0, 0, 0)
	}

	return (b000)
}

/*
 * Check pair of parameters
 *
 * arg0 - Expected completion statuses (see m33f).
 * arg1 - Expected hang       statuses (see m33f).
 */
Method(m344, 2, Serialized)
{
	Name(int0, 0)
	Name(int1, 0)
	Name(all0, 0)
	Name(all1, 0)

	if (LEqual(ObjectType(arg0), c009)) {
		Store(1, int0)
		if (arg0) {
			Store(1, all0)
		}
	}

	if (LEqual(ObjectType(arg1), c009)) {
		Store(1, int1)
		if (arg1) {
			Store(1, all1)
		}
	}

	if (LOr(all0, all1)) {
		if (LAnd(int0, int0)) {
			if (LAnd(all0, all1)) {
				return (1)
			}
		} else {
			return (2)
		}
	}

	return (0)
}

/*
 * Reset exception expectation
 *
 * arg0 - number of threads (total)
 * arg1 - non-zero -- has non-zero exception expectations
 */
Method(m336, 2)
{
	/* Add statistics of exceptions (total) */
	Add(ex10, EXC0, ex10)

	if (arg1) {
		if (LNot(EXC0)) {
			/* Expected exceptions but have none */
			err("m333", z149, 0x006, 0, 0, EXC0, 0)
		}
	} else {
		if (EXC0) {
			/* Unexpected exceptions */
			err("m333", z149, 0x007, 0, 0, EXC0, 0)
		}
	}

	/*Reset EXC0 (the current number of exceptions handled) */
	CH0A()

	m215(arg0)             // Reset TimeOutValue and exceptional condition flags
}

/* Init fl01 */
Method(m339,, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(lpN1, 0)
	Name(lpC1, 0)


	Store(max0, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		Store(max1, lpN1)
		Store(0, lpC1)
		While (lpN1) {
			Store(0, Index(DerefOf(Index(fl01, lpC0)), lpC1))
			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

