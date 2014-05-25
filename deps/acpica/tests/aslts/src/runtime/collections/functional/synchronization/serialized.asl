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
 * Check for serialized methods
 */

Name(z173, 173)

/*
 * Proper sequence of calls to Serialized methods with different levels, 0-15, all Serialized
 */
Method(m3b0, 0, Serialized, 0)
{
	Name(ts, "m3b0")
	Name(i000, 0)

	Method(m000, 0, Serialized,  0) { Increment(i000) m001() }
	Method(m001, 0, Serialized,  1) { Increment(i000) m002() }
	Method(m002, 0, Serialized,  2) { Increment(i000) m003() }
	Method(m003, 0, Serialized,  3) { Increment(i000) m004() }
	Method(m004, 0, Serialized,  4) { Increment(i000) m005() }
	Method(m005, 0, Serialized,  5) { Increment(i000) m006() }
	Method(m006, 0, Serialized,  6) { Increment(i000) m007() }
	Method(m007, 0, Serialized,  7) { Increment(i000) m008() }
	Method(m008, 0, Serialized,  8) { Increment(i000) m009() }
	Method(m009, 0, Serialized,  9) { Increment(i000) m010() }
	Method(m010, 0, Serialized, 10) { Increment(i000) m011() }
	Method(m011, 0, Serialized, 11) { Increment(i000) m012() }
	Method(m012, 0, Serialized, 12) { Increment(i000) m013() }
	Method(m013, 0, Serialized, 13) { Increment(i000) m014() }
	Method(m014, 0, Serialized, 14) { Increment(i000) m015() }
	Method(m015, 0, Serialized, 15) { Increment(i000) m016() }
	Method(m016, 0, Serialized, 15) {
		Increment(i000)
		Store("m016", Debug)
		if (LNotEqual(i000, 17)) {
			err(ts, z173, 0x000, 0, 0, i000, 17)
		}
	}

	CH03(ts, z173, 0x001, 0, 0)
	m000()
	CH03(ts, z173, 0x002, 0, 0)
}

/*
 * Proper sequence of calls to Serialized methods with different levels, 0-15,
 * alternating Serialized and not-Serialized
 */
Method(m3b1,, Serialized)
{
	Name(ts, "m3b1")
	Name(i000, 0)

	Method(m000, 0, Serialized,  0) { Increment(i000) m001() }
	Method(m001                   ) { Increment(i000) m002() }
	Method(m002, 0, Serialized,  2) { Increment(i000) m003() }
	Method(m003                   ) { Increment(i000) m004() }
	Method(m004                   ) { Increment(i000) m005() }
	Method(m005, 0, Serialized,  5) { Increment(i000) m006() }
	Method(m006, 0, Serialized,  6) { Increment(i000) m007() }
	Method(m007                   ) { Increment(i000) m008() }
	Method(m008, 0, Serialized,  8) { Increment(i000) m009() }
	Method(m009, 0, Serialized,  9) { Increment(i000) m010() }
	Method(m010                   ) { Increment(i000) m011() }
	Method(m011                   ) { Increment(i000) m012() }
	Method(m012, 0, Serialized, 12) { Increment(i000) m013() }
	Method(m013, 0, Serialized, 13) { Increment(i000) m014() }
	Method(m014, 0, Serialized, 14) { Increment(i000) m015() }
	Method(m015                   ) { Increment(i000) m016() }
	Method(m016, 0, Serialized, 15) {
		Increment(i000)
		Store("m016", Debug)
		if (LNotEqual(i000, 17)) {
			err(ts, z173, 0x003, 0, 0, i000, 17)
		}
	}

	CH03(ts, z173, 0x004, 0, 0)
	m000()
	CH03(ts, z173, 0x005, 0, 0)
}

/*
 * Proper sequence of calls to Serialized methods with different levels, 0-15, all Serialized,
 * 1-3 on each level
 */
