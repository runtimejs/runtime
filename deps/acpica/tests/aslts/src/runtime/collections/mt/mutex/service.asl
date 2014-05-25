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
 * Service routines of common use
 */

Name(z153, 153)

/*
 * Fill the buffer with the same value
 *
 * arg0 - buffer
 * arg1 - the length of buffer
 * arg2 - the value
 */
Method(m200, 3, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(arg1, lpN0)
	Store(0, lpC0)

	While (lpN0) {

		/* For not a Control thread only */
		if (LNotEqual(lpC0, 0)) {
			Store(arg2, Index(arg0, lpC0))
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Fill the region of buffer with the same value
 *
 * arg0 - buffer
 * arg1 - the length of buffer
 * arg2 - the value
 *
 * arg3 - start index
 * arg4 - the length of region to be filled
 *        0 - everywhere from index to the end of buffer
 * arg5 - if non-zero than fill the ground value arg6 into the buffer
 *        everywhere outside the specified region
 * arg6 - the value of ground
 */
Method(m210, 7, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Name(sz01, 0)
	Name(ix02, 0)

	if (LGreaterEqual(arg3, arg1)) {
		err("m210", z153, 0x000, 0, 0, arg3, arg1)
		return
	}

	/* Sizes of fields */
	if (arg4) {
		Store(arg4, sz01)
	} else {
		Subtract(arg1, arg3, sz01)
	}
	Add(arg3, sz01, ix02)
	if (LGreater(ix02, arg1)) {
		err("m210", z153, 0x001, 0, 0, ix02, arg1)
		Store(arg1, Debug)
		Store(arg3, Debug)
		Store(arg4, Debug)
		Store(arg5, Debug)
		return
	}

	if (arg5) {
		Store(arg1, lpN0)
		Store(0, lpC0)
	} else {
		Store(sz01, lpN0)
		Store(arg3, lpC0)
	}

	While (lpN0) {

		if (LOr(LLess(lpC0, arg3), LGreaterEqual(lpC0, ix02))) {
			Store(arg6, Local0)
		} else {
			Store(arg2, Local0)
		}

		Store(Local0, Index(arg0, lpC0))

		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Report message of thread
 * (adds index of thread and reports the message)
 *
 * arg0 - Index of current thread
 * arg1 - s-flag of verbal mode
 * arg2 - string
 */
Method(m201, 3)
{
	if (arg1) {
		Concatenate("THREAD ", arg0, Local0)
		Concatenate(Local0, ": ", Local1)
		Concatenate(Local1, arg2, Local0)
		Store(Local0, Debug)
	}
}

/*
 * Report the message conditionally according to the relevant
 * flag of verbal mode.
 *
 * arg0 - Index of current thread
 * arg1 - mc-flag of verbal mode
 * arg2 - if do printing actually (or only return flag)
 * arg3 - message - object to be sent to Debug
 */
Method(m202, 4)
{
	Store(0, Local0)

	Switch (arg1) {
		Case (1) {
			/* allow only for Control Thread to report */
			if (LNot(arg0)) {
				Store(1, Local0)
			}
		}
		Case (2) {
			/* allow only for Slave Threads to report */
			if (arg0) {
				Store(1, Local0)
			}
		}
		Case (3) {
			/* allow for all threads to report */
			Store(1, Local0)
		}
	}

	if (LAnd(Local0, arg2)) {
		Store(arg3, Debug)
	}

	return (Local0)
}

/*
 * Report start of test
 *
 * arg0 - name of test
 * arg1 - number of threads
 * arg2 - ID of current thread
 * arg3 - Index of current thread
 */
Method(m204, 4)
{
	if (m202(arg3, vb01, 0, 0)) {
		Concatenate("Test ", arg0, Local0)
		Concatenate(Local0, " started", Local1)
		Concatenate(Local1, ", threads num ", Local0)
		Concatenate(Local0, arg1, Local1)
		Concatenate(Local1, ", ID of thread ", Local0)
		Concatenate(Local0, arg2, Local1)
		Concatenate(Local1, ", Index of thread ", Local0)
		Concatenate(Local0, arg3, Local1)
		Store(Local1, Debug)
	}
}

/*
 * Fulfil and report Sleep
 *
 * arg0 - Index of current thread
 * arg1 - number of milliseconds to sleep
 */
Method(m206, 2)
{
	m201(arg0, vb03, "Sleep")

	/* Increment statistics of Sleep */
	if (LAnd(vb04, ctl0)) {
		m212(RefOf(p104), arg0)
	}

	Sleep(arg1)
}

/*
 * Fulfil and report Stall
 *
 * arg0 - Index of current thread
 * arg1 - number of MicroSeconds to Stall
 */
Method(m207, 2)
{
	m201(arg0, vb03, "Stall")
	Stall(arg1)
}

/*
 * Put the value into i-th element of the buffer
 *
 * arg0 - buffer
 * arg1 - index
 * arg2 - the value
 */
Method(m208, 3)
{
	Store(arg2, Index(arg0, arg1))
}

/*
 * Set up a sleeping mode
 *
 * arg0 - opcode of sleeping mode
 */
Method(m209)
{
	/* Milliseconds to sleep for non-zero slm0 */

	Switch (0) {
		Case (0) {
			Store(10, i100)
			Store(10, i101)
			Store(10, i102)
			Store(10, i103)
			Store(10, i104)
			Store(10, i105)
			Store(10, i106)
			Store(10, i107)
			Store(10, i108)
		}
		Default {
			Store(50,  i100)
			Store(100, i101)
			Store(200, i102)
			Store(400, i103)
			Store(500, i104)
			Store(75,  i105)
			Store(150, i106)
			Store(250, i107)
			Store(300, i108)
		}
	}
}

/*
 * Fill specified elements of buffer with the same value
 *
 * arg0 - buffer
 * arg1 - the length of buffer
 * arg2 - the value
 * arg3 - specificator of elements:
 *        Integer - all elements of arg0
 *        Buffer  - for non-zero elements of arg3 only
 */
Method(m20a, 4, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(slct, 0)
	Name(run0, 0)

	Store(ObjectType(arg3), Local0)
	if (LNotEqual(Local0, c009)) {
		Store(1, slct)
	}

	Store(arg1, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		Store(1, run0)
		if (slct) {
			Store(DerefOf(Index(arg3, lpC0)), run0)
		}
		if (run0) {
			Store(arg2, Index(arg0, lpC0))
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Print out all the auxiliary buffers
 *
 * arg0 - Index of current thread
 * arg1 - message
 */
Method(m20b, 2)
{
	Concatenate("Print out the auxiliary buffers (bs00,bs01,bs02) <", arg1, Local0)
	Concatenate(Local0, ">", Local1)

	m201(arg0, 1, Local1)
	m201(arg0, 1, bs00)
	m201(arg0, 1, bs01)
	m201(arg0, 1, bs02)
	m201(arg0, 1, bs03)
}

/*
 * Return numbers of threads Buffer
 *
 * arg0 - number of threads (total)
 * arg1 - number of threads (threads actually in work, not extra idle ones)
 */
Method(m20d, 2, Serialized)
{
	Name(nth0, Buffer(2) {})

	Store(arg0, Index(nth0, 0))
	Store(arg1, Index(nth0, 1))

	return (nth0)
}

/*
 * Prepare the exceptional conditions flags buffer
 *
 * arg0 - number of threads
 * arg1 - Exceptional conditions flags (buffer/Integer)
 */
Method(m20e, 2, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(ObjectType(arg1), Local0)
	if (LNotEqual(Local0, c009)) {
		/* Not Integer */
		return (arg1)
	}

	Name(b000, Buffer(arg0){})

	Store(arg0, lpN0)
	Store(0, lpC0)
	While (lpN0) {

		/* Flag of exceptional condition */

		Store(arg1, Index(b000, lpC0))

		Decrement(lpN0)
		Increment(lpC0)
	}

	return (b000)
}

/*
 * Initialize the exceptional conditions flags (p204 & FLG0)
 * (initialize expectation of exceptions).
 *
 * arg0 - number of threads
 * arg1 - exceptional conditions flags (buffer/Integer)
 * arg2 - non-zero means to check absence of exception
 *        before and after each operation additionally
 *        to the checking (if any) specified per-operation.
 */
Method(m20f, 3, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(slct, 0)
	Name(ex00, 0)

	Store(ObjectType(arg1), Local0)
	if (LEqual(Local0, c009)) {
		/* Integer */
		Store(arg1, ex00)
	} else {
		/* Buffer/Package */
		Store(1, slct)
	}

	Store(arg0, lpN0)
	Store(0, lpC0)
	While (lpN0) {

		if (slct) {
			/* Flag of exceptional condition */
			Store(DerefOf(Index(arg1, lpC0)), ex00)
		}

		Store(ex00, Index(p204, lpC0))

		Decrement(lpN0)
		Increment(lpC0)
	}

	Store(arg2, FLG0)
}

/*
 * Initialize the TimeOutValue mapping buffer
 *
 * arg0 - number of threads (total)
 * arg1 - number of threads (threads actually in work)
 * arg2 - (buffer/Integer) of TimeOutValue
 */
Method(m214, 3, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(slct, 0)
	Name(topc, 0)

	Store(ObjectType(arg2), Local0)
	if (LEqual(Local0, c009)) {
		/* Integer */
		Store(arg2, topc)
	} else {
		/* Buffer/Package */
		Store(1, slct)
	}

	Store(arg1, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		if (slct) {
			Store(DerefOf(Index(arg2, lpC0)), topc)
		}
		Store(topc, Index(p205, lpC0))
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Reset TimeOutValue and exceptional conditions flags to default
 *
 * arg0 - number of threads (total)
 */
Method(m215, 1)
{
	m20f(arg0, 0, 0)       // Reset the exceptional conditions flags
	m214(arg0, arg0, TOVF) // Set TimeOutValue to default
}

/*
 * Report statistics
 *
 * arg0 - number of threads
 */
Method(m211, 1, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	/* global data not initialized */
	if (LNot(gldi)) {
		return
	}

	Store("================ Per-thread statistics: ================", Debug)

	Store("Errors   scale   : ", Local0)
	Store("          number : ", Local1)
	Store("Warnings   scale : ", Local2)
	Store("          number : ", Local3)
	Store("Sleep     number : ", Local4)
	Store("Acquire   number : ", Local5)
	Store("Release   number : ", Local6)

	Store(arg0, lpN0)
	Store(0, lpC0)
	While (lpN0) {

		Store(DerefOf(Index(p100, lpC0)), Local7)
		Concatenate(Local0, Local7, Local0)
		if (LNotEqual(lpN0, 1)) {
			Concatenate(Local0, ", ", Local0)
		}

		Store(DerefOf(Index(p101, lpC0)), Local7)
		Concatenate(Local1, Local7, Local1)
		if (LNotEqual(lpN0, 1)) {
			Concatenate(Local1, ", ", Local1)
		}

		Store(DerefOf(Index(p102, lpC0)), Local7)
		Concatenate(Local2, Local7, Local2)
		if (LNotEqual(lpN0, 1)) {
			Concatenate(Local2, ", ", Local2)
		}

		Store(DerefOf(Index(p103, lpC0)), Local7)
		Concatenate(Local3, Local7, Local3)
		if (LNotEqual(lpN0, 1)) {
			Concatenate(Local3, ", ", Local3)
		}

		Store(DerefOf(Index(p104, lpC0)), Local7)
		Concatenate(Local4, Local7, Local4)
		if (LNotEqual(lpN0, 1)) {
			Concatenate(Local4, ", ", Local4)
		}

		Store(DerefOf(Index(p105, lpC0)), Local7)
		Concatenate(Local5, Local7, Local5)
		if (LNotEqual(lpN0, 1)) {
			Concatenate(Local5, ", ", Local5)
		}

		Store(DerefOf(Index(p106, lpC0)), Local7)
		Concatenate(Local6, Local7, Local6)
		if (LNotEqual(lpN0, 1)) {
			Concatenate(Local6, ", ", Local6)
		}

		Decrement(lpN0)
		Increment(lpC0)
	}

	Store(Local0, Debug)
	Store(Local1, Debug)
	Store(Local2, Debug)
	Store(Local3, Debug)
	Store(Local4, Debug)
	Store(Local5, Debug)
	Store(Local6, Debug)

	Concatenate("Exceptions total : ", ex10, Debug)

	Store("========================================================", Debug)

}

/*
 * Increment element of Package
 *
 * arg0 - RefOf of Package
 * arg1 - index of element
 */
Method(m212, 2)
{
	Store(DerefOf(Index(DerefOf(arg0), arg1)), Local0)
	Increment(Local0)
	Store(Local0, Index(DerefOf(arg0), arg1))
}

/*
 * Return the number of threads to be the number of threads actually in work
 * (including Control thread).
 * Should be not less than 3.
 *
 * Note: to be provided that arg0 is not less than the test needs
 *       to perform effective checking according to its scenario.
 *
 * arg0 - number of threads (total)
 * arg1 - maximal number of threads according to scenario of test (including Control thread)
 * arg2 - if non-zero, then the number of treads to be actually in work in reduced mode (including Control thread)
 */
Method(m213, 3, Serialized)
{
	Name(num, 0)

	Store(arg0, num)
	if (arg1) {
		Store(arg1, num)
	}
	if (redm) {
		if (arg2) {
			Store(arg2, num)
		}
	}
	if (LLess(arg0, num)) {
		Store(arg0, num)
	}

	return (num)
}

