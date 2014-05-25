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
 * Bug 128:
 *
 * SUMMARY: Copying the RefOf reference to Named object spoils that reference
 */

Method(mf17,, Serialized)
{
	Name(i000, 0x1234)

	CopyObject(RefOf(i000), Local0)
	Store(Local0, Debug)
	Store(DerefOf(Local0), Local1)
	Store(Local1, Debug)
	if (LNotEqual(Local1, 0x1234)) {
		err("", zFFF, 0x000, 0, 0, Local1, 0x1234)
	}
}

Method(mf18,, Serialized)
{
	Name(ref0, 0)
	Name(i000, 0x1234)

	CH03("", 0, 0x000, 0, 0)

	CopyObject(RefOf(i000), ref0)
	Store("Before printing ref0", Debug)
	Store(ref0, Debug)
	Store("Before DerefOf", Debug)
	Store(DerefOf(ref0), Local1)
	Store("Before printing Local1", Debug)
	Store(Local1, Debug)
	Store("Before LNotEqual", Debug)

	if (LNotEqual(Local1, 0x1234)) {
		err("", zFFF, 0x001, 0, 0, Local1, 0x1234)
	}

	CH03("", 0, 0x002, 0, 0)
}

Method(mf9e,, Serialized)
{
	Name(i000, 0xabbc0000)
	Name(ii00, 0xabbc0000)
	Name(b000, Buffer(){ 1, 2, 3, 4, 0x95, 6, 7, 8})
	Name(bb00, Buffer(){ 1, 2, 3, 4, 0x95, 6, 7, 8})
	Name(s000, "String")
	Name(ss00, "String")

	Name(p000, Package() {1,2,3,4})

	Name(ref0, 0)

	CH03("", 0, 0x000, 0, 0)

	CopyObject(RefOf(i000), ref0)
	mf88(DerefOf(ref0), c009, ii00, 1, 2, 1)

	CopyObject(RefOf(b000), ref0)
	mf88(DerefOf(ref0), c00b, bb00, 3, 4, 1)

	CopyObject(RefOf(s000), ref0)
	mf88(DerefOf(ref0), c00a, ss00, 3, 4, 1)

	CopyObject(RefOf(p000), ref0)
	mf88(DerefOf(ref0), c00c, ss00, 5, 6, 0)

	CH03("", 0, 0x007, 0, 0)
}

Method(mf9f,, Serialized)
{
	Name(ref0, 0)

	Event(e000)
	Mutex(mx00, 0)
	Device(d000) { Name(i900, 0xabcd0017) }
	ThermalZone(tz00) {}
	Processor(pr00, 0, 0xFFFFFFFF, 0) {}
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	PowerResource(pw00, 1, 0) {Method(mmmm){return (0)}}

	// Checkings

	CH03("", 0, 0x026, 0, 0)
	CopyObject(RefOf(e000), ref0)
	mf88(DerefOf(ref0), c00f, 0, 0x027, 0x028, 0)

	CH03("", 0, 0x029, 0, 0)
	CopyObject(RefOf(mx00), ref0)
	mf88(DerefOf(ref0), c011, 0, 0x02a, 0x02b, 0)

	if (y511) {
		CH03("", 0, 0x02c, 0, 0)
		CopyObject(RefOf(d000), ref0)
		mf88(DerefOf(ref0), c00e, 0, 0x02d, 0x02e, 0)
	}

	if (y508) {
		CH03("", 0, 0x02f, 0, 0)
		CopyObject(RefOf(tz00), ref0)
		mf88(DerefOf(ref0), c015, 0, 0x030, 0x031, 0)
	}

	CH03("", 0, 0x032, 0, 0)
	CopyObject(RefOf(pr00), ref0)
	mf88(DerefOf(ref0), c014, 0, 0x033, 0x034, 0)

	CH03("", 0, 0x035, 0, 0)
	CopyObject(RefOf(r000), ref0)
	mf88(DerefOf(ref0), c012, 0, 0x036, 0x037, 0)

	CH03("", 0, 0x038, 0, 0)
	CopyObject(RefOf(pw00), ref0)
	mf88(DerefOf(ref0), c013, 0, 0x039, 0x03a, 0)
}


