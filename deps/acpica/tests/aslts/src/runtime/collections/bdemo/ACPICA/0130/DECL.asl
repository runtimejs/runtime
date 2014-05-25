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
 * Bug 130:
 *
 * SUMMARY: Reference to String works differently to like the references to Buffer and Package work
 */

	Method(mf19, 1)
	{
		Store(DerefOf(arg0), Local2)
		Store(0x2b, Index(Local2, 1))
//		Store(0x2b, Index(DerefOf(arg0), 1))
	}

	Method(mf1a, 1)
	{
		Store(RefOf(arg0), Local0)
		mf19(Local0)
	}

	Method(mf1b)
	{
		// Index of String

		mf1a(sd04)
		if (LNotEqual(sd04, "qwer0000")) {
			err("", zFFF, 0x000, 0, 0, sd04, "qwer0000")
		}

		// Index of Buffer

		mf1a(bd08)
		if (LNotEqual(bd08, Buffer(4) {1,0x77,3,4})) {
			err("", zFFF, 0x001, 0, 0, bd08, Buffer(4) {1,0x77,3,4})
		}

		// Index of Package

		mf1a(pd0d)

		Index(pd0d, 1, Local0)
		Store(DerefOf(Local0), Local1)

		if (LNotEqual(Local1, 0x77)) {
			err("", zFFF, 0x002, 0, 0, Local1, 0x77)
		}
	}
