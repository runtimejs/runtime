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
 * Bug 226:
 *
 * SUMMARY: Excessive data is written to the Data field if
 *          it is wider than Access Width of the IndexField
 */

Method(m10e,, Serialized)
{
	OperationRegion(OPR0, SystemMemory, 0, 256)

	Field(OPR0, ByteAcc, NoLock, WriteAsZeros) {
		idx0, 8,
		dta0, 24,
	}

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		tot0, 32,
	}

	IndexField(idx0, dta0, ByteAcc, NoLock, WriteAsZeros) {
		, 15,
		idf0, 1
	}

	Store(0x3ff, idf0)

	Store(tot0, Local0)

	if (LNotEqual(Local0, 0x8001)) {
		err("", zFFF, 0x000, 0, 0, Local0, 0x8001)
	}
}

Method(m17a,, Serialized)
{
	Name(b000, Buffer(64) {})
	Name(b001, Buffer() {0xF0, 0xDE, 0xBC, 0x9A, 0, 0, 0, 0})

	CreateQWordField(b000, 5, bf00)
	Store(0x123456789abcdef0, bf00)

	if (F64) {
		if (LNotEqual(bf00, 0x123456789abcdef0)) {
			err("", zFFF, 0x001, 0, 0, bf00, 0x123456789abcdef0)
		}
	} else {
		if (LNotEqual(bf00, b001)) {
			err("", zFFF, 0x002, 0, 0, bf00, b001)
		}
	}
}
