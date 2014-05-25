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
 * Check for exceptions on mutexes
 */

Name(z150, 150)

/*
 * Run checking that all mutexes are actually Released.
 * To be used while debugging the tests mainly.
 */
Name(FL03, 0)

/* Counter for m08e */
Name(cn00, 0)


/*
 * These declarations are used for to check the Acquire
 * and Release operations in a global level AML code.
 */
Name(i101, 0) // non-zero means that this test was run

/*
 * Valid sequence of requests, no exceptions expected.
 *
 * Acquire mutexes of monotone increasing level (Global lock
 * on level 0 too) for all available levels from 0 up to 15,
 * then Release them all in the inverse order.
 */
Method(m301,, Serialized)
{
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

    Name(ts, "m301")

    CH03(ts, z150, 0x000, 0, 0)

    Store(Acquire(MT00, 0xffff), Local0)
    if (Local0) {
        err(ts, z150, 1, 0, 0, 0, Local0)
    } else {
    Store(Acquire(\_GL, 0xffff), Local0) /* GL */
    if (Local0) {
        err(ts, z150, 3, 0, 0, 0, Local0)
    } else {
        Store(Acquire(MT10, 0xffff), Local0)
        if (Local0) {
            err(ts, z150, 2, 0, 0, 0, Local0)
        } else {
            Store(Acquire(MT20, 0xffff), Local0)
            if (Local0) {
                err(ts, z150, 3, 0, 0, 0, Local0)
            } else {
                Store(Acquire(MT30, 0xffff), Local0)
                if (Local0) {
                    err(ts, z150, 4, 0, 0, 0, Local0)
                } else {
                    Store(Acquire(MT40, 0xffff), Local0)
                    if (Local0) {
                        err(ts, z150, 5, 0, 0, 0, Local0)
                    } else {
                        Store(Acquire(MT50, 0xffff), Local0)
                        if (Local0) {
                            err(ts, z150, 6, 0, 0, 0, Local0)
                        } else {
                            Store(Acquire(MT60, 0xffff), Local0)
                            if (Local0) {
                                err(ts, z150, 7, 0, 0, 0, Local0)
                            } else {
                                Store(Acquire(MT70, 0xffff), Local0)
                                if (Local0) {
                                    err(ts, z150, 8, 0, 0, 0, Local0)
                                } else {
                                    Store(Acquire(MT80, 0xffff), Local0)
                                    if (Local0) {
                                        err(ts, z150, 9, 0, 0, 0, Local0)
                                    } else {
                                        Store(Acquire(MT90, 0xffff), Local0)
                                        if (Local0) {
                                            err(ts, z150, 0x00a, 0, 0, 0, Local0)
                                        } else {
                                            Store(Acquire(MTa0, 0xffff), Local0)
                                            if (Local0) {
                                                err(ts, z150, 0x00b, 0, 0, 0, Local0)
                                            } else {
                                                Store(Acquire(MTb0, 0xffff), Local0)
                                                if (Local0) {
                                                    err(ts, z150, 0x00c, 0, 0, 0, Local0)
                                                } else {
                                                    Store(Acquire(MTc0, 0xffff), Local0)
                                                    if (Local0) {
                                                        err(ts, z150, 0x00d, 0, 0, 0, Local0)
                                                    } else {
                                                        Store(Acquire(MTd0, 0xffff), Local0)
                                                        if (Local0) {
                                                            err(ts, z150, 0x00e, 0, 0, 0, Local0)
                                                        } else {
                                                            Store(Acquire(MTe0, 0xffff), Local0)
                                                            if (Local0) {
                                                                err(ts, z150, 0x00f, 0, 0, 0, Local0)
                                                            } else {
                                                                Store(Acquire(MTf0, 0xffff), Local0)
                                                                if (Local0) {
                                                                    err(ts, z150, 0x010, 0, 0, 0, Local0)
                                                                } else {
                                                                    Release(MTF0)
                                                                    Release(MTE0)
                                                                    Release(MTD0)
                                                                    Release(MTC0)
                                                                    Release(MTB0)
                                                                    Release(MTA0)
                                                                    Release(MT90)
                                                                    Release(MT80)
                                                                    Release(MT70)
                                                                    Release(MT60)
                                                                    Release(MT50)
                                                                    Release(MT40)
                                                                    Release(MT30)
                                                                    Release(MT20)
                                                                    Release(MT10)
                                                                    Release(\_GL)
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

    CH03(ts, z150, 0x011, 0, 0)
}

/*
 * Valid sequence of requests, no exceptions expected.
 *
 * Acquire mutexes of monotone increasing level (Global lock on level 0 too)
 * for all available levels from 0 up to 15, Acquire 2 mutexes of each level,
 * then Release them all in the inverse order (keep the exactly inverse order
 * for Releasing mutexes of the same level too).
 *
 * arg0 - if to force AE_LIMIT by exceeding the maximal number of created mutexes
 */
Method(m369, 1, Serialized)
{
    Name(ts, "m369")

    CH03(ts, z150, 0x022, 0, 0)

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
        Mutex(MTf1, 15)
        Mutex(MTf2, 15)
        Mutex(MTf3, 15)
        Mutex(MTf4, 15)
    }

    Store(Acquire(MT00, 0xffff), Local0)
    if (Local0) {
        err(ts, z150, 1, 0, 0, 0, Local0)
    } else {
    Store(Acquire(MT01, 0xffff), Local0) /* the same level */
    if (Local0) {
        err(ts, z150, 2, 0, 0, 0, Local0)
    } else {
    Store(Acquire(\_GL, 0xffff), Local0) /* GL */
    if (Local0) {
        err(ts, z150, 3, 0, 0, 0, Local0)
    } else {
        Store(Acquire(MT10, 0xffff), Local0)
        if (Local0) {
            err(ts, z150, 4, 0, 0, 0, Local0)
        } else {
        Store(Acquire(MT11, 0xffff), Local0)
        if (Local0) {
            err(ts, z150, 5, 0, 0, 0, Local0)
        } else {
            Store(Acquire(MT20, 0xffff), Local0)
            if (Local0) {
                err(ts, z150, 6, 0, 0, 0, Local0)
            } else {
            Store(Acquire(MT21, 0xffff), Local0)
            if (Local0) {
                err(ts, z150, 7, 0, 0, 0, Local0)
            } else {
                Store(Acquire(MT30, 0xffff), Local0)
                if (Local0) {
                    err(ts, z150, 8, 0, 0, 0, Local0)
                } else {
                Store(Acquire(MT31, 0xffff), Local0)
                if (Local0) {
                    err(ts, z150, 9, 0, 0, 0, Local0)
                } else {
                    Store(Acquire(MT40, 0xffff), Local0)
                    if (Local0) {
                        err(ts, z150, 0x00a, 0, 0, 0, Local0)
                    } else {
                    Store(Acquire(MT41, 0xffff), Local0)
                    if (Local0) {
                        err(ts, z150, 0x00b, 0, 0, 0, Local0)
                    } else {
                        Store(Acquire(MT50, 0xffff), Local0)
                        if (Local0) {
                            err(ts, z150, 0x00c, 0, 0, 0, Local0)
                        } else {
                        Store(Acquire(MT51, 0xffff), Local0)
                        if (Local0) {
                            err(ts, z150, 0x00d, 0, 0, 0, Local0)
                        } else {
                            Store(Acquire(MT60, 0xffff), Local0)
                            if (Local0) {
                                err(ts, z150, 0x00e, 0, 0, 0, Local0)
                            } else {
                            Store(Acquire(MT61, 0xffff), Local0)
                            if (Local0) {
                                err(ts, z150, 0x00f, 0, 0, 0, Local0)
                            } else {
                                Store(Acquire(MT70, 0xffff), Local0)
                                if (Local0) {
                                    err(ts, z150, 0x010, 0, 0, 0, Local0)
                                } else {
                                Store(Acquire(MT71, 0xffff), Local0)
                                if (Local0) {
                                    err(ts, z150, 0x011, 0, 0, 0, Local0)
                                } else {
                                    Store(Acquire(MT80, 0xffff), Local0)
                                    if (Local0) {
                                        err(ts, z150, 0x012, 0, 0, 0, Local0)
                                    } else {
                                    Store(Acquire(MT81, 0xffff), Local0)
                                    if (Local0) {
                                        err(ts, z150, 0x013, 0, 0, 0, Local0)
                                    } else {
                                        Store(Acquire(MT90, 0xffff), Local0)
                                        if (Local0) {
                                            err(ts, z150, 0x014, 0, 0, 0, Local0)
                                        } else {
                                        Store(Acquire(MT91, 0xffff), Local0)
                                        if (Local0) {
                                            err(ts, z150, 0x015, 0, 0, 0, Local0)
                                        } else {
                                            Store(Acquire(MTa0, 0xffff), Local0)
                                            if (Local0) {
                                                err(ts, z150, 0x016, 0, 0, 0, Local0)
                                            } else {
                                            Store(Acquire(MTa1, 0xffff), Local0)
                                            if (Local0) {
                                                err(ts, z150, 0x017, 0, 0, 0, Local0)
                                            } else {
                                                Store(Acquire(MTb0, 0xffff), Local0)
                                                if (Local0) {
                                                    err(ts, z150, 0x018, 0, 0, 0, Local0)
                                                } else {
                                                Store(Acquire(MTb1, 0xffff), Local0)
                                                if (Local0) {
                                                    err(ts, z150, 0x019, 0, 0, 0, Local0)
                                                } else {
                                                    Store(Acquire(MTc0, 0xffff), Local0)
                                                    if (Local0) {
                                                        err(ts, z150, 0x01a, 0, 0, 0, Local0)
                                                    } else {
                                                    Store(Acquire(MTc1, 0xffff), Local0)
                                                    if (Local0) {
                                                        err(ts, z150, 0x01b, 0, 0, 0, Local0)
                                                    } else {
                                                        Store(Acquire(MTd0, 0xffff), Local0)
                                                        if (Local0) {
                                                            err(ts, z150, 0x01c, 0, 0, 0, Local0)
                                                        } else {
                                                        Store(Acquire(MTd1, 0xffff), Local0)
                                                        if (Local0) {
                                                            err(ts, z150, 0x01d, 0, 0, 0, Local0)
                                                        } else {
                                                            Store(Acquire(MTe0, 0xffff), Local0)
                                                            if (Local0) {
                                                                err(ts, z150, 0x01e, 0, 0, 0, Local0)
                                                            } else {
                                                            Store(Acquire(MTe1, 0xffff), Local0)
                                                            if (Local0) {
                                                                err(ts, z150, 0x01f, 0, 0, 0, Local0)
                                                            } else {
                                                                Store(Acquire(MTf0, 0xffff), Local0)
                                                                if (Local0) {
                                                                    err(ts, z150, 0x020, 0, 0, 0, Local0)
                                                                } else {
                                                                if (arg0) {
                                                                    Store(Acquire(MTf1, 0xffff), Local0)
                                                                } else {
                                                                    Store(0, Local0)
                                                                }
                                                                if (Local0) {
                                                                    err(ts, z150, 0x021, 0, 0, 0, Local0)
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
        CH04(ts, 1, 18, z150, 0x122, 0, 0) // AE_LIMIT
    } else {
        CH03(ts, z150, 0x123, 0, 0)
    }
}

/*
 * Valid sequence of requests, no exceptions expected.
 *
 * Acquire mutexes of monotone increasing level (Global lock
 * on level 0 too) for all available levels from 0 up to 15,
 * then Release them all in the inverse order.
 *
 * Exactly m301 but additioanlly:
 *    all Release opreations are located into separate method.
 */
Method(m36a,, Serialized)
{
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

    Name(ts, "m36a")

    Method(m000)
    {

    Store(Acquire(MT00, 0xffff), Local0)
    if (Local0) {
        err(ts, z150, 1, 0, 0, 0, Local0)
    } else {
    Store(Acquire(\_GL, 0xffff), Local0)
    if (Local0) {
        err(ts, z150, 2, 0, 0, 0, Local0)
    } else {
        Store(Acquire(MT10, 0xffff), Local0)
        if (Local0) {
            err(ts, z150, 3, 0, 0, 0, Local0)
        } else {
            Store(Acquire(MT20, 0xffff), Local0)
            if (Local0) {
                err(ts, z150, 4, 0, 0, 0, Local0)
            } else {
                Store(Acquire(MT30, 0xffff), Local0)
                if (Local0) {
                    err(ts, z150, 5, 0, 0, 0, Local0)
                } else {
                    Store(Acquire(MT40, 0xffff), Local0)
                    if (Local0) {
                        err(ts, z150, 6, 0, 0, 0, Local0)
                    } else {
                        Store(Acquire(MT50, 0xffff), Local0)
                        if (Local0) {
                            err(ts, z150, 7, 0, 0, 0, Local0)
                        } else {
                            Store(Acquire(MT60, 0xffff), Local0)
                            if (Local0) {
                                err(ts, z150, 8, 0, 0, 0, Local0)
                            } else {
                                Store(Acquire(MT70, 0xffff), Local0)
                                if (Local0) {
                                    err(ts, z150, 9, 0, 0, 0, Local0)
                                } else {
                                    Store(Acquire(MT80, 0xffff), Local0)
                                    if (Local0) {
                                        err(ts, z150, 0x00a, 0, 0, 0, Local0)
                                    } else {
                                        Store(Acquire(MT90, 0xffff), Local0)
                                        if (Local0) {
                                            err(ts, z150, 0x00b, 0, 0, 0, Local0)
                                        } else {
                                            Store(Acquire(MTa0, 0xffff), Local0)
                                            if (Local0) {
                                                err(ts, z150, 0x00c, 0, 0, 0, Local0)
                                            } else {
                                                Store(Acquire(MTb0, 0xffff), Local0)
                                                if (Local0) {
                                                    err(ts, z150, 0x00d, 0, 0, 0, Local0)
                                                } else {
                                                    Store(Acquire(MTc0, 0xffff), Local0)
                                                    if (Local0) {
                                                        err(ts, z150, 0x00e, 0, 0, 0, Local0)
                                                    } else {
                                                        Store(Acquire(MTd0, 0xffff), Local0)
                                                        if (Local0) {
                                                            err(ts, z150, 0x00f, 0, 0, 0, Local0)
                                                        } else {
                                                            Store(Acquire(MTe0, 0xffff), Local0)
                                                            if (Local0) {
                                                                err(ts, z150, 0x010, 0, 0, 0, Local0)
                                                            } else {
                                                                Store(Acquire(MTf0, 0xffff), Local0)
                                                                if (Local0) {
                                                                    err(ts, z150, 0x011, 0, 0, 0, Local0)
                                                                } else {
                                                                    m001()
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
    } /* m000 */

    Method(m001)
    {
		Release(MTF0)
		Release(MTE0)
		Release(MTD0)
		Release(MTC0)
		Release(MTB0)
		Release(MTA0)
		Release(MT90)
		Release(MT80)
		Release(MT70)
		Release(MT60)
		Release(MT50)
		Release(MT40)
		Release(MT30)
		Release(MT20)
		Release(MT10)
		Release(\_GL)
		Release(MT00)
    }

    CH03(ts, z150, 0x012, 0, 0)
    m000()
    CH03(ts, z150, 0x013, 0, 0)
}

/*
 * Valid sequence of requests, no exceptions expected.
 *
 * Acquire mutexes of monotone increasing level (Global lock
 * on level 0 too) for all available levels from 0 up to 15,
 * then Release them all in the inverse order.
 *
 * Exactly m301 but additioanlly:
 *    all Acquire and Release opreations are located into separate methods.
 */
Method(m36b,, Serialized)
{
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

    Name(ts, "m36b")

    Method(m000)
    {

    Store(Acquire(MT00, 0xffff), Local0)
    if (Local0) {
        err(ts, z150, 1, 0, 0, 0, Local0)
    } else {
    Store(Acquire(\_GL, 0xffff), Local0)
    if (Local0) {
        err(ts, z150, 2, 0, 0, 0, Local0)
    } else {
        Store(Acquire(MT10, 0xffff), Local0)
        if (Local0) {
            err(ts, z150, 3, 0, 0, 0, Local0)
        } else {
            Store(Acquire(MT20, 0xffff), Local0)
            if (Local0) {
                err(ts, z150, 4, 0, 0, 0, Local0)
            } else {
                Store(Acquire(MT30, 0xffff), Local0)
                if (Local0) {
                    err(ts, z150, 5, 0, 0, 0, Local0)
                } else {
                    Store(Acquire(MT40, 0xffff), Local0)
                    if (Local0) {
                        err(ts, z150, 6, 0, 0, 0, Local0)
                    } else {
                        Store(Acquire(MT50, 0xffff), Local0)
                        if (Local0) {
                            err(ts, z150, 7, 0, 0, 0, Local0)
                        } else {
                            Store(Acquire(MT60, 0xffff), Local0)
                            if (Local0) {
                                err(ts, z150, 8, 0, 0, 0, Local0)
                            } else {
                                Store(Acquire(MT70, 0xffff), Local0)
                                if (Local0) {
                                    err(ts, z150, 9, 0, 0, 0, Local0)
                                } else {
                                    Store(Acquire(MT80, 0xffff), Local0)
                                    if (Local0) {
                                        err(ts, z150, 0x00a, 0, 0, 0, Local0)
                                    } else {
                                        Store(Acquire(MT90, 0xffff), Local0)
                                        if (Local0) {
                                            err(ts, z150, 0x00b, 0, 0, 0, Local0)
                                        } else {
                                            Store(Acquire(MTa0, 0xffff), Local0)
                                            if (Local0) {
                                                err(ts, z150, 0x00c, 0, 0, 0, Local0)
                                            } else {
                                                Store(Acquire(MTb0, 0xffff), Local0)
                                                if (Local0) {
                                                    err(ts, z150, 0x00d, 0, 0, 0, Local0)
                                                } else {
                                                    Store(Acquire(MTc0, 0xffff), Local0)
                                                    if (Local0) {
                                                        err(ts, z150, 0x00e, 0, 0, 0, Local0)
                                                    } else {
                                                        Store(Acquire(MTd0, 0xffff), Local0)
                                                        if (Local0) {
                                                            err(ts, z150, 0x00f, 0, 0, 0, Local0)
                                                        } else {
                                                            Store(Acquire(MTe0, 0xffff), Local0)
                                                            if (Local0) {
                                                                err(ts, z150, 0x010, 0, 0, 0, Local0)
                                                            } else {
                                                                Store(Acquire(MTf0, 0xffff), Local0)
                                                                if (Local0) {
                                                                    err(ts, z150, 0x011, 0, 0, 0, Local0)
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
    } /* m000 */

    Method(m001)
    {
		Release(MTF0)
		Release(MTE0)
		Release(MTD0)
		Release(MTC0)
		Release(MTB0)
		Release(MTA0)
		Release(MT90)
		Release(MT80)
		Release(MT70)
		Release(MT60)
		Release(MT50)
		Release(MT40)
		Release(MT30)
		Release(MT20)
		Release(MT10)
		Release(\_GL)
		Release(MT00)
    }

    CH03(ts, z150, 0x012, 0, 0)
    m000()
    CH03(ts, z150, 0x013, 0, 0)
    m001()
    CH03(ts, z150, 0x014, 0, 0)
}

/*
 * Invalid sequence of Acquire operations:
 *
 *   1) Acquire N-th level mutex (N>=1):
 *   2) Acquire:
 *      - mutexes from 0 up to (N-1)-levels
 *      - Global lock
 *   3) exception AE_AML_MUTEX_ORDER is expected for each Acquire of (2)
 */
Method(m36c,, Serialized)
{
	Name(ts, "m36c")
	Name(lpN0, 0)
	Name(lpC0, 0)

	/*
	 * arg0 - level of mutex to be acquired first
	 * arg1 - level of mutex to be acquired second
	 * arg2 - 1 - acquire 0-level mutex instead of arg1
	 *        2 - acquire Global lock   instead of arg1
	 */
	Method(m000, 3, Serialized)
	{
		/* Acquire the first mutex */

		CH03(ts, z150, 0x000, 0, 0)
		m36f(arg0, 0, 0, 0) // Acquire N-level mutex
		CH03(ts, z150, 0x001, 0, 0)

		/*
		 * Attempt to Acquire the second mutex (exception is expected).
		 *
		 * It is supposed that the second acquired
		 * is a mutex of level not greater than (N-1)
		 */
		Switch (ToInteger (arg2)) {
			Case (1) {
				m36f(0, 0, 1, 0) // Acquire 0 level mux
			}
			Case (2) {
				m36f(GLLL, GLIX, 1, 0) // Acquire GL
			}
			Default {
				m36f(arg1, 0, 1, 0) // Acquire arg1-level mux
			}
		}
		CH04(ts, 0, 64, z150, 0x002, 0, 0) // AE_AML_MUTEX_ORDER

		m388(arg0, 0, 0) // Release

		CH03(ts, z150, 0x003, 0, 0)
	}

	/*
	 * The second Acquires are run in range from 0 up to (N-1) levels
	 *
	 * arg0 - N level (to be in range from 1 up to 15)
	 */
	Method(m001, 1, Serialized)
	{
		Name(lpN0, 0)
		Name(lpC0, 0)

		Store(arg0, lpN0)
		Store(0, lpC0)
		While (lpN0) {
			m000(arg0, lpC0, 0)
			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	/* From 1 up to 15 levels */

	Subtract(max0, 1, lpN0)
	Store(1, lpC0)
	While (lpN0) {
		if (lpC0) {
			m001(lpC0)
			m000(lpC0, 0, 1) // 0 level mux
			m000(lpC0, 0, 2) // GL
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Exception on Release.
 * Release mutex twice.
 *
 * Attempt to Release free mutex: Acquire, Release, Release.
 * Exception is expected on the second Release.
 * Do it for all level mutexes and Global lock too.
 */
Method(m389,, Serialized)
{
	Name(ts, "m389")
	Name(lpN0, 0)
	Name(lpC0, 0)

	/* arg0 - level of mutex */
	Method(m000, 1)
	{
		CH03(ts, z150, 0x000, 0, 0)
		m36f(arg0, 0, 0, 0) // Acquire
		m388(arg0, 0, 0) // Release
		CH03(ts, z150, 0x001, 0, 0)

		/* Attempt to Release free mutex */
		m388(arg0, 0, 0) // Release
		CH04(ts, 0, 65, z150, 0x002, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED

		CH03(ts, z150, 0x003, 0, 0)
		m36f(arg0, 0, 0, 0) // Acquire
		m388(arg0, 0, 0) // Release
		CH03(ts, z150, 0x004, 0, 0)
	}

	Store(max0, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		m000(lpC0)
		Decrement(lpN0)
		Increment(lpC0)
	}

	/* Separately for GL */

	CH03(ts, z150, 0x005, 0, 0)
	m36f(GLLL, GLIX, 0, 0) // Acquire
	m388(GLLL, GLIX, 0) // Release
	CH03(ts, z150, 0x006, 0, 0)

	/* Attempt to Release free mutex */
	m388(GLLL, GLIX, 0) // Release
	CH04(ts, 0, 65, z150, 0x007, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED

	CH03(ts, z150, 0x008, 0, 0)
	m36f(GLLL, GLIX, 0, 0) // Acquire
	m388(GLLL, GLIX, 0) // Release
	CH03(ts, z150, 0x009, 0, 0)
}

/*
 * Exception on Release.
 * Attempt ot Release clean mutex which was never Acquired.
 */
Method(m07b,, Serialized)
{
	Name(ts, "m07b")

	Mutex(T000, 0)
	Mutex(T100, 1)
	Mutex(T200, 2)
	Mutex(T300, 3)
	Mutex(T400, 4)
	Mutex(T500, 5)
	Mutex(T600, 6)
	Mutex(T700, 7)
	Mutex(T800, 8)
	Mutex(T900, 9)
	Mutex(Ta00, 10)
	Mutex(Tb00, 11)
	Mutex(Tc00, 12)
	Mutex(Td00, 13)
	Mutex(Te00, 14)
	Mutex(Tf00, 15)

	/* First time */

	CH03(ts, z150, 0x000, 0, 0)
	Release(T000)
	CH04(ts, 0, 65, z150, 0x001, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED

	CH03(ts, z150, 0x002, 0, 0)
	Release(\_GL)
	CH04(ts, 0, 65, z150, 0x003, 0, 0)

	CH03(ts, z150, 0x004, 0, 0)
	Release(T100)
	CH04(ts, 0, 65, z150, 0x005, 0, 0)

	CH03(ts, z150, 0x006, 0, 0)
	Release(T200)
	CH04(ts, 0, 65, z150, 0x007, 0, 0)

	CH03(ts, z150, 0x008, 0, 0)
	Release(T300)
	CH04(ts, 0, 65, z150, 0x009, 0, 0)

	CH03(ts, z150, 0x00a, 0, 0)
	Release(T400)
	CH04(ts, 0, 65, z150, 0x00b, 0, 0)

	CH03(ts, z150, 0x00c, 0, 0)
	Release(T500)
	CH04(ts, 0, 65, z150, 0x00d, 0, 0)

	CH03(ts, z150, 0x00e, 0, 0)
	Release(T600)
	CH04(ts, 0, 65, z150, 0x00f, 0, 0)

	CH03(ts, z150, 0x010, 0, 0)
	Release(T700)
	CH04(ts, 0, 65, z150, 0x011, 0, 0)

	CH03(ts, z150, 0x012, 0, 0)
	Release(T800)
	CH04(ts, 0, 65, z150, 0x013, 0, 0)

	CH03(ts, z150, 0x014, 0, 0)
	Release(T900)
	CH04(ts, 0, 65, z150, 0x015, 0, 0)

	CH03(ts, z150, 0x016, 0, 0)
	Release(Ta00)
	CH04(ts, 0, 65, z150, 0x017, 0, 0)

	CH03(ts, z150, 0x018, 0, 0)
	Release(Tb00)
	CH04(ts, 0, 65, z150, 0x019, 0, 0)

	CH03(ts, z150, 0x01a, 0, 0)
	Release(Tc00)
	CH04(ts, 0, 65, z150, 0x01b, 0, 0)

	CH03(ts, z150, 0x01c, 0, 0)
	Release(Td00)
	CH04(ts, 0, 65, z150, 0x01d, 0, 0)

	CH03(ts, z150, 0x01e, 0, 0)
	Release(Te00)
	CH04(ts, 0, 65, z150, 0x01f, 0, 0)

	CH03(ts, z150, 0x020, 0, 0)
	Release(Tf00)
	CH04(ts, 0, 65, z150, 0x021, 0, 0)


	/* Second time */

	CH03(ts, z150, 0x022, 0, 0)
	Release(T000)
	CH04(ts, 0, 65, z150, 0x023, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED

	CH03(ts, z150, 0x024, 0, 0)
	Release(T100)
	CH04(ts, 0, 65, z150, 0x025, 0, 0)

	CH03(ts, z150, 0x026, 0, 0)
	Release(T200)
	CH04(ts, 0, 65, z150, 0x027, 0, 0)

	CH03(ts, z150, 0x028, 0, 0)
	Release(T300)
	CH04(ts, 0, 65, z150, 0x029, 0, 0)

	CH03(ts, z150, 0x02a, 0, 0)
	Release(T400)
	CH04(ts, 0, 65, z150, 0x02b, 0, 0)

	CH03(ts, z150, 0x02c, 0, 0)
	Release(T500)
	CH04(ts, 0, 65, z150, 0x02d, 0, 0)

	CH03(ts, z150, 0x02e, 0, 0)
	Release(T600)
	CH04(ts, 0, 65, z150, 0x02f, 0, 0)

	CH03(ts, z150, 0x030, 0, 0)
	Release(T700)
	CH04(ts, 0, 65, z150, 0x031, 0, 0)

	CH03(ts, z150, 0x032, 0, 0)
	Release(T800)
	CH04(ts, 0, 65, z150, 0x033, 0, 0)

	CH03(ts, z150, 0x034, 0, 0)
	Release(T900)
	CH04(ts, 0, 65, z150, 0x035, 0, 0)

	CH03(ts, z150, 0x036, 0, 0)
	Release(Ta00)
	CH04(ts, 0, 65, z150, 0x037, 0, 0)

	CH03(ts, z150, 0x038, 0, 0)
	Release(Tb00)
	CH04(ts, 0, 65, z150, 0x039, 0, 0)

	CH03(ts, z150, 0x03a, 0, 0)
	Release(Tc00)
	CH04(ts, 0, 65, z150, 0x03b, 0, 0)

	CH03(ts, z150, 0x03c, 0, 0)
	Release(Td00)
	CH04(ts, 0, 65, z150, 0x03d, 0, 0)

	CH03(ts, z150, 0x03e, 0, 0)
	Release(Te00)
	CH04(ts, 0, 65, z150, 0x03f, 0, 0)

	CH03(ts, z150, 0x040, 0, 0)
	Release(Tf00)
	CH04(ts, 0, 65, z150, 0x041, 0, 0)
}

/*
 * Exception on Release.
 * Break the sequence of Acquiring mutexes while Releasing them,
 * jump over the level.
 *
 * Invalid sequence of Releases:
 *
 *   1) Take level from range (N>=1 & N<=15)
 *   2) Acquire mutexes of all levels from 0 up to N
 *   3) Try to Release any mutex:
 *      - in the level range from (N-1) down to 0
 *      - Global lock
 *   4) Do 1-3 for all levels in range (N>=1 & N<=15)
 */
Method(m38a,, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(br00, 0)


	Subtract(max0, 1, lpN0)
	Store(2, lpC0)

	While (lpN0) {

		/* Acquire lpC0 levels from 0 level */

		m38b(0, lpC0, 1, 0)


		/*
		 * Exception is expected on each Release there.
		 *
		 * Break the sequence of Acquiring mutexes while Releasing them,
		 * jump over the level.
		 * Run Releasing mutexes NOT from (lpC0-1) level which whould be
		 * correct but from (lpC0-2) level down to 0 level so jumping over
		 * the mutex of (lpC0-1) level which is Acquired which should cause
		 * each of these Releases to generate AE_AML_MUTEX_ORDER exception.
		 */
		Subtract(lpC0, 2, Local0)
		Subtract(lpC0, 1, Local1)
		if (m38c(Local0, Local1, 1, 64)) { // AE_AML_MUTEX_ORDER
			/*
			 * Break for the first bunch of errors encountered,
			 * dont waste log.
			 */
			Store(1, br00)
		}


		/*
		 * Correct sequence of Releases.
		 * Release lpC0 levels from (lpC0-1) down to 0 level.
		 */

		if (br00) {
			m36f(hlmx, 0, 0, 0)
			m388(hlmx, 0, 0)
		}
		Subtract(lpC0, 1, Local0)
		m38c(Local0, lpC0, 1, 0)

		if (br00) {
			break
		}

		Decrement(lpN0)
		Increment(lpC0)
	}

	CH03("m38a", z150, 0x000, 0, 0)
}

/*
 * Manager for m38d.
 *
 * arg0 - the value of flag of GL
 * arg1 - order of Releasing bitmap (see m089)
 */
Method(m08c, 2, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	/*
	 * arg0 - Level of mutex
	 * arg1 - the value of flag of GL
	 * arg2 - order of Releasing bitmap (see m089)
	 */
	Method(m000, 3)
	{
		/* Set up the value of flag of Global lock */
		Store(m078(arg1), Local7)

		/*
		 * min0 - number of mutexes existent for each level
		 *
		 * Acquire mutexes of level arg0
		 * in the order from 0 index up
		 * to (min0-1) one, then Release
		 * them in the order specified
		 * by arg2.
		 */
		m088(arg0, 1, 0, min0, 0, 0, 0)    // Acquire
		m089(arg0, 1, 0, min0, 0, 0, arg2) // Release

		/* Restore the value of flag of Global lock */
		m078(Local7)
	}

	/* For each level */
	Store(max0, lpN0)
	Store(0, lpC0)

	While (lpN0) {
		m000(lpC0, arg0, arg1)
		Decrement(lpN0)
		Increment(lpC0)
	}

}

/*
 * Check up that the Releasing of the same level mutexes
 * can be performed in an arbitrary order, independently
 * on the order they were Acquired.
 *
 * For each level separately, one by one.
 */
Method(m38d)
{
	m08c(0, 0x0000) // direct  order of Releasing, Mutex(0,1) is usual mutex
	m08c(0, 0x0001) // inverse order of Releasing, Mutex(0,1) is usual mutex
	m08c(1, 0x0000) // direct  order of Releasing, Mutex(0,1) is GL
	m08c(1, 0x0001) // inverse order of Releasing, Mutex(0,1) is GL

	/* Check that all mutexes are Released */
	m08a()
}

/*
 * Check up that the Releasing of the same level mutexes
 * can be performed in an arbitrary order, independently
 * on the order they were Acquired.
 *
 * Cross through all the levels.
 *
 * arg0 - order of Releasing bitmap (see m089)
 */
Method(m07d, 1)
{
	m088(0, max0, 0, min0, 0, 0, 0)    // Acquire all mutexes on all levels
	m089(0, max0, 0, min0, 0, 0, arg0) // Release all mutexes on all levels
}

/*
 * ACPI allows multiply own the same mutex
 *
 * arg0 - the value of flag of GL
 */
Method(m07a, 1)
{
	m079(10, arg0)
}

/*
 * Multiply owning the same ACPI mutex.
 * Acquire the same mutex arg2 times, then Release it (arg2+1) times,
 * expect exception on the last Release.
 * The repeated Acquire are made with TimeoutValue equal to zero.
 *
 * arg0 - how many times to Acquire it
 * arg1 - the value of flag of GL
 */
Method(m079, 2, Serialized)
{
	Name(ts, "m079")
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(lpN1, 0)
	Name(lpC1, 0)
	Name(tout, 0)
	Name(ix00, 1)

	/* Set up the value of flag of Global lock */
	Store(m078(arg1), Local7)

	/* Acquire */

	/* levels */

	Store(max0, lpN0)
	Store(0, lpC0)
	While (lpN0) {
		/* repetitions */
		Store(arg0, lpN1)
		Store(0, lpC1)
		While (lpN1) {
			if (lpC1) {
				Store(TOV0, tout) // TimeOutValue equal to 0
			} else {
				Store(0, tout) // TimeOutValue equal to 0xffff (once for the first Acquire)
			}
			m36f(lpC0, ix00, 0, tout)
			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}

	/* Release */

	CH03(ts, z150, 0x000, 0, 0)

	Store(max0, lpN0)
	Subtract(max0, 1, lpC0)
	While (lpN0) {
		/* repetitions */
		Store(arg0, lpN1)
		Store(0, lpC1)
		While (lpN1) {
			m388(lpC0, ix00, 0)
			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Decrement(lpC0)
	}

	/* The 'owning counters' are exhausted, so exceptions are expected */

	Store(max0, lpN0)
	Subtract(max0, 1, lpC0)
	While (lpN0) {
		CH03(ts, z150, 0x001, 0, 0)
		m388(lpC0, ix00, 0)
		CH04(ts, 0, 65, z150, 0x002, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
		Decrement(lpN0)
		Decrement(lpC0)
	}

	/* Restore the value of flag of Global lock */
	m078(Local7)
}


/*
 * /////////////////////////////////////////
 *
 *    The tests below examine different ways
 *    to Acquire/Release mutexes
 *
 * /////////////////////////////////////////
 */

/*
 * ATTENTION: this test must be run the first
 *
 * Different ways to Acquire/Release mutexes
 *
 * 1) Acquire and Release operations are in a global level AML code
 *
 * See m07c.
 */
Method(m0b9,, Serialized)
{
	Name(ts, "m0b9")

	/* i101 - non-zero means that the test was run */
	if (LNot(i101)) {
		return
	}

	CH03(ts, z150, 0x000, 0, 0)

}

/*
 * The same operations as m0b9 (the test for global level AML code)
 * but enclosed into Method.
 */
Method(m0bb,, Serialized)
{
	Name(ts, "m0bb")

	CH03(ts, z150, 0x000, 0, 0)

	Method(m137)
	{
		Store("m137 started", Debug)

		if (LNot(i102)) {
			Release(T804)
		}

		Store("m137 completed", Debug)

		return (1)
	}
	Method(m13e)
	{
		Store("m13e started", Debug)

		Store(Acquire(T805, 0xffff), i103)
		if (i103) {
			err(ts, z150, 0x001, 0, 0, 0, i103)
		}

		Store("m13e completed", Debug)

		return (1)
	}
	Method(m13f)
	{
		Store("m13f started", Debug)

		if (LNot(i103)) {
			Release(T805)
		}

		Store("m13f completed", Debug)

		return (1)
	}


	Name(i102, 1)
	Name(i103, 1)
	Name(b11c, Buffer(Add(1, Store(Acquire(T804, 0xffff), i102))){0})
	Name(b11d, Buffer(m137()){0})
	Name(b11e, Buffer(m13e()){0})
	Name(b11f, Buffer(m13f()){0})

	if (i102) {
		Store("Acquire(T804, 0xffff) failed", Debug)
		err(ts, z150, 0x002, 0, 0, 0, i102)
	}

	if (i103) {
		Store("Acquire(T805, 0xffff) failed", Debug)
		err(ts, z150, 0x003, 0, 0, 0, i103)
	}

	CH03(ts, z150, 0x004, 0, 0)
}

/*
 * Different ways to Acquire/Release mutexes
 *
 * 2) Acquire and Release operations are in the same method
 * 3) Acquire and Release operations are in different methods
 *
 * See m0b9.
 */
Method(m07c,, Serialized)
{
	Name(ts, "m07c")

	/* Acquire and Release operations are in the same method */
	Method(m000)
	{
			CH03(ts, z150, 0x000, 0, 0)

			/* Acquire all */

			Store(Acquire(\_GL, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T000, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T100, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T200, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T300, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T400, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T500, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T600, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T700, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T800, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T900, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(Ta00, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(Tb00, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(Tc00, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(Td00, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(Te00, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(Tf00, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			CH03(ts, z150, 0x000, 0, 0)

			/* Release all */

			Release(Tf00)
			Release(Te00)
			Release(Td00)
			Release(Tc00)
			Release(Tb00)
			Release(Ta00)
			Release(T900)
			Release(T800)
			Release(T700)
			Release(T600)
			Release(T500)
			Release(T400)
			Release(T300)
			Release(T200)
			Release(T100)
			Release(T000)
			Release(\_GL)

			CH03(ts, z150, 0x000, 0, 0)
	}

	/* Acquire and Release operations are in different methods */
	Method(m001)
	{
		Method(mm00)
		{
			CH03(ts, z150, 0x000, 0, 0)

			Store(Acquire(\_GL, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T000, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T100, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T200, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T300, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T400, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T500, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T600, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T700, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T800, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(T900, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(Ta00, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(Tb00, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(Tc00, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(Td00, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(Te00, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			Store(Acquire(Tf00, 0xffff), Local0)
			if (Local0) {
				err(ts, z150, 0x000, 0, 0, 0, Local0)
			}

			CH03(ts, z150, 0x000, 0, 0)
		}

		Method(mm01)
		{
			CH03(ts, z150, 0x000, 0, 0)

			Release(Tf00)
			Release(Te00)
			Release(Td00)
			Release(Tc00)
			Release(Tb00)
			Release(Ta00)
			Release(T900)
			Release(T800)
			Release(T700)
			Release(T600)
			Release(T500)
			Release(T400)
			Release(T300)
			Release(T200)
			Release(T100)
			Release(T000)
			Release(\_GL)

			CH03(ts, z150, 0x000, 0, 0)
		}

		Method(mm02)
		{
			CH03(ts, z150, 0x000, 0, 0)
			Release(Tf00)
			CH04(ts, 0, 65, z150, 0x001, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x002, 0, 0)
			Release(Te00)
			CH04(ts, 0, 65, z150, 0x003, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x004, 0, 0)
			Release(Td00)
			CH04(ts, 0, 65, z150, 0x005, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x006, 0, 0)
			Release(Tc00)
			CH04(ts, 0, 65, z150, 0x007, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x008, 0, 0)
			Release(Tb00)
			CH04(ts, 0, 65, z150, 0x009, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x00a, 0, 0)
			Release(Ta00)
			CH04(ts, 0, 65, z150, 0x00b, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x00c, 0, 0)
			Release(T900)
			CH04(ts, 0, 65, z150, 0x00d, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x00e, 0, 0)
			Release(T800)
			CH04(ts, 0, 65, z150, 0x00f, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x010, 0, 0)
			Release(T700)
			CH04(ts, 0, 65, z150, 0x011, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x012, 0, 0)
			Release(T600)
			CH04(ts, 0, 65, z150, 0x013, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x014, 0, 0)
			Release(T500)
			CH04(ts, 0, 65, z150, 0x015, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x016, 0, 0)
			Release(T400)
			CH04(ts, 0, 65, z150, 0x017, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x018, 0, 0)
			Release(T300)
			CH04(ts, 0, 65, z150, 0x019, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x01a, 0, 0)
			Release(T200)
			CH04(ts, 0, 65, z150, 0x01b, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x01c, 0, 0)
			Release(T100)
			CH04(ts, 0, 65, z150, 0x01d, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x01e, 0, 0)
			Release(T000)
			CH04(ts, 0, 65, z150, 0x01f, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
			CH03(ts, z150, 0x020, 0, 0)
			Release(\_GL)
			CH04(ts, 0, 65, z150, 0x021, 0, 0) // AE_AML_MUTEX_NOT_ACQUIRED
		}

		mm00()
		mm01()
		mm02()
	}

	/* Acquire and Release operations are in the same method */
	m000()

	/* Acquire and Release operations are in different methods */
	m001()
}

/*
 * Acquire/Release operations enclosed in other operations
 */
Method(m0ba,, Serialized)
{
	Name(ts, "m0ba")

	CH03(ts, z150, 0x000, 0, 0)

	/* Add */

	Add(Acquire(\_GL, 0xffff), 1, Local0)
	if (LNotEqual(Local0, 1)) {
		err(ts, z150, 0x001, 0, 0, 0, Local0)
	}

	Add(Acquire(T500, 0xffff), 1, Local0)
	if (LNotEqual(Local0, 1)) {
		err(ts, z150, 0x002, 0, 0, 0, Local0)
	}

	Release(T500)
	Release(\_GL)

	/* Subtract */

	Subtract(1, Acquire(\_GL, 0xffff), Local0)
	if (LNotEqual(Local0, 1)) {
		err(ts, z150, 0x003, 0, 0, 0, Local0)
	}

	Subtract(1, Acquire(T500, 0xffff), Local0)
	if (LNotEqual(Local0, 1)) {
		err(ts, z150, 0x004, 0, 0, 0, Local0)
	}

	Release(T500)
	Release(\_GL)

	/* LEqual */

	if (LNotEqual(Acquire(T500, 0xffff), 0)) {
		err(ts, z150, 0x004, 0, 0, 0, Local0)
	}
	Release(T500)

	if (FL03) {
		// Check that all mutexes are Released (doesn't check T804..)
		m08a()
	}
	CH04 (ts, 1, 64, z150, 0x001, 0, 0)
}

/*
 * /////////////////////////////////////////////
 *
 *    The tests below generate some combinations
 *    of Acquire/Release operations
 *
 * /////////////////////////////////////////////
 */

/*
 * Get 0 or 1 value pseudo randomly
 *
 * arg0 - input Integer
 */
Method(m08e)
{
	/* To be improved */

	And(cn00, 0x01, Local0)

	Increment(cn00)

	if (LNot(y242)) {
		/* Always inverse order untill the bug 242 is fixes */
		Store(0x0001, Local0)
	}

	return (Local0)
}

/*
 * Acquire/Release combination #1
 */
Method(m07e,, Serialized)
{
	Name(num, 4)
	Name(rpt0, 0)
	Name(rpt1, 3)
	Name(lpN0, 0)
	Name(lpC0, 0)


	/* Set up the value of flag of Global lock */
	Store(m078(0), Local7)

	Store(num, lpN0)
	Store(0, lpC0)
	While (lpN0) {

		/* Set up the value of flag of Global lock */
		Divide(lpC0, 2, Local0)
		m078(Local0)

		if (Local0) {
			Store(rpt1, rpt0)
		} else {
			Store(1, rpt0)
		}

		m088( 0,  3, 0, 4, 0, rpt0, 0)      // Step  0, Acquire
		m088( 3,  3, 1, 2, 0, rpt0, 0)      // Step  1, Acquire
		m089( 4,  2, 1, 2, 0, rpt0, m08e()) // Step  1, Release
		m088( 5,  3, 0, 4, 0, rpt0, 0)      // Step  2, Acquire
		m089( 7,  1, 1, 3, 0, rpt0, m08e()) // Step  2, Release
		m089( 7,  1, 0, 1, 0, rpt0, m08e()) // Step  2, Release
		m089( 6,  1, 0, 4, 0, rpt0, m08e()) // Step  2, Release
		m088( 9,  2, 2, 2, 0, rpt0, 0)      // Step  3, Acquire
		m089(10,  1, 3, 1, 0, rpt0, m08e()) // Step  3, Release
		m089(10,  1, 2, 1, 0, rpt0, m08e()) // Step  3, Release
		m089( 9,  1, 3, 1, 0, rpt0, m08e()) // Step  3, Release
		m088(10,  2, 0, 3, 0, rpt0, 0)      // Step  4, Acquire
		m089(10,  2, 0, 3, 0, rpt0, m08e()) // Step  4, Release
		m088(10,  2, 0, 3, 0, rpt0, 0)      // Step  5, Acquire
		m089(10,  2, 0, 3, 0, rpt0, m08e()) // Step  5, Release
		m088(12,  2, 0, 3, 0, rpt0, 0)      // Step  6, Acquire
		m089(12,  2, 0, 3, 0, rpt0, m08e()) // Step  6, Release
		m088(10,  6, 0, 4, 0, rpt0, 0)      // Step  7, Acquire
		m089(10,  6, 0, 4, 0, rpt0, m08e()) // Step  7, Release
		m088(12,  2, 0, 3, 0, rpt0, 0)      // Step  8, Acquire
		m089(12,  2, 0, 3, 0, rpt0, m08e()) // Step  8, Release
		m089( 9,  1, 2, 1, 0, rpt0, m08e()) // Step  3, Release
		m089( 5,  1, 0, 4, 0, rpt0, m08e()) // Step  2, Release
		m089( 3,  1, 1, 2, 0, rpt0, m08e()) // Step  1, Release
		m089( 1,  2, 0, 4, 0, rpt0, m08e()) // Step  0, Release
		m088( 1, 15, 1, 2, 0, rpt0, 0)      // Step  9, Acquire
		m089( 1, 15, 1, 2, 0, rpt0, m08e()) // Step  9, Release
		m089( 0,  1, 1, 1, 0, rpt0, m08e()) // Step  0, Release
		m089( 0,  1, 3, 1, 0, rpt0, m08e()) // Step  0, Release
		m089( 0,  1, 2, 1, 0, rpt0, m08e()) // Step  0, Release
		m089( 0,  1, 0, 1, 0, rpt0, m08e()) // Step  0, Release
		m088( 0, 16, 1, 2, 0, rpt0, 0)      // Step 10, Acquire
		m089( 0, 16, 1, 2, 0, rpt0, m08e()) // Step 10, Release

		Decrement(lpN0)
		Increment(lpC0)
	}

	/* Restore the value of flag of Global lock */
	m078(Local7)

	if (FL03) {
		// Check that all mutexes are Released
		m08a()
	}
}

/*
 * ///////////////////////////////////////////////////
 *
 *    The tests below check behaviour after exceptions
 *
 * ///////////////////////////////////////////////////
 */

/*
 * Check the life after AE_AML_MUTEX_ORDER exception on Acquire
 *
 *  1)     Acquire     N-th level mutex MUX-N
 *  2) run Acquire (N-2)-th level mutex MUX-(N-2) and get AE_AML_MUTEX_ORDER exception
 *  3) run Acquire (N-1)-th level mutex MUX-(N-1) and get AE_AML_MUTEX_ORDER exception
 *  4)     Acquire                mutex MUX-N and check that no exception on this operation
 *  5)     Release                mutex MUX-N and check that no exception on this operation
 *  6)     Release                mutex MUX-N and check that no exception on this operation
 *  7)     do 1-6 for all N in range 2-15 levels
 *  8)     check additionally that all the mutexes are free (run Release and
 *         get AE_AML_MUTEX_NOT_ACQUIRED exception for all the mutexes of all levels)
 *  9)     Acquire all mutexes of all levels and check that no exceptions
 * 10)     Release all mutexes of all levels and check that no exceptions
 * 11)     check additionally that all the mutexes are free (see 8)
 *
 * 12)     do it for GL mode too
 * 13)     do additional Acquire of MUX-(N-2) and MUX-(N-1) before Acquire of MUX-N (Release them later)
 *
 * arg0 - the value of flag of GL
 * arg1 - if non-zero do additional Acquire of MUX-(N-2) and MUX-(N-1) before Acquire of MUX-N
 */
Method(m08b, 2, Serialized)
{
	Name(rpt0, 1)
	Name(ord0, 0x0001)

	Name(lpN0, 0) // level
	Name(lpC0, 0)

	/* Set up the value of flag of Global lock */
	Store(m078(arg0), Local7)

	Subtract(max0, 2, lpN0)
	Store(2, lpC0)
	While (lpN0) {

		Subtract(lpC0, 1, Local0)
		Subtract(lpC0, 2, Local1)

		if (arg1) {
		m088( Local1, 1, 0, 4,  0, rpt0, 0)    // Step -2, Acquire
		m088( Local0, 1, 0, 4,  0, rpt0, 0)    // Step -1, Acquire
		}

		m088( lpC0,   1, 0, 1,  0, rpt0, 0)    // Step  0, Acquire
		m088( Local1, 1, 0, 4, 64, rpt0, 0)    // Step  1, Acquire, AE_AML_MUTEX_ORDER
		m088( Local0, 1, 0, 4, 64, rpt0, 0)    // Step  2, Acquire, AE_AML_MUTEX_ORDER
		m088( lpC0,   1, 0, 4,  0, rpt0, 0)    // Step  3, Acquire
		m089( lpC0,   1, 0, 4,  0, rpt0, ord0) // Step  3, Release
		m089( lpC0,   1, 0, 1,  0, rpt0, ord0) // Step  0, Release

		if (arg1) {
		m089( Local0, 1, 0, 4,  0, rpt0, ord0) // Step -1, Release
		m089( Local1, 1, 0, 4,  0, rpt0, ord0) // Step -2, Release
		}

		Decrement(lpN0)
		Increment(lpC0)
	}

	// Check that all mutexes are Released
	m08a()

	m088( 0, max0, 0, min0,  0, rpt0, 0)    // Step  4, Acquire
	m089( 0, max0, 0, min0,  0, rpt0, ord0) // Step  4, Release

	// Check that all mutexes are Released
	m08a()

	/* Restore the value of flag of Global lock */
	m078(Local7)
}

/*
 * Check the life after AE_AML_MUTEX_ORDER exception on Release
 *
 *  1)     Acquire     (N-1)-th level mutex MUX-(N-1)
 *  2)     Acquire       (N)-th level mutex MUX-N
 *  3) run Release     (N-1)-th level mutex MUX-(N-1) and get AE_AML_MUTEX_ORDER exception
 *  4)     Release       (N)-th level mutex MUX-N     and check that no exception on this operation
 *  5)     Release     (N-1)-th level mutex MUX-(N-1) and check that no exception on this operation
 *  6)     do 1-5 for all N in range 1-15 levels
 *  7)     check additionally that all the mutexes are free (run Release and
 *         get AE_AML_MUTEX_NOT_ACQUIRED exception for all the mutexes of all levels)
 *  8)     Acquire all mutexes of all levels and check that no exceptions
 *  9)     Release all mutexes of all levels and check that no exceptions
 * 10)     check additionally that all the mutexes are free (see 7)
 *
 * 11)     do it for GL mode too
 *
 * arg0 - the value of flag of GL
 */
Method(m08d, 1, Serialized)
{
	Name(rpt0, 1)
	Name(ord0, 0x0001)

	Name(lpN0, 0) // level
	Name(lpC0, 0)

	/* Set up the value of flag of Global lock */
	Store(m078(arg0), Local7)

	Subtract(max0, 1, lpN0)
	Store(1, lpC0)
	While (lpN0) {

		Subtract(lpC0, 1, Local0)


		m088( Local0,  1, 0, min0,  0, rpt0, 0)    // Step  0, Acquire
		m088( lpC0,    1, 0, min0,  0, rpt0, 0)    // Step  1, Acquire

		/* Jump over the level */
		m089( Local0,  1, 0, min0, 64, rpt0, ord0) // Step  2, Release, AE_AML_MUTEX_ORDER

		m089( lpC0,    1, 0, min0,  0, rpt0, ord0) // Step  1, Release
		m089( Local0,  1, 0, min0,  0, rpt0, ord0) // Step  0, Release


		Decrement(lpN0)
		Increment(lpC0)
	}

	// Check that all mutexes are Released
	m08a()

	m088( 0, max0, 0, min0,  0, rpt0, 0)    // Step  3, Acquire
	m089( 0, max0, 0, min0,  0, rpt0, ord0) // Step  3, Release

	// Check that all mutexes are Released
	m08a()

	/* Restore the value of flag of Global lock */
	m078(Local7)
}

/*
 * Check the life after AE_AML_MUTEX_ORDER exception on Release
 *
 * Similar to the m08d but trying to heal situation by
 * Acquiring/Release operations applied to the greater
 * level so changing the current level upper than all the
 * currently Acquired levels so don't expect exceptions on
 * the following Release operations applied in the correct
 * inverse order to all the Acquired mutexes.
 *
 * (for the current 20060828 ACPICA this doesn't help).
 */
Method(m07f,, Serialized)
{
	Name(rpt0, 1)
	Name(ord0, 0x0001)

	Name(lpN0, 0) // level
	Name(lpC0, 0)

	Subtract(max0, 2, lpN0)
	Store(1, lpC0)
	While (lpN0) {

		Subtract(lpC0, 1, Local0)
		Add(lpC0, 1, Local1)


		m088( Local0,  1, 0, min0,  0, rpt0, 0)    // Step  0, Acquire
		m088( lpC0,    1, 0, min0,  0, rpt0, 0)    // Step  1, Acquire

		/* Jump over the level on Releasing */
		m089( Local0,  1, 0, min0, 64, rpt0, ord0) // Step  2, Release, AE_AML_MUTEX_ORDER

		/*
		 * Additional attempt is made to restore the normal calculation -
		 * Acquire the mutex M0 of level greater than all the levels
		 * touched at that moment so changing the current level by the
		 * succeeded operation. Then do Release operations for all
		 * the Acquired mutexes in the correct inverse order starting
		 * with the M0 mutex expecting no exceptions on them.
		 *
		 * (for the current 20060828 ACPICA this doesn't help).
		 */
		m088( lpC0,    1, 0,    1,  0, rpt0, 0)    // Step  3, Acquire
		m088( Local1,  1, 0,    1,  0, rpt0, 0)    // Step  4, Acquire
		m088( lpC0,    1, 0,    1, 64, rpt0, 0)    // Step  5, Acquire, AE_AML_MUTEX_ORDER
		m089( Local1,  1, 0,    1,  0, rpt0, ord0) // Step  4, Release
		m089( lpC0,    1, 0,    1,  0, rpt0, ord0) // Step  3, Release

		m089( lpC0,    1, 0, min0,  0, rpt0, ord0) // Step  1, Release
		m089( Local0,  1, 0, min0,  0, rpt0, ord0) // Step  0, Release


		Decrement(lpN0)
		Increment(lpC0)
	}

	// Check that all mutexes are Released
	m08a()

	m088( 0, max0, 0, min0,  0, rpt0, 0)    // Step  6, Acquire
	m089( 0, max0, 0, min0,  0, rpt0, ord0) // Step  6, Release

	// Check that all mutexes are Released
	m08a()
}

// ############################################### Run-method:

Method(m300)
{
	if (FL03) {
		// Check that all mutexes are Released (doesn't check T804..)
		m08a()
	}

	SRMT("m300")
	if (ERR7) {
		err("ERRORS were detected during the loading stage", z150, 0x200, 0, 0, 0, ERR7)
	}

	/* ATTENTION: this test must be run the first */
	SRMT("m0b9")
	m0b9()


	SRMT("m0bb")
	m0bb()

	SRMT("m301")
	m301()

	SRMT("m369-0")
	m369(0)
	SRMT("m369-1")
	if (y297) {
		m369(1)
	} else {
		BLCK()
	}
	SRMT("m369-0")
	m369(0)

	SRMT("m36a")
	m36a()

	SRMT("m36b")
	m36b()

	SRMT("m36c")
	m36c()

	SRMT("m389")
	m389()

	SRMT("m07b")
	m07b()

	SRMT("m38a")
	if (y238) {
		m38a()
	} else {
		BLCK()
	}

	SRMT("m38d")
	if (y242) {
		m38d()
	} else {
		BLCK()
	}

	SRMT("m07d-direct")
	if (y242) {
		m07d(0x0000)
	} else {
		BLCK()
	}

	SRMT("m07d-inverse")
	m07d(0x0001)

	SRMT("m07a-no-GL")
	m07a(0)

	SRMT("m07a-GL")
	m07a(1)

	SRMT("m07e")
	m07e()

	SRMT("m08b-no-GL-0")
	m08b(0, 0)

	SRMT("m08b-no-GL-1")
	m08b(0, 1)

	SRMT("m08b-GL-0")
	m08b(1, 0)

	SRMT("m08b-GL-1")
	m08b(1, 1)

	SRMT("m08d-no-GL")
	if (y238) {
		m08d(0)
	} else {
		BLCK()
	}

	SRMT("m08d-GL")
	if (y238) {
		m08d(1)
	} else {
		BLCK()
	}

	SRMT("m07f")
	if (y243) {
		m07f()
	} else {
		BLCK()
	}

	SRMT("m07c")
	m07c()

	SRMT("m0ba")
	m0ba()

	/*
	 * To see if the mutex-es framework can continue working after AE_LIMIT.
	 * Now, after AE_LIMIT, it looks can't actually restore -- many messages
	 * during the all further execution of tests, and even the tests
	 * "TEST: WAI0, Wait for Events" somewhere hangs forever:
	 *
	 * **** AcpiExec: Exception AE_LIMIT during execution of method [M369] Opcode [Mutex] @E2
	 * ACPI Exception (utmutex-0376): AE_BAD_PARAMETER, Thread 1475 could not acquire Mutex [0] [20074403]
	 * ACPI Error (exutils-0180): Could not acquire AML Interpreter mutex [20074403]
	 * ACPI Error (utmutex-0421): Mutex [0] is not acquired, cannot release [20074403]
	 * ACPI Error (exutils-0250): Could not release AML Interpreter mutex [20074403]
	 * **** AcpiExec: Exception override, new status AE_OK
	 */
	SRMT("m369-0")
	m369(0)
	SRMT("m369-1")
	if (y297) {
		m369(1)
	} else {
		BLCK()
	}
	SRMT("m369-0")
	m369(0)


	if (FL03) {
		// Check that all mutexes are Released
		m08a()
	}

	CH03("m300", z150, 0x000, 0, 0)
}


