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
 * Bug 139:
 *
 * SUMMARY: DeRefof and Store operations on 64-bit Integers of 32-bit AML table has been loaded modify them
 *
 * ROOT CAUSE
 */

	Method(mf2a)
	{
		if (LNotEqual(id1b, 0xfedcba9876543210)) {
			err("", zFFF, 0x000, 0, 0, id1b, 0xfedcba9876543210)
		} else {
			Store("Ok, initially id1b = 0xfedcba9876543210", Debug)

			Store("Store(id1b, Local0)" , Debug)

			Store(id1b, Local0)

			if (LNotEqual(id1b, 0xfedcba9876543210)) {
				err("", zFFF, 0x001, 0, 0, id1b, 0xfedcba9876543210)
			}
		}
	}

	Method(mf2b)
	{
		Store("Store(Refof(id1c), Local0)" , Debug)
		Store(Refof(id1c), Local0)

		if (LNotEqual(id1c, 0xfedcba9876543211)) {
			err("", zFFF, 0x002, 0, 0, id1c, 0xfedcba9876543211)
		} else {
			Store("Ok, initially id1c = 0xfedcba9876543211", Debug)

			Store("DeRefof(Local0)" , Debug)

			Store(DeRefof(Local0), Local1)

			if (LNotEqual(id1c, 0xfedcba9876543211)) {
				err("", zFFF, 0x003, 0, 0, id1c, 0xfedcba9876543211)
			}
		}
	}
