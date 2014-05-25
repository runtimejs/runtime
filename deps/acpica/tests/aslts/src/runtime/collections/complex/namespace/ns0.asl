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
 * Trying to get the chain of calls of methods such that
 * sections of operative stack corresponding to different
 * methods contain the internal object (itself, not a RefOf
 * reference to it) of the same Name Space node.
 *
 * Then force (by Store/CopyObject):
 *   1) changing the value of that internal object
 *   2) replacing the internal object itself by some another one
 *
 * Check that the changing/replacing has no effect on the
 * values evaluated on the lowest stages of calculation.
 */
Name(z154, 154)

/*
 * Named Integer i000
 */

Method(m000, 1, Serialized)
{
	Name(ts, "m000")
	Name(i000, 0x00000001)
	Name(p000, Package() {1,2,3,4})

	Name(i001, 0)

	CH03(ts, z154, 0x000, 0, 0)

	Store(arg0, i001)

	Method(m001)
	{
		Method(m002)
		{
			Method(m003)
			{
				if (i001) {
					CopyObject(p000, i000)
				}
				Return (0xabcd0000)
			}
			Return (Add(i000, m003()))
		}
		Return (Add(i000, m002()))
	}
	Store(Add(i000, m001()), Local0)
	if (LNotEqual(Local0, 0xabcd0003)) {
		err(ts, z154, 0x001, 0, 0, Local0, 0xabcd0003)
	}
	Store(Local0, Debug)

	CH03(ts, z154, 0x002, 0, 0)
}

Method(m001, 1, Serialized)
{
	Name(ts, "m001")
	Name(i000, 0x00000001)
	Name(i001, 0)
	Name(p000, Package() {1,2,3,4})

	Store(arg0, i001)

	Method(m001)
	{
		Method(m002)
		{
			Method(m003)
			{
				Method(m004)
				{
					Method(m005)
					{
						Method(m006)
						{
							Method(m007)
							{
								Method(m008)
								{
									if (i001)
									{
										CopyObject(p000, i000)
									}
									Return (0)
								}
								Store(0x80000000, i000)
								Return (Add(i000, m008()))
							}
							Store(0x07000000, i000)
							Return (Add(i000, m007()))
						}
						Store(0x00600000, i000)
						Return (Add(i000, m006()))
					}
					Store(0x00050000, i000)
					Return (Add(i000, m005()))
				}
				Store(0x00004000, i000)
				Return (Add(i000, m004()))
			}
			Store(0x00000300, i000)
			Return (Add(i000, m003()))
		}
		Store(0x00000020, i000)
		Return (Add(i000, m002()))
	}
	Store(Add(i000, m001()), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z154, 0x003, 0, 0, Local0, 0x87654321)
	}

	if (LNotEqual(i000, 0x80000000)) {
		err(ts, z154, 0x004, 0, 0, i000, 0x80000000)
	}

	CH03(ts, z154, 0x005, 0, 0)
}

Method(m002,, Serialized)
{
	Name(ts, "m002")
	Name(i000, 0x00100000)
	Name(i001, 0)

	Method(m001)
	{
		if (LLess(i001, 100)) {
			Increment(i000)
			Increment(i001)
			Add(i000, m001(), Local0)
			Return (Local0)
		}
		Return (0)
	}
	Store(Add(i000, m001()), Local0)

	if (LNotEqual(Local0, 0x065013BA)) {
		err(ts, z154, 0x006, 0, 0, Local0, 0x065013BA)
	}

	if (LNotEqual(i000, 0x00100064)) {
		err(ts, z154, 0x007, 0, 0, i000, 0x00100064)
	}

	CH03(ts, z154, 0x008, 0, 0)
}

Method(m003,, Serialized)
{
	Name(ts, "m003")
	Name(i000, 0x00100000)
	Name(i001, 0)

	Method(m001)
	{
		if (LLess(i001, 100)) {
			Increment(i000)
			Increment(i001)
			Return (Add(i000, m001(), Local0))
		}
		Return (0)
	}
	Store(Add(i000, m001()), Local0)

	if (LNotEqual(Local0, 0x065013BA)) {
		err(ts, z154, 0x009, 0, 0, Local0, 0x065013BA)
	}

	if (LNotEqual(i000, 0x00100064)) {
		err(ts, z154, 0x00a, 0, 0, i000, 0x00100064)
	}

	CH03(ts, z154, 0x00b, 0, 0)
}

