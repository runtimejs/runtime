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

Name(z108, 108)

// m16a
Method(m1b0)
{
	if (y100) {
		ts00("m1b0")
	} else {
		Store("m1b0", Debug)
	}

	// T2:R1-R14

	// Computational Data

	m1a2(i900, c009, 0, 0, c009, 0xfe7cb391d65a0000, 0)
	m1a2(i901, c009, 0, 0, c009, 0xc1790001, 1)
	m1a2(s900, c00a, 0, 0, c00a, "12340002", 2)
	m1a2(s901, c00a, 0, 0, c00a, "qwrtyu0003", 3)
	m1a2(b900, c00b, 0, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 4)
	m1a2(f900, c009, 0, 0, c009, 0, 5)
	m1a2(bn90, c009, 0, 0, c009, 0, 6)
	m1a2(if90, c009, 0, 0, c009, 0, 7)
	m1a2(bf90, c009, 0, 0, c009, 0xb0, 8)

	// Not Computational Data

	m1a0(e900, c00f, Ones, 9)
	m1a0(mx90, c011, Ones, 10)
	if (y511) {
		m1a0(d900, c00e, Ones, 11)
	}
	if (y508) {
		m1a0(tz90, c015, Ones, 12)
	}
	m1a0(pr90, c014, Ones, 13)
	m1a0(r900, c012, Ones, 14)
	m1a0(pw90, c013, Ones, 15)

	// Elements of Package are Uninitialized

	m1a0(p900, c00c, Ones, 16)

	// Elements of Package are Computational Data

	m1a2(p901, c00c, 1, 0, c009, 0xabcd0004, 17)
	m1a2(p901, c00c, 1, 1, c009, 0x1122334455660005, 18)
	m1a2(p902, c00c, 1, 0, c00a, "12340006", 19)
	m1a2(p902, c00c, 1, 1, c00a, "q1w2e3r4t5y6u7i80007", 20)
	m1a2(p903, c00c, 1, 0, c00a, "qwrtyuiop0008", 21)
	m1a2(p903, c00c, 1, 1, c00a, "1234567890abdef0250009", 22)
	m1a2(p904, c00c, 1, 0, c00b, Buffer() {0xb5,0xb6,0xb7}, 23)
	m1a2(p905, c00c, 2, 0, c009, 0xabc000a, 24)
	m1a2(p905, c00c, 2, 1, c00a, "0xabc000b", 25)
	m1a2(p906, c00c, 2, 0, c00a, "abc000d", 26)
	m1a2(p907, c00c, 2, 0, c00a, "aqwevbgnm000e", 27)
	m1a2(p908, c00c, 2, 0, c00b, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}, 28)
	m1a2(p909, c00c, 3, 0, c009, 0xabc000f, 29)
	m1a2(p90a, c00c, 3, 0, c00a, "12340010", 30)
	m1a2(p90b, c00c, 3, 0, c00a, "zxswefas0011", 31)
	m1a2(p90c, c00c, 3, 0, c00b, Buffer() {0xbf,0xc0,0xc1}, 32)
	m1a2(p90d, c00c, 1, 0, c009, 0xfe7cb391d65a0000, 33)
	m1a2(p90e, c00c, 1, 0, c009, 0xc1790001, 34)
	m1a2(p90f, c00c, 1, 0, c00a, "12340002", 35)
	m1a2(p910, c00c, 1, 0, c00a, "qwrtyu0003", 36)
	m1a2(p911, c00c, 1, 0, c00b, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4}, 37)

	if (y118) {
		m1a2(p912, c00c, 1, 0, c00d, 0, 38)
		m1a2(p913, c00c, 1, 0, c00d, 0, 39)
		m1a2(p914, c00c, 1, 0, c00d, 0, 40)
		m1a2(p915, c00c, 1, 0, c016, 0xb0, 41)
	}

	// Elements of Package are NOT Computational Data

	m1a0(p916, c00c, Ones, 42)
	m1a0(p917, c00c, Ones, 43)
	m1a0(p918, c00c, Ones, 44)
	m1a0(p919, c00c, Ones, 45)
	m1a0(p91a, c00c, Ones, 46)
	m1a0(p91b, c00c, Ones, 47)
	m1a0(p91c, c00c, Ones, 48)

	// Elements of Package are Methods

	m1a0(p91d, c00c, Ones, 49)
	m1a0(p91e, c00c, Ones, 50)
	m1a0(p91f, c00c, Ones, 51)
	m1a0(p920, c00c, Ones, 52)
	m1a0(p921, c00c, Ones, 53)
	m1a0(p922, c00c, Ones, 54)
	m1a0(p923, c00c, Ones, 55)
	m1a0(p924, c00c, Ones, 56)
	m1a0(p925, c00c, Ones, 57)
	m1a0(p926, c00c, Ones, 58)
	m1a0(p927, c00c, Ones, 59)
	m1a0(p928, c00c, Ones, 60)
	m1a0(p929, c00c, Ones, 61)
	m1a0(p92a, c00c, Ones, 62)
	m1a0(p92b, c00c, Ones, 63)
	m1a0(p92c, c00c, Ones, 64)
	m1a0(p92d, c00c, Ones, 65)
	m1a0(p92e, c00c, Ones, 66)
	m1a0(p92f, c00c, Ones, 67)
	m1a0(p930, c00c, Ones, 68)
	m1a0(p931, c00c, Ones, 69)
	m1a0(p932, c00c, Ones, 70)
	m1a0(p933, c00c, Ones, 71)
	m1a0(p934, c00c, Ones, 72)
	m1a0(p935, c00c, Ones, 73)
	m1a0(p936, c00c, Ones, 74)
	m1a0(p937, c00c, Ones, 75)
	m1a0(p938, c00c, Ones, 76)
	m1a0(p939, c00c, Ones, 77)
	m1a0(p93a, c00c, Ones, 78)
	m1a0(p93b, c00c, Ones, 79)
	m1a0(p93c, c00c, Ones, 80)
	m1a0(p93d, c00c, Ones, 81)
	m1a0(p93e, c00c, Ones, 82)
	m1a0(p93f, c00c, Ones, 83)
	m1a0(p940, c00c, Ones, 84)
	m1a0(p941, c00c, Ones, 85)
	m1a0(p942, c00c, Ones, 86)
	m1a0(p943, c00c, Ones, 87)
	m1a0(p944, c00c, Ones, 88)
	m1a0(p945, c00c, Ones, 89)
	m1a0(p946, c00c, Ones, 90)
	m1a0(p947, c00c, Ones, 91)
	m1a0(p948, c00c, Ones, 92)
	m1a0(p949, c00c, Ones, 93)
	m1a0(p94a, c00c, Ones, 94)
	m1a0(p94b, c00c, Ones, 95)
	m1a0(p94c, c00c, Ones, 96)
	m1a0(p94d, c00c, Ones, 97)
	m1a0(p94e, c00c, Ones, 98)
	m1a0(p94f, c00c, Ones, 99)
	m1a0(p950, c00c, Ones, 100)
	m1a0(p951, c00c, Ones, 101)
	m1a0(p952, c00c, Ones, 102)
	m1a0(p953, c00c, Ones, 103)

	// Methods

	if (y509) {
		m1a0(m900, c010, Ones, 104)
		m1a0(m901, c010, Ones, 105)
		m1a0(m902, c010, Ones, 106)
		m1a0(m903, c010, Ones, 107)
		m1a0(m904, c010, Ones, 108)
		m1a0(m905, c010, Ones, 109)
		m1a0(m906, c010, Ones, 110)
		m1a0(m907, c010, Ones, 111)
		m1a0(m908, c010, Ones, 112)
		m1a0(m909, c010, Ones, 113)
		m1a0(m90a, c010, Ones, 114)
		m1a0(m90b, c010, Ones, 115)
		m1a0(m90c, c010, Ones, 116)
		m1a0(m90d, c010, Ones, 117)
		m1a0(m90e, c010, Ones, 118)
		m1a0(m90f, c010, Ones, 119)
		m1a0(m910, c010, Ones, 120)
		m1a0(m911, c010, Ones, 121)
		m1a0(m912, c010, Ones, 122)
		m1a0(m913, c010, Ones, 123)
		m1a0(m914, c010, Ones, 124)
		m1a0(m915, c010, Ones, 125)
		m1a0(m916, c010, Ones, 126)
		m1a0(m917, c010, Ones, 127)
		m1a0(m918, c010, Ones, 128)
		m1a0(m919, c010, Ones, 129)
		m1a0(m91a, c010, Ones, 130)
		m1a0(m91b, c010, Ones, 131)
		m1a0(m91c, c010, Ones, 132)
		m1a0(m91d, c010, Ones, 133)
		m1a0(m91e, c010, Ones, 134)
		m1a0(m91f, c010, Ones, 135)
		m1a0(m920, c010, Ones, 136)
		m1a0(m921, c010, Ones, 137)
		m1a0(m922, c010, Ones, 138)
		m1a0(m923, c010, Ones, 139)
		m1a0(m924, c010, Ones, 140)
		m1a0(m925, c010, Ones, 141)
		m1a0(m926, c010, Ones, 142)
		m1a0(m927, c010, Ones, 143)
		m1a0(m928, c010, Ones, 144)
		m1a0(m929, c010, Ones, 145)
		m1a0(m92a, c010, Ones, 146)
		m1a0(m92b, c010, Ones, 147)
		m1a0(m92c, c010, Ones, 148)
		m1a0(m92d, c010, Ones, 149)
		m1a0(m92e, c010, Ones, 150)
		m1a0(m92f, c010, Ones, 151)
		m1a0(m930, c010, Ones, 152)
		m1a0(m931, c010, Ones, 153)
		m1a0(m932, c010, Ones, 154)
		m1a0(m933, c010, Ones, 155)
		m1a0(m934, c010, Ones, 156)
		m1a0(m935, c010, Ones, 157)
	}

	m1a6()
}

