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
 * Bug 113:
 *
 * SUMMARY: Unexpected dereference of Index reference immediately passed to Method
 */

	Method(me79, 6)
	{
		Store(arg0, Debug)
		Store(arg1, Debug)
		Store(arg2, Debug)
		Store(arg3, Debug)
		Store(arg4, Debug)
		Store(arg5, Debug)


		Store("Test 0", Debug)
		CH03("", 0, 0x000, 0, 0)
		Store(Add(arg0, 1), Local5)
		CH04("", 1, 47, 0, 0x001, 0, 0) // AE_AML_OPERAND_TYPE

		Store("Test 1", Debug)
		CH03("", 0, 0x002, 0, 0)
		Store(Add(arg1, 1), Local5)
		CH04("", 1, 47, 0, 0x003, 0, 0) // AE_AML_OPERAND_TYPE

		Store("Test 2", Debug)
		CH03("", 0, 0x004, 0, 0)
		Store(Add(arg2, 1), Local5)
		CH04("", 1, 47, 0, 0x005, 0, 0) // AE_AML_OPERAND_TYPE

		Store("Test 3", Debug)
		CH03("", 0, 0x006, 0, 0)
		Store(Add(arg3, 1), Local5)
		CH04("", 1, 47, 0, 0x007, 0, 0) // AE_AML_OPERAND_TYPE

		Store("Test 4", Debug)
		CH03("", 0, 0x008, 0, 0)
		Store(Add(arg4, 1), Local5)
		CH04("", 1, 47, 0, 0x009, 0, 0) // AE_AML_OPERAND_TYPE

		Store("Test 5", Debug)
		CH03("", 0, 0x00a, 0, 0)
		Store(Add(arg5, 1), Local5)
		CH04("", 1, 47, 0, 0x00b, 0, 0) // AE_AML_OPERAND_TYPE
	}

	Method(me7a,, Serialized)
	{
		Name(p000, Package(){0x00, 0x01, 0x02, 0x03, 0x04})
		Name(p001, Package(){0x10, 0x11, 0x12, 0x13, 0x14})
		Name(p002, Package(){0x20, 0x21, 0x22, 0x23, 0x24})
		Name(p003, Package(){0x30, 0x31, 0x32, 0x33, 0x34})
		Name(p004, Package(){0x40, 0x41, 0x42, 0x43, 0x44})


		Store(Index(p002, 2), Local0)

		Index(p003, 3, Local1)

		Store(Index(p004, 4, Local2), Local3)

		me79(Index(p000, 0), Index(p001, 1, Local4), Local0, Local1, Local2, Local3)

		Store(Local4, Debug)
	}
