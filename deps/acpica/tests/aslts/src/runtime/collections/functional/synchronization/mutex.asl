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
 * Synchronization (mutexes)
 *
 * The test for ASL-Mutexes to be run on a single invocation only
 */

/*
 * Mutex + Acquire + Release
 *
 * The test actions exercise the (Mutex + Acquire + Release)
 * operators adhering to the following ACPI-specified rules
 * (some of them are verified):
 *
 * - creates a data mutex synchronization object,
 *   with level from 0 to 15 specified by SyncLevel,
 * - a Mutex is not owned by a different invocation so it is owned
 *   immediately,
 * - acquiring ownership of a Mutex can be nested,
 * - a Mutex can be acquired more than once by the same invocation,
 * - Acquire returns False if a timeout not occurred and the mutex
 *   ownership was successfully acquired,
 * - to prevent deadlocks, wherever more than one synchronization
 *   object must be owned, the synchronization objects must always
 *   be released in the order opposite the order in which they were
 *   acquired,
 * - all Acquire terms must refer to a synchronization object with
 *   an equal or greater SyncLevel to current level,
 * - all Release terms must refer to a synchronization object with
 *   equal or lower SyncLevel to the current level,
 * - after all the acquired mutexes of the current level are released
 *   the top occupied levels declines to the nearest occupied level,
 * - Acquire increases the counter of mutex by one,
 * - Release decreases the counter of mutex by one.
 */

// Acquire methods
// m01X(<method name>, <mux0>,  <mux1>,  <mux2>, <mux3>)

// Release methods
// m02X(<method name>, <mux0>,  <mux1>,  <mux2>, <mux3>)

// ================================================= Acquire methods

Method(m010, 5)
{
	if (arg1){CH00(arg0, 0x00, 0, Acquire(T000, 0x0))}
	if (arg2){CH00(arg0, 0x00, 1, Acquire(T001, 0xFFFF))}
	if (arg3){CH00(arg0, 0x00, 2, Acquire(T002, 0x8000))}
	if (arg4){CH00(arg0, 0x00, 3, Acquire(T003, 0x1000))}
}

Method(m011, 5)
{
	if (arg1){CH00(arg0, 0x01, 0, Acquire(T100, 0x0))}
	if (arg2){CH00(arg0, 0x01, 1, Acquire(T101, 0xFFFF))}
	if (arg3){CH00(arg0, 0x01, 2, Acquire(T102, 0x8000))}
	if (arg4){CH00(arg0, 0x01, 3, Acquire(T103, 0x1000))}
}

Method(m012, 5)
{
	if (arg1){CH00(arg0, 0x02, 0, Acquire(T200, 0x0))}
	if (arg2){CH00(arg0, 0x02, 1, Acquire(T201, 0xFFFF))}
	if (arg3){CH00(arg0, 0x02, 2, Acquire(T202, 0x8000))}
	if (arg4){CH00(arg0, 0x02, 3, Acquire(T203, 0x1000))}
}

Method(m013, 5)
{
	if (arg1){CH00(arg0, 0x03, 0, Acquire(T300, 0x0))}
	if (arg2){CH00(arg0, 0x03, 1, Acquire(T301, 0xFFFF))}
	if (arg3){CH00(arg0, 0x03, 2, Acquire(T302, 0x8000))}
	if (arg4){CH00(arg0, 0x03, 3, Acquire(T303, 0x1000))}
}

Method(m014, 5)
{
	if (arg1){CH00(arg0, 0x04, 0, Acquire(T400, 0x0))}
	if (arg2){CH00(arg0, 0x04, 1, Acquire(T401, 0xFFFF))}
	if (arg3){CH00(arg0, 0x04, 2, Acquire(T402, 0x8000))}
	if (arg4){CH00(arg0, 0x04, 3, Acquire(T403, 0x1000))}
}

Method(m015, 5)
{
	if (arg1){CH00(arg0, 0x05, 0, Acquire(T500, 0x0))}
	if (arg2){CH00(arg0, 0x05, 1, Acquire(T501, 0xFFFF))}
	if (arg3){CH00(arg0, 0x05, 2, Acquire(T502, 0x8000))}
	if (arg4){CH00(arg0, 0x05, 3, Acquire(T503, 0x1000))}
}

Method(m016, 5)
{
	if (arg1){CH00(arg0, 0x06, 0, Acquire(T600, 0x0))}
	if (arg2){CH00(arg0, 0x06, 1, Acquire(T601, 0xFFFF))}
	if (arg3){CH00(arg0, 0x06, 2, Acquire(T602, 0x8000))}
	if (arg4){CH00(arg0, 0x06, 3, Acquire(T603, 0x1000))}
}