/*
 * CopyObject of Object to LocalX:
 *
 * Local0-Local7 can be written with any
 * type object without any conversion.
 *
 * Check each type after each one.
 */
Method(m1b1,, Serialized)
{
	Name(ts, "m1b1")

	Store(z108, c081) // absolute index of file initiating the checking

	// All types

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 158)

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 159)

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 160)

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 161)

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 162)

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 163)

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 164)

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 165)

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 166)

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 167)
	}

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 168)

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 169)

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 170)
	}

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 171)

	/////////////////////// All after Integer

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 172)

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 173)

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 174)

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 175)

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 176)

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 177)

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 178)

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 179)

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 180)

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 181)

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 182)

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 183)

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 184)

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 185)

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 186)

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 187)

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 188)

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 189)

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 190)
	}

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 191)

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 192)

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 193)

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 194)

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 195)

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 196)
	}

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 197)

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 198)

	CopyObject(i900, Local0)
	m1a3(Local0, c009, z108, ts, 199)

	/////////////////////// All-Integer after String

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 200)

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 201)

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 202)

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 203)

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 204)

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 205)

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 206)

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 207)

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 208)

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 209)

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 210)

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 211)

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 212)

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 213)

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 214)

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 215)

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 216)
	}

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 217)

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 218)

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 219)

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 220)

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 221)

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 222)
	}

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 223)

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 224)

	CopyObject(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 225)

	/////////////////////// All-(Integer+String) after Buffer

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 226)

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 227)

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 228)

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 229)

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 230)

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 231)

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 232)

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 233)

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 234)

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 235)

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 236)

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 237)

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 238)

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 239)

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 240)
	}

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 241)

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 242)

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 243)

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 244)

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 245)

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 246)
	}

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 247)

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 247)

	CopyObject(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 249)

	/////////////////////// All-(...) after Package

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 250)

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 251)

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 252)

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 253)

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 254)

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 255)

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 256)

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 257)

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 258)

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 259)

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 260)

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 261)

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 262)
	}

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 263)

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 264)

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 265)

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 266)

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 267)

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 268)
	}

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 269)

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 270)

	CopyObject(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 271)

	/////////////////////// All-(...) after Field Unit

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 272)

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 273)

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 274)

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 275)

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 276)

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 277)

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 278)

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 279)

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 280)

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 281)

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 282)
	}

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 283)

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 284)

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 285)

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 286)

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 287)

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 288)
	}

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 289)

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 290)

	CopyObject(f900, Local0)
	m1a3(Local0, c009, z108, ts, 291)

	/////////////////////// All-(...) after Device

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 292)

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 293)

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 294)

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 295)

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 296)

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 297)

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 298)

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 299)

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 300)
	}

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 301)

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 302)

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 303)

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 304)

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 305)

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 306)
	}

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 307)

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 308)

	CopyObject(d900, Local0)
	m1a3(Local0, c00e, z108, ts, 309)

	/////////////////////// All-(...) after Event

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 310)

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 311)

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 312)

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 313)

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 314)

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 315)

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 316)
	}

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 317)

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 318)

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 319)

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 320)

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 321)

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 322)
	}

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 323)

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 324)

	CopyObject(e900, Local0)
	m1a3(Local0, c00f, z108, ts, 325)

	/////////////////////// All-(...) after Method

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 326)

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 327)

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 328)

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 329)

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 330)
	}

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 331)

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 332)

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 333)

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 334)

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 335)

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 336)
	}

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 337)

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 338)

	if (rn06) {
		CopyObject(m901, Local0)
	} else {
		CopyObject(DerefOf(RefOf(m901)), Local0)
	}
	m1a3(Local0, c010, z108, ts, 339)

	/////////////////////// All-(...) after Mutex

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 340)

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 341)

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 342)
	}

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 343)

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 344)

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 345)

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 346)

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 347)

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 348)
	}

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 349)

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 350)

	CopyObject(mx90, Local0)
	m1a3(Local0, c011, z108, ts, 351)

	/////////////////////// All-(...) after Operation Region

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 352)
	}

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 353)
	}

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 354)

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 355)
	}

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 356)

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 357)
	}

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 358)
	}

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 359)
	}

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 360)

	if (y510) {
		CopyObject(r900, Local0)
		m1a3(Local0, c012, z108, ts, 361)
	}

	/////////////////////// All-(...) after Power Resource

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 362)

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 363)

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 364)

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 365)

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 366)
	}

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 367)

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 368)

	CopyObject(pw90, Local0)
	m1a3(Local0, c013, z108, ts, 369)

	/////////////////////// All-(...) after Processor

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 370)

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 371)

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 372)
	}

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 373)

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 374)

	CopyObject(pr90, Local0)
	m1a3(Local0, c014, z108, ts, 375)

	/////////////////////// All-(...) after Thermal Zone

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 376)
	}

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 377)

	if (y508) {
		CopyObject(tz90, Local0)
		m1a3(Local0, c015, z108, ts, 378)
	}

	/////////////////////// All-(...) after Buffer Field

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 379)

	CopyObject(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 380)
}

