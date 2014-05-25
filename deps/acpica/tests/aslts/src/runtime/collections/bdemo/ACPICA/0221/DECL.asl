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
 * Bug 221:
 *
 * SUMMARY: AcpiExec improper emulates alternating access to OpRegions
 *          covering different ranges
 */

Method(m109,, Serialized)
{
	Method(CHCK, 3)
	{
		if (LNotEqual(arg0, arg1)) {
			err("", zFFF, arg2, 0, 0, arg0, arg1)
		}
	}

	OperationRegion(OPR0, SystemMemory, 0x00, 0x02)
	OperationRegion(OPR1, SystemMemory, 0x00, 0x01)
	OperationRegion(OPR2, SystemMemory, 0x01, 0x01)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		f000, 8,		// Byte 0
		f001, 8,		// Byte 1
	}
	Field(OPR1, ByteAcc, NoLock, Preserve) {
		f002, 8,		// Byte 0
	}
	Field(OPR2, ByteAcc, NoLock, Preserve) {
		f003, 8,		// Byte 1
	}

	Store(0x5a, f001)	// Byte 1
	CHCK(f001, 0x5a, 0)

	Store(0xc3, f002)	// Byte 0
	CHCK(f002, 0xc3, 1)

	CHCK(f000, 0xc3, 2)	// Byte 0

	CHCK(f001, 0x5a, 3)	// Byte 1

	CHCK(f003, 0x5a, 4)	// Byte 1
}
