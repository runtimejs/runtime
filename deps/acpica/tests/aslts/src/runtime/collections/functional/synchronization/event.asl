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
 * Synchronization (events)
 */

/*
!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SEE: shouls be a few updated
!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/

// The test for ASL-Events to be run on a single invocation only
//
// Note: additional checkings should be implemented to measure
//       the actual idle time provided by Wait operator according
//       to the time measuring provided by the Timer operator.

// Pass TimeoutValues for Wait globally (all locals busy)
Name(TOT0, 0)
Name(TOT1, 0)
Name(TOT2, 0)
Name(TOT3, 0)

// All events
Event(EVT0)
Event(EVT1)
Event(EVT2)
Event(EVT3)

// Wait, expected Zero
Method(m050, 5)
{
	if (0) {Store("m050: Wait, expected Zero", Debug)}

	if (arg1){CH00(arg0, 0x00, 0, Wait(EVT0, TOT0))}
	if (arg2){CH00(arg0, 0x00, 1, Wait(EVT1, TOT1))}
	if (arg3){CH00(arg0, 0x00, 2, Wait(EVT2, TOT2))}
	if (arg4){CH00(arg0, 0x00, 3, Wait(EVT3, TOT3))}
}

// Wait, expected Non-Zero
Method(m051, 5)
{
	if (0) {Store("m051: Wait, expected Non-Zero", Debug)}

	if (arg1){CH01(arg0, 0x01, 0, Wait(EVT0, TOT0))}
	if (arg2){CH01(arg0, 0x01, 1, Wait(EVT1, TOT1))}
	if (arg3){CH01(arg0, 0x01, 2, Wait(EVT2, TOT2))}
	if (arg4){CH01(arg0, 0x01, 3, Wait(EVT3, TOT3))}
}

// Signal
Method(m052, 5)
{
	if (0) {Store("m052: Signal", Debug)}

	if (arg1){Signal(EVT0)}
	if (arg2){Signal(EVT1)}
	if (arg3){Signal(EVT2)}
	if (arg4){Signal(EVT3)}
}

// Reset
Method(m053, 5)
{
	if (0) {Store("m053: Reset", Debug)}

	if (arg1){Reset(EVT0)}
	if (arg2){Reset(EVT1)}
	if (arg3){Reset(EVT2)}
	if (arg4){Reset(EVT3)}
}

/*
 * Package:={N lines}
 * Line:= consists of 6 elements:
 *   0:     operation:
 *          0 - Wait, expected Zero     (acquired)
 *          1 - Wait, expected Non-Zero (failed to acquire)
 *          2 - Signal
 *          3 - Reset
 *   1:     bit-mask of events operation to be applied to which
 *          bit 0x08 - 0th event
 *          bit 0x04 - 1th event
 *          bit 0x02 - 2th event
 *          bit 0x01 - 3th event
 *   2-5:   TimeoutValues for Wait operations (left->right too)
 */
 Name(p011, Package() {

	// 1. Wait without signals results in non-zero (failed to acquire)
	// 2. Applied to all 4 event-Objects

	1, 0x0f,	0x0000, 0x0001, 0x002, 0x00ff,
	1, 0x0f,	0x0001, 0x0002, 0x003, 0x0004,
	1, 0x0f,	0x0011, 0x0022, 0x033, 0x0000,

	// 1. Send Ni signals to i-th Object.
	// 2. All Ni events of i-th Object are successfully one
	//    by one acquired by Ni Waits applied to that Object.
	// 3. But, attempt to acquire one more failed.
	// 4. Applied to all 4 event-Objects.

	2, 0x0f,	0, 0, 0, 0,
	2, 0x0f,	0, 0, 0, 0,
	2, 0x0f,	0, 0, 0, 0,
	2, 0x0f,	0, 0, 0, 0,
	0, 0x0f,	0xffff, 0xffff, 0xffff, 0xffff,
	0, 0x0f,	0x8000, 0x4000, 0x2000, 0x1000,
	0, 0x0f,	0x0001, 0x0002, 0x0003, 0x0004,
	0, 0x0f,	0xffff, 0xffff, 0xffff, 0xffff,
	1, 0x0f,	0x0001, 0x0002, 0x0003, 0x0004,

	2, 0x0f,	0, 0, 0, 0,
	2, 0x07,	0, 0, 0, 0,
	2, 0x03,	0, 0, 0, 0,
	2, 0x01,	0, 0, 0, 0,
	0, 0x01,	0xffff, 0xffff, 0xffff, 0xffff,
	0, 0x03,	0xffff, 0xffff, 0xffff, 0xffff,
	0, 0x07,	0xffff, 0xffff, 0xffff, 0xffff,
	0, 0x0f,	0xffff, 0xffff, 0xffff, 0xffff,
	1, 0x0f,	0x0001, 0x0002, 0x0003, 0x0004,

	// 1. Send Ni_s signals to i-th Object.
	// 2. Reset i-th object, one time.
	// 3. Wait of i-th Object results in non-zero (failed to acquire)
	// 4. Applied to all 4 event-Objects.

	2, 0x0f,	0, 0, 0, 0,
	2, 0x0f,	0, 0, 0, 0,
	2, 0x0f,	0, 0, 0, 0,
	2, 0x0f,	0, 0, 0, 0,
	3, 0x0f,	0, 0, 0, 0,
	1, 0x0f,	0x0001, 0x0002, 0x0003, 0x0004,
	1, 0x0f,	0x0001, 0x0002, 0x0003, 0x0004,

	2, 0x0f,	0, 0, 0, 0,
	2, 0x0f,	0, 0, 0, 0,
	2, 0x0f,	0, 0, 0, 0,
	2, 0x0f,	0, 0, 0, 0,
	3, 0x0a,	0, 0, 0, 0,
	1, 0x0a,	0x0001, 0x0002, 0x0003, 0x0004,
	0, 0x05,	0x0001, 0x0002, 0x0003, 0x0004,
	0, 0x05,	0x0001, 0x0002, 0x0003, 0x0004,
	0, 0x05,	0x0001, 0x0002, 0x0003, 0x0004,
	0, 0x05,	0x0001, 0x0002, 0x0003, 0x0004,
	1, 0x0f,	0x0001, 0x0002, 0x0003, 0x0004,

	// For to track the current state only:
	// Wait() allows TimeoutValue greater then
	// 0xffff though cuts it to 16 bits.

	1, 0x0f, 0x10000, 0x10000, 0x10000, 0x10000,
	}
)

