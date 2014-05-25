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
 * Mutex
 *
 * declarations for common use
 */

Name(max0, 16) // Number of different Levels of mutexes
Name(hlmx, 15) // Highest Level of mutex
Name(max1, 18) // Max number of mutexes of the same level
Name(unim, 18) // Undefined index of mutex

Name(max2, Buffer(max0) { // Numbers of mutexes of the relevant level
	18, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4})

/*
 * GLLL - Level of mutex for Global Lock.
 * GLIX - Index of mutex for Global Lock.
 *
 * The Global Lock in tests is represented as mutex of 0-th Level 1-th Index.
 */
Name(GLLL, 0) // Level of mutex for GL
Name(GLIX, 1) // Index of mutex for GL
/*
 * Flag of Global lock.
 * If non-zero then actually the Global lock is used in tests
 * instead of the usual mutex T001 (of level 0 index 1).
 */
Name(GL00, 0)

Name(min0, 4)  // Minimal number of mutexes of the same level in groups below
Name(min1, 5)  // Minimal number of threads corresponding to min0

/*
 * See TOV0 and TOV0 below,
 * all other opcodes of TimeOutValue correspond to 0xffff.
 */
Name(TOV0, 5) // opcode of TimeOutValue corresponding to 0 milliseconds
Name(TOV1, 6) // opcode of TimeOutValue corresponding to 1 milliseconds
Name(TOVF, 0) // opcode of TimeOutValue corresponding to 0xffff (endless)


/* Level 0 */
Mutex(T000, 0)
Mutex(T001, 0) // used in case when the flag of the Global Lock (GL00) is zero
Mutex(T002, 0)
Mutex(T003, 0)
Mutex(T004, 0)
Mutex(T005, 0)
Mutex(T006, 0)
Mutex(T007, 0)
Mutex(T008, 0)
Mutex(T009, 0)
Mutex(T00a, 0)
Mutex(T00b, 0)
Mutex(T00c, 0)
Mutex(T00d, 0)
Mutex(T00e, 0)
Mutex(T00f, 0)
Mutex(T010, 0)
Mutex(T011, 0)

/* Level 1 */
Mutex(T100, 1)
Mutex(T101, 1)
Mutex(T102, 1)
Mutex(T103, 1)

/* Level 2 */
Mutex(T200, 2)
Mutex(T201, 2)
Mutex(T202, 2)
Mutex(T203, 2)

/* Level 3 */
Mutex(T300, 3)
Mutex(T301, 3)
Mutex(T302, 3)
Mutex(T303, 3)

/* Level 4 */
Mutex(T400, 4)
Mutex(T401, 4)
Mutex(T402, 4)
Mutex(T403, 4)

/* Level 5 */
Mutex(T500, 5)
Mutex(T501, 5)
Mutex(T502, 5)
Mutex(T503, 5)

/* Level 6 */
Mutex(T600, 6)
Mutex(T601, 6)
Mutex(T602, 6)
Mutex(T603, 6)

/* Level 7 */
Mutex(T700, 7)
Mutex(T701, 7)
Mutex(T702, 7)
Mutex(T703, 7)

/* Level 8 */
Mutex(T800, 8)
Mutex(T801, 8)
Mutex(T802, 8)
Mutex(T803, 8)
Mutex(T804, 8) // used in functional/synchronization
Mutex(T805, 8) // used in functional/synchronization

/* Level 9 */
Mutex(T900, 9)
Mutex(T901, 9)
Mutex(T902, 9)
Mutex(T903, 9)

/* Level 10 */
Mutex(Ta00, 0x0a)
Mutex(Ta01, 0x0a)
Mutex(Ta02, 0x0a)
Mutex(Ta03, 0x0a)

/* Level 11 */
Mutex(Tb00, 0x0b)
Mutex(Tb01, 0x0b)
Mutex(Tb02, 0x0b)
Mutex(Tb03, 0x0b)

/* Level 12 */
Mutex(Tc00, 0x0c)
Mutex(Tc01, 0x0c)
Mutex(Tc02, 0x0c)
Mutex(Tc03, 0x0c)

/* Level 13 */
Mutex(Td00, 0x0d)
Mutex(Td01, 0x0d)
Mutex(Td02, 0x0d)
Mutex(Td03, 0x0d)

/* Level 14 */
Mutex(Te00, 0x0e)
Mutex(Te01, 0x0e)
Mutex(Te02, 0x0e)
Mutex(Te03, 0x0e)

