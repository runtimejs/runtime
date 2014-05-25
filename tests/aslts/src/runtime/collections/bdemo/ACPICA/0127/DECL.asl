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
 * Bug 127:
 *
 * SUMMARY: Unexpectedly CopyObject of immediately passed Index reference is not reference
 */


	// Store

	Method(mf13)
	{
		Store(Index(pd11, 0, Local0), Local1)

		CH03("", 0, 0x000, 0, 0)
		Store(Add(Local0, 0), Local2)
		CH04("", 1, 47, 0, 0x001, 0, 0) // AE_AML_OPERAND_TYPE

		CH03("", 0, 0x002, 0, 0)
		Store(Add(Local1, 0), Local2)
		CH04("", 1, 47, 0, 0x003, 0, 0) // AE_AML_OPERAND_TYPE

		Store(Index(pd11, 1, Local0), Local1)

		CH03("", 0, 0x004, 0, 0)
		Store(Add(Local0, 0), Local2)
		CH04("", 1, 47, 0, 0x005, 0, 0) // AE_AML_OPERAND_TYPE

		CH03("", 0, 0x006, 0, 0)
		Store(Add(Local1, 0), Local2)
		CH04("", 1, 47, 0, 0x007, 0, 0) // AE_AML_OPERAND_TYPE
	}

	// CopyObject

	Method(mf14)
	{
		CopyObject(Index(pd11, 0, Local0), Local1)

		CH03("", 0, 0x008, 0, 0)
		Store(Add(Local0, 0), Local2)
		CH04("", 1, 47, 0, 0x009, 0, 0) // AE_AML_OPERAND_TYPE

		CH03("", 0, 0x00a, 0, 0)
		Store(Add(Local1, 0), Local2)
		CH04("", 1, 47, 0, 0x00b, 0, 0) // AE_AML_OPERAND_TYPE
	}

	Method(mf15)
	{
		CH03("", 0, 0x00c, 0, 0)

		CopyObject(Index(pd11, 1, Local0), Local1)

		CH03("", 0, 0x00d, 0, 0)
		Store(Add(Local0, 0), Local2)
		CH04("", 1, 47, 0, 0x00e, 0, 0) // AE_AML_OPERAND_TYPE

		CH03("", 0, 0x00f, 0, 0)
		Store(Add(Local1, 0), Local2)
		CH04("", 1, 47, 0, 0x010, 0, 0) // AE_AML_OPERAND_TYPE
	}

	Method(mf16)
	{
		if (1) {
			mf13()
		}
		if (1) {
			mf14()
		}
		if (1) {
			mf15()
		}
	}
