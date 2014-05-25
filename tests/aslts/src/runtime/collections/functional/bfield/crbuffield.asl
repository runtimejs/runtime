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
 * Create Buffer Field operators
 */

/*
 * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 * Clean up method m218 after that when errors 65,66,68,69
 * (in 32-bit mode) will be investigated and resolved
 * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 *
 * Update needed: 1) add "Common features", see below ...
 *                2) tune parameters in m21d
 */

Name(z001, 1)

Name(BS00, 256)

// Benchmark Buffers

Name(b000, Buffer(BS00) {})
Name(b0ff, Buffer(BS00) {
	// 0-127
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	// 128-255
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,})

Name(b256, Buffer(BS00) {
	// 0-127
	0x00,0x00,0x02,0x03,0x04,0x05,0x06,0x07,
	0x08,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0f,
	0x00,0x11,0x12,0x13,0x14,0x15,0x16,0x17,
	0x18,0x19,0x1a,0x1b,0x1c,0x1d,0x1e,0x1f,
	0x10,0x21,0x22,0x23,0x24,0x25,0x26,0x27,
	0x28,0x29,0x2a,0x2b,0x2c,0x2d,0x2e,0x2f,
	0x20,0x31,0x32,0x33,0x34,0x35,0x36,0x37,
	0x38,0x39,0x3a,0x3b,0x3c,0x3d,0x3e,0x3f,
	0x30,0x41,0x42,0x43,0x44,0x45,0x46,0x47,
	0x48,0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f,
	0x40,0x51,0x52,0x53,0x54,0x55,0x56,0x57,
	0x58,0x59,0x5a,0x5b,0x5c,0x5d,0x5e,0x5f,
	0x50,0x61,0x62,0x63,0x64,0x65,0x66,0x67,
	0x68,0x69,0x6a,0x6b,0x6c,0x6d,0x6e,0x6f,
	0x60,0x71,0x72,0x73,0x74,0x75,0x76,0x77,
	0x78,0x79,0x7a,0x7b,0x7c,0x7d,0x7e,0x7f,

	// 128-255

	0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,
	0x88,0x89,0x8a,0x8b,0x8c,0x8d,0x8e,0x8f,
	0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,
	0x98,0x99,0x9a,0x9b,0x9c,0x9d,0x9e,0x9f,
	0xa0,0xa1,0xa2,0xa3,0xa4,0xa5,0xa6,0xa7,
	0xa8,0xa9,0xaa,0xab,0xac,0xad,0xae,0xaf,
	0xb0,0xb1,0xb2,0xb3,0xb4,0xb5,0xb6,0xb7,
	0xb8,0xb9,0xba,0xbb,0xbc,0xbd,0xbe,0xbf,
	0xc0,0xc1,0xc2,0xc3,0xc4,0xc5,0xc6,0xc7,
	0xc8,0xc9,0xca,0xcb,0xcc,0xcd,0xce,0xcf,
	0xd0,0xd1,0xd2,0xd3,0xd4,0xd5,0xd6,0xd7,
	0xd8,0xd9,0xda,0xdb,0xdc,0xdd,0xde,0xdf,
	0xe0,0xe1,0xe2,0xe3,0xe4,0xe5,0xe6,0xe7,
	0xe8,0xe9,0xea,0xeb,0xec,0xed,0xee,0xef,
	0xf0,0xf1,0xf2,0xf3,0xf4,0xf5,0xf6,0xf7,
	0xf8,0xf9,0xfa,0xfb,0xfc,0xfd,0xfe,0xff,
	})

// Generated benchmark buffers for comparison with

Name(b010, Buffer(BS00) {})
Name(b101, Buffer(BS00) {})
Name(b0B0, Buffer(BS00) {})

// Buffer for filling the ground

Name(b0G0, Buffer(BS00) {})

// Buffer for filling the field (over the ground)

Name(b0F0, Buffer(BS00) {})