/*
 * Store of Object to LocalX:
 *
 * Local0-Local7 can be written without any conversion
 *
 * A set of available for Store types is restricted
 *
 * Check each available type after each one
 */
Method(m1b2,, Serialized)
{
	Name(ts, "m1b2")

	Store(z108, c081) // absolute index of file initiating the checking

	// All available for Store types

	Store(i900, Local0)
	m1a3(Local0, c009, z108, ts, 381)

	Store(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 382)

	Store(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 383)

	Store(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 384)

	Store(f900, Local0)
	m1a3(Local0, c009, z108, ts, 385)

	Store(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 386)

	/////////////////////// All after Integer

	Store(i900, Local0)
	m1a3(Local0, c009, z108, ts, 387)

	Store(i900, Local0)
	m1a3(Local0, c009, z108, ts, 388)

	Store(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 389)

	Store(i900, Local0)
	m1a3(Local0, c009, z108, ts, 390)

	Store(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 391)

	Store(i900, Local0)
	m1a3(Local0, c009, z108, ts, 392)

	Store(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 393)

	Store(i900, Local0)
	m1a3(Local0, c009, z108, ts, 394)

	Store(f900, Local0)
	m1a3(Local0, c009, z108, ts, 395)

	Store(i900, Local0)
	m1a3(Local0, c009, z108, ts, 396)

	Store(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 397)

	Store(i900, Local0)
	m1a3(Local0, c009, z108, ts, 398)

	/////////////////////// All-Integer after String

	Store(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 399)

	Store(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 400)

	Store(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 401)

	Store(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 402)

	Store(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 403)

	Store(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 404)

	Store(f900, Local0)
	m1a3(Local0, c009, z108, ts, 405)

	Store(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 406)
	Store(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 407)

	Store(s900, Local0)
	m1a3(Local0, c00a, z108, ts, 408)

	/////////////////////// All-(Integer+String) after Buffer

	Store(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 409)

	Store(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 410)

	Store(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 411)

	Store(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 412)

	Store(f900, Local0)
	m1a3(Local0, c009, z108, ts, 413)

	Store(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 414)

	Store(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 415)

	Store(b900, Local0)
	m1a3(Local0, c00b, z108, ts, 416)

	/////////////////////// All-(...) after Package

	Store(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 417)

	Store(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 418)

	Store(f900, Local0)
	m1a3(Local0, c009, z108, ts, 419)

	Store(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 420)

	Store(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 421)

	Store(p900, Local0)
	m1a3(Local0, c00c, z108, ts, 422)

	/////////////////////// All-(...) after Field Unit

	Store(f900, Local0)
	m1a3(Local0, c009, z108, ts, 423)

	Store(f900, Local0)
	m1a3(Local0, c009, z108, ts, 424)

	Store(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 425)

	Store(f900, Local0)
	m1a3(Local0, c009, z108, ts, 426)

	/////////////////////// All-(...) after Buffer Field

	Store(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 427)

	Store(bf90, Local0)
	m1a3(Local0, c009, z108, ts, 428)
}

