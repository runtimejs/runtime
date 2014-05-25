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
 * Bug 215 (local-bugzilla-351):
 *
 * SUMMARY: exception on accessing IndexField with IndexName Region Field exceeding 32 bits
 *
 * Exception AE_BUFFER_OVERFLOW unexpectedly
 * occurs on access to an IndexField object if
 * the length of the respective IndexName Region
 * Field exceeds 32 bits.
 */

Method(m81d)
{
	Method(m000,, Serialized)
	{
		OperationRegion(OPR0, SystemMemory, 0, 0x30)

		Field(OPR0, ByteAcc, NoLock, Preserve) {
			idx0, 32,
			dta0, 32,
		}

		Field(OPR0, ByteAcc, NoLock, Preserve) {
			Offset(8),  idx1, 32,
			Offset(16), dta1, 33,
		}

		Field(OPR0, ByteAcc, NoLock, Preserve) {
			Offset(24), idx2, 33,
			Offset(32), dta2, 32,
		}

		IndexField(idx0, dta0, ByteAcc, NoLock, Preserve) {
			idf0, 1,
		}

		IndexField(idx1, dta1, ByteAcc, NoLock, Preserve) {
			idf1, 1,
		}

		IndexField(idx2, dta2, ByteAcc, NoLock, Preserve) {
			idf2, 1,
		}

		Store(1, idf0)
		if (LNotEqual(idf0, 1)) {
			err("", zFFF, 0x000, 0, 0, idf0, 1)
		}

		Store(1, idf1)
		if (LNotEqual(idf1, 1)) {
			err("", zFFF, 0x001, 0, 0, idf1, 1)
		}

		Store(1, idf2)
		if (LNotEqual(idf2, 1)) {
			err("", zFFF, 0x002, 0, 0, idf2, 1)
		}
	}

	CH03("", 0, 0x000, 0, 0)
	m000()
	CH03("", 0, 0x001, 0, 0)
}
