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
 * Bug 64:
 *
 * SUMMARY: Specific operations should initiate AE_BAD_HEX_CONSTANT exceptions
 */


	Method(mf61, 1)
	{
		CH03("", 0, 0x000, 0, 0)
		Add("", 0xabcd0000, Local0)
		if (LNotEqual(Local0, 0xabcd0000)) {
			err("", zFFF, 0x001, 0, 0, Local0, 0xabcd0000)
		}
		CH03("", 0, 0x002, 0, 0)

		CH03("", 0, 0x003, 0, 0)
		Add("                      ", 0xabcd0001, Local0)
		if (LNotEqual(Local0, 0xabcd0001)) {
			err("", zFFF, 0x004, 0, 0, Local0, 0xabcd0001)
		}
		CH03("", 0, 0x005, 0, 0)

		CH03("", 0, 0x006, 0, 0)
		ToInteger("", Local0)
		CH04("", 0, 36, 0, 0x007, 0, 0) // AE_BAD_DECIMAL_CONSTANT

		CH03("", 0, 0x008, 0, 0)
		ToInteger("                 ", Local0)
		CH04("", 0, 36, 0, 0x009, 0, 0) // AE_BAD_DECIMAL_CONSTANT

		CH03("", 0, 0x00a, 0, 0)
		Add("q", 0xabcd0002, Local0)
		if (LNotEqual(Local0, 0xabcd0002)) {
			err("", zFFF, 0x00b, 0, 0, Local0, 0xabcd0002)
		}
		CH03("", 0, 0x00c, 0, 0)

		CH03("", 0, 0x00d, 0, 0)
		Add("q                      ", 0xabcd0003, Local0)
		if (LNotEqual(Local0, 0xabcd0003)) {
			err("", zFFF, 0x00e, 0, 0, Local0, 0xabcd0003)
		}
		CH03("", 0, 0x00f, 0, 0)

		CH03("", 0, 0x010, 0, 0)
		ToInteger("q", Local0)
		CH04("", 0, 36, 0, 0x011, 0, 0) // AE_BAD_DECIMAL_CONSTANT

		CH03("", 0, 0x012, 0, 0)
		ToInteger("q                 ", Local0)
		CH04("", 0, 36, 0, 0x013, 0, 0) // AE_BAD_DECIMAL_CONSTANT
	}