/*
 * Run operations one by one in accordance with the table passed by arg2.
 * arg1 - number of operations.
 */
Method(m060, 4)
{
	Store(0, Local7)
	While(arg1) {
		Multiply(Local7, 6, Local6)
		Store(DeRefOf(Index(arg2, Local6)), Local5)

		Increment(Local6)
		Store(DeRefOf(Index(arg2, Local6)), Local1)

		// TimeoutValues for Wait

		Increment(Local6)
		Store(DeRefOf(Index(arg2, Local6)), TOT0)
		Increment(Local6)
		Store(DeRefOf(Index(arg2, Local6)), TOT1)
		Increment(Local6)
		Store(DeRefOf(Index(arg2, Local6)), TOT2)
		Increment(Local6)
		Store(DeRefOf(Index(arg2, Local6)), TOT3)

					// Local1 - run 0th event
		Store(0, Local2)	// run 1th event
		Store(0, Local3)	// run 2th event
		Store(0, Local4)	// run 3th event

		if (And(Local1, 0x04)) {
			Store(1, Local2)
		}
		if (And(Local1, 0x02)) {
			Store(1, Local3)
		}
		if (And(Local1, 0x01)) {
			Store(1, Local4)
		}
		if (And(Local1, 0x08)) {
			Store(1, Local1)
		} else {
			Store(0, Local1)
		}

		if (LEqual(Local5, 0)) {
			m050(arg0, Local1, Local2, Local3, Local4)
		} else {
			if (LEqual(Local5, 1)) {
				m051(arg0, Local1, Local2, Local3, Local4)
			} else {
				if (LEqual(Local5, 2)) {
					m052(arg0, Local1, Local2, Local3, Local4)
				} else {
					if (LEqual(Local5, 3)) {
						m053(arg0, Local1, Local2, Local3, Local4)
					}
				}
			}
		}

		Increment(Local7)
		Decrement(arg1)
	}
}

Method(WAI0,, Serialized)
{
	Name(ts, "WAI0")

	Store("TEST: WAI0, Wait for Events", Debug)

	m060(ts, 40, p011, "p011")
}

// Run-method
Method(EVN0)
{
	Store("TEST: EVN0, Events", Debug)

	WAI0()
}


