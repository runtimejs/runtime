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
 * Bug 161:
 *
 * SUMMARY: Named object passed as a BitIndex or NumBits to CreateField causes hang
 *
 * ROOT CAUSE
 */

// Global CreateField declarations

Method(md8f)
{
	if (LNotEqual(bf32, 0x14)) {
		err("", zFFF, 0x000, 0, 0, bf32, 0x14)
	}
	if (LNotEqual(bf33, 0x1615)) {
		err("", zFFF, 0x001, 0, 0, bf33, 0x1615)
	}
}

Method(md90)
{
	if (LNotEqual(bf34, 0x18)) {
		err("", zFFF, 0x002, 0, 0, bf34, 0x18)
	}
	if (LNotEqual(bf35, 0x19)) {
		err("", zFFF, 0x003, 0, 0, bf35, 0x19)
	}
}

Method(md91)
{
	if (LNotEqual(bf36, 0x1a)) {
		err("", zFFF, 0x004, 0, 0, bf36, 0x1a)
	}
	if (LNotEqual(bf37, 0x1c1b)) {
		err("", zFFF, 0x005, 0, 0, bf37, 0x1c1b)
	}
}

// Local CreateField declarations, another buffer than used in md8f-md91

Method(md92)
{
	CreateField(bd02, 32, id03, bf32)
	CreateField(bd02, 40, Add(id03, 8), bf33)

	if (LNotEqual(bf32, 0x14)) {
		err("", zFFF, 0x006, 0, 0, bf32, 0x14)
	}
	if (LNotEqual(bf33, 0x1615)) {
		err("", zFFF, 0x007, 0, 0, bf33, 0x1615)
	}
}

Method(md93)
{
	CreateField(bd02, id04, 8, bf34)
	CreateField(bd02, Add(id04, 8), 8, bf35)

	if (LNotEqual(bf34, 0x18)) {
		err("", zFFF, 0x008, 0, 0, bf34, 0x18)
	}
	if (LNotEqual(bf35, 0x19)) {
		err("", zFFF, 0x009, 0, 0, bf35, 0x19)
	}
}

Method(md94)
{
	CreateField(bd02, id05, id06, bf36)
	CreateField(bd02, Add(id07, 8), Add(id08, 8), bf37)

	if (LNotEqual(bf36, 0x1a)) {
		err("", zFFF, 0x00a, 0, 0, bf36, 0x1a)
	}
	if (LNotEqual(bf37, 0x1c1b)) {
		err("", zFFF, 0x00b, 0, 0, bf37, 0x1c1b)
	}
}

// Local CreateField declarations, the same buffer that used in md8f-md91

Method(md95)
{
	CreateField(bd03, 32, id03, bf32)
	CreateField(bd03, 40, Add(id03, 8), bf33)

	if (LNotEqual(bf32, 0x14)) {
		err("", zFFF, 0x00c, 0, 0, bf32, 0x14)
	}
	if (LNotEqual(bf33, 0x1615)) {
		err("", zFFF, 0x00d, 0, 0, bf33, 0x1615)
	}
}

Method(md96)
{
	CreateField(bd03, id04, 8, bf34)
	CreateField(bd03, Add(id04, 8), 8, bf35)

	if (LNotEqual(bf34, 0x18)) {
		err("", zFFF, 0x00e, 0, 0, bf34, 0x18)
	}
	if (LNotEqual(bf35, 0x19)) {
		err("", zFFF, 0x00f, 0, 0, bf35, 0x19)
	}
}

Method(md97)
{
	CreateField(bd03, id05, id06, bf36)
	CreateField(bd03, Add(id07, 8), Add(id08, 8), bf37)

	if (LNotEqual(bf36, 0x1a)) {
		err("", zFFF, 0x010, 0, 0, bf36, 0x1a)
	}
	if (LNotEqual(bf37, 0x1c1b)) {
		err("", zFFF, 0x011, 0, 0, bf37, 0x1c1b)
	}
}

