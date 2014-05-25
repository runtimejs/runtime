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
 * Bug 297:
 *
 * SUMMARY: After AE_LIMIT the further work of ACPICA mutex framework looks unstable
 */

/*
 * It is m369 od Synchronization test
 */
Method(m1e4, 1, Serialized)
{
    CH03("", 0, 0x000, 0, 0)

    Mutex(MT00, 0)
    Mutex(MT10, 1)
    Mutex(MT20, 2)
    Mutex(MT30, 3)
    Mutex(MT40, 4)
    Mutex(MT50, 5)
    Mutex(MT60, 6)
    Mutex(MT70, 7)
    Mutex(MT80, 8)
    Mutex(MT90, 9)
    Mutex(MTa0, 10)
    Mutex(MTb0, 11)
    Mutex(MTc0, 12)
    Mutex(MTd0, 13)
    Mutex(MTe0, 14)
    Mutex(MTf0, 15)

    Mutex(MT01, 0)
    Mutex(MT11, 1)
    Mutex(MT21, 2)
    Mutex(MT31, 3)
    Mutex(MT41, 4)
    Mutex(MT51, 5)
    Mutex(MT61, 6)
    Mutex(MT71, 7)
    Mutex(MT81, 8)
    Mutex(MT91, 9)
    Mutex(MTa1, 10)
    Mutex(MTb1, 11)
    Mutex(MTc1, 12)
    Mutex(MTd1, 13)
    Mutex(MTe1, 14)
    if (arg0) {

        // Should be enough to exceed the maximal available number of mutexes

        Mutex(M000, 10)
        Mutex(M001, 10)
        Mutex(M002, 10)
        Mutex(M003, 10)
        Mutex(M004, 10)
        Mutex(M005, 10)
        Mutex(M006, 10)
        Mutex(M007, 10)
        Mutex(M008, 10)
        Mutex(M009, 10)

        Mutex(M010, 10)
        Mutex(M011, 10)
        Mutex(M012, 10)
        Mutex(M013, 10)
        Mutex(M014, 10)
        Mutex(M015, 10)
        Mutex(M016, 10)
        Mutex(M017, 10)
        Mutex(M018, 10)
        Mutex(M019, 10)

        Mutex(M020, 10)
        Mutex(M021, 10)
        Mutex(M022, 10)
        Mutex(M023, 10)
        Mutex(M024, 10)
        Mutex(M025, 10)
        Mutex(M026, 10)
        Mutex(M027, 10)
        Mutex(M028, 10)
        Mutex(M029, 10)

        Mutex(M030, 10)
        Mutex(M031, 10)
        Mutex(M032, 10)
        Mutex(M033, 10)
        Mutex(M034, 10)
        Mutex(M035, 10)
        Mutex(M036, 10)
        Mutex(M037, 10)
        Mutex(M038, 10)
        Mutex(M039, 10)


        Mutex(MTb2, 11)
        Mutex(MTb3, 11)
        Mutex(MTb4, 11)
        Mutex(MTb5, 11)
        Mutex(MTb6, 11)
        Mutex(MTb7, 11)
        Mutex(MTb8, 11)
        Mutex(MTb9, 11)
        Mutex(MTba, 11)
        Mutex(MTbb, 11)
        Mutex(MTbc, 11)
        Mutex(MTbd, 11)
        Mutex(MTbe, 11)
        Mutex(MTbf, 11)

        Mutex(MTc2, 12)
        Mutex(MTc3, 12)
        Mutex(MTc4, 12)
        Mutex(MTc5, 12)
        Mutex(MTc6, 12)
        Mutex(MTc7, 12)
        Mutex(MTc8, 12)
        Mutex(MTc9, 12)
        Mutex(MTca, 12)
        Mutex(MTcb, 12)
        Mutex(MTcc, 12)
        Mutex(MTcd, 12)
        Mutex(MTce, 12)
        Mutex(MTcf, 12)

        Mutex(MTd2, 13)
        Mutex(MTd3, 13)
        Mutex(MTd4, 13)
        Mutex(MTd5, 13)
        Mutex(MTd6, 13)
        Mutex(MTd7, 13)
        Mutex(MTd8, 13)
        Mutex(MTd9, 13)
        Mutex(MTda, 13)
        Mutex(MTdb, 13)
        Mutex(MTdc, 13)
        Mutex(MTdd, 13)
        Mutex(MTde, 13)
        Mutex(MTdf, 13)

        Mutex(MTe2, 14)
        Mutex(MTe3, 14)
        Mutex(MTe4, 14)
        Mutex(MTe5, 14)
        Mutex(MTe6, 14)
        Mutex(MTe7, 14)
        Mutex(MTe8, 14)
        Mutex(MTe9, 14)
        Mutex(MTea, 14)
        Mutex(MTeb, 14)
        Mutex(MTec, 14)
        Mutex(MTed, 14)
        Mutex(MTee, 14)
        Mutex(MTef, 14)

        Mutex(MTf1, 15)
        Mutex(MTf2, 15)
        Mutex(MTf3, 15)
        Mutex(MTf4, 15)
        Mutex(MTf5, 15)
        Mutex(MTf6, 15)
        Mutex(MTf7, 15)
        Mutex(MTf8, 15)
        Mutex(MTf9, 15)
        Mutex(MTfa, 15)
        Mutex(MTfb, 15)
        Mutex(MTfc, 15)
        Mutex(MTfd, 15)
        Mutex(MTfe, 15)
        Mutex(MTff, 15)
    }

    Store(Acquire(MT00, 0xffff), Local0)
    if (Local0) {
        err("", zFFF, 1, 0, 0, 0, Local0)
    } else {
    Store(Acquire(MT01, 0xffff), Local0) /* the same level */
    if (Local0) {
        err("", zFFF, 2, 0, 0, 0, Local0)
    } else {
    Store(Acquire(\_GL, 0xffff), Local0) /* GL */
    if (Local0) {
        err("", zFFF, 3, 0, 0, 0, Local0)
    } else {
        Store(Acquire(MT10, 0xffff), Local0)
        if (Local0) {
            err("", zFFF, 4, 0, 0, 0, Local0)
        } else {
        Store(Acquire(MT11, 0xffff), Local0)
        if (Local0) {
            err("", zFFF, 5, 0, 0, 0, Local0)
        } else {
            Store(Acquire(MT20, 0xffff), Local0)
            if (Local0) {
                err("", zFFF, 6, 0, 0, 0, Local0)
            } else {
            Store(Acquire(MT21, 0xffff), Local0)
            if (Local0) {
                err("", zFFF, 7, 0, 0, 0, Local0)
            } else {
                Store(Acquire(MT30, 0xffff), Local0)
                if (Local0) {
                    err("", zFFF, 8, 0, 0, 0, Local0)
                } else {
                Store(Acquire(MT31, 0xffff), Local0)
                if (Local0) {
                    err("", zFFF, 9, 0, 0, 0, Local0)
                } else {
                    Store(Acquire(MT40, 0xffff), Local0)
                    if (Local0) {
                        err("", zFFF, 0x00a, 0, 0, 0, Local0)
                    } else {
                    Store(Acquire(MT41, 0xffff), Local0)
                    if (Local0) {
                        err("", zFFF, 0x00b, 0, 0, 0, Local0)
                    } else {
                        Store(Acquire(MT50, 0xffff), Local0)
                        if (Local0) {
                            err("", zFFF, 0x00c, 0, 0, 0, Local0)
                        } else {
                        Store(Acquire(MT51, 0xffff), Local0)
                        if (Local0) {
                            err("", zFFF, 0x00d, 0, 0, 0, Local0)
                        } else {
                            Store(Acquire(MT60, 0xffff), Local0)
                            if (Local0) {
                                err("", zFFF, 0x00e, 0, 0, 0, Local0)
                            } else {
                            Store(Acquire(MT61, 0xffff), Local0)
                            if (Local0) {
                                err("", zFFF, 0x00f, 0, 0, 0, Local0)
                            } else {
                                Store(Acquire(MT70, 0xffff), Local0)
                                if (Local0) {
                                    err("", zFFF, 0x010, 0, 0, 0, Local0)
                                } else {
                                Store(Acquire(MT71, 0xffff), Local0)
                                if (Local0) {
                                    err("", zFFF, 0x011, 0, 0, 0, Local0)
                                } else {
                                    Store(Acquire(MT80, 0xffff), Local0)
                                    if (Local0) {
                                        err("", zFFF, 0x012, 0, 0, 0, Local0)
                                    } else {
                                    Store(Acquire(MT81, 0xffff), Local0)
                                    if (Local0) {
                                        err("", zFFF, 0x013, 0, 0, 0, Local0)
                                    } else {
                                        Store(Acquire(MT90, 0xffff), Local0)
                                        if (Local0) {
                                            err("", zFFF, 0x014, 0, 0, 0, Local0)
                                        } else {
                                        Store(Acquire(MT91, 0xffff), Local0)
                                        if (Local0) {
                                            err("", zFFF, 0x015, 0, 0, 0, Local0)
                                        } else {
                                            Store(Acquire(MTa0, 0xffff), Local0)
                                            if (Local0) {
                                                err("", zFFF, 0x016, 0, 0, 0, Local0)
                                            } else {
                                            Store(Acquire(MTa1, 0xffff), Local0)
                                            if (Local0) {
                                                err("", zFFF, 0x017, 0, 0, 0, Local0)
                                            } else {
                                                Store(Acquire(MTb0, 0xffff), Local0)
                                                if (Local0) {
                                                    err("", zFFF, 0x018, 0, 0, 0, Local0)
                                                } else {
                                                Store(Acquire(MTb1, 0xffff), Local0)
                                                if (Local0) {
                                                    err("", zFFF, 0x019, 0, 0, 0, Local0)
                                                } else {
                                                    Store(Acquire(MTc0, 0xffff), Local0)
                                                    if (Local0) {
                                                        err("", zFFF, 0x01a, 0, 0, 0, Local0)
                                                    } else {
                                                    Store(Acquire(MTc1, 0xffff), Local0)
                                                    if (Local0) {
                                                        err("", zFFF, 0x01b, 0, 0, 0, Local0)
                                                    } else {
                                                        Store(Acquire(MTd0, 0xffff), Local0)
                                                        if (Local0) {
                                                            err("", zFFF, 0x01c, 0, 0, 0, Local0)
                                                        } else {
                                                        Store(Acquire(MTd1, 0xffff), Local0)
                                                        if (Local0) {
                                                            err("", zFFF, 0x01d, 0, 0, 0, Local0)
                                                        } else {
                                                            Store(Acquire(MTe0, 0xffff), Local0)
                                                            if (Local0) {
                                                                err("", zFFF, 0x01e, 0, 0, 0, Local0)
                                                            } else {
                                                            Store(Acquire(MTe1, 0xffff), Local0)
                                                            if (Local0) {
                                                                err("", zFFF, 0x01f, 0, 0, 0, Local0)
                                                            } else {
                                                                Store(Acquire(MTf0, 0xffff), Local0)
                                                                if (Local0) {
                                                                    err("", zFFF, 0x020, 0, 0, 0, Local0)
                                                                } else {
                                                                if (arg0) {
                                                                    Store(Acquire(MTf1, 0xffff), Local0)
                                                                } else {
                                                                    Store(0, Local0)
                                                                }
                                                                if (Local0) {
                                                                    err("", zFFF, 0x021, 0, 0, 0, Local0)
                                                                } else {
                                                                    if (arg0) {
                                                                        Release(MTF1)
                                                                    }
                                                                    Release(MTF0)
                                                                    Release(MTE1)
                                                                    Release(MTE0)
                                                                    Release(MTD1)
                                                                    Release(MTD0)
                                                                    Release(MTC1)
                                                                    Release(MTC0)
                                                                    Release(MTB1)
                                                                    Release(MTB0)
                                                                    Release(MTA1)
                                                                    Release(MTA0)
                                                                    Release(MT91)
                                                                    Release(MT90)
                                                                    Release(MT81)
                                                                    Release(MT80)
                                                                    Release(MT71)
                                                                    Release(MT70)
                                                                    Release(MT61)
                                                                    Release(MT60)
                                                                    Release(MT51)
                                                                    Release(MT50)
                                                                    Release(MT41)
                                                                    Release(MT40)
                                                                    Release(MT31)
                                                                    Release(MT30)
                                                                    Release(MT21)
                                                                    Release(MT20)
                                                                    Release(MT11)
                                                                    Release(MT10)
                                                                    Release(\_GL)
                                                                    Release(MT01)
                                                                    Release(MT00)
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

    if (arg0) {
        CH04("", 1, 18, 0, 0x022, 0, 0) // AE_LIMIT
    } else {
        CH03("", 0, 0x023, 0, 0)
    }
}

Method(m1e5)
{
	/*
	 * This DECLARATION causes hang forever
	 *
	 * Event(E000)
	 */

	CH03("", 0, 0x024, 0, 0)

	/*
	 * This causes messages (but no exceptions):
	 *
	 * ACPI Error (utmutex-0421): Mutex [0] is not acquired, cannot release [20061215]
	 * ACPI Error (exutils-0250): Could not release AML Interpreter mutex [20061215]
	 * ACPI Exception (utmutex-0376): AE_BAD_PARAMETER, Thread B45 could not acquire Mutex [0] [20061215]
	 * ACPI Error (exutils-0180): Could not acquire AML Interpreter mutex [20061215]
	 */
	Sleep(100)

	CH03("", 0, 0x025, 0, 0)
}

Method(m1e6)
{
	SRMT("m1e4-1")
	m1e4(1)
	SRMT("m1e4-0")
	m1e4(0)
	SRMT("m1e5")
	m1e5()
	CH03("", 0, 0x026, 0, 0)

	/*
	 * m1e5 shows appearance of bug but doesn't cause exceptions
	 * (so it is not detected automatically), so actions are required
	 * for to see result of this bug until it is actually fixed. Then
	 * (when fixed) uncomment Event(E000) in m1e5 and remove this error
	 * report below (or try to find how to detect this situation
	 * automatically now (for not fixed yet)):
	 */
	err("", zFFF, 0x027, 0, 0, 0, 0)
}