/*
 * CopyObject the result of RefOf/CondRefOf to LocalX
 *
 * Local0-Local7 can be written with RefOf_References
 * to any type object without any conversion.
 *
 * Check each type after each one.
 *
 * The same as m1b1 but RefOf() added.
 */
Method(m1b4,, Serialized)
{
	Name(ts, "m1b4")

	Store(z108, c081) // absolute index of file initiating the checking

	// All types

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 429)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 430)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 431)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 432)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 433)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 434)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 435)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 436)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 437)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 438)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 439)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 440)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 441)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 442)

	/////////////////////// All after Integer

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 443)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 444)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 445)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 446)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 447)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 448)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 449)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 450)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 451)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 452)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 453)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 454)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 455)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 456)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 457)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 458)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 459)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 460)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 461)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 462)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 463)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 464)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 465)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 466)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 467)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 468)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 469)

	CopyObject(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 470)

	/////////////////////// All-Integer after String

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 471)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 472)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 473)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 474)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 475)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 476)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 477)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 478)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 479)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 480)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 481)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 482)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 483)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 484)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 485)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 486)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 487)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 488)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 489)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 490)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 491)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 492)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 493)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 494)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 495)

	CopyObject(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 496)

	/////////////////////// All-(Integer+String) after Buffer

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 497)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 498)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 499)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 500)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 501)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 502)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 503)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 504)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 505)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 506)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 507)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 508)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 509)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 510)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 511)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 512)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 513)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 514)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 515)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 516)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 517)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 518)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 519)

	CopyObject(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 520)

	/////////////////////// All-(...) after Package

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 521)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 522)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 523)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 524)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 525)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 526)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 527)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 528)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 529)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 560)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 561)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 562)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 563)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 564)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 565)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 566)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 567)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 568)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 569)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 570)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 571)

	CopyObject(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 572)

	/////////////////////// All-(...) after Field Unit

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 573)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 574)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 575)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 576)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 577)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 578)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 579)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 580)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 581)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 582)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 583)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 584)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 585)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 586)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 587)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 588)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 589)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 590)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 591)

	CopyObject(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 592)

	/////////////////////// All-(...) after Device

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 593)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 594)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 595)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 596)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 597)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 598)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 599)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 600)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 601)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 602)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 603)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 604)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 605)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 606)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 607)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 608)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 609)

	CopyObject(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 610)

	/////////////////////// All-(...) after Event

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 611)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 612)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 613)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 614)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 615)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 616)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 617)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 618)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 619)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 620)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 621)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 622)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 623)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 624)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 625)

	CopyObject(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 626)

	/////////////////////// All-(...) after Method

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 627)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 628)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 629)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 630)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 631)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 632)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 633)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 634)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 635)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 636)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 637)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 638)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 639)

	CopyObject(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 640)

	/////////////////////// All-(...) after Mutex

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 641)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 642)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 643)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 644)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 645)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 646)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 647)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 648)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 649)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 650)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 651)

	CopyObject(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 652)

	/////////////////////// All-(...) after Operation Region

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 653)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 654)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 655)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 656)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 657)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 658)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 659)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 660)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 661)

		CopyObject(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 662)

	/////////////////////// All-(...) after Power Resource

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 663)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 664)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 665)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 666)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 667)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 668)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 669)

	CopyObject(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 670)

	/////////////////////// All-(...) after Processor

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 671)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 672)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 673)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 674)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 675)

	CopyObject(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 676)

	/////////////////////// All-(...) after Thermal Zone

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 677)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 678)

		CopyObject(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 679)

	/////////////////////// All-(...) after Buffer Field

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 680)

	CopyObject(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 681)
}

