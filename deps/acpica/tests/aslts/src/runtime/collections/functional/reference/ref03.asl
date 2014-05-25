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
 * TABLE 6: all the legal ways to generate references to ArgX
 *
 * Producing Reference operators:
 *
 *    Index, RefOf, CondRefOf
 */

Name(z079, 79)

// ///////////////////////////////////////////////////////////////////////////
//
// TABLE 6: all the legal ways to generate references to ArgX
//
// ///////////////////////////////////////////////////////////////////////////

// m169,m190,m170
Method(m180, 2)
{
	if (y100) {
		ts00("m180")
	} else {
		Store("m180", Debug)
	}

	// T6:I2-I4

	// Computational Data

	Store(s900, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x31, 1)

	Store(s901, arg1)
	Store(Index(arg1, 2), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x72, 2)

	Store(b900, arg1)
	Store(Index(arg1, 3), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0xb3, 3)

	// Elements of Package are Uninitialized

	if (y104) {
		Store(p900, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c008, Ones, 4)
	}

	// Elements of Package are Computational Data

	Store(p901, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xabcd0004, 5)

	Store(p901, arg1)
	Store(Index(arg1, 1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0x1122334455660005, 6)

	Store(p902, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12340006", 7)

	Store(p902, arg1)
	Store(Index(arg1, 1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "q1w2e3r4t5y6u7i80007", 8)

	Store(p903, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyuiop0008", 9)

	Store(p903, arg1)
	Store(Index(arg1, 1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "1234567890abdef0250009", 10)

	Store(p904, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 11)

	Store(p905, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabc000a, 12)

	Store(p905, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00c, 1, 1, c00a, "0xabc000b", 13)

	Store(p906, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "abc000d", 14)

	Store(p907, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "aqwevbgnm000e", 15)

	Store(p908, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 16)

	Store(p909, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabc000f, 17)

	Store(p90a, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "12340010", 18)

	Store(p90b, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "zxswefas0011", 19)

	Store(p90c, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 20)

	Store(p90d, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a0000, 21)

	Store(p90e, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xc1790001, 22)

	Store(p90f, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12340002", 23)

	Store(p910, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu0003", 24)

	Store(p911, arg1)
	Store(Index(arg1, 0), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 25)

	if (y118) {
		Store(p912, arg1)
		Store(Index(arg1, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 26)

		Store(p913, arg1)
		Store(Index(arg1, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 27)

		Store(p914, arg1)
		Store(Index(arg1, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 28)

		Store(p915, arg1)
		Store(Index(arg1, 0), Local0)
		m1a2(Local0, c016, 0, 0, c016, 0xb0, 29)
	}

	// Elements of Package are NOT Computational Data

	Store(p916, arg1)
	Store(Index(arg1, 0), Local0)
	m1a0(Local0, c00e, Ones, 30)

	Store(p917, arg1)
	Store(Index(arg1, 0), Local0)
	m1a0(Local0, c00f, Ones, 31)

	Store(p918, arg1)
	Store(Index(arg1, 0), Local0)
	m1a0(Local0, c011, Ones, 32)

	Store(p919, arg1)
	Store(Index(arg1, 0), Local0)
	m1a0(Local0, c012, Ones, 33)

	Store(p91a, arg1)
	Store(Index(arg1, 0), Local0)
	m1a0(Local0, c013, Ones, 34)

	Store(p91b, arg1)
	Store(Index(arg1, 0), Local0)
	m1a0(Local0, c014, Ones, 35)

	Store(p91c, arg1)
	Store(Index(arg1, 0), Local0)
	m1a0(Local0, c015, Ones, 36)

	// Elements of Package are Methods

	if (y105) {

		Store(p91d, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 37)

		Store(p91e, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 38)

		Store(p91f, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 39)

		Store(p920, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 40)

		Store(p921, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 41)

		Store(p922, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 42)

		Store(p923, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 43)

		Store(p924, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 44)

		Store(p925, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 45)

		Store(p926, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 46)

		Store(p927, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 47)

		Store(p928, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 48)

		Store(p929, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 49)

		Store(p92a, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 50)

		Store(p92b, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 51)

		Store(p92c, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 52)

		Store(p92d, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 53)

		Store(p92e, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 54)

		Store(p92f, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 55)

		Store(p930, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 56)

		Store(p931, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 57)

		Store(p932, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 58)

		Store(p933, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 59)

		Store(p934, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 60)

		if (y103) {
			Store(p935, arg1)
			Store(Index(arg1, 0), Local0)
			m1a0(Local0, c010, Ones, 61)
		}

		Store(p936, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 62)

		Store(p937, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 63)

		Store(p938, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 64)

		Store(p939, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 65)

		Store(p93a, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 66)

		Store(p93b, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 67)

		Store(p93c, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 68)

		Store(p93d, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 69)

		Store(p93e, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 70)

		Store(p93f, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 71)

		Store(p940, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 72)

		Store(p941, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 73)

		Store(p942, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 74)

		Store(p943, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 75)

		Store(p944, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 76)

		Store(p945, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 77)

		Store(p946, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 78)

		Store(p947, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 79)

		Store(p948, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 80)

		Store(p949, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 81)

		Store(p94a, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 82)

		Store(p94b, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 83)

		Store(p94c, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 84)

		Store(p94d, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 85)

		Store(p94e, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 86)

		Store(p94f, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 87)

		Store(p950, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 88)

		Store(p951, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 89)

		Store(p952, arg1)
		Store(Index(arg1, 0), Local0)
		m1a0(Local0, c010, Ones, 90)
	}

	// T6:IR2-IR4

	// Computational Data

	Store(s900, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x31, 91)
	m1a2(Local1, c016, 0, 0, c009, 0x31, 92)

	Store(s901, arg1)
	Store(Index(arg1, 2, Local1), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x72, 93)
	m1a2(Local1, c016, 0, 0, c009, 0x72, 94)

	Store(b900, arg1)
	Store(Index(arg1, 4, Local1), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0xb4, 95)
	m1a2(Local1, c016, 0, 0, c009, 0xb4, 96)

	// Elements of Package are Uninitialized

	if (y104) {
		Store(p900, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c008, Ones, 97)
		m1a0(Local1, c008, Ones, 98)
	}

	// Elements of Package are Computational Data

	Store(p901, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xabcd0004, 99)
	m1a2(Local1, c009, 0, 0, c009, 0xabcd0004, 100)

	Store(p901, arg1)
	Store(Index(arg1, 1, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0x1122334455660005, 101)
	m1a2(Local1, c009, 0, 0, c009, 0x1122334455660005, 102)

	Store(p902, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12340006", 103)
	m1a2(Local1, c00a, 0, 0, c00a, "12340006", 104)

	Store(p902, arg1)
	Store(Index(arg1, 1, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "q1w2e3r4t5y6u7i80007", 105)
	m1a2(Local1, c00a, 0, 0, c00a, "q1w2e3r4t5y6u7i80007", 106)

	Store(p903, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyuiop0008", 107)
	m1a2(Local1, c00a, 0, 0, c00a, "qwrtyuiop0008", 108)

	Store(p903, arg1)
	Store(Index(arg1, 1, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "1234567890abdef0250009", 109)
	m1a2(Local1, c00a, 0, 0, c00a, "1234567890abdef0250009", 110)

	Store(p904, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 111)
	m1a2(Local1, c00b, 0, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 112)

	Store(p905, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabc000a, 113)
	m1a2(Local1, c00c, 1, 0, c009, 0xabc000a, 114)

	Store(p905, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 1, c00a, "0xabc000b", 115)
	m1a2(Local1, c00c, 1, 1, c00a, "0xabc000b", 116)

	Store(p906, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "abc000d", 117)
	m1a2(Local1, c00c, 1, 0, c00a, "abc000d", 118)

	Store(p907, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "aqwevbgnm000e", 119)
	m1a2(Local1, c00c, 1, 0, c00a, "aqwevbgnm000e", 120)

	Store(p908, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 121)
	m1a2(Local1, c00c, 1, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 122)

	Store(p909, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabc000f, 123)
	m1a2(Local1, c00c, 2, 0, c009, 0xabc000f, 124)

	Store(p90a, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "12340010", 125)
	m1a2(Local1, c00c, 2, 0, c00a, "12340010", 126)

	Store(p90b, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "zxswefas0011", 127)
	m1a2(Local1, c00c, 2, 0, c00a, "zxswefas0011", 128)

	Store(p90c, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 129)
	m1a2(Local1, c00c, 2, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 130)

	Store(p90d, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a0000, 131)
	m1a2(Local1, c009, 0, 0, c009, 0xfe7cb391d65a0000, 132)

	Store(p90e, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xc1790001, 133)
	m1a2(Local1, c009, 0, 0, c009, 0xc1790001, 134)

	Store(p90f, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12340002", 135)
	m1a2(Local1, c00a, 0, 0, c00a, "12340002", 136)

	Store(p910, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu0003", 137)
	m1a2(Local1, c00a, 0, 0, c00a, "qwrtyu0003", 138)

	Store(p911, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 139)
	m1a2(Local1, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 140)

	if (y118) {
		Store(p912, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 141)
		m1a2(Local1, c00d, 0, 0, c00d, 0, 142)

		Store(p913, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 143)
		m1a2(Local1, c00d, 0, 0, c00d, 0, 144)

		Store(p914, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 145)
		m1a2(Local1, c00d, 0, 0, c00d, 0, 146)

		Store(p915, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a2(Local0, c016, 0, 0, c016, 0xb0, 147)
		m1a2(Local1, c016, 0, 0, c016, 0xb0, 148)
	}

	// Elements of Package are NOT Computational Data

	Store(p916, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a0(Local0, c00e, Ones, 149)
	m1a0(Local1, c00e, Ones, 150)

	Store(p917, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a0(Local0, c00f, Ones, 151)
	m1a0(Local1, c00f, Ones, 152)

	Store(p918, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a0(Local0, c011, Ones, 153)
	m1a0(Local1, c011, Ones, 154)

	Store(p919, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a0(Local0, c012, Ones, 155)
	m1a0(Local1, c012, Ones, 156)

	Store(p91a, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a0(Local0, c013, Ones, 157)
	m1a0(Local1, c013, Ones, 158)

	Store(p91b, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a0(Local0, c014, Ones, 159)
	m1a0(Local1, c014, Ones, 160)

	Store(p91c, arg1)
	Store(Index(arg1, 0, Local1), Local0)
	m1a0(Local0, c015, Ones, 161)
	m1a0(Local1, c015, Ones, 162)

	// Elements of Package are Methods

	if (y105) {

		Store(p91d, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 163)
		m1a0(Local1, c010, Ones, 164)

		Store(p91e, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 165)
		m1a0(Local1, c010, Ones, 166)

		Store(p91f, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 167)
		m1a0(Local1, c010, Ones, 168)

		Store(p920, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 169)
		m1a0(Local1, c010, Ones, 170)

		Store(p921, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 171)
		m1a0(Local1, c010, Ones, 172)

		Store(p922, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 173)
		m1a0(Local1, c010, Ones, 174)

		Store(p923, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 175)
		m1a0(Local1, c010, Ones, 176)

		Store(p924, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 177)
		m1a0(Local1, c010, Ones, 178)

		Store(p925, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 179)
		m1a0(Local1, c010, Ones, 180)

		Store(p926, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 181)
		m1a0(Local1, c010, Ones, 182)

		Store(p927, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 183)
		m1a0(Local1, c010, Ones, 184)

		Store(p928, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 185)
		m1a0(Local1, c010, Ones, 186)

		Store(p929, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 187)
		m1a0(Local1, c010, Ones, 188)

		Store(p92a, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 189)
		m1a0(Local1, c010, Ones, 190)

		Store(p92b, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 191)
		m1a0(Local1, c010, Ones, 192)

		Store(p92c, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 193)
		m1a0(Local1, c010, Ones, 194)

		Store(p92d, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 195)
		m1a0(Local1, c010, Ones, 196)

		Store(p92e, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 197)
		m1a0(Local1, c010, Ones, 198)

		Store(p92f, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 199)
		m1a0(Local1, c010, Ones, 200)

		Store(p930, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 201)
		m1a0(Local1, c010, Ones, 202)

		Store(p931, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 203)
		m1a0(Local1, c010, Ones, 204)

		Store(p932, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 205)
		m1a0(Local1, c010, Ones, 206)

		Store(p933, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 207)
		m1a0(Local1, c010, Ones, 208)

		Store(p934, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 209)
		m1a0(Local1, c010, Ones, 210)

		if (y103) {
			Store(p935, arg1)
			Store(Index(arg1, 0, Local1), Local0)
			m1a0(Local0, c010, Ones, 211)
			m1a0(Local1, c010, Ones, 212)
		}

		Store(p936, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 213)
		m1a0(Local1, c010, Ones, 214)

		Store(p937, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 215)
		m1a0(Local1, c010, Ones, 216)

		Store(p938, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 217)
		m1a0(Local1, c010, Ones, 218)

		Store(p939, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 219)
		m1a0(Local1, c010, Ones, 220)

		Store(p93a, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 221)
		m1a0(Local1, c010, Ones, 222)

		Store(p93b, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 223)
		m1a0(Local1, c010, Ones, 224)

		Store(p93c, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 225)
		m1a0(Local1, c010, Ones, 226)

		Store(p93d, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 227)
		m1a0(Local1, c010, Ones, 228)

		Store(p93e, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 229)
		m1a0(Local1, c010, Ones, 230)

		Store(p93f, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 231)
		m1a0(Local1, c010, Ones, 232)

		Store(p940, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 233)
		m1a0(Local1, c010, Ones, 234)

		Store(p941, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 235)
		m1a0(Local1, c010, Ones, 236)

		Store(p942, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 237)
		m1a0(Local1, c010, Ones, 238)

		Store(p943, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 239)
		m1a0(Local1, c010, Ones, 240)

		Store(p944, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 241)
		m1a0(Local1, c010, Ones, 242)

		Store(p945, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 243)
		m1a0(Local1, c010, Ones, 244)

		Store(p946, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 245)
		m1a0(Local1, c010, Ones, 246)

		Store(p947, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 247)
		m1a0(Local1, c010, Ones, 248)

		Store(p948, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 249)
		m1a0(Local1, c010, Ones, 250)

		Store(p949, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 251)
		m1a0(Local1, c010, Ones, 252)

		Store(p94a, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 253)
		m1a0(Local1, c010, Ones, 254)

		Store(p94b, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 255)
		m1a0(Local1, c010, Ones, 256)

		Store(p94c, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 257)
		m1a0(Local1, c010, Ones, 258)

		Store(p94d, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 259)
		m1a0(Local1, c010, Ones, 260)

		Store(p94e, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 261)
		m1a0(Local1, c010, Ones, 262)

		Store(p94f, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 263)
		m1a0(Local1, c010, Ones, 264)

		Store(p950, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 265)
		m1a0(Local1, c010, Ones, 266)

		Store(p951, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 267)
		m1a0(Local1, c010, Ones, 268)

		Store(p952, arg1)
		Store(Index(arg1, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 269)
		m1a0(Local1, c010, Ones, 270)
	}

	m1a6()
}

// m16a,m191,m171
// arg2 - writing mode
Method(m181, 3)
{
	if (y100) {
		ts00("m181")
	} else {
		Store("m181", Debug)
	}

	// T6:R0-R5,R14

	// Uninitialized Local

	if (Arg0) {
		Store(0, arg6)
	}
	Store(RefOf(arg6), Local0)
	m1a0(Local0, c008, Ones, 1000)

	// Computational Data

	Store(i900, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a0000, 271)

	Store(i901, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xc1790001, 272)

	Store(s900, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12340002", 273)

	Store(s901, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu0003", 274)

	Store(b900, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 275)

	// Not Computational Data

	// Package

	Store(p953, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabcd0018, 1007)

	if (arg2) {

		// Data are unchanged, because writings were made
		// into the new objects assosiated with arg1.

		m1a6()
		return
	}

	// Computational Data (Field Unit and Buffer Field)

	Store(f900, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0, 276)

	Store(bn90, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0, 277)

	Store(if90, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0, 278)

	Store(bf90, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xb0, 279)

	// Elements of Package are Uninitialized

	Store(p900, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 287)

	// Elements of Package are Computational Data

	Store(p901, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabcd0004, 288)
	m1a2(Local0, c00c, 1, 1, c009, 0x1122334455660005, 289)

	Store(p902, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12340006", 290)
	m1a2(Local0, c00c, 1, 1, c00a, "q1w2e3r4t5y6u7i80007", 291)

	Store(p903, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyuiop0008", 292)
	m1a2(Local0, c00c, 1, 1, c00a, "1234567890abdef0250009", 293)

	Store(p904, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 294)

	Store(p905, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabc000a, 295)
	m1a2(Local0, c00c, 2, 1, c00a, "0xabc000b", 296)

	Store(p906, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "abc000d", 297)

	Store(p907, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "aqwevbgnm000e", 298)

	Store(p908, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 299)

	Store(p909, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 3, 0, c009, 0xabc000f, 300)

	Store(p90a, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "12340010", 301)

	Store(p90b, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "zxswefas0011", 302)

	Store(p90c, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 3, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 303)

	Store(p90d, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xfe7cb391d65a0000, 304)

	Store(p90e, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xc1790001, 305)

	Store(p90f, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12340002", 306)

	Store(p910, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyu0003", 307)

	Store(p911, arg1)
	Store(RefOf(arg1), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 308)

	if (y118) {
		Store(p912, arg1)
		Store(RefOf(arg1), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 309)

		Store(p913, arg1)
		Store(RefOf(arg1), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 310)

		Store(p914, arg1)
		Store(RefOf(arg1), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 311)

		Store(p915, arg1)
		Store(RefOf(arg1), Local0)
		m1a2(Local0, c00c, 1, 0, c016, 0xb0, 312)
	}

	// Elements of Package are NOT Computational Data

	Store(p916, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 313)

	Store(p917, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 314)

	Store(p918, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 315)

	Store(p919, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 316)

	Store(p91a, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 317)

	Store(p91b, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 318)

	Store(p91c, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 319)

	// Elements of Package are Methods

	Store(p91d, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 320)

	Store(p91e, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 321)

	Store(p91f, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 322)

	Store(p920, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 323)

	Store(p921, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 324)

	Store(p922, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 325)

	Store(p923, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 326)

	Store(p924, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 327)

	Store(p925, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 328)

	Store(p926, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 329)

	Store(p927, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 330)

	Store(p928, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 331)

	Store(p929, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 332)

	Store(p92a, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 333)

	Store(p92b, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 334)

	Store(p92c, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 335)

	Store(p92d, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 336)

	Store(p92e, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 337)

	Store(p92f, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 338)

	Store(p930, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 339)

	Store(p931, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 340)

	Store(p932, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 341)

	Store(p933, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 342)

	Store(p934, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 343)

	Store(p935, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 344)

	Store(p936, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 345)

	Store(p937, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 346)

	Store(p938, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 347)

	Store(p939, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 348)

	Store(p93a, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 349)

	Store(p93b, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 350)

	Store(p93c, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 351)

	Store(p93d, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 352)

	Store(p93e, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 353)

	Store(p93f, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 354)

	Store(p940, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 355)

	Store(p941, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 356)

	Store(p942, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 357)

	Store(p943, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 358)

	Store(p944, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 359)

	Store(p945, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 360)

	Store(p946, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 361)

	Store(p947, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 362)

	Store(p948, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 363)

	Store(p949, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 364)

	Store(p94a, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 365)

	Store(p94b, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 366)

	Store(p94c, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 367)

	Store(p94d, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 368)

	Store(p94e, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 369)

	Store(p94f, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 370)

	Store(p950, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 371)

	Store(p951, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 372)

	Store(p952, arg1)
	Store(RefOf(arg1), Local0)
	m1a0(Local0, c00c, Ones, 373)

	m1a6()

	return
}

// m16c,m193,m172
// arg2 - writing mode
Method(m182, 3)
{
	if (y100) {
		ts00("m182")
	} else {
		Store("m182", Debug)
	}

	// T6:CR0-CR5,CR14

	// Uninitialized Local

	if (Arg0) {
		Store(0, arg6)
	}
	Store(CondRefOf(arg6, Local0), Local1)
	if (m1a4(Local1, 589)) {
		m1a0(Local0, c008, Ones, 590)
	}

	// Computational Data

	Store(i900, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 591)) {
		m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a0000, 592)
	}

	Store(i901, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 593)) {
		m1a2(Local0, c009, 0, 0, c009, 0xc1790001, 594)
	}

	Store(s900, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 595)) {
		m1a2(Local0, c00a, 0, 0, c00a, "12340002", 596)
	}

	Store(s901, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 597)) {
		m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu0003", 598)
	}

	Store(b900, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 599)) {
		m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 600)
	}

	// Not Computational Data

	// Package

	Store(p953, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 1008)) {
		m1a2(Local0, c00c, 1, 0, c009, 0xabcd0018, 1009)
	}

	if (arg2) {

		// Data are unchanged, because writings were made
		// into the new objects assosiated with arg1.

		m1a6()
		return
	}

	// Computational Data (Field Unit and Buffer Field)

	Store(f900, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 601)) {
		m1a2(Local0, c009, 0, 0, c009, 0, 602)
	}

	Store(bn90, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 603)) {
		m1a2(Local0, c009, 0, 0, c009, 0, 604)
	}

	Store(if90, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 605)) {
		m1a2(Local0, c009, 0, 0, c009, 0, 606)
	}

	Store(bf90, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 607)) {
		m1a2(Local0, c009, 0, 0, c009, 0xb0, 608)
	}

	// Elements of Package are Uninitialized

	Store(p900, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 616)

	// Elements of Package are Computational Data

	Store(p901, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 617)) {
		m1a2(Local0, c00c, 1, 0, c009, 0xabcd0004, 618)
		m1a2(Local0, c00c, 1, 1, c009, 0x1122334455660005, 619)
	}

	Store(p902, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 620)) {
		m1a2(Local0, c00c, 1, 0, c00a, "12340006", 621)
		m1a2(Local0, c00c, 1, 1, c00a, "q1w2e3r4t5y6u7i80007", 622)
	}

	Store(p903, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 623)) {
		m1a2(Local0, c00c, 1, 0, c00a, "qwrtyuiop0008", 624)
		m1a2(Local0, c00c, 1, 1, c00a, "1234567890abdef0250009", 625)
	}

	Store(p904, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 626)) {
		m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 627)
	}

	Store(p905, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 628)) {
		m1a2(Local0, c00c, 2, 0, c009, 0xabc000a, 629)
		m1a2(Local0, c00c, 2, 1, c00a, "0xabc000b", 630)
	}

	Store(p906, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 631)) {
		m1a2(Local0, c00c, 2, 0, c00a, "abc000d", 632)
	}

	Store(p907, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 633)) {
		m1a2(Local0, c00c, 2, 0, c00a, "aqwevbgnm000e", 634)
	}

	Store(p908, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 635)) {
		m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 636)
	}

	Store(p909, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 637)) {
		m1a2(Local0, c00c, 3, 0, c009, 0xabc000f, 638)
	}

	Store(p90a, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 639)) {
		m1a2(Local0, c00c, 3, 0, c00a, "12340010", 640)
	}

	Store(p90b, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 641)) {
		m1a2(Local0, c00c, 3, 0, c00a, "zxswefas0011", 642)
	}

	Store(p90c, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 643)) {
		m1a2(Local0, c00c, 3, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 644)
	}

	Store(p90d, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 645)) {
		m1a2(Local0, c00c, 1, 0, c009, 0xfe7cb391d65a0000, 646)
	}

	Store(p90e, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 647)) {
		m1a2(Local0, c00c, 1, 0, c009, 0xc1790001, 648)
	}

	Store(p90f, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 649)) {
		m1a2(Local0, c00c, 1, 0, c00a, "12340002", 650)
	}

	Store(p910, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 651)) {
		m1a2(Local0, c00c, 1, 0, c00a, "qwrtyu0003", 652)
	}

	Store(p911, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	if (m1a4(Local1, 653)) {
		m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 654)
	}

	if (y118) {
		Store(p912, arg1)
		Store(CondRefOf(arg1, Local0), Local1)
		if (m1a4(Local1, 655)) {
			m1a2(Local0, c00c, 1, 0, c00d, 0, 656)
		}

		Store(p913, arg1)
		Store(CondRefOf(arg1, Local0), Local1)
		if (m1a4(Local1, 657)) {
			m1a2(Local0, c00c, 1, 0, c00d, 0, 658)
		}

		Store(p914, arg1)
		Store(CondRefOf(arg1, Local0), Local1)
		if (m1a4(Local1, 659)) {
			m1a2(Local0, c00c, 1, 0, c00d, 0, 660)
		}

		Store(p915, arg1)
		Store(CondRefOf(arg1, Local0), Local1)
		if (m1a4(Local1, 661)) {
			m1a2(Local0, c00c, 1, 0, c016, 0xb0, 662)
		}
	}

	// Elements of Package are NOT Computational Data

	Store(p916, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 663)

	Store(p917, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 664)

	Store(p918, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 6655)

	Store(p919, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 666)

	Store(p91a, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 667)

	Store(p91b, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 668)

	Store(p91c, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 669)

	// Elements of Package are Methods

	Store(p91d, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 670)

	Store(p91e, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 671)

	Store(p91f, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 672)

	Store(p920, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 673)

	Store(p921, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 674)

	Store(p922, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 675)

	Store(p923, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 676)

	Store(p924, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 677)

	Store(p925, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 678)

	Store(p926, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 679)

	Store(p927, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 680)

	Store(p928, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 681)

	Store(p929, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 682)

	Store(p92a, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 683)

	Store(p92b, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 684)

	Store(p92c, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 685)

	Store(p92d, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 686)

	Store(p92e, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 687)

	Store(p92f, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 688)

	Store(p930, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 689)

	Store(p931, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 690)

	Store(p932, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 691)

	Store(p933, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 692)

	Store(p934, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 693)

	Store(p935, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 694)

	Store(p936, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 695)

	Store(p937, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 696)

	Store(p938, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 697)

	Store(p939, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 698)

	Store(p93a, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 699)

	Store(p93b, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 700)

	Store(p93c, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 701)

	Store(p93d, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 702)

	Store(p93e, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 703)

	Store(p93f, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 704)

	Store(p940, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 705)

	Store(p941, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 706)

	Store(p942, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 707)

	Store(p943, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 708)

	Store(p944, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 709)

	Store(p945, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 710)

	Store(p946, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 711)

	Store(p947, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 712)

	Store(p948, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 713)

	Store(p949, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 714)

	Store(p94a, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 715)

	Store(p94b, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 716)

	Store(p94c, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 717)

	Store(p94d, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 718)

	Store(p94e, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 719)

	Store(p94f, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 720)

	Store(p950, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 721)

	Store(p951, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 722)

	Store(p952, arg1)
	Store(CondRefOf(arg1, Local0), Local1)
	m1a0(Local0, c00c, Local1, 723)

	m1a6()

	return
}

Method(m185, 3)
{
	Store(z079, c081)		// absolute index of file initiating the checking
	Store(1, c089)		// flag of Reference, object otherwise

	if (arg0) {
		m180(0, 0)
	}
	if (arg1) {
		m181(0, 0, c083)
	}
	if (arg2) {
		m182(0, 0, c083)
	}
}

// The mode with the chain of references to LocalX
Method(m186)
{
	Store(1, c084)	// run verification of references (reading)
	Store(1, c085)	// create the chain of references to LocalX, then dereference them

	Store("The mode with the chain of references to LocalX:", Debug)

	m185(1, 1, 1)
}

// Run-method
Method(REF3)
{
	Store("TEST: REF3, References", Debug)

	Store("REF3", c080)	// name of test
	Store(0, c082)		// flag of test of exceptions
	Store(0, c083)		// run verification of references (write/read)
	Store(0, c086)		// flag, run test till the first error
	Store(1, c087)		// apply DeRefOf to ArgX-ObjectReference

	m186()
}
