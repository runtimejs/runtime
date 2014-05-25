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
 * Bug 200 (local-bugzilla-352):
 *
 * SUMMARY: the code path taken after exception is incorrect
 *
 * AcpiPsParseLoop --> AcpiDsGetPredicateValue --> FAILURE -->>
 * doesn't fall into AcpiDsMethodError routine after FAILURE (exception)
 * (the ASLTS-testing stops after these FAILUREs).
 */


Method(mfb4)
{
	Store("Message from mfb4 -------------------------------!!!", Debug)
}

Method(mfb5)
{
	Store(0, Local7)
	Divide(1, Local7, Local2)
	if (LNotEqual(Local2, 0)) {
		mfb4()
	}
}

Method(mfb6)
{
	Store(0, Local7)
	Divide(1, Local7, Local2)
	if (LNotEqual(Local2, 0)) {
		Store("Message 0 !!!!!!!!!!!!!!!!!!!!!!", Debug)
		mfb4()
	}
}

Method(mfb7)
{
	Store(0, Local7)
	Divide(1, Local7, Local2)
}

Method(mfb8)
{
	Store(0, Local7)
	Divide(1, Local7, Local2)
	while (LNotEqual(Local2, 0)) {
		mfb4()
		break
	}
}

Method(mfb9)
{
	Store(0, Local7)
	Divide(1, Local7, Local2)
	while (LNotEqual(Local2, 0)) {
		Store("Message 1 !!!!!!!!!!!!!!!!!!!!!!", Debug)
		mfb4()
		break
	}
}

Method(mfba, 0, Serialized)
{
	Store(0, Local7)
	Divide(1, Local7, Local2)
	switch (LNotEqual(Local2, 0)) {
		case (0)
		{
			mfb4()
		}
	}
}

Method(mfbb, 0, Serialized)
{
	Store(0, Local7)
	Divide(1, Local7, Local2)
	switch (LNotEqual(Local2, 0)) {
		case (0)
		{
			Store("Message 2 !!!!!!!!!!!!!!!!!!!!!!", Debug)
			mfb4()
		}
	}
}

Method(mfbc)
{
	Store(0, Local7)
	Divide(1, Local7, Local2)
	Return (Local2)
}

Method(mfbd)
{
	if (mfbc()) {
		Store("Message 3 !!!!!!!!!!!!!!!!!!!!!!", Debug)
	}
}

Method(mfbe)
{
	while (mfbc()) {
		break
	}
}

Method(mfbf, 0, Serialized)
{
	switch (ToInteger (mfbc())) {
		case (0)
		{
			Store("Message 4 !!!!!!!!!!!!!!!!!!!!!!", Debug)
		}
	}
}

Method(mfc0)
{
	/*
	 * The code path taken after the exception here
	 * is not correct for each of these Method calls:
	 */

	SRMT("mfb5")
	if (y200) {
		CH03("", 0, 0x000, 0, 0)
		mfb5()
		CH04("", 0, 0xff, 0, 0x001, 0, 0)
	} else {
		BLCK()
	}

	SRMT("mfbd")
	if (y200) {
		CH03("", 0, 0x002, 0, 0)
		mfbd()
		CH04("", 0, 0xff, 0, 0x003, 0, 0)
	} else {
		BLCK()
	}

	SRMT("mfbe")
	if (y200) {
		CH03("", 0, 0x004, 0, 0)
		mfbe()
		CH04("", 0, 0xff, 0, 0x005, 0, 0)
	} else {
		BLCK()
	}

	/*
	 * These work Ok:
	 */

	SRMT("mfb6")
	CH03("", 0, 0x006, 0, 0)
	mfb6()
	CH04("", 0, 0xff, 0, 0x007, 0, 0)

	SRMT("mfb7")
	CH03("", 0, 0x008, 0, 0)
	mfb7()
	CH04("", 0, 0xff, 0, 0x009, 0, 0)

	SRMT("mfb8")
	CH03("", 0, 0x00a, 0, 0)
	mfb8()
	CH04("", 0, 0xff, 0, 0x00b, 0, 0)

	SRMT("mfb9")
	CH03("", 0, 0x00c, 0, 0)
	mfb9()
	CH04("", 0, 0xff, 0, 0x00d, 0, 0)

	SRMT("mfba")
	CH03("", 0, 0x00e, 0, 0)
	mfba()
	CH04("", 0, 0xff, 0, 0x00f, 0, 0)

	SRMT("mfbb")
	CH03("", 0, 0x010, 0, 0)
	mfbb()
	CH04("", 0, 0xff, 0, 0x011, 0, 0)

	SRMT("mfbf")
	CH03("", 0, 0x012, 0, 0)
	mfbf()
	CH04("", 0, 0xff, 0, 0x013, 0, 0)

	Store("mfc0 ==== successfully returned to mfc0; finished !!!!!", Debug)
}