/*
 * Store the result of RefOf/CondRefOf to LocalX
 *
 * The same as m1b4 but Store instead of CopyObject.
 */
Method(m1b5,, Serialized)
{
	Name(ts, "m1b5")

	Store(z108, c081) // absolute index of file initiating the checking

	// All types

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 682)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 683)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 684)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 685)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 686)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 687)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 688)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 689)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 690)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 691)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 692)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 693)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 694)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 695)

	/////////////////////// All after Integer

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 696)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 697)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 698)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 699)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 700)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 701)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 702)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 703)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 704)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 705)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 706)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 707)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 708)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 709)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 710)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 711)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 712)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 713)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 714)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 715)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 716)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 717)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 718)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 719)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 720)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 721)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 722)

	Store(RefOf(i900), Local0)
	m1a3(Local0, c009, z108, ts, 723)

	/////////////////////// All-Integer after String

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 724)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 725)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 726)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 727)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 728)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 729)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 730)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 731)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 732)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 733)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 734)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 735)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 736)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 737)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 738)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 739)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 740)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 741)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 742)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 743)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 744)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 745)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 746)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 747)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 748)

	Store(RefOf(s900), Local0)
	m1a3(Local0, c00a, z108, ts, 749)

	/////////////////////// All-(Integer+String) after Buffer

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 750)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 751)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 752)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 753)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 754)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 755)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 756)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 757)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 758)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 759)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 760)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 761)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 762)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 763)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 764)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 765)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 766)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 767)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 768)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 769)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 770)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 771)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 772)

	Store(RefOf(b900), Local0)
	m1a3(Local0, c00b, z108, ts, 773)

	/////////////////////// All-(...) after Package

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 774)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 775)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 776)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 777)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 778)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 779)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 780)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 781)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 782)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 783)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 784)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 785)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 786)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 787)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 788)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 789)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 790)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 791)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 792)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 793)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 794)

	Store(RefOf(p900), Local0)
	m1a3(Local0, c00c, z108, ts, 795)

	/////////////////////// All-(...) after Field Unit

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 796)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 797)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 798)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 799)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 800)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 801)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 802)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 803)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 804)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 805)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 806)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 807)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 808)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 809)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 810)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 811)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 812)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 813)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 814)

	Store(RefOf(f900), Local0)
	m1a3(Local0, c00d, z108, ts, 815)

	/////////////////////// All-(...) after Device

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 816)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 817)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 818)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 819)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 820)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 821)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 822)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 823)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 824)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 825)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 826)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 827)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 828)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 829)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 830)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 831)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 832)

	Store(RefOf(d900), Local0)
	m1a3(Local0, c00e, z108, ts, 833)

	/////////////////////// All-(...) after Event

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 834)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 835)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 836)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 837)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 838)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 839)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 840)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 841)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 842)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 843)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 844)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 845)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 846)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 847)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 848)

	Store(RefOf(e900), Local0)
	m1a3(Local0, c00f, z108, ts, 849)

	/////////////////////// All-(...) after Method

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 850)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 851)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 852)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 853)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 854)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 855)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 956)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 857)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 858)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 859)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 860)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 861)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 862)

	Store(RefOf(m901), Local0)
	m1a3(Local0, c010, z108, ts, 863)

	/////////////////////// All-(...) after Mutex

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 864)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 865)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 866)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 867)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 868)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 869)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 870)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 871)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 872)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 873)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 874)

	Store(RefOf(mx90), Local0)
	m1a3(Local0, c011, z108, ts, 875)

	/////////////////////// All-(...) after Operation Region

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 876)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 877)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 878)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 879)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 880)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 881)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 882)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 883)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 884)

		Store(RefOf(r900), Local0)
		m1a3(Local0, c012, z108, ts, 885)

	/////////////////////// All-(...) after Power Resource

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 886)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 887)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 888)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 889)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 890)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 891)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 892)

	Store(RefOf(pw90), Local0)
	m1a3(Local0, c013, z108, ts, 893)

	/////////////////////// All-(...) after Processor

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 894)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 895)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 896)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 897)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 898)

	Store(RefOf(pr90), Local0)
	m1a3(Local0, c014, z108, ts, 899)

	/////////////////////// All-(...) after Thermal Zone

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 900)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 901)

		Store(RefOf(tz90), Local0)
		m1a3(Local0, c015, z108, ts, 902)

	/////////////////////// All-(...) after Buffer Field

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 903)

	Store(RefOf(bf90), Local0)
	m1a3(Local0, c016, z108, ts, 904)
}