Method(m075, 6, Serialized)
{
	Name(b000, Buffer() {0x5D, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18})

	if (LNotEqual(arg0, 1)) {
		err("", zFFF, 0x012, 0, 0, arg0, 1)
	}
	if (LNotEqual(arg1, 0x5d)) {
		err("", zFFF, 0x013, 0, 0, arg1, 0x5d)
	}
	if (LNotEqual(arg2, 0x125D)) {
		err("", zFFF, 0x014, 0, 0, arg2, 0x125D)
	}
	if (LNotEqual(arg3, 0x1413125D)) {
		err("", zFFF, 0x015, 0, 0, arg3, 0x1413125D)
	}

	if (F64) {
		if (LNotEqual(arg4, 0x181716151413125D)) {
			err("", zFFF, 0x016, 0, 0, arg4, 0x181716151413125D)
		}
	} else {
		if (LNotEqual(arg4, b000)) {
			err("", zFFF, 0x016, 0, 0, arg4, b000)
		}
	}

	if (LNotEqual(arg5, 0x5d)) {
		err("", zFFF, 0x017, 0, 0, arg5, 0x5d)
	}
}

Method(m076, 2)
{
	if (LNotEqual(arg0, 0x5d)) {
		err("", zFFF, 0x018, 0, 0, arg0, 0x5d)
	}
	if (LNotEqual(arg1, 0x5d)) {
		err("", zFFF, 0x019, 0, 0, arg1, 0x5d)
	}
}

Method(md98)
{
	md8f()
	md90()
	md91()
	md92()
	md93()
	md94()
	md95()
	md96()
	md97()
}

Method(mf7f)
{
	SRMT("mf7f-0")
	m075(bf40, bf41, bf42, bf43, bf44, bf45)

	SRMT("mf7f-1")
	m075(bf46, bf47, bf48, bf49, bf4a, bf4b)
	m076(bf4c, bf4d)
}

Method(m077,, Serialized)
{
	CreateBitField(bd03, 8, bf40)
	CreateByteField(bd03, 1, bf41)
	CreateWordField(bd03, 1, bf42)
	CreateDWordField(bd03, 1, bf43)
	CreateQWordField(bd03, 1, bf44)
	CreateField(bd03, 8, 8, bf45)

	Name(id21, 1)
	Name(id22, 8)

	CreateBitField(bd03, id22, bf46)
	CreateByteField(bd03, id21, bf47)
	CreateWordField(bd03, id21, bf48)
	CreateDWordField(bd03, id21, bf49)
	CreateQWordField(bd03, id21, bf4a)
	CreateField(bd03, 8, id22, bf4b)
	CreateField(bd03, id22, 8, bf4c)
	CreateField(bd03, id22, id22, bf4d)

	SRMT("m077-0")
	m075(bf40, bf41, bf42, bf43, bf44, bf45)

	SRMT("m077-1")
	m075(bf46, bf47, bf48, bf49, bf4a, bf4b)
	m076(bf4c, bf4d)
}

Method(mf83)
{
	Store(1, Local0)
	Store(8, Local1)

	CreateBitField(bd03, Local1, bf46)
	CreateByteField(bd03, Local0, bf47)
	CreateWordField(bd03, Local0, bf48)
	CreateDWordField(bd03, Local0, bf49)
	CreateQWordField(bd03, Local0, bf4a)
	CreateField(bd03, 8, Local1, bf4b)
	CreateField(bd03, Local1, 8, bf4c)
	CreateField(bd03, Local1, Local1, bf4d)

	SRMT("mf83")
	m075(bf46, bf47, bf48, bf49, bf4a, bf4b)
	m076(bf4c, bf4d)
}

Method(mf84, 2)
{
	CreateBitField(bd03, Arg1, bf46)
	CreateByteField(bd03, Arg0, bf47)
	CreateWordField(bd03, Arg0, bf48)
	CreateDWordField(bd03, Arg0, bf49)
	CreateQWordField(bd03, Arg0, bf4a)
	CreateField(bd03, 8, Arg1, bf4b)
	CreateField(bd03, Arg1, 8, bf4c)
	CreateField(bd03, Arg1, Arg1, bf4d)

	SRMT("mf84")
	m075(bf46, bf47, bf48, bf49, bf4a, bf4b)
	m076(bf4c, bf4d)
}


