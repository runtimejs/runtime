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
 * Data type conversion and manipulation
 *
 * Convert Data to Decimal String
 */

// Integer

// 32-bit
Name(p338, Package()
{
	0,
	1,
	12,
	345,
	6789,
	12345,
	678901,
	2345678,
	90123456,
	789012345,
	4294967295,
	123456789,
	0xff,
	0xffff,
	0xffffffff,
})

Name(p339, Package()
{
	"0",
	"1",
	"12",
	"345",
	"6789",
	"12345",
	"678901",
	"2345678",
	"90123456",
	"789012345",
	"4294967295",	// == "0xffffffff"
	"123456789",
	"255",
	"65535",
	"4294967295",	// == "0xffffffff"
})

// 64-bit
Name(p340, Package()
{
	30123456790,
	123456789012,
	3456789012345,
	26789012346789,
	123456789012345,
	3789012345678901,
	23456789012345678,
	301234567890123456,
	1890123456789012345,
	18446744073709551615,
	0xffffffffffffffff,
})

Name(p341, Package()
{
	"30123456790",
	"123456789012",
	"3456789012345",
	"26789012346789",
	"123456789012345",
	"3789012345678901",
	"23456789012345678",
	"301234567890123456",
	"1890123456789012345",
	"18446744073709551615",
	"18446744073709551615",	// == "0xffffffffffffffff"
})

// String
Name(p344, Package()
{
	"",
	"0123456789",
	"ABCDEFGHIJKLMNOPQRSTUVWXYZ",
	"abcdefghijklmnopqrstuvwxyz",
	"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz",
	"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
})

// Buffer
Name(p342, Package()
{
	Buffer(9) {},
	Buffer() {9, 7, 5, 3},
	Buffer(1) {1},
	Buffer(4) {1,  2,  3,  4},
	Buffer(8) {1,  2,  3,  4,  5,  6,  7,  8},

	// Results into 197 characters
	Buffer(69) {
		  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
		 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
		 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
		 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
		 65, 66, 67, 68, 69},
	Buffer(57) {
		 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
		 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
		 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,
		113,114,115,116,117,118,119,120,121,122,123,124,125,126},

	// Results into 199 characters
	Buffer(50) {
		127,128,
		129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,
		145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,
		161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176},
	Buffer(50) {
		177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,
		193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,
		209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,
		225,226},

	Buffer(30) {
		227,228,229,230,231,232,233,234,235,236,237,238,239,240,
		241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,  0},

	// Results into 200 characters
	Buffer(100) {
		  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
		  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
		  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
		  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
		  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
		  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
		  1,  1,  1,  11},
	Buffer(51) {
		111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,
		111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,
		111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,
		111, 11,  1},
})

Name(p343, Package()
{
	"0,0,0,0,0,0,0,0,0",
	"9,7,5,3",
	"1",
	"1,2,3,4",
	"1,2,3,4,5,6,7,8",
	"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69",
	"70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126",
	"127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176",
	"177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226",
	"227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,0",
	"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,11",
	"111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,11,1",
})

// Run-method
Method(TOD0,, Serialized)
{
	Name(ts, "TOD0")

	Store("TEST: TOD0, Convert Data to Decimal String", Debug)

	// From integer
	if (LEqual(F64, 1)) {
		m302(ts, 15, "p338", p338, p339, 3)
		m302(ts, 11, "p340", p340, p341, 3)
	} else {
		m302(ts, 15, "p338", p338, p339, 3)
	}

	// From buffer
	m302(ts, 12, "p342", p342, p343, 3)

	// From string
	m302(ts, 6, "p344", p344, p344, 3)
}
