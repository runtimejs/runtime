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
 * RefCounts of named objects are incremented
 * and then decremented just after completions
 * of operations applied to them - it is true
 * for the following operations:
 *
 * - object used in AML operations except Index one
 * - object passed as parameter to Method
 *
 * The following AML operations increment the RefCounts
 * of objects which are decremented only while deleting
 * the objects where the results of these operations are
 * saved:
 *
 * - Index AML operation
 * - RefOf AML operation
 */

Method(m806,, Serialized)
{
	Name(p000, Package(64) {})
	Name(p001, Package(64) {})
	Name(s000, "01234567890-qwertyuiop[]")
	Name(b000, Buffer(){0x10,0x12,0x13,0x14,0x15,0x16,0x17})
	Name(i000, 0xabcd0000)
	Name(i001, 0xabcd0001)
	Name(i002, 0xabcd0002)
	Name(i003, 0xabcd0003)
	Name(i004, 0xabcd0004)
	Name(i005, 0xabcd0005)
	Name(i006, 0xabcd0006)
	Name(i007, 0xabcd0007)

	Method(m000)
	{
		Store(Index(s000, 0), Index(p001, 4))
		Store(Index(s000, 0), Index(p001, 4))
	}

	Method(m001)
	{
		Store(Index(b000, 0), Index(p001, 7))
		Store(Index(b000, 0), Index(p001, 7))
	}

	m000()
	m001()
}

