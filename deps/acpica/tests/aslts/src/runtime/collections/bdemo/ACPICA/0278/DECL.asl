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
 * Bug 278:
 *
 * SUMMARY: "Namespace location to be relative" functionality of Load operator issue
 */

Device (D278) {
	Name(SSDT, Buffer(0x30){
		0x53,0x53,0x44,0x54,0x5F,0x00,0x00,0x00,  /* 00000000    "SSDT_..." */
		0x02,0x2D,0x49,0x6E,0x74,0x65,0x6C,0x00,  /* 00000008    "..Intel." */
		0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00,  /* 00000010    "Many...." */
		0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
		0x15,0x12,0x06,0x20,0x10,0x1F,0x5C,0x00,  /* 00000020    "... ..\." */
		0x08,0x4E,0x41,0x42,0x53,0x0D,0x61,0x62,  /* 00000028    ".NABS.ab" */
		0x73,0x6F,0x6C,0x75,0x74,0x65,0x20,0x6C,  /* 00000030    "solute l" */
		0x6F,0x63,0x61,0x74,0x69,0x6F,0x6E,0x20,  /* 00000038    "ocation " */
		0x6F,0x62,0x6A,0x00,0x08,0x4E,0x43,0x52,  /* 00000040    "obj..NCR" */
		0x52,0x0D,0x63,0x75,0x72,0x72,0x65,0x6E,  /* 00000048    "R.curren" */
		0x74,0x20,0x6C,0x6F,0x63,0x61,0x74,0x69,  /* 00000050    "t locati" */
		0x6F,0x6E,0x20,0x6F,0x62,0x6A,0x00,
	})

	OperationRegion (IST0, SystemMemory, 0, 0x5f)

	Field(IST0, ByteAcc, NoLock, Preserve) {
		RFU0, 0x2f8,
	}

	Name(DDBH, 0)

	Method(TST0)
	{
		// Check absence
		if (CondRefof(NABS, Local0)) {
			err("", zFFF, 0x001, 0, 0, "NABS", 1)
		}
		if (CondRefof(NCRR, Local0)) {
			err("", zFFF, 0x002, 0, 0, "NCRR", 1)
		}

		Store(SSDT, RFU0)
		Load(RFU0, DDBH)
		Store("SSDT loaded", Debug)

		// Check existence
		if (CondRefof(NABS, Local0)) {
			if (LNotEqual("absolute location obj", Derefof(Local0))) {
				err("", zFFF, 0x003, 0, 0, "absolute location NABS", 1)
			}
		} else {
			err("", zFFF, 0x004, 0, 0, "NABS", 0)
		}
		if (CondRefof(NCRR, Local0)) {
			if (LNotEqual("current location obj", Derefof(Local0))) {
				err("", zFFF, 0x005, 0, 0, "current location NCRR", 1)
			}
		} else {
			err("", zFFF, 0x006, 0, 0, "NCRR", 0)
		}

		// Check location
		if (CondRefof(\NABS, Local0)) {
		} else {
			err("", zFFF, 0x007, 0, 0, "\\NABS", 0)
		}
		if (CondRefof(\NCRR, Local0)) {
			err("", zFFF, 0x008, 0, 0, "\\NCRR", 1)
		}
		if (CondRefof(\D278.NCRR, Local0)) {
			err("", zFFF, 0x009, 0, 0, "\\D278.NCRR", 1)
		}
		if (CondRefof(\D278.TST0.NCRR, Local0)) {
		} else {
			err("", zFFF, 0x00a, 0, 0, "\\D278.TST0.NCRR", 0)
		}

		UnLoad(DDBH)
		Store("SSDT unloaded", Debug)

		// Check absence
		if (CondRefof(NABS, Local0)) {
			err("", zFFF, 0x00b, 0, 0, "NABS", 1)
		}
		if (CondRefof(NCRR, Local0)) {
			err("", zFFF, 0x00c, 0, 0, "NCRR", 1)
		}
	}
}

Method(m278)
{
	\D278.TST0()
}
