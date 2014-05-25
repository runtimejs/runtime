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
 * Bug 261:
 *
 * SUMMARY: Crash when DDBHandle parameter of Load is an Indexed Reference
 */

Method(m028,, Serialized)
{
	Name(BUF0, Buffer() {

	0x53,0x53,0x44,0x54,0x4D,0x00,0x00,0x00,  /* 00000000    "SSDTM..." */
	0x02,0x95,0x49,0x6E,0x74,0x65,0x6C,0x00,  /* 00000008    "..Intel." */
	0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00,  /* 00000010    "Many...." */
	0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
	0x02,0x11,0x06,0x20,0x5B,0x82,0x1C,0x41,  /* 00000020    "... [..A" */
	0x55,0x58,0x44,0x14,0x16,0x4D,0x30,0x30,  /* 00000028    "UXD..M00" */
	0x30,0x00,0x70,0x0D,0x5C,0x41,0x55,0x58,  /* 00000030    "0.p.\AUX" */
	0x44,0x2E,0x4D,0x30,0x30,0x30,0x3A,0x00,  /* 00000038    "D.M000:." */
	0x5B,0x31,0x10,0x0A,0x5C,0x00,0x08,0x45,  /* 00000040    "[1..\..E" */
	0x58,0x53,0x54,0x0A,0x02,
	})

	OperationRegion (IST0, SystemMemory, 0, 0x4D)

	Field(IST0, ByteAcc, NoLock, Preserve) {
		RFU0, 0x268,
	}

	External(\AUXZ)

	Method(m000,, Serialized)
	{
		Name(PAC0, Package(1){})

		CH03("", 0, 0x000, 0, 0)

		Store(BUF0, RFU0)

		if (CondRefof(\AUXZ, Local0)) {
			err("", zFFF, 0x001, 0, 0, Local0, 0x1777777)
			return
		}

		Load(RFU0, Index(PAC0, 0))

		Store("SSDT loaded", Debug)

		if (CondRefof(\AUXZ, Local0)) {
		} else {
			err("", zFFF, 0x002, 0, 0, Local0, 0x1777777)
			return
		}

		Store(ObjectType(Index(PAC0, 0)), Local1)
		if (LNotEqual(Local1, 15)) {
			Store(Local1, Debug)
			err("", zFFF, 0x003, 0, 0, Local0, 0x1777777)
			return
		}

		UnLoad(Derefof(Index(PAC0, 0)))

		Store("SSDT unloaded", Debug)

		if (CondRefof(\AUXZ, Local0)) {
			err("", zFFF, 0x004, 0, 0, Local0, 0x1777777)
		}

		CH03("", 0, 0x005, 0, 0)

		return
	}

	m000()
}

