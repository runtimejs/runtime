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
 * References
 */

Name(z110, 110)

// The number of repetitions
//
// Minimum: 26*6=156
Name(rep0, 1000)

// Strategies of traveling the Cases of Switch

// Total number of Cases
Name(maxf, 100)

// Current indexes inside groups
Name(i200, 0)
Name(i201, 0)
Name(i202, 0)
Name(i203, 0)
Name(i204, 0)
Name(i205, 0)

/*
 * Mix of groups strategy
 *
 * Distribution of (6) groups:
 *
 * 0) Cases   0 - 13 (14)
 * 1) Cases  14 - 19 (6)
 * 2) Cases  20 - 33 (14)
 * 3) Cases  34 - 47 (14)
 * 4) Cases  48 - 73 (26)
 * 5) Cases  74 - 99 (26)
 *
 * arg0 - index of iteration
 */
Method(m1e1, 1, Serialized)
{
	Mod(arg0, 6, Local7)

	// Groups
	Switch (ToInteger(Local7)) {
		Case (0) {
			Mod(i200, 14, Local1)
			Increment(i200)
		}
		Case (1) {
			Mod(i201, 6, Local0)
			Add(14, Local0, Local1)
			Increment(i201)
		}
		Case (2) {
			Mod(i202, 14, Local0)
			Add(20, Local0, Local1)
			Increment(i202)
		}
		Case (3) {
			Mod(i203, 14, Local0)
			Add(34, Local0, Local1)
			Increment(i203)
		}
		Case (4) {
			Mod(i204, 26, Local0)
			Add(48, Local0, Local1)
			Increment(i204)
		}
		Case (5) {
			Mod(i205, 26, Local0)
			Add(74, Local0, Local1)
			Increment(i205)
		}
		Default {
			err("m1e2", z110, 0, 0, 0, Local7, 0)
		}
	}

	return (Local1)
}

// Mod-6 strategy
//
// Observed, it causes many "Outstanding allocations"
//
// arg0 - index of iteration
Method(m1e2, 1)
{
	Mod(arg0, 6, Local7)
	return (Local7)
}

// Linear strategy
//
// arg0 - index of iteration
Method(m1e3, 1)
{
	Mod(arg0, maxf, Local7)
	return (Local7)
}

