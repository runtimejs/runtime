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
 * Convert Buffer To String
 */

Name(z048, 48)

Name(p330, Package()
{
	Buffer(8) {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
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
	Buffer(8) {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
	Buffer(128) {
		  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
		 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
		 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
		 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
		 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
		 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
		 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,
		113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128},
	Buffer(8) {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
	Buffer(16) {1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16},
	Buffer(8) {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
	Buffer(8) {1,  2,  3,  4,  5,  6,  7,  8},
	Buffer(8) {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
	Buffer(4) {1,  2,  3,  4},
	Buffer(8) {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
	Buffer(1) {1},
	Buffer(8) {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
})

Name(b330, Buffer(6) {200, 128, 16, 8, 4, 1})

// Init buffer with the symbols 1-255
Method(m303, 2)	// buf, len
{
	Store(0, Local0)
	While (LLess(Local0, arg1)) {
		Mod(Add(Local0, 1), 256, Local1)
		Store(Local1, Index(arg0, Local0))
		Increment(Local0)
	}
}

// Verify the contents of result string
Method(m305, 5)	// ts, string, len, err, case
{
	Store(0, Local0)
	While (LLess(Local0, arg2)) {
		Mod(Add(Local0, 1), 256, Local1)
		if (LNotEqual(Derefof(Index(arg1, Local0)), Local1)) {
			err(arg0, z048, arg3, 0, 0, Local0, arg4)
		}
		Increment(Local0)
	}
}

// Verify type, length of the obtained string, call to m305
Method(m307, 5)	// ts, string, len, ts, err, case
{
	if (LNotequal(ObjectType(arg1), 2)) {
		err(arg0, z048, arg3, 0, 0, arg2, "Type")
	} else {
		if (LNotEqual(Sizeof(arg1), arg2)) {
			err(arg0, z048, arg3, 0, 0, arg2, "Sizeof")
		} else {
			m305(arg0, arg1, arg2, arg3, arg4)
		}
	}
}

// Check the surrounding control buffers are safe
Method(m309, 3)	// ts, indbuf, err
{
	// control buffer
	Store(Derefof(Index(p330, arg1)), Local1)

	Store(0, Local0)
	While (LLess(Local0, 8)) {
		if (LNotEqual(Derefof(Index(Local1, Local0)), 0xff)) {
			err(arg0, z048, arg2, 0, 0, Local0, "buf8")
		}
		Increment(Local0)
	}
}

// Check all positions of null character (0-200)
Method(m30a, 1, Serialized)
{
	Name(LENS, Buffer() {200, 199, 129, 128, 127, 9, 8, 7, 1, 0})

	Name(BUF0, Buffer(255){})

	// Buffer (255 bytes) initialized with non-zero bytes

	m303(BUF0, 255)

	Store(0, Local1)

	While (LLess(Local1, 10)) {

		// Fill zero byte in position specified by LENS

		Store(Derefof(Index(LENS, Local1)), Local0)
		Store(Derefof(Index(BUF0, Local0)), Local5)
		Store(0, Index(BUF0, Local0))

		// The contents of buffer is not more changed in checkings below

		// Checking for unspecified Length parameter

		// Invoke ToString without Length

		Store(ToString(BUF0), Local2)
		m307(arg0, Local2, Local0, 1, "Omit")

		// Invoke ToString with Ones

		ToString(BUF0, Ones, Local2)
		m307(arg0, Local2, Local0, 2, "Ones")

		// Checking for particular values of Length parameter (0, 32, 64...)

		Store(0, Local3) // Length
		While (LLess(Local3, 401)) {

			Store(Local0, Local4) // expected size
			if (LLess(Local3, Local4)) {
				Store(Local3, Local4)
			}

			ToString(BUF0, Local3, Local2)
			m307(arg0, Local2, Local4, 3, "Size")

			Add(Local3, 32, Local3)
		}

		// Restore position specified by LENS

		Store(Local5, Index(BUF0, Local0))
		Increment(Local1)
	}
}

Method(m333, 1)
{
	Store(0, Local0)
	Store(ToString(DerefOf(Arg0)), Local0)
	Store(Local0, Debug)
}

// Check Buffer->Length effective condition.
// Don't put null characters. Check the surrounding
// control buffers are safe.
Method(m30b, 1, Serialized)
{
	Name(Loc8, 0)

	Store(0, Local5)	// index of control buffer 1

	While (LLess(Loc8, 6)) {

		// Choose the buffer from package

		Store(Derefof(Index(b330, Loc8)), Local0)	// length
		Multiply(Loc8, 2, Local1)			// index of a buffer
		Add(Local1, 1, Local1)
		Add(Local1, 1, Local6)				// index of control buffer 2
		Store(Index(p330, Local1), Local4)		// ref to test buffer

		// Checking for unspecified Length parameter

		// Invoke ToString without Length

		Store(ToString(Derefof(Local4)), Local2)
		m307(arg0, Local2, Local0, 4, "Omit")
		m309(arg0, Local5, 4)	// check control buffers
		m309(arg0, Local6, 4)

		// Invoke ToString with Ones

		ToString(Derefof(Local4), Ones, Local2)
		m307(arg0, Local2, Local0, 5, "Ones")
		m309(arg0, Local5, 5)	// check control buffers
		m309(arg0, Local6, 5)

		// Checking for particular values of Length parameter
		// exceeding (by 0, 1, 2, 3, ... 8) the actual lengths of Buffer

		Add(Local0, 9, Local7) // Max. Length

		Store(Local0, Local3) // Length
		While (LLess(Local3, Local7)) {

			ToString(Derefof(Local4), Local3, Local2)
			m307(arg0, Local2, Local0, 6, "Size")

			m309(arg0, Local5, 6)	// check control buffers
			m309(arg0, Local6, 6)

			Increment(Local3)
		}
		Store(Local6, Local5)

		Increment(Loc8)
	}
}

// Check zero length buffer, and, in passing,
// dynamically allocated buffers.
Method(m30c, 1, Serialized)
{
	Name(LENS, Buffer() {200, 199, 1, 0})

	Store(0, Local1)
	While (LLess(Local1, 4)) {


		// Allocate buffer dynamically and initialize it,
		// don't put null characters.

		Store(Derefof(Index(LENS, Local1)), Local0)
		Store(Buffer(Local0){}, Local4)
		m303(Local4, Local0)

		// Checking for unspecified Length parameter

		// Invoke ToString without Length

		Store(ToString(Local4), Local2)
		m307(arg0, Local2, Local0, 7, "Omit")

		// Invoke ToString with Ones

		ToString(Local4, Ones, Local2)
		m307(arg0, Local2, Local0, 8, "Ones")


		// Allocate buffer of +1 size and put null characters
		// into the last byte.

		Store(Buffer(Add(Local0, 1)){}, Local4)
		m303(Local4, Local0)
		Store(0, Index(Local4, Local0))

		// Invoke ToString without Length

		Store(ToString(Local4), Local2)
		m307(arg0, Local2, Local0, 9, "Omit")

		// Invoke ToString with Ones

		ToString(Local4, Ones, Local2)
		m307(arg0, Local2, Local0, 10, "Ones")

		Increment(Local1)
	}
}

// Run-method
Method(TOS0,, Serialized)
{
	Name(ts, "TOS0")

	Store("TEST: TOS0, Convert Buffer To String", Debug)

	m30a(ts)
	m30b(ts)
	m30c(ts)
}