Method(m3b2, 0, Serialized, 0)
{
	Name(ts, "m3b2")
	Name(i000, 0)
	Name(i001, 0)

	Method(m000, 0, Serialized,   0) { Increment(i000) m100() }
	Method(m100, 0, Serialized,   0) { Increment(i000) m001() }

	Method(m001, 0, Serialized,   1) { Increment(i000) m002() }

	Method(m002, 0, Serialized,   2) { Increment(i000) m102() }
	Method(m102, 0, Serialized,   2) { Increment(i000) m003() }

	Method(m003, 0, Serialized,   3) { Increment(i000) m004() }

	Method(m004, 0, Serialized,   4) { Increment(i000) m104() }
	Method(m104, 0, Serialized,   4) { Increment(i000) m005() }

	Method(m005, 0, Serialized,   5) { Increment(i000) m006() }

	Method(m006, 0, Serialized,   6) { Increment(i000) m106() }
	Method(m106, 0, Serialized,   6) { Increment(i000) m007() }

	Method(m007, 0, Serialized,   7) { Increment(i000) m107() }
	Method(m107, 0, Serialized,   7) { Increment(i000) m008() }

	Method(m008, 0, Serialized,   8) { Increment(i000) m108() }
	Method(m108, 0, Serialized,   8) { Increment(i000) m009() }

	Method(m009, 0, Serialized,   9) { Increment(i000) m109() }
	Method(m109, 0, Serialized,   9) { Increment(i000) m209() }
	Method(m209, 0, Serialized,   9) { Increment(i000) m010() }

	Method(m010, 0, Serialized,  10) { Increment(i000) m110() }
	Method(m110, 0, Serialized,  10) { Increment(i000) m011() }

	Method(m011, 0, Serialized,  11) { Increment(i000) m111() }
	Method(m111, 0, Serialized,  11) { Increment(i000) m012() }

	Method(m012, 0, Serialized,  12) { Increment(i000) m112() }
	Method(m112, 0, Serialized,  12) { Increment(i000) m013() }

	Method(m013, 0, Serialized,  13) { Increment(i000) m014() }

	Method(m014, 0, Serialized,  14) { Increment(i000) m015() }

	Method(m015, 0, Serialized,  15) { Increment(i000) m115() }
	Method(m115, 0, Serialized, 15) {
		Increment(i000)
		Store("m016", Debug)
		if (LNotEqual(i000, 28)) {
			err(ts, z173, 0x006, 0, 0, i000, 28)
		}
		Store(0xabcd0000, i001)
	}

	CH03(ts, z173, 0x007, 0, 0)
	m000()

	if (LNotEqual(i001, 0xabcd0000)) {
		err(ts, z173, 0x008, 0, 0, i001, 0xabcd0000)
	}
	CH03(ts, z173, 0x009, 0, 0)
}

/*
 * Check pairs of calls to Serialized methods,
 * the second method is invoked from the first method.
 *
 * All the 256 combinations are verified (16*16):
 * - the level of the first  method in pair changes in range from 0 up to 15
 * - the level of the second method in pair changes in range from 0 up to 15
 *
 * So all the checkings are provided:
 *
 * -   proper sequence of levels (from i-th level to all possible correct levels)
 * -   proper sequence of levels (from i-th level to i-th level (in particular))
 * - improper sequence of levels (from i-th level to all possible incorrect levels)
 *
 * arg0 - level of first call
 * arg1 - level of second call
 * arg2 - how many calls to do
 */
