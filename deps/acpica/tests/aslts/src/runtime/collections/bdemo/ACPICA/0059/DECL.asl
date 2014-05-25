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
 * Bug 0059:
 *
 * SUMMARY: String to Buffer conversion doesn't reduce the size of resulting Buffer
 */

Method(mdf9,, Serialized)
{
	// Table 17-8 Object Conversion Rules,
	// String -->> Buffer Rule:
	//	"If the string is shorter than the buffer,
	//	the buffer size is reduced".

	/*
	 * New reduction of 12.03.05:
	 * "If the string is shorter than the buffer,
	 * the remaining buffer bytes are set to zero".
	 */

	Name(b000, Buffer(202) {
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
			193,194,195,196,197,198,199,200,201,202})

	Name(b001, Buffer(202) {"zxqwrt"})

	Store("zxqwrt", b000)
	Store(ObjectType(b000), Local0)
	Store(SizeOf(b000), Local1)

	if (LNotEqual(Local0, 3)) {
		err("", zFFF, 0x000, 0, 0, Local0, 3)
	} elseif (LNotEqual(Local1, 202)) {
		err("", zFFF, 0x001, 0, 0, Local0, 202)
	} elseif (LNotEqual(b000, b001)) {
		err("", zFFF, 0x002, 0, 0, b000, b001)
	}
}


