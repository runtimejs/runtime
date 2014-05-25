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
   ============================
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!
   IT IS IN PROGRESS !!!!!!!!!!
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!
   ============================
*/

// Implicit Result Object Conversion, complex test

Name(z067, 67)

// Integers
Name(ii00, 0)
Name(ii10, 0)

// Strings
Name(ss00, "")
Name(ss10, "!@#$%^&*()_+=-[]{}")

// Buffers
Name(bb00, Buffer(1) {})
Name(bb80, Buffer(1) {})
// Inside 32-bit Integer
Name(bb01, Buffer(3) {})
Name(bb81, Buffer(3) {})
// 32-bit Integer
Name(bb02, Buffer(4) {})
Name(bb82, Buffer(4) {})
// Inside 64-bit Integer
Name(bb03, Buffer(5) {})
Name(bb83, Buffer(5) {})
// Inside 64-bit Integer
Name(bb04, Buffer(8) {})
Name(bb84, Buffer(8) {})
// Size exceeding result
Name(bb05, Buffer(20) {})
Name(bb85, Buffer(20) {})

// Buffer Fields
Name(bbff, Buffer(160) {})
CreateField(bbff, 5, 27, bf00)
CreateField(bbff, 32, 47, bf01)
CreateField(bbff, 79, 27, bf10)
CreateField(bbff, 106, 47, bf11)
// Incomplete last byte
CreateField(bbff, 153, 111, bf02)
CreateField(bbff, 264, 111, bf12)
// Incomplete extra byte
CreateField(bbff, 375, 119, bf03)
CreateField(bbff, 494, 119, bf13)
// Size exceeding result
CreateField(bbff, 654, 160, bf04)
CreateField(bbff, 814, 160, bf14)
// 32-bit Integer
CreateField(bbff, 974, 32, bf05)
CreateField(bbff, 1006, 32, bf15)
// 64-bit Integer
CreateField(bbff, 1038, 64, bf06)
CreateField(bbff, 1102, 64, bf16)

// Set all bytes of Buffer bbff to 0xff
Method(m565,, Serialized)
{
	Name(lpN0, 160)
	Name(lpC0, 0)

	While (lpN0) {

		Store(0xff, Index(bbff, lpC0))

		Decrement(lpN0)
		Increment(lpC0)
	}
}

// Acquire (mux, wrd) => Boolean
Method(m500, 1, Serialized)
{
	Name(ts, "m500")
	ts00(ts)

	Mutex(mt00, 0)
	Name(b000, Buffer() {0x00})

	Store(Acquire(mt00, 0), ii10)
	m4c0(ts, ii10, ZERO, ZERO)

	Store(Acquire(mt00, 0x0010), ss10)
	m4c0(ts, ss10, "0000000000000000", "00000000")

	Store(Acquire(mt00, 0x0020), bb80)
	m4c0(ts, bb80, b000, b000)
}

