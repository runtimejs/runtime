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
 * Bug 299:
 *
 * SUMMARY: Many outstanding allocations on abnormal termination of AcpiDsCallControlMethod
 *
 *
 * [ACPI Debug]  String: [0x29] "========= ROOT METHODS SUMMARY (max 600):"
 * [ACPI Debug]  String: [0x3E] ":STST:bug-demo:Demo of bug 299:m1e8:FAIL:Errors # 01 00 00 00:"
 * [ACPI Debug]  String: [0x0E] "========= END."
 * [ACPI Debug]  String: [0x5B] "TEST ACPICA: 64-bit : FAIL : Errors # 0x0000000000000001, Failed tests # 0x0000000000000001"
 * Outstanding: 0x14 allocations after execution
 * Execution of \MAIN returned object 00327E40 Buflen 10
 *   [Integer] = 0000000000000001
 * - q
 * 0047DDE8 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047DE48 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047DEA8 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047DF08 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047DF68 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047DFC8 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047C988 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047C9E8 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047CA48 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047CAA8 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047CB08 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047CB68 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047C328 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047C848 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047B398 Len 0028   utcache-414 [Operand]      Integer R1
 * 0047A128 Len 0028   utcache-414 [Operand]      Integer R1
 * ACPI Error (uttrack-0719): 16(10) Outstanding allocations [20061215]
 */

Method(m1e8)
{
	Method(m306, 2, Serialized)
	{
		Name(i000, 0)
		Name(i001, 0)
		Name(i002, 0x34)
		Name(i003, 0xabcd0003)
		Name(i004, 0xabcd0004)
		Method(m000,1,Serialized, 0) {if (arg0) {Store( 0,i004)} else {Store( 0,i003)} mm00(7,i000,i001)}
		Method(m001,1,Serialized, 1) {if (arg0) {Store( 1,i004)} else {Store( 1,i003)} mm00(8,i000,i001)}

		Method(mm00, 3)
		{
			Store(i002, Local0)
			Increment(i002)

			if (LGreater(i002, 0x36)) {
				Return
			}

			if (arg0) {
				Store(arg2, Local1)
			} else {
				Store(arg1, Local1)
			}

			if (LEqual(Local1, 0)) {
				m000(Local0)
			} else {
				m001(Local0)
			}
		}

		Store(arg0, i000)
		Store(arg1, i001)

		mm00(0, i000, i001)
	}

	CH03("", 0, 0x000, 0, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	m306(9, 0)
	CH04("", 1, 64, 0, 0x001, 0, 0) // AE_AML_MUTEX_ORDER

	/*
	 * The problem is not automatically detected,
	 * so remove this error report after the problem has been resolved.
	 */
	err("", zFFF, 0x123, 0, 0, 0, 0)
}


