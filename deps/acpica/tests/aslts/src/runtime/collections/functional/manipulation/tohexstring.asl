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
 * Convert Data to Hexadecimal String
 */

// Integer

// 32-bit
Name(p346, Package()
{
	0,
	0x1,
	0x83,
	0x456,
	0x8232,
	0xbcdef,
	0x123456,
	0x789abcd,
	0xffffffff,
	0x1234567,
	0xff,
	0xffff,
})

Name(p347, Package()
{
	"00000000",
	"00000001",
	"00000083",
	"00000456",
	"00008232",
	"000BCDEF",
	"00123456",
	"0789ABCD",
	"FFFFFFFF",
	"01234567",
	"000000FF",
	"0000FFFF",
})

// 64-bit
Name(p348, Package()
{
	0,
	0x1,
	0x83,
	0x456,
	0x8232,
	0xbcdef,
	0x123456,
	0x789abcd,
	0xffffffff,
	0x1234567,
	0xff,
	0xffff,
	0x123456789,
	0x8123456789,
	0xabcdef01234,
	0x876543210abc,
	0x1234567abcdef,
	0x8234567abcdef1,
	0x6789abcdef01234,
	0x76543201f89abcde,
	0xf89abcde76543201,
	0xffffffffffffffff,
	0x0123456789abcdef,
})

Name(p349, Package()
{
	"0000000000000000",
	"0000000000000001",
	"0000000000000083",
	"0000000000000456",
	"0000000000008232",
	"00000000000BCDEF",
	"0000000000123456",
	"000000000789ABCD",
	"00000000FFFFFFFF",
	"0000000001234567",
	"00000000000000FF",
	"000000000000FFFF",
	"0000000123456789",
	"0000008123456789",
	"00000ABCDEF01234",
	"0000876543210ABC",
	"0001234567ABCDEF",
	"008234567ABCDEF1",
	"06789ABCDEF01234",
	"76543201F89ABCDE",
	"F89ABCDE76543201",
	"FFFFFFFFFFFFFFFF",
	"0123456789ABCDEF",
})

// Buffer
Name(p350, Package()
{
	Buffer(9) {},
	Buffer() {9, 7, 5, 3},
	Buffer(1) {1},
	Buffer(4) {1,  2,  3,  4},
	Buffer(8) {1,  2,  3,  4,  5,  6,  7,  8},
	Buffer(16) {
		  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16},

	Buffer(55) {
		202,203,204,205,206,207,208,
		209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,
		225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,
		241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,  0},

	// All buffers below result in 200 characters strings

	Buffer(67) {
		  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
		 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
		 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
		 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
		 65, 66, 67},
	Buffer(67) {
		 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
		 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
		 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,
		113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,
		129,130,131,132,133,134},
	Buffer(67) {
		135,136,137,138,139,140,141,142,143,144,
		145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,
		161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,
		177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,
		193,194,195,196,197,198,199,200,201},
})

Name(p351, Package()
{
	"00,00,00,00,00,00,00,00,00",
	"09,07,05,03",
	"01",
	"01,02,03,04",
	"01,02,03,04,05,06,07,08",
	"01,02,03,04,05,06,07,08,09,0A,0B,0C,0D,0E,0F,10",
	"CA,CB,CC,CD,CE,CF,D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,DA,DB,DC,DD,DE,DF,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,EA,EB,EC,ED,EE,EF,F0,F1,F2,F3,F4,F5,F6,F7,F8,F9,FA,FB,FC,FD,FE,FF,00",
	"01,02,03,04,05,06,07,08,09,0A,0B,0C,0D,0E,0F,10,11,12,13,14,15,16,17,18,19,1A,1B,1C,1D,1E,1F,20,21,22,23,24,25,26,27,28,29,2A,2B,2C,2D,2E,2F,30,31,32,33,34,35,36,37,38,39,3A,3B,3C,3D,3E,3F,40,41,42,43",
	"44,45,46,47,48,49,4A,4B,4C,4D,4E,4F,50,51,52,53,54,55,56,57,58,59,5A,5B,5C,5D,5E,5F,60,61,62,63,64,65,66,67,68,69,6A,6B,6C,6D,6E,6F,70,71,72,73,74,75,76,77,78,79,7A,7B,7C,7D,7E,7F,80,81,82,83,84,85,86",
	"87,88,89,8A,8B,8C,8D,8E,8F,90,91,92,93,94,95,96,97,98,99,9A,9B,9C,9D,9E,9F,A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,AA,AB,AC,AD,AE,AF,B0,B1,B2,B3,B4,B5,B6,B7,B8,B9,BA,BB,BC,BD,BE,BF,C0,C1,C2,C3,C4,C5,C6,C7,C8,C9",
})

// Run-method
Method(TOH0,, Serialized)
{
	Name(ts, "TOH0")

	Store("TEST: TOH0, Convert Data to Hexadecimal String", Debug)

	// From integer
	if (LEqual(F64, 1)) {
		m302(ts, 23, "p348", p348, p349, 4)
	} else {
		m302(ts, 12, "p346", p346, p347, 4)
	}

	// From string
	m302(ts, 6, "p344", p344, p344, 4)

	// From buffer
	m302(ts, 10, "p350", p350, p351, 4)
}
