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
 * Bug 178:
 *
 * SUMMARY: Unexpected exception occurs on access to the Fields specified by BankField
 */

	Method(mf0a,, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field(r000, ByteAcc, NoLock, Preserve) { bnk0, 2 }
		BankField(r000, bnk0, 4, ByteAcc, NoLock, Preserve) { bkf0, 9 }


		CH03("", 0, 0x000, 0, 0)
		Store(bkf0, Local0)

		if (y263) {
			/*
			 * After the bug 263 fixed we started actually
			 * have there several exceptions:
			 * - on evaluation of f001 stage
			 * - and on Store-to-debug stage
			 * Check opcode of the last exception.
			 */
			CH04("", 2, 68, 0, 0x001, 0, 0) // AE_AML_REGISTER_LIMIT
		} else {
			CH04("", 0, 68, 0, 0x001, 0, 0) // AE_AML_REGISTER_LIMIT
		}
	}

	Method(mf0b,, Serialized)
	{
		Name(i000, 4)
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field(r000, ByteAcc, NoLock, Preserve) { bnk0, 2 }
		BankField(r000, bnk0, i000, ByteAcc, NoLock, Preserve) { bkf0, 9 }


		CH03("", 0, 0x002, 0, 0)
		Store(bkf0, Local0)
		CH04("", 0, 68, 0, 0x003, 0, 0) // AE_AML_REGISTER_LIMIT
	}

	Method(mf0c,, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field(r000, ByteAcc, NoLock, Preserve) { bnk0, 2 }
		BankField(r000, bnk0, 0, ByteAcc, NoLock, Preserve) { bkf0, 9 }


		CH03("", 0, 0x004, 0, 0)
		Store(bkf0, Local0)
		CH03("", 0, 0x005, 0, 0)
	}

	Method(mf0d,, Serialized)
	{
		Name(i000, 0)
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field(r000, ByteAcc, NoLock, Preserve) { bnk0, 2 }
		BankField(r000, bnk0, Add(i000, 0), ByteAcc, NoLock, Preserve) { bkf0, 9 }


		CH03("", 0, 0x006, 0, 0)
		Store(bkf0, Local0)
		CH03("", 0, 0x007, 0, 0)
	}

	Method(mf0e,, Serialized)
	{
		Name(i000, 0)
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field(r000, ByteAcc, NoLock, Preserve) { bnk0, 2 }
		BankField(r000, bnk0, i000, ByteAcc, NoLock, Preserve) { bkf0, 9 }


		CH03("", 0, 0x008, 0, 0)
		Store(bkf0, Local0)
		CH03("", 0, 0x009, 0, 0)
	}