Method(m017, 5)
{
	if (arg1){CH00(arg0, 0x07, 0, Acquire(T700, 0x0))}
	if (arg2){CH00(arg0, 0x07, 1, Acquire(T701, 0xFFFF))}
	if (arg3){CH00(arg0, 0x07, 2, Acquire(T702, 0x8000))}
	if (arg4){CH00(arg0, 0x07, 3, Acquire(T703, 0x1000))}
}

Method(m018, 5)
{
	if (arg1){CH00(arg0, 0x08, 0, Acquire(T800, 0x0))}
	if (arg2){CH00(arg0, 0x08, 1, Acquire(T801, 0xFFFF))}
	if (arg3){CH00(arg0, 0x08, 2, Acquire(T802, 0x8000))}
	if (arg4){CH00(arg0, 0x08, 3, Acquire(T803, 0x1000))}
}

Method(m019, 5)
{
	if (arg1){CH00(arg0, 0x09, 0, Acquire(T900, 0x0))}
	if (arg2){CH00(arg0, 0x09, 1, Acquire(T901, 0xFFFF))}
	if (arg3){CH00(arg0, 0x09, 2, Acquire(T902, 0x8000))}
	if (arg4){CH00(arg0, 0x09, 3, Acquire(T903, 0x1000))}
}

Method(m01a, 5)
{
	if (arg1){CH00(arg0, 0x0a, 0, Acquire(Ta00, 0x0))}
	if (arg2){CH00(arg0, 0x0a, 1, Acquire(Ta01, 0xFFFF))}
	if (arg3){CH00(arg0, 0x0a, 2, Acquire(Ta02, 0x8000))}
	if (arg4){CH00(arg0, 0x0a, 3, Acquire(Ta03, 0x1000))}
}

Method(m01b, 5)
{
	if (arg1){CH00(arg0, 0x0b, 0, Acquire(Tb00, 0x0))}
	if (arg2){CH00(arg0, 0x0b, 1, Acquire(Tb01, 0xFFFF))}
	if (arg3){CH00(arg0, 0x0b, 2, Acquire(Tb02, 0x8000))}
	if (arg4){CH00(arg0, 0x0b, 3, Acquire(Tb03, 0x1000))}
}

Method(m01c, 5)
{
	if (arg1){CH00(arg0, 0x0c, 0, Acquire(Tc00, 0x0))}
	if (arg2){CH00(arg0, 0x0c, 1, Acquire(Tc01, 0xFFFF))}
	if (arg3){CH00(arg0, 0x0c, 2, Acquire(Tc02, 0x8000))}
	if (arg4){CH00(arg0, 0x0c, 3, Acquire(Tc03, 0x1000))}
}

Method(m01d, 5)
{
	if (arg1){CH00(arg0, 0x0d, 0, Acquire(Td00, 0x0))}
	if (arg2){CH00(arg0, 0x0d, 1, Acquire(Td01, 0xFFFF))}
	if (arg3){CH00(arg0, 0x0d, 2, Acquire(Td02, 0x8000))}
	if (arg4){CH00(arg0, 0x0d, 3, Acquire(Td03, 0x1000))}
}

Method(m01e, 5)
{
	if (arg1){CH00(arg0, 0x0e, 0, Acquire(Te00, 0x0))}
	if (arg2){CH00(arg0, 0x0e, 1, Acquire(Te01, 0xFFFF))}
	if (arg3){CH00(arg0, 0x0e, 2, Acquire(Te02, 0x8000))}
	if (arg4){CH00(arg0, 0x0e, 3, Acquire(Te03, 0x1000))}
}

Method(m01f, 5)
{
	if (arg1){CH00(arg0, 0x0f, 0, Acquire(Tf00, 0x0))}
	if (arg2){CH00(arg0, 0x0f, 1, Acquire(Tf01, 0xFFFF))}
	if (arg3){CH00(arg0, 0x0f, 2, Acquire(Tf02, 0x8000))}
	if (arg4){CH00(arg0, 0x0f, 3, Acquire(Tf03, 0x1000))}
}

// ================================================= Release methods

Method(m020, 5)
{
	if (arg4){Release(T003)}
	if (arg3){Release(T002)}
	if (arg2){Release(T001)}
	if (arg1){Release(T000)}
}

Method(m021, 5)
{
	if (arg4){Release(T103)}
	if (arg3){Release(T102)}
	if (arg2){Release(T101)}
	if (arg1){Release(T100)}
}

