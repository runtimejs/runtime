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
 * Bug 273:
 *
 * SUMMARY: Implementation of LoadTable operator should take into account its RootPathString parameter
 */

Name(SSDT, Buffer(0x30){
	0x4F,0x45,0x4D,0x31,0x38,0x00,0x00,0x00,  /* 00000000    "OEM18..." */
	0x01,0x4B,0x49,0x6E,0x74,0x65,0x6C,0x00,  /* 00000008    ".KIntel." */
	0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00,  /* 00000010    "Many...." */
	0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
	0x18,0x09,0x03,0x20,0x08,0x5F,0x58,0x54,  /* 00000020    "... ._XT" */
	0x32,0x0A,0x04,0x14,0x0C,0x5F,0x58,0x54,  /* 00000028    "2...._XT" */
	0x31,0x00,0x70,0x01,0x5F,0x58,0x54,0x32,  /* 00000030    "1.p._XT2" */
})

DataTableRegion (DR73, "OEM1", "", "")
Field(DR73, AnyAcc, NoLock, Preserve) {
	F273, 0x1C0}


Device(D273) {
	Name(s000, "D273")
}

Name(RPST, "\\D273")
Name(PLDT, 0)
Name(PPST, "\\PLDT")

External(\_XT2)
External(\D273._XT2)

Method(mc73,, Serialized)
{
	Name(DDBH, 0)

	Method(LD)
	{
		Store(LoadTable("OEM1", "", "", RPST, PPST, 1), DDBH)
		Store("OEM1 loaded", Debug)
	}

	Method(UNLD)
	{
		UnLoad(DDBH)
		Store("OEM1 unloaded", Debug)
	}

	if (LNotEqual(F273, SSDT)) {
		err("", zFFF, 0x001, 0, 0, F273, SSDT)
	}

	if (CondRefof(\_XT2, Local0)) {
		err("", zFFF, 0x002, 0, 0, "\\_XT2", 1)
	}

	if (CondRefof(\D273._XT2, Local0)) {
		err("", zFFF, 0x003, 0, 0, "\\D273._XT2", 1)
	}

	LD()

	if (CondRefof(\_XT2, Local0)) {
		err("", zFFF, 0x004, 0, 0, "\\_XT2", 1)
	}

	if (CondRefof(\D273._XT2, Local0)) {
	} else {
		err("", zFFF, 0x005, 0, 0, "\\D273._XT2", 0)
	}

	UNLD()

	if (CondRefof(\_XT2, Local0)) {
		err("", zFFF, 0x006, 0, 0, "\\_XT2", 1)
	}

	if (CondRefof(\D273._XT2, Local0)) {
		err("", zFFF, 0x007, 0, 0, "\\D273._XT2", 1)
	}
}