Method(m3b3, 3, Serialized)
{
	Name(ts, "m3b3")

	Name(i000, 0)
	Name(i001, 0)
	Name(i002, 0)
	Name(i003, 0xabcd0003)
	Name(i004, 0xabcd0004)
	Name(i005, 0)

	Method(m000,1,Serialized, 0) {if (arg0) {Store( 0,i004)} else {Store( 0,i003)} mm00(1,i000,i001)}
	Method(m001,1,Serialized, 1) {if (arg0) {Store( 1,i004)} else {Store( 1,i003)} mm00(1,i000,i001)}
	Method(m002,1,Serialized, 2) {if (arg0) {Store( 2,i004)} else {Store( 2,i003)} mm00(1,i000,i001)}
	Method(m003,1,Serialized, 3) {if (arg0) {Store( 3,i004)} else {Store( 3,i003)} mm00(1,i000,i001)}
	Method(m004,1,Serialized, 4) {if (arg0) {Store( 4,i004)} else {Store( 4,i003)} mm00(1,i000,i001)}
	Method(m005,1,Serialized, 5) {if (arg0) {Store( 5,i004)} else {Store( 5,i003)} mm00(1,i000,i001)}
	Method(m006,1,Serialized, 6) {if (arg0) {Store( 6,i004)} else {Store( 6,i003)} mm00(1,i000,i001)}
	Method(m007,1,Serialized, 7) {if (arg0) {Store( 7,i004)} else {Store( 7,i003)} mm00(1,i000,i001)}
	Method(m008,1,Serialized, 8) {if (arg0) {Store( 8,i004)} else {Store( 8,i003)} mm00(1,i000,i001)}
	Method(m009,1,Serialized, 9) {if (arg0) {Store( 9,i004)} else {Store( 9,i003)} mm00(1,i000,i001)}
	Method(m010,1,Serialized,10) {if (arg0) {Store(10,i004)} else {Store(10,i003)} mm00(1,i000,i001)}
	Method(m011,1,Serialized,11) {if (arg0) {Store(11,i004)} else {Store(11,i003)} mm00(1,i000,i001)}
	Method(m012,1,Serialized,12) {if (arg0) {Store(12,i004)} else {Store(12,i003)} mm00(1,i000,i001)}
	Method(m013,1,Serialized,13) {if (arg0) {Store(13,i004)} else {Store(13,i003)} mm00(1,i000,i001)}
	Method(m014,1,Serialized,14) {if (arg0) {Store(14,i004)} else {Store(14,i003)} mm00(1,i000,i001)}
	Method(m015,1,Serialized,15) {if (arg0) {Store(15,i004)} else {Store(15,i003)} mm00(1,i000,i001)}


	Method(mm00, 3, Serialized)
	{
		Name(iii0, 0)
		Name(iii1, 0)
		Name(iii2, 0)
		Name(iii3, 0)

		Store(i002, Local0)
		Increment(i002)

		if (LGreater(i002, i005)) {
			Return
		}

		if (arg0) {
			Store(arg2, Local1)
		} else {
			Store(arg1, Local1)
		}

		Switch (ToInteger (Local1)) {
			Case (0) {
				m000(Local0)
			}
			Case (1) {
				m001(Local0)
			}
			Case (2) {
				m002(Local0)
			}
			Case (3) {
				m003(Local0)
			}
			Case (4) {
				m004(Local0)
			}
			Case (5) {
				m005(Local0)
			}
			Case (6) {
				m006(Local0)
			}
			Case (7) {
				m007(Local0)
			}
			Case (8) {
				m008(Local0)
			}
			Case (9) {
				m009(Local0)
			}
			Case (10) {
				m010(Local0)
			}
			Case (11) {
				m011(Local0)
			}
			Case (12) {
				m012(Local0)
			}
			Case (13) {
				m013(Local0)
			}
			Case (14) {
				m014(Local0)
			}
			Case (15) {
				m015(Local0)
			}
		}
	}

	CH03(ts, z173, 0x00a, 0, 0)

	Store(arg0, i000)
	Store(arg1, i001)
	Store(arg2, i005)

	mm00(0, i000, i001)

	if (LGreater(arg0, arg1)) {
		CH04(ts, 0, 64, z173, 0x00b, 0, 0) // AE_AML_MUTEX_ORDER
	} else {
		if (LNotEqual(i003, arg0)) {
			err(ts, z173, 0x00c, 0, 0, i003, arg0)
		}
		if (LNotEqual(i004, arg1)) {
			err(ts, z173, 0x00d, 0, 0, i004, arg1)
		}
	}

	CH03(ts, z173, 0x00e, 0, 0)
}