Method(m022, 5)
{
	if (arg4){Release(T203)}
	if (arg3){Release(T202)}
	if (arg2){Release(T201)}
	if (arg1){Release(T200)}
}

Method(m023, 5)
{
	if (arg4){Release(T303)}
	if (arg3){Release(T302)}
	if (arg2){Release(T301)}
	if (arg1){Release(T300)}
}

Method(m024, 5)
{
	if (arg4){Release(T403)}
	if (arg3){Release(T402)}
	if (arg2){Release(T401)}
	if (arg1){Release(T400)}
}

Method(m025, 5)
{
	if (arg4){Release(T503)}
	if (arg3){Release(T502)}
	if (arg2){Release(T501)}
	if (arg1){Release(T500)}
}

Method(m026, 5)
{
	if (arg4){Release(T603)}
	if (arg3){Release(T602)}
	if (arg2){Release(T601)}
	if (arg1){Release(T600)}
}

Method(m027, 5)
{
	if (arg4){Release(T703)}
	if (arg3){Release(T702)}
	if (arg2){Release(T701)}
	if (arg1){Release(T700)}
}

Method(m028, 5)
{
	if (arg4){Release(T803)}
	if (arg3){Release(T802)}
	if (arg2){Release(T801)}
	if (arg1){Release(T800)}
}

Method(m029, 5)
{
	if (arg4){Release(T903)}
	if (arg3){Release(T902)}
	if (arg2){Release(T901)}
	if (arg1){Release(T900)}
}

Method(m02a, 5)
{
	if (arg4){Release(Ta03)}
	if (arg3){Release(Ta02)}
	if (arg2){Release(Ta01)}
	if (arg1){Release(Ta00)}
}

Method(m02b, 5)
{
	if (arg4){Release(Tb03)}
	if (arg3){Release(Tb02)}
	if (arg2){Release(Tb01)}
	if (arg1){Release(Tb00)}
}

Method(m02c, 5)
{
	if (arg4){Release(Tc03)}
	if (arg3){Release(Tc02)}
	if (arg2){Release(Tc01)}
	if (arg1){Release(Tc00)}
}

Method(m02d, 5)
{
	if (arg4){Release(Td03)}
	if (arg3){Release(Td02)}
	if (arg2){Release(Td01)}
	if (arg1){Release(Td00)}
}

Method(m02e, 5)
{
	if (arg4){Release(Te03)}
	if (arg3){Release(Te02)}
	if (arg2){Release(Te01)}
	if (arg1){Release(Te00)}
}

Method(m02f, 5)
{
	if (arg4){Release(Tf03)}
	if (arg3){Release(Tf02)}
	if (arg2){Release(Tf01)}
	if (arg1){Release(Tf00)}
}

// ================================================= Run Acquire/Release

/*
 * Acquire
 *	arg0 - name of method to be reported
 *	arg1 - synclevel (0-15)
 *	arg2 - start mutex inside the first processed synclevel
 *           (0 for other levels)
 *           0 - starting with the # (arg3)
 *           1 - 0-th
 *           2 - 1-th
 *           3 - 2-th
 *           4 - 3-th
 *	arg3 - # operations to be performed for current synclevel
 */
Method(m030, 4)
{
	if (LEqual(arg3, 0)) {
		Return (0)
	}

	Store(0, Local1)
	Store(0, Local2)
	Store(0, Local3)
	Store(0, Local4)

	// Local5 - index of highest
	Store(Add(arg2, arg3), Local5)
	Decrement(Local5)

	Store(0, Local6)
	Store(0, Local7)
	if (LLessEqual(arg2, 0))	{Store(1, Local6)}
	if (LGreaterEqual(Local5, 0))	{Store(1, Local7)}
	if (LAnd(Local6, Local7))	{Store(1, Local1)}

	Store(0, Local6)
	Store(0, Local7)
	if (LLessEqual(arg2, 1))	{Store(1, Local6)}
	if (LGreaterEqual(Local5, 1))	{Store(1, Local7)}
	if (LAnd(Local6, Local7))	{Store(1, Local2)}

	Store(0, Local6)
	Store(0, Local7)
	if (LLessEqual(arg2, 2))	{Store(1, Local6)}
	if (LGreaterEqual(Local5, 2))	{Store(1, Local7)}
	if (LAnd(Local6, Local7))	{Store(1, Local3)}

	Store(0, Local6)
	Store(0, Local7)
	if (LLessEqual(arg2, 3))	{Store(1, Local6)}
	if (LGreaterEqual(Local5, 3))	{Store(1, Local7)}
	if (LAnd(Local6, Local7))	{Store(1, Local4)}

	if (0) {
		Store(Local1, Debug)
		Store(Local2, Debug)
		Store(Local3, Debug)
		Store(Local4, Debug)
		Return (0)
	}

	if (LEqual(arg1, 0)) {
		m010(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 1)) {
		m011(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 2)) {
		m012(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 3)) {
		m013(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 4)) {
		m014(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 5)) {
		m015(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 6)) {
		m016(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 7)) {
		m017(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 8)) {
		m018(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 9)) {
		m019(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 10)) {
		m01a(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 11)) {
		m01b(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 12)) {
		m01c(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 13)) {
		m01d(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 14)) {
		m01e(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 15)) {
		m01f(arg0, Local1, Local2, Local3, Local4)
	}

	Return (0)
}