// arg0 - strategy of traveling the Cases of Switch
Method(m1e0, 1, Serialized)
{
/*
	// ################################## Check all the test:

	// Packages for _TCI statistics
	Name(LLL0, Package(1) {})
	Name(LLL1, Package(1) {})
	Name(LLL2, Package(1) {})

	// Create and initialize the Memory Consumption Statistics Packages

	Store(m3a0(c200), LLL0)	// _TCI-end statistics
	Store(m3a0(c201), LLL1)	// _TCI-begin statistics
	Store(m3a0(0), LLL2)	// difference

	_TCI(c200, LLL0)
	// ################################## Check all the test.
*/


	Name(ts, "m1e0")

	Name(pr, 0)

	Name(ind0, 0)

	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(z110, c081) // absolute index of file initiating the checking

	Store(rep0, lpN0)
	Store(0, lpC0)

	if (LEqual(arg0, 1)) {
		Store("Mix of groups strategy", Debug)
	} elseif (LEqual(arg0, 2)) {
		Store("Mod-6 strategy", Debug)
	} else {
		Store("Linear strategy", Debug)
	}

	While (lpN0) {

	    if (pr) {
		    Store(lpC0, Debug)
	    }

	    if (LEqual(arg0, 1)) {
		    Store(m1e1(lpC0), ind0)
	    } elseif (LEqual(arg0, 2)) {
		    Store(m1e2(lpC0), ind0)
	    } else {
		    Store(m1e3(lpC0), ind0)
	    }

	    Switch (ToInteger(ind0)) {

	            // ========================= Group 0:

	            // All types
	            // (from m1b1: CopyObject of Object to LocalX)

            Case (0) {
	            CopyObject(i900, Local0)
	            m1a3(Local0, c009, z110, ts, 0)
            }
            Case (1) {
	            CopyObject(s900, Local0)
	            m1a3(Local0, c00a, z110, ts, 1)
            }
            Case (2) {
	            CopyObject(b900, Local0)
	            m1a3(Local0, c00b, z110, ts, 2)
            }
            Case (3) {
	            CopyObject(p900, Local0)
	            m1a3(Local0, c00c, z110, ts, 3)
            }
            Case (4) {
	            CopyObject(f900, Local0)
	            m1a3(Local0, c009, z110, ts, 4)
            }
            Case (5) {
	            CopyObject(RefOf(d900), Local0)
	            m1a3(Local0, c00e, z110, ts, 5)
            }
            Case (6) {
	            CopyObject(RefOf(e900), Local0)
	            m1a3(Local0, c00f, z110, ts, 6)
            }
            Case (7) {
	            if (rn06) {
		            CopyObject(RefOf(m901), Local0)
	            } else {
		            CopyObject(RefOf(m901), Local0)
	            }
	            m1a3(Local0, c010, z110, ts, 7)
            }
            Case (8) {
	            CopyObject(RefOf(mx90), Local0)
	            m1a3(Local0, c011, z110, ts, 8)
            }
            Case (9) {
	            if (y510) {
		            CopyObject(RefOf(r900), Local0)
		            m1a3(Local0, c012, z110, ts, 9)
	            }
            }
            Case (10) {
	            CopyObject(RefOf(pw90), Local0)
	            m1a3(Local0, c013, z110, ts, 10)
            }
            Case (11) {
	            CopyObject(RefOf(pr90), Local0)
	            m1a3(Local0, c014, z110, ts, 11)
            }
            Case (12) {
	            if (y508) {
		            CopyObject(RefOf(tz90), Local0)
		            m1a3(Local0, c015, z110, ts, 12)
	            }
            }
            Case (13) {
	            CopyObject(bf90, Local0)
	            m1a3(Local0, c009, z110, ts, 13)
            }

	            // ========================= Group 1:

	            // All available for Store types
	            // (from m1b2: Store of Object to LocalX)

            Case (14) {
	            Store(i900, Local0)
	            m1a3(Local0, c009, z110, ts, 14)
            }
            Case (15) {
	            Store(s900, Local0)
	            m1a3(Local0, c00a, z110, ts, 15)
            }
            Case (16) {
	            Store(b900, Local0)
	            m1a3(Local0, c00b, z110, ts, 16)
            }
            Case (17) {
	            Store(p900, Local0)
	            m1a3(Local0, c00c, z110, ts, 17)
            }
            Case (18) {
	            Store(f900, Local0)
	            m1a3(Local0, c009, z110, ts, 18)
            }
            Case (19) {
	            Store(bf90, Local0)
	            m1a3(Local0, c009, z110, ts, 19)
            }

	            // ========================= Group 2:

	            // All types
	            // (from m1b4: CopyObject the result of RefOf/CondRefOf to LocalX)

            Case (20) {
	            CopyObject(RefOf(i900), Local0)
	            m1a3(Local0, c009, z110, ts, 20)
            }
            Case (21) {
	            CopyObject(RefOf(s900), Local0)
	            m1a3(Local0, c00a, z110, ts, 21)
            }
            Case (22) {
	            CopyObject(RefOf(b900), Local0)
	            m1a3(Local0, c00b, z110, ts, 22)
            }
            Case (23) {
	            CopyObject(RefOf(p900), Local0)
	            m1a3(Local0, c00c, z110, ts, 23)
            }
            Case (24) {
	            CopyObject(RefOf(f900), Local0)
	            m1a3(Local0, c00d, z110, ts, 24)
            }
            Case (25) {
	            CopyObject(RefOf(d900), Local0)
	            m1a3(Local0, c00e, z110, ts, 25)
            }
            Case (26) {
	            CopyObject(RefOf(e900), Local0)
	            m1a3(Local0, c00f, z110, ts, 26)
            }
            Case (27) {
	            CopyObject(RefOf(m901), Local0)
	            m1a3(Local0, c010, z110, ts, 27)
            }
            Case (28) {
	            CopyObject(RefOf(mx90), Local0)
	            m1a3(Local0, c011, z110, ts, 28)
            }
            Case (29) {
                CopyObject(RefOf(r900), Local0)
                m1a3(Local0, c012, z110, ts, 29)
            }
            Case (30) {
	            CopyObject(RefOf(pw90), Local0)
	            m1a3(Local0, c013, z110, ts, 30)
            }
            Case (31) {
	            CopyObject(RefOf(pr90), Local0)
	            m1a3(Local0, c014, z110, ts, 31)
            }
            Case (32) {
		            CopyObject(RefOf(tz90), Local0)
		            m1a3(Local0, c015, z110, ts, 32)
            }
            Case (33) {
	            CopyObject(RefOf(bf90), Local0)
	            m1a3(Local0, c016, z110, ts, 33)
            }

	            // ========================= Group 3:

	            // All types
	            // (from m1b5: Store the result of RefOf/CondRefOf to LocalX)

            Case (34) {
	            Store(RefOf(i900), Local0)
	            m1a3(Local0, c009, z110, ts, 34)
            }
            Case (35) {
	            Store(RefOf(s900), Local0)
	            m1a3(Local0, c00a, z110, ts, 35)
            }
            Case (36) {
	            Store(RefOf(b900), Local0)
	            m1a3(Local0, c00b, z110, ts, 36)
            }
            Case (37) {
	            Store(RefOf(p900), Local0)
	            m1a3(Local0, c00c, z110, ts, 37)
            }
            Case (38) {
	            Store(RefOf(f900), Local0)
	            m1a3(Local0, c00d, z110, ts, 38)
            }
            Case (39) {
	            Store(RefOf(d900), Local0)
	            m1a3(Local0, c00e, z110, ts, 39)
            }
            Case (40) {
	            Store(RefOf(e900), Local0)
	            m1a3(Local0, c00f, z110, ts, 40)
            }
            Case (41) {
	            Store(RefOf(m901), Local0)
	            m1a3(Local0, c010, z110, ts, 41)
            }
            Case (42) {
	            Store(RefOf(mx90), Local0)
	            m1a3(Local0, c011, z110, ts, 42)
            }
            Case (43) {
                Store(RefOf(r900), Local0)
                m1a3(Local0, c012, z110, ts, 43)
            }
            Case (44) {
	            Store(RefOf(pw90), Local0)
	            m1a3(Local0, c013, z110, ts, 44)
            }
            Case (45) {
	            Store(RefOf(pr90), Local0)
	            m1a3(Local0, c014, z110, ts, 45)
            }
            Case (46) {
		        Store(RefOf(tz90), Local0)
		        m1a3(Local0, c015, z110, ts, 46)
            }
            Case (47) {
	            Store(RefOf(bf90), Local0)
	            m1a3(Local0, c016, z110, ts, 47)
            }

	            // ========================= Group 4:

	            // From m1b6: CopyObject the result of Index to LocalX

	            // Computational Data

            Case (48) {
	            CopyObject(Index(s900, 1, Local0), Local1)
	            m1a3(Local0, c016, z110, ts, 48)
	            m1a3(Local1, c016, z110, ts, 49)
            }
            Case (49) {
	            CopyObject(Index(b900, 1, Local0), Local1)
	            m1a3(Local0, c016, z110, ts, 50)
	            m1a3(Local1, c016, z110, ts, 51)
            }

	            // Elements of Package are Uninitialized

            Case (50) {
	            if (y127) {
		            CopyObject(Index(p900, 0, Local0), Local1)
		            m1a3(Local0, c008, z110, ts, 52)
		            m1a3(Local1, c008, z110, ts, 53)
	            }
            }

	            // Elements of Package are Computational Data

            Case (51) {
	            CopyObject(Index(p901, 1, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 54)
	            m1a3(Local1, c009, z110, ts, 55)
            }
            Case (52) {
	            CopyObject(Index(p904, 1, Local0), Local1)
	            m1a3(Local0, c00b, z110, ts, 56)
	            m1a3(Local1, c00b, z110, ts, 57)
            }
            Case (53) {
	            CopyObject(Index(p905, 0, Local0), Local1)
	            m1a3(Local0, c00c, z110, ts, 58)
	            m1a3(Local1, c00c, z110, ts, 59)
            }
            Case (54) {
	            CopyObject(Index(p90d, 0, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 60)
	            m1a3(Local1, c009, z110, ts, 61)
            }
            Case (55) {
	            CopyObject(Index(p90e, 0, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 62)
	            m1a3(Local1, c009, z110, ts, 63)
            }
            Case (56) {
	            CopyObject(Index(p90f, 0, Local0), Local1)
	            m1a3(Local0, c00a, z110, ts, 64)
	            m1a3(Local1, c00a, z110, ts, 65)
            }
            Case (57) {
	            CopyObject(Index(p910, 0, Local0), Local1)
	            m1a3(Local0, c00a, z110, ts, 66)
	            m1a3(Local1, c00a, z110, ts, 67)
            }
            Case (58) {
	            CopyObject(Index(p911, 0, Local0), Local1)
	            m1a3(Local0, c00b, z110, ts, 68)
	            m1a3(Local1, c00b, z110, ts, 69)
            }
            Case (59) {
	            CopyObject(Index(p912, 0, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 70)
	            m1a3(Local1, c009, z110, ts, 71)
            }
            Case (60) {
	            CopyObject(Index(p913, 0, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 72)
	            m1a3(Local1, c009, z110, ts, 73)
            }
            Case (61) {
	            CopyObject(Index(p914, 0, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 74)
	            m1a3(Local1, c009, z110, ts, 75)
            }
            Case (62) {
	            CopyObject(Index(p915, 0, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 76)
	            m1a3(Local1, c009, z110, ts, 77)
            }

	            // Elements of Package are NOT Computational Data

            Case (63) {
	            CopyObject(Index(p916, 0, Local0), Local1)
	            m1a3(Local0, c00e, z110, ts, 78)
	            m1a3(Local1, c00e, z110, ts, 79)
            }
            Case (64) {
	            CopyObject(Index(p917, 0, Local0), Local1)
	            m1a3(Local0, c00f, z110, ts, 80)
	            m1a3(Local1, c00f, z110, ts, 81)
            }
            Case (65) {
	            CopyObject(Index(p918, 0, Local0), Local1)
	            m1a3(Local0, c011, z110, ts, 82)
	            m1a3(Local1, c011, z110, ts, 83)
            }
            Case (66) {
	            CopyObject(Index(p919, 0, Local0), Local1)
	            m1a3(Local0, c012, z110, ts, 84)
	            m1a3(Local1, c012, z110, ts, 85)
            }
            Case (67) {
	            CopyObject(Index(p91a, 0, Local0), Local1)
	            m1a3(Local0, c013, z110, ts, 86)
	            m1a3(Local1, c013, z110, ts, 87)
            }
            Case (68) {
	            CopyObject(Index(p91b, 0, Local0), Local1)
	            m1a3(Local0, c014, z110, ts, 88)
	            m1a3(Local1, c014, z110, ts, 89)
            }
            Case (69) {
	            CopyObject(Index(p91c, 0, Local0), Local1)
	            m1a3(Local0, c015, z110, ts, 90)
	            m1a3(Local1, c015, z110, ts, 91)
            }

	            // Elements of Package are Methods

            Case (70) {
	            CopyObject(Index(p91d, 0, Local0), Local1)
	            m1a3(Local0, c010, z110, ts, 92)
	            m1a3(Local1, c010, z110, ts, 93)
            }
            Case (71) {
	            CopyObject(Index(p91e, 0, Local0), Local1)
	            m1a3(Local0, c010, z110, ts, 94)
	            m1a3(Local1, c010, z110, ts, 95)
            }
            Case (72) {
	            CopyObject(Index(p91f, 0, Local0), Local1)
	            m1a3(Local0, c010, z110, ts, 96)
	            m1a3(Local1, c010, z110, ts, 97)
            }
            Case (73) {
	            CopyObject(Index(p920, 0, Local0), Local1)
	            m1a3(Local0, c010, z110, ts, 98)
	            m1a3(Local1, c010, z110, ts, 99)
            }

	            // ========================= Group 5:

	            // From m1b7: Store the result of Index to LocalX

	            // Computational Data

            Case (74) {
	            Store(Index(s900, 1, Local0), Local1)
	            m1a3(Local0, c016, z110, ts, 100)
	            m1a3(Local1, c016, z110, ts, 101)
            }
            Case (75) {
	            Store(Index(b900, 1, Local0), Local1)
	            m1a3(Local0, c016, z110, ts, 102)
	            m1a3(Local1, c016, z110, ts, 103)
            }

	            // Elements of Package are Uninitialized

            Case (76) {
		            Store(Index(p900, 0, Local0), Local1)
		            m1a3(Local0, c008, z110, ts, 104)
		            m1a3(Local1, c008, z110, ts, 105)
            }

	            // Elements of Package are Computational Data

            Case (77) {
	            Store(Index(p901, 1, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 106)
	            m1a3(Local1, c009, z110, ts, 107)
            }
            Case (78) {
	            Store(Index(p904, 1, Local0), Local1)
	            m1a3(Local0, c00b, z110, ts, 108)
	            m1a3(Local1, c00b, z110, ts, 109)
            }
            Case (79) {
	            Store(Index(p905, 0, Local0), Local1)
	            m1a3(Local0, c00c, z110, ts, 110)
	            m1a3(Local1, c00c, z110, ts, 111)
            }
            Case (80) {
	            Store(Index(p90d, 0, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 112)
	            m1a3(Local1, c009, z110, ts, 113)
            }
            Case (81) {
	            Store(Index(p90e, 0, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 114)
	            m1a3(Local1, c009, z110, ts, 115)
            }
            Case (82) {
	            Store(Index(p90f, 0, Local0), Local1)
	            m1a3(Local0, c00a, z110, ts, 116)
	            m1a3(Local1, c00a, z110, ts, 117)
            }
            Case (83) {
	            Store(Index(p910, 0, Local0), Local1)
	            m1a3(Local0, c00a, z110, ts, 118)
	            m1a3(Local1, c00a, z110, ts, 119)
            }
            Case (84) {
	            Store(Index(p911, 0, Local0), Local1)
	            m1a3(Local0, c00b, z110, ts, 120)
	            m1a3(Local1, c00b, z110, ts, 121)
            }
            Case (85) {
	            Store(Index(p912, 0, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 122)
	            m1a3(Local1, c009, z110, ts, 123)
            }
            Case (86) {
	            Store(Index(p913, 0, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 124)
	            m1a3(Local1, c009, z110, ts, 125)
            }
            Case (87) {
	            Store(Index(p914, 0, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 126)
	            m1a3(Local1, c009, z110, ts, 127)
            }
            Case (88) {
	            Store(Index(p915, 0, Local0), Local1)
	            m1a3(Local0, c009, z110, ts, 128)
	            m1a3(Local1, c009, z110, ts, 129)
            }

	            // Elements of Package are NOT Computational Data

            Case (89) {
	            Store(Index(p916, 0, Local0), Local1)
	            m1a3(Local0, c00e, z110, ts, 130)
	            m1a3(Local1, c00e, z110, ts, 131)
            }
            Case (90) {
	            Store(Index(p917, 0, Local0), Local1)
	            m1a3(Local0, c00f, z110, ts, 132)
	            m1a3(Local1, c00f, z110, ts, 133)
            }
            Case (91) {
	            Store(Index(p918, 0, Local0), Local1)
	            m1a3(Local0, c011, z110, ts, 134)
	            m1a3(Local1, c011, z110, ts, 135)
            }
            Case (92) {
	            Store(Index(p919, 0, Local0), Local1)
	            m1a3(Local0, c012, z110, ts, 136)
	            m1a3(Local1, c012, z110, ts, 137)
            }
            Case (93) {
	            Store(Index(p91a, 0, Local0), Local1)
	            m1a3(Local0, c013, z110, ts, 138)
	            m1a3(Local1, c013, z110, ts, 139)
            }
            Case (94) {
	            Store(Index(p91b, 0, Local0), Local1)
	            m1a3(Local0, c014, z110, ts, 140)
	            m1a3(Local1, c014, z110, ts, 141)
            }
            Case (95) {
	            Store(Index(p91c, 0, Local0), Local1)
	            m1a3(Local0, c015, z110, ts, 142)
	            m1a3(Local1, c015, z110, ts, 143)
            }

	            // Elements of Package are Methods

            Case (96) {
	            Store(Index(p91d, 0, Local0), Local1)
	            m1a3(Local0, c010, z110, ts, 144)
	            m1a3(Local1, c010, z110, ts, 145)
            }
            Case (97) {
	            Store(Index(p91e, 0, Local0), Local1)
	            m1a3(Local0, c010, z110, ts, 146)
	            m1a3(Local1, c010, z110, ts, 147)
            }
            Case (98) {
	            Store(Index(p91f, 0, Local0), Local1)
	            m1a3(Local0, c010, z110, ts, 148)
	            m1a3(Local1, c010, z110, ts, 149)
            }
            Case (99) {
	            Store(Index(p920, 0, Local0), Local1)
	            m1a3(Local0, c010, z110, ts, 150)
	            m1a3(Local1, c010, z110, ts, 151)
            }
            Default {
	            err(ts, z110, 1, 0, 0, ind0, 0)
            }

        } /* Switch */

        Decrement(lpN0)
        Increment(lpC0)

	} /* While */


/*
	// ################################## Check all the test:
	_TCI(c201, LLL1)
	m3a3(LLL0, LLL1, LLL2)
	m3a4(LLL0, LLL1, LLL2, 0, 0, 0, 0x12345678)
	// ################################## Check all the test.
*/


//	m1a6()
}