// Add (int, int, Result) => Integer
Method(m501, 1, Serialized)
{
	Name(ts, "m501")
	ts00(ts)

	Name(b000, Buffer() {0x63})
	Name(b001, Buffer() {0x63})
	Name(b002, Buffer() {0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,
					0x18,0x19,0x1a,0x1b,0x1c,0x1d,0x1e,0x1f})
	Name(b003, Buffer() {0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,
					0x28,0x29,0x2a,0x2b,0x2c,0x2d,0x2e,0x2f})
	Name(b004, Buffer() {0x63,0xF4,0x9C,0x52,0x13,0xCF,0x8A,0,0,0,0,0,0,0,0,0})
	Name(b005, Buffer() {0x63,0xF4,0x9C,0x52,0,0,0,0,0,0,0,0,0,0,0,0})

	// Integers
	Store(Add(0x123456789abcda, 0x789abcda023789, ii00), ii10)
	m4c0(ts, ii00, 0x008ACF13529CF463, 0x529CF463)
	m4c0(ts, ii10, 0x008ACF13529CF463, 0x529CF463)

	// Strings
	Store(Add(0x123456789abcda, 0x789abcda023789, ss00), ss10)
	m4c0(ts, ss00, "008ACF13529CF463", "529CF463")
	m4c0(ts, ss10, "008ACF13529CF463", "529CF463")

	// Buffers smaller than result
	Store(Add(0x123456789abcda, 0x789abcda023789, bb00), bb80)
	m4c0(ts, bb00, b000, b001)
	m4c0(ts, bb80, b000, b001)

	// Buffers greater than result
	Store(Add(0x123456789abcda, 0x789abcda023789, b002), b003)
	m4c0(ts, b002, b004, b005)
	m4c0(ts, b003, b004, b005)

	// Set fields (their source buffer) to zero

// Store(bbff, Debug)

	m565()
	Store(Add(0x123456789abcda, 0x789abcda023789, bf00), bf10)
	m4c0(ts, bf00, b004, b005)
	m4c0(ts, bf10, b004, b005)

// !!! check the contents of bbff !!!!!!!!!

// Store(bbff, Debug)
}

// And (int, int, Result) => Integer
Method(m502, 1, Serialized)
{
	Name(ts, "m502")
	ts00(ts)
}

// Concatenate ({int|str|buf}, {int|str|buf}, Result) => ComputationalData
Method(m503, 1)
{
	m563()
	m564()
}

