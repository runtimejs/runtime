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
 * Bug 276:
 *
 * SUMMARY: 'Large Reference Count' on AML code with LoadTable/UnLoad in a slack mode
 *
 * Note: Check the result of this test manually that there are no
 *       'Large Reference Count' reported.
 *
 * Note: these 'Large Reference Count' could be detected automatically by Do utility
 */

Method(mc76,, Serialized)
{

	Name(ERR5, 0)
	Name(ERRS, 0)
	Name(tmt0, 0)
	Name(TCLL, 0)
	Name(RMRC, 0)
	Name(RP0P, Package(8) {})
	Name(NRMT, "")
	Name(STST, "STST")
	Name(TCNP, Package() {
		"compilation",
		"functional",
		"complex",
		"exceptions",
		"bug-demo",
		"service",
		"mt",
		"Identity2MS",
		"IMPL",
	})

	Method(TCN0, 1)
	{
		Store("?", Local7)
		Store(DerefOf(Index(TCNP, arg0)), Local7)
		Return(Local7)
	}

	Method(mmm0)
	{
		Increment(ERRS)
	}

	Method(mc73,, Serialized)
	{
		Name(DDBH, 0)
		Method(m000) {}
		Method(m001) {}

		Store(LoadTable("OEM1", "", "", "", "", 1), DDBH)
		mmm0()
		UnLoad(DDBH)
		Store("OEM1 unloaded", Debug)
	}

	Method(mmm2, 5) {}

	Method(mmm3,, Serialized)
	{
		Name(b000, Buffer(4) {})

		Concatenate(":", TCN0(TCLL), Local1)
		Concatenate(Local1, ":", Local0)
		Concatenate(Local0, "?", Local1)
		Concatenate(Local1, ":", Local0)
		Concatenate(Local0, NRMT, Local1)
		Concatenate(Local1, ":", Local0)
		Subtract(ERRS, ERR5, Local7)
		Concatenate(Local0, "FAIL:Errors # ", Local2)
		Concatenate(Local2, Local7, Local0)
		Concatenate(Local0, Local1, Local2)
		Store(Local2, Debug)
		Concatenate(":", STST, Local2)
		Concatenate(Local2, Local1, Local0)
		Store(Local0, Index(RP0P, RMRC))
	}

	Method(mmm1)
	{
		mmm2(0, 0, 0, 0, 0)
		mmm3()
	}

	Method(mmm4, 1)
	{
		Store(Timer, tmt0)
	}

	Method(mmm5) {
		mmm4(0)
		mc73()
		mmm1()
	}
	mmm5()
}
