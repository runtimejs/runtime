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
 * Run only for the Slave threads,
 * they wait there for the Control
 * thread says 'all is ready',
 * 'go further'.
 *
 * arg0 - Index of current thread
 */
Method(m116, 1)
{
	While (1) {

		if (ctl0) {
			/* Control thread says 'all is ready' */
			break
		}

		m201(arg0, vb03, "Sleep, waiting for Control thread")
		m206(arg0, sl01)
	}
}

/*
 * Infinite loop of the Slave Threads
 *
 * arg0 - number of threads
 * arg1 - ID of current thread
 * arg2 - Index of current thread
 * arg3 - the depth of recursion of call
 */
Method(m101, 4)
{
	/*
	 * These internal variables are specified only to show that
	 * recursive calls to methods having internal declarations
	 * (as well as Switch operators) of objects works.
	 */
	Name(i000, 0xabcd0000)
	Name(i001, 0xabcd0001)
	Name(i002, 0xabcd0002)
	Name(i003, 0xabcd0003)

	Store(DerefOf(Index(bs04, arg2)), Local0)
	if (Local0) {
		/* Go everywhere to the exit to "Terminate thread" */
		return
	}

	/* Wait for Control thread saying 'go further' */
	m116(arg2)


	/*
	 * Local0 - command for slave to be executed
	 *
	 * Local7 - non-zero means to do break after
	 *          confirming "I see zero do00".
	 *          Keep Local7 zero otherwise.
	 */
	Store(0, Local7)
	While (1) {

		if (LGreaterEqual(arg2, arg0)) {
			se00(arg2, er06, "Error er06")
		}

		/* Determine the command for particular thread */

		Store(c100, Local0)

		/* Control thread allows for slave threads to fulfill their commands */
		if (do00) {

			Store(DerefOf(Index(bs01, arg2)), Local1)

			/* This thread doesn't yet fulfill its command */
			if (LNot(Local1)) {
				/* Command to be fulfilled */
				Store(DerefOf(Index(bs00, arg2)), Local0)
			}

			/* Unnecessary */
			if (LNot(do00)) {
				Store(c100, Local0)
			}
		}

		if (LNot(do00)) {
			Store(DerefOf(Index(bs02, arg2)), Local1)
			if (LNot(Local1)) {
				/* Slave thread reports: "I see zero do00" */
				Store(rs00, Index(bs02, arg2))
				if (Local7) {
					m201(arg2, vb03, "Break completed: exit invinitive loop")
					break
				}
			}
		}

		Switch (Local0) {
			Case (0xf0) { // c100 (Idle thread)
				/*
				 * This command is fulfilled by slave thread
				 * without directive of Control thread.
				 */
				m201(arg2, vb03, "Sleep")
				m206(arg2, sl01)
				Store(c100, Index(bs03, arg2))
			}
			Case (0xf1) { // c101
				m201(arg2, vb03, "Break started")
				Store(c101, Index(bs01, arg2))
				/*
				 * se00(3, 0x12345, "")
				 * break
				 *
				 * Note:
				 * Non-zero Local7 means to do break after
				 * confirming "I see zero do00".
				 * Keep Local7 zero in all other entries.
				 */
				Store(1, Local7)
			}
			Case (0xf2) { // c102
				m201(arg2, vb03, "Sleep, command")
				m206(arg2, sl01)
				Store(c102, Index(bs01, arg2))
			}
			Case (0xf3) { // c103
				m201(arg2, vb03, "Acquire/Release")

				/*
				 * Local1 - Level of mutex
				 * Local2 - number of Levels of mutexes (only 1 here)
				 * Local3 - Index of mutex
				 * Local4 - number of mutexes of the same level
				 */
				Store(DerefOf(Index(p200, arg2)), Local1)
				/* Local2 - number of Levels of mutexes is 1 here, not used */
				Store(DerefOf(Index(p202, arg2)), Local3)
				Store(DerefOf(Index(p203, arg2)), Local4)

				While (Local4) {
					// Acquire
					Store(m310(arg1, arg2, Local1, Local3, 0, 0, 1), Local7)
					if (LNot(Local7)) {
						// Release
						m311(arg1, arg2, Local1, Local3, 0, 1)
					}
					Decrement(Local4)
					Increment(Local3)
				}
				Store(c103, Index(bs01, arg2))

				Store(0, Local7) // keep Local7 zero
			}
			Case (0xf4) { // c104

				m201(arg2, vb03, "c104")

				/*
				 * Local1 - Level of mutex
				 * Local2 - number of Levels of mutexes (only 1 here)
				 * Local3 - Index of mutex
				 * Local4 - number of mutexes of the same level
				 */

				/* Acquire mutexes from 0 up to 15 level */

				Store(max0, Local2)
				Store(0, Local1)
				While (Local2) {
					Store(DerefOf(Index(p202, arg2)), Local3)
					Store(DerefOf(Index(p203, arg2)), Local4)
					While (Local4) {
						m310(arg1, arg2, Local1, Local3, 0, 0, 1)
						Decrement(Local4)
						Increment(Local3)
					}
					Decrement(Local2)
					Increment(Local1)
				}

				/* Levels - in the inverse order */

				/* Release mutexes from 15 down t0 0 level */

				Store(max0, Local2)
				Subtract(max0, 1, Local1)
				While (Local2) {

					Store(DerefOf(Index(p202, arg2)), Local3)
					Store(DerefOf(Index(p203, arg2)), Local4)

					/* Indexes - in the inverse order too */

					Add(Local3, Local4, Local3)
					Decrement(Local3)
					While (Local4) {
						m311(arg1, arg2, Local1, Local3, 0, 1)
						Decrement(Local4)
						Decrement(Local3)
					}
					Decrement(Local2)
					Decrement(Local1)
				}

				Store(c104, Index(bs01, arg2))
			}
			Case (0xf5) { // c105
				m201(arg2, vb03, "Example 0")
				Store(10, Local1)
				While (Local1) {
					Switch (arg2) {
						Case (2) {
							C0AB(arg1, arg2)
						}
						Case (4) {
							C0AB(arg1, arg2)
						}
						Case (6) {
							C0AB(arg1, arg2)
						}
						Default {
							C0A2(arg1, arg2, 1, 1, 1)
						}
					}
					Decrement(Local1)
				}
				Store(c105, Index(bs01, arg2))
			}
			Case (0xf6) { // c106

				m201(arg2, vb03, "Acquire specified set of mutexes")

				/*
				 * Local0 - auxiliary
				 * Local1 - Level of mutex
				 * Local2 - number of Levels of mutexes (only 1 here)
				 * Local3 - Index of mutex
				 * Local4 - number of mutexes of the same level
				 * Local5 - non-zero means that we generate exceptional condition
				 * Local6 - opcode of TimeOutValue
				 * Local7 - auxiliary
				 */

				Store(DerefOf(Index(p200, arg2)), Local1)
				Store(DerefOf(Index(p201, arg2)), Local2)
				While (Local2) {
					Store(DerefOf(Index(p202, arg2)), Local3)
					Store(DerefOf(Index(p203, arg2)), Local4)
					Store(DerefOf(Index(p204, arg2)), Local5)
					Store(DerefOf(Index(p205, arg2)), Local6)
					While (Local4) {
						Store(m111(arg1, arg2, Local5, "Acquire"), Local7)
						Store(m310(arg1, arg2, Local1, Local3, Local7, Local6, 1), Local0)
						m112(arg1, arg2, Local5, Local0)
						Decrement(Local4)
						Increment(Local3)
					}
					Decrement(Local2)
					Increment(Local1)
				}

				Store(c106, Index(bs01, arg2))

				Store(0, Local7) // keep Local7 zero
			}
			Case (0xf7) { // c107

				m201(arg2, vb03, "Release specified set of mutexes")

				/*
				 * Local1 - Level of mutex
				 * Local2 - number of Levels of mutexes (only 1 here)
				 * Local3 - Index of mutex
				 * Local4 - number of mutexes of the same level
				 * Local5 - non-zero means that we generate exceptional condition
				 * Local7 - auxiliary
				 */

				Store(DerefOf(Index(p200, arg2)), Local1)
				Store(DerefOf(Index(p201, arg2)), Local2)

				/* Levels - in the inverse order */

				Add(Local1, Local2, Local1)
				Decrement(Local1)
				While (Local2) {

					Store(DerefOf(Index(p202, arg2)), Local3)
					Store(DerefOf(Index(p203, arg2)), Local4)
					Store(DerefOf(Index(p204, arg2)), Local5)

					/* Indexes - in the inverse order too */

					Add(Local3, Local4, Local3)
					Decrement(Local3)
					While (Local4) {
						Store(m111(arg1, arg2, Local5, "Release"), Local7)
						m311(arg1, arg2, Local1, Local3, Local7, 1)
						m112(arg1, arg2, Local5, 0)
						Decrement(Local4)
						Decrement(Local3)
					}
					Decrement(Local2)
					Decrement(Local1)
				}

				Store(c107, Index(bs01, arg2))

				Store(0, Local7) // keep Local7 zero
			}
			Case (0xf8) { // c108
				m201(arg2, vb03, "Terminate thread")
				Store(1, Index(bs04, arg2))
				break
			}
			Case (0xf9) { // c109
				if (LNot(arg3)) {
					m201(arg2, vb03, "Invoke Serialized method")
					m8fc(arg0, arg1, arg2)
				} else {
					/*
					 * Only after falling down to the second recurcive call
					 * to m101 report that you are completed c109 command and
					 * ready handle following commands.
					 */
					m201(arg2, vb03, "Recursive call to m101 for 'Invoke Serialized method'")
					Store(c109, Index(bs01, arg2))
				}
			}
			Case (0xfa) { // c10a
				if (LNot(arg3)) {
					m201(arg2, vb03, "Invoke non-serialized method, use Mutex for critical section")
					m8fa(arg0, arg1, arg2)
				} else {
					/*
					 * Only after falling down to the second recurcive call
					 * to m101 report that you are completed c109 command and
					 * ready handle following commands.
					 */
					m201(arg2, vb03, "Recursive call to m101 for 'Mutex for critical section'")
					Store(c10a, Index(bs01, arg2))
				}
			}
			Case (0xfb) { // c10b
				if (LNot(arg3)) {
					m201(arg2, vb03, "Non-serialized method is grabbed simultaneously by several threads")
					m8f9(arg0, arg1, arg2)
				} else {
					/*
					 * Only after falling down to the second recurcive call
					 * to m101 report that you are completed c109 command and
					 * ready handle following commands.
					 */
					m201(arg2, vb03, "Recursive call to m101 for 'Non-serialized method'")
					Store(c10b, Index(bs01, arg2))
				}
			}

			Default {
				se00(arg2, er05, , "Error er05")
				m201(arg2, vb03, "Sleep, bad command")
				Store(Local0, Debug)
				m206(arg2, sl01)
			}
		}
	}
}
