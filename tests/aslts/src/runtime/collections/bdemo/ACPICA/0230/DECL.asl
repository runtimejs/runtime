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
 * Bug 230:
 *
 * SUMMARY: ReturnType argument of Method declaration is not supported
 */

Method(m127,, Serialized)
{
	/* Data to be passed to Method */

	Name(i000, 0xfe7cb391d65a0000)
	Name(s000, "12340002")
	Name(b000, Buffer() {1,2,3,4})
	Name(b001, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	Name(p000, Package() {1,2,3,4})

	Event(e000)
	Mutex(mx00, 0)
	Device(d000) { Name(i000, 0xabcd0017) }
	ThermalZone(tz00) {}
	Processor(pr00, 0, 0xFFFFFFFF, 0) {}
	OperationRegion(r900, SystemMemory, 0x100, 0x100)
	OperationRegion(r9Z0, SystemMemory, 0x100, 0x100)
	PowerResource(pw90, 1, 0) {Method(mmmm){return (0)}}

	CreateField(b001, 0, 8, bf90)
	Field(r9Z0, ByteAcc, NoLock, Preserve) {f900,8,f901,8,f902,8,f903,8}
	BankField(r9Z0, f901, 0, ByteAcc, NoLock, Preserve) {bn90,4}
	IndexField(f902, f903, ByteAcc, NoLock, Preserve) {if90,8,if91,8}

	Method(mmm0) {Return ("mmm0")}

	/* Method */

	Method(m000, , , , IntObj) { Return(i000) }
	Method(m001, , , , IntObj) { Return(s000) }
	Method(m002, , , , IntObj) { Return(b000) }
	Method(m003, , , , IntObj) { Return(p000) }
	Method(m004, , , , IntObj) { Return(e000) }
	Method(m005, , , , IntObj) { Return(mx00) }
	Method(m006, , , , IntObj) { Return(d000) }
	Method(m007, , , , IntObj) { Return(tz00) }
	Method(m008, , , , IntObj) { Return(pr00) }
	Method(m009, , , , IntObj) { Return(r900) }
	Method(m00a, , , , IntObj) { Return(pw90) }
	Method(m00b, , , , IntObj) { Return(bf90) }
	Method(m00c, , , , IntObj) { Return(f900) }
	Method(m00d, , , , IntObj) { Return(bn90) }
	Method(m00e, , , , IntObj) { Return(if90) }
	Method(m00f, , , , IntObj) { Return(mmm0) }
	Method(m010, , , , IntObj) { Return(0xfe7cb391d65a0000) }
	Method(m011, , , , IntObj) { Return("12340002") }
	Method(m012, , , , IntObj) { Return(Buffer() {1,2,3,4}) }
	Method(m013, , , , IntObj) { Return(Package() {1,2,3,4}) }

	Method(m100)
	{
		Store("Start of test", Debug)

		m000()
		m001()
		m002()
		m003()
		m004()
		m005()
		m006()
		m007()
		m008()
		m009()
		m00a()
		m00b()
		m00c()
		m00d()
		m00e()
		m00f()
		m010()
		m011()
		m012()
		m013()

		Store("Finish of test", Debug)
	}

	CH03("", 0, 0x000, 0, 0)
	m100()

	/* Expect either ASL compiler error or any AML interpreter exception */

	CH04("", 0, 0xff, 0, 0x001, 0, 0)
}
