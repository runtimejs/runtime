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
 * Convert Data to Buffer
 */

Name(z043, 43)

// Integer

// 32-bit
Name(p320, Package()
{
	0,
	0x81,
	0x8232,
	0x76543201,
	0xf89abcde,
	0xffffffff,
})

Name(p321, Package()
{
	Buffer(4) {0x00, 0x00, 0x00, 0x00},
	Buffer(4) {0x81, 0x00, 0x00, 0x00},
	Buffer(4) {0x32, 0x82, 0x00, 0x00},
	Buffer(4) {0x01, 0x32, 0x54, 0x76},
	Buffer(4) {0xde, 0xbc, 0x9a, 0xf8},
	Buffer(4) {0xff, 0xff, 0xff, 0xff},
})

// 64-bit
Name(p322, Package()
{
	0,
	0x81,
	0x8232,
	0x76543201,
	0x8123456789,
	0x8cdae2376890,
	0x76543201fabcde,
	0xabcdef9876543201,
	0xffffffffffffffff,
})

Name(p323, Package()
{
	Buffer(8) {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
	Buffer(8) {0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
	Buffer(8) {0x32, 0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
	Buffer(8) {0x01, 0x32, 0x54, 0x76, 0x00, 0x00, 0x00, 0x00},
	Buffer(8) {0x89, 0x67, 0x45, 0x23, 0x81, 0x00, 0x00, 0x00},
	Buffer(8) {0x90, 0x68, 0x37, 0xe2, 0xda, 0x8c, 0x00, 0x00},
	Buffer(8) {0xde, 0xbc, 0xfa, 0x01, 0x32, 0x54, 0x76, 0x00},
	Buffer(8) {0x01, 0x32, 0x54, 0x76, 0x98, 0xef, 0xcd, 0xab},
	Buffer(8) {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
})

// Buffer
Name(p325, Package()
{
	Buffer(1) {1},
	Buffer(4) {1,  2,  3,  4},
	Buffer(8) {1,  2,  3,  4,  5,  6,  7,  8},
	Buffer(128) {
		  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
		 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
		 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
		 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
		 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
		 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
		 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,
		113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128},
	Buffer(200) {
		  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
		 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
		 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
		 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
		 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
		 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
		 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,
		113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,
		129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,
		145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,
		161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,
		177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,
		193,194,195,196,197,198,199,200},
	Buffer(257) {
		  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
		 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
		 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
		 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
		 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
		 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
		 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,
		113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,
		129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,
		145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,
		161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,
		177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,
		193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,
		209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,
		225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,
		241,242,243,244,245,246,247,248,249,250,251,252,253,254,255, 0, 1},
})

// Verify type, length of the obtained buffer
// call to m305 to check the contents
Method(m320, 6)	// ts, buffer, len, null, err, case
{
	if (LNotequal(ObjectType(arg1), 3)) {
		err(arg0, z043, arg3, 0, 0, arg2, "Type")
	} else {
		if (LNotEqual(Sizeof(arg1), Add(arg2, arg3))) {
			err(arg0, z043, arg4, 0, 0, arg2, "Sizeof")
		} else {
			m305(arg0, arg1, arg2, arg4, arg5)
		}
	}
}

// Checking strings with different lengths
Method(m321, 1, Serialized)
{
	Name(LENS, Buffer() {200, 199, 129, 128, 127, 9, 8, 7, 1, 0})

	Store(0, Local1)
	While (LLess(Local1, 10)) {

		// Prepare benchmark buffer

		Store(Derefof(Index(LENS, Local1)), Local0)
		Store(Buffer(Local0){}, Local4)
		m303(Local4, Local0)

		// Convert benchmark buffer to string

		Store(ToString(Local4), Local2)

		// Create the same benchmark buffer anew
		// with null character appended

		Store(Buffer(Add(Local0, 1)){}, Local5)
		m303(Local5, Local0)
		Store(0, Index(Local5, Local0))

		// Convert string to buffer

		ToBuffer(Local2, Local3)

		// Verify obtained buffer with the benchmark one

		if (LNotEqual(Local3, Local5)) {
			err(arg0, z043, 2, 0, 0, Local0, "NotEqual")
		}

		// Check the source string was not corrupted

		m307(arg0, Local2, Local0, 2, "Source")

		// Check both buffers state too

		m320(arg0, Local3, Local0, 1, 3, "Dest")
		m320(arg0, Local4, Local0, 0, 4, "Test")

		Increment(Local1)
	}
}

// Checking buffers with different lengths
// (zero length in the first order).
Method(m322, 1, Serialized)
{
	Name(LENS, Package() {0, 513})

	Store(0, Local1)
	While (LLess(Local1, 2)) {

		// Prepare benchmark buffer

		Store(Derefof(Index(LENS, Local1)), Local0)
		Store(Buffer(Local0){}, Local4)
		m303(Local4, Local0)

		/*
		 * // ToBuffer caused destroying of source buffer (passed
		 * // by Data parameter), so they are duplicated below.
		 *
		 * Store(Local4, Local5)
		 */

		ToBuffer(Local4, Local3)

		if (LNotEqual(Local3, Local4)) {
			err(arg0, z043, 3, 0, 0, Local0, "NotEqual")
		}

		// Check the buffers were not corrupted
		// (because know Data parameter was)

		m320(arg0, Local3, Local0, 0, 6, "Dest")
		m320(arg0, Local4, Local0, 0, 7, "Source")

		Increment(Local1)
	}
}

// Run-method
Method(TOB0,, Serialized)
{
	Name(ts, "TOB0")

	Store("TEST: TOB0, Convert Data to Buffer", Debug)

	// From integer

	if (LEqual(F64, 1)) {
		m302(ts, 9, "p322", p322, p323, 1)
	} else {
		m302(ts, 6, "p320", p320, p321, 1)
	}

	// From string

	m321(ts)

	// From buffer

	m322(ts)

	m302(ts, 6, "p325", p325, p325, 1)
}