/*
 * Local instead of i000 (in m001)
 */
Method(m004, 1, Serialized)
{
	Name(ts, "m004")
	Name(i001, 0)
	Name(p000, Package() {1,2,3,4})

	Store(arg0, i001)

	Store(0x00000001, Local7)

	Method(m001)
	{
		Method(m002)
		{
			Method(m003)
			{
				Method(m004)
				{
					Method(m005)
					{
						Method(m006)
						{
							Method(m007)
							{
								Method(m008)
								{
									if (i001)
									{
										CopyObject(p000, Local7)
									}
									Return (0)
								}
								Store(0x80000000, Local7)
								Return (Add(Local7, m008()))
							}
							Store(0x07000000, Local7)
							Return (Add(Local7, m007()))
						}
						Store(0x00600000, Local7)
						Return (Add(Local7, m006()))
					}
					Store(0x00050000, Local7)
					Return (Add(Local7, m005()))
				}
				Store(0x00004000, Local7)
				Return (Add(Local7, m004()))
			}
			Store(0x00000300, Local7)
			Return (Add(Local7, m003()))
		}
		Store(0x00000020, Local7)
		Return (Add(Local7, m002()))
	}
	Store(Add(Local7, m001()), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z154, 0x00c, 0, 0, Local0, 0x87654321)
	}

	if (LNotEqual(Local7, 1)) {
		err(ts, z154, 0x00d, 0, 0, Local7, 1)
	}

	CH03(ts, z154, 0x00e, 0, 0)
}

/*
 * Arg instead of i000 (in m001)
 */
Method(m005, 2, Serialized)
{
	Name(ts, "m005")
	Name(i001, 0)
	Name(p000, Package() {1,2,3,4})

	Store(arg0, i001)

	Store(0x00000001, arg1)

	Method(m001)
	{
		Method(m002)
		{
			Method(m003)
			{
				Method(m004)
				{
					Method(m005)
					{
						Method(m006)
						{
							Method(m007)
							{
								Method(m008)
								{
									if (i001)
									{
										CopyObject(p000, arg1)
									}
									Return (0)
								}
								Store(0x80000000, arg1)
								Return (Add(arg1, m008()))
							}
							Store(0x07000000, arg1)
							Return (Add(arg1, m007()))
						}
						Store(0x00600000, arg1)
						Return (Add(arg1, m006()))
					}
					Store(0x00050000, arg1)
					Return (Add(arg1, m005()))
				}
				Store(0x00004000, arg1)
				Return (Add(arg1, m004()))
			}
			Store(0x00000300, arg1)
			Return (Add(arg1, m003()))
		}
		Store(0x00000020, arg1)
		Return (Add(arg1, m002()))
	}
	Store(Add(arg1, m001()), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z154, 0x00f, 0, 0, Local0, 0x87654321)
	}

	if (LNotEqual(arg1, 1)) {
		err(ts, z154, 0x010, 0, 0, arg1, 1)
	}

	CH03(ts, z154, 0x011, 0, 0)
}

Method(n000)
{
if (1) {
	SRMT("m000-0")
	m000(0)
	SRMT("m000-1")
	m000(1)
	SRMT("m001-0")
	m001(0)
	SRMT("m001-1")
	if (y200) {
		m001(1)
	} else {
		BLCK()
	}
	SRMT("m002")
	m002()
	SRMT("m003")
	m003()
	SRMT("m004-0")
	m004(0)
	SRMT("m004-1")
	m004(1)
	SRMT("m005-0")
	m005(0, 0)
	SRMT("m005-1")
	m005(1, 0)
} else {
	SRMT("m000-0")
	m000(0)
	SRMT("m000-1")
	m000(1)
}
}

