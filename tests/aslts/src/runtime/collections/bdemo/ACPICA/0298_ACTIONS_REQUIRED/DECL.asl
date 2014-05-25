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
 * Bug 298:
 *
 * SUMMARY: AcpiExOpcode_XA_XT_XR routines assign addresses of released cache objects to WalkState->ResultObj causing further problems
 *
 * Note: appearance of bug greatly depends on the memory cache dynamics
 *
 *       So, PASS of this test doesn't mean yet that the root cause of the problem
 *       has been resolved.
 */

Mutex(MX00, 0)
Mutex(MX01, 1)
Mutex(MX02, 2)
Mutex(MX03, 3)

Name(p000, Package() { 0x67890000 })

Method(m1e7)
{
	Store(0x123, Local0)
	Acquire(MX03, 0x100)

	CH03("", 0, 0x000, 0, 0)

	Acquire(MX02, 0x100)
	CH04("", 0, 64, 0, 0x003, 0, 0) // AE_AML_MUTEX_ORDER

	Store(RefOf(p000), Local2) // L0(0x004d5ec8, 0x123), L2 (0x004d5dc8, res of RefOf)
	Store(DerefOf(Local2), Local3)
	Store("Sit 1: Local2 contains bad object there!!!!!", Debug)
	Store(LAnd(0xabcd0000, 0xabcd0001), Local5)
	Decrement(Local0) // L0(0x004d5ec8, 0x123), L2 (0x004d5dc8, 0xCACA)
	Store("============================== 0", Debug)
	Store(Local0, Debug)
	Store("============================== 1", Debug)
	Store(RefOf(p000), Local2)
	Store("============================== 2", Debug)
	Add(Local0, 0x11111111, Local4)
	Store(Local4, Debug)
	if (LNotEqual(Local4, 0x11111233)) {
		err("", zFFF, 0x001, 0, 0, Local4, 0x11111233)
	}
	Store("============================== 3", Debug)

	CH03("", 0, 0x002, 0, 0)

	/*
	 * The problem is not automatically detected,
	 * so remove this error report after the problem has been resolved.
	 */
	err("", zFFF, 0x123, 0, 0, 0, 0)
}

