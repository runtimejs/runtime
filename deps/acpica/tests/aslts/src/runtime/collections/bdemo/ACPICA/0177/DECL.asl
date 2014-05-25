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
 * Bug 177:
 *
 * SUMMARY: Exception BUFFER_LIMIT occurs instead of STRING_LIMIT one
 */

	Method(mf07,, Serialized)
	{
		Name(i000, 1)
		OperationRegion(r000, SystemMemory, 0, i000)
		Field(r000, ByteAcc, NoLock, Preserve) {f000, 8}
		Field(r000, ByteAcc, NoLock, Preserve) {f001, 9}

		Name(p000, Package(2){0, 1})
		Name(b000, Buffer(3){2, 3, 4})
		Name(s000, "5678")

		Name(i001, 0)
		OperationRegion(r001, SystemMemory, 0x100, 0x100)
		Field(r001, ByteAcc, NoLock, Preserve) { bnk0, 2 }
		BankField(r001, bnk0, 4, ByteAcc, NoLock, Preserve) { bkf0, 9 }

		// Named

		CH03("", 0, 0x000, 0, 0)
		Store(Index(p000, 2), Local1)
		CH04("", 1, 55, 0, 0x001, 0, 0) // AE_AML_PACKAGE_LIMIT

		CH03("", 0, 0x002, 0, 0)
		Store(Index(b000, 3), Local1)
		CH04("", 1, 54, 0, 0x003, 0, 0) // AE_AML_BUFFER_LIMIT

		CH03("", 0, 0x004, 0, 0)
		Store(Index(s000, 4), Local1)
		CH04("", 1, 61, 0, 0x005, 0, 0) // AE_AML_STRING_LIMIT

		// Immediate

		CH03("", 0, 0x006, 0, 0)
		Store(Index(Package(2){0, 1}, 2), Local1)
		if (y900) {
			CH04("", 1, 55, 0, 0x007, 0, 0) // AE_AML_PACKAGE_LIMIT
		} else {
			CH04("", 0, 85, 0, 0x008, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
		}

		CH03("", 0, 0x009, 0, 0)
		Store(Index(Buffer(3){2, 3, 4}, 3), Local1)
		if (y900) {
			CH04("", 1, 54, 0, 0x00a, 0, 0) // AE_AML_BUFFER_LIMIT
		} else {
			CH04("", 0, 85, 0, 0x00b, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
		}

		CH03("", 0, 0x00c, 0, 0)
		Store(Index("5678", 4), Local1)
		if (y900) {
			CH04("", 1, 61, 0, 0x00d, 0, 0) // AE_AML_STRING_LIMIT
		} else {
			CH04("", 0, 85, 0, 0x00e, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
		}

		// Fields

		CH03("", 0, 0x00f, 0, 0)
		Store(f000, Local0)
		CH03("", 0, 0x010, 0, 0)

		CH03("", 0, 0x011, 0, 0)
		Store(f001, Local0)
		if (y263) {
			/*
			 * After the bug 263 fixed we started actually
			 * have there several exceptions:
			 * - on evaluation of f001 stage
			 * - and on Store-to-debug stage
			 * Check opcode of the last exception.
			 */
			CH04("", 2, 53, 0, 0x013, 0, 0) // AE_AML_REGION_LIMIT
		} else {
			CH04("", 0, 53, 0, 0x013, 0, 0) // AE_AML_REGION_LIMIT
		}

		CH03("", 0, 0x014, 0, 0)
		Store(bkf0, Local0)
		if (y263) {
			/* See comment to sub-test above */
			CH04("", 2, 68, 0, 0x016, 0, 0) // AE_AML_REGISTER_LIMIT
		} else {
			CH04("", 0, 68, 0, 0x016, 0, 0) // AE_AML_REGISTER_LIMIT
		}
	}


