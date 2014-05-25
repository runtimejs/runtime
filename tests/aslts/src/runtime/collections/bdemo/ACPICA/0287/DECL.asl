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
 * Bug 287:
 *
 * SUMMARY: If any string to match a proper field on LoadTable exceeds field's length
 *          an exception should be emitted
 */

Device (D287) {

	Name(PLDT, 0)

	Method(TST0)
	{
		// SignatureString is greater than four characters
		LoadTable("OEMXX", "", "", , "\\D287.PLDT", 1)

		CH04("", 0, 0xff, 0, 0x001, 0, 0)
		if (LNotEqual(PLDT, 0)) {
			err("", zFFF, 0x002, 0, 0, PLDT, 0)
			Return (1)
		}

		// OEMIDString is greater than six characters
		LoadTable("OEM1", "IntelXX", "", , "\\D287.PLDT", 1)

		CH04("", 0, 0xff, 0, 0x003, 0, 0)
		if (LNotEqual(PLDT, 0)) {
			err("", zFFF, 0x004, 0, 0, PLDT, 0)
			Return (1)
		}

		// OEMTableID is greater than eight characters
		LoadTable("OEM1", "", "ManyXXXXX", , "\\D287.PLDT", 1)

		CH04("", 0, 0xff, 0, 0x005, 0, 0)
		if (LNotEqual(PLDT, 0)) {
			err("", zFFF, 0x006, 0, 0, PLDT, 0)
			Return (1)
		}

		Return (0)
	}
}

Method(m287)
{
	\D287.TST0()
}