/*
 * Release
 *	arg0 - name of method to be reported
 *	arg1 - synclevel (0-15)
 *	arg2 - start mutex inside the first processed synclevel
 *           (0 for other levels)
 *           0 - starting with the # (arg3)
 *           4 - 3-th
 *           3 - 2-th
 *           2 - 1-th
 *           1 - 0-th
 *	arg3 - # operations to be performed for current synclevel
 */
Method(m031, 4)
{
	if (LEqual(arg3, 0)) {
		Return (0)
	}

	Store(0, Local1)
	Store(0, Local2)
	Store(0, Local3)
	Store(0, Local4)

	// arg2 - index of highest
	if (LEqual(arg2, 0)) {
		Store(arg3, arg2)
	}
	Decrement(arg2)

	// Local5 - index of lowest
	Store(Subtract(arg2, arg3), Local5)
	Increment(Local5)

	Store(0, Local6)
	Store(0, Local7)
	if (LLessEqual(Local5, 0))	{Store(1, Local6)}
	if (LGreaterEqual(arg2, 0))	{Store(1, Local7)}
	if (LAnd(Local6, Local7))	{Store(1, Local1)}

	Store(0, Local6)
	Store(0, Local7)
	if (LLessEqual(Local5, 1))	{Store(1, Local6)}
	if (LGreaterEqual(arg2, 1))	{Store(1, Local7)}
	if (LAnd(Local6, Local7))	{Store(1, Local2)}

	Store(0, Local6)
	Store(0, Local7)
	if (LLessEqual(Local5, 2))	{Store(1, Local6)}
	if (LGreaterEqual(arg2, 2))	{Store(1, Local7)}
	if (LAnd(Local6, Local7))	{Store(1, Local3)}

	Store(0, Local6)
	Store(0, Local7)
	if (LLessEqual(Local5, 3))	{Store(1, Local6)}
	if (LGreaterEqual(arg2, 3))	{Store(1, Local7)}
	if (LAnd(Local6, Local7))	{Store(1, Local4)}

	if (0) {
		Store(Local1, Debug)
		Store(Local2, Debug)
		Store(Local3, Debug)
		Store(Local4, Debug)
		Return (0)
	}

	if (LEqual(arg1, 0)) {
		m020(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 1)) {
		m021(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 2)) {
		m022(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 3)) {
		m023(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 4)) {
		m024(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 5)) {
		m025(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 6)) {
		m026(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 7)) {
		m027(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 8)) {
		m028(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 9)) {
		m029(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 10)) {
		m02a(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 11)) {
		m02b(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 12)) {
		m02c(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 13)) {
		m02d(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 14)) {
		m02e(arg0, Local1, Local2, Local3, Local4)
	} if (LEqual(arg1, 15)) {
		m02f(arg0, Local1, Local2, Local3, Local4)
	}

	Return (0)
}

// ================================================= Tests

// How many times run Acquire/Release for the particular level mutexes
// 0 - Acquire
// 1 - Release
/*
 * Name(p010, Buffer() {
 *	0, 0,   2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17,
 *	1, 0,  20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35,
 *	0, 0,  38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53,
 *	1, 0,  56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
 *	}
 * )
 */