Method(m563,, Serialized)
{
	Name(ts, "m503,s+s")

	// s+s -->> s -->> all combinations of Result and ComputationalData

	// Result 64-bit, 32-bit, ComputationalData 64-bit, 32-bit
	Name(p000, Package() {

	// ============= With Result

	0x00ABCDEF12345678, 0x12345678, 0x00ABCDEF12345678, 0x12345678,
	0x00ABCDEF12345678, 0x12345678, "abcdef12345678", "abcdef12345678",
	0x00ABCDEF12345678, 0x12345678, Buffer() {0x61}, Buffer() {0x61},
	0x00ABCDEF12345678, 0x12345678, 0x04636261, 0x04636261,
	0x00ABCDEF12345678, 0x12345678, 0x0000666564636261,
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
	"abcdef12345678", "abcdef12345678", 0x00ABCDEF12345678, 0x12345678,
	"abcdef12345678", "abcdef12345678", "abcdef12345678", "abcdef12345678",
	"abcdef12345678", "abcdef12345678", Buffer() {0x61}, Buffer() {0x61},
	"abcdef12345678", "abcdef12345678", 0x04636261, 0x04636261,
	"abcdef12345678", "abcdef12345678", 0x0000666564636261,
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
	Buffer() {0x61}, Buffer() {0x61}, 0x00ABCDEF12345678, 0x12345678,
	Buffer() {0x61}, Buffer() {0x61}, "abcdef12345678", "abcdef12345678",
	Buffer() {0x61}, Buffer() {0x61}, Buffer() {0x61}, Buffer() {0x61},
	Buffer() {0x61}, Buffer() {0x61}, 0x04636261, 0x04636261,
	Buffer() {0x61}, Buffer() {0x61}, 0x0000666564636261,
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
	0x0000000004636261, 0x04636261, 0x00ABCDEF12345678, 0x12345678,
	0x0000000004636261, 0x04636261, "abcdef12345678", "abcdef12345678",
	0x0000000004636261, 0x04636261, Buffer() {0x61}, Buffer() {0x61},
	0x0000000004636261, 0x04636261, 0x0000000004636261, 0x04636261,
	0x0000000004636261, 0x04636261, 0x0000666564636261,
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
	0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
		0x00ABCDEF12345678, 0x12345678,
	0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
		"abcdef12345678", "abcdef12345678",
	0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
		Buffer() {0x61}, Buffer() {0x61},
	0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
		0x0000000004636261, 0x04636261,
	0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
		0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},

	// ============= Result omited

	0,0, 0x00ABCDEF12345678, 0x12345678,
	0,0, "abcdef12345678", "abcdef12345678",
	0,0, Buffer() {0x61}, Buffer() {0x61},
	0,0, 0x04636261, 0x04636261,
	0,0, 0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},

	// ============= Store omited

	0x00ABCDEF12345678, 0x12345678, 0,0,
	"abcdef12345678", "abcdef12345678", 0,0,
	Buffer() {0x61}, Buffer() {0x61}, 0,0,
	0x04636261, 0x04636261, 0,0,
	0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66}, 0,0,

	// ============= Particular additional cases

	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
			0x33,0x34,0x35,0x36,0x37,0x38},
	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
			0x33,0x34,0x35,0x36,0x37,0x38},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38},
	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
			0x33,0x34,0x35,0x36,0x37,0x38,0x00},
	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
			0x33,0x34,0x35,0x36,0x37,0x38,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00},
	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
				0x00,0x00,0x00,0x00},
	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
				0x00,0x00,0x00,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
				0x00,0x00,0x00,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
				0x00,0x00,0x00,0x00},
	Buffer() {0x61,0x62,0x63}, Buffer() {0x61,0x62,0x63},
	Buffer() {0x61,0x62,0x63}, Buffer() {0x61,0x62,0x63},
	Buffer() {0x61,0x62,0x63,0x64}, Buffer() {0x61,0x62,0x63,0x64},
	Buffer() {0x61,0x62,0x63,0x64}, Buffer() {0x61,0x62,0x63,0x64},

	Buffer() {0x61,0x62,0x63,0x64,0x65}, Buffer() {0x61,0x62,0x63,0x64,0x65},
	Buffer() {0x61,0x62,0x63,0x64,0x65}, Buffer() {0x61,0x62,0x63,0x64,0x65},

	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32},
	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32},
	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
			0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
			0x00,0x00,0x00,0x00},
	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
			0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
			0x00,0x00,0x00,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
				0x00,0x00,0x00,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
				0x00,0x00,0x00,0x00},
	})

	Store("abcdef", Local0)
	Store("12345678", Local1)

	m562(ts, Local0, Local1, p000)

	// Source values are not corrupted

	Store(ObjectType(Local0), Local2)
	if (LNotEqual(Local2, 2)) {
		err(ts, z067, 0, 0, 0, Local2, 2)
	} elseif (LNotEqual(Local0, "abcdef")) {
		err(ts, z067, 1, 0, 0, Local0, "abcdef")
	}

	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, 2)) {
		err(ts, z067, 2, 0, 0, Local2, 2)
	} elseif (LNotEqual(Local1, "12345678")) {
		err(ts, z067, 3, 0, 0, Local1, "12345678")
	}
}