Method(m3b4,, Serialized)
{
	Name(ts, "m3b4")

	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(lpN1, 0)
	Name(lpC1, 0)

	Store(16, lpN0)
	Store(0, lpC0)

	While (lpN0) {
		Store(16, lpN1)
		Store(0, lpC1)
		While (lpN1) {

			m3b3(lpC0, lpC1, 2)

			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * The same as m3b3 but without Switch
 *
 * arg0 - level of first call
 * arg1 - level of second call
 */
Method(m3b5, 2, Serialized)
{
	Name(ts, "m3b5")

	Name(i000, 0)
	Name(i001, 0)
	Name(i002, 0)
	Name(i003, 0xabcd0003)
	Name(i004, 0xabcd0004)

	Method(m000,1,Serialized, 0) {if (arg0) {Store( 0,i004)} else {Store( 0,i003)} mm00(1,i000,i001)}
	Method(m001,1,Serialized, 1) {if (arg0) {Store( 1,i004)} else {Store( 1,i003)} mm00(1,i000,i001)}
	Method(m002,1,Serialized, 2) {if (arg0) {Store( 2,i004)} else {Store( 2,i003)} mm00(1,i000,i001)}
	Method(m003,1,Serialized, 3) {if (arg0) {Store( 3,i004)} else {Store( 3,i003)} mm00(1,i000,i001)}
	Method(m004,1,Serialized, 4) {if (arg0) {Store( 4,i004)} else {Store( 4,i003)} mm00(1,i000,i001)}
	Method(m005,1,Serialized, 5) {if (arg0) {Store( 5,i004)} else {Store( 5,i003)} mm00(1,i000,i001)}
	Method(m006,1,Serialized, 6) {if (arg0) {Store( 6,i004)} else {Store( 6,i003)} mm00(1,i000,i001)}
	Method(m007,1,Serialized, 7) {if (arg0) {Store( 7,i004)} else {Store( 7,i003)} mm00(1,i000,i001)}
	Method(m008,1,Serialized, 8) {if (arg0) {Store( 8,i004)} else {Store( 8,i003)} mm00(1,i000,i001)}
	Method(m009,1,Serialized, 9) {if (arg0) {Store( 9,i004)} else {Store( 9,i003)} mm00(1,i000,i001)}
	Method(m010,1,Serialized,10) {if (arg0) {Store(10,i004)} else {Store(10,i003)} mm00(1,i000,i001)}
	Method(m011,1,Serialized,11) {if (arg0) {Store(11,i004)} else {Store(11,i003)} mm00(1,i000,i001)}
	Method(m012,1,Serialized,12) {if (arg0) {Store(12,i004)} else {Store(12,i003)} mm00(1,i000,i001)}
	Method(m013,1,Serialized,13) {if (arg0) {Store(13,i004)} else {Store(13,i003)} mm00(1,i000,i001)}
	Method(m014,1,Serialized,14) {if (arg0) {Store(14,i004)} else {Store(14,i003)} mm00(1,i000,i001)}
	Method(m015,1,Serialized,15) {if (arg0) {Store(15,i004)} else {Store(15,i003)} mm00(1,i000,i001)}


	Method(mm00, 3)
	{
		Store(i002, Local0)
		Increment(i002)

		if (LGreater(i002, 2)) {
			Return
		}

		if (arg0) {
			Store(arg2, Local1)
		} else {
			Store(arg1, Local1)
		}

		if (LEqual(Local1, 0)) {
			m000(Local0)
		} elseif (LEqual(Local1, 1)) {
			m001(Local0)
		} elseif (LEqual(Local1, 2)) {
			m002(Local0)
		} elseif (LEqual(Local1, 3)) {
			m003(Local0)
		} elseif (LEqual(Local1, 4)) {
			m004(Local0)
		} elseif (LEqual(Local1, 5)) {
			m005(Local0)
		} elseif (LEqual(Local1, 6)) {
			m006(Local0)
		} elseif (LEqual(Local1, 7)) {
			m007(Local0)
		} elseif (LEqual(Local1, 8)) {
			m008(Local0)
		} elseif (LEqual(Local1, 9)) {
			m009(Local0)
		} elseif (LEqual(Local1, 10)) {
			m010(Local0)
		} elseif (LEqual(Local1, 11)) {
			m011(Local0)
		} elseif (LEqual(Local1, 12)) {
			m012(Local0)
		} elseif (LEqual(Local1, 13)) {
			m013(Local0)
		} elseif (LEqual(Local1, 14)) {
			m014(Local0)
		} elseif (LEqual(Local1, 15)) {
			m015(Local0)
		}
	}

	CH03(ts, z173, 0x00f, 0, 0)

	Store(arg0, i000)
	Store(arg1, i001)

	mm00(0, i000, i001)

	if (LGreater(arg0, arg1)) {
		CH04(ts, 0, 64, z173, 0x010, 0, 0) // AE_AML_MUTEX_ORDER
	} else {
		if (LNotEqual(i003, arg0)) {
			err(ts, z173, 0x011, 0, 0, i003, arg0)
		}
		if (LNotEqual(i004, arg1)) {
			err(ts, z173, 0x012, 0, 0, i004, arg1)
		}
	}

	CH03(ts, z173, 0x013, 0, 0)
}

Method(m3b6,, Serialized)
{
	Name(ts, "m3b6")

	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(lpN1, 0)
	Name(lpC1, 0)

	Store(16, lpN0)
	Store(0, lpC0)

	While (lpN0) {
		Store(16, lpN1)
		Store(0, lpC1)
		While (lpN1) {

			m3b5(lpC0, lpC1)

			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * The same as m3b5 but
 * between two Serialized calls non-Serialized calls are performed
 *
 * arg0 - level of first call
 * arg1 - level of second call
 * arg2 - how many calls to do
 */
Method(m3b7, 3, Serialized)
{
	Name(ts, "m3b5")

	Name(i000, 0)
	Name(i001, 0)
	Name(i002, 0)
	Name(i003, 0xabcd0003)
	Name(i004, 0xabcd0004)
	Name(i005, 0)

	Method(m000,1,Serialized, 0) {if (arg0) {Store( 0,i004)} else {Store( 0,i003)} mm00(1,i000,i001)}
	Method(m001,1,Serialized, 1) {if (arg0) {Store( 1,i004)} else {Store( 1,i003)} mm00(1,i000,i001)}
	Method(m002,1,Serialized, 2) {if (arg0) {Store( 2,i004)} else {Store( 2,i003)} mm00(1,i000,i001)}
	Method(m003,1,Serialized, 3) {if (arg0) {Store( 3,i004)} else {Store( 3,i003)} mm00(1,i000,i001)}
	Method(m004,1,Serialized, 4) {if (arg0) {Store( 4,i004)} else {Store( 4,i003)} mm00(1,i000,i001)}
	Method(m005,1,Serialized, 5) {if (arg0) {Store( 5,i004)} else {Store( 5,i003)} mm00(1,i000,i001)}
	Method(m006,1,Serialized, 6) {if (arg0) {Store( 6,i004)} else {Store( 6,i003)} mm00(1,i000,i001)}
	Method(m007,1,Serialized, 7) {if (arg0) {Store( 7,i004)} else {Store( 7,i003)} mm00(1,i000,i001)}
	Method(m008,1,Serialized, 8) {if (arg0) {Store( 8,i004)} else {Store( 8,i003)} mm00(1,i000,i001)}
	Method(m009,1,Serialized, 9) {if (arg0) {Store( 9,i004)} else {Store( 9,i003)} mm00(1,i000,i001)}
	Method(m010,1,Serialized,10) {if (arg0) {Store(10,i004)} else {Store(10,i003)} mm00(1,i000,i001)}
	Method(m011,1,Serialized,11) {if (arg0) {Store(11,i004)} else {Store(11,i003)} mm00(1,i000,i001)}
	Method(m012,1,Serialized,12) {if (arg0) {Store(12,i004)} else {Store(12,i003)} mm00(1,i000,i001)}
	Method(m013,1,Serialized,13) {if (arg0) {Store(13,i004)} else {Store(13,i003)} mm00(1,i000,i001)}
	Method(m014,1,Serialized,14) {if (arg0) {Store(14,i004)} else {Store(14,i003)} mm00(1,i000,i001)}
	Method(m015,1,Serialized,15) {if (arg0) {Store(15,i004)} else {Store(15,i003)} mm00(1,i000,i001)}

	Method(mm01, 7)
	{
		Store(0, Local0)
	}


	Method(mm00, 3)
	{
		Store(i002, Local0)
		Increment(i002)

		if (LGreater(i002, i005)) {
			Return
		}

		if (arg0) {
			Store(arg2, Local1)
		} else {
			Store(arg1, Local1)
		}

		if (LEqual(Local1, 0)) {
			mm01(0,1,2,3,4,5,6)
			m000(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 1)) {
			mm01(0,1,2,3,4,5,6)
			m001(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 2)) {
			mm01(0,1,2,3,4,5,6)
			m002(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 3)) {
			mm01(0,1,2,3,4,5,6)
			m003(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 4)) {
			mm01(0,1,2,3,4,5,6)
			m004(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 5)) {
			mm01(0,1,2,3,4,5,6)
			m005(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 6)) {
			mm01(0,1,2,3,4,5,6)
			m006(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 7)) {
			mm01(0,1,2,3,4,5,6)
			m007(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 8)) {
			mm01(0,1,2,3,4,5,6)
			m008(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 9)) {
			mm01(0,1,2,3,4,5,6)
			m009(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 10)) {
			mm01(0,1,2,3,4,5,6)
			m010(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 11)) {
			mm01(0,1,2,3,4,5,6)
			m011(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 12)) {
			mm01(0,1,2,3,4,5,6)
			m012(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 13)) {
			mm01(0,1,2,3,4,5,6)
			m013(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 14)) {
			mm01(0,1,2,3,4,5,6)
			m014(Local0)
			mm01(0,1,2,3,4,5,6)
		} elseif (LEqual(Local1, 15)) {
			mm01(0,1,2,3,4,5,6)
			m015(Local0)
			mm01(0,1,2,3,4,5,6)
		}
	}

	CH03(ts, z173, 0x014, 0, 0)

	Store(arg0, i000)
	Store(arg1, i001)
	Store(arg2, i005)

	mm00(0, i000, i001)

	if (LGreater(arg0, arg1)) {
		CH04(ts, 0, 64, z173, 0x015, 0, 0) // AE_AML_MUTEX_ORDER
	} else {
		if (LNotEqual(i003, arg0)) {
			err(ts, z173, 0x016, 0, 0, i003, arg0)
		}
		if (LNotEqual(i004, arg1)) {
			err(ts, z173, 0x017, 0, 0, i004, arg1)
		}
	}

	CH03(ts, z173, 0x018, 0, 0)
}

Method(m3b8,, Serialized)
{
	Name(ts, "m3b6")

	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(lpN1, 0)
	Name(lpC1, 0)

	Store(16, lpN0)
	Store(0, lpC0)

	While (lpN0) {
		Store(16, lpN1)
		Store(0, lpC1)
		While (lpN1) {

			m3b7(lpC0, lpC1, 2)

			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Check that Serialized method can be invoked repeatedly
 *
 * (Serialized method without internal objects (including Methods) and Switches)
 *
 * Method is invoked 2 times, then 3 times, then 4 times,...
 * Then do it for next Method.
 */
Method(m3b9,, Serialized)
{
	Name(ts, "m3b9")

	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(lpN1, 0)
	Name(lpC1, 0)

	Store(16, lpN0)
	Store(0, lpC0)

	While (lpN0) {
		Store(16, lpN1)
		Store(2, lpC1)
		While (lpN1) {

			m3b3(lpC0, lpC0, lpC1)

			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Check that Serialized method can be invoked repeatedly
 *
 * (Serialized method without internal objects (including Methods) and Switches)
 *
 * between two Serialized calls non-Serialized calls are performed
 *
 * Method is invoked 2 times, then 3 times, then 4 times,...
 * Then do it for next Method.
 */
Method(m3ba,, Serialized)
{
	Name(ts, "m3ba")

	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(lpN1, 0)
	Name(lpC1, 0)

	Store(16, lpN0)
	Store(0, lpC0)

	While (lpN0) {
		Store(16, lpN1)
		Store(2, lpC1)
		While (lpN1) {

			m3b7(lpC0, lpC0, lpC1)

			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * The level is set up by either call to Serialized method or Acquire mutex of that level
 *
 * Check pairs of calls to methods which provide exclusive access to critical sections
 * either by 'Serialized method' technique or AML mutexes (Acquire/Release) framework.
 * The second method is invoked from the first method.
 *
 * All the 1024 combinations are verified (32*32):
 *
 * The first call to method in pair is call to:
 * - Serialized method with level in range from 0 up to 15
 * - non-Serialized method Acquiring mutex with level in range from 0 up to 15
 *
 * Identically, the second call to method in pair is call to:
 * - Serialized method with level in range from 0 up to 15
 * - non-Serialized method Acquiring mutex with level in range from 0 up to 15
 *
 * So all the checkings are provided:
 *
 * -   proper sequence of levels (from i-th level to all possible correct levels)
 * -   proper sequence of levels (from i-th level to i-th level (in particular))
 * - improper sequence of levels (from i-th level to all possible incorrect levels)
 *
 * arg0 - level of first call
 * arg1 - level of second call
 * arg2 - how many calls to do
 */
Method(m3bb, 3, Serialized)
{
	Name(ts, "m3bb")

	Name(i000, 0)
	Name(i001, 0)
	Name(i002, 0)
	Name(i003, 0xabcd0003)
	Name(i004, 0xabcd0004)
	Name(i005, 0)

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

	Method(m000,1,Serialized, 0) {if (arg0) {Store( 0,i004)} else {Store( 0,i003)} mm00(1,i000,i001)}
	Method(m001,1,Serialized, 1) {if (arg0) {Store( 1,i004)} else {Store( 1,i003)} mm00(1,i000,i001)}
	Method(m002,1,Serialized, 2) {if (arg0) {Store( 2,i004)} else {Store( 2,i003)} mm00(1,i000,i001)}
	Method(m003,1,Serialized, 3) {if (arg0) {Store( 3,i004)} else {Store( 3,i003)} mm00(1,i000,i001)}
	Method(m004,1,Serialized, 4) {if (arg0) {Store( 4,i004)} else {Store( 4,i003)} mm00(1,i000,i001)}
	Method(m005,1,Serialized, 5) {if (arg0) {Store( 5,i004)} else {Store( 5,i003)} mm00(1,i000,i001)}
	Method(m006,1,Serialized, 6) {if (arg0) {Store( 6,i004)} else {Store( 6,i003)} mm00(1,i000,i001)}
	Method(m007,1,Serialized, 7) {if (arg0) {Store( 7,i004)} else {Store( 7,i003)} mm00(1,i000,i001)}
	Method(m008,1,Serialized, 8) {if (arg0) {Store( 8,i004)} else {Store( 8,i003)} mm00(1,i000,i001)}
	Method(m009,1,Serialized, 9) {if (arg0) {Store( 9,i004)} else {Store( 9,i003)} mm00(1,i000,i001)}
	Method(m010,1,Serialized,10) {if (arg0) {Store(10,i004)} else {Store(10,i003)} mm00(1,i000,i001)}
	Method(m011,1,Serialized,11) {if (arg0) {Store(11,i004)} else {Store(11,i003)} mm00(1,i000,i001)}
	Method(m012,1,Serialized,12) {if (arg0) {Store(12,i004)} else {Store(12,i003)} mm00(1,i000,i001)}
	Method(m013,1,Serialized,13) {if (arg0) {Store(13,i004)} else {Store(13,i003)} mm00(1,i000,i001)}
	Method(m014,1,Serialized,14) {if (arg0) {Store(14,i004)} else {Store(14,i003)} mm00(1,i000,i001)}
	Method(m015,1,Serialized,15) {if (arg0) {Store(15,i004)} else {Store(15,i003)} mm00(1,i000,i001)}

	Method(m100, 2) {
		if (arg0) {
			Store(16, i004)
		} else {
			Store(16, i003)
		}
		Store(Acquire(MT00, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MT00)
		}
	}
	Method(m101, 2) {
		if (arg0) {
			Store(17, i004)
		} else {
			Store(17, i003)
		}
		Store(Acquire(MT10, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MT10)
		}
	}
	Method(m102, 2) {
		if (arg0) {
			Store(18, i004)
		} else {
			Store(18, i003)
		}
		Store(Acquire(MT20, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MT20)
		}
	}
	Method(m103, 2) {
		if (arg0) {
			Store(19, i004)
		} else {
			Store(19, i003)
		}
		Store(Acquire(MT30, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MT30)
		}
	}
	Method(m104, 2) {
		if (arg0) {
			Store(20, i004)
		} else {
			Store(20, i003)
		}
		Store(Acquire(MT40, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MT40)
		}
	}
	Method(m105, 2) {
		if (arg0) {
			Store(21, i004)
		} else {
			Store(21, i003)
		}
		Store(Acquire(MT50, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MT50)
		}
	}
	Method(m106, 2) {
		if (arg0) {
			Store(22, i004)
		} else {
			Store(22, i003)
		}
		Store(Acquire(MT60, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MT60)
		}
	}
	Method(m107, 2) {
		if (arg0) {
			Store(23, i004)
		} else {
			Store(23, i003)
		}
		Store(Acquire(MT70, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MT70)
		}
	}
	Method(m108, 2) {
		if (arg0) {
			Store(24, i004)
		} else {
			Store(24, i003)
		}
		Store(Acquire(MT80, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MT80)
		}
	}
	Method(m109, 2) {
		if (arg0) {
			Store(25, i004)
		} else {
			Store(25, i003)
		}
		Store(Acquire(MT90, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MT90)
		}
	}
	Method(m110, 2) {
		if (arg0) {
			Store(26, i004)
		} else {
			Store(26, i003)
		}
		Store(Acquire(MTa0, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MTa0)
		}
	}
	Method(m111, 2) {
		if (arg0) {
			Store(27, i004)
		} else {
			Store(27, i003)
		}
		Store(Acquire(MTb0, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MTb0)
		}
	}
	Method(m112, 2) {
		if (arg0) {
			Store(28, i004)
		} else {
			Store(28, i003)
		}
		Store(Acquire(MTc0, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MTc0)
		}
	}
	Method(m113, 2) {
		if (arg0) {
			Store(29, i004)
		} else {
			Store(29, i003)
		}
		Store(Acquire(MTd0, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MTd0)
		}
	}
	Method(m114, 2) {
		if (arg0) {
			Store(30, i004)
		} else {
			Store(30, i003)
		}
		Store(Acquire(MTe0, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MTe0)
		}
	}
	Method(m115, 2) {
		if (arg0) {
			Store(31, i004)
		} else {
			Store(31, i003)
		}
		Store(Acquire(MTf0, 0xffff), Local0)
		mm00(1, i000, i001)
		if (arg1) {
			if (Local0) {
				err(ts, z173, 0x019, 0, 0, 0, Local0)
			}
		}
		if (LNot(Local0)) {
			Release(MTf0)
		}
	}

	/*
	 * arg0 - 0 - first call, otherwise - non-first call
	 * arg1 - level of first call
	 * arg2 - level of second call
	 */
	Method(mm00, 3, Serialized)
	{
		Store(i002, Local0)
		Increment(i002)

		if (LGreater(i002, i005)) {
			Return
		}

		if (arg0) {
			Store(arg2, Local1)
		} else {
			Store(arg1, Local1)
		}

		if (arg0) {
			// non-first call
			if (LGreaterEqual(arg1, 16)) {
				Subtract(arg1, 16, Local2)
			} else {
				Store(arg1, Local2)
			}
			if (LGreaterEqual(arg2, 16)) {
				Subtract(arg2, 16, Local3)
			} else {
				Store(arg2, Local3)
			}
			if (LGreater(Local2, Local3)) {
				Store(0, Local4)
			} else {
				Store(1, Local4) // Check return of Acquire, success is expected
			}
		} else {
			// first call
			Store(1, Local4) // Check return of Acquire, success is expected
		}

		Switch (ToInteger (Local1)) {
			Case (0) {
				m000(Local0)
			}
			Case (1) {
				m001(Local0)
			}
			Case (2) {
				m002(Local0)
			}
			Case (3) {
				m003(Local0)
			}
			Case (4) {
				m004(Local0)
			}
			Case (5) {
				m005(Local0)
			}
			Case (6) {
				m006(Local0)
			}
			Case (7) {
				m007(Local0)
			}
			Case (8) {
				m008(Local0)
			}
			Case (9) {
				m009(Local0)
			}
			Case (10) {
				m010(Local0)
			}
			Case (11) {
				m011(Local0)
			}
			Case (12) {
				m012(Local0)
			}
			Case (13) {
				m013(Local0)
			}
			Case (14) {
				m014(Local0)
			}
			Case (15) {
				m015(Local0)
			}


			Case (16) {
				m100(Local0, Local4)
			}
			Case (17) {
				m101(Local0, Local4)
			}
			Case (18) {
				m102(Local0, Local4)
			}
			Case (19) {
				m103(Local0, Local4)
			}
			Case (20) {
				m104(Local0, Local4)
			}
			Case (21) {
				m105(Local0, Local4)
			}
			Case (22) {
				m106(Local0, Local4)
			}
			Case (23) {
				m107(Local0, Local4)
			}
			Case (24) {
				m108(Local0, Local4)
			}
			Case (25) {
				m109(Local0, Local4)
			}
			Case (26) {
				m110(Local0, Local4)
			}
			Case (27) {
				m111(Local0, Local4)
			}
			Case (28) {
				m112(Local0, Local4)
			}
			Case (29) {
				m113(Local0, Local4)
			}
			Case (30) {
				m114(Local0, Local4)
			}
			Case (31) {
				m115(Local0, Local4)
			}
		}
	}

	CH03(ts, z173, 0x00a, 0, 0)

	Store(arg0, i000)
	Store(arg1, i001)
	Store(arg2, i005)

	mm00(0, i000, i001)

	if (LGreaterEqual(arg0, 16)) {
		Subtract(arg0, 16, Local2)
	} else {
		Store(arg0, Local2)
	}
	if (LGreaterEqual(arg1, 16)) {
		Subtract(arg1, 16, Local3)
	} else {
		Store(arg1, Local3)
	}
	if (LGreater(Local2, Local3)) {
		Store(0, Local4)
	} else {
		Store(1, Local4) // Success is expected, no exceptions
	}

	if (LNot(Local4)) {
		CH04(ts, 1, 64, z173, 0x00b, 0, 0) // AE_AML_MUTEX_ORDER
	} else {
		if (LNotEqual(i003, arg0)) {
			err(ts, z173, 0x00c, 0, 0, i003, arg0)
		}
		if (LNotEqual(i004, arg1)) {
			err(ts, z173, 0x00d, 0, 0, i004, arg1)
		}
	}

	CH03(ts, z173, 0x00e, 0, 0)
}

Method(m3bc,, Serialized)
{
	Name(ts, "m3bc")

	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(lpN1, 0)
	Name(lpC1, 0)

	Store(32, lpN0)
	Store(0, lpC0)

	While (lpN0) {
		Store(32, lpN1)
		Store(0, lpC1)
		While (lpN1) {

			m3bb(lpC0, lpC1, 2)

			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

Method(m3bd)
{
	SRMT("m3b0")
	m3b0()

	SRMT("m3b1")
	m3b1()

	SRMT("m3b2")
	m3b2()

	SRMT("m3b4")
	if (y300) {
		m3b4()
	} else {
		BLCK()
	}

	SRMT("m3b6")
	m3b6()

	SRMT("m3b8")
	m3b8()

	SRMT("m3b9")
	if (y300) {
		m3b9()
	} else {
		BLCK()
	}

	SRMT("m3ba")
	m3ba()

	SRMT("m3bc")
	if (y300) {
		m3bc()
	} else {
		BLCK()
	}
}


