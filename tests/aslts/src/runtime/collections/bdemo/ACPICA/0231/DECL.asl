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
 * Bug 231:
 *
 * SUMMARY: ParameterTypes argument of Method declaration is not supported
 */

Method(m128,, Serialized)
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

	Method(m000, 1, , , , IntObj) {
		Store(arg0, Debug)
	}

	Method(m100)
	{
		Store("Start of test", Debug)

		m000(i000)
		m000(s000)
		m000(b000)
		m000(p000)
		m000(e000)
		m000(mx00)
		m000(d000)
		m000(tz00)
		m000(pr00)
		m000(r900)
		m000(pw90)
		m000(bf90)
		m000(f900)
		m000(bn90)
		m000(if90)
		m000(mmm0)
		m000(0xfe7cb391d65a0000)
		m000("12340002")
		m000(Buffer() {1,2,3,4})
		m000(Package() {1,2,3,4})

		Store("Finish of test", Debug)
	}

	CH03("", 0, 0x000, 0, 0)
	m100()

	/* Expect either ASL compiler error or any AML interpreter exception */

	CH04("", 0, 0xff, 0, 0x001, 0, 0)
}