Method(m564,, Serialized)
{
	Name(ts, "m503,b+b")

	// b+b -->> b -->> all combinations of Result and ComputationalData

	// Result 64-bit, 32-bit, ComputationalData 64-bit, 32-bit
	Name(p000, Package() {

	// ============= With Result

	// i,i
	0x3231666564636261, 0x64636261, 0x3231666564636261, 0x64636261,
	// i,s
	0x3231666564636261, 0x64636261,
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
	// i,b
	0x3231666564636261, 0x64636261, Buffer() {0x61}, Buffer() {0x61},
	// i,bf(i,i)
	0x3231666564636261, 0x64636261, 0x04636261, 0x04636261,
	// i,bf(i,b)
	0x3231666564636261, 0x64636261,
		0x0000666564636261,
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
	// s,i
	"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		0x3231666564636261, 0x64636261,
	// s,s
	"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
	// s,b
	"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		Buffer() {0x61},
		Buffer() {0x61},
	// s,bf(i,i)
	"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		0x0000000004636261,
		0x04636261,
	// s,bf(i,b)
	"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		0x0000666564636261,
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
	// b,i
	Buffer() {0x61}, Buffer() {0x61}, 0x3231666564636261, 0x64636261,
	// b,s
	Buffer() {0x61}, Buffer() {0x61},
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
	// b,b
	Buffer() {0x61}, Buffer() {0x61}, Buffer() {0x61}, Buffer() {0x61},
	// b,bf(i,i)
	Buffer() {0x61}, Buffer() {0x61}, 0x04636261, 0x04636261,
	// b,bf(i,b)
	Buffer() {0x61}, Buffer() {0x61}, 0x0000666564636261,
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
	// bf(i,i),i
	0x0000000004636261, 0x04636261, 0x3231666564636261, 0x64636261,
	// bf(i,i),s
	0x0000000004636261, 0x04636261,
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
	// bf(i,i),b
	0x0000000004636261, 0x04636261, Buffer() {0x61}, Buffer() {0x61},
	// bf(i,i),bf(i,i)
	0x0000000004636261, 0x04636261, 0x0000000004636261, 0x04636261,
	// bf(i,i),bf(i,b)
	0x0000000004636261, 0x04636261, 0x0000666564636261,
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
	// bf(i,b),i
	0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
		0x3231666564636261, 0x64636261,
	// bf(i,b),s
	0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
	// bf(i,b),b
	0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
		Buffer() {0x61}, Buffer() {0x61},
	// bf(i,b),bf(i,i)
	0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
		0x0000000004636261, 0x04636261,
	// bf(i,b),bf(i,b)
	0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},
		0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},

	// ============= Result omited

	// ,i
	0,0, 0x3231666564636261, 0x64636261,
	// ,s
	0,0, "61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
	// ,b
	0,0, Buffer() {0x61}, Buffer() {0x61},
	// ,bf(i,i)
	0,0, 0x04636261, 0x04636261,
	// b,bf(i,b)
	0,0, 0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66},

	// ============= Store omited

	// i,
	0x3231666564636261, 0x64636261, 0,0,
	// s,
	"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		"61 62 63 64 65 66 31 32 33 34 35 36 37 38",
		0,0,
	// b,
	Buffer() {0x61}, Buffer() {0x61}, 0,0,
	// bf(i,i),
	0x04636261, 0x04636261, 0,0,
	// bf(i,b),
	0x0000666564636261, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66}, 0,0,

	// ============= Particular additional cases

	// Buffer Field, incomplete last byte
	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
			0x33,0x34,0x35,0x36,0x37,0x38},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
			0x33,0x34,0x35,0x36,0x37,0x38},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38},
	// Buffer Field, incomplete extra byte
	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
			0x33,0x34,0x35,0x36,0x37,0x38,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
			0x33,0x34,0x35,0x36,0x37,0x38,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00},
	// Buffer Field, size exceeding result
	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
				0x00,0x00,0x00,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
				0x00,0x00,0x00,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
				0x00,0x00,0x00,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
				0x00,0x00,0x00,0x00},
	// Buffer, inside 32-bit Integer
	Buffer() {0x61,0x62,0x63}, Buffer() {0x61,0x62,0x63},
		Buffer() {0x61,0x62,0x63}, Buffer() {0x61,0x62,0x63},
	// Buffer, 32-bit Integer
	Buffer() {0x61,0x62,0x63,0x64}, Buffer() {0x61,0x62,0x63,0x64},
		Buffer() {0x61,0x62,0x63,0x64}, Buffer() {0x61,0x62,0x63,0x64},
	// Buffer, inside 64-bit Integer
	Buffer() {0x61,0x62,0x63,0x64,0x65}, Buffer() {0x61,0x62,0x63,0x64,0x65},
		Buffer() {0x61,0x62,0x63,0x64,0x65}, Buffer() {0x61,0x62,0x63,0x64,0x65},
	// Buffer, 64-bit Integer
	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32},
	// Buffer, size exceeding result
	Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
			0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
			0x00,0x00,0x00,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
			0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
			0x00,0x00,0x00,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
				0x00,0x00,0x00,0x00},
		Buffer() {0x61,0x62,0x63,0x64,0x65,0x66,0x31,0x32,
				0x33,0x34,0x35,0x36,0x37,0x38,0x00,0x00,
				0x00,0x00,0x00,0x00},
	})

	Name(b000, Buffer() {0x61,0x62,0x63,0x64,0x65,0x66})
	Name(b001, Buffer() {0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38})

	Store(b000, Local0)
	Store(b001, Local1)

	m562(ts, Local0, Local1, p000)

	// Source values are not corrupted

	Store(ObjectType(Local0), Local2)
	if (LNotEqual(Local2, 3)) {
		err(ts, z067, 4, 0, 0, Local2, 3)
	} elseif (LNotEqual(Local0, b000)) {
		err(ts, z067, 5, 0, 0, Local0, b000)
	}

	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, 3)) {
		err(ts, z067, 6, 0, 0, Local2, 3)
	} elseif (LNotEqual(Local1, b001)) {
		err(ts, z067, 7, 0, 0, Local1, b001)
	}
}