// CopyObject the result of Index to LocalX
Method(m1b6,, Serialized)
{
	Name(ts, "m1b6")

	Store(z108, c081) // absolute index of file initiating the checking

	// Computational Data

	CopyObject(Index(s900, 1, Local0), Local1)
	m1a3(Local0, c016, z108, ts, 905)
	m1a3(Local1, c016, z108, ts, 906)

	CopyObject(Index(b900, 1, Local0), Local1)
	m1a3(Local0, c016, z108, ts, 907)
	m1a3(Local1, c016, z108, ts, 908)

	// Elements of Package are Uninitialized

	if (y127) {
		CopyObject(Index(p900, 0, Local0), Local1)
		m1a3(Local0, c008, z108, ts, 909)
		m1a3(Local1, c008, z108, ts, 910)
	}

	// Elements of Package are Computational Data

	CopyObject(Index(p901, 1, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 911)
	m1a3(Local1, c009, z108, ts, 912)

	CopyObject(Index(p904, 1, Local0), Local1)
	m1a3(Local0, c00b, z108, ts, 913)
	m1a3(Local1, c00b, z108, ts, 914)

	CopyObject(Index(p905, 0, Local0), Local1)
	m1a3(Local0, c00c, z108, ts, 915)
	m1a3(Local1, c00c, z108, ts, 916)

	CopyObject(Index(p90d, 0, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 917)
	m1a3(Local1, c009, z108, ts, 918)

	CopyObject(Index(p90e, 0, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 919)
	m1a3(Local1, c009, z108, ts, 920)

	CopyObject(Index(p90f, 0, Local0), Local1)
	m1a3(Local0, c00a, z108, ts, 921)
	m1a3(Local1, c00a, z108, ts, 922)

	CopyObject(Index(p910, 0, Local0), Local1)
	m1a3(Local0, c00a, z108, ts, 923)
	m1a3(Local1, c00a, z108, ts, 924)

	CopyObject(Index(p911, 0, Local0), Local1)
	m1a3(Local0, c00b, z108, ts, 925)
	m1a3(Local1, c00b, z108, ts, 926)

    // These objects become an integer in a package

	CopyObject(Index(p912, 0, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 927)
	m1a3(Local1, c009, z108, ts, 928)

	CopyObject(Index(p913, 0, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 929)
	m1a3(Local1, c009, z108, ts, 930)

	CopyObject(Index(p914, 0, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 931)
	m1a3(Local1, c009, z108, ts, 932)

	CopyObject(Index(p915, 0, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 933)
	m1a3(Local1, c009, z108, ts, 934)

	// Elements of Package are NOT Computational Data

	CopyObject(Index(p916, 0, Local0), Local1)
	m1a3(Local0, c00e, z108, ts, 935)
	m1a3(Local1, c00e, z108, ts, 936)

	CopyObject(Index(p917, 0, Local0), Local1)
	m1a3(Local0, c00f, z108, ts, 937)
	m1a3(Local1, c00f, z108, ts, 938)

	CopyObject(Index(p918, 0, Local0), Local1)
	m1a3(Local0, c011, z108, ts, 939)
	m1a3(Local1, c011, z108, ts, 940)

	CopyObject(Index(p919, 0, Local0), Local1)
	m1a3(Local0, c012, z108, ts, 941)
	m1a3(Local1, c012, z108, ts, 942)

	CopyObject(Index(p91a, 0, Local0), Local1)
	m1a3(Local0, c013, z108, ts, 943)
	m1a3(Local1, c013, z108, ts, 944)

	CopyObject(Index(p91b, 0, Local0), Local1)
	m1a3(Local0, c014, z108, ts, 945)
	m1a3(Local1, c014, z108, ts, 946)

	CopyObject(Index(p91c, 0, Local0), Local1)
	m1a3(Local0, c015, z108, ts, 947)
	m1a3(Local1, c015, z108, ts, 948)

	// Elements of Package are Methods

	CopyObject(Index(p91d, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 949)
	m1a3(Local1, c010, z108, ts, 950)

	CopyObject(Index(p91e, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 951)
	m1a3(Local1, c010, z108, ts, 952)

	CopyObject(Index(p91f, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 953)
	m1a3(Local1, c010, z108, ts, 954)

	CopyObject(Index(p920, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 955)
	m1a3(Local1, c010, z108, ts, 956)

	CopyObject(Index(p921, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 957)
	m1a3(Local1, c010, z108, ts, 958)

	CopyObject(Index(p922, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 959)
	m1a3(Local1, c010, z108, ts, 960)

	CopyObject(Index(p923, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 961)
	m1a3(Local1, c010, z108, ts, 962)

	CopyObject(Index(p924, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 963)
	m1a3(Local1, c010, z108, ts, 964)

	CopyObject(Index(p925, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 965)
	m1a3(Local1, c010, z108, ts, 966)

	CopyObject(Index(p926, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 967)
	m1a3(Local1, c010, z108, ts, 968)

	CopyObject(Index(p927, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 969)
	m1a3(Local1, c010, z108, ts, 970)

	CopyObject(Index(p928, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 971)
	m1a3(Local1, c010, z108, ts, 972)

	CopyObject(Index(p929, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 973)
	m1a3(Local1, c010, z108, ts, 974)

	CopyObject(Index(p92a, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 975)
	m1a3(Local1, c010, z108, ts, 976)

	CopyObject(Index(p92b, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 977)
	m1a3(Local1, c010, z108, ts, 978)

	CopyObject(Index(p92c, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 979)
	m1a3(Local1, c010, z108, ts, 980)

	CopyObject(Index(p92d, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 981)
	m1a3(Local1, c010, z108, ts, 982)

	CopyObject(Index(p92e, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 983)
	m1a3(Local1, c010, z108, ts, 984)

	CopyObject(Index(p92f, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 985)
	m1a3(Local1, c010, z108, ts, 986)

	CopyObject(Index(p930, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 987)
	m1a3(Local1, c010, z108, ts, 988)

	CopyObject(Index(p931, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 989)
	m1a3(Local1, c010, z108, ts, 990)

	CopyObject(Index(p932, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 991)
	m1a3(Local1, c010, z108, ts, 992)

	CopyObject(Index(p933, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 993)
	m1a3(Local1, c010, z108, ts, 994)

	CopyObject(Index(p934, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 995)
	m1a3(Local1, c010, z108, ts, 996)

	CopyObject(Index(p935, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 997)
	m1a3(Local1, c010, z108, ts, 998)

	CopyObject(Index(p936, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 999)
	m1a3(Local1, c010, z108, ts, 1000)

	CopyObject(Index(p937, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1001)
	m1a3(Local1, c010, z108, ts, 1002)

	CopyObject(Index(p938, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1003)
	m1a3(Local1, c010, z108, ts, 1004)

	CopyObject(Index(p939, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1005)
	m1a3(Local1, c010, z108, ts, 1006)

	CopyObject(Index(p93a, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1007)
	m1a3(Local1, c010, z108, ts, 1008)

	CopyObject(Index(p93b, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1009)
	m1a3(Local1, c010, z108, ts, 1010)

	m1a6()
}

// Store the result of Index to LocalX.
//
// The same as m1b6 but Store instead of CopyObject.
Method(m1b7,, Serialized)
{
	Name(ts, "m1b7")

	Store(z108, c081) // absolute index of file initiating the checking

	// Computational Data

	Store(Index(s900, 1, Local0), Local1)
	m1a3(Local0, c016, z108, ts, 1011)
	m1a3(Local1, c016, z108, ts, 1012)

	Store(Index(b900, 1, Local0), Local1)
	m1a3(Local0, c016, z108, ts, 1013)
	m1a3(Local1, c016, z108, ts, 1014)

	// Elements of Package are Uninitialized

		Store(Index(p900, 0, Local0), Local1)
		m1a3(Local0, c008, z108, ts, 1015)
		m1a3(Local1, c008, z108, ts, 1016)

	// Elements of Package are Computational Data

	Store(Index(p901, 1, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 1017)
	m1a3(Local1, c009, z108, ts, 1018)

	Store(Index(p904, 1, Local0), Local1)
	m1a3(Local0, c00b, z108, ts, 1019)
	m1a3(Local1, c00b, z108, ts, 1020)

	Store(Index(p905, 0, Local0), Local1)
	m1a3(Local0, c00c, z108, ts, 1021)
	m1a3(Local1, c00c, z108, ts, 1022)

	Store(Index(p90d, 0, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 1023)
	m1a3(Local1, c009, z108, ts, 1024)

	Store(Index(p90e, 0, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 1025)
	m1a3(Local1, c009, z108, ts, 1026)

	Store(Index(p90f, 0, Local0), Local1)
	m1a3(Local0, c00a, z108, ts, 1027)
	m1a3(Local1, c00a, z108, ts, 1028)

	Store(Index(p910, 0, Local0), Local1)
	m1a3(Local0, c00a, z108, ts, 1029)
	m1a3(Local1, c00a, z108, ts, 1030)

	Store(Index(p911, 0, Local0), Local1)
	m1a3(Local0, c00b, z108, ts, 1031)
	m1a3(Local1, c00b, z108, ts, 1032)

    // These objects become an integer in a package

	Store(Index(p912, 0, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 1033)
	m1a3(Local1, c009, z108, ts, 1034)

	Store(Index(p913, 0, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 1035)
	m1a3(Local1, c009, z108, ts, 1036)

	Store(Index(p914, 0, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 1037)
	m1a3(Local1, c009, z108, ts, 1038)

	Store(Index(p915, 0, Local0), Local1)
	m1a3(Local0, c009, z108, ts, 1039)
	m1a3(Local1, c009, z108, ts, 1040)

	// Elements of Package are NOT Computational Data

	Store(Index(p916, 0, Local0), Local1)
	m1a3(Local0, c00e, z108, ts, 1041)
	m1a3(Local1, c00e, z108, ts, 1042)

	Store(Index(p917, 0, Local0), Local1)
	m1a3(Local0, c00f, z108, ts, 1043)
	m1a3(Local1, c00f, z108, ts, 1044)

	Store(Index(p918, 0, Local0), Local1)
	m1a3(Local0, c011, z108, ts, 1045)
	m1a3(Local1, c011, z108, ts, 1046)

	Store(Index(p919, 0, Local0), Local1)
	m1a3(Local0, c012, z108, ts, 1047)
	m1a3(Local1, c012, z108, ts, 1048)

	Store(Index(p91a, 0, Local0), Local1)
	m1a3(Local0, c013, z108, ts, 1049)
	m1a3(Local1, c013, z108, ts, 1050)

	Store(Index(p91b, 0, Local0), Local1)
	m1a3(Local0, c014, z108, ts, 1051)
	m1a3(Local1, c014, z108, ts, 1052)

	Store(Index(p91c, 0, Local0), Local1)
	m1a3(Local0, c015, z108, ts, 1053)
	m1a3(Local1, c015, z108, ts, 1054)

	// Elements of Package are Methods

	Store(Index(p91d, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1055)
	m1a3(Local1, c010, z108, ts, 1056)

	Store(Index(p91e, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1057)
	m1a3(Local1, c010, z108, ts, 1058)

	Store(Index(p91f, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1059)
	m1a3(Local1, c010, z108, ts, 1060)

	Store(Index(p920, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1061)
	m1a3(Local1, c010, z108, ts, 1062)

	Store(Index(p921, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1063)
	m1a3(Local1, c010, z108, ts, 1064)

	Store(Index(p922, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1065)
	m1a3(Local1, c010, z108, ts, 1066)

	Store(Index(p923, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1067)
	m1a3(Local1, c010, z108, ts, 1068)

	Store(Index(p924, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1069)
	m1a3(Local1, c010, z108, ts, 1070)

	Store(Index(p925, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1071)
	m1a3(Local1, c010, z108, ts, 1072)

	Store(Index(p926, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1073)
	m1a3(Local1, c010, z108, ts, 1074)

	Store(Index(p927, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1075)
	m1a3(Local1, c010, z108, ts, 1076)

	Store(Index(p928, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1077)
	m1a3(Local1, c010, z108, ts, 1078)

	Store(Index(p929, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1079)
	m1a3(Local1, c010, z108, ts, 1080)

	Store(Index(p92a, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1081)
	m1a3(Local1, c010, z108, ts, 1082)

	Store(Index(p92b, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1083)
	m1a3(Local1, c010, z108, ts, 1084)

	Store(Index(p92c, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1085)
	m1a3(Local1, c010, z108, ts, 1086)

	Store(Index(p92d, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1087)
	m1a3(Local1, c010, z108, ts, 1088)

	Store(Index(p92e, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1089)
	m1a3(Local1, c010, z108, ts, 1090)

	Store(Index(p92f, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1091)
	m1a3(Local1, c010, z108, ts, 1092)

	Store(Index(p930, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1093)
	m1a3(Local1, c010, z108, ts, 1094)

	Store(Index(p931, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1095)
	m1a3(Local1, c010, z108, ts, 1096)

	Store(Index(p932, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1097)
	m1a3(Local1, c010, z108, ts, 1098)

	Store(Index(p933, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1099)
	m1a3(Local1, c010, z108, ts, 1100)

	Store(Index(p934, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1101)
	m1a3(Local1, c010, z108, ts, 1102)

	Store(Index(p935, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1103)
	m1a3(Local1, c010, z108, ts, 1104)

	Store(Index(p936, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1105)
	m1a3(Local1, c010, z108, ts, 1106)

	Store(Index(p937, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1107)
	m1a3(Local1, c010, z108, ts, 1108)

	Store(Index(p938, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1109)
	m1a3(Local1, c010, z108, ts, 1110)

	Store(Index(p939, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1111)
	m1a3(Local1, c010, z108, ts, 1112)

	Store(Index(p93a, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1113)
	m1a3(Local1, c010, z108, ts, 1114)

	Store(Index(p93b, 0, Local0), Local1)
	m1a3(Local0, c010, z108, ts, 1115)
	m1a3(Local1, c010, z108, ts, 1116)

	m1a6()
}

Method(m1c0)
{
	Store(z108, c081)		// absolute index of file initiating the checking
	Store(0, c089)		// flag of Reference, object otherwise

	m1b0()
}