// CreateBitField
//
// <test name>,
// <index of bit>,
// <buf: 00>,
// <buf: ff>,
// <buf: 010>,
// <buf: 101>,
// <byte size of buf>
Method(m210, 7, Serialized)
{
	Name(pr00, 0)

	if (pr00) {
		Store("========:", Debug)
	}

	Name(b001, Buffer(arg6) {})
	Name(b002, Buffer(arg6) {})

	CreateBitField(b001, arg1, f001)

	//////////////// A. 1->0 (010->000)

	Store(arg4, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0xfffffffffffffffe, f001)

	Store(f001, Local0)

	if (LNotEqual(Local0, 0)) {
		err(arg0, z001, 0, 0, 0, Local0, 0)
	}

	Store(arg2, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 1, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	//////////////// B. 1->0 (111->101)

	Store(arg3, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0x0000000000000000, f001)

	Store(f001, Local0)

	if (LNotEqual(Local0, 0)) {
		err(arg0, z001, 2, 0, 0, Local0, 0)
	}

	Store(arg5, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 3, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	//////////////// C. 0->1 (101->111)

	Store(arg5, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0x0000000000000001, f001)
	Store(f001, Local0)

	if (LNotEqual(Local0, 0x0000000000000001)) {
		err(arg0, z001, 4, 0, 0, Local0, 0x0000000000000001)
	}

	Store(arg3, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 5, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	//////////////// D. 0->1 (000->010)

	Store(arg2, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0xffffffffffffffff, f001)
	Store(f001, Local0)

	if (LNotEqual(Local0, 0x0000000000000001)) {
		err(arg0, z001, 6, 0, 0, Local0, 0x0000000000000001)
	}

	Store(arg4, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 7, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	// Common features

	Store(SizeOf(b001), Local0)
	if (LNotEqual(Local0, arg6)) {
		err(arg0, z001, 8, 0, 0, Local0, arg6)
	}

	Store(SizeOf(b002), Local0)
	if (LNotEqual(Local0, arg6)) {
		err(arg0, z001, 9, 0, 0, Local0, arg6)
	}

	Store(ObjectType(f001), Local0)
	if (LNotEqual(Local0, c016)) {
		err(arg0, z001, 10, 0, 0, Local0, c016)
	}

	if (pr00) {
		Store(Local0, Debug)
	}
}

Method(m211,, Serialized)
{
	Name(ts, "m211")

	Store("TEST: m211, Create 1-Bit Buffer Field:", Debug)

	// Size of buffer (in bytes)
	Name(bsz0, 0)
	Store(BS00, bsz0)

	// Max steps to check
	Name(bsz1, 0)

	// How many elements to check
	Name(n000, 0)
	Name(ncur, 0)

	Multiply(bsz0, 8, n000)

	Store(n000, bsz1)

	While (n000) {

		if (LGreaterEqual(ncur, bsz1)) {
			err(ts, z001, 11, 0, 0, ncur, bsz1)
			Break
		}

		Store(b000, b010)
		Store(b0ff, b101)

		Divide(ncur, 8, Local1, Local0)

		ShiftLeft(1, Local1, Local2)
		Store(Local2, Index(b010, Local0))

		Not(Local2, Local3)
		Store(Local3, Index(b101, Local0))

		m210(ts, ncur, b000, b0ff, b010, b101, bsz0)

		Decrement(n000)
		Increment(ncur)
	}
}

// CreateByteField
//
// <test name>,
// <index of byte>,
// <byte size of buf>
Method(m212, 3, Serialized)
{
	Name(pr00, 0)

	if (pr00) {
		Store("========:", Debug)
	}

	Name(b001, Buffer(arg2) {})
	Name(b002, Buffer(arg2) {})

	//////////////// A. 1->0 (010->000)

	CreateByteField(b001, arg1, f001)
	Store(b010, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0xffffffffffffff00, f001)

	Store(f001, Local0)

	if (LNotEqual(Local0, 0)) {
		err(arg0, z001, 12, 0, 0, Local0, 0)
	}

	Store(b000, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 13, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	//////////////// B. 1->0 (111->101)

	Store(b0ff, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0x0000000000000000, f001)

	Store(f001, Local0)

	if (LNotEqual(Local0, 0)) {
		err(arg0, z001, 14, 0, 0, Local0, 0)
	}

	Store(b101, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 15, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	//////////////// C. 0->1 (101->111)

	Store(b101, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0x00000000000000ff, f001)
	Store(f001, Local0)

	if (LNotEqual(Local0, 0x00000000000000ff)) {
		err(arg0, z001, 16, 0, 0, Local0, 0x00000000000000ff)
	}

	Store(b0ff, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 17, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	//////////////// D. 0->1 (000->010)

	Store(b000, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0xffffffffffffffff, f001)
	Store(f001, Local0)

	if (LNotEqual(Local0, 0x00000000000000ff)) {
		err(arg0, z001, 18, 0, 0, Local0, 0x00000000000000ff)
	}

	Store(b010, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 19, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	//////////////// E. 0->1 (000->010)

	Store(b000, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0xffffffffffffff96, f001)
	Store(f001, Local0)

	if (LNotEqual(Local0, 0x0000000000000096)) {
		err(arg0, z001, 20, 0, 0, Local0, 0x0000000000000096)
	}

	Store(b0B0, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 21, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	// Common features

	Store(SizeOf(b001), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 22, 0, 0, Local0, arg2)
	}

	Store(SizeOf(b002), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 23, 0, 0, Local0, arg2)
	}

	Store(ObjectType(f001), Local0)
	if (LNotEqual(Local0, c016)) {
		err(arg0, z001, 24, 0, 0, Local0, c016)
	}

	if (pr00) {
		Store(Local0, Debug)
	}
}

Method(m213,, Serialized)
{
	Name(ts, "m213")

	Store("TEST: m213, Create 8-Bit Buffer Field:", Debug)

	// Size of buffer (in bytes)
	Name(bsz0, 0)
	Store(BS00, bsz0)

	// Max steps to check
	Name(bsz1, 0)

	// How many elements to check
	Name(n000, 0)
	Name(ncur, 0)

	Store(bsz0, n000)

	Store(n000, bsz1)

	While (n000) {

		if (LGreaterEqual(ncur, bsz1)) {
			err(ts, z001, 25, 0, 0, ncur, bsz1)
			Break
		}

		Store(b000, b010)
		Store(b000, b0B0)
		Store(b0ff, b101)

		Store(0xff, Index(b010, ncur))
		Store(0x96, Index(b0B0, ncur))
		Store(0, Index(b101, ncur))

		m212(ts, ncur, bsz0)

		Decrement(n000)
		Increment(ncur)
	}
}

// CreateWordField
//
// <test name>,
// <index of byte>,
// <byte size of buf>
Method(m214, 3, Serialized)
{
	Name(pr00, 0)

	if (pr00) {
		Store("========:", Debug)
		Store(arg1, Debug)
		Store(arg2, Debug)
	}

	Name(b001, Buffer(arg2) {})
	Name(b002, Buffer(arg2) {})

	CreateWordField(b001, arg1, f001)

	//////////////// A. 1->0 (010->000)

	Store(b010, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0xffffffffffff0000, f001)

	Store(f001, Local0)

	if (LNotEqual(Local0, 0)) {
		err(arg0, z001, 26, 0, 0, Local0, 0)
	}

	Store(b000, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 27, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	//////////////// B. 1->0 (111->101)

	Store(b0ff, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0x0000000000000000, f001)

	Store(f001, Local0)

	if (LNotEqual(Local0, 0)) {
		err(arg0, z001, 28, 0, 0, Local0, 0)
	}

	Store(b101, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 29, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	//////////////// C. 0->1 (101->111)

	Store(b101, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0x000000000000ffff, f001)
	Store(f001, Local0)

	if (LNotEqual(Local0, 0x000000000000ffff)) {
		err(arg0, z001, 30, 0, 0, Local0, 0x000000000000ffff)
	}

	Store(b0ff, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 31, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	//////////////// D. 0->1 (000->010)

	Store(b000, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0xffffffffffffffff, f001)
	Store(f001, Local0)

	if (LNotEqual(Local0, 0x000000000000ffff)) {
		err(arg0, z001, 32, 0, 0, Local0, 0x000000000000ffff)
	}

	Store(b010, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 33, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	Store(SizeOf(b001), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 34, 0, 0, Local0, arg2)
	}

	Store(SizeOf(b002), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 35, 0, 0, Local0, arg2)
	}

	//////////////// E. 0->1 (000->010)

	Store(b000, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0xffffffffffff7698, f001)
	Store(f001, Local0)

	if (LNotEqual(Local0, 0x0000000000007698)) {
		err(arg0, z001, 36, 0, 0, Local0, 0x0000000000007698)
	}

	Store(b0B0, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 37, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	// Common features

	Store(SizeOf(b001), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 38, 0, 0, Local0, arg2)
	}

	Store(SizeOf(b002), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 39, 0, 0, Local0, arg2)
	}

	Store(ObjectType(f001), Local0)
	if (LNotEqual(Local0, c016)) {
		err(arg0, z001, 40, 0, 0, Local0, c016)
	}

	if (pr00) {
		Store(Local0, Debug)
	}
}

Method(m215,, Serialized)
{
	Name(ts, "m215")

	Store("TEST: m215, Create 16-Bit Buffer Field:", Debug)

	// Size of buffer (in bytes)
	Name(bsz0, 0)
	Store(BS00, bsz0)

	// Max steps to check
	Name(bsz1, 0)

	// How many elements to check
	Name(n000, 0)
	Name(ncur, 0)

	Subtract(bsz0, 1, n000)

	Store(n000, bsz1)

	While (n000) {

		if (LGreaterEqual(ncur, bsz1)) {
			err(ts, z001, 41, 0, 0, ncur, bsz1)
			Break
		}

		Store(b000, b010)
		Store(b000, b0B0)
		Store(b0ff, b101)

		Store(ncur, Local0)

		Store(0xff, Index(b010, Local0))
		Store(0x98, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		Increment(Local0)

		Store(0xff, Index(b010, Local0))
		Store(0x76, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		m214(ts, ncur, bsz0)

		Decrement(n000)
		Increment(ncur)
	}
}

// CreateDWordField
//
// <test name>,
// <index of byte>,
// <byte size of buf>
Method(m216, 3, Serialized)
{
	Name(pr00, 0)

	if (pr00) {
		Store("========:", Debug)
		Store(arg1, Debug)
		Store(arg2, Debug)
	}

	Name(b001, Buffer(arg2) {})
	Name(b002, Buffer(arg2) {})

	CreateDWordField(b001, arg1, f001)

	//////////////// A. 1->0 (010->000)

	Store(b010, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0xffffffff00000000, f001)

	Store(f001, Local0)

	if (LNotEqual(Local0, 0)) {
		err(arg0, z001, 42, 0, 0, Local0, 0)
	}

	Store(b000, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 43, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	//////////////// B. 1->0 (111->101)

	Store(b0ff, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0x0000000000000000, f001)

	Store(f001, Local0)

	if (LNotEqual(Local0, 0)) {
		err(arg0, z001, 44, 0, 0, Local0, 0)
	}

	Store(b101, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 45, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	//////////////// C. 0->1 (101->111)

	Store(b101, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0x00000000ffffffff, f001)
	Store(f001, Local0)

	if (LNotEqual(Local0, 0x00000000ffffffff)) {
		err(arg0, z001, 46, 0, 0, Local0, 0x00000000ffffffff)
	}

	Store(b0ff, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 47, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	//////////////// D. 0->1 (000->010)

	Store(b000, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0xffffffffffffffff, f001)
	Store(f001, Local0)

	if (LNotEqual(Local0, 0x00000000ffffffff)) {
		err(arg0, z001, 48, 0, 0, Local0, 0x00000000ffffffff)
	}

	Store(b010, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 49, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	Store(SizeOf(b001), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 50, 0, 0, Local0, arg2)
	}

	Store(SizeOf(b002), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 51, 0, 0, Local0, arg2)
	}

	//////////////// E. 0->1 (000->010)

	Store(b000, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	Store(0xffffffff32547698, f001)
	Store(f001, Local0)

	if (LNotEqual(Local0, 0x0000000032547698)) {
		err(arg0, z001, 52, 0, 0, Local0, 0x0000000032547698)
	}

	Store(b0B0, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 53, 0, 0, 0, 0)
	}

	if (pr00) {
		Store(b001, Debug)
	}

	// Common features

	Store(SizeOf(b001), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 54, 0, 0, Local0, arg2)
	}

	Store(SizeOf(b002), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 55, 0, 0, Local0, arg2)
	}

	Store(ObjectType(f001), Local0)
	if (LNotEqual(Local0, c016)) {
		err(arg0, z001, 56, 0, 0, Local0, c016)
	}

	if (pr00) {
		Store(Local0, Debug)
	}
}

Method(m217,, Serialized)
{
	Name(ts, "m217")

	Store("TEST: m217, Create 32-Bit Buffer Field:", Debug)

	// Size of buffer (in bytes)
	Name(bsz0, 0)
	Store(BS00, bsz0)

	// Max steps to check
	Name(bsz1, 0)

	// How many elements to check
	Name(n000, 0)
	Name(ncur, 0)

	Subtract(bsz0, 3, n000)

	Store(n000, bsz1)

	While (n000) {

		if (LGreaterEqual(ncur, bsz1)) {
			err(ts, z001, 57, 0, 0, ncur, bsz1)
			Break
		}

		Store(b000, b010)
		Store(b000, b0B0)
		Store(b0ff, b101)

		Store(ncur, Local0)

		Store(0xff, Index(b010, Local0))
		Store(0x98, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		Increment(Local0)

		Store(0xff, Index(b010, Local0))
		Store(0x76, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		Increment(Local0)

		Store(0xff, Index(b010, Local0))
		Store(0x54, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		Increment(Local0)

		Store(0xff, Index(b010, Local0))
		Store(0x32, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		m216(ts, ncur, bsz0)

		Decrement(n000)
		Increment(ncur)
	}
}

// CreateQWordField
//
// <test name>,
// <index of byte>,
// <byte size of buf>
Method(m218, 3, Serialized)
{
	Name(pr00, 0)
	Name(err0, 0)
	Store(ERRS, err0)

	Name(bb00, Buffer(8) {})
//	Name(bb01, Buffer(8) {0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff})
	Name(bb01, Buffer(8) {0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00})
//	Name(bb02, Buffer(8) {0x98,0x76,0x54,0x32,0x10,0xAB,0xCD,0xEF})
	Name(bb02, Buffer(8) {0x98,0x76,0x54,0x32,0x00,0x00,0x00,0x00})

	if (pr00) {
		Store("========:", Debug)
		Store(arg1, Debug)
		Store(arg2, Debug)
	}

	Name(b001, Buffer(arg2) {})
	Name(b002, Buffer(arg2) {})

	CreateQWordField(b001, arg1, f001)

	/*
	 * Create Field to the part of b002 which is set to
	 * zero by storing Integer into f001 in 32-bit mode.
	 */
	CreateDWordField(b002, Add(arg1, 4), f321)

	//////////////// A. 1->0 (010->000)

	Store(b010, b001)

	if (pr00) {
		Store("======== 1:", Debug)
		Store(b001, Debug)
	}

	Store(0x0000000000000000, f001)

	Store(f001, Local0)

	if (LEqual(F64, 1)) {
		if (LNotEqual(Local0, 0x0000000000000000)) {
			err(arg0, z001, 58, 0, 0, Local0, 0x0000000000000000)
		}
	} else {
		if (LNotEqual(Local0, bb00)) {
			err(arg0, z001, 59, 0, 0, 0, 0)
		}
	}

	Store(b000, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 60, 0, 0, 0, 0)
	}

	if (pr00) {
		Store("======== 2:", Debug)
		Store(b001, Debug)
	}

	//////////////// B. 1->0 (111->101)

	Store(b0ff, b001)

	if (pr00) {
		Store("======== 3:", Debug)
		Store(b001, Debug)
	}

	Store(0x0000000000000000, f001)

	Store(f001, Local0)

	if (LEqual(F64, 1)) {
		if (LNotEqual(Local0, 0x0000000000000000)) {
			err(arg0, z001, 61, 0, 0, Local0, 0x0000000000000000)
		}
	} else {
		if (LNotEqual(Local0, bb00)) {
			err(arg0, z001, 62, 0, 0, 0, 0)
		}
	}

	Store(b101, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 63, 0, 0, 0, 0)
	}

	if (pr00) {
		Store("======== 4:", Debug)
		Store(b001, Debug)
	}

	//////////////// C. 0->1 (101->111)

	Store(b101, b001)

	if (pr00) {
		Store("======== 5:", Debug)
		Store(b001, Debug)
	}

	Store(0xffffffffffffffff, f001)
//	Store(bb01, f001)

	Store(f001, Local0)

	if (LEqual(F64, 1)) {
		if (LNotEqual(Local0, 0xffffffffffffffff)) {
			err(arg0, z001, 64, 0, 0, Local0, 0xffffffffffffffff)
		}
	} else {
		if (LNotEqual(Local0, bb01)) {

			if (pr00) {
				Store("=========================:", Debug)
				Store(Local0, Debug)
				Store(bb01, Debug)
				Store("=========================.", Debug)
			}

			err(arg0, z001, 65, 0, 0, 0, 0)
		}
	}

	Store(b0ff, b002)

	if (LEqual(F64, 0)) {
		// 32-bit mode update of b002
		Store(0, f321)
	}

	if (LNotEqual(b001, b002)) {

		if (pr00) {
			Store("=========================:", Debug)
			Store(b001, Debug)
			Store(b002, Debug)
			Store("=========================.", Debug)
		}

		err(arg0, z001, 66, 0, 0, 0, 0)
	}

	if (pr00) {
		Store("======== 6:", Debug)
		Store(b001, Debug)
	}

	//////////////// D. 0->1 (000->010)

	Store(b000, b001)

	if (pr00) {
		Store("======== 7:", Debug)
		Store(f001, Debug)
		Store(b001, Debug)
		Store(bb01, Debug)
	}

	Store(0xffffffffffffffff, f001)
//	Store(bb01, f001)
//	Store(0xefcdab1032547698, f001)
//	Store(0x8888888888888888, f001)
//	Store(0x7777777777777777, f001)
//	Store(0x0f0f0f0f0f0f0f0f, f001)
//	Store(0xf0f0f0f0f0f0f0f0, f001)
//	Store(0x7fffffffffffffff, f001)

	if (pr00) {
		Store("======== 8:", Debug)
		Store(Local0, Debug)
		Store(f001, Debug)
		Store(b001, Debug)
		Store(bb01, Debug)
	}

	Store(f001, Local0)

	if (LEqual(F64, 1)) {
		if (LNotEqual(Local0, 0xffffffffffffffff)) {
			err(arg0, z001, 67, 0, 0, Local0, 0xffffffffffffffff)
		}
	} else {
		if (LNotEqual(Local0, bb01)) {

			if (pr00) {
				Store("=========================:", Debug)
				Store(Local0, Debug)
				Store(bb01, Debug)
				Store("=========================.", Debug)
			}

			err(arg0, z001, 68, 0, 0, 0, 0)
		}
	}

	Store(b010, b002)

	if (LEqual(F64, 0)) {
		// 32-bit mode update of b002
		Store(0, f321)
	}

	if (LNotEqual(b001, b002)) {

		if (pr00) {
			Store("=========================:", Debug)
			Store(b001, Debug)
			Store(b002, Debug)
			Store("=========================.", Debug)
		}

		err(arg0, z001, 69, 0, 0, 0, 0)
	}

	if (pr00) {
		Store("======== 9:", Debug)
		Store(b001, Debug)
	}

	Store(SizeOf(b001), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 70, 0, 0, Local0, arg2)
	}

	Store(SizeOf(b002), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 71, 0, 0, Local0, arg2)
	}

	//////////////// E. 0->1 (000->010)

	Store(b000, b001)

	if (pr00) {
		Store("======== 10:", Debug)
		Store(f001, Debug)
		Store(b001, Debug)
		Store(bb02, Debug)
	}

	Store(0xefcdab1032547698, f001)
//	Store(0xffffffffffffffff, f001)
	Store(f001, Local0)


	if (pr00) {
		Store("======== 11:", Debug)
		Store(Local0, Debug)
		Store(f001, Debug)
		Store(b001, Debug)
		Store(bb02, Debug)
	}

	if (LEqual(F64, 1)) {
		if (LNotEqual(Local0, 0xefcdab1032547698)) {
			err(arg0, z001, 72, 0, 0, Local0, 0xefcdab1032547698)
		}
	} else {
		if (LNotEqual(Local0, bb02)) {
			err(arg0, z001, 73, 0, 0, 0, 0)
		}
	}

	Store(b0B0, b002)

	if (LEqual(F64, 0)) {
		// 32-bit mode update of b002
		Store(0, f321)
	}

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 74, 0, 0, 0, 0)
	}

	if (pr00) {
		Store("======== 12:", Debug)
		Store(b001, Debug)
		Store(b002, Debug)
	}

	// Common features

	Store(SizeOf(b001), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 75, 0, 0, Local0, arg2)
	}

	Store(SizeOf(b002), Local0)
	if (LNotEqual(Local0, arg2)) {
		err(arg0, z001, 76, 0, 0, Local0, arg2)
	}

	Store(ObjectType(f001), Local0)
	if (LNotEqual(Local0, c016)) {
		err(arg0, z001, 77, 0, 0, Local0, c016)
	}

	if (pr00) {
		Store("======== 13:", Debug)
		Store(Local0, Debug)
	}

	if (LNotEqual(ERRS, err0)) {
		Store(1, Local0)
	} else {
		Store(0, Local0)
	}

	return (Local0)
}

Method(m219,, Serialized)
{
	Name(ts, "m219")

	Store("TEST: m219, Create 64-Bit Buffer Field:", Debug)

	// Size of buffer (in bytes)
	Name(bsz0, 0)
	Store(BS00, bsz0)

	// Max steps to check
	Name(bsz1, 0)

	// How many elements to check
	Name(n000, 0)
	Name(ncur, 0)

	Subtract(bsz0, 7, n000)

	Store(n000, bsz1)

	While (n000) {

		if (LGreaterEqual(ncur, bsz1)) {
			err(ts, z001, 78, 0, 0, ncur, bsz1)
			Break
		}

		Store(b000, b010)
		Store(b000, b0B0)
		Store(b0ff, b101)

		Store(ncur, Local0)

		Store(0xff, Index(b010, Local0))
		Store(0x98, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		Increment(Local0)

		Store(0xff, Index(b010, Local0))
		Store(0x76, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		Increment(Local0)

		Store(0xff, Index(b010, Local0))
		Store(0x54, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		Increment(Local0)

		Store(0xff, Index(b010, Local0))
		Store(0x32, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		Increment(Local0)

		Store(0xff, Index(b010, Local0))
		Store(0x10, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		Increment(Local0)

		Store(0xff, Index(b010, Local0))
		Store(0xab, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		Increment(Local0)

		Store(0xff, Index(b010, Local0))
		Store(0xcd, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		Increment(Local0)

		Store(0xff, Index(b010, Local0))
		Store(0xef, Index(b0B0, Local0))
		Store(0, Index(b101, Local0))

		if (m218(ts, ncur, bsz0)) {
			return (1)
		}

		Decrement(n000)
		Increment(ncur)
	}

	return (0)
}

// CreateField
//
// <test name>,
// <name of test-package>,
// <index of bit>,
// <num of bits>,
// <byte size of buf>
// <the benchmark buffer for Field comparison with>
Method(m21a, 6, Serialized)
{
	Name(pr00, 0)

	if (pr00) {
		Store("========:", Debug)
		Store(arg2, Debug)
		Store(arg3, Debug)
	}

	Name(b001, Buffer(arg4) {})
	Name(b002, Buffer(arg4) {})

	// Flag of Integer
	Name(INT0, 0)

	Name(INT1, 0)

	CreateField(b001, arg2, arg3, f001)

	// Expected type

	if (LEqual(F64, 1)) {
		if (LLessEqual(arg3, 64)) {
			Store(1, INT0)
		}
	} else {
		if (LLessEqual(arg3, 32)) {
			Store(1, INT0)
		}
	}

	// Check Type

	Store(ObjectType(f001), Local0)
	if (LNotEqual(Local0, c016)) {
		err(arg0, z001, 79, 0, 0, Local0, c016)
	}

	// Fill the entire buffer (ground)

	Store(b0G0, b001)

	if (pr00) {
		Store(b001, Debug)
	}

	// Fill into the field of buffer

	Store(b0F0, f001)
	Store(f001, Local0)

	// Crash for 20041105 [Nov  5 2004]
	// Store("!!!!!!!!!!!! test is crashing
	// here when attempting access pr00:", Debug)

	if (pr00) {
		Store("============ 0:", Debug)
		Store(b0G0, Debug)
		Store(b0F0, Debug)
		Store(b0B0, Debug)
		Store(Local0, Debug)
		Store(b001, Debug)
		Store("============.", Debug)
	}

	// Check the contents of field


	if (INT0) {
		Store(arg5, INT1)
		if (LNotEqual(Local0, INT1)) {
			err(arg0, z001, 80, 0, 0, Local0, INT1)
		}
	} else {
		if (LNotEqual(Local0, arg5)) {
			err(arg0, z001, 81, 0, 0, 0, 0)
		}
	}

	// Check the contents of Buffer

	Store(b0B0, b002)

	if (LNotEqual(b001, b002)) {
		err(arg0, z001, 82, 0, 0, 0, 0)

		if (pr00) {
			Store("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE:", Debug)
			Store(b0G0, Debug)
			Store(b0F0, Debug)
			Store(b0B0, Debug)
			Store(b001, Debug)
			Store("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.", Debug)
		}
	}

	// Common features

	// Add "Common features" here too.

	return (Zero)
}

// <test name>,
// <name of test-package>,
// <index of bit>,
// <num of bits>,
// <opcode of buffer to fill the ground>
// <opcode of buffer to fill the field>
Method(m21b, 6, Serialized)
{
	Name(pr00, 0)

	Name(INT2, 0)

	// For loop 1
	Name(lpN1, 0)
	Name(lpC1, 0)

	// For loop 2
	Name(lpN2, 0)
	Name(lpC2, 0)

	// <entire byte size of buffer>
	Name(bsz0, 0)
	Store(BS00, bsz0)

	// byte size of field
	Name(bsf0, 0)

	// byte size of buffer affected by field
	Name(bsb0, 0)

	// index of the first byte of field in the buffer
	Name(fb00, 0)

	// index of the last byte of field in the buffer
	Name(lb00, 0)

	// Num of bits have to be non-zero

	if (LEqual(arg3, 0)) {
		err(arg0, z001, 83, 0, 0, 0, 0)
		return (Ones)
	}

	Store(MBS0(arg2, arg3), bsb0)

	// =========================================
	// Prepare the buffer for filling the ground
	// =========================================

	switch (ToInteger (arg4)) {
		case (0) {
			Store(b000, b0G0)
		}
		case (1) {
			Store(b0ff, b0G0)
		}
		default {
			Store(b256, b0G0)
		}
	}

	// ==========================================================
	// Prepare the buffer for filling the field (over the ground)
	// ==========================================================

	switch (ToInteger (arg5)) {
		case (0) {
			Store(b000, b0F0)
		}
		case (1) {
			Store(b0ff, b0F0)
		}
		default {
			Store(b256, b0F0)
		}
	}

	// ======================================================
	// Prepare the benchmark buffer for Field COMPARISON with
	// Result in Local6
	// ======================================================

	// lpN1 - number of bytes minus one

	Store(arg3, Local0)
	Decrement(Local0)
	Divide(Local0, 8, Local7, lpN1)
	Divide(arg3, 8, Local7, Local0)

	Store(lpN1, bsf0)
	Increment(bsf0)
	Store(Buffer(bsf0) {}, Local6)

	Store(DeRefOf(Index(b0F0, lpN1)), Local0)
	if (Local7) {
		Subtract(8, Local7, Local1)
		ShiftLeft(Local0, Local1, Local2)
		And(Local2, 0xff, Local3)
		ShiftRight(Local3, Local1, Local0)
	}
	Store(Local0, Index(Local6, lpN1))

	Store(0, lpC1)

	While (lpN1) {
		Store(DeRefOf(Index(b0F0, lpC1)), Local0)
		Store(Local0, Index(Local6, lpC1))
		Decrement(lpN1)
		Increment(lpC1)
	}

	// ================================================
	// Prepare the benchmark buffer for comparison with
	// ================================================

	Store(b0G0, b0B0)

	Divide(arg2, 8, Local1, fb00)
	Store(DeRefOf(Index(b0B0, fb00)), Local2)

	Store(bsb0, lb00)
	Decrement(lb00)
	Store(DeRefOf(Index(b0B0, lb00)), Local3)

	Store(sft1(Local6, Local1, arg3, Local2, Local3), Local0)

	Store(fb00, Local2)
	Store(Sizeof(Local0), lpN2)
	Store(0, lpC2)
	While (lpN2) {

		Store(DeRefOf(Index(Local0, lpC2)), Local1)
		Store(Local1, Index(b0B0, Local2))

		Increment(Local2)

		Decrement(lpN2)
		Increment(lpC2)
	}


	m21a(arg0, arg1, arg2, arg3, bsz0, Local6)

	return (Zero)
}

Method(m21c, 4, Serialized)
{
	// For loop 0
	Name(lpN0, 0)
	Name(lpC0, 0)

	// For loop 1
	Name(lpN1, 0)
	Name(lpC1, 0)

	// For loop 2
	Name(lpN2, 0)
	Name(lpC2, 0)

	// Index of bit
	Name(ib00, 0)

	// Number of bits
	Name(nb00, 0)

	Store(arg1, lpN0)
	Store(0, lpC0)
	While(lpN0) {

		// Operands

		Multiply(lpC0, 6, Local6)
		Store(DeRefOf(Index(arg3, Local6)), ib00)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), lpN1)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local0)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local1)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local2)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local3)

		Store(0, lpC1)
		While (lpN1) {
			Store(Local0, nb00)
			Store(Local1, lpN2)
			Store(0, lpC2)
			While (lpN2) {
				m21b(arg0, arg2, ib00, nb00, Local2, Local3)
				Increment(nb00)

				Decrement(lpN2)
				Increment(lpC2)
			}

			Increment(ib00)

			Decrement(lpN1)
			Increment(lpC1)
		}

		Increment(lpC0)
		Decrement(lpN0)
	}
}

Method(m21d,, Serialized)
{
	Name(ts, "m21d")

	Store("TEST: m21d, Create Arbitrary Length Buffer Field:", Debug)

	// Layout of Package:
	// - <first index of bit>,
	// - <num of indexes of bits>,
	// - <first num of bits>,
	// - <num of num of bits>,
	// - opcode of buffer to fill the ground
	// - opcode of buffer to fill the field
	//   Opcodes of buffers:
	//     0 - all zeros
	//     1 - all units
	//     2 - some mix
	Name(p000, Package() {

		0, 8, 1, 80, 1, 2,

// try for 32-bit, 64-bit:
//		1, 1, 0x28, 1, 1, 2,
//		1, 1, 0x48, 1, 1, 2,

// try for 32-bit, 64-bit:
//		4, 1, 0x200, 1, 1, 2,
//		6, 1, 0x69, 1, 1, 2,

// examines the whole range possible for the size
// of the unerlying 256-byte Buffer:
//		0, 17, 1, 2032, 1, 2,

//		0, 1, 1, 1, 1, 2,
//		0, 10, 1, 30, 1, 2,
//		1, 1, 1, 90, 1, 2,
//		1, 1, 40, 1, 1, 2,
//		1, 1, 1, 39, 1, 2,
//		1, 1, 1, 40, 1, 2,
//		1, 1, 40, 1, 0, 2,
//		0, 1, 1, 65, 0, 1,
		}
	)

	m21c(ts, 1, "p000", p000)
}

// Run-method
Method(CBF0)
{
	SRMT("m211")
	m211()
	SRMT("m213")
	m213()
	SRMT("m215")
	m215()
	SRMT("m217")
	m217()
	SRMT("m219")
	m219()
	SRMT("m21d")
	m21d()
}