// arg0 - name of test
// arg1 - Source1
// arg2 - Source2
// arg3 - results
Method(m562, 4)
{
	ts00(arg0)

	// ============= With Result
	// ii,is,ib,ibf
	// si,ss,sb,sbf
	// bi,bs,bb,bbf
	// bfi,bfs,bfb,bfbf

	// i,i
	Store(Concatenate(arg1, arg2, ii00), ii10)
	m4c1(arg0, arg3, 0, 1, 1, ii00, ii10)
	// i,s
	Store(Concatenate(arg1, arg2, ii00), ss10)
	m4c1(arg0, arg3, 1, 1, 1, ii00, ss10)
	// i,b
	Store(Concatenate(arg1, arg2, ii00), bb80)
	m4c1(arg0, arg3, 2, 1, 1, ii00, bb80)
	// i,bf(i,i)
	Store(Concatenate(arg1, arg2, ii00), bf10)
	m4c1(arg0, arg3, 3, 1, 1, ii00, bf10)
	// i,bf(i,b)
	Store(Concatenate(arg1, arg2, ii00), bf11)
	m4c1(arg0, arg3, 4, 1, 1, ii00, bf11)

	// s,i
	Store(Concatenate(arg1, arg2, ss00), ii10)
	m4c1(arg0, arg3, 5, 1, 1, ss00, ii10)
	// s,s
	Store(Concatenate(arg1, arg2, ss00), ss10)
	m4c1(arg0, arg3, 6, 1, 1, ss00, ss10)
	// s,b
	Store(Concatenate(arg1, arg2, ss00), bb80)
	m4c1(arg0, arg3, 7, 1, 1, ss00, bb80)
	// s,bf(i,i)
	Store(Concatenate(arg1, arg2, ss00), bf10)
	m4c1(arg0, arg3, 8, 1, 1, ss00, bf10)
	// s,bf(i,b)
	Store(Concatenate(arg1, arg2, ss00), bf11)
	m4c1(arg0, arg3, 9, 1, 1, ss00, bf11)

	// b,i
	Store(Concatenate(arg1, arg2, bb00), ii10)
	m4c1(arg0, arg3, 10, 1, 1, bb00, ii10)
	// b,s
	Store(Concatenate(arg1, arg2, bb00), ss10)
	m4c1(arg0, arg3, 11, 1, 1, bb00, ss10)
	// b,b
	Store(Concatenate(arg1, arg2, bb00), bb80)
	m4c1(arg0, arg3, 12, 1, 1, bb00, bb80)
	// b,bf(i,i)
	Store(Concatenate(arg1, arg2, bb00), bf10)
	m4c1(arg0, arg3, 13, 1, 1, bb00, bf10)
	// b,bf(i,b)
	Store(Concatenate(arg1, arg2, bb00), bf11)
	m4c1(arg0, arg3, 14, 1, 1, bb00, bf11)

	// bf(i,i),i
	Store(Concatenate(arg1, arg2, bf00), ii10)
	m4c1(arg0, arg3, 15, 1, 1, bf00, ii10)
	// bf(i,i),s
	Store(Concatenate(arg1, arg2, bf00), ss10)
	m4c1(arg0, arg3, 16, 1, 1, bf00, ss10)
	// bf(i,i),b
	Store(Concatenate(arg1, arg2, bf00), bb80)
	m4c1(arg0, arg3, 17, 1, 1, bf00, bb80)
	// bf(i,i),bf(i,i)
	Store(Concatenate(arg1, arg2, bf00), bf10)
	m4c1(arg0, arg3, 18, 1, 1, bf00, bf10)
	// bf(i,i),bf(i,b)
	Store(Concatenate(arg1, arg2, bf00), bf11)
	m4c1(arg0, arg3, 19, 1, 1, bf00, bf11)

	// bf(i,b),i
	Store(Concatenate(arg1, arg2, bf01), ii10)
	m4c1(arg0, arg3, 20, 1, 1, bf01, ii10)
	// bf(i,b),s
	Store(Concatenate(arg1, arg2, bf01), ss10)
	m4c1(arg0, arg3, 21, 1, 1, bf01, ss10)
	// bf(i,b),b
	Store(Concatenate(arg1, arg2, bf01), bb80)
	m4c1(arg0, arg3, 22, 1, 1, bf01, bb80)
	// bf(i,b),bf(i,i)
	Store(Concatenate(arg1, arg2, bf01), bf10)
	m4c1(arg0, arg3, 23, 1, 1, bf01, bf10)
	// bf(i,b),bf(i,b)
	Store(Concatenate(arg1, arg2, bf01), bf11)
	m4c1(arg0, arg3, 24, 1, 1, bf01, bf11)

	// ============= Result omited
	// ,i,s,b,bf

	// ,i
	Store(Concatenate(arg1, arg2), ii10)
	m4c1(arg0, arg3, 25, 0, 1, 0, ii10)
	// ,s
	Store(Concatenate(arg1, arg2), ss10)
	m4c1(arg0, arg3, 26, 0, 1, 0, ss10)
	// ,b
	Store(Concatenate(arg1, arg2), bb80)
	m4c1(arg0, arg3, 27, 0, 1, 0, bb80)
	// ,bf(i,i)
	Store(Concatenate(arg1, arg2), bf10)
	m4c1(arg0, arg3, 28, 0, 1, 0, bf10)
	// b,bf(i,b)
	Store(Concatenate(arg1, arg2), bf11)
	m4c1(arg0, arg3, 29, 0, 1, 0, bf11)

	// ============= Store omited
	// i,s,b,bf,

	// i,
	Concatenate(arg1, arg2, ii00)
	m4c1(arg0, arg3, 30, 1, 0, ii00, 0)
	// s,
	Concatenate(arg1, arg2, ss00)
	m4c1(arg0, arg3, 31, 1, 0, ss00, 0)
	// b,
	Concatenate(arg1, arg2, bb00)
	m4c1(arg0, arg3, 32, 1, 0, bb00, 0)
	// bf(i,i),
	Concatenate(arg1, arg2, bf00)
	m4c1(arg0, arg3, 33, 1, 0, bf00, 0)
	// bf(i,b),
	Concatenate(arg1, arg2, bf01)
	m4c1(arg0, arg3, 34, 1, 0, bf01, 0)

	// ============= Particular additional cases

	// Buffer Field, incomplete last byte
	Store(Concatenate(arg1, arg2, bf02), bf12)
	m4c1(arg0, arg3, 35, 1, 1, bf02, bf12)

	// Buffer Field, incomplete extra byte
	Store(Concatenate(arg1, arg2, bf03), bf13)
	m4c1(arg0, arg3, 36, 1, 1, bf03, bf13)

	// Buffer Field, size exceeding result
	Store(Concatenate(arg1, arg2, bf04), bf14)
	m4c1(arg0, arg3, 37, 1, 1, bf04, bf14)

	// Buffer, inside 32-bit Integer
	Store(Concatenate(arg1, arg2, bb01), bb81)
	m4c1(arg0, arg3, 38, 1, 1, bb01, bb81)

	// Buffer, 32-bit Integer
	Store(Concatenate(arg1, arg2, bb02), bb82)
	m4c1(arg0, arg3, 39, 1, 1, bb02, bb82)

	// Buffer, inside 64-bit Integer
	Store(Concatenate(arg1, arg2, bb03), bb83)
	m4c1(arg0, arg3, 40, 1, 1, bb03, bb83)

	// Buffer, 64-bit Integer
	Store(Concatenate(arg1, arg2, bb04), bb84)
	m4c1(arg0, arg3, 41, 1, 1, bb04, bb84)

	// Buffer, size exceeding result
	Store(Concatenate(arg1, arg2, bb05), bb85)
	m4c1(arg0, arg3, 42, 1, 1, bb05, bb85)
}

