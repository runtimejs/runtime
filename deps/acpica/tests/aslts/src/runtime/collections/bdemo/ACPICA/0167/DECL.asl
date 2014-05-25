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
 * Bug 167:
 *
 * SUMMARY: Manipulation test PASS but started reporting suspicious diagnostic
 *
 * Check that messages doesnt occur...
 * but since it was due to the incorrect size of Package
 * generated in that case we do this test as runtime test
 * (but not ACTION_REQUIRED type).
 *
 * NOTE:    checking of AE_AML_METHOD_LIMIT limits (32 and 256)
 *          should be performed in a separate tests (see plan/addition).
 *
 * This is regression.
 * It did not take place earlier.
 * Our test (manipulation) results in PASS, and no exceptions,
 * but some diagnostic information is suspicious (see below).
 * The anomalies are revealed by the test package.asl,
 * methods m1f3 and m203. See attachment.
 * .........
 */

	// gr1.asl

	Method(mf54,, Serialized)
	{
		Name(p000, Package() {
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
			241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,
		})

		Store(Sizeof (p000), Local0)

		if (LNotEqual(Local0, 256)) {
			err("", zFFF, 0x000, 0, 0, Local0, 256)
		} else {
			Store(1, Local1)
			Store(0, Local2)
			while (Local0) {
				Store(DeRefOf(Index(p000, Local2)), Local3)
				if (LNotEqual(Local3, Local1)) {
					err("", zFFF, 0x001, 0, 0, Local3, Local1)
					Break
				}
				Decrement(Local0)
				Increment(Local1)
				Increment(Local2)
			}
			if (LNot(Local0)) {Store("Ok", Debug)}
		}
	}

	// gr2.asl

	Method(mf55, 1)
	{
		if (Arg0) {
			Return (Multiply(Arg0, mf55(Subtract(Arg0, 1))))
		} else {
			Return (1)
		}
	}

	Method(mf56)
	{
		Store("mf55(4):", Debug)
		mf55(4)

		Store("mf55(25):", Debug)
		mf55(25)
	}

	// gr3.asl

	Method(mf57,, Serialized)
	{
		Name(i000, 0)

		Method(mm00, 1)
		{
			Increment(i000)

			if (arg0) {
				mm01()
			}
		}

		Method(mm01) {mm00(0)}

		Store(0, i000)
		mm00(0)
		if (LNotEqual(i000, 1)) {
			err("", zFFF, 0x002, 0, 0, i000, 1)
		}

		Store(0, i000)
		mm00(1)
		if (LNotEqual(i000, 2)) {
			err("", zFFF, 0x003, 0, 0, i000, 2)
		}
	}
