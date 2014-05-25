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
 * Bug 214 (local-bugzilla-350):
 *
 *
 * SUMMARY: crash of AcpiExec on repeated CopyObject of OpRegion
 *
 * Repeated duplication of an OpRegion to another
 * dynamic OpRegion by CopyObject ASL operator causes
 * crash of AcpiExec.
 */

Method(m81c,, Serialized)
{
	Method(m000, 1, Serialized)
	{
		OperationRegion(OPR0, SystemMemory, 0, 0x10)

		CopyObject(arg0, OPR0)
	}

	OperationRegion(OPR1, SystemMemory, 0, 0x10)

	Method(m001,, Serialized)
	{
		Field(OPR1, ByteAcc, NoLock, WriteAsZeros) {
			rfu0, 8,
		}

		Store(0x01, rfu0)
		m000(OPR1)
		if (LNotEqual(rfu0, 0x01)) {
			err("", zFFF, 0x000, 0, 0, rfu0, 0x01)
		}

		Store(0x02, rfu0)
		m000(OPR1)
		if (LNotEqual(rfu0, 0x02)) {
			err("", zFFF, 0x001, 0, 0, rfu0, 0x02)
		}

		Store(0x03, rfu0)
		m000(OPR1)
		if (LNotEqual(rfu0, 0x03)) {
			err("", zFFF, 0x002, 0, 0, rfu0, 0x03)
		}

		Store(0x04, rfu0)
		if (LNotEqual(rfu0, 0x04)) {
			err("", zFFF, 0x003, 0, 0, rfu0, 0x04)
		}
	}

	CH03("", 0, 0x000, 0, 0)
	m001()
	CH03("", 0, 0x001, 0, 0)
}
