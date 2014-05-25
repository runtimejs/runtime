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
 *
 *          (named objects, if present, are the global objects (from DefinitionBlock))
 *
 * TABLE 2: all the legal ways to generate references to the
 *          named objects
 * TABLE 4: all the legal ways to generate references to the
 *          named objects being elements of Package
 *
 * Producing Reference operators:
 *
 *    Index, RefOf, CondRefOf
 */

/*
??????????????
SEE: PUT everywhere APPROPREATE arg6 - number of checking for diagnostics
!!!!!!!!!!!!!!
SEE: add verification of Field Unit (in all files)
SEE: run the tests two times - to check that the data are not corrupted
SEE: uncomment runs after bug fixing
*/


Name(z080, 80)

// ///////////////////////////////////////////////////////////////////////////
//
// TABLE 2: all the legal ways to generate references to the named objects
//
// ///////////////////////////////////////////////////////////////////////////

// m169 but with global data
Method(m190)
{
	if (y100) {
		ts00("m190")
	} else {
		Store("m190", Debug)
	}

	// T2:I2-I4

	if (y114) {
		// Remove this after the bug fixing
		Store(Index(m902, 0), Local0)
		m1a0(Local0, c010, Ones, 0)
	}

	// Computational Data

	Store(Index(s900, 0), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x31, 1)

	Store(Index(s901, 2), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x72, 2)

	Store(Index(b900, 3), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0xb3, 3)

	// Elements of Package are Uninitialized

	if (y104) {
		Store(Index(p900, 0), Local0)
		m1a0(Local0, c008, Ones, 4)
	}

	// Elements of Package are Computational Data

	Store(Index(p901, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xabcd0004, 5)

	Store(Index(p901, 1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0x1122334455660005, 6)

	Store(Index(p902, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12340006", 7)

	Store(Index(p902, 1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "q1w2e3r4t5y6u7i80007", 8)

	Store(Index(p903, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyuiop0008", 9)

	Store(Index(p903, 1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "1234567890abdef0250009", 10)

	Store(Index(p904, 0), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 11)

	Store(Index(p905, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabc000a, 12)

	Store(Index(p905, 0), Local0)
	m1a2(Local0, c00c, 1, 1, c00a, "0xabc000b", 13)

	Store(Index(p906, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "abc000d", 14)

	Store(Index(p907, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "aqwevbgnm000e", 15)

	Store(Index(p908, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 16)

	Store(Index(p909, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabc000f, 17)

	Store(Index(p90a, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "12340010", 18)

	Store(Index(p90b, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "zxswefas0011", 19)

	Store(Index(p90c, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 20)

	Store(Index(p90d, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a0000, 21)

	Store(Index(p90e, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xc1790001, 22)

	Store(Index(p90f, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12340002", 23)

	Store(Index(p910, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu0003", 24)

	Store(Index(p911, 0), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 25)

	if (y118) {
		Store(Index(p912, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 26)

		Store(Index(p913, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 27)

		Store(Index(p914, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 28)

		Store(Index(p915, 0), Local0)
		m1a2(Local0, c016, 0, 0, c016, 0xb0, 29)
	}

	// Elements of Package are NOT Computational Data

	Store(Index(p916, 0), Local0)
	m1a0(Local0, c00e, Ones, 30)

	Store(Index(p917, 0), Local0)
	m1a0(Local0, c00f, Ones, 31)

	Store(Index(p918, 0), Local0)
	m1a0(Local0, c011, Ones, 32)

	Store(Index(p919, 0), Local0)
	m1a0(Local0, c012, Ones, 33)

	Store(Index(p91a, 0), Local0)
	m1a0(Local0, c013, Ones, 34)

	Store(Index(p91b, 0), Local0)
	m1a0(Local0, c014, Ones, 35)

	Store(Index(p91c, 0), Local0)
	m1a0(Local0, c015, Ones, 36)

	// Elements of Package are Methods

	if (y105) {

		Store(Index(p91d, 0), Local0)
		m1a0(Local0, c010, Ones, 37)

		Store(Index(p91e, 0), Local0)
		m1a0(Local0, c010, Ones, 38)

		Store(Index(p91f, 0), Local0)
		m1a0(Local0, c010, Ones, 39)

		Store(Index(p920, 0), Local0)
		m1a0(Local0, c010, Ones, 40)

		Store(Index(p921, 0), Local0)
		m1a0(Local0, c010, Ones, 41)

		Store(Index(p922, 0), Local0)
		m1a0(Local0, c010, Ones, 42)

		Store(Index(p923, 0), Local0)
		m1a0(Local0, c010, Ones, 43)

		Store(Index(p924, 0), Local0)
		m1a0(Local0, c010, Ones, 44)

		Store(Index(p925, 0), Local0)
		m1a0(Local0, c010, Ones, 45)

		Store(Index(p926, 0), Local0)
		m1a0(Local0, c010, Ones, 46)

		Store(Index(p927, 0), Local0)
		m1a0(Local0, c010, Ones, 47)

		Store(Index(p928, 0), Local0)
		m1a0(Local0, c010, Ones, 48)

		Store(Index(p929, 0), Local0)
		m1a0(Local0, c010, Ones, 49)

		Store(Index(p92a, 0), Local0)
		m1a0(Local0, c010, Ones, 50)

		Store(Index(p92b, 0), Local0)
		m1a0(Local0, c010, Ones, 51)

		Store(Index(p92c, 0), Local0)
		m1a0(Local0, c010, Ones, 52)

		Store(Index(p92d, 0), Local0)
		m1a0(Local0, c010, Ones, 53)

		Store(Index(p92e, 0), Local0)
		m1a0(Local0, c010, Ones, 54)

		Store(Index(p92f, 0), Local0)
		m1a0(Local0, c010, Ones, 55)

		Store(Index(p930, 0), Local0)
		m1a0(Local0, c010, Ones, 56)

		Store(Index(p931, 0), Local0)
		m1a0(Local0, c010, Ones, 57)

		Store(Index(p932, 0), Local0)
		m1a0(Local0, c010, Ones, 58)

		Store(Index(p933, 0), Local0)
		m1a0(Local0, c010, Ones, 59)

		Store(Index(p934, 0), Local0)
		m1a0(Local0, c010, Ones, 60)

		if (y103) {
			Store(Index(p935, 0), Local0)
			m1a0(Local0, c010, Ones, 61)
		}

		Store(Index(p936, 0), Local0)
		m1a0(Local0, c010, Ones, 62)

		Store(Index(p937, 0), Local0)
		m1a0(Local0, c010, Ones, 63)

		Store(Index(p938, 0), Local0)
		m1a0(Local0, c010, Ones, 64)

		Store(Index(p939, 0), Local0)
		m1a0(Local0, c010, Ones, 65)

		Store(Index(p93a, 0), Local0)
		m1a0(Local0, c010, Ones, 66)

		Store(Index(p93b, 0), Local0)
		m1a0(Local0, c010, Ones, 67)

		Store(Index(p93c, 0), Local0)
		m1a0(Local0, c010, Ones, 68)

		Store(Index(p93d, 0), Local0)
		m1a0(Local0, c010, Ones, 69)

		Store(Index(p93e, 0), Local0)
		m1a0(Local0, c010, Ones, 70)

		Store(Index(p93f, 0), Local0)
		m1a0(Local0, c010, Ones, 71)

		Store(Index(p940, 0), Local0)
		m1a0(Local0, c010, Ones, 72)

		Store(Index(p941, 0), Local0)
		m1a0(Local0, c010, Ones, 73)

		Store(Index(p942, 0), Local0)
		m1a0(Local0, c010, Ones, 74)

		Store(Index(p943, 0), Local0)
		m1a0(Local0, c010, Ones, 75)

		Store(Index(p944, 0), Local0)
		m1a0(Local0, c010, Ones, 76)

		Store(Index(p945, 0), Local0)
		m1a0(Local0, c010, Ones, 77)

		Store(Index(p946, 0), Local0)
		m1a0(Local0, c010, Ones, 78)

		Store(Index(p947, 0), Local0)
		m1a0(Local0, c010, Ones, 79)

		Store(Index(p948, 0), Local0)
		m1a0(Local0, c010, Ones, 80)

		Store(Index(p949, 0), Local0)
		m1a0(Local0, c010, Ones, 81)

		Store(Index(p94a, 0), Local0)
		m1a0(Local0, c010, Ones, 82)

		Store(Index(p94b, 0), Local0)
		m1a0(Local0, c010, Ones, 83)

		Store(Index(p94c, 0), Local0)
		m1a0(Local0, c010, Ones, 84)

		Store(Index(p94d, 0), Local0)
		m1a0(Local0, c010, Ones, 85)

		Store(Index(p94e, 0), Local0)
		m1a0(Local0, c010, Ones, 86)

		Store(Index(p94f, 0), Local0)
		m1a0(Local0, c010, Ones, 87)

		Store(Index(p950, 0), Local0)
		m1a0(Local0, c010, Ones, 88)

		Store(Index(p951, 0), Local0)
		m1a0(Local0, c010, Ones, 89)

		Store(Index(p952, 0), Local0)
		m1a0(Local0, c010, Ones, 90)
	}

	// T2:IR2-IR4

	// Computational Data

	Store(Index(s900, 0, Local1), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x31, 91)
	m1a2(Local1, c016, 0, 0, c009, 0x31, 92)

	Store(Index(s901, 2, Local1), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x72, 93)
	m1a2(Local1, c016, 0, 0, c009, 0x72, 94)

	Store(Index(b900, 4, Local1), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0xb4, 95)
	m1a2(Local1, c016, 0, 0, c009, 0xb4, 96)

	// Elements of Package are Uninitialized

	if (y104) {
		Store(Index(p900, 0, Local1), Local0)
		m1a0(Local0, c008, Ones, 97)
		m1a0(Local1, c008, Ones, 98)
	}

	// Elements of Package are Computational Data

	Store(Index(p901, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xabcd0004, 99)
	m1a2(Local1, c009, 0, 0, c009, 0xabcd0004, 100)

	Store(Index(p901, 1, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0x1122334455660005, 101)
	m1a2(Local1, c009, 0, 0, c009, 0x1122334455660005, 102)

	Store(Index(p902, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12340006", 103)
	m1a2(Local1, c00a, 0, 0, c00a, "12340006", 104)

	Store(Index(p902, 1, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "q1w2e3r4t5y6u7i80007", 105)
	m1a2(Local1, c00a, 0, 0, c00a, "q1w2e3r4t5y6u7i80007", 106)

	Store(Index(p903, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyuiop0008", 107)
	m1a2(Local1, c00a, 0, 0, c00a, "qwrtyuiop0008", 108)

	Store(Index(p903, 1, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "1234567890abdef0250009", 109)
	m1a2(Local1, c00a, 0, 0, c00a, "1234567890abdef0250009", 110)

	Store(Index(p904, 0, Local1), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 111)
	m1a2(Local1, c00b, 0, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 112)

	Store(Index(p905, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabc000a, 113)
	m1a2(Local1, c00c, 1, 0, c009, 0xabc000a, 114)

	Store(Index(p905, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 1, c00a, "0xabc000b", 115)
	m1a2(Local1, c00c, 1, 1, c00a, "0xabc000b", 116)

	Store(Index(p906, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "abc000d", 117)
	m1a2(Local1, c00c, 1, 0, c00a, "abc000d", 118)

	Store(Index(p907, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "aqwevbgnm000e", 119)
	m1a2(Local1, c00c, 1, 0, c00a, "aqwevbgnm000e", 120)

	Store(Index(p908, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 121)
	m1a2(Local1, c00c, 1, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 122)

	Store(Index(p909, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabc000f, 123)
	m1a2(Local1, c00c, 2, 0, c009, 0xabc000f, 124)

	Store(Index(p90a, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "12340010", 125)
	m1a2(Local1, c00c, 2, 0, c00a, "12340010", 126)

	Store(Index(p90b, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "zxswefas0011", 127)
	m1a2(Local1, c00c, 2, 0, c00a, "zxswefas0011", 128)

	Store(Index(p90c, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 129)
	m1a2(Local1, c00c, 2, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 130)

	Store(Index(p90d, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a0000, 131)
	m1a2(Local1, c009, 0, 0, c009, 0xfe7cb391d65a0000, 132)

	Store(Index(p90e, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xc1790001, 133)
	m1a2(Local1, c009, 0, 0, c009, 0xc1790001, 134)

	Store(Index(p90f, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12340002", 135)
	m1a2(Local1, c00a, 0, 0, c00a, "12340002", 136)

	Store(Index(p910, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu0003", 137)
	m1a2(Local1, c00a, 0, 0, c00a, "qwrtyu0003", 138)

	Store(Index(p911, 0, Local1), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 139)
	m1a2(Local1, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 140)

	if (y118) {
		Store(Index(p912, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 141)
		m1a2(Local1, c00d, 0, 0, c00d, 0, 142)

		Store(Index(p913, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 143)
		m1a2(Local1, c00d, 0, 0, c00d, 0, 144)

		Store(Index(p914, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 145)
		m1a2(Local1, c00d, 0, 0, c00d, 0, 146)

		Store(Index(p915, 0, Local1), Local0)
		m1a2(Local0, c016, 0, 0, c016, 0xb0, 147)
		m1a2(Local1, c016, 0, 0, c016, 0xb0, 148)
	}

	// Elements of Package are NOT Computational Data

	Store(Index(p916, 0, Local1), Local0)
	m1a0(Local0, c00e, Ones, 149)
	m1a0(Local1, c00e, Ones, 150)

	Store(Index(p917, 0, Local1), Local0)
	m1a0(Local0, c00f, Ones, 151)
	m1a0(Local1, c00f, Ones, 152)

	Store(Index(p918, 0, Local1), Local0)
	m1a0(Local0, c011, Ones, 153)
	m1a0(Local1, c011, Ones, 154)

	Store(Index(p919, 0, Local1), Local0)
	m1a0(Local0, c012, Ones, 155)
	m1a0(Local1, c012, Ones, 156)

	Store(Index(p91a, 0, Local1), Local0)
	m1a0(Local0, c013, Ones, 157)
	m1a0(Local1, c013, Ones, 158)

	Store(Index(p91b, 0, Local1), Local0)
	m1a0(Local0, c014, Ones, 159)
	m1a0(Local1, c014, Ones, 160)

	Store(Index(p91c, 0, Local1), Local0)
	m1a0(Local0, c015, Ones, 161)
	m1a0(Local1, c015, Ones, 162)

	// Elements of Package are Methods

	if (y105) {

		Store(Index(p91d, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 163)
		m1a0(Local1, c010, Ones, 164)

		Store(Index(p91e, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 165)
		m1a0(Local1, c010, Ones, 166)

		Store(Index(p91f, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 167)
		m1a0(Local1, c010, Ones, 168)

		Store(Index(p920, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 169)
		m1a0(Local1, c010, Ones, 170)

		Store(Index(p921, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 171)
		m1a0(Local1, c010, Ones, 172)

		Store(Index(p922, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 173)
		m1a0(Local1, c010, Ones, 174)

		Store(Index(p923, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 175)
		m1a0(Local1, c010, Ones, 176)

		Store(Index(p924, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 177)
		m1a0(Local1, c010, Ones, 178)

		Store(Index(p925, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 179)
		m1a0(Local1, c010, Ones, 180)

		Store(Index(p926, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 181)
		m1a0(Local1, c010, Ones, 182)

		Store(Index(p927, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 183)
		m1a0(Local1, c010, Ones, 184)

		Store(Index(p928, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 185)
		m1a0(Local1, c010, Ones, 186)

		Store(Index(p929, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 187)
		m1a0(Local1, c010, Ones, 188)

		Store(Index(p92a, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 189)
		m1a0(Local1, c010, Ones, 190)

		Store(Index(p92b, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 191)
		m1a0(Local1, c010, Ones, 192)

		Store(Index(p92c, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 193)
		m1a0(Local1, c010, Ones, 194)

		Store(Index(p92d, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 195)
		m1a0(Local1, c010, Ones, 196)

		Store(Index(p92e, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 197)
		m1a0(Local1, c010, Ones, 198)

		Store(Index(p92f, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 199)
		m1a0(Local1, c010, Ones, 200)

		Store(Index(p930, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 201)
		m1a0(Local1, c010, Ones, 202)

		Store(Index(p931, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 203)
		m1a0(Local1, c010, Ones, 204)

		Store(Index(p932, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 205)
		m1a0(Local1, c010, Ones, 206)

		Store(Index(p933, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 207)
		m1a0(Local1, c010, Ones, 208)

		Store(Index(p934, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 209)
		m1a0(Local1, c010, Ones, 210)

		if (y103) {
			Store(Index(p935, 0, Local1), Local0)
			m1a0(Local0, c010, Ones, 211)
			m1a0(Local1, c010, Ones, 212)
		}

		Store(Index(p936, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 213)
		m1a0(Local1, c010, Ones, 214)

		Store(Index(p937, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 215)
		m1a0(Local1, c010, Ones, 216)

		Store(Index(p938, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 217)
		m1a0(Local1, c010, Ones, 218)

		Store(Index(p939, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 219)
		m1a0(Local1, c010, Ones, 220)

		Store(Index(p93a, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 221)
		m1a0(Local1, c010, Ones, 222)

		Store(Index(p93b, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 223)
		m1a0(Local1, c010, Ones, 224)

		Store(Index(p93c, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 225)
		m1a0(Local1, c010, Ones, 226)

		Store(Index(p93d, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 227)
		m1a0(Local1, c010, Ones, 228)

		Store(Index(p93e, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 229)
		m1a0(Local1, c010, Ones, 230)

		Store(Index(p93f, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 231)
		m1a0(Local1, c010, Ones, 232)

		Store(Index(p940, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 233)
		m1a0(Local1, c010, Ones, 234)

		Store(Index(p941, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 235)
		m1a0(Local1, c010, Ones, 236)

		Store(Index(p942, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 237)
		m1a0(Local1, c010, Ones, 238)

		Store(Index(p943, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 239)
		m1a0(Local1, c010, Ones, 240)

		Store(Index(p944, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 241)
		m1a0(Local1, c010, Ones, 242)

		Store(Index(p945, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 243)
		m1a0(Local1, c010, Ones, 244)

		Store(Index(p946, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 245)
		m1a0(Local1, c010, Ones, 246)

		Store(Index(p947, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 247)
		m1a0(Local1, c010, Ones, 248)

		Store(Index(p948, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 249)
		m1a0(Local1, c010, Ones, 250)

		Store(Index(p949, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 251)
		m1a0(Local1, c010, Ones, 252)

		Store(Index(p94a, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 253)
		m1a0(Local1, c010, Ones, 254)

		Store(Index(p94b, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 255)
		m1a0(Local1, c010, Ones, 256)

		Store(Index(p94c, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 257)
		m1a0(Local1, c010, Ones, 258)

		Store(Index(p94d, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 259)
		m1a0(Local1, c010, Ones, 260)

		Store(Index(p94e, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 261)
		m1a0(Local1, c010, Ones, 262)

		Store(Index(p94f, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 263)
		m1a0(Local1, c010, Ones, 264)

		Store(Index(p950, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 265)
		m1a0(Local1, c010, Ones, 266)

		Store(Index(p951, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 267)
		m1a0(Local1, c010, Ones, 268)

		Store(Index(p952, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 269)
		m1a0(Local1, c010, Ones, 270)
	}

	m1a6()
}

// m16a but with global data
// arg0 - writing mode
Method(m191, 1)
{
	if (y100) {
		ts00("m191")
	} else {
		Store("m191", Debug)
	}

	// T2:R1-R14

	// Computational Data

	Store(RefOf(i900), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a0000, 271)

	Store(RefOf(i901), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xc1790001, 272)

	Store(RefOf(s900), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12340002", 273)

	Store(RefOf(s901), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu0003", 274)

	Store(RefOf(b900), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 275)

	// Not Computational Data

	Store(RefOf(e900), Local0)
	m1a0(Local0, c00f, Ones, 280)

	Store(RefOf(mx90), Local0)
	m1a0(Local0, c011, Ones, 281)

	Store(RefOf(d900), Local0)
	m1a0(Local0, c00e, Ones, 282)

	if (arg0) {
		if (y508) {
			Store(RefOf(tz90), Local0)
			m1a0(Local0, c015, Ones, 283)
		}
	} else {
		Store(RefOf(tz90), Local0)
		m1a0(Local0, c015, Ones, 283)
	}

	Store(RefOf(pr90), Local0)
	m1a0(Local0, c014, Ones, 284)

	if (arg0) {
		if (y510) {
			Store(RefOf(r900), Local0)
			m1a0(Local0, c012, Ones, 285)
		}
	} else {
		Store(RefOf(r900), Local0)
		m1a0(Local0, c012, Ones, 1002)
	}

	Store(RefOf(pw90), Local0)
	m1a0(Local0, c013, Ones, 286)

	// Package

	Store(RefOf(p953), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabcd0018, 1001)

	if (arg0) {
		m1ab()
		return
	}

	// Computational Data (Field Unit and Buffer Field)

	Store(RefOf(f900), Local0)
	m1a2(Local0, c00d, 0, 0, c009, 0, 276)

	Store(RefOf(bn90), Local0)
	m1a2(Local0, c00d, 0, 0, c009, 0, 277)

	Store(RefOf(if90), Local0)
	m1a2(Local0, c00d, 0, 0, c009, 0, 278)

	Store(RefOf(bf90), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0xb0, 279)

	// Elements of Package are Uninitialized

	Store(RefOf(p900), Local0)
	m1a0(Local0, c00c, Ones, 287)

	// Elements of Package are Computational Data

	Store(RefOf(p901), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabcd0004, 288)
	m1a2(Local0, c00c, 1, 1, c009, 0x1122334455660005, 289)

	Store(RefOf(p902), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12340006", 290)
	m1a2(Local0, c00c, 1, 1, c00a, "q1w2e3r4t5y6u7i80007", 291)

	Store(RefOf(p903), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyuiop0008", 292)
	m1a2(Local0, c00c, 1, 1, c00a, "1234567890abdef0250009", 293)

	Store(RefOf(p904), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 294)

	Store(RefOf(p905), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabc000a, 295)
	m1a2(Local0, c00c, 2, 1, c00a, "0xabc000b", 296)

	Store(RefOf(p906), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "abc000d", 297)

	Store(RefOf(p907), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "aqwevbgnm000e", 298)

	Store(RefOf(p908), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 299)

	Store(RefOf(p909), Local0)
	m1a2(Local0, c00c, 3, 0, c009, 0xabc000f, 300)

	Store(RefOf(p90a), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "12340010", 301)

	Store(RefOf(p90b), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "zxswefas0011", 302)

	Store(RefOf(p90c), Local0)
	m1a2(Local0, c00c, 3, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 303)

	Store(RefOf(p90d), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xfe7cb391d65a0000, 304)

	Store(RefOf(p90e), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xc1790001, 305)

	Store(RefOf(p90f), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12340002", 306)

	Store(RefOf(p910), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyu0003", 307)

	Store(RefOf(p911), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 308)

	if (y118) {
		Store(RefOf(p912), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 309)

		Store(RefOf(p913), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 310)

		Store(RefOf(p914), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 311)

		Store(RefOf(p915), Local0)
		m1a2(Local0, c00c, 1, 0, c016, 0xb0, 312)
	}

	// Elements of Package are NOT Computational Data

	Store(RefOf(p916), Local0)
	m1a0(Local0, c00c, Ones, 313)

	Store(RefOf(p917), Local0)
	m1a0(Local0, c00c, Ones, 314)

	Store(RefOf(p918), Local0)
	m1a0(Local0, c00c, Ones, 315)

	Store(RefOf(p919), Local0)
	m1a0(Local0, c00c, Ones, 316)

	Store(RefOf(p91a), Local0)
	m1a0(Local0, c00c, Ones, 317)

	Store(RefOf(p91b), Local0)
	m1a0(Local0, c00c, Ones, 318)

	Store(RefOf(p91c), Local0)
	m1a0(Local0, c00c, Ones, 319)

	// Elements of Package are Methods

	Store(RefOf(p91d), Local0)
	m1a0(Local0, c00c, Ones, 320)

	Store(RefOf(p91e), Local0)
	m1a0(Local0, c00c, Ones, 321)

	Store(RefOf(p91f), Local0)
	m1a0(Local0, c00c, Ones, 322)

	Store(RefOf(p920), Local0)
	m1a0(Local0, c00c, Ones, 323)

	Store(RefOf(p921), Local0)
	m1a0(Local0, c00c, Ones, 324)

	Store(RefOf(p922), Local0)
	m1a0(Local0, c00c, Ones, 325)

	Store(RefOf(p923), Local0)
	m1a0(Local0, c00c, Ones, 326)

	Store(RefOf(p924), Local0)
	m1a0(Local0, c00c, Ones, 327)

	Store(RefOf(p925), Local0)
	m1a0(Local0, c00c, Ones, 328)

	Store(RefOf(p926), Local0)
	m1a0(Local0, c00c, Ones, 329)

	Store(RefOf(p927), Local0)
	m1a0(Local0, c00c, Ones, 330)

	Store(RefOf(p928), Local0)
	m1a0(Local0, c00c, Ones, 331)

	Store(RefOf(p929), Local0)
	m1a0(Local0, c00c, Ones, 332)

	Store(RefOf(p92a), Local0)
	m1a0(Local0, c00c, Ones, 333)

	Store(RefOf(p92b), Local0)
	m1a0(Local0, c00c, Ones, 334)

	Store(RefOf(p92c), Local0)
	m1a0(Local0, c00c, Ones, 335)

	Store(RefOf(p92d), Local0)
	m1a0(Local0, c00c, Ones, 336)

	Store(RefOf(p92e), Local0)
	m1a0(Local0, c00c, Ones, 337)

	Store(RefOf(p92f), Local0)
	m1a0(Local0, c00c, Ones, 338)

	Store(RefOf(p930), Local0)
	m1a0(Local0, c00c, Ones, 339)

	Store(RefOf(p931), Local0)
	m1a0(Local0, c00c, Ones, 340)

	Store(RefOf(p932), Local0)
	m1a0(Local0, c00c, Ones, 341)

	Store(RefOf(p933), Local0)
	m1a0(Local0, c00c, Ones, 342)

	Store(RefOf(p934), Local0)
	m1a0(Local0, c00c, Ones, 343)

	Store(RefOf(p935), Local0)
	m1a0(Local0, c00c, Ones, 344)

	Store(RefOf(p936), Local0)
	m1a0(Local0, c00c, Ones, 345)

	Store(RefOf(p937), Local0)
	m1a0(Local0, c00c, Ones, 346)

	Store(RefOf(p938), Local0)
	m1a0(Local0, c00c, Ones, 347)

	Store(RefOf(p939), Local0)
	m1a0(Local0, c00c, Ones, 348)

	Store(RefOf(p93a), Local0)
	m1a0(Local0, c00c, Ones, 349)

	Store(RefOf(p93b), Local0)
	m1a0(Local0, c00c, Ones, 350)

	Store(RefOf(p93c), Local0)
	m1a0(Local0, c00c, Ones, 351)

	Store(RefOf(p93d), Local0)
	m1a0(Local0, c00c, Ones, 352)

	Store(RefOf(p93e), Local0)
	m1a0(Local0, c00c, Ones, 353)

	Store(RefOf(p93f), Local0)
	m1a0(Local0, c00c, Ones, 354)

	Store(RefOf(p940), Local0)
	m1a0(Local0, c00c, Ones, 355)

	Store(RefOf(p941), Local0)
	m1a0(Local0, c00c, Ones, 356)

	Store(RefOf(p942), Local0)
	m1a0(Local0, c00c, Ones, 357)

	Store(RefOf(p943), Local0)
	m1a0(Local0, c00c, Ones, 358)

	Store(RefOf(p944), Local0)
	m1a0(Local0, c00c, Ones, 359)

	Store(RefOf(p945), Local0)
	m1a0(Local0, c00c, Ones, 360)

	Store(RefOf(p946), Local0)
	m1a0(Local0, c00c, Ones, 361)

	Store(RefOf(p947), Local0)
	m1a0(Local0, c00c, Ones, 362)

	Store(RefOf(p948), Local0)
	m1a0(Local0, c00c, Ones, 363)

	Store(RefOf(p949), Local0)
	m1a0(Local0, c00c, Ones, 364)

	Store(RefOf(p94a), Local0)
	m1a0(Local0, c00c, Ones, 365)

	Store(RefOf(p94b), Local0)
	m1a0(Local0, c00c, Ones, 366)

	Store(RefOf(p94c), Local0)
	m1a0(Local0, c00c, Ones, 367)

	Store(RefOf(p94d), Local0)
	m1a0(Local0, c00c, Ones, 368)

	Store(RefOf(p94e), Local0)
	m1a0(Local0, c00c, Ones, 369)

	Store(RefOf(p94f), Local0)
	m1a0(Local0, c00c, Ones, 370)

	Store(RefOf(p950), Local0)
	m1a0(Local0, c00c, Ones, 371)

	Store(RefOf(p951), Local0)
	m1a0(Local0, c00c, Ones, 372)

	Store(RefOf(p952), Local0)
	m1a0(Local0, c00c, Ones, 373)

	// Methods

	Store(RefOf(m900), Local0)
	m1a0(Local0, c010, Ones, 374)

	Store(RefOf(m901), Local0)
	m1a0(Local0, c010, Ones, 375)

	Store(RefOf(m902), Local0)
	m1a0(Local0, c010, Ones, 376)

	Store(RefOf(m903), Local0)
	m1a0(Local0, c010, Ones, 377)

	Store(RefOf(m904), Local0)
	m1a0(Local0, c010, Ones, 378)

	Store(RefOf(m905), Local0)
	m1a0(Local0, c010, Ones, 379)

	Store(RefOf(m906), Local0)
	m1a0(Local0, c010, Ones, 380)

	Store(RefOf(m907), Local0)
	m1a0(Local0, c010, Ones, 381)

	Store(RefOf(m908), Local0)
	m1a0(Local0, c010, Ones, 382)

	Store(RefOf(m909), Local0)
	m1a0(Local0, c010, Ones, 383)

	Store(RefOf(m90a), Local0)
	m1a0(Local0, c010, Ones, 384)

	Store(RefOf(m90b), Local0)
	m1a0(Local0, c010, Ones, 385)

	Store(RefOf(m90c), Local0)
	m1a0(Local0, c010, Ones, 386)

	Store(RefOf(m90d), Local0)
	m1a0(Local0, c010, Ones, 387)

	Store(RefOf(m90e), Local0)
	m1a0(Local0, c010, Ones, 388)

	Store(RefOf(m90f), Local0)
	m1a0(Local0, c010, Ones, 389)

	Store(RefOf(m910), Local0)
	m1a0(Local0, c010, Ones, 390)

	Store(RefOf(m911), Local0)
	m1a0(Local0, c010, Ones, 391)

	Store(RefOf(m912), Local0)
	m1a0(Local0, c010, Ones, 392)

	Store(RefOf(m913), Local0)
	m1a0(Local0, c010, Ones, 393)

	Store(RefOf(m914), Local0)
	m1a0(Local0, c010, Ones, 394)

	Store(RefOf(m915), Local0)
	m1a0(Local0, c010, Ones, 395)

	Store(RefOf(m916), Local0)
	m1a0(Local0, c010, Ones, 396)

	Store(RefOf(m917), Local0)
	m1a0(Local0, c010, Ones, 397)

	Store(RefOf(m918), Local0)
	m1a0(Local0, c010, Ones, 398)

	Store(RefOf(m919), Local0)
	m1a0(Local0, c010, Ones, 399)

	Store(RefOf(m91a), Local0)
	m1a0(Local0, c010, Ones, 400)

	Store(RefOf(m91b), Local0)
	m1a0(Local0, c010, Ones, 401)

	Store(RefOf(m91c), Local0)
	m1a0(Local0, c010, Ones, 402)

	Store(RefOf(m91d), Local0)
	m1a0(Local0, c010, Ones, 403)

	Store(RefOf(m91e), Local0)
	m1a0(Local0, c010, Ones, 404)

	Store(RefOf(m91f), Local0)
	m1a0(Local0, c010, Ones, 405)

	Store(RefOf(m920), Local0)
	m1a0(Local0, c010, Ones, 406)

	Store(RefOf(m921), Local0)
	m1a0(Local0, c010, Ones, 407)

	Store(RefOf(m922), Local0)
	m1a0(Local0, c010, Ones, 408)

	Store(RefOf(m923), Local0)
	m1a0(Local0, c010, Ones, 409)

	Store(RefOf(m924), Local0)
	m1a0(Local0, c010, Ones, 410)

	Store(RefOf(m925), Local0)
	m1a0(Local0, c010, Ones, 411)

	Store(RefOf(m926), Local0)
	m1a0(Local0, c010, Ones, 412)

	Store(RefOf(m927), Local0)
	m1a0(Local0, c010, Ones, 413)

	Store(RefOf(m928), Local0)
	m1a0(Local0, c010, Ones, 414)

	Store(RefOf(m929), Local0)
	m1a0(Local0, c010, Ones, 415)

	Store(RefOf(m92a), Local0)
	m1a0(Local0, c010, Ones, 416)

	Store(RefOf(m92b), Local0)
	m1a0(Local0, c010, Ones, 417)

	Store(RefOf(m92c), Local0)
	m1a0(Local0, c010, Ones, 418)

	Store(RefOf(m92d), Local0)
	m1a0(Local0, c010, Ones, 419)

	Store(RefOf(m92e), Local0)
	m1a0(Local0, c010, Ones, 420)

	Store(RefOf(m92f), Local0)
	m1a0(Local0, c010, Ones, 421)

	Store(RefOf(m930), Local0)
	m1a0(Local0, c010, Ones, 422)

	Store(RefOf(m931), Local0)
	m1a0(Local0, c010, Ones, 423)

	Store(RefOf(m932), Local0)
	m1a0(Local0, c010, Ones, 424)

	Store(RefOf(m933), Local0)
	m1a0(Local0, c010, Ones, 425)

	Store(RefOf(m934), Local0)
	m1a0(Local0, c010, Ones, 426)

	Store(RefOf(m935), Local0)
	m1a0(Local0, c010, Ones, 427)

	m1a6()

	return
}

// m16b but with global data
Method(m192)
{
	if (y100) {
		ts00("m192")
	} else {
		Store("m192", Debug)
	}

	// T2:C1-C14

	// Computational Data

	Store(CondRefOf(i900), Local0)
	m1a4(Local0, 428)

	Store(CondRefOf(i901), Local0)
	m1a4(Local0, 429)

	Store(CondRefOf(s900), Local0)
	m1a4(Local0, 430)

	Store(CondRefOf(s901), Local0)
	m1a4(Local0, 431)

	Store(CondRefOf(b900), Local0)
	m1a4(Local0, 432)

	Store(CondRefOf(f900), Local0)
	m1a4(Local0, 433)

	Store(CondRefOf(bn90), Local0)
	m1a4(Local0, 434)

	Store(CondRefOf(if90), Local0)
	m1a4(Local0, 435)

	Store(CondRefOf(bf90), Local0)
	m1a4(Local0, 436)

	// Not Computational Data

	Store(CondRefOf(e900), Local0)
	m1a4(Local0, 437)

	Store(CondRefOf(mx90), Local0)
	m1a4(Local0, 438)

	Store(CondRefOf(d900), Local0)
	m1a4(Local0, 439)

	Store(CondRefOf(tz90), Local0)
	m1a4(Local0, 450)

	Store(CondRefOf(pr90), Local0)
	m1a4(Local0, 451)

	Store(CondRefOf(r900), Local0)
	m1a4(Local0, 452)

	Store(CondRefOf(pw90), Local0)
	m1a4(Local0, 453)

	// Elements of Package are Uninitialized

	Store(CondRefOf(p900), Local0)
	m1a4(Local0, 454)

	// Elements of Package are Computational Data

	Store(CondRefOf(p901), Local0)
	m1a4(Local0, 455)

	Store(CondRefOf(p902), Local0)
	m1a4(Local0, 456)

	Store(CondRefOf(p903), Local0)
	m1a4(Local0, 457)

	Store(CondRefOf(p904), Local0)
	m1a4(Local0, 458)

	Store(CondRefOf(p905), Local0)
	m1a4(Local0, 459)

	Store(CondRefOf(p906), Local0)
	m1a4(Local0, 460)

	Store(CondRefOf(p907), Local0)
	m1a4(Local0, 461)

	Store(CondRefOf(p908), Local0)
	m1a4(Local0, 462)

	Store(CondRefOf(p909), Local0)
	m1a4(Local0, 463)

	Store(CondRefOf(p90a), Local0)
	m1a4(Local0, 464)

	Store(CondRefOf(p90b), Local0)
	m1a4(Local0, 465)

	Store(CondRefOf(p90c), Local0)
	m1a4(Local0, 466)

	Store(CondRefOf(p90d), Local0)
	m1a4(Local0, 467)

	Store(CondRefOf(p90e), Local0)
	m1a4(Local0, 468)

	Store(CondRefOf(p90f), Local0)
	m1a4(Local0, 469)

	Store(CondRefOf(p910), Local0)
	m1a4(Local0, 470)

	Store(CondRefOf(p911), Local0)
	m1a4(Local0, 471)

	Store(CondRefOf(p912), Local0)
	m1a4(Local0, 472)

	Store(CondRefOf(p913), Local0)
	m1a4(Local0, 473)

	Store(CondRefOf(p914), Local0)
	m1a4(Local0, 474)

	Store(CondRefOf(p915), Local0)
	m1a4(Local0, 475)

	// Elements of Package are NOT Computational Data

	Store(CondRefOf(p916), Local0)
	m1a4(Local0, 476)

	Store(CondRefOf(p917), Local0)
	m1a4(Local0, 477)

	Store(CondRefOf(p918), Local0)
	m1a4(Local0, 478)

	Store(CondRefOf(p919), Local0)
	m1a4(Local0, 479)

	Store(CondRefOf(p91a), Local0)
	m1a4(Local0, 480)

	Store(CondRefOf(p91b), Local0)
	m1a4(Local0, 481)

	Store(CondRefOf(p91c), Local0)
	m1a4(Local0, 482)

	// Elements of Package are Methods

	Store(CondRefOf(p91d), Local0)
	m1a4(Local0, 483)

	Store(CondRefOf(p91e), Local0)
	m1a4(Local0, 484)

	Store(CondRefOf(p91f), Local0)
	m1a4(Local0, 485)

	Store(CondRefOf(p920), Local0)
	m1a4(Local0, 486)

	Store(CondRefOf(p921), Local0)
	m1a4(Local0, 487)

	Store(CondRefOf(p922), Local0)
	m1a4(Local0, 488)

	Store(CondRefOf(p923), Local0)
	m1a4(Local0, 489)

	Store(CondRefOf(p924), Local0)
	m1a4(Local0, 490)

	Store(CondRefOf(p925), Local0)
	m1a4(Local0, 491)

	Store(CondRefOf(p926), Local0)
	m1a4(Local0, 492)

	Store(CondRefOf(p927), Local0)
	m1a4(Local0, 493)

	Store(CondRefOf(p928), Local0)
	m1a4(Local0, 494)

	Store(CondRefOf(p929), Local0)
	m1a4(Local0, 495)

	Store(CondRefOf(p92a), Local0)
	m1a4(Local0, 496)

	Store(CondRefOf(p92b), Local0)
	m1a4(Local0, 497)

	Store(CondRefOf(p92c), Local0)
	m1a4(Local0, 498)

	Store(CondRefOf(p92d), Local0)
	m1a4(Local0, 499)

	Store(CondRefOf(p92e), Local0)
	m1a4(Local0, 500)

	Store(CondRefOf(p92f), Local0)
	m1a4(Local0, 501)

	Store(CondRefOf(p930), Local0)
	m1a4(Local0, 502)

	Store(CondRefOf(p931), Local0)
	m1a4(Local0, 503)

	Store(CondRefOf(p932), Local0)
	m1a4(Local0, 504)

	Store(CondRefOf(p933), Local0)
	m1a4(Local0, 505)

	Store(CondRefOf(p934), Local0)
	m1a4(Local0, 506)

	Store(CondRefOf(p935), Local0)
	m1a4(Local0, 507)

	Store(CondRefOf(p936), Local0)
	m1a4(Local0, 508)

	Store(CondRefOf(p937), Local0)
	m1a4(Local0, 509)

	Store(CondRefOf(p938), Local0)
	m1a4(Local0, 510)

	Store(CondRefOf(p939), Local0)
	m1a4(Local0, 511)

	Store(CondRefOf(p93a), Local0)
	m1a4(Local0, 512)

	Store(CondRefOf(p93b), Local0)
	m1a4(Local0, 513)

	Store(CondRefOf(p93c), Local0)
	m1a4(Local0, 514)

	Store(CondRefOf(p93d), Local0)
	m1a4(Local0, 515)

	Store(CondRefOf(p93e), Local0)
	m1a4(Local0, 516)

	Store(CondRefOf(p93f), Local0)
	m1a4(Local0, 517)

	Store(CondRefOf(p940), Local0)
	m1a4(Local0, 518)

	Store(CondRefOf(p941), Local0)
	m1a4(Local0, 519)

	Store(CondRefOf(p942), Local0)
	m1a4(Local0, 520)

	Store(CondRefOf(p943), Local0)
	m1a4(Local0, 521)

	Store(CondRefOf(p944), Local0)
	m1a4(Local0, 522)

	Store(CondRefOf(p945), Local0)
	m1a4(Local0, 523)

	Store(CondRefOf(p946), Local0)
	m1a4(Local0, 524)

	Store(CondRefOf(p947), Local0)
	m1a4(Local0, 525)

	Store(CondRefOf(p948), Local0)
	m1a4(Local0, 526)

	Store(CondRefOf(p949), Local0)
	m1a4(Local0, 527)

	Store(CondRefOf(p94a), Local0)
	m1a4(Local0, 528)

	Store(CondRefOf(p94b), Local0)
	m1a4(Local0, 529)

	Store(CondRefOf(p94c), Local0)
	m1a4(Local0, 530)

	Store(CondRefOf(p94d), Local0)
	m1a4(Local0, 531)

	Store(CondRefOf(p94e), Local0)
	m1a4(Local0, 532)

	Store(CondRefOf(p94f), Local0)
	m1a4(Local0, 533)

	Store(CondRefOf(p950), Local0)
	m1a4(Local0, 534)

	Store(CondRefOf(p951), Local0)
	m1a4(Local0, 535)

	Store(CondRefOf(p952), Local0)
	m1a4(Local0, 536)

	// Methods

	Store(CondRefOf(m900), Local0)
	m1a4(Local0, 537)

	Store(CondRefOf(m901), Local0)
	m1a4(Local0, 538)

	Store(CondRefOf(m902), Local0)
	m1a4(Local0, 539)

	Store(CondRefOf(m903), Local0)
	m1a4(Local0, 540)

	Store(CondRefOf(m904), Local0)
	m1a4(Local0, 541)

	Store(CondRefOf(m905), Local0)
	m1a4(Local0, 542)

	Store(CondRefOf(m906), Local0)
	m1a4(Local0, 543)

	Store(CondRefOf(m907), Local0)
	m1a4(Local0, 544)

	Store(CondRefOf(m908), Local0)
	m1a4(Local0, 545)

	Store(CondRefOf(m909), Local0)
	m1a4(Local0, 546)

	Store(CondRefOf(m90a), Local0)
	m1a4(Local0, 547)

	Store(CondRefOf(m90b), Local0)
	m1a4(Local0, 548)

	Store(CondRefOf(m90c), Local0)
	m1a4(Local0, 549)

	Store(CondRefOf(m90d), Local0)
	m1a4(Local0, 550)

	Store(CondRefOf(m90e), Local0)
	m1a4(Local0, 551)

	Store(CondRefOf(m90f), Local0)
	m1a4(Local0, 552)

	Store(CondRefOf(m910), Local0)
	m1a4(Local0, 553)

	Store(CondRefOf(m911), Local0)
	m1a4(Local0, 554)

	Store(CondRefOf(m912), Local0)
	m1a4(Local0, 555)

	Store(CondRefOf(m913), Local0)
	m1a4(Local0, 556)

	Store(CondRefOf(m914), Local0)
	m1a4(Local0, 557)

	Store(CondRefOf(m915), Local0)
	m1a4(Local0, 558)

	Store(CondRefOf(m916), Local0)
	m1a4(Local0, 559)

	Store(CondRefOf(m917), Local0)
	m1a4(Local0, 560)

	Store(CondRefOf(m918), Local0)
	m1a4(Local0, 561)

	Store(CondRefOf(m919), Local0)
	m1a4(Local0, 562)

	Store(CondRefOf(m91a), Local0)
	m1a4(Local0, 563)

	Store(CondRefOf(m91b), Local0)
	m1a4(Local0, 564)

	Store(CondRefOf(m91c), Local0)
	m1a4(Local0, 565)

	Store(CondRefOf(m91d), Local0)
	m1a4(Local0, 566)

	Store(CondRefOf(m91e), Local0)
	m1a4(Local0, 567)

	Store(CondRefOf(m91f), Local0)
	m1a4(Local0, 568)

	Store(CondRefOf(m920), Local0)
	m1a4(Local0, 569)

	Store(CondRefOf(m921), Local0)
	m1a4(Local0, 570)

	Store(CondRefOf(m922), Local0)
	m1a4(Local0, 571)

	Store(CondRefOf(m923), Local0)
	m1a4(Local0, 572)

	Store(CondRefOf(m924), Local0)
	m1a4(Local0, 573)

	Store(CondRefOf(m925), Local0)
	m1a4(Local0, 574)

	Store(CondRefOf(m926), Local0)
	m1a4(Local0, 575)

	Store(CondRefOf(m927), Local0)
	m1a4(Local0, 576)

	Store(CondRefOf(m928), Local0)
	m1a4(Local0, 577)

	Store(CondRefOf(m929), Local0)
	m1a4(Local0, 578)

	Store(CondRefOf(m92a), Local0)
	m1a4(Local0, 579)

	Store(CondRefOf(m92b), Local0)
	m1a4(Local0, 580)

	Store(CondRefOf(m92c), Local0)
	m1a4(Local0, 581)

	Store(CondRefOf(m92d), Local0)
	m1a4(Local0, 582)

	Store(CondRefOf(m92e), Local0)
	m1a4(Local0, 583)

	Store(CondRefOf(m92f), Local0)
	m1a4(Local0, 584)

	Store(CondRefOf(m930), Local0)
	m1a4(Local0, 585)

	Store(CondRefOf(m931), Local0)
	m1a4(Local0, 586)

	Store(CondRefOf(m932), Local0)
	m1a4(Local0, 587)

	Store(CondRefOf(m933), Local0)
	m1a4(Local0, 588)

	Store(CondRefOf(m934), Local0)
	m1a4(Local0, 589)

	Store(CondRefOf(m935), Local0)
	m1a4(Local0, 590)

	m1a6()
}

// m16c but with global data
// arg0 - writing mode
Method(m193, 1)
{
	if (y100) {
		ts00("m193")
	} else {
		Store("m193", Debug)
	}

	// T2:CR1-CR14

	// Computational Data

	Store(CondRefOf(i900, Local0), Local1)
	if (m1a4(Local1, 591)) {
		m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a0000, 592)
	}

	Store(CondRefOf(i901, Local0), Local1)
	if (m1a4(Local1, 593)) {
		m1a2(Local0, c009, 0, 0, c009, 0xc1790001, 594)
	}

	Store(CondRefOf(s900, Local0), Local1)
	if (m1a4(Local1, 595)) {
		m1a2(Local0, c00a, 0, 0, c00a, "12340002", 596)
	}

	Store(CondRefOf(s901, Local0), Local1)
	if (m1a4(Local1, 597)) {
		m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu0003", 598)
	}

	Store(CondRefOf(b900, Local0), Local1)
	if (m1a4(Local1, 599)) {
		m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 600)
	}

	// Not Computational Data

	Store(CondRefOf(e900, Local0), Local1)
	m1a0(Local0, c00f, Local1, 609)

	Store(CondRefOf(mx90, Local0), Local1)
	m1a0(Local0, c011, Local1, 610)

	Store(CondRefOf(d900, Local0), Local1)
	m1a0(Local0, c00e, Local1, 611)

	if (arg0) {
		if (y508) {
			Store(CondRefOf(tz90, Local0), Local1)
			m1a0(Local0, c015, Local1, 612)
		}
	} else {
		Store(CondRefOf(tz90, Local0), Local1)
		m1a0(Local0, c015, Local1, 1004)
	}

	Store(CondRefOf(pr90, Local0), Local1)
	m1a0(Local0, c014, Local1, 613)

	if (arg0) {
		if (y510) {
			Store(CondRefOf(r900, Local0), Local1)
			m1a0(Local0, c012, Local1, 614)
		}
	} else {
		Store(CondRefOf(r900, Local0), Local1)
		m1a0(Local0, c012, Local1, 614)
	}

	Store(CondRefOf(pw90, Local0), Local1)
	m1a0(Local0, c013, Local1, 615)

	// Package

	Store(CondRefOf(p953, Local0), Local1)
	if (m1a4(Local1, 1005)) {
		m1a2(Local0, c00c, 1, 0, c009, 0xabcd0018, 1006)
	}

	if (arg0) {
		m1ab()
		return
	}

	// Computational Data (Field Unit and Buffer Field)

	Store(CondRefOf(f900, Local0), Local1)
	if (m1a4(Local1, 601)) {
		m1a2(Local0, c00d, 0, 0, c009, 0, 602)
	}

	Store(CondRefOf(bn90, Local0), Local1)
	if (m1a4(Local1, 603)) {
		m1a2(Local0, c00d, 0, 0, c009, 0, 604)
	}

	Store(CondRefOf(if90, Local0), Local1)
	if (m1a4(Local1, 605)) {
		m1a2(Local0, c00d, 0, 0, c009, 0, 606)
	}

	Store(CondRefOf(bf90, Local0), Local1)
	if (m1a4(Local1, 607)) {
		m1a2(Local0, c016, 0, 0, c009, 0xb0, 608)
	}

	// Elements of Package are Uninitialized

	Store(CondRefOf(p900, Local0), Local1)
	m1a0(Local0, c00c, Local1, 616)

	// Elements of Package are Computational Data

	Store(CondRefOf(p901, Local0), Local1)
	if (m1a4(Local1, 617)) {
		m1a2(Local0, c00c, 1, 0, c009, 0xabcd0004, 618)
		m1a2(Local0, c00c, 1, 1, c009, 0x1122334455660005, 619)
	}

	Store(CondRefOf(p902, Local0), Local1)
	if (m1a4(Local1, 620)) {
		m1a2(Local0, c00c, 1, 0, c00a, "12340006", 621)
		m1a2(Local0, c00c, 1, 1, c00a, "q1w2e3r4t5y6u7i80007", 622)
	}

	Store(CondRefOf(p903, Local0), Local1)
	if (m1a4(Local1, 623)) {
		m1a2(Local0, c00c, 1, 0, c00a, "qwrtyuiop0008", 624)
		m1a2(Local0, c00c, 1, 1, c00a, "1234567890abdef0250009", 625)
	}

	Store(CondRefOf(p904, Local0), Local1)
	if (m1a4(Local1, 626)) {
		m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 627)
	}

	Store(CondRefOf(p905, Local0), Local1)
	if (m1a4(Local1, 628)) {
		m1a2(Local0, c00c, 2, 0, c009, 0xabc000a, 629)
		m1a2(Local0, c00c, 2, 1, c00a, "0xabc000b", 630)
	}

	Store(CondRefOf(p906, Local0), Local1)
	if (m1a4(Local1, 631)) {
		m1a2(Local0, c00c, 2, 0, c00a, "abc000d", 632)
	}

	Store(CondRefOf(p907, Local0), Local1)
	if (m1a4(Local1, 633)) {
		m1a2(Local0, c00c, 2, 0, c00a, "aqwevbgnm000e", 634)
	}

	Store(CondRefOf(p908, Local0), Local1)
	if (m1a4(Local1, 635)) {
		m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 636)
	}

	Store(CondRefOf(p909, Local0), Local1)
	if (m1a4(Local1, 637)) {
		m1a2(Local0, c00c, 3, 0, c009, 0xabc000f, 638)
	}

	Store(CondRefOf(p90a, Local0), Local1)
	if (m1a4(Local1, 639)) {
		m1a2(Local0, c00c, 3, 0, c00a, "12340010", 640)
	}

	Store(CondRefOf(p90b, Local0), Local1)
	if (m1a4(Local1, 641)) {
		m1a2(Local0, c00c, 3, 0, c00a, "zxswefas0011", 642)
	}

	Store(CondRefOf(p90c, Local0), Local1)
	if (m1a4(Local1, 643)) {
		m1a2(Local0, c00c, 3, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 644)
	}

	Store(CondRefOf(p90d, Local0), Local1)
	if (m1a4(Local1, 645)) {
		m1a2(Local0, c00c, 1, 0, c009, 0xfe7cb391d65a0000, 646)
	}

	Store(CondRefOf(p90e, Local0), Local1)
	if (m1a4(Local1, 647)) {
		m1a2(Local0, c00c, 1, 0, c009, 0xc1790001, 648)
	}

	Store(CondRefOf(p90f, Local0), Local1)
	if (m1a4(Local1, 649)) {
		m1a2(Local0, c00c, 1, 0, c00a, "12340002", 650)
	}

	Store(CondRefOf(p910, Local0), Local1)
	if (m1a4(Local1, 651)) {
		m1a2(Local0, c00c, 1, 0, c00a, "qwrtyu0003", 652)
	}

	Store(CondRefOf(p911, Local0), Local1)
	if (m1a4(Local1, 653)) {
		m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 654)
	}

	if (y118) {
		Store(CondRefOf(p912, Local0), Local1)
		if (m1a4(Local1, 655)) {
			m1a2(Local0, c00c, 1, 0, c00d, 0, 656)
		}

		Store(CondRefOf(p913, Local0), Local1)
		if (m1a4(Local1, 657)) {
			m1a2(Local0, c00c, 1, 0, c00d, 0, 658)
		}

		Store(CondRefOf(p914, Local0), Local1)
		if (m1a4(Local1, 659)) {
			m1a2(Local0, c00c, 1, 0, c00d, 0, 660)
		}

		Store(CondRefOf(p915, Local0), Local1)
		if (m1a4(Local1, 661)) {
			m1a2(Local0, c00c, 1, 0, c016, 0xb0, 662)
		}
	}

	// Elements of Package are NOT Computational Data

	Store(CondRefOf(p916, Local0), Local1)
	m1a0(Local0, c00c, Local1, 663)

	Store(CondRefOf(p917, Local0), Local1)
	m1a0(Local0, c00c, Local1, 664)

	Store(CondRefOf(p918, Local0), Local1)
	m1a0(Local0, c00c, Local1, 6655)

	Store(CondRefOf(p919, Local0), Local1)
	m1a0(Local0, c00c, Local1, 666)

	Store(CondRefOf(p91a, Local0), Local1)
	m1a0(Local0, c00c, Local1, 667)

	Store(CondRefOf(p91b, Local0), Local1)
	m1a0(Local0, c00c, Local1, 668)

	Store(CondRefOf(p91c, Local0), Local1)
	m1a0(Local0, c00c, Local1, 669)

	// Elements of Package are Methods

	Store(CondRefOf(p91d, Local0), Local1)
	m1a0(Local0, c00c, Local1, 670)

	Store(CondRefOf(p91e, Local0), Local1)
	m1a0(Local0, c00c, Local1, 671)

	Store(CondRefOf(p91f, Local0), Local1)
	m1a0(Local0, c00c, Local1, 672)

	Store(CondRefOf(p920, Local0), Local1)
	m1a0(Local0, c00c, Local1, 673)

	Store(CondRefOf(p921, Local0), Local1)
	m1a0(Local0, c00c, Local1, 674)

	Store(CondRefOf(p922, Local0), Local1)
	m1a0(Local0, c00c, Local1, 675)

	Store(CondRefOf(p923, Local0), Local1)
	m1a0(Local0, c00c, Local1, 676)

	Store(CondRefOf(p924, Local0), Local1)
	m1a0(Local0, c00c, Local1, 677)

	Store(CondRefOf(p925, Local0), Local1)
	m1a0(Local0, c00c, Local1, 678)

	Store(CondRefOf(p926, Local0), Local1)
	m1a0(Local0, c00c, Local1, 679)

	Store(CondRefOf(p927, Local0), Local1)
	m1a0(Local0, c00c, Local1, 680)

	Store(CondRefOf(p928, Local0), Local1)
	m1a0(Local0, c00c, Local1, 681)

	Store(CondRefOf(p929, Local0), Local1)
	m1a0(Local0, c00c, Local1, 682)

	Store(CondRefOf(p92a, Local0), Local1)
	m1a0(Local0, c00c, Local1, 683)

	Store(CondRefOf(p92b, Local0), Local1)
	m1a0(Local0, c00c, Local1, 684)

	Store(CondRefOf(p92c, Local0), Local1)
	m1a0(Local0, c00c, Local1, 685)

	Store(CondRefOf(p92d, Local0), Local1)
	m1a0(Local0, c00c, Local1, 686)

	Store(CondRefOf(p92e, Local0), Local1)
	m1a0(Local0, c00c, Local1, 687)

	Store(CondRefOf(p92f, Local0), Local1)
	m1a0(Local0, c00c, Local1, 688)

	Store(CondRefOf(p930, Local0), Local1)
	m1a0(Local0, c00c, Local1, 689)

	Store(CondRefOf(p931, Local0), Local1)
	m1a0(Local0, c00c, Local1, 690)

	Store(CondRefOf(p932, Local0), Local1)
	m1a0(Local0, c00c, Local1, 691)

	Store(CondRefOf(p933, Local0), Local1)
	m1a0(Local0, c00c, Local1, 692)

	Store(CondRefOf(p934, Local0), Local1)
	m1a0(Local0, c00c, Local1, 693)

	Store(CondRefOf(p935, Local0), Local1)
	m1a0(Local0, c00c, Local1, 694)

	Store(CondRefOf(p936, Local0), Local1)
	m1a0(Local0, c00c, Local1, 695)

	Store(CondRefOf(p937, Local0), Local1)
	m1a0(Local0, c00c, Local1, 696)

	Store(CondRefOf(p938, Local0), Local1)
	m1a0(Local0, c00c, Local1, 697)

	Store(CondRefOf(p939, Local0), Local1)
	m1a0(Local0, c00c, Local1, 698)

	Store(CondRefOf(p93a, Local0), Local1)
	m1a0(Local0, c00c, Local1, 699)

	Store(CondRefOf(p93b, Local0), Local1)
	m1a0(Local0, c00c, Local1, 700)

	Store(CondRefOf(p93c, Local0), Local1)
	m1a0(Local0, c00c, Local1, 701)

	Store(CondRefOf(p93d, Local0), Local1)
	m1a0(Local0, c00c, Local1, 702)

	Store(CondRefOf(p93e, Local0), Local1)
	m1a0(Local0, c00c, Local1, 703)

	Store(CondRefOf(p93f, Local0), Local1)
	m1a0(Local0, c00c, Local1, 704)

	Store(CondRefOf(p940, Local0), Local1)
	m1a0(Local0, c00c, Local1, 705)

	Store(CondRefOf(p941, Local0), Local1)
	m1a0(Local0, c00c, Local1, 706)

	Store(CondRefOf(p942, Local0), Local1)
	m1a0(Local0, c00c, Local1, 707)

	Store(CondRefOf(p943, Local0), Local1)
	m1a0(Local0, c00c, Local1, 708)

	Store(CondRefOf(p944, Local0), Local1)
	m1a0(Local0, c00c, Local1, 709)

	Store(CondRefOf(p945, Local0), Local1)
	m1a0(Local0, c00c, Local1, 710)

	Store(CondRefOf(p946, Local0), Local1)
	m1a0(Local0, c00c, Local1, 711)

	Store(CondRefOf(p947, Local0), Local1)
	m1a0(Local0, c00c, Local1, 712)

	Store(CondRefOf(p948, Local0), Local1)
	m1a0(Local0, c00c, Local1, 713)

	Store(CondRefOf(p949, Local0), Local1)
	m1a0(Local0, c00c, Local1, 714)

	Store(CondRefOf(p94a, Local0), Local1)
	m1a0(Local0, c00c, Local1, 715)

	Store(CondRefOf(p94b, Local0), Local1)
	m1a0(Local0, c00c, Local1, 716)

	Store(CondRefOf(p94c, Local0), Local1)
	m1a0(Local0, c00c, Local1, 717)

	Store(CondRefOf(p94d, Local0), Local1)
	m1a0(Local0, c00c, Local1, 718)

	Store(CondRefOf(p94e, Local0), Local1)
	m1a0(Local0, c00c, Local1, 719)

	Store(CondRefOf(p94f, Local0), Local1)
	m1a0(Local0, c00c, Local1, 720)

	Store(CondRefOf(p950, Local0), Local1)
	m1a0(Local0, c00c, Local1, 721)

	Store(CondRefOf(p951, Local0), Local1)
	m1a0(Local0, c00c, Local1, 722)

	Store(CondRefOf(p952, Local0), Local1)
	m1a0(Local0, c00c, Local1, 723)

	// Methods

	Store(CondRefOf(m900, Local0), Local1)
	m1a0(Local0, c010, Local1, 724)

	Store(CondRefOf(m901, Local0), Local1)
	m1a0(Local0, c010, Local1, 725)

	Store(CondRefOf(m902, Local0), Local1)
	m1a0(Local0, c010, Local1, 726)

	Store(CondRefOf(m903, Local0), Local1)
	m1a0(Local0, c010, Local1, 727)

	Store(CondRefOf(m904, Local0), Local1)
	m1a0(Local0, c010, Local1, 728)

	Store(CondRefOf(m905, Local0), Local1)
	m1a0(Local0, c010, Local1, 729)

	Store(CondRefOf(m906, Local0), Local1)
	m1a0(Local0, c010, Local1, 730)

	Store(CondRefOf(m907, Local0), Local1)
	m1a0(Local0, c010, Local1, 731)

	Store(CondRefOf(m908, Local0), Local1)
	m1a0(Local0, c010, Local1, 732)

	Store(CondRefOf(m909, Local0), Local1)
	m1a0(Local0, c010, Local1, 733)

	Store(CondRefOf(m90a, Local0), Local1)
	m1a0(Local0, c010, Local1, 734)

	Store(CondRefOf(m90b, Local0), Local1)
	m1a0(Local0, c010, Local1, 735)

	Store(CondRefOf(m90c, Local0), Local1)
	m1a0(Local0, c010, Local1, 736)

	Store(CondRefOf(m90d, Local0), Local1)
	m1a0(Local0, c010, Local1, 737)

	Store(CondRefOf(m90e, Local0), Local1)
	m1a0(Local0, c010, Local1, 738)

	Store(CondRefOf(m90f, Local0), Local1)
	m1a0(Local0, c010, Local1, 739)

	Store(CondRefOf(m910, Local0), Local1)
	m1a0(Local0, c010, Local1, 740)

	Store(CondRefOf(m911, Local0), Local1)
	m1a0(Local0, c010, Local1, 741)

	Store(CondRefOf(m912, Local0), Local1)
	m1a0(Local0, c010, Local1, 742)

	Store(CondRefOf(m913, Local0), Local1)
	m1a0(Local0, c010, Local1, 743)

	Store(CondRefOf(m914, Local0), Local1)
	m1a0(Local0, c010, Local1, 744)

	Store(CondRefOf(m915, Local0), Local1)
	m1a0(Local0, c010, Local1, 745)

	Store(CondRefOf(m916, Local0), Local1)
	m1a0(Local0, c010, Local1, 746)

	Store(CondRefOf(m917, Local0), Local1)
	m1a0(Local0, c010, Local1, 747)

	Store(CondRefOf(m918, Local0), Local1)
	m1a0(Local0, c010, Local1, 748)

	Store(CondRefOf(m919, Local0), Local1)
	m1a0(Local0, c010, Local1, 749)

	Store(CondRefOf(m91a, Local0), Local1)
	m1a0(Local0, c010, Local1, 750)

	Store(CondRefOf(m91b, Local0), Local1)
	m1a0(Local0, c010, Local1, 751)

	Store(CondRefOf(m91c, Local0), Local1)
	m1a0(Local0, c010, Local1, 752)

	Store(CondRefOf(m91d, Local0), Local1)
	m1a0(Local0, c010, Local1, 753)

	Store(CondRefOf(m91e, Local0), Local1)
	m1a0(Local0, c010, Local1, 754)

	Store(CondRefOf(m91f, Local0), Local1)
	m1a0(Local0, c010, Local1, 755)

	Store(CondRefOf(m920, Local0), Local1)
	m1a0(Local0, c010, Local1, 756)

	Store(CondRefOf(m921, Local0), Local1)
	m1a0(Local0, c010, Local1, 757)

	Store(CondRefOf(m922, Local0), Local1)
	m1a0(Local0, c010, Local1, 758)

	Store(CondRefOf(m923, Local0), Local1)
	m1a0(Local0, c010, Local1, 759)

	Store(CondRefOf(m924, Local0), Local1)
	m1a0(Local0, c010, Local1, 760)

	Store(CondRefOf(m925, Local0), Local1)
	m1a0(Local0, c010, Local1, 761)

	Store(CondRefOf(m926, Local0), Local1)
	m1a0(Local0, c010, Local1, 762)

	Store(CondRefOf(m927, Local0), Local1)
	m1a0(Local0, c010, Local1, 763)

	Store(CondRefOf(m928, Local0), Local1)
	m1a0(Local0, c010, Local1, 764)

	Store(CondRefOf(m929, Local0), Local1)
	m1a0(Local0, c010, Local1, 765)

	Store(CondRefOf(m92a, Local0), Local1)
	m1a0(Local0, c010, Local1, 766)

	Store(CondRefOf(m92b, Local0), Local1)
	m1a0(Local0, c010, Local1, 767)

	Store(CondRefOf(m92c, Local0), Local1)
	m1a0(Local0, c010, Local1, 768)

	Store(CondRefOf(m92d, Local0), Local1)
	m1a0(Local0, c010, Local1, 769)

	Store(CondRefOf(m92e, Local0), Local1)
	m1a0(Local0, c010, Local1, 780)

	Store(CondRefOf(m92f, Local0), Local1)
	m1a0(Local0, c010, Local1, 781)

	Store(CondRefOf(m930, Local0), Local1)
	m1a0(Local0, c010, Local1, 782)

	Store(CondRefOf(m931, Local0), Local1)
	m1a0(Local0, c010, Local1, 783)

	Store(CondRefOf(m932, Local0), Local1)
	m1a0(Local0, c010, Local1, 784)

	Store(CondRefOf(m933, Local0), Local1)
	m1a0(Local0, c010, Local1, 785)

	Store(CondRefOf(m934, Local0), Local1)
	m1a0(Local0, c010, Local1, 786)

	Store(CondRefOf(m935, Local0), Local1)
	m1a0(Local0, c010, Local1, 787)

	m1a6()

	return
}

// ///////////////////////////////////////////////////////////////////////////
//
// TABLE 4: all the legal ways to generate references to the named objects
//          being elements of Package
//
// ///////////////////////////////////////////////////////////////////////////

// m16e but with global data
Method(m194)
{
	if (y100) {
		ts00("m194")
	} else {
		Store("m194", Debug)
	}

	if (LNot(y900)) {
		Store("Test m194 skipped!", Debug)
		return
	}

	// T4:x,I1-I14,x,x

	// Computational Data

	Store(Index(Package(){i900}, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a0000, 788)

	Store(Index(Package(){i901}, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xc1790001, 789)

	Store(Index(Package(){s900}, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12340002", 790)

	Store(Index(Package(){s901}, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu0003", 791)

	Store(Index(Package(){b900}, 0), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 792)

	if (y118) {
		Store(Index(Package(){f900}, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 793)

		Store(Index(Package(){bn90}, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 794)

		Store(Index(Package(){if90}, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 795)

		Store(Index(Package(){bf90}, 0), Local0)
		m1a2(Local0, c016, 0, 0, c016, 0xb0, 796)
	}

	// Not Computational Data

	Store(Index(Package(){e900}, 0), Local0)
	m1a0(Local0, c00f, Ones, 797)

	Store(Index(Package(){mx90}, 0), Local0)
	m1a0(Local0, c011, Ones, 798)

	Store(Index(Package(){d900}, 0), Local0)
	m1a0(Local0, c00e, Ones, 799)

	Store(Index(Package(){tz90}, 0), Local0)
	m1a0(Local0, c015, Ones, 800)

	Store(Index(Package(){pr90}, 0), Local0)
	m1a0(Local0, c014, Ones, 801)

	Store(Index(Package(){r900}, 0), Local0)
	m1a0(Local0, c012, Ones, 802)

	Store(Index(Package(){pw90}, 0), Local0)
	m1a0(Local0, c013, Ones, 803)

	// Elements of Package are Uninitialized

	Store(Index(Package(){p900}, 0), Local0)
	m1a0(Local0, c00c, Ones, 804)

	// Elements of Package are Computational Data

	Store(Index(Package(){p901}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabcd0004, 805)
	m1a2(Local0, c00c, 1, 1, c009, 0x1122334455660005, 806)

	Store(Index(Package(){p902}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12340006", 807)
	m1a2(Local0, c00c, 1, 1, c00a, "q1w2e3r4t5y6u7i80007", 808)

	Store(Index(Package(){p903}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyuiop0008", 809)
	m1a2(Local0, c00c, 1, 1, c00a, "1234567890abdef0250009", 810)

	Store(Index(Package(){p904}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 811)

	Store(Index(Package(){p905}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabc000a, 812)
	m1a2(Local0, c00c, 2, 1, c00a, "0xabc000b", 813)

	Store(Index(Package(){p906}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "abc000d", 814)

	Store(Index(Package(){p907}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "aqwevbgnm000e", 815)

	Store(Index(Package(){p908}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 816)

	Store(Index(Package(){p909}, 0), Local0)
	m1a2(Local0, c00c, 3, 0, c009, 0xabc000f, 817)

	Store(Index(Package(){p90a}, 0), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "12340010", 818)

	Store(Index(Package(){p90b}, 0), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "zxswefas0011", 819)

	Store(Index(Package(){p90c}, 0), Local0)
	m1a2(Local0, c00c, 3, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 820)

	Store(Index(Package(){p90d}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xfe7cb391d65a0000, 821)

	Store(Index(Package(){p90e}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xc1790001, 822)

	Store(Index(Package(){p90f}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12340002", 823)

	Store(Index(Package(){p910}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyu0003", 824)

	Store(Index(Package(){p911}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 825)

	if (y118) {
		Store(Index(Package(){p912}, 0), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 826)

		Store(Index(Package(){p913}, 0), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 827)

		Store(Index(Package(){p914}, 0), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 828)

		Store(Index(Package(){p915}, 0), Local0)
		m1a2(Local0, c00c, 1, 0, c016, 0xb0, 829)
	}

	// Elements of Package are NOT Computational Data

	Store(Index(Package(){p916}, 0), Local0)
	m1a0(Local0, c00c, Ones, 830)

	Store(Index(Package(){p917}, 0), Local0)
	m1a0(Local0, c00c, Ones, 831)

	Store(Index(Package(){p918}, 0), Local0)
	m1a0(Local0, c00c, Ones, 832)

	Store(Index(Package(){p919}, 0), Local0)
	m1a0(Local0, c00c, Ones, 833)

	Store(Index(Package(){p91a}, 0), Local0)
	m1a0(Local0, c00c, Ones, 834)

	Store(Index(Package(){p91b}, 0), Local0)
	m1a0(Local0, c00c, Ones, 835)

	Store(Index(Package(){p91c}, 0), Local0)
	m1a0(Local0, c00c, Ones, 836)

	// Elements of Package are Methods

	Store(Index(Package(){p91d}, 0), Local0)
	m1a0(Local0, c00c, Ones, 837)

	Store(Index(Package(){p91e}, 0), Local0)
	m1a0(Local0, c00c, Ones, 838)

	Store(Index(Package(){p91f}, 0), Local0)
	m1a0(Local0, c00c, Ones, 839)

	Store(Index(Package(){p920}, 0), Local0)
	m1a0(Local0, c00c, Ones, 840)

	Store(Index(Package(){p921}, 0), Local0)
	m1a0(Local0, c00c, Ones, 841)

	Store(Index(Package(){p922}, 0), Local0)
	m1a0(Local0, c00c, Ones, 842)

	Store(Index(Package(){p923}, 0), Local0)
	m1a0(Local0, c00c, Ones, 843)

	Store(Index(Package(){p924}, 0), Local0)
	m1a0(Local0, c00c, Ones, 844)

	Store(Index(Package(){p925}, 0), Local0)
	m1a0(Local0, c00c, Ones, 845)

	Store(Index(Package(){p926}, 0), Local0)
	m1a0(Local0, c00c, Ones, 846)

	Store(Index(Package(){p927}, 0), Local0)
	m1a0(Local0, c00c, Ones, 847)

	Store(Index(Package(){p928}, 0), Local0)
	m1a0(Local0, c00c, Ones, 848)

	Store(Index(Package(){p929}, 0), Local0)
	m1a0(Local0, c00c, Ones, 849)

	Store(Index(Package(){p92a}, 0), Local0)
	m1a0(Local0, c00c, Ones, 850)

	Store(Index(Package(){p92b}, 0), Local0)
	m1a0(Local0, c00c, Ones, 851)

	Store(Index(Package(){p92c}, 0), Local0)
	m1a0(Local0, c00c, Ones, 852)

	Store(Index(Package(){p92d}, 0), Local0)
	m1a0(Local0, c00c, Ones, 853)

	Store(Index(Package(){p92e}, 0), Local0)
	m1a0(Local0, c00c, Ones, 854)

	Store(Index(Package(){p92f}, 0), Local0)
	m1a0(Local0, c00c, Ones, 855)

	Store(Index(Package(){p930}, 0), Local0)
	m1a0(Local0, c00c, Ones, 856)

	Store(Index(Package(){p931}, 0), Local0)
	m1a0(Local0, c00c, Ones, 857)

	Store(Index(Package(){p932}, 0), Local0)
	m1a0(Local0, c00c, Ones, 858)

	Store(Index(Package(){p933}, 0), Local0)
	m1a0(Local0, c00c, Ones, 859)

	Store(Index(Package(){p934}, 0), Local0)
	m1a0(Local0, c00c, Ones, 860)

	Store(Index(Package(){p935}, 0), Local0)
	m1a0(Local0, c00c, Ones, 861)

	Store(Index(Package(){p936}, 0), Local0)
	m1a0(Local0, c00c, Ones, 862)

	Store(Index(Package(){p937}, 0), Local0)
	m1a0(Local0, c00c, Ones, 863)

	Store(Index(Package(){p938}, 0), Local0)
	m1a0(Local0, c00c, Ones, 864)

	Store(Index(Package(){p939}, 0), Local0)
	m1a0(Local0, c00c, Ones, 865)

	Store(Index(Package(){p93a}, 0), Local0)
	m1a0(Local0, c00c, Ones, 866)

	Store(Index(Package(){p93b}, 0), Local0)
	m1a0(Local0, c00c, Ones, 867)

	Store(Index(Package(){p93c}, 0), Local0)
	m1a0(Local0, c00c, Ones, 868)

	Store(Index(Package(){p93d}, 0), Local0)
	m1a0(Local0, c00c, Ones, 869)

	Store(Index(Package(){p93e}, 0), Local0)
	m1a0(Local0, c00c, Ones, 870)

	Store(Index(Package(){p93f}, 0), Local0)
	m1a0(Local0, c00c, Ones, 871)

	Store(Index(Package(){p940}, 0), Local0)
	m1a0(Local0, c00c, Ones, 872)

	Store(Index(Package(){p941}, 0), Local0)
	m1a0(Local0, c00c, Ones, 873)

	Store(Index(Package(){p942}, 0), Local0)
	m1a0(Local0, c00c, Ones, 874)

	Store(Index(Package(){p943}, 0), Local0)
	m1a0(Local0, c00c, Ones, 875)

	Store(Index(Package(){p944}, 0), Local0)
	m1a0(Local0, c00c, Ones, 876)

	Store(Index(Package(){p945}, 0), Local0)
	m1a0(Local0, c00c, Ones, 877)

	Store(Index(Package(){p946}, 0), Local0)
	m1a0(Local0, c00c, Ones, 878)

	Store(Index(Package(){p947}, 0), Local0)
	m1a0(Local0, c00c, Ones, 879)

	Store(Index(Package(){p948}, 0), Local0)
	m1a0(Local0, c00c, Ones, 880)

	Store(Index(Package(){p949}, 0), Local0)
	m1a0(Local0, c00c, Ones, 881)

	Store(Index(Package(){p94a}, 0), Local0)
	m1a0(Local0, c00c, Ones, 882)

	Store(Index(Package(){p94b}, 0), Local0)
	m1a0(Local0, c00c, Ones, 883)

	Store(Index(Package(){p94c}, 0), Local0)
	m1a0(Local0, c00c, Ones, 884)

	Store(Index(Package(){p94d}, 0), Local0)
	m1a0(Local0, c00c, Ones, 885)

	Store(Index(Package(){p94e}, 0), Local0)
	m1a0(Local0, c00c, Ones, 886)

	Store(Index(Package(){p94f}, 0), Local0)
	m1a0(Local0, c00c, Ones, 887)

	Store(Index(Package(){p950}, 0), Local0)
	m1a0(Local0, c00c, Ones, 888)

	Store(Index(Package(){p951}, 0), Local0)
	m1a0(Local0, c00c, Ones, 889)

	Store(Index(Package(){p952}, 0), Local0)
	m1a0(Local0, c00c, Ones, 890)

	// Methods

	Store(Index(Package(){m900}, 0), Local0)
	m1a0(Local0, c010, Ones, 891)

	Store(Index(Package(){m901}, 0), Local0)
	m1a0(Local0, c010, Ones, 892)

	Store(Index(Package(){m902}, 0), Local0)
	m1a0(Local0, c010, Ones, 893)

	Store(Index(Package(){m903}, 0), Local0)
	m1a0(Local0, c010, Ones, 894)

	Store(Index(Package(){m904}, 0), Local0)
	m1a0(Local0, c010, Ones, 895)

	Store(Index(Package(){m905}, 0), Local0)
	m1a0(Local0, c010, Ones, 896)

	Store(Index(Package(){m906}, 0), Local0)
	m1a0(Local0, c010, Ones, 897)

	Store(Index(Package(){m907}, 0), Local0)
	m1a0(Local0, c010, Ones, 898)

	Store(Index(Package(){m908}, 0), Local0)
	m1a0(Local0, c010, Ones, 899)

	Store(Index(Package(){m909}, 0), Local0)
	m1a0(Local0, c010, Ones, 900)

	Store(Index(Package(){m90a}, 0), Local0)
	m1a0(Local0, c010, Ones, 901)

	Store(Index(Package(){m90b}, 0), Local0)
	m1a0(Local0, c010, Ones, 902)

	Store(Index(Package(){m90c}, 0), Local0)
	m1a0(Local0, c010, Ones, 903)

	Store(Index(Package(){m90d}, 0), Local0)
	m1a0(Local0, c010, Ones, 904)

	Store(Index(Package(){m90e}, 0), Local0)
	m1a0(Local0, c010, Ones, 905)

	Store(Index(Package(){m90f}, 0), Local0)
	m1a0(Local0, c010, Ones, 906)

	Store(Index(Package(){m910}, 0), Local0)
	m1a0(Local0, c010, Ones, 907)

	Store(Index(Package(){m911}, 0), Local0)
	m1a0(Local0, c010, Ones, 908)

	Store(Index(Package(){m912}, 0), Local0)
	m1a0(Local0, c010, Ones, 909)

	Store(Index(Package(){m913}, 0), Local0)
	m1a0(Local0, c010, Ones, 910)

	Store(Index(Package(){m914}, 0), Local0)
	m1a0(Local0, c010, Ones, 911)

	Store(Index(Package(){m915}, 0), Local0)
	m1a0(Local0, c010, Ones, 912)

	Store(Index(Package(){m916}, 0), Local0)
	m1a0(Local0, c010, Ones, 913)

	Store(Index(Package(){m917}, 0), Local0)
	m1a0(Local0, c010, Ones, 914)

	Store(Index(Package(){m918}, 0), Local0)
	m1a0(Local0, c010, Ones, 915)

	Store(Index(Package(){m919}, 0), Local0)
	m1a0(Local0, c010, Ones, 916)

	Store(Index(Package(){m91a}, 0), Local0)
	m1a0(Local0, c010, Ones, 917)

	Store(Index(Package(){m91b}, 0), Local0)
	m1a0(Local0, c010, Ones, 918)

	Store(Index(Package(){m91c}, 0), Local0)
	m1a0(Local0, c010, Ones, 919)

	Store(Index(Package(){m91d}, 0), Local0)
	m1a0(Local0, c010, Ones, 920)

	Store(Index(Package(){m91e}, 0), Local0)
	m1a0(Local0, c010, Ones, 921)

	Store(Index(Package(){m91f}, 0), Local0)
	m1a0(Local0, c010, Ones, 922)

	Store(Index(Package(){m920}, 0), Local0)
	m1a0(Local0, c010, Ones, 923)

	Store(Index(Package(){m921}, 0), Local0)
	m1a0(Local0, c010, Ones, 924)

	Store(Index(Package(){m922}, 0), Local0)
	m1a0(Local0, c010, Ones, 925)

	Store(Index(Package(){m923}, 0), Local0)
	m1a0(Local0, c010, Ones, 926)

	Store(Index(Package(){m924}, 0), Local0)
	m1a0(Local0, c010, Ones, 927)

	Store(Index(Package(){m925}, 0), Local0)
	m1a0(Local0, c010, Ones, 928)

	Store(Index(Package(){m926}, 0), Local0)
	m1a0(Local0, c010, Ones, 929)

	Store(Index(Package(){m927}, 0), Local0)
	m1a0(Local0, c010, Ones, 930)

	Store(Index(Package(){m928}, 0), Local0)
	m1a0(Local0, c010, Ones, 931)

	Store(Index(Package(){m929}, 0), Local0)
	m1a0(Local0, c010, Ones, 932)

	Store(Index(Package(){m92a}, 0), Local0)
	m1a0(Local0, c010, Ones, 933)

	Store(Index(Package(){m92b}, 0), Local0)
	m1a0(Local0, c010, Ones, 934)

	Store(Index(Package(){m92c}, 0), Local0)
	m1a0(Local0, c010, Ones, 935)

	Store(Index(Package(){m92d}, 0), Local0)
	m1a0(Local0, c010, Ones, 936)

	Store(Index(Package(){m92e}, 0), Local0)
	m1a0(Local0, c010, Ones, 937)

	Store(Index(Package(){m92f}, 0), Local0)
	m1a0(Local0, c010, Ones, 938)

	Store(Index(Package(){m930}, 0), Local0)
	m1a0(Local0, c010, Ones, 939)

	Store(Index(Package(){m931}, 0), Local0)
	m1a0(Local0, c010, Ones, 940)

	Store(Index(Package(){m932}, 0), Local0)
	m1a0(Local0, c010, Ones, 941)

	Store(Index(Package(){m933}, 0), Local0)
	m1a0(Local0, c010, Ones, 942)

	Store(Index(Package(){m934}, 0), Local0)
	m1a0(Local0, c010, Ones, 943)

	Store(Index(Package(){m935}, 0), Local0)
	m1a0(Local0, c010, Ones, 944)

	// T4:x,IR1-IR14,x,x

	// Computational Data

	Store(Index(Package(){i900}, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a0000, 945)
	m1a2(Local1, c009, 0, 0, c009, 0xfe7cb391d65a0000, 946)

	Store(Index(Package(){i901}, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xc1790001, 947)
	m1a2(Local1, c009, 0, 0, c009, 0xc1790001, 948)

	Store(Index(Package(){s900}, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12340002", 949)
	m1a2(Local1, c00a, 0, 0, c00a, "12340002", 950)

	Store(Index(Package(){s901}, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu0003", 951)
	m1a2(Local1, c00a, 0, 0, c00a, "qwrtyu0003", 952)

	Store(Index(Package(){b900}, 0, Local1), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 953)
	m1a2(Local1, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 954)

	if (y118) {
		Store(Index(Package(){f900}, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 955)
		m1a2(Local1, c00d, 0, 0, c00d, 0, 956)

		Store(Index(Package(){bn90}, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 957)
		m1a2(Local1, c00d, 0, 0, c00d, 0, 958)

		Store(Index(Package(){if90}, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 959)
		m1a2(Local1, c00d, 0, 0, c00d, 0, 960)

		Store(Index(Package(){bf90}, 0, Local1), Local0)
		m1a2(Local0, c016, 0, 0, c016, 0xb0, 961)
		m1a2(Local1, c016, 0, 0, c016, 0xb0, 962)
	}

	// Not Computational Data

	Store(Index(Package(){e900}, 0, Local1), Local0)
	m1a0(Local0, c00f, Ones, 963)
	m1a0(Local1, c00f, Ones, 964)

	Store(Index(Package(){mx90}, 0, Local1), Local0)
	m1a0(Local0, c011, Ones, 965)
	m1a0(Local1, c011, Ones, 966)

	Store(Index(Package(){d900}, 0, Local1), Local0)
	m1a0(Local0, c00e, Ones, 967)
	m1a0(Local1, c00e, Ones, 968)

	Store(Index(Package(){tz90}, 0, Local1), Local0)
	m1a0(Local0, c015, Ones, 969)
	m1a0(Local1, c015, Ones, 970)

	Store(Index(Package(){pr90}, 0, Local1), Local0)
	m1a0(Local0, c014, Ones, 971)
	m1a0(Local1, c014, Ones, 972)

	Store(Index(Package(){r900}, 0, Local1), Local0)
	m1a0(Local0, c012, Ones, 973)
	m1a0(Local1, c012, Ones, 974)

	Store(Index(Package(){pw90}, 0, Local1), Local0)
	m1a0(Local0, c013, Ones, 975)
	m1a0(Local1, c013, Ones, 976)

	// Elements of Package are Uninitialized

	Store(Index(Package(){p900}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 977)
	m1a0(Local1, c00c, Ones, 978)

	// Elements of Package are Computational Data

	Store(Index(Package(){p901}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabcd0004, 979)
	m1a2(Local0, c00c, 1, 1, c009, 0x1122334455660005, 980)
	m1a2(Local1, c00c, 1, 0, c009, 0xabcd0004, 981)
	m1a2(Local1, c00c, 1, 1, c009, 0x1122334455660005, 982)

	Store(Index(Package(){p902}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12340006", 983)
	m1a2(Local0, c00c, 1, 1, c00a, "q1w2e3r4t5y6u7i80007", 984)
	m1a2(Local1, c00c, 1, 0, c00a, "12340006", 985)
	m1a2(Local1, c00c, 1, 1, c00a, "q1w2e3r4t5y6u7i80007", 986)

	Store(Index(Package(){p903}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyuiop0008", 987)
	m1a2(Local0, c00c, 1, 1, c00a, "1234567890abdef0250009", 988)
	m1a2(Local1, c00c, 1, 0, c00a, "qwrtyuiop0008", 989)
	m1a2(Local1, c00c, 1, 1, c00a, "1234567890abdef0250009", 990)

	Store(Index(Package(){p904}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 991)
	m1a2(Local1, c00c, 1, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 992)

	Store(Index(Package(){p905}, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabc000a, 993)
	m1a2(Local0, c00c, 2, 1, c00a, "0xabc000b", 994)
	m1a2(Local1, c00c, 2, 0, c009, 0xabc000a, 995)
	m1a2(Local1, c00c, 2, 1, c00a, "0xabc000b", 996)

	Store(Index(Package(){p906}, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "abc000d", 997)
	m1a2(Local1, c00c, 2, 0, c00a, "abc000d", 998)

	Store(Index(Package(){p907}, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "aqwevbgnm000e", 999)
	m1a2(Local1, c00c, 2, 0, c00a, "aqwevbgnm000e", 1000)

	Store(Index(Package(){p908}, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 1001)
	m1a2(Local1, c00c, 2, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 1002)

	Store(Index(Package(){p909}, 0, Local1), Local0)
	m1a2(Local0, c00c, 3, 0, c009, 0xabc000f, 1003)
	m1a2(Local1, c00c, 3, 0, c009, 0xabc000f, 1004)

	Store(Index(Package(){p90a}, 0, Local1), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "12340010", 1005)
	m1a2(Local1, c00c, 3, 0, c00a, "12340010", 1006)

	Store(Index(Package(){p90b}, 0, Local1), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "zxswefas0011", 1007)
	m1a2(Local1, c00c, 3, 0, c00a, "zxswefas0011", 1008)

	Store(Index(Package(){p90c}, 0, Local1), Local0)
	m1a2(Local0, c00c, 3, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 1009)
	m1a2(Local1, c00c, 3, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 1010)

	Store(Index(Package(){p90d}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xfe7cb391d65a0000, 1011)
	m1a2(Local1, c00c, 1, 0, c009, 0xfe7cb391d65a0000, 1012)

	Store(Index(Package(){p90e}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xc1790001, 1013)
	m1a2(Local1, c00c, 1, 0, c009, 0xc1790001, 1014)

	Store(Index(Package(){p90f}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12340002", 1015)
	m1a2(Local1, c00c, 1, 0, c00a, "12340002", 1016)

	Store(Index(Package(){p910}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyu0003", 1017)
	m1a2(Local1, c00c, 1, 0, c00a, "qwrtyu0003", 1018)

	Store(Index(Package(){p911}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 1019)
	m1a2(Local1, c00c, 1, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 1020)

	if (y118) {
		Store(Index(Package(){p912}, 0, Local1), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 1021)
		m1a2(Local1, c00c, 1, 0, c00d, 0, 1022)

		Store(Index(Package(){p913}, 0, Local1), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 1023)
		m1a2(Local1, c00c, 1, 0, c00d, 0, 1024)

		Store(Index(Package(){p914}, 0, Local1), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 1025)
		m1a2(Local1, c00c, 1, 0, c00d, 0, 1026)

		Store(Index(Package(){p915}, 0, Local1), Local0)
		m1a2(Local0, c00c, 1, 0, c016, 0xb0, 1027)
		m1a2(Local1, c00c, 1, 0, c016, 0xb0, 1028)
	}

	// Elements of Package are NOT Computational Data

	Store(Index(Package(){p916}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1029)
	m1a0(Local1, c00c, Ones, 1030)

	Store(Index(Package(){p917}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1031)
	m1a0(Local1, c00c, Ones, 1032)

	Store(Index(Package(){p918}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1033)
	m1a0(Local1, c00c, Ones, 1034)

	Store(Index(Package(){p919}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1035)
	m1a0(Local1, c00c, Ones, 1036)

	Store(Index(Package(){p91a}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1037)
	m1a0(Local1, c00c, Ones, 1038)

	Store(Index(Package(){p91b}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1039)
	m1a0(Local1, c00c, Ones, 1040)

	Store(Index(Package(){p91c}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1041)
	m1a0(Local1, c00c, Ones, 1042)

	// Elements of Package are Methods

	Store(Index(Package(){p91d}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1043)
	m1a0(Local1, c00c, Ones, 1044)

	Store(Index(Package(){p91e}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1045)
	m1a0(Local1, c00c, Ones, 1046)

	Store(Index(Package(){p91f}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1047)
	m1a0(Local1, c00c, Ones, 1048)

	Store(Index(Package(){p920}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1049)
	m1a0(Local1, c00c, Ones, 1050)

	Store(Index(Package(){p921}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1051)
	m1a0(Local1, c00c, Ones, 1052)

	Store(Index(Package(){p922}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1053)
	m1a0(Local1, c00c, Ones, 1054)

	Store(Index(Package(){p923}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1055)
	m1a0(Local1, c00c, Ones, 1056)

	Store(Index(Package(){p924}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1057)
	m1a0(Local1, c00c, Ones, 1058)

	Store(Index(Package(){p925}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1059)
	m1a0(Local1, c00c, Ones, 1060)

	Store(Index(Package(){p926}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1061)
	m1a0(Local1, c00c, Ones, 1062)

	Store(Index(Package(){p927}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1063)
	m1a0(Local1, c00c, Ones, 1064)

	Store(Index(Package(){p928}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1065)
	m1a0(Local1, c00c, Ones, 1066)

	Store(Index(Package(){p929}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1067)
	m1a0(Local1, c00c, Ones, 1068)

	Store(Index(Package(){p92a}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1069)
	m1a0(Local1, c00c, Ones, 1070)

	Store(Index(Package(){p92b}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1071)
	m1a0(Local1, c00c, Ones, 1072)

	Store(Index(Package(){p92c}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1073)
	m1a0(Local1, c00c, Ones, 1074)

	Store(Index(Package(){p92d}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1075)
	m1a0(Local1, c00c, Ones, 1076)

	Store(Index(Package(){p92e}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1077)
	m1a0(Local1, c00c, Ones, 1078)

	Store(Index(Package(){p92f}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1079)
	m1a0(Local1, c00c, Ones, 1080)

	Store(Index(Package(){p930}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1081)
	m1a0(Local1, c00c, Ones, 1082)

	Store(Index(Package(){p931}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1083)
	m1a0(Local1, c00c, Ones, 1084)

	Store(Index(Package(){p932}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1085)
	m1a0(Local1, c00c, Ones, 1086)

	Store(Index(Package(){p933}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1087)
	m1a0(Local1, c00c, Ones, 1088)

	Store(Index(Package(){p934}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1089)
	m1a0(Local1, c00c, Ones, 1090)

	Store(Index(Package(){p935}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1091)
	m1a0(Local1, c00c, Ones, 1092)

	Store(Index(Package(){p936}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1093)
	m1a0(Local1, c00c, Ones, 1094)

	Store(Index(Package(){p937}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1095)
	m1a0(Local1, c00c, Ones, 1096)

	Store(Index(Package(){p938}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1097)
	m1a0(Local1, c00c, Ones, 1098)

	Store(Index(Package(){p939}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1099)
	m1a0(Local1, c00c, Ones, 1100)

	Store(Index(Package(){p93a}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1101)
	m1a0(Local1, c00c, Ones, 1102)

	Store(Index(Package(){p93b}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1103)
	m1a0(Local1, c00c, Ones, 1104)

	Store(Index(Package(){p93c}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1105)
	m1a0(Local1, c00c, Ones, 1106)

	Store(Index(Package(){p93d}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1107)
	m1a0(Local1, c00c, Ones, 1108)

	Store(Index(Package(){p93e}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1109)
	m1a0(Local1, c00c, Ones, 1110)

	Store(Index(Package(){p93f}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1111)
	m1a0(Local1, c00c, Ones, 1112)

	Store(Index(Package(){p940}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1113)
	m1a0(Local1, c00c, Ones, 1114)

	Store(Index(Package(){p941}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1115)
	m1a0(Local1, c00c, Ones, 1116)

	Store(Index(Package(){p942}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1117)
	m1a0(Local1, c00c, Ones, 1118)

	Store(Index(Package(){p943}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1119)
	m1a0(Local1, c00c, Ones, 1120)

	Store(Index(Package(){p944}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1121)
	m1a0(Local1, c00c, Ones, 1122)

	Store(Index(Package(){p945}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1123)
	m1a0(Local1, c00c, Ones, 1124)

	Store(Index(Package(){p946}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1125)
	m1a0(Local1, c00c, Ones, 1126)

	Store(Index(Package(){p947}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1127)
	m1a0(Local1, c00c, Ones, 1128)

	Store(Index(Package(){p948}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1129)
	m1a0(Local1, c00c, Ones, 1130)

	Store(Index(Package(){p949}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1131)
	m1a0(Local1, c00c, Ones, 1132)

	Store(Index(Package(){p94a}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1133)
	m1a0(Local1, c00c, Ones, 1134)

	Store(Index(Package(){p94b}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1135)
	m1a0(Local1, c00c, Ones, 1136)

	Store(Index(Package(){p94c}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1137)
	m1a0(Local1, c00c, Ones, 1138)

	Store(Index(Package(){p94d}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1139)
	m1a0(Local1, c00c, Ones, 1140)

	Store(Index(Package(){p94e}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1141)
	m1a0(Local1, c00c, Ones, 1142)

	Store(Index(Package(){p94f}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1143)
	m1a0(Local1, c00c, Ones, 1144)

	Store(Index(Package(){p950}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1145)
	m1a0(Local1, c00c, Ones, 1146)

	Store(Index(Package(){p951}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1147)
	m1a0(Local1, c00c, Ones, 1148)

	Store(Index(Package(){p952}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1149)
	m1a0(Local1, c00c, Ones, 1150)

	// Methods

	Store(Index(Package(){m900}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1151)
	m1a0(Local1, c010, Ones, 1152)

	Store(Index(Package(){m901}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1153)
	m1a0(Local1, c010, Ones, 1154)

	Store(Index(Package(){m902}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1155)
	m1a0(Local1, c010, Ones, 1156)

	Store(Index(Package(){m903}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1157)
	m1a0(Local1, c010, Ones, 1158)

	Store(Index(Package(){m904}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1159)
	m1a0(Local1, c010, Ones, 1160)

	Store(Index(Package(){m905}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1161)
	m1a0(Local1, c010, Ones, 1162)

	Store(Index(Package(){m906}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1163)
	m1a0(Local1, c010, Ones, 1164)

	Store(Index(Package(){m907}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1165)
	m1a0(Local1, c010, Ones, 1166)

	Store(Index(Package(){m908}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1167)
	m1a0(Local1, c010, Ones, 1168)

	Store(Index(Package(){m909}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1169)
	m1a0(Local1, c010, Ones, 1170)

	Store(Index(Package(){m90a}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1171)
	m1a0(Local1, c010, Ones, 1172)

	Store(Index(Package(){m90b}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1173)
	m1a0(Local1, c010, Ones, 1174)

	Store(Index(Package(){m90c}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1175)
	m1a0(Local1, c010, Ones, 1176)

	Store(Index(Package(){m90d}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1177)
	m1a0(Local1, c010, Ones, 1178)

	Store(Index(Package(){m90e}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1179)
	m1a0(Local1, c010, Ones, 1180)

	Store(Index(Package(){m90f}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1181)
	m1a0(Local1, c010, Ones, 1182)

	Store(Index(Package(){m910}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1183)
	m1a0(Local1, c010, Ones, 1184)

	Store(Index(Package(){m911}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1185)
	m1a0(Local1, c010, Ones, 1186)

	Store(Index(Package(){m912}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1187)
	m1a0(Local1, c010, Ones, 1188)

	Store(Index(Package(){m913}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1189)
	m1a0(Local1, c010, Ones, 1190)

	Store(Index(Package(){m914}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1191)
	m1a0(Local1, c010, Ones, 1192)

	Store(Index(Package(){m915}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1193)
	m1a0(Local1, c010, Ones, 1194)

	Store(Index(Package(){m916}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1195)
	m1a0(Local1, c010, Ones, 1196)

	Store(Index(Package(){m917}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1197)
	m1a0(Local1, c010, Ones, 1198)

	Store(Index(Package(){m918}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1199)
	m1a0(Local1, c010, Ones, 1200)

	Store(Index(Package(){m919}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1201)
	m1a0(Local1, c010, Ones, 1202)

	Store(Index(Package(){m91a}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1203)
	m1a0(Local1, c010, Ones, 1204)

	Store(Index(Package(){m91b}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1205)
	m1a0(Local1, c010, Ones, 1206)

	Store(Index(Package(){m91c}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1207)
	m1a0(Local1, c010, Ones, 1208)

	Store(Index(Package(){m91d}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1209)
	m1a0(Local1, c010, Ones, 1210)

	Store(Index(Package(){m91e}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1211)
	m1a0(Local1, c010, Ones, 1212)

	Store(Index(Package(){m91f}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1213)
	m1a0(Local1, c010, Ones, 1214)

	Store(Index(Package(){m920}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1215)
	m1a0(Local1, c010, Ones, 1216)

	Store(Index(Package(){m921}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1217)
	m1a0(Local1, c010, Ones, 1218)

	Store(Index(Package(){m922}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1219)
	m1a0(Local1, c010, Ones, 1220)

	Store(Index(Package(){m923}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1221)
	m1a0(Local1, c010, Ones, 1222)

	Store(Index(Package(){m924}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1223)
	m1a0(Local1, c010, Ones, 1224)

	Store(Index(Package(){m925}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1225)
	m1a0(Local1, c010, Ones, 1226)

	Store(Index(Package(){m926}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1227)
	m1a0(Local1, c010, Ones, 1228)

	Store(Index(Package(){m927}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1229)
	m1a0(Local1, c010, Ones, 1230)

	Store(Index(Package(){m928}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1231)
	m1a0(Local1, c010, Ones, 1232)

	Store(Index(Package(){m929}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1233)
	m1a0(Local1, c010, Ones, 1234)

	Store(Index(Package(){m92a}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1235)
	m1a0(Local1, c010, Ones, 1236)

	Store(Index(Package(){m92b}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1237)
	m1a0(Local1, c010, Ones, 1238)

	Store(Index(Package(){m92c}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1239)
	m1a0(Local1, c010, Ones, 1240)

	Store(Index(Package(){m92d}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1241)
	m1a0(Local1, c010, Ones, 1242)

	Store(Index(Package(){m92e}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1243)
	m1a0(Local1, c010, Ones, 1244)

	Store(Index(Package(){m92f}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1245)
	m1a0(Local1, c010, Ones, 1246)

	Store(Index(Package(){m930}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1247)
	m1a0(Local1, c010, Ones, 1248)

	Store(Index(Package(){m931}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1249)
	m1a0(Local1, c010, Ones, 1250)

	Store(Index(Package(){m932}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1251)
	m1a0(Local1, c010, Ones, 1252)

	Store(Index(Package(){m933}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1253)
	m1a0(Local1, c010, Ones, 1254)

	Store(Index(Package(){m934}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1255)
	m1a0(Local1, c010, Ones, 1256)

	Store(Index(Package(){m935}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1257)
	m1a0(Local1, c010, Ones, 1258)

	m1a6()
}

Method(m195, 5)
{
	Store(z080, c081)		// absolute index of file initiating the checking
	Store(1, c089)		// flag of Reference, object otherwise

/*
 *	Store(0xd7, f900)
 *	Store(0xd8, if90)
 */

	if (arg0) {
		m190()
	}
	if (arg1) {
		m191(c083)
	}
	if (arg2) {
		m192()
	}
	if (arg3) {
		m193(c083)
	}
	if (arg4) {
		m194()
	}
}

// Usual mode
Method(m196)
{
	Store(1, c084)	// run verification of references (reading)
	Store(0, c085)	// create the chain of references to LocalX, then dereference them

	Store("Usual mode:", Debug)

	m195(1, 1, 1, 1, 1)
}

// The mode with the chain of references to LocalX
Method(m197)
{
	Store(1, c084)	// run verification of references (reading)
	Store(1, c085)	// create the chain of references to LocalX, then dereference them

	Store("The mode with the chain of references to LocalX:", Debug)

	m195(1, 1, 1, 1, 1)
}

// Run-method
Method(REF4)
{
	Store("TEST: REF4, References", Debug)

	Store("REF4", c080)	// name of test
	Store(0, c082)		// flag of test of exceptions
	Store(0, c083)		// run verification of references (write/read)
	Store(0, c086)		// flag, run test till the first error
	Store(1, c087)		// apply DeRefOf to ArgX-ObjectReference

	m196()
	m197()
}
