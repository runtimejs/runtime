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
 * Auxiliary routines to access mutexes
 */

Name(z151, 151)

/*
 * For debugging:
 *
 * FL02 - print out Acquire/Release
 * im00 - imitation of Acquire/Release (don't really run Acquire/Release)
 */
Name(FL02, 0)
Name(im00, 0)

/*
 * Acquire interval of mutexes
 *
 * arg0 - number of mutexes to Acquire (use not less than 1)
 */
Method(m36d, 1, Serialized)
{
    Name(ts, "m36d")

    if (LEqual(arg0, 0)) {
        return
    }
    Store(Acquire(T000, 0xffff), Local0)
    if (Local0) {
        err(ts, z151, 1, 0, 0, 0, Local0)
    } else {
        if (LEqual(arg0, 1)) {
            return
        }
    Store(Acquire(\_GL, 0xffff), Local0)
    if (Local0) {
        err(ts, z151, 2, 0, 0, 0, Local0)
    } else {
        if (LEqual(arg0, 2)) {
            return
        }
        Store(Acquire(T100, 0xffff), Local0)
        if (Local0) {
            err(ts, z151, 3, 0, 0, 0, Local0)
        } else {
            if (LEqual(arg0, 3)) {
                return
            }
            Store(Acquire(T200, 0xffff), Local0)
            if (Local0) {
                err(ts, z151, 4, 0, 0, 0, Local0)
            } else {
                if (LEqual(arg0, 4)) {
                    return
                }
                Store(Acquire(T300, 0xffff), Local0)
                if (Local0) {
                    err(ts, z151, 5, 0, 0, 0, Local0)
                } else {
                    if (LEqual(arg0, 5)) {
                        return
                    }
                    Store(Acquire(T400, 0xffff), Local0)
                    if (Local0) {
                        err(ts, z151, 6, 0, 0, 0, Local0)
                    } else {
                        if (LEqual(arg0, 6)) {
                            return
                        }
                        Store(Acquire(T500, 0xffff), Local0)
                        if (Local0) {
                            err(ts, z151, 7, 0, 0, 0, Local0)
                        } else {
                            if (LEqual(arg0, 7)) {
                                return
                            }
                            Store(Acquire(T600, 0xffff), Local0)
                            if (Local0) {
                                err(ts, z151, 8, 0, 0, 0, Local0)
                            } else {
                                if (LEqual(arg0, 8)) {
                                    return
                                }
                                Store(Acquire(T700, 0xffff), Local0)
                                if (Local0) {
                                    err(ts, z151, 9, 0, 0, 0, Local0)
                                } else {
                                    if (LEqual(arg0, 9)) {
                                        return
                                    }
                                    Store(Acquire(T800, 0xffff), Local0)
                                    if (Local0) {
                                        err(ts, z151, 0x00a, 0, 0, 0, Local0)
                                    } else {
                                        if (LEqual(arg0, 10)) {
                                            return
                                        }
                                        Store(Acquire(T900, 0xffff), Local0)
                                        if (Local0) {
                                            err(ts, z151, 0x00b, 0, 0, 0, Local0)
                                        } else {
                                            if (LEqual(arg0, 11)) {
                                                return
                                            }
                                            Store(Acquire(Ta00, 0xffff), Local0)
                                            if (Local0) {
                                                err(ts, z151, 0x00c, 0, 0, 0, Local0)
                                            } else {
                                                if (LEqual(arg0, 12)) {
                                                    return
                                                }
                                                Store(Acquire(Tb00, 0xffff), Local0)
                                                if (Local0) {
                                                    err(ts, z151, 0x00d, 0, 0, 0, Local0)
                                                } else {
                                                    if (LEqual(arg0, 13)) {
                                                        return
                                                    }
                                                    Store(Acquire(Tc00, 0xffff), Local0)
                                                    if (Local0) {
                                                        err(ts, z151, 0x00e, 0, 0, 0, Local0)
                                                    } else {
                                                        if (LEqual(arg0, 14)) {
                                                            return
                                                        }
                                                        Store(Acquire(Td00, 0xffff), Local0)
                                                        if (Local0) {
                                                            err(ts, z151, 0x00f, 0, 0, 0, Local0)
                                                        } else {
                                                            if (LEqual(arg0, 15)) {
                                                                return
                                                            }
                                                            Store(Acquire(Te00, 0xffff), Local0)
                                                            if (Local0) {
                                                                err(ts, z151, 0x010, 0, 0, 0, Local0)
                                                            } else {
                                                                if (LEqual(arg0, 16)) {
                                                                    return
                                                                }
                                                                Store(Acquire(Tf00, 0xffff), Local0)
                                                                if (Local0) {
                                                                    err(ts, z151, 0x011, 0, 0, 0, Local0)
                                                                } else {
                                                                    if (LEqual(arg0, 17)) {
                                                                        return
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    }
}

/*
 * Release interval of mutexes
 *
 * arg0 - number of mutexes to Release (use not less than 1)
 */
Method(m36e, 1)
{
		if (LGreaterEqual(arg0, 17)) {
			Release(Tf00)
		}
		if (LGreaterEqual(arg0, 16)) {
			Release(Te00)
		}
		if (LGreaterEqual(arg0, 15)) {
			Release(Td00)
		}
		if (LGreaterEqual(arg0, 14)) {
			Release(Tc00)
		}
		if (LGreaterEqual(arg0, 13)) {
			Release(Tb00)
		}
		if (LGreaterEqual(arg0, 12)) {
			Release(Ta00)
		}
		if (LGreaterEqual(arg0, 11)) {
			Release(T900)
		}
		if (LGreaterEqual(arg0, 10)) {
			Release(T800)
		}
		if (LGreaterEqual(arg0, 9)) {
			Release(T700)
		}
		if (LGreaterEqual(arg0, 8)) {
			Release(T600)
		}
		if (LGreaterEqual(arg0, 7)) {
			Release(T500)
		}
		if (LGreaterEqual(arg0, 6)) {
			Release(T400)
		}
		if (LGreaterEqual(arg0, 5)) {
			Release(T300)
		}
		if (LGreaterEqual(arg0, 4)) {
			Release(T200)
		}
		if (LGreaterEqual(arg0, 3)) {
			Release(T100)
		}
		if (LGreaterEqual(arg0, 2)) {
			Release(\_GL)
		}
		if (LGreaterEqual(arg0, 1)) {
			Release(T000)
		}
}

/*
 * Acquire mutex
 *
 * arg0 - Level of mutex
 * arg1 - Index of mutex
 * arg2 - opcode of exception to be generated or zero
 * arg3 - opcode of TimeOutValue (see comment to ma00)
 */
Method(m36f, 4, Serialized)
{
	Store(1, Local0) // Init with FAIL

	if (FL02) {
		Store(m21e("Acquire mutex, ", arg0, arg1), Local1)

		if (im00) {
			Concatenate("IMITATION: ", Local1, Local1)
		}

		if (arg2) {
			Concatenate(Local1, ", Exception expected", Local1)
		} else {
			Switch (ToInteger (arg3)) {
				Case (5) { // TOV0
					Concatenate(Local1, ", tout 0", Local1)
				}
				Case (6) { // TOV1
					Concatenate(Local1, ", tout 1", Local1)
				}
				Default {
					Concatenate(Local1, ", tout 0xffff", Local1)
				}
			}
		}
		Store(Local1, Debug)
	}

	if (im00) {
		/* Just imitation */
		return (0)
	}

	Switch (ToInteger (arg0)) {
		Case (0) {
			Store(ma00(arg1, arg2, arg3), Local0)
		}
		Case (1) {
			Store(ma01(arg1, arg2, arg3), Local0)
		}
		Case (2) {
			Store(ma02(arg1, arg2, arg3), Local0)
		}
		Case (3) {
			Store(ma03(arg1, arg2, arg3), Local0)
		}
		Case (4) {
			Store(ma04(arg1, arg2, arg3), Local0)
		}
		Case (5) {
			Store(ma05(arg1, arg2, arg3), Local0)
		}
		Case (6) {
			Store(ma06(arg1, arg2, arg3), Local0)
		}
		Case (7) {
			Store(ma07(arg1, arg2, arg3), Local0)
		}
		Case (8) {
			Store(ma08(arg1, arg2, arg3), Local0)
		}
		Case (9) {
			Store(ma09(arg1, arg2, arg3), Local0)
		}
		Case (10) {
			Store(ma0a(arg1, arg2, arg3), Local0)
		}
		Case (11) {
			Store(ma0b(arg1, arg2, arg3), Local0)
		}
		Case (12) {
			Store(ma0c(arg1, arg2, arg3), Local0)
		}
		Case (13) {
			Store(ma0d(arg1, arg2, arg3), Local0)
		}
		Case (14) {
			Store(ma0e(arg1, arg2, arg3), Local0)
		}
		Case (15) {
			Store(ma0f(arg1, arg2, arg3), Local0)
		}
	}

	if (LNot(arg2)) {
		if (Local0) {
			err("m36f", z151, 0x002, 0, 0, Local0, 0)
		}
	}

	return (Local0)
}

/*
 * Release mutex
 *
 * arg0 - Level of mutex
 * arg1 - Index of mutex
 * arg2 - opcode of exception to be generated or zero
 */
Method(m388, 3, Serialized)
{
	if (FL02) {
		Store(m21e("Release mutex, ", arg0, arg1), Local1)

		if (im00) {
			Concatenate("IMITATION: ", Local1, Local1)
		}

		if (arg2) {
			Concatenate(Local1, ", Exception expected", Local1)
		}
		Store(Local1, Debug)
	}

	if (im00) {
		/* Just imitation */
		return
	}

	Switch (ToInteger (arg0)) {
		Case (0) {
			ma10(arg1)
		}
		Case (1) {
			ma11(arg1)
		}
		Case (2) {
			ma12(arg1)
		}
		Case (3) {
			ma13(arg1)
		}
		Case (4) {
			ma14(arg1)
		}
		Case (5) {
			ma15(arg1)
		}
		Case (6) {
			ma16(arg1)
		}
		Case (7) {
			ma17(arg1)
		}
		Case (8) {
			ma18(arg1)
		}
		Case (9) {
			ma19(arg1)
		}
		Case (10) {
			ma1a(arg1)
		}
		Case (11) {
			ma1b(arg1)
		}
		Case (12) {
			ma1c(arg1)
		}
		Case (13) {
			ma1d(arg1)
		}
		Case (14) {
			ma1e(arg1)
		}
		Case (15) {
			ma1f(arg1)
		}
	}
}

/*
 * Acquire the range of mutexes from lower to upper levels (index 0)
 * arg0 - start level of mutex
 * arg1 - number of levels
 * arg2 - if non-zero - Axquire GL too
 * arg3 - non-zero means that we generate exceptional
 *        condition on each Acquire. The non-zero value
 *        means the opcode of exception.
 */
Method(m38b, 4, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	if (arg2) {
		if (arg3) {
			CH03("m38b", z151, 0x000, 0, 0)
		}
		m36f(GLLL, GLIX, arg3, 0) // Acquire GL
		if (arg3) {
			CH04("m38b", 0, arg3, z151, 0x001, 0, 0)
		}
	}

	Store(arg1, lpN0)
	Store(arg0, lpC0)
	While (lpN0) {

		if (arg3) {
			CH03("m38b", z151, 0x000, 0, 0)
		}
		m36f(lpC0, 0, arg3, 0) // Acquire
		if (arg3) {
			CH04("m38b", 0, arg3, z151, 0x001, 0, 0)
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Release the range of mutexes from upper to lower levels (index 0)
 * arg0 - start level of mutex
 * arg1 - number of levels
 * arg2 - if non-zero - Release GL too
 * arg3 - non-zero means that we generate exceptional
 *        condition on each Acquire. The non-zero value
 *        means the opcode of exception.
 */
Method(m38c, 4, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(0, Local7)

	Store(arg1, lpN0)
	Store(arg0, lpC0)
	While (lpN0) {

		if (arg3) {
			Store(LOr(CH03("m38b", z151, 0x000, 0, 0), Local7), Local7)
		}
		m388(lpC0, 0, 0) // Release
		if (arg3) {
			Store(LOr(CH04("m38b", 0, arg3, z151, 0x001, 0, 0), Local7), Local7)
		}

		Decrement(lpN0)
		Decrement(lpC0)
	}

	if (arg2) {
		if (arg3) {
			Store(LOr(CH03("m38b", z151, 0x000, 0, 0), Local7), Local7)
		}
		m388(GLLL, GLIX, 0) // Release GL
		if (arg3) {
			Store(LOr(CH04("m38b", 0, arg3, z151, 0x001, 0, 0), Local7), Local7)
		}
	}

	return (Local7)
}

/*
 * Acquire the range of mutexes
 *
 * arg0 - start level of mutex
 * arg1 - number of levels
 * arg2 - start index of mutex on level
 * arg3 - number of mutexes on the same level
 * arg4 - opcode of exception to be generated or zero
 * arg5 - repetition number
 * arg6 - opcode of TimeOutValue (see comment to ma00)
 */
Method(m088, 7, Serialized)
{
	Name(lpN0, 0) // level
	Name(lpC0, 0)
	Name(lpN1, 0) // index
	Name(lpC1, 0)
	Name(lpN2, 0) // repetition
	Name(lpC2, 0)
	Name(rpt0, 1)

	Name(exc0, 0) // exception is expected - opcode to pass to (m36f & CH04)
	Name(exc1, 0) // exception is expected - run (CH03 & CH04)

	Store(arg4, exc0)
	if (im00) {
		Store(0, exc1)
	} elseif (arg4) {
		Store(arg4, exc1)
	}

	if (arg5) {
		Store(arg5, rpt0)
	}

	Store(arg1, lpN0)
	Store(arg0, lpC0)
	While (lpN0) {
		Store(arg3, lpN1)
		Store(arg2, lpC1)
		While (lpN1) {
			Store(rpt0, lpN2)
			Store(0, lpC2)
			While (lpN2) {
				if (exc1) {
					CH03("m088", z151, 0x000, 0, 0)
				}
				m36f(lpC0, lpC1, exc0, arg6) // Acquire
				if (exc1) {
					CH04("m088", 0, exc0, z151, 0x001, 0, 0)
				}
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
 * Release the range of mutexes
 *
 * arg0 - start level of mutex
 * arg1 - number of levels
 * arg2 - start index of mutex on level
 * arg3 - number of mutexes on the same level
 * arg4 - opcode of exception to be generated or zero
 * arg5 - repetition number
 *
 * arg6 - order of Releasing bitmap,
 *        determinates the order of Releasing mutexes of the same level:
 *           [0] - 0 - derect order
 *                 1 - inverse order
 *           [1] - 0 - don't replace the last index
 *                 1 - replace the last index
 *        [15:8] - the index of mutex to be the last in case of non-zero [1]
 *
 * Note: the bit [1] technique was added while investigating the anomaly
 *       reflected by bug 242 "Releasing the mutex the first Acquired on
 *       the non-zero level makes Releasing the residuary mutexes of that
 *       level impossible".
 *
 * Examples:
 *
 * Acquired on the same level are mutexes of 0,1,2,3 indexes
 * Releasing for arg6 equal to:
 * 0x00 - 0123 (direct - the same order the mutexes were Acquired)
 *   01 - 3210 (inverse to Acquiring)
 *   22 - 0132 (direct + replace the last index, it becomes index 2)
 *   23 - 3102 (inverse + replace the last index, it becomes index 2)
 */
Method(m089, 7, Serialized)
{
	Name(lpN0, 0) // level
	Name(lpC0, 0)
	Name(lpN1, 0) // index
	Name(lpC1, 0)
	Name(lpN2, 0) // repetition
	Name(lpC2, 0)
	Name(rpt0, 1)

	Name(bg00, 0)
	Name(en00, 0)

	Name(inv0, 0) // sign of the inverse order
	Name(rpl0, 0) // to do replacing
	Name(lix0, 0) // value to be the last index

	Name(exc0, 0) // exception is expected - opcode to pass to (m36f & CH04)
	Name(exc1, 0) // exception is expected - run (CH03 & CH04)

	Store(arg4, exc0)
	if (im00) {
		Store(0, exc1)
	} elseif (arg4) {
		Store(arg4, exc1)
	}

	if (arg5) {
		Store(arg5, rpt0)
	}

	And(arg6, 0x01, inv0)
	And(arg6, 0x02, rpl0)
	And(arg6, 0xff00, lix0)
	ShiftRight(lix0, 8, lix0)

	Store(arg2, bg00)
	Add(arg2, arg3, en00)
	Decrement(en00)

	/* Inverse order of levels */

	Store(arg1, lpN0)
	Add(arg0, arg1, lpC0)
	Decrement(lpC0)
	While (lpN0) {

		if (inv0) {

			/* inverse order */

			Store(arg3, lpN1)
			Add(arg2, arg3, lpC1)
			Decrement(lpC1)
			While (lpN1) {

				Store(lpC1, Local0)
				if (rpl0) {
					if (LEqual(lpN1, 1)) {
						Store(lix0, Local0)
					} elseif (LLessEqual(lpC1, lix0)) {
						Subtract(lpC1, 1, Local0)
					}
				}

				Store(rpt0, lpN2)
				Store(0, lpC2)
				While (lpN2) {

					if (exc1) {
						CH03("m088", z151, 0x000, 0, 0)
					}
					m388(lpC0, Local0, exc0) // Release
					if (exc1) {
						CH04("m088", 0, exc0, z151, 0x001, 0, 0)
					}

					Decrement(lpN2)
					Increment(lpC2)
				}

				Decrement(lpN1)
				Decrement(lpC1)
			}
		} else {

			/* direct order */

			Store(arg3, lpN1)
			Store(arg2, lpC1)
			While (lpN1) {

				Store(lpC1, Local0)
				if (rpl0) {
					if (LEqual(lpN1, 1)) {
						Store(lix0, Local0)
					} elseif (LGreaterEqual(lpC1, lix0)) {
						Add(lpC1, 1, Local0)
					}
				}

				Store(rpt0, lpN2)
				Store(0, lpC2)
				While (lpN2) {

					if (exc1) {
						CH03("m088", z151, 0x000, 0, 0)
					}
					m388(lpC0, Local0, exc0) // Release
					if (exc1) {
						CH04("m088", 0, exc0, z151, 0x001, 0, 0)
					}

					Decrement(lpN2)
					Increment(lpC2)
				}

				Decrement(lpN1)
				Increment(lpC1)
			}
		}

		Decrement(lpN0)
		Decrement(lpC0)
	}
}

/*
 * Check that all mutexes are Released (don't check T804..)
 */
Method(m08a)
{
	m089(0, max0, 0, min0, 65, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
}

