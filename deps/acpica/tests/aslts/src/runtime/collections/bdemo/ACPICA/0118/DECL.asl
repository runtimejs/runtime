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
 * Bug 118:
 *
 * SUMMARY: Access to FieldObject element of Package causes exception
 *
 * EXAMPLES:
 *
 * ROOT CAUSE:
 *
 * SEE ALSO:     bugs 65,66,67,68,118
 */

// Access to the named Integer object as an element of Package

Method(mf80,, Serialized)
{
	Name(i000, 0xaaaa0000)
	Name(p000, Package() {i000})

	Store(0xaaaa0100, i000)

	Store(Index(p000, 0), Local0)

	Store(0xaaaa0200, i000)

	Store(DerefOf(Local0), Local1)

	Store(0xaaaa0300, i000)

	Store(ObjectType(i000), Local2)
	Store(ObjectType(Local0), Local3)
	Store(ObjectType(Local1), Local4)

	Add(Local1, 0x079, Local5)

	if (LNotEqual(Local4, c009)) {
		err("", zFFF, 0x000, 0, 0, Local4, c009)
	} elseif (LNotEqual(Local5, 0xaaaa0279)) {
		err("", zFFF, 0x001, 0, 0, Local5, 0xaaaa0279)
	}

	if (LNotEqual(i000, 0xaaaa0300)) {
		err("", zFFF, 0x002, 0, 0, i000, 0xaaaa0300)
	}

	if (LNotEqual(Local2, c009)) {
		err("", zFFF, 0x003, 0, 0, Local2, c009)
	}

	if (LNotEqual(Local3, c009)) {
		err("", zFFF, 0x004, 0, 0, Local3, c009)
	}

	CH03("", 0, 0x005, 0, 0)
	Add(Local0, 0x079, Local5)
	CH04("", 0, 47, 0, 0x006, 0, 0) // AE_AML_OPERAND_TYPE
}

Method(mf81,, Serialized)
{
	Name(ii00, 0)
	Name(ii01, 0)
	Name(ii02, 0)
	Name(ii03, 0)
	Name(ii04, 0)
	Name(ii05, 0)

	Name(i000, 0xaaaa0000)
	Name(p000, Package() {i000})

	Store(0xaaaa0100, i000)

//	Store(Index(p000, 0), ii00)
//	CopyObject(Index(p000, 0), ii00)
	Store(Index(p000, 0), Local0)

	Store(0xaaaa0200, i000)

	Store(DerefOf(Local0), ii01)

	Store(0xaaaa0300, i000)

	Store(ObjectType(i000), ii02)
	Store(ObjectType(Local0), ii03)
	Store(ObjectType(ii01), ii04)

	Add(ii01, 0x079, ii05)

	if (LNotEqual(ii04, c009)) {
		err("", zFFF, 0x007, 0, 0, ii04, c009)
	} elseif (LNotEqual(ii05, 0xaaaa0279)) {
		err("", zFFF, 0x008, 0, 0, ii05, 0xaaaa0279)
	}

	if (LNotEqual(i000, 0xaaaa0300)) {
		err("", zFFF, 0x009, 0, 0, i000, 0xaaaa0300)
	}

	if (LNotEqual(ii02, c009)) {
		err("", zFFF, 0x00a, 0, 0, ii02, c009)
	}

	if (LNotEqual(ii03, c009)) {
		err("", zFFF, 0x00b, 0, 0, ii03, c009)
	}

	CH03("", 0, 0x00c, 0, 0)
	Add(Local0, 0x079, ii05)
	CH04("", 0, 47, 0, 0x00d, 0, 0) // AE_AML_OPERAND_TYPE
}

Method(mf82,, Serialized)
{
	Name(ii00, 0)
	Name(ii01, 0)
	Name(ii02, 0)
	Name(ii03, 0)
	Name(ii04, 0)
	Name(ii05, 0)

	Name(i000, 0xaaaa0000)
	Name(p000, Package() {i000})

	Store(0xaaaa0100, i000)

	CopyObject(Index(p000, 0), ii00)

	Store(0xaaaa0200, i000)

	Store(DerefOf(ii00), ii01)

	Store(0xaaaa0300, i000)

	Store(ObjectType(i000), ii02)
	Store(ObjectType(ii00), ii03)
	Store(ObjectType(ii01), ii04)

	Add(ii01, 0x079, ii05)

	if (LNotEqual(ii04, c009)) {
		err("", zFFF, 0x00e, 0, 0, ii04, c009)
	} elseif (LNotEqual(ii05, 0xaaaa0279)) {
		err("", zFFF, 0x00f, 0, 0, ii05, 0xaaaa0279)
	}

	if (LNotEqual(i000, 0xaaaa0300)) {
		err("", zFFF, 0x010, 0, 0, i000, 0xaaaa0300)
	}

	if (LNotEqual(ii02, c009)) {
		err("", zFFF, 0x011, 0, 0, ii02, c009)
	}

	if (LNotEqual(ii03, c009)) {
		err("", zFFF, 0x012, 0, 0, ii03, c009)
	}

	CH03("", 0, 0x013, 0, 0)
	Add(ii00, 0x079, ii05)
	CH04("", 0, 47, 0, 0x014, 0, 0) // AE_AML_OPERAND_TYPE
}

Method(md79)
{
	Store(Index(pd0a, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local0)

	if (LNotEqual(Local0, c009)) {
		err("", zFFF, 0x000, 0, 0, Local0, c009)
	} else {
		if (LNotEqual(Local1, 0xfe7cb391d650a284)) {
			err("", zFFF, 0x001, 0, 0, Local1, 0xfe7cb391d650a284)
		}
	}
}

// Access to the Buffer Field object as an element of Package

Method(md7a)
{
	Store(Index(pd0b, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local0)

	if (LNotEqual(Local0, c016)) {
		err("", zFFF, 0x002, 0, 0, Local0, c016)
	} else {
Store("=======================================", Debug)
Store(Local1, Debug)
Store(bfd1, Debug)
Store(Local1, Local0)
Store(Local0, Debug)
Store("=======================================", Debug)
if (1) {
		if (LNotEqual(Local1, 0x59)) {
			err("", zFFF, 0x003, 0, 0, Local1, 0x59)
		}
}
	}
}

// Access to the Field Unit object as an element of Package

Method(md7b)
{
	Store(Index(pd0c, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local0)

	if (LNotEqual(Local0, c00d)) {
		err("", zFFF, 0x004, 0, 0, Local0, c00d)
	} else {

Store("=======================================", Debug)
Store(Local1, Debug)
Store(fd03, Debug)
Store(Local1, Local0)
Store(Local0, Debug)
Store("=======================================", Debug)
if (1) {
		if (LNotEqual(Local1, 0)) {
			err("", zFFF, 0x005, 0, 0, Local1, 0)
		}
}
	}
}

Method(md7c)
{
	// Named Integer object as an element of Package

/*
	SRMT("mf80")
	mf80()

	SRMT("mf81")
	mf81()

	SRMT("mf82")
	if (y127) {
		mf82()
	} else {
		BLCK()
	}

	SRMT("md79")
	md79()
*/


	SRMT("md7a")
	md7a()

	SRMT("md7b")
	md7b()
}