Name(p010, Buffer() {
	0, 0,  4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

	0, 0,  4, 3, 2, 1, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  4, 3, 2, 1, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0,

	0, 0,  4, 3, 2, 1, 4, 3, 2, 1, 4, 3, 2, 1, 4, 3, 2, 0,
	1, 0,  4, 3, 2, 1, 4, 3, 2, 1, 4, 3, 2, 1, 4, 3, 2, 0,

	0, 0,  4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
	1, 0,  4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,

	0, 0,  4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0,  4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0,  4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

	0, 0,  4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0,
	0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0,
	0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0,

	0, 0,  4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
	0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,
	0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,
	1, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,
	1, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,
	1, 0,  4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,

	0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,
	1, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,

	0, 0,  0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4,
	1, 0,  0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4,

	0, 0,  4, 0, 4, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 0, 4, 4,
	1, 0,  4, 0, 4, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 0, 4, 4,

	0, 0,  4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0,
	0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0,

	0, 0,  4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0,
	0, 0,  0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0,

	0, 0,  4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 4,  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 3,  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 2,  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 1,  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

	0, 0,  4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0,
	1, 4,  0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 1,  0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0,

	0, 0,  4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0,
	1, 0,  0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0,
	0, 0,  0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0,
	1, 0,  0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 0, 0, 0,
	0, 0,  0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4,
	1, 0,  4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
	}
)

/*
 * Run Acquire/Release for all level mutexes
 *
 * Buffer:={N lines}
 * Line:= consists of 18 bytes:
 *   0:     operation: 0-Acquire, 1-Release
 *   1:     The start mutex inside the first processed synclevel
 *          (start mux and synclevels are ordered: Acquire: left->r,
 *           Release: r->l)
 *          0:   to start according to the given number (bytes 2-17)
 *          1-4: Acquire (left->right) (1-0th,2-1th,3-2th,4-3th)
 *               Release (right->left) (4-3th,3-2th,2-1th,1-0th)
 *   2-17:  per-synclevel numbers of operations to be performed:
 *          how many operations (from 0 up to 4) to be performed
 *          (at most one per mutex) on the mutexes of the relevant
 *          level (2th - synclevel 0, 3th - synclevel 1, etc.)
 * Variables:
 *	arg0   - name of method to be reported
 *	arg1   - lines total number
 *	arg2   - buffer of lines
 *	arg3   - name of buffer
 *	Local7 - index of line
 *	Local6 - synclevel (0-15)
 *	Local5 - operation (0-Acquire,1-Release)
 *	Local4 - abs index corresponding to synclevel inside the buffer
 *	Local3 - auxiliary = (Local6 + 1)
 *	Local2 - # operations to be performed for current synclevel
 *	Local1 - start mutex inside the first processed synclevel
 *             (0 for other levels)
 */
Method(m032, 4)
{
	Store(0, Local7)
	While(arg1) {
		Multiply(Local7, 18, Local6)
		Store(DeRefOf(Index(arg2, Local6)), Local5)

		Increment(Local6)
		Store(DeRefOf(Index(arg2, Local6)), Local1)

		if (LEqual(Local5, 0)) {

			if (0) {
				Store("============= Acq", Debug)
			}

			Store(Add(Local6, 1), Local4)
			Store(0, Local6)
			While(LLess(Local6, 16)) {

				Store(DeRefOf(Index(arg2, Local4)), Local2)

				if (0){
					Store(Local6, Debug)
					Store(Local4, Debug)
					Store(Local2, Debug)
				}

				if (Local2){
					m030(arg0, Local6, Local1, Local2)
					Store(0, Local1)
				}

				Increment(Local6)
				Increment(Local4)
			}
		} else {
			if (0) {
				Store("============= Rel", Debug)
			}

			Store(Add(Local6, 16), Local4)
			Store(16, Local3)
			While(Local3) {
				Store(Subtract(Local3, 1), Local6)

				Store(DeRefOf(Index(arg2, Local4)), Local2)

				if (0){
					Store(Local6, Debug)
					Store(Local4, Debug)
					Store(Local2, Debug)
				}

				if (Local2){
					m031(arg0, Local6, Local1, Local2)
					Store(0, Local1)
				}

				Decrement(Local3)
				Decrement(Local4)
			}
		}

		Increment(Local7)
		Decrement(arg1)
	}
	CH03("MUX0", Z150, 0x000, 0, 0)
}

Method(m033,, Serialized) {
	Mutex(MTX0, 0)
	Store (Acquire(MTX0, 0), Local0)
    if (Local0)
    {
        Store ("M033: Could not acquire mutex", Debug)
        Return
    }
	Release(MTX0)
}

Method(m034) {
	Store(200, Local0)
	While (Local0) {
		m033()
		Decrement(Local0)
	}
}

// Run-method
Method(MUX0,, Serialized)
{
	Name(ts, "MUX0")

	Store("TEST: MUX0, Acquire/Release Mutex", Debug)

	SRMT("m032")
	m032(ts, 56, p010, "p010")

	SRMT("m034")
	m034()
}
