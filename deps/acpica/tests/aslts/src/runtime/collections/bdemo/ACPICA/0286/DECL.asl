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
 * Bug 286:
 *
 * SUMMARY: After an exception the elements of the Package passed to Unload
 *          are unexpectedly deleted
 */

Device (D286) {

	Name(BUF3, Buffer(){
		0x53,0x53,0x44,0x54,0x58,0x00,0x00,0x00,  /* 00000000    "SSDTX..." */
		0x02,0xD4,0x49,0x6E,0x74,0x65,0x6C,0x00,  /* 00000008    "..Intel." */
		0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00,  /* 00000010    "Many...." */
		0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
		0x15,0x12,0x06,0x20,0x5B,0x82,0x32,0x41,  /* 00000020    "... [.2A" */
		0x55,0x58,0x44,0x08,0x50,0x41,0x43,0x30,  /* 00000028    "UXD.PAC0" */
		0x12,0x27,0x03,0x0E,0x1F,0x32,0x54,0x76,  /* 00000030    ".'...2Tv" */
		0x98,0xBA,0xDC,0xFE,0x0D,0x74,0x65,0x73,  /* 00000038    ".....tes" */
		0x74,0x20,0x70,0x61,0x63,0x6B,0x61,0x67,  /* 00000040    "t packag" */
		0x65,0x30,0x00,0x11,0x0C,0x0A,0x09,0x13,  /* 00000048    "e0......" */
		0x12,0x11,0x10,0x0F,0x0E,0x0D,0x0C,0x0B,  /* 00000050    "........" */
	})

	OperationRegion (IST3, SystemMemory, 0x400, 0x58)

	Field(IST3, ByteAcc, NoLock, Preserve) {
		RFU3, 0x2c0,
	}

	Method(m000, 1)
	{
		Unload(Derefof(arg0))
	}

	Method(TST0,, Serialized)
	{
		Name(DDB0, 0)

		External(\AUXD.PAC0)

		Store(BUF3, RFU3)
		Load(RFU3, DDB0)

		m000(Refof(\AUXD.PAC0))

		CH04("", 0, 0xff, 0, 0x001, 0, 0)

		Store(Derefof(Index(\AUXD.PAC0, 0)), Debug)
		CH03("", 0, 0x002, 0, 0)

		Unload(DDB0)
		CH03("", 0, 0x003, 0, 0)
	}
}

Method(m286)
{
	\D286.TST0()
}