// ConcatenateResTemplate (rtb, rtb, Result) => Buffer
Method(m504, 1, Serialized)
{
	Name(op, 4)

	Name(ts, "m504")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// CondRefOf (any, Result) => Boolean
Method(m505, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m505")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// CopyObject (any, Destination) => DataRefObject
Method(m506, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m506")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// Decrement (int) => Integer
Method(m507, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m507")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// DerefOf ({ref|str}) => Object
Method(m508, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m508")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// Divide (int, int, Remainder, Result) => Integer
Method(m509, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m509")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// FindSetLeftBit (int, Result) => Integer
Method(m511, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m511")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// FindSetRightBit (int, Result) => Integer
Method(m512, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m512")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// FromBCD (int, Result) => Integer
Method(m513, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m513")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// Increment (int) => Integer
Method(m514, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m514")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// Index ({str|buf|pkg}, int, Destination) => ObjectReference
Method(m515, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m515")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// LAnd (int, int) => Boolean
Method(m516, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m516")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// LEqual ({int|str|buf}, {int|str|buf}) => Boolean
Method(m517, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m517")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// LGreater ({int|str|buf}, {int|str|buf}) => Boolean
Method(m518, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m518")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// LGreaterEqual ({int|str|buf}, {int|str|buf}) => Boolean
Method(m519, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m519")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// LLess ({int|str|buf}, {int|str|buf}) => Boolean
Method(m520, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m520")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// LLessEqual ({int|str|buf}, {int|str|buf}) => Boolean
Method(m521, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m521")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// LNot (int) => Boolean
Method(m522, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m522")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// LNotEqual ({int|str|buf}, {int|str|buf}) => Boolean
Method(m523, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m523")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// LOr (int, int) => Boolean
Method(m524, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m524")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// Match (pkg, byt, int, byt, int, int) => Ones | Integer
Method(m525, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m525")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// Mid ({str|buf}, int, int, Result) => Buffer or String
Method(m526, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m526")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// Mod (int, int, Result) => Integer
Method(m527, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m527")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// Multiply (int, int, Result) => Integer
Method(m528, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m528")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// NAnd (int, int, Result) => Integer
Method(m529, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m529")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// NOr (int, int, Result) => Integer
Method(m530, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m530")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// Not (int, Result) => Integer
Method(m531, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m531")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// ObjectType (any) => Integer
Method(m532, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m532")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// Or (int, int, Result) => Integer
Method(m533, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m533")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// RefOf (any) => ObjectReference
Method(m534, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m534")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// Return ({any|ref})
Method(m537, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m537")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// ShiftLeft (int, int, Result) => Integer
Method(m538, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m538")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// ShiftRight (int, int, Result) => Integer
Method(m539, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m539")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// SizeOf ({int|str|buf|pkg}) => Integer
Method(m541, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m541")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// Store (any, Destination) => DataRefObject
Method(m544, 1, Serialized)
{
	Name(ts, "m544")

	ts00(ts)

	Name(ss00, "DEF")
	Store("ABC", ss00)

	Store(ObjectType(ss00), Local0)
	if (LNotEqual(Local0, 2)) {
		err(ts, z067, 8, 0, 0, Local0, 2)
	} elseif (LNotEqual(ss00, "ABC")) {
		err(ts, z067, 9, 0, 0, ss00, "ABC")
	}

	// If the string is shorter than the buffer, the buffer size is reduced.

	Name(b000, Buffer(200) {})
	Name(b001, Buffer() {0x41,0x42,0x43,0x44,0x45,0x46})

	Store("ABCDEF", b000)
	Store(ObjectType(b000), Local0)
	Store(SizeOf(b000), Local1)

	if (LNotEqual(Local0, 3)) {
		err(ts, z067, 10, 0, 0, Local0, 3)
	} elseif (LNotEqual(Local1, 6)) {
		err(ts, z067, 11, 0, 0, Local1, 6)
	} elseif (LNotEqual(b000, b001)) {
		err(ts, z067, 12, 0, 0, b000, b001)
	}

/*
	Store("================ 000000000:", Debug)
	Store(Local0, Debug)
	Store(Local1, Debug)


	CopyObject("ABC", b000)
	Store(SizeOf(b000), Local0)
	Store(ObjectType(b000), Local1)

	Store("================ 000000000:", Debug)
	Store(Local0, Debug)
	Store(Local1, Debug)
*/
}

// Subtract (int, int, Result) => Integer
Method(m545, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m545")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// ToBCD (int, Result) => Integer
Method(m546, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m546")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// ToBuffer ({int|str|buf}, Result) => Buffer
Method(m547, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m547")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// ToDecimalString ({int|str|buf}, Result) => String
Method(m548, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m548")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// ToHexString ({int|str|buf}, Result) => String
Method(m549, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m549")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// ToInteger ({int|str|buf}, Result) => Integer
Method(m550, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m550")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// ToString (buf, int, Result) => String
Method(m551, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m551")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// Wait (evt, int) => Boolean
Method(m552, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m552")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

// XOr (int, int, Result) => Integer
Method(m553, 1, Serialized)
{
	Name(op, 0)

	Name(ts, "m553")

	ts00(ts)

	if (arg0) {
	} else {
	}
}

Method(m560, 1)
{
/*
	m500(arg0)
	m501(arg0)
	m502(arg0)
	m503(arg0)
	m504(arg0)
	m505(arg0)
	m506(arg0)
	m507(arg0)
	m508(arg0)
	m509(arg0)
	m511(arg0)
	m512(arg0)
	m513(arg0)
	m514(arg0)
	m515(arg0)
	m516(arg0)
	m517(arg0)
	m518(arg0)
	m519(arg0)
	m520(arg0)
	m521(arg0)
	m522(arg0)
	m523(arg0)
	m524(arg0)
	m525(arg0)
	m526(arg0)
	m527(arg0)
	m528(arg0)
	m529(arg0)
	m530(arg0)
	m531(arg0)
	m532(arg0)
	m533(arg0)
	m534(arg0)
	m537(arg0)
	m538(arg0)
	m539(arg0)
	m541(arg0)
	m544(arg0)
	m545(arg0)
	m546(arg0)
	m547(arg0)
	m548(arg0)
	m549(arg0)
	m550(arg0)
	m551(arg0)
	m552(arg0)
	m553(arg0)
*/

	m500(arg0)
	m501(arg0)
	m502(arg0)
	m503(arg0)
	m544(arg0)
}
