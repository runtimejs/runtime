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
 * Bug 47:
 *
 * SUMMARY: Timer operator doesn’t provide gradually increased values
 *
 * APPEARANCE
 *
 * The ASL Timer operator is declared as a 64-bit one
 * "17.5.117 Timer (Get 64-Bit Timer Value)" but actualy,
 * we observe it is overrun during each 15 minutes, but we
 * expect that to be one time in more than 50 thousand years!
 *
 * SPECS (17.5.117)
 *
 * The value resulting from this opcode is 64-bits.
 * It is monotonically increasing, but it is not guaranteed
 * that every result will be unique,  i.e. two subsequent
 * instructions may return the same value.  The only guarantee
 * is that each subsequent evaluation will be greater-than or
 * equal to the previous ones.
 *
 * Timer operator doesn’t provide
 * gradually increased values. The test takes long time,
 * and ends only when encounters error. Since the test is
 * based on Timer operator which is under testing and works
 * incorrectly we excluded this test from the normally run
 * tests set. We can't even control the time the run of test
 * is in progress from inside the test.
 */

Method(md77,, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Name(TSLP, 5000)	// MilliSecs to sleep each cycle (5 secs)
	Name(NCCL, 180)	// Number of cycles

	Store(NCCL, lpN0)
	Store(0, lpC0)

	Multiply(TSLP, lpN0, Local0)
	Divide(Local0, 1000, Local1, Local2)
	Store(Concatenate("Maximal time of execution (in seconds): 0x", Local2), Debug)

	Store(Timer, Local0)
	Store(0, Local5)

	Store(Concatenate("Start value of Timer : 0x", Local0), Debug)

	While (lpN0) {

		Store(Timer, Local7)
		Store(Concatenate("Timer: 0x", Local7), Debug)

		if (LGreater(Local0, Local7)) {
			// if (Local5) {
				err("", zFFF, 0x000, 0, 0, Local0, Local7)
				Store(Concatenate("Cur   timer    : 0x", Local7), Debug)
				Store(Concatenate("Start timer    : 0x", Local0), Debug)
				Store(Concatenate("Step of cycle  : 0x", TSLP), Debug)
				Break
			// }
			// First time in more than 50 thousand years!
			Store(1, Local5)
		}

		Sleep (TSLP)

		Decrement(lpN0)
		Increment(lpC0)
	}

	Store(Concatenate("Start  timer: 0x", Local0), Debug)
	Store(Concatenate("Finish timer: 0x", Local7), Debug)

	Subtract(Local7, Local0, Local6)
	Store(TMR0(Local6), Local0)
	Store(Concatenate("Run time (in seconds): 0x", Local0), Debug)
}
