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
 * Bug 259:
 *
 * SUMMARY: _REG method execution during Load operator processing issue
 */

Name(B259, Buffer() {

    0x53,0x53,0x44,0x54,0xD1,0x00,0x00,0x00,  /* 00000000    "SSDT...." */
    0x02,0xE1,0x49,0x6E,0x74,0x65,0x6C,0x00,  /* 00000008    "..Intel." */
    0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00,  /* 00000010    "Many...." */
    0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
    0x11,0x10,0x06,0x20,0x5B,0x82,0x4B,0x0A,  /* 00000020    "... [.K." */
    0x41,0x55,0x58,0x44,0x5B,0x80,0x4F,0x50,  /* 00000028    "AUXD[.OP" */
    0x52,0x30,0x80,0x0A,0x00,0x0A,0x04,0x5B,  /* 00000030    "R0.....[" */
    0x81,0x0B,0x4F,0x50,0x52,0x30,0x03,0x52,  /* 00000038    "..OPR0.R" */
    0x46,0x30,0x30,0x20,0x08,0x52,0x45,0x47,  /* 00000040    "F00 .REG" */
    0x43,0xFF,0x08,0x52,0x45,0x47,0x50,0x0A,  /* 00000048    "C..REGP." */
    0x00,0x14,0x33,0x5F,0x52,0x45,0x47,0x02,  /* 00000050    "..3_REG." */
    0x70,0x0D,0x5C,0x41,0x55,0x58,0x44,0x2E,  /* 00000058    "p.\AUXD." */
    0x5F,0x52,0x45,0x47,0x3A,0x00,0x5B,0x31,  /* 00000060    "_REG:.[1" */
    0x70,0x68,0x5B,0x31,0x70,0x69,0x5B,0x31,  /* 00000068    "ph[1pi[1" */
    0xA0,0x14,0x93,0x68,0x0A,0x80,0x70,0x52,  /* 00000070    "...h..pR" */
    0x45,0x47,0x43,0x52,0x45,0x47,0x50,0x70,  /* 00000078    "EGCREGPp" */
    0x69,0x52,0x45,0x47,0x43,0x14,0x4B,0x04,  /* 00000080    "iREGC.K." */
    0x41,0x43,0x43,0x30,0x00,0x70,0x0D,0x5C,  /* 00000088    "ACC0.p.\" */
    0x41,0x55,0x58,0x44,0x2E,0x41,0x43,0x43,  /* 00000090    "AUXD.ACC" */
    0x30,0x3A,0x00,0x5B,0x31,0x70,0x52,0x46,  /* 00000098    "0:.[1pRF" */
    0x30,0x30,0x5B,0x31,0x70,0x52,0x45,0x47,  /* 000000A0    "00[1pREG" */
    0x50,0x5B,0x31,0xA0,0x25,0x92,0x93,0x52,  /* 000000A8    "P[1.%..R" */
    0x45,0x47,0x43,0x0A,0x01,0x70,0x0D,0x45,  /* 000000B0    "EGC..p.E" */
    0x72,0x72,0x6F,0x72,0x3A,0x20,0x52,0x45,  /* 000000B8    "rror: RE" */
    0x47,0x43,0x20,0x21,0x3D,0x20,0x31,0x00,  /* 000000C0    "GC != 1." */
    0x5B,0x31,0x70,0x52,0x45,0x47,0x43,0x5B,  /* 000000C8    "[1pREGC[" */
    0x31,
})

Name (H259, 0)

OperationRegion (R259, SystemMemory, 0, 0xD1)

Field(R259, ByteAcc, NoLock, Preserve) {
	F259, 0x688,
}

Method(m17f)
{
	External(\AUXD.REGC)

	Store(B259, F259)

	if (CondRefof(\AUXD, Local0)) {
		err("", zFFF, 0x000, 0, 0, "\\AUXD", 1)
		return
	}

	if (CH03("", 0, 0x001, 0, 0)) {
		return
	}

	Load(R259, H259)

	if (CH03("", 0, 0x002, 0, 0)) {
		return
	}

	if (CondRefof(\AUXD, Local0)) {
	} else {
		err("", zFFF, 0x003, 0, 0, "\\AUXD", 0)
		return
	}

	Store (ObjectType(Local0), Local1)

	if (LNotEqual(Local1, 6)) {
		err("", zFFF, 0x004, 0, 0, Local1, 6)
		return
	}

	Store(\AUXD.REGC, Local0)
	if (LNotEqual(Local0, 1)) {
		err("", zFFF, 0x005, 0, 0, Local0, 1)
		return
	}

	UnLoad(H259)

	if (CondRefof(\AUXD, Local0)) {
		err("", zFFF, 0x006, 0, 0, "\\AUXD", 1)
	}
}