Method(m807,, Serialized)
{
	Name(p000, Package(64) {})
	Name(p001, Package(64) {})
	Name(s000, "01234567890-qwertyuiop[]")
	Name(b000, Buffer(){0x10,0x12,0x13,0x14,0x15,0x16,0x17})
	Name(i000, 0xabcd0000)
	Name(i001, 0xabcd0001)
	Name(i002, 0xabcd0002)
	Name(i003, 0xabcd0003)
	Name(i004, 0xabcd0004)
	Name(i005, 0xabcd0005)
	Name(i006, 0xabcd0006)
	Name(i007, 0xabcd0007)

	Method(mm00, 2)
	{
		Method(m000)
		{
			Store(Index(p000, 0), Index(p001, 0))
			Store(Index(p000, 1), Index(p001, 1))
			Store(Index(p000, 2), Index(p001, 2))
			Store(Index(p000, 3), Index(p001, 3))

			Store(Index(s000, 0), Index(p001, 4))
			Store(Index(s000, 1), Index(p001, 5))
			Store(Index(s000, 2), Index(p001, 6))

			Store(Index(b000, 0), Index(p001, 7))
			Store(Index(b000, 1), Index(p001, 8))
			Store(Index(b000, 2), Index(p001, 9))
		}
		Method(m001)
		{
			Store(Index(p000, 0), Index(p001, 0))
			Store(Index(p000, 1), Index(p001, 1))
			Store(Index(p000, 2), Index(p001, 2))
			Store(Index(p000, 3), Index(p001, 3))

			Store(Index(p001, 0), Index(p000, 0))
			Store(Index(p001, 1), Index(p000, 1))
			Store(Index(p001, 2), Index(p000, 2))
			Store(Index(p001, 3), Index(p000, 3))

			Store(Index(s000, 0), Index(p001, 4))
			Store(Index(s000, 1), Index(p001, 5))
			Store(Index(s000, 2), Index(p001, 6))

			Store(Index(b000, 0), Index(p001, 7))
			Store(Index(b000, 1), Index(p001, 8))
			Store(Index(b000, 2), Index(p001, 9))
		}
		Method(m002)
		{
			Store(Index(p000, 0), Local0)
			Store(Index(p000, 1), Local1)
			Store(Index(p000, 2), Local2)
			Store(Index(p000, 3), Local3)
		}
		Method(m003, 4)
		{
			Store(Index(p000, 0), arg0)
			Store(Index(p000, 1), arg1)
			Store(Index(p000, 2), arg2)
			Store(Index(p000, 3), arg3)
		}
		Method(m004, 4)
		{
			Store(Index(p000, 0), Index(p001, 0))
			Store(Index(p000, 1), Index(p001, 1))
			Store(Index(p000, 2), Index(p001, 2))
			Store(Index(p000, 3), Index(p001, 3))

			Store(Index(p001, 0), Index(p000, 0))
			Store(Index(p001, 1), Index(p000, 1))
			Store(Index(p001, 2), Index(p000, 2))
			Store(Index(p001, 3), Index(p000, 3))

			Store(Index(s000, 0), Index(p001, 4))
			Store(Index(s000, 1), Index(p001, 5))
			Store(Index(s000, 2), Index(p001, 6))

			Store(Index(b000, 0), Index(p001, 7))
			Store(Index(b000, 1), Index(p001, 8))
			Store(Index(b000, 2), Index(p001, 9))

			Store(Index(p000, 0), Local0)
			Store(Index(p000, 1), Local1)
			Store(Index(p000, 2), Local2)
			Store(Index(p000, 3), Local3)

			Store(Index(p000, 0), arg0)
			Store(Index(p000, 1), arg1)
			Store(Index(p000, 2), arg2)
			Store(Index(p000, 3), arg3)
		}

		Method(m005, 6)
		{
			Store(Index(arg0, 0), Index(arg1, 0))
			Store(Index(arg0, 1), Index(arg1, 1))
			Store(Index(arg0, 2), Index(arg1, 2))
			Store(Index(arg0, 3), Index(arg1, 3))

			Store(Index(arg1, 0), Index(arg0, 0))
			Store(Index(arg1, 1), Index(arg0, 1))
			Store(Index(arg1, 2), Index(arg0, 2))
			Store(Index(arg1, 3), Index(arg0, 3))

			Store(Index(s000, 0), Index(p001, 4))
			Store(Index(s000, 1), Index(p001, 5))
			Store(Index(s000, 2), Index(p001, 6))

			Store(Index(b000, 0), Index(p001, 7))
			Store(Index(b000, 1), Index(p001, 8))
			Store(Index(b000, 2), Index(p001, 9))

			Store(Index(arg0, 0), Local0)
			Store(Index(arg0, 1), Local1)
			Store(Index(arg0, 2), Local2)
			Store(Index(arg0, 3), Local3)

			Store(Index(arg0, 0), arg2)
			Store(Index(arg0, 1), arg3)
			Store(Index(arg0, 2), arg4)
			Store(Index(arg0, 3), arg5)
		}

		m000()
		m001()
		m002()
		m003(0,0,0,0)
		m004(0,0,0,0)
		m005(p000,p001,0,0,0,0)
		m005(arg0,arg1,0,0,0,0)
	}

	Method(mm01, 2)
	{
		m000()
		m001()
		m002()
		m003(0,0,0,0)
		m004(0,0,0,0)
		m005(p000,p001,0,0,0,0)
		m005(arg0,arg1,0,0,0,0)
	}

	Method(m000)
	{
		Store(Index(p000, 0), Index(p001, 0))
		Store(Index(p000, 1), Index(p001, 1))
		Store(Index(p000, 2), Index(p001, 2))
		Store(Index(p000, 3), Index(p001, 3))
	}
	Method(m001)
	{
		Store(Index(p000, 0), Index(p001, 0))
		Store(Index(p000, 1), Index(p001, 1))
		Store(Index(p000, 2), Index(p001, 2))
		Store(Index(p000, 3), Index(p001, 3))

		Store(Index(p001, 0), Index(p000, 0))
		Store(Index(p001, 1), Index(p000, 1))
		Store(Index(p001, 2), Index(p000, 2))
		Store(Index(p001, 3), Index(p000, 3))
	}
	Method(m002)
	{
		Store(Index(p000, 0), Local0)
		Store(Index(p000, 1), Local1)
		Store(Index(p000, 2), Local2)
		Store(Index(p000, 3), Local3)
	}
	Method(m003, 4)
	{
		Store(Index(p000, 0), arg0)
		Store(Index(p000, 1), arg1)
		Store(Index(p000, 2), arg2)
		Store(Index(p000, 3), arg3)
	}

	Method(m004, 4)
	{
		Store(Index(p000, 0), Index(p001, 0))
		Store(Index(p000, 1), Index(p001, 1))
		Store(Index(p000, 2), Index(p001, 2))
		Store(Index(p000, 3), Index(p001, 3))

		Store(Index(p001, 0), Index(p000, 0))
		Store(Index(p001, 1), Index(p000, 1))
		Store(Index(p001, 2), Index(p000, 2))
		Store(Index(p001, 3), Index(p000, 3))

		Store(Index(s000, 0), Index(p001, 4))
		Store(Index(s000, 1), Index(p001, 5))
		Store(Index(s000, 2), Index(p001, 6))

		Store(Index(b000, 0), Index(p001, 7))
		Store(Index(b000, 1), Index(p001, 8))
		Store(Index(b000, 2), Index(p001, 9))

		Store(Index(p000, 0), Local0)
		Store(Index(p000, 1), Local1)
		Store(Index(p000, 2), Local2)
		Store(Index(p000, 3), Local3)

		Store(Index(p000, 0), arg0)
		Store(Index(p000, 1), arg1)
		Store(Index(p000, 2), arg2)
		Store(Index(p000, 3), arg3)
	}

	Method(m005, 6)
	{
		Store(Index(arg0, 0), Index(arg1, 0))
		Store(Index(arg0, 1), Index(arg1, 1))
		Store(Index(arg0, 2), Index(arg1, 2))
		Store(Index(arg0, 3), Index(arg1, 3))

		Store(Index(arg1, 0), Index(arg0, 0))
		Store(Index(arg1, 1), Index(arg0, 1))
		Store(Index(arg1, 2), Index(arg0, 2))
		Store(Index(arg1, 3), Index(arg0, 3))

		Store(Index(s000, 0), Index(p001, 4))
		Store(Index(s000, 1), Index(p001, 5))
		Store(Index(s000, 2), Index(p001, 6))

		Store(Index(b000, 0), Index(p001, 7))
		Store(Index(b000, 1), Index(p001, 8))
		Store(Index(b000, 2), Index(p001, 9))

		Store(Index(arg0, 0), Local0)
		Store(Index(arg0, 1), Local1)
		Store(Index(arg0, 2), Local2)
		Store(Index(arg0, 3), Local3)

		Store(Index(arg0, 0), arg2)
		Store(Index(arg0, 1), arg3)
		Store(Index(arg0, 2), arg4)
		Store(Index(arg0, 3), arg5)
	}

	Method(m006,, Serialized)
	{
		Name(p000, Package(8) {})
		Name(p001, Package(8) {})

		Store(RefOf(p000), Index(p001, 0))
		Store(RefOf(p001), Index(p000, 0))

		Store(RefOf(p000), Index(p000, 1))
		Store(RefOf(p001), Index(p001, 1))

		/* Repeat the same */

		Store(RefOf(p000), Index(p001, 0))
		Store(RefOf(p001), Index(p000, 0))

		Store(RefOf(p000), Index(p000, 1))
		Store(RefOf(p001), Index(p001, 1))
	}

	m000()
	m001()
	m002()
	m003(0,0,0,0)
	m004(0,0,0,0)
	m005(p000,p001,0,0,0,0)
	mm00(p000,p001)
	mm01(p000,p001)
	m006()
}

