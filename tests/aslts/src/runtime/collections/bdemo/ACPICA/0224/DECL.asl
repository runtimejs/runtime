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
 * Bug 224:
 *
 * SUMMARY: AcpiExec is unable to emulate access to IndexField Object
 */

Method(m10c,, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, 256)

	Method(CHCK, 3)
	{
		if (LNotEqual(arg0, arg1)) {
			err("", zFFF, arg2, 0, 0, arg0, arg1)
		}
	}

	Field(OPR0, WordAcc, NoLock, WriteAsZeros) {
		idx0, 16,
		dta0, 16,
	}
	IndexField(idx0, dta0, WordAcc, NoLock, WriteAsZeros) {
		idf0, 8, , 4, idf1, 8,
		idf2, 8, , 4, idf3, 8,
	}

	Method(m000, 3)
	{
		Store(Refof(arg1), Local0)

		Store(arg2, Derefof(Local0))
		Store(Derefof(arg1), Local1)
		CHCK(Local1, arg2, arg0)
	}

	Method(m001, 3)
	{
		Store(Derefof(arg1), Local1)
		CHCK(Local1, arg2, arg0)
	}

	m000(0, Refof(idf0), 0x12)
	m000(1, Refof(idf1), 0x34)
	m000(2, Refof(idf2), 0x56)
	m000(3, Refof(idf3), 0x78)
	m000(4, Refof(idf0), 0x12)
	m000(5, Refof(idf1), 0x34)
	m000(6, Refof(idf2), 0x56)
	m000(7, Refof(idf3), 0x78)
}