/* Level 15 */
Mutex(Tf00, 0x0f)
Mutex(Tf01, 0x0f)
Mutex(Tf02, 0x0f)
Mutex(Tf03, 0x0f)


/*
 *
 * Methods to manage mutexes declared above
 *
 */


/*
 * Set flag of Global lock
 *
 * arg0 - new value of flag of GL
 *
 * Return:
 *   old value of flag of GL
 */
Method(m078, 1)
{
	Store(GL00, Local7)
	Store(arg0, GL00)

	return (Local7)
}

/*
 * Acquire mutex of level 0
 *
 * arg0 - Index of mutex
 * arg1 - opcode of exception to be generated or zero
 * arg2 - opcode of TimeOutValue (unfortunately, ACPA doesn't allow TermArg there)
 *        0 - 0
 *        1 - 1
 *        otherwise - oxffff
 */
Method(ma00, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(T000, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T000, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T000, 1), Local0)
			} else {
				Store(Acquire(T000, 0xffff), Local0)
			}
		}
		Case (1) {
			if (GL00) {
				if (arg1) {
					Acquire(\_GL, 0xffff)
				} elseif (LEqual(arg2, TOV0)) {
					Store(Acquire(\_GL, 0), Local0)
				} elseif (LEqual(arg2, TOV1)) {
					Store(Acquire(\_GL, 1), Local0)
				} else {
					Store(Acquire(\_GL, 0xffff), Local0)
				}
			} else {
				if (arg1) {
					Acquire(T001, 0xffff)
				} elseif (LEqual(arg2, TOV0)) {
					Store(Acquire(T001, 0), Local0)
				} elseif (LEqual(arg2, TOV1)) {
					Store(Acquire(T001, 1), Local0)
				} else {
					Store(Acquire(T001, 0xffff), Local0)
				}
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(T002, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T002, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T002, 1), Local0)
			} else {
				Store(Acquire(T002, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(T003, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T003, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T003, 1), Local0)
			} else {
				Store(Acquire(T003, 0xffff), Local0)
			}
		}
		Case (4) {
			if (arg1) {
				Acquire(T004, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T004, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T004, 1), Local0)
			} else {
				Store(Acquire(T004, 0xffff), Local0)
			}
		}
		Case (5) {
			if (arg1) {
				Acquire(T005, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T005, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T005, 1), Local0)
			} else {
				Store(Acquire(T005, 0xffff), Local0)
			}
		}
		Case (6) {
			if (arg1) {
				Acquire(T006, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T006, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T006, 1), Local0)
			} else {
				Store(Acquire(T006, 0xffff), Local0)
			}
		}
		Case (7) {
			if (arg1) {
				Acquire(T007, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T007, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T007, 1), Local0)
			} else {
				Store(Acquire(T007, 0xffff), Local0)
			}
		}
		Case (8) {
			if (arg1) {
				Acquire(T008, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T008, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T008, 1), Local0)
			} else {
				Store(Acquire(T008, 0xffff), Local0)
			}
		}
		Case (9) {
			if (arg1) {
				Acquire(T009, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T009, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T009, 1), Local0)
			} else {
				Store(Acquire(T009, 0xffff), Local0)
			}
		}
		Case (10) {
			if (arg1) {
				Acquire(T00a, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T00a, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T00a, 1), Local0)
			} else {
				Store(Acquire(T00a, 0xffff), Local0)
			}
		}
		Case (11) {
			if (arg1) {
				Acquire(T00b, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T00b, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T00b, 1), Local0)
			} else {
				Store(Acquire(T00b, 0xffff), Local0)
			}
		}
		Case (12) {
			if (arg1) {
				Acquire(T00c, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T00c, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T00c, 1), Local0)
			} else {
				Store(Acquire(T00c, 0xffff), Local0)
			}
		}
		Case (13) {
			if (arg1) {
				Acquire(T00d, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T00d, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T00d, 1), Local0)
			} else {
				Store(Acquire(T00d, 0xffff), Local0)
			}
		}
		Case (14) {
			if (arg1) {
				Acquire(T00e, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T00e, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T00e, 1), Local0)
			} else {
				Store(Acquire(T00e, 0xffff), Local0)
			}
		}
		Case (15) {
			if (arg1) {
				Acquire(T00f, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T00f, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T00f, 1), Local0)
			} else {
				Store(Acquire(T00f, 0xffff), Local0)
			}
		}
		Case (16) {
			if (arg1) {
				Acquire(T010, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T010, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T010, 1), Local0)
			} else {
				Store(Acquire(T010, 0xffff), Local0)
			}
		}
		Case (17) {
			if (arg1) {
				Acquire(T011, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T011, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T011, 1), Local0)
			} else {
				Store(Acquire(T011, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 1
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma01, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(T100, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T100, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T100, 1), Local0)
			} else {
				Store(Acquire(T100, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(T101, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T101, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T101, 1), Local0)
			} else {
				Store(Acquire(T101, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(T102, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T102, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T102, 1), Local0)
			} else {
				Store(Acquire(T102, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(T103, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T103, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T103, 1), Local0)
			} else {
				Store(Acquire(T103, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 2
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma02, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(T200, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T200, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T200, 1), Local0)
			} else {
				Store(Acquire(T200, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(T201, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T201, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T201, 1), Local0)
			} else {
				Store(Acquire(T201, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(T202, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T202, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T202, 1), Local0)
			} else {
				Store(Acquire(T202, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(T203, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T203, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T203, 1), Local0)
			} else {
				Store(Acquire(T203, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 3
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma03, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(T300, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T300, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T300, 1), Local0)
			} else {
				Store(Acquire(T300, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(T301, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T301, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T301, 1), Local0)
			} else {
				Store(Acquire(T301, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(T302, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T302, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T302, 1), Local0)
			} else {
				Store(Acquire(T302, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(T303, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T303, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T303, 1), Local0)
			} else {
				Store(Acquire(T303, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 4
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma04, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(T400, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T400, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T400, 1), Local0)
			} else {
				Store(Acquire(T400, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(T401, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T401, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T401, 1), Local0)
			} else {
				Store(Acquire(T401, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(T402, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T402, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T402, 1), Local0)
			} else {
				Store(Acquire(T402, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(T403, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T403, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T403, 1), Local0)
			} else {
				Store(Acquire(T403, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 5
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma05, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(T500, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T500, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T500, 1), Local0)
			} else {
				Store(Acquire(T500, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(T501, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T501, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T501, 1), Local0)
			} else {
				Store(Acquire(T501, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(T502, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T502, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T502, 1), Local0)
			} else {
				Store(Acquire(T502, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(T503, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T503, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T503, 1), Local0)
			} else {
				Store(Acquire(T503, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 6
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma06, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(T600, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T600, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T600, 1), Local0)
			} else {
				Store(Acquire(T600, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(T601, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T601, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T601, 1), Local0)
			} else {
				Store(Acquire(T601, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(T602, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T602, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T602, 1), Local0)
			} else {
				Store(Acquire(T602, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(T603, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T603, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T603, 1), Local0)
			} else {
				Store(Acquire(T603, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 7
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma07, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(T700, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T700, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T700, 1), Local0)
			} else {
				Store(Acquire(T700, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(T701, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T701, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T701, 1), Local0)
			} else {
				Store(Acquire(T701, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(T702, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T702, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T702, 1), Local0)
			} else {
				Store(Acquire(T702, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(T703, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T703, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T703, 1), Local0)
			} else {
				Store(Acquire(T703, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 8
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma08, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(T800, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T800, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T800, 1), Local0)
			} else {
				Store(Acquire(T800, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(T801, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T801, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T801, 1), Local0)
			} else {
				Store(Acquire(T801, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(T802, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T802, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T802, 1), Local0)
			} else {
				Store(Acquire(T802, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(T803, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T803, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T803, 1), Local0)
			} else {
				Store(Acquire(T803, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 9
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma09, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(T900, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T900, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T900, 1), Local0)
			} else {
				Store(Acquire(T900, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(T901, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T901, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T901, 1), Local0)
			} else {
				Store(Acquire(T901, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(T902, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T902, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T902, 1), Local0)
			} else {
				Store(Acquire(T902, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(T903, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(T903, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(T903, 1), Local0)
			} else {
				Store(Acquire(T903, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 10
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma0a, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(Ta00, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Ta00, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Ta00, 1), Local0)
			} else {
				Store(Acquire(Ta00, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(Ta01, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Ta01, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Ta01, 1), Local0)
			} else {
				Store(Acquire(Ta01, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(Ta02, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Ta02, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Ta02, 1), Local0)
			} else {
				Store(Acquire(Ta02, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(Ta03, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Ta03, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Ta03, 1), Local0)
			} else {
				Store(Acquire(Ta03, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 11
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma0b, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(Tb00, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Tb00, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Tb00, 1), Local0)
			} else {
				Store(Acquire(Tb00, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(Tb01, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Tb01, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Tb01, 1), Local0)
			} else {
				Store(Acquire(Tb01, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(Tb02, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Tb02, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Tb02, 1), Local0)
			} else {
				Store(Acquire(Tb02, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(Tb03, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Tb03, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Tb03, 1), Local0)
			} else {
				Store(Acquire(Tb03, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 12
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma0c, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(Tc00, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Tc00, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Tc00, 1), Local0)
			} else {
				Store(Acquire(Tc00, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(Tc01, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Tc01, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Tc01, 1), Local0)
			} else {
				Store(Acquire(Tc01, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(Tc02, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Tc02, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Tc02, 1), Local0)
			} else {
				Store(Acquire(Tc02, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(Tc03, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Tc03, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Tc03, 1), Local0)
			} else {
				Store(Acquire(Tc03, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 13
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma0d, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(Td00, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Td00, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Td00, 1), Local0)
			} else {
				Store(Acquire(Td00, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(Td01, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Td01, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Td01, 1), Local0)
			} else {
				Store(Acquire(Td01, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(Td02, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Td02, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Td02, 1), Local0)
			} else {
				Store(Acquire(Td02, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(Td03, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Td03, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Td03, 1), Local0)
			} else {
				Store(Acquire(Td03, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 14
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma0e, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(Te00, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Te00, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Te00, 1), Local0)
			} else {
				Store(Acquire(Te00, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(Te01, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Te01, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Te01, 1), Local0)
			} else {
				Store(Acquire(Te01, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(Te02, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Te02, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Te02, 1), Local0)
			} else {
				Store(Acquire(Te02, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(Te03, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Te03, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Te03, 1), Local0)
			} else {
				Store(Acquire(Te03, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Acquire mutex of level 15
 * (Index of mux, opcode of exception to be generated or zero, opcode of TimeOutValue)
 */
Method(ma0f, 3, Serialized)
{
	Store(1, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			if (arg1) {
				Acquire(Tf00, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Tf00, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Tf00, 1), Local0)
			} else {
				Store(Acquire(Tf00, 0xffff), Local0)
			}
		}
		Case (1) {
			if (arg1) {
				Acquire(Tf01, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Tf01, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Tf01, 1), Local0)
			} else {
				Store(Acquire(Tf01, 0xffff), Local0)
			}
		}
		Case (2) {
			if (arg1) {
				Acquire(Tf02, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Tf02, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Tf02, 1), Local0)
			} else {
				Store(Acquire(Tf02, 0xffff), Local0)
			}
		}
		Case (3) {
			if (arg1) {
				Acquire(Tf03, 0xffff)
			} elseif (LEqual(arg2, TOV0)) {
				Store(Acquire(Tf03, 0), Local0)
			} elseif (LEqual(arg2, TOV1)) {
				Store(Acquire(Tf03, 1), Local0)
			} else {
				Store(Acquire(Tf03, 0xffff), Local0)
			}
		}
	}
	return (Local0)
}

/*
 * Release mutex of level 0
 *
 * arg0 - Index of mutex
 */
Method(ma10, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(T000)
		}
		Case (1) {
			if (GL00) {
				Release(\_GL)
			} else {
				Release(T001)
			}
		}
		Case (2) {
			Release(T002)
		}
		Case (3) {
			Release(T003)
		}
		Case (4) {
			Release(T004)
		}
		Case (5) {
			Release(T005)
		}
		Case (6) {
			Release(T006)
		}
		Case (7) {
			Release(T007)
		}
		Case (8) {
			Release(T008)
		}
		Case (9) {
			Release(T009)
		}
		Case (10) {
			Release(T00a)
		}
		Case (11) {
			Release(T00b)
		}
		Case (12) {
			Release(T00c)
		}
		Case (13) {
			Release(T00d)
		}
		Case (14) {
			Release(T00e)
		}
		Case (15) {
			Release(T00f)
		}
		Case (16) {
			Release(T010)
		}
		Case (17) {
			Release(T011)
		}
	}
}

/*
 * Release mutex of level 1 (Index of mux)
 */
Method(ma11, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(T100)
		}
		Case (1) {
			Release(T101)
		}
		Case (2) {
			Release(T102)
		}
		Case (3) {
			Release(T103)
		}
	}
}

/*
 * Release mutex of level 2 (Index of mux)
 */
Method(ma12, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(T200)
		}
		Case (1) {
			Release(T201)
		}
		Case (2) {
			Release(T202)
		}
		Case (3) {
			Release(T203)
		}
	}
}

/*
 * Release mutex of level 3 (Index of mux)
 */
Method(ma13, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(T300)
		}
		Case (1) {
			Release(T301)
		}
		Case (2) {
			Release(T302)
		}
		Case (3) {
			Release(T303)
		}
	}
}

/*
 * Release mutex of level 4 (Index of mux)
 */
Method(ma14, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(T400)
		}
		Case (1) {
			Release(T401)
		}
		Case (2) {
			Release(T402)
		}
		Case (3) {
			Release(T403)
		}
	}
}

/*
 * Release mutex of level 5 (Index of mux)
 */
Method(ma15, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(T500)
		}
		Case (1) {
			Release(T501)
		}
		Case (2) {
			Release(T502)
		}
		Case (3) {
			Release(T503)
		}
	}
}

/*
 * Release mutex of level 6 (Index of mux)
 */
Method(ma16, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(T600)
		}
		Case (1) {
			Release(T601)
		}
		Case (2) {
			Release(T602)
		}
		Case (3) {
			Release(T603)
		}
	}
}

/*
 * Release mutex of level 7 (Index of mux)
 */
Method(ma17, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(T700)
		}
		Case (1) {
			Release(T701)
		}
		Case (2) {
			Release(T702)
		}
		Case (3) {
			Release(T703)
		}
	}
}

/*
 * Release mutex of level 8 (Index of mux)
 */
Method(ma18, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(T800)
		}
		Case (1) {
			Release(T801)
		}
		Case (2) {
			Release(T802)
		}
		Case (3) {
			Release(T803)
		}
	}
}

/*
 * Release mutex of level 9 (Index of mux)
 */
Method(ma19, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(T900)
		}
		Case (1) {
			Release(T901)
		}
		Case (2) {
			Release(T902)
		}
		Case (3) {
			Release(T903)
		}
	}
}

/*
 * Release mutex of level 10 (Index of mux)
 */
Method(ma1a, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(Ta00)
		}
		Case (1) {
			Release(Ta01)
		}
		Case (2) {
			Release(Ta02)
		}
		Case (3) {
			Release(Ta03)
		}
	}
}

/*
 * Release mutex of level 11 (Index of mux)
 */
Method(ma1b, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(Tb00)
		}
		Case (1) {
			Release(Tb01)
		}
		Case (2) {
			Release(Tb02)
		}
		Case (3) {
			Release(Tb03)
		}
	}
}

/*
 * Release mutex of level 12 (Index of mux)
 */
Method(ma1c, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(Tc00)
		}
		Case (1) {
			Release(Tc01)
		}
		Case (2) {
			Release(Tc02)
		}
		Case (3) {
			Release(Tc03)
		}
	}
}

/*
 * Release mutex of level 13 (Index of mux)
 */
Method(ma1d, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(Td00)
		}
		Case (1) {
			Release(Td01)
		}
		Case (2) {
			Release(Td02)
		}
		Case (3) {
			Release(Td03)
		}
	}
}

/*
 * Release mutex of level 14 (Index of mux)
 */
Method(ma1e, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(Te00)
		}
		Case (1) {
			Release(Te01)
		}
		Case (2) {
			Release(Te02)
		}
		Case (3) {
			Release(Te03)
		}
	}
}

/*
 * Release mutex of level 15 (Index of mux)
 */
Method(ma1f, 1, Serialized)
{
	Switch (ToInteger (arg0)) {
		Case (0) {
			Release(Tf00)
		}
		Case (1) {
			Release(Tf01)
		}
		Case (2) {
			Release(Tf02)
		}
		Case (3) {
			Release(Tf03)
		}
	}
}

/*
 * Get name of mutex
 *
 * arg0 - string
 * arg1 - Level of mutex
 * arg2 - Index of mutex
 */
Method(m21e, 3)
{
	Concatenate(arg0, "Level ", Local0)
	Concatenate(Local0, arg1, Local1)
	Concatenate(Local1, ", Index ", Local0)
	Concatenate(Local0, arg2, Local1)

	if (LEqual(arg1, GLLL)) {
		if (LEqual(arg2, GLIX)) {
			if (GL00) {
				Concatenate(Local1, " (Global lock)", Local1)
			}
		}
	}

	return (Local1)
}