Method(m80f,, Serialized)
{

	Name(ig00, 0xabcd0001)
	Name(ir00, 0xabcd0002)

	Method(m000,, Serialized)
	{
		Name(i000, 0xabcd0003)
		CopyObject(RefOf(i000), ir00)
	}

	Method(m001, 1, Serialized)
	{
		Name(iii0, 0xabcd0004)
		Name(iii1, 0xabcd0005)
		Name(iii2, 0xabcd0006)
		Name(iii3, 0xabcd0007)
		Name(iii4, 0xabcd0008)
		Name(iii5, 0xabcd0009)
		Name(iii6, 0xabcd000a)
		Name(iii7, 0xabcd000b)

		CopyObject(DerefOf(ir00), Local0)
		if (LNotEqual(Local0, arg0)) {
			err("", zFFF, 0x534, 0, 0, Local0, arg0)
		}
	}
	m000()
	m001(0xabcd0003)
}

Method(m810,, Serialized)
{
	Name(p000, Package(4) {0,1,2,3})

	Method(m000)
	{
		Store(0xabcd0009, Local0)
		Store(RefOf(Local0), Index(p000, 2))
	}
	m000()
}

Method(m811,, Serialized)
{
	Name(p000, Package(4) {0,1,2,3})

	Method(m000)
	{
		Store(RefOf(Local0), Index(p000, 2))
	}
	m000()
}

Method(m805)
{
	SRMT("m806")
	m806()
	SRMT("m807")
	if (y135) {
		m807()
	} else {
		BLCK()
	}
	SRMT("m80f")
	m80f()
	SRMT("m810")
	m810()
	SRMT("m811")
	m811()
}
